Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0853C32C305
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbhCDAAI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:08 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59888 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356705AbhCCKsJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Mar 2021 05:48:09 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A7E602004CE;
        Wed,  3 Mar 2021 11:47:19 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 972D12004BC;
        Wed,  3 Mar 2021 11:47:19 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 815FA20308;
        Wed,  3 Mar 2021 11:47:19 +0100 (CET)
Date:   Wed, 3 Mar 2021 12:47:19 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, pete.zhang@nxp.com,
        marex@denx.de
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 00/14] Add BLK_CTL support for i.MX8MP
Message-ID: <20210303104719.74guq4bfm75dyzvj@fsr-ub1664-175>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-11-03 13:18:12, Abel Vesa wrote:
> The BLK_CTL according to HW design is basically the wrapper of the entire
> function specific group of IPs and holds GPRs that usually cannot be placed
> into one specific IP from that group. Some of these GPRs are used to control
> some clocks, other some resets, others some very specific function that does
> not fit into clocks or resets. Since the clocks are registered using the i.MX
> clock subsystem API, the driver is placed into the clock subsystem, but it
> also registers the resets. For the other functionalities that other GPRs might
> have, the syscon is used.
> 

This approach seems to be introducing a possible ABBA deadlock due to
the core clock and genpd locking. Here is a backtrace I got from Pete
Zhang (he reported the issue on the internal mailing list):

[   11.667711][  T108] -> #1 (&genpd->mlock){+.+.}-{3:3}:
[   11.675041][  T108]        __lock_acquire+0xae4/0xef8
[   11.680093][  T108]        lock_acquire+0xfc/0x2f8
[   11.684888][  T108]        __mutex_lock+0x90/0x870
[   11.689685][  T108]        mutex_lock_nested+0x44/0x50
[   11.694826][  T108]        genpd_lock_mtx+0x18/0x24
[   11.699706][  T108]        genpd_runtime_resume+0x90/0x214 (hold genpd->mlock)
[   11.705194][  T108]        __rpm_callback+0x80/0x2c0
[   11.710160][  T108]        rpm_resume+0x468/0x650
[   11.714866][  T108]        __pm_runtime_resume+0x60/0x88
[   11.720180][  T108]        clk_pm_runtime_get+0x28/0x9c
[   11.725410][  T108]        clk_disable_unused_subtree+0x8c/0x144
[   11.731420][  T108]        clk_disable_unused_subtree+0x124/0x144
[   11.737518][  T108]        clk_disable_unused+0xa4/0x11c (hold prepare_lock)
[   11.742833][  T108]        do_one_initcall+0x98/0x178
[   11.747888][  T108]        do_initcall_level+0x9c/0xb8
[   11.753028][  T108]        do_initcalls+0x54/0x94
[   11.757736][  T108]        do_basic_setup+0x24/0x30
[   11.762614][  T108]        kernel_init_freeable+0x70/0xa4
[   11.768014][  T108]        kernel_init+0x14/0x18c
[   11.772722][  T108]        ret_from_fork+0x10/0x18

[   11.777512][  T108] -> #0 (prepare_lock){+.+.}-{3:3}:
[   11.784749][  T108]        check_noncircular+0x134/0x13c
[   11.790064][  T108]        validate_chain+0x590/0x2a04
[   11.795204][  T108]        __lock_acquire+0xae4/0xef8
[   11.800258][  T108]        lock_acquire+0xfc/0x2f8
[   11.805050][  T108]        __mutex_lock+0x90/0x870
[   11.809841][  T108]        mutex_lock_nested+0x44/0x50
[   11.814983][  T108]        clk_unprepare+0x5c/0x100 ((hold prepare_lock))
[   11.819864][  T108]        imx8m_pd_power_off+0xac/0x110
[   11.825179][  T108]        genpd_power_off+0x1b4/0x2dc
[   11.830318][  T108]        genpd_power_off_work_fn+0x38/0x58 (hold genpd->mlock)
[   11.835981][  T108]        process_one_work+0x270/0x444
[   11.841208][  T108]        worker_thread+0x280/0x4e4
[   11.846176][  T108]        kthread+0x13c/0x14
[   11.850621][  T108]        ret_from_fork+0x10/0x18

Now, this has been reproduced only on the NXP internal tree, but I think
it is pretty obvious this could happen in upstream too, with this
patchset applied.

First, my thought was to change the prepare_lock/enable_lock in clock
core, from a global approach to a per clock basis. But that doesn't
actually fix the issue.

The usecase seen above is due to clk_disable_unused, but the same could
happen when a clock consumer calls prepare/unprepare on a clock.

I guess the conclusion is that the current state of the clock core and
genpd implementation does not support a usecase where a clock controller
has a PD which in turn uses another clock (from another clock controller).

Jacky, Pete, did I miss anything here ?

> Changes since v4:
>  * added back the bus_blk_clk in the imx8mp blk_ctl driver (media_blk_ctl)
>  * added the R-b tag from Rob to the documentation patch
> 
> Abel Vesa (14):
>   dt-bindings: clocks: imx8mp: Rename audiomix ids clocks to
>     audio_blk_ctl
>   dt-bindings: reset: imx8mp: Add audio blk_ctl reset IDs
>   dt-bindings: clock: imx8mp: Add ids for the audio shared gate
>   dt-bindings: clock: imx8mp: Add media blk_ctl clock IDs
>   dt-bindings: reset: imx8mp: Add media blk_ctl reset IDs
>   dt-bindings: clock: imx8mp: Add hdmi blk_ctl clock IDs
>   dt-bindings: reset: imx8mp: Add hdmi blk_ctl reset IDs
>   clk: imx8mp: Add audio shared gate
>   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
>   clk: imx: Add generic blk-ctl driver
>   clk: imx: Add blk-ctl driver for i.MX8MP
>   arm64: dts: imx8mp: Add audio_blk_ctl node
>   arm64: dts: imx8mp: Add media_blk_ctl node
>   arm64: dts: imx8mp: Add hdmi_blk_ctl node
> 
>  .../devicetree/bindings/clock/fsl,imx-blk-ctl.yaml |  60 ++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  37 +++
>  drivers/clk/imx/Makefile                           |   2 +-
>  drivers/clk/imx/clk-blk-ctl-imx8mp.c               | 317 +++++++++++++++++++++
>  drivers/clk/imx/clk-blk-ctl.c                      | 302 ++++++++++++++++++++
>  drivers/clk/imx/clk-blk-ctl.h                      |  80 ++++++
>  drivers/clk/imx/clk-imx8mp.c                       |  12 +-
>  include/dt-bindings/clock/imx8mp-clock.h           | 200 +++++++++----
>  include/dt-bindings/reset/imx8mp-reset.h           |  45 +++
>  9 files changed, 992 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
>  create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mp.c
>  create mode 100644 drivers/clk/imx/clk-blk-ctl.c
>  create mode 100644 drivers/clk/imx/clk-blk-ctl.h
> 
> -- 
> 2.7.4
> 

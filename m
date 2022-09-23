Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1DA5E758E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Sep 2022 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiIWISi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Sep 2022 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiIWISc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 04:18:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFEC1296BF
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 01:18:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1obdtC-0008Rz-Im; Fri, 23 Sep 2022 10:18:26 +0200
Message-ID: <e8828c9c94146127ded316b7ad8b6042cf9f6919.camel@pengutronix.de>
Subject: Re: Help: i.MX8MP AUDIOMIX BLK-CTRL CLK driver support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peng Fan <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        Marek Vasut <marex@denx.de>, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        festevam@gmail.com, Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 23 Sep 2022 10:18:24 +0200
In-Reply-To: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
References: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peng,

Am Freitag, dem 23.09.2022 um 11:41 +0800 schrieb Peng Fan:
> Hi All,
> 
> I would start a discussion about the A/B B/A lock issue when make 
> audiomix blk ctrl function as clk provider.
> 
> I not have good idea on this, hope you have any suggestions.
> 
> major issue is: the blk ctrl clk has a power domain supplier
> The power domain supplier also use clk API to prepare_enable clks.
> The blk ctrl clk driver has runtime pm enabled.
> 
> The NXP downstream:
> The dts:
> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/arch/arm64/boot/dts/freescale/imx8mp.dtsi#L1872
> 
> The driver:
> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-imx8mp.c
> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-blk-ctrl.c
> 
> Note: The following log was reproduced with NXP downstream. For upstream
> I think we have similar issue if we still take audiomix blk ctrl as clk
> driver. Because the gpcv2 also use clk prepare enable API.
> 1. deadlock 1:
> Callchain after enable some lock debug:
> clk_ignore_unused will use lock seq: take prepare lock, take blk-ctrl 
> parent power domain genpd lock
> genpd_power_off_work_fun will use lock seq: take the power domain genpd 
> lock, take prepare lock.
> 
> clk_disable_unused:
> [   11.667711][  T108] -> #1 (&genpd->mlock){+.+.}-{3:3}:
> [   11.675041][  T108]        __lock_acquire+0xae4/0xef8
> [   11.680093][  T108]        lock_acquire+0xfc/0x2f8
> [   11.684888][  T108]        __mutex_lock+0x90/0x870
> [   11.689685][  T108]        mutex_lock_nested+0x44/0x50
> [   11.694826][  T108]        genpd_lock_mtx+0x18/0x24
> [   11.699706][  T108]        genpd_runtime_resume+0x90/0x214 (hold 
> genpd->mlock)
> [   11.705194][  T108]        __rpm_callback+0x80/0x2c0
> [   11.710160][  T108]        rpm_resume+0x468/0x650
> [   11.714866][  T108]        __pm_runtime_resume+0x60/0x88
> [   11.720180][  T108]        clk_pm_runtime_get+0x28/0x9c
> [   11.725410][  T108]        clk_disable_unused_subtree+0x8c/0x144
> [   11.731420][  T108]        clk_disable_unused_subtree+0x124/0x144
> [   11.737518][  T108]        clk_disable_unused+0xa4/0x11c (hold 
> prepare_lock)
> [   11.742833][  T108]        do_one_initcall+0x98/0x178
> [   11.747888][  T108]        do_initcall_level+0x9c/0xb8
> [   11.753028][  T108]        do_initcalls+0x54/0x94
> [   11.757736][  T108]        do_basic_setup+0x24/0x30
> [   11.762614][  T108]        kernel_init_freeable+0x70/0xa4
> [   11.768014][  T108]        kernel_init+0x14/0x18c
> [   11.772722][  T108]        ret_from_fork+0x10/0x18
> [   11.777512][  T108] -> #0 (prepare_lock){+.+.}-{3:3}:
> [   11.784749][  T108]        check_noncircular+0x134/0x13c
> [   11.790064][  T108]        validate_chain+0x590/0x2a04
> [   11.795204][  T108]        __lock_acquire+0xae4/0xef8
> [   11.800258][  T108]        lock_acquire+0xfc/0x2f8
> [   11.805050][  T108]        __mutex_lock+0x90/0x870
> [   11.809841][  T108]        mutex_lock_nested+0x44/0x50
> [   11.814983][  T108]        clk_unprepare+0x5c/0x100 ((hold prepare_lock))
> [   11.819864][  T108]        imx8m_pd_power_off+0xac/0x110
> [   11.825179][  T108]        genpd_power_off+0x1b4/0x2dc
> [   11.830318][  T108]        genpd_power_off_work_fn+0x38/0x58 (hold 
> genpd->mlock)
> [   11.835981][  T108]        process_one_work+0x270/0x444
> [   11.841208][  T108]        worker_thread+0x280/0x4e4
> [   11.846176][  T108]        kthread+0x13c/0x14c
> [   11.850621][  T108]        ret_from_fork+0x10/0x18
> 
> 
> 2:
> another mutex dead lock between deferred_probe_work_func/ 
> genpd_power_off_work_fn
> 
> The sequency in deferred_probe_work_func is lock the clk firstly, than 
> hold pd secondly.
> 
> 
> [   11.351159][   T46] the existing dependency chain (in reverse order) is:
> [   11.351162][   T46]
> [   11.351162][   T46] -> #1 (&genpd->mlock){+.+.}-{3:3}:
> [   11.351176][   T46]        __lock_acquire+0xae4/0xef8
> [   11.351180][   T46]        lock_acquire+0xfc/0x2f8
> [   11.351185][   T46]        __mutex_lock+0x90/0x870
> [   11.351188][   T46]        mutex_lock_nested+0x44/0x50
> [   11.351192][   T46]        genpd_lock_mtx+0x18/0x24
> [   11.351196][   T46]        genpd_runtime_suspend+0x1dc/0x224 (hold pd 
> lock)
> [   11.351201][   T46]        __rpm_callback+0x80/0x2c0
> [   11.351205][   T46]        rpm_suspend+0x2a4/0x62c
> [   11.351208][   T46]        rpm_idle+0x158/0x228
> [   11.351212][   T46]        __pm_runtime_idle+0x64/0xac
> [   11.351217][   T46]        clk_change_rate+0x400/0x494 
> (clk_pm_runtime_put()
> [   11.351220][   T46]        clk_change_rate+0x438/0x494
> [   11.351224][   T46]        clk_core_set_rate_nolock+0x22c/0x2d8
> [   11.351228][   T46]        clk_set_rate+0x94/0x134 (hold prepared lock)
> [   11.351232][   T46]        of_clk_set_defaults+0x27c/0x364
> [   11.351236][   T46]        platform_drv_probe+0x28/0xbc
> [   11.351241][   T46]        really_probe+0x1dc/0x4c0
> [   11.351245][   T46]        driver_probe_device+0x7c/0xb8
> [   11.351249][   T46]        __device_attach_driver+0x118/0x13c
> [   11.351253][   T46]        bus_for_each_drv+0x80/0xcc
> [   11.351257][   T46]        __device_attach+0xd0/0x174
> [   11.351261][   T46]        device_initial_probe+0x14/0x20
> [   11.351265][   T46]        bus_probe_device+0x34/0x9c
> [   11.351269][   T46]        deferred_probe_work_func+0x64/0xc4
> [   11.351274][   T46]        process_one_work+0x270/0x444
> [   11.351278][   T46]        worker_thread+0x280/0x4e4
> [   11.351288][   T46]        kthread+0x13c/0x14c
> [   11.529876][   T46]        ret_from_fork+0x10/0x18
> 

There are two possible solutions here:

1. Make it a contract between the blk-ctrl and the devices put into
blk-ctrl power domains that they first need to RPM resume then call the
clock functions, never call clock clock functions when the device is
suspended. This way the GPC domain is already up when any clock
manipulation is done, so the GPC will not need to take any clock
mutexes. Downside to this is that drivers then need to adhere to this
contract when they are in a blk-ctrl domain, which deviates from the
usual rules, so might take some driver writers by surprise if they
aren't aware of this.

2. Move the bus/reset clocks from the GPC domain to the blk-ctrl. In
the current design blk-ctrl has full control over the sequencing of the
GPC power up, so it would be possible to enable the bus/reset clocks
from the blk-ctrl driver, then power up the GPC domain. As the task
doing the the bus/reset clk enable would then be the same that already
has the clk_prepare mutex there will be no deadlock, as the clk
framework alows this kind of recursive locking.

Regards,
Lucas


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B288124880
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 14:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfLRNfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 08:35:25 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33570 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfLRNfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 08:35:24 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so1724359iln.0;
        Wed, 18 Dec 2019 05:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkEKgt/GZK2xmOcGzjWTpOOcB/kiPGj9OjuqfsdNIfE=;
        b=sssgw8nWNunrDFpKcaAgWjMyHej/RR2H11AeBSC/xDwY5ZQyBYSBn7hi5kkzz+yFeV
         Orw4J1cfsiRpDTz+nz5Yd4p+y9tN5Us8s7/YgtEqzXqLyg9IY1+hOVGQsWW3b9z5m6NS
         oCYbOVpV/WBdLxBl9O3Q5fnjj+YHPt6YdVVH743B9pKQiW5D1CJHwAcPvgNwk8JkVvdX
         n5Kh71LHQkGED5QDvSluKxYpxxAzI91qBTS2BqphYFDS3WP11Uxw/IY6tlzxUBE3+DJs
         r+FQf7OkHhU8X8qcWBNZfzBmBkv2lI25T6rtlMxc0Y86ICf4ml1CARcOu2HAs783IYI4
         mXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkEKgt/GZK2xmOcGzjWTpOOcB/kiPGj9OjuqfsdNIfE=;
        b=ufbJJCznjL9wdmCjEn7zQ2MzYfNTv/GP1D5Lk1wU58jS+ktbMDXx1ugt/4RE66bXyl
         sZhSLqrlqWyQO5OKxH/x8GdAy+E35FqggrNZzkQFgQguLwDcCW3Z5UPoexYeHYkm+Qrv
         rY+n5oKPoKRSWDWFPzj2osZDfYLbop90mS0wd8UphGdr2GvzOGVk/Mu2gDJYHlUeGp0V
         VZ+ETmHeM2MuRj7Fx1q+vrMz006dlaJE7SKf2Aj3pweoQq+fh+1a7G7UXQZDc9wN4YmU
         +LDXGkvNg30Gdn+2VprrTTSulp7rjX5MmvoYPh88KvY+L45j0Faa1kivRyRppmoBBCWI
         qrrQ==
X-Gm-Message-State: APjAAAWvUA51Oqbmpo11x1fXOYXeaZhK2hYpfGyvliAHUBPVaJt2as1/
        qFcFDJDkhz/rZJg3+lBicULYFFOPkWU4UVJjrCKE2jlw
X-Google-Smtp-Source: APXvYqwJAf46d/C9VjYfkHpeuMrtLbleQhk2rMy5HqEUAoJqtaKfqLVyH8Z8d5F1MGmKJXZT8+I9ntTVoI/PjfKQtVI=
X-Received: by 2002:a92:4095:: with SMTP id d21mr1831507ill.158.1576676123483;
 Wed, 18 Dec 2019 05:35:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1574458460.git.leonard.crestez@nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Dec 2019 07:35:12 -0600
Message-ID: <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr controller
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This adds support for dynamic scaling of the DDR Controller (ddrc)
> present on i.MX8M series chips. Actual frequency switching is
> implemented inside TF-A, this driver wraps the SMC calls and
> synchronizes the clk tree.
>
> DRAM frequency switching requires clock manipulation but during this operation
> DRAM itself is briefly inaccessible so this operation is performed a SMC call
> to by TF-A which runs from a SRAM area. Upon returning to linux the clock tree
> is updated to correspond to hardware configuration.
>
> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are handled
> manually: the driver will prepare/enable the new parents ahead of switching (so
> that the expected roots are enabled) and afterwards it will call clk_set_parent
> to ensure the parents in clock framework are up-to-date.
>
> This series is useful standalone and roughly similar to devfreq drivers for
> tegra and rockchip.
>
> Running at lower dram rates saves power but can affect the functionality of
> other blocks in the chip (display, vpu etc). Support for in-kernel constraints
> will some separately.
>
> This series has no dependencies outside linux-next. The driver depends
> on features from the NXP branch of TF-A and will cleanly fail to probe
> on mainline. There are also plans to upstream dram dvfs in TF-A.
>
> Changes since v6:
> * Replace ARCH_MXC || COMPILE_TEST with ARCH_MXC && HAVE_ARM_SMCCC
> * Collect reviews
> Link to v6: https://patchwork.kernel.org/cover/11244283/
>
> I'd rather not fix COMPILE_TEST with ifdefs for this driver, if anything
> that should be fixed in smccc header. ARCH_MXC doesn't imply SMCCC, it
> also covers some very old chips which don't have it.
>
> Resending full series because that's the standard method.
>
> Changes since v5:
> * Fix a dram_apb/dram_alt mixup in imx8m_ddrc_set_freq
> * Make clk_get_parent_by_index static (kbuild robot)
> * Adjust messages in imx8m_ddrc_set_freq
> * Use a for loop inside imx8m_ddrc_check_opps instead of while
> * More elaborate description in dt-bindings file.
> Link to v5: https://patchwork.kernel.org/cover/11240289/
>
> Changes since v4:
> * Restore empty _get_dev_status: testing shows this is *NOT* optional. If
> absent then switching to simple_ondemand governor will trigger an Oops.
> * Keep clk registration on single-line in clk-imx8m* for consistency with rest
> of the file.
> * Drop explicit "select PM_OPP"
> * Check for NULL new_dram_core_parent
> * Rename "out_dis_" labels to out_disable_*
> * Use dev_warn on imx8m_ddrc_set_freq error paths after SMC call (where
> operation is not abandoned).
> * More elaborate error messages in imx8m_ddrc_target
> * More elaborate checks when fetching clks in imx8m_ddrc_set_freq
> * Rename ddrc nodes to memory-controller@* as per devicetree.org "Generic Names
> Recommendation"
> * Defer perf support, it requires perf changes to fetch PMU by DT
> Link to v4: https://patchwork.kernel.org/cover/11235685/
>
> Changes since v3:
> * Rename to imx8m-ddrc. Similar blocks are present on imx7d and imx8qxp/imx8qm
> but soc integration is different.
> * Move dt bindings to /memory-controllers/fsl/
> * Fix dt validation issues
> * Fix imx8mm.dtsi ddrc referencing ddrc_opp_table which is only defined in evk
> * Move opps to child of ddrc device node
> * Only add imx_ddrc_get_dev_status in perf patch.
> * Adjust print messages
> Link to v3: https://patchwork.kernel.org/cover/11221935/
>
> Changes since v2:
> * Add support for entire imx8m family including imx8mq B0.
> * Also mark dram PLLs as CLK_GET_RATE_NO_CACHE (required for imx8mq b0 low OPP)
> * Explicitly update dram pll rate at the end of imx_ddrc_set_freq.
> * Use do_div in imx-ddrc (kbuild robot)
> * Improve explanations around adding CLK_GET_RATE_NO_CACHE to dram clks.
> (Stephen Boyd)
> * Handle ddrc devfreq-events earlier for fewer probe defers.
> * Validate DDRC opp tables versus firmware: supported OPPs depend on board and
> SOC revision.
> * Move DDRC opp tables to board dts because they can vary based on ram type on
> board.
> * Verify DDRC rate is changed in clk tree and otherwise report an error.
> * Change imx_ddrc_freq.rate to be measure in MT/s and round down from HZ in
> imx_ddrc_find_freq instead.
> * Split away from NOC scaling and interconnect support.
> Link to v2: https://patchwork.kernel.org/cover/11104113/
>
> Changes since v1:
> * bindings: Stop using "contains" for "compatible"
> * bindings: Set "additionalProperties: false" and document missing stuff.
> * Remove (c) from NXP copyright notice
> * Fix various checkpatch issues
> * Remove unused dram_alt_root clk from imx-ddrc
> Link to v1: https://patchwork.kernel.org/cover/11090649/
>
> Leonard Crestez (5):
>   clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
>   clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
>   dt-bindings: memory: Add bindings for imx8m ddr controller
>   PM / devfreq: Add dynamic scaling for imx8m ddr controller
>   arm64: dts: imx8m: Add ddr controller nodes
>
>  .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +
>  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +
>  drivers/clk/imx/clk-imx8mm.c                  |  11 +-
>  drivers/clk/imx/clk-imx8mn.c                  |  12 +-
>  drivers/clk/imx/clk-imx8mq.c                  |  12 +-
>  drivers/clk/imx/clk-pll14xx.c                 |   7 +
>  drivers/clk/imx/clk.h                         |   1 +
>  drivers/devfreq/Kconfig                       |   9 +

Since there is a Kconfig change, should there me a defconfig change?

>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/imx8m-ddrc.c                  | 465 ++++++++++++++++++
>  15 files changed, 670 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
>  create mode 100644 drivers/devfreq/imx8m-ddrc.c

I applied the whole series against 5.5-rc1 and I am trying to test it.
I know the 4.14 kernel NXP posted on Code Aurora is capable to
lowering the DDRC controller to 25MHz on the 8MM when the video is
off.  Since there is no video support yet for the 8MM, I was expecting
to see the DDRC clock to be at or around 25MHz.

Using debug FS, I can see the dram core clock is still running at
750MHz, and measuring power, it shows something consistent with what I
see on the Code Aurora kernel with video turned on and the clock at
750MHz.

Is there some way to get the dram_core_clk to drop to 25MHz to see
some power reduction?  The same commands used in the Yocto build don't
apply here since we don't have video.

thanks,

adam
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

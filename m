Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4B124A9C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLRPFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 10:05:42 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41556 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLRPFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 10:05:42 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so1944636ils.8;
        Wed, 18 Dec 2019 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qpZHSL4AcB3kgk21kuMo/J0A9vvDS0nQUGykICvtQMk=;
        b=MQicO8c7d5xphZrZZ8qnCNARW9qhHC9o4kWtr0VUl8E9+g+eQF3UnZOio3V3ao8TDd
         2AKj3X0NdxGAlN/pgeFIYb80YRYuGegXeCxhQZibG6bakH9cPX85nONa7BKOdW26TGiN
         889AdYCS3JC3ng67IjUZ9UDXSSp+rDqW7dh7AB971OaCCLKfgXa/HsAsg2q/HG4WGvyB
         2JJUmRwOK+rXLXsdMt/MtaQA0C4oiSKdSL6BRuU17xvVHOAQlyUyGCkrxXpRZByFWwbK
         c7bibNKb6mtc3dijQH5ZYU3IUCP/osO8kiAiYxNgFea8yChvw5SfTZep1oBZWl/oPqAj
         4dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qpZHSL4AcB3kgk21kuMo/J0A9vvDS0nQUGykICvtQMk=;
        b=MYBL6ivIojzJvqcWNtMAiasPZwD9Pjdj0guDltAfKHEGBLkKW5UtnIiv1NJFz49est
         gMzO+/nKFncPz9VWA+b9+IQd7E+CO9f9Yovb1+1aRKrIEdRsk/z5eicMjmDeUbry6vl8
         9UgN9R7UIXVSuEKD7HKpw1BEczHESP4XleK8FIxJwImDcvyjLfWdbsQgxEVhcVT1FBM+
         FL60qXAS3P/ECwjQCObGirnsrmN+es6IVW/CkdVguupaL9axrGqDdyfk5bnSIHlMEo7R
         Skk/9yCODmG7xeu6uw2rlx3NlJ96wKAkMUbl+CC2IXbkQq9wyEMT0BVUNe+lNPN97yiw
         XuRA==
X-Gm-Message-State: APjAAAVTLJDhLJVWQEw42pe1bs+xKn0nyVj0+NB9rgzK41P1E7Orq/PJ
        lbDVD6xcr95HkPjoo7fcZPwq/CCQpLZ4FkZitEE=
X-Google-Smtp-Source: APXvYqwHaKfjoBa3UFocF63h9McBZzwgUF6Oc6jihTkaDxCKuPN9zD6Cj8gnO6IZST5sLqu7rvKkOopQEa698xtBTf4=
X-Received: by 2002:a92:dc91:: with SMTP id c17mr2439267iln.78.1576681540519;
 Wed, 18 Dec 2019 07:05:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com> <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Dec 2019 09:05:28 -0600
Message-ID: <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com>
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
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 8:44 AM Leonard Crestez <leonard.crestez@nxp.com> w=
rote:
>
> On 18.12.2019 15:35, Adam Ford wrote:
> > On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nxp.co=
m> wrote:
> >>
> >> This adds support for dynamic scaling of the DDR Controller (ddrc)
> >> present on i.MX8M series chips. Actual frequency switching is
> >> implemented inside TF-A, this driver wraps the SMC calls and
> >> synchronizes the clk tree.
> >>
> >> DRAM frequency switching requires clock manipulation but during this o=
peration
> >> DRAM itself is briefly inaccessible so this operation is performed a S=
MC call
> >> to by TF-A which runs from a SRAM area. Upon returning to linux the cl=
ock tree
> >> is updated to correspond to hardware configuration.
> >>
> >> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are h=
andled
> >> manually: the driver will prepare/enable the new parents ahead of swit=
ching (so
> >> that the expected roots are enabled) and afterwards it will call clk_s=
et_parent
> >> to ensure the parents in clock framework are up-to-date.
> >>
> >> This series is useful standalone and roughly similar to devfreq driver=
s for
> >> tegra and rockchip.
> >>
> >> Running at lower dram rates saves power but can affect the functionali=
ty of
> >> other blocks in the chip (display, vpu etc). Support for in-kernel con=
straints
> >> will some separately.
> >>
> >> This series has no dependencies outside linux-next. The driver depends
> >> on features from the NXP branch of TF-A and will cleanly fail to probe
> >> on mainline. There are also plans to upstream dram dvfs in TF-A.
> >>
> >> Changes since v6:
> >> * Replace ARCH_MXC || COMPILE_TEST with ARCH_MXC && HAVE_ARM_SMCCC
> >> * Collect reviews
> >> Link to v6: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11244283%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637122729275120308&amp;sdata=3DZEZnG6pijjj4MO=
bC99c6%2BvC8BFEfT1KLVxbJCNocoWw%3D&amp;reserved=3D0
> >>
> >> I'd rather not fix COMPILE_TEST with ifdefs for this driver, if anythi=
ng
> >> that should be fixed in smccc header. ARCH_MXC doesn't imply SMCCC, it
> >> also covers some very old chips which don't have it.
> >>
> >> Resending full series because that's the standard method.
> >>
> >> Changes since v5:
> >> * Fix a dram_apb/dram_alt mixup in imx8m_ddrc_set_freq
> >> * Make clk_get_parent_by_index static (kbuild robot)
> >> * Adjust messages in imx8m_ddrc_set_freq
> >> * Use a for loop inside imx8m_ddrc_check_opps instead of while
> >> * More elaborate description in dt-bindings file.
> >> Link to v5: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11240289%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3DmMqglPQign%2B6=
NHgmDYoZ74%2FZeThGI6%2FgNkajo1VaHTI%3D&amp;reserved=3D0
> >>
> >> Changes since v4:
> >> * Restore empty _get_dev_status: testing shows this is *NOT* optional.=
 If
> >> absent then switching to simple_ondemand governor will trigger an Oops=
.
> >> * Keep clk registration on single-line in clk-imx8m* for consistency w=
ith rest
> >> of the file.
> >> * Drop explicit "select PM_OPP"
> >> * Check for NULL new_dram_core_parent
> >> * Rename "out_dis_" labels to out_disable_*
> >> * Use dev_warn on imx8m_ddrc_set_freq error paths after SMC call (wher=
e
> >> operation is not abandoned).
> >> * More elaborate error messages in imx8m_ddrc_target
> >> * More elaborate checks when fetching clks in imx8m_ddrc_set_freq
> >> * Rename ddrc nodes to memory-controller@* as per devicetree.org "Gene=
ric Names
> >> Recommendation"
> >> * Defer perf support, it requires perf changes to fetch PMU by DT
> >> Link to v4: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11235685%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3DLXG4bo0l7FOttZ=
IolJE73CK67AAAW72xfx8yq3Vld7o%3D&amp;reserved=3D0
> >>
> >> Changes since v3:
> >> * Rename to imx8m-ddrc. Similar blocks are present on imx7d and imx8qx=
p/imx8qm
> >> but soc integration is different.
> >> * Move dt bindings to /memory-controllers/fsl/
> >> * Fix dt validation issues
> >> * Fix imx8mm.dtsi ddrc referencing ddrc_opp_table which is only define=
d in evk
> >> * Move opps to child of ddrc device node
> >> * Only add imx_ddrc_get_dev_status in perf patch.
> >> * Adjust print messages
> >> Link to v3: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11221935%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3D%2FFGddgm7jq87=
j7tz6gNd%2B7V%2BGX4KF5RaPsnXK2kITdQ%3D&amp;reserved=3D0
> >>
> >> Changes since v2:
> >> * Add support for entire imx8m family including imx8mq B0.
> >> * Also mark dram PLLs as CLK_GET_RATE_NO_CACHE (required for imx8mq b0=
 low OPP)
> >> * Explicitly update dram pll rate at the end of imx_ddrc_set_freq.
> >> * Use do_div in imx-ddrc (kbuild robot)
> >> * Improve explanations around adding CLK_GET_RATE_NO_CACHE to dram clk=
s.
> >> (Stephen Boyd)
> >> * Handle ddrc devfreq-events earlier for fewer probe defers.
> >> * Validate DDRC opp tables versus firmware: supported OPPs depend on b=
oard and
> >> SOC revision.
> >> * Move DDRC opp tables to board dts because they can vary based on ram=
 type on
> >> board.
> >> * Verify DDRC rate is changed in clk tree and otherwise report an erro=
r.
> >> * Change imx_ddrc_freq.rate to be measure in MT/s and round down from =
HZ in
> >> imx_ddrc_find_freq instead.
> >> * Split away from NOC scaling and interconnect support.
> >> Link to v2: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11104113%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3D3hh0dR1h4Esc6q=
o79QQKH%2FkUQjrOUgLANR0PcIz1Pss%3D&amp;reserved=3D0
> >>
> >> Changes since v1:
> >> * bindings: Stop using "contains" for "compatible"
> >> * bindings: Set "additionalProperties: false" and document missing stu=
ff.
> >> * Remove (c) from NXP copyright notice
> >> * Fix various checkpatch issues
> >> * Remove unused dram_alt_root clk from imx-ddrc
> >> Link to v1: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11090649%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3DHj6NEmoaRHoR%2=
BQpFoUDdTlybO%2FSTatO2fFo20UGLJf0%3D&amp;reserved=3D0
> >>
> >> Leonard Crestez (5):
> >>    clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
> >>    clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
> >>    dt-bindings: memory: Add bindings for imx8m ddr controller
> >>    PM / devfreq: Add dynamic scaling for imx8m ddr controller
> >>    arm64: dts: imx8m: Add ddr controller nodes
> >>
> >>   .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++
> >>   arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
> >>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +
> >>   .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
> >>   arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +
> >>   arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
> >>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +
> >>   drivers/clk/imx/clk-imx8mm.c                  |  11 +-
> >>   drivers/clk/imx/clk-imx8mn.c                  |  12 +-
> >>   drivers/clk/imx/clk-imx8mq.c                  |  12 +-
> >>   drivers/clk/imx/clk-pll14xx.c                 |   7 +
> >>   drivers/clk/imx/clk.h                         |   1 +
> >>   drivers/devfreq/Kconfig                       |   9 +
> >
> > Since there is a Kconfig change, should there me a defconfig change?
>
> Yes, you need to enable CONFIG_ARM_IMX8M_DDRC_DEVFREQ in order to test
> this. Enabling as "m" should work.

I enabled it as 'm' but I was more curious to know if we should push
this upstream with the rest of the series.

>
> >>   drivers/devfreq/Makefile                      |   1 +
> >>   drivers/devfreq/imx8m-ddrc.c                  | 465 ++++++++++++++++=
++
> >>   15 files changed, 670 insertions(+), 10 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/memory-controll=
ers/fsl/imx8m-ddrc.yaml
> >>   create mode 100644 drivers/devfreq/imx8m-ddrc.c
> >
> > I applied the whole series against 5.5-rc1 and I am trying to test it.
> > I know the 4.14 kernel NXP posted on Code Aurora is capable to
> > lowering the DDRC controller to 25MHz on the 8MM when the video is
> > off.  Since there is no video support yet for the 8MM, I was expecting
> > to see the DDRC clock to be at or around 25MHz.
> >
> > Using debug FS, I can see the dram core clock is still running at
> > 750MHz, and measuring power, it shows something consistent with what I
> > see on the Code Aurora kernel with video turned on and the clock at
> > 750MHz.
> >
> > Is there some way to get the dram_core_clk to drop to 25MHz to see
> > some power reduction?  The same commands used in the Yocto build don't
> > apply here since we don't have video.
>
> Current upstream driver just keeps current frequency by default. Try the
> following:
>
> cd /sys/class/devfreq/devices/devfreq0

can't cd to /sys/class/devfreq/devices/devfreq0: No such file or directory

I did some checking and I found:
    imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init
firmware freq info: -19

Was there some prerequisite patches I needed to apply before your series?

I applied them against 5.5-r1, but if there is a better branch
somewhere, I can try that as well.

adam

> echo userspace > governor
> echo 25000000 > userspace/set_freq
> cat /sys/kernel/debug/clk/dram_core_clk/clk_rate
> echo 750000000 > userspace/set_freq
> cat /sys/kernel/debug/clk/dram_core_clk/clk_rate
>
> --
> Regards,
> Leonard

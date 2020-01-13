Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF2138C20
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 08:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMHC6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 02:02:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36842 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgAMHC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 02:02:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so7615523qkc.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Jan 2020 23:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K36+LY4tN/Cuk9TuKZ9obMWdWD2cQOBdE1ooq67vcY=;
        b=A/xMlDoReXGb70l5stlQeC5VS6KsRtK3WJhpU6b+scCfDM3Vf0zDYy+RAF+OIF4lrA
         fMSXjyto0aKufDajYSWeZzCh/lOr7eBgVuz3C3n1aNEXCmodW5s7FMPq2vhMpGeMawu5
         dM1ZJv50OY3YhDsvyyQCa9w5fBvuu34+PBwbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K36+LY4tN/Cuk9TuKZ9obMWdWD2cQOBdE1ooq67vcY=;
        b=Z+o79VbhT8/cfy8NjjMnLYXu9LRV1gWiMH5Q7OyhIYC8Hy2dDsMcw5qPe8hykW3RRP
         5NFIZsWbtrodOE9CQRDWMilbeyOCcvRxLSCq816dD+7oV7llKtM5xx/5t0KQTXUTjXFq
         uX5VfPl9sxVMAlDwaNuK6q080TOdeG8nPgBYMHtDN2MxHP9yIneYitZrvFDAk859z1aa
         sGRmN5xpCf9yln+fSyqIcfHKu+uqHyMpNNXNGi7hTZKdG/NLJn8fOf1zxqj5pIP3N55X
         QxJ8z2Da439wgR0FmqQMtFbe4CFxPlzKrHn5JmlP9+ITJGtEFhjXImedVY6hzaJlxqLd
         wdOw==
X-Gm-Message-State: APjAAAXfcusHG7c/4WSwbTMHo0VYlW/NDcobfBU/cEharihtbW+4ClVL
        /bUI5xtaRsevIpwrG3da7g+kmJjTCN4DvNWjrj0z/g==
X-Google-Smtp-Source: APXvYqzyFcsTC6SV/9v+0c2iO5eTJ1fr5S8u1LUXKUfdU24tfRLPsnI2WnOV4KaJ6n0aX7Qh/FjTi4RgwzDmSx7ggc8=
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr14161009qky.299.1578898977343;
 Sun, 12 Jan 2020 23:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20190906100514.30803-1-roger.lu@mediatek.com> <20190906100514.30803-2-roger.lu@mediatek.com>
 <20190930133548.GA24574@bogus> <1577429450.10290.47.camel@mtksdaap41>
In-Reply-To: <1577429450.10290.47.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 13 Jan 2020 15:02:46 +0800
Message-ID: <CANMq1KDHPA9eOufL5X9OLfQESL=MdHvuQfQkyJ1Q381MeDkSQQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: soc: add mtk svs dt-bindings
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 27, 2019 at 2:51 PM Roger Lu <roger.lu@mediatek.com> wrote:
>
> Dear Rob,
>
> Sorry for the late reply.
>
> On Mon, 2019-09-30 at 08:35 -0500, Rob Herring wrote:
> > On Fri, Sep 06, 2019 at 06:05:13PM +0800, Roger Lu wrote:
> > > Document the binding for enabling mtk svs on MediaTek SoC.
> > >
> > > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/power/mtk-svs.txt     | 88 +++++++++++++++++++
> > >  1 file changed, 88 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > new file mode 100644
> > > index 000000000000..6a71992ef162
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > @@ -0,0 +1,88 @@
> > > +* Mediatek Smart Voltage Scaling (MTK SVS)
> > > +
> > > +This describes the device tree binding for the MTK SVS controller (bank)
> > > +which helps provide the optimized CPU/GPU/CCI voltages. This device also
> > > +needs thermal data to calculate thermal slope for accurately compensate
> > > +the voltages when temperature change.
> > > +
> > > +Required properties:
> > > +- compatible:
> > > +  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
> > > +- reg: Address range of the MTK SVS controller.
> > > +- interrupts: IRQ for the MTK SVS controller.
> > > +- clocks, clock-names: Clocks needed for the svs controller. required
> > > +                       clocks are:
> > > +                  "main_clk": Main clock needed for register access
> >
> > '_clk' is redundant.
>
> Oh Okay. I'll remove _clk. Thanks.
>
> >
> > > +- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
> > > +- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
> > > +
> > > +Subnodes:
> > > +- svs_cpu_little: SVS bank device node of little CPU
> > > +  compatible: "mediatek,mt8183-svs-cpu-little"
> > > +  operating-points-v2: OPP table hooked by SVS little CPU bank.
> > > +                  SVS will optimze this OPP table voltage part.
> > > +  vcpu-little-supply: PMIC buck of little CPU
> > > +- svs_cpu_big: SVS bank device node of big CPU
> > > +  compatible: "mediatek,mt8183-svs-cpu-big"
> > > +  operating-points-v2: OPP table hooked by SVS big CPU bank.
> > > +                  SVS will optimze this OPP table voltage part.
> > > +  vcpu-big-supply: PMIC buck of big CPU
> > > +- svs_cci: SVS bank device node of CCI
> > > +  compatible: "mediatek,mt8183-svs-cci"
> > > +  operating-points-v2: OPP table hooked by SVS CCI bank.
> > > +                  SVS will optimze this OPP table voltage part.
> > > +  vcci-supply: PMIC buck of CCI
> > > +- svs_gpu: SVS bank device node of GPU
> > > +  compatible: "mediatek,mt8183-svs-gpu"
> > > +  operating-points-v2: OPP table hooked by SVS GPU bank.
> > > +                  SVS will optimze this OPP table voltage part.
> > > +  vgpu-spply: PMIC buck of GPU
> > > +
> > > +Example:
> > > +
> > > +   svs: svs@1100b000 {
> > > +           compatible = "mediatek,mt8183-svs";
> > > +           reg = <0 0x1100b000 0 0x1000>;
> > > +           interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;
> >
> > GIC interrupts are 3 cells, you have 4.
>
> Oops, I'll remove the fourth parameter. Thanks a lot.
>
> >
> > > +           clocks = <&infracfg CLK_INFRA_THERM>;
> > > +           clock-names = "main_clk";
> > > +           nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> > > +           nvmem-cell-names = "svs-calibration-data", "calibration-data";
> > > +
> > > +           svs_cpu_little: svs_cpu_little {
> >
> > Don't use '_' in node names.
>
> Okay. I'll replace it with '-'. Thanks.
>
> >
> > > +                   compatible = "mediatek,mt8183-svs-cpu-little";
> > > +                   operating-points-v2 = <&cluster0_opp>;
> > > +           };
> > > +
> > > +           svs_cpu_big: svs_cpu_big {
> > > +                   compatible = "mediatek,mt8183-svs-cpu-big";
> > > +                   operating-points-v2 = <&cluster1_opp>;
> > > +           };
> > > +
> > > +           svs_cci: svs_cci {
> > > +                   compatible = "mediatek,mt8183-svs-cci";
> > > +                   operating-points-v2 = <&cci_opp>;
> > > +           };
> > > +
> > > +           svs_gpu: svs_gpu {
> > > +                   compatible = "mediatek,mt8183-svs-gpu";
> > > +                   power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> > > +                   operating-points-v2 = <&gpu_opp_table>;
> > > +           };
> > > +   };
> > > +
> > > +   &svs_cpu_little {
> > > +           vcpu-little-supply = <&mt6358_vproc12_reg>;
> >
> > It's already defined to have OPP and supply in the cpu nodes. Parse them
> > to get this information rather than duplicating it here.
> >
> > The same should apply to the CCI and GPU.
>
> Please let me explain the reason why I add SVS sub-nodes. I ever try to
> parse other nodes to get desired power-domains/OPP table. However, it
> makes SVS driver harder to develop and maintain.
>
> 1. When a SVS-controller-init wants GPU_CORE0's OPP table in one node
> but it needs power-domains(GPU_MFG_2D) in another node, it becomes
> complicated and confusing when SVS sub-node tries to parse many nodes.
> Therefore, we want SVS sub-node to focus on what SVS bank requires by
> how we do in this patch.
>
> 2. In hardware point of view, SVS controller depends on other hardware's
> power only. All the SVS controller registers are in SVS hardware. So, we
> think It's good that SVS sub-node describes what SVS controller requires
> instead of linking other subsys nodes and parse the property that SVS
> controller needs.
>
> 3. We want SVS driver to have a generic way to attain subsys device for
> using "pm_runtime and OPP framework" API. If SVS driver tries to parse
> CPU(little/big core) and other subsys device node(e.g cci/gpu), it means
> SVS driver has to maintain different methodologies(cpu-specific?
> devfreq? others?) in order to get CPU(little/big core) and other subsys
> device(e.g cci/gpu) for using "pm_runtime and OPP framework" API.

(Didn't see this more complete reply before replying to v6, I can see
your argument, but if we wanted to push further to have the sub-device
node in the DT)

From what I see, the SVS driver for node x (cpu/cci/gpu) requires only 3 things:
 - An OPP table => that should always be "operating-points-v2"
property of the node x.
 - A power domain => that should always be power-domains property of node x.
 - A regulator. That one is a bit tricky as the cpu/cci uses "proc",
but gpu uses "mali" (at least on 8183). But maybe you can add a
child-regulator-name property or something to the DT so that the SVS
driver can find the correct regulator?

Seems like the solution could be quite generic?

> >
> > Rob
>
> Sincerely,
> Roger Lu.

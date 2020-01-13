Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD3139537
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAMPvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 10:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMPvM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 10:51:12 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57BE207FD;
        Mon, 13 Jan 2020 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578930670;
        bh=rD4hU2QqJoSErZl4UuTT2zPbb7QwaT2/PFJkW2k69y8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pmSTR/vd3mg8eR1cW5YBs7g4oPeTSfDybSWz+8KoUME7c/ctOmWtOhUy/WNQZlDaZ
         fajBNja4kq5mrRKZNvMx6l2pMtgKHEnpKncpsy662u4pU3Fuw51btDKxvDXkU+l135
         r+pN3hJ7tATHZlpyrNYoCyeYQTVBud8A47X+4AoI=
Received: by mail-qk1-f173.google.com with SMTP id d71so8932828qkc.0;
        Mon, 13 Jan 2020 07:51:10 -0800 (PST)
X-Gm-Message-State: APjAAAXEUWQGAV9BpxCshIB9uhOwCGzmxqvvVqcNg5xzJ2SxmTDS3PdL
        2H4EYRJQ5xzMuKOvxauOtUR0ndE0aCOE/5hXZg==
X-Google-Smtp-Source: APXvYqxu73YIMoP9uqRC4HzO0JTlnG/L6A5l+pEvaDbz1NNmXMAtPsneSeN1KwdYZ6T0MMijcnS7tLhwhir05gbrTwY=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr17408883qkn.254.1578930669733;
 Mon, 13 Jan 2020 07:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20200107070154.1574-1-roger.lu@mediatek.com> <20200107070154.1574-2-roger.lu@mediatek.com>
 <20200108203829.GA18987@bogus> <CANMq1KBu-gFy701BgFcjEwyhV9GgCCU2mkT9c8LviOJKBF30UA@mail.gmail.com>
In-Reply-To: <CANMq1KBu-gFy701BgFcjEwyhV9GgCCU2mkT9c8LviOJKBF30UA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jan 2020 09:50:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLnVEhvAh_8DfGWRZa+MdPRpXc9sWEQ6-3HQAeUfvkOSg@mail.gmail.com>
Message-ID: <CAL_JsqLnVEhvAh_8DfGWRZa+MdPRpXc9sWEQ6-3HQAeUfvkOSg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: soc: add mtk svs dt-bindings
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 12:44 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Jan 9, 2020 at 4:38 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jan 07, 2020 at 03:01:52PM +0800, Roger Lu wrote:
> > > Document the binding for enabling mtk svs on MediaTek SoC.
> > >
> > > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/power/mtk-svs.txt     | 76 +++++++++++++++++++
> > >  1 file changed, 76 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > new file mode 100644
> > > index 000000000000..9a3e81b9e1d2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > @@ -0,0 +1,76 @@
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
> > > +- clocks, clock-names: Clocks needed for the svs hardware. required
> > > +                       clocks are:
> > > +                    "main": Main clock for svs controller to work.
> > > +- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
> > > +- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
> > > +
> > > +Subnodes:
> > > +- svs-cpu-little: SVS bank device node of little CPU
> > > +  compatible: "mediatek,mt8183-svs-cpu-little"
> > > +  operating-points-v2: OPP table hooked by SVS little CPU bank.
> > > +                    SVS will optimze this OPP table voltage part.
> > > +  vcpu-little-supply: PMIC buck of little CPU
> > > +- svs-cpu-big: SVS bank device node of big CPU
> > > +  compatible: "mediatek,mt8183-svs-cpu-big"
> > > +  operating-points-v2: OPP table hooked by SVS big CPU bank.
> > > +                    SVS will optimze this OPP table voltage part.
> > > +  vcpu-big-supply: PMIC buck of big CPU
> > > +- svs-cci: SVS bank device node of CCI
> > > +  compatible: "mediatek,mt8183-svs-cci"
> > > +  operating-points-v2: OPP table hooked by SVS CCI bank.
> > > +                    SVS will optimze this OPP table voltage part.
> > > +  vcci-supply: PMIC buck of CCI
> > > +- svs-gpu: SVS bank device node of GPU
> > > +  compatible: "mediatek,mt8183-svs-gpu"
> > > +  operating-points-v2: OPP table hooked by SVS GPU bank.
> > > +                    SVS will optimze this OPP table voltage part.
> > > +  vgpu-supply: PMIC buck of GPU
> > > +
> > > +Example:
> > > +
> > > +     svs: svs@1100b000 {
> > > +             compatible = "mediatek,mt8183-svs";
> > > +             reg = <0 0x1100b000 0 0x1000>;
> > > +             interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> > > +             clocks = <&infracfg CLK_INFRA_THERM>;
> > > +             clock-names = "main_clk";
> > > +             nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> > > +             nvmem-cell-names = "svs-calibration-data", "calibration-data";
> > > +
> > > +             svs_cpu_little: svs-cpu-little {
> > > +                     compatible = "mediatek,mt8183-svs-cpu-little";
> > > +                     operating-points-v2 = <&cluster0_opp>;
> > > +                     vcpu-little-supply = <&mt6358_vproc12_reg>;
> > > +             };
> >
> > I don't think this is a good binding. This information already exists
> > elsewhere in the DT, so your driver should just look in those nodes.
> > For example the regulator can be in the cpu nodes or the OPP table
> > itself.
>
> Roger, if that helps, without changing any other binding, on 8183,
> basically you could have:
>  - svs-cpu-little: Add a handle to &cpu0 and get the regulator/opp
> table from it.
>  - svs-cpu-big: Handle to &cpu4

Why do you need those? Use the compatible of the cpus to determine big
and little cores. Or there's the cpu capacity property that could be
used instead.

>  - svs-cci: Handle to &cci

Is there more than 1 CCI? Just retrieve the node by the compatible.
There's no need to have nodes that simply serve as a collection of
data for some driver.

>  - svs-gpu: Handle to &gpu (BTW, it is expected that SVS would only
> apply to vgpu/mali regulator, and not vsram regulator?)
>
> I'm not too sure how we'd fetch the right regulator name, however (for
> the first 3 the name is "proc", for the last one it's "mali"), maybe
> add a regulator-name list in the DT?

To put this another way, write an SoC specific driver that understands
to some extent what exists in the SoC (and DT). I doubt something like
this is going to be generic across more than a few SoCs at most.

Rob

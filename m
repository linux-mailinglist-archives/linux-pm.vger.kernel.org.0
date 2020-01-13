Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4270138BF0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 07:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMGo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 01:44:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40989 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMGoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 01:44:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so7551723qke.8
        for <linux-pm@vger.kernel.org>; Sun, 12 Jan 2020 22:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNID1+xlk/LusKrfyvTRadaTjl4JTdHdZqFClmlrkE8=;
        b=OyvIPxXK+9gRKfh1j2g/pw9Okrn9nsbKhZjAf9nvWrFWTasOHoycaN/UYYMfhcIC19
         q7V2LwdxqeCs4zYNYujxCALeZwUnxdGHWOyse3uCMcKGt+LjGnSL1M0bpUfxgD4n2fec
         c1TWiw/luhrhXoyB6w/D1tFMJi+V+IvKJEasQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNID1+xlk/LusKrfyvTRadaTjl4JTdHdZqFClmlrkE8=;
        b=TddBswKlClN7wGZPI2IdsaDLEoFsEU7f7UVDZxuwaYoRmOxbSZ0v/vf1Tm18FHOcXC
         u9d3Wc44K6NH6uEeCGN4abKYJl3w0bs8knu63ndQ5b0DkKGoGB2lbga8OO5BUsKoSSRP
         2HXLpoUc3U17iLRs6tCmvMaW5uRxmziokfhBDhWNo9yZx0orhTgQAZzYyuF9T7TiGUI3
         Dx+LgOCfMLFjwWovIWeM8ANa2IBoULbfXVgj6qGdXL81UgV2NwncXt0aW5XceiuhdJuF
         /6k+upr39VtYIPYqLvPEQZNC5nsfELZZB2rFamgNWHIzEwli399bmgvS/vIXBzSis4DY
         HFRA==
X-Gm-Message-State: APjAAAWK1eH/1ozqUHmRiHcGyWjvcxPLszF0kkdzVjHk/0NPvU5Azc20
        5ro3ySvqkP5Q9BhQ9K7/HH/bSTILDrn3nPDzbfMc7Q==
X-Google-Smtp-Source: APXvYqzL5B5r73soR628uc2jDkq8fU1OUh+0wVt0KMcWK9cN8MbW5ohquaKM4R+Ks/ACv40A/WWnmnHJYeJHxhoohe8=
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr14117387qky.299.1578897858106;
 Sun, 12 Jan 2020 22:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20200107070154.1574-1-roger.lu@mediatek.com> <20200107070154.1574-2-roger.lu@mediatek.com>
 <20200108203829.GA18987@bogus>
In-Reply-To: <20200108203829.GA18987@bogus>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 13 Jan 2020 14:44:07 +0800
Message-ID: <CANMq1KBu-gFy701BgFcjEwyhV9GgCCU2mkT9c8LviOJKBF30UA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: soc: add mtk svs dt-bindings
To:     Rob Herring <robh@kernel.org>
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
        lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 9, 2020 at 4:38 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 07, 2020 at 03:01:52PM +0800, Roger Lu wrote:
> > Document the binding for enabling mtk svs on MediaTek SoC.
> >
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >  .../devicetree/bindings/power/mtk-svs.txt     | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > new file mode 100644
> > index 000000000000..9a3e81b9e1d2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > @@ -0,0 +1,76 @@
> > +* Mediatek Smart Voltage Scaling (MTK SVS)
> > +
> > +This describes the device tree binding for the MTK SVS controller (bank)
> > +which helps provide the optimized CPU/GPU/CCI voltages. This device also
> > +needs thermal data to calculate thermal slope for accurately compensate
> > +the voltages when temperature change.
> > +
> > +Required properties:
> > +- compatible:
> > +  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
> > +- reg: Address range of the MTK SVS controller.
> > +- interrupts: IRQ for the MTK SVS controller.
> > +- clocks, clock-names: Clocks needed for the svs hardware. required
> > +                       clocks are:
> > +                    "main": Main clock for svs controller to work.
> > +- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
> > +- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
> > +
> > +Subnodes:
> > +- svs-cpu-little: SVS bank device node of little CPU
> > +  compatible: "mediatek,mt8183-svs-cpu-little"
> > +  operating-points-v2: OPP table hooked by SVS little CPU bank.
> > +                    SVS will optimze this OPP table voltage part.
> > +  vcpu-little-supply: PMIC buck of little CPU
> > +- svs-cpu-big: SVS bank device node of big CPU
> > +  compatible: "mediatek,mt8183-svs-cpu-big"
> > +  operating-points-v2: OPP table hooked by SVS big CPU bank.
> > +                    SVS will optimze this OPP table voltage part.
> > +  vcpu-big-supply: PMIC buck of big CPU
> > +- svs-cci: SVS bank device node of CCI
> > +  compatible: "mediatek,mt8183-svs-cci"
> > +  operating-points-v2: OPP table hooked by SVS CCI bank.
> > +                    SVS will optimze this OPP table voltage part.
> > +  vcci-supply: PMIC buck of CCI
> > +- svs-gpu: SVS bank device node of GPU
> > +  compatible: "mediatek,mt8183-svs-gpu"
> > +  operating-points-v2: OPP table hooked by SVS GPU bank.
> > +                    SVS will optimze this OPP table voltage part.
> > +  vgpu-supply: PMIC buck of GPU
> > +
> > +Example:
> > +
> > +     svs: svs@1100b000 {
> > +             compatible = "mediatek,mt8183-svs";
> > +             reg = <0 0x1100b000 0 0x1000>;
> > +             interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> > +             clocks = <&infracfg CLK_INFRA_THERM>;
> > +             clock-names = "main_clk";
> > +             nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> > +             nvmem-cell-names = "svs-calibration-data", "calibration-data";
> > +
> > +             svs_cpu_little: svs-cpu-little {
> > +                     compatible = "mediatek,mt8183-svs-cpu-little";
> > +                     operating-points-v2 = <&cluster0_opp>;
> > +                     vcpu-little-supply = <&mt6358_vproc12_reg>;
> > +             };
>
> I don't think this is a good binding. This information already exists
> elsewhere in the DT, so your driver should just look in those nodes.
> For example the regulator can be in the cpu nodes or the OPP table
> itself.

Roger, if that helps, without changing any other binding, on 8183,
basically you could have:
 - svs-cpu-little: Add a handle to &cpu0 and get the regulator/opp
table from it.
 - svs-cpu-big: Handle to &cpu4
 - svs-cci: Handle to &cci
 - svs-gpu: Handle to &gpu (BTW, it is expected that SVS would only
apply to vgpu/mali regulator, and not vsram regulator?)

I'm not too sure how we'd fetch the right regulator name, however (for
the first 3 the name is "proc", for the last one it's "mali"), maybe
add a regulator-name list in the DT?

>
> Rob

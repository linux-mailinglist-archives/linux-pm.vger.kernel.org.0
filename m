Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4F011348
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 08:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEBGTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 02:19:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8295 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbfEBGTj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 02:19:39 -0400
X-UUID: 7e95605b17544ffc80cac70bcfe2c597-20190502
X-UUID: 7e95605b17544ffc80cac70bcfe2c597-20190502
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 759783719; Thu, 02 May 2019 14:19:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 May 2019 14:19:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 May 2019 14:19:31 +0800
Message-ID: <1556777971.12123.35.camel@mtksdaap41>
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
From:   Roger Lu <roger.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, "Kevin Hilman" <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <Angus.Lin@mediatek.com>,
        <Andy-YT.Liu@mediatek.com>
Date:   Thu, 2 May 2019 14:19:31 +0800
In-Reply-To: <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
References: <20190430112012.4514-1-roger.lu@mediatek.com>
         <20190430112012.4514-2-roger.lu@mediatek.com>
         <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2E2F08777EB39D1A247C11B19DDF97D305EB6283DD65100F47975443F62BB5352000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Stephen,

Thanks for the review.

On Tue, 2019-04-30 at 13:31 -0700, Stephen Boyd wrote:
> Quoting Roger Lu (2019-04-30 04:20:10)
> > Document the binding for enabling mtk svs on MediaTek SoC.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >  .../devicetree/bindings/power/mtk-svs.txt     | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > new file mode 100644
> > index 000000000000..355329db74ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > @@ -0,0 +1,70 @@
> > +* Mediatek Smart Voltage Scaling (MTK SVS)
> > +
> > +This describes the device tree binding for the MTK SVS controller
> > +which helps provide the optimized CPU/GPU/CCI voltages. This device also
> > +needs thermal data to calculate thermal slope for accurately compensate
> > +the voltages when temperature change.
> > +
> > +Required properties:
> > +- compatible:
> > +  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
> > +- reg: Address range of the MTK SVS controller.
> > +- interrupts: IRQ for the MTK SVS controller.
> > +- clocks, clock-names: Clocks needed for the svs controller. required
> > +                       clocks are:
> > +                      "main_clk": Main clock needed for register access
> > +- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
> > +- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
> > +- svs_xxx: Phandle of svs_bank device for controlling corresponding opp
> 
> Properties shouldn't have underscores in them. Use dashes?
Ok. I'll use dashes.

> 
> > +           table and power-domains.
> > +- vxxx-supply: Phandle to each regulator. vxxx can be "vcpu_little",
> > +              "vcpu_big", "vcci" and "vgpu".
> > +
> > +Example:
> > +
> > +       svs: svs@1100b000 {
> > +               compatible = "mediatek,mt8183-svs";
> > +               reg = <0 0x1100b000 0 0x1000>;
> > +               interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;
> > +               clocks = <&infracfg CLK_INFRA_THERM>;
> > +               clock-names = "main_clk";
> > +               nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> > +               nvmem-cell-names = "svs-calibration-data", "calibration-data";
> > +
> > +               svs_cpu_little: svs_cpu_little {
> > +                       compatible = "mediatek,mt8183-svs-cpu-little";
> > +                       operating-points-v2 = <&cluster0_opp>;
> > +               };
> > +
> > +               svs_cpu_big: svs_cpu_big {
> > +                       compatible = "mediatek,mt8183-svs-cpu-big";
> > +                       operating-points-v2 = <&cluster1_opp>;
> > +               };
> > +
> > +               svs_cci: svs_cci {
> > +                       compatible = "mediatek,mt8183-svs-cci";
> > +                       operating-points-v2 = <&cluster2_opp>;
> > +               };
> > +
> > +               svs_gpu: svs_gpu {
> > +                       compatible = "mediatek,mt8183-svs-gpu";
> > +                       power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> > +                       operating-points-v2 = <&gpu_opp_table>;
> > +               };
> 
> It looks like you need multiple OPPs for a single device, because it has
> different independent power supplies it wants to associate the OPP
> tables with?
Yes. SVS has different controllers inside the hardware in order to
calculate and optimize different OPP table voltage part.

> Why can't these OPP tables be attached to the devices that
> use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices don't
> have OPP tables that this hardware block can look up somehow.
Those OPP tables are attached by our DVFS node (please refers below
patch). SVS just shares with their OPP table and help optimize these OPP
tables' voltage part.

Add cpufreq DTS node to the mt8183 and mt8183-evb
https://patchwork.kernel.org/patch/10921675/


> Similarly,
> the power domains should probably be part of the devices that are using
> them and not these sub-nodes that are mirroring the other hardware
> blocks in the system?
Oh. There is a svs controller in GPU power-domain. We need to turn on
GPU power so that svs controller can work functionally. Therefore, we
add GPU power-domains in our svs_gpu sub-node.


> 
> > +       };
> > +
> > +       &svs_cpu_little {
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



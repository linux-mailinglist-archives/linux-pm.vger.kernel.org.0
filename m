Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12C6100DA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfD3Ube (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfD3Ube (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Apr 2019 16:31:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068C92087B;
        Tue, 30 Apr 2019 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556656293;
        bh=Rl6KR3mE/J4TovWktTnPEk6bL3lFfupWJ2cXE8RKcsA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=wHvQCF48Origsh+9ks+KYh/bRuAs6K6xp778iJA1nRTZzsT36/reutO1Up4TzrAds
         WiRpljJ4fDtsI1kUoNe0YkY9axaShkcYuXsQCaYQqivN7wRDjcek1H8cymh1H4V+Mr
         /CdVuiy/7arCFuCtZOhpv5dw5dpt+lmN6NiHND5k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430112012.4514-2-roger.lu@mediatek.com>
References: <20190430112012.4514-1-roger.lu@mediatek.com> <20190430112012.4514-2-roger.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Lu <roger.lu@mediatek.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Roger Lu <roger.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Message-ID: <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 30 Apr 2019 13:31:32 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Roger Lu (2019-04-30 04:20:10)
> Document the binding for enabling mtk svs on MediaTek SoC.
>=20
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../devicetree/bindings/power/mtk-svs.txt     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Docume=
ntation/devicetree/bindings/power/mtk-svs.txt
> new file mode 100644
> index 000000000000..355329db74ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> @@ -0,0 +1,70 @@
> +* Mediatek Smart Voltage Scaling (MTK SVS)
> +
> +This describes the device tree binding for the MTK SVS controller
> +which helps provide the optimized CPU/GPU/CCI voltages. This device also
> +needs thermal data to calculate thermal slope for accurately compensate
> +the voltages when temperature change.
> +
> +Required properties:
> +- compatible:
> +  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
> +- reg: Address range of the MTK SVS controller.
> +- interrupts: IRQ for the MTK SVS controller.
> +- clocks, clock-names: Clocks needed for the svs controller. required
> +                       clocks are:
> +                      "main_clk": Main clock needed for register access
> +- nvmem-cells: Phandle to the calibration data provided by a nvmem devic=
e.
> +- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-da=
ta"
> +- svs_xxx: Phandle of svs_bank device for controlling corresponding opp

Properties shouldn't have underscores in them. Use dashes?

> +           table and power-domains.
> +- vxxx-supply: Phandle to each regulator. vxxx can be "vcpu_little",
> +              "vcpu_big", "vcci" and "vgpu".
> +
> +Example:
> +
> +       svs: svs@1100b000 {
> +               compatible =3D "mediatek,mt8183-svs";
> +               reg =3D <0 0x1100b000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;
> +               clocks =3D <&infracfg CLK_INFRA_THERM>;
> +               clock-names =3D "main_clk";
> +               nvmem-cells =3D <&svs_calibration>, <&thermal_calibration=
>;
> +               nvmem-cell-names =3D "svs-calibration-data", "calibration=
-data";
> +
> +               svs_cpu_little: svs_cpu_little {
> +                       compatible =3D "mediatek,mt8183-svs-cpu-little";
> +                       operating-points-v2 =3D <&cluster0_opp>;
> +               };
> +
> +               svs_cpu_big: svs_cpu_big {
> +                       compatible =3D "mediatek,mt8183-svs-cpu-big";
> +                       operating-points-v2 =3D <&cluster1_opp>;
> +               };
> +
> +               svs_cci: svs_cci {
> +                       compatible =3D "mediatek,mt8183-svs-cci";
> +                       operating-points-v2 =3D <&cluster2_opp>;
> +               };
> +
> +               svs_gpu: svs_gpu {
> +                       compatible =3D "mediatek,mt8183-svs-gpu";
> +                       power-domains =3D <&scpsys MT8183_POWER_DOMAIN_MF=
G_2D>;
> +                       operating-points-v2 =3D <&gpu_opp_table>;
> +               };

It looks like you need multiple OPPs for a single device, because it has
different independent power supplies it wants to associate the OPP
tables with? Why can't these OPP tables be attached to the devices that
use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices don't
have OPP tables that this hardware block can look up somehow. Similarly,
the power domains should probably be part of the devices that are using
them and not these sub-nodes that are mirroring the other hardware
blocks in the system?

> +       };
> +
> +       &svs_cpu_little {

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870F0123D4
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBVGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 17:06:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44254 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 17:06:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so3417531otl.11;
        Thu, 02 May 2019 14:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CuGAjHSPjjBWWVAFMyTE3knLTp6TXz4Szt1/dM+IzVE=;
        b=rsG7eYZb696PD16MRvFrtA8D2PQdZ+q5YfAgBSWbssxu+Vqg7439OmEHdOOy6rYawu
         V+6uygi7MyhdNj2dgPjtTgCYmRF+B3PQwMGX383nBwH+o9zssBp+SwRLQdqsRzbQLigN
         kZeketZEy3iUeQT8oxedeu+zuhb1b9nls9TcYPle6KdlZZm2o+EtOyK1hWBsUHv8V5SG
         1BXW4gTYlBnNZiY5kZTTNPeecpi3HeJYHIddOkRYATWChRUERq6cLVwyZjjV5bKYz0B1
         LQTcewpZQ3eXglT2wJRKP+AAtRFm4/z3SbzcLMJv+mSKEY3LIVhQwovu9wHmrDBATW9f
         zKbQ==
X-Gm-Message-State: APjAAAU5qxwtDscuwAW+b2+MnAQGCM2hw3+7g0MwRe+Xvrw3o0FdW1Sd
        TfIcbA+M934LyloElstYtA==
X-Google-Smtp-Source: APXvYqyKMgnvb3ZJTI9cej9idHGzwn8Jc5NYtnpoVITtSflxkN3uRtjD+X0X3SoavlxzWIHmMYUeRQ==
X-Received: by 2002:a9d:5e82:: with SMTP id f2mr4073879otl.217.1556831209035;
        Thu, 02 May 2019 14:06:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a131sm192923oif.23.2019.05.02.14.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 14:06:48 -0700 (PDT)
Date:   Thu, 2 May 2019 16:06:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
Message-ID: <20190502210647.GA32209@bogus>
References: <20190430112012.4514-1-roger.lu@mediatek.com>
 <20190430112012.4514-2-roger.lu@mediatek.com>
 <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 01:31:32PM -0700, Stephen Boyd wrote:
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

It's also a node, not a property.

> 
> > +           table and power-domains.
> > +- vxxx-supply: Phandle to each regulator. vxxx can be "vcpu_little",
> > +              "vcpu_big", "vcci" and "vgpu".

Just list each property instead of the indirection with 'xxx'. Though 
here to, these should be in the nodes actually getting the power.

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

Not documented. Though I think the child nodes should be removed if you 
do as Stephen suggests below.

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
> tables with? Why can't these OPP tables be attached to the devices that
> use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices don't
> have OPP tables that this hardware block can look up somehow. Similarly,
> the power domains should probably be part of the devices that are using
> them and not these sub-nodes that are mirroring the other hardware
> blocks in the system?
> 
> > +       };
> > +
> > +       &svs_cpu_little {

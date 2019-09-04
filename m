Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E479EA7A85
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 07:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfIDFBH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 01:01:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41916 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfIDFBH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 01:01:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so5802956pfo.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2019 22:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lP88Oq7al7PBW9u8uObARBFewmt5nawXVbYgCnhmgcw=;
        b=aQFs7BkXwDJuV1ik953IOR1wWCX2nurSza5bS5jYIVI2sCbPXF+akThAh/Z3xWrc21
         g8Kyoc88gEIgKCfJZFcJ+FBA4p8OoeX8C6qWU/mul4kBAiC5HmVLGqgHo7ibjE+W0R5U
         OyR/ABcezgGd3PR3USsnne64F8tSn4bhlBvukvSO7ohvESals7geHyvwFINqUk13h87B
         P6jkW4BaSiBjS66AqptBnovUsu1usKtdd2YR4IqVVYPTlF9QoqnTzsJBb7SJhd7ON6Ry
         M2m5L9p/Pw/mPLahK/gw4jqumbg5yMysu5bx+W6H248SZCQ2J0kVD7kD8VH5WJib92zf
         DhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lP88Oq7al7PBW9u8uObARBFewmt5nawXVbYgCnhmgcw=;
        b=peeW7Lso5IFPnHMfnxjKm8W1ezY8gvz/kEaU46Qd6cD6wSEezS1djqLloau/rVOAM6
         HnOmc2ZjtpoEURg2ppCF6s4R9snqg718FEF6tZ/zhfOHE33kyVPB3vAizgpl7AAczTnI
         9FjJv8jRrUDcTdTVMi5laqDfMOpeaKWlZDjC7qaN/YzbqfWjIn5BzxWIVSV/ogWo/niB
         ptxZ2Idyem5PQ/2tLrcn106/zUzaMVo6Wzt6M9M6PPm2V870OoXRTPCgnRgXDqvcaWc1
         psZCWXUje1l5Qo+Vc8vYDmjYspyLWi/en4y3dfekiPmy6j2BnaxtZ9aVrS6on01NbELn
         nKRA==
X-Gm-Message-State: APjAAAWTJhFtSUi5srZbrvn5EPuxGn9EhABA0rY5sAvYlscziPgZE5Jr
        /pQXa6U85+dttB1zNdvf45Xlcg==
X-Google-Smtp-Source: APXvYqx/GqVjUT76KPVaabdbztCQ4ffzG1QXBDfRUnTq7vn7Vdl5H/I7GTHJvwGyI9sIh85YqwJ/5A==
X-Received: by 2002:a63:4522:: with SMTP id s34mr33065155pga.362.1567573266199;
        Tue, 03 Sep 2019 22:01:06 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e17sm1152021pjt.6.2019.09.03.22.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 22:01:05 -0700 (PDT)
Date:   Tue, 3 Sep 2019 22:01:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: interconnect: qcom: add msm8974
 bindings
Message-ID: <20190904050103.GE3081@tuxbook-pro>
References: <20190902211925.27169-1-masneyb@onstation.org>
 <20190902211925.27169-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902211925.27169-2-masneyb@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 02 Sep 14:19 PDT 2019, Brian Masney wrote:

> Add device tree bindings for the Qualcomm MSM8974 interconnect providers
> that support setting system bandwidth requirements between various
> network-on-chip fabrics.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../bindings/interconnect/qcom,msm8974.yaml   | 163 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++++++++++++++
>  2 files changed, 309 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
> new file mode 100644
> index 000000000000..fbf440f5ffe0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8974.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8974 Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Brian Masney <masneyb@onstation.org>
> +
> +description: |
> +   The Qualcomm MSM8974 interconnect providers support setting system
> +   bandwidth requirements between various network-on-chip fabrics.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  compatible:
> +    enum:
> +      - qcom,msm8974-bimc
> +      - qcom,msm8974-cnoc
> +      - qcom,msm8974-mmssnoc
> +      - qcom,msm8974-ocmemnoc
> +      - qcom,msm8974-pnoc
> +      - qcom,msm8974-snoc
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: bus_a
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Bus A Clock
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#interconnect-cells'
> +  - clock-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,mmcc-msm8974.h>
> +      #include <dt-bindings/clock/qcom,rpmcc.h>
> +      #include <dt-bindings/interconnect/qcom,msm8974.h>
> +      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +      bimc: interconnect@fc380000 {
> +              reg = <0xfc380000 0x6a000>;
> +              compatible = "qcom,msm8974-bimc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +      };
> +
> +      cnoc: interconnect@fc480000 {
> +              reg = <0xfc480000 0x4000>;
> +              compatible = "qcom,msm8974-cnoc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> +                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +      };
> +
> +      mmssnoc: interconnect@fc478000 {
> +              reg = <0xfc478000 0x4000>;
> +              compatible = "qcom,msm8974-mmssnoc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
> +                       <&rpmcc RPM_SMD_MMSSNOC_AHB_A_CLK>;

Isn't MMSS_S0_AXI_CLK the bus clock of the mmssnoc (which somehow seems
to depend on mmssnoc_ahb_clk)?

> +      };
> +
> +      ocmemnoc: interconnect@fc470000 {
> +              reg = <0xfc470000 0x4000>;
> +              compatible = "qcom,msm8974-ocmemnoc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
> +                       <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
> +      };
> +
> +      pnoc: interconnect@fc468000 {
> +              reg = <0xfc468000 0x4000>;
> +              compatible = "qcom,msm8974-pnoc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +                       <&rpmcc RPM_SMD_PNOC_A_CLK>;
> +      };
> +
> +      snoc: interconnect@fc460000 {
> +              reg = <0xfc460000 0x4000>;
> +              compatible = "qcom,msm8974-snoc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +      };
> +
> +      mdss: mdss@fd900000 {

I think you can omit the client, as this adheres to the standard binding
for interconnect clients. And you don't need to have an example that
covers all compatibles either...


> +              compatible = "qcom,mdss";
> +              reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
> +              reg-names = "mdss_phys", "vbif_phys";
> +
> +              power-domains = <&mmcc MDSS_GDSC>;
> +
> +              clocks = <&mmcc MDSS_AHB_CLK>,
> +                       <&mmcc MDSS_AXI_CLK>,
> +                       <&mmcc MDSS_VSYNC_CLK>;
> +              clock-names = "iface", "bus", "vsync";
> +
> +              interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +              interrupt-controller;
> +              #interrupt-cells = <1>;
> +
> +              #address-cells = <1>;
> +              #size-cells = <1>;
> +              ranges;
> +
> +              mdp: mdp@fd900000 {
> +                      compatible = "qcom,mdp5";
> +                      reg = <0xfd900100 0x22000>;
> +                      reg-names = "mdp_phys";
> +
> +                      interrupt-parent = <&mdss>;
> +                      interrupts = <0 0>;
> +
> +                      clocks = <&mmcc MDSS_AHB_CLK>,
> +                               <&mmcc MDSS_AXI_CLK>,
> +                               <&mmcc MDSS_MDP_CLK>,
> +                               <&mmcc MDSS_VSYNC_CLK>;
> +                      clock-names = "iface", "bus", "core", "vsync";
> +
> +                      interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
> +                                      <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
> +                      interconnect-names = "mdp0-mem", "mdp1-mem";
> +
> +                      ports {
> +                              #address-cells = <1>;
> +                              #size-cells = <0>;
> +
> +                              port@0 {
> +                                      reg = <0>;
> +                                      mdp5_intf1_out: endpoint {
> +                                              remote-endpoint = <&dsi0_in>;
> +                                      };
> +                              };
> +                      };
> +              };
> +      };
> diff --git a/include/dt-bindings/interconnect/qcom,msm8974.h b/include/dt-bindings/interconnect/qcom,msm8974.h
> new file mode 100644
> index 000000000000..58acf7196410
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,msm8974.h
> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Would you mind dual licensing this part as well?

Apart from that, I think this binding looks good.

Regards,
Bjorn

> +/*
> + * Qualcomm msm8974 interconnect IDs
> + *
> + * Copyright (c) 2019 Brian Masney <masneyb@onstation.org>
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8974_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8974_H
> +
> +#define BIMC_MAS_AMPSS_M0		0
> +#define BIMC_MAS_AMPSS_M1		1
> +#define BIMC_MAS_MSS_PROC		2
> +#define BIMC_TO_MNOC			3
> +#define BIMC_TO_SNOC			4
> +#define BIMC_SLV_EBI_CH0		5
> +#define BIMC_SLV_AMPSS_L2		6
> +
> +#define CNOC_MAS_RPM_INST		0
> +#define CNOC_MAS_RPM_DATA		1
> +#define CNOC_MAS_RPM_SYS		2
> +#define CNOC_MAS_DEHR			3
> +#define CNOC_MAS_QDSS_DAP		4
> +#define CNOC_MAS_SPDM			5
> +#define CNOC_MAS_TIC			6
> +#define CNOC_SLV_CLK_CTL		7
> +#define CNOC_SLV_CNOC_MSS		8
> +#define CNOC_SLV_SECURITY		9
> +#define CNOC_SLV_TCSR			10
> +#define CNOC_SLV_TLMM			11
> +#define CNOC_SLV_CRYPTO_0_CFG		12
> +#define CNOC_SLV_CRYPTO_1_CFG		13
> +#define CNOC_SLV_IMEM_CFG		14
> +#define CNOC_SLV_MESSAGE_RAM		15
> +#define CNOC_SLV_BIMC_CFG		16
> +#define CNOC_SLV_BOOT_ROM		17
> +#define CNOC_SLV_PMIC_ARB		18
> +#define CNOC_SLV_SPDM_WRAPPER		19
> +#define CNOC_SLV_DEHR_CFG		20
> +#define CNOC_SLV_MPM			21
> +#define CNOC_SLV_QDSS_CFG		22
> +#define CNOC_SLV_RBCPR_CFG		23
> +#define CNOC_SLV_RBCPR_QDSS_APU_CFG	24
> +#define CNOC_TO_SNOC			25
> +#define CNOC_SLV_CNOC_ONOC_CFG		26
> +#define CNOC_SLV_CNOC_MNOC_MMSS_CFG	27
> +#define CNOC_SLV_CNOC_MNOC_CFG		28
> +#define CNOC_SLV_PNOC_CFG		29
> +#define CNOC_SLV_SNOC_MPU_CFG		30
> +#define CNOC_SLV_SNOC_CFG		31
> +#define CNOC_SLV_EBI1_DLL_CFG		32
> +#define CNOC_SLV_PHY_APU_CFG		33
> +#define CNOC_SLV_EBI1_PHY_CFG		34
> +#define CNOC_SLV_RPM			35
> +#define CNOC_SLV_SERVICE_CNOC		36
> +
> +#define MNOC_MAS_GRAPHICS_3D		0
> +#define MNOC_MAS_JPEG			1
> +#define MNOC_MAS_MDP_PORT0		2
> +#define MNOC_MAS_VIDEO_P0		3
> +#define MNOC_MAS_VIDEO_P1		4
> +#define MNOC_MAS_VFE			5
> +#define MNOC_TO_CNOC			6
> +#define MNOC_TO_BIMC			7
> +#define MNOC_SLV_CAMERA_CFG		8
> +#define MNOC_SLV_DISPLAY_CFG		9
> +#define MNOC_SLV_OCMEM_CFG		10
> +#define MNOC_SLV_CPR_CFG		11
> +#define MNOC_SLV_CPR_XPU_CFG		12
> +#define MNOC_SLV_MISC_CFG		13
> +#define MNOC_SLV_MISC_XPU_CFG		14
> +#define MNOC_SLV_VENUS_CFG		15
> +#define MNOC_SLV_GRAPHICS_3D_CFG	16
> +#define MNOC_SLV_MMSS_CLK_CFG		17
> +#define MNOC_SLV_MMSS_CLK_XPU_CFG	18
> +#define MNOC_SLV_MNOC_MPU_CFG		19
> +#define MNOC_SLV_ONOC_MPU_CFG		20
> +#define MNOC_SLV_SERVICE_MNOC		21
> +
> +#define OCMEM_NOC_TO_OCMEM_VNOC		0
> +#define OCMEM_MAS_JPEG_OCMEM		1
> +#define OCMEM_MAS_MDP_OCMEM		2
> +#define OCMEM_MAS_VIDEO_P0_OCMEM	3
> +#define OCMEM_MAS_VIDEO_P1_OCMEM	4
> +#define OCMEM_MAS_VFE_OCMEM		5
> +#define OCMEM_MAS_CNOC_ONOC_CFG		6
> +#define OCMEM_SLV_SERVICE_ONOC		7
> +#define OCMEM_VNOC_TO_SNOC		8
> +#define OCMEM_VNOC_TO_OCMEM_NOC		9
> +#define OCMEM_VNOC_MAS_GFX3D		10
> +#define OCMEM_SLV_OCMEM			11
> +
> +#define PNOC_MAS_PNOC_CFG		0
> +#define PNOC_MAS_SDCC_1			1
> +#define PNOC_MAS_SDCC_3			2
> +#define PNOC_MAS_SDCC_4			3
> +#define PNOC_MAS_SDCC_2			4
> +#define PNOC_MAS_TSIF			5
> +#define PNOC_MAS_BAM_DMA		6
> +#define PNOC_MAS_BLSP_2			7
> +#define PNOC_MAS_USB_HSIC		8
> +#define PNOC_MAS_BLSP_1			9
> +#define PNOC_MAS_USB_HS			10
> +#define PNOC_TO_SNOC			11
> +#define PNOC_SLV_SDCC_1			12
> +#define PNOC_SLV_SDCC_3			13
> +#define PNOC_SLV_SDCC_2			14
> +#define PNOC_SLV_SDCC_4			15
> +#define PNOC_SLV_TSIF			16
> +#define PNOC_SLV_BAM_DMA		17
> +#define PNOC_SLV_BLSP_2			18
> +#define PNOC_SLV_USB_HSIC		19
> +#define PNOC_SLV_BLSP_1			20
> +#define PNOC_SLV_USB_HS			21
> +#define PNOC_SLV_PDM			22
> +#define PNOC_SLV_PERIPH_APU_CFG		23
> +#define PNOC_SLV_PNOC_MPU_CFG		24
> +#define PNOC_SLV_PRNG			25
> +#define PNOC_SLV_SERVICE_PNOC		26
> +
> +#define SNOC_MAS_LPASS_AHB		0
> +#define SNOC_MAS_QDSS_BAM		1
> +#define SNOC_MAS_SNOC_CFG		2
> +#define SNOC_TO_BIMC			3
> +#define SNOC_TO_CNOC			4
> +#define SNOC_TO_PNOC			5
> +#define SNOC_TO_OCMEM_VNOC		6
> +#define SNOC_MAS_CRYPTO_CORE0		7
> +#define SNOC_MAS_CRYPTO_CORE1		8
> +#define SNOC_MAS_LPASS_PROC		9
> +#define SNOC_MAS_MSS			10
> +#define SNOC_MAS_MSS_NAV		11
> +#define SNOC_MAS_OCMEM_DMA		12
> +#define SNOC_MAS_WCSS			13
> +#define SNOC_MAS_QDSS_ETR		14
> +#define SNOC_MAS_USB3			15
> +#define SNOC_SLV_AMPSS			16
> +#define SNOC_SLV_LPASS			17
> +#define SNOC_SLV_USB3			18
> +#define SNOC_SLV_WCSS			19
> +#define SNOC_SLV_OCIMEM			20
> +#define SNOC_SLV_SNOC_OCMEM		21
> +#define SNOC_SLV_SERVICE_SNOC		22
> +#define SNOC_SLV_QDSS_STM		23
> +
> +#endif
> -- 
> 2.21.0
> 

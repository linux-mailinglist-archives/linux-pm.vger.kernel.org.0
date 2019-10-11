Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3948D4632
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfJKRGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 13:06:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJKRGZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 13:06:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so6444970pfe.5
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2019 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2RYeAhaqz2bKg54GzrINrH3nvZldOH7SwzX0Ny+3oU=;
        b=ANMAk0/JXcZOuIQjrqfm22gi3a8GyHgA3hwmhqhBIGFhtt8cgb6gwhpp1+ZRq7tqIH
         zt98Zjb9+0KpiKN+RaWPF1UqU1U3nzx0XTlFe7J0BEr/w0aXBXQYZHatc8lytl3ub54+
         NTRbadMQu+h9KR3BZFqkznF9gbSksfBLn8ntVLRY0JW83a8+9ZDT5UFNEqAKJeG8Ze4v
         HJQIM9Jk0L7VmiMpRzkpaCP28kRq+s2Nd6yMbXqBC3Vpbl/Uz/NfAaYZAFN0umtQBVRW
         dWiMm3ioKnqX63YuCaLXUyHCChW5ucYxONagM9LekPE93dHKaXlss7fc1npFBQRgvJ8D
         do9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2RYeAhaqz2bKg54GzrINrH3nvZldOH7SwzX0Ny+3oU=;
        b=W1B/+REb0BXJI4C+0tJniVdEILOqj0Xla4WMWdaz1NdEKTgM7v7tlxMNqPzEQwUNvh
         Hn3jxy1lIPFR4D/UspclvvoTgOqPeF/Lq4/n7Oj2pwIMKIVGNSyrjOctBbuljqxjCPLg
         5YaTu9H9ZX9ScIQ4S1R/ndJMeGi5aCwCTEYWToCrYEe0swsO3267Qzeb61+/ZPYqjJUU
         He8JE8AsBIgB1JKcGRm/HYlkk59WuPrsOUVCm2m9+tCLiviPW+crcuXqnx4bIlVQ2pzN
         D1k7ISUdDIhtxbpzz6EKB8OTDKvyMThVLpUsxRLonbn/M1mWwQ4YoX+jJZrf3ArOD+iH
         E2bg==
X-Gm-Message-State: APjAAAXAUKGRDYxvnrt5nbccvhK4yA5oEWKs6uS+FfUp9+Trcy6cgjm9
        cFf3cArT7NfLM1PbIA61CHoPfg==
X-Google-Smtp-Source: APXvYqy5rK5EF6xCV0LvkdSzHnVZ3Jzu2D/v2S0ZENhmINBWVKkEBc/CPXAKyJ0wEXL3ONiBfGeXuA==
X-Received: by 2002:a17:90b:288:: with SMTP id az8mr18641088pjb.18.1570813582778;
        Fri, 11 Oct 2019 10:06:22 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v4sm9499073pff.181.2019.10.11.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:06:22 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:06:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     georgi.djakov@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: add msm8974
 bindings
Message-ID: <20191011170619.GE571@minitux>
References: <20191005114605.5279-1-masneyb@onstation.org>
 <20191005114605.5279-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005114605.5279-2-masneyb@onstation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat 05 Oct 04:46 PDT 2019, Brian Masney wrote:

> Add device tree bindings for the Qualcomm MSM8974 interconnect providers
> that support setting system bandwidth requirements between various
> network-on-chip fabrics.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> Rob: I included in the next patch at the top a rough diagram showing the
> relationship between different buses. I wanted to include that diagram
> here, however I didn't since I assume that this document will be
> transformed into HTML. I've seen some of the text bindings in the IIO
> subsystem have nice ASCII-art diagrams, such as
> Documentation/devicetree/bindings/iio/dac/dpot-dac.txt. Do you have any
> suggestions for how this can go in the YAML bindings? Prefix the line
> with four spaces, similiar to what is done in markdown?
> 
> Changes since v1:
> - Don't include all compatibles in the examples. Removed interconnect
>   GPU client from example as well.
> - Dual license header file: BSD or GPL 2.0
> 
>  .../bindings/interconnect/qcom,msm8974.yaml   |  62 ++++++++
>  .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++++++++++++++++
>  2 files changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
> new file mode 100644
> index 000000000000..9af3c6e59cff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
> @@ -0,0 +1,62 @@
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
> +      #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +      bimc: interconnect@fc380000 {
> +              reg = <0xfc380000 0x6a000>;
> +              compatible = "qcom,msm8974-bimc";
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +      };
> diff --git a/include/dt-bindings/interconnect/qcom,msm8974.h b/include/dt-bindings/interconnect/qcom,msm8974.h
> new file mode 100644
> index 000000000000..e65ae27ffff2
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,msm8974.h
> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
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

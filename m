Return-Path: <linux-pm+bounces-29520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F5AE8763
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FF95A1DCF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31526981C;
	Wed, 25 Jun 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ilt9IW1p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE1267721;
	Wed, 25 Jun 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863899; cv=none; b=th1nNhiGg5UU3VXB37M1dewGc2NGbEWczmaUtd4VJNy9k8XyAk7zbmWjjR2N+kKTef1R9CjlWAYHRRBBoUzGTTjUi1EXh8EF+XNZjQSO/XX3aSqE+2AptOxacbcP1Fnh5jxT/dI3zcjaMLWJh43ADpeXqVWB4QKSkvzJ5cAX8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863899; c=relaxed/simple;
	bh=erqKyzYZBkC2k4jwO0YfXfbBhRrSe/HEWA1WEpcGpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtYpZYUWo3Yb+bpltM6LD87SC3J4/BbFjWBvx8MWKo/QaWTut2AKjeHW80hp8dPyKM+hOhjzN+rW1KQxEzG0Yq7TL/06iIkCnfogYsBKGwuQJusWO5LrrOIL5HV4X5PG8T8/TApRoNYhBPG54MT3SJ9mW2wmentJFgDQxqBdsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ilt9IW1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07472C4CEEA;
	Wed, 25 Jun 2025 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750863899;
	bh=erqKyzYZBkC2k4jwO0YfXfbBhRrSe/HEWA1WEpcGpwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ilt9IW1p43qOtF86yrHozBkPoikkh6GVyBrbaergaF2iXcLrAOYTD3+LPKC+vv0Qq
	 X3bHbe6tvBpUIEIRi0pKWLz8CXCr/0S4U3RGp7dJlp64uX4drHdpq3wxYcHf7rUtVW
	 +taCZTQlBcnEYCxumMfVJ13ezSLCOxqbvXEfRBoELjMeFN7Yr9tKkd/QbC2fD+ezz1
	 h4EFTGur9ptIe9t3pmLJ9TZTjBW+mqZXTMhnSFN2ojQyuWdgoVFXjlcFozFCQOgOO+
	 /R3+QfPYJv4nGA5anXmniGw7Qraupk9oQqID+c4WYSDEopkqATXLKVkbRLyw+sT0gO
	 +k0MLUKuU10FQ==
Date: Wed, 25 Jun 2025 10:04:58 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip Interconnect in Qualcomm SM7635 SoC
Message-ID: <20250625150458.GA1182597-robh@kernel.org>
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-1-8b49200416b0@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-sm7635-icc-v1-1-8b49200416b0@fairphone.com>

On Wed, Jun 25, 2025 at 11:13:47AM +0200, Luca Weiss wrote:
> Document the RPMh Network-On-Chip Interconnect of the SM7635 platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/interconnect/qcom,sm7635-rpmh.yaml    | 136 ++++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sm7635-rpmh.h    | 141 +++++++++++++++++++++
>  2 files changed, 277 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7635-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7635-rpmh.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..6373399542d5728b4a4097876d2c4dffc4482038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7635-rpmh.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm7635-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SM7635
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +  See also:: include/dt-bindings/interconnect/qcom,sm7635-rpmh.h

Don't need double colon. Please fix whatever you blindly copied this 
from.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm7635-aggre1-noc
> +      - qcom,sm7635-aggre2-noc
> +      - qcom,sm7635-clk-virt
> +      - qcom,sm7635-cnoc-cfg
> +      - qcom,sm7635-cnoc-main
> +      - qcom,sm7635-gem-noc
> +      - qcom,sm7635-lpass-ag-noc
> +      - qcom,sm7635-mc-virt
> +      - qcom,sm7635-mmss-noc
> +      - qcom,sm7635-nsp-noc
> +      - qcom,sm7635-pcie-anoc
> +      - qcom,sm7635-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm7635-clk-virt
> +              - qcom,sm7635-mc-virt
> +    then:
> +      properties:
> +        reg: false
> +    else:
> +      required:
> +        - reg
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm7635-pcie-anoc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre-NOC PCIe AXI clock
> +            - description: cfg-NOC PCIe a-NOC AHB clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm7635-aggre1-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre USB3 PRIM AXI clock
> +            - description: aggre UFS PHY AXI clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm7635-aggre2-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RPMH CC IPA clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm7635-aggre1-noc
> +              - qcom,sm7635-aggre2-noc
> +              - qcom,sm7635-pcie-anoc
> +    then:
> +      required:
> +        - clocks
> +    else:
> +      properties:
> +        clocks: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sm7635-gcc.h>
> +
> +    interconnect-0 {
> +        compatible = "qcom,sm7635-clk-virt";
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    interconnect@16e0000 {
> +        compatible = "qcom,sm7635-aggre1-noc";
> +        reg = <0x016e0000 0x16400>;
> +        #interconnect-cells = <2>;
> +        clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +                 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> diff --git a/include/dt-bindings/interconnect/qcom,sm7635-rpmh.h b/include/dt-bindings/interconnect/qcom,sm7635-rpmh.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..d963780ddb540825672bc411eb106a298003b09f
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm7635-rpmh.h
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM7635_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SM7635_H
> +
> +#define MASTER_QUP_1				0
> +#define MASTER_UFS_MEM				1
> +#define MASTER_USB3_0				2
> +#define SLAVE_A1NOC_SNOC			3
> +
> +#define MASTER_QDSS_BAM				0
> +#define MASTER_QSPI_0				1
> +#define MASTER_QUP_0				2
> +#define MASTER_CRYPTO				3
> +#define MASTER_IPA				4
> +#define MASTER_QDSS_ETR				5
> +#define MASTER_QDSS_ETR_1			6
> +#define MASTER_SDCC_1				7
> +#define MASTER_SDCC_2				8
> +#define SLAVE_A2NOC_SNOC			9
> +
> +#define MASTER_QUP_CORE_0			0
> +#define MASTER_QUP_CORE_1			1
> +#define SLAVE_QUP_CORE_0			2
> +#define SLAVE_QUP_CORE_1			3
> +
> +#define MASTER_CNOC_CFG				0
> +#define SLAVE_AHB2PHY_SOUTH			1
> +#define SLAVE_AHB2PHY_NORTH			2
> +#define SLAVE_CAMERA_CFG			3
> +#define SLAVE_CLK_CTL				4
> +#define SLAVE_RBCPR_CX_CFG			5
> +#define SLAVE_RBCPR_MXA_CFG			6
> +#define SLAVE_CRYPTO_0_CFG			7
> +#define SLAVE_CX_RDPM				8
> +#define SLAVE_GFX3D_CFG				9
> +#define SLAVE_IMEM_CFG				10
> +#define SLAVE_CNOC_MSS				11
> +#define SLAVE_MX_2_RDPM				12
> +#define SLAVE_MX_RDPM				13
> +#define SLAVE_PDM				14
> +#define SLAVE_QDSS_CFG				15
> +#define SLAVE_QSPI_0				16
> +#define SLAVE_QUP_0				17
> +#define SLAVE_QUP_1				18
> +#define SLAVE_SDC1				19
> +#define SLAVE_SDCC_2				20
> +#define SLAVE_TCSR				21
> +#define SLAVE_TLMM				22
> +#define SLAVE_UFS_MEM_CFG			23
> +#define SLAVE_USB3_0				24
> +#define SLAVE_VENUS_CFG				25
> +#define SLAVE_VSENSE_CTRL_CFG			26
> +#define SLAVE_WLAN				27
> +#define SLAVE_CNOC_MNOC_HF_CFG			28
> +#define SLAVE_CNOC_MNOC_SF_CFG			29
> +#define SLAVE_NSP_QTB_CFG			30
> +#define SLAVE_PCIE_ANOC_CFG			31
> +#define SLAVE_WLAN_Q6_THROTTLE_CFG		32
> +#define SLAVE_SERVICE_CNOC_CFG			33
> +#define SLAVE_QDSS_STM				34
> +#define SLAVE_TCU				35
> +
> +#define MASTER_GEM_NOC_CNOC			0
> +#define MASTER_GEM_NOC_PCIE_SNOC		1
> +#define SLAVE_AOSS				2
> +#define SLAVE_DISPLAY_CFG			3
> +#define SLAVE_IPA_CFG				4
> +#define SLAVE_IPC_ROUTER_CFG			5
> +#define SLAVE_PCIE_0_CFG			6
> +#define SLAVE_PCIE_1_CFG			7
> +#define SLAVE_PRNG				8
> +#define SLAVE_TME_CFG				9
> +#define SLAVE_APPSS				10
> +#define SLAVE_CNOC_CFG				11
> +#define SLAVE_DDRSS_CFG				12
> +#define SLAVE_IMEM				13
> +#define SLAVE_PIMEM				14
> +#define SLAVE_SERVICE_CNOC			15
> +#define SLAVE_PCIE_0				16
> +#define SLAVE_PCIE_1				17
> +
> +#define MASTER_GPU_TCU				0
> +#define MASTER_SYS_TCU				1
> +#define MASTER_APPSS_PROC			2
> +#define MASTER_GFX3D				3
> +#define MASTER_LPASS_GEM_NOC			4
> +#define MASTER_MSS_PROC				5
> +#define MASTER_MNOC_HF_MEM_NOC			6
> +#define MASTER_MNOC_SF_MEM_NOC			7
> +#define MASTER_COMPUTE_NOC			8
> +#define MASTER_ANOC_PCIE_GEM_NOC		9
> +#define MASTER_SNOC_GC_MEM_NOC			10
> +#define MASTER_SNOC_SF_MEM_NOC			11
> +#define MASTER_WLAN_Q6				12
> +#define SLAVE_GEM_NOC_CNOC			13
> +#define SLAVE_LLCC				14
> +#define SLAVE_MEM_NOC_PCIE_SNOC			15
> +
> +#define MASTER_LPASS_PROC			0
> +#define SLAVE_LPASS_GEM_NOC			1
> +
> +#define MASTER_LLCC				0
> +#define SLAVE_EBI1				1
> +
> +#define MASTER_CAMNOC_HF			0
> +#define MASTER_CAMNOC_ICP			1
> +#define MASTER_CAMNOC_SF			2
> +#define MASTER_MDP				3
> +#define MASTER_VIDEO				4
> +#define MASTER_CNOC_MNOC_HF_CFG			5
> +#define MASTER_CNOC_MNOC_SF_CFG			6
> +#define SLAVE_MNOC_HF_MEM_NOC			7
> +#define SLAVE_MNOC_SF_MEM_NOC			8
> +#define SLAVE_SERVICE_MNOC_HF			9
> +#define SLAVE_SERVICE_MNOC_SF			10
> +
> +#define MASTER_CDSP_PROC			0
> +#define SLAVE_CDSP_MEM_NOC			1
> +
> +#define MASTER_PCIE_ANOC_CFG			0
> +#define MASTER_PCIE_0				1
> +#define MASTER_PCIE_1				2
> +#define SLAVE_ANOC_PCIE_GEM_NOC			3
> +#define SLAVE_SERVICE_PCIE_ANOC			4
> +
> +#define MASTER_A1NOC_SNOC			0
> +#define MASTER_A2NOC_SNOC			1
> +#define MASTER_APSS_NOC				2
> +#define MASTER_CNOC_SNOC			3
> +#define MASTER_PIMEM				4
> +#define MASTER_GIC				5
> +#define SLAVE_SNOC_GEM_NOC_GC			6
> +#define SLAVE_SNOC_GEM_NOC_SF			7
> +
> +
> +#endif
> 
> -- 
> 2.50.0
> 


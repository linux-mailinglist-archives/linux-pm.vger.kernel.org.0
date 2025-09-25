Return-Path: <linux-pm+bounces-35330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE07B9E276
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E34A3828A3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D30280035;
	Thu, 25 Sep 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtgeGXkH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29227FD56
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790667; cv=none; b=C6KGvrkvM7EcEEAsZnRwcncMUz5Kny2VORvQe6mrZuzJWyIjhczbOPj4g05PsCrY5ZIWQLICZxbAwmiG4jR8lLH+9iTLAKe5Js8c/XD7jYKu+bRyOgieh4/Z0OUBJAEJ1S1pZkhBz1wfHDaMBg4tqzX/V9YwgX1NC9lxOehrRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790667; c=relaxed/simple;
	bh=s1IvWBoDghRdTxNI9ntahbtNb3ceyjypNF92BFpPstg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcUnW82itesXnW/38VSDupjWC80gvkxeZN+J2a7ZH+VL+59qyZzUwX6TVF6NSlJPPqag+T7WlKr3Qegp+Yi1U//u+6KQFb3ld5ZBkKdiNm0xqofu7zS1c3xdu1Zjtj1LSXmdT2tBKEOquCvefW+6MGhkPVglXZHn3kOtzsIVbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtgeGXkH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b2e66a300cbso135738566b.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758790663; x=1759395463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gyeemM5bv0/cwHb/gRYJJo/u8gfbvqaOjqlOCWg4JE=;
        b=VtgeGXkHItiSlP0KD3DKgSpuIYMSMcbjRUlyNQ/C8xStSBJF/HLkmsdAoMYdZhEb6q
         hn6UJH9x76C3uGBGbGEVCDVD9FkhdAW95q5eF1PJE7Wtfx0n3gNCVRc/+11Mr4Wxtu/d
         gaDUQ30i6e8bqHiuVgKR3jzpR4T5qf897jNk6Zjt4qjguB/NZk5fVNbZGrxaU6PQd7v8
         vjOrK3WUW81wmJVAPnqRE/qWDGvxGAhxMywHRkQ+6H/pqtGNAKoOMuAoRXMwOpa5+mfz
         ygcwQk7mT6yg1yPUXHlCpb6DqIk7m8Ftsen16eew6E1N+Lt7/9jnfZhL+XJ61fgpcL7p
         vY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790663; x=1759395463;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gyeemM5bv0/cwHb/gRYJJo/u8gfbvqaOjqlOCWg4JE=;
        b=VtsGzCRpnI7UEFTWRB+HVXqSuToMyD+jdU9OFsoqS/bUzBBcIJF/98YxRDu1qlsgsI
         oTS62syV794A9HCUbqTQbIT1Y5m6/mwjwqCU2YcjJY054X5fX7EOhdIVcszBcfVyTIXh
         Ev6+qBIUxmn2dnj3igRmaZLym5JfE0U9QihQaN2H04Hl2Ssq/9ZIvVgmhn7MlV1kER+k
         W4oGEAQup34nLxve5YKMq88E1P/onOotC/r+jlvhOdNXeLPMV5/KciyopW4FqIxm/ic8
         vxckKOhINN2Rr5GfjU8yNH75nkXvYwKOZ9Fnp1QLxZZFLarsYJtlolj2/wFxMXLJslef
         k2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXco0SrWMqwu2OpTnT9N5nqqNti4xce7IOcNZLrurOklwsagPXn69vIVmh0WEqT+veeILy0f7cyRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5mbh491oyVFwXGhFIvW08vHg0M0RIDC7422UbXdXtOs8qmCW
	b3s9I1JHGu/6xGmE9lU8P5GP9i6qKSUoMgn6Hq/4+LZobZbUEqjJu1Ac9iINxMilK0c=
X-Gm-Gg: ASbGncvziLsT5pLhU1xsRRqa6s9O8R/DMwx69eq+uTA3VMoMg+jWPmNYtVcEUBGOTmH
	2ysmTMSdUZIe0d3XsgZHRnOKNbkYvju476X98IXyeqtw2LURRsK5yJM0B/UCObPFFXGcBiCW8DF
	MIp/NDXqau0dmjsxboR33zsK7CNuIv0Nd8Mhom84EzkFjBb/VaTH1imF2pnb3waJBXRTMfv59X+
	6U7ubCQVUUvb9B+u6r6/A3vOWMoAsfB1qaziYnzfOsN05wIYVgCKhjf3EeTyY9EyF0FthXNRWtb
	aujuLhvFKu6w2o7ybUIPhzlL8DrGNA0xZK6ts8PHKLNJ8VaikTBamt8BBIL1T2VTM3ywLWD87Ny
	C9N3FPtuugmP2l8nTKBFnjr6J1LhbGA==
X-Google-Smtp-Source: AGHT+IHAqvFuArcYlmLsH6QWv4YuNWEk6UM56Ovz265N4A8KauZbqfvtw43LomwCRUeB+PPlGp6V8w==
X-Received: by 2002:a17:907:7e84:b0:b29:e717:f0af with SMTP id a640c23a62f3a-b34b9f4fc52mr328324766b.18.1758790663253;
        Thu, 25 Sep 2025 01:57:43 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7472sm122712666b.57.2025.09.25.01.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:57:42 -0700 (PDT)
Message-ID: <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
Date: Thu, 25 Sep 2025 11:57:41 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 02:02, Jingyi Wang wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 126 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
>  2 files changed, 275 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
> new file mode 100644
> index 000000000000..574150cc4930
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,kaanapali-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on KAANAPALI
> +
> +maintainers:
> +  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +  See also: include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kaanapali-aggre-noc

Hi,

Does Kaanapali have a single aggre node, or there are several ?
On previous SoC, I see there are two (aggre1 and aggre2).
Also in your driver (second patch), I notice aggre1_noc and aggre2_noc .
It would make sense to accurately describe here the hardware.

Eugen

> +      - qcom,kaanapali-clk-virt
> +      - qcom,kaanapali-cnoc-main
> +      - qcom,kaanapali-cnoc-cfg
> +      - qcom,kaanapali-gem-noc
> +      - qcom,kaanapali-lpass-ag-noc
> +      - qcom,kaanapali-lpass-lpiaon-noc
> +      - qcom,kaanapali-lpass-lpicx-noc
> +      - qcom,kaanapali-mc-virt
> +      - qcom,kaanapali-mmss-noc
> +      - qcom,kaanapali-nsp-noc
> +      - qcom,kaanapali-pcie-anoc
> +      - qcom,kaanapali-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
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
> +              - qcom,kaanapali-clk-virt
> +              - qcom,kaanapali-mc-virt
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
> +              - qcom,kaanapali-pcie-anoc
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
> +              - qcom,kaanapali-aggre-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre USB3 PRIM AXI clock
> +            - description: RPMH CC IPA clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,kaanapali-aggre-noc
> +              - qcom,kaanapali-pcie-anoc
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
> +    #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clk_virt: interconnect-0 {
> +      compatible = "qcom,kaanapali-clk-virt";
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre_noc: interconnect@16e0000 {
> +      compatible = "qcom,kaanapali-aggre-noc";
> +      reg = <0x016e0000 0x42400>;
> +      #interconnect-cells = <2>;
> +      clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +               <&rpmhcc RPMH_IPA_CLK>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> diff --git a/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
> new file mode 100644
> index 000000000000..dde3f9abd677
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
> @@ -0,0 +1,149 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
> +
> +#define MASTER_QSPI_0				0
> +#define MASTER_CRYPTO				1
> +#define MASTER_QUP_1				2
> +#define MASTER_SDCC_4				3
> +#define MASTER_UFS_MEM				4
> +#define MASTER_USB3				5
> +#define MASTER_QUP_2				6
> +#define MASTER_QUP_3				7
> +#define MASTER_QUP_4				8
> +#define MASTER_IPA				9
> +#define MASTER_SOCCP_PROC			10
> +#define MASTER_SP				11
> +#define MASTER_QDSS_ETR				12
> +#define MASTER_QDSS_ETR_1			13
> +#define MASTER_SDCC_2				14
> +#define SLAVE_A1NOC_SNOC			15
> +#define SLAVE_A2NOC_SNOC			16
> +
> +#define MASTER_QUP_CORE_0			0
> +#define MASTER_QUP_CORE_1			1
> +#define MASTER_QUP_CORE_2			2
> +#define MASTER_QUP_CORE_3			3
> +#define MASTER_QUP_CORE_4			4
> +#define SLAVE_QUP_CORE_0			5
> +#define SLAVE_QUP_CORE_1			6
> +#define SLAVE_QUP_CORE_2			7
> +#define SLAVE_QUP_CORE_3			8
> +#define SLAVE_QUP_CORE_4			9
> +
> +#define MASTER_CNOC_CFG				0
> +#define SLAVE_AHB2PHY_SOUTH			1
> +#define SLAVE_AHB2PHY_NORTH			2
> +#define SLAVE_CAMERA_CFG			3
> +#define SLAVE_CLK_CTL				4
> +#define SLAVE_CRYPTO_0_CFG			5
> +#define SLAVE_DISPLAY_CFG			6
> +#define SLAVE_EVA_CFG				7
> +#define SLAVE_GFX3D_CFG				8
> +#define SLAVE_I2C				9
> +#define SLAVE_I3C_IBI0_CFG			10
> +#define SLAVE_I3C_IBI1_CFG			11
> +#define SLAVE_IMEM_CFG				12
> +#define SLAVE_IPC_ROUTER_CFG			13
> +#define SLAVE_CNOC_MSS				14
> +#define SLAVE_PCIE_CFG				15
> +#define SLAVE_PRNG				16
> +#define SLAVE_QDSS_CFG				17
> +#define SLAVE_QSPI_0				18
> +#define SLAVE_QUP_1				19
> +#define SLAVE_QUP_2				20
> +#define SLAVE_QUP_3				21
> +#define SLAVE_QUP_4				22
> +#define SLAVE_SDCC_2				23
> +#define SLAVE_SDCC_4				24
> +#define SLAVE_SPSS_CFG				25
> +#define SLAVE_TCSR				26
> +#define SLAVE_TLMM				27
> +#define SLAVE_UFS_MEM_CFG			28
> +#define SLAVE_USB3				29
> +#define SLAVE_VENUS_CFG				30
> +#define SLAVE_VSENSE_CTRL_CFG			31
> +#define SLAVE_CNOC_MNOC_CFG			32
> +#define SLAVE_PCIE_ANOC_CFG			33
> +#define SLAVE_QDSS_STM				34
> +#define SLAVE_TCU				35
> +
> +#define MASTER_GEM_NOC_CNOC			0
> +#define MASTER_GEM_NOC_PCIE_SNOC		1
> +#define SLAVE_AOSS				2
> +#define SLAVE_IPA_CFG				3
> +#define SLAVE_IPC_ROUTER_FENCE			4
> +#define SLAVE_SOCCP				5
> +#define SLAVE_TME_CFG				6
> +#define SLAVE_APPSS				7
> +#define SLAVE_CNOC_CFG				8
> +#define SLAVE_DDRSS_CFG				9
> +#define SLAVE_BOOT_IMEM				10
> +#define SLAVE_IMEM				11
> +#define SLAVE_PCIE_0				12
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
> +#define MASTER_QPACE				10
> +#define MASTER_SNOC_SF_MEM_NOC			11
> +#define MASTER_WLAN_Q6				12
> +#define MASTER_GIC				13
> +#define SLAVE_GEM_NOC_CNOC			14
> +#define SLAVE_LLCC				15
> +#define SLAVE_MEM_NOC_PCIE_SNOC			16
> +
> +#define MASTER_LPIAON_NOC			0
> +#define SLAVE_LPASS_GEM_NOC			1
> +
> +#define MASTER_LPASS_LPINOC			0
> +#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
> +
> +#define MASTER_LPASS_PROC			0
> +#define SLAVE_LPICX_NOC_LPIAON_NOC		1
> +
> +#define MASTER_LLCC				0
> +#define SLAVE_EBI1				1
> +
> +#define MASTER_CAMNOC_HF			0
> +#define MASTER_CAMNOC_NRT_ICP_SF		1
> +#define MASTER_CAMNOC_RT_CDM_SF			2
> +#define MASTER_CAMNOC_SF			3
> +#define MASTER_MDP				4
> +#define MASTER_MDSS_DCP				5
> +#define MASTER_CDSP_HCP				6
> +#define MASTER_VIDEO_CV_PROC			7
> +#define MASTER_VIDEO_EVA			8
> +#define MASTER_VIDEO_MVP			9
> +#define MASTER_VIDEO_V_PROC			10
> +#define MASTER_CNOC_MNOC_CFG			11
> +#define SLAVE_MNOC_HF_MEM_NOC			12
> +#define SLAVE_MNOC_SF_MEM_NOC			13
> +#define SLAVE_SERVICE_MNOC			14
> +
> +#define MASTER_CDSP_PROC			0
> +#define SLAVE_CDSP_MEM_NOC			1
> +
> +#define MASTER_PCIE_ANOC_CFG			0
> +#define MASTER_PCIE_0				1
> +#define SLAVE_ANOC_PCIE_GEM_NOC			2
> +#define SLAVE_SERVICE_PCIE_ANOC			3
> +
> +#define MASTER_A1NOC_SNOC			0
> +#define MASTER_A2NOC_SNOC			1
> +#define MASTER_APSS_NOC				2
> +#define MASTER_CNOC_SNOC			3
> +#define SLAVE_SNOC_GEM_NOC_SF			4
> +
> +#endif
> 



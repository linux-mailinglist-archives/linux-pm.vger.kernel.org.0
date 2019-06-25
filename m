Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1481D552B0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfFYPAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 11:00:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37357 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfFYPAK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 11:00:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so16607128ljf.4
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hxzjHuG9f6eUk/5rGX6/OuDQOCaB5EwP2dw41LeV6K8=;
        b=AyBJ/0k4t0R+ZNhuo6Cj3euoENM7e+ETH+ppQ8P/g8a8iOGDQ9i3KYqZPNlgRwhdYa
         HNgCuF9aOGMC4pif11HKSdH7nLXFwZCaAwFYXIy8pDMaxul/tzcooc7K3hPb0APvqbRc
         yO2MIWjaUbxu/jo3Xn6tLmThmhdU/7XO3KYICtqF8fXp3rD/zuc4bm1OPTNeS+jxUqFI
         i9yXwovchx6i/kc4A1Jwny9Y892R+1xFmZxjboJ5MCLi3udZG6VDL2mRPAodbY1Y8+z9
         Ok1W9+o7dv0EXzbj6zd4MZfE6BE2g/9iRXWvYo1FBnb0jYfv2lY0isDmbrISV5x04cB1
         86DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxzjHuG9f6eUk/5rGX6/OuDQOCaB5EwP2dw41LeV6K8=;
        b=THl9QRf0V+0Vx7pp0TbivcaD/6vLVTCXBkCiLMXg6jHHYu/E693BZSL7HPhQSW3Bqs
         V3RjjqiGt/wQaaQt1Rc793w6r/T85MxG+/Qiygwv07hGcvGlbIpipB6YusMsuh0fCXuB
         tWFmBr3jxbMy8vPwx3t0mRgbzOyV4C6T1bV//z88XpT/aU3GhCmrgD3TkgK2AmPvrGY9
         5SLQRsQMKRpoWa1l65uLlrGoYwG6jxCIXnj4a6Fz0LJgVvfFEqsVSer5e7npBDiitSFl
         GbheDMmGGXRtXLX9gZLPGqmjQAKKV904j3T3q43ZpcDAN6ey1ofm/vqKVDotHF14kaGo
         PWKA==
X-Gm-Message-State: APjAAAU/XKy9kdOp6HN68ZcC/7qS/HXa6qKy96QxXi045YzOPqOc8k2t
        X4iCJwZR5M5pp/2FFUEqK4Q1sQ==
X-Google-Smtp-Source: APXvYqzUsCIjayB8S/ee9C8qDkFsJ5Ca3H2eUQarQho9CCtEp8Es+VmFR6AU8AXHS1eCzMLtKq83cA==
X-Received: by 2002:a2e:968e:: with SMTP id q14mr41485988lji.195.1561474807414;
        Tue, 25 Jun 2019 08:00:07 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j11sm1991092lfm.29.2019.06.25.08.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:00:06 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
To:     robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
 <20190613151323.10850-2-georgi.djakov@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <c99c052d-40e7-1bff-34f9-3b48a821a175@linaro.org>
Date:   Tue, 25 Jun 2019 18:00:05 +0300
MIME-Version: 1.0
In-Reply-To: <20190613151323.10850-2-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 6/13/19 18:13, Georgi Djakov wrote:
> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v4:
> - Add the DT header into this patch.
> - Pick Bjorn's r-b.
> 
> v3:
> - Add a reg property and move the interconnect nodes under the "soc" node.
> 
> v2:
> - No changes.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 46 ++++++++++
>  .../dt-bindings/interconnect/qcom,qcs404.h    | 88 +++++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>  create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> new file mode 100644
> index 000000000000..14a827268dda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -0,0 +1,46 @@
> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,qcs404-bimc"
> +			"qcom,qcs404-pcnoc"
> +			"qcom,qcs404-snoc"
> +- #interconnect-cells : should contain 1
> +
> +Optional properties :
> +reg : specifies the physical base address and size of registers
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Example:
> +
> +soc {
> +	...
> +	bimc: interconnect@400000 {
> +		reg = <0x00400000 0x80000>;
> +		compatible = "qcom,qcs404-bimc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +			<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +	};
> +
> +	pnoc: interconnect@500000 {
> +		reg = <0x00500000 0x15080>;
> +		compatible = "qcom,qcs404-pcnoc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +			<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +	};
> +
> +	snoc: interconnect@580000 {
> +		reg = <0x00580000 0x23080>;
> +		compatible = "qcom,qcs404-snoc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +			<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +	};
> +};

Does this look ok from DT perspective?

Thanks,
Georgi

> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
> new file mode 100644
> index 000000000000..960f6e39c5f2
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,qcs404.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Qualcomm interconnect IDs
> + *
> + * Copyright (c) 2019, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QCS404_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_QCS404_H
> +
> +#define MASTER_AMPSS_M0			0
> +#define MASTER_OXILI			1
> +#define MASTER_MDP_PORT0		2
> +#define MASTER_SNOC_BIMC_1		3
> +#define MASTER_TCU_0			4
> +#define SLAVE_EBI_CH0			5
> +#define SLAVE_BIMC_SNOC			6
> +
> +#define MASTER_SPDM			0
> +#define MASTER_BLSP_1			1
> +#define MASTER_BLSP_2			2
> +#define MASTER_XI_USB_HS1		3
> +#define MASTER_CRYPT0			4
> +#define MASTER_SDCC_1			5
> +#define MASTER_SDCC_2			6
> +#define MASTER_SNOC_PCNOC		7
> +#define MASTER_QPIC			8
> +#define PCNOC_INT_0			9
> +#define PCNOC_INT_2			10
> +#define PCNOC_INT_3			11
> +#define PCNOC_S_0			12
> +#define PCNOC_S_1			13
> +#define PCNOC_S_2			14
> +#define PCNOC_S_3			15
> +#define PCNOC_S_4			16
> +#define PCNOC_S_6			17
> +#define PCNOC_S_7			18
> +#define PCNOC_S_8			19
> +#define PCNOC_S_9			20
> +#define PCNOC_S_10			21
> +#define PCNOC_S_11			22
> +#define SLAVE_SPDM			23
> +#define SLAVE_PDM			24
> +#define SLAVE_PRNG			25
> +#define SLAVE_TCSR			26
> +#define SLAVE_SNOC_CFG			27
> +#define SLAVE_MESSAGE_RAM		28
> +#define SLAVE_DISP_SS_CFG		29
> +#define SLAVE_GPU_CFG			30
> +#define SLAVE_BLSP_1			31
> +#define SLAVE_BLSP_2			32
> +#define SLAVE_TLMM_NORTH		33
> +#define SLAVE_PCIE			34
> +#define SLAVE_ETHERNET			35
> +#define SLAVE_TLMM_EAST			36
> +#define SLAVE_TCU			37
> +#define SLAVE_PMIC_ARB			38
> +#define SLAVE_SDCC_1			39
> +#define SLAVE_SDCC_2			40
> +#define SLAVE_TLMM_SOUTH		41
> +#define SLAVE_USB_HS			42
> +#define SLAVE_USB3			43
> +#define SLAVE_CRYPTO_0_CFG		44
> +#define SLAVE_PCNOC_SNOC		45
> +
> +#define MASTER_QDSS_BAM			0
> +#define MASTER_BIMC_SNOC		1
> +#define MASTER_PCNOC_SNOC		2
> +#define MASTER_QDSS_ETR			3
> +#define MASTER_EMAC			4
> +#define MASTER_PCIE			5
> +#define MASTER_USB3			6
> +#define QDSS_INT			7
> +#define SNOC_INT_0			8
> +#define SNOC_INT_1			9
> +#define SNOC_INT_2			10
> +#define SLAVE_KPSS_AHB			11
> +#define SLAVE_WCSS			12
> +#define SLAVE_SNOC_BIMC_1		13
> +#define SLAVE_IMEM			14
> +#define SLAVE_SNOC_PCNOC		15
> +#define SLAVE_QDSS_STM			16
> +#define SLAVE_CATS_0			17
> +#define SLAVE_CATS_1			18
> +#define SLAVE_LPASS			19
> +
> +#endif
> 

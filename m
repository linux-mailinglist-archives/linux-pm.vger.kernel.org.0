Return-Path: <linux-pm+bounces-30647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E7B00F20
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F07A421D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509329C33C;
	Thu, 10 Jul 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyUBK/XF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0128FFC6;
	Thu, 10 Jul 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188141; cv=none; b=Lm+B3onlcPehAi6FdoqfiA8SK3i7RBhftWWgbfVPQohITrWfVRN2QVn+K193hycNcXkIwkzd4/tQ58Y4RNZ/vR8oWTlAEw/7DvW0JnqBowfq/117utnKZs+NzjUOSKMOzAGY+UeSdItgBpfEhjMfOJI90XS9AHstRvAovV5XD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188141; c=relaxed/simple;
	bh=ppem5ioqyvvNaJrxZ8a+k8hXOxE1osk+Jas8tjtD+SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnaHS/mSMmKJhNa1IRyBwFZqZ37pDxrPlv8ITN2gwQQxtbvdt7/8ReDMpm4jFmzPbEkOhWXOBppFdLjHFzMRuREMgksY/M1DBs9D16NH64yrozs+rmYkQk7Wi3nYNtVb+E6fjxwwfEHsM+LRY02tz/F/orAhUjXyD3JZvyEStHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyUBK/XF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783CBC4CEE3;
	Thu, 10 Jul 2025 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752188140;
	bh=ppem5ioqyvvNaJrxZ8a+k8hXOxE1osk+Jas8tjtD+SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyUBK/XFn69FTeUCpolhOAcM1/eKSNtWfNsBiof5Re4WgKIBMc+ezRzYD/f1j88QQ
	 QlNQNbH+y69lo3i5alT1C98xkkE0IPkrx8k1mdcPUzWWAaVAkWI6zFse05FksFE1EX
	 FRGGrP9IHrQkrExSII5t3vYNMS4rgB/NsS943z9EDc26KZs1rW00Uf0H6ExYmBqPRy
	 4XtDv01EiIRVaHyO/Yn7L/HjR4v+ytyU2Zhx1Vdp/Nulk5+Xs1pKETGpyk8yJ4/ZQn
	 1li0U1hp1JEZsSTJ2uD60z4QlwZFZqKzK0xBpUtVej03CiMcj4vyigyqyjvLnHUe1H
	 QSzLVTXZTS6rw==
Date: Thu, 10 Jul 2025 17:55:39 -0500
From: Rob Herring <robh@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
	quic_suruchia@quicinc.com
Subject: Re: [PATCH v3 07/10] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
Message-ID: <20250710225539.GA29510-robh@kernel.org>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-7-f149dc461212@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-7-f149dc461212@quicinc.com>

On Thu, Jul 10, 2025 at 08:28:15PM +0800, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
> devices.
> 
> Add the compatible "qcom,ipq5424-nsscc" support based on the current
> IPQ9574 NSS clock controller DT binding file. ICC clocks are always
> provided by the NSS clock controller of IPQ9574 and IPQ5424, so add
> interconnect-cells as required DT property.
> 
> Also add master/slave ids for IPQ5424 networking interfaces, which is
> used by nss-ipq5424 driver for providing interconnect services using
> icc-clk framework.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml         | 14 +++--
>  include/dt-bindings/clock/qcom,ipq5424-nsscc.h     | 65 ++++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,ipq5424.h    | 13 +++++
>  include/dt-bindings/reset/qcom,ipq5424-nsscc.h     | 46 +++++++++++++++
>  4 files changed, 134 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> index b9ca69172adc..86ee9ffb2eda 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
>  
>  maintainers:
>    - Bjorn Andersson <andersson@kernel.org>
> @@ -12,15 +12,19 @@ maintainers:
>  
>  description: |
>    Qualcomm networking sub system clock control module provides the clocks,
> -  resets on IPQ9574
> +  resets on IPQ9574 and IPQ5424
>  
> -  See also::
> +  See also:
> +    include/dt-bindings/clock/qcom,ipq5424-nsscc.h
>      include/dt-bindings/clock/qcom,ipq9574-nsscc.h
> +    include/dt-bindings/reset/qcom,ipq5424-nsscc.h
>      include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>  
>  properties:
>    compatible:
> -    const: qcom,ipq9574-nsscc
> +    enum:
> +      - qcom,ipq5424-nsscc
> +      - qcom,ipq9574-nsscc
>  
>    clocks:
>      items:
> @@ -57,6 +61,7 @@ required:
>    - compatible
>    - clocks
>    - clock-names
> +  - '#interconnect-cells'

You just made this required for everyone. Again, that's an ABI change.

>  
>  allOf:
>    - $ref: qcom,gcc.yaml#
> @@ -94,5 +99,6 @@ examples:
>                      "bus";
>        #clock-cells = <1>;
>        #reset-cells = <1>;
> +      #interconnect-cells = <1>;
>      };
>  ...
> diff --git a/include/dt-bindings/clock/qcom,ipq5424-nsscc.h b/include/dt-bindings/clock/qcom,ipq5424-nsscc.h
> new file mode 100644
> index 000000000000..59ce056ead93
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,ipq5424-nsscc.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_QCOM_IPQ5424_NSSCC_H
> +#define _DT_BINDINGS_CLOCK_QCOM_IPQ5424_NSSCC_H
> +
> +/* NSS_CC clocks */
> +#define NSS_CC_CE_APB_CLK					0
> +#define NSS_CC_CE_AXI_CLK					1
> +#define NSS_CC_CE_CLK_SRC					2
> +#define NSS_CC_CFG_CLK_SRC					3
> +#define NSS_CC_DEBUG_CLK					4
> +#define NSS_CC_EIP_BFDCD_CLK_SRC				5
> +#define NSS_CC_EIP_CLK						6
> +#define NSS_CC_NSS_CSR_CLK					7
> +#define NSS_CC_NSSNOC_CE_APB_CLK				8
> +#define NSS_CC_NSSNOC_CE_AXI_CLK				9
> +#define NSS_CC_NSSNOC_EIP_CLK					10
> +#define NSS_CC_NSSNOC_NSS_CSR_CLK				11
> +#define NSS_CC_NSSNOC_PPE_CFG_CLK				12
> +#define NSS_CC_NSSNOC_PPE_CLK					13
> +#define NSS_CC_PORT1_MAC_CLK					14
> +#define NSS_CC_PORT1_RX_CLK					15
> +#define NSS_CC_PORT1_RX_CLK_SRC					16
> +#define NSS_CC_PORT1_RX_DIV_CLK_SRC				17
> +#define NSS_CC_PORT1_TX_CLK					18
> +#define NSS_CC_PORT1_TX_CLK_SRC					19
> +#define NSS_CC_PORT1_TX_DIV_CLK_SRC				20
> +#define NSS_CC_PORT2_MAC_CLK					21
> +#define NSS_CC_PORT2_RX_CLK					22
> +#define NSS_CC_PORT2_RX_CLK_SRC					23
> +#define NSS_CC_PORT2_RX_DIV_CLK_SRC				24
> +#define NSS_CC_PORT2_TX_CLK					25
> +#define NSS_CC_PORT2_TX_CLK_SRC					26
> +#define NSS_CC_PORT2_TX_DIV_CLK_SRC				27
> +#define NSS_CC_PORT3_MAC_CLK					28
> +#define NSS_CC_PORT3_RX_CLK					29
> +#define NSS_CC_PORT3_RX_CLK_SRC					30
> +#define NSS_CC_PORT3_RX_DIV_CLK_SRC				31
> +#define NSS_CC_PORT3_TX_CLK					32
> +#define NSS_CC_PORT3_TX_CLK_SRC					33
> +#define NSS_CC_PORT3_TX_DIV_CLK_SRC				34
> +#define NSS_CC_PPE_CLK_SRC					35
> +#define NSS_CC_PPE_EDMA_CFG_CLK					36
> +#define NSS_CC_PPE_EDMA_CLK					37
> +#define NSS_CC_PPE_SWITCH_BTQ_CLK				38
> +#define NSS_CC_PPE_SWITCH_CFG_CLK				39
> +#define NSS_CC_PPE_SWITCH_CLK					40
> +#define NSS_CC_PPE_SWITCH_IPE_CLK				41
> +#define NSS_CC_UNIPHY_PORT1_RX_CLK				42
> +#define NSS_CC_UNIPHY_PORT1_TX_CLK				43
> +#define NSS_CC_UNIPHY_PORT2_RX_CLK				44
> +#define NSS_CC_UNIPHY_PORT2_TX_CLK				45
> +#define NSS_CC_UNIPHY_PORT3_RX_CLK				46
> +#define NSS_CC_UNIPHY_PORT3_TX_CLK				47
> +#define NSS_CC_XGMAC0_PTP_REF_CLK				48
> +#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC			49
> +#define NSS_CC_XGMAC1_PTP_REF_CLK				50
> +#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC			51
> +#define NSS_CC_XGMAC2_PTP_REF_CLK				52
> +#define NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC			53
> +
> +#endif
> diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
> index 66cd9a9ece03..a78604beff99 100644
> --- a/include/dt-bindings/interconnect/qcom,ipq5424.h
> +++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
> @@ -27,4 +27,17 @@
>  #define MASTER_NSSNOC_SNOC_1		22
>  #define SLAVE_NSSNOC_SNOC_1		23
>  
> +#define MASTER_NSSNOC_PPE		0
> +#define SLAVE_NSSNOC_PPE		1
> +#define MASTER_NSSNOC_PPE_CFG		2
> +#define SLAVE_NSSNOC_PPE_CFG		3
> +#define MASTER_NSSNOC_NSS_CSR		4
> +#define SLAVE_NSSNOC_NSS_CSR		5
> +#define MASTER_NSSNOC_CE_AXI		6
> +#define SLAVE_NSSNOC_CE_AXI		7
> +#define MASTER_NSSNOC_CE_APB		8
> +#define SLAVE_NSSNOC_CE_APB		9
> +#define MASTER_NSSNOC_EIP		10
> +#define SLAVE_NSSNOC_EIP		11
> +
>  #endif /* INTERCONNECT_QCOM_IPQ5424_H */
> diff --git a/include/dt-bindings/reset/qcom,ipq5424-nsscc.h b/include/dt-bindings/reset/qcom,ipq5424-nsscc.h
> new file mode 100644
> index 000000000000..f2f7eaa28b21
> --- /dev/null
> +++ b/include/dt-bindings/reset/qcom,ipq5424-nsscc.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_QCOM_IPQ5424_NSSCC_H
> +#define _DT_BINDINGS_RESET_QCOM_IPQ5424_NSSCC_H
> +
> +#define NSS_CC_CE_APB_CLK_ARES					0
> +#define NSS_CC_CE_AXI_CLK_ARES					1
> +#define NSS_CC_DEBUG_CLK_ARES					2
> +#define NSS_CC_EIP_CLK_ARES					3
> +#define NSS_CC_NSS_CSR_CLK_ARES					4
> +#define NSS_CC_NSSNOC_CE_APB_CLK_ARES				5
> +#define NSS_CC_NSSNOC_CE_AXI_CLK_ARES				6
> +#define NSS_CC_NSSNOC_EIP_CLK_ARES				7
> +#define NSS_CC_NSSNOC_NSS_CSR_CLK_ARES				8
> +#define NSS_CC_NSSNOC_PPE_CLK_ARES				9
> +#define NSS_CC_NSSNOC_PPE_CFG_CLK_ARES				10
> +#define NSS_CC_PORT1_MAC_CLK_ARES				11
> +#define NSS_CC_PORT1_RX_CLK_ARES				12
> +#define NSS_CC_PORT1_TX_CLK_ARES				13
> +#define NSS_CC_PORT2_MAC_CLK_ARES				14
> +#define NSS_CC_PORT2_RX_CLK_ARES				15
> +#define NSS_CC_PORT2_TX_CLK_ARES				16
> +#define NSS_CC_PORT3_MAC_CLK_ARES				17
> +#define NSS_CC_PORT3_RX_CLK_ARES				18
> +#define NSS_CC_PORT3_TX_CLK_ARES				19
> +#define NSS_CC_PPE_BCR						20
> +#define NSS_CC_PPE_EDMA_CLK_ARES				21
> +#define NSS_CC_PPE_EDMA_CFG_CLK_ARES				22
> +#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES				23
> +#define NSS_CC_PPE_SWITCH_CLK_ARES				24
> +#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES				25
> +#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES				26
> +#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES				27
> +#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES				28
> +#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES				29
> +#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES				30
> +#define NSS_CC_UNIPHY_PORT3_RX_CLK_ARES				31
> +#define NSS_CC_UNIPHY_PORT3_TX_CLK_ARES				32
> +#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES				33
> +#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES				34
> +#define NSS_CC_XGMAC2_PTP_REF_CLK_ARES				35
> +
> +#endif
> 
> -- 
> 2.34.1
> 


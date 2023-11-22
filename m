Return-Path: <linux-pm+bounces-86-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27E7F4969
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 15:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F611C20895
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2C4EB3A;
	Wed, 22 Nov 2023 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2nLHfrl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F04EB33;
	Wed, 22 Nov 2023 14:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3537C433C8;
	Wed, 22 Nov 2023 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700664760;
	bh=sAcyOaQD3H8yNNyICEEcQesIVItkS+W3nQU7LOMsA5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H2nLHfrlVrecaRMxljeGrGPPA1/Bs/RYZ9Ev2x/KsNSFbFCgd/Qa2eOI1Ow7fQDFv
	 2HslTgqlcfn1snthG3a2Yd2eXCyOo8jw02pp3VrnMIvRNPuZovk5YjLdStnmd6c/TT
	 02mXMVlEVH055S1KG/3Yrj+Mk47dUePHMWbXZka/pWJULz2U5vPAfQveM9rBrtOBNg
	 zegujGhydRKuiORCgoNcobzs4mvum0pUjynIpc8upA+9Zpr+Qon06kn69aswrJSbxg
	 vFmyNhsFD/hQvgpXgVGthf+Vk+si05oI3aSM0UGm118ezb3EP3NoEa35IX9IMdU9eM
	 YWRLWvt1a1G7A==
Message-ID: <77f39971-6d8a-4e1a-b7e6-bffb5fbf74db@kernel.org>
Date: Wed, 22 Nov 2023 16:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: interconnect: Add Qualcomm X1E80100
 SoC
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc: agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
 abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
 neil.armstrong@linaro.org
References: <20231117103035.25848-1-quic_sibis@quicinc.com>
 <20231117103035.25848-2-quic_sibis@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231117103035.25848-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sibi,

On 17.11.23 12:30, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> The Qualcomm X1E80100 SoC has several bus fabrics that could be controlled
> and tuned dynamically according to the bandwidth demand.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> v2:
> * Update the part number from sc8380xp to x1e80100.
> * Fixup required property ordering [Krzysztof]
> * Pickup Rbs.
> 
>   .../interconnect/qcom,x1e80100-rpmh.yaml      |  83 +++++++
>   .../interconnect/qcom,x1e80100-rpmh.h         | 207 ++++++++++++++++++
>   2 files changed, 290 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
>   create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h

[..]

> +#define MASTER_AV1_ENC				0
> +#define MASTER_CAMNOC_HF			1
> +#define MASTER_CAMNOC_ICP			2
> +#define MASTER_CAMNOC_SF			3
> +#define MASTER_EVA				4
> +#define MASTER_MDP				5
> +#define MASTER_VIDEO				6
> +#define MASTER_VIDEO_CV_PROC			7
> +#define MASTER_VIDEO_V_PROC			8
> +#define MASTER_CNOC_MNOC_CFG			9
> +#define SLAVE_MNOC_HF_MEM_NOC			10
> +#define SLAVE_MNOC_SF_MEM_NOC			11
> +#define SLAVE_SERVICE_MNOC			12
> +#define MASTER_MDP_DISP				13
> +#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
> +
> +#define MASTER_CDSP_PROC			0
> +#define SLAVE_CDSP_MEM_NOC			1
> +
> +#define MASTER_PCIE_NORTH			0
> +#define MASTER_PCIE_SOUTH			0

This duplicate index looks like a typo?

> +#define SLAVE_ANOC_PCIE_GEM_NOC			3
> +#define MASTER_PCIE_NORTH_PCIE			4
> +#define MASTER_PCIE_SOUTH_PCIE			5
> +#define SLAVE_ANOC_PCIE_GEM_NOC_PCIE		6
[..]

Thanks,
Georgi



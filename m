Return-Path: <linux-pm+bounces-31061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322EB0A55B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F46A168EB2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B1148838;
	Fri, 18 Jul 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbGbpXgC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB282AD2F;
	Fri, 18 Jul 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846112; cv=none; b=ju1IM0k38lakF0252lyPgxf9ooZW1MdQq2Bv7eL/1HZ7imPgec83VNHwQWCic28QmibnDtyX8Kw6g1WiGGa47j+UOb6HxVya/W9Kk5OwGtsWai943wRARly5p/mSJywtwEt56Xg1JgnHNyTrY72RPaB1vi02i92+9tnZV2u7Zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846112; c=relaxed/simple;
	bh=avJpFlqig12EKxnGpyoNFdv5k4eIVYy9aoIS6p/eMc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Okc+5qaOlayFyvCcAlRfLSqTbaneupCxCeJ1hZsTiglw2rZsne7I4oDQtrVCoCe0SM76M2RmjnqeBgtxjzjTeUcsj4MTJX4kovR8uYilBUSrQHaGGsFePGYLrYoUh3JlrZk/+NcGxZUILsHyHPpelu+c+5Y5+rQixMrrL2hHAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbGbpXgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD9FC4CEF0;
	Fri, 18 Jul 2025 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752846111;
	bh=avJpFlqig12EKxnGpyoNFdv5k4eIVYy9aoIS6p/eMc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZbGbpXgCzOARuo5vgET6kteenJppwv4exXdqXMgEzWRrWkIYETKx8sRh+SM/jDtPs
	 OHjrgWFOE2lRI+saSsdQ6iNGi12rLhAj2pNC4YUKRmsQ10TBqDomKCmv56YFfIBb/n
	 lux43igB5+Li3CCJMmTPSowTUsDHIgfyrH+O5fuDoj7AowXBMy/epfzIejCFJNYJoV
	 mFzjfV17nb2j/KUwSG1diISm5kTTiV1YVrRtbjb1I2auZAX4FFanGE+YAGE2vYkU5t
	 CkmDa4r7DuNDhCOFTRPN82JtP7S6izBIIOsCguK6lc4ts6sGKq6B71MQ3yKbdwmNm1
	 Bace+ZOeS7C6Q==
Message-ID: <6a6a471c-1d1b-4283-93b0-0f777a44959c@kernel.org>
Date: Fri, 18 Jul 2025 16:41:42 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
To: Luo Jie <quic_luoj@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
 quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
 quic_suruchia@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-1-f149dc461212@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-1-f149dc461212@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 3:28 PM, Luo Jie wrote:
> Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
> (NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
> that provides the interconnect services by using the icc-clk framework.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   include/dt-bindings/interconnect/qcom,ipq5424.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
> index a770356112ee..66cd9a9ece03 100644
> --- a/include/dt-bindings/interconnect/qcom,ipq5424.h
> +++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
> @@ -20,5 +20,11 @@
>   #define SLAVE_CNOC_PCIE3		15
>   #define MASTER_CNOC_USB			16
>   #define SLAVE_CNOC_USB			17
> +#define MASTER_NSSNOC_NSSCC		18
> +#define SLAVE_NSSNOC_NSSCC		19
> +#define MASTER_NSSNOC_SNOC_0		20
> +#define SLAVE_NSSNOC_SNOC_0		21
> +#define MASTER_NSSNOC_SNOC_1		22
> +#define SLAVE_NSSNOC_SNOC_1		23
>   
>   #endif /* INTERCONNECT_QCOM_IPQ5424_H */
> 



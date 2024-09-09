Return-Path: <linux-pm+bounces-13885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C79971880
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A23284504
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504571B5EB8;
	Mon,  9 Sep 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5rCuUt/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BA13BAF1;
	Mon,  9 Sep 2024 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882282; cv=none; b=hW8MzaVM3PuCpzNonVgACwlrXa9hjC0LnW5en70HIK/wmfc4QFsvZ6UXb4XKZmEmoxrigbAYhGs8TZioL3wLGP4YnqXwF5JKZqegJ4+WgbzWXOdajPBGH/f6tf8prr7aqQYcCug0x0IhL0ZSrhCkJZquVE+wy5V4nD+n7mMSa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882282; c=relaxed/simple;
	bh=f+NSGq6TljgaNwZQR7G5fjeuCWVRffzY5N1ZKOCGWRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hd1FpBjDhcvAhsj2tM54ga7kZsfiq3BApvQnVHODrFvL6hHK7b6+6OKj6Qks2hwGMtz5t2wQ/OpiOfGnoMMx8caXthysijtbMYEOwn1faEoHAtpCiV/DECUP4KDw8lHk1DgmTwb92Of/vbC9bqGF/g1ZzGzoLlpWfzIAVU+ygNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5rCuUt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D665C4CEC5;
	Mon,  9 Sep 2024 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725882281;
	bh=f+NSGq6TljgaNwZQR7G5fjeuCWVRffzY5N1ZKOCGWRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U5rCuUt/Kr5K4UckaJ73ypDTLTtixWFzKt3lquC/DY09gjkA3/Nzoio4x4Whgr6va
	 vu6s5/ffO1xDlTlN0O71toCg5d6yY3DKQswqMCug3OKn8Mkk/w5kr/Jpp2J8/urKOz
	 ZfOwLz+ck0/pJB2Jxf1jD3yzGdJyMeE5fbKLQDrl1YBtPbotH5RILg3qPKCyyeEFvP
	 kcSNg1hMkb8yyqcIztk16N+kAeu8UzbXWkU4qtU9k0y9/tptbj5i59cylHNpuIC/b5
	 u+NohObw3VMX2zk+tywKp83wOhoKvMU3RRSKJWSDcA5FfN1UmZRoztPsIrfaGvQpDQ
	 4jDYni0nYYGzg==
Message-ID: <19c749c5-2afd-4623-861a-ad30606c2722@kernel.org>
Date: Mon, 9 Sep 2024 13:44:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
 <20240904171209.29120-4-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240904171209.29120-4-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.09.2024 7:12 PM, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> SA8775P SoCs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 61a8695a9adc..e97d61a9d8d7 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/args.h>
> @@ -74,6 +75,11 @@ enum {
>  	OSM_L3_SLAVE_NODE,
>  };
>  
> +enum {
> +	EPSS_L3_CL1_MASTER_NODE = 20000,
> +	EPSS_L3_CL1_SLAVE_NODE,
> +};
> +
>  #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
>  	static const struct qcom_osm_l3_node _name = {			\
>  		.name = #_name,						\
> @@ -99,6 +105,15 @@ static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>  };
>  
> +DEFINE_QNODE(epss_l3_cl1_master, EPSS_L3_CL1_MASTER_NODE, 32,
> +	     EPSS_L3_CL1_SLAVE_NODE);
> +DEFINE_QNODE(epss_l3_cl1_slave, EPSS_L3_CL1_SLAVE_NODE, 32);
> +
> +static const struct qcom_osm_l3_node * const epss_l3_cl1_nodes[] = {
> +	[MASTER_EPSS_L3_APPS] = &epss_l3_cl1_master,
> +	[SLAVE_EPSS_L3_SHARED] = &epss_l3_cl1_slave,
> +};
> +
>  static const struct qcom_osm_l3_desc osm_l3 = {
>  	.nodes = osm_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
> @@ -115,6 +130,14 @@ static const struct qcom_osm_l3_desc epss_l3_perf_state = {
>  	.reg_perf_state = EPSS_REG_PERF_STATE,
>  };
>  
> +static const struct qcom_osm_l3_desc epss_l3_cl1_perf_state = {
> +	.nodes = epss_l3_cl1_nodes,
> +	.num_nodes = ARRAY_SIZE(epss_l3_cl1_nodes),
> +	.lut_row_size = EPSS_LUT_ROW_SIZE,
> +	.reg_freq_lut = EPSS_REG_FREQ_LUT,
> +	.reg_perf_state = EPSS_REG_PERF_STATE,
> +};

This is a bad workaround for the unfortunate interconnect API choices
(conflicting ICC IDs), in no way specific to this platform

> +
>  static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
>  	.nodes = epss_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
> @@ -284,6 +307,10 @@ static const struct of_device_id osm_l3_of_match[] = {
>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
> +	{ .compatible = "qcom,sa8775p-epss-l3-cl0",
> +	  .data = &epss_l3_perf_state },

Reuse qcom,sm8250-epss-l3, like:

compatible = "qcom,foobar-epss-l3", "qcom,sm8250-epss-l3";

Konrad


Return-Path: <linux-pm+bounces-25363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE36A87C8F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B2C188789B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142E265604;
	Mon, 14 Apr 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTEwOkdH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03425F7BB;
	Mon, 14 Apr 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624649; cv=none; b=Js/JRS9cRaGT6l+muGgxNzRKjsKUuqVH6OKfYvCUKfmf5iXMN88Mz/HnWt+uZAmF/SIKKZFAqGw3JQy1N3U/yzwFtP/bPW9xAWaKGck3KNUOBTPwuZ+mUHNP0WQZpWfNe6HSgLs0MxvjgR/shxCJlylVMtcR/L7QS3CV5PQm5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624649; c=relaxed/simple;
	bh=iiRnoafCCd8JPxJ69U7BdDo3/KfoV2+6rCQa4eUJrS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NT5368Mw59iyBVL/jXQgjBUH8T4nvILLpRzcS1STflY6E/xrUlx6QQWbtc61KIj79NBIcL8wkYbydI1Lhsbx108KrAZ1iJO5MdRs0ORSxMHLjKEjyPE+XkrnQ2lmYmRM+VW8tIeoHoRzL00IZVBGcxuiIs7jnMg9E811BL7BSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTEwOkdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D207FC4CEE2;
	Mon, 14 Apr 2025 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744624649;
	bh=iiRnoafCCd8JPxJ69U7BdDo3/KfoV2+6rCQa4eUJrS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TTEwOkdHH0OtupdnImGncs6dDgKOQLmnG44gSC9R7pj2I4WkCnDyYtaf+dVCe/6fd
	 AXZUUymuVoJmPHFUW582AT0VgFtqy1mKAdVn1Eql7fKFqGqYKnLvdeLYcowDj7k+jB
	 O6KyiKGmKPKV6RnNU7x7nnfwB7YRuudgqazLi244RVX0/NA60SaQYlssdeSqWxedoR
	 1gmbVNvcYv3h+KBqrc5VpWWbQ4Gktu3U6H/PlUTWbpTC5IucGJyygBJCR6J/x2DFXw
	 c6ZqE+nVqZ3nByi5D5Gg0Tv0KOGV/lDG8uo0QtZGddlqvRqQwJ9LOYOMYMyJUdE4h7
	 dPrxwI+qF8t5w==
Message-ID: <5310f549-fdb0-4554-87fc-33bf61e752b7@kernel.org>
Date: Mon, 14 Apr 2025 12:57:23 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 2/7] interconnect: core: Add dynamic id allocation
 support
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-3-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250324183203.30127-3-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.03.25 20:31, Raviteja Laggyshetty wrote:
> The current interconnect framework relies on static IDs for node
> creation and registration, which limits topologies with multiple
> instances of the same interconnect provider. To address this,
> introduce icc_node_create_dyn() and icc_link_nodes() APIs to
> dynamically allocate IDs for interconnect nodes during creation
> and link. This change removes the dependency on static IDs,
> allowing multiple instances of the same hardware, such as EPSS L3.
> 

Hi Raviteja,

Thank you for working on this!

> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>   drivers/interconnect/core.c           | 83 ++++++++++++++++++++++++++-
>   include/linux/interconnect-provider.h | 12 ++++
>   include/linux/interconnect.h          |  3 +
>   3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 9d5404a07e8a..d4c40c2b3ec1 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -20,6 +20,8 @@
>   
>   #include "internal.h"
>   
> +#define ICC_DYN_ID_START 10000
> +
>   #define CREATE_TRACE_POINTS
>   #include "trace.h"
>   
> @@ -826,7 +828,12 @@ static struct icc_node *icc_node_create_nolock(int id)
>   	if (!node)
>   		return ERR_PTR(-ENOMEM);
>   
> -	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +	/* dynamic id allocation */
> +	if (id == ICC_ALLOC_DYN_ID)
> +		id = idr_alloc(&icc_idr, node, ICC_DYN_ID_START, 0, GFP_KERNEL);
> +	else
> +		id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +
>   	if (id < 0) {
>   		WARN(1, "%s: couldn't get idr\n", __func__);
>   		kfree(node);
> @@ -838,6 +845,26 @@ static struct icc_node *icc_node_create_nolock(int id)
>   	return node;
>   }
>   
> +/**
> + * icc_node_create_dyn() - create a node with dynamic id
> + * @id: node id

This function does not take any arguments. Please remove.

> + *
> + * Return: icc_node pointer on success, or ERR_PTR() on error
> + */
> +struct icc_node *icc_node_create_dyn(void)
> +{
> +	struct icc_node *node;
> +
> +	mutex_lock(&icc_lock);
> +
> +	node = icc_node_create_nolock(ICC_ALLOC_DYN_ID);
> +
> +	mutex_unlock(&icc_lock);
> +
> +	return node;
> +}
> +EXPORT_SYMBOL_GPL(icc_node_create_dyn);

BR,
Georgi


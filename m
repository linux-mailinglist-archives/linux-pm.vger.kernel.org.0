Return-Path: <linux-pm+bounces-31060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2756B0A54F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81017A8E30
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975012CD8B;
	Fri, 18 Jul 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2F6vehq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5162AD2F;
	Fri, 18 Jul 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845887; cv=none; b=fL2xHFs/tURWcbaH+y8x71S4zDIDJTMSjNjx4ZB9QRdUF/smKcTZysESmbGmgZkM4DZVBH9qEN4Dpp8IwiVpd898lMdcjcymYPcfbu4zNQ6f+5tD4hOtk6Bvs/uBm/w0fXtfwzxKCMFu1CA4VVX2K5f+fj16fZe2ZTu/ZRO0gAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845887; c=relaxed/simple;
	bh=cQfMiHxKSxzXd0SZmHAWYnE0ssYW1iWXlohanmbLpSo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L/aT4VU1JYO6/IHONCNXnrk4j8hEY9ZeacUvFBG8S9HBQ/TJKnXDnWk4/gLYZulTIRdahatb7DjLZBHu/lk0BMi9bhHsOlA8JgW+CvoatlNWiZxnc77msBAMXF1f/kkNBmpoFGpVcnC7V2dceuByWNh9nuaA6czDZQvtcSSZ0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2F6vehq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A40C4CEEB;
	Fri, 18 Jul 2025 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752845886;
	bh=cQfMiHxKSxzXd0SZmHAWYnE0ssYW1iWXlohanmbLpSo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=L2F6vehqsN4RSbPPfYD/fGbRIOoD30lJ6yZLscm2oNslO8Hdolj1ZxAW/1PA2gmvO
	 mcdhAEXRqBIEvKHjJGPBF89W5NyCt2WRwCygubCUnpjQ2ViwLcknhm0JRLMTObNGe9
	 tTTGNv+0wo2mG8c/9ERydH3VneE7Kbn9AVWowcwbVnnr9SkjO3qR+ZTYwLmw4QjWvM
	 /64fKHIBHrSju+UNa5RlbndYQLm0bvRVDem7QwgXIpYnc6RNVIr2LwQHBeoND2mZ68
	 0O/gyJGt7e6cQHpgkipCdmwbJuyzEaJILdCDnUnsCk0TOGyf78OPUoC7XJnOw3ilc/
	 GoDjUfou9mgOg==
Message-ID: <859be3e3-be14-411d-b5ef-07bdad91a878@kernel.org>
Date: Fri, 18 Jul 2025 16:38:02 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 7/4/25 7:35 PM, Dmitry Baryshkov wrote:
> Having the .num_nodes as a separate struct field can provoke errors as
> it is easy to omit it or to put an incorrect value into that field. Turn
> .nodes into a NULL-terminated array, removing a need for a separate
> .num_nodes field. 

I am not entirely convinced that an error in the termination is more
unlikely than an error in the num_nodes. Aren't we trading one kind of
error for another? Also if we omit the num_nodes i expect that just the
QoS of a specific path will fail, but if we miss the NULL - worse things
might happen.

[..]
>   27 files changed, 541 insertions(+), 1119 deletions(-)

The negative diffstat is nice.

> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index a2d437a05a11fa7325f944865c81a3ac7dbb203e..4fa960630d28f338f484794d271a5b52f3e698d3 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -68,7 +68,7 @@ static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
>   		bcm->vote_x[bucket] = 0;
>   		bcm->vote_y[bucket] = 0;
>   
> -		for (i = 0; i < bcm->num_nodes; i++) {
> +		for (i = 0; bcm->nodes[i]; i++) {
>   			node = bcm->nodes[i];

I like better the single memory access and the two registers comparison
that we already have, but both are fine as we are not in some critical
section.

[..]
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index bd8d730249b1c9e5b37afbee485b9500a8028c2e..0018aa74187edcac9a0492c737771d957a133cc0 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -126,7 +126,6 @@ struct qcom_icc_node {
>    * communicating with RPMh
>    * @list: used to link to other bcms when compiling lists for commit
>    * @ws_list: used to keep track of bcms that may transition between wake/sleep
> - * @num_nodes: total number of @num_nodes
>    * @nodes: list of qcom_icc_nodes that this BCM encapsulates
>    */
>   struct qcom_icc_bcm {
> @@ -142,7 +141,6 @@ struct qcom_icc_bcm {
>   	struct bcm_db aux_data;
>   	struct list_head list;
>   	struct list_head ws_list;
> -	size_t num_nodes;

So no change in memory footprint, as now instead of the num_nodes, there
will be an additional NULL pointer for termination.

[..]

Well, this approach is also good. The existing one just follows the pattern
used by other frameworks, that seemed more common and thus make the code
easier to read and review.

I don't see a strong argument to switch to a NULL terminated arrays (yet),
as it does not make things any better for performance/memory, so I'm not
sure if it's worth reshuffling the 10k+ LoC in drivers. Is there any other
argument that i miss?

Thanks,
Georgi



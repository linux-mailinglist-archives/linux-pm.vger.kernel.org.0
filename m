Return-Path: <linux-pm+bounces-20279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A75A0A604
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 21:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AB13A9255
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814211B87E7;
	Sat, 11 Jan 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX3bwQVN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419E1B86D5;
	Sat, 11 Jan 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736629081; cv=none; b=d6CllpdiMj4JgH/7Ka5IF3V+u9taJKpG9ELERF6Nbo6JqwmRaNgfrW8mTD7OiA42mdmL79JhX66kK4levuqszQiuXjxOR6ccl+Tef4P3EH0At1UEskVScZT/+tfU68hryVE66VY8Z/I9hGrb9htA3Z+SNXN38MvFcPP7GtgOm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736629081; c=relaxed/simple;
	bh=rZlrw1MdH6lT8XSO9uN3ijndrX0n6Szo2E+ewjmusds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaZcRqN3dLniZNJvZXxL4bLsSoJkSVhudbHR+AFx9IvmJNvd3iSBL1/ZHicwbjnqqBy8EcHqYvCFMt21tHtFDvStgjxyMye90RJoGtGQ0GYy3svpPiU49H+XRs7gI4aGw7HGbSUFcf7DAktcABACAryBMIhlyRyGMPuNRz3Lhr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX3bwQVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9DFC4CEDF;
	Sat, 11 Jan 2025 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736629080;
	bh=rZlrw1MdH6lT8XSO9uN3ijndrX0n6Szo2E+ewjmusds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX3bwQVNl3E/1qKRxzxPkJlmeYY1s+/Jb0+cxDa+EXiuK2dFpWgv/DsnRkxh3kLge
	 ZuU/BnQgf7fUAZIYQeMNMTrhbb1gO5ioqTyE9SUMiUIJUnD5wp/mY+p1whA73mQHaK
	 jNtVwpwsSd/09U3ZN+WNQ5daMz0DRO9rMi1rOfnOG7Z4ru44/RXQ+jvnKR6q+FgoZk
	 wPQ4yQkfyeerWgFOmryCeV+xhgwh525IgAA7RycHyItPHtswJzBLpputMZsKRrOW8R
	 QSOmBYnF4no5EsF/GHI8BiV1XboXJ2+kLtknFwlE+XgLmT/a6Cby/4bdl8kSmn5ojD
	 O/8H2mPGeXIvA==
Date: Sat, 11 Jan 2025 14:57:57 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	Mike Tipton <mdptipton@quicinc.com>, Vivek Aknurwar <viveka@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation
 support
Message-ID: <pu3s3fjkt2663wce2632s25oys56wkhsc22lcc5ydepfc4pbll@n73ouprb25zj>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111161429.51-2-quic_rlaggysh@quicinc.com>

On Sat, Jan 11, 2025 at 04:14:25PM +0000, Raviteja Laggyshetty wrote:
> Current interconnect framework is based on static IDs for creating node
> and registering with framework. This becomes a limitation for topologies
> where there are multiple instances of same interconnect provider. Add
> icc_node_create_alloc_id() API to create icc node with dynamic id, this
> will help to overcome the dependency on static IDs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/core.c           | 32 +++++++++++++++++++++++++++
>  include/linux/interconnect-provider.h |  6 +++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 9d5404a07e8a..0b7093eb51af 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -858,6 +858,38 @@ struct icc_node *icc_node_create(int id)
>  }
>  EXPORT_SYMBOL_GPL(icc_node_create);
>  
> +/**
> + * icc_node_create_alloc_id() - create node and dynamically allocate id
> + * @start_id: min id to be allocated
> + *
> + * Return: icc_node pointer on success, or ERR_PTR() on error
> + */
> +struct icc_node *icc_node_create_alloc_id(int start_id)

By having clients pass in start_id, you distribute the decision of what
a "good number" is across multiple parts of the system (or you have
clients relying on getting [start_id, start_id + N) back).

Wouldn't it be better to hide that choice in one place (inside the icc
framework)?

Regards,
Bjorn

> +{
> +	struct icc_node *node;
> +	int id;
> +
> +	mutex_lock(&icc_lock);
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id = idr_alloc(&icc_idr, node, start_id, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		WARN(1, "%s: couldn't get idr\n", __func__);
> +		kfree(node);
> +		node = ERR_PTR(id);
> +		goto out;
> +	}
> +	node->id = id;
> +out:
> +	mutex_unlock(&icc_lock);
> +
> +	return node;
> +}
> +EXPORT_SYMBOL_GPL(icc_node_create_alloc_id);
> +
>  /**
>   * icc_node_destroy() - destroy a node
>   * @id: node id
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index f5aef8784692..4fc7a5884374 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -117,6 +117,7 @@ struct icc_node {
>  int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>  struct icc_node *icc_node_create(int id);
> +struct icc_node *icc_node_create_alloc_id(int start_id);
>  void icc_node_destroy(int id);
>  int icc_link_create(struct icc_node *node, const int dst_id);
>  void icc_node_add(struct icc_node *node, struct icc_provider *provider);
> @@ -141,6 +142,11 @@ static inline struct icc_node *icc_node_create(int id)
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline struct icc_node *icc_node_create_alloc_id(int start_id)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline void icc_node_destroy(int id)
>  {
>  }
> -- 
> 2.39.2
> 


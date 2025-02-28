Return-Path: <linux-pm+bounces-23141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479AA48D7E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 01:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814BF18874D1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9B276D2D;
	Fri, 28 Feb 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzT3biDk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62240182D0;
	Fri, 28 Feb 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703199; cv=none; b=TU5QNjkQujXPbsXJopUcwurAzOVr6H49YcM7ZncUo+k2gS8cr37Y2Al1zIZKplZ7svakReQ9sYZ+dkD2Qj1wpw4sFBELFPNbddgiGJeNf5Km5cQbVTeaMWyBX43MBO/Zluntss31CvCqK2czHUek/j/N0kMD/06Df2oS+R5GI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703199; c=relaxed/simple;
	bh=ZOo+t3tjZlWVGbfk1wn2SMiVrhVzuQM3wZ7uUv4EW4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrBXzOSsQDrirY5GzSp6SyOBPzmSqw6trhfYQqMnepqMpxSuP+1fF+UCRVnopEkA4Scwtwj7LB34xaikyTvvmEqbcv4aqkxBUncsUEiL5gXW01HxoBYnH0YUfkf7d5+gzmDFFpHexL/IbQ90aqVO2RRbNfb5GH5tAOgW5iUaFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzT3biDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEC2C4CEE4;
	Fri, 28 Feb 2025 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740703198;
	bh=ZOo+t3tjZlWVGbfk1wn2SMiVrhVzuQM3wZ7uUv4EW4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzT3biDkfelFWlaJR1wsrIqHikIsHyerNJBDSD0Ot8Um23ZFNQUwJkoOaQzxEx0aw
	 1lFCFZ5XpO5elEvddPtf1wVVQh866F48VLsngWfAqyCl6sCCMuqlOnp3F7TJwdGkdx
	 QdyLtWSis8X2jU/aj1QuVYWayiY+W0HOzNNLHLQxbkvSkinWd/ZvXPyIXW/Hs1KpkI
	 Ca0Hzmj6JelmMbpSe7YpjUQV/vj3oKA9LjOaUKkQcyQBriOk2WGKUnEGRnKTZN+WJ7
	 aoDTDFVCVgBWGJ6WUkE1XOidEU7jZELu+vlIJxilVZ5CIiIiJB2AM+RwOUsI3wPmgD
	 o4i2uELWSIyyg==
Date: Thu, 27 Feb 2025 18:39:55 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Mike Tipton <mdtipton@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 3/7] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <a2hpdflba4wmho3wzphr2w5htgolksq43nuewcwqr7goy6rc5q@6fot5l6q6ods>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155213.404-4-quic_rlaggysh@quicinc.com>

On Thu, Feb 27, 2025 at 03:52:09PM +0000, Raviteja Laggyshetty wrote:
> EPSS on SA8775P has two instances, necessitating the creation of two
> device nodes with different compatibles due to the unique ICC node ID
> and name limitations in the interconnect framework. Add multidevice
> support for the OSM-L3 provider to dynamically obtain unique node IDs
> and register with the framework.
> EPSS topology includes a single master-slave pair within the same
> provider, the node linking logic is simplified by directly connecting
> the master node to the slave node.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 37 ++++++++++--------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 6a656ed44d49..a9dacc4b7f2e 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/args.h>
> @@ -48,16 +49,10 @@ struct qcom_osm_l3_icc_provider {
>  /**
>   * struct qcom_osm_l3_node - Qualcomm specific interconnect nodes
>   * @name: the node name used in debugfs
> - * @links: an array of nodes where we can go next while traversing
> - * @id: a unique node identifier
> - * @num_links: the total number of @links
>   * @buswidth: width of the interconnect between a node and the bus
>   */
>  struct qcom_osm_l3_node {
>  	const char *name;
> -	u16 links[OSM_L3_MAX_LINKS];
> -	u16 id;
> -	u16 num_links;
>  	u16 buswidth;
>  };
>  
> @@ -69,30 +64,22 @@ struct qcom_osm_l3_desc {
>  	unsigned int reg_perf_state;
>  };
>  
> -enum {
> -	OSM_L3_MASTER_NODE = 10000,
> -	OSM_L3_SLAVE_NODE,
> -};
> -
> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
> +#define DEFINE_QNODE(_name, _buswidth)					\
>  	static const struct qcom_osm_l3_node _name = {			\
>  		.name = #_name,						\
> -		.id = _id,						\
>  		.buswidth = _buswidth,					\
> -		.num_links = COUNT_ARGS(__VA_ARGS__),			\
> -		.links = { __VA_ARGS__ },				\
>  	}
>  
> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
> +DEFINE_QNODE(osm_l3_master, 16);
> +DEFINE_QNODE(osm_l3_slave, 16);
>  
>  static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>  };
>  
> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
> +DEFINE_QNODE(epss_l3_master, 32);
> +DEFINE_QNODE(epss_l3_slave, 32);
>  
>  static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
> @@ -242,10 +229,9 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  
>  	icc_provider_init(provider);
>  
> +	/* Create nodes */
>  	for (i = 0; i < num_nodes; i++) {
> -		size_t j;
> -
> -		node = icc_node_create(qnodes[i]->id);
> +		node = icc_node_create(ALLOC_DYN_ID);

Rather than passing a "magic value" as argument to alter how node
creation happens, and in particular if we can avoid sprinkling
ALLOC_DYN_ID across the provider.

How about creating a new function icc_node_create_dyn() and hide the
ALLOC_DYN_ID within the interconnect framework?


Other than that I really like how this is turning out.

Regards,
Bjorn

>  		if (IS_ERR(node)) {
>  			ret = PTR_ERR(node);
>  			goto err;
> @@ -256,12 +242,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  		node->data = (void *)qnodes[i];
>  		icc_node_add(node, provider);
>  
> -		for (j = 0; j < qnodes[i]->num_links; j++)
> -			icc_link_create(node, qnodes[i]->links[j]);
> -
>  		data->nodes[i] = node;
>  	}
>  
> +	/* Create link */
> +	icc_link_create(data->nodes[MASTER_OSM_L3_APPS], data->nodes[SLAVE_OSM_L3]->id);
> +
>  	ret = icc_provider_register(provider);
>  	if (ret)
>  		goto err;
> @@ -278,6 +264,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  static const struct of_device_id osm_l3_of_match[] = {
>  	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
>  	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
>  	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
>  	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
>  	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
> -- 
> 2.43.0
> 


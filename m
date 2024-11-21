Return-Path: <linux-pm+bounces-17858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D59D4C65
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1190EB22860
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2A1D2F6D;
	Thu, 21 Nov 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojzIeINy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E41CD1EE;
	Thu, 21 Nov 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190290; cv=none; b=YZob7Uw7nTib3Ix+2AyRpVaEoLUQN6IPrdPNNf3IpXw2mZdLFM+lnrjCqkV9eRKuw3jlqeuT9Ak434Y2JwAhlK6rMwkGabirsIFUuwAPkC/O/AvdOs2oZsUpM77UE7+noar+/UX5aUSRRG4xx4YvDJbk9Iit0zjYumXI4RtRjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190290; c=relaxed/simple;
	bh=z440+pwaVdLB6iaRYialbWC9O/Ye84qcKAmGEAtf3c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa36MRxMItk88se2A+Ax220kbAxtb+2AeMSUId0B7fenJd0+DWkUOSIhf3TqARf/NPk5Yga34c4gK7ekrZDnuJ3jnU6+fRSEh2v5DY8u0knqz7qgMWZY14DZUdGoF18qJK+vZXWZwKTBOFpBI4UtWkCXtR+7u2NIFoKGitFpmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojzIeINy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B24C4CECC;
	Thu, 21 Nov 2024 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732190290;
	bh=z440+pwaVdLB6iaRYialbWC9O/Ye84qcKAmGEAtf3c0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ojzIeINySnzA28a7btVo+FoSMiSFruB4iW7c98l8cn5COd+8z/QVWhLW2UfxspV96
	 TZdnSAn5JdNzUu8+F2Hn+Vc0lH/sPtUPLnGrO4NCTkvRTYLl8mj7P9r8BToWifXvKT
	 6PXZJbfneMq+DIRYcxWQISTTfOlSmlJW1WOQPqGIu5vZDLsoejlavvRjgjx0FNBzne
	 QOon7LILx7aJ2lhbGtQSTQgPJ+O8CBJJAqrU7NdQwxD9i2/BidVGN3bltEsfYpyFaq
	 hfsWNh2k+u3+Skz5UxMR3VHkH15S+LhIgdXOdihhnkj0ZEDySAZSh7Y3H1nsXZHGww
	 PcXEJZt6dMM6w==
Message-ID: <bc926d6d-e3d1-4fbf-9b6a-bbd3816a766d@kernel.org>
Date: Thu, 21 Nov 2024 12:58:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/4] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>, Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider on
> SA8775P SoCs with multiple device support.
> 


...

> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
> +DEFINE_QNODE(osm_l3_master, 16, osm_l3_slave);
> +DEFINE_QNODE(osm_l3_slave, 16);
>  
> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>  };
>  
> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
> +DEFINE_QNODE(epss_l3_master, 32, epss_l3_slave);
> +DEFINE_QNODE(epss_l3_slave, 32);
>  
> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {


I think dropping const makes the code worse, not better. Commit msg does
not explain all these changes and I could not figure out the intention
(except modifying but that's just obvious).



>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>  };
> @@ -123,6 +125,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
>  	.reg_perf_state = EPSS_REG_L3_VOTE,
>  };
>  
> +static u16 get_node_id_by_name(const char *node_name,
> +			       const struct qcom_osm_l3_desc *desc)
> +{
> +	struct qcom_osm_l3_node *const *nodes = desc->nodes;
> +	int i;
> +
> +	for (i = 0; i < desc->num_nodes; i++) {
> +		if (!strcmp(nodes[i]->name, node_name))
> +			return nodes[i]->id;
> +	}
> +	return 0;
> +}
> +
>  static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
>  {
>  	struct qcom_osm_l3_icc_provider *qp;
> @@ -164,10 +179,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  	const struct qcom_osm_l3_desc *desc;
>  	struct icc_onecell_data *data;
>  	struct icc_provider *provider;
> -	const struct qcom_osm_l3_node * const *qnodes;
> +	struct qcom_osm_l3_node * const *qnodes;
>  	struct icc_node *node;
>  	size_t num_nodes;
>  	struct clk *clk;
> +	u64 addr;
>  	int ret;
>  
>  	clk = clk_get(&pdev->dev, "xo");
> @@ -188,6 +204,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  	if (!qp)
>  		return -ENOMEM;
>  
> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
> +	if (ret)
> +		return ret;
> +
>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(qp->base))
>  		return PTR_ERR(qp->base);
> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  
>  	icc_provider_init(provider);
>  
> +	/* Allocate unique id for qnodes */
> +	for (i = 0; i < num_nodes; i++)
> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
> +
>  	for (i = 0; i < num_nodes; i++) {
> -		size_t j;
> +		char *node_name;
> +		size_t j, len;
>  
>  		node = icc_node_create(qnodes[i]->id);
>  		if (IS_ERR(node)) {
> @@ -251,13 +276,29 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  			goto err;
>  		}
>  
> -		node->name = qnodes[i]->name;
> +		/* len = strlen(node->name) + @ + 8 (base-address) + NULL */
> +		len = strlen(qnodes[i]->name) + OSM_NODE_NAME_SUFFIX_SIZE;
> +		node_name = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> +		if (!node_name) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		snprintf(node_name, len, "%s@%08llx", qnodes[i]->name, addr);
> +		node->name = node_name;


Why the node name becomes dynamic?

Best regards,
Krzysztof


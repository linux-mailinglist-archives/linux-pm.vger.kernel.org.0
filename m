Return-Path: <linux-pm+bounces-20280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E0A0A617
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 22:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199343A3698
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D11B87F4;
	Sat, 11 Jan 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMpSm/9D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99D1B85FD;
	Sat, 11 Jan 2025 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736629688; cv=none; b=GbeG7VgRwizNcsHbr5tqJpXY37BW0sd6aL+Y9CJRqt6DnM3bmx3ZMEa2bmTpFMPkNVpT1rEn7oD5hws2x4SGHo9GrZhzmsrtAM7/Y6wsCCVPKDmB/TdLFjqZPSXpWlNucO0LMPqyQGSWDqP6EOtF+wuSn2NG3il3k+UrwKTiAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736629688; c=relaxed/simple;
	bh=sTdZbJvN1R01ZZ3exddjP/gE5g6WnN+eKXplEucOz8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f65UjyMcNOCJSMRN373ogu4XHVbUWHve1RzPEHkb52sAHdnOOXS044eJtbV8u1yc2ASA0NaIBFXeQUlRbdxc865HS5dS1uD5Aav+6fDdhxo/RNd3AwOUrXCMIp+5LWkUOtN0haaha4h5i8McIYca99x6pJ3riJIBYSKbmgcFsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMpSm/9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00AEC4CED2;
	Sat, 11 Jan 2025 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736629686;
	bh=sTdZbJvN1R01ZZ3exddjP/gE5g6WnN+eKXplEucOz8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMpSm/9Dm6eNRDifPkcCIWHwdGzItwvxsRmjKeITJHhGm6HPxLvotLNxfbjmt7lG1
	 rl6OO5eLBMSZ7Uoua9zqzlcE67Bv1yKCYWz7eFfEdAsVXlIK6GgoDCHgNMnHe3Kipx
	 +a3EQz7aaS+22P5cb6Ei731tQQ7HioGBLrBJqiQg4yuT4R5nxi7HaDZ6dcOvFAYUfu
	 Z16Ad1+R20EUk8iqs4Pxbv1hgyi1KY7XK2Vf95qgDEYvZ7HMGRGaCg3fKtGnJVKAQQ
	 kwXaWBaV0Dd0phoMH11ga+6pFEsfLTCt4EFNQ2ljJNH+WiJ5Dm2k1xh4KnaHJkwl/n
	 596xtl2nah+Eg==
Date: Sat, 11 Jan 2025 15:08:03 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	Mike Tipton <mdptipton@quicinc.com>, Vivek Aknurwar <viveka@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/5] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <lm6gvcrnd2pcphex4pugxie7m47qlvrgvsvuf75w4uumwoouew@qcuvxeb3u72s>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-3-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111161429.51-3-quic_rlaggysh@quicinc.com>

On Sat, Jan 11, 2025 at 04:14:26PM +0000, Raviteja Laggyshetty wrote:
> EPSS on SA8775P has two instances which requires creation of two device
> nodes with different compatible and device data because of unique
> icc node id and name limitation in interconnect framework.
> Add multidevice support to osm-l3 code to get unique node id from icc
> framework.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 91 ++++++++++++++++++++++--------
>  1 file changed, 67 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 6a656ed44d49..8e98d1c9a840 100644
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
> @@ -11,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
> @@ -34,6 +36,9 @@
>  
>  #define OSM_L3_MAX_LINKS		1
>  
> +#define OSM_L3_NODE_ID_START		10000
> +#define OSM_NODE_NAME_SUFFIX_SIZE	10
> +
>  #define to_osm_l3_provider(_provider) \
>  	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>  
> @@ -55,46 +60,40 @@ struct qcom_osm_l3_icc_provider {
>   */
>  struct qcom_osm_l3_node {
>  	const char *name;
> -	u16 links[OSM_L3_MAX_LINKS];
> +	const char *links[OSM_L3_MAX_LINKS];
>  	u16 id;
>  	u16 num_links;
>  	u16 buswidth;
>  };
>  
>  struct qcom_osm_l3_desc {
> -	const struct qcom_osm_l3_node * const *nodes;
> +	struct qcom_osm_l3_node * const *nodes;
>  	size_t num_nodes;
>  	unsigned int lut_row_size;
>  	unsigned int reg_freq_lut;
>  	unsigned int reg_perf_state;
>  };
>  
> -enum {
> -	OSM_L3_MASTER_NODE = 10000,
> -	OSM_L3_SLAVE_NODE,
> -};
> -
> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
> -	static const struct qcom_osm_l3_node _name = {			\
> +#define DEFINE_QNODE(_name, _buswidth, ...)				\
> +	static struct qcom_osm_l3_node _name = {			\
>  		.name = #_name,						\
> -		.id = _id,						\
>  		.buswidth = _buswidth,					\
>  		.num_links = COUNT_ARGS(__VA_ARGS__),			\
> -		.links = { __VA_ARGS__ },				\
> +		__VA_OPT__(.links = { #__VA_ARGS__ })			\
>  	}
>  
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
>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>  };
> @@ -123,6 +122,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
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
> @@ -164,10 +176,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
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
> @@ -188,6 +201,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
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
> @@ -242,26 +259,51 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  
>  	icc_provider_init(provider);
>  
> +	/* create icc nodes */
>  	for (i = 0; i < num_nodes; i++) {
> -		size_t j;
> +		char *node_name;
> +		size_t len;
>  
> -		node = icc_node_create(qnodes[i]->id);
> +		node = icc_node_create_alloc_id(OSM_L3_NODE_ID_START);
>  		if (IS_ERR(node)) {
>  			ret = PTR_ERR(node);
>  			goto err;
>  		}
> +		qnodes[i]->id = node->id;
> +
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

I don't think it's reasonable to duplicate this logic and the decision
of naming convention in each provider driver. Please provide a generic
solution in the framework.


PS. Not that I want you to use it here, but for the next time be aware
of devm_kasprintf().

>  
> -		node->name = qnodes[i]->name;
>  		/* Cast away const and add it back in qcom_osm_l3_set() */
>  		node->data = (void *)qnodes[i];
>  		icc_node_add(node, provider);
>  
> -		for (j = 0; j < qnodes[i]->num_links; j++)
> -			icc_link_create(node, qnodes[i]->links[j]);
> -
>  		data->nodes[i] = node;
>  	}
>  
> +	/* create links in topolgy */
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		node = data->nodes[i];
> +		for (j = 0; j < qnodes[i]->num_links; j++) {
> +			u16 link_node_id = get_node_id_by_name(qnodes[i]->links[j], desc);

Isn't that O(i^2*j) string comparisons? I don't find that acceptable.

> +
> +			if (link_node_id)
> +				icc_link_create(node, link_node_id);
> +			else
> +				goto err;
> +		}
> +	}
> +
>  	ret = icc_provider_register(provider);
>  	if (ret)
>  		goto err;
> @@ -284,6 +326,7 @@ static const struct of_device_id osm_l3_of_match[] = {
>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },

With the exception of sc8180x, this list is sorted alphabetically.
Please insert your entry where it makes sense.

Regards,
Bjorn

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, osm_l3_of_match);
> -- 
> 2.39.2
> 


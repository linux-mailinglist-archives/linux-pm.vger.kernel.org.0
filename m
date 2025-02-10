Return-Path: <linux-pm+bounces-21670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270E4A2EA3C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EF3168A39
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27701DE3B8;
	Mon, 10 Feb 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezuv+mLV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A71CEACB
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185027; cv=none; b=N9B5yPlReItlIpE2aICEuoin99L0m73tNwWdQG5rCzgE2cWgvXxd8JATPcIJCpCe9BUnG7xcofZF9MPuqGvxF0gpsHU1PN5CxbhmgRphZY1fwJ7PTqjgl2f+6rf6HPMNMDdBXI3JzJywOy9Tu8OKjzqcGu54LlkTte4SEPtlgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185027; c=relaxed/simple;
	bh=iyDDi1r4riFULUgod5wCm2MoIyCOnVwU3km7vkRgHgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPcmC9O7sHe88lj6uKGUIbIWpmHLHZGQhL8v6pDTlU7JDsr5Yr7e26SBnHOk/cPnGlIIuWi6H9UzG6mGYXB+OBnasP4ObALotBbO0A8HYbjmjgnPStkobsiFm7FhjnSHAYXONo2c0LEoS2f/io23PUYoCACo/02I36eOzD7XLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezuv+mLV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5450475df04so1983638e87.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 02:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739185023; x=1739789823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xd+vxcqG1mZGT915T0HX9ILQH/E7rjAK2oLVDx9yII=;
        b=ezuv+mLVh82zeTpiJ3bNiqw5ygj2NriYPftMzParFxgKTi3AdObY3aU7pPKca9vKP3
         KTpH8V/XYhxoLzAgMWjFNZHN6uBfm3mgtkqWay8cebPOzfqcSfE6BHu20G1qDNDThOKM
         Uw1Ao4zOxXT22c22WJm7d9/p3cDVIFSdbc3l8d15KsD8pEBeZxBE0gCuN34Okzs5Ndem
         BGv6hqTkt8cv6lGo2Uro8EjUYuE6fqPHX05UcnlUVvy9aw+pcozq1BQMMzXg2uybBnA8
         fLV3AKjIJYGnTtao8ulr9OvKtdm3hpyB+Hfk8BkcTDnDZiuc3/tiX6A3NZg/friy9wLz
         QBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185023; x=1739789823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xd+vxcqG1mZGT915T0HX9ILQH/E7rjAK2oLVDx9yII=;
        b=kVGSEAIaz7EkmJ0f98GYlav/tq11/HiyXZDeu3nHf5huT+td8LE8seqRsbP3EDKUH6
         EKDAKbQE9SoIAG+w8mw5LgFF/kVSUchRMKO1Hgdli3nzhVs8gt94hxUQkaVIUF7oiBCv
         GIB5FYtuWH84Bhe9gK7pqWa3gFXjCvIpHcn3Tk/74ekJ90sB2M0WqV6eU1F833q7EsE8
         gNtEysX6VfeMUa+z1aQI4c11pHkP3nNN93eJI0db6ocl6YHQ/E6pOo7o8z2xMn0zOkUP
         R79DIm7KI9uPorZnKKF6dxk0xIAWHFtd3FYIoQXQOYEmVyZGhCiRewvNGqCuOGt/W1H7
         n2IA==
X-Forwarded-Encrypted: i=1; AJvYcCW/7CCA3RFcIaJdwWXBZ2zDixBEwa1Koz5CsK7qwaII3HCE4o+38S5jTf2v7x7As+tE94xK8V2MlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAYOAM7P9bAtqojaaDrDpvc9o6AyYFnl50NKeniPg76R2cr9m
	0nl/ICm1usq0U9Iw0zsVxXbUOhmNE8Y6O2PsdgbQCsupTiI53iIixSXzNr8tOxM=
X-Gm-Gg: ASbGncvyeH6KHZqPQqAM40u3AE//3v/4PqKp6jmgjEyy4DkpNK9G56N5UGfI7SW5Ot1
	Zh/CODQPs1q2qIESXXcV5QGCPG6ITRflHULUFNKWMxDJQPvULT0ug41y6qjUu9RCVdATNBhAn9U
	1WeE3lXKDoh7PIrLAk/2664E3BTD0jVGhAbyBiSe0fyU6oZANxH6EjWPc2rE5rAsx7+D07+YPuR
	/B3OcdxFx++WWW6sQN7uCe5fGTTZ1E9glVDOS8na0eurNPbrXKmSnBLko79QNlfoQNw2UMKRFPs
	MIqosums0ZT6FOvdyq5yqrSBz0TYfrqYJTeDsL0PpYCNr23czxdMWWBLZ+iC8dVl4F2XZtE=
X-Google-Smtp-Source: AGHT+IHwDEpaVSkoV9uzP8u1aUI2Q7JyUrXFsxYabhPcKGbqKSc1h4oh6oLKcGACEjWOIjuumC9uOA==
X-Received: by 2002:a05:6512:e89:b0:545:ea9:1a17 with SMTP id 2adb3069b0e04-5450ea91b4amr641356e87.13.1739185022967;
        Mon, 10 Feb 2025 02:57:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450d27e43csm228979e87.214.2025.02.10.02.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:57:01 -0800 (PST)
Date: Mon, 10 Feb 2025 12:57:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 3/7] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <fclfywuw3p43pcj42gi2w5kutvnto3rcrdng2zl2pzgpvz7dis@cjx2e6v4skfm>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205182743.915-4-quic_rlaggysh@quicinc.com>

On Wed, Feb 05, 2025 at 06:27:39PM +0000, Raviteja Laggyshetty wrote:
> EPSS on SA8775P has two instances, necessitating the creation of two
> device nodes with different compatibles due to the unique ICC node ID
> and name limitations in the interconnect framework. Add multidevice
> support for the OSM-L3 provider to dynamically obtain unique node IDs
> and register with the framework.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 46 +++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 6a656ed44d49..da2d82700b5a 100644
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
> @@ -33,6 +34,7 @@
>  #define EPSS_REG_PERF_STATE		0x320
>  
>  #define OSM_L3_MAX_LINKS		1
> +#define ALLOC_DYN_ID			-1

This should be defined by ICC framework.

>  
>  #define to_osm_l3_provider(_provider) \
>  	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
> @@ -55,46 +57,40 @@ struct qcom_osm_l3_icc_provider {
>   */
>  struct qcom_osm_l3_node {
>  	const char *name;
> -	u16 links[OSM_L3_MAX_LINKS];
> -	u16 id;
> +	struct qcom_osm_l3_node *links[OSM_L3_MAX_LINKS];
> +	int id;
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
> +#define DEFINE_QNODE(_name, _buswidth, ...)			\
> +	static struct qcom_osm_l3_node _name = {			\
>  		.name = #_name,						\
> -		.id = _id,						\
>  		.buswidth = _buswidth,					\
>  		.num_links = COUNT_ARGS(__VA_ARGS__),			\
>  		.links = { __VA_ARGS__ },				\
>  	}
>  
> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
> +DEFINE_QNODE(osm_l3_slave, 16);
> +DEFINE_QNODE(osm_l3_master, 16, &osm_l3_slave);
>  
> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>  };
>  
> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
> +DEFINE_QNODE(epss_l3_slave, 32);
> +DEFINE_QNODE(epss_l3_master, 32, &epss_l3_slave);
>  
> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>  };
> @@ -164,7 +160,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  	const struct qcom_osm_l3_desc *desc;
>  	struct icc_onecell_data *data;
>  	struct icc_provider *provider;
> -	const struct qcom_osm_l3_node * const *qnodes;
> +	struct qcom_osm_l3_node * const *qnodes;
>  	struct icc_node *node;
>  	size_t num_nodes;
>  	struct clk *clk;
> @@ -242,6 +238,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  
>  	icc_provider_init(provider);
>  
> +	/*Initialize IDs to ALLOC_DYN_ID to indicate dynamic id allocation*/
> +	for (i = 0; i < num_nodes; i++)
> +		qnodes[i]->id = ALLOC_DYN_ID;

This can be initialized statically.

> +
>  	for (i = 0; i < num_nodes; i++) {
>  		size_t j;
>  
> @@ -250,14 +250,19 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  			ret = PTR_ERR(node);
>  			goto err;
>  		}
> +		qnodes[i]->id = node->id;

Should not be necessary.

>  
>  		node->name = qnodes[i]->name;
>  		/* Cast away const and add it back in qcom_osm_l3_set() */
>  		node->data = (void *)qnodes[i];
>  		icc_node_add(node, provider);
>  
> -		for (j = 0; j < qnodes[i]->num_links; j++)
> -			icc_link_create(node, qnodes[i]->links[j]);
> +		for (j = 0; j < qnodes[i]->num_links; j++) {
> +			struct qcom_osm_l3_node *link_node = qnodes[i]->links[j];
> +
> +			icc_link_create(node, link_node->id);

Please add icc_link_nodes() (or something like that), taking two struct
icc_node instances. Then you can use it here, instead of reading back
the ID. Ideally the 'ID' should become an internal detail which is of no
concern for the ICC drivers.

> +			link_node->id = (node->links[node->num_links - 1])->id;
> +		}
>  
>  		data->nodes[i] = node;
>  	}
> @@ -278,6 +283,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  static const struct of_device_id osm_l3_of_match[] = {
>  	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
>  	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
>  	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
>  	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
>  	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry


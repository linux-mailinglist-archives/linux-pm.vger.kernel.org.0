Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4CD3D63BA
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 18:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhGZPu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhGZPuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 11:50:50 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8FC061760
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 09:31:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso10543511otq.6
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ELn3EZuGEDiUnXCf8ikGoXvGmOXoCSOD6xENG4y2dZc=;
        b=mLFUP1duMTTy4DG4OMhqACwUxu+RIWClqRuK7xYBkcYtaLHr8EY4H1AonGIuzMNTEY
         HpchzDZLCEvIGHzSj6Ak/m7yupq4yFJp4j4C/Sj6BLC9Iu2OgFt+lWSPs82auAVCodpn
         VteFZOdc54EpKWkUrmmhkdwSeZr9DZPqLZgjnhShyv1hgFpk+S7bMZadaZMhn3h6rcCp
         Ki0z8sL/3744fVDgGzUVUhKrZFlyjmctLJKnM6t+KuKxxJtkg8ZBHM19cZEVYTvn/VZp
         N+hvPANPEO7yZucR9/UInv+o2ODStNYb/g7cRLtRFV//Vk7GIwxZTGadkD/FCiZacuXG
         7XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ELn3EZuGEDiUnXCf8ikGoXvGmOXoCSOD6xENG4y2dZc=;
        b=AsU9H+g8p4DGDbrWug+U14HcUy1RWkpcCPcQTQtjCDDZB+Hzs6SIi8DSBQRLScOO42
         rCHfXI+HM9d5L26jUAftFoxhTq0TRu5jnInEk546PyVonyCetpqyYp7S4j2570iLWKu7
         x1+gGPtvLAsMc+bfionEzelgdlU4GNhznF23VVw7S/j3RFrd9oEZu9N0wKk8+GAX6Kcn
         8VYcZjKeXOZ9TVebzaMTNUzeErC/9C6POP156Iu5DidK1Cb3pR8tYj31gtWMa2Y6PLLr
         jzWYRhfTiQMvulYan2PL+JSjBANQ52tv0zSf3nr4/UZQhYvf4WJVJs+tXgM8RnqBU96p
         8Ctg==
X-Gm-Message-State: AOAM533r0JJyJMxuSTOiv5mz/jF89FBskd0PDXopd9Jf6S8kkTVKCQNI
        v1LyeL+kTMh9hjMC6tKmFDW+rw==
X-Google-Smtp-Source: ABdhPJy83AcBPucMpzQYRsSrydOAihpe1OB7cUkgFC7TGoS4sBFvRhxCloB9X/H8DDp4bA1tDkK6oA==
X-Received: by 2002:a9d:3608:: with SMTP id w8mr12747099otb.371.1627317075990;
        Mon, 26 Jul 2021 09:31:15 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id bc42sm45162oob.39.2021.07.26.09.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:31:15 -0700 (PDT)
Subject: Re: [PATCH] interconnect: qcom: osm-l3: Use driver-specific naming
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210725031414.3961227-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <5148d281-d5d9-7731-f30a-090af8cd2ea2@kali.org>
Date:   Mon, 26 Jul 2021 11:31:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210725031414.3961227-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/24/21 10:14 PM, Bjorn Andersson wrote:
> In situations were the developer screws up by e.g. not giving the OSM
> nodes unique identifiers the interconnect framework might mix up nodes
> between the OSM L3 provider and e.g. the RPMh provider.
>
> The resulting callstack containts "qcom_icc_set", which is not unique to
> the OSM L3 provider driver. Once the faulting qcom_icc_set() is
> identified it's further confusing that "qcom_icc_node" is different
> between the different drivers.
>
> To avoid this confusion, rename the node struct and the setter in the
> OSM L3 driver to include "osm_l3" in their names.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> This was written after the sc8180x patch and as such applies ontop of:
> https://lore.kernel.org/linux-arm-msm/20210725025834.3941777-2-bjorn.andersson@linaro.org/
>
>  drivers/interconnect/qcom/osm-l3.c | 46 +++++++++++++++---------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 13e41b932567..c7af143980de 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -38,7 +38,7 @@
>  
>  #define OSM_L3_MAX_LINKS		1
>  
> -#define to_qcom_provider(_provider) \
> +#define to_osm_l3_provider(_provider) \
>  	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>  
>  struct qcom_osm_l3_icc_provider {
> @@ -50,14 +50,14 @@ struct qcom_osm_l3_icc_provider {
>  };
>  
>  /**
> - * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * struct qcom_osm_l3_node - Qualcomm specific interconnect nodes
>   * @name: the node name used in debugfs
>   * @links: an array of nodes where we can go next while traversing
>   * @id: a unique node identifier
>   * @num_links: the total number of @links
>   * @buswidth: width of the interconnect between a node and the bus
>   */
> -struct qcom_icc_node {
> +struct qcom_osm_l3_node {
>  	const char *name;
>  	u16 links[OSM_L3_MAX_LINKS];
>  	u16 id;
> @@ -65,8 +65,8 @@ struct qcom_icc_node {
>  	u16 buswidth;
>  };
>  
> -struct qcom_icc_desc {
> -	const struct qcom_icc_node **nodes;
> +struct qcom_osm_l3_desc {
> +	const struct qcom_osm_l3_node **nodes;
>  	size_t num_nodes;
>  	unsigned int lut_row_size;
>  	unsigned int reg_freq_lut;
> @@ -74,7 +74,7 @@ struct qcom_icc_desc {
>  };
>  
>  #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
> -	static const struct qcom_icc_node _name = {			\
> +	static const struct qcom_osm_l3_node _name = {			\
>  		.name = #_name,						\
>  		.id = _id,						\
>  		.buswidth = _buswidth,					\
> @@ -85,12 +85,12 @@ struct qcom_icc_desc {
>  DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
>  DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
>  
> -static const struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
> +static const struct qcom_osm_l3_node *sdm845_osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
>  	[SLAVE_OSM_L3] = &sdm845_osm_l3,
>  };
>  
> -static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
> +static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
>  	.nodes = sdm845_osm_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
>  	.lut_row_size = OSM_LUT_ROW_SIZE,
> @@ -101,12 +101,12 @@ static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
>  DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
>  DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
>  
> -static const struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
> +static const struct qcom_osm_l3_node *sc7180_osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
>  	[SLAVE_OSM_L3] = &sc7180_osm_l3,
>  };
>  
> -static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
> +static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
>  	.nodes = sc7180_osm_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
>  	.lut_row_size = OSM_LUT_ROW_SIZE,
> @@ -117,12 +117,12 @@ static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
>  DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
>  DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
>  
> -static const struct qcom_icc_node *sc8180x_osm_l3_nodes[] = {
> +static const struct qcom_osm_l3_node *sc8180x_osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &sc8180x_osm_apps_l3,
>  	[SLAVE_OSM_L3] = &sc8180x_osm_l3,
>  };
>  
> -static const struct qcom_icc_desc sc8180x_icc_osm_l3 = {
> +static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
>  	.nodes = sc8180x_osm_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(sc8180x_osm_l3_nodes),
>  	.lut_row_size = OSM_LUT_ROW_SIZE,
> @@ -133,12 +133,12 @@ static const struct qcom_icc_desc sc8180x_icc_osm_l3 = {
>  DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
>  DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
>  
> -static const struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
> +static const struct qcom_osm_l3_node *sm8150_osm_l3_nodes[] = {
>  	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
>  	[SLAVE_OSM_L3] = &sm8150_osm_l3,
>  };
>  
> -static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
> +static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
>  	.nodes = sm8150_osm_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(sm8150_osm_l3_nodes),
>  	.lut_row_size = OSM_LUT_ROW_SIZE,
> @@ -149,12 +149,12 @@ static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
>  DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
>  DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
>  
> -static const struct qcom_icc_node *sm8250_epss_l3_nodes[] = {
> +static const struct qcom_osm_l3_node *sm8250_epss_l3_nodes[] = {
>  	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
>  	[SLAVE_EPSS_L3_SHARED] = &sm8250_epss_l3,
>  };
>  
> -static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
> +static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
>  	.nodes = sm8250_epss_l3_nodes,
>  	.num_nodes = ARRAY_SIZE(sm8250_epss_l3_nodes),
>  	.lut_row_size = EPSS_LUT_ROW_SIZE,
> @@ -162,11 +162,11 @@ static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
>  	.reg_perf_state = EPSS_REG_PERF_STATE,
>  };
>  
> -static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
>  {
>  	struct qcom_osm_l3_icc_provider *qp;
>  	struct icc_provider *provider;
> -	const struct qcom_icc_node *qn;
> +	const struct qcom_osm_l3_node *qn;
>  	struct icc_node *n;
>  	unsigned int index;
>  	u32 agg_peak = 0;
> @@ -175,7 +175,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  
>  	qn = src->data;
>  	provider = src->provider;
> -	qp = to_qcom_provider(provider);
> +	qp = to_osm_l3_provider(provider);
>  
>  	list_for_each_entry(n, &provider->nodes, node_list)
>  		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> @@ -208,10 +208,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  	u32 info, src, lval, i, prev_freq = 0, freq;
>  	static unsigned long hw_rate, xo_rate;
>  	struct qcom_osm_l3_icc_provider *qp;
> -	const struct qcom_icc_desc *desc;
> +	const struct qcom_osm_l3_desc *desc;
>  	struct icc_onecell_data *data;
>  	struct icc_provider *provider;
> -	const struct qcom_icc_node **qnodes;
> +	const struct qcom_osm_l3_node **qnodes;
>  	struct icc_node *node;
>  	size_t num_nodes;
>  	struct clk *clk;
> @@ -281,7 +281,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  
>  	provider = &qp->provider;
>  	provider->dev = &pdev->dev;
> -	provider->set = qcom_icc_set;
> +	provider->set = qcom_osm_l3_set;
>  	provider->aggregate = icc_std_aggregate;
>  	provider->xlate = of_icc_xlate_onecell;
>  	INIT_LIST_HEAD(&provider->nodes);
> @@ -303,7 +303,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>  		}
>  
>  		node->name = qnodes[i]->name;
> -		/* Cast away const and add it back in qcom_icc_set() */
> +		/* Cast away const and add it back in qcom_osm_l3_set() */
>  		node->data = (void *)qnodes[i];
>  		icc_node_add(node, provider);
>  

Hi Bjorn,

Tested on both C630 and Flex 5G


Tested-by: Steev Klimaszewski <steev@kali.org>

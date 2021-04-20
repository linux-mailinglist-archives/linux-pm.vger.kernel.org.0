Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17D73653C3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhDTILw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhDTILu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 04:11:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95DC06138C
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 01:11:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so7312352wmi.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 01:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aOgsxsyFkixaOEX4Ox5Or9kKZNDyZdWkucXEJ1ql0+o=;
        b=a8bPGXcPIvg448ZNoLAgeZPKTkqmVeqEEmJQ9/hC6hTvZZIq2Hc9kuVGY27Uq9VWFh
         98sw+D7bme/H+7IftmI+TSeP3JHQ72LiP2rY2HnjEySmdyVaR0MtPFoFVhWUEl8DEfK7
         DmHmWwAxDhrGIfQkS4ryhQEg1WFdMLjqGvb3KVNPClvLqGYW7C9LF/E3pPIdcCfHT9m8
         Yqb3m5pM9bMJHFj53vqpc7Mkrfgg+x4jfg8O8g+wntIdcrs0NpudEv1//qACKLC5V8BV
         ecQDFblwklsyYrirN4vFuFne/msnNgtWXQ8nMz+ioUIixXMKB2jEzGDSlvdo9+WO4HXS
         8Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aOgsxsyFkixaOEX4Ox5Or9kKZNDyZdWkucXEJ1ql0+o=;
        b=O8X8apqOYAtVt8ZHM5WOs4zQo54Im2rq6qlaNSRXNXjWo0r128P5Pec77pM/MajVM5
         FXEGZ7bzmb8nqMPKPBqUaJHBg/J9ae8li33i97u480YjBLYsGIlOJocKU0v+ALQ5w5UK
         4np74zEhegM7AeEA6IiEcyb+ChQqMzfVeIm85TJugJodzLi96oSP+TFkeGTOISc3XIrM
         ONDAPW6eRuoG1zIzsKm+ZCjAEcvjwB38EmI1NtQXr9jCNuFZ2K0SE+9vZSL+WFEQDho6
         A7vjj87/CFoGxh9aXZMMXArcmHRytR0AJwIfzS8IK/7NxEKJI4RlZpVBPbXY3mpX96OV
         rNKQ==
X-Gm-Message-State: AOAM533HDUirRVzFIXVGoq+InjCqItY6/rZNaRmZlpL0pBqfwJF15P5E
        8zgf4dNFfQf/RQDV+OglKXv9o7QH4CNQhA==
X-Google-Smtp-Source: ABdhPJzPdAc/n37zRPsv5fH0kCLXe32AuerB0HH0gRpic7zt91WdCVK+qchJhy5nXDIVkFExCIV8SA==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr3196252wmj.100.1618906275445;
        Tue, 20 Apr 2021 01:11:15 -0700 (PDT)
Received: from MacBook-Pro.local ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 66sm2756529wmb.36.2021.04.20.01.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 01:11:14 -0700 (PDT)
Subject: Re: [2/3] interconnect: qcom: Add EPSS L3 support on SC7280
To:     Odelu Kukatla <okukatla@codeaurora.org>,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        sibis@codeaurora.org, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1618556290-28303-1-git-send-email-okukatla@codeaurora.org>
 <1618556290-28303-3-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <3a4460f3-3416-16f0-8e21-45e8b7a3a0ad@linaro.org>
Date:   Tue, 20 Apr 2021 11:11:13 +0300
MIME-Version: 1.0
In-Reply-To: <1618556290-28303-3-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

On 16.04.21 9:58, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> SC7280 SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>   drivers/interconnect/qcom/osm-l3.c             | 124 +++++++++++++++++++------
>   drivers/interconnect/qcom/sc7280.h             |  10 ++
>   include/dt-bindings/interconnect/qcom,osm-l3.h |  10 +-
>   3 files changed, 114 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 695f287..3403e09 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -15,6 +15,7 @@
>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>   
>   #include "sc7180.h"
> +#include "sc7280.h"
>   #include "sdm845.h"
>   #include "sm8150.h"
>   #include "sm8250.h"
> @@ -32,17 +33,24 @@
>   
>   /* EPSS Register offsets */
>   #define EPSS_LUT_ROW_SIZE		4
> +#define EPSS_REG_L3_VOTE		0x90
>   #define EPSS_REG_FREQ_LUT		0x100
>   #define EPSS_REG_PERF_STATE		0x320
> +#define EPSS_CORE_OFFSET		0x4
> +#define EPSS_L3_VOTE_REG(base, cpu)\
> +			((base + EPSS_REG_L3_VOTE) +\
> +			(cpu * EPSS_CORE_OFFSET))

Nit: Please add parenthesis around "base" and "cpu" to avoid
any potential precedence issues.

>   
> -#define OSM_L3_MAX_LINKS		1
> +#define L3_DOMAIN_CNT		4
> +#define L3_MAX_LINKS		9
>   
>   #define to_qcom_provider(_provider) \
>   	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>   
>   struct qcom_osm_l3_icc_provider {
> -	void __iomem *base;
> +	void __iomem *domain_base[L3_DOMAIN_CNT];
>   	unsigned int max_state;
> +	bool per_core_dcvs;
>   	unsigned int reg_perf_state;
>   	unsigned long lut_tables[LUT_MAX_ENTRIES];
>   	struct icc_provider provider;
> @@ -58,31 +66,36 @@ struct qcom_osm_l3_icc_provider {
>    */
>   struct qcom_icc_node {
>   	const char *name;
> -	u16 links[OSM_L3_MAX_LINKS];
> +	u16 links[L3_MAX_LINKS];
>   	u16 id;
>   	u16 num_links;
>   	u16 buswidth;
> +	u16 domain;
> +	int cpu;

Please describe these in the kerneldoc. Adding a kerneldoc for
qcom_osm_l3_icc_provider would be also nice.

>   };
>   
>   struct qcom_icc_desc {
>   	const struct qcom_icc_node **nodes;
>   	size_t num_nodes;
> +	bool per_core_dcvs;
>   	unsigned int lut_row_size;
>   	unsigned int reg_freq_lut;
>   	unsigned int reg_perf_state;
>   };
>   
> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
> -	static const struct qcom_icc_node _name = {			\
> -		.name = #_name,						\
> -		.id = _id,						\
> -		.buswidth = _buswidth,					\
> -		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
> -		.links = { __VA_ARGS__ },				\
> +#define DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, ...)			\
> +	static const struct qcom_icc_node _name = {				\
> +		.name = #_name,							\
> +		.id = _id,							\
> +		.buswidth = _buswidth,						\
> +		.domain = _domain,						\
> +		.cpu = _cpu,						\
> +		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),		\
> +		.links = { __VA_ARGS__ },					\
>   	}
>   
> -DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
> -DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
> +DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, 0, 0, SDM845_SLAVE_OSM_L3);
> +DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16, 0, 0);
>   
>   static const struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
>   	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
> @@ -97,8 +110,8 @@ static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
> -DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
> +DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, 0, 0, SC7180_SLAVE_OSM_L3);
> +DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16, 0, 0);
>   
>   static const struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
>   	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
> @@ -113,8 +126,8 @@ static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
> -DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
> +DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, 0, 0, SM8150_SLAVE_OSM_L3);
> +DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32, 0, 0);
>   
>   static const struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
>   	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
> @@ -129,8 +142,8 @@ static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
>   	.reg_perf_state = OSM_REG_PERF_STATE,
>   };
>   
> -DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
> -DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
> +DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, 0, 0, SM8250_SLAVE_EPSS_L3);
> +DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32, 0, 0);
>   
>   static const struct qcom_icc_node *sm8250_epss_l3_nodes[] = {
>   	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
> @@ -145,6 +158,39 @@ static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
>   	.reg_perf_state = EPSS_REG_PERF_STATE,
>   };
>   
> +DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, 0, 0, SC7280_SLAVE_EPSS_L3_SHARED, SC7280_SLAVE_EPSS_L3_CPU0, SC7280_SLAVE_EPSS_L3_CPU1, SC7280_SLAVE_EPSS_L3_CPU2, SC7280_SLAVE_EPSS_L3_CPU3, SC7280_SLAVE_EPSS_L3_CPU4, SC7280_SLAVE_EPSS_L3_CPU5, SC7280_SLAVE_EPSS_L3_CPU6, SC7280_SLAVE_EPSS_L3_CPU7);
> +DEFINE_QNODE(sc7280_epss_l3_shared, SC7280_SLAVE_EPSS_L3_SHARED, 32, 0, 0);
> +DEFINE_QNODE(sc7280_epss_l3_cpu0, SC7280_SLAVE_EPSS_L3_CPU0, 32, 1, 0);
> +DEFINE_QNODE(sc7280_epss_l3_cpu1, SC7280_SLAVE_EPSS_L3_CPU1, 32, 1, 1);
> +DEFINE_QNODE(sc7280_epss_l3_cpu2, SC7280_SLAVE_EPSS_L3_CPU2, 32, 1, 2);
> +DEFINE_QNODE(sc7280_epss_l3_cpu3, SC7280_SLAVE_EPSS_L3_CPU3, 32, 1, 3);
> +DEFINE_QNODE(sc7280_epss_l3_cpu4, SC7280_SLAVE_EPSS_L3_CPU4, 32, 2, 0);
> +DEFINE_QNODE(sc7280_epss_l3_cpu5, SC7280_SLAVE_EPSS_L3_CPU5, 32, 2, 1);
> +DEFINE_QNODE(sc7280_epss_l3_cpu6, SC7280_SLAVE_EPSS_L3_CPU6, 32, 2, 2);
> +DEFINE_QNODE(sc7280_epss_l3_cpu7, SC7280_SLAVE_EPSS_L3_CPU7, 32, 3, 0);
> +
> +static const struct qcom_icc_node *sc7280_epss_l3_nodes[] = {
> +	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
> +	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3_shared,
> +	[SLAVE_EPSS_L3_CPU0] = &sc7280_epss_l3_cpu0,
> +	[SLAVE_EPSS_L3_CPU1] = &sc7280_epss_l3_cpu1,
> +	[SLAVE_EPSS_L3_CPU2] = &sc7280_epss_l3_cpu2,
> +	[SLAVE_EPSS_L3_CPU3] = &sc7280_epss_l3_cpu3,
> +	[SLAVE_EPSS_L3_CPU4] = &sc7280_epss_l3_cpu4,
> +	[SLAVE_EPSS_L3_CPU5] = &sc7280_epss_l3_cpu5,
> +	[SLAVE_EPSS_L3_CPU6] = &sc7280_epss_l3_cpu6,
> +	[SLAVE_EPSS_L3_CPU7] = &sc7280_epss_l3_cpu7,
> +};
> +
> +static const struct qcom_icc_desc sc7280_icc_epss_l3 = {
> +	.nodes = sc7280_epss_l3_nodes,
> +	.num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
> +	.per_core_dcvs = true,
> +	.lut_row_size = EPSS_LUT_ROW_SIZE,
> +	.reg_freq_lut = EPSS_REG_FREQ_LUT,
> +	.reg_perf_state = EPSS_REG_PERF_STATE,
> +};
> +
>   static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   {
>   	struct qcom_osm_l3_icc_provider *qp;
> @@ -156,13 +202,18 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   	u32 agg_avg = 0;
>   	u64 rate;
>   
> -	qn = src->data;
> +	qn = dst->data;
>   	provider = src->provider;

dst->provider? To keep it symmetric maybe? I am expecting that src
and dst are the same provider?

>   	qp = to_qcom_provider(provider);
>   
> -	list_for_each_entry(n, &provider->nodes, node_list)
> -		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> -				    &agg_avg, &agg_peak);
> +	/* Skip aggregation when per core l3 scaling is enabled */
> +	if (qp->per_core_dcvs) {
> +		agg_peak = dst->peak_bw;
> +	} else {
> +		list_for_each_entry(n, &provider->nodes, node_list)
> +			provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> +						&agg_avg, &agg_peak);
> +	}
>   
>   	rate = max(agg_avg, agg_peak);
>   	rate = icc_units_to_bps(rate);
> @@ -173,7 +224,10 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   			break;
>   	}
>   
> -	writel_relaxed(index, qp->base + qp->reg_perf_state);
> +	if (qp->per_core_dcvs)
> +		writel_relaxed(index, EPSS_L3_VOTE_REG(qp->domain_base[qn->domain], qn->cpu));
> +	else
> +		writel_relaxed(index, qp->domain_base[qn->domain] + qp->reg_perf_state);
>   
>   	return 0;
>   }
> @@ -194,11 +248,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   	const struct qcom_icc_desc *desc;
>   	struct icc_onecell_data *data;
>   	struct icc_provider *provider;
> +	struct property *prop;
>   	const struct qcom_icc_node **qnodes;
>   	struct icc_node *node;
>   	size_t num_nodes;
>   	struct clk *clk;
> -	int ret;
> +	int ret, index, domain_count;
>   
>   	clk = clk_get(&pdev->dev, "xo");
>   	if (IS_ERR(clk))
> @@ -218,12 +273,21 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   	if (!qp)
>   		return -ENOMEM;
>   
> -	qp->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(qp->base))
> -		return PTR_ERR(qp->base);
> +	prop = of_find_property(pdev->dev.of_node, "reg", NULL);
> +	if (!prop)
> +		return -EINVAL;
> +	domain_count = prop->length / (4 * sizeof(prop->length));
> +	if(!domain_count)

Please add a space before opening the parenthesis.

> +		return -EINVAL;
> +
> +	for (index = 0; index < domain_count ; index++) {
> +		qp->domain_base[index] = devm_platform_ioremap_resource(pdev, index);
> +		if (IS_ERR(qp->domain_base[index]))
> +			return PTR_ERR(qp->domain_base[index]);
> +	}
>   
>   	/* HW should be in enabled state to proceed */
> -	if (!(readl_relaxed(qp->base + REG_ENABLE) & 0x1)) {
> +	if (!(readl_relaxed(qp->domain_base[0] + REG_ENABLE) & 0x1)) {
>   		dev_err(&pdev->dev, "error hardware not enabled\n");
>   		return -ENODEV;
>   	}
> @@ -235,7 +299,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   	qp->reg_perf_state = desc->reg_perf_state;
>   
>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> -		info = readl_relaxed(qp->base + desc->reg_freq_lut +
> +		info = readl_relaxed(qp->domain_base[0] + desc->reg_freq_lut +
>   				     i * desc->lut_row_size);
>   		src = FIELD_GET(LUT_SRC, info);
>   		lval = FIELD_GET(LUT_L_VAL, info);
> @@ -254,6 +318,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   		prev_freq = freq;
>   	}
>   	qp->max_state = i;
> +	qp->per_core_dcvs = desc->per_core_dcvs;
>   
>   	qnodes = desc->nodes;
>   	num_nodes = desc->num_nodes;
> @@ -309,6 +374,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   
>   static const struct of_device_id osm_l3_of_match[] = {
>   	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
> +	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
>   	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
>   	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
>   	{ .compatible = "qcom,sm8250-epss-l3", .data = &sm8250_icc_epss_l3 },
> diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
> index 66ac6ee..6d323ba 100644
> --- a/drivers/interconnect/qcom/sc7280.h
> +++ b/drivers/interconnect/qcom/sc7280.h
> @@ -148,5 +148,15 @@
>   #define SC7280_SLAVE_PCIE_1			137
>   #define SC7280_SLAVE_QDSS_STM			138
>   #define SC7280_SLAVE_TCU			139
> +#define SC7280_MASTER_EPSS_L3_APPS			140
> +#define SC7280_SLAVE_EPSS_L3_SHARED			141
> +#define SC7280_SLAVE_EPSS_L3_CPU0			142
> +#define SC7280_SLAVE_EPSS_L3_CPU1			143
> +#define SC7280_SLAVE_EPSS_L3_CPU2			144
> +#define SC7280_SLAVE_EPSS_L3_CPU3			145
> +#define SC7280_SLAVE_EPSS_L3_CPU4			146
> +#define SC7280_SLAVE_EPSS_L3_CPU5			147
> +#define SC7280_SLAVE_EPSS_L3_CPU6			148
> +#define SC7280_SLAVE_EPSS_L3_CPU7			149
>   
>   #endif
> diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bindings/interconnect/qcom,osm-l3.h
> index 61ef649..99534a5 100644
> --- a/include/dt-bindings/interconnect/qcom,osm-l3.h
> +++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (C) 2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2019, 2021 The Linux Foundation. All rights reserved.
>    */
>   
>   #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
> @@ -11,5 +11,13 @@
>   
>   #define MASTER_EPSS_L3_APPS	0
>   #define SLAVE_EPSS_L3_SHARED	1
> +#define SLAVE_EPSS_L3_CPU0	2
> +#define SLAVE_EPSS_L3_CPU1	3
> +#define SLAVE_EPSS_L3_CPU2	4
> +#define SLAVE_EPSS_L3_CPU3	5
> +#define SLAVE_EPSS_L3_CPU4	6
> +#define SLAVE_EPSS_L3_CPU5	7
> +#define SLAVE_EPSS_L3_CPU6	8
> +#define SLAVE_EPSS_L3_CPU7	9

This hunk should be part of the dt-bindings patch.

Thanks,
Georgi

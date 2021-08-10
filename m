Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337393E5A53
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhHJMqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbhHJMqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 08:46:38 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81040C061798
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 05:46:16 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u7so274946ilk.7
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZKt7SArs/iNOcmhmux0PvAgC04ew3//VWO8NyWkdDl0=;
        b=GuFEzky/GCD0hN1Tan0ujZfCcWVxPMx65fy2SXCvekCM/+ERb8iC6Ti6VGGEDPjr8Q
         rZ2LgjbAN1TJrG9ePSgAEfqUh5y7bwlkeXhrhIrVBljsob4si7oYfwquMHvlMPuWAb9w
         bqm5ocWoG5hbwk2QOlNujyj77qiU/MGwBcOB/oGg2GTw42iAsbcETi/EwDBxMkHmDG7f
         FIexoBnmasMUPocfzKBgXMOqUW+soheUDgKCa+PCeAvlzEYqzUhCOCc4Tj5+FrAqB6pO
         QFbGvyI9SKhJSkltZ8DUdEyno7dhYB+BEv1xet5b6HNjy/xDgiD9alVbTWP9Lz46t3Ip
         TafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKt7SArs/iNOcmhmux0PvAgC04ew3//VWO8NyWkdDl0=;
        b=V2D+AxM8qdlZMmyh7MQk9EdFg3kngbK596snpePkZlTHPTqvlgtrjobkJaEq9TA5fd
         xhTXnHOiyZvi35U0dkoblkpldcoO8W3tvqxSFJjevwNd2Dg5YBM7wqmcQFngIAkYV1LC
         22WZQL6v9Rrvpjdt9msBEry7WgMqGhl3Azu/7yxDp1sbrz/v/Ooaxl0aOFpoj1vYbC/k
         SUlwzb266DqIPFZ2g+I0a9t6s5ehJb37XS/HR+80Bb6soNt9gxh/KAWPgK8Oee/V3zJ0
         g8OjOwcPZ0FqDVZzL1Ip3pLyqMr9/R+q+XPelbniOnktV7AzYiDWmkmFG7Lzy5gSQlhB
         pPAQ==
X-Gm-Message-State: AOAM533AqB8mCPedjv2V9TLlZVo5/xAC2a8c4NXAVUIF6H7RLKo8smR1
        sTibODSj9/O9pAx9QFL81KX31A==
X-Google-Smtp-Source: ABdhPJxnaVo8I1vb2eZhb04YoumJhrALjIqn2a8inaOnRQBJhWntxYqNa6v1sUVvoj2phheL7xdjhg==
X-Received: by 2002:a92:a30a:: with SMTP id a10mr7883ili.219.1628599575923;
        Tue, 10 Aug 2021 05:46:15 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id s16sm3992750iln.5.2021.08.10.05.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 05:46:15 -0700 (PDT)
Subject: Re: [v6 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
To:     Odelu Kukatla <okukatla@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com,
        linux-arm-msm-owner@vger.kernel.org
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-3-git-send-email-okukatla@codeaurora.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <8c046ac4-27c8-d858-941b-80f1509dbb61@linaro.org>
Date:   Tue, 10 Aug 2021 07:46:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628577962-3995-3-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/10/21 1:46 AM, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> SC7280 SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>

I don't have much to say about what this is doing but I
have a few suggestions.

					-Alex

> ---
>   drivers/interconnect/qcom/osm-l3.c | 136 +++++++++++++++++++++++++++++++------
>   drivers/interconnect/qcom/sc7280.h |  10 +++
>   2 files changed, 125 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index c7af143..3b16e73 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -9,12 +9,14 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   
>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>   
>   #include "sc7180.h"
> +#include "sc7280.h"
>   #include "sc8180x.h"
>   #include "sdm845.h"
>   #include "sm8150.h"
> @@ -33,17 +35,33 @@
>   
>   /* EPSS Register offsets */
>   #define EPSS_LUT_ROW_SIZE		4
> +#define EPSS_REG_L3_VOTE		0x90
>   #define EPSS_REG_FREQ_LUT		0x100
>   #define EPSS_REG_PERF_STATE		0x320
> +#define EPSS_CORE_OFFSET		0x4
> +#define EPSS_L3_VOTE_REG(base, cpu)\
> +			(((base) + EPSS_REG_L3_VOTE) +\
> +			((cpu) * EPSS_CORE_OFFSET))
>   
> -#define OSM_L3_MAX_LINKS		1
> +#define L3_DOMAIN_CNT		4
> +#define L3_MAX_LINKS		9

It may not matter much, but if you specified the
qcom_osm_l3_node->links[] field as the last field
in the structure, I think it could be a flexible
array and you wouldn't have to specify the maximum
number of links.  (You are already using the actual
array size to set ->num_links in __DEFINE_QNODE().)

>   #define to_osm_l3_provider(_provider) \
>   	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>   
> +/**
> + * @domain_base: an array of base address for each clock domain
> + * @max_state: max supported frequency level
> + * @per_core_dcvs: flag used to indicate whether the frequency scaling
> + * for each core is enabled
> + * @reg_perf_state: requested frequency level
> + * @lut_tables: an array of supported frequency levels
> + * @provider: interconnect provider of this node
> + */

Run this to check your kernel doc validity:
     scripts/kernel-doc -none <file> [<file>...]

>   struct qcom_osm_l3_icc_provider {
> -	void __iomem *base;
> +	void __iomem *domain_base[L3_DOMAIN_CNT];
>   	unsigned int max_state;
> +	bool per_core_dcvs;
>   	unsigned int reg_perf_state;
>   	unsigned long lut_tables[LUT_MAX_ENTRIES];
>   	struct icc_provider provider;

. . .

> @@ -235,12 +322,17 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   	if (!qp)
>   		return -ENOMEM;
>   
> -	qp->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(qp->base))
> -		return PTR_ERR(qp->base);
> +	while (of_get_address(pdev->dev.of_node, i++, NULL, NULL))
> +		nr_domain_bases++;

Maybe you could combine these two loops by counting as you go.
I.e.:

     i = 0;
     while (true) {
	void __iomem *base;

	if (of_get_address(pdev->dev.of_node, i, NULL, NULL))
		break;
	base = devm_platform_ioremap_resource(pdev, i);
	if (IS_ERR(base))
	    return PTR_ERR(base);
	qp->domain_base[i++] = base
     }
     nr_domain_bases = i;

> +
> +	for (i = 0; i < nr_domain_bases ; i++) {
> +		qp->domain_base[i] = devm_platform_ioremap_resource(pdev, i);
> +		if (IS_ERR(qp->domain_base[i]))
> +			return PTR_ERR(qp->domain_base[i]);
> +	}
>   
>   	/* HW should be in enabled state to proceed */
> -	if (!(readl_relaxed(qp->base + REG_ENABLE) & 0x1)) {
> +	if (!(readl_relaxed(qp->domain_base[0] + REG_ENABLE) & 0x1)) {
>   		dev_err(&pdev->dev, "error hardware not enabled\n");
>   		return -ENODEV;
>   	}
> @@ -252,7 +344,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   	qp->reg_perf_state = desc->reg_perf_state;
>   
>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> -		info = readl_relaxed(qp->base + desc->reg_freq_lut +
> +		info = readl_relaxed(qp->domain_base[0] + desc->reg_freq_lut +
>   				     i * desc->lut_row_size);

Maybe you could define a macro to encapsulate computing this
register offset, along the lines of EPSS_L3_VOTE_REG().  (Here
and elsewhere.)

>   		src = FIELD_GET(LUT_SRC, info);
>   		lval = FIELD_GET(LUT_L_VAL, info);
> @@ -271,6 +363,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   		prev_freq = freq;
>   	}
>   	qp->max_state = i;
> +	qp->per_core_dcvs = desc->per_core_dcvs;
>   
>   	qnodes = desc->nodes;
>   	num_nodes = desc->num_nodes;
> @@ -326,6 +419,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   
>   static const struct of_device_id osm_l3_of_match[] = {
>   	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
> +	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
>   	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
>   	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
>   	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 },
> diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
> index 175e400..5df7600 100644
> --- a/drivers/interconnect/qcom/sc7280.h
> +++ b/drivers/interconnect/qcom/sc7280.h
> @@ -150,5 +150,15 @@
>   #define SC7280_SLAVE_PCIE_1			139
>   #define SC7280_SLAVE_QDSS_STM			140
>   #define SC7280_SLAVE_TCU			141
> +#define SC7280_MASTER_EPSS_L3_APPS			142
> +#define SC7280_SLAVE_EPSS_L3_SHARED			143
> +#define SC7280_SLAVE_EPSS_L3_CPU0			144
> +#define SC7280_SLAVE_EPSS_L3_CPU1			145
> +#define SC7280_SLAVE_EPSS_L3_CPU2			146
> +#define SC7280_SLAVE_EPSS_L3_CPU3			147
> +#define SC7280_SLAVE_EPSS_L3_CPU4			148
> +#define SC7280_SLAVE_EPSS_L3_CPU5			149
> +#define SC7280_SLAVE_EPSS_L3_CPU6			150
> +#define SC7280_SLAVE_EPSS_L3_CPU7			151
>   
>   #endif
> 


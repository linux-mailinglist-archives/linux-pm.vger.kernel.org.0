Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CC3EDC86
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHPRnp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 13:43:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37930 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhHPRno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 13:43:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629135792; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=INjVMyWHHGhC425iiHp5zLCGy+F03/1Rk5zPlKmyR6A=;
 b=F0ZB3H2HAasKiSflSQLoInCqZEmqz6Ld/ECW0tSN3ZqBi/lHAf19rw0ND+LRhlG5VUFjuoHd
 +DExZF+E2oB5oPL/7o3vdZnBP1VraFZoTioVJm4wZ8Vq7j7t51f2xvzmGWQaCO7D5E+lM6CV
 bwxBBlV+rJfT2TdTvtIxKc+FeLo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 611aa3ab9507ca1a342e8597 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Aug 2021 17:43:07
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3B4FC43617; Mon, 16 Aug 2021 17:43:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9860FC4338F;
        Mon, 16 Aug 2021 17:43:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Aug 2021 23:13:05 +0530
From:   okukatla@codeaurora.org
To:     Alex Elder <elder@linaro.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [v6 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
In-Reply-To: <8c046ac4-27c8-d858-941b-80f1509dbb61@linaro.org>
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-3-git-send-email-okukatla@codeaurora.org>
 <8c046ac4-27c8-d858-941b-80f1509dbb61@linaro.org>
Message-ID: <8f67306fe163b93b1c5076d0d2b725a5@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-10 18:16, Alex Elder wrote:
> On 8/10/21 1:46 AM, Odelu Kukatla wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
>> SC7280 SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> 
> I don't have much to say about what this is doing but I
> have a few suggestions.
> 
> 					-Alex
> 
Thanks for review Alex!
>> ---
>>   drivers/interconnect/qcom/osm-l3.c | 136 
>> +++++++++++++++++++++++++++++++------
>>   drivers/interconnect/qcom/sc7280.h |  10 +++
>>   2 files changed, 125 insertions(+), 21 deletions(-)
>> 
>> diff --git a/drivers/interconnect/qcom/osm-l3.c 
>> b/drivers/interconnect/qcom/osm-l3.c
>> index c7af143..3b16e73 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -9,12 +9,14 @@
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>     #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>     #include "sc7180.h"
>> +#include "sc7280.h"
>>   #include "sc8180x.h"
>>   #include "sdm845.h"
>>   #include "sm8150.h"
>> @@ -33,17 +35,33 @@
>>     /* EPSS Register offsets */
>>   #define EPSS_LUT_ROW_SIZE		4
>> +#define EPSS_REG_L3_VOTE		0x90
>>   #define EPSS_REG_FREQ_LUT		0x100
>>   #define EPSS_REG_PERF_STATE		0x320
>> +#define EPSS_CORE_OFFSET		0x4
>> +#define EPSS_L3_VOTE_REG(base, cpu)\
>> +			(((base) + EPSS_REG_L3_VOTE) +\
>> +			((cpu) * EPSS_CORE_OFFSET))
>>   -#define OSM_L3_MAX_LINKS		1
>> +#define L3_DOMAIN_CNT		4
>> +#define L3_MAX_LINKS		9
> 
> It may not matter much, but if you specified the
> qcom_osm_l3_node->links[] field as the last field
> in the structure, I think it could be a flexible
> array and you wouldn't have to specify the maximum
> number of links.  (You are already using the actual
> array size to set ->num_links in __DEFINE_QNODE().)
> 
I will address this in next revision, will see if we can move it to 
flexible array.
>>   #define to_osm_l3_provider(_provider) \
>>   	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>>   +/**
>> + * @domain_base: an array of base address for each clock domain
>> + * @max_state: max supported frequency level
>> + * @per_core_dcvs: flag used to indicate whether the frequency 
>> scaling
>> + * for each core is enabled
>> + * @reg_perf_state: requested frequency level
>> + * @lut_tables: an array of supported frequency levels
>> + * @provider: interconnect provider of this node
>> + */
> 
> Run this to check your kernel doc validity:
>     scripts/kernel-doc -none <file> [<file>...]
> 
Done!
>>   struct qcom_osm_l3_icc_provider {
>> -	void __iomem *base;
>> +	void __iomem *domain_base[L3_DOMAIN_CNT];
>>   	unsigned int max_state;
>> +	bool per_core_dcvs;
>>   	unsigned int reg_perf_state;
>>   	unsigned long lut_tables[LUT_MAX_ENTRIES];
>>   	struct icc_provider provider;
> 
> . . .
> 
>> @@ -235,12 +322,17 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>   	if (!qp)
>>   		return -ENOMEM;
>>   -	qp->base = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(qp->base))
>> -		return PTR_ERR(qp->base);
>> +	while (of_get_address(pdev->dev.of_node, i++, NULL, NULL))
>> +		nr_domain_bases++;
> 
> Maybe you could combine these two loops by counting as you go.
> I.e.:
> 
>     i = 0;
>     while (true) {
> 	void __iomem *base;
> 
> 	if (of_get_address(pdev->dev.of_node, i, NULL, NULL))
> 		break;
> 	base = devm_platform_ioremap_resource(pdev, i);
> 	if (IS_ERR(base))
> 	    return PTR_ERR(base);
> 	qp->domain_base[i++] = base
>     }
>     nr_domain_bases = i;
> 
Not exactly as above, but will merge these two loops.
>> +
>> +	for (i = 0; i < nr_domain_bases ; i++) {
>> +		qp->domain_base[i] = devm_platform_ioremap_resource(pdev, i);
>> +		if (IS_ERR(qp->domain_base[i]))
>> +			return PTR_ERR(qp->domain_base[i]);
>> +	}
>>     	/* HW should be in enabled state to proceed */
>> -	if (!(readl_relaxed(qp->base + REG_ENABLE) & 0x1)) {
>> +	if (!(readl_relaxed(qp->domain_base[0] + REG_ENABLE) & 0x1)) {
>>   		dev_err(&pdev->dev, "error hardware not enabled\n");
>>   		return -ENODEV;
>>   	}
>> @@ -252,7 +344,7 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>   	qp->reg_perf_state = desc->reg_perf_state;
>>     	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> -		info = readl_relaxed(qp->base + desc->reg_freq_lut +
>> +		info = readl_relaxed(qp->domain_base[0] + desc->reg_freq_lut +
>>   				     i * desc->lut_row_size);
> 
> Maybe you could define a macro to encapsulate computing this
> register offset, along the lines of EPSS_L3_VOTE_REG().  (Here
> and elsewhere.)
> 
This register OFFSET calculation is here only, will keep this code as 
is.
>>   		src = FIELD_GET(LUT_SRC, info);
>>   		lval = FIELD_GET(LUT_L_VAL, info);
>> @@ -271,6 +363,7 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>   		prev_freq = freq;
>>   	}
>>   	qp->max_state = i;
>> +	qp->per_core_dcvs = desc->per_core_dcvs;
>>     	qnodes = desc->nodes;
>>   	num_nodes = desc->num_nodes;
>> @@ -326,6 +419,7 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>     static const struct of_device_id osm_l3_of_match[] = {
>>   	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
>> +	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 
>> },
>>   	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
>>   	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
>>   	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 
>> },
>> diff --git a/drivers/interconnect/qcom/sc7280.h 
>> b/drivers/interconnect/qcom/sc7280.h
>> index 175e400..5df7600 100644
>> --- a/drivers/interconnect/qcom/sc7280.h
>> +++ b/drivers/interconnect/qcom/sc7280.h
>> @@ -150,5 +150,15 @@
>>   #define SC7280_SLAVE_PCIE_1			139
>>   #define SC7280_SLAVE_QDSS_STM			140
>>   #define SC7280_SLAVE_TCU			141
>> +#define SC7280_MASTER_EPSS_L3_APPS			142
>> +#define SC7280_SLAVE_EPSS_L3_SHARED			143
>> +#define SC7280_SLAVE_EPSS_L3_CPU0			144
>> +#define SC7280_SLAVE_EPSS_L3_CPU1			145
>> +#define SC7280_SLAVE_EPSS_L3_CPU2			146
>> +#define SC7280_SLAVE_EPSS_L3_CPU3			147
>> +#define SC7280_SLAVE_EPSS_L3_CPU4			148
>> +#define SC7280_SLAVE_EPSS_L3_CPU5			149
>> +#define SC7280_SLAVE_EPSS_L3_CPU6			150
>> +#define SC7280_SLAVE_EPSS_L3_CPU7			151
>>     #endif
>> 

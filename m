Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD03EDC7A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhHPRfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 13:35:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64678 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbhHPRfp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 13:35:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629135313; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qNlRTEofxEuTWEpTGP1/1u9Fi6z/2vUJGRHKwDjc23k=;
 b=q6uFHZ6lwMsl1AkCI5CCGd0h9eo3/LHWIt/Lk8p5E2tmbMPQCeUh1RZgRDjW6NPRpaFsbS3L
 k0L1qiW8heD+T+isoyPVTO5uu0wp2u88NdOHn15/B9HpxYr9RlIm9MSF5zRV1jkupQ4Mg2Hf
 syYQ1ficBkf5oDrslqLNvcr9bHc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 611aa1b891487ad52008caaf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Aug 2021 17:34:48
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16E2AC4360D; Mon, 16 Aug 2021 17:34:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4A56C4338F;
        Mon, 16 Aug 2021 17:34:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Aug 2021 23:04:44 +0530
From:   okukatla@codeaurora.org
To:     Georgi Djakov <djakov@kernel.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [v6 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
In-Reply-To: <b2e74ff4-c15c-3df3-27d9-87cebbf9342d@kernel.org>
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-3-git-send-email-okukatla@codeaurora.org>
 <b2e74ff4-c15c-3df3-27d9-87cebbf9342d@kernel.org>
Message-ID: <db00387126872e09c225fe9616debf53@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-10 17:28, Georgi Djakov wrote:
> Hi Odelu,
> 
> On 10.08.21 9:46, Odelu Kukatla wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
>> SC7280 SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
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
>>     #define to_osm_l3_provider(_provider) \
>>   	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>>   +/**
>> + * @domain_base: an array of base address for each clock domain
> 
> This is not a valid kerneldoc. Please add a title for
> 	struct qcom_osm_l3_icc_provider
> 
Thanks for review! will address this in next revision.
>> + * @max_state: max supported frequency level
>> + * @per_core_dcvs: flag used to indicate whether the frequency 
>> scaling
>> + * for each core is enabled
>> + * @reg_perf_state: requested frequency level
>> + * @lut_tables: an array of supported frequency levels
>> + * @provider: interconnect provider of this node
>> + */
>>   struct qcom_osm_l3_icc_provider {
>> -	void __iomem *base;
>> +	void __iomem *domain_base[L3_DOMAIN_CNT];
>>   	unsigned int max_state;
>> +	bool per_core_dcvs;
>>   	unsigned int reg_perf_state;
>>   	unsigned long lut_tables[LUT_MAX_ENTRIES];
>>   	struct icc_provider provider;
>> @@ -56,32 +74,44 @@ struct qcom_osm_l3_icc_provider {
>>    * @id: a unique node identifier
>>    * @num_links: the total number of @links
>>    * @buswidth: width of the interconnect between a node and the bus
>> + * @domain: clock domain of the cpu node
>> + * @cpu: cpu instance within its clock domain
>>    */
>>   struct qcom_osm_l3_node {
>>   	const char *name;
>> -	u16 links[OSM_L3_MAX_LINKS];
>> +	u16 links[L3_MAX_LINKS];
>>   	u16 id;
>>   	u16 num_links;
>>   	u16 buswidth;
>> +	u8 domain;
>> +	u8 cpu;
>>   };
>>     struct qcom_osm_l3_desc {
>>   	const struct qcom_osm_l3_node **nodes;
>>   	size_t num_nodes;
>> +	bool per_core_dcvs;
>>   	unsigned int lut_row_size;
>>   	unsigned int reg_freq_lut;
>>   	unsigned int reg_perf_state;
>>   };
>>   -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
>> +#define __DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, ...)	\
>>   	static const struct qcom_osm_l3_node _name = {			\
>>   		.name = #_name,						\
>>   		.id = _id,						\
>>   		.buswidth = _buswidth,					\
>> +		.domain = _domain,					\
>> +		.cpu = _cpu,						\
>>   		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
>>   		.links = { __VA_ARGS__ },				\
>>   	}
>>   +#define DEFINE_QNODE(_name, _id, _buswidth, ...)		\
>> +		__DEFINE_QNODE(_name, _id, _buswidth, 0, 0, __VA_ARGS__ )
> 
> Nit: No space before the close parenthesis please.
> 
Thanks for review! will address this in next revision.
>> +#define DEFINE_DCVS_QNODE(_name, _id, _buswidth, _domain, _cpu, 
>> ...)		\
>> +		__DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, __VA_ARGS__ )
> 
> Ditto
> 
>> +
>>   DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, 
>> SDM845_SLAVE_OSM_L3);
>>   DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
>>   @@ -162,26 +192,80 @@ static const struct qcom_osm_l3_desc 
>> sm8250_icc_epss_l3 = {
>>   	.reg_perf_state = EPSS_REG_PERF_STATE,
>>   };
>>   +DEFINE_DCVS_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 
>> 32, 0, 0,
>> +					SC7280_SLAVE_EPSS_L3_SHARED, SC7280_SLAVE_EPSS_L3_CPU0,
>> +					SC7280_SLAVE_EPSS_L3_CPU1, SC7280_SLAVE_EPSS_L3_CPU2,
>> +					SC7280_SLAVE_EPSS_L3_CPU3, SC7280_SLAVE_EPSS_L3_CPU4,
>> +					SC7280_SLAVE_EPSS_L3_CPU5, SC7280_SLAVE_EPSS_L3_CPU6,
>> +					SC7280_SLAVE_EPSS_L3_CPU7);
> 
> Nit: Please align these to the open parenthesis.
> 
Thanks for review! will address this in next revision.
> Thanks,
> Georgi

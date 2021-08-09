Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C93E4A39
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhHIQsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 12:48:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29090 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233539AbhHIQsF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Aug 2021 12:48:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628527665; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qPN59Q87stu5bfLC5qk7HVguSCx6upaOMuYBreLw/co=;
 b=OaHZF97GN7wbNBoTwV/ROvhJFMLNz0l+bA0Pc6djmFM4SFMH1kx0YJMaBc2SXAi6u9tOXb+d
 tIYLsC9ClMY+fOmM+WvhQDIHCT7xd+T9F4lLAEubkVSpGjT/7yohp92viSY/qevX++GhvGwC
 bHrv0AlDIvlKU3JDvuiyX+sd/JI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61115bae7ee6040977a2bb2c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 16:45:34
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A5C7C4360C; Mon,  9 Aug 2021 16:45:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D633C433F1;
        Mon,  9 Aug 2021 16:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Aug 2021 22:15:31 +0530
From:   okukatla@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        bjorn.andersson@linaro.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V4 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
In-Reply-To: <CAE-0n52Hvf_b_bLBz3d-Ts8VyVM_1ydgHud=6LA-kS5+0++oqQ@mail.gmail.com>
References: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org>
 <1624015734-16778-3-git-send-email-okukatla@codeaurora.org>
 <CAE-0n52Hvf_b_bLBz3d-Ts8VyVM_1ydgHud=6LA-kS5+0++oqQ@mail.gmail.com>
Message-ID: <b1e757d1f0001ade03180a37b6c2c97e@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-07-09 04:51, Stephen Boyd wrote:
> Quoting Odelu Kukatla (2021-06-18 04:28:53)
>> diff --git a/drivers/interconnect/qcom/osm-l3.c 
>> b/drivers/interconnect/qcom/osm-l3.c
>> index 695f287..a8c0ee8 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -15,6 +15,7 @@
>>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>> 
>>  #include "sc7180.h"
>> +#include "sc7280.h"
>>  #include "sdm845.h"
>>  #include "sm8150.h"
>>  #include "sm8250.h"
>> @@ -32,17 +33,33 @@
>> 
>>  /* EPSS Register offsets */
>>  #define EPSS_LUT_ROW_SIZE              4
>> +#define EPSS_REG_L3_VOTE               0x90
>>  #define EPSS_REG_FREQ_LUT              0x100
>>  #define EPSS_REG_PERF_STATE            0x320
>> +#define EPSS_CORE_OFFSET               0x4
>> +#define EPSS_L3_VOTE_REG(base, cpu)\
>> +                       (((base) + EPSS_REG_L3_VOTE) +\
>> +                       ((cpu) * EPSS_CORE_OFFSET))
>> 
>> -#define OSM_L3_MAX_LINKS               1
>> +#define L3_DOMAIN_CNT          4
>> +#define L3_MAX_LINKS           9
>> 
>>  #define to_qcom_provider(_provider) \
>>         container_of(_provider, struct qcom_osm_l3_icc_provider, 
>> provider)
>> 
>> +/**
>> + * @domain_base: an array of base address for each clock domain
>> + * @max_state: max supported frequency level
>> + * @per_core_dcvs: flag used to indicate whether the frequency 
>> scaling
>> + * for each core is enabled
>> + * @reg_perf_state: requested frequency level
>> + * @lut_tables: an array of supported frequency levels
>> + * @provider: interconnect provider of this node
>> + */
>>  struct qcom_osm_l3_icc_provider {
>> -       void __iomem *base;
>> +       void __iomem *domain_base[L3_DOMAIN_CNT];
>>         unsigned int max_state;
>> +       bool per_core_dcvs;
>>         unsigned int reg_perf_state;
>>         unsigned long lut_tables[LUT_MAX_ENTRIES];
>>         struct icc_provider provider;
>> @@ -55,34 +72,41 @@ struct qcom_osm_l3_icc_provider {
>>   * @id: a unique node identifier
>>   * @num_links: the total number of @links
>>   * @buswidth: width of the interconnect between a node and the bus
>> + * @domain: clock domain of the cpu node
>> + * @cpu: cpu instance within its clock domain
>>   */
>>  struct qcom_icc_node {
>>         const char *name;
>> -       u16 links[OSM_L3_MAX_LINKS];
>> +       u16 links[L3_MAX_LINKS];
>>         u16 id;
>>         u16 num_links;
>>         u16 buswidth;
>> +       u16 domain;
>> +       int cpu;
> 
> unsigned int? Or is -1 intended for no cpu? If we keep int, please
> document -1 as special.
> 
Thanks, it needs to be unsigned. will fix this in v5.
>>  };
>> 
>>  struct qcom_icc_desc {
>>         const struct qcom_icc_node **nodes;
>>         size_t num_nodes;
>> +       bool per_core_dcvs;
>>         unsigned int lut_row_size;
>>         unsigned int reg_freq_lut;
>>         unsigned int reg_perf_state;
>>  };
>> 
>> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)                      
>>  \
>> -       static const struct qcom_icc_node _name = {                    
>>  \
>> -               .name = #_name,                                        
>>  \
>> -               .id = _id,                                             
>>  \
>> -               .buswidth = _buswidth,                                 
>>  \
>> -               .num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),     
>>  \
>> -               .links = { __VA_ARGS__ },                              
>>  \
>> +#define DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, ...)       
>>                  \
>> +       static const struct qcom_icc_node _name = {                    
>>          \
>> +               .name = #_name,                                        
>>          \
>> +               .id = _id,                                             
>>          \
>> +               .buswidth = _buswidth,                                 
>>          \
>> +               .domain = _domain,                                     
>>          \
>> +               .cpu = _cpu,                                           
>>  \
>> +               .num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),     
>>          \
>> +               .links = { __VA_ARGS__ },                              
>>          \
>>         }
>> 
>> -DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, 
>> SDM845_SLAVE_OSM_L3);
>> -DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
>> +DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, 0, 0, 
>> SDM845_SLAVE_OSM_L3);
>> +DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16, 0, 0);
> 
> Please avoid making these changes. Instead, have a common macro
> __DEFINE_QNODE() that takes all the arguments and then leave
> DEFINE_QNODE alone and have it pass 0 by default for the ones that are
> new and make a new define for newer SoCs like DEFINE_DOMAIN_QNODE (or a
> better name) that takes the new arguments. Then we don't have to review
> the older SoCs and figure out what changed.
> 
Thanks, will fix this in v5.
>> 
>>  static const struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
>>         [MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
>> @@ -97,8 +121,8 @@ static const struct qcom_icc_desc sdm845_icc_osm_l3 
>> = {
>>         .reg_perf_state = OSM_REG_PERF_STATE,
>>  };
>> 
>> -DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, 
>> SC7180_SLAVE_OSM_L3);
>> -DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
>> +DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, 0, 0, 
>> SC7180_SLAVE_OSM_L3);
>> +DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16, 0, 0);
>> 
>>  static const struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
>>         [MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
>> @@ -113,8 +137,8 @@ static const struct qcom_icc_desc 
>> sc7180_icc_osm_l3 = {
>>         .reg_perf_state = OSM_REG_PERF_STATE,
>>  };
>> 
>> -DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, 
>> SM8150_SLAVE_OSM_L3);
>> -DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
>> +DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, 0, 0, 
>> SM8150_SLAVE_OSM_L3);
>> +DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32, 0, 0);
>> 
>>  static const struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
>>         [MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
>> @@ -129,8 +153,8 @@ static const struct qcom_icc_desc 
>> sm8150_icc_osm_l3 = {
>>         .reg_perf_state = OSM_REG_PERF_STATE,
>>  };
>> 
>> -DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, 
>> SM8250_SLAVE_EPSS_L3);
>> -DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
>> +DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, 0, 
>> 0, SM8250_SLAVE_EPSS_L3);
>> +DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32, 0, 0);
>> 
>>  static const struct qcom_icc_node *sm8250_epss_l3_nodes[] = {
>>         [MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
> 
> Because it is quite a few!
> 
>> @@ -145,6 +169,39 @@ static const struct qcom_icc_desc 
>> sm8250_icc_epss_l3 = {
>>         .reg_perf_state = EPSS_REG_PERF_STATE,
>>  };
>> 
>> +DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, 0, 
>> 0, SC7280_SLAVE_EPSS_L3_SHARED, SC7280_SLAVE_EPSS_L3_CPU0, 
>> SC7280_SLAVE_EPSS_L3_CPU1, SC7280_SLAVE_EPSS_L3_CPU2, 
>> SC7280_SLAVE_EPSS_L3_CPU3, SC7280_SLAVE_EPSS_L3_CPU4, 
>> SC7280_SLAVE_EPSS_L3_CPU5, SC7280_SLAVE_EPSS_L3_CPU6, 
>> SC7280_SLAVE_EPSS_L3_CPU7);
> 
> Surely this line can be split up?
> 
will fix this in v5.
>> +DEFINE_QNODE(sc7280_epss_l3_shared, SC7280_SLAVE_EPSS_L3_SHARED, 32, 
>> 0, 0);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu0, SC7280_SLAVE_EPSS_L3_CPU0, 32, 1, 
>> 0);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu1, SC7280_SLAVE_EPSS_L3_CPU1, 32, 1, 
>> 1);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu2, SC7280_SLAVE_EPSS_L3_CPU2, 32, 1, 
>> 2);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu3, SC7280_SLAVE_EPSS_L3_CPU3, 32, 1, 
>> 3);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu4, SC7280_SLAVE_EPSS_L3_CPU4, 32, 2, 
>> 0);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu5, SC7280_SLAVE_EPSS_L3_CPU5, 32, 2, 
>> 1);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu6, SC7280_SLAVE_EPSS_L3_CPU6, 32, 2, 
>> 2);
>> +DEFINE_QNODE(sc7280_epss_l3_cpu7, SC7280_SLAVE_EPSS_L3_CPU7, 32, 3, 
>> 0);
>> +
>> +static const struct qcom_icc_node *sc7280_epss_l3_nodes[] = {
>> +       [MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
>> +       [SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3_shared,
>> +       [SLAVE_EPSS_L3_CPU0] = &sc7280_epss_l3_cpu0,
>> +       [SLAVE_EPSS_L3_CPU1] = &sc7280_epss_l3_cpu1,
>> +       [SLAVE_EPSS_L3_CPU2] = &sc7280_epss_l3_cpu2,
>> +       [SLAVE_EPSS_L3_CPU3] = &sc7280_epss_l3_cpu3,
>> +       [SLAVE_EPSS_L3_CPU4] = &sc7280_epss_l3_cpu4,
>> +       [SLAVE_EPSS_L3_CPU5] = &sc7280_epss_l3_cpu5,
>> +       [SLAVE_EPSS_L3_CPU6] = &sc7280_epss_l3_cpu6,
>> +       [SLAVE_EPSS_L3_CPU7] = &sc7280_epss_l3_cpu7,
>> +};
>> +
>> +static const struct qcom_icc_desc sc7280_icc_epss_l3 = {
>> +       .nodes = sc7280_epss_l3_nodes,
>> +       .num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
>> +       .per_core_dcvs = true,
>> +       .lut_row_size = EPSS_LUT_ROW_SIZE,
>> +       .reg_freq_lut = EPSS_REG_FREQ_LUT,
>> +       .reg_perf_state = EPSS_REG_PERF_STATE,
>> +};
>> +
>>  static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  {
>>         struct qcom_osm_l3_icc_provider *qp;
>> @@ -156,13 +213,18 @@ static int qcom_icc_set(struct icc_node *src, 
>> struct icc_node *dst)
>>         u32 agg_avg = 0;
>>         u64 rate;
>> 
>> -       qn = src->data;
>> +       qn = dst->data;
>>         provider = src->provider;
>>         qp = to_qcom_provider(provider);
>> 
>> -       list_for_each_entry(n, &provider->nodes, node_list)
>> -               provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
>> -                                   &agg_avg, &agg_peak);
>> +       /* Skip aggregation when per core l3 scaling is enabled */
>> +       if (qp->per_core_dcvs) {
>> +               agg_peak = dst->peak_bw;
>> +       } else {
>> +               list_for_each_entry(n, &provider->nodes, node_list)
>> +                       provider->aggregate(n, 0, n->avg_bw, 
>> n->peak_bw,
>> +                                               &agg_avg, &agg_peak);
>> +       }
> 
> Maybe make this a function like
> 
> 	agg_peak = qcom_icc_calc_aggregate_peak();
> 
> so the indenting of the list_for_each_entry can be avoided
> 
> 
> 	if (qp->per_core_dcvs)
> 		return dst->peak_bw;
> 
> 
>         list_for_each_entry(n, &provider->nodes, node_list)
> 	      provider->aggregate(n, 0, n->avg_bw, n->peak_bw, &agg_avg,
> 	      			  &agg_peak);
> 
> 	return agg_peak;
> 
> 
> you get the idea.
> 
Thanks, will fix this in v5.

>> @@ -173,7 +235,10 @@ static int qcom_icc_set(struct icc_node *src, 
>> struct icc_node *dst)
> 
> This function name really should be different. There are other
> qcom_icc_set()s already so the tag space is cluttered.
> 
will address this in v5.
>>                         break;
>>         }
>> 
>> -       writel_relaxed(index, qp->base + qp->reg_perf_state);
>> +       if (qp->per_core_dcvs)
>> +               writel_relaxed(index, 
>> EPSS_L3_VOTE_REG(qp->domain_base[qn->domain], qn->cpu));
>> +       else
>> +               writel_relaxed(index, qp->domain_base[qn->domain] + 
>> qp->reg_perf_state);
>> 
>>         return 0;
>>  }
>> @@ -194,11 +259,12 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>         const struct qcom_icc_desc *desc;
>>         struct icc_onecell_data *data;
>>         struct icc_provider *provider;
>> +       struct property *prop;
>>         const struct qcom_icc_node **qnodes;
>>         struct icc_node *node;
>>         size_t num_nodes;
>>         struct clk *clk;
>> -       int ret;
>> +       int ret, index, domain_count;
>> 
>>         clk = clk_get(&pdev->dev, "xo");
>>         if (IS_ERR(clk))
>> @@ -218,12 +284,21 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>         if (!qp)
>>                 return -ENOMEM;
>> 
>> -       qp->base = devm_platform_ioremap_resource(pdev, 0);
>> -       if (IS_ERR(qp->base))
>> -               return PTR_ERR(qp->base);
>> +       prop = of_find_property(pdev->dev.of_node, "reg", NULL);
>> +       if (!prop)
>> +               return -EINVAL;
>> +       domain_count = prop->length / (4 * sizeof(prop->length));
>> +       if (!domain_count)
>> +               return -EINVAL;
> 
> This is counting reg properties? Most definitely this is wrong as
> #address-cells or #size-cells could be different than what this code is
> expecting. Maybe roll a loop over of_get_address() and then consider
> using that? Or just hardcode the expected number of reg properties 
> based
> on the compatible string.
> 
Thanks, will fix this in v5.
>> +
>> +       for (index = 0; index < domain_count ; index++) {
>> +               qp->domain_base[index] = 
>> devm_platform_ioremap_resource(pdev, index);
>> +               if (IS_ERR(qp->domain_base[index]))
>> +                       return PTR_ERR(qp->domain_base[index]);
>> +       }
>> 
>>         /* HW should be in enabled state to proceed */
>> -       if (!(readl_relaxed(qp->base + REG_ENABLE) & 0x1)) {
>> +       if (!(readl_relaxed(qp->domain_base[0] + REG_ENABLE) & 0x1)) {
>>                 dev_err(&pdev->dev, "error hardware not enabled\n");
>>                 return -ENODEV;
>>         }
>> @@ -235,7 +310,7 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>         qp->reg_perf_state = desc->reg_perf_state;
>> 
>>         for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> -               info = readl_relaxed(qp->base + desc->reg_freq_lut +
>> +               info = readl_relaxed(qp->domain_base[0] + 
>> desc->reg_freq_lut +
> 
> So is the first address a special "global" IO region that hols the LUT
> for everyone?
> 
yes
>>                                      i * desc->lut_row_size);
>>                 src = FIELD_GET(LUT_SRC, info);
>>                 lval = FIELD_GET(LUT_L_VAL, info);
>> @@ -254,6 +329,7 @@ static int qcom_osm_l3_probe(struct 
>> platform_device *pdev)
>>                 prev_freq = freq;
>>         }
>>         qp->max_state = i;
>> +       qp->per_core_dcvs = desc->per_core_dcvs;
>> 
>>         qnodes = desc->nodes;
>>         num_nodes = desc->num_nodes;
>> diff --git a/drivers/interconnect/qcom/sc7280.h 
>> b/drivers/interconnect/qcom/sc7280.h
>> index 175e400..5df7600 100644
>> --- a/drivers/interconnect/qcom/sc7280.h
>> +++ b/drivers/interconnect/qcom/sc7280.h
>> @@ -150,5 +150,15 @@
>>  #define SC7280_SLAVE_PCIE_1                    139
>>  #define SC7280_SLAVE_QDSS_STM                  140
>>  #define SC7280_SLAVE_TCU                       141
>> +#define SC7280_MASTER_EPSS_L3_APPS                     142
>> +#define SC7280_SLAVE_EPSS_L3_SHARED                    143
>> +#define SC7280_SLAVE_EPSS_L3_CPU0                      144
>> +#define SC7280_SLAVE_EPSS_L3_CPU1                      145
>> +#define SC7280_SLAVE_EPSS_L3_CPU2                      146
>> +#define SC7280_SLAVE_EPSS_L3_CPU3                      147
>> +#define SC7280_SLAVE_EPSS_L3_CPU4                      148
>> +#define SC7280_SLAVE_EPSS_L3_CPU5                      149
>> +#define SC7280_SLAVE_EPSS_L3_CPU6                      150
>> +#define SC7280_SLAVE_EPSS_L3_CPU7                      151
> 
> Can we stop using master and slave here? I know it's part of AXI
> terminology but I'm hoping they've come up with some better terms to 
> use
> now.

We will keep this for now for sc7280 as these names are already being 
used by clients. we will move to new terminology in new provider 
drivers.

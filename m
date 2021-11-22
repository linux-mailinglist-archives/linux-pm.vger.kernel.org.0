Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A315459154
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 16:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhKVP2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 10:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239945AbhKVP2U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Nov 2021 10:28:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FD8D60230;
        Mon, 22 Nov 2021 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637594709;
        bh=GR8LyQtM0ZM0W2FoeSZ0IwjeQhHesgzQ9tX4AHyKytg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=poGol0emrDdzryc5UnGTptPoklyDE9E2uyhaJuvTRbxXW8bjb2r3pbcg2f6qau1ep
         NLFh14w9Dxyb54cnIPZ0RuyoxpW7ARmyZCwj8OM8+REfiGWIj66BhiTCliSxcVEcn5
         Md/FFwSgAejmmIvJas9wpPk2yd8yC5OXp4Nacn0F+i5+6+8OcXLc+LzpMm/XM2i2sn
         GVTVuipPT1vCc4m1eBs7DAF9QQy0ssy4MjFbj2j2RY2c1xea76lmOb+LizkqKiIZDp
         Mw6kPv8uOxZY1uhlcs4ucg8ArUdEADm+1GEGeBtsKAXnTzpLT8zcYEqNj7ctkI8MGn
         edlM05akgLw2w==
Message-ID: <1b9cdfba-6436-f2bd-d67b-7528758a6c35@kernel.org>
Date:   Mon, 22 Nov 2021 17:25:03 +0200
MIME-Version: 1.0
Subject: Re: [v8 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        georgi.djakov@linaro.org
Cc:     evgreen@google.com, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
 <1634812857-10676-3-git-send-email-okukatla@codeaurora.org>
 <YZa9SStiYqfp6f7a@builder.lan>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YZa9SStiYqfp6f7a@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.11.21 22:53, Bjorn Andersson wrote:
> On Thu 21 Oct 05:40 CDT 2021, Odelu Kukatla wrote:
> 
>> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
>> SC7280 SoCs.
>>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks!

> @Georgi, do you intend to apply the two interconnect patches in this
> series?

Yes, applied!

BR,
Georgi

> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>   drivers/interconnect/qcom/osm-l3.c | 20 +++++++++++++++++++-
>>   drivers/interconnect/qcom/sc7280.h |  2 ++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>> index c7af143..eec1309 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>>    */
>>   
>>   #include <linux/bitfield.h>
>> @@ -15,6 +15,7 @@
>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>   
>>   #include "sc7180.h"
>> +#include "sc7280.h"
>>   #include "sc8180x.h"
>>   #include "sdm845.h"
>>   #include "sm8150.h"
>> @@ -114,6 +115,22 @@ static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
>>   	.reg_perf_state = OSM_REG_PERF_STATE,
>>   };
>>   
>> +DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, SC7280_SLAVE_EPSS_L3);
>> +DEFINE_QNODE(sc7280_epss_l3, SC7280_SLAVE_EPSS_L3, 32);
>> +
>> +static const struct qcom_osm_l3_node *sc7280_epss_l3_nodes[] = {
>> +	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
>> +	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3,
>> +};
>> +
>> +static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
>> +	.nodes = sc7280_epss_l3_nodes,
>> +	.num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
>> +	.lut_row_size = EPSS_LUT_ROW_SIZE,
>> +	.reg_freq_lut = EPSS_REG_FREQ_LUT,
>> +	.reg_perf_state = EPSS_REG_PERF_STATE,
>> +};
>> +
>>   DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
>>   DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
>>   
>> @@ -326,6 +343,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>   
>>   static const struct of_device_id osm_l3_of_match[] = {
>>   	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
>> +	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
>>   	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
>>   	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
>>   	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 },
>> diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
>> index 175e400..1fb9839 100644
>> --- a/drivers/interconnect/qcom/sc7280.h
>> +++ b/drivers/interconnect/qcom/sc7280.h
>> @@ -150,5 +150,7 @@
>>   #define SC7280_SLAVE_PCIE_1			139
>>   #define SC7280_SLAVE_QDSS_STM			140
>>   #define SC7280_SLAVE_TCU			141
>> +#define SC7280_MASTER_EPSS_L3_APPS		142
>> +#define SC7280_SLAVE_EPSS_L3			143
>>   
>>   #endif
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCB212E70
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGBVCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 17:02:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54439 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgGBVCq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jul 2020 17:02:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593723766; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=N0Ded94Yw/A97ejOt/Byw9brMZzuEH1tTLERSwoMMfg=; b=NJlixJpSu+xu2rMtScUzuuwgmYpZHH1Ax3yv0BPIohTgKPiT0zt0yh2ljOGoTAYYrNApxSum
 3PKa4grUBMkFy8C53NOlEqe8Mth/rLWfw5cuv+F1eoQ84QtOs1dnQfWXaLMuo0RoOPJGamuW
 8Jq/E76FvVPp24NwTcbf4OwW12M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5efe4b63117610c7ff6eed27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 21:02:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5E81C43391; Thu,  2 Jul 2020 21:02:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C160DC433C6;
        Thu,  2 Jul 2020 21:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C160DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH 4/4] interconnect: qcom: Fix small BW votes being
 truncated to zero
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200623040814.23791-1-mdtipton@codeaurora.org>
 <20200623040814.23791-5-mdtipton@codeaurora.org>
 <09f21847-33bc-64fb-aeb7-df5bafa5593c@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <d093fed9-dede-93dc-2990-80769d0d4439@codeaurora.org>
Date:   Thu, 2 Jul 2020 14:02:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <09f21847-33bc-64fb-aeb7-df5bafa5593c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/2/2020 4:11 AM, Georgi Djakov wrote:
> Hi Mike,
> 
> On 6/23/20 07:08, Mike Tipton wrote:
>> Small BW votes that translate to less than a single BCM unit are
>> currently truncated to zero. Ensure that non-zero BW requests always
>> result in at least a vote of 1 to BCM.
>>
>> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>   drivers/interconnect/qcom/bcm-voter.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
>> index a68c858ca6b7..9e2612fe7fad 100644
>> --- a/drivers/interconnect/qcom/bcm-voter.c
>> +++ b/drivers/interconnect/qcom/bcm-voter.c
>> @@ -54,8 +54,20 @@ static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
>>   		return 1;
>>   }
>>   
>> +static u64 bcm_div(u64 num, u64 base)
>> +{
>> +	/* Ensure that small votes aren't lost. */
>> +	if (num && num < base)
>> +		return 1;
>> +
>> +	do_div(num, base);
> 
> do_div() does a 64-by-32 division, which will truncate these to 32-bit.
I can change base to a u32. It doesn't need anything more than that.

> 
>> +
>> +	return num;
>> +}
>> +
>>   static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>>   {
>> +	struct qcom_icc_node *node;
>>   	size_t i, bucket;
>>   	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
>>   	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
>> @@ -63,22 +75,21 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>>   
>>   	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
>>   		for (i = 0; i < bcm->num_nodes; i++) {
>> -			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
>> -			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
>> +			node = bcm->nodes[i];
>> +			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
>> +				       node->buswidth * node->channels);
>>   			agg_avg[bucket] = max(agg_avg[bucket], temp);
>>   
>> -			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
>> -			do_div(temp, bcm->nodes[i]->buswidth);
>> +			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
>> +				       node->buswidth);
>>   			agg_peak[bucket] = max(agg_peak[bucket], temp);
>>   		}
>>   
>>   		temp = agg_avg[bucket] * bcm->vote_scale;
>> -		do_div(temp, bcm->aux_data.unit);
>> -		bcm->vote_x[bucket] = temp;
>> +		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
>>   
>>   		temp = agg_peak[bucket] * bcm->vote_scale;
>> -		do_div(temp, bcm->aux_data.unit);
>> -		bcm->vote_y[bucket] = temp;
>> +		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
>>   	}
>>   
>>   	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
>>
> 
> The rest looks good.
> 
> Thanks,
> Georgi
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4272AE4D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jun 2023 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjFJTJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jun 2023 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFJTJY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2023 15:09:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75DFF
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2023 12:09:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4effb818c37so3542227e87.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2023 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686424160; x=1689016160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuPDYUPmo09x9+exjkTuDHCOViuuuI1E1oWNi/ZOWb8=;
        b=mmVEwli0LWMvShsnbMXXN7md+qU3srSNdhROfEwrQ5FueHga8DbB3VrJHoJ1JFJY7s
         q28KqcAfqqvW27BWp92VwDzShN+AvpPchjgHYwstDW6CvszehfuigDWLqgZ2crprfI2y
         H3RVxZrHn3bGZnWyBPONy8Eu/g0Y1KYKu5sEFsYBFkT2mn0tfoyoYq9cURAAf+zij+Dn
         8GgszVqE+NI92krNFEThkQfd0kPCce91FJkF1QmpAbAPHkBLkDy1DVvd5wGzCNLM81qm
         JFCd9S/ug5Aqa1aHnGCQ0QgLGFiwqWT589gj/wuD+l6UXurNFLujlvFBg0KZGgjCdWst
         rJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686424160; x=1689016160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuPDYUPmo09x9+exjkTuDHCOViuuuI1E1oWNi/ZOWb8=;
        b=BAW3xPeFoGMSErw/qePToguJSS2VddwHVqCa6LbzpK9j3c+iFFtTxinRrJTcI1qQUF
         3d/n+Xp2gWZDLNeg+f58+WPUGJy4VpVQHVFgv8BuVWMISihR9YjfmOrIfyUqtyZfGoL3
         mcvwPKto7UoBVc2yH+q3OVrKWgp2e7BPAq++56Q5FWMwsA4CQOQJziEBE8Eqa2WKsJiZ
         cpeNNVRTauTKDvK9SKEFEE7GPQNGR3MnqLqRoOX5RDL0WKQUh8Ptv6vDVnCmARjhfm07
         +yQ5X9c0utjlXt+b4uYVsSb9PT+b9o0x6tiymIi8/AnLA9lrYUB/Fuw2xJ0SfbjBGKyB
         pxGA==
X-Gm-Message-State: AC+VfDwsugDCpM3neOIsWcvoMzi2W00lRpK/i9uzD2Lnqn9il6VV869V
        CeY+GxXkMRtmcv+cRek15YxAbA==
X-Google-Smtp-Source: ACHHUZ5xdgeSm1eWZ9EdpY5bV5Zot6l5jeg4PcRLpcA1sqWJrb90TLV/w7Ns9EeHWxPpOO2vL/xYcg==
X-Received: by 2002:a2e:998a:0:b0:2ac:7852:4096 with SMTP id w10-20020a2e998a000000b002ac78524096mr730673lji.24.1686424160336;
        Sat, 10 Jun 2023 12:09:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e2c14000000b002b1a8b926f3sm949346ljs.3.2023.06.10.12.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 12:09:20 -0700 (PDT)
Message-ID: <5362844c-253c-b624-c8f0-81a06a891dbd@linaro.org>
Date:   Sat, 10 Jun 2023 21:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 22/22] interconnect: qcom: icc-rpm: Fix bandwidth
 calculations
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-22-e5934b07d813@linaro.org>
 <ZITJw05MYgCjzLFx@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZITJw05MYgCjzLFx@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10.06.2023 21:06, Stephan Gerhold wrote:
> On Fri, Jun 09, 2023 at 10:19:27PM +0200, Konrad Dybcio wrote:
>> Up until now, we've been aggregating the bandwidth values and only
>> dividing them by the bus width of the source node. This was completely
>> wrong, as different nodes on a given path may (and usually do) have
>> varying bus widths.  That in turn, resulted in the calculated clock rates
>> being completely bogus - usually they ended up being much higher, as
>> NoC_A<->NoC_B links are very wide.
>>
>> Since we're not using the aggregate bandwidth value for anything other
>> than clock rate calculations, remodel qcom_icc_bus_aggregate() to
>> calculate the per-context clock rate for a given provider, taking into
>> account the bus width of every individual node.
>>
>> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
>> Reported-by: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 59 ++++++++++++-------------------------
>>  1 file changed, 19 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 1508233632f6..d177a76abe2a 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -293,58 +293,44 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>  }
>>  
>>  /**
>> - * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
>> + * qcom_icc_bus_aggregate - calculate bus clock rates by traversing all nodes
>>   * @provider: generic interconnect provider
>> - * @agg_avg: an array for aggregated average bandwidth of buckets
>> - * @agg_peak: an array for aggregated peak bandwidth of buckets
>> - * @max_agg_avg: pointer to max value of aggregated average bandwidth
>> + * @agg_clk_rate: array containing the aggregated clock rates in kHz
>>   */
>> -static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>> -				   u64 *agg_avg, u64 *agg_peak,
>> -				   u64 *max_agg_avg)
>> +static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
>>  {
>> -	struct icc_node *node;
>> +	u64 agg_avg_rate, agg_rate;
>>  	struct qcom_icc_node *qn;
>> -	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
>> +	struct icc_node *node;
>>  	int i;
>>  
>> -	/* Initialise aggregate values */
>> -	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>> -		agg_avg[i] = 0;
>> -		agg_peak[i] = 0;
>> -	}
>> -
>> -	*max_agg_avg = 0;
>> -
>>  	/*
>> -	 * Iterate nodes on the interconnect and aggregate bandwidth
>> -	 * requests for every bucket.
>> +	 * Iterate nodes on the provider, aggregate bandwidth requests for
>> +	 * every bucket and convert them into bus clock rates.
>>  	 */
>>  	list_for_each_entry(node, &provider->nodes, node_list) {
>>  		qn = node->data;
>>  		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>>  			if (qn->channels)
>> -				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>> +				agg_avg_rate = div_u64(qn->sum_avg[i], qn->channels);
>>  			else
>> -				sum_avg[i] = qn->sum_avg[i];
>> -			agg_avg[i] += sum_avg[i];
>> -			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>> +				agg_avg_rate = qn->sum_avg[i];
>> +
>> +			agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
>> +			do_div(agg_rate, qn->buswidth);
>> +
>> +			agg_clk_rate[i] = max_t(u64, agg_clk_rate[i], agg_rate);
>>  		}
>>  	}
>> -
>> -	/* Find maximum values across all buckets */
>> -	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
>> -		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
>>  }
>>  
>>  static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  {
>> -	struct qcom_icc_provider *qp;
>>  	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>> +	u64 agg_clk_rate[QCOM_SMD_RPM_STATE_NUM] = { 0 };
>>  	struct icc_provider *provider;
>> +	struct qcom_icc_provider *qp;
>>  	u64 active_rate, sleep_rate;
>> -	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
>> -	u64 max_agg_avg;
>>  	int ret;
>>  
>>  	src_qn = src->data;
>> @@ -353,7 +339,9 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  	provider = src->provider;
>>  	qp = to_qcom_provider(provider);
>>  
>> -	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
>> +	qcom_icc_bus_aggregate(provider, agg_clk_rate);
>> +	active_rate = agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE];
>> +	sleep_rate = agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE];
>>  
>>  	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
>>  	if (ret)
>> @@ -369,15 +357,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  	if (!qp->bus_clk_desc && !qp->bus_clk)
>>  		return 0;
>>  
>> -	/* Intentionally keep the rates in kHz as that's what RPM accepts */
> 
> I kind of liked this comment because otherwise it's not obvious why
> you're not converting from "ICC units" anywhere.
I figured the kerneldoc change would be enough:

@agg_clk_rate: array containing the aggregated clock rates in kHz

> 
> Anyway:
> 
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Thanks for going through the giant maze to fix this!
Thanks for being there along the way.. This spaghetti is far too much
for a single human..

Konrad

> 
> Stephan

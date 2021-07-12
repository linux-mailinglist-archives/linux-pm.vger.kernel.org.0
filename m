Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06483C5FA8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhGLPs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:48:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44293 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234603AbhGLPs1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jul 2021 11:48:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626104739; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=tA/haQnIhDKwMdN+3GGg/zfDcFzFpJVczZ3Qskj+6X4=;
 b=vpGNUlHJU6mKckT+wCr8l8HeClE7fhl5B8SJlunu//UayisXrfjnFe2wHUynKEWm6Dv53sM0
 LdI41RuuKCsxmdDNGTciYuJkm35d9pDAg+UkFH+y7v8lkEqbe1X803F/r96mZ5+VcqjlaAfH
 K/nAKaOiLK41tAnKW8SBpR7mRrM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60ec63993a8b6d0a45dfc1aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Jul 2021 15:45:29
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF690C4323A; Mon, 12 Jul 2021 15:45:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.12] (pool-96-253-99-54.rcmdva.fios.verizon.net [96.253.99.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC894C433F1;
        Mon, 12 Jul 2021 15:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC894C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
Subject: Re: [PATCH 3/4] interconnect: qcom: icc-rpmh: Ensure floor BW is
 enforced for all nodes
To:     okukatla@codeaurora.org
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton=codeaurora.org@codeaurora.org
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
 <20210625212839.24155-4-mdtipton@codeaurora.org>
 <afaf4cb4ccc60a1c7c937a296f199f70@codeaurora.org>
Message-ID: <63d0f7fc-5bbf-5e5f-3d51-4f2dbaa99346@codeaurora.org>
Date:   Mon, 12 Jul 2021 08:45:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <afaf4cb4ccc60a1c7c937a296f199f70@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/1/2021 11:48 AM, okukatla@codeaurora.org wrote:
> On 2021-06-26 02:58, Mike Tipton wrote:
>> We currently only enforce BW floors for a subset of nodes in a path.
>> All BCMs that need updating are queued in the pre_aggregate/aggregate
>> phase. The first set() commits all queued BCMs and subsequent set()
>> calls short-circuit without committing anything. Since the floor BW
>> isn't set in sum_avg/max_peak until set(), then some BCMs are committed
>> before their associated nodes reflect the floor.
>>
>> Set the floor as each node is being aggregated. This ensures that all
>> all relevant floors are set before the BCMs are committed.
>>
>> Fixes: 266cd33b5913 ("interconnect: qcom: Ensure that the floor
>> bandwidth value is enforced")
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c
>> b/drivers/interconnect/qcom/icc-rpmh.c
>> index bf01d09dba6c..f118f57eae37 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -57,6 +57,11 @@ int qcom_icc_aggregate(struct icc_node *node, u32
>> tag, u32 avg_bw,
>>              qn->sum_avg[i] += avg_bw;
>>              qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
>>          }
>> +
>> +        if (node->init_avg || node->init_peak) {
>> +            qn->sum_avg[i] = max_t(u64, qn->sum_avg[i], node->init_avg);
>> +            qn->max_peak[i] = max_t(u64, qn->max_peak[i], 
>> node->init_peak);
>> +        }
> Hi Mike,
> Original problem is BCMs not getting added to commit_list for unused 
> nodes, right? that is solved by moving *_bcm_voter_add() to 
> pre_aggregate().
> I could not get why we need to do above change, we are enforcing node 
> votes with floor votes in framework + below code snippet that you removed.
> How would adding this code in qcom_icc_aggregate() make difference? Is 
> there any other issue that i am not to able to get?

This series fixes a couple of separate issues. One is not removing the 
initial floor after sync_state for unvoted paths, which the change to 
add BCMs to the commit list in pre_aggregate addresses. The other issue 
is not properly enforcing the initial floor *before* sync_state, which 
this patch addresses.

We only commit to HW what we've aggregated in our internal, 
provider-specific buckets (AMC, WAKE, SLEEP) during 
pre_aggregate/aggregate. All BCMs in the path are added to the commit 
list during this stage. Everything in the commit list is voted on the 
*first* set() callback for the path. The commit list is empty for every 
subsequent set() callback, so nothing actually happens except in the 
first set().

The original snippet below in qcom_icc_set() partially re-aggregates AMC 
with BW values from the icc_node struct. This is to capture the floor 
enforced by the framework itself. However, this is only for a single 
node in the path, which means it's also only for a single BCM in the 
path. Since we commit all BCMs on the first set(), this means most BCMs 
in the path don't see the floor BW at the time we commit them. This can 
lead to some BCMs being under-voted, or in some cases completely off.

So, instead of aggregating the floor for each node in qcom_icc_set(), 
this patch moves it to qcom_icc_aggregate(). This means all floors are 
captured internally before committing the BCMs.

>>      }
>>
>>      *agg_avg += avg_bw;
>> @@ -90,11 +95,6 @@ int qcom_icc_set(struct icc_node *src, struct 
>> icc_node *dst)
>>      qp = to_qcom_provider(node->provider);
>>      qn = node->data;
>>
>> -    qn->sum_avg[QCOM_ICC_BUCKET_AMC] = max_t(u64,
>> qn->sum_avg[QCOM_ICC_BUCKET_AMC],
>> -                         node->avg_bw);
>> -    qn->max_peak[QCOM_ICC_BUCKET_AMC] = max_t(u64,
>> qn->max_peak[QCOM_ICC_BUCKET_AMC],
>> -                          node->peak_bw);
>> -
>>      qcom_icc_bcm_voter_commit(qp->voter);
>>
>>      return 0;

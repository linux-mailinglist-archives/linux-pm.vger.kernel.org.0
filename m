Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972EC3F487B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhHWKS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 06:18:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61656 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhHWKSz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 06:18:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629713893; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=WdDl3Bs62eJOXS4ON5GLmg1zUOk70f0ikhAxZW4zP74=; b=rncIHfrJISM9XFBKWNULYYFAKGXpZTz1ESFlTyRJBDA6PMmHlYJc7xqTpYf/frTXjYldRZ+y
 XOJiLt0Cceic99ZG/aIXWkAD1EgmvCGQLNeef4fzO6K9xh1ovrUeq3jjvX3ldfJHkBWRv3l8
 Kl0/ifG4hsln36ueG9cJn+fN2LM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 612375d8e19abc7959be8630 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Aug 2021 10:18:00
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6062FC43618; Mon, 23 Aug 2021 10:18:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.102] (unknown [49.204.182.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAC58C4338F;
        Mon, 23 Aug 2021 10:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CAC58C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
 <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
 <77dde5fa-6b12-d970-ac3e-0d3f6c352fbe@codeaurora.org>
 <20210818102644.v2ob46azq47beeqg@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <447cb27e-cd67-5d92-1c0e-932b8581fc7b@codeaurora.org>
Date:   Mon, 23 Aug 2021 15:47:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818102644.v2ob46azq47beeqg@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

Thanks for the review.

On 8/18/2021 3:56 PM, Viresh Kumar wrote:
> On 18-08-21, 15:33, Taniya Das wrote:
>> Hi Doug,
>>
>> Thanks for your review.
>>
>> On 8/13/2021 2:03 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Aug 12, 2021 at 7:19 AM Taniya Das <tdas@codeaurora.org> wrote:
>>>>
>>>> As remote cpufreq updates are supported on QCOM platforms, set
>>>> dvfs_possible_from_any_cpu cpufreq driver flag.
>>>>
>>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>>> ---
>>>>
>>>> [v2]
>>>>     * update the dvfs_possible_from_any_cpu always.
>>>>
>>>>    drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> index f86859b..53d3898 100644
>>>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>>>> @@ -223,6 +223,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>>>
>>>>           table[i].frequency = CPUFREQ_TABLE_END;
>>>>           policy->freq_table = table;
>>>> +       policy->dvfs_possible_from_any_cpu = true;
>>>> +
>>>
>>> Why is this in the qcom_cpufreq_hw_read_lut() function? Shouldn't it
>>> be straight in qcom_cpufreq_hw_cpu_init()?
>>>
>> All CPU policy related data is updated here, thus wanted to keep it
>> together.
> 
> This function should only be updating freq table, please do it in
> qcom_cpufreq_hw_cpu_init() itself, around where you set
> policy->driver_data.
> 

Thanks Viresh, updated the same in the next patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--

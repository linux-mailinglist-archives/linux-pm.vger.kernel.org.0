Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036213F0135
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhHRKFK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 06:05:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60586 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhHRKFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 06:05:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629281072; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ffYmGcp7Eu3u33+LBwJ9wlg05be8ylA9sfwQ3B7Gs8o=; b=pC/ufhj7UY8zWG1jOVraH/+dcxTQ9QHxVeC+BFOwSQGL+finSKBcw7rQKP8Xj5vzoaBeqG/x
 u6bcG5NUA3yVkNFHgKeRoAmqHwGtJQp/+eOLOrpJpco9ATn9vdXTU7EpQ+8z+R0dJqo+oYD5
 nk3U0LEkTW3XFiBiCSc6fQMTeyo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 611cdb01b3873958f527e4f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 10:03:45
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE8D9C4360C; Wed, 18 Aug 2021 10:03:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.0.102] (unknown [49.204.181.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FF2BC4338F;
        Wed, 18 Aug 2021 10:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4FF2BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
 <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <77dde5fa-6b12-d970-ac3e-0d3f6c352fbe@codeaurora.org>
Date:   Wed, 18 Aug 2021 15:33:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

Thanks for your review.

On 8/13/2021 2:03 AM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Aug 12, 2021 at 7:19 AM Taniya Das <tdas@codeaurora.org> wrote:
>>
>> As remote cpufreq updates are supported on QCOM platforms, set
>> dvfs_possible_from_any_cpu cpufreq driver flag.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>
>> [v2]
>>    * update the dvfs_possible_from_any_cpu always.
>>
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f86859b..53d3898 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -223,6 +223,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>
>>          table[i].frequency = CPUFREQ_TABLE_END;
>>          policy->freq_table = table;
>> +       policy->dvfs_possible_from_any_cpu = true;
>> +
> 
> Why is this in the qcom_cpufreq_hw_read_lut() function? Shouldn't it
> be straight in qcom_cpufreq_hw_cpu_init()?
> 
All CPU policy related data is updated here, thus wanted to keep it 
together.

> -Doug
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--

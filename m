Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1413E9FDA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhHLHvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 03:51:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23647 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhHLHvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 03:51:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628754680; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=kksxuIAxFnwR5reAUsynjR7msAT3zsFobFtuiLcro/U=; b=vZ8F/6tS16emoeSandW7rWTscVN6YOaFncqYH3hBFcYqbnxQ33Om72R1AQ1v8J/widBJKQfM
 vyKIYp3OX5/wE9+URMobF+nGMJ3TbAfKyu+pguS7JtUoIaDDLh3m+o2ugbBEWx32I8p0sycg
 QQ3Z84g832+MJnNpwtcGWyflcM8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6114d2f191487ad52097d107 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 07:51:13
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C763C43460; Thu, 12 Aug 2021 07:51:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.103] (unknown [49.204.180.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBEAFC433D3;
        Thu, 12 Aug 2021 07:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBEAFC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <1628645918-12890-1-git-send-email-tdas@codeaurora.org>
 <20210811035745.j6jbufrd2pdrnqdp@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <570078bf-12fc-eab2-39e1-a6cbc4119244@codeaurora.org>
Date:   Thu, 12 Aug 2021 13:21:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811035745.j6jbufrd2pdrnqdp@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks Viresh for the review.

On 8/11/2021 9:27 AM, Viresh Kumar wrote:
> On 11-08-21, 07:08, Taniya Das wrote:
>> As remote cpufreq updates are supported on QCOM platforms, set
>> dvfs_possible_from_any_cpu cpufreq driver flag.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f86859b..20455aa 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -161,6 +161,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>   		return ret;
>>   	} else {
>>   		policy->fast_switch_possible = true;
>> +		policy->dvfs_possible_from_any_cpu = true;
>>   		icc_scaling_enabled = false;
>>   	}
> 
> Why don't you set it always ?
> 

Sure, will move it outside.
>>
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--

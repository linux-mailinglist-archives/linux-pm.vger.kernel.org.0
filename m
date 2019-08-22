Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632BF98A9B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 06:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfHVEzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 00:55:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfHVEzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 00:55:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F15E460E7A; Thu, 22 Aug 2019 04:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566449713;
        bh=ex+PYiDnxvXFBbAIxjjVWchckk1ABhu84A5RKxKV2nA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YSXogrIVnCm4lp/XX6On8454uJ1UGcnRKQFe0dNrJGxvFKB4BmkM/JvAuJC2TjlZI
         wGeUVTnp/A/YpFnFYmZt20y0aL+v3rvxbdNs8sAefxo8Yn7N01oT3LLWXdJ/ramAR8
         Y0mDigX472MAfytIbI53hjoVwaxgwy99yxQao//w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ED03260D0C;
        Thu, 22 Aug 2019 04:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566449712;
        bh=ex+PYiDnxvXFBbAIxjjVWchckk1ABhu84A5RKxKV2nA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OeB5hN57Ektitd1gpmKqfCMtEDatoQoCc/i+KzA5DV8eUBvHIrXUiis7ipN9S6+bC
         N+wmDu4fWgI9M4HcAB3AGNOjYxyc6snwRjN4VWLAEEpgcvVTbNy1LeTzX/Bj6f9y0p
         kwmBwIdLOVFDbD0xBfQLzykAbNoH+ohvnYwIgcHM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 22 Aug 2019 10:25:11 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, agross@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: remove set but not used variable
 'prev_cc'
In-Reply-To: <20190822024051.eubzzxh3b2ip2gzv@vireshk-i7>
References: <20190821121445.72588-1-yuehaibing@huawei.com>
 <20190822024051.eubzzxh3b2ip2gzv@vireshk-i7>
Message-ID: <6c485d00652f873b98664ff211e496cd@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

@YueHaibing thanks for the patch.

On 2019-08-22 08:10, Viresh Kumar wrote:
> On 21-08-19, 20:14, YueHaibing wrote:
>> drivers/cpufreq/qcom-cpufreq-hw.c: In function 
>> qcom_cpufreq_hw_read_lut:
>> drivers/cpufreq/qcom-cpufreq-hw.c:89:38: warning:
>>  variable prev_cc set but not used [-Wunused-but-set-variable]
>> 
>> It is not used since commit 3003e75a5045 ("cpufreq:
>> qcom-hw: Update logic to detect turbo frequency")
>> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 3eea197..a9ae2f8 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -86,7 +86,7 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  				    struct cpufreq_policy *policy,
>>  				    void __iomem *base)
>>  {
>> -	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, 
>> freq;
>> +	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>>  	u32 volt;
>>  	struct cpufreq_frequency_table	*table;
>> 
>> @@ -139,7 +139,6 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  			break;
>>  		}
>> 
>> -		prev_cc = core_count;
>>  		prev_freq = freq;
>>  	}
> 
> @Sibi, you fine with this change ? I will merge it with the original 
> patch then.

yes the changes seem fine, I missed
removing prev_cc.

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D843E4468
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHILJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 07:09:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16215 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhHILJX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Aug 2021 07:09:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628507343; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=iVGYr8BvmR6QN2P1ZSMux09dzqkFjV+3tlj3x4l+kQ8=; b=R3BDJWPured8aLTvLzYCURa5+qgx3mogCioS5irPC1RqRhsabfBUwdAHWElJzZNsgHqXXAJR
 oinqBrt+Ob77IX2B2g+my0sbNHXllnMB9CBKZRoIf5uKWPnw2LMiW7LPBc/1qMwiR/cY98a4
 I2pDeLev/Rq/Si4e0IUmWs6qjVA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61110cc98c78eaf8089be40a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 11:08:57
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41654C433F1; Mon,  9 Aug 2021 11:08:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.100] (unknown [49.207.220.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BFD7C433D3;
        Mon,  9 Aug 2021 11:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BFD7C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrebwt5=S7hqXvcqRvt+-EXLcVmRSRZt1uPf-9n7_pRDg@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <2afd0fac-ed28-c090-a345-3fd4284b4125@codeaurora.org>
Date:   Mon, 9 Aug 2021 16:38:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrebwt5=S7hqXvcqRvt+-EXLcVmRSRZt1uPf-9n7_pRDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/6/2021 3:02 PM, Ulf Hansson wrote:
> On Wed, 4 Aug 2021 at 12:58, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> Some devices within power domains with performance states do not
>> support DVFS, but still need to vote on a default/static state
>> while they are active. They can express this using the 'required-opps'
>> property in device tree, which points to the phandle of the OPP
>> supported by the corresponding power-domains.
>>
>> Add support to parse this information from DT and then set the
>> specified performance state during attach and drop it on detach.
>> runtime suspend/resume callbacks already have logic to drop/set
>> the vote as needed and should take care of dropping the default
>> perf state vote on runtime suspend and restore it back on runtime
>> resume.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/base/power/domain.c | 28 ++++++++++++++++++++++++++--
>>   include/linux/pm_domain.h   |  1 +
>>   2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index a934c67..b9b5a9b 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2598,6 +2598,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>>
>>          dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>>
>> +       /* Drop the default performance state */
>> +       if (dev_gpd_data(dev)->default_pstate) {
>> +               dev_pm_genpd_set_performance_state(dev, 0);
>> +               dev_gpd_data(dev)->default_pstate = 0;
>> +       }
>> +
>>          for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>>                  ret = genpd_remove_device(pd, dev);
>>                  if (ret != -EAGAIN)
>> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>   {
>>          struct of_phandle_args pd_args;
>>          struct generic_pm_domain *pd;
>> +       struct device_node *np;
>> +       int pstate;
>>          int ret;
>>
>>          ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>                  genpd_unlock(pd);
>>          }
>>
>> -       if (ret)
>> +       if (ret) {
>>                  genpd_remove_device(pd, dev);
>> +               return -EPROBE_DEFER;
>> +       }
>> +
>> +       /* Set the default performance state */
>> +       np = dev->of_node;
>> +       if (of_parse_phandle(np, "required-opps", index)) {
> 
> Looks like Viresh thinks it's a good idea to drop the error print in
> of_get_required_opp_performance_state() when there is no
> "required-opps" specifier.
> 
> Would you mind folding in a patch for that in the series, so this code
> can be simplified according to our earlier discussions?

Sure, I can do that, apart from the error print, the function currently also
returns a -EINVAL in case of the missing 'required-opps', are we suggesting
we change that to not return an error also?

Since this is completely optional in the device node, we would want the function to
ideally not return error and only do so in case 'required-opps' exists and the
translation to performance state fails.
I am not sure that's the behavior we expect in case of 'required-opps' in the OPP
tables also, Viresh?

> 
>> +               pstate = of_get_required_opp_performance_state(np, index);
>> +               if (pstate < 0) {
>> +                       ret = pstate;
>> +                       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>> +                               pd->name, ret);
>> +               } else {
>> +                       dev_pm_genpd_set_performance_state(dev, pstate);
>> +                       dev_gpd_data(dev)->default_pstate = pstate;
>> +               }
>> +       }
>>
>> -       return ret ? -EPROBE_DEFER : 1;
>> +       return ret ? ret : 1;
>>   }
>>
>>   /**
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 21a0577..67017c9 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -198,6 +198,7 @@ struct generic_pm_domain_data {
>>          struct notifier_block *power_nb;
>>          int cpu;
>>          unsigned int performance_state;
>> +       unsigned int default_pstate;
>>          unsigned int rpm_pstate;
>>          ktime_t next_wakeup;
>>          void *data;
> 
> Other than the above, this looks good to me!
> 
> Kind regards
> Uffe
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

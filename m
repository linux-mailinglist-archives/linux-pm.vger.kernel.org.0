Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9B3E8D6E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhHKJqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 05:46:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47616 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236462AbhHKJqI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 05:46:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628675145; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uSt79frfisEnQoSy8AUSjOVYQKhD134iVOQ+hRTplH0=; b=TKtmcL0fJ0aaEdiBialfeHpc7hxUd/MMtBMDu2hCnCwdF/JPnP1rZONo0oBKvy/3QCrv9xhh
 bqY7FfplYGIG2PDT1Was7YJi3fkxIolfqsM97xENEQMm8zj6Ab8UhgbUKVEzHDqMWIGEuwRd
 U1xAfhEWvaf3CcMA6xiccEE39QM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61139c4866ff107904a6b1bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 09:45:44
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CE94C43143; Wed, 11 Aug 2021 09:45:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [49.207.220.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 515AAC4338A;
        Wed, 11 Aug 2021 09:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 515AAC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Dmitry Osipenko <digetx@gmail.com>, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <f58e631d-67a7-4981-ce59-6a4772b44564@gmail.com>
 <c43ddc6b-32ca-433d-76f2-901cb594eaf1@gmail.com>
 <9588f01d-1cb6-7ca3-eb41-74259f1678f6@gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <5f676dbe-6b8a-d302-cd81-2d12fe089e5a@codeaurora.org>
Date:   Wed, 11 Aug 2021 15:15:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9588f01d-1cb6-7ca3-eb41-74259f1678f6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/10/2021 5:16 AM, Dmitry Osipenko wrote:
> 10.08.2021 01:44, Dmitry Osipenko пишет:
>> 10.08.2021 01:26, Dmitry Osipenko пишет:
>>> 04.08.2021 13:58, Rajendra Nayak пишет:
>>>> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>>   {
>>>>   	struct of_phandle_args pd_args;
>>>>   	struct generic_pm_domain *pd;
>>>> +	struct device_node *np;
>>>> +	int pstate;
>>>>   	int ret;
>>>>   
>>>>   	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>>>> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>>   		genpd_unlock(pd);
>>>>   	}
>>>>   
>>>> -	if (ret)
>>>> +	if (ret) {
>>>>   		genpd_remove_device(pd, dev);
>>>> +		return -EPROBE_DEFER;
>>>> +	}
>>>> +
>>>> +	/* Set the default performance state */
>>>> +	np = dev->of_node;
>>>> +	if (of_parse_phandle(np, "required-opps", index)) {
> 
> The OF node returned by of_parse_phandle() must be put.

Thanks for spotting that, I will fix it, though I might just drop
the use of of_parse_phandle() and call of_get_required_opp_performance_state()
unconditionally as suggested by Ulf.

> 
>>>> +		pstate = of_get_required_opp_performance_state(np, index);
> 
> If you have more than one power domain, then this will override the
> pstate which was set for a previous domain. This code doesn't feel solid
> to me, at least a clarifying comment is needed about how it's supposed
> to work.

I don't quite understand the concern here, this should work with devices
having multiple power-domains as well. __genpd_dev_pm_attach gets called
once per power-domain, and we use the index above to identify the power-domain.
  
>>>> +		if (pstate < 0) {
>>>> +			ret = pstate;
>>>> +			dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>>>> +				pd->name, ret);
>>>> +		} else {
>>>> +			dev_pm_genpd_set_performance_state(dev, pstate);
>>
>> Where is error handling?

Sure, I'll fix that.

>>
>>>> +			dev_gpd_data(dev)->default_pstate = pstate;
>>>> +		}
>>>> +	}
>>>
>>> Why performance state is set after genpd_power_on()?

The requirement is that the domain is operating at a given performance
state before the device becomes operational. The driver should ideally wait
for the attach to complete before expecting the device to be functional.
So the order here should really not matter, or rather the small amount of time
while the power-domain is on but not at the right performance state should
not matter if that's the concern.

> 
> Should set_performance_state() be invoked when power_on=false?
> 
> I assume it should be:
> 
> if (power_on) {
> 	dev_pm_genpd_set_performance_state(dev, pstate);
> 	dev_gpd_data(dev)->default_pstate = pstate;
> } else {
> 	dev_gpd_data(dev)->rpm_pstate = pstate;
> }
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

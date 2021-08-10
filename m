Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F593E5066
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 02:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhHJAiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 20:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbhHJAiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 20:38:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0CC0613D3;
        Mon,  9 Aug 2021 17:37:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y34so7766538lfa.8;
        Mon, 09 Aug 2021 17:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vcaxQuinFziAA6YBVy1ZbQi08AqEMGEhiwNUVZciWY=;
        b=OCf84kCg+mB3vB+WRTQTLHVbl4YjoxSyeXSO18i5tgX3mvJrfrajn37tnlfDUilmIm
         ktA5FVAFSdpKYg92noUYs5uPVtlKVmcCzupMVqKfu24KtEvicQySXNSR8Lrb5oMefKwP
         mVlhewSBCOUR4nY+uWv24nqtyN13PvdUjsiuWW1Olaxk1akjn3huXZ/wwQQzW/k4IAy4
         D2V6eLhPx+aRgJFTYAn+RgBzBsmVO1vJhqnDtUCngB5F7hipuu965+kLePeeywQ+TMLM
         rwJtIkPl06CVz7zqYjb/UsXoCcb/OXzJjkQLfJ9G/MCtWxqsT8fj5bmBECgJZ75yM5nE
         N/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vcaxQuinFziAA6YBVy1ZbQi08AqEMGEhiwNUVZciWY=;
        b=Zx4IQ84C6tl7/u3L2SXKeNOeGDZjxeK6eeU80KIGMhr3LUw1xzrn2/thyqjPWd4Zyf
         0emHqBGFn1m3BPF125pj+igWRt9/PP5lPAs/Pig3w73SC5lOH7Qc71jbsDvmB0wZ7OlG
         2f8vxuvDFDluWgTZLfHgbqXaI41/alhOLeimKXf2XlWstV2gSOCMDOmhHi/zaL4qFysJ
         hmPKOvTYCuvwcTBPd7L2sVVhxml1CDyJ9s+VBrnFY+hBmFeN7Db34ZcOFBXzdG9mJgsU
         p3l+oooxF9cZ/A4A3Wvz3Qv+3rSGiEYxbAtEqmhpnLQsYDAUKK+c671gXTnqPqd1HOXq
         JPLQ==
X-Gm-Message-State: AOAM531DXHoYMS6QfbdQ45S4uWmyxshAj66aTyo99/YerjW87l059Vvj
        hN7mjE6U9Is7qQyu6E9wgec=
X-Google-Smtp-Source: ABdhPJw2pCBw7AjETG6JNTZafwXn7nFu7XEwEMOoZ5bobjNR5MdmqZZ0cBFohLeOE77ke11p/kD+hw==
X-Received: by 2002:ac2:4941:: with SMTP id o1mr19993490lfi.100.1628555878197;
        Mon, 09 Aug 2021 17:37:58 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id t8sm1708106ljg.33.2021.08.09.17.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 17:37:57 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <f58e631d-67a7-4981-ce59-6a4772b44564@gmail.com>
 <c43ddc6b-32ca-433d-76f2-901cb594eaf1@gmail.com>
 <9588f01d-1cb6-7ca3-eb41-74259f1678f6@gmail.com>
Message-ID: <5515e731-dc07-5f28-1f80-e616718597a4@gmail.com>
Date:   Tue, 10 Aug 2021 03:37:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9588f01d-1cb6-7ca3-eb41-74259f1678f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.08.2021 02:46, Dmitry Osipenko пишет:
> 10.08.2021 01:44, Dmitry Osipenko пишет:
>> 10.08.2021 01:26, Dmitry Osipenko пишет:
>>> 04.08.2021 13:58, Rajendra Nayak пишет:
>>>> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>>  {
>>>>  	struct of_phandle_args pd_args;
>>>>  	struct generic_pm_domain *pd;
>>>> +	struct device_node *np;
>>>> +	int pstate;
>>>>  	int ret;
>>>>  
>>>>  	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>>>> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>>  		genpd_unlock(pd);
>>>>  	}
>>>>  
>>>> -	if (ret)
>>>> +	if (ret) {
>>>>  		genpd_remove_device(pd, dev);
>>>> +		return -EPROBE_DEFER;
>>>> +	}
>>>> +
>>>> +	/* Set the default performance state */
>>>> +	np = dev->of_node;
>>>> +	if (of_parse_phandle(np, "required-opps", index)) {
> 
> The OF node returned by of_parse_phandle() must be put.
> 
>>>> +		pstate = of_get_required_opp_performance_state(np, index);
> 
> If you have more than one power domain, then this will override the
> pstate which was set for a previous domain. This code doesn't feel solid
> to me, at least a clarifying comment is needed about how it's supposed
> to work.
> 
>>>> +		if (pstate < 0) {
>>>> +			ret = pstate;
>>>> +			dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>>>> +				pd->name, ret);
>>>> +		} else {
>>>> +			dev_pm_genpd_set_performance_state(dev, pstate);
>>
>> Where is error handling?
>>
>>>> +			dev_gpd_data(dev)->default_pstate = pstate;
>>>> +		}
>>>> +	}
>>>
>>> Why performance state is set after genpd_power_on()?
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

Although, thinking a bit more about this, it should be better to skip
setting perf state in a case of power_on=false and let drivers to handle
it, IMO. Too much trouble with it for the core.

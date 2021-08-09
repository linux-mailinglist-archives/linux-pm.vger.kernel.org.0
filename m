Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DCC3E5017
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 01:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhHIXrI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhHIXrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 19:47:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D1C0613D3;
        Mon,  9 Aug 2021 16:46:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m9so26180114ljp.7;
        Mon, 09 Aug 2021 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiApi7G+VnFykOPRYjvLWbpQLitx31kBAvkrkjs55U4=;
        b=hj6cjc6vEf6M1bmBMLNtoe6SXdhi0jjQcbBuoAfWb3QrIfBuZowJ/IBymxQw8deQmb
         FNxfrP6mBH6cLjLTIbp3JOIA51xXIb99Xd9u61kZV7kJgXepwSBSdGQ8oP9unEBplgAZ
         LxD2vTliuGcvvkHR3MPuteQ3QVkeViStJK09Vk+uEVsg9ZfY7a9U+xisUucy02KOJvzw
         THeyJei7nvht+d/r3Y6iqf8745DrwHTeLEd/4qChHyuf33aLAr4doh5pJjZopC1eEA1K
         J8CM8i8O8zXsewXV8iU21Mr7bhpj/U2uw+P3yx9RmvttEnf/VCuWlqxt/AzS7KtlFO00
         hM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiApi7G+VnFykOPRYjvLWbpQLitx31kBAvkrkjs55U4=;
        b=mQlOJSgo6KLp/6v89mnlocGrE48LTq5s4L0XM52nWd0yRgT/KCHrMuW0oGAC6ACZzG
         r62eYn0RFNf18D9GAxu6hx2IZzeSe2S0MD2hl4HLqonAk2tB9Q2nus3R0i99FSGyLdnv
         9V6PIIPZ3T7dbjFKulmydK+Jv9FCTsutKIGE+EUIQVwNb2biQWwmgkF9MLm1rx8hHObK
         oA3X1KN4trK/zb9sHHe9qcTmNE0R6xMoJT/GqOyLg0vYmtkKKqHyA4ILlpsxHESo2jkD
         79Y7zs1GGShnn++Syv5CCy3IVOSEpWCLalTu6A4YqyoPoFqUM3S1+jLeYYDtxww/H93S
         ad3A==
X-Gm-Message-State: AOAM532/kZkZOoA6dYZPcUmAQPKQkuNlRvLSJY1RHVCYjRD97eCzTT6u
        U6SwM/Td++ExYpuRYHSS5WE=
X-Google-Smtp-Source: ABdhPJx5RIySknB2pRdg4ziQQNjaT4cVz4nC+C+8kafzn7EsIH2nl0aRqJ2NE3O26Edu6kPTlrLkog==
X-Received: by 2002:a2e:b532:: with SMTP id z18mr6586507ljm.309.1628552805027;
        Mon, 09 Aug 2021 16:46:45 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id q23sm1872117lfp.169.2021.08.09.16.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 16:46:44 -0700 (PDT)
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
Message-ID: <9588f01d-1cb6-7ca3-eb41-74259f1678f6@gmail.com>
Date:   Tue, 10 Aug 2021 02:46:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c43ddc6b-32ca-433d-76f2-901cb594eaf1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.08.2021 01:44, Dmitry Osipenko пишет:
> 10.08.2021 01:26, Dmitry Osipenko пишет:
>> 04.08.2021 13:58, Rajendra Nayak пишет:
>>> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>  {
>>>  	struct of_phandle_args pd_args;
>>>  	struct generic_pm_domain *pd;
>>> +	struct device_node *np;
>>> +	int pstate;
>>>  	int ret;
>>>  
>>>  	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>>> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>  		genpd_unlock(pd);
>>>  	}
>>>  
>>> -	if (ret)
>>> +	if (ret) {
>>>  		genpd_remove_device(pd, dev);
>>> +		return -EPROBE_DEFER;
>>> +	}
>>> +
>>> +	/* Set the default performance state */
>>> +	np = dev->of_node;
>>> +	if (of_parse_phandle(np, "required-opps", index)) {

The OF node returned by of_parse_phandle() must be put.

>>> +		pstate = of_get_required_opp_performance_state(np, index);

If you have more than one power domain, then this will override the
pstate which was set for a previous domain. This code doesn't feel solid
to me, at least a clarifying comment is needed about how it's supposed
to work.

>>> +		if (pstate < 0) {
>>> +			ret = pstate;
>>> +			dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>>> +				pd->name, ret);
>>> +		} else {
>>> +			dev_pm_genpd_set_performance_state(dev, pstate);
> 
> Where is error handling?
> 
>>> +			dev_gpd_data(dev)->default_pstate = pstate;
>>> +		}
>>> +	}
>>
>> Why performance state is set after genpd_power_on()?

Should set_performance_state() be invoked when power_on=false?

I assume it should be:

if (power_on) {
	dev_pm_genpd_set_performance_state(dev, pstate);
	dev_gpd_data(dev)->default_pstate = pstate;
} else {
	dev_gpd_data(dev)->rpm_pstate = pstate;
}

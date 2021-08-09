Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AC3E4F71
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 00:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhHIWpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhHIWpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 18:45:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88782C06179F;
        Mon,  9 Aug 2021 15:44:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so14569254lfu.5;
        Mon, 09 Aug 2021 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AmgysG4X1Rf9LeXjKhIGoZjfBo/p5PA6DCR3EkiU4wQ=;
        b=WM87OFwLnP183x1t/ZJ9piOCZWSTEAQ/e+rTfcACaqC+6VB+knooVJU+v54Wp8gOr8
         pF3TR6grRAA4SfwOM+US/+3Y8lKhrta9yheMZZUMhiVXFF7gn4kmYqt9lGcN99rNhDeS
         /E9N+oLBnvbBiU/gcgl7XDzfMNM9mkpIoMlzy/5Jnbx0U9pKUtH924+GwGor+qTso44o
         mhd27gfloNLKFhGUOFPXSwbPdK79y00oBMrTkP9ydMev7lJoFehQnHGLQf3B0slv+m2x
         6P+q+mHfGphaic1/laYPTTMImBKidFaPFwONw83BxWZ4oxEUWB201onkOSVIUxLj73wR
         BS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AmgysG4X1Rf9LeXjKhIGoZjfBo/p5PA6DCR3EkiU4wQ=;
        b=dglLkp5LB3BcjbV8WnlzWZ00eqDbL+/ZDiioza9BPXHvCZhKl9opw2wZ0kmOaeeD6i
         0n+aBOd2YL9nS9orsbt2eOVpFQVHKRAZJMT3p5qKr8xGm7imF7JLirzuFhgufKLyVN8T
         jpWDeVI5h8OKRRMM7ggySD5/uAcp9BzHT4n8MOYq+rpjq8dnt4+veuRLus0GJLiuZwGm
         nLuueO+V0WDq3mrPOn+VUTXIBEAoN+mUJ5BXd6b06FMtIH3e+VDeOvhIvoVaI3VNnMBX
         dTjPF2tAWzgPwL7bK6DdnzpuWkUMEZIvOgW/ukB9ug4xvh7au03gwKWn+8/65oUqsMKj
         09Sw==
X-Gm-Message-State: AOAM5329CzmWsExNkcf+OpD9Mi0iJJSkShyycOu3h3VTvAf/fmDJFQ/5
        NGWj1Vz/Z4K+phqY0/j5w1I=
X-Google-Smtp-Source: ABdhPJwY0+X6GydW9/IVBGp4QE7x9ka/TjKvAIof+YwzJm+k98YIqyPDMi7M5DUyaHEPfKXLbBlgxA==
X-Received: by 2002:a19:ee1a:: with SMTP id g26mr7016457lfb.611.1628549054904;
        Mon, 09 Aug 2021 15:44:14 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id c19sm968742lfc.70.2021.08.09.15.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 15:44:14 -0700 (PDT)
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
Message-ID: <c43ddc6b-32ca-433d-76f2-901cb594eaf1@gmail.com>
Date:   Tue, 10 Aug 2021 01:44:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f58e631d-67a7-4981-ce59-6a4772b44564@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.08.2021 01:26, Dmitry Osipenko пишет:
> 04.08.2021 13:58, Rajendra Nayak пишет:
>> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>  {
>>  	struct of_phandle_args pd_args;
>>  	struct generic_pm_domain *pd;
>> +	struct device_node *np;
>> +	int pstate;
>>  	int ret;
>>  
>>  	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>  		genpd_unlock(pd);
>>  	}
>>  
>> -	if (ret)
>> +	if (ret) {
>>  		genpd_remove_device(pd, dev);
>> +		return -EPROBE_DEFER;
>> +	}
>> +
>> +	/* Set the default performance state */
>> +	np = dev->of_node;
>> +	if (of_parse_phandle(np, "required-opps", index)) {
>> +		pstate = of_get_required_opp_performance_state(np, index);
>> +		if (pstate < 0) {
>> +			ret = pstate;
>> +			dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>> +				pd->name, ret);
>> +		} else {
>> +			dev_pm_genpd_set_performance_state(dev, pstate);

Where is error handling?

>> +			dev_gpd_data(dev)->default_pstate = pstate;
>> +		}
>> +	}
> 
> Why performance state is set after genpd_power_on()?
> 


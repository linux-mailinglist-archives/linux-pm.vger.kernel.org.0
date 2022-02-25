Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F684C4488
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 13:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiBYMXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 07:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiBYMXO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 07:23:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D41DCCDA
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 04:22:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p4so1562617wmg.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OETEWwvv9RFP7XYmInP3bfKnzep+PqGUkb76y2TbWCE=;
        b=aePHe9Yy5kBZxHKom2jnALVrMKuGLj0XXCWvo4FXTH2h3JJQQuN9qZhTYdXHho9GiZ
         KMcbzp3MQAKRs0JPS29Ohg9hCjPIz6E4/sY+5toS6HKaQeC7WlGpHXgnfnO4I2lIDL85
         QiU3ENEhKGSRZZc5V77zpdFtFKNnwY+MT7If429y/Y34008hw0sSP9LxBK9UqSidWnAH
         nD8uwrGy5Hnc1R1bu4SvTljkCWj2ejYPO1tUExSc4Kur0tm1Gjaq/nvgc5cNdS6LtUil
         Z2tkMsvA/ynFVcBYnQIlfTpJbut2W/SibqFNyENpwIX4YmV//Ij4bSmTCVBZ4hSLimPn
         gv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OETEWwvv9RFP7XYmInP3bfKnzep+PqGUkb76y2TbWCE=;
        b=jPGed2RMF0qhvCOJLVpafHSoIUA210my0I1EgAGJTme3hGgAqQ0JcPtglILTpP7wc8
         r8ZEzz+qYfcdnCYv7tKEuJy8yRAb8hcAtYYEKXCACMRengmU17hyz2aoWRyB5/apYtZC
         Fi6iOTWnc9PPozTA5a2a8bGEVrPF5WQGKifu1G9O+bM9P5qXMb4keW1cCR+dMteEeRih
         7Evfr23wkW2hoRhZyDYq6wCLcUevjfiewQVCqdbOl9RmxPM0DSD2pop+hrpyoXcdZxwB
         kpZ+9gUCD7ExTTR0O9RB7qHVFV5WPNQbpzJ+FdjVQUNvI79g25L0pGIKW+aHURjcybKF
         +EjA==
X-Gm-Message-State: AOAM5302SQ3m/2dxVk3vOZI4mOicvDJE7s560S2AIJbCLpB8OYGnJ7G/
        8pA2pp8mnQZ92Ng34sAMIYu1SA==
X-Google-Smtp-Source: ABdhPJz8fEwup5DY7Gel/4fG39qakCdzfviq7s+zlcO2JVDKuhr/zY47COWQpiNf7MwJAwFLO9rkGA==
X-Received: by 2002:a05:600c:798:b0:381:3b9a:6ba3 with SMTP id z24-20020a05600c079800b003813b9a6ba3mr1487826wmo.153.1645791760081;
        Fri, 25 Feb 2022 04:22:40 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id s12-20020a5d6a8c000000b001e32cc8adb7sm2056155wru.107.2022.02.25.04.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 04:22:39 -0800 (PST)
Message-ID: <3a1bd8c0-2522-2f4a-2505-e3a3edfb290c@linaro.org>
Date:   Fri, 25 Feb 2022 13:22:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] thermal: tegra-bpmp: Handle errors in BPMP response
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <YV86cX/omlQa3kpq@orome.fritz.box>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YV86cX/omlQa3kpq@orome.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/10/2021 20:20, Thierry Reding wrote:
> On Wed, Sep 15, 2021 at 11:55:13AM +0300, Mikko Perttunen wrote:
>> The return value from tegra_bpmp_transfer indicates the success or
>> failure of the IPC transaction with BPMP. If the transaction
>> succeeded, we also need to check the actual command's result code.
>> Add code to do this.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/thermal/tegra/tegra-bpmp-thermal.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Perhaps this should be moved into tegra_bpmp_transfer() or some new
> helper to make sure we can keep this consistent across all callers.
> 
> For instance, I'm not sure -EINVAL is the right (or best) error code in
> all the cases. Either way, seems fine in this case and this is certainly
> an improvement, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

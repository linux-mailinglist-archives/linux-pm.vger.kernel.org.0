Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51792C5502
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 14:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbgKZNJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 08:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389784AbgKZNJl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 08:09:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4302C0617A7
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 05:09:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so2067976wrw.10
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uPX5WtnioZEgnMR9Q1L+JTJpZPzfNtcvjnReWuKjp/g=;
        b=u2q8FzMDnqtZA9RS+RdFR/YBqcsAM8vhZoUM8AcwGIyYOHa1cLFQiQIGp0idGay/jV
         hfJa0fdpByabunWMGXAD6Gl+67CCZkUMp9DM+DH4IS4KAUGTCy6ywoBQDmyCjGzpcy8K
         nDh81NJaVH4fDafXXoDxzS3nHtZsZYAkgCMyur942i4trwWO6XGB/jwKnMQQxZEIgqel
         16Ub7WUO//qEjZqsprAiXj/BaKQIssOVdKnhZ0nxKGq2r+niZAtfLVwowU4cfKOC8X34
         jVUNt987SVJ9bhZ16pj+yzIRr/u7RAGZmD0g7hxieTMvBlaEIPAjXc6vpTm8WLUyvmzt
         yK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPX5WtnioZEgnMR9Q1L+JTJpZPzfNtcvjnReWuKjp/g=;
        b=C6hMSl3wlSiJrUq0da0cgHRhPyVAJNfTThMN7t1p+/VjsUeyeuRaXHSu4u8BeUVltF
         VlYuVob9/qkJ/b0VurT2LjwsbJspEgW8rYg7PtRO+oP3XWC5cpkLqWTXqQt/Zb/XkMtp
         nBkVrupvF1/QZwgJSk3NQJJUsDKElxmX2CcDflF4jwjVgk/koWDRUhUGohyT+wpz+QA0
         G0aXVyudTB/bWLTJ9QFktwo/J0/ph+bpHDi8sWZAz17qag5lXosFXv1KvkoZ8PEeshlR
         ojWNqhGdAgFshxG1dm2jYqhjzYKHfd4uDAqGLlGaQKRW0tA+s41eeZNbl0GVyL8W18j4
         4WZA==
X-Gm-Message-State: AOAM530tzDWIwNA+suyKEB3rBp/SU8CRVw18tgZ4OPtjYQ+KpTfih54y
        bPO1cP4xtkVzi/7StWsNWIBKFQ==
X-Google-Smtp-Source: ABdhPJyRnrD4xBuApMK0aBHjnXTYxNNyNq9SVndaTvfq07J8Czhpuvfe4GR//R/RBevvaq4JrCC6Ig==
X-Received: by 2002:adf:de05:: with SMTP id b5mr3793933wrm.131.1606396179220;
        Thu, 26 Nov 2020 05:09:39 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c023:e75f:e8c4:d86? ([2a01:e34:ed2f:f020:c023:e75f:e8c4:d86])
        by smtp.googlemail.com with ESMTPSA id u5sm8140424wml.13.2020.11.26.05.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 05:09:38 -0800 (PST)
Subject: Re: [PATCH v4 0/3] Improve the estimations in Intelligent Power
 Allocation
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, Dietmar.Eggemann@arm.com, ionela.voinescu@arm.com
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <e953e887-0fc7-8375-9e5d-1be339f48216@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f9899f7b-0bc9-40e2-4969-eb76bd11ed5b@linaro.org>
Date:   Thu, 26 Nov 2020 14:09:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e953e887-0fc7-8375-9e5d-1be339f48216@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2020 13:49, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 11/24/20 4:10 PM, Lukasz Luba wrote:
>> Hi all,
>>
>> The Intelligent Power Allocation (IPA) estimates the needed
>> coefficients for
>> internal algorithm. It can also estimate the sustainable power value
>> when the
>> DT has not provided one. Fix the 'k_i' coefficient which might be to big
>> related to the other values, when the sustainable power is in an abstract
>> scale. Do the estimation of sustainable power only once and avoid
>> expensive
>> calculation every time the IPA is called. Do the estimation of PID
>> constants
>> when there was user update via sysfs to sustainable power.
>>
>> The patch set should apply on top next-20201124
>>
>> Changes:
>> v4:
>> - added new function get_sustainable_power() which handles use cases
>>    when the value should be estimated again or simply returned
>> - added sustainable_power in the power_allocator_params to track if there
>>    was a change to sustainable_power by the user via sysfs
>> - addressed Daniel's comments that sustainable power set via sysfs should
>>    trigger PID coefficients estimation
>> - removed 'force' argument from estimate_pid_constants() and make it
>> ready
>>    for updates due to new value for sust. power from sysfs
>> - abandoned the design from v3 with a single function responsible for
>>    estimation both sust. power and PID const. requested by Ionela
>> v3 [1]:
>> - changed estimate_pid_constants to estimate_tzp_constants and related
>> comments
>> - estimate the PID coefficients always together with sust. power
>> - added print indicating that we are estimating sust. power and PID
>> const.
>> - don't use local variable 'sustainable_power'
>>
>> Regards,
>> Lukasz Luba
>>
>> [1]
>> https://lore.kernel.org/lkml/20201009135850.14727-1-lukasz.luba@arm.com/
>>
>> Lukasz Luba (3):
>>    thermal: power allocator: change the 'k_i' coefficient estimation
>>    thermal: power allocator: refactor sustainable power estimation
>>    thermal: power allocator: change the 'k_*' always in
>>      estimate_pid_constants()
>>
>>   drivers/thermal/gov_power_allocator.c | 76 +++++++++++++++++----------
>>   1 file changed, 49 insertions(+), 27 deletions(-)
>>
> 
> Gentle ping. This is a self contained change to only power allocator
> file. It addresses also your requirement regarding sustainable_power
> changed via sysfs.
> 
> Could you take it please? It should apply smoothly in your tree.

Actually, I'm waiting for Ionela and Dietmar ack.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

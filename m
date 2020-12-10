Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A72D5BB9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 14:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgLJN2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 08:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbgLJN2W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 08:28:22 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF6C0613D6
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 05:27:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r7so5468991wrc.5
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2NP+PKYJsDPow7exxFRK74sky0Q+Dn5/x2QpUWD/y/w=;
        b=Lwwv4gDzwfzwvBO0TABco/Arr9IrL0hEp2TOuhU/YvE8nfGngK6VplpBvilgt79Jl2
         uCCAoTvDJNRTPGYc85XT4anSUYifttzmA2Jn6mQuvrBczZXdvs7NtrSFxzMVaOmCrgxI
         9iHLh2WGQQz2C/kK9c1zYMM2M22RlxgxmnG8rnwFvhkbTOWdxQ66fJ/X5I0PFnOm4rHB
         K9mjdPOGpeIvS0Xplk9a+8Z3ibF+TmKGp/XWc/sP3HWs85LSpedt6x3damNZCF26dRTF
         yjg8hG73k64ZZZ6yRZ56pIBTF4J+8Ddm0zB1aZ0Er71asLTzVbipc5otKdKl/eaY82dT
         MlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2NP+PKYJsDPow7exxFRK74sky0Q+Dn5/x2QpUWD/y/w=;
        b=WFOEIbQvVdHkSFGsLENkRuCHLx+zscwXz+rrdaN52rFo8QZBljGuc3PYmZS+ZbVSnS
         tLLb+MXXnc0zGhj8FMk4vOcMwmKFvRiESi9iQgnZhEr3NC9Yz5ZhGdAfdGj8bueTPucs
         cT4j1ZLuqRlQ9ZYaENOKHp+RzbZ7qLKAEf2yaDZ3djbRUT8VTi16Tq92DjdzotN1GjtT
         W0raNWLbOtuHvohAfo5gn9XMHTizfg+sbrZjhXlWDJEKsqlCNqLVK5NKGw1JqnStRO2x
         JK3nqWWByL6zbmIVpixzTxuhtd04XsiRGb9Nm/xWUZjV8qINUiu3AKLth58YQhOn9tbL
         J91Q==
X-Gm-Message-State: AOAM5325Q3SSsFIRl0Xs/LhElHisyCHZMmlbe4SfAXknb7A/3zCTmoN7
        KTqkQlmbClYfZH6RSJ4D1YiK8qrqKmC8Ow==
X-Google-Smtp-Source: ABdhPJye4M7FEunH3OAWlEPqendaSIuQgiNdl8g0otyEERNQIKw41jhXBKPIWax3tjyG7vmLm7nT8w==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr8280624wrv.397.1607606860594;
        Thu, 10 Dec 2020 05:27:40 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4ea:d408:1aec:e109? ([2a01:e34:ed2f:f020:4ea:d408:1aec:e109])
        by smtp.googlemail.com with ESMTPSA id j15sm9326990wrr.85.2020.12.10.05.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 05:27:39 -0800 (PST)
Subject: Re: [PATCH v3 0/5] Thermal devfreq cooling improvements with Energy
 Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201209103016.10442-1-lukasz.luba@arm.com>
 <383b757b-63b0-ca81-c74c-bf2f31172bc3@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ec7154b7-da86-eda7-0668-9af18d2a82c9@linaro.org>
Date:   Thu, 10 Dec 2020 14:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <383b757b-63b0-ca81-c74c-bf2f31172bc3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/2020 14:22, Lukasz Luba wrote:
> Hi Daniel,

[ ... ]

>> Lukasz Luba (5):
>>    thermal: devfreq_cooling: change tracing function and arguments
>>    thermal: devfreq_cooling: use a copy of device status
>>    thermal: devfreq_cooling: add new registration functions with Energy
>>      Model
>>    thermal: devfreq_cooling: remove old power model and use EM
>>    drm/panfrost: Register devfreq cooling and attempt to add Energy Model
>>
>>   drivers/gpu/drm/panfrost/panfrost_devfreq.c |   2 +-
>>   drivers/thermal/devfreq_cooling.c           | 420 ++++++++++----------
>>   include/linux/devfreq_cooling.h             |  40 +-
>>   include/trace/events/thermal.h              |  19 +-
>>   4 files changed, 240 insertions(+), 241 deletions(-)
>>
> 
> If you consider to take it, please don't. 

Ok, I'll wait for the v4

Thanks






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

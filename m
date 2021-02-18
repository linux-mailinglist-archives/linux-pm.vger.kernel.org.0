Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF531ED16
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhBRRO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhBRPNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 10:13:48 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25ADC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 07:03:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m144so2291517qke.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 07:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p89DwoOOsvw+CnJ+KQOJKP+OK4RgyV7iDfRp7yPRuZo=;
        b=sgctuxKei7vpMxAFsHQIa8x6kCjgbaZvDkmVddN/LebhlxKF/pKp6tjD2DTiXUgLCt
         1cz7XUznrCNS7chrttB3GVbH2iITgGkEtzHzD1aLraA2mGEz1aU8d0vo+6V19zbzlTQp
         t4u5OBodgkj8GBJO1U6v4tGZz9yUUMo/kB720eV6RZjLH15grwDdYcBBTitxrohj0hGy
         HZ4oJUxIow1RUSGGTJttrInJn2tM97F6Ii1y9uIIduW/WO9LxAmlO3z8ZCTcL/jHMFxW
         Pqgm2El0fVG5MnU9qCwEGnKK7g37Y18a6/jWLnMR7yIruP1Rw4mrmzXr3vQQCSS8Aovn
         T7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p89DwoOOsvw+CnJ+KQOJKP+OK4RgyV7iDfRp7yPRuZo=;
        b=k94F06IUmBRzwwKNoaz5gxT660HPz12qDaNBEJ1gTOkADkwQhogKrDYa/OGynOt9yJ
         lEwqLVii/tqawms4wR7QgkDn16qDmOy6SrcbBi2902h2R7xP6OMIQeNaV+xx2i71J64a
         i1Mb702AkHzQrj6w4BdwEWjFeRarlcQ+BuIuoH1YArb5byOoJKTnjhG5E/XTKT8Wkp8l
         Vxq3ElwxUR+0zaKRmLy5E/fwQiWxS0yILl+/TGaxbqCYLqiE5jLrQjUIyDl0Kj/8UnBf
         ulf1/G7+qtVg6SDRJOa8r3hTOLE4ZuGltA2/jVDGNptte1F8bdVAxb6v2MjdDRvjrR7W
         AgZQ==
X-Gm-Message-State: AOAM532Qxv7snZClBmzPQsB/H6Ql/wRKBC9xwaQP9gdsdwpPOshTGCJ7
        2vH6NR4wm3wCzfj5Cbh9abSWBA==
X-Google-Smtp-Source: ABdhPJwHIjGq2Qhgr/H2XVcUdMeLSumIo6vhlXYJH+GBjSxPPlh97AiMJ2XZSq5xQoedh4g2E5DQBA==
X-Received: by 2002:a37:8b84:: with SMTP id n126mr4461711qkd.223.1613660602315;
        Thu, 18 Feb 2021 07:03:22 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id u133sm4135077qka.116.2021.02.18.07.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 07:03:21 -0800 (PST)
Subject: Re: [PATCH] cpufreq: exclude boost frequencies from valid count if
 not enabled
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210217000013.4063289-1-thara.gopinath@linaro.org>
 <20210217055029.a25wjsyoosxageti@vireshk-i7>
 <4c9d9d44-5fa5-3ae1-e9bb-45cf6521b764@linaro.org>
 <20210218084847.743rttqwlmwyx6pz@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <d693d999-7734-3e69-edb9-9e03fd2f0d1a@linaro.org>
Date:   Thu, 18 Feb 2021 10:03:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210218084847.743rttqwlmwyx6pz@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/18/21 3:48 AM, Viresh Kumar wrote:
> On 17-02-21, 10:32, Thara Gopinath wrote:
>> First of all, I am still unable to find this setting in the sysfs space.
> 
> The driver needs to call cpufreq_enable_boost_support() for that.

Ok. that makes sense.

> 
>> Irrespective the ideal behavior here will be to change the cpufreq cooling
>> dev max state when this happens.
> 
> Hmm.. recreating it every time boost frequency is enabled is like
> inviting trouble and it will be tricky. Maybe it can be done, I don't
> know.:)

Scheduling a notifier for max frequency change from the qos framework 
should do the work, right?

> 

-- 
Warm Regards
Thara

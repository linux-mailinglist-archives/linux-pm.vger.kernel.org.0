Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7663A1BAF48
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 22:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD0UWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 16:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgD0UWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 16:22:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9AEC0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 13:22:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so22042565wrm.13
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdxiERottlKcy9xyHsKmHd0rKuRvpCIt300WZLvvdRc=;
        b=cGHu5ZZTmqk4aLVWy7b6f5E9Yr4Lz6ZhEhVQypPl32nTL6LQlL7SlIsJwlXCtS4zVQ
         lbB6S8SNBB3SgT1IUuIUijWwvVTF2aFSfc3M/Tg7cooKKR3oPLsGYFGmxOL+8VisoaPx
         mivQFkm6EcrAyfRrcKdnbzGaPqruajVAZZwZZJ3H8fznwn23WlPGw49PfOU6l42b698J
         ukvV5fhquMWKeSijBkf+8+a/NzVvsVHGmRCfKyPsScRG4ThTyPlAg1BhFADYFGmsfS6O
         6F0F0uuD34WqwUtXfVvgLsmpTAwqsKh1OyQ/MUhpym9nKm7CXlHLseirzLzARQSg0SY6
         y2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdxiERottlKcy9xyHsKmHd0rKuRvpCIt300WZLvvdRc=;
        b=YpFujx5Ewr9JlrisGY4OxNv12HNqrKXP9nmXwttFOVzv7ZakfHOwbVkV78rXAOqQlk
         JpoNGtd9K+skLygz+aDScId+dtz+DW0AkVCk8C3MCqXtI2t3y3imEpn5UQRtxW4OkRvD
         fDw5EOgWV2S/Mgvn96V3Xn9AV09dWVUmshxL0BSE0VsCqco1MkVJI/AkQ/wuxQ5S4Ylr
         lQTzOLRJvfdinShxOQuCYJbr7/0s1o8aiwtpixSEVYTKiZKJaDos7rpX9LcfUWYVof9l
         QielhmqBt/lXnoxUOvEY8GULHZ47qUUktycY9H90vcnc008fxW3NcqNLubs1R5Sl+Dwe
         MPEQ==
X-Gm-Message-State: AGi0PuYAl4QaBYXycR8hTmiRU8osWBwHttTokqoXg93WhyKRY7uR83RE
        vX7SfUt9l8pr3iUqmTYgex+nQA==
X-Google-Smtp-Source: APiQypLSB+bfRu/8oBH4g7YFKHVP5pOAEdbPo/3OUsn6zQey/fT1bmZfOPWIoXJlOj7xHKKwuyhfLQ==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr31013136wrt.16.1588018952612;
        Mon, 27 Apr 2020 13:22:32 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id h3sm22116089wrm.73.2020.04.27.13.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:22:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
To:     gao yunxiao <gao.yunxiao6@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     amit.kachhap@gmail.com, javi.merino@kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7>
 <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
 <20200422095433.br2zgpzm7f66ydhi@vireshk-i7>
 <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
 <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f6a57336-a591-09df-49f6-7f80cc6ddfb4@linaro.org>
Date:   Mon, 27 Apr 2020 22:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/04/2020 13:11, gao yunxiao wrote:
> On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
>> viresh
>>
>> On UNISOC platform, CPU's temperature can not be controlled when
>> cpufreq has been limited to the lowest frequency, we have to hotplug
>> out CPUS to mitigate temperature rising.
>>
>> adding platform callback to have a chance to check whether the
>> normalised power at power2state() is lower than the power
>> corresponding to the lowest frequency. provide an example in another
>> patch

You can use in addition the cpuidle cooling device if the cpufreq
cooling device fails.

Add two trip points. The first one mitigated by the cpufreq cooling
device and the second one, with a higher temperature, mitigated by the
cpuidle cooling device [1][2].

For my personal information, does the platform support voltage scaling?


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/thermal/cpu-idle-cooling.rst

[2] https://lkml.org/lkml/2020/4/14/1442



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

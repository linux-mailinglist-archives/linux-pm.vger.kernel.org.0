Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDF190001
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 22:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCWVIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 17:08:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33652 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgCWVIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 17:08:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so18971183wrd.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=687KbESYiM8wnn56HtrynedT82uRKZ3AZhgE3NNrRms=;
        b=i6vsEh9sk9T5FjlwJB2CkTMmncnXIwZATtDWZ993D5G3H+J+yOfLATSaN2/6NnVRSJ
         20mY+60XGp6xp6R0UpqhlvuR/BDpQtEFvmNrSd7A+qH5WV1Nfs2TvmF5es3Z3/3ZC/NP
         ZyYDRFFl7sgZV52dYqK2sbmaPuOEi9AM8rxYzz1rNvLGM0o6/k2KTqfYY53H43clQKFu
         s8o8ccIZ4xFq9yVuzX3oQwKWitIzR+yY+gjkVMoTX8kuUyFhHgyCzvn8lgGcaP/xis1f
         JNWIsgW95OHu4SeBB/NSfj0Ql5z/vMTU+DUqVdDsqogAaFMMCUmRiQvVIrjpa/aLhbJV
         CLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=687KbESYiM8wnn56HtrynedT82uRKZ3AZhgE3NNrRms=;
        b=NswO61OkJnrO/nvzSymkYsSOo3axect3CE1GFTHgc1R+VodlXTSHSfngmAxNhIJqw2
         8ZSvgmuG1BhwfHQ5j6NdnGIUA6VtTzWMqzLC+spJRTpbwhQWuL1/kscn/oYdj3Yuk9n+
         lvpOOdkv+dFQRMwQ8hR6CzjLFqB1iPueVgM6baLOONT4Ty3B1k2jKWPK7sMvUl9YIkrL
         w+aArO1qyzyw6yIteeypyQLCaL7rfDjmIBE1fmbxbZE73QPeEU9sv8F3g56ZoAnaO1L9
         5LleWQ/pngxsJLm0SOB36GZDW34F2bk8xzLe45w6A1GqgNC8PiQGqUz1vTgRIi5FlpCv
         gIuA==
X-Gm-Message-State: ANhLgQ3MXcMwu2X5RsmHz3Etxxk06f6VaPKZuVzHGaGzERDXaajWW5n/
        RPQtnXnlmEoQN+8uQNf1zIX5lg==
X-Google-Smtp-Source: ADFU+vuz/4XfJK2Sx1f5DAGVmlNqDFqEUCqFcboYTwx1ksJnRI6lnxOt92rS0gOTlb5OrAIsZGjtbg==
X-Received: by 2002:a05:6000:114f:: with SMTP id d15mr33290917wrx.143.1584997720974;
        Mon, 23 Mar 2020 14:08:40 -0700 (PDT)
Received: from [192.168.0.43] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id d5sm15962265wrh.40.2020.03.23.14.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 14:08:40 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of
 cpufreq_set_cur_state
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
References: <20200321092740.7vvwfxsebcrznydh@macmini.local>
 <CAHLCerOFg30GEaQgV=4ccgA1fG6P3OTgaG33pw-3YCtuD5mSmA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b30a2e5b-5fa6-9761-efe1-d3b5396ceaaa@linaro.org>
Date:   Mon, 23 Mar 2020 22:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerOFg30GEaQgV=4ccgA1fG6P3OTgaG33pw-3YCtuD5mSmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2020 22:05, Amit Kucheria wrote:
> Hi Willy,
> 
> On Sat, Mar 21, 2020 at 2:57 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>>
>> The function freq_qos_update_request returns 0 or 1 describing update
>> effectiveness, and a negative error code on failure. However,
>> cpufreq_set_cur_state returns 0 on success or an error code otherwise.
>>
> 
> Please improve the commit message with context from your earlier bug
> report thread and a summary of how the problem shows up.

I've improved the commit message when applied:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=testing&id=ff44f672d74178b3be19d41a169b98b3e391d4ce

>> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>> ---
>>  drivers/thermal/cpufreq_cooling.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
>> index fe83d7a210d4..af55ac08e1bd 100644
>> --- a/drivers/thermal/cpufreq_cooling.c
>> +++ b/drivers/thermal/cpufreq_cooling.c
>> @@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>                                  unsigned long state)
>>  {
>>         struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>> +       int ret;
>>
>>         /* Request state should be less than max_level */
>>         if (WARN_ON(state > cpufreq_cdev->max_level))
>> @@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>
>>         cpufreq_cdev->cpufreq_state = state;
>>
>> -       return freq_qos_update_request(&cpufreq_cdev->qos_req,
>> -                               get_state_freq(cpufreq_cdev, state));
>> +       ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
>> +                                     get_state_freq(cpufreq_cdev, state));
>> +       return ret < 0 ? ret : 0;
>>  }
>>
>>  /* Bind cpufreq callbacks to thermal cooling device ops */
>> --
>> 2.20.1
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F226DBA0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgIQMdv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgIQMdW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 08:33:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF4C06174A
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2020 05:33:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so1877266wmm.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2020 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lSmbmSp0vTLjkpjcwc95ATbPKvR5uzI8SEkr43DYMdw=;
        b=cwflIlv1fOV5pfkvMZO++S3xQGizRiz3OlTTI1yyFgQ1RKH8t80pYLJZXn56J1nJKF
         MGWcuRc54Etd0RZXzfnTtM09DCDIIsRZcJboumPTCmYM7fSwPvAfc0apDIe+vu35EuaB
         uFAG1eG1ZAjQms6AvF94xXJwyyXAj9C9FTKBWIUIIsdrt9jwrIFqLdntvAZaDBjYXHtl
         wt70ZFiMHowCa/qZPBbzMSNcM4R7EF8GqdKpbtlwVwQ898xWmORMPXiI4lO5Z/5WPZF5
         VzsSCPERoRDLEZDQNFuRmu1sd3mPIsAShAv9JFzPCsxPdOotCNb9u0+AU3hg/86ky+qr
         FQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lSmbmSp0vTLjkpjcwc95ATbPKvR5uzI8SEkr43DYMdw=;
        b=t75Y5ZONZEmULiTedGrq8gBX+TRfSDIgydRRMDh13i030mWiTf3SPiVncjFZMvRfkd
         Fk0REFsL6d/RyfodmXkupBv3rJUh0f9ujIt0qgulYMV1TW/mR/2uFdjJuUm1Z3zcpDqj
         2VPjUtfosoda45wygdlANe+4y7UwYqXZPewFPl88/awhWAYhrhyJrLNIq3KGQMji1Oso
         ILsVtYillqUj7jOXTnRknYpnBVDSdoaBjCnJFC1ihi9tGqUqtPeDqgpIiT5CEkLyCc/q
         KhCGedGdfUeSTdH1Iy01fohvQq9aCNtIy4CASVRJaKbWpLWsuIDm1BpgBfLUs7nMu0dw
         KXfw==
X-Gm-Message-State: AOAM530ZsvooxKQnqLjhqI1X/MjTmvKd1u1ti23U8gP1VQMDXA6/mUPJ
        iYi3Rbppzk6jjocPpdbxLcRHDDLFwXPYqc0u
X-Google-Smtp-Source: ABdhPJx8C5DUkFdyQvBVG3t6Qjy71GoM60WhVQfU91ytC7Jw3n/jtHODvaamTau0i+WocGKKzGcvyQ==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr10273808wml.50.1600346000592;
        Thu, 17 Sep 2020 05:33:20 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9934:ad8d:e364:de32? ([2a01:e34:ed2f:f020:9934:ad8d:e364:de32])
        by smtp.googlemail.com with ESMTPSA id r14sm38800456wrn.56.2020.09.17.05.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:33:20 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Change the set_cur_state
 function
To:     zhuguangqing83 <zhuguangqing83@gmail.com>, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, zhuguangqing@xiaomi.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <19e301d68ce3$de5f9840$9b1ec8c0$@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d1367763-335a-53ba-d4fc-7b02dbd59c88@linaro.org>
Date:   Thu, 17 Sep 2020 14:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <19e301d68ce3$de5f9840$9b1ec8c0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/09/2020 13:15, zhuguangqing83 wrote:
> 
>>> From: zhuguangqing <zhuguangqing@xiaomi.com>
>>>
>>> In the function cpuidle_cooling_set_cur_state(), if current_state is
>>> not equal to state and both current_state and state are greater than
>>> 0(scene 4 as follows), then maybe it should stop->start or restart
>>> idle_inject.
>>
>> Sorry, I don't get it.
>>
>> It is an update of the state, why do we need to restart the idle
>> injection ? The state change will be automatically take into account by
>> the idle injection code at the new injection cycle.
>>
> 
> Thanks for your comments.
> 
> For example, we call cpuidle_cooling_set_cur_state() twice, first time
> the input parameter state is 20, second time the input parameter state
> is 30.
> 
> In current code, in the second call of cpuidle_cooling_set_cur_state(),
> current_state == 20, state == 30, then "if (current_state == 0 &&
> state > 0)" is not satisfied, "else if (current_state > 0 && !state)"
> is not satisfied either, so we just update idle_cdev->state to 30 and
> idle_inject_set_duration to new injection cycle，but we do not call
> idle injection code.

Ok, I think understand your question.

When the idle injection is started, a timer is periodically calling the
function play_idle_precise() with the idle duration. This one is updated
by idle_inject_set_duration().

So when the state is changed, that changes the idle duration. At the
next timer expiration, a few Milli seconds after, play_idle_precise()
will be called with the new idle duration which was updated by
idle_inject_set_duration().

There is no need to stop and start the idle injection at each update.

The new value is take into account automatically for the next cycle.

It does not really matter if the update is delayed. Restarting the idle
injection at each update will be worth in the cooling context than
waiting an idle cycle.

> In the example mentioned above, we should call idle injection code. If
> idle_inject_start() takes into account by the idle injection code at
> the new injection cycle, then just calling idle_inject_start() is ok.
> Otherwise, we need a restart or stop->start process to execute idle
> injection code at the new state 30.
> 
>>> The scenes changed is as follows,
>>>
>>> scene    current_state    state    action
>>>  1              0          >0       start
>>>  2              0          0        do nothing
>>>  3              >0         0        stop
>>>  4        >0 && !=state    >0       stop->start or restart
>>>  5        >0 && ==state    >0       do nothing
>>>
>>> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
>>> ---
>>>  drivers/thermal/cpuidle_cooling.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/cpuidle_cooling.c
>> b/drivers/thermal/cpuidle_cooling.c
>>> index 78e3e8238116..868919ad3dda 100644
>>> --- a/drivers/thermal/cpuidle_cooling.c
>>> +++ b/drivers/thermal/cpuidle_cooling.c
>>> @@ -113,7 +113,7 @@ static int cpuidle_cooling_get_cur_state(struct
>>> thermal_cooling_device *cdev,
>>>  /**
>>>   * cpuidle_cooling_set_cur_state - Set the current cooling state
>>>   * @cdev: the thermal cooling device
>>> - * @state: the target state
>>> + * @state: the target state, max value is 100
>>>   *
>>>   * The function checks first if we are initiating the mitigation which
>>>   * in turn wakes up all the idle injection tasks belonging to the idle
>>> @@ -130,6 +130,9 @@ static int cpuidle_cooling_set_cur_state(struct
>>> thermal_cooling_device *cdev,
>>>  	unsigned long current_state = idle_cdev->state;
>>>  	unsigned int runtime_us, idle_duration_us;
>>>
>>> +	if (state > 100 || current_state == state)
>>> +		return 0;
>>> +
>>>  	idle_cdev->state = state;
>>>
>>>  	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
>>> @@ -140,8 +143,11 @@ static int cpuidle_cooling_set_cur_state(struct
>>> thermal_cooling_device *cdev,
>>>
>>>  	if (current_state == 0 && state > 0) {
>>>  		idle_inject_start(ii_dev);
>>> -	} else if (current_state > 0 && !state)  {
>>> +	} else if (current_state > 0 && !state) {
>>>  		idle_inject_stop(ii_dev);
>>> +	} else {
>>> +		idle_inject_stop(ii_dev);
>>> +		idle_inject_start(ii_dev);
>>>  	}
>>>
>>>  	return 0;
>>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

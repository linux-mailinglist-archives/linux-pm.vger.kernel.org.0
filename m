Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2094BBC88A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfIXNCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 09:02:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46704 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfIXNCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 09:02:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so1327423pfg.13
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=79190FXhTiPYIFVHmeDnpGs9dUmtrTyVRMPQuDYMVaE=;
        b=jANpL5E41vxSN8dE0kysWF1E1Banw4ayZvPi79WjX7YyKZtSxxn2bwv4xThBXZTyuF
         7uWePoGilgQEAlQ3xYxSfa8arShZxqaMEBhXwiVbP1w5AVYadqYh6Jyq8Qd02Iy+f+MG
         hPcXPZF0OFzgbKFi61u1dglOdChmrIAl4To6zW1rukU3TOY3a1jYbc8pZR0KPN/+Ah87
         FNTszcyNZ2MBoDa1XHkNtCV95AK8HCdEWx7E4M42qfQq2glZxF6tMg8imMGfr/ImWico
         AQTjrMlNoaakG7DXrcXkoCjtmO7pGfxfkGCRInI17P2Lpn68s139vTiQPzes0qPdpg3F
         w+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=79190FXhTiPYIFVHmeDnpGs9dUmtrTyVRMPQuDYMVaE=;
        b=YS/jI6eim+1R1iZHzJ7kBddS1BqGAhTT0QD3+YTTMRohOZpFKiuVBDl9surPOXwyAc
         135mDGHN0pTnV5MDKXdruwlpaBq50fmmAit+1YLCcnTDLIsdF3aQmpqlLWzCZsv7+uzL
         7ge5nwmWDXInUyFBoaP3UZImLnSpEQ9Td8n4gIOa9WFM9MDyzzu4qOyI3xQf2us4NRmA
         0WNN65Bd5o8FB8Wn6bIYI9BnNQsG0lSsdeVhMUzpADHxVau1K7kZRsd6R3nKgZKEw85U
         MU9cVg/A+gLohZCWP8dBqPJbFxoPO9cp1KEfvQ/lq+W9VS5CEFRQgxmdgGcKXJiMxFKu
         Gzng==
X-Gm-Message-State: APjAAAW/oS3gtqoDUQkzFHk38eV7P73ftR/l5ofZUq4VsI7Ih+okzDNO
        Ct1sHLTgRUjFOYDOLtMJ0HOFhw==
X-Google-Smtp-Source: APXvYqxgXO/UYcpC1iCPakoePNlXXNqo69DUb79/l+yT377CN74jg44D/X8zgUZcRfesh+sfhBA8XQ==
X-Received: by 2002:a63:1c56:: with SMTP id c22mr2966201pgm.231.1569330173498;
        Tue, 24 Sep 2019 06:02:53 -0700 (PDT)
Received: from [172.20.32.102] ([12.157.10.114])
        by smtp.googlemail.com with ESMTPSA id p68sm6079925pfp.9.2019.09.24.06.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:02:52 -0700 (PDT)
Subject: Re: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state
 to inject
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
 <20190909145015.26317-3-daniel.lezcano@linaro.org>
 <20190918193554.GC24433@xps15>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f90bcd0c-e937-54f7-0dae-0e9d9ed45a41@linaro.org>
Date:   Tue, 24 Sep 2019 15:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918193554.GC24433@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Mathieu,

On 18/09/2019 21:35, Mathieu Poirier wrote:
> On Mon, Sep 09, 2019 at 04:50:15PM +0200, Daniel Lezcano wrote:
>> Currently the idle injection framework only allows to inject the
>> deepest idle state available on the system.
>>
>> Give the opportunity to specify which idle state we want to inject by
>> adding a new function helper to set the state and use it when calling
>> play_idle().
>>
>> There is no functional changes, the cpuidle state is the deepest one.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +/**
>> + * idle_inject_set_state - set the idle state to inject
>> + * @state: an integer for the idle state to inject
>> + */
>> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
>> +{
>> +	if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
>> +		WRITE_ONCE(ii_dev->state, state);
>> +}
>> +
>>  /**
>>   * idle_inject_start - start idle injections
>>   * @ii_dev: idle injection control device structure
>> @@ -298,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>>  	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>>  	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>  	ii_dev->timer.function = idle_inject_timer_fn;
>> +	ii_dev->state = cpuidle_find_deepest_state();
>>  
>>  	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>>  
>> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
>> index a445cd1a36c5..e2b26b9ccd34 100644
>> --- a/include/linux/idle_inject.h
>> +++ b/include/linux/idle_inject.h
>> @@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>>  				 unsigned int *run_duration_us,
>>  				 unsigned int *idle_duration_us);
>> +
>> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
>> +
> 
> The above function is not used in this patch and as such should be introduce as
> part of future work.  Otherwise I agree that this patch does not carry any
> functional changes.
> 
> Without function idle_inject_set_state():

I was about to remove the function but actually it may not make sense as
the idle_inject is a framework providing the different API to do the
idle injection and the function is an helper to set the state value. It
comes with the addition of the state number in the structure.

Next patch is the idle cooling device and makes use of it.

Can I still consider your acked-by valid?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


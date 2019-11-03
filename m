Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26AED3AF
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 16:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfKCPZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 10:25:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43830 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfKCPZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 10:25:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so4006514ljh.10;
        Sun, 03 Nov 2019 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rn9KeNDT4iKdtNBCSH/cL/Z9GtPYoGbYGu5A9HzK+V8=;
        b=aE/p2FZzEKu66BHJpH4hj/dEDXQxyxWCua3xFzwKaHe96+IqbqAZXWZ1HxJfYa+fZq
         vC1ViJa2PsNRG45cQ+AstJS0+7eLZC2QkBcw9fkLaGyNvu/18xfnyhSFaDktZ2NngReA
         ke4jYoVYTdkf2TzqyqyrKHAbpAucd9C2AXHnwIJS+I3TTwVncu9uY5jAjUyCAKpKEp+4
         6jY3mtkliZbn1K5Ai7NlxacFZw66GV4rL+WhnTC0peCc2729BDsLhIa1xh8+rCN9uaAp
         fYJcl5K83+hTGMV1WSo0B+9OtEfUwu0ofXDvrWyhsUI3ir0zWBBZoBSGPGHRMJlfz7Nc
         kLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rn9KeNDT4iKdtNBCSH/cL/Z9GtPYoGbYGu5A9HzK+V8=;
        b=fBEAR4qPVhh5+B9r4zBa0a/JsdpRUWqr1w/Iv7oTeql4VMfkkatCuow/go5tTDHrSF
         5iVGK2oMZkzeLz+h5CnkCvyadmLAvgcDF+U0De/xHXu9/N64CQa31OuqhkgHPKt//bDr
         FDNS1dABY6waowM8iNFItIAF0WItmqES44vwl3kv6OkmSgkofyWPuKgw3W1DO+Hhv2pR
         zZgk35+ZMskdTGmWvVbjVdudP2W00KAsIln5ufTfXyyZ/litcpr8TMri96eZV3JTxQAj
         rhCHbkAkbxSrKWwtieTCGDknOOodqY/t9IgPqDwHSXocIcA4qjabqeXNo50BkHnlUDDO
         KsSw==
X-Gm-Message-State: APjAAAWMCl4zzCYuVTVUm99MNDVB/jFyE1nmf8WnkNOCNwjG8dt11nxa
        LzMJfbvl0KGWee33cm/7vU9Jzq6q
X-Google-Smtp-Source: APXvYqybUK3ykGyF1yNXnJXyTeInwvIxLz2b6crTmz2O69lefh6fgNByWl410QpolqgTMdDb+P3uiQ==
X-Received: by 2002:a2e:3016:: with SMTP id w22mr15687484ljw.117.1572794721360;
        Sun, 03 Nov 2019 07:25:21 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id q26sm5372252lfo.65.2019.11.03.07.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2019 07:25:20 -0800 (PST)
Subject: Re: [PATCH v7 17/19] PM / devfreq: tegra30: Support variable polling
 interval
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191029220019.26773-1-digetx@gmail.com>
 <20191029220019.26773-18-digetx@gmail.com>
 <20191101215816.GB8724@qmqm.qmqm.pl>
 <590f47a4-c75a-e8c9-88b8-b3cd98578969@gmail.com>
Message-ID: <71a16d74-5908-ea97-ae98-4b7d0e99a765@gmail.com>
Date:   Sun, 3 Nov 2019 18:25:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <590f47a4-c75a-e8c9-88b8-b3cd98578969@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.11.2019 01:23, Dmitry Osipenko пишет:
> 02.11.2019 00:58, Michał Mirosław пишет:
>> On Wed, Oct 30, 2019 at 01:00:17AM +0300, Dmitry Osipenko wrote:
>>> The ACTMON governor is interrupt-driven and currently hardware's polling
>>> interval is fixed to 16ms in the driver. Devfreq supports variable polling
>>> interval by the generic governors, let's re-use the generic interface for
>>> changing of the polling interval. Now the polling interval can be changed
>>> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
>> [...]
>>> @@ -308,7 +308,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>>>  	unsigned int avg_sustain_coef;
>>>  	unsigned long target_freq;
>>>  
>>> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>>> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>>>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>>>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>>>  	target_freq += dev->boost_freq;
>>
>> Noting a comment in patch 13, if this is hot path you could try reciprocal_divide().
> 
> Hello Michał,
> 
> This not really a hot path, I just wanted to optimize that case to keep
> things a bit nicer.
> 
> Please take a look at the arch/arm/boot/compressed/lib1funcs.S, firstly
> it checks whether divisor is a power of 2 value and then takes optimized
> code path that uses a single shift. Hence the patch 13 still applies here.

On the other hand, there is now only a single case of the division by
polling_ms in the driver which won't bring much benefit, so it indeed
makes sense to skip the patch 13 for now.

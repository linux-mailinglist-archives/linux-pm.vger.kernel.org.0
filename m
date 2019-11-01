Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACFEECB50
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 23:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKAWXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 18:23:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36940 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAWXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 18:23:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id v2so11714492lji.4;
        Fri, 01 Nov 2019 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZtYy8JIoPhclpxplgGaYgaB4fxX4wiQ7tc8XNEC8Bx0=;
        b=d1lRCCjtx3wCBamI6MROflNdX9OFkuv1AbxijfmzU9uEtbGPU+0Me3Rc1qHhjJ4CDb
         hectN2uXw09c4XQyyRQSh/fOL+Uk/6p3kATNtFGDhHnOvI0y+vH7X5FnYywLcZpBZzZZ
         B7sTfZtc+kLxC6JuKDPZ86hIjLiUBaVEiet/X6QoVWAD8QPKpLtdCmGdvg6hTx84IDfV
         Bk85a725iwQpxvZhtlqeD6pApa0MWJc6r7TqnB6hFUFvGnKk0P4mYvIhEfKWR6ZyaWLc
         ULLLWpB3Se0tC3VhScFi6ku3lokkujvIF+W4h/7VcJ0dCpGIQXxQ/sUqLAXmxTCP+9uD
         hZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZtYy8JIoPhclpxplgGaYgaB4fxX4wiQ7tc8XNEC8Bx0=;
        b=mZRRWPkUISPlexKmLtw3TtZ8N7xNWP8+PqJa5zvF3NlJXXB+PrBrYzjH4ccs/XeXlw
         rUzsgf1/Ex3WawA/0hRbpPDA7JyiKt2Iw0ZlzeYt2d4fIS5iVNvdBhmprbcJSoAUIZ4q
         4r/UjvkmMc3hIxQItrj5nnHn52YeEd5MsvLeJEmMWAN2dO3VjIm9cSRCOyPFxSQCe88D
         IaINBc017nIxkRHtq73mmNoMiAqCF7wag0PssUvQ/v9/Bna0p0z/YkArz1hdwf2f5lO/
         expWtB/A/y85UFXIyAMZ5fIVz4sVe1NxCfs9lOBGvhBgOIMJsDOsF2GVB4Gc+Wpic2um
         ZF3w==
X-Gm-Message-State: APjAAAVjuRY1h5OhW0wMDc6028VzySDxyxFZoJHrOOYCb/xCGXxc0TEC
        QLeszvP1btAfx8cUQKrBgGWlnspW
X-Google-Smtp-Source: APXvYqw0wp/lLW5MOFN7wQ4OQm6O8roXtIB3VdUnRHs9Hu0WeaESXzHtJ71S8ISX9OMF5N2g9euJQQ==
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr9629902lja.239.1572647030504;
        Fri, 01 Nov 2019 15:23:50 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id b141sm3137785lfg.67.2019.11.01.15.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:23:49 -0700 (PDT)
Subject: Re: [PATCH v7 17/19] PM / devfreq: tegra30: Support variable polling
 interval
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <590f47a4-c75a-e8c9-88b8-b3cd98578969@gmail.com>
Date:   Sat, 2 Nov 2019 01:23:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101215816.GB8724@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.11.2019 00:58, Michał Mirosław пишет:
> On Wed, Oct 30, 2019 at 01:00:17AM +0300, Dmitry Osipenko wrote:
>> The ACTMON governor is interrupt-driven and currently hardware's polling
>> interval is fixed to 16ms in the driver. Devfreq supports variable polling
>> interval by the generic governors, let's re-use the generic interface for
>> changing of the polling interval. Now the polling interval can be changed
>> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
> [...]
>> @@ -308,7 +308,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>>  	unsigned int avg_sustain_coef;
>>  	unsigned long target_freq;
>>  
>> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>>  	target_freq += dev->boost_freq;
> 
> Noting a comment in patch 13, if this is hot path you could try reciprocal_divide().

Hello Michał,

This not really a hot path, I just wanted to optimize that case to keep
things a bit nicer.

Please take a look at the arch/arm/boot/compressed/lib1funcs.S, firstly
it checks whether divisor is a power of 2 value and then takes optimized
code path that uses a single shift. Hence the patch 13 still applies here.

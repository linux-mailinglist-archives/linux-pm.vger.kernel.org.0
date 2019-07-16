Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7546A9F2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfGPN7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:59:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38448 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPN7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:59:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so20055681ljg.5;
        Tue, 16 Jul 2019 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7H6i1LxDmB04ycY5ef1F3c/qYaMlYDDIBcVi4+5VGZs=;
        b=MArk12hyaMeQaUedo0Zo3ngitcjN1CJN65igxLVq6n3lA6NpZVHcxE5KbtO3ipqBaU
         uMl0q8Xw2v68Ha5HDdDRadjG0sJ/YvgCISRQEME+xeCFgMkfZBwNOrsOg1CTdQ463hOp
         6w1Xr4LCn8iBjCustjV/j8mdtYdO15qVJOngV8yUkJt7Iv9zkeCRJA6QjtC7ni9HM+ru
         lO94WMul5YG495bgeYL/rjCKxCxQAJZnxUBQzRZcPs5R5n0+xjrGh5s4h4DlvSjD1WsO
         O/lDua85p4zwLhMVssZIttrcs2YEOKbYWr7WpRDaqXx4ABYbjRfZFZWm0uYIYh0Z4pVE
         bmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7H6i1LxDmB04ycY5ef1F3c/qYaMlYDDIBcVi4+5VGZs=;
        b=A6VRIXR6eTgygpDpucFUjvj9vJClGu/R0x+zKL/Q+Qa6dN55CZv8cEqtSdnF/eQSUF
         OPIgjSoc9U9XkEQkPKlylTtueoKcl5uHOj8EqVrBXfHNBdsCFvQoKsW0+Qc7RzAFvGLb
         FlJ0NyqdYVnkAi7VgGglYpOgeDHW+hYHkOo7fpTvVxu2rviR2Ft0CIt+1ggD977/DlNb
         SL5PJdxOdPpNhc5IWEUzfbn4lm6VeGYeDCPy+ASI0Bdf8ozTqLkYYzh45X9OcX/AU+Cc
         j3wyDPzeawr8Ipi7FcDeXN4KkhuvY9U9eZBB7tLbxltdAnkymGSxj5nk+/fyiDYd387Y
         dl2g==
X-Gm-Message-State: APjAAAWypjzlY9ZVfurN0YHNmzu7Tv5snuleWIx+ADdva4iKb13EaufQ
        DvPOcZkxir6rJsx6tAuUVdeND4TJ
X-Google-Smtp-Source: APXvYqxQNH0L/ucC++0xm+Z0K2Lj8uPYP4FhAVzja+WgJC3TQm7601IQXRAm96Z0eFCAtgaG5+P1vw==
X-Received: by 2002:a2e:2b01:: with SMTP id q1mr17270563lje.27.1563285584512;
        Tue, 16 Jul 2019 06:59:44 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id r24sm4176544ljb.72.2019.07.16.06.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:59:43 -0700 (PDT)
Subject: Re: [PATCH v4 14/24] PM / devfreq: tegra30: Ensure that target freq
 won't overflow
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223631epcas4p42012d0364a4c952d90f078fb45982722@epcas4p4.samsung.com>
 <20190707223303.6755-15-digetx@gmail.com>
 <e6b53ba0-ac98-bda6-b087-553088a43d9f@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <14115aa7-ed40-2775-9b0b-a2bf6ca9d47e@gmail.com>
Date:   Tue, 16 Jul 2019 16:59:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e6b53ba0-ac98-bda6-b087-553088a43d9f@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 15:30, Chanwoo Choi пишет:
> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>> Potentially very high boosting could cause an integer overflow for a
>> highly clocked memory after conversion to MHz.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 2f59c78930bd..0de1efdaabf4 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -460,6 +460,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>>  	unsigned long target_freq;
>>  
>>  	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
>> +	target_freq = min(target_freq, ULONG_MAX / KHZ);
> 
> Did you meet this corner case?

I can't recall that, technically it could happen and I don't feel
comfortable by having potential integer overflows anyway.

> If have to change it, you better to use 'tegra->max_freq' as following:
> 	min(target_freq, tegra->max_freq);

The 'tegra->max_freq' will work here, but 'ULONG_MAX / KHZ' is a
constant value which is also correct and doesn't case any harm.

Probably will be even more expressive to write this as:

	target_freq = dev->avg_freq + dev->boost_freq;
	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);

	return min(target_freq, tegra->max_freq);


Thank you very much for the reviews!

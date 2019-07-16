Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA76A971
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGPNTZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:19:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42549 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPNTZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:19:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so19892432lje.9;
        Tue, 16 Jul 2019 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EkdasPMgGnwihc1DSdnhBOd4C244LSLsm8CGrCb1iAU=;
        b=YwapdDTLSP9fmg8iiyTzQ/Y504livetiGXjF0pjWgVja6KtV7nKyOLOHSmhpb4omPF
         JePE9JLsdXwOCs9rPOMD+zSXyGuU6lnmcMzYV0sNT0T4u3ig4HdRygVkArSUb0hnbV0u
         HH9MSrmXwnOn3+hnncg+sFEyhrtzyeWg43BzrETKjfRNEWBSKWpi0NjH+FyshHdUc2ai
         zVwALa6M/bBFo4zWABJv75UlSXlZ9ckmS//C2RKwtnkOK6km2LvqFsM0MObDhkVq+9yD
         clbCxDYIXNS9WNOkvth3Y1USme822AgujW8TWBp7UK7Xr69eiluL0OmS/948gJvbG+2+
         JXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EkdasPMgGnwihc1DSdnhBOd4C244LSLsm8CGrCb1iAU=;
        b=ObpR2VEY3k/6EZkokB2uddC65vRQ08ZX5EOxNpT72Zu3JUIjjgmlb3iPlkzfBWtt+3
         lwxLtkRiPlb7JfwDIphkGfnyHEZZdAEWOR22qlIKKZXEYkP5VS0TEUvFXADB6LY0Km81
         rHDWfAmTDV27MvQ1/eAalQYbHhVw0A5wF1mfYB/xAgWqi35EWcsWQWd3WAwD+11Qvh9t
         lDT0L8CUDn/GIuRR5gYpaTmrGTNTy1fwoiWap98B1vplIjqYayOfULV9XT/9byS9NWpT
         2zEriEcHbLmsAWP4jhIz2+XOjin/bbR3YfHBU+PXX4287Pqo63+Sm1kWnmINPKCWkJsZ
         ANyw==
X-Gm-Message-State: APjAAAWONE+Hk+Cw7J7VObOBhAAtJTl3t16a+pIBwXDSouJwjSdY8gw+
        8d5KRMy0hHIbf9z4c9MNYAbJ2B/L
X-Google-Smtp-Source: APXvYqzJJgD5y9i5vztuRuLgouYy44IzN5SEoidUA4vu+xPqFD03Qc2Yqh/OG7KOZ9K2kqRx/B8WOQ==
X-Received: by 2002:a2e:96d0:: with SMTP id d16mr3668222ljj.14.1563283162653;
        Tue, 16 Jul 2019 06:19:22 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id k82sm3722138lje.30.2019.07.16.06.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:19:22 -0700 (PDT)
Subject: Re: [PATCH v4 09/24] PM / devfreq: tegra30: Reset boosting on startup
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223639epcas4p392300747244905ec06f580394d579eb4@epcas4p3.samsung.com>
 <20190707223303.6755-10-digetx@gmail.com>
 <caed4a78-ad8a-5bee-adc4-4a342e2898c3@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d86c8b97-40b7-ba63-e0a0-736862fa786c@gmail.com>
Date:   Tue, 16 Jul 2019 16:19:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <caed4a78-ad8a-5bee-adc4-4a342e2898c3@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 15:13, Chanwoo Choi пишет:
> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>> Governor could be stopped while boosting is active. We have assumption
>> that everything is reset on governor's restart, including the boosting
>> value, which was missed.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index d5d04c25023b..32fe95458ee7 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -536,6 +536,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  {
>>  	u32 val = 0, target_freq;
>>  
>> +	/* we don't want boosting on restart */
> 
> nitpick.
> I think that following comment is proper in my case.
> In my case, I think 'we' expression is not good
> 
> 	/* Reset the boost frequency on restart */

Okay, I'll change the wording.

>> +	dev->boost_freq = 0;
>> +
>>  	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>>  	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
>>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>>
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> 


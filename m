Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05107C90FD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJBSkf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:40:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:40:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so13506419lfg.9;
        Wed, 02 Oct 2019 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GUBRUP2u2eKGVvnndVg7wTQG7sJk53iR61t2d44YcI=;
        b=lNeHOOGLE0unDDY+mIojdHHkRAgF2Acc5f1ze7p0GnVLn4jH/D53ZrPRvBxDDLZTpi
         iq8LFoDLXnFYeStL3YJhfEpKHMfcw6//ml1KkhHZ/yN37Wl49uZM+BT4m4uuLMfZSny/
         63WYYByTRvU5/T3lAe3N98B5sxA8Hn3LLCw4jaLc3EfuVFCmJPYLFMdVV3OBdR74PzOK
         FZy2SUAzQW/a0rzkS6tWmyF8cYRthlRfFjZBAhp6EZmFVdIf1aClZ02I/r/v4ClWOJxt
         opOMonWvQT216Xe8hLsNzR6TuCK/oKbPxgN+N7WaUCBq4Sk7BvOm63GTlxXx3z1kSlIb
         oegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GUBRUP2u2eKGVvnndVg7wTQG7sJk53iR61t2d44YcI=;
        b=aBv+2GxfHeh3l7IvgvY+Bv6LAUuZPJOHY+yaw4nfJIGYr9IsYijcToJscbzG0+qer5
         GR3YpClV7lKEGpWuSNqKgnZqi9smumCt/+8Eu8rd2lfby++xRWI1m8WphqRzf4zWFw5C
         uuko6AstzE5LyHrsnVC6UQwGcmbmayQb1FRQzOeZxt01sK9/utAk722eSsQ0UlTgHCWY
         lRcmzwh2WPluPtxfxXkdOX2DGnmT3FWqbTpzuSGXwHkfqj/VFBnrqS9IW0ySisjJPkSA
         8Kka3elEjo4AN3+pZwoevZgomJmsTaAHJYk+Et94a+8LQ+mk0nsV1mcVaNB2zdPZEtQK
         WMIg==
X-Gm-Message-State: APjAAAVRdGApcEOFvaNEVZtQz6I7WCaiRpYMtcEDOwcmkTSMssXHk9HL
        PuRs61vcvVDD8MLkxslWZSxueomU
X-Google-Smtp-Source: APXvYqyF2yRcP2R0J2Y13RXkfZU+qwpGXDiZXZcE/geIai0x1MyoZbx/8bL75SzG0GITskdNxpT+dw==
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr2925012lfn.125.1570041631341;
        Wed, 02 Oct 2019 11:40:31 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id q26sm4809189lfd.53.2019.10.02.11.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:40:30 -0700 (PDT)
Subject: Re: [PATCH v6 10/19] PM / devfreq: tegra30: Reduce unnecessary
 interrupts activity
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811212315.12689-1-digetx@gmail.com>
 <CGME20190811212533epcas4p3e4968a3397caaf8682a56105cd061cad@epcas4p3.samsung.com>
 <20190811212315.12689-11-digetx@gmail.com>
 <b67a7878-fa74-df89-9a62-556b9300b5a5@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5d5bce05-1eab-7635-b684-b833b0cf00ce@gmail.com>
Date:   Wed, 2 Oct 2019 21:40:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b67a7878-fa74-df89-9a62-556b9300b5a5@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.10.2019 02:35, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
>> There are cases where unnecessary ACTMON interrupts could be avoided,
>> like when one memory client device requests higher clock rate than the
>> other or when clock rate is manually limited using sysfs devfreq
>> parameters. These cases could be avoided by tuning upper watermark or
>> disabling hardware events when min/max boosting thresholds are reached.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 87 ++++++++++++++++++++++++++++---
>>  1 file changed, 80 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 43d50b4366dd..a2623de56d20 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -312,7 +312,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>>  }
>>  
>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>> -					   struct tegra_devfreq_device *dev)
>> +					   struct tegra_devfreq_device *dev,
>> +					   unsigned long freq)
>>  {
>>  	unsigned long avg_dependency_freq, lower, upper;
>>  
>> @@ -320,6 +321,22 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  
>>  	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
>>  
>> +	/*
>> +	 * If cumulative EMC frequency selection (MCALL / min_freq) is
>> +	 * higher than the device's, then there is no need to set upper
>> +	 * watermark to a lower value because it will result in unnecessary
>> +	 * upper interrupts.
>> +	 *
>> +	 * Note that average watermarks are also updated after EMC
>> +	 * clock rate change, hence if clock rate goes down, then the
>> +	 * watermarks will be set in accordance to the new rate after
>> +	 * changing the rate. There are other ways to achieve the same
>> +	 * result, but this one is probably the least churning, although
>> +	 * it may look a bit convoluted.
>> +	 */
>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>> +		upper = freq * ACTMON_SAMPLING_PERIOD;
>> +
>>  	/*
>>  	 * We want to get interrupts when MCCPU client crosses the
>>  	 * dependency threshold in order to take into / out of account
>> @@ -361,7 +378,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>  	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
>>  
>>  	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
>> -	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
> 
> 
> Also, this patch edits the added codes on front patch.
> This code was added on patch5 and then delete it on this patch.
> If it is not necessary, you can remove it on patch5 by refactoring.
> 
>> +
>> +	/*
>> +	 * The memory events count could go a bit higher than the maximum
>> +	 * defined by the OPPs, hence make the upper watermark infinitely
>> +	 * high to avoid unnecessary upper interrupts in that case.
>> +	 */
>> +	if (freq == tegra->max_freq)
>> +		upper = ULONG_MAX;
>> +	else
>> +		upper = lower + delta;
>> +
>> +	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
> 
> I think that the changes of tegra_devfreq_update_avg_wmark() on this patch
> can be merged to patch5.

Okay, I'll revisit these parts of tegra_devfreq_update_avg_wmark() and will move them to
patch5 if there won't be any major obstacles.

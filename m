Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73680C90CB
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBS06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:26:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41776 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBS05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:26:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so13444669lfn.8;
        Wed, 02 Oct 2019 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5l3JIvKbdj/BZD4ArSIajRVT4RvxlvsDg4EquDv6KDw=;
        b=dxcaxw12DgkzQbPT4rJ6KIFE6mHYDvOtbDoJ7vM3XkylPBb77EPLd+JykBvK1afUWE
         h6IHNu/gM8BNHS+eS2JeoPLu33Tfd98M/BzCJND7H3CBlFh0Ga5kNICcaywSz7oHzzQ6
         kkS2HmoGjLMA0IE0NigAaYdxdpXnCXUbdoSz6hrMycMLWyi4SdZYVAliaGjNWn+3tz0a
         c38a1kS2uNR5Hg9bpLDCFdHb2HHweJVsgddcGN+qTkaZyxRdre2vownWV4NM1tj82l0z
         zD/G2L3ByjKEK5FZ0M9fZXLT9Xz+JoXW3z4ROGkYxLvg7sJyY57+5lxfDHFgvInWk10i
         Nj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5l3JIvKbdj/BZD4ArSIajRVT4RvxlvsDg4EquDv6KDw=;
        b=GZMCf9qCjUb7hHA5EfNQwJzXhpsdLPsHpZo5CW2M1pZs/+Rh+Cl4Oos3dKIIMY6QoF
         gipkmBRgYiEcggUpE3Nokn+YWV9/gorgA6R2V36CeUGtj730L6NXLz1nYEVO5ZWgRVPZ
         f4Fg5VUWWMCdS70GDe62dXL8t73dOfXtNYczkhQhMu27sxt+7RTt+Vl2DC3+ReSfJY4a
         4kSwk/NmT7CHPCZK1FYq+XSl/rnC4M19u7DjjK70OlVFfy2oUprx9BVOMbjX7IhCEOp7
         vEhkO3E3p8qCeEQ24DS2yvMC/V0sW7cbnQOqaE1OXQGhrvN9kb7R6F9AS65iiCewyqOf
         dJJg==
X-Gm-Message-State: APjAAAWngE5H4fHDZfLNAsYC9Y7n/51ywt2Gmo+2ymfzfJlLugOPKSSE
        9d6sp136SE9tulWtXp7DukcB5j5G
X-Google-Smtp-Source: APXvYqxfIDehY7eS/NBGbE6nnf2GbatSSCrZDq56r6kmwr5dSDJKG4MPbHh8cezWtMlTEbEnNkixag==
X-Received: by 2002:a19:ee02:: with SMTP id g2mr3166266lfb.113.1570040814503;
        Wed, 02 Oct 2019 11:26:54 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id n12sm4678683lfh.86.2019.10.02.11.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:26:53 -0700 (PDT)
Subject: Re: [PATCH v6 09/19] PM / devfreq: tegra30: Use kHz units uniformly
 in the code
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811212315.12689-1-digetx@gmail.com>
 <CGME20190811212545epcas4p4132cb98ef69ef04136fda4030bd64f92@epcas4p4.samsung.com>
 <20190811212315.12689-10-digetx@gmail.com>
 <2b65c78a-4b8f-661b-dd9c-29b3cbf0844f@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <10e71085-dc92-6003-2bbd-40c3369cdb26@gmail.com>
Date:   Wed, 2 Oct 2019 21:26:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2b65c78a-4b8f-661b-dd9c-29b3cbf0844f@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.10.2019 02:29, Chanwoo Choi пишет:
> On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
>> Now that all kHz-conversion related bugs are fixed, we can use the kHz
>> uniformly. This makes code cleaner and avoids integer divisions in the
>> code, which is useful in a case of Tegra30 that has Cortex A9 CPU that
>> doesn't support integer division instructions, hence all divisions are
>> actually made in software mode. Another small benefit from this change
>> is that now powertop utility correctly displays devfreq's stats, for
>> some reason it expects them to be in kHz.
> 
> If possible, please specify the benefit result on patch description.

As I wrote above, there are fewer divisions in the code as a result of this patch.

Then I also found that powertop expects KHz. This is actually something that devfreq core
potentially could improve by allowing drivers to specify what units are used for the freqs
such that sysfs interface could present freqs to userpspace in a predictable manner.

Lastly, this patch comes very handy for the patch11, because of the replacement of
avg_count with avg_freq which helps to keep code cleaner in further patches. Please note
that this patch doesn't change logic of the code.

> And I have a question. Why do you fix the KHz-conversion issue on one patch?
> Actually, in my case, it is difficult to understand that multiple patches
> try to fix the KHz-conversion issue. I think that it is possible to
> make one patch.

This driver used Hz units for the OPPs from the very beginning and then there were
Hz<->KHz conversion bugs that were fixed by previous patches. This patch doesn't fix any
KHz-conversion issue and merely makes a minor clean up by using KHz units everywhere in
the code, starting from OPPs that are created by dev_pm_opp_add().

> And, 
> On these series, some codes wad added and then these codes are deleted
> on later patch. It looks like that you made the issue and then you fix
> the issue by yourself. I think that it is not proper.
> Even if you developed the patches on your local environment sequentially
> according to the sequence of your issue detection, you better to do
> refactoring the patches.
> 
> Frankly, I cannot agree that some codes wad added on front patch
> and then added codes are deleted on later patch in the same patchset.

Alright, I understand that it makes easier for you to review patches without going back
and forth between patches, verifying every changed line of the previous patches of this
series.

>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 81 +++++++++++++++++++------------
>>  1 file changed, 49 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index ca499368ee81..43d50b4366dd 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -137,8 +137,11 @@ struct tegra_devfreq_device {
>>  	const struct tegra_devfreq_device_config *config;
>>  	void __iomem *regs;
>>  
>> -	/* Average event count sampled in the last interrupt */
>> -	u32 avg_count;
>> +	/*
>> +	 * Average event count sampled in the last interrupt and converted
>> +	 * to frequency value.
>> +	 */
>> +	u32 avg_freq;
>>  
>>  	/*
>>  	 * Extra frequency to increase the target by due to consecutive
>> @@ -222,6 +225,14 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
>>  	return 0;
>>  }
>>  
>> +static unsigned long
>> +tegra_actmon_dev_avg_dependency_freq(struct tegra_devfreq *tegra,
>> +				     struct tegra_devfreq_device *dev)
>> +{
>> +	return dev->config->avg_dependency_threshold /
>> +		ACTMON_SAMPLING_PERIOD;
>> +}
>> +
>>  static unsigned long
>>  tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>>  			      struct tegra_devfreq_device *dev,
>> @@ -229,13 +240,15 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>>  {
>>  	unsigned long static_cpu_emc_freq;
>>  
>> -	if (dev->config->avg_dependency_threshold &&
>> -	    dev->config->avg_dependency_threshold < dev->avg_count) {
>> +	if (!dev->config->avg_dependency_threshold)
>> +		return target_freq;
>> +
>> +	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
>>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
>> -		target_freq = max(target_freq, static_cpu_emc_freq);
>> -	}
>> +	else
>> +		static_cpu_emc_freq = 0;
>>  
>> -	return target_freq;
>> +	return max(target_freq, static_cpu_emc_freq);
>>  }
>>  
>>  static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq *tegra,
>> @@ -261,7 +274,7 @@ static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq *tegra,
>>  
>>  	opp = dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
>>  	if (IS_ERR(opp))
>> -		upper = ULONG_MAX;
>> +		upper = KHZ_MAX;
>>  	else
>>  		dev_pm_opp_put(opp);
>>  
>> @@ -280,15 +293,12 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>>  	 * range in a case where target_freq falls into a range of
>>  	 * next_possible_opp_freq - 1MHz.
>>  	 */
>> -	target_freq = round_down(target_freq, 1000000);
> 
> This line was added on patch5. I think that you could fix the KHz-conversion
> on patch5 instead of this patch. It is not good way to make the patches.
> Because some codes wad added and then these codes are deleted on later patch.
> 
> It looks like that you made the issue and then you fix the issue by yourself.
> It is difficult to make me to decide this patch is either proper or not.

The OPPs were always defined in Hz units in this driver. The patch5 was created much
earlier than this patch and thus I'm making changes here to the code that was added in patch5.

Okay, I'll try to change the order of the patches. But usually it takes a lot if time and
effort to rebase patches and then re-test them, so I'm trying to avoid that when not
absolutely necessary.

>> +	target_freq = round_down(target_freq, 1000);
>>  
>>  	/* watermarks are set at the borders of the corresponding OPPs */
>>  	*lower = tegra_actmon_lower_freq(tegra, target_freq);
>>  	*upper = tegra_actmon_upper_freq(tegra, target_freq);
>>  
>> -	*lower /= KHZ;
>> -	*upper /= KHZ;
>> -
>>  	/*
>>  	 * The upper watermark should take into account CPU's frequency
>>  	 * because cpu_to_emc_rate() may override the target_freq with
>> @@ -304,10 +314,11 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  					   struct tegra_devfreq_device *dev)
>>  {
>> -	unsigned long lower, upper, freq;
>> +	unsigned long avg_dependency_freq, lower, upper;
>> +
>> +	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
>>  
>> -	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
>> -	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
>> +	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
>>  
>>  	/*
>>  	 * We want to get interrupts when MCCPU client crosses the
>> @@ -316,7 +327,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  	 */
>>  	if (lower < dev->config->avg_dependency_threshold &&
>>  	    upper > dev->config->avg_dependency_threshold) {
>> -		if (dev->avg_count < dev->config->avg_dependency_threshold)
>> +		if (dev->avg_freq < avg_dependency_freq)
>>  			upper = dev->config->avg_dependency_threshold;
>>  		else
>>  			lower = dev->config->avg_dependency_threshold;
>> @@ -358,8 +369,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>  	 * device. Once that mark is hit and boosting is stopped, the
>>  	 * interrupt is disabled by ISR.
>>  	 */
>> -	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
>> -	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
>> +	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
> 
> Also, patch5 newly defined this function and then you edit the function prototype
> of this function. It is not proper way.

Sorry, I'm not sure what you're meaning by the "prototype" here. In case of this
particular hunk, the freq==dev->avg_freq and dev->avg_count is replaced with dev->avg_freq
in this patch as well. Hence this is a cosmetic change that doesn't change any logic of
the code. I'll see if this all could be made a bit more clear and easier for review.

[snip]

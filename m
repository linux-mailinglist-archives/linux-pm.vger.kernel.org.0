Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500BC352DF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFDWzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 18:55:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39920 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFDWzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 18:55:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so196050ljh.6;
        Tue, 04 Jun 2019 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fePBt3r1OxgAuxOQl6GJ/UfKTptcITLj0x1ZlMv6DJs=;
        b=OVBtu/FlF0G44Y21xdUsHsOmmnkrrGiuH6YzEU7dI9KthThMC+p2AHu8d1tkDCaqYP
         xPRClOoWr/3JxwGpIFYpx4NPOPbO9xRTrKshJRqVWJC/v5oHku+GEjJxPULC4Nauun5f
         SAT2/3X0dH6i7+fBNV2HwTFWjE59JDmKdDTXeq8TxrROJ717c8nkeNUVgHGtGZe3cRt0
         soM4wAgr0GEjpr7uDR4wrRba6aDhE/32EcdtZ4bWpxxTpaF/jQN6axFwJW9lqcAi8MEF
         OnEr3hvvO9Z3xsGnj+SP/QVHmZ7oBx7z2njSCMMp3NEIJGI4vJ12FskCWj9jC5QDhIRN
         OmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fePBt3r1OxgAuxOQl6GJ/UfKTptcITLj0x1ZlMv6DJs=;
        b=H6TAI8xGhy+kFBxcsiCDAF/5djpUu80PVCA5VkzlaixrTgCvih/Qi1jmMh5AgiV2x+
         MVjqQcBjPa+eEoitDxRzdqXg02tFPGSCgY+/wHTQq9Y5cdrG5mMxG1cWWzSdr6nVBIGv
         Z27tGsTQ2rLWWaeiyzpG3E2UYGIgRx/Xybna88ZoF3Xs/OuHWarP37U/C0C7lbhTHQ86
         +97lyvkpnjrwDSkyGgtehb5LefLRL+xH09tgNKB1N8ySP68sSiWWCZdgfrccNaZRjYcO
         aBEs9XJY8tU2MvBLNRgHjFkXjeGE1EEyFey6fIY5Ri9wUmDpKhE2I577eAjkPshl1neZ
         nZQg==
X-Gm-Message-State: APjAAAX9TLVak8NQPuvTaodnVuXq3MC1SC0szlTJTD1GRQjkyE4jqGk2
        XteW5oD/8o42Q3b+VX5bDU+Ws/Wc
X-Google-Smtp-Source: APXvYqwvaU/UnvKRfaK79XRAdEBiQsJD7KsDgnP6BL/6BvHzdD+gmPeHxABHVMU4b8YEosJwRqi0PQ==
X-Received: by 2002:a2e:9c4a:: with SMTP id t10mr12552333ljj.197.1559688907959;
        Tue, 04 Jun 2019 15:55:07 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id y2sm3933163lfc.35.2019.06.04.15.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 15:55:06 -0700 (PDT)
Subject: Re: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-8-digetx@gmail.com> <20190604110744.GG16519@ulmo>
 <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com>
Message-ID: <2b09a162-a090-901b-01cf-46b116a87a7a@gmail.com>
Date:   Wed, 5 Jun 2019 01:55:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 16:40, Dmitry Osipenko пишет:
> 04.06.2019 14:07, Thierry Reding пишет:
>> On Thu, May 02, 2019 at 02:38:06AM +0300, Dmitry Osipenko wrote:
>>> There is no guarantee that interrupt handling isn't running in parallel
>>> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
>>> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
>>> disabled in the Interrupt Controller in order to ensure that device
>>> interrupt is indeed being disabled.
>>>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>> index b65313fe3c2e..ce1eb97a2090 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>>>  	struct notifier_block	rate_change_nb;
>>>  
>>>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>>> +
>>> +	int irq;
>>
>> Interrupts are typically unsigned int.
>>
>>>  };
>>>  
>>>  struct tegra_actmon_emc_ratio {
>>> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>>  	u32 val;
>>>  	unsigned int i;
>>>  
>>> +	disable_irq(tegra->irq);
>>> +
>>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>>  		dev = &tegra->devices[i];
>>>  
>>> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>>  		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>>>  
>>>  		device_writel(dev, val, ACTMON_DEV_CTRL);
>>> +
>>> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>> +			      ACTMON_DEV_INTR_STATUS);
>>>  	}
>>>  
>>>  	actmon_write_barrier(tegra);
>>> +
>>> +	enable_irq(tegra->irq);
>>
>> Why do we enable interrupts after this? Is there any use in having the
>> top-level interrupt enabled if nothing's going to generate an interrupt
>> anyway?
> 
> There is no real point in having the interrupt enabled other than to
> keep the enable count balanced.
> 
> IIUC, we will need to disable IRQ at the driver's probe time (after
> requesting the IRQ) if we want to avoid that (not really necessary)
> balancing. This is probably something that could be improved in a
> follow-up patches, if desired.

Nah, it's not worth the effort. It is quite problematic that we can't
keep interrupt disabled during of devfreq_add_device() execution because
it asks governor to enable the interrupt and the interrupt shall be
disabled because we're using device's lock in the governor interrupt
handler.. device is getting assigned only after completion of the
devfreq_add_device() and hence ISR gets a NULL deref if it is fired
before device is assigned. So I'll leave this part as-is.

Thierry, please answer to all of the remaining patches where you had
some concerns. I'll send out another series on top of this, addressing
yours comments and fixing another bug that I spotted today.

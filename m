Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441E23929B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfFGQ60 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 12:58:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42966 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfFGQ60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 12:58:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so2135604lfh.9;
        Fri, 07 Jun 2019 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sa5CPLr945oENhA42CHez0IG2yijXXEexO7nDRxrhcg=;
        b=jT6H4PluKS7p0yHRpfnlgjRfXFf8iNnFbEGHVXe6ADiqaRNtyoXNohAd2PQwWJ1P4u
         SvO9xYRp0xboi/J3TEaRdqXXmzfT1Ny4EP7ij/RSprlo7mvE6v3+BeEdqlFZoeyXNA3V
         9LncR2gQb10OS5JLbGNDK3pdlyLmVl2gnu4SPMcWikz2dKxt2d0Gvl3bx6T+v2IxY5OG
         6NaABP+J/Znm8Il0uOGuqrd5nYfJIBDKQWUbHBUFhNvrKCS7Mnafg1AtmqqP3vyNi1bn
         +3rdrHWVp3/aoXY6ZZATP2PT/6I1I59Boc9WLrqWH0zC7N8qO4OacEFqKHAPNy4e+dW5
         a2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sa5CPLr945oENhA42CHez0IG2yijXXEexO7nDRxrhcg=;
        b=t6nNOtXlOAnAXwCCwnftC1qgvq2+QpJjsiAWWQ9aXSMt7yZfkFo2SIQVNgsJygkm/N
         EEdYypApFuxphsbKBpciKTCbE4xuxZ4q1vzuxo7NdRqKr8cuNf4SUjj+8eWyNuhFuGfq
         LHl2v7NBAjpY+g6sHWDH7XGvZtNPjRi2X8Ulk7xsEGwWmHEhkQMFidQYk5hEgmT4771o
         GOVzE3oLpvKJRg20Biy58A6UB1PGM3X8iEJrOyZsc/Y0JweZHg9aBHMHnEGPkW7+0Z8r
         kipxFr3w66a/CwJ3+/4t4HqJAB8G9iGMG3BWMMw41ePy7ebdFVB59jeqegLIGxSV0BHr
         CBQg==
X-Gm-Message-State: APjAAAXHapQykGVtSCTVpC9wIslto1loGZtrpXxandXOCLb+PPynbJyF
        Q0X/ONH2FK5VVt/QZgouAtyqQF66
X-Google-Smtp-Source: APXvYqyTmsWuUCPMQn3oXC1I0d0ziInebRNTdYB2MXTJTjoM2go2TOjpG+F+/9OIc/fND+MzaW3J7Q==
X-Received: by 2002:a05:6512:30a:: with SMTP id t10mr11839927lfp.22.1559926703037;
        Fri, 07 Jun 2019 09:58:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-170-54.pppoe.mtu-net.ru. [91.76.170.54])
        by smtp.googlemail.com with ESMTPSA id q22sm470197lje.75.2019.06.07.09.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:58:21 -0700 (PDT)
Subject: Re: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-8-digetx@gmail.com> <20190604110744.GG16519@ulmo>
 <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com>
 <2b09a162-a090-901b-01cf-46b116a87a7a@gmail.com>
Message-ID: <7be61b38-62c7-8536-a102-36f5ac6668e2@gmail.com>
Date:   Fri, 7 Jun 2019 19:58:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2b09a162-a090-901b-01cf-46b116a87a7a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.06.2019 1:55, Dmitry Osipenko пишет:
> 04.06.2019 16:40, Dmitry Osipenko пишет:
>> 04.06.2019 14:07, Thierry Reding пишет:
>>> On Thu, May 02, 2019 at 02:38:06AM +0300, Dmitry Osipenko wrote:
>>>> There is no guarantee that interrupt handling isn't running in parallel
>>>> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
>>>> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
>>>> disabled in the Interrupt Controller in order to ensure that device
>>>> interrupt is indeed being disabled.
>>>>
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>>> index b65313fe3c2e..ce1eb97a2090 100644
>>>> --- a/drivers/devfreq/tegra-devfreq.c
>>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>>> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>>>>  	struct notifier_block	rate_change_nb;
>>>>  
>>>>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>>>> +
>>>> +	int irq;
>>>
>>> Interrupts are typically unsigned int.
>>>
>>>>  };
>>>>  
>>>>  struct tegra_actmon_emc_ratio {
>>>> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>>>  	u32 val;
>>>>  	unsigned int i;
>>>>  
>>>> +	disable_irq(tegra->irq);
>>>> +
>>>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>>>  		dev = &tegra->devices[i];
>>>>  
>>>> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>>>  		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>>>>  
>>>>  		device_writel(dev, val, ACTMON_DEV_CTRL);
>>>> +
>>>> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>>> +			      ACTMON_DEV_INTR_STATUS);
>>>>  	}
>>>>  
>>>>  	actmon_write_barrier(tegra);
>>>> +
>>>> +	enable_irq(tegra->irq);
>>>
>>> Why do we enable interrupts after this? Is there any use in having the
>>> top-level interrupt enabled if nothing's going to generate an interrupt
>>> anyway?
>>
>> There is no real point in having the interrupt enabled other than to
>> keep the enable count balanced.
>>
>> IIUC, we will need to disable IRQ at the driver's probe time (after
>> requesting the IRQ) if we want to avoid that (not really necessary)
>> balancing. This is probably something that could be improved in a
>> follow-up patches, if desired.
> 
> Nah, it's not worth the effort. It is quite problematic that we can't
> keep interrupt disabled during of devfreq_add_device() execution because
> it asks governor to enable the interrupt and the interrupt shall be
> disabled because we're using device's lock in the governor interrupt
> handler.. device is getting assigned only after completion of the
> devfreq_add_device() and hence ISR gets a NULL deref if it is fired
> before device is assigned. So I'll leave this part as-is.
> 
> Thierry, please answer to all of the remaining patches where you had
> some concerns. I'll send out another series on top of this, addressing
> yours comments and fixing another bug that I spotted today.
> 

I looked at this once again and found that the interrupt could be kept
disabled on request using the IRQ_NOAUTOEN flag and then the device
could be assigned within the governor's event handler, so everything is
resolved very nicely! :)

I'll send patches addressing this comment and the rest after getting
relies from you guys. Please try to not postpone the responses too much
as more interactivity in a review/apply process usually help quite a
lot, thanks in advance!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD586BFC8
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGQQoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 12:44:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45842 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQQoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 12:44:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so24257303lje.12;
        Wed, 17 Jul 2019 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CGE+X8ckrtnyxFAXLFXXVIZ9hPlv1NjuKqBGCRzqByI=;
        b=hhWQv/QG2DNbPreGmmjLHGuiRKWYwIwCAi7mLxMQ3Fn1/HBgOWor4mz8yY0HFiNeit
         fyHEwXn6a1dr/BWPpwgc/zStOsAFGdglquc8KoBgLA3AfGpCi2OQgCVjTnxYoi7CLaE8
         bJslyBmCJ7VURR8j5KLcQeLwDktrc3+PMbU/Iy0blC4hieJN9WCbtSIAXDfzSIt2wdlp
         2DZHeOit4RTv/SSYHWoYw0rzdSzKJ5ZreiJmhMrGIeuG625ZWP/LEINKoFoceZw3IP0S
         eNXZiUgmBOuDtQB+F9Smiv35qPi55UWDRMVI+ALMufCyfG6H7lpIZiJ5uaeSPFHCNd2D
         hmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CGE+X8ckrtnyxFAXLFXXVIZ9hPlv1NjuKqBGCRzqByI=;
        b=htNSPoMZVBnIel5gdN9qzf+F/T/EX6iVB78NhL5lzo/uilLiiz3ZfvTw323MQoqa0O
         DNtU7ZiduJK4+DLC4qz6/nGB1ZCf75AJa1UiaRvVe/iICRHITWvNnJtFV6LiJxu85jFR
         5W89o+hWJsDcnuDgtKeRdnoiMdvflt+C4P57WveuDPUzzwkZhSQi1ZvfvSyFatAukZc8
         cO5Q9Si4PzXT+CPE6jOwRb9QS+wEr8rY5gu7Ae+V1Khm6Tf18OfTQWpFK5vt4vp1lZyu
         8q5jl7PQGI5+fhq1iRTA64PG5rh6rz+7TYIaU3t/bGKPkeXgluM9By4tutYrDzt6oWKy
         xhlg==
X-Gm-Message-State: APjAAAXQ7rM8pMYJqviAuQTeHJeq/gLsicf15e4m4AFZvft/11hwrAgm
        /QOCUKTcED4Q3S2GOHOVwKnZQykc
X-Google-Smtp-Source: APXvYqxYRDRMfBu1u8Fk1hovIfRdfVNhGOozt3pkDF9g4w5Oyt0wEhsATv3DB2uXZ2AewqsblPMwww==
X-Received: by 2002:a2e:9147:: with SMTP id q7mr20961992ljg.19.1563381853573;
        Wed, 17 Jul 2019 09:44:13 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id x67sm4567861ljb.13.2019.07.17.09.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 09:44:12 -0700 (PDT)
Subject: Re: [PATCH v4 02/24] PM / devfreq: tegra30: Keep interrupt disabled
 while governor is stopped
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223724epcas4p2d82cecc2969fecddca67192417843418@epcas4p2.samsung.com>
 <20190707223303.6755-3-digetx@gmail.com>
 <f691a845-18f3-a6fb-302c-a8a3fc13e5bf@samsung.com>
 <6c517d04-cf99-f907-e74d-9fba99405a53@gmail.com>
 <ca339b7f-1141-4c68-1c07-2ac818422bbc@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <00dfcd92-a41a-11c0-b8b2-1cdc68048aa9@gmail.com>
Date:   Wed, 17 Jul 2019 19:44:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ca339b7f-1141-4c68-1c07-2ac818422bbc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.07.2019 9:37, Chanwoo Choi пишет:
> On 19. 7. 16. 오후 10:03, Dmitry Osipenko wrote:
>> 16.07.2019 14:47, Chanwoo Choi пишет:
>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>>> There is no real need to keep interrupt always-enabled, will be nicer
>>>> to keep it disabled while governor is inactive.
>>>>
>>>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
>>>>  1 file changed, 22 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>> index a27300f40b0b..5e2b133babdd 100644
>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>> @@ -11,6 +11,7 @@
>>>>  #include <linux/devfreq.h>
>>>>  #include <linux/interrupt.h>
>>>>  #include <linux/io.h>
>>>> +#include <linux/irq.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/mod_devicetable.h>
>>>>  #include <linux/platform_device.h>
>>>> @@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>>>>  {
>>>>  	unsigned int i;
>>>>  
>>>> -	disable_irq(tegra->irq);
>>>> -
>>>>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>>>>  		      ACTMON_GLB_PERIOD_CTRL);
>>>>  
>>>> @@ -442,8 +441,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>>>  	}
>>>>  
>>>>  	actmon_write_barrier(tegra);
>>>> -
>>>> -	enable_irq(tegra->irq);
>>>>  }
>>>>  
>>>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>>> @@ -552,6 +549,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>>>  {
>>>>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>>>>  
>>>> +	/*
>>>> +	 * Couple device with the governor early as it is needed at
>>>> +	 * the moment of governor's start (used by ISR).
>>>> +	 */
>>>> +	tegra->devfreq = devfreq;
>>>
>>> I'm not sure it is necessary. Almost devfreq device get
>>> the devfreq instance on probe timing through devfreq_add_device directly.
>>
>> This is necessary because this assignment is for the "governor" and not
>> the "device". Governor is started during of devfreq_add_device(), hence
>> there is no better way to assign device to the driver's governor.
> 
> OK. I understand.
> 
> But, I have a question. Is it working before this patch?
> How can you test it on that tegra->devfreq is NULL?

It was working before this patch because previously interrupt was
requested *after* devfreq_add_device(), now the IRQ requesting happens
*before* devfreq_add_device() and enabling *during of*. If interrupt
fires before the assignment happened, then ISR gets a NULL deference and
this is easily reproducible.

Please note that 'tegra->devfreq' is used only by the ISR and onward, in
the further patches of this series the usage is extended by the cpufreq
notifier.

>>
>>>> +
>>>>  	switch (event) {
>>>>  	case DEVFREQ_GOV_START:
>>>>  		devfreq_monitor_start(devfreq);
>>>> @@ -586,10 +589,11 @@ static struct devfreq_governor tegra_devfreq_governor = {
>>>>  
>>>>  static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  {
>>>> -	struct tegra_devfreq *tegra;
>>>>  	struct tegra_devfreq_device *dev;
>>>> -	unsigned int i;
>>>> +	struct tegra_devfreq *tegra;
>>>> +	struct devfreq *devfreq;
>>>>  	unsigned long rate;
>>>> +	unsigned int i;
>>>>  	int err;
>>>>  
>>>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>>>> @@ -625,6 +629,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  	}
>>>>  	tegra->irq = err;
>>>>  
>>>> +	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
>>>> +
>>>> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>>>> +					actmon_thread_isr, IRQF_ONESHOT,
>>>> +					"tegra-devfreq", tegra);
>>>> +	if (err) {
>>>> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
>>>> +		return err;
>>>> +	}
>>>> +
>>>>  	reset_control_assert(tegra->reset);
>>>>  
>>>>  	err = clk_prepare_enable(tegra->clock);
>>>> @@ -672,28 +686,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  	}
>>>>  
>>>>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>>>> -	tegra->devfreq = devfreq_add_device(&pdev->dev,
>>>> -					    &tegra_devfreq_profile,
>>>> -					    "tegra_actmon",
>>>> -					    NULL);
>>>> +	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>>>> +				     "tegra_actmon", NULL);
>>>>  	if (IS_ERR(tegra->devfreq)) {
>>>
>>> Have to check 'devfreq' instead of 'tegra->devfreq'.
>>> Did you test it? It might be failed because 'tegra->devfreq is NULL.
>>
>> That's a good catch! Thank you very much.
>>
>>>>  		err = PTR_ERR(tegra->devfreq);
>>>
>>> ditto.
>>
>> Ok

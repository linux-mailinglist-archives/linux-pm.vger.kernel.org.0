Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392806A919
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGPNDx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:03:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37005 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPNDx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:03:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so13647229lfh.4;
        Tue, 16 Jul 2019 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7vUO+aDmSixtQf+Kmq7Y+cEBs2LRiHU953G0lMx12po=;
        b=iVVr+tkDz3DW6fmqGZxulh2q0YXBNHNQqidJwx6q3Icc0lPfC2OQ16wPu1Qb+Cmx5s
         HMrx9enixZ9w2dOm8whNg53xjNH4yxUcl0MVqrEBHXtbH8YIR3CcL0zlup40XXyWy0R9
         3CG89hssZ8tv8R5AjtSyo2KYWm89YogOqTCVc+7B9Xd7HnqZ47plvo/Llg9rKTicwl/7
         2n6839/mJsMlRXygX6aj0crB4DWGiPAD2slB6246tepDrfC1k6iwl3WvpPg+ghzgNEGY
         TjUoClyhFZWZkibX+XlV/oKgbckNUHXZEgnFCTqRewV3Ekk17e9SnjtxDOQpSZmHpqP5
         P7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vUO+aDmSixtQf+Kmq7Y+cEBs2LRiHU953G0lMx12po=;
        b=rud66sy/mEVTNP4Z/CjIFBCL0paqHpxfFPfEBYXg9S4DexDzcc8WuDXczMzX8BUeib
         WCrN4+H/xNkGWx/v4nYFFyXYDdVIpeafI/205YlTVHhLhf9V3fy+K6o8OAmod4NZcIOK
         uZICCws02VzTyAhcgth3Q45Y3MMLhPjtK1tj079qtewfkayvB6MLHGQc/agBu37uXYKo
         RSJae5gYNzvU2tcdT8DLV+qtm6SeiBrQbgeyg2OxA/zrF/fj061QWC4xmIDKV8By+VAt
         dwk6gS6125CrQTJOJ2O1vSQbgEvSt1KX2MK5EFLoVYDiKYN0UHLlku895LNggoWOy5DN
         TJrg==
X-Gm-Message-State: APjAAAXE+l5z76qti1bOXJbv84+CHgzbh4fXoakW4+kdDlk/hTVpqCIS
        82bWf8z6CHkUzo4njm+Z1GaokWd0
X-Google-Smtp-Source: APXvYqwbRrvti+Refi6Ehi7FHXGu7SjxzedeBfvEcIL34RpbqoIXYIQUzl7wtB3t15yETESjAhGvRA==
X-Received: by 2002:a19:4f4a:: with SMTP id a10mr14589699lfk.30.1563282229851;
        Tue, 16 Jul 2019 06:03:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id x18sm2841896lfe.42.2019.07.16.06.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:03:47 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6c517d04-cf99-f907-e74d-9fba99405a53@gmail.com>
Date:   Tue, 16 Jul 2019 16:03:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f691a845-18f3-a6fb-302c-a8a3fc13e5bf@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 14:47, Chanwoo Choi пишет:
> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>> There is no real need to keep interrupt always-enabled, will be nicer
>> to keep it disabled while governor is inactive.
>>
>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index a27300f40b0b..5e2b133babdd 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/devfreq.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> +#include <linux/irq.h>
>>  #include <linux/module.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/platform_device.h>
>> @@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>>  {
>>  	unsigned int i;
>>  
>> -	disable_irq(tegra->irq);
>> -
>>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>>  		      ACTMON_GLB_PERIOD_CTRL);
>>  
>> @@ -442,8 +441,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  	}
>>  
>>  	actmon_write_barrier(tegra);
>> -
>> -	enable_irq(tegra->irq);
>>  }
>>  
>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>> @@ -552,6 +549,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>>  
>> +	/*
>> +	 * Couple device with the governor early as it is needed at
>> +	 * the moment of governor's start (used by ISR).
>> +	 */
>> +	tegra->devfreq = devfreq;
> 
> I'm not sure it is necessary. Almost devfreq device get
> the devfreq instance on probe timing through devfreq_add_device directly.

This is necessary because this assignment is for the "governor" and not
the "device". Governor is started during of devfreq_add_device(), hence
there is no better way to assign device to the driver's governor.

>> +
>>  	switch (event) {
>>  	case DEVFREQ_GOV_START:
>>  		devfreq_monitor_start(devfreq);
>> @@ -586,10 +589,11 @@ static struct devfreq_governor tegra_devfreq_governor = {
>>  
>>  static int tegra_devfreq_probe(struct platform_device *pdev)
>>  {
>> -	struct tegra_devfreq *tegra;
>>  	struct tegra_devfreq_device *dev;
>> -	unsigned int i;
>> +	struct tegra_devfreq *tegra;
>> +	struct devfreq *devfreq;
>>  	unsigned long rate;
>> +	unsigned int i;
>>  	int err;
>>  
>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>> @@ -625,6 +629,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	}
>>  	tegra->irq = err;
>>  
>> +	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
>> +
>> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>> +					actmon_thread_isr, IRQF_ONESHOT,
>> +					"tegra-devfreq", tegra);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
>> +		return err;
>> +	}
>> +
>>  	reset_control_assert(tegra->reset);
>>  
>>  	err = clk_prepare_enable(tegra->clock);
>> @@ -672,28 +686,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>> -	tegra->devfreq = devfreq_add_device(&pdev->dev,
>> -					    &tegra_devfreq_profile,
>> -					    "tegra_actmon",
>> -					    NULL);
>> +	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>> +				     "tegra_actmon", NULL);
>>  	if (IS_ERR(tegra->devfreq)) {
> 
> Have to check 'devfreq' instead of 'tegra->devfreq'.
> Did you test it? It might be failed because 'tegra->devfreq is NULL.

That's a good catch! Thank you very much.

>>  		err = PTR_ERR(tegra->devfreq);
> 
> ditto.

Ok

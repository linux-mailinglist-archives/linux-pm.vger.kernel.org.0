Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6302934916
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfFDNkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 09:40:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46226 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDNkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 09:40:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26so16467408lfh.13;
        Tue, 04 Jun 2019 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qU5YrqsZb5+ghV71fBKL1+4mGyCSiQxy01gmQROp5S4=;
        b=UsfjvGknGsgbUyNRksFRLwfWPVbBNie/s5ElpFO0VCbewBJ+Ylem/ZuZWcXSSZxrTl
         989v6WNey3FVSR0tzbgr09mLaw49+rd2iY1MZ0U9Ix4kQw3W8CNQKNNZfpfBG0bm9+n3
         BTyD34gIA1KyriH44odoS3x9tj9Avsl7NKz9+NorJ4z7J5x3wXO/mq2LHYDSvGO1vUYC
         5N+VkNQsvemSC6Sj35LbCu3rOke/BNUR6hg9YhyoYFcU/dD/EINYEH+VFuOcmbAaMieU
         EQk1UbpeDZNOllIBznKrR1syOLOvK+xlYbwHMHzLXAFAA0DZsEoaQ2cRj5bNT8lNGN4E
         xQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qU5YrqsZb5+ghV71fBKL1+4mGyCSiQxy01gmQROp5S4=;
        b=Mxh1giv4K8BLvLKeGgvsATvGn3ud02T9fCEbTya0fH2ukASR9Qt17g1B+1g727cXw1
         1NOy00hWGBwyQl5TZkQ2hwOv8OoD8EAwlr+Nv0WgsIuk1z77uCXHmDFCTwPbPC7ooQzN
         WEwxUKsMcMr8LsyxsQKlZJLgeV7lAYOrcHsM+GqBkJUi9OzgCmtSdPWnKzVmeSMTnhpu
         C4RxRvYDZY/+TtDWHl32DB3fUiWLU45aA6eOpi8rt2++G4Cv1eavMd127C0tX0VbTa5h
         4IkGCvqbSo/2zjv8CQ1FUUEN1w9uMwe3g9U4nGQyHgGF9rDYGOIWW/v60YrQrScaqhoX
         ggWg==
X-Gm-Message-State: APjAAAWzVYzORiMNhw/KiR4WjSVWckMjNTK8eTMTXGhgf9dbgGGJK6UE
        xaEESBDBsawVIkgLfF9D7NoiekZz
X-Google-Smtp-Source: APXvYqzQ+9TolLx3t2xkoSlz5UAL2UFsqD4bMDyYrJKFDLmHD1lsElwXmjimXXjsnIsyvrGzHd29NA==
X-Received: by 2002:ac2:47fa:: with SMTP id b26mr3555411lfp.82.1559655620679;
        Tue, 04 Jun 2019 06:40:20 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id i195sm2924873lfi.87.2019.06.04.06.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:40:19 -0700 (PDT)
Subject: Re: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com>
Date:   Tue, 4 Jun 2019 16:40:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604110744.GG16519@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 14:07, Thierry Reding пишет:
> On Thu, May 02, 2019 at 02:38:06AM +0300, Dmitry Osipenko wrote:
>> There is no guarantee that interrupt handling isn't running in parallel
>> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
>> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
>> disabled in the Interrupt Controller in order to ensure that device
>> interrupt is indeed being disabled.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index b65313fe3c2e..ce1eb97a2090 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>>  	struct notifier_block	rate_change_nb;
>>  
>>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>> +
>> +	int irq;
> 
> Interrupts are typically unsigned int.
> 
>>  };
>>  
>>  struct tegra_actmon_emc_ratio {
>> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>  	u32 val;
>>  	unsigned int i;
>>  
>> +	disable_irq(tegra->irq);
>> +
>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>  		dev = &tegra->devices[i];
>>  
>> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>  		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>>  
>>  		device_writel(dev, val, ACTMON_DEV_CTRL);
>> +
>> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>> +			      ACTMON_DEV_INTR_STATUS);
>>  	}
>>  
>>  	actmon_write_barrier(tegra);
>> +
>> +	enable_irq(tegra->irq);
> 
> Why do we enable interrupts after this? Is there any use in having the
> top-level interrupt enabled if nothing's going to generate an interrupt
> anyway?

There is no real point in having the interrupt enabled other than to
keep the enable count balanced.

IIUC, we will need to disable IRQ at the driver's probe time (after
requesting the IRQ) if we want to avoid that (not really necessary)
balancing. This is probably something that could be improved in a
follow-up patches, if desired.

>>  }
>>  
>>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>> @@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	struct resource *res;
>>  	unsigned int i;
>>  	unsigned long rate;
>> -	int irq;
>>  	int err;
>>  
>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>> @@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>>  	}
>>  
>> -	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0) {
>> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
>> -		return irq;
>> +	tegra->irq = platform_get_irq(pdev, 0);
>> +	if (tegra->irq < 0) {
>> +		err = tegra->irq;
>> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
>> +		return err;
>>  	}
> 
> This is very oddly written. tegra->irq should really be an unsigned int
> since that's the standard type for interrupt numbers. But since you need
> to be able to detect errors from platform_get_irq() it now becomes
> natural to write this as:
> 
> 	err = platform_get_irq(pdev, 0);
> 	if (err < 0) {
> 		dev_err(...);
> 		return err;
> 	}
> 
> 	tegra->irq = err;
> 
> Two birds with one stone. I suppose this could be done in a follow-up
> patch since it isn't practically wrong in your version, so either way:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

Thank you for the ACK! Although, I disagree with yours suggestion, to me
that makes code a bit less straightforward and it's not really
worthwhile to bloat the code just because technically IRQ's are unsigned
numbers (we don't care about that). It also makes me a bit uncomfortable
to see "err" assigned to a variable, I don't think it's a good practice.

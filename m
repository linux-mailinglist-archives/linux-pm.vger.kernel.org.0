Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1669D7BEB6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfGaK4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:56:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44078 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfGaK4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:56:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so65107852ljc.11;
        Wed, 31 Jul 2019 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ruV96eR8x0/hUsLVlDy8Q+NkUQzpxpxvSxroyPzqzk=;
        b=GOtNIbIF+FwSdoSSuqOdCRwipjuBAkt61ISft9SuLdF/xve2q68EEQIwfK3wzwRnrm
         5msw0ky7aRIFGdGG4LAzlEO8Cg1ptWrW4WaThsPDhDS3gXEEziSU4FbslxwFS9srU4iI
         e6+SeP6PfFELBL43QMoabxOvZymfYo7FbCY/XHJE84+sSvjJJfI4EbjLMQP44HpB29mV
         8sE7DBb4AdsCXJlvlXfVSDgxwTHsIUAvISuoY/bPDk1PQa2dzYsS2lpJ0Rygk+GQpD2q
         5Lqt7xoW8oZ+ks1o4sEpFlOXtBD/bumkcw3OH+7ROp7dQ2J/VsBj+Il1SaxnmRoyjoEH
         PYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ruV96eR8x0/hUsLVlDy8Q+NkUQzpxpxvSxroyPzqzk=;
        b=pE/py7v58zQQCj2BB9rJBuohwipnY8FHMjpOV0I0mKovUHGy9qI7y3fI8p5LFceyLQ
         4EGEmqlMpzLZtLDxRvmoZiSFBYH39CL/8vsQ48qijy1nlpwowpX3FF3nE2EWKrX7Usbe
         sV2M1D0jPd5YsrWEoinV6qBCM5ql/QL7fUVcY20CRvuYpV37jBw9CBt7wyGBhByyQr6r
         yl9fBG5cc319pinjteZbmYSqzzf+MojBpQtIN3+67l8nOwDKdHDvC73rviX6TIW3ldP2
         VUfA8sw8iO+eDRUcwZmWk4BrqHT/+5gPcqAkVVR7DbsbmPQiV54shzUsS/pLuPkog4W8
         brOg==
X-Gm-Message-State: APjAAAWIgu3CHAvi1KlULrO4yrX8xH21Niq83pebTfH3uIWHu7huKJv0
        Whz7HmMS95GpVhXdURuE2rI+I0gE
X-Google-Smtp-Source: APXvYqztGOoSbQR9A0xUiUIAyr0EBR8VhfVjH4uIj9PMb0cZ21qTlLVNsqEx7+YL2IiAPD4R1nsaKg==
X-Received: by 2002:a2e:968f:: with SMTP id q15mr21909669lji.30.1564570578578;
        Wed, 31 Jul 2019 03:56:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id e87sm15987690ljf.54.2019.07.31.03.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 03:56:18 -0700 (PDT)
Subject: Re: [PATCH v5 18/20] PM / devfreq: tegra30: Define
 ACTMON_DEV_CTRL_STOP
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190730162236.6063-1-digetx@gmail.com>
 <CGME20190730163331epcas4p2fabd7ccf1b24c0cb95bf3994a289e13b@epcas4p2.samsung.com>
 <20190730162236.6063-19-digetx@gmail.com>
 <033a342c-ffd6-fa51-a9a2-daac36b195f9@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <682c7b5d-eace-8c6a-6117-4b9b6d4e82f8@gmail.com>
Date:   Wed, 31 Jul 2019 13:55:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <033a342c-ffd6-fa51-a9a2-daac36b195f9@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.07.2019 3:37, Chanwoo Choi пишет:
> On 19. 7. 31. 오전 1:22, Dmitry Osipenko wrote:
>> Add verbose definition for the client's device control register value that
>> makes ACTMON to stop monitoring of the device.
>>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 3543fba74b52..8adc0ff48b45 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -35,6 +35,8 @@
>>  #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
>>  #define ACTMON_DEV_CTRL_ENB					BIT(31)
>>  
>> +#define ACTMON_DEV_CTRL_STOP					0x00000000
>> +
>>  #define ACTMON_DEV_UPPER_WMARK					0x4
>>  #define ACTMON_DEV_LOWER_WMARK					0x8
>>  #define ACTMON_DEV_INIT_AVG					0xc
>> @@ -714,7 +716,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  
>>  static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
>>  {
>> -	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);
>> +	device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
>>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>>  }
>>  
>>
> 
> I think that you can combine it to patch11.
> When combining it to patch11, don't need to add the suggested-by tag.
> Thanks.
> 

Alright, will combine them in the next revision which I'll make once the
rest of the patches will be reviewed.

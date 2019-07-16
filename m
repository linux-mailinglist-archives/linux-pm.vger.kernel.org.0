Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C26AB7B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfGPPRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 11:17:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34061 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPPRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 11:17:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so20374742ljg.1;
        Tue, 16 Jul 2019 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJp++cLN27g/ca+Sa3xTKXF6djUalOvIpbg8bqgN3cI=;
        b=T9jwKbpU1/jY0Y5BI8Dbu0hEoblHKGEoBH6OjGJmEtprsNF5GCn1GwD+Ob4RVDo7V4
         M9v+IQzj2kO2Fv9VzQEB3itQ4b3Jij8MSMWiA/M6HZs8iMuvjMiajWkJZ90EmhV0G6wq
         f+78bd+UV2tcR9dnM4w0dfYWSZn6pD8ODyw9mO+wFl1004O+wtqIkvgMBBRI+3NEv7YO
         1S2/fAJQrRdKD/k1EV8XikS+0umorBu01ue1pLxGBkaZiprt7TNADi5jCRIWLA4kiWDd
         CL2wNpqwFIQQmoagM2+neFBYe1Ptx3KMhn89epzn5GBPPrCodv1qDtZRdK+ZDLWVEOdo
         kL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJp++cLN27g/ca+Sa3xTKXF6djUalOvIpbg8bqgN3cI=;
        b=bIiR3Uyd/xgt9MQjiKGd1prL/Ho0pPX0UOAWvQO7Kb5I/i+8kP/B7h3adgmoeSWYIV
         jYsrB2KNNlT9Y4/uxFokYObYGPGW/irtaytEOaZ0FGYfJxVVRUHI0N71f0NGgN22Lnwo
         7av0ckUwmpMa7d90en6Pgq/tTwoMY2vluB6ZbTA2Z0NXU4qvEy6/DPAiE3WZeT4CGZre
         K9SK0WIEygJkOUV1nsOudbzTq4dvs3JDFJumAPCX5IrjYsgdGW/bEY639EWf546+bgIP
         /pcOFx0kRcfcV/tuPFHvW0GoH7i9est0SJYoNUt/6gBYWG52v2bWEIlHsHLIyIr25EzK
         AIkQ==
X-Gm-Message-State: APjAAAWYWmVHPYmVcsj782sO+EiEUoT0wOeCKeIOY9EU2OLqZj3LTbpx
        wFA4P6PxQtL+0a3+YPXRaIPW9T1y
X-Google-Smtp-Source: APXvYqxRp4/Wk6e/4UjTI64BrFWY/3Vyb2ZSjmmef+33NTKhQmfG28HbPFXmIky7rRkADdg3VvRv9w==
X-Received: by 2002:a2e:1459:: with SMTP id 25mr17536548lju.153.1563290240180;
        Tue, 16 Jul 2019 08:17:20 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id p15sm3864900lji.80.2019.07.16.08.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 08:17:19 -0700 (PDT)
Subject: Re: [PATCH v4 10/24] PM / devfreq: tegra30: Don't enable
 consecutive-down interrupt on startup
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223642epcas4p1fbfbcf5181e9a25fbbaad9ef95c56f8f@epcas4p1.samsung.com>
 <20190707223303.6755-11-digetx@gmail.com>
 <933b99a1-ac45-25fb-e8d5-0641ec0cab18@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <54ad7bb8-1ffe-50bc-9003-acc02b1b6f9d@gmail.com>
Date:   Tue, 16 Jul 2019 18:17:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <933b99a1-ac45-25fb-e8d5-0641ec0cab18@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 15:17, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>> The consecutive-down event tells that we should perform frequency
>> de-boosting, but boosting is in a reset state on start and hence the
>> event won't do anything useful for us and it will be just a dummy
>> interrupt request.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 32fe95458ee7..878c9396bb8c 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -558,7 +558,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
>>  	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
>>  	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
>> -	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>>  	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>>  	val |= ACTMON_DEV_CTRL_ENB;
>>  
>>
> 
> Maybe, I think that better to review it by Thierry.
> I'm not sure it is right or not because it depend on h/w.
> 

The CONSECUTIVE_LOWER interrupts are generated if
ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN is enabled and ISR enables
the BELOW_WMARK_EN bit once CONSECUTIVE_UPPER event is received. The
CONSECUTIVE events are used in for the frequency boosting logic and
there is no boosting on start, hence the CONSECUTIVE_LOWER event isn't
needed on start as well. Hope this helps.

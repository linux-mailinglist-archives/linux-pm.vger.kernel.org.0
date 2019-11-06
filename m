Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C335CF1AEA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 17:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKFQOX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 11:14:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41592 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFQOW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 11:14:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id m9so26742980ljh.8;
        Wed, 06 Nov 2019 08:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=joKxQnkkxdO9mIVqa3qEcUbcrPGnQ4/2u0RIGvRgsOI=;
        b=G+22pKwm/joj3iUM7PGkAdPREe4aRd+JfRQvZD+HMveozzNCtXelXOGzp4Yej/8AKy
         p1RyM3lDrg3KrYe01xM1rw1lvB6XkjWUZq47qWbWSng56STBjj7Oh5x/AwDbtq0CiCr/
         qDVdl4K52sIYT2fRymMBzGFpU6PTilEEHDUEfUAC7xQtlggVCSJaggWi5dy+RzpCOtFk
         AwBCzSOqSpEThP3Fgi8jX+QZAgpQq0VUjjMeyRWRIkFbEfKyXu9B+gyrD4LDyWHbiXSA
         +lS23RYWVhaRYBbSHumcsNlkAbZPUQ5ZEmEBYlSMGQlWuvf9sBySYY3+dcpEuy5ol5c3
         h+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joKxQnkkxdO9mIVqa3qEcUbcrPGnQ4/2u0RIGvRgsOI=;
        b=HMEJL5LOUGNfgp7b+bg1TQh1dTPTYfKPvsl9derjmI1Zql1fLqpqOH/b+nFeyO8x8M
         aok6iK3F4kDS6Z8Ii5eNmp5NsTEMw6egMIp1eJCaDqQOw5R0zJ3axaW8oSDwpE1jbf2t
         Qy0kr1kAJ10+uEqklkg/7IIl8LtivSDS5c4WSy0gTp3EglF4sno6kWVls2Kwqt4kG94f
         vVgi6fjAgfP+hMB1/LQ0vzycsICAg1LnyOmfBMaPCaJQf9tS2TG91R/d6Fc2cs6hKkK8
         WwVH8u45Tp0w5FNbIDQCzM7tyS00RIE4DFPxY6zYiDnCx1lKy8rR2bmZZ0ei2VouoYkn
         hLaw==
X-Gm-Message-State: APjAAAWo3oYJwFJi/BdL4lNRbqLRWbc01WYgTXi7CQCtX6wWRASt3iGG
        vJRGAKHDfbnw84cuBRGwCkBuqm7M
X-Google-Smtp-Source: APXvYqxa+cMB8x0PS4pozyT+BWnwQGDkScDO2lOp/wH3K8e16yCmWHjP/WZlpQ4+fXFwlFoucLZrQw==
X-Received: by 2002:a2e:7202:: with SMTP id n2mr2347739ljc.194.1573056858717;
        Wed, 06 Nov 2019 08:14:18 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id l21sm976916lfc.62.2019.11.06.08.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:14:17 -0800 (PST)
Subject: Re: [PATCH v9 19/19] PM / devfreq: tegra20/30: Add Dmitry as a
 maintainer
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191104215617.25544-1-digetx@gmail.com>
 <CGME20191104221855epcas4p3761ca7e09ffa66b686be8b5a840ea383@epcas4p3.samsung.com>
 <20191104215617.25544-20-digetx@gmail.com>
 <0e7db72b-37ff-a36e-11fe-727ed43c26a6@samsung.com>
 <9bd7bfc0-508f-e7fb-d985-d32f2d9a88d8@gmail.com>
 <da10a370-de1d-67c9-a916-cdc1a31c0a96@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <698d5cf8-7c73-edee-e963-581bdf8ca088@gmail.com>
Date:   Wed, 6 Nov 2019 19:14:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <da10a370-de1d-67c9-a916-cdc1a31c0a96@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.11.2019 04:24, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 19. 11. 5. 오후 10:29, Dmitry Osipenko wrote:
>> 05.11.2019 07:07, Chanwoo Choi пишет:
>>> On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
>>>> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
>>>> want to help keep them working and evolving in the future.
>>>>
>>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  MAINTAINERS | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 9f69d01da3a6..4b9679988514 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -10632,6 +10632,15 @@ F:	include/linux/memblock.h
>>>>  F:	mm/memblock.c
>>>>  F:	Documentation/core-api/boot-time-mm.rst
>>>>  
>>>> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
>>>> +M:	Dmitry Osipenko <digetx@gmail.com>
>>>> +L:	linux-pm@vger.kernel.org
>>>> +L:	linux-tegra@vger.kernel.org
>>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> 
> From now, I'll help and review the devfreq patches as maintainer
> and the devfreq git information is changed[1]. You should change 
> the git info as following:
> [1] https://lkml.org/lkml/2019/11/5/39
> 
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> 
> Also, I add my acked-by tag.
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks, I'll update this patch.

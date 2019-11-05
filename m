Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32F8EFE8E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 14:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbfKEN3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 08:29:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45522 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbfKEN3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 08:29:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so15086694lfa.12;
        Tue, 05 Nov 2019 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZOTg6g7hCuvtXnBHLuvcs7p7udu+4fyfYleTU75B/EM=;
        b=p5Xj5ezgsgFtifssHjdEwSuNEJ/GCbehuE5g+iH1oYuhg7XMTeFgXrwV+Ek8E5Q0DS
         fl0zAfWEA94oiTi2JTJneBAiFOf1rhPK//qsATHTyDX+BgAKS84L1hnCVkjcYHD2gyvq
         MKraJGRUChWYOmE6Dkvzkc123NQ/EVuly2Qv2YIoYJeDT3QOhm9vDg5HZpOgJBmEiixK
         4pNSBn1eoGXwqZ/D2cr1JkPThDvWDQUUw1uuvL3wRih70+/Wc/gUGQWRwcDEbbqRO79O
         8iMjrlPHVdbkk7+spFGJUSbTgK75cAWDPUHjUlN9e8graqJWZXa+yXI5HvqH12bj7IMO
         FI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZOTg6g7hCuvtXnBHLuvcs7p7udu+4fyfYleTU75B/EM=;
        b=oVJSbkoYc7JoW6DGLyoyaFTpzD1Uub/xwqlUIyRwpD/hsyBWPeCw7jee0kQfqevjYG
         Fa5lYLIP9n00QDFNfdru6OubzdWaLgLbgLKFgLpKRA6tLT4MZd5QnDUoYixItyKFC5zI
         ltO66NajzZByQ8yYov3mE4YI88JJnNzMc129STVtrgxPTKN7GYROT5KmVkuPqsVLZ/1x
         1m3KmrcRfF7fP0c816kBPttN4zZe85ImyGgktnqkcWSI1r4MEVIz1uOSivhH6/yeSTO5
         O1egMYotLDYJEoxe7nEn6kKoS0ncL7AszGVsDDLFvsTiHahK7YQvoYFrulpmoJLQJPH0
         7+xQ==
X-Gm-Message-State: APjAAAXw9VUGG/5k8kV9dVHGbY5CWL85lQXvESFTMopIaI2lBSQFY9+6
        bp38h3JQd0MDfjkaaxPPR2Q3rIiV
X-Google-Smtp-Source: APXvYqznZXKXH8nF2dSdhtB4hX0nZfuUp2RVCTfMvSd7yo4ZS00SQT3DtwBWwYiNxDgib34c5ZpYZA==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr21011786lfc.153.1572960573592;
        Tue, 05 Nov 2019 05:29:33 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id j23sm8037113lji.41.2019.11.05.05.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 05:29:32 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9bd7bfc0-508f-e7fb-d985-d32f2d9a88d8@gmail.com>
Date:   Tue, 5 Nov 2019 16:29:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0e7db72b-37ff-a36e-11fe-727ed43c26a6@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.11.2019 07:07, Chanwoo Choi пишет:
> On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
>> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
>> want to help keep them working and evolving in the future.
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9f69d01da3a6..4b9679988514 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10632,6 +10632,15 @@ F:	include/linux/memblock.h
>>  F:	mm/memblock.c
>>  F:	Documentation/core-api/boot-time-mm.rst
>>  
>> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
>> +M:	Dmitry Osipenko <digetx@gmail.com>
>> +L:	linux-pm@vger.kernel.org
>> +L:	linux-tegra@vger.kernel.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>> +S:	Maintained
>> +F:	drivers/devfreq/tegra20-devfreq.c
>> +F:	drivers/devfreq/tegra30-devfreq.c
>> +
>>  MEMORY MANAGEMENT
>>  L:	linux-mm@kvack.org
>>  W:	https://protect2.fireeye.com/url?k=9d0ba644-c09508de-9d0a2d0b-0cc47a336fae-300ed90f1ba3077c&u=http://www.linux-mm.org/
>>
> 
> Looks good to me. 
> 
> But, the merge conflict might be occurred.
> After getting the review from Myungjoo,
> you better to send this patch separately
> based on the latest MAINTAINERS file.
> 
> Thanks for your all efforts.

Okay, I'll wait for the rest of patches to land and then re-send this
patch separately. Thank you very much for the reviews.

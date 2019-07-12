Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D56867336
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGLQXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 12:23:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39768 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGLQXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 12:23:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so9888775ljh.6;
        Fri, 12 Jul 2019 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YX2LaoIpYXot2QMtvHwy8R8N2TUvBM9RDNiIQ4cQ7Q=;
        b=nltokVSSN/p/Xkq4jRStuN4Lk6uX7ML12OYVy4WMZHboGjVH5zflEh5vOBKm3BAFs1
         7N0nc0uuadGFPHi7NcI6dYRDU+LyFG6K6hsnQF0mGD/QC9lY8Xnr0UPWBwayvB8V4e+e
         hLON9HJcfPfaQ4O6CAPQlsrDbSFvRbKrCUP8QS9fOxWn6gEpjfVH8bVs5HwzhpDkIkao
         xXp3tdv1I/5AojtEDHVDj7NLqvajgZyzH4mLRg9EY9ET6t6x+BSQPtjtJeIVBpDQYUyv
         cWEYG0ZKwcf+HQ+w10g+gOGCTHuBfgAMYQuKrSGGy0PTcfYLEYL63nj8tY4KgW+IMUlg
         pMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YX2LaoIpYXot2QMtvHwy8R8N2TUvBM9RDNiIQ4cQ7Q=;
        b=itWCDz4nGSoTS9EfEsHX3ZhkbZVrL2nJJMjlMIejv7eFvVHuqvucaGViKwiqDGkkMZ
         SW6Pp/k3vS8zWnBX6jH0UTIcKNePSuDIePSYuw0zOWeTV8nxty6rXgvYY/AZstzjaEB3
         hNF0JBUJMX40zXCx0qBz1pK7Np50spBt1f7mp/BxEhnWpDtyeHXBdcZBa9A0ydiYyKkQ
         ciwEoGMHHjGMmYBy1dIUZC7JO2GCGuKf2ebEHA5aOyAlbRFUuG7oV9XpjI8RI21QHK1Q
         S1NeKdq4qDFYxjg2pz+rrVCfBJYYimEHcCqos6inwXXriWxvUV2Y4hNd2/R0JCSdQ1pd
         IM3Q==
X-Gm-Message-State: APjAAAVA8VtnOdyP9ZT3ollnsD7oGDM7zrlorr17JUKrT0P6I/7fsELo
        nbpAckkj8L/UzFZ1+ohL/UxnZelN
X-Google-Smtp-Source: APXvYqwVVpBQgAJ+iBwLONW4YShysAZHExOb7cuYCRG3sez9mFiaH1eutiGR89WwWo+77OdA1NyzaQ==
X-Received: by 2002:a2e:4794:: with SMTP id u142mr6521643lja.222.1562948627718;
        Fri, 12 Jul 2019 09:23:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id h3sm1549158lja.93.2019.07.12.09.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 09:23:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] ARM: tegra: Remove cpuidle drivers
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190711031312.10038-1-digetx@gmail.com>
 <20190711031312.10038-2-digetx@gmail.com>
 <c087a5cb-2ffa-1cf6-f0bf-631234759a22@nvidia.com>
 <a6e4b43e-369c-c501-6d2e-69d5b940ff9c@gmail.com>
 <73781434-d25a-b17b-aacb-95ace5ac5f95@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9d79ed3e-a37f-af9c-0696-31dc33bbdefd@gmail.com>
Date:   Fri, 12 Jul 2019 19:23:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <73781434-d25a-b17b-aacb-95ace5ac5f95@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.07.2019 12:39, Jon Hunter пишет:
> 
> On 11/07/2019 18:03, Dmitry Osipenko wrote:
>> 11.07.2019 12:26, Jon Hunter пишет:
>>>
>>> On 11/07/2019 04:13, Dmitry Osipenko wrote:
>>>> Remove the old drivers to replace them cleanly with a new one later on.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  arch/arm/mach-tegra/Makefile           |  13 --
>>>>  arch/arm/mach-tegra/cpuidle-tegra114.c |  89 -----------
>>>>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -------------------------
>>>>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 ---------------
>>>>  arch/arm/mach-tegra/cpuidle.c          |  50 ------
>>>>  arch/arm/mach-tegra/cpuidle.h          |  21 ---
>>>>  arch/arm/mach-tegra/irq.c              |  18 ---
>>>>  arch/arm/mach-tegra/irq.h              |  11 --
>>>>  arch/arm/mach-tegra/pm.c               |   7 -
>>>>  arch/arm/mach-tegra/pm.h               |   1 -
>>>>  arch/arm/mach-tegra/reset-handler.S    |  11 --
>>>>  arch/arm/mach-tegra/reset.h            |   9 +-
>>>>  arch/arm/mach-tegra/sleep-tegra20.S    | 190 +---------------------
>>>>  arch/arm/mach-tegra/sleep.h            |  12 --
>>>>  arch/arm/mach-tegra/tegra.c            |   3 -
>>>>  drivers/soc/tegra/Kconfig              |   1 -
>>>>  include/soc/tegra/cpuidle.h            |   4 -
>>>>  17 files changed, 5 insertions(+), 779 deletions(-)
>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.c
>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.h
>>>>  delete mode 100644 arch/arm/mach-tegra/irq.h
>>>
>>> By removing all the above, it is really hard to review the diff. Is
>>> there any way you could first consolidate the cpuidle drivers into say
>>> the existing arch/arm/mach-tegra/cpuidle-tegra20.c and then move to
>>> drivers/cpuidle?
>>
>> I'm afraid that it will make reviewing even more difficult because
>> everything that is removed here is not returned in the further patches.
>> The new driver is based on the older ones, but I wrote it from scratch
>> and it's not only looks different, but also works a bit different as you
>> may see.
>>
>> Could you please clarify what exactly makes it hard to review? The diff
>> looks pretty clean to me, while squashing everything into existing
>> driver should be quite a mess.
> 
> Ideally a patch should standalone and can be reviewed by itself.
> However, to review this, we need to review patches 1, 2 and 3 at the
> same time. So IMO it is not that convenient from a reviewers
> perspective. Furthermore, patches 1 and 3 are large and so easy to miss
> something.
> 
> Is there really no way to have a patch to combined the existing drivers,
> then a patch to convert them into the newer rewritten version you have
> implemented, then move the driver?

Probably I spent a bit too much time with that code, so now yours
suggestion looks to me like an unnecessary step. But I will try and see
how it goes, at least it should be possible to break down the patch 1 a
bit more, hopefully it will help to better understand what's going on in
the further patches if you're not familiar or don't remember how it all
works.

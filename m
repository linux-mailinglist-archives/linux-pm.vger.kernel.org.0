Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D965E1D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfGKRD0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 13:03:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45980 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRD0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 13:03:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so6487496lje.12;
        Thu, 11 Jul 2019 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=poZMR+/iqhG3v4xOfyiATFmovw9vtsgxY+271Xi/Cog=;
        b=BuuDg3G9UWeoBZfqsugcEKWYp/PJ8BC9sfdgtT3jAaN6afHGwxq7NkJky6nBxlHB3F
         2D8S+jhp8NNjLxS5WXAZZUf0p+ytrEFiMB+BQY8VCxB3jH/37dPmG7Zg737wGW/9Mjxg
         KbRJL3n8xwxPoQRisTnHY5lY1oOUS+LWTc7z23mptLbXhGbso7i53JJZXx6xJby78/WU
         ssM25MxbIRLpvMEejsd+to+AQRuWGqhmDuvbMyoCFkV9IYgO6m8CEGZuqCfCDEofNlJE
         Z9/efZ/efuimPX7mafjPtkh+dEGuwaF4NdccOOYmrZDSv6DkaNEvxNFT/lY7HUQy7+ZJ
         IfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=poZMR+/iqhG3v4xOfyiATFmovw9vtsgxY+271Xi/Cog=;
        b=kI+nKsCE1rTB+nf2iQFleJp4nFIuU+PC2CmdGiRP++g3S6WkViNnFfKBlHgKJGHrF1
         FDOCcXC+l8du1JMwjE5ZAkWP/qobLmh+oDLKFIycLCe6O2pmMZ1cbcJj5D2nYN14B/qn
         LovhC1dpHvbn7ObLiVZlW1lQRG8MUqbq8K/JN+kDeu+a3faWNvRAGbynMUTS1xE2sfRc
         19Jr4IP6bLmY4c66YTy+YtbZD4d5b5HEnmJVPDymj6GkjgMLY0s9XjNajByS8A82giMF
         /L3Jlvj5TahEUZi/EW48RlRbtJze3ZiloATs87ZPlZ7td6N76E3pC08PqT0+9HnkvC6N
         ihnQ==
X-Gm-Message-State: APjAAAU+RfyDBwH+5mIHs4Jd0RReVvQmZhUdbtACdh5oWu68ouDwExcu
        CmiHOEftp51wdDftVFqBgYKUPRgm
X-Google-Smtp-Source: APXvYqzEw0D1L1Jf1yGuRGjXpk3Wr2+dEw8JPyoRdvwkR4c5Pb4ONMol/nsDmFw3szvS+rm9TpntNg==
X-Received: by 2002:a2e:3013:: with SMTP id w19mr3187304ljw.73.1562864604445;
        Thu, 11 Jul 2019 10:03:24 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id d21sm808224lfc.73.2019.07.11.10.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:03:23 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a6e4b43e-369c-c501-6d2e-69d5b940ff9c@gmail.com>
Date:   Thu, 11 Jul 2019 20:03:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c087a5cb-2ffa-1cf6-f0bf-631234759a22@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.07.2019 12:26, Jon Hunter пишет:
> 
> On 11/07/2019 04:13, Dmitry Osipenko wrote:
>> Remove the old drivers to replace them cleanly with a new one later on.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/Makefile           |  13 --
>>  arch/arm/mach-tegra/cpuidle-tegra114.c |  89 -----------
>>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -------------------------
>>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 ---------------
>>  arch/arm/mach-tegra/cpuidle.c          |  50 ------
>>  arch/arm/mach-tegra/cpuidle.h          |  21 ---
>>  arch/arm/mach-tegra/irq.c              |  18 ---
>>  arch/arm/mach-tegra/irq.h              |  11 --
>>  arch/arm/mach-tegra/pm.c               |   7 -
>>  arch/arm/mach-tegra/pm.h               |   1 -
>>  arch/arm/mach-tegra/reset-handler.S    |  11 --
>>  arch/arm/mach-tegra/reset.h            |   9 +-
>>  arch/arm/mach-tegra/sleep-tegra20.S    | 190 +---------------------
>>  arch/arm/mach-tegra/sleep.h            |  12 --
>>  arch/arm/mach-tegra/tegra.c            |   3 -
>>  drivers/soc/tegra/Kconfig              |   1 -
>>  include/soc/tegra/cpuidle.h            |   4 -
>>  17 files changed, 5 insertions(+), 779 deletions(-)
>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.c
>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.h
>>  delete mode 100644 arch/arm/mach-tegra/irq.h
> 
> By removing all the above, it is really hard to review the diff. Is
> there any way you could first consolidate the cpuidle drivers into say
> the existing arch/arm/mach-tegra/cpuidle-tegra20.c and then move to
> drivers/cpuidle?

I'm afraid that it will make reviewing even more difficult because
everything that is removed here is not returned in the further patches.
The new driver is based on the older ones, but I wrote it from scratch
and it's not only looks different, but also works a bit different as you
may see.

Could you please clarify what exactly makes it hard to review? The diff
looks pretty clean to me, while squashing everything into existing
driver should be quite a mess.

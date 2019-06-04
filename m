Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED40F34A84
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfFDOff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 10:35:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42305 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfFDOff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 10:35:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so8801002lje.9;
        Tue, 04 Jun 2019 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqJBuqEPpW0/G/35TiXjjTPFxqh2poe5DD3UV/6cHjQ=;
        b=A3TkCEZ1/wrrjxbM6ojxs2I7Y6JlyxMVz24B3dz7fTrWqFDyNE5coXTSPmLbda7n0V
         hnA5dJeVw9fGH9kVPopJ+/imzouwPANdzmPrdXU4XbyiD9kMFEfuNviZhh01Ag6euVS5
         d7oy0ZwVgilDk8KxpDiIFrEqFIkdeLaUHmiWK8tQ7/TrOBjKMkoJWscGKQYVstlLPD9e
         TWpwop0muFEDS0yKqmxFdwv+KLAwoQEuKGDr/kvn8v+a1ck4K4B0iuc+6hdrItFZR5AA
         HAsrXpJSqQY2SXCcWUVVbpUSlGLEIc1zsZulM6OkI9cpmoryD5vkFwYvwKWu5Ll6r1jB
         o33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqJBuqEPpW0/G/35TiXjjTPFxqh2poe5DD3UV/6cHjQ=;
        b=omy1l0v6pxLjDAAwhOed2XGf2x8fBhtq0ldjTK+BkhK3agaBspAQ2U2s/leM5FLM9u
         dYznRK2nTVlx1LA4KlDLSqs8wAI9/u2epuptG6OQPrfaEb4WtQqQOPjzO7rg65udAouR
         vXx57E+g1LtJFg9LWHBwpDLTHv81E++XVfu4fv6jczPslpL34HzpN4nmAMrsmQNLkuYP
         1WNeMu9rDLfhj7pKIfGh+H4kzZEmtwwYcjYWUo7Yh/JDHMB11GFNNXTCauxxHJP3z7iE
         HNoutS0jCQb8Qy84JUCqV7Kk357V4NMvPRU+ZfPf8MkDPzsLZPyUeDYtDBp4pVvNTn9f
         z2mg==
X-Gm-Message-State: APjAAAW+t29QPFy9s+YaPY6MLai9LYGXetsJ1nhmsFNpXz5+ZJTVxRDh
        oli8o35e8MWWk/vl1FoLar0s06Pe
X-Google-Smtp-Source: APXvYqxNnkAa+XVdvuRuE4JkklgBcKCEczDGSWjqykwVTZIbQnnwH8TF9WyZitk3FfAOh4H1CUDHjw==
X-Received: by 2002:a2e:9a19:: with SMTP id o25mr4677921lji.63.1559658933190;
        Tue, 04 Jun 2019 07:35:33 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id c4sm3190976ljj.22.2019.06.04.07.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:35:32 -0700 (PDT)
Subject: Re: [PATCH v4 15/16] PM / devfreq: tegra: Rename tegra-devfreq.c to
 tegra30-devfreq.c
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-16-digetx@gmail.com> <20190604112323.GO16519@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f96a88fd-5d99-12e8-abbd-82c32d60fab8@gmail.com>
Date:   Tue, 4 Jun 2019 17:35:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604112323.GO16519@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 14:23, Thierry Reding пишет:
> On Thu, May 02, 2019 at 02:38:14AM +0300, Dmitry Osipenko wrote:
>> In order to reflect that driver serves NVIDIA Tegra30 and later SoC
>> generations, let's rename the driver's source file to "tegra30-devfreq.c".
>> This will make driver files to look more consistent after addition of a
>> driver for Tegra20.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/Makefile                               | 2 +-
>>  drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} | 0
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>  rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (100%)
>>
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 32b8d4d3f12c..47e5aeeebfd1 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>  # DEVFREQ Drivers
>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>> -obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
>> +obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> 
> Technically this changes the name of the driver. Sometimes boot or other
> scripts rely on those names. Perhaps a better way of keeping backwards-
> compatibility would be to do:
> 
> 	obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> 	tegra-devfreq-y				+= tegra30-devfreq.o
> 
> That way you can later on just add the tegra20-devfreq.o to that driver
> as well and have them both ship in one .ko.

Combining two drivers into a single kernel object certainly doesn't work
("multiple definition of `init_module'" error, etc).

Indeed, this changes the name of the driver. It should be fine as long
as it doesn't hurt anybody, so what about to keep this change as-is for
now and wait for complains? I promise to make a revert if this will
cause real problems for anyone. Let's be realistic, there should be a
very little chance that somebody will notice this change. ACK?

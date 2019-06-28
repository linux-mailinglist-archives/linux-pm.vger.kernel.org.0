Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92612598F9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF1LFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 07:05:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44706 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1LFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 07:05:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so5729690qtk.11;
        Fri, 28 Jun 2019 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TQD3Jo1dHRA0U9Z4yvwoDM+Y9nWZex8/mcRO751hgME=;
        b=YbR0sg/rKOaL03h+DiWSU4ysk+NT9PL05a9fYsci+cy5FuCTxEGXRSPg6Ob8+B1zVt
         tAukj1brmVUfLw3n3mSbZmLPxUi6wC58oph5iHZnzM4iu1IkKQvEmHb9JmKRnMdsWRPs
         yNpG4gVrlMsxUE/NyoolJK/TyeGIX65K4GpPpB2aaT02l1yKwDLpq4k6QU7PoHXHPRdN
         rH8od9VPAaSOn8OIO52k0BAUeGtN+TsvTnak8pAX0R/mhM8q36pr6muDCxkivLN4ju1N
         EMkCIWeZgh9r/h/1cAatBOaDo2s0DuDCR0vHr+Cb8XL5ubkigSb+ttAhexG/z2X29/2S
         a3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQD3Jo1dHRA0U9Z4yvwoDM+Y9nWZex8/mcRO751hgME=;
        b=r2UU7Nk0ORDq6suMa6fLb7BMa/BtJ/2LHl2sD3kkxXWx4rY6Ctw9jmhiB5VzE3lJe4
         kZg9imze8gbxICZB6kEFsMFiy/DK0lbs4YC3GcWYQNSB9jXzBvpnBmNApdOa0nb/zL8p
         ZY0v09BQDhXGX9NZCKe4znAMYnW3J8dKkGaRdGMQxUViUklH/oGwfujEGp8wF5Bmnr3y
         WoA7w25eziUjP4253vdUvCvSjMNXZdxIVoMsqN5VwYl+7TkR6PzggAnr+Ig6M6lN5Xf4
         rPUbsMjTgW+ZCVa/gO1qCznKU2cHN18FAlMTUxoYs6EexXDq+JOmcGESeLqZwnAlK7RD
         +MoA==
X-Gm-Message-State: APjAAAUMkBLtDalrHuy9bHCJkIsMXV1ygX8coOYlm2XY+4PVuXj0t6xf
        dxZoCLzAmt0epLSmPTBIVO3BfXHM
X-Google-Smtp-Source: APXvYqz9LySnjsdwQIaft4JM8+Lb467eu+Ucee2kMKLVnLBEwkvbZf9YsKomfFNthGEB3eEYjOdvgg==
X-Received: by 2002:a0c:bd9a:: with SMTP id n26mr7481819qvg.25.1561719951477;
        Fri, 28 Jun 2019 04:05:51 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id n3sm806816qkk.54.2019.06.28.04.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 04:05:51 -0700 (PDT)
Subject: Re: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190628103232.2467959-1-arnd@arndb.de>
 <c2701295-0fd6-c5ec-59d4-6e6b3b3bdb8e@gmail.com>
Message-ID: <cbf6cff3-f5f5-66ea-9cca-86eb93f23c50@gmail.com>
Date:   Fri, 28 Jun 2019 14:05:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <c2701295-0fd6-c5ec-59d4-6e6b3b3bdb8e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.06.2019 14:00, Dmitry Osipenko пишет:
> 28.06.2019 13:32, Arnd Bergmann пишет:
>> Compile-testing the new driver on platforms without CONFIG_COMMON_CLK
>> leads to a link error:
>>
>> drivers/devfreq/tegra20-devfreq.o: In function `tegra_devfreq_target':
>> tegra20-devfreq.c:(.text+0x288): undefined reference to `clk_set_min_rate'
>>
>> Add a dependency on COMMON_CLK to avoid this.
>>
>> Fixes: 1d39ee8dad6d ("PM / devfreq: Introduce driver for NVIDIA Tegra20")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/devfreq/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index f3b242987fd9..defe1d438710 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -107,6 +107,7 @@ config ARM_TEGRA_DEVFREQ
>>  config ARM_TEGRA20_DEVFREQ
>>  	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>>  	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
>> +	depends on COMMON_CLK
>>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>>  	select PM_OPP
>>  	help
>>
> 
> How is it possible to happen? There is a stub for clk_set_min_rate() when COMMON_CLK
> is disabled .. Could you please show the kernel's config that causes the problem?
> 
> Moreover that was me who added the missing stub for clk_set_min_rate() in [1] to fix [2].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/clk.h?id=b88c9f4129dcec941e5a26508e991c08051ed1ac
> 
> [2] https://lists.01.org/pipermail/kbuild-all/2019-April/060292.html
> 
> So this patch looks wrong to me because apparently it fixes a non-existent problem.
> 

Oh, wait. That was "implicit declaration" and this one is "undefined reference"!
Still looks like something else need to be fixed..

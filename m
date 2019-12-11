Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A411AE11
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfLKOoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 09:44:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43126 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbfLKOoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 09:44:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so16885042lfq.10;
        Wed, 11 Dec 2019 06:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RLcmDX3Xl0I1T2TfjUDQrn1yh+H1GJi9jjADEglfdt0=;
        b=SdQ+mOfgltwR/Q22SJ8lSEx3kpyybc82wHJHFeHjfN76Lm8bsgzzbfzp3OPqY3O5IM
         chUKPt0VD09h59lpk6zJyJXscq34fugbNdATsiw49BJaI0Pt91km3Pw8mojw/mHpuoGe
         MVXlXFmZnG//nqmDBeHwpmVEhKPMVPzcN3Ree1rTwhVvXJlwomLEKyWGG8/Fe2TbYBe+
         v1RRl8KH5Q32xggmPC8P2BHHKmnxM9uSs2K5mYK/LK6oV33UWJvIdPURmt1sDpiLnTtY
         w/8w7Q2/+c+STpgW2wAy7YYTzUVBeLrb9TbHsmb4aLU/6WoofFr/oh/AAFMxOU5Wr/e0
         yObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RLcmDX3Xl0I1T2TfjUDQrn1yh+H1GJi9jjADEglfdt0=;
        b=Fhx7VEPkH8UDYSIVQfWEWHZvqOy7d5l9Wsab/QHHNjpK11FSgf0Y4xNLOmDoIAJZ2L
         Bz80FNTgvtBrSFGmKtSRAy/YE30q00YmV5dC+HNjdLCbiLyD2KM9E/Hu7U8j5MMs+BO2
         wUAqEUDxcJ6KDGU48EdSsYXfeylqYPn9UMqa9mvxtrYJIJQz0BYr9vZvkYb/o11o4qJg
         h1gyd4Q8cSjFkZwfReIq1pPSw+jivgG5e9TbfeyuvDuXOOT9fqypq0DKmwt2KGZgUtPC
         2KlhWwF2RyPp3mgl25VnUkwttxi9LGuu4X95FlxAf/iR41k5qw0xuHgSpUFUk3LwnCBs
         DuKA==
X-Gm-Message-State: APjAAAXcGgJqBVWWksaE6wm+clmEZ2MhhzWJqMOyV+365H6+Ln4X7Krs
        XttWYtxfBgvZRayRLzjhZnryt9bU
X-Google-Smtp-Source: APXvYqx+pHd1o6C8oJgYgMxRKZGy92H63UCjcCY3WzShV/a2GIJ6XLcQ7vKColdhnQ22qudl2XcvrQ==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr2483615lfa.63.1576075469979;
        Wed, 11 Dec 2019 06:44:29 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id h19sm1279298ljl.57.2019.12.11.06.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:44:29 -0800 (PST)
Subject: Re: [PATCH] PM / devfreq: tegra: add COMMON_CLK dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191211125411.1857250-1-arnd@arndb.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b6aee51a-295e-dfa3-d9a7-cc378afa0373@gmail.com>
Date:   Wed, 11 Dec 2019 17:44:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211125411.1857250-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.12.2019 15:54, Arnd Bergmann пишет:
> Compile-testing this driver fails if CONFIG_COMMON_CLK is not set:
> 
> drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_target':
> tegra30-devfreq.c:(.text+0x164): undefined reference to `clk_set_min_rate'
> 
> Fixes: 35f8dbc72721 ("PM / devfreq: tegra: Enable COMPILE_TEST for the driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index defe1d438710..f712c3de0876 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -98,6 +98,7 @@ config ARM_TEGRA_DEVFREQ
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
>  		COMPILE_TEST
> +	depends on COMMON_CLK
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> 

Hello Arnd,

I was about to send the same change because Geert Uytterhoeven reported
the problem a day ago [1], but you beat me to it.

[1] https://www.spinics.net/lists/linux-tegra/msg46169.html


Thank you very much for the patch!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

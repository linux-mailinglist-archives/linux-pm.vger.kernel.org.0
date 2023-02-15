Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53661697D14
	for <lists+linux-pm@lfdr.de>; Wed, 15 Feb 2023 14:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjBONYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Feb 2023 08:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjBONYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2023 08:24:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7BF3591
        for <linux-pm@vger.kernel.org>; Wed, 15 Feb 2023 05:24:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k3so11504542wrv.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Feb 2023 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UPG3Ps5bQsYanoFaHsSUnU9dtAfpghrnqTZxU5VJQd8=;
        b=PLl8BqJHUnqbarza30vH1AysNBawltXZawto7JnNQcDHp+P8jsodXp0q2uemiChwQv
         8C/R10D+4620hJflYFMRB5s4FrRF9Uk8ZmjIGvGyp7RYyxhwqWyE0QIZsWKcMfwBFjJj
         PicpT/xJV/t8u0FWGpU58n+QCDwJd+W0dse5eYDzwQGUOFQ2Ow0rGZ/6XRknb3k7eXMC
         kl88/oySe45x/dfTlvBxzgn6JX6jjDYfCdXmqG824EiQM3NrvnoykKg9RAidkA156B09
         3yhpd1CBPddLi0NcTqMlRCQnVZAd6xBxfjUrdDu2FbqyK+JUhml1CRh8/5xrSCL/+F+J
         EQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPG3Ps5bQsYanoFaHsSUnU9dtAfpghrnqTZxU5VJQd8=;
        b=f/ZL/lR/+EYsyQu05+hwWgNhtPCBeQcT0A+C/lwzkhWoBdV4k4C88TEidKYIYK5nFT
         gErRkgFO35JJylKngmoqG4EJ5Kd6bUUzZVHYb8D9v9QV6e3s8/iQatfzhAVNOG8DSgLb
         bFGnwV4YcRvC1pdmOvpiwVoYYHutSOvnPlpehXqHJpHjcqpxHAiIrPFREDKDmzXPxhJH
         mleqIYkQJeyD9b+30awuj2nyvkohEzZnEx2MBjDvIQRqfpedJcHoPoCKGaM40Zn4P8KV
         fwqkGhOlVK45P91MHfBsU2PwyrIt+JOPUw1YkpM8ZXokaWEmRkrHZhBDhV6Xp4P77NG8
         EHew==
X-Gm-Message-State: AO0yUKX6DKDp2ct9MZ0jmJsX1AXx/ziioGCzPbk4ZMN4OyigZ6jyub6N
        9A2zc8hbykjjZ2Qu2V8tpodTdIjBjd0173hUi60=
X-Google-Smtp-Source: AK7set9ASCujwkfYbmtvORKI+VoJdJbLWwudLIdBRAKAKGZf+TAiDHd4SsNl8Obo7bzM70kGVst4tA==
X-Received: by 2002:adf:f6c8:0:b0:2be:34fb:673 with SMTP id y8-20020adff6c8000000b002be34fb0673mr1479401wrp.52.1676467443642;
        Wed, 15 Feb 2023 05:24:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:77be:c518:6ccc:9a53? ([2a01:e0a:982:cbb0:77be:c518:6ccc:9a53])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm13431166wrq.25.2023.02.15.05.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 05:24:02 -0800 (PST)
Message-ID: <3e9cd799-48ee-51b8-f969-303690ca626a@linaro.org>
Date:   Wed, 15 Feb 2023 14:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] power: reset: odroid-go-ultra: fix I2C dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Asmaa Mnebhi <asmaa@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230215124714.2872813-1-arnd@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230215124714.2872813-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/02/2023 13:47, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since this driver can only be built-in, it fails to link when
> the I2C layer is in a loadable module:
> 
> x86_64-linux-ld: drivers/power/reset/odroid-go-ultra-poweroff.o: in function `odroid_go_ultra_poweroff_get_pmic_device':
> odroid-go-ultra-poweroff.c:(.text+0x30): undefined reference to `i2c_find_device_by_fwnode'
> 
> Tighten the dependency to only allow enabling
> POWER_RESET_ODROID_GO_ULTRA_POWEROFF is I2C is built-in as well.
> 
> Fixes: cec3b46b8bda ("power: reset: add Odroid Go Ultra poweroff driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix !

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

> ---
>   drivers/power/reset/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 7059bd1f2ee7..8c87eeda0fec 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -144,7 +144,7 @@ config POWER_RESET_OCELOT_RESET
>   config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
>   	bool "Odroid Go Ultra power-off driver"
>   	depends on ARCH_MESON || COMPILE_TEST
> -	depends on I2C && OF
> +	depends on I2C=y && OF
>   	help
>   	  This driver supports Power off for Odroid Go Ultra device.
>   


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B524EF6C
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHWT2M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWT2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 15:28:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD2CC061573;
        Sun, 23 Aug 2020 12:28:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so7234774ljk.9;
        Sun, 23 Aug 2020 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s13OsjDQPtL8KuQJ8dsi0mLtQkr0NRKTnj5zGuiKZ2E=;
        b=sCt6RdWAVKRlkVqrE5hOoHlkuA4JCN3B2ZXzyWBY1O2D1PB+RqJqnIHGLoABvhIBOv
         YCacflFemwc/hNH8GMI3OO9592O+kDPwMObrQSG0CoTvsm0paMihgj9KNVutz/dmo0SB
         MpV/VOvF9iU+K8bK7HSWE+2jp/KRmrrxqDDyeYCJa2rXraQp4QVi7JQ+AYHjQ8El3Cdk
         KLiDkDDtVzqKVHMGKCZTExJlNPhCGcuvRg7zyvsNqZb2MYcA86qnBFJWqzacoV0IOHbM
         akVFH9RJ9dY9V1+atJOc3hhWYG1B0PLD+hRGjDXG579cb7/h4qTvu580RSmOMMUJkcaU
         wysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s13OsjDQPtL8KuQJ8dsi0mLtQkr0NRKTnj5zGuiKZ2E=;
        b=DauHkE0F4m8a2SH3vMbg+0xz+Iuig4vrsxqdxflIn9bDIt+1Qi9GfWJRTBOD2HFmKd
         dQqUuv8cgMdG/m0YdQAJ9vgcbegZa9hsvfkcHFCbHqH781R9mbjdWQvKob1yZ8p7K00y
         WWBuj5+vejNaBSx5IeKvV7wcC9j+/Sc2CTsfwPazX1FE3GK8Y0aJcUwurEUnrkbBeVtm
         4bUBWI0NVi36FOfcsGRWScAg7hwqll1H2zgOf8fCd1NSCWFlTxL6tHrjEBguChylqCOY
         jNcBkiokGlqDz6uPWEYKW9So/Zvqbi0XkZUl/I2+1/9qvuPcrnZv5sJ1SeEItFC3izGy
         m3wA==
X-Gm-Message-State: AOAM533smz7GaBmMqfuOx8Fx4qoB8DUcupyKYwZ8cPIMkU4rHIH6C28A
        njZqhVULn25a66wPydv1DlsoAJczveA=
X-Google-Smtp-Source: ABdhPJwDfjK/HE0tON7VnxYRNaHOg4uBo5YnQYPxLlscHgVNfikIIom+nVrHDtNT8aZCv4KBPiNAHQ==
X-Received: by 2002:a05:651c:110d:: with SMTP id d13mr1057059ljo.206.1598210889300;
        Sun, 23 Aug 2020 12:28:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id i24sm1765732lfo.16.2020.08.23.12.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 12:28:08 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-2-digetx@gmail.com>
 <20200823181653.GC209852@demiurge.local>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <82abab10-9af6-a9c4-b241-d5a3af5b588d@gmail.com>
Date:   Sun, 23 Aug 2020 22:28:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823181653.GC209852@demiurge.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.08.2020 21:16, Lubomir Rintel пишет:
> Hello,
...
>> +config MFD_ACER_A500_EC
>> +	tristate "Embedded Controller driver for Acer Iconia Tab A500"
>> +	depends on (I2C_TEGRA && ARCH_TEGRA_2x_SOC) || COMPILE_TEST
> 
> This seems to also depend on I2C and OF. Perhaps I2C_TEGRA and
> ARCH_TEGRA_2x_SOC imply that, but it could lead to build failures with
> COMPILE_TEST=y. 

Hello, Lubomir! You're right about the I2C because it could be compiled
as a loadable module, good catch! The OF seems should fine as-is.

...
>> +static struct a500_ec *a500_ec_scratch;
> 
> If this is only used for power_off, please rename it. I've been told to
> do so in my driver: https://lore.kernel.org/lkml/20200519104933.GX271301@dell/

I don't mind to rename the variable, but not sure whether it will be a
worthwhile change since _scratch is also a common naming scheme among
MFD drivers. Please see max77620_scratch for example, which I added
about a year ago.

...
>> +int a500_ec_read_locked(struct a500_ec *ec_chip,
>> +			const struct a500_ec_cmd *cmd_desc)
> 
> Any reason you're exporting these to the cell drivers instead of using
> regmap?
> 
> I think regmap would also help you with the locking if you set .lock() and
> .unlock() callbacks in regmap_config.

Yes, perhaps you're right. Right now I can't recall what stopped me from
using regmap. I'll give it a shot for v2, thank you for the suggestion!

...
>> +static struct notifier_block a500_ec_restart_handler = {
>> +	.notifier_call = a500_ec_restart_notify,
>> +	.priority = 200,
> 
> What would happend if you didn't set priority explicitly?

Then the Tegra's default CPU soft-reset handler will be used for
rebooting [1].

[1]
https://elixir.bootlin.com/linux/v5.9-rc1/source/drivers/soc/tegra/pmc.c#L977

...
>> +MODULE_LICENSE("GPL v2");
> 
> MODULE_LICENSE("GPL");
> 
> Your SPDX tag suggests newer versions of GPL than v2 are okay.

Okay! I'll change this in v2, thanks.

...
>> +#define A500_EC_COMMAND(NAME, CMD, DELAY_MS)				\
>> +static const struct a500_ec_cmd A500_EC_##NAME = {			\
>> +	.cmd = CMD,							\
>> +	.post_delay = DELAY_MS,						\
>> +};									\
> 
> I think that the mfd driver should decide about the delay, not the cell
> drivers.

This should be a good idea, especially combined with the regmap, thanks!


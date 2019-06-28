Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713BE598EE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF1LBD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 07:01:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35145 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF1LBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 07:01:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so5777756qto.2;
        Fri, 28 Jun 2019 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PHi/l29WbV9XGvG08yaJu2JZdqFHxJ2LPSLS5LkPUgE=;
        b=rt96ENqdL6G1Tr+cMkk1T3g2/2K/RUQTjrLRXsbKsNNIdHOI9ySelUsBGog5QVqSNW
         ECre0OW3JSUxqdLSDlGV3coL8SQo2pvFnFstPm2YjZRAS0q+JHi2POrvwQoa0jyMB1eK
         FgwziXKA6DsEJy7nrBpj+kqwkSZeY4dc1z1w1GPnhct1T/An4vCarpp69gD7YicGdajs
         cUGltF3PhOff4yz+PdGjMdGEv89XE3IHuDMQu2IXZYX4uYf/2MjNpPkZMnBJLV+RKwhf
         bu6wDQ/1gunlF/geSeQnojUUP9qeo2guScCLS05E0L9JACvlJ2kqbhbfvrsaqcdFaYY0
         u8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PHi/l29WbV9XGvG08yaJu2JZdqFHxJ2LPSLS5LkPUgE=;
        b=tDs1egUXrqIQGzEganA1kMQkiSDnoM5ma4S+SNcQkbkMQU4Mqzs9Sbu/6DRuQiOVHm
         /pXQDW5B05ftFdqFzMDMXraMEMqZKFFAHmtkht5D0Zvlq/EIiVv0nHrwRHEPqwcqocFS
         jldQVyrFzy9fBApbD/OH6qZGHLRyPfxG3roSe7/I/dFx2QRaRUGzinP3F78YFRsOknpV
         Mg7AwdAi9OpllPTBzBkLL+pQUkuo+L6DB/ea7k17oKJ+9tbMDNQNGgfd2DR1hZiJElSC
         FRx2DJ5QYgLllIphETEubLXZTPhLJNX5eD579jNWv0TaqUx4RDj/oJx0/65ILRXiS7PW
         7N2Q==
X-Gm-Message-State: APjAAAUGI8YRLL4fdGFIeTw9ZcL/GkMd1cGMtZWFR3Rgw5+OS8Oy6CMk
        zAoDL/iyQPRbGNqZHBUcmuAcCVxC
X-Google-Smtp-Source: APXvYqzwCr+FGhUpSDu7u5VfwZ94QnIWoiCWRUcr230qT8m85gg0sysgzx3uQkUbImDHJrydKogJZg==
X-Received: by 2002:a0c:d7c7:: with SMTP id g7mr7476473qvj.171.1561719661775;
        Fri, 28 Jun 2019 04:01:01 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id u71sm883674qka.21.2019.06.28.04.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 04:01:01 -0700 (PDT)
Subject: Re: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190628103232.2467959-1-arnd@arndb.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c2701295-0fd6-c5ec-59d4-6e6b3b3bdb8e@gmail.com>
Date:   Fri, 28 Jun 2019 14:00:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628103232.2467959-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.06.2019 13:32, Arnd Bergmann пишет:
> Compile-testing the new driver on platforms without CONFIG_COMMON_CLK
> leads to a link error:
> 
> drivers/devfreq/tegra20-devfreq.o: In function `tegra_devfreq_target':
> tegra20-devfreq.c:(.text+0x288): undefined reference to `clk_set_min_rate'
> 
> Add a dependency on COMMON_CLK to avoid this.
> 
> Fixes: 1d39ee8dad6d ("PM / devfreq: Introduce driver for NVIDIA Tegra20")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index f3b242987fd9..defe1d438710 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -107,6 +107,7 @@ config ARM_TEGRA_DEVFREQ
>  config ARM_TEGRA20_DEVFREQ
>  	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>  	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
> +	depends on COMMON_CLK
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_OPP
>  	help
> 

How is it possible to happen? There is a stub for clk_set_min_rate() when COMMON_CLK
is disabled .. Could you please show the kernel's config that causes the problem?

Moreover that was me who added the missing stub for clk_set_min_rate() in [1] to fix [2].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/clk.h?id=b88c9f4129dcec941e5a26508e991c08051ed1ac

[2] https://lists.01.org/pipermail/kbuild-all/2019-April/060292.html

So this patch looks wrong to me because apparently it fixes a non-existent problem.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3AD268435
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINFql (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 01:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgINFqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 01:46:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE45C061788
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2020 22:46:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so9893283wmb.4
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2020 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDD9xbXrOHoErjZLRR+/+AtDLaCnVmHRrkVezZM912Y=;
        b=eY+okMC8xfBiRH3cE/90LzCYt3zAjKBnNwVqBIqPfCCKGfS4LiZkI1tz5tVuAKD9Bt
         gHHBuuvOIghEFOViq4ZTL21bCZXni8/Zlat4xIzctM+SS4EZdWsHZhBzUfXknGocvPSZ
         mn+q3/tooHeVkXczfc+2yfawVsDQCwVVlOXbeB0gLAozyKoOoX7PO0KpkOk0jzw0OKiz
         3VTlXVTjQia8VZeLobuuTUCrBFsjKu2CQdjs7vPq06bmvTkCRG7NOvMKj6xW/SGdOY9S
         MQSRrUXP4HCb/O+HyjwfRdOpOfcCETks981G/J9Y+KeI7juc5WC4LpooQ2Fz/esbZE+4
         Vf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDD9xbXrOHoErjZLRR+/+AtDLaCnVmHRrkVezZM912Y=;
        b=Hzal5CQYsv8LHPoLozuAiYR2jKiznbtHQF51kAQAqDFilDo+N0Y30nYk4MZKpLHE29
         WsoFWcLlg+f85P9SzgrsEZ8N+O81ZcQ0dBE7QyjspA+Y5ysHAUjHjTDaAhaq5yb/rCJk
         37fMylfg3JuXBl07mLEopkKBqvvJq/7oKt88qETiWGP9/UJN/bXK0QtAFv+Aq+Qbj4RA
         0pB7PHmcMq93iwXvlGDc5cMUzRx+E2UrAx4IjfdqcAcBC84KIQelRqbBbeQkS6xBREdA
         5n4SS2GO0B+vcqjL+RcbUkGEDciR65BKM8J85RxjJo63zAn8QCajcTFm6imoffUBggJh
         lthA==
X-Gm-Message-State: AOAM533EdW8lZQ99WVoi+bZw2R+B5kOkQxAQPjGEZ2I8KPVvgepi1JHM
        y0TVL3iHiKwRNwb/RoNZwYrsirK+6+G+CnjN
X-Google-Smtp-Source: ABdhPJyUVCGBR93hL6wzG0lCe51kAZFFaJG76CajpH7T3daMVWhHg+pdihb6Vi5OLEnx0XzSO+6QCg==
X-Received: by 2002:a05:600c:22c5:: with SMTP id 5mr13272418wmg.34.1600062412115;
        Sun, 13 Sep 2020 22:46:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a402:e7fb:d494:d130? ([2a01:e34:ed2f:f020:a402:e7fb:d494:d130])
        by smtp.googlemail.com with ESMTPSA id h204sm17849917wmf.35.2020.09.13.22.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 22:46:51 -0700 (PDT)
Subject: Re: [PATCH] cpuidle: add riscv cpuidle driver
To:     liush <liush@allwinnertech.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rjw@rjwysocki.net,
        anup.patel@wdc.com, atish.patra@wdc.com, damien.lemoal@wdc.com,
        wangkefeng.wang@huawei.com, kernel@esmil.dk, zong.li@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <80bc85f5-fba3-5f08-4d73-372b5f495833@linaro.org>
Date:   Mon, 14 Sep 2020 07:46:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/09/2020 03:52, liush wrote:
> This patch adds a cpuidle driver for systems based RISCV architecture.
> This patch supports state WFI. Other states will be supported in the
> future.
> 
> Signed-off-by: liush <liush@allwinnertech.com>
> ---

[ ... ]

>  
>  obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
> diff --git a/arch/riscv/kernel/cpuidle.c b/arch/riscv/kernel/cpuidle.c
> new file mode 100644
> index 00000000..a3289e7
> --- /dev/null
> +++ b/arch/riscv/kernel/cpuidle.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/cpuidle.h>
> +
> +void cpu_do_idle(void)
> +{
> +	__asm__ __volatile__ ("wfi");
> +

extra line

> +}

As for the next deeper states should end up with the cpu_do_idle
function, isn't there an extra operation with the wfi() like flushing
the l1 cache?

> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd..f6be0fd 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -62,6 +62,11 @@ depends on PPC
>  source "drivers/cpuidle/Kconfig.powerpc"
>  endmenu
>  
> +menu "RISCV CPU Idle Drivers"
> +depends on RISCV
> +source "drivers/cpuidle/Kconfig.riscv"
> +endmenu
> +
>  config HALTPOLL_CPUIDLE
>  	tristate "Halt poll cpuidle driver"
>  	depends on X86 && KVM_GUEST
> diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
> new file mode 100644
> index 00000000..e86d36b
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.riscv
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RISCV CPU Idle drivers
> +#
> +config RISCV_CPUIDLE
> +        bool "Generic RISCV CPU idle Driver"
> +        select DT_IDLE_STATES
> +	select CPU_IDLE_MULTIPLE_DRIVERS
> +        help
> +          Select this option to enable generic cpuidle driver for RISCV.
> +	  Now only support C0 State.

Identation

Rest looks ok for me.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

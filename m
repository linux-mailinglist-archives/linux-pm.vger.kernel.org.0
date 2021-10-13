Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD042CB76
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhJMUvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhJMUvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 16:51:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A100C061749;
        Wed, 13 Oct 2021 13:49:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y26so17339537lfa.11;
        Wed, 13 Oct 2021 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYOHGxf2r6rYeOUDd6Yc620BvdGiAPSc5bWMT6QlQfI=;
        b=DZlMgnMbolCpO3CS7e36G9Q9EbeQwtLsgWDaj2Tqn94OPUqOYas4ZsbnnPvyOcCmpS
         AB6ioepXDuA/R8K5Ahwy+VDCa3J9jus1mQXvzQ00zpc0i88IPfK4cVtzVLb4NYN3x+VW
         s0keCoeQ0WrbkBMwriPSBSc8tKAOSs2jv4itxdPvVtjwcS0SfuNU2JshN4HY0yKGgHgR
         huIdV/YfL01wogWi7V0t+MeTEPUsxNb8UgPz0NnqVeQgET+nTgs1ezc1KZidzuxhFoxN
         o/bkmYKlP2ztZDAsvY3T6PNesoT5NksPdFX4sqGFVzO6RVwf4onUHNcqS0Hs4IMa5uzz
         xgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYOHGxf2r6rYeOUDd6Yc620BvdGiAPSc5bWMT6QlQfI=;
        b=30KlRl/NDmJGaAguFdYNU3hLHp6PQEnfQf/gGb/dlwaC3G6bXasZyNsdqh1UtoWLqf
         WByzSxsv1vjIjJTnrSob2wnp7QZalxIDmfiKQeTD+4ib/EcDVIiVRAGA21KwfnRxYBCS
         CxAQLhovBdOl4YLCKm+p7lSeFq1UGb3bGlxNlYb4MiZ/If3qGd2dFnAly5V+4bOwLk0s
         zPTtDDGjfkW2ZBjvW9kyPf7ht1da4jVeyIJ41yUWMwU8/l3FITc8MFOh9WlokW5EI2Qd
         4yJJpP7MY8sldhy4sYguRjauwAPL0jJielXjMCreEK+SpPBYiq00cVsgfIUqSFUyvlVi
         cmAA==
X-Gm-Message-State: AOAM532E/GjHIOzRtHJcoVF9sXIXxcbUoWFXRjBHLrqs4XVQlOvOqeEa
        jC9zH5tWAf1dBYZBXO01FLA/ty3Rfsw=
X-Google-Smtp-Source: ABdhPJy8c7eUvo1G6CLigC0dGKZ1+WPSJX5yuDQsyq9W1CY+Z2D9y06lq5MdpNVghANUK2+WLIhSSQ==
X-Received: by 2002:a2e:a274:: with SMTP id k20mr1699804ljm.479.1634158145709;
        Wed, 13 Oct 2021 13:49:05 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-181.dynamic.spd-mgts.ru. [94.29.10.181])
        by smtp.googlemail.com with ESMTPSA id c14sm60499ljj.32.2021.10.13.13.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 13:49:05 -0700 (PDT)
Subject: Re: [PATCH] cpuidle: tegra: add ARCH_SUSPEND_POSSIBLE dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        He Ying <heying24@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211013160125.772873-1-arnd@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7b4c1c31-3ef6-db9b-dc98-8a6f7a3d6243@gmail.com>
Date:   Wed, 13 Oct 2021 23:49:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211013160125.772873-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.10.2021 19:01, Arnd Bergmann пишет:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some StrongARM processors don't support suspend, which leads
> to a build failure with the tegra cpuidle driver:
> 
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
> 
> arch/arm/kernel/sleep.o: in function `__cpu_suspend':
> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
> 
> Add an explicit dependency to make randconfig builds avoid
> this combination.
> 
> Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpuidle/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 2cc3c208a180..af97992eaa82 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
>  config ARM_TEGRA_CPUIDLE
>  	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
>  	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
> +	depends on ARCH_SUSPEND_POSSIBLE
>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>  	select ARM_CPU_SUSPEND
>  	help
> 

Arnd, thank you for the patch!

Apparently ARM_QCOM_SPM_CPUIDLE doesn't have that problem visible
because it selects QCOM_SPM, which depends on ARCH_QCOM, and thus
ARCH_QCOM should be auto-selected(?). I'm curious whether this needs to
be corrected, otherwise (ARCH_QCOM || COMPILE_TEST) doesn't make much
sense for that driver. And then it will need the same Kconfig fix as well.

I assume this problem wasn't caught by regular kernel build bots because
they don't test randconfig, don't they?

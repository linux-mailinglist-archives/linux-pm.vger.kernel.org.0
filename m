Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F242CDEA
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJMW13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhJMW1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 18:27:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76370C061570;
        Wed, 13 Oct 2021 15:25:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so18138163lfd.1;
        Wed, 13 Oct 2021 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2OPCwBrMbBCrKDyIHkefu8URcFCi9BaSH2w554aQQPI=;
        b=Fz5xpO0uDZ0dows1hiU+NVUA4kCzRZoxkDwqLedXiniMX+EtUknIXXl+ycTYsnnEd6
         a2Hev/nadpzBTz1l3bP6PGNUhtreas4veRmPjtuFBnj0cKhjpPTFYtMgLxXM+aGIOPPf
         SzHRFTnxIObca1sz9BJI9AMCohJBc8mN50UxzroK0BpQKEhk2m9YYEP9Isuuw6MwwYeB
         +QoPQicXLc/fw0htIyOE7JERkBzucj68Z/KS6Jfei22d25bWd1JbOgQif+W8t3d8iz4w
         fSiTfuJi33v6g++3SPv/dG41Fv2O+g3bTFewaUutUhfSCFjaTaG4ZV5C7aAZcR10kBEx
         7LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2OPCwBrMbBCrKDyIHkefu8URcFCi9BaSH2w554aQQPI=;
        b=07NjHUMa8RS5Bbj36r2uy18RNjf49vg1Yq0AOTuXg7nWthIhZY1/0liHr5bgdhJzfv
         p50ihBQVLER+YoKxopAj7vkYFkAh2xQ4UdTvMMhavzKvDXwuTlhEgC3n+x4Lbl+fCoNx
         XBfBqw2ru+k3RdsIGEYRdPN8HP7nxim988jICJlBSHk1NpQGQXc0Oe8kVgVxHnOyRF0U
         7urfQ3AGlu06O3RPBFYoSFTtqmb7Hna3kYR35StBZliAa6AUDj7YdJdjLljAMovLbcBi
         myEgQmqks6bc3BlVmjaYLM970XhxLLMW2XF00PhqsBihEEvfNJhp7al9xyy/AGk5iFHh
         8FSQ==
X-Gm-Message-State: AOAM532duJYRMRDpDtii5FC64SNPYiHkAnx9IOwhtqov7UEqv4RcNqZq
        ytEY6QPSIA918fcf9yJuD284qMfghV4=
X-Google-Smtp-Source: ABdhPJztdnqI3yra7GanYKdtDlBSFacGyTa03XghwkKHspB2euhuZhbOEDcNrQ9QTRsI6ow+9R4DaA==
X-Received: by 2002:a2e:5c43:: with SMTP id q64mr2177948ljb.224.1634163917721;
        Wed, 13 Oct 2021 15:25:17 -0700 (PDT)
Received: from [192.168.2.145] (79-139-174-234.dynamic.spd-mgts.ru. [79.139.174.234])
        by smtp.googlemail.com with ESMTPSA id c1sm78283ljr.111.2021.10.13.15.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 15:25:17 -0700 (PDT)
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
Message-ID: <2fdbd732-2496-2267-6636-2f682c39e928@gmail.com>
Date:   Thu, 14 Oct 2021 01:25:16 +0300
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

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

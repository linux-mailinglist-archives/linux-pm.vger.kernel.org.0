Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422783ED9EB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhHPPdZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPPdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 11:33:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569E0C0613C1;
        Mon, 16 Aug 2021 08:32:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i28so8547563lfl.2;
        Mon, 16 Aug 2021 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hvKEFcnj6UwSa3ayzmSl9tvWYXHQ0pEJNdBHHDUYHVs=;
        b=bvNaSZBdUi0PywHh2d8NONhB/11X/70LYuPfW3w5xBzDanBgvFPt75UbtZi5rG0egh
         HThD17KT4Em0ttO91WvtCVNw3p7qhIX08oktynQT1oQ+50s2HnioZQXDwbtObeRJG9wB
         gOW9yq3ZK91Ofc+2sIhJ9aUCOR1lYr6wnJqaBGWA2iQpvzB3FJRzV7E+ohz3epigIc+j
         izpimwRVbHz1oX8JmuQxtdl5qcL+9/4lbA7Bts4s2AmuKpMSzqHQ0X04VjHl7ZFMDPR+
         lhTOWtnTkI/m08RbPAgLBNz8GpwDzFpBcAsw0Kgl2v65qxchQeDqaK1PcMsWgEwHtJtn
         PcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvKEFcnj6UwSa3ayzmSl9tvWYXHQ0pEJNdBHHDUYHVs=;
        b=rTwH7+8ouS7e4hxEfkaDeop/D3xTDtDbU2qjJngTgijmQ1jZ+Sls5sYCBYyI9+ObV2
         KqrPqy/22aO4rf/K31kv33+Ftsy4RAyBgIIF6Y3gwY1R80Jl7WN/eEmZ45pjOwebFsTD
         pTsk1eQIYAXTSoFnQyhFBA0vxg5F8blBoenZvpNnqEsha+zHN1dCzzPn+WmOwgm8fp7E
         4qY/CQLHd4tWjngTxf8jr1V1MUpDk3Ag+zg8d02vHRX2qsGFRL1iKmkU4DzOA/LBm8Gd
         NwTkg8RHaFw5dvO7AmVitGfVnX8su/nosKxZZx7tjFArMpDl3nN62bC4AQRxin1flQ7R
         IXNA==
X-Gm-Message-State: AOAM530VJqtzhWEHjwFRLhxxoqHmFppYnhZpnLEyyQj/bLP2Ys8FG4UX
        GcEqxo4VVeIMR9C1BALqKkJ/ZaP64Ok=
X-Google-Smtp-Source: ABdhPJxsmoy5XdzdavPh2SpH/NLVK2rXELY6fqz7P5XzALLrkXwbwkWkiQa8He+RXf+HplGJyEByEA==
X-Received: by 2002:a05:6512:904:: with SMTP id e4mr11959599lft.170.1629127971632;
        Mon, 16 Aug 2021 08:32:51 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id y26sm703901lfg.103.2021.08.16.08.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:32:51 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] cpuidle: tegra: Enable compile testing
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210712000322.4224-1-digetx@gmail.com>
 <20210712000322.4224-6-digetx@gmail.com>
Message-ID: <bae8fc99-b29e-0721-c37e-a29898c7cba4@gmail.com>
Date:   Mon, 16 Aug 2021 18:32:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712000322.4224-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.07.2021 03:03, Dmitry Osipenko пишет:
> Enable compile testing of tegra-cpuidle driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpuidle/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 334f83e56120..599286fc0b08 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -99,7 +99,7 @@ config ARM_MVEBU_V7_CPUIDLE
>  
>  config ARM_TEGRA_CPUIDLE
>  	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
> -	depends on ARCH_TEGRA && !ARM64
> +	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>  	select ARM_CPU_SUSPEND
>  	help
> 

Daniel, could you please ack this patch?

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3432B325
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhCCDrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350750AbhCBMrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 07:47:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B2C0611C3
        for <linux-pm@vger.kernel.org>; Tue,  2 Mar 2021 04:45:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b18so13236676wrn.6
        for <linux-pm@vger.kernel.org>; Tue, 02 Mar 2021 04:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4euAoXNn6FQqfmTSnFOsjkjdbyGvfspTApnyHwWUciA=;
        b=LqNnTf0i5fCnl4xx9VAq6Pu6sSlRDkWtkujkH1GBClOZvrooBcRYyeRolHIfQ85wWv
         HlsaqLv1aXj9dY8Ddfbs7nEK108330zMu8hYqTEgoiJs/+Sv498Srmcz7UBX5ZZWta2U
         zVjd/ivC4bvu875db7aV24OIT8lyizvBnuI04iC+zfmRJvg5QfNu5EHz7qvjGJf7gbxN
         FQxv5QYB0vq6kf//7lxz3S2lPrkLMGCAzvUJVUPFJk9TJ2yvHP3w9LEMyjKA3odC4je8
         ZTCVEds1jevMGWuklRBtZOxpZqxdSOP8fa14NtOqRDU0wDtdPGXbRnbS5mtwnVyaOhKN
         6KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4euAoXNn6FQqfmTSnFOsjkjdbyGvfspTApnyHwWUciA=;
        b=fGfi+D9TbMtLmP40z0h7vgqvovtQUxGxSODgOhsVZwkibYiIg8cFR08Hw66gmWkhrp
         00HYAiCSj++DNkY1OcfDHPnb17UhltfAydkOtFDjRN9IQklK4IKub0A4DwtL9aV3QzVR
         2F/Wo4xR99I6ZdnXzR1839l8XfJWrg7dfyg980X88W25NhhWH5iHg1Xnt44+HoDqoaVn
         XLCC+zExyvbHCkrnKZ8835OiuQ/7sHKXbmJHm4yhZ4WBmM47p+B+L0B3fBzhe6i03WOF
         0M91wlZWG6BTwTtnSYwc+5tOIIjxa8cve8cQWsq3nP2OZ6DGHaPAocIGMYtggET10z8s
         n0tg==
X-Gm-Message-State: AOAM531wRXTKFtJJ7WSScqKTunz1tqZdkD2rIABLPBQDmvW44gfbsTjj
        HT5AcFcbMwwPy8I7dXC3v0PJwg==
X-Google-Smtp-Source: ABdhPJyQIazlL9gr2QbnjHUu4wmXs/ydg+N9QfOHzrHtxvZQ4y8uisyp2biBKsxWd/+sILULsvRd9g==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr22144213wri.373.1614689144334;
        Tue, 02 Mar 2021 04:45:44 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id o2sm2441521wme.16.2021.03.02.04.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 04:45:43 -0800 (PST)
Subject: Re: [PATCH RESEND v2 2/2] cpuidle: tegra: Remove do_idle firmware
 call
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210302095405.28453-1-digetx@gmail.com>
 <20210302095405.28453-2-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd5cff9e-b86b-7fea-c88b-c32b5c428705@linaro.org>
Date:   Tue, 2 Mar 2021 13:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302095405.28453-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/03/2021 10:54, Dmitry Osipenko wrote:
> The do_idle firmware call is unused by all Tegra SoCs, hence remove it in
> order to keep driver's code clean.
> 
> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: - No changes. V1 got no attention, hence re-sending.
> 
>  drivers/cpuidle/cpuidle-tegra.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 29c5e83500d3..508bd9f23792 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -48,11 +48,6 @@ enum tegra_state {
>  static atomic_t tegra_idle_barrier;
>  static atomic_t tegra_abort_flag;
>  
> -static inline bool tegra_cpuidle_using_firmware(void)
> -{
> -	return firmware_ops->prepare_idle && firmware_ops->do_idle;
> -}
> -
>  static void tegra_cpuidle_report_cpus_state(void)
>  {
>  	unsigned long cpu, lcpu, csr;
> @@ -139,10 +134,6 @@ static int tegra_cpuidle_c7_enter(void)
>  	if (err && err != -ENOSYS)
>  		return err;
>  
> -	err = call_firmware_op(do_idle, 0);
> -	if (err != -ENOSYS)
> -		return err;
> -
>  	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
>  }
>  
> @@ -356,9 +347,7 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
>  	 * is disabled.
>  	 */
>  	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
> -		if (!tegra_cpuidle_using_firmware())
> -			tegra_cpuidle_disable_state(TEGRA_C7);

So firmware_ops->do_idle is always NULL, thus
tegra_cpuidle_using_firmware() is always false and
tegra_cpuidle_disable_state() always called, right ?


> +		tegra_cpuidle_disable_state(TEGRA_C7);
>  		tegra_cpuidle_disable_state(TEGRA_CC6);
>  	}
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

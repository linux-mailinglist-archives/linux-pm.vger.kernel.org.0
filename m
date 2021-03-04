Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B804232D534
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbhCDOWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 09:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhCDOW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 09:22:29 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5447C061756
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 06:21:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o7-20020a05600c4fc7b029010a0247d5f0so4588880wmq.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YHMatXXdPYDDLT8wFieGnvfikjazopW2uuK4cphVynI=;
        b=cBKVejxUszzm7okV0GptpaMa8NrhhwLstLYnr0G1mASa52ru1xXNBq8BlxVGqfqCzP
         vS6B4NtiClU643oxRfg2EgmliarKwsSXDXf8vAt9pomimkGfEiTItmTLZLwIJPu+T18L
         8zPocXlnqmUbJva2ZA9I4DITtvyHuFAYyQcsF6LQZ64TQ4BI70TyoIAXgCXT5tEtxqXt
         EInltfff4mlqmqBTUmzJ6sQmgf0zMZQM+JehLMdD4G/BJGQFB50S35LXUvlRkIoh4jlM
         dKP6PLkt3nYN6fQqga59kmyYhusUVCOh50DH1tTVZBsYEn+Ykh2fNxRROSAdwGcEzrLZ
         S3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YHMatXXdPYDDLT8wFieGnvfikjazopW2uuK4cphVynI=;
        b=EDasUJGsCBUzBZeBr4El7cK165bVZDUv6YPj6MCgoKVxt3R9l61iHIvQlgAjuo3C2V
         S/g3jXLUpHswASof+mLPRJgb7NvoKrZ+VVc3gOisdr97kYoxz3OnbPEdm1sR6crnJZte
         VsWrl9A6djK0LmlheAhuVjDRd/RWcksDa6vxR/EyvHdGjiF1xtyCuKL46xVvkksgV2UX
         gx7XgjVy/s41tWAVxxJpOYXjnAPCPtQ5H3NRKkXZTyKYOWmmAodGDfksDUW1URTHIP95
         2Tis2aaHklHxvSy6se5wDprVEpYMC8ylDM9F2I1zY/JfQC3RHQ69fYY5avLXdKyFHtA1
         xOLA==
X-Gm-Message-State: AOAM533A1947Nu5s/Xez5OqjUVnIFXeM5EK/FpG79nP/SheKZFDSsffb
        upNf+r8D+E8z/8MZobr3mjpNWQ==
X-Google-Smtp-Source: ABdhPJwYh1ksGVDpl0FahcyzbTJom6+XKEw2joRKqtGw0qfADldQGlRXUGLhi7PppqmR5jtX+mERJA==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr4314920wme.172.1614867707412;
        Thu, 04 Mar 2021 06:21:47 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id v5sm10221494wmh.2.2021.03.04.06.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:21:46 -0800 (PST)
Subject: Re: [PATCH RESEND v2 1/2] cpuidle: tegra: Fix C7 idling state on
 Tegra114
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210302095405.28453-1-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <34319e26-8c11-4333-a4c4-47e827c12a87@linaro.org>
Date:   Thu, 4 Mar 2021 15:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302095405.28453-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/03/2021 10:54, Dmitry Osipenko wrote:
> Trusted Foundation firmware doesn't implement the do_idle call and in
> this case suspending should fall back to the common suspend path. In order
> to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
> firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
> C7 idling, like it was done by the older Tegra114 cpuidle driver.
> 
> Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
> Cc: stable@vger.kernel.org # 5.7+
> Reported-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

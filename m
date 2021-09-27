Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E58A4198E9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhI0QfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhI0QfJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 12:35:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1274C061575;
        Mon, 27 Sep 2021 09:33:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z24so80947022lfu.13;
        Mon, 27 Sep 2021 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UpaNyYiU+SE/sZ2hW32UrRRP4FJCGyXyjaUjdow1VSk=;
        b=XCUBYdSQydLlmJ9mUUm5ALRKgk8oUXB5XCHECL/qQ942E88l6evRLIj4YRZ5a6JBNO
         3Otc2e/argHXga17ZCNbKz8BGGHtHFdW5ToR3aJ3o8NhbsYMjrhz9pWrFDkyXcQ9dyPH
         KuctqCG47vLRunLe6Q+uIt9dHzYFyG1keNmdPZhFlSPi22537wwOBSGxr5sf1LTJ+i/F
         R7y01YKF1PAk2Wt4QLC07v94Ke99mo1M9OxpGcLi4lRRgCOkDf73kE8KEDYP4gfuA5el
         Kojt3Eb7qemMqKLMcGjwifcW9kSGbu40v6i4hHCag6Dc9eK/fPfjvC2E02Okq7dJifFl
         AjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpaNyYiU+SE/sZ2hW32UrRRP4FJCGyXyjaUjdow1VSk=;
        b=AeRb/6eljBo1nAXGEtM4XorXnngUGpNRMcXsTUOQUtgwRZHAIWVYxeSpbnU9w3bOKc
         vjzXvypjJBeXYKpOyfVE7gnlsAmmfp/zyk35TrJssw1AN4wo9lWpi5mOxp0/rAZgqEKd
         pWGMuqMmqtUelYtfYHbBWCuY28GFVfihWOckCuFp7U6/zlhyFwfZoadsKDAOMC73VMUk
         uEXjhBJ7vuMKAkrPZU4IpHAcgn4OeusY4D9s3o3eScdsNSl5Fdn5kelhyGfPeGcG13Zs
         wwb0qfSFVp0xhBTbWHh8Rj4ZgfWNHTw2mXWU9wP/QAiUMwG2/qUy7lMBsfghV+O0muQ0
         at4w==
X-Gm-Message-State: AOAM53366tpm2fqyIn1okqQXDKa7SELL/MHOrBM9FMa1ud6HgmvaftVC
        LztC1Wk4ul2Ne381ztZAGL6qc/by5yI=
X-Google-Smtp-Source: ABdhPJyfA/ehtuqS96ae4yW7a0cpUybKZdvK+JyjJ3vNCCpATXApePJWBFXlM5kKJvfIGgomqNTMrQ==
X-Received: by 2002:a05:6512:40d:: with SMTP id u13mr676318lfk.618.1632760409065;
        Mon, 27 Sep 2021 09:33:29 -0700 (PDT)
Received: from [192.168.2.145] (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.googlemail.com with ESMTPSA id u16sm759723lfo.160.2021.09.27.09.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 09:33:28 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] cpuidle: tegra: Enable compile testing
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210912202907.28471-1-digetx@gmail.com>
 <20210912202907.28471-6-digetx@gmail.com>
Message-ID: <8610c371-b670-8336-07b9-3ea673d3c5bc@gmail.com>
Date:   Mon, 27 Sep 2021 19:33:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210912202907.28471-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.09.2021 23:29, Dmitry Osipenko пишет:
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

Daniel / Rafael, could you please ack this patch to allow Thierry to
take this whole series via the Tegra tree?

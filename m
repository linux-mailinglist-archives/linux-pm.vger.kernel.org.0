Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17497B136F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjI1G65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1G64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 02:58:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D33BE
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 23:58:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c735473d1aso4814565ad.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695884334; x=1696489134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwI6smVHd5UMaBia65XA0pC9Bo4/EoWiOYnQn85uIHg=;
        b=PPbXQX/eAeR94mdeE3TLCv3fep00QImAa0B080BO3wpbTb5rPx71szKD5eaGnjh+mC
         mlEfB3AF5h8bRn8poqpztouc9CPSkeU4ro3RFTuwr4hqkQBefP3pPc+IgDdpY7DyxE0j
         ChEA7M3JCK4lBdrRkvHmHUcgqmdWLw8+7tXxJVW//KiFHEMRkLkiBK3qBMKcjMf3h18c
         LDwB701dls7iAA47rbo66aFoOvp92igmexdAbylrKyYxMpSpuqcSXhQekzWLgVFk50qb
         8WJbYxlgteP0F0sxmRnbkwmAOH0gHQXDwuFISvP0O3CyG1HqCsGcBh887oqZrfvSD91m
         g0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884334; x=1696489134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwI6smVHd5UMaBia65XA0pC9Bo4/EoWiOYnQn85uIHg=;
        b=c7iWOAcy2BUKQ5VaS/3PIYE55nTk9gaCiOCV2aUc/NgI8iqJn+iUXJuiFiYy3vySY6
         ++KTWYyvXqFw1fGhpLj4lpuA8X4wXJN5M4Nkgf/V1FaO3JQZ/K7SzWh+xsh9zrKF+P2t
         QUy+j/gbkZ8PmfS6wjfjLtpjfHLnLxMbDcTEYQD43EwKBpVtSPurDzbbiDFArEfFLPw2
         S+2dQKre/0swz/3bLBUsODmWjXulsMM7TeAyOr6zxb6gM4Ls+eK+dx98WFV4I8q1MDUu
         6GlalqeTUzDTSULL8fO+qdqn2bKe9uKvBKX0mXUTHDsYza0h08LZVRq/s3t4a2EyF0Ow
         RKjQ==
X-Gm-Message-State: AOJu0YxqHPinJ2Oh3Kow7xPBlhvTDsJhGWtZ7KyFdvNpTSdQaaq0Mv5T
        O7vQkk2odnfJVWCDdGUWvMY7qg==
X-Google-Smtp-Source: AGHT+IGrj7aiQMA4Uprf8SfQhI+1smIAVwuJN/uHYkcV4Vjv7Aer3HJ4iBpF4ZBfrRArUrRDEVF3Yw==
X-Received: by 2002:a17:903:1109:b0:1c3:ed30:ce04 with SMTP id n9-20020a170903110900b001c3ed30ce04mr398860plh.25.1695884334495;
        Wed, 27 Sep 2023 23:58:54 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b001c474d6a408sm14221518plc.201.2023.09.27.23.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:58:53 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:28:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cpufreq: refactor deprecated strncpy
Message-ID: <20230928065851.5zhqxjxd3vgdmbsd@vireshk-i7>
References: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-09-23, 00:07, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Both `policy->last_governor` and `default_governor` are expected to be
> NUL-terminated which is shown by their heavy usage with other string
> apis like `strcmp`.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..3eb851a03fce 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1607,7 +1607,7 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
>  	}
>  
>  	if (has_target())
> -		strncpy(policy->last_governor, policy->governor->name,
> +		strscpy(policy->last_governor, policy->governor->name,
>  			CPUFREQ_NAME_LEN);
>  	else
>  		policy->last_policy = policy->policy;
> @@ -2951,7 +2951,7 @@ static int __init cpufreq_core_init(void)
>  	BUG_ON(!cpufreq_global_kobject);
>  
>  	if (!strlen(default_governor))
> -		strncpy(default_governor, gov->name, CPUFREQ_NAME_LEN);
> +		strscpy(default_governor, gov->name, CPUFREQ_NAME_LEN);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

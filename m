Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41C72B8B8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjFLHiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 03:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjFLHiL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 03:38:11 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278B10E6
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 00:37:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56cf6f4211aso19314937b3.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686555220; x=1689147220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM8cSNzatRt7iVDLhS9loK+hrwWt39XACb17rH3wM/U=;
        b=A5iqi7eDMfsR11wBrVQ3xDUG4wrXOFIb8FWkS/iuiJET3uBbwXH0qEtFkGf88b0BQQ
         FhKKDxy77SoLu/xE/Fa9xuh9kBwOjRSEtglgEdKL/Ii+O0AydAJCrSkjG/E2HF2ZFKyO
         HVKACR/TchHmdPZiMTKdgxuFGKjrODjxOR7IoChG/ZPoaXx/8Q1PW6qC3fSHRO7u+yUl
         2oaTalH715J88KZzzjYX2H4u7gwtD/ejvge28Y+rFq0m45GUkLgIEv9jMUXjquqdM5+J
         dWrBk/weo0fjhbAy/lVEIBsk6eaPNdMRq6uZkypzWMXV2cCh4NncxRO1mBTus39TLRZ/
         Gp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555220; x=1689147220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM8cSNzatRt7iVDLhS9loK+hrwWt39XACb17rH3wM/U=;
        b=QtWXrKT9sqY76aEVho3MlVXUgerEjKx52pMDKcCCDKBk0RbQak5Irs2loUThjhToqW
         4iq/UCcaW12AcZ/Hxl2xt/8bQ6kWzbp28DqhA781iDlC4K+dUYXgh4wqmsJLNE8t+aoQ
         Ov5M4jpgCpUz67xS0pglY+de8KKIoipF3QUZdNJQpvrZfrSHFJimHo7L6NJVSUx7//wH
         YX+fFP/aSqzwv9uRBnN0xuEFq6Ty8KCrkkcz0hp9iRKxZmNyFyiMWu1iziK5G2fMk5MM
         E02twnpl54ly++CM/3jqF1nMznLGnTiVvDAv6N21G+Fi87koUxP34HGWjx8yqU/K0w88
         pIfg==
X-Gm-Message-State: AC+VfDwwj2ahUfXP07tcx9BQ1Y1lJTxA3damuLQ1eMfcQfyxa4PPV+NT
        N0BxeULyhX7Z4pSF6E02Ut94ihfaKKxdjH2E034=
X-Google-Smtp-Source: ACHHUZ6WULGFh7chtEHb1ZkZQmmJTBWrb+YD5bXXWBH3s//Zr0f4h/gIzkRgc7zjKizyLWEJh8ckSg==
X-Received: by 2002:a05:6a20:a20d:b0:10b:d70d:f96b with SMTP id u13-20020a056a20a20d00b0010bd70df96bmr6884057pzk.3.1686554790361;
        Mon, 12 Jun 2023 00:26:30 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b0065418efa5ebsm6259308pfe.155.2023.06.12.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 00:26:29 -0700 (PDT)
Date:   Mon, 12 Jun 2023 12:56:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Mario.Limonciello@amd.com, Deepak.Sharma@amd.com,
        Wyes.Karny@amd.com, gautham.shenoy@amd.com, Sunpeng.Li@amd.com,
        Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
Message-ID: <20230612072627.5wzmsfp64jho3bdj@vireshk-i7>
References: <20230612030321.3097627-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612030321.3097627-1-perry.yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-06-23, 23:03, Perry Yuan wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The Kconfig currently defaults the governor to schedutil on x86_64
> only when intel-pstate and SMP have been selected.
> 
> If the kernel is built only with amd-pstate, the default governor
> should also be schedutil.
> 
> Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c839bd2b051..a1c51abddbc5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -38,7 +38,7 @@ choice
>  	prompt "Default CPUFreq governor"
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
>  	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  	help
>  	  This option sets which CPUFreq governor shall be loaded at

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

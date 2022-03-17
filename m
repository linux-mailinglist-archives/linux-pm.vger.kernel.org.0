Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46994DBE2A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Mar 2022 06:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiCQFXm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 01:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCQFXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 01:23:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BDE3884
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 22:15:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm4-20020a17090b358400b001c68e836fa6so71589pjb.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 22:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7smyLFvHz2Kxey0W+Yi7oN5ICRziKPJC1LjV5NQwwk=;
        b=KemArhaWTIVubPvMsIMQ8OlKGpoQDmo1ZZvhcN6gDYzj3bp37U2sI8SYEvB8h546r+
         v/fcNlo0HEBe40u5ftBopH13Nu3Ut74gyGyves4UQhGZw0afG849ELCeT51K7OphAgxE
         MqHUnL/WaDThCJiDKVvXKnIiUH+93YEPokJS5k+KtgyZyjwXoYsjDgQLMrT6jmXkNwKF
         26hlKxTWIR6aGsUm+DPNf35VJS7ZmekGDLbdXbIFGL9/1jvwblv93a4DbEZ/nyDGsr89
         +vh+jLwe4L6/KAodk4fycFAbdpUbkbJ+Ooi2JZSZ5dL4UHaTblChfnfNBuM8vjdIDyWq
         94HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7smyLFvHz2Kxey0W+Yi7oN5ICRziKPJC1LjV5NQwwk=;
        b=MA9UMvGac1Ggy5v8eYDVJX6diy5aOzzRAYIE9Ru5xKLPfK8F9twUsKyCFCnPBadl36
         roqMHvwidjHVPk8+8R104oeXICZzMF8mbqsQ6S4APiLs9IRp4DMW1Z/DjDNXu9qcd9aV
         ktqxjOrmEVSNJDk1sRZ31N1eOhxaWTLVapZBsQIZfuGSrv7bBwkq0+C3HWD5s75fzEBS
         GmfoVCMHHFlC4EKSjvkdjnLo61kePg040VpQt6/39L2orYg/pdF1LQWK8wu3hYOQTWvC
         s9Ax4uMAUWpN5eOhiAdiuA9SZy5BI3BeyG/D644T/Um7JDqXbG3h11WY2WNqjSegiWDo
         CGrA==
X-Gm-Message-State: AOAM530QqCQAu5wyxu5nhEAsg9zqmArEirLkYzDWkNiUYqpo3UQ5CvJw
        vN7YC8SQsqe5HL5yOY+XixtY2fPnDSl6Zg==
X-Google-Smtp-Source: ABdhPJyGO6HDpoqeNPuTMyPE4VKjjOoL2RhB+3LchyawYMdBOmrYAbi19m1JeKQ8UBgHzgLUX1tdPA==
X-Received: by 2002:a17:903:1c9:b0:153:6e7:d505 with SMTP id e9-20020a17090301c900b0015306e7d505mr3138053plh.69.1647489839811;
        Wed, 16 Mar 2022 21:03:59 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a000cc500b004f6ff0f51f4sm4883441pfv.5.2022.03.16.21.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 21:03:59 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:33:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, Ray.Huang@amd.com
Subject: Re: [PATCH] cpufreq: powernow-k8: Re-order the init checks
Message-ID: <20220317040357.l4k6h5oh5awwxicn@vireshk-i7>
References: <20220316215548.6013-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316215548.6013-1-mario.limonciello@amd.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-03-22, 16:55, Mario Limonciello wrote:
> The powernow-k8 driver will do checks at startup that the current
> active driver is acpi-cpufreq and show a warning when they're not
> expected.
> 
> Because of this the following warning comes up on systems that
> support amd-pstate and compiled in both drivers:
> `WTF driver: amd-pstate`
> 
> The systems that support powernow-k8 will not support amd-pstate,
> so re-order the checks to validate the CPU model number first to
> avoid this warning being displayed on modern SOCs.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 12ab4014af71..d289036beff2 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1172,14 +1172,14 @@ static int powernowk8_init(void)
>  	unsigned int i, supported_cpus = 0;
>  	int ret;
>  
> +	if (!x86_match_cpu(powernow_k8_ids))
> +		return -ENODEV;
> +
>  	if (boot_cpu_has(X86_FEATURE_HW_PSTATE)) {
>  		__request_acpi_cpufreq();
>  		return -ENODEV;
>  	}
>  
> -	if (!x86_match_cpu(powernow_k8_ids))
> -		return -ENODEV;
> -
>  	cpus_read_lock();
>  	for_each_online_cpu(i) {
>  		smp_call_function_single(i, check_supported_cpu, &ret, 1);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

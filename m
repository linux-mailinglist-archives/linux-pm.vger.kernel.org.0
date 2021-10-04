Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520714205A4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 07:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhJDF5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 01:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDF5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 01:57:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C8C061783
        for <linux-pm@vger.kernel.org>; Sun,  3 Oct 2021 22:55:45 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r201so9581914pgr.4
        for <linux-pm@vger.kernel.org>; Sun, 03 Oct 2021 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6xhZhYqkaIt6kM8b1wik0C1vHSYtAO2/WSvHpSpwxo=;
        b=xEqOfwSJP2ARGibOhlAQUqUu6ybqEZUU2TXsicp4S8lbXEgQNTMINpdvuFROHHpUcG
         bVrzk3kWmIzV8+96H8LI3RSqbUiFvzNvdo5IkGxO1K7XIMYGXXpsoRZwhdj1HPBfFDSZ
         YWnOuqImvIMjl4P60MpHqu0q3fWpouxsXoQ1inlUOJbZp2HDu68qSMTayO3wJMKqUDJL
         DtTit0XMrBjZY/etrIBdHwVjE0pDg6q5DwIzvDoQeXsJ0hB1utq58D2CcdONGeD5fToP
         Wes2ir6J+rd4d9fFR8ijmu/r2AhJ1BuYPKMJJcu9KLyD8DztfZO8ckPCLGrJKJZUr+ON
         NqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6xhZhYqkaIt6kM8b1wik0C1vHSYtAO2/WSvHpSpwxo=;
        b=h75vA8xTNtgPPzf0ViBYQ8cpmWMGqdycPKPJ1HJB7Q1yrbkEs3q1k1HppyqyBeoKTj
         fdZFps17FqNXCftkPpw/0LSzUKDBzSy5J8ws+KGq9W4XiO/Of/fwX/xJx/iYLOgLp9fW
         Ao6Q9/GrqDLf/JQ64A48ExaAtL2/KLyhJwvGrg6/B18iQrkwOL0V1dFOe5d4rtx9jbHF
         nednBikZ388V0oNaeGAoY6OJVn1s9EjGYmThyE7FMwVgGgaeFWfYXgDNy629+jKox4iX
         +V7msQ62NANXCloEK5jUt73k3W5KwZVIhCJW9Ip+rD3O0HVXo76gADHyC/tT14JIIaKa
         CDBg==
X-Gm-Message-State: AOAM533IRI6RkmnAt8GKztaJVtc1PDAdhr6TyBoY9j1E+U1b9WhRKzn7
        lJEKz+/lF4wvcVxKfaLZJ+UYbw==
X-Google-Smtp-Source: ABdhPJzaYRPC71fEdRVTXUmzOLhxANyV7+vPbQPRrd1RjOfI2Ii89+bfhJBE0Ew2bRbHbQ6IFm+vlQ==
X-Received: by 2002:a63:392:: with SMTP id 140mr9572340pgd.189.1633326945316;
        Sun, 03 Oct 2021 22:55:45 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id z10sm12398069pfn.70.2021.10.03.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 22:55:44 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:25:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: vexpress: Drop unused variable
Message-ID: <20211004055542.kw7npqif5jfcdugt@vireshk-i7>
References: <20210909184714.153068-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909184714.153068-1-linux@roeck-us.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-09-21, 11:47, Guenter Roeck wrote:
> arm:allmodconfig fails to build with the following error.
> 
> drivers/cpufreq/vexpress-spc-cpufreq.c:454:13: error:
> 					unused variable 'cur_cluster'
> 
> Remove the unused variable.
> 
> Fixes: bb8c26d9387f ("cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag")
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 284b6bd040b1..d295f405c4bb 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -451,7 +451,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>  static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev;
> -	int cur_cluster = cpu_to_cluster(policy->cpu);
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {

Applied. Thanks.

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4685533A9E9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 04:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCODTS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 23:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCODTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 23:19:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C009C061574
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:19:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x29so19639068pgk.6
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDCmu7NNeFOsaz3ex6Yajs6eqS0GyGiKmIas8xB2iNQ=;
        b=WH/tejgXvqzVf8JYT72zxcRhK8qb0/a9CUUZA8WLWfE5YmygsnXzSDAaEfGC6NxJ9A
         CDHFlMQSqAro08eENM0DVktWW2L1cPCUcJazKVeXhMasSEfGVRj8e3vcEhz+tsBHi1jI
         u1h020nA2yLHElyL/htGrY2ArPMiucbUAHou2c5C50pnlIJMLcLMNeLU6iIBRBEMphoS
         d1ZmcijPQ7N2qTPpE4wPc6WjdVcy2q6ZSZlkNRXfyZwGLroV0a9F+sicNLOxhek5SqC/
         2RdJZAyHS7IR18KuS69KOwwmQf4J1Dx11CcZZ8NVc9rDGliD7PeYUtp25SvOrfXYxRXx
         pD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDCmu7NNeFOsaz3ex6Yajs6eqS0GyGiKmIas8xB2iNQ=;
        b=e6w/3+f55BEKSoy2V3NKHrxz+MqIckL4WaBWlGpvsfLp5+ttKibhvFb/2o+461w1B5
         xqDaTkoj20GZ54g7iDKlU+M7pBWjVfqdfQ7w9PbljteN4qvmgfVylqe1yQxOJoLarP4Q
         4riWa1F3b4e9SJ0W25rlgfnrNVk8daDOgFbiRqxZYjYBSS45jfYf7xbWigacwg/UEmCf
         t4yPwt9I5bs9YFKK0S+RbBX6j9cXQU6SAxIlS5QnRCMEmcQVDW3soLKSTbDchyIwT0Ln
         8lWZsO0bNoJuuGjXOTa0BzmNmvjjp8wuOyAtGpjOZVBKj1HrQ4fX35BV0AtayD1ptlCm
         O2oQ==
X-Gm-Message-State: AOAM5334vcHbXkNunCU/TrUqhG0EmhefYIXRjvePmLCupeIfxOiIkdGA
        bokZxPsPD9awsVZ8aekgWb+fuA==
X-Google-Smtp-Source: ABdhPJyTibjPgJPCLizyD/7BvexS7xXo+UuF+DS76XeBzq45C0t2ed5Ijx8yEj7dWhiG1SxOQrm2Bg==
X-Received: by 2002:a62:3c4:0:b029:1ee:9771:2621 with SMTP id 187-20020a6203c40000b02901ee97712621mr22289663pfd.47.1615778356750;
        Sun, 14 Mar 2021 20:19:16 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id d22sm8730397pjx.24.2021.03.14.20.19.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 20:19:15 -0700 (PDT)
Date:   Mon, 15 Mar 2021 08:49:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ia64: fix format string for ia64-acpi-cpu-freq
Message-ID: <20210315031913.icgekcdrbw4clikm@vireshk-i7>
References: <20210313104214.1548076-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313104214.1548076-1-slyfox@gentoo.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-03-21, 10:42, Sergei Trofimovich wrote:
> Fix warning with %lx / s64 mismatch:
> 
>   CC [M]  drivers/cpufreq/ia64-acpi-cpufreq.o
>     drivers/cpufreq/ia64-acpi-cpufreq.c: In function 'processor_get_pstate':
>       warning: format '%lx' expects argument of type 'long unsigned int',
>       but argument 3 has type 's64' {aka 'long long int'} [-Wformat=]
> 
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> index 2efe7189ccc4..c6bdc455517f 100644
> --- a/drivers/cpufreq/ia64-acpi-cpufreq.c
> +++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
> @@ -54,7 +54,7 @@ processor_set_pstate (
>  	retval = ia64_pal_set_pstate((u64)value);
>  
>  	if (retval) {
> -		pr_debug("Failed to set freq to 0x%x, with error 0x%lx\n",
> +		pr_debug("Failed to set freq to 0x%x, with error 0x%llx\n",
>  		        value, retval);
>  		return -ENODEV;
>  	}
> @@ -77,7 +77,7 @@ processor_get_pstate (
>  
>  	if (retval)
>  		pr_debug("Failed to get current freq with "
> -			"error 0x%lx, idx 0x%x\n", retval, *value);
> +			"error 0x%llx, idx 0x%x\n", retval, *value);
>  
>  	return (int)retval;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

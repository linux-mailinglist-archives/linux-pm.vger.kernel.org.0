Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35177D92B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 05:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHPDjT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241603AbjHPDgk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 23:36:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F830C2
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 20:36:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5656a5b83e4so3145860a12.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692156977; x=1692761777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+8Aaqk0KK2inEOOEcLZtJ3ERQB2JivfttUCrefEJKI=;
        b=WTpo1JowifB3Ec4MxrroJPI8a8jua0zGZI1jWozn+alkSD9LeXNbwwmXIHQL8sO2xh
         pV4QR7Mlugk0rxyAuI9zP7Q548CpPT21gK7dxwjU8fIf8SlZgYtSg3K2l1f1djnU77ES
         JxW9mIf//CpcWKw0AI7WdT4uwhi7302KxD3buI56Q8tSe1nVotcrW98ZVc78qCdpKnRk
         hQGsx1NRDXIl3PdbEVl3k5YaPAEfqc084V6paOvnfScpxgTpeWeO6JK6CSoj73bO+TjJ
         ZyFobx1q2CZu4n1zmfMAnu5bk+4nBbiPW6wlnqvW6CWpQc+v+LXx7HZUp3wSxbDHEt8M
         NqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156977; x=1692761777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+8Aaqk0KK2inEOOEcLZtJ3ERQB2JivfttUCrefEJKI=;
        b=LTv1Mywiv/BoVL0duYry7kGQr4gtlTe6bgtn1eww38q9H3J/9XqTQQoxqKvsoaFwDP
         ZBV4bA4hngr8GjihO+GSFP92zz/ped/1kq2d0xMZQsAxe8UzJSSM67VLXW1S6cOyIB7r
         /N5q5v38w8v+FyLZ3LHgOeiE3NM0jSydEWCtqLrBPAKN66R6e9lksxtlmZnKqZ5z1VCX
         93PhjWYgWBFGwOvVuyu+2Exu38ueats+5NyH153WmvC0RrqLLVzbuC9Gl7zDewGfMDIG
         kw6R9F6v7Z0Sh5D2n9/5RahmUkMSeB2ILgeREx/pohRVqTVZy7WXDJVfvujMFxuTMUNd
         TYxw==
X-Gm-Message-State: AOJu0YyAui4setEcMXsDDqolsuttHGUzPD42Ha1RlRukAzAa0eYtv9kr
        TvTqgoW96TDkB02aD49AopRgMQ==
X-Google-Smtp-Source: AGHT+IHDOnQ8iRfK5Rz2PJvcd9w/sx7SJsa7QDuXmRhGn2QTT5zzw+tKpYZJOZj1TsTtbZh62RCaSQ==
X-Received: by 2002:a17:90b:4c4f:b0:261:688:fd91 with SMTP id np15-20020a17090b4c4f00b002610688fd91mr368938pjb.8.1692156976744;
        Tue, 15 Aug 2023 20:36:16 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709026a8c00b001bc18e579aesm11806746plk.101.2023.08.15.20.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:36:16 -0700 (PDT)
Date:   Wed, 16 Aug 2023 09:06:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: cppc: cppc_cpufreq_get_rate() returns zero
 in all error cases.
Message-ID: <20230816033614.j7iobsaakfjojkxz@vireshk-i7>
References: <20230815014018.4132350-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815014018.4132350-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-08-23, 09:40, Liao Chang wrote:
> The cpufreq framework used to use the zero of return value to reflect
> the cppc_cpufreq_get_rate() had failed to get current frequecy and treat
> all positive integer to be succeed. Since cppc_get_perf_ctrs() returns a
> negative integer in error case, so it is better to convert the value to
> zero as the return value of cppc_cpufreq_get_rate().
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
>  include/linux/cpufreq.h        | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 796bc3e19f77..1cdef2da1ea4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -854,13 +854,13 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>  	if (ret)
> -		return ret;
> +		return 0;
>  
>  	udelay(2); /* 2usec delay between sampling */
>  
>  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>  	if (ret)
> -		return ret;
> +		return 0;
>  
>  	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>  					       &fb_ctrs_t1);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 172ff51c1b2a..99da27466b8f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -370,7 +370,7 @@ struct cpufreq_driver {
>  	int		(*target_intermediate)(struct cpufreq_policy *policy,
>  					       unsigned int index);
>  
> -	/* should be defined, if possible */
> +	/* should be defined, if possible, return 0 on error */
>  	unsigned int	(*get)(unsigned int cpu);
>  
>  	/* Called to update policy limits on firmware notifications. */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

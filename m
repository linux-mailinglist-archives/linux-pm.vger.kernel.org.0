Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875A77F259
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbjHQInr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 04:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349053AbjHQInV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 04:43:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1B26A8
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 01:43:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1398192a12.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692261796; x=1692866596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2L4C5R28cbryggTkgsTbJhOs95hAoOhjBRL8672G4w=;
        b=w48wRkJFgSgs14mGvW8yL9VkRkVfhujtSK5SMpUTWjNIRTy4j3dqLigip+/7P/yqxl
         WAos9+gjFyT/LWGz0ZFfpGKJZBg4c6atVw8+J1vAxiSPInA2eRFw2nwTLVE5EQzXRBDt
         mF+8zvQp/dS1vqYRlIRfzx2NX99kIiwe4ZAaV8nSwUA6PzhedfBo6aEg6AOii1v6SN6/
         a/cYPh2RBcwLRuLteXsUKHjCopAqQ/yQy9BZFAGhBNAU95POH70qyJBgR/Gu/7D0fl3H
         GNNNgAZ7ETMyc63vxwFlo1Snn4h6bJ0JFZLaXHGuRWH7vpdky/EiNSSAy88PWanFaHsS
         itkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692261796; x=1692866596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2L4C5R28cbryggTkgsTbJhOs95hAoOhjBRL8672G4w=;
        b=SMM8zQnH0skbQFeP6kb9PW9wkiRszHswi/lYTOqePADdYnWp+vvyfqGoa+MgtTdaDS
         kIQ7dQrvUYpd2UurQVWjaXgWC4+mRg1qPdg2RdfDjGUq6M/tQpe+MTGTMTU5fwL2g1au
         sn95gVKO0eL0jktbrU7j0B2Pcfym6VeTO9cL1WosP/MvcqbCfoVSEjNEL7P1AcYrgue/
         xmlqTcpjUlVxhIGqdUjmnB1Z2b5SIKrkT6D2hQ6+laMoIxOJty66g+15ssTJokO8+XCV
         gjyEuhB7aLzmla4iwFpc8lGf5UWqDV2d6n3ZKIvLsVjSUhJ3dR92+BzggsiRkerdVyYd
         iQIw==
X-Gm-Message-State: AOJu0Yz3gYlNrEimJUfLNu++zJKkQ14E6FhtPrRuSZiycNOJo5lZdheQ
        BjVf0WjJQvEYlRYkNu22z+MzTQ==
X-Google-Smtp-Source: AGHT+IGQrst5AZOFbEPCDmMYUExv2C/YC6Cai1Zz5cEBkHsY3pX7eqss6vxelOypQNoP9bmFVWQC1A==
X-Received: by 2002:a17:90a:c7c4:b0:268:5575:93d9 with SMTP id gf4-20020a17090ac7c400b00268557593d9mr3260325pjb.10.1692261796011;
        Thu, 17 Aug 2023 01:43:16 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090ae39300b002682523653asm1057274pjz.49.2023.08.17.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:43:15 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:13:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if
 fails to create kworker_fie
Message-ID: <20230817084313.2tffmexdzvmpyend@vireshk-i7>
References: <20230817074756.883380-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817074756.883380-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-08-23, 07:47, Liao Chang wrote:
> The function cppc_freq_invariance_init() may failed to create
> kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
> to prevent an invalid pointer dereference in kthread_destroy_worker(),
> which called from cppc_freq_invariance_exit().
> 
> v3:
> Simplify cleanup code when invariance initialization fails.
> 
> v2:
> Set fie_disabled to FIE_DISABLED when invariance initialization fails.
> 
> Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..4d501f0bf55d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -249,15 +249,19 @@ static void __init cppc_freq_invariance_init(void)
>  		return;
>  
>  	kworker_fie = kthread_create_worker(0, "cppc_fie");
> -	if (IS_ERR(kworker_fie))
> +	if (IS_ERR(kworker_fie)) {
> +		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
> +			PTR_ERR(kworker_fie));
> +		fie_disabled = FIE_DISABLED;
>  		return;
> +	}
>  
>  	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
>  	if (ret) {
>  		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
>  			ret);
>  		kthread_destroy_worker(kworker_fie);
> -		return;
> +		fie_disabled = FIE_DISABLED;
>  	}
>  }
>  
> @@ -267,7 +271,6 @@ static void cppc_freq_invariance_exit(void)
>  		return;
>  
>  	kthread_destroy_worker(kworker_fie);
> -	kworker_fie = NULL;
>  }
>  
>  #else

Applied. Thanks.

-- 
viresh

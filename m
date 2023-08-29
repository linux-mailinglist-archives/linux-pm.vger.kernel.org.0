Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC578BF02
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjH2HNz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 03:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjH2HNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 03:13:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8C19F
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 00:13:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5657add1073so2633481a12.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293222; x=1693898022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/erXdEoaUC1CpX1z4UIvUg82Ych5XFi4CUHzs/lZE0=;
        b=KzotwORWwUmVAbcvOzkkbpAnUn8DilzJC3+pWouk2oSXvVTur92wwuzx/BPhqTNkHV
         xq2Pmg5CUT5jo5vof/PUYLnddBoaLpGOtrnpTraHQF4tpsl/fFNbNH4i52lppk2DdrFw
         98DnDaActhS7UxCFsf1AYomqb0R6bMurVO1LBUmyY5RSZq7geHugwOH9zCeI1xTH3uVG
         RBWw6wCBYNhrf6Gk/WDD8TmX98KMwAO9eTxIWratgWW1cCjj2itdfqSRICRtbtmWSyDZ
         mrr78bKy0si3EtHwIgsClz/VLNd115brnvO6Hr4xblGM8SUMe09vZnBdBTMqGB8a23sX
         vvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293222; x=1693898022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/erXdEoaUC1CpX1z4UIvUg82Ych5XFi4CUHzs/lZE0=;
        b=BIk+jxq62QOkRfLeHF3uAwMP2TqZDsBrHOIRN9BBxbqZES3rDkOrIaba7Y0CAv9xCM
         J4HHG5OI93oOemjnw2a49KSuKgJLcxuPfxXTE7BcNonDpddpfWjdAlyiaX/XbbqhZgLb
         B9AEwych5EjPHpQKBTwiYCryvOHGKHs0YWbnhFrV8qO9d+quoI3JiNHelVWBE2gVwQp+
         6uWFmMpfNuHLQoFkt5j3922pXAy8fe09kr2Kc6rnMqGCFzVoYddAnI+/iYBWVotUp64f
         jOz4uG3azudFxV9HFeR5a/mtFNn2BxiPffpwgWjz/uH6Zo2TdT3BRksfPIclq4GdsZ6q
         QwJQ==
X-Gm-Message-State: AOJu0YyWBE+8toiKK2JQ1d5ELKPDRvBYLNXH00S1RsywxqMUnQbBboTg
        ZssnLM78TS2oZeSoz3i/yuKD1b3C3NpqPEaQcqc=
X-Google-Smtp-Source: AGHT+IHMXlfcD46rjuQlenQWZdm+5BV//6kTg6gYv0TMdLBtxRmgwed/c9YzSrBk8prVeF7wNVvV7w==
X-Received: by 2002:a05:6a20:6a1f:b0:148:9ce9:2f2a with SMTP id p31-20020a056a206a1f00b001489ce92f2amr2771388pzk.8.1693293222369;
        Tue, 29 Aug 2023 00:13:42 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id s25-20020a62e719000000b006675c242548sm7799984pfh.182.2023.08.29.00.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:13:41 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:43:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Avoid printing kernel addresses in
 cpufreq_resume()
Message-ID: <20230829071338.6y5ng2g34vdiigve@vireshk-i7>
References: <20230829070150.1217624-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829070150.1217624-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-08-23, 07:01, Liao Chang wrote:
> The pointer value of policy and driver structure are currently printed
> in the error messages of cpufreq_resume(), this is not recommended and
> helpful. In order to be consistent with the error message in
> cpufreq_suspend() and easier to understand, print the name of driver
> strcture and the manage CPU of policy structure individually in the
> error messages of cpufreq_resume().
> 
> Link: https://lore.kernel.org/all/b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..26fa99d46684 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1943,16 +1943,16 @@ void cpufreq_resume(void)
>  
>  	for_each_active_policy(policy) {
>  		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
> -			pr_err("%s: Failed to resume driver: %p\n", __func__,
> -				policy);
> +			pr_err("%s: Failed to resume driver: %s\n", __func__,
> +				cpufreq_driver->name);
>  		} else if (has_target()) {
>  			down_write(&policy->rwsem);
>  			ret = cpufreq_start_governor(policy);
>  			up_write(&policy->rwsem);
>  
>  			if (ret)
> -				pr_err("%s: Failed to start governor for policy: %p\n",
> -				       __func__, policy);
> +				pr_err("%s: Failed to start governor for CPU%u's policy\n",
> +				       __func__, policy->cpu);
>  		}
>  	}
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

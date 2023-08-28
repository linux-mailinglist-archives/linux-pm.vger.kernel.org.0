Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30078A626
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjH1G6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 02:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjH1G6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 02:58:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B1CC0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 23:57:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bedc0c268so2544743b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693205864; x=1693810664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUn4dyld4kq/vvDUpxmNXC3WorMCmOqcAvLB4JKywJ8=;
        b=H9WmGyfENqaCJS3MEHtDq76yTx5H0Q8DtYyJwps0ZXzAoH3UAEgUNdPpJNrnd/vGU/
         yE0AtbC9Jg1VDgyM8UT70LV7MJ7100bFy320QLbeNsFmTnbV7U4Uug4Asb9MNVSADEOe
         xCDmuC2AvVzzwR/SCHTwz52V6BPwlWV+XtPnfNdYd/yaVGYGPXjpgAv5YtV6LwT/SSJy
         qeAWQejR9A5UgLRboXpsHm7vFNAFXA2TPiRlMll/fNI10zeFXWOhjyfK2sgkrIhNymWp
         kOMCZBAEIjUVRLTgNrGY634jvOBRtFk1bghExn+hGU/z6781UIysF51a37mfhW7mW+fR
         27lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693205864; x=1693810664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUn4dyld4kq/vvDUpxmNXC3WorMCmOqcAvLB4JKywJ8=;
        b=Y3PzIkA0ALs7RnSow3qWNdaWUcKboAQyoBU7ArMvu+imqnOXACa5dcES2/McxLwhIK
         uUZfz5T/PlnHbJWQZQ2H5Jg3t5VKAnuHAY994G4w8kQCj1EQiVpPzuiJat+7NZ/w9INY
         BVRepP0YIevjICSVkQ3cC0yA8bFdIF9tKiQmy6hE8WqIbd2+ZpG2900uLtiaNQmiliql
         BXfiTXwTtOSt+GZPQ9IlPotz/Q0Om6ySX5ZJGBrREO8y2Ltx/30VBGJ2wI19qoaE8Cj9
         3bQk4EaDtpa6VCYxPVbN07kmAj4TkdPObsQ0BDARKY2FN58PpA4w+01R7JwCnYTEOUya
         LmKw==
X-Gm-Message-State: AOJu0YwZuwONJmxdUG6ihmWIA892wqZfWbzgfn8jVVwtzyD9YfilKDYj
        DOHDYIppPXfKm94Vd4kwfHBONA==
X-Google-Smtp-Source: AGHT+IF+IoQNIya692iAxYlAdmYCS3NLpvftmX3s4F4JFf3QUHOoR6AMff/7DtyWdIM/rUZNItZMyQ==
X-Received: by 2002:a05:6a00:84f:b0:68b:e801:e34d with SMTP id q15-20020a056a00084f00b0068be801e34dmr15065981pfk.29.1693205864019;
        Sun, 27 Aug 2023 23:57:44 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id d23-20020a637357000000b0055c558ac4edsm6666872pgn.46.2023.08.27.23.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:57:43 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:27:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow-k8: Use related_cpus instead of cpus
 in driver.exit()
Message-ID: <20230828065741.rtmrqi7zfnd4qq3n@vireshk-i7>
References: <20230826095113.1137177-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826095113.1137177-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-23, 09:51, Liao Chang wrote:
> Since the 'cpus' field of policy structure will become empty in the
> cpufreq core API, it is better to use 'related_cpus' in the exit()
> callback of driver.
> 
> Fixes: c3274763bfc3 ("cpufreq: powernow-k8: Initialize per-cpu data-structures properly")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index d289036beff2..b10f7a1b77f1 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1101,7 +1101,8 @@ static int powernowk8_cpu_exit(struct cpufreq_policy *pol)
>  
>  	kfree(data->powernow_table);
>  	kfree(data);
> -	for_each_cpu(cpu, pol->cpus)
> +	/* pol->cpus will be empty here, use related_cpus instead. */
> +	for_each_cpu(cpu, pol->related_cpus)
>  		per_cpu(powernow_data, cpu) = NULL;
>  
>  	return 0;

Applied. Thanks.

-- 
viresh

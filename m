Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6D617FB0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Nov 2022 15:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiKCOhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Nov 2022 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiKCOhJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2022 10:37:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C214021
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 07:37:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q71so1821735pgq.8
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2022 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PF4KJhlREAMO13MZb6HASqlqjPtxWxB+/ki0jtcrRVU=;
        b=YuqXDAGfRgXxsHfPuM9MeVNi/kdbzsvn5G7ZIdhGVTAb+wop8Zh+aIA57zeTQWx6mi
         N/b/f4ZIJDyi+/mBgHDLFlNuciJ3i/72TvNuAR/gnxgYwTDgZDUWulPtd3K7Mgclnsea
         hQz8IgVdmPfyi1Vw4w6PfdRt+R8JOd0paiyF3kVM9XA5/FzNAblhMXZcuKVmmMT3uDxm
         NwQp1KtKLjLWawPqgrAWNY4CFUe79c9y8Zc7On2VktguYebhnYla9SDb1Al5weP8ikbf
         MbRBaPqpZKYykvZQAz1yMidd5mZ3ZZ9L2GDVusXquGC6k3HPHieNk9AIQtz3xfcmJJwC
         2F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF4KJhlREAMO13MZb6HASqlqjPtxWxB+/ki0jtcrRVU=;
        b=6uB3wXXHI6Z/BOUWOmJsUos1hvgKZ8BqCfZXLVqArZix/6rcbpapJIddd5p5/krHPE
         02X1/8/83zXrOU/JpQHtwPC1825AvLpt/ZPhFfyYQVM7HtYK1Zw6PjFxCWdd2/CWf1BD
         K7tBZu5I3rc0XH/kUgWm62tyznS1G3VBvbmu7t7H8WuynfJ9YkIgzX86quAALlEyg1U5
         6c6luNbrxJ7jJ57ZzZaUJKlkSGX98SUtSejG6v1nl9Bpe9fOtwQlhzeodH9wbGB9e8FA
         cop40EeYRACzo71LagBb4wsaQy5AO43ggEtRz+5wTyp79rjh+ztl68VG0cFg+ool2l/v
         Z1RQ==
X-Gm-Message-State: ACrzQf3mgpBG4BckSbXHLvR4pGvmbQPBZLGuYM6tvePD0eMTDs1Yft7J
        BO9Yue8THjz6lLWhKd+bORcIWw==
X-Google-Smtp-Source: AMsMyM5LRPw3sJu0S6IYaEzxAplyQPG+AMWGIal4R4heyurPG/hw3ddScxNuvMy9AVHXwotlltfM/A==
X-Received: by 2002:a63:cc43:0:b0:43a:2f12:d326 with SMTP id q3-20020a63cc43000000b0043a2f12d326mr26197581pgi.320.1667486227674;
        Thu, 03 Nov 2022 07:37:07 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id s124-20020a625e82000000b0056b9124d441sm779193pfb.218.2022.11.03.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:37:07 -0700 (PDT)
Date:   Thu, 3 Nov 2022 20:07:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: longhaul: Make array speeds static const
Message-ID: <20221103143705.6g3geneixpmguaq5@vireshk-i7>
References: <20221103132141.79671-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103132141.79671-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-11-22, 13:21, Colin Ian King wrote:
> Don't populate the read-only array speeds on the stack but instead
> make it static. Also makes the object code a little smaller.

How will that benefit ? I am just looking for a valid answer in commit log.

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/cpufreq/longhaul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 3e000e1a75c6..25f8ef7bac47 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -407,7 +407,7 @@ static int guess_fsb(int mult)
>  {
>  	int speed = cpu_khz / 1000;
>  	int i;
> -	int speeds[] = { 666, 1000, 1333, 2000 };
> +	static const int speeds[] = { 666, 1000, 1333, 2000 };

Why not make it global then ?

-- 
viresh

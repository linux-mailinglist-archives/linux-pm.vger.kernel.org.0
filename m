Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645465E576
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jan 2023 07:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjAEGRj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Jan 2023 01:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjAEGRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2023 01:17:35 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5242603
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 22:17:33 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so23867875pgr.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/1aybnPVY0/ZNTp0WbN12YUVnKEmDwvIweR8iefDFI=;
        b=o+XAB+dLSUyM6V5YKDraKGQgLWoLovmiV0TgxDc07o8QqUotH+jjgbznl8XhGbnJIF
         3aD82YEN6um5bhlTQaH4k4vc8JMW2uwpwiUVIBynERpanuMYcs+D9InRnH1ZI6OvkCpT
         g47hSfxkjaBKKmHFu4dllH/utVSZiGN1LgML+GG4sSbEI6slJyclho2lN/5AZ5tAKXLh
         TqrkhGxYD1LAs00GDPV9toLM2lPydAQTflu6o/BoCSswsPofC7VqS6tLPU2mnrLO157j
         sdxVYd0euvkanQIGzmn6kooQEWd5TWLgwEX0kQHmxpBg/yw4NngtHl86wnc2kbLyO1qB
         y5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/1aybnPVY0/ZNTp0WbN12YUVnKEmDwvIweR8iefDFI=;
        b=avk6f0727XcWW/KzBggJV16gTv2aIL4AxqFQEMEqnv2sxVzTwQVjMwB0tgpB1jgZSp
         Xe1+VjJMSVNmcSqhiksl6fXAJ+vaxAsTYhPaVWF7GtzaIlX2163mkhWjlrb2wIbo2YtO
         Rh5ynCPnlcBjlX8CmpumN23EJDsK/txNq3djOlsnd5oGZmLF0Jnp3sNRDD390SPWfyoK
         B9kTK0fJFh5khHUQg3ZZo3vInO+TFC0t2duBQCkGLkRjeMvoikrtZCzKx+lh5i34iMQU
         hfMp5MZpaq1KfvYSbfLBShPJYCeDDDiKiKiHlZ7JxagEejaN1Il6wIORQVzBH1eCcn+B
         xCOQ==
X-Gm-Message-State: AFqh2krYu7b0gtKCJUNyt2Xpb/rt8m6JFjF2SdlisYeM4HLYfYvBHTKs
        2yV/JS7i1uCdDStixQBnwv/2fA==
X-Google-Smtp-Source: AMrXdXuKJ0qxcPATbS9ZQ+UYd769Zh8fOV1lf1jcTfyohOfcDpBJpqZ4kFEPDkTxk6Wjg6+e8P9c3w==
X-Received: by 2002:aa7:99cb:0:b0:580:d188:f516 with SMTP id v11-20020aa799cb000000b00580d188f516mr48391340pfi.19.1672899452804;
        Wed, 04 Jan 2023 22:17:32 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056283e2bdbdsm23519120pfx.138.2023.01.04.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 22:17:32 -0800 (PST)
Date:   Thu, 5 Jan 2023 11:47:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH rcu 16/27] drivers/opp: Remove "select SRCU"
Message-ID: <20230105061730.nyghfo7cm4pqs7vt@vireshk-i7>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-16-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-16-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-01-23, 16:38, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: <linux-pm@vger.kernel.org>
> ---
>  drivers/opp/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
> index e8ce47b327359..d7c649a1a981c 100644
> --- a/drivers/opp/Kconfig
> +++ b/drivers/opp/Kconfig
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config PM_OPP
>  	bool
> -	select SRCU
>  	help
>  	  SOCs have a standard set of tuples consisting of frequency and
>  	  voltage pairs that the device will support per voltage domain. This

Applied. Thanks.

-- 
viresh

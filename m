Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE56A3F71
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjB0K12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 05:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjB0K11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 05:27:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BFB2054E
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 02:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677493598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORysGkdK/Pguqa6KzjHxllcwhbHEv5qK0Wn8PNtiKpA=;
        b=fq83vbvrGJB3LZ4t98xZfuvnnU/P+zPLqjbm/XBlXjn/vRH9eJgkeo1dF6o8tZxHYoQP2q
        3Xne85ZRZdX8kO5YiG093/92Famd4KGa8axFcI5eiWBUsh/D/jq98nIeFygiB1nx3EoblD
        ci4J2PhhtrmY5EhJIcW2rwz0oz9Q+f4=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-bLNi-eTaO9uEhe8gogFsYQ-1; Mon, 27 Feb 2023 05:26:36 -0500
X-MC-Unique: bLNi-eTaO9uEhe8gogFsYQ-1
Received: by mail-vs1-f69.google.com with SMTP id v6-20020a056102302600b0042148d6b7baso3233889vsa.12
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 02:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORysGkdK/Pguqa6KzjHxllcwhbHEv5qK0Wn8PNtiKpA=;
        b=zte8IBcOFAkex4jUUpmyqFMZBmxj+xUnTMplsx300Ttgbik98+zZffyy6OPUecBHkg
         oRqKUm2R40FJSk4reYPqWKOwXukrBaoIqYEHfykwsUI92xkYUltVou7yOqvTd71rLZQj
         tUHg0PvkvEbCj7Hna85paecINLa0INn0gHFtg3axDm8VkgP0jDJt3ZBZVGVmaUwYt1Dp
         RFKNcT5eUqG0h5MPlyfSrk21MmAuJMYOsPrp5Kw0+MU/yYk6aWaczMDq4AkDqGGpYB4M
         L7SfzvLB7hkrnNSCQVotqVkp0rbjgysNIx6A4TR9a1LDncoi67dYLAQwKZeAa3suCWJz
         craw==
X-Gm-Message-State: AO0yUKU92SkZp7todrQFr2SXTTWqtAE4qRGCajZstzIHezYj3MZBfcw0
        VSnKgYqP/U6FJCpUIHP+8twFJXicBdbronhmu+6034V3s27Me4OwinNTG4xuyeh4dH0Shq5p3NE
        qfjitp0dD975EdWyG+8EnAF/inxVQ5J4Ctag=
X-Received: by 2002:a1f:bf16:0:b0:413:1498:e843 with SMTP id p22-20020a1fbf16000000b004131498e843mr7165639vkf.0.1677493596352;
        Mon, 27 Feb 2023 02:26:36 -0800 (PST)
X-Google-Smtp-Source: AK7set992JZJfczXidh5nXBnsu5o2gkRvL073x6tl2UuRSKy8og8GT5X66IeGe+wctC68z1nH/ku6NujpNQ8OHcKkJ8=
X-Received: by 2002:a1f:bf16:0:b0:413:1498:e843 with SMTP id
 p22-20020a1fbf16000000b004131498e843mr7165626vkf.0.1677493596036; Mon, 27 Feb
 2023 02:26:36 -0800 (PST)
MIME-Version: 1.0
References: <Y/yAzR6sWvPedLej@kili>
In-Reply-To: <Y/yAzR6sWvPedLej@kili>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 27 Feb 2023 10:26:20 +0000
Message-ID: <CAOgh=FyxFuENe6SgJB7aUwPS-ZB_51q6a=zWEcZSAsGqX034hA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: apple-soc: Fix an IS_ERR() vs NULL check
To:     Dan Carpenter <error27@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Feb 2023 at 10:16, Dan Carpenter <error27@gmail.com> wrote:
>
> The of_iomap() function returns NULL if it fails.  It never returns
> error pointers.  Fix the check accordingly.
>
> Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---

Nice catch!

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/cpufreq/apple-soc-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index c11d22fd84c3..021f423705e1 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -189,8 +189,8 @@ static int apple_soc_cpufreq_find_cluster(struct cpufreq_policy *policy,
>         *info = match->data;
>
>         *reg_base = of_iomap(args.np, 0);
> -       if (IS_ERR(*reg_base))
> -               return PTR_ERR(*reg_base);
> +       if (!*reg_base)
> +               return -ENOMEM;
>
>         return 0;
>  }
> --
> 2.39.1
>
>


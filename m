Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8F64DF6B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Dec 2022 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLORM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Dec 2022 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLORMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2022 12:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082347309
        for <linux-pm@vger.kernel.org>; Thu, 15 Dec 2022 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671124274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqfvPrwDCUsZIW9mE1ST+e7fYO/OE5JE7HWjiLLZSQw=;
        b=MtI92X53USr/CE+0+Nhb/AM9ySwlRpmfIciDOeqWcT7+gFH28QNWSgJoODMDy2EqvGhkoa
        xkmfa2lXSoGksUZyawTHTakleg/OmsVDYmJd5SSidTgYTN9tcu5wFtr9gxRVMzkgkSXwhu
        Z4esqFaW7arIoIIjCeAGHyyUH9ojWss=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-w6OZq3c-NliOL2Q5mg1tiA-1; Thu, 15 Dec 2022 12:11:12 -0500
X-MC-Unique: w6OZq3c-NliOL2Q5mg1tiA-1
Received: by mail-vs1-f71.google.com with SMTP id v184-20020a6761c1000000b003b2f766dcceso918556vsb.10
        for <linux-pm@vger.kernel.org>; Thu, 15 Dec 2022 09:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqfvPrwDCUsZIW9mE1ST+e7fYO/OE5JE7HWjiLLZSQw=;
        b=zh7A3KzTwUbI/oW9dyFb9wdpITpGprsUPPlGvSnucSIq8lHtz35qGpc4VDyobmAfRl
         pFatC8gPeN6UgbeRfx++X63Hd7MzhLvi3pkoz2g4VZ3VEv7ppYxf7VBEZZ2ah5fv5PtB
         RV3xpr+viJcV/Y1SA7evLCHWjUq8JlgnTlEqynO9f+5blPRCgr1up7hOIbLcxj4Gu1Gp
         pdS2XH1YhrbV2EeQn/VnSfKSR+Do8bkhJmrHYSv6vDxesoTUIzqZIyhYNz5j9vAnI0dZ
         QCCjnu7PWtChuW5qGqc1YtYWWzshCdoYLfukJ24DEhReOnPObXY0FW2wNj4xE1Mktyau
         jNdA==
X-Gm-Message-State: ANoB5pl8JPVPbbOEW7XOJI2297/hnRp98lty6C9bZCqxfiJH5FKQlfcJ
        mH0MlNVow8/pQ9zVdnqKhy6YoN8x/r8Els6NKv/wzTmdKzqYYLKshf/WNHkc/MJ7QaIhSJPsL4F
        q5d6RowRX61+Z5QZ9b3guB+kKh6i9MC69klw=
X-Received: by 2002:a1f:9d45:0:b0:3bd:7464:d818 with SMTP id g66-20020a1f9d45000000b003bd7464d818mr15951097vke.11.1671124272272;
        Thu, 15 Dec 2022 09:11:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5DpRvSS1TE6vnCQIy8OtywyRZKjB7AAg3FRM32z2D5CsF6I9GRgKRogkj7PTJRC46YP7KwFVukn8aYZgB9xQ8=
X-Received: by 2002:a1f:9d45:0:b0:3bd:7464:d818 with SMTP id
 g66-20020a1f9d45000000b003bd7464d818mr15951093vke.11.1671124271987; Thu, 15
 Dec 2022 09:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20221215165523.1920672-1-arnd@kernel.org>
In-Reply-To: <20221215165523.1920672-1-arnd@kernel.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Thu, 15 Dec 2022 17:10:56 +0000
Message-ID: <CAOgh=Fw4BXvGNV0bsTXfSxy+ks09ed=nbJhkOWE+UrT7LW+r6A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: apple: remove duplicate intializer
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 15 Dec 2022 at 17:05, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Woverride-init is enabled, gcc notices that the .attr
> field is initialized twice:
>
> drivers/cpufreq/apple-soc-cpufreq.c:331:27: error: initialized field overwritten [-Werror=override-init]
>   331 |         .attr           = apple_soc_cpufreq_hw_attr,
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Remove the first one, since this is not actually used.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index d1801281cdd9..6f26395184c4 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -321,7 +321,6 @@ static struct cpufreq_driver apple_soc_cpufreq_driver = {
>         .flags          = CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
>                           CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
>         .verify         = cpufreq_generic_frequency_table_verify,
> -       .attr           = cpufreq_generic_attr,
>         .get            = apple_soc_cpufreq_get_rate,
>         .init           = apple_soc_cpufreq_init,
>         .exit           = apple_soc_cpufreq_exit,
> --
> 2.35.1
>
>


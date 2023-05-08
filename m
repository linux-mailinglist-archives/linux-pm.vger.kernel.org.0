Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792AB6FA816
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjEHKhd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjEHKhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 06:37:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A525532
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 03:37:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-559ded5e170so63562017b3.3
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683542235; x=1686134235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nVBy4bKcE1ILeYYBlxSfGOYmCjji6ZcSR1cqticyufg=;
        b=OR7a+dENDMKXARK/BF7xnqS2vk6KqxhOP9CI8buuf6XfsKKkAy4qDjJ66glIbUd3Pm
         ITjN96mDv6yDGpKevw4UYKQtyf9g3WpuE1FEYCtqVlFWbwnsqek/JifE4IMamkhIEQ0R
         lJljGHqm0cRwC6EAHfzq+YmGcjf/885lBXEwTan5IgJLuq/QJMXjXxz9A8rIe+xatxQL
         AvL7o5jm5Q5urSkX2waxSzGKmKyxA443sBsQ0TTDCr961fS6FOPtjZErwPTQUHco+KXk
         ziIuye7LUEaiKyvn82rrPin6Nv9oGAR4XY9WrGYa9ctpU85aUogew6U954xwfvIYDsV9
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542235; x=1686134235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVBy4bKcE1ILeYYBlxSfGOYmCjji6ZcSR1cqticyufg=;
        b=en2NBmNRn78nzySWF7kHGQcBOh0fep+xr8x3MQ39ardKDsUtrsvuq9Y6/0NJs38QUI
         47/nM+KUlBTjBBEHrZEo6u63RVXofo6/0rKH0AA4viX6ZOJWKn9fO0r4O2GlzVs+TQZS
         IJbGDpfcCnw+KYiXn+d70ZmqbFwOqkojC4rkQtXjhQSY/OfZ38PzkFtTIrM2bLB0dber
         hGJEy9mbnB2HVXFLip6bPnxPIrJ5vml3tPHi9KkChLyvAskLMLJ4gUzamJ/PMFDqspbo
         qB7l2a3bCWSWybbAqwj+OOOWHf50R7dDyuXeguv93MI37gfquZAg+yFFhrXjNfmWisXY
         3F3Q==
X-Gm-Message-State: AC+VfDyRUq9dPqJhGHfHnKRHjdo7hCyv6pTkmUVu95pttPNYh+KR4vDn
        2MDTmBr2ozvUsRPEhnQWSytN+OouhZegNFKOrHuGydDoUKG0UGPX
X-Google-Smtp-Source: ACHHUZ4HsqL/N/9al9gg/Vp1dK31uQxKKhVQLhHGx86/FmyidhGtZfpy7+GaFqvy3yIqlteSwZzY6EjLxS+CkMzdWlk=
X-Received: by 2002:a0d:e64a:0:b0:55a:6f13:dbb4 with SMTP id
 p71-20020a0de64a000000b0055a6f13dbb4mr10567481ywe.8.1683542235218; Mon, 08
 May 2023 03:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230418130743.67024-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20230418130743.67024-1-n.zhandarovich@fintech.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 May 2023 12:36:39 +0200
Message-ID: <CAPDyKFqC6eCMCjg4n_pRi9oJrkBfJuUT3Hpm=3C93dmU5E1muA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix integer overflow issues in genpd_parse_state()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 18 Apr 2023 at 15:07, Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Currently, while calculating residency and latency values, right
> operands may overflow if resulting values are big enough.
>
> To prevent this, albeit unlikely case, play it safe and convert
> right operands to left ones' type s64.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 30f604283e05 ("PM / Domains: Allow domain power states to be read from DT")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 32084e38b73d..51b9d4eaab5e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2939,10 +2939,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>
>         err = of_property_read_u32(state_node, "min-residency-us", &residency);
>         if (!err)
> -               genpd_state->residency_ns = 1000 * residency;
> +               genpd_state->residency_ns = 1000LL * residency;
>
> -       genpd_state->power_on_latency_ns = 1000 * exit_latency;
> -       genpd_state->power_off_latency_ns = 1000 * entry_latency;
> +       genpd_state->power_on_latency_ns = 1000LL * exit_latency;
> +       genpd_state->power_off_latency_ns = 1000LL * entry_latency;
>         genpd_state->fwnode = &state_node->fwnode;
>
>         return 0;
> --
> 2.25.1
>

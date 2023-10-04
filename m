Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6797B97F6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjJDWZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjJDWZD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 18:25:03 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D6D9
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 15:24:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d89491dab33so422651276.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696458297; x=1697063097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gH30QPkyF/caBY3YS+rN5NHQoXS59+XKdr7laMCwC0E=;
        b=fH2h1lIEmZYJHcsbKulKvnsi04ejpIVxeUaRQCllnrQWJda+wy3kHaoOb9HRk9YlaV
         1WXtbjXFV9hTY+sUqWVXlhpsg1gC+1RXrYKx1dCKqM06PkDYUg3rcEKNeyGusk6jQ7D4
         XB9kqLYIxTIYaJzqPBA+kZLTaq6i3F3PwuraQdh7IZp1DpIG3TwczGnNtD9+RhOiHhHy
         9INDdQfOd/af2mUdIKVoc8sN+knjNs0GIbqQkSf1BBmcIHVC0gdiV9Uo7sEUmQB2r7s5
         Pw2pQjIcEQJAGrqBHrAOkrgy2EOTmD4WmzMNNPe9+Cwyf4pyvpImziPQ3bh46HpIyEpI
         VuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458297; x=1697063097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH30QPkyF/caBY3YS+rN5NHQoXS59+XKdr7laMCwC0E=;
        b=QbQj+3BHXKqhT4A2q1tk7RvnTcMPD5cK8MGTrGNQrmZwvE0OxfLEfP0WQ1/YM62jDz
         RpoS1Uj5TR7JwrI+II2S2LROCpY6IHVNjMeNJfVJH8YcDNFdCoFWJ/DCHNKVjhhs5dA3
         pEjyZuYKZLrqNF6Y0QiC9/gu8JNgLWtbU5xQC9eaDMKBZ8KWjvyxjI7RYrBTsrTaYVOA
         707iZYFh5dxjY1sn4Hz3uiL7rGpvObbzYSPJVNAgkCOo+QkyqR9iFPDUOrbufIAThEF7
         U/uiUw2n+7iSpv+dVxyzOsvrztKqpr4YA4suWwagVdCsUQlCHTYv2kVHJSKH+sN0uyqe
         1BXg==
X-Gm-Message-State: AOJu0Yw4YEHU7jrnn6sVvBgeM8RgYTzebCNvBKvbODgR0dMxHvs4KP75
        Gq7vsaRI7Tfiw7F9VE55lICzgp2celH34hMFIZVwuQ==
X-Google-Smtp-Source: AGHT+IFo+3fXJ8TdbXgEN/Hz8y43/QTFuu7aQACpU8yUl344BH2AOBs1bXzHNFgaMnM5ALFgVPOmBpQhUdPplxGG4hI=
X-Received: by 2002:a25:7797:0:b0:d12:ab1:d88a with SMTP id
 s145-20020a257797000000b00d120ab1d88amr3426559ybc.40.1696458297530; Wed, 04
 Oct 2023 15:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230907095521.14053-1-Julia.Lawall@inria.fr> <20230907095521.14053-5-Julia.Lawall@inria.fr>
In-Reply-To: <20230907095521.14053-5-Julia.Lawall@inria.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Oct 2023 00:24:21 +0200
Message-ID: <CAPDyKFpEdFnJ5p+O2p-gr06mF9ug43Ss-=2uJeSVZzgrcTGzTg@mail.gmail.com>
Subject: Re: [PATCH 04/11] genpd: ti: add missing of_node_put
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Nishanth Menon <nm@ti.com>, kernel-janitors@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Sept 2023 at 11:55, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> for_each_node_with_property performs an of_node_get on
> each iteration, so a break out of the loop requires an
> of_node_put.
>
> This was done using the Coccinelle semantic patch
> iterators/for_each_child.cocci
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied for next (by amending the change to pmdomain instead of genpd), thanks!

Kind regards
Uffe

>
> ---
>  drivers/genpd/ti/ti_sci_pm_domains.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -u -p a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> --- a/drivers/genpd/ti/ti_sci_pm_domains.c
> +++ b/drivers/genpd/ti/ti_sci_pm_domains.c
> @@ -153,14 +153,18 @@ static int ti_sci_pm_domain_probe(struct
>                                         max_id = args.args[0];
>
>                                 pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> -                               if (!pd)
> +                               if (!pd) {
> +                                       of_node_put(np);
>                                         return -ENOMEM;
> +                               }
>
>                                 pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
>                                                              "pd:%d",
>                                                              args.args[0]);
> -                               if (!pd->pd.name)
> +                               if (!pd->pd.name) {
> +                                       of_node_put(np);
>                                         return -ENOMEM;
> +                               }
>
>                                 pd->pd.power_off = ti_sci_pd_power_off;
>                                 pd->pd.power_on = ti_sci_pd_power_on;
>

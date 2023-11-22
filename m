Return-Path: <linux-pm+bounces-85-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47937F48E8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFDB2815DF
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DA14BAB5;
	Wed, 22 Nov 2023 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="waQsfoa3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FFF195
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 06:27:11 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso6275176276.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700663230; x=1701268030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEGlLD2Ow2lZAT02DeB30p2mlAQUUZVJgtqFw5LKgjM=;
        b=waQsfoa3gBnm8gcsRXLPVTjEGIoddM/SN4mFDkTksRedKjNR0YxDOxfEx0535gkuA0
         eYqrxwD6LJ22JtYKxM2ZH6AoZj0tHAmbFllE+sFXcQy2sc0g+Nz9IWMWOIWbkW5tVisM
         E6Zrhwe+YokXqYngXYw6FqvnDztXb6IjWqMuGjEGndF3cn3iE1kFZgmlWrBSScE3ay4T
         OKeXW3/mWK3zbffuCQoRBdh9UYdTQW7AGU9/a2214zCep95U0gPI/9s03rmXhTOJGhiB
         qiQ54BLn6R66XJ9+vKqS7g/7wgkZvAI8rhfkti3At1nW/izoMdqidkEyrl8Qf+DpuJU/
         bK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663230; x=1701268030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEGlLD2Ow2lZAT02DeB30p2mlAQUUZVJgtqFw5LKgjM=;
        b=texn/Ex7/wY5Lnt+1iXOIbHsRl0aIsR0PDP1rMHqsjR8SMQ9jE9ndlhHv7HhP8rKVf
         0wxX0+A2SJeEd4l0uRp7bhrpwGhO+Wyx2eE2yo4eYylUvQBNWvylAa+R7TrG6vPoN0nW
         n18J/6527GZIOBxdj72cJ3UUzPD/yyHqY+4Deyfw8MURkgJRE24t3bH4Qe2cn/tX8swY
         1dSYTIckI3WrMye9Dl8YL2XCcCvWbRSpqq4UTGxM+ZP5ovscwgCFtQ9WqiryhPTRzMcN
         qK0e4bAdNblnbmGOzm1kQV4+/cYNzYrVuSEcm1xuB6wAbm48sbG8vRJSmX5ktxJV4g4B
         LCwQ==
X-Gm-Message-State: AOJu0YwrxdPJKqOTtFGsjTzK9K8Q/12N6bTSliM2wEtbaUmiywE8J7du
	DubwUvr0AGP3zUw0zhFtP7NpBWspcNsWPnVdCWF6bg==
X-Google-Smtp-Source: AGHT+IE2+q7lrPs5mSsrDj1Dttt3UsvOtu0q+VkkJx8sMENomjWEPq8uZjL3XpWfo4rtj7OvMlXJ3Ubb/nGEP5XSaXg=
X-Received: by 2002:a25:e20b:0:b0:d9a:51d7:2d1c with SMTP id
 h11-20020a25e20b000000b00d9a51d72d1cmr1990489ybe.45.1700663230453; Wed, 22
 Nov 2023 06:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700131353.git.viresh.kumar@linaro.org> <084b6088106da837abc43526c11d7d8bec850c5c.1700131353.git.viresh.kumar@linaro.org>
In-Reply-To: <084b6088106da837abc43526c11d7d8bec850c5c.1700131353.git.viresh.kumar@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Nov 2023 15:26:34 +0100
Message-ID: <CAPDyKFqX9LkYP=16guCBOMbNgYSb=HyXgVZvgYg3V8VEGQL11Q@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] OPP: Don't set OPP recursively for a parent genpd
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 11:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Like other frameworks (clk, regulator, etc.) genpd core too takes care
> of propagation to performance state to parent genpds. The OPP core
> shouldn't attempt the same, or it may result in undefined behavior.
>
> Add checks at various places to take care of the same.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I think this looks good to me, even if I think it's a bit tricky to
consider the various scenarios. :-) Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/opp/core.c | 16 +++++++++++++++-
>  drivers/opp/of.c   |  7 +++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e08375ed50aa..4f1ca84d9ed0 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2392,6 +2392,12 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>                 return -EINVAL;
>         }
>
> +       /* Genpd core takes care of propagation to parent genpd */
> +       if (opp_table->is_genpd) {
> +               dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> +               return -EOPNOTSUPP;
> +       }
> +
>         /* Checking only the first one is enough ? */
>         if (opp_table->required_devs[0])
>                 return 0;
> @@ -2453,8 +2459,16 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
>         if (opp_table->required_devs[0])
>                 return 0;
>
> -       for (i = 0; i < opp_table->required_opp_count; i++)
> +       for (i = 0; i < opp_table->required_opp_count; i++) {
> +               /* Genpd core takes care of propagation to parent genpd */
> +               if (required_devs[i] && opp_table->is_genpd &&
> +                   opp_table->required_opp_tables[i]->is_genpd) {
> +                       dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> +                       return -EOPNOTSUPP;
> +               }
> +
>                 opp_table->required_devs[i] = required_devs[i];
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5a7e294e56b7..f9f0b22bccbb 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -339,8 +339,11 @@ static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_tab
>          */
>         if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
>             !opp_table->required_devs[0]) {
> -               if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
> -                       opp->level = opp->required_opps[0]->level;
> +               /* Genpd core takes care of propagation to parent genpd */
> +               if (!opp_table->is_genpd) {
> +                       if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
> +                               opp->level = opp->required_opps[0]->level;
> +               }
>         }
>
>         return 0;
> --
> 2.31.1.272.g89b43f80a514
>


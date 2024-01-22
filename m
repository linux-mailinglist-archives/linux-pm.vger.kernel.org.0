Return-Path: <linux-pm+bounces-2479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393E836B97
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2E61F21468
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B959B56;
	Mon, 22 Jan 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0kRBFiG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D56405F0
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936906; cv=none; b=aEL8s4wJC98mvO2XjAb8uO1WGv7UTKTcsuTHvkM+yE5Y0YRT23MLJW1zoG1f3Nsuw566Rq5By6LxQxW0ejYSD8mwmwDIUe/Xtd5iB9DzkvcRkL+z+tAMb7Id7JlCU2GLTMmGoxFJoNdLDFMhFJjT6RzDsx29SZxqgDLxsGyAkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936906; c=relaxed/simple;
	bh=kDaZTGvX1qegyipawpDHtqiFJZ07zD34kOucMWLGuCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIy54XnuLagpAnbp36LvNPmfQLdv9LP7Nus1rzDuiFvQN7x0pMF/3MMXKAXVNS1FMwZKVyMYW5yTNTKzx5tgbXjgZuV3sE+Gaog5JNlcslxhO5T1oNWsX1Dky14o4ouFXXrg+H5wF5HcD4+Cez1CXkCzXqfO8Q9R88UpJIH6tZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A0kRBFiG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ffcb478512so9523007b3.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936902; x=1706541702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azZj8uWoAYXpYPWNpYpxGJSP02xYLkyFYL+zSVWu1Bk=;
        b=A0kRBFiG6UAmHBkpek1H0z+ZugkprCM4v+dvp8ZkbvS2euJqTiIj63D9KyEHLJuQku
         Ppy+zal9ycNrL0i7kzjKn3ScnHuy3F1qza3DknfSeHG7t1Yzw3c8uFsV83Pz7PcEIJnd
         iegoZGjmVUjiHjc98u44hQ7Xm0fTaLlIV6iAwQjK5ArBKw5aHwvIjGwG/3MRHq0jhOOM
         VzQD0YfMuD3IwywGPHN7TD2cAnO+urH4d8p8n2r59iuOPwba6/zapiBiA07hBK91/olR
         1sEjlV4pl2gG96cM79rxqXwHHY/X1Lhzh8BQeePzXAlxx9v+xQOyN+n1p6NIcPK4D+p0
         F8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936902; x=1706541702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azZj8uWoAYXpYPWNpYpxGJSP02xYLkyFYL+zSVWu1Bk=;
        b=DhmDzyrnxd9vZ545GxIlSgOCdLM+NTCEgEOO1OX87QOQ7AySUcCu5AKo9ARiTHzOdO
         p7U8+Bd6oizpAbYJHopMlYeVtpP8rkXTrpCG8FFGB5CcBUeGwS5xS5ShdY21vjJ2TAfZ
         0Tjx/bwenXCJJd1Zcr7NOWhMitK8cNeOqoShO5rylEqYU+wq68J0wARN8R/MRAmM6BYA
         QCH23gE9A1Emzcb1SsbjYFEX8gX+sW6GDlnCiIoaKjW8s9qX85YOrC54Hr2R/Lu8uHAC
         FVZqEvB+Xo7CanyKaqZqIbV9i/bNqnhPPBkRiWCrAfWf6LCTb6G6G4O6d52nMUs87eN4
         An7Q==
X-Gm-Message-State: AOJu0YzzOMxwMPusPA2gZowd+aMCIILVd/f6eWvePMJQfA+xvBTItTlI
	x/mgbNMSQutIXPUVaJQk41AtETMjENqKt+cMBUU7hiquKQdE6jTd/L8jEzKOlZ9ZDuOPhXufcsa
	0E6IBG6JAClweKqrnOHpT+wZ51Lk9hT2+NhFmQjIy025rJ8/msJE=
X-Google-Smtp-Source: AGHT+IGYCqA4bk0i1nasQEY2oO3ecNWeQHgvLLj0Cs/eKLO9AkpXZlekz3dN0S9SpflSX5Qf9j4n4Z9Lq2p6MFv6bDE=
X-Received: by 2002:a81:5cc1:0:b0:5fa:1942:f055 with SMTP id
 q184-20020a815cc1000000b005fa1942f055mr3274396ywb.48.1705936902370; Mon, 22
 Jan 2024 07:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
In-Reply-To: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:06 +0100
Message-ID: <CAPDyKFr3TRWM9UOtKkxSXKCAFN5wuvWLNcUfQuqGD91Ut1Ys1g@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Scale down parent performance states in
 reverse order
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 22:10, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Power domains might have parent domains assigned that are automatically
> managed by the PM domain core. In particular, parent domains are
> automatically powered on/off and setting performance states on child
> domains is translated to parent domains (e.g. using an OPP table from
> the device tree).
>
> Currently parent performance states are always adjusted before the
> performance state of the child domain is changed.
>
> However, typically a parent/child relationship between two power
> domains with performance states models the requirement to keep the
> parent domain at a performance state equal or higher to the child
> domain. When scaling down there is a brief moment where the parent
> domain will end up having a lower performance state than required by
> the child domain.
>
> To avoid this, we need to differentiate between scaling up/down and
> adjust the order of operations:
>
>  - When scaling up, parent domains should be adjusted before the child
>    domain. In case of an error, the rollback happens in reverse order.
>
>  - When scaling down, parent domains should be adjusted after the child
>    domain, in reverse order, just as if we would rollback scaling up.
>    In case of an error, the rollback happens in normal order (just as
>    if we would normally scale up).
>
> Implement this by moving the existing functionality of
> _genpd_set_performance_state() to two separate functions that are
> called in the proper iteration order.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

I have tested this with my local set of test drivers - and things are
now working as they should. Thanks a lot for fixing this!

I have applied the patch for next, but it's probably a good idea to
add a fixes/stable tag to it and queue it as a fix instead. What do
you think?

Note that, I took the liberty of slightly updating the commit message
a bit, to try to make things even more clear.

Kind regards
Uffe



> ---
> Changes in v2:
> - Rebase to adjust for move of drivers/base/power/domain.c
>   to drivers/pmdomain/core.c
> - Regenerate CC list
> - No code changes
> - Link to v1: https://lore.kernel.org/r/20231205-genpd-perf-order-v1-1-6597cc69a729@gerhold.net
> ---
> Related discussion: https://lore.kernel.org/linux-pm/ZWXgFNKgm9QaFuzx@gerhold.net/
> ---
>  drivers/pmdomain/core.c | 124 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 77 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a1f6cba3ae6c..fec9dc6ab828 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -311,72 +311,102 @@ static int genpd_xlate_performance_state(struct generic_pm_domain *genpd,
>  }
>
>  static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> -                                       unsigned int state, int depth)
> +                                       unsigned int state, int depth);
> +
> +static void _genpd_rollback_parent_state(struct gpd_link *link, int depth)
>  {
> -       struct generic_pm_domain *parent;
> -       struct gpd_link *link;
> -       int parent_state, ret;
> +       struct generic_pm_domain *parent = link->parent;
> +       int parent_state;
>
> -       if (state == genpd->performance_state)
> -               return 0;
> +       genpd_lock_nested(parent, depth + 1);
>
> -       /* Propagate to parents of genpd */
> -       list_for_each_entry(link, &genpd->child_links, child_node) {
> -               parent = link->parent;
> +       parent_state = link->prev_performance_state;
> +       link->performance_state = parent_state;
>
> -               /* Find parent's performance state */
> -               ret = genpd_xlate_performance_state(genpd, parent, state);
> -               if (unlikely(ret < 0))
> -                       goto err;
> +       parent_state = _genpd_reeval_performance_state(parent, parent_state);
> +       if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
> +               pr_err("%s: Failed to roll back to %d performance state\n",
> +                      parent->name, parent_state);
> +       }
>
> -               parent_state = ret;
> +       genpd_unlock(parent);
> +}
>
> -               genpd_lock_nested(parent, depth + 1);
> +static int _genpd_set_parent_state(struct generic_pm_domain *genpd,
> +                                  struct gpd_link *link,
> +                                  unsigned int state, int depth)
> +{
> +       struct generic_pm_domain *parent = link->parent;
> +       int parent_state, ret;
>
> -               link->prev_performance_state = link->performance_state;
> -               link->performance_state = parent_state;
> -               parent_state = _genpd_reeval_performance_state(parent,
> -                                               parent_state);
> -               ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
> -               if (ret)
> -                       link->performance_state = link->prev_performance_state;
> +       /* Find parent's performance state */
> +       ret = genpd_xlate_performance_state(genpd, parent, state);
> +       if (unlikely(ret < 0))
> +               return ret;
>
> -               genpd_unlock(parent);
> +       parent_state = ret;
>
> -               if (ret)
> -                       goto err;
> -       }
> +       genpd_lock_nested(parent, depth + 1);
>
> -       if (genpd->set_performance_state) {
> -               ret = genpd->set_performance_state(genpd, state);
> -               if (ret)
> -                       goto err;
> -       }
> +       link->prev_performance_state = link->performance_state;
> +       link->performance_state = parent_state;
>
> -       genpd->performance_state = state;
> -       return 0;
> +       parent_state = _genpd_reeval_performance_state(parent, parent_state);
> +       ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
> +       if (ret)
> +               link->performance_state = link->prev_performance_state;
>
> -err:
> -       /* Encountered an error, lets rollback */
> -       list_for_each_entry_continue_reverse(link, &genpd->child_links,
> -                                            child_node) {
> -               parent = link->parent;
> +       genpd_unlock(parent);
>
> -               genpd_lock_nested(parent, depth + 1);
> +       return ret;
> +}
> +
> +static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> +                                       unsigned int state, int depth)
> +{
> +       struct gpd_link *link = NULL;
> +       int ret;
> +
> +       if (state == genpd->performance_state)
> +               return 0;
>
> -               parent_state = link->prev_performance_state;
> -               link->performance_state = parent_state;
> +       /* When scaling up, propagate to parents first in normal order */
> +       if (state > genpd->performance_state) {
> +               list_for_each_entry(link, &genpd->child_links, child_node) {
> +                       ret = _genpd_set_parent_state(genpd, link, state, depth);
> +                       if (ret)
> +                               goto rollback_parents_up;
> +               }
> +       }
>
> -               parent_state = _genpd_reeval_performance_state(parent,
> -                                               parent_state);
> -               if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
> -                       pr_err("%s: Failed to roll back to %d performance state\n",
> -                              parent->name, parent_state);
> +       if (genpd->set_performance_state) {
> +               ret = genpd->set_performance_state(genpd, state);
> +               if (ret) {
> +                       if (link)
> +                               goto rollback_parents_up;
> +                       return ret;
>                 }
> +       }
>
> -               genpd_unlock(parent);
> +       /* When scaling down, propagate to parents last in reverse order */
> +       if (state < genpd->performance_state) {
> +               list_for_each_entry_reverse(link, &genpd->child_links, child_node) {
> +                       ret = _genpd_set_parent_state(genpd, link, state, depth);
> +                       if (ret)
> +                               goto rollback_parents_down;
> +               }
>         }
>
> +       genpd->performance_state = state;
> +       return 0;
> +
> +rollback_parents_up:
> +       list_for_each_entry_continue_reverse(link, &genpd->child_links, child_node)
> +               _genpd_rollback_parent_state(link, depth);
> +       return ret;
> +rollback_parents_down:
> +       list_for_each_entry_continue(link, &genpd->child_links, child_node)
> +               _genpd_rollback_parent_state(link, depth);
>         return ret;
>  }
>
>
> ---
> base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
> change-id: 20231205-genpd-perf-order-bf33029c25ac
>
> Best regards,
> --
> Stephan Gerhold <stephan@gerhold.net>
>


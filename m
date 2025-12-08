Return-Path: <linux-pm+bounces-39308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73ACAD374
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0453330271A3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD413313E0B;
	Mon,  8 Dec 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfneg7iY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41A31329B
	for <linux-pm@vger.kernel.org>; Mon,  8 Dec 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199606; cv=none; b=Eq/1JEGhCY18FC14F/OkUugovWHxdRwEWAtoXv7jLz9ylC1JqD/ot58+5Wr46GHnO/B0SJuCaeKMhpbOSu8YR/JuyYCDv6L17AxmPyu698o2JA4iqsIHtC9YK+PBAFVkOoMMp+AKV1wzJkv8iUSplnEBgRM6Q+ZaNtKAN4YnUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199606; c=relaxed/simple;
	bh=TwWCPKzpIxFggiis5EJAWjbBKx94IAg8+GXkvJtKvLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feY/jIE1U9hzt5zWmsDURklmksrQW+MYY54tYSTJZdyf5AVPCJviGhTthK9dXuH+RUYGiBaQlWKBT2KfPfUL4nEfTqEyCxAt1IBNwCS4csqhMz1CPZwSFkXhz7vuwzrvEArfNaLSuK1tTk3NxR3raBhWDWg9XVRxRujksEl/nuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nfneg7iY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c04f279c2so35470177b3.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2025 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765199604; x=1765804404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U4F7ZL99aqhqCZu6b5r5aq44/krq7Nw9zGliMYiL0Xo=;
        b=nfneg7iYzTjRJqnE6tYzIblNYK/RuE/iBfU3J7EOQV6diRee6b7/+pJNMuXeQj9b1S
         w+ReAEH2gItuNUWEKIY+PIacC9FUNpbqu/XRqAbtsZ5wWWxrZw7Fqy8rxbIn1QTcPwTt
         uOaFLSf3cR0l66Wl2VKJUgtEtrHZ0CQgBVUTR8BY1kuFUMaVhZdIZZN1f5snxmMTjn5x
         BkD34p1Swa7m17q8RphNIMuqv7iwM1nEMIhApsSbF5dM0h3lQafh+ERWISRBBIH8ZiGY
         CdQX8nRFinUcMHsMa0Ie/G7Xa6NVBfgKi62P8dlptLuWBeqRpm9qmbO8/pUQolclQlhl
         SA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765199604; x=1765804404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4F7ZL99aqhqCZu6b5r5aq44/krq7Nw9zGliMYiL0Xo=;
        b=p9s1VKOk64u0p3TRkr8N5C4lSLlKbSqhCTxUBraBGlfV5FQ/np/0+kCO7NRG9yNw6F
         CDpCQB3wo1UnxskH6ewRhzOK1PezXk0heOBMm+4xet2r91vjWhKY1PaJ5qUbx51JtpPv
         ZnMah8cJpE1hE2UMTQhjLD26SaN4NNIsbxh7MPBd2z62ovx6mRIbXGnwDKPehYtjJi3v
         TsWwjjHjYHD45W5SP8/PcDYyFhOFR3/A+sWFp9bznQCcvVrjGJvbdZUCb4QUqEyW8QlJ
         dMFdKbgNFB8o8IC2HD50md6+pUdcHFgULI8xAoYOiNQGqxVxEQv+az+ZaRRf2Sr1ea3V
         ++Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWUadkL4/OOHVtOCi3SwcGf2/ktcewVnWi6odK5jDmHRDZQfar6lpyrPGJqJBfkE71UyLClp3WRRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcBGwtxqYwon/NX1KwmaMg+AMfU8h/V/5l/RFWR1h2vX0ejr0
	eR6Mzaln7z2zCj4nbk6TkJb7ia7GxFicxJKOBeCtrz90YDvMn3CErZhShs2ZpJuu3aBjaeg2qNN
	1JzatLx4aK1tIQU5i9gEvTSspz2NsuNXu34tCtYIOjQ==
X-Gm-Gg: ASbGncu+OfJQTdWivnMKjPoi3iQukc0gPiBFhc6NJsfilKuOzSgOG38P3s6gG+QtMhL
	1YbISZnYshRfq5/OyBYwuH45QBkBu8k8wSv3n23JrjC0rLWD9CwEHiDHYDFjJUybOqp/o2+ZUCr
	KmfHgBMT2uY6Xv5yI9vcPy0E/GXFj3h+LGWzgAQT2Cwf65cWmy6pu3ZMLnU2IFYLqZkgYWc2eIq
	xP/nSbLNgS1Jg6Q7bRBeNkQdzQtw2Pt6mlpnQe1SmPoMN5nM1sa6gcUJamhlqhNt2TGU5Qe8Lk0
	b5Yq5ZQ=
X-Google-Smtp-Source: AGHT+IEc+tQn4FlM3xgfoi7p+M/ePz1xrg/JLm9qgbY5MbEStmMwZWYW1PqFqIMzAt111qvaxaw/ojMdWaOmp4eJ238=
X-Received: by 2002:a05:690c:998f:b0:788:e1b:5ec5 with SMTP id
 00721157ae682-78c33c9d585mr64063137b3.70.1765199603530; Mon, 08 Dec 2025
 05:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-pmdomain-hierarchy-onecell-v4-0-f25a1d5022f8@baylibre.com>
 <20251119-pmdomain-hierarchy-onecell-v4-1-f25a1d5022f8@baylibre.com>
In-Reply-To: <20251119-pmdomain-hierarchy-onecell-v4-1-f25a1d5022f8@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Dec 2025 14:12:46 +0100
X-Gm-Features: AQt7F2oi-0CKfmM2SJnDhrJJSctBrmKoLQ1-b2GC0lpHAW_bc0xkxXimQ7YUE9c
Message-ID: <CAPDyKFoU10ASgtXVUiCyj+rWehkMhkX=w=W1ieTksPdpskUN0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/2] pmdomain: core: support domain hierarchy via power-domain-map
To: "Kevin Hilman (TI.com)" <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 01:58, Kevin Hilman (TI.com)
<khilman@baylibre.com> wrote:
>
> Add of_genpd_add_subdomain_map() helper function to support
> hierarchical PM domains defined by using power-domains-map
> property (c.f. nexus node maps in DT spec, section 2.5.1).
>
> This enables PM domain providers with #power-domain-cells > 0 to
> establish subdomain relationships via the power-domain-map property,
> which was not previously possible.
>
> This new helper function
> - uses an OF helper to iterate to over entries in power-domain-map
> - For each mapped entry: extracts child specifier, resolves parent phandle,
>   extracts parent specifier args, and establishes subdomain relationship
> - Uses genpd_add_subdomain() with proper gpd_list_lock mutex protection
>
> Example from k3-am62l.dtsi:
>
>   scmi_pds: protocol@11 {
>       #power-domain-cells = <1>;
>       power-domain-map = <15 &MAIN_PD>,  /* TIMER0 */
>                          <19 &WKUP_PD>;  /* WKUP_TIMER0 */
>   };
>
>   MAIN_PD: power-controller-main {
>       #power-domain-cells = <0>;
>   };
>
>   WKUP_PD: power-controller-main {
>       #power-domain-cells = <0>;
>   };
>
> This allows SCMI power domain 15 to become a subdomain of MAIN_PD, and
> domain 19 to become a subdomain of WKUP_PD.

Nitpick:
As long as possible, please use the terminology "parent-domain" and
"child-domain" and avoid "subdomain". There are a couple of cases of
this, in the code too, can you please update all of them?

>
> Signed-off-by: Kevin Hilman (TI.com) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/core.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  9 +++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 61c2277c9ce3..592e9126896c 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3483,6 +3483,70 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>

We need to add some description of the function here.

> +int of_genpd_add_subdomain_map(struct device_node *np,

Nitpick:
Hmm, either we should keep consistency with the name
"of_genpd_add_subdomain", according to what you propose - or we should
take the opportunity to move to use "child" in the name instead
(of_genpd_add_child_domain_map()).

Sooner or later it would be nice if we could rename
of_genpd_add_subdomain() (and friends) to of_genpd_add_child_domain().

No big deal at this point, I am fine with whatever name you decide to use.

> +                              struct genpd_onecell_data *data)
> +{
> +       struct generic_pm_domain *genpd, *parent_genpd;

Maybe use "child" and "parent" as variable names instead. This should
make the code a bit more clear.

> +       struct of_phandle_args child_args, parent_args;
> +       int index = 0;
> +       int ret = 0;
> +       u32 child_index;
> +
> +       if (!np || !data)
> +               return -EINVAL;
> +
> +       /* Iterate through power-domain-map entries using the OF helper */
> +       while (!of_parse_map_iter(np, "power-domain", &index,
> +                                  &child_args, &parent_args)) {
> +               /* Extract the child domain index from the child specifier */
> +               if (child_args.args_count < 1) {

This should be exactly 1, right?

> +                       of_node_put(parent_args.np);
> +                       ret = -EINVAL;
> +                       break;

If we fail here, we should remove child domains that we added for the
earlier indexes in the while loop, rather than just bailing out.

This applies to other error paths below too.

> +               }
> +               child_index = child_args.args[0];
> +
> +               /* Validate child domain index */
> +               if (child_index >= data->num_domains) {
> +                       of_node_put(parent_args.np);
> +                       continue;

I don't think we should just continue here, but instead treat this as an error.

> +               }
> +
> +               genpd = data->domains[child_index];
> +               if (!genpd) {
> +                       of_node_put(parent_args.np);
> +                       continue;

Ditto.

> +               }
> +
> +               /* Get parent power domain from provider and establish subdomain relationship */
> +               mutex_lock(&gpd_list_lock);
> +
> +               parent_genpd = genpd_get_from_provider(&parent_args);
> +               if (IS_ERR(parent_genpd)) {
> +                       mutex_unlock(&gpd_list_lock);
> +                       of_node_put(parent_args.np);
> +                       ret = PTR_ERR(parent_genpd);
> +                       dev_err(&genpd->dev, "failed to get parent domain: %d\n", ret);

Perhaps clarify the print by changing the text to state that we can't
find the parent's OF provider. If the print is needed at all.

> +                       break;
> +               }
> +
> +               ret = genpd_add_subdomain(parent_genpd, genpd);
> +               mutex_unlock(&gpd_list_lock);
> +               of_node_put(parent_args.np);
> +
> +               if (ret) {
> +                       dev_err(&genpd->dev, "failed to add as subdomain of %s: %d\n",
> +                               parent_genpd->name, ret);
> +                       break;
> +               }
> +
> +               dev_info(&genpd->dev, "added as subdomain of %s\n",
> +                       parent_genpd->name);
> +       }
> +
> +       return ret;
> +}

Except for taking better care in the error path, it also looks like we
are missing a corresponding function to remove the child-domains that
was added with the above new function.

Perhaps that function can be used in the error paths too?

> +
>  /**
>   * of_genpd_sync_state() - A common sync_state function for genpd providers
>   * @np: The device node the genpd provider is associated with.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f67a2cb7d781..3585acb89b83 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -462,6 +462,8 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
>  int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
>                               const struct of_phandle_args *subdomain_spec);
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
> +int of_genpd_add_subdomain_map(struct device_node *np,
> +                              struct genpd_onecell_data *data);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
>  void of_genpd_sync_state(struct device_node *np);
> @@ -504,6 +506,13 @@ static inline int of_genpd_remove_subdomain(const struct of_phandle_args *parent
>         return -ENODEV;
>  }
>
> +static int of_genpd_add_subdomain_map(struct device_node *np,
> +                                     struct generic_pm_domain *genpd,
> +                                     int index)
> +{
> +       return -ENODEV;
> +}
> +
>  static inline int of_genpd_parse_idle_states(struct device_node *dn,
>                         struct genpd_power_state **states, int *n)
>  {
>
> --
> 2.51.0
>

Kind regards
Uffe


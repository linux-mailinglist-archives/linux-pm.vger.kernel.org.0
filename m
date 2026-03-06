Return-Path: <linux-pm+bounces-43849-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JkPIwP0qmkjZAEAu9opvQ
	(envelope-from <linux-pm+bounces-43849-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:34:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6F223E19
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBA923039650
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14093E556F;
	Fri,  6 Mar 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVI3IsJf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78ED3E3D9A
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811056; cv=pass; b=Nb8+0TwnOhYCX5K9LuhAjbP1BSVp1uSIZ+SFSfPXxzGchRsJxGZbBaRibJGxnYBmtBAJByGEZhLWhYYd6dpIYd4iYq4c2zIyfZSEjJ/zqHqs+rGRqkSmP/snuC9DSb1oJcB6Q57s04O0RzcnDRMKCC9gOmey+rXQ43eL4QPSFZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811056; c=relaxed/simple;
	bh=46xMvOYumwmjwLPg5YVs7sI653yrVjCZpDniQ/O9pso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsWOvunGRSUKIe2f2ZqPtGWPk0T4l/rxPqcoTdHjaIINSfRNe3zfdHvQNxXc365dsFeLV9umTKD159FYNK+ykvhYTB49ppwb38gYHgBYQnNgkXsPnclCTI+EaIMVhEZo61sdwfntpTl1saaOmcJjmzOsqrOv9h5/PUq3zDNrTyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVI3IsJf; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso2850451a12.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772811053; cv=none;
        d=google.com; s=arc-20240605;
        b=OsqdRffXQa39s+VuQmcZmfoJ+HnoJNa2Heos0GzccEgxVJQPs6aIzB84jWmWATC+Fm
         0hk3OP2FizDfKwZBHml3QXnuQBIIuwVA6PsOkScvcvMd4kX8E+aMmDWxZ3u/gMdaDISa
         ntFXxbd7ol78Q4zlIJHwsD5uVSW1qJhzUYJg5Jz/J6pdZ6/91iFfHJdrRFDBV6U+UyHY
         6OXzWmjbHoIhMzWAQBWduQaGGxCPLFKz2fjNCVUVZ5dkuw2s4mwfd9GxCbS2UiXZu7Zf
         Ke4ORSfZypssl6l9HF5/l3fOGco3HaO4TB2u+mx8mNROBsv6UgKuc064PKOpyNTsUZqH
         loSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEcKE/Xry4U3uD1i7TPLQGRKNjLm+QJOilg4eN6K6Ig=;
        fh=wAM7PMOqv8wrePnJ6eYAza1/XwxdLBA7IJHISBD4DWs=;
        b=GNaIhqfQO9eEV3U7pbjB5TVtTVRb7yBIXsDGF6yHz5NyTwaSjFAOve3LXYZ1mlAhbb
         gMEOPhDr2OCAlJy0nPJUcH7XWQzAvVCyYfByXZPmdlPRm6oK5yRBma+iayqqeVQkxrIN
         dF3aNDDzd1Ac+f427OW13xys5ZDxhKRAd+/5tS2K4XMlJNLIo6jtR4bplp0Ld9Kl0lc/
         BU6OEidk8soZpMNt1QROiOvR1AI1K/JTPa03vsqra3Lhym1lonWeJ77zmQX3P4j0S4I5
         oMMPTzzwyTnXqs9JEO4ZKyiBtC1UmJvZX///23K3MkXS/zp4XILWEdJzEdwUaGwnI6hb
         lABg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772811053; x=1773415853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEcKE/Xry4U3uD1i7TPLQGRKNjLm+QJOilg4eN6K6Ig=;
        b=fVI3IsJfhbPtjn+9sIwlAH42d3Tspl9+0/Avk4wuCeOr3Pq9w3/JnmzYEvBBU34W0q
         XS43+GW7ohVVg0zXEYmcLkSOPbZBu2g3hDK+VYfbHiPnjSfHAIZ2UeM1SU0AaOIRdTKG
         oQ0aEmWuCyRrvCsGLHoOMM1yOlbMIorbRFWcaBCmreWmMzHcB+cWSQb322zuy/j8j/m3
         C23Iyb4pp1mly6jGRZw3A64YulAupOCAEUVNunLV07ETU0B/GQWOXsBesyNv+IGVgJ/V
         Ja3/dVk8hxB+BQ/UB/7x6qFoKVVP1t4mANgAk1plHZb2vqB+G/PmFi4fhtGFe8MkCc8a
         lJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772811053; x=1773415853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEcKE/Xry4U3uD1i7TPLQGRKNjLm+QJOilg4eN6K6Ig=;
        b=GqhhZX5Ktb14ugeBOJQc0Wt1i+V8+sj1ATCTiP8cJS40FrgyPVScrJttc4DQWq8CXr
         /ltHlEfgVOIWqOGDpBiK+g0u4RmfIbIjWXO+Rd+1UPB0cXwMJb8u5VN3d8EsDKvuN2Xu
         lrtm3zC/G58kcMQOyQRdOydv79cyXFS9aKep27q+t2ln6hnobs9ygjKrrh2HrhXkKfs1
         lMUX+KWDUT8Tvt654+PQthaCI1Qt/Bul4emvNZgU1gN+LSn/WqwzwFeWtAwLhFZTF5eT
         lclI1rf3SaYO/EPac63xX8XTzVtEt6v7SDUg5E53ekPMYyJSuzHoLiMVdUqqegFtV5Vl
         yADA==
X-Forwarded-Encrypted: i=1; AJvYcCUQN325ui07InftHE+qkO+uwYAKBxFeg0jHKWUz8vn8jaSYE9lxcNbf8v/o1w1BI7m3sIcw9TyDcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ynI3ufz2UNfKzQhQ/63703iV10sq7DH0Qh0zLEzZOEvVnRG8
	mGME5rDKV5E3GW8BeI0LlXU9Rs7KkMoUC2rK/AJCqixuI6OiqVmp+XK47699d7hBwHNiM9ZNfG8
	DsNq6qFQhmsgNNzIz1CBALhWHrsZTbo7YNoB7yYENrg==
X-Gm-Gg: ATEYQzziNRfgelU2JftuvblcayVrLe3viIVh04AwQYdN/PE2JWd0sMQyZ/uxF0klDsI
	B3Cdz0jr2WUNfxwjHREdFQKJYwqZAot4DzMamwiR3xPqA5nOVXQXWNKfDcR1+Q8C8cXJPp5t3tS
	6KfgNWeyHL0cP7hit70UWlNLPdZBYJrhSDX6iNTfdMm2jEhZLY0qsDPaWUGtkoWItY9BffH+axq
	y2SV/IKpOi4k6/tV8unJ/SZFUJOXFbOYhP7y0/GpynLnTnDvhgQ8YrFfPn7BPEblj/LNiKFjplF
	HRN4HdGN59AAUNyx+6u1CzSletBo9yEqYoOnzf1LaA==
X-Received: by 2002:a05:6402:278f:b0:659:4099:877 with SMTP id
 4fb4d7f45d1cf-6619d2f6d81mr1512760a12.0.1772811052896; Fri, 06 Mar 2026
 07:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-5-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-5-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 15:30:41 +0000
X-Gm-Features: AaiRm50zapVukbutcTzczn3suOY9q3j1hR6w8wOK7BWF-RBJ1XR5B4U0Jjw-RuU
Message-ID: <CADrjBPriZBKpBvZZ4ScNSd2NDT1Oa=y0Z7ZXTt1_ss3y4xkCcQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] pmdomain: samsung: convert to using regmap
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8AE6F223E19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43849-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,samsung.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On platforms such as Google gs101, direct mmio register access to the
> PMU registers doesn't necessarily work and access must happen via a
> regmap created by the PMU driver instead.
>
> In preparation for supporting such SoCs convert the existing mmio
> accesses to using a regmap wrapper.
>
> With this change in place, a follow-up patch can update the driver to
> optionally acquire the PMU-created regmap without having to change the
> rest of the code.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> There is one checkpatch warning, relating to the non-const
> regmap_config. It can not easily be made const at this stage, but a
> follow-up patch allows us to make it const and the warning will go away
> anyway.
>
> v4:
> - rework the loop in exynos_pd_power() slightly, to not return 0 early
>   to allow more code to be run after pd on/off register write without
>   changing the loop again, required for gs101.
> - add error message in case first regmap write in exynos_pd_power() fails
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/pmdomain/samsung/exynos-pm-domains.c | 83 +++++++++++++++++++++-=
------
>  1 file changed, 62 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 5c3aa8983087..3bcba7d38ac1 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -9,15 +9,14 @@
>  // conjunction with runtime-pm. Support for both device-tree and non-dev=
ice-tree
>  // based power domain support is included.
>
> -#include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/pm_domain.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>
>  struct exynos_pm_domain_config {
>         /* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
> @@ -28,7 +27,7 @@ struct exynos_pm_domain_config {
>   * Exynos specific wrapper around the generic power domain
>   */
>  struct exynos_pm_domain {
> -       void __iomem *base;
> +       struct regmap *regmap;
>         struct generic_pm_domain pd;
>         u32 local_pwr_cfg;
>  };
> @@ -36,31 +35,42 @@ struct exynos_pm_domain {
>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_=
on)
>  {
>         struct exynos_pm_domain *pd;
> -       void __iomem *base;
>         u32 timeout, pwr;
> -       char *op;
> +       int err;
>
>         pd =3D container_of(domain, struct exynos_pm_domain, pd);
> -       base =3D pd->base;
>
>         pwr =3D power_on ? pd->local_pwr_cfg : 0;
> -       writel_relaxed(pwr, base);
> +       err =3D regmap_write(pd->regmap, 0, pwr);
> +       if (err) {
> +               pr_err("Regmap write for power domain %s %sable failed: %=
d\n",
> +                      domain->name, power_on ? "en" : "dis", err);
> +               return err;
> +       }
>
>         /* Wait max 1ms */
>         timeout =3D 10;
> -
> -       while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) !=3D pwr) =
{
> -               if (!timeout) {
> -                       op =3D (power_on) ? "enable" : "disable";
> -                       pr_err("Power domain %s %s failed\n", domain->nam=
e, op);
> -                       return -ETIMEDOUT;
> +       while (timeout-- > 0) {
> +               unsigned int val;
> +
> +               err =3D regmap_read(pd->regmap, 0x4, &val);
> +               if (err || ((val & pd->local_pwr_cfg) !=3D pwr)) {
> +                       cpu_relax();
> +                       usleep_range(80, 100);
> +                       continue;
>                 }
> -               timeout--;
> -               cpu_relax();
> -               usleep_range(80, 100);
> +
> +               break;
>         }
>
> -       return 0;
> +       if (!timeout && !err)
> +               /* Only return timeout if no other error also occurred. *=
/
> +               err =3D -ETIMEDOUT;
> +       if (err)
> +               pr_err("Power domain %s %sable failed: %d\n", domain->nam=
e,
> +                      power_on ? "en" : "dis", err);
> +
> +       return err;
>  }
>
>  static int exynos_pd_power_on(struct generic_pm_domain *domain)
> @@ -109,8 +119,18 @@ static int exynos_pd_probe(struct platform_device *p=
dev)
>         struct device_node *np =3D dev->of_node;
>         struct of_phandle_args child, parent;
>         struct exynos_pm_domain *pd;
> +       struct resource *res;
> +       void __iomem *base;
> +       unsigned int val;
>         int on, ret;
>
> +       struct regmap_config reg_config =3D {
> +               .reg_bits =3D 32,
> +               .val_bits =3D 32,
> +               .reg_stride =3D 4,
> +               .use_relaxed_mmio =3D true,
> +       };
> +
>         pm_domain_cfg =3D of_device_get_match_data(dev);
>         pd =3D devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
>         if (!pd)
> @@ -120,9 +140,26 @@ static int exynos_pd_probe(struct platform_device *p=
dev)
>         if (!pd->pd.name)
>                 return -ENOMEM;
>
> -       pd->base =3D of_iomap(np, 0);
> -       if (!pd->base)
> -               return -ENODEV;
> +       /*
> +        * The resource typically points into the address space of the PM=
U.
> +        * Therefore, avoid using devm_platform_get_and_ioremap_resource(=
) and
> +        * instead use platform_get_resource() and devm_ioremap() to avoi=
d
> +        * conflicts due to address space overlap.
> +        */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return dev_err_probe(dev, -ENXIO, "missing IO resources")=
;
> +
> +       base =3D devm_ioremap(dev, res->start, resource_size(res));
> +       if (!base)
> +               return dev_err_probe(dev, -ENOMEM,
> +                                    "failed to ioremap PMU registers");
> +
> +       reg_config.max_register =3D resource_size(res) - reg_config.reg_s=
tride;
> +       pd->regmap =3D devm_regmap_init_mmio(dev, base, &reg_config);
> +       if (IS_ERR(pd->regmap))
> +               return dev_err_probe(dev, PTR_ERR(base),
> +                                    "failed to init regmap");
>
>         pd->pd.power_off =3D exynos_pd_power_off;
>         pd->pd.power_on =3D exynos_pd_power_on;
> @@ -137,7 +174,11 @@ static int exynos_pd_probe(struct platform_device *p=
dev)
>             of_device_is_compatible(np, "samsung,exynos4210-pd"))
>                 exynos_pd_power_off(&pd->pd);
>
> -       on =3D readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
> +       ret =3D regmap_read(pd->regmap, 0x4, &val);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to read status");
> +
> +       on =3D val & pd->local_pwr_cfg;
>
>         pm_genpd_init(&pd->pd, NULL, !on);
>         ret =3D of_genpd_add_provider_simple(np, &pd->pd);
>
> --
> 2.53.0.473.g4a7958ca14-goog
>


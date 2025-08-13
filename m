Return-Path: <linux-pm+bounces-32262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B4B24855
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E31A273F7
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AF2ECEBD;
	Wed, 13 Aug 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZEeUlg7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FE2D373A
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083882; cv=none; b=ejmkn1M9Qb0g8JVoUZnA4n/EGhbyZlMag+mo14ERaoKg7P6EcBqDhf3gE+Dla15XuxDDC87R7MbyVfeLtWDFLMdarmLQ8kaxTxpgD6a+RHaWleFvInbxpJxS7Sm0d6YbqlXmYwfEfVUM4h5Ch3T2lDCC+sDCgYfn5qQEV5NM5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083882; c=relaxed/simple;
	bh=RyRDckRflIvigbMK4BKJe6kv1H6Avr2M4Juoxfr73+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sD6WJwfirn9Grrbd8MDeXDIA04LANNhkCJ3Uk9TQY3Ji0NwvrqxTb/oaIddNPe2PMvBy61bCtXel7tyXn+dunk+xHJI/onRZ/e0qYDaqDa19dUC3kyKo2QX9Oxh5n4qB3/PaWHYP/InQBXuJ1l67h7M6OpR3h4rSkAYF11O0MJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZEeUlg7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71b49bbb95cso64403277b3.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755083880; x=1755688680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQn0ud8P/exClfh8nwi+p3iZczWgk30lvs9ZzrOzyjs=;
        b=pZEeUlg7fKmBYbrYn3J/fH2eoND1Ky6zItzzpQXFiVc46OnmSpQcbjNRbHJnvEe3rK
         pGjxcZ3VWcQbpHSzHz9RDmNim932rlpQVlrS0qnRZxCuug6V9zC48LO3H9K2phT/1wTm
         ME7FLFX4CTojhJEObpaRncUWksh4FdTwwhmdpw6E1Se0dPIJyqYST0Biz0w8249z/xXr
         9nhYsOXG1/ziVYzBaRGoNCq+138pWKPFaIWBt9CGMFlfc/m7T2VJaEc67Hxu6OHHvuYp
         qP3iqKwkwWls4vCGfax3NymMqTsTFEoD5z87huio5Y/SHvvDqFQBBA5ckHLmWiSI6WIe
         q6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083880; x=1755688680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQn0ud8P/exClfh8nwi+p3iZczWgk30lvs9ZzrOzyjs=;
        b=xNgXQqKQPO9UutCX6zrAKN428lHbsZn1C5Fn9FJxxrBTCtfhfd+960Iw0yayv56OMR
         4bg6oWGI4onJTfUEmjUPWfjlwqqSLD3PmH0lDBhWhDP33fWbnckeyopgc8nZULmoB1TJ
         KGWju8gS91Zs4hS2SiaXz2OaRXA0q/QbCtZjvlazJ31C9W2McMwCLl8WX9QksGNXBPJi
         1GMPyHwAAas2XlY0EFbfIYUNaxdVzx6YlBKLM0ZjRhj8n09i4TgU4MQOYtQLSOwgw05G
         rV+uagafrup2h2FZljtaAOWuUWOX5dt0/9SKYDaW9I3os8Bj87bLZFyScX0FB0MQuiR/
         48iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmR5VSJWVWKVp7OU1pmGsdlpLmIeihyY7q+Gki8m7OxByCj/uMlNDOUA4y+AyEz7ep9CkdJWH02Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxeJsznvwUlHS7S35oeK2GV0HWpvS/Ab/JihOKie/jbEPidfQ
	Oz7LqNzLtLpQfWLLshrMkzeiqtS/+b1+pLxPLkSqAd/bgLz2+8pkmieA81hmOmDVydMAc/DnGS1
	9PsfZ9WBJyx7snI9Kto9CNjZODEgxvNZuEG1Eqivf8Q==
X-Gm-Gg: ASbGncsekEMX4/wjQy6FqbgqUPlAr+8UF1QMxmJ6DYkknLNNV6YtiixkRc4dol+xx5k
	f0l+zhnayCAPGbbQ1oYInYNr7XCgrW/D2HojdFqzyKrL6NTt0KbCRDX4vO2VkA4+uNiVUQKiJ6J
	vKH0tqYvOoRb870Y+ztC+y7nZ6e/IfwQ4yN7RkWtSOj5WR4gFOOp12yIShOlltdMmAxoid6c/a8
	fXflbVn
X-Google-Smtp-Source: AGHT+IG052VMXccj//iGRu0wrLb2Y8MwTk9cbYCNNk3fvvneFhZ02VT0QHUekplN/0z2vyPr5RH0oPrEgIPeeW8/eko=
X-Received: by 2002:a05:690c:4b93:b0:71c:1673:7bd4 with SMTP id
 00721157ae682-71d4e52cb3dmr29653857b3.23.1755083879749; Wed, 13 Aug 2025
 04:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be>
In-Reply-To: <81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Aug 2025 13:17:23 +0200
X-Gm-Features: Ac12FXxID4SAvN1nQwTTkwzxcE_ncFRuux2gIUE7FTXR5LTWY5TdT46TbnCNXb4
Message-ID: <CAPDyKFrCQdPAiDQyHm05mS7avOq6GPr0Ke4rZ2eaOhm37KGjfw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: mstp: Add genpd OF provider at postcore_initcall()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 10:20, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Genpd OF providers must now be registered after genpd bus registration.
> However, cpg_mstp_add_clk_domain() is only called from CLK_OF_DECLARE(),
> which is too early.  Hence on R-Car M1A, R-Car H1, and RZ/A1, the
> CPG/MSTP Clock Domain fails to register, and any devices residing in
> that clock domain fail to probe.
>
> Fix this by splitting initialization into two steps:
>   - The first part keeps on registering the PM domain with genpd at
>     CLK_OF_DECLARE(),
>   - The second and new part moves the registration of the genpd OF
>     provider to a postcore_initcall().
>
> See also commit c5ae5a0c61120d0c ("pmdomain: renesas: rcar-sysc: Add
> genpd OF provider at postcore_initcall").
>
> Fixes: 18a3a510ecfd0e50 ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume there is a good reason to have one early part and one later
part for the OF provider registration, otherwise we might as well do
all the genpd registration at postcore_initcall, right?

In any case, please add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> To be queued as a fix in renesas-clk-for-v6.17.
>
> drivers/clk/mmp/clk-of-mmp2.c:mmp2_pm_domain_init() has the same issue.
>
> Note that R-Car H1 still booted fine, as the CPG/MSTP Clock Domain is no
> longer used directly on that SoC: all devices were moved to the R-Car
> SYSC PM Domain in commits 751e29bbb64ad091 ("ARM: dts: r8a7779: Use SYSC
> "always-on" PM Domain") and commit a03fa77d85a736d3 ("ARM: dts: r8a7779:
> Use SYSC "always-on" PM Domain for HSCIF"), and use the clock domain
> only indirectly from rcar-sysc through cpg_mstp_{at,de}tach_dev()).
> ---
>  drivers/clk/renesas/clk-mstp.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
> index 6b47bb5eee45f75b..5fcc81b92a973771 100644
> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c
> @@ -305,6 +305,9 @@ void cpg_mstp_detach_dev(struct generic_pm_domain *unused, struct device *dev)
>                 pm_clk_destroy(dev);
>  }
>
> +static struct device_node *cpg_mstp_pd_np __initdata = NULL;
> +static struct generic_pm_domain *cpg_mstp_pd_genpd __initdata = NULL;
> +
>  void __init cpg_mstp_add_clk_domain(struct device_node *np)
>  {
>         struct generic_pm_domain *pd;
> @@ -326,5 +329,20 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
>         pd->detach_dev = cpg_mstp_detach_dev;
>         pm_genpd_init(pd, &pm_domain_always_on_gov, false);
>
> -       of_genpd_add_provider_simple(np, pd);
> +       cpg_mstp_pd_np = of_node_get(np);
> +       cpg_mstp_pd_genpd = pd;
> +}
> +
> +static int __init cpg_mstp_pd_init_provider(void)
> +{
> +       int error;
> +
> +       if (!cpg_mstp_pd_np)
> +               return -ENODEV;
> +
> +       error = of_genpd_add_provider_simple(cpg_mstp_pd_np, cpg_mstp_pd_genpd);
> +
> +       of_node_put(cpg_mstp_pd_np);
> +       return error;
>  }
> +postcore_initcall(cpg_mstp_pd_init_provider);
> --
> 2.43.0
>


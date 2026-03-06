Return-Path: <linux-pm+bounces-43852-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NXMIAL5qmmcZAEAu9opvQ
	(envelope-from <linux-pm+bounces-43852-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:55:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF4224564
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B9D319D962
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC03F0767;
	Fri,  6 Mar 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zR0CHvYe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BB3F23C5
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812059; cv=pass; b=q+B3LQaFlLpgq4PaYlLJcD/UJjIfqnJlWGZpDmU02CO1LMic6pKr3i6IFpRhWOkVXUGHn7YiTPf+j5gtuRbA7qnJ2a0x658F86QagWk1U4u4P54hE3dU/5m+buOK1uJwuMwZnBJupjuelaHIA0sPAKaGwJzXltoEYeK3x65vwIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812059; c=relaxed/simple;
	bh=aGRGwhJZcZdvpbIr5j6VxFzfRNr55VjDk3hvYSJyKU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Syem5Sf5pEaT6zwl9PdTFGK68dn6zR64JGXNhR1YneVsnYNlmj3cDhOgYeeYv9b7b+Wpb4bujEq1NBPiUEbJtYkyx+qwWk8OTv+Z2ViyllkIPmIpACP9CaQwcXi+v7snK3y+9dAnUiDOTrJZffbWMRXHJizsyErjeS0SDgCdwOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zR0CHvYe; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso380099a12.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812056; cv=none;
        d=google.com; s=arc-20240605;
        b=VQQsAVO7Rf9aRlHzgouBuDo3fKM4h8iht8YuNXDhC6k5appmf7gCWaAZrQr2qlFfii
         Yf/7DTu90OZt6Gm0uCTRFC+Ltuj5YKgNUVGfInEtMH6BJbNjXmtlxMak0X1QC6hxN3i6
         R2oufl2MpRBHqnkokCUNp6I+vPzg1M8cUmnQgDEuPRZUzKeYqaSSa9TFVqNAsdcafYMH
         NMx9pUaHKC4Am+p5/qkcVnw9ln0pzlbwy4mHqSc6r2EgyOBXUrqowFh1WrexaRvOJsXk
         xU++fXNJnIEw1C0joeGoKAVG57yFKq22GvfR4OIXP0zlHl2Mol+IjC5Ur9rsGVIeX8g7
         PSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MAibUuNCn/6BbfV0vtODnkSnkQDwc6wpTn7lzKFXoH4=;
        fh=AFax7wqvDCXSrsmjpZBTQdkiYa04Bo8z4xZ/ZTmotAY=;
        b=Ggwp2pNtXap0W5Y/9ycoGeedDqXAF679AxgMlOFvpo/3Gnf5BtPP/8Nv3BrPqbl1WU
         G7a5XkBhpDLYBt+a/kQkX+/dAynMVi5MhIXNVOD3E2yaN3OL27PggguTZylf2o3i9xZh
         zolXe6l+rpVhLxYRlP7pQCB9K+kGjXShZiXrokp2xFich2Usp8TUejp1j1lf/cOgCkMN
         rOFQ9fD9YbgWD4p11nGtJJNGsMLPWoL37GRrokn6Kihq2Od71PkOwFkEUQsnuRKL0//6
         9jJfzbjFQpJlNQJ8jMJdLkVThbKbnPqEazCwxfDg82BNYhk21jUroMGB+411O2pm5K9/
         qirg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772812056; x=1773416856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAibUuNCn/6BbfV0vtODnkSnkQDwc6wpTn7lzKFXoH4=;
        b=zR0CHvYexvnQLu907O/6P3GDvF/jlerSfL/mRoBtldgmsL+ppE/GA/rsQ+fzigz83r
         gBzaDh30p7Whm6MjE83pcufJg8t0nhhZgt2WnMisgFhTns0WRZg6fsbic0+2nuDo9cMh
         m32pa8zpM0LAsdj59p8pING3uxnDYU7lvSMkzAfYm9jtRl/eFwVi+sS8C2nIGH0n7VSM
         gJUxu0qBxS+UlJlJ2EwUKKenJ1iOkxrhM8iswc6Qa5fooFX4jdp92y+AvYbLifr1HqnQ
         dfOEU95q9fS7eOJhayHv8vTIHddwLYm6+CM5WCMzixT2CsQ+ROXd+9sB5O7MErjQJFPR
         /aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812056; x=1773416856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAibUuNCn/6BbfV0vtODnkSnkQDwc6wpTn7lzKFXoH4=;
        b=rYiVvbhBQqjc64wvyGmfQkkwRwA8FCcZbqf8J5j3tVMNYc8vXPouAmeHPQUgztZhjU
         HSU+p+2Wo/zkAl5WItPiWSg5/sMMn3RUgChfQi7qgjPwYX4gyOrrFEEuF9HgsO5azNBZ
         zVJuOTG67a+xCc8h4XLooE9pMkSxfZbz3aJfyMvTtiOYYtOmeobnV8H4dTYVd3hGhGhG
         BI148PvVrdZ/3i/9qAsSc+X+M1rcrGFe1MPaLIhHCp01qJBBPjrArV+kqgkJrjJX+M6m
         53YTxEsQCRijpYu7RL5QU9T/lD6OmfIxF8CpPZyCkMlgcQvjNbuCz4iOtuWsjkwJrde1
         /L6A==
X-Forwarded-Encrypted: i=1; AJvYcCXvA1ryOB5po3DKAGquzSDgLF0UeIHPhTJKEub61+PHpiQ2x6ONzbHrPZmaBChpGgadK86a21Efdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznplmdipwtFmqa102ZP91EVv2+HgNuiUnWS90YXw3Hlvg4EuLl
	rv0V9XJZG6AzoKEDF6S7MmmreHUK6tN9AbHFHVSL8EGXwWJr/+2uTzeOVCEKwd4fEKPm9t2u/wv
	m6sje4XUVcZl4Ndix5t5QB0z2ZCKyhTcTgX+opwMlxQ==
X-Gm-Gg: ATEYQzwB8j4usIr7veN6118N8+S0Et/tTL2ZEOE4JerK8zWYI+gUPZhvjslzn+vq0Kh
	tbF2Z25P2wMBmm6MPBA5znFuD7Ba/Np4ZaO3zRFTcXpHR54NNFVcGlnWzLyFsKt4GjYsLsMBSQc
	dTRXqnenntR3SxM6mKU0iM/tYVC8g2pbZxhDDa2r2dRisqOO6ZuwnBaroBzWy3Gu5hIsataKM2c
	zT2D2WxTzOiX5GKXQP7aBpDzrArX6qnBd5l4Lg1xqYWT8OEgO1CPGVQ2ODOsGrX25riH4DcJEDf
	2HPmOxlYhwMjx+plhbZAvI6o5kEZ2+RukJCY8dRKvA==
X-Received: by 2002:a05:6402:278d:b0:659:4295:96e with SMTP id
 4fb4d7f45d1cf-6619d45c877mr1269842a12.1.1772812056473; Fri, 06 Mar 2026
 07:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-10-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-10-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 15:47:24 +0000
X-Gm-Features: AaiRm50ckxtcAQiHBaxvyD5wpcj-AQFCGJHbC5hh7xV8KbjQj7W4u1kNphkwgtU
Message-ID: <CADrjBPr1jGX_-G0H2s8yKSNJYLawvdkYKZqQRwFhV+jy8cZWVA@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] pmdomain: samsung: implement domain-supply regulator
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CEEF4224564
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43852-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:30, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Some power domains on Exynos are fed by a regulator rail and therefore
> regulator control needs be implemented for Exynos power domains.
>
> On Google gs101, HSI0 (USB) is one example of such a power domain.
>
> While at it, add a to_exynos_pd() to avoid direct use of
> container_of() in various additional places, and update existing code
> to use it.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/pmdomain/samsung/exynos-pm-domains.c | 53 ++++++++++++++++++++++=
+++---
>  1 file changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index f59986b56213..ed7a5807555b 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -20,12 +20,15 @@
>  #include <linux/of_address.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>
>  #define EXYNOS_SMC_CMD_PREPARE_PD_ONOFF                0x82000410
>  #define EXYNOS_GET_IN_PD_DOWN                  0
>  #define EXYNOS_WAKEUP_PD_DOWN                  1
>  #define EXYNOS_RUNTIME_PM_TZPC_GROUP           2
>
> +#define to_exynos_pd(gpd) container_of_const(gpd, struct exynos_pm_domai=
n, pd)
> +
>  struct exynos_pm_domain_config {
>         /* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
>         u32 local_pwr_cfg;
> @@ -39,6 +42,7 @@ struct exynos_pm_domain_config {
>  struct exynos_pm_domain {
>         struct regmap *regmap;
>         struct device *dev;
> +       struct regulator *supply;
>         struct generic_pm_domain pd;
>         const struct exynos_pm_domain_config *cfg;
>         u32 configuration_reg;
> @@ -64,12 +68,10 @@ static int exynos_pd_access_controller_power(struct e=
xynos_pm_domain *pd,
>
>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_=
on)
>  {
> -       struct exynos_pm_domain *pd;
> +       struct exynos_pm_domain *pd =3D to_exynos_pd(domain);
>         u32 timeout, pwr;
>         int err;
>
> -       pd =3D container_of(domain, struct exynos_pm_domain, pd);
> -
>         if (!power_on) {
>                 err =3D exynos_pd_access_controller_power(pd, power_on);
>                 if (err) {
> @@ -126,14 +128,45 @@ static int exynos_pd_power(struct generic_pm_domain=
 *domain, bool power_on)
>         return err;
>  }
>
> +static int exynos_pd_regulator_enable(struct regulator *supply)
> +{
> +       return supply ? regulator_enable(supply) : 0;
> +}
> +
> +static int exynos_pd_regulator_disable(struct regulator *supply)
> +{
> +       return supply ? regulator_disable(supply) : 0;
> +}
> +
>  static int exynos_pd_power_on(struct generic_pm_domain *domain)
>  {
> -       return exynos_pd_power(domain, true);
> +       struct exynos_pm_domain *pd =3D to_exynos_pd(domain);
> +       int ret;
> +
> +       ret =3D exynos_pd_regulator_enable(pd->supply);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D exynos_pd_power(domain, true);
> +       if (ret)
> +               exynos_pd_regulator_disable(pd->supply);
> +
> +       return ret;
>  }
>
>  static int exynos_pd_power_off(struct generic_pm_domain *domain)
>  {
> -       return exynos_pd_power(domain, false);
> +       struct exynos_pm_domain *pd =3D to_exynos_pd(domain);
> +       int ret;
> +
> +       ret =3D exynos_pd_power(domain, false);
> +       if (ret)
> +               return ret;
> +
> +       /* Ignore regulator errors - the domain was disabled after all. *=
/
> +       exynos_pd_regulator_disable(pd->supply);
> +
> +       return 0;
>  }
>
>  static const struct exynos_pm_domain_config exynos4210_cfg =3D {
> @@ -283,6 +316,16 @@ static int exynos_pd_probe(struct platform_device *p=
dev)
>         if (ret)
>                 return ret;
>
> +       /* get the domain power supply if required */
> +       pd->supply =3D devm_regulator_get_optional(dev, "domain");
> +       if (IS_ERR(pd->supply)) {
> +               if (PTR_ERR(pd->supply) !=3D -ENODEV)
> +                       return dev_err_probe(dev, PTR_ERR(pd->supply),
> +                                            "failed to get domain supply=
");
> +
> +               pd->supply =3D NULL;
> +       }
> +
>         /*
>          * Some Samsung platforms with bootloaders turning on the splash-=
screen
>          * and handing it over to the kernel, requires the power-domains =
to be
>
> --
> 2.53.0.473.g4a7958ca14-goog
>


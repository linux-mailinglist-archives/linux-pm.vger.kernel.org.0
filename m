Return-Path: <linux-pm+bounces-30470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1EAFE7D0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB194E59F7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E812D8372;
	Wed,  9 Jul 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EN7jCNpm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D02D6609
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060687; cv=none; b=fKrDA0iYIjmzP+sURjhJkQDFEBpcPUHMFu0PmM1hpXB5uZOOezsxYs7V0e+clrvJXZiE7ZIYE6T7s+prTbhWsw2yDdDrYz6ihJDvE+QGfVfkz3VgxndKKdQeGFM9fxqICuItkPVeFVi54AdmAcQziNM3t1lAWK8JcfOsNa52e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060687; c=relaxed/simple;
	bh=N8QY2YLbLqwZxs7VhmrGcUAii95hVfhe2zG9GwU9b2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CERMp6FWMeCvIhemHcedjOXPbnJdviSJ1oNcd7BEVETJFjiMK+cLW6bgTIBkAk/wh22RaC9DEkZfijq5km10fRFLlFPGDHtVrrmIuSqZEB6QwjoUpMwK88CdIurPptnokDXcjlo9t6oRU7CUaCmgcgoxhkhferMoosiVSUSuiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EN7jCNpm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so3100102276.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060685; x=1752665485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDvxz8anR+BJ4sHLfVXzhIbmkKQRFf6UUA1osiYchOg=;
        b=EN7jCNpmkIWhW6NN7O6gwnZKkXTKemOAomy/L64yPJHPV3EnFX1yqI9KsR1XHxnawc
         yra7yuFEYDnxRkZMcqzk8jnWcix/jf2MxDibQKNVy7CP1oR97d3Lmch6g/KpZQPLeL0M
         2EGvqk0wHv64xqxcTHKQlRiZLt+0U7cI/e0JGTr9dkxBs6JwwYwregd0rWS+Go5QsVga
         Gqa5fby62A1KAkPl2UhNE2wMJz2BQyOdHrdlxlwJK1jyyryjcylrKUSns//xIc8le4ET
         6qYDzpo13i2DkeJJhp7/R2z9kU6vPNEu01PHCGdDbkFfIbVEtc2nySE/ri9k0udNFQSh
         x5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060685; x=1752665485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDvxz8anR+BJ4sHLfVXzhIbmkKQRFf6UUA1osiYchOg=;
        b=AsNHpbUzv84IqW/Q6KfS2zI1WrhCfQ2AZpJr/s+hCVfsmNkq4ZfUBzOL1DR0WaFIkv
         TB4LoLaL5IeXtC5snxBFEKjuv9BvbYJoORAvgtgfN+YUdbPpqfz1P2gOzDAvGABu5aCl
         ClyHEmckCPheIIEAfznZelin89DwKSjExEyTaVzn4lODuKsLiJizBNEdvLZOn6157Pq4
         62KlFbx3BB/XqYVL1wWWn8I8SvnVo1yoZojrjWJg+8j82pU2H4zgAP1gSqcmCpMbtJCG
         X6UNn2+wEoo61z6/iLi8efwI5eE1ZQeE45A/aCwo2gjR035LtQUM3mcsLVlk2LxTWwN+
         l9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWHWdAHoQX4+ahxqWGA+4+/NBmMQxNV29f3XleA26k/WVc5Md2T2iA0awuhV8Qn9DSlJZITcNNeGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwwI/Lj1iPxTN2LMJrnmtOUBBIEs5K28ru2S/Cm9vyJ1GBPrb
	ixPXQ+CaN6HBNpPMMNtahk4NtgUFbe2+zpwcIOD9FtlamPhZOxlx/oG7YsETkNbH9NfZR9Odhmn
	ue7GZKrhjPlTw0UUUItnqPAH7VDzGoSF2l1FgOEomEw==
X-Gm-Gg: ASbGnctkHRgJKOJM+YZH+tX5T+muMpRq9j9z9jij6R6ODVXutnz++IJ300zMiAZ/mWm
	ztRMyQxQK6uXG000IYnPwUorSJCbWnVmGHdM5JRlrCxXABSHRl2XNfDiAbGWYh3q4ZRHveUuIQy
	dVSFVGHRZfnZeNxorJZ/h/RUCvX8E7Y8XYICy++E5q8JPbSFZ62C8jP60=
X-Google-Smtp-Source: AGHT+IGU+pji3u6/G/drrXD9f6hzZ57lAuY7UQylTxtmRHqJxsYBUBEDT5Y4GQThZIBDfvEDAxWsUuXsGoMFEvARnXI=
X-Received: by 2002:a05:690c:6901:b0:70e:2c7f:2ed4 with SMTP id
 00721157ae682-717b13c163fmr32649447b3.0.1752060684637; Wed, 09 Jul 2025
 04:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e71abd8d75dd842690e5a11e38037bcf5feac189.1751816732.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e71abd8d75dd842690e5a11e38037bcf5feac189.1751816732.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:48 +0200
X-Gm-Features: Ac12FXwjFFHXtdaaUqyy9FfmUbPYblM-fvRv4hnhCWqr-KyPAgwmhH4mdvxEDsE
Message-ID: <CAPDyKFr2VPbQRRx6hYp4e6by1O4LvpD=WwwP2gb2KCMTB8uQGQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_data
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 17:45, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct meson_secure_pwrc_domain_data' are not modified in these drivers.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
>
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text    data     bss     dec     hex filename
>    9248     408       0    9656    25b8 drivers/pmdomain/amlogic/meson-secure-pwrc.o
>
> After:
> =====
>    text    data     bss     dec     hex filename
>    9344     304       0    9648    25b0 drivers/pmdomain/amlogic/meson-secure-pwrc.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested only
> ---
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index ff76ea36835e..e8bda60078c4 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -342,32 +342,32 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>         return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
>  }
>
> -static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
>         .domains = a1_pwrc_domains,
>         .count = ARRAY_SIZE(a1_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
>         .domains = a4_pwrc_domains,
>         .count = ARRAY_SIZE(a4_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
>         .domains = a5_pwrc_domains,
>         .count = ARRAY_SIZE(a5_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
>         .domains = c3_pwrc_domains,
>         .count = ARRAY_SIZE(c3_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
>         .domains = s4_pwrc_domains,
>         .count = ARRAY_SIZE(s4_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
>         .domains = t7_pwrc_domains,
>         .count = ARRAY_SIZE(t7_pwrc_domains),
>  };
> --
> 2.50.0
>


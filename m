Return-Path: <linux-pm+bounces-21330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87401A27493
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2031640B5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DA2139CE;
	Tue,  4 Feb 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7oYfX31"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A02135D7
	for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680075; cv=none; b=MbP32ACasvtgkyE9mPVWZSVIajTsrW95FQBEO2zjZ8hoPTWi7J8tk97Gz3uIqGkFIq1Uqa8dYw4qA0cWp4kHpFWXMsUWf1C/Juo+YC+vrv7LB7Aq/VzLC7plDA1teoCe8DuQkUarEGc0Sr3msXJJSwVa7nIlvKYRJCNXvarXfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680075; c=relaxed/simple;
	bh=91N+LRtBj3itj2ylbUHtfZjyPuwCyXJA3tx1li28bLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icRi5foq1VKiKm8MI+zytYXByi2CZH31hZ/pMHZAmQ7b/4TPRcE11QdrJscNBu3pqAutPQAdPCfB7rVJ1N/K32kQj7YAGhz04cTjXE/g+aMxTOdTLcWb9fNlXNAnfrgPQtG+K3rnpVKSzl3muBGhx0etIvD/1cU7ITVlJ/1g2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n7oYfX31; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5b225b1df4so69384276.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 06:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738680072; x=1739284872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ew4DOVhQnp3KVlv6Z+adbVElEmJww+rFIUASaWfJwLQ=;
        b=n7oYfX31A/NH3eQ20R13JOYxzT/yquVu6Utu0u1J1D4nD4dynrH27xyievqj4mQ8W5
         EBBr64jt0d/klDXCI90CNM5Kt27AdRCPSosiiybsPjIPU/wn1Ol7ycGMGyJdvky5HTbX
         rjLz3CaA7sNqL9Cztnc6Jvd2l7dH3zNadnk2qoEdKMXsFCPQvVex6pL/j+EYpPalTGFk
         dfN0Pe/RODqy81J2k9QncRqF5DLBuUzNDq1X+CKZvdXi55jwT92ni1ShmQvKthBDkQ43
         Dm7a4jjMlC+KqVbd2WhbmPo3cSDjgDQa6Zh2crYqaNQBAL8P+lPYfs9UeQjie27tkvJz
         EYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680072; x=1739284872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ew4DOVhQnp3KVlv6Z+adbVElEmJww+rFIUASaWfJwLQ=;
        b=nqeJOc41n6SzuKavThj6rFPQvWi3G4hvUzF3Ur0bueDNaunucedfpf/NzG6IYjMnY8
         LW6VUSKs95sZDdVzv9PRXiLLJmPGQo/9Mvrz4WphPvYsA/LNQZse0wbX/f3J1gVNt8+l
         5MY4HkOHAxDQ2w94Sdx1wFqlKIMF92vtj4asup1gwnwrpxLnYkHYiDRttM3QO39Vwn1U
         5BjmGLj8gXQ4kQ6XEoelrARWhUYYOaPuMkqTGRd1vSGeGx158XgVrRv0vkn4+DLmp5ln
         nIrfLhsC3GbdRwL2QOwEPuckUMbJth86mSr2zUGTLXr1m6ytBECR7ShExZJM7VrEzlgi
         rD2g==
X-Forwarded-Encrypted: i=1; AJvYcCVSSC0xiTpGI0muyzj1f6XeExVaQKQItEfbXaojS3pkdl1r4nnqVo74QEVuupT3qJylEGK4FpaEiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pqixHF46RCu3EOgQrYy+6m7FWOWipnD4uS3nglRgSTlqQW6b
	kciHWIxwbZtXicoboxahr4sDHySy7IpyKSi3SMieShmRqyDI0B+pXPE6fgPQtuRV4bQKvSIgUMX
	Mwsirm8gw55e/OgCZkaIWwOL8O7Y42jm9A955Ci/gx6/5H6P9
X-Gm-Gg: ASbGncvnSVrR9a1jdtsEJNKflvwe2M6VfvW5gOLJ8q7ME08u2B321luIAiuAD5EZoCX
	X8R9fnDoykWH0g6pfXEFP31fMy9hfn6XUd01gGgCms6NowTVzxYXgRVh9QGbRKZnZ76wnRiS2zw
	==
X-Google-Smtp-Source: AGHT+IFB7VsIcSnlCga8NeUStj+nz7dcGdSq8KdqrAerawmVjHxlGaQ1qu1pYWqjA4/tsyCajzkdoxica/UvVlxL0Zk=
X-Received: by 2002:a05:6902:e05:b0:e5b:1034:909 with SMTP id
 3f1490d57ef6-e5b10340af8mr5144143276.29.1738680071774; Tue, 04 Feb 2025
 06:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <accb12bd6d048d95bd1feea07dd1a799ad3f8b31.1737532423.git.geert+renesas@glider.be>
In-Reply-To: <accb12bd6d048d95bd1feea07dd1a799ad3f8b31.1737532423.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Feb 2025 15:40:35 +0100
X-Gm-Features: AWEUYZk6NgieIWPfpkG1IfqaDakdkwS41m6bUoTtDOf9y7ZpOmY6vlu_-K7SU_E
Message-ID: <CAPDyKFrOa4hqGkwqGN9BwW0w2QP8S17EO6mSrQHqx+LLprkFxg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti: Use of_property_present() for non-boolean properties
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 08:56, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On BeagleBone Black:
>
>     OF: /ocp: Read of boolean property 'clocks' with a value.
>     OF: /ocp/interconnect@44c00000: Read of boolean property 'clocks' with a value.
>     OF: /ocp/interconnect@48000000: Read of boolean property 'clocks' with a value.
>     OF: /ocp/interconnect@4a000000: Read of boolean property 'clocks' with a value.
>
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Seen since commit c141ecc3cecd7647 ("of: Warn when
> of_property_read_bool() is used on non-boolean properties") in
> dt-rh/for-next.
> ---
>  drivers/pmdomain/ti/omap_prm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
> index b8ceb3c2b81c2510..79d165331d8c6379 100644
> --- a/drivers/pmdomain/ti/omap_prm.c
> +++ b/drivers/pmdomain/ti/omap_prm.c
> @@ -613,7 +613,7 @@ static int omap_prm_domain_attach_clock(struct device *dev,
>         if (!of_device_is_compatible(np, "simple-pm-bus"))
>                 return 0;
>
> -       if (!of_property_read_bool(np, "clocks"))
> +       if (!of_property_present(np, "clocks"))
>                 return 0;
>
>         error = pm_clk_create(dev);
> --
> 2.43.0
>


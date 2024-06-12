Return-Path: <linux-pm+bounces-9021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E560905690
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C282861A9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6575180A69;
	Wed, 12 Jun 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZAEus65"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E214A17F4F5
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205158; cv=none; b=JZBWkjdxYLKIO3ATnAE2o62zholUvCrgPKs9pncyaO+R7s4G0qyJW0oezCjO3AgBVR86EKtDxKSzt07cPdJU7QOMtJE00GSTzsDSTLiUvEJNlatgWPp8NlbafLlr+ljzo5f2PbroQ5711hjikiwcY68qozoBZ6iXI5kYbP9W2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205158; c=relaxed/simple;
	bh=UfKYU+FaEaDhlgVIlRO+d4NHVy0mPvtEYjAmluIP2c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBdQ553vNRmC+JcgtDQwrPuSk9IQIUwboEMvlOTmircq9IReFWhvS/Kr1ai62fxuEaAnvYlqly4lZxmhTxfjDMplnTIcrE4NYHxy3N1zKcVJp9Ex8mOzrbSvowvUlxNGIo5MK7yE+LcYVR6XoCeqFg/Ek+8QIx5O7sk9ac92sZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZAEus65; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef7b13c98so397746276.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718205156; x=1718809956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui0asLPnRQrSAoLGngUgtvhcpdpuHV+OvoZ2KNM3Fig=;
        b=AZAEus65lFwXLSuDD7pvNBIR6lQmCU0QWOCq5Mb3lBOqD6hWB8qUxOKsp0Plc6YleJ
         O1iA38wyo2Qit0rf/jPen7iLSbeMQnMbwEMYP6g/M16fRCqegSun+WBX4IeucxzUfYWk
         CZ5qSfbLIKrLWSzVn9n6xf/NwGWELQJrWMQ5dG0E3DisOX0YkdXSPP0Pdzsc9hT5oREe
         +72RdbxtYILqDqV0NLWuZi2yaqA4cJIulb43SP8nadcmtACHGQbnSkx3FsCzBzj7sPKX
         PQt/VE3CXQpACCxgrfynk4GTzrY8NcfgufMPKvisClqJwmGPFBkM4fqXSMAjywazb0cN
         pt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205156; x=1718809956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui0asLPnRQrSAoLGngUgtvhcpdpuHV+OvoZ2KNM3Fig=;
        b=izxJNxc7/9TFmmmpClxbEDxadURHGbWQun0FOY+l7uN81r1eYjuqumNR+BxuDoqPIt
         2+vNMJ4L74toIWsOnpy6O+YTZELXowO5CnR0NVxTC5dE7tRckK3sfY0kV7EbMviXARZL
         p1F5zPelc9kVGcv7geKZjMQzhPPqbhbmJ7d4Q0rR2Mq3VFFtEN99GUBB8e9vOg+pxBlT
         8ZAxVh4uVK3zBs+gTsV1pETRrM4WGcg5yIIt3joaUcy8+AM60N6S4H9s992CuhPFshEX
         j7/dUTxMpBiXBUjhk2VsLCPlQbDqtm3Zxb110p5lX0EBxTsPRjt2wyFz61veWdGKi06l
         xvpg==
X-Forwarded-Encrypted: i=1; AJvYcCXqiTVVUJ0GCVL6Z5lB/nFXgfB1Ijov41/5KlacdNWqiX0OwVhIrKW27cBNk2xBtwzuMgtWpF1ZE7HnMAar49VHCEc7N7iSpxk=
X-Gm-Message-State: AOJu0Ywl6tEZcCKt/RpldXN0lrGahj73zKDC5gkyDbFD+w6jtNyLr00a
	bF2oZ9vGYSsTrpiD/ZJShxLsDQ/REctE48suqUgf5O0Uxq06a8A1vI2t3DoSlDNxGPxQSkfKspS
	59tPwY9VzZNkpw6eXXi2lm/wqfmLT+olNMdFHlw==
X-Google-Smtp-Source: AGHT+IFWoi12CdmKen6XCavHsYiaGeZ6uNOT7Y113dWDJBAN7YMJe+nUPHOOTDfX1o7vHsPrrRKwh1FWKxulzT69BGo=
X-Received: by 2002:a25:6a45:0:b0:dfb:538:df1d with SMTP id
 3f1490d57ef6-dfe6852d794mr1893187276.43.1718205155725; Wed, 12 Jun 2024
 08:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610-md-drivers-pmdomain-amlogic-v1-1-b49ddb1a8bdf@quicinc.com>
In-Reply-To: <20240610-md-drivers-pmdomain-amlogic-v1-1-b49ddb1a8bdf@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Jun 2024 17:11:59 +0200
Message-ID: <CAPDyKFpJdOGq7VneJfaodo2Jc1jc8pfnoNxCdRW5+T0ofdabtg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 01:13, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/amlogic/meson-ee-pwrc.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
>
> This includes meson-secure-pwrc.c which, although it did not produce a
> warning with the x86 allmodconfig configuration, may cause this
> warning with other configurations where CONFIG_MESON_SM is enabled.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/amlogic/meson-ee-pwrc.c     | 1 +
>  drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c | 1 +
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> index fcec6eb610e4..fbb2b4103930 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -648,4 +648,5 @@ static struct platform_driver meson_ee_pwrc_driver = {
>         },
>  };
>  module_platform_driver(meson_ee_pwrc_driver);
> +MODULE_DESCRIPTION("Amlogic Meson Everything-Else Power Domains driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
> index 33df520eab95..6028e91664a4 100644
> --- a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
> +++ b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
> @@ -376,4 +376,5 @@ static struct platform_driver meson_gx_pwrc_vpu_driver = {
>         },
>  };
>  module_platform_driver(meson_gx_pwrc_vpu_driver);
> +MODULE_DESCRIPTION("Amlogic Meson GX Power Domains driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index 4d5bda0d60fc..b50e5678abe3 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -355,4 +355,5 @@ static struct platform_driver meson_secure_pwrc_driver = {
>         },
>  };
>  module_platform_driver(meson_secure_pwrc_driver);
> +MODULE_DESCRIPTION("Amlogic Meson Secure Power Domains driver");
>  MODULE_LICENSE("Dual MIT/GPL");
>
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-pmdomain-amlogic-f117930600ea
>


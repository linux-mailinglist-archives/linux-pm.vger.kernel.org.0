Return-Path: <linux-pm+bounces-30453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9AAFE715
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A8817DC73
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9A28DF1D;
	Wed,  9 Jul 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpBQ2m7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E828DB48
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059401; cv=none; b=tc2vNAxrNdyzgFAo7L+jRPoBSI9scEGRgaPBbStUu9N3fgqOaoRMbuVLy7vas9ZSjWsHgbR0qQ1WiLuhDVmEoHQNjV+lJwTe0F8vkwg1S+fzUuXjawElml6bvdcFm3LcCgYUKd80CTJ9z2lphKlTFzSogGp1P9UoEP/Sclr9FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059401; c=relaxed/simple;
	bh=e9Hitx/AaABUc9wSWNOxzRx5igfO7v0kpeqQjepU+tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb8DYHpc1+m9PvI4dqD7oHroZWzV216v2lp8Hx6NCFQC7gPeloThLWn40O+PNesvR7NxpXpac6CMcKdfQnTEMdREdavouVRj4ppRtDJKXCdUaN24ER1SNfGPcHtzg8ct3o6HNLmH/302coIHu2hpCVLjeCjfQi5VRzRICLTGKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MpBQ2m7i; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70f862dbeaeso50954877b3.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752059397; x=1752664197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuabvlF+HEOtpGNRTV/JqdfGljf8eHAq+QOlPtUiPrY=;
        b=MpBQ2m7iVPHdvkHCor7hGjPOf9l9yLdd90G7u3tOzv+p8jdFqNoUR0lH+tH7WrtT0H
         HjIZV+kJY/ABxZ09vH4E1ZmIg4WUdMlTmzyTc7pTbwLvvV/eILF2GJbbOsYQIOzQFDKB
         6SygfX+I0KXOExkbaO13XRl2yiwbP+NGoY7mPdFUNS5yYimrsl9ck9qePpZlnss4igP8
         seCGjE5mgW4iJ572tBReLNhiq2tCaj29BY+OUuwXR6S6OBvR884mh1JHnnl97nT0+/UG
         QYSYcbXDQjXwuo+GXvsFiqdKEXc6ofS9JemdN5WrfNg3gHk5689z5fhhR0VOU3PbEDRT
         X7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059397; x=1752664197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuabvlF+HEOtpGNRTV/JqdfGljf8eHAq+QOlPtUiPrY=;
        b=Tk58Z1ZyoWiIidIuiH0hao1I6TTwizZsdtAbjziBa4mw/asMzpX2HIthyde4tA6TWF
         Lu//tDLHZQ/Veg7mVVW/uEnX31KqIXF87klfaTi1U3TN6iYIwYmuf20wW6JSKsAXxME+
         pwjYCQpWB0pXiNZ1v7wAONwqSVtOGYA5deB272sDETMmWpxtFLCp2EtCn6BD2foz/vqB
         LNmTNmSpOY04AhkOmMVo4kah2s9M7tkTsa15O60s7fK6n9FbV8ujq6FWPvUDlEcdVU2c
         cEdoaztqI8r/gUBZZ1DLqexcQ7uEZW3lJEcbqxcTRQPEAx4gGa7kVKpXwTu1kq9TzkwZ
         SD5A==
X-Forwarded-Encrypted: i=1; AJvYcCUx++rYiVsXYqtIWDZOwpKTeH6VzK9FEVYP1MRAJa4E58VYIl7UFeUsH+aYARsi7PPAMIUgbCKkYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9fZ8jw6RMOGmD2Vu306TnIvHkRTxat68FL/PHzCYlN7NMXAI
	23hEq12MDmK6qAZImnQhtjr/PUTKmLDza5OqAJeIt8Det+7Hw7iudu6ORN/OBnKF+VtE4qkvVOz
	iKILBVQXCHSVmM98ZQs3PpgVmOgdLwmYwGP4lmh7wNg==
X-Gm-Gg: ASbGncsq47qnADJ/5LhsyTV0SmRo+VyQvMzqvKTDleG/AnRe0V3DdNAUItzV0oiF1Mx
	IAVPSRLwf3CO8tyJS8rAhEBu9YoOUAKNlIqlQXgkpoRgZFfn/l/nyQuPEpSdPAXORHNIrqXJEE7
	zewk14qaJ8p4s3hbmUZHUHhcJxVYoMeQg4i9QNdefqj4Zb
X-Google-Smtp-Source: AGHT+IFsmTgSEvZesdYQYcydeG0/O1Hj58Hv2o9yJbhCercvOyzKlY94jJgNF6EOqwOuKT73wkIxTQ5VclXQ3n/n+tQ=
X-Received: by 2002:a05:690c:6e02:b0:70c:d256:e7fc with SMTP id
 00721157ae682-717b1c37983mr29095877b3.21.1752059397067; Wed, 09 Jul 2025
 04:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
In-Reply-To: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:09:21 +0200
X-Gm-Features: Ac12FXy4yNHd8YRyFcLOsAx6a604HDoqyG-G_1hY2N2OnXQWEmVA7BZrsriQrbk
Message-ID: <CAPDyKFpdZGa0nT1V7fkOv-RuNPDz_xNJk-+Ex+NzyMF4Lp=peQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti: Select PM_GENERIC_DOMAINS
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: vigneshr@ti.com, nm@ti.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vishalm@ti.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 11:08, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
> it is always enabled when TI_SCI_PM_DOMAINS is selected. This
> simplifies the configuration process and prevents build errors
> if PM_GENERIC_DOMAINS is not explicitly enabled.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/pmdomain/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> index 67c608bf7ed0..35a4c73da17a 100644
> --- a/drivers/pmdomain/ti/Kconfig
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -10,7 +10,7 @@ if SOC_TI
>  config TI_SCI_PM_DOMAINS
>         tristate "TI SCI PM Domains Driver"
>         depends on TI_SCI_PROTOCOL
> -       depends on PM_GENERIC_DOMAINS
> +       select PM_GENERIC_DOMAINS

You need an "if PM" too here. So:

select PM_GENERIC_DOMAINS if PM

>         help
>           Generic power domain implementation for TI device implementing
>           the TI SCI protocol.
>
> ---
> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
> change-id: 20250704-depspmdomain-2c584745dca8
>
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>
>

Kind regards
Uffe


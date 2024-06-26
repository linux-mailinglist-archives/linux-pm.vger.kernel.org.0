Return-Path: <linux-pm+bounces-10036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33993917E57
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25A8289DDE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349F22083;
	Wed, 26 Jun 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHbB149Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D11662F2
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398408; cv=none; b=bdTT6NcuegKX/wkcVr061iFFEzdPDneikvKO7cT0wDEH34TGLUVkHRit3fj0XcLF7GfLn8k+7OzbiwxPUJlV1RIO4pABL2ou/dSWf/DWZ0BqWHPcFT+dLxfQVyS+r6J98kOWvgkowQWMAidVG5oPiMXnuPM7ACOHNUQ4W7YT3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398408; c=relaxed/simple;
	bh=SOiuO5Fl6G+i9DWSRv/mCUh3g+3xRS6CNTyybI7Wnk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lulWLd3wIbGl7o5WtyWK/EikibXVBWTrbqiTVOzh+q+K1EHlN/SHMaROsZQ/DKC5jY3unNFrhCNMJIQrGE5WygPFcQyfR5NJJKlwUZpYmvEwReyW05SFSPmu1X/A83xCkaUhFOOcptNNgmd+vRnkR+uqkn+6Cg0YKwKTh3fhjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHbB149Y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ce6c93103so3891744e87.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398405; x=1720003205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOiuO5Fl6G+i9DWSRv/mCUh3g+3xRS6CNTyybI7Wnk0=;
        b=CHbB149YYvQ7hirS3x2iF+a7DrarXRo2d5iyB+wht7QLHKm+HImw/GaB6ZTMwb9c1f
         GsI+MSiU528QPHm/m27BBrXefq6Xd3j42G16ntw0l1L5AUlLmgUD4c9/ohnVIvIbMwM5
         7wspgKLxz4A0hpwHlk2BkqE0X0VWDG3+BgdxNf/89T7tBvOCwkLN7gsxkcCajta8XA2S
         +G1KxHMKbO9LZjh+xA1Tx7xnloWQK/0cUVhsyaPGNyjVkfx9xH3QBqYviY7YPagr83fQ
         Rxc6LcXzpxQXbEvqiUMxNdBbw8V18MjA1wTxGt/95RTWMg0OMQRzigOOlHdx96UJcl3Y
         DH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398405; x=1720003205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOiuO5Fl6G+i9DWSRv/mCUh3g+3xRS6CNTyybI7Wnk0=;
        b=TzXSjl37hNwa9OvmIbUyy9lGDGuBKnz9F6ETjhO+61JXhMs25r6GPR/j1Ul8hefsay
         cyLI7wuqdExEtcdB2MdDD78Z+8TiN/yGJveA7xl3P4F4VwoiQ0LtXxWWWKXjREd2T2P3
         DPLLmHoXIXLPmlWyjneA0boCGq5HqY70djJ92K51Wv3rBL4MgmOxf4xAE88dZAdj8BCp
         d+Torh6bZo0IbzYiG7XSmHpjT5Un1jmjSJY8ZrU/knlVW2YdOHaImKSWONvflQQ0f2ym
         EAt0j7tjDg1XrOJ0Qu8xzsa0R9lQo1Zs/PnyTBvkI2KdXf4KgHx6JuMSGaxdUAleemfC
         xRMA==
X-Forwarded-Encrypted: i=1; AJvYcCW7hkDKOSWb3KIet24uRa2Gl5QVUwTeIVYIB8YRwngq/exxbeqBaa/9FK3Q6WHMYVgMaRkEdlantWCr+Zyx1JvWkv7gbpIY5A8=
X-Gm-Message-State: AOJu0YxZeE+gCBMLHGkCqPuT3MIYChofzvG3MfRUbft+C9/RbDweRFuf
	DxXK65maBTdS4boc6SorO2YscYE8HJqLK8UYa9y0XuD3f4vkz5uXD9jAIrKO4TlGnRrQuLHcTNN
	v+sRq3fl6DvwToqM3ZeTKVwx2FYVLb+PEOG1aSw==
X-Google-Smtp-Source: AGHT+IEEDLlgKkyLEHb/F4ksXcKqwRKo5110z2q983p4MDz3/i+AYm+GBB6HLyfL9Ci6xvmQwPbQLu94NT1EQjQELFc=
X-Received: by 2002:a05:6512:110f:b0:52c:df8e:a367 with SMTP id
 2adb3069b0e04-52cf4dafc54mr2880823e87.53.1719398405223; Wed, 26 Jun 2024
 03:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr> <e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:39:54 +0200
Message-ID: <CACRpkdYZfNyekcwo35Ccne7VaEhX+Oeg314piZP23piD+yxLWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] power: supply: ab8500: Clean some error messages
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: sre@kernel.org, jic23@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 9:05=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> There is an useless extra comma at the end of some error messages, remove
> them.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


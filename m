Return-Path: <linux-pm+bounces-31089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A284B0B0B5
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 17:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9D13AF335
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C742877E2;
	Sat, 19 Jul 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebKgJs54"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1B264A84
	for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939728; cv=none; b=Op8e9290sjbTZMysH3lBGSTCFJcBqvKYUjmv4bCvbcl7GEb7xDRw139FswGEkdZ89RQrHXrd+ougqpXgHFFoox1KXW2F8bWm9uipDR6RDNFbfTgJwNRvSE1xnsq1fvkqLy6ExrnqIGeWlvXN9fQRZlk5JtT0WD9MzYF9enV+YdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939728; c=relaxed/simple;
	bh=rn1nnfWM5bSta9/PZz3/I1BzLdbB7ZlLj09o7IEgKVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBcezFNxUnNNKQd0PADPpPLkHK2kVDGUzHoczPSrdPDCwD/lWaPiGS2M0Tcuz4z0DfSV39px2US3mM6eMIuBMe5DoBTqihUKtbVYBqVhy+MCfbaaGSn4pfreALyxSRDzPVvy305AEbFRJHbCyYBeUg5dsP3dlUVkgIUepg5FYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ebKgJs54; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so27110851fa.0
        for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752939725; x=1753544525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn1nnfWM5bSta9/PZz3/I1BzLdbB7ZlLj09o7IEgKVU=;
        b=ebKgJs54pJ2fab+5VlnaUg/5Bojl+h+Q1zvBui86qYGWpEGMsYNCC/f+LESEA9uhM9
         4ebh1vYN47hGuPGSYW0cydgVvchSD/ceo6AuKz2aNeevZFGQzqst1lL5Zh2BFZTIBWAA
         jiflfmk91dvsQrILf7YPxK+tVeNXx7pQh5tPrRVhYulTUcFkQbhJ6nhTETNEE6WNs00e
         ArEHPYsaobCpOHISSlGjOfQQbIsK5x2w1cl0CyuiYt8iA1gUY6WzxaYqEVVqU1A6dSsQ
         pIiVypiiB8DadSHRO53FaKDf0wEymKRk5VbK5sAYXcYy/V9cIw7FDLkQk64DMkNqNmlU
         32nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752939725; x=1753544525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn1nnfWM5bSta9/PZz3/I1BzLdbB7ZlLj09o7IEgKVU=;
        b=BGZRkZ2xEoXTbJd0bjpZLQtPctYQUo7V/TVY1uZZGN0RAmdxJlrjlq3M6Pj8jhQ+8j
         WI3F0nqwZi1Ip/+u48oB+FbrTF4hpbN8DooEntkUmPfjVYYpDvF0M5DtRHdHfvSxNOLj
         nxcQCkiqXmktedOsvYlIiXFzSkHRjcNwdQ4rjYJKpdHYbbgxGaXCxCP5xyX+KRbQFPfj
         k12uOHM/UZxrxDQy86WSsYCHrFCXdES708J1PPAGkZOhGwDfP0EJlzbvSCP3TDH3Rw9D
         K8zeAYmJuJmKaBneQ4TUei9DI5lJ2ZF3HYMdWQjfdyyYM3C0O7dWUuGB58BiZJk087vI
         LMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVowi2FU1ahVO7OOJ55EyKySBWIHxnqz40TnXU6M3J3HLviuS2PSquUn0A8UG5KkWFrVFRo2MFPkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ81NJAx9PsqMXLz6SFFOfeevXVjX1ryBNmgBlXCzM57y8K+Ly
	6l3QqBzTduCROzGNn0Azwoi/GnFnGpzVNkMat7d5Ljp15BfbmvpiQ0AO/mMRK5iB/CcHNyRfztm
	whB11f8meTjFd5W6wvq3+BNrBWB+yECsuwq6UkSpWZA==
X-Gm-Gg: ASbGncsd1Sk8ohNTJvQ19stwgAx7G/FSSykn7dM3BFadcKm38lCGpsPv1lyQMAdCV2D
	ehXsrsjtqDQu+Shkxlm0l7RlkdaEiso4Z/8GFnpuGoOkNN0PnzViIYnf8+jXQyVanKNw5+nOF82
	e79vQKqRtWEFy8rIZovOfL2EbzW5q3jYHeKtwYzF2dYl6yZ4TKqFdNk5jaZObPHO2+Xq+J5h1MX
	4fiMqo=
X-Google-Smtp-Source: AGHT+IHz0AgUzYYyokGlt/TZ09DPKHJYVrOty6k/FTgVY5vV1r1KxHh9aV72LWBbI4MCzMrbevh/6hzgi1HVNc+Usj4=
X-Received: by 2002:a05:651c:54d:b0:32a:864a:46eb with SMTP id
 38308e7fff4ca-3308f2b7638mr46687401fa.0.1752939725118; Sat, 19 Jul 2025
 08:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-6-556cafd771d3@kernel.org> <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
In-Reply-To: <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Jul 2025 17:41:54 +0200
X-Gm-Features: Ac12FXwAlxaX4ocIXQ1MhtIhdmA9pd8x_pk-4cH3CUUGhFSCjbZy3REqIbEaUb0
Message-ID: <CACRpkdZdz7eHVjgX-X_UwjJ_qSu5hSPeocuQ9DWSiyjNLU5AmA@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] gpio: Add new gpio-macsmc driver for Apple Macs
To: Sven Peter <sven@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Hector Martin <marcan@marcan.st>, 
	Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, linux-pm@vger.kernel.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Conor Dooley <conor+dt@kernel.org>, 
	Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 2:59=E2=80=AFPM Sven Peter <sven@kernel.org> wrote:

> top posting on purpose: are you fine if Lee takes this commit with the
> rest through his mfd tree?

Bartosz should answer this since he's dealing with the merge
window for GPIO, but generally it's fine, and it's even using
.set_rv.

Yours,
Linus Walleij


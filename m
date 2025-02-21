Return-Path: <linux-pm+bounces-22644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A418A3F58B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9262217ACDA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A4E20DD63;
	Fri, 21 Feb 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ocs8BcLD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAE20C489
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143199; cv=none; b=TyPRQTMCFDgfn5LHZs6XHE+4cAIKzn8Jh5Cj43O0AIUmjTcECsXV5EIyG0SZVVcu5K7EgBQ+DMa58Z/I2gsmRfM0Gd4h0Ocj55RxT+GLgd9pxMwiS0IruMWLK9xa4kg24if5tMc01aqwtt4EniMFAQLq5Tm3jZZQH9LEizMxwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143199; c=relaxed/simple;
	bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNfWIUuEdK9Ey051eXLnM1iYHmlZ4wFwKvm5PYkn6IHnneBUyhLEOLZKeSsKzOCh2CPed/6Iu7Wznu4doXVkdjb1gYueCZQ0TUTN0Uxc4MhjG7mLkRXe8vBr5ugy2OxGQlZH9jLplTq9HpG6qlG3Gp1kHsMLroQWTQoClYPInWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ocs8BcLD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-545316f80beso1920274e87.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740143195; x=1740747995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
        b=ocs8BcLDVX0cFE4GS7mdtoyTmdq7ov0aDknHxHtvq9pyWd+CzzxiSTj0LDGbCb+O2y
         IjEppM3n5enmNQpEeHa2spfrTWNe6L51o8MBwFqRm2r5bp6uWo7nIwTSxWFeEZVKb06j
         qBZWHdVKsdcaIx5WmsjZknBd+np0SH4ChBYDnpyBg9iRPhRhLgTs1mrUMTVrlzJ3HaWQ
         qlOaX5DLH3FRuWJpD9RL+PkuyZrD+QMVkTrFaJxVMC365ur2kVbzf11ksEdOkjVm10Hd
         zdx8/zMhfRIvLwT74dGk5Szikj2e9IoTiLl9yVtNpAq9mkf0Kn1BZLOF2OjzqzG1D3z8
         3mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143195; x=1740747995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
        b=wx4rbbksykjLvfAUTkhJhW4ZGWtiouG3fmrrlsfNUv6k0ddmhhkbS4pnLiQAXln3Ws
         9akcl6aagpRLkE62pExlo/J4W5hretKBIaohrK+nc/rtD7dS6B0537vW6Nb5pyWmV8j7
         Qfk+m5WyGnFnwFqznYXY6AkdXrYV4uZijnfma/ZHoNINUYxgd46JWjvaaO4eSvefIyhv
         4FRZORuulAEFajm3VgU7TS3cEwxLyBGZvBBm3oRW8Bme8arrErl36zC9zg7R3tY3OLZ/
         O+WPDQW221OKGPTi+HVpRptgoujAP0Y6tP3JW1J9kGUbQqHUOHBi7v7reYxD2PoqzymH
         XLPA==
X-Forwarded-Encrypted: i=1; AJvYcCWtTz1iAxIH4Qi/VnoViwGt3P5Q5EH/ZKzLbLHfAO6vKI3+lFwQCJ9/kBzH/eXDG/0V1Y6efmKesA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqwkMzdz8D3h7Q/98ATgqzZ2N1kT5taWh/k/CubYxB8g7mmgy
	HegVstKBuy31xo70G45xMBdhFDNsEFi22r6DjG+uXM/JBsK/7TKQI5t9yYmUsa5tOVNASGM0UVt
	aO9mePEx6m839zc/e3jQ4Yh/SE48jvoFt9OjTZA==
X-Gm-Gg: ASbGnctjbsBZeqY6rTw71zcri2pBZt9NbHbdU7Zf3gnHMXWYXCiNzmH6H1V/jWSASZs
	h8qAjVTcTEOSgBDbKhVN2rJKmwXOi+f7RRGdXM8A6WDXu7yZPusbIrf9OGuWkEA9UfRFJmBjjCg
	Quj2Io1owRHlS+Sp32Z5OZGZRUW4Ta4eN7gd87hxc=
X-Google-Smtp-Source: AGHT+IGvF+qVoZb/YNG1V1s6uhLH0tipo14kcVPCZjvopoT6AHOJ53n961FIS1cHHYi7UkY/30eVAcyuJ5RU22yTz1g=
X-Received: by 2002:a05:6512:230a:b0:545:17b:3cf9 with SMTP id
 2adb3069b0e04-54838f5c910mr1152614e87.48.1740143195091; Fri, 21 Feb 2025
 05:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Feb 2025 14:06:23 +0100
X-Gm-Features: AWEUYZkXE5OFXjjPS11KVvHprrUdePtYS343T04IUIfa13H27L0Aw2Tb2OnslNQ
Message-ID: <CAMRc=McG2xLUcE_yHq4MiFnm665riHHuHjk0GJE4cFV_gGU90Q@mail.gmail.com>
Subject: Re: [PATCH *-next 13/18] gpiolib: Remove needless return in two void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:02=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Remove needless 'return' in the following void APIs:
>
> gpio_set_value_cansleep()
> gpio_set_value()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

That would normally make sense but we're getting that reworked[1] in
this very cycle so please drop this patch from your series.

Bart

[1] https://lore.kernel.org/linux-gpio/20250220-gpio-set-retval-v2-0-bc4cfd=
38dae3@linaro.org/


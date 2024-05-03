Return-Path: <linux-pm+bounces-7464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF7B8BA5C3
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 05:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF5A281B1E
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 03:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B81C6BD;
	Fri,  3 May 2024 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGOe/lNT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3757C97;
	Fri,  3 May 2024 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714707822; cv=none; b=uE0PDisEyi1fCpVwFsRlJEUPTWZypnrG38Fwxut5bG7MMUWgvyTl/+6F+HQvQ4JZmBkrYEn3bFY3QJDjDZJU2++QCJ5Ks7ijTGt/s2IDWgNLOvl65tvq9sBx231rhrPhzHmfN8OwD+LmLiLbz9szmxsPspBBFcL6tQv1Zycd69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714707822; c=relaxed/simple;
	bh=V7eIXOqNmFLhC3i47yFjLR/ilzBMxYpgsSuG6dfy+Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NT8iYeWJw8V3+CtoKUUCeqCXS/+CvP1UMLtFRrm3kuNo6lpvCwmXpESUB/56ZMysOZWl5cCnvGUR00y+zEmjg1S2BEAP26YoxuGi/qHC5ZSc7KH551IOHeR+8x/asKteLkoShTbrmRI4g6imwmMqDBqNfJHk4Fsmc1u8GlD9GyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGOe/lNT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso21182141fa.0;
        Thu, 02 May 2024 20:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714707819; x=1715312619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ5TWg7WC9En7ODeglID0r5NltyGrfGwjugkScoq5sk=;
        b=nGOe/lNTHdouy4xXhL8lDxKeJsyn9K9BiT7w1M6L/TOvCNQfYf0+E3vPlFQcr6Iyw3
         TdL3UOOZ4Z0V2yeFSLwVe/MBfSGIh0dnxYszzcyLGN92/zoV3DxrCVee/PEX+nsK34wr
         SEm4Q1U2l8LwsXD98KimO+q9JRKN06QSmSyDEYdBHMIA6AUWA13Tw4zx7/kO9M5TEGQV
         dRR4TOClPySbzoUy5C5c/4Zx7pu+LH38+fBsYhk7FsZVtWVMiHD4hYe8hlhc4B/7uf9u
         4P5UdbnOMj50wyg2RZFrhO6Z4QueqeRmGXXp4Ov/cPo+Y8gKi0qAEaW1BXKFXxZVgtDe
         lQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714707819; x=1715312619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ5TWg7WC9En7ODeglID0r5NltyGrfGwjugkScoq5sk=;
        b=f1BDWRBI9PWXiSFBHJK9fX330bXf2CfYcJ3mip+nN7yGUhqlBu2FKY2th07uffJjTM
         iITQckTdNYyCLo7/ocVq13asUqibDEVX7RkBeB8/bFvdBl2nB5bouIobGCm8VNpVn7+Y
         B6wcsq5DApO3E/Gc2gYfFQpmNkYkl9XDYKg9icxW3xpUJfFXMa77bLRhxMmzOuvLrVy6
         DoHLOS1bbAJ3NPPqDBLCsSfDfty+cvgmHj+B3qLqncdqbMshVPqGuzlGMU0XuH665ww5
         ztgzZQHXAfRH3nzYWMHSjmA1LfmCYcgvL2TytgeaZ3MLNLxpAB8wB9INiFHolxUf2Sf/
         iK6w==
X-Forwarded-Encrypted: i=1; AJvYcCWjA+D4IKHKy8AL5x8C7/zHEBGf9j7bILjPv6LYjT1+E9DzdKKFQRLztRKSMGs10f9JvA9a5alhe1MJaj6WCxOqYXRPncZqzLKVZR0RiQIEnZqfRRDBd7x6GQxr1mFaUWUtRtTFshpoMvBcRnisE14kKDgAWGhlQIZxTqXnSRwvGXf4t8ghbZXS1Q==
X-Gm-Message-State: AOJu0YxkOsOydVxPwe4M9W0mv1qzNO4WKxi1Dg7e8g8JWF2KEp6dbcjI
	otsX2PWbJ/scasC0zt5g+LykNvvKv1mZzSfZ7nCZNqgoDT708v9tmyEJqs2JmIrxdbivMNj6JYj
	6oSZzz8Qq9L/TPkb2VEv+gCX4/AaF0X6+bH4=
X-Google-Smtp-Source: AGHT+IEQXK2ymqjm9RS7Gw4oIrIZC0eP/AACnY3IUga+kVXLIWVYoq6iANWVMjRZNMA29ZKW8WyFf9DIkEkV5q4j1U8=
X-Received: by 2002:a2e:a406:0:b0:2e1:9c57:195a with SMTP id
 p6-20020a2ea406000000b002e19c57195amr1186952ljn.32.1714707818413; Thu, 02 May
 2024 20:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211425.8678-1-hdegoede@redhat.com> <20240502211425.8678-4-hdegoede@redhat.com>
In-Reply-To: <20240502211425.8678-4-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 06:43:02 +0300
Message-ID: <CAHp75VdSHGXuvGtPBuQSeDLTg0FjPNStcgG3-p07cfVLi_D_YA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] leds: rgb: leds-ktd202x: Initialize mutex earlier
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:14=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The mutex must be initialized before the LED class device is registered
> otherwise there is a race where it may get used before it is initialized:
>
>  DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
>  WARNING: CPU: 2 PID: 2045 at kernel/locking/mutex.c:587 __mutex_lock
>  ...
>  RIP: 0010:__mutex_lock+0x7db/0xc10
>  ...
>  set_brightness_delayed_set_brightness.part.0+0x17/0x60
>  set_brightness_delayed+0xf1/0x100
>  process_one_work+0x222/0x5a0

...

> +       mutex_init(&chip->mutex);

devm_mutex_init() ?

...

There is an immutable branch (in case of this series going behind LED
subsystem):
https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=3Dib-le=
ds-locking-6.10


--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-pm+bounces-36438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C61BEEC67
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 22:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5581E4E158E
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5918722688C;
	Sun, 19 Oct 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABTacBYu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8D1F2B88
	for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907228; cv=none; b=iaSzDkIXAqgOzg4nV5vBhbN103Fze8SZLX/pAP3ChryFpQA2MBlpp5cENko8mm/DwDSkMyFf6VeD+3w6M4WveCpsTdg0dc7SHq8W+SgQoMSVO2vvGvOd3Ql4CctP0ZBZSrSbNIxz5Jx9m0S10cMD8Us91NerkB5jAONUHESTOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907228; c=relaxed/simple;
	bh=O2zfE4vf4ah1dibiRpvsd3NnhgM9Vr10uy3t41JeKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht3YDROBRRV769ONjv28acA8+JlJzxmpK2uq5sVNlLFSz8F6iJ7JAsUsJuda91DUtkqdVrLvo6chFR2qR8ZEXjvbDyNdz4+dVT0si98MiOAFk9KIfdHC8+gxbkTz2b+0Up5jp++odyNgatFQgbCRGyYKR/B7SFAaShJYBqQVHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABTacBYu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7829fc3b7deso28251237b3.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760907225; x=1761512025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLIclD2aF84lUbWy0CIM8XnSXp6AC1BEWNN7dbQyLN4=;
        b=ABTacBYuhPvnzWu4OtghliDgZGKXPT2miCS4VSLkBaizIwEsmYpkZ0aLIblBDjBKZ3
         lfKOA+/R/C16MdrumYsJFws/cRfQlq2+gDETwDhxXntuRtkbFdir+mKl2McpAYs3l2y2
         pZYVqBdMw2ukaEC/GOh0E+u2hmWbefXPK5OQvR5fg7kNCIvEEuUBJ95GbpFnwx/gIwR/
         3ZPphUA7b5lh08vMlXxRuNRZB9fJ2tRxncBS4e2ZmXtx0bBP5JiUmb+xmDYjdKKdhsi1
         teCpwTGIQpgr2rLassZZrZ9loRMic8ujW4eccBFhYQQrVzQqGSJ2SvAmUx8LNXaJphIB
         YAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760907225; x=1761512025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLIclD2aF84lUbWy0CIM8XnSXp6AC1BEWNN7dbQyLN4=;
        b=M3E6fDvC1x3PNJqrNxhBR3VX2Gr9yN4Rl4fuPWwzVxJM1X96Nq+M9HTPqHCBYxw1CH
         EnLyIu8tNbpTxbDsQPYsQcz5VsIlgTwLc9OqtQxgqBC1zC5uXkpCjK91T0PDrNFVxeKs
         koCtcODYk/8/g6Fjc9TioCr+R2yxYDl6KIbC1lT8yeNiIPBDqsN+cEXpXBABON7Zcc5L
         xHAj4VTxVxRvN+IiAkYtabXmAKPolFF8KVnTsRuNJS6qBrK40cayto1HZ77B927YzANF
         pfg/1em0MNinS9YMkOKnevDREjCbm93p/NcnM4RpzWktDmLRvLWtLbXrr/dXfLPEy0NN
         7lGA==
X-Forwarded-Encrypted: i=1; AJvYcCWjznQIRZhFoJxuy5QKdPJxrtkd7nsMG1ageO1PtPiarPpqjmuiGhDla27RTXJEA+ew0zjSjPkQ9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5w+ehMYefUbSKwkYa9hoRbvOsDOM1e6qUuOAugfP0610ua8/z
	ABPRdiXAqr4xsdOTKZgQkLkIMxsnUtCoMHw9561SzRWuKeWr9GPvgBuedYKgxMi7zfjYu2EuJCk
	84jT0gJbLPPh7X6AuMuAlUptEB6UBr0o=
X-Gm-Gg: ASbGncvz02v10MM/Ln4sJFZKOyZtdrc6oqOlk89GXCxxT10qcVuvKuuZlxfjobbmdpK
	oswzhpiO6lK3UMPv+F9O6Y749EJA3ncjYqqd8+CnijFw0v1qFHDhIn07rkYAjfFRitAfZ1xMfV2
	goOHxywaZOcDz8zoAIxCjB6lDSzAs1XZLgU4E3r8pV6HItjGOlZwT3nbb+8psIL5sdC/VUAcL+3
	ThpncdATvTsGesxPuUcAFzY6yFzCvur5u/3oPsbJYJLheDA9zpIvGl6L+zPseHWdWaw08Qg5X9x
	0IrQ
X-Google-Smtp-Source: AGHT+IG+VnVg4eeqtni24th+c8XSTz9bZ4o+eo5ggxBTkXyndw/uiD4XSbKqdvbqo7rPEXjxfr8g73d/jXS/Qyg3a7c=
X-Received: by 2002:a05:690e:4091:b0:63e:3c2a:c33a with SMTP id
 956f58d0204a3-63e3c2ad83fmr192995d50.12.1760907225531; Sun, 19 Oct 2025
 13:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019191519.3898095-1-aurelien@aurel32.net> <20251019191519.3898095-2-aurelien@aurel32.net>
In-Reply-To: <20251019191519.3898095-2-aurelien@aurel32.net>
From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date: Sun, 19 Oct 2025 22:53:34 +0200
X-Gm-Features: AS18NWC8mas1vOpzBcYTdN6WQn4JlQUKb553pLiF9PjWnggz16K-ukTapFmx2g8
Message-ID: <CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 22:34, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> chip, which is commonly paired with the SpacemiT K1 SoC.
>
> The SpacemiT P1 support is implemented as a MFD driver, so the access is
> done directly through the regmap interface. Reboot or poweroff is
> triggered by setting a specific bit in a control register, which is
> automatically cleared by the hardware afterwards.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> v2:
>  - Rebase onto v6.18-rc1
>  - Use dev_err_probe() to simplify the code
>  - Fix indentation of patch 1
>  - Collect Acked-by and Tested-by
>
>  drivers/power/reset/Kconfig              |  9 +++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8248895ca9038..063202923d95d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
>         help
>           Reboot support for the KEYSTONE SoCs.
>
> +config POWER_RESET_SPACEMIT_P1
> +       bool "SpacemiT P1 poweroff and reset driver"

The driver code looks to be written to work as a module, but here it
says "bool" not "tristate".

> +       depends on ARCH_SPACEMIT || COMPILE_TEST
> +       select MFD_SPACEMIT_P1
> +       default ARCH_SPACEMIT

If it does work as a module I'd prefer "default m" here.

/Emil


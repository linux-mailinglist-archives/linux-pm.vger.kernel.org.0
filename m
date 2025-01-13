Return-Path: <linux-pm+bounces-20293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D41A0B0A0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18FE161B25
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE8233131;
	Mon, 13 Jan 2025 08:06:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EE231CA0;
	Mon, 13 Jan 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755607; cv=none; b=uwa27VytO4YYaQ59bQHo9/H/sExoHAaWvECIZStg+dx/DYXdDDAXJsbwGXJsJTvlaux6EqOsocZ6HORmRWlad+J5/wsZq/pOBzitKrWDjmNxnWhgCk356e9NCyYI6oUvJL2XmPkaQxZfasQMrQ/RxYGM3OYfn3qD1goljnASIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755607; c=relaxed/simple;
	bh=6THSFx/AFsr9lz4GIRAGYuA0iwZKBXlb/hbJB4FiF2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+/LhY6+ny6BombJ0ZHLhFDGPx5M+AdHv1c2iWvEoQjoWY1Hev0K6Y6p53kL0nUF+kKTGME2aVGmgpDo3dotV9A7E2qHn00hV3/5C13DJJmcjksSrbgxxvyJgGAdcqWFP5YHppznzP3fbgrFOCSysbrqCESvtzqmd/yjYatHPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30229d5b21cso32010591fa.1;
        Mon, 13 Jan 2025 00:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736755601; x=1737360401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9SvbOZC1nnq5Y5FqEi1BPs9LivsVwnmqcjEJAXSzCg=;
        b=rugAQh+cgkoWHckZ/Co301Ih5408LkV2jtp/wJ8YfosJzEjBzUz8rVNhM8daid047J
         IQeg+mFPRJSSmP88jzr9A4b6yU5y6MFgrLG63t6YQZvgU2DpTyz90h4VLZXc3fq+uvkC
         T9KLHtbr/7ICDq41zXoit0Aia5aLhvfj/U2pcrlX4xYGQrhqFjYFaouVkSsE3tLFIeX0
         wSt0BwMnjjFWSj2GYbYJ2jKMeTJ0ZwJXJO+uSLnPxt7pxPEfFi/sINj3Y4PwZz88skR8
         mJW/+mot/+aaqedA3WeP5F4R8Mb+GTDE8qpUhV2HIDzIB7yjvdWNTwCMYk4xmRjOaDjO
         31NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKjCLoVi1uW0FuoLiXNzGYp5HR3ezBcB/+Wg3P36lZQfh1MMIqp3NzLEzoglAE5ZESt89Ts4sSZ8Vq@vger.kernel.org, AJvYcCX5PM8stdQDROX+RSNRjdJ+4PGIm4GEnm7Q6VV8/oPMDkbveDGep0RbMdh0ylzoGwaxYoNmiOUBxO++@vger.kernel.org, AJvYcCXYcuhsFmOo3Q6lp5vzNGWgCOgdPVa1C9h+aN92SljWQxq4uHoyjpr59JlG1FR+RC/dEVVacW1HXxk=@vger.kernel.org, AJvYcCXb5kbwcTGL5VJhvDv8v8H75BKRUqTKBhGOpLkTpr2EWBHtAfkOv3Vo8ZicePdWAN20zDnNfQXDDYqPpw==@vger.kernel.org, AJvYcCXr3Fb0xRh87DR+E90ykWhyfNvKeAe2/Jdh3BXhQYHjeuBaak4ApGsEh7tK8Kpdb6+jZwSWE4waS56kjBMw@vger.kernel.org
X-Gm-Message-State: AOJu0YxweF6nargi/9EzHf4j3INP/FsOD7NDIXgFlGayfymeRLm3zIcM
	zYWeZ7qyajkMgiQFwRS8/9XdklvQhE+y/0pvDfDvfy8sy1L5xfgjW6evVzA8
X-Gm-Gg: ASbGncvZjFX1KOasx1HFhSfwS0DK/AguUJ0yJ5UKz10Mq8SAks7JlMnDyazIcAsEOTB
	5TWHAinTJIyTP9PUKjwxRiP1d57jTiCo9l4zZKDJkr4ntedYADlMSYNSC9kpPdJQTpFl+WHN8SQ
	ew8uUR4cJe0zNF++bO3L6GvuJrxOC3ImhNe3uN0wGUs5ulaa5j+xFevTJ+Tn/53HEJZ1vh1Xz6Y
	pcGnqen5c/qo3cwFwPVugGSCesPz+Jv7a3/26DJWEV8haCcy5b4os7zqILkXN7K6CbiNKXNI9Rj
	OnkJWfUW1g==
X-Google-Smtp-Source: AGHT+IFrLyVeXUmX1JK92spdrQvhTE35RvlCzsFcOzDe1x8/Vd/a0dn38G9gzxSSwlwTdgMjAX5Czg==
X-Received: by 2002:a05:651c:a0b:b0:300:1f2c:e3d1 with SMTP id 38308e7fff4ca-305f45a09abmr63215401fa.23.1736755601156;
        Mon, 13 Jan 2025 00:06:41 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff1c7b6asm14027671fa.79.2025.01.13.00.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 00:06:40 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so3956903e87.3;
        Mon, 13 Jan 2025 00:06:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/lvUq//tBamzpeiNCuKcwJYZOHSKiRaKv0UUDipmJC2R61ooBJyWTyeI/0gco0vVzu0rL5nCzWgi0@vger.kernel.org, AJvYcCVyAZ8m29Kyh+Xunf9uN3zUYsrGgeNCKdPKpVOwm1SMeUzP/ujEUDur9usIrQ3vB7IbRZV4PeQV4/f9@vger.kernel.org, AJvYcCWD+QH8I0S6R/cqvQ4NpV3eySB/PG96YkP1DukBXSpAWDdYvEM2E5tg3cI2keYFzkPcDEOq02u7FpWbG2Mx@vger.kernel.org, AJvYcCWk24AJ3Ce8nk4hIUD7YD0YB3FGFHlkYKuEL3x+MdYr8vSd9Jrwx839a1c5ya/DvZ1MTHDKaHXpWfg=@vger.kernel.org, AJvYcCXHu+0KgXz99ff5dWloZ/ggWYGRPZS5trctFNuolzEnkXtLCOSR3fZjVs9RbxTH/4kv5AoYUs+e/skwZA==@vger.kernel.org
X-Received: by 2002:a05:6512:1149:b0:540:2201:57d1 with SMTP id
 2adb3069b0e04-542845c01b8mr6646548e87.49.1736755599852; Mon, 13 Jan 2025
 00:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-7-szemzo.andras@gmail.com> <de280eed-bcc8-4802-9734-5e95ad1f6611@kernel.org>
In-Reply-To: <de280eed-bcc8-4802-9734-5e95ad1f6611@kernel.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 13 Jan 2025 16:06:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65arvBMg+reReVqK-Y6dL+CSrSx4618msiRKcNf=Vk1=A@mail.gmail.com>
X-Gm-Features: AbW1kva6YUV9q8y_q0KQe84KsHadIWhU7SR1t_0-KhCfFvLqL38ru64zHHHYBmg
Message-ID: <CAGb2v65arvBMg+reReVqK-Y6dL+CSrSx4618msiRKcNf=Vk1=A@mail.gmail.com>
Subject: Re: [PATCH 06/12] dt-bindings: clk: sunxi-ng: add V853 CCU clock/reset
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andras Szemzo <szemzo.andras@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Ripard <mripard@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 9:56=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/01/2025 13:39, Andras Szemzo wrote:
> > As the device tree needs the clock/reset indices, add them to DT bindin=
g
> > headers.
> >
> > Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
>
> That's never a separate commit from the binding.
>
>
> ...
>
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/sun8i-v853-r-ccu.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/* Copyright(c) 2020 - 2023 Allwinner Technology Co.,Ltd. All rights r=
eserved.
> > + *
> > + * Copyright (C) 2023 rengaomin@allwinnertech.com
> > + */
> > +#ifndef _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
> > +#define _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
> > +
> > +#define CLK_R_TWD            0
> > +#define CLK_R_PPU            1
> > +#define CLK_R_RTC            2
> > +#define CLK_R_CPUCFG         3
> > +
> > +#define CLK_R_MAX_NO         (CLK_R_CPUCFG + 1)
>
> Nope, drop. Not a binding.
>
> > +
> > +#endif
> > diff --git a/include/dt-bindings/reset/sun8i-v853-ccu.h b/include/dt-bi=
ndings/reset/sun8i-v853-ccu.h
> > new file mode 100644
> > index 000000000000..89d94fcbdb55
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/sun8i-v853-ccu.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>
> Odd license. Did you copy the file with such license from the downstream?

AFAIK all the existing sunxi clock / reset binding header files are
dual licensed. OOTH all the YAML files are GPL 2.0 only.

IIRC we started out GPL 2.0 only, but then figured that the header files
couldn't be shared with non-GPL projects, so we changed those to dual
license.

Hope that explains the current situation. Relicensing the whole lot
to just MIT or BSD is probably doable.


ChenYu

>
> Best regards,
> Krzysztof
>


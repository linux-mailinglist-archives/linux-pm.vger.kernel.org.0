Return-Path: <linux-pm+bounces-15352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3736995329
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8842B239F7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE321DFE1D;
	Tue,  8 Oct 2024 15:17:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49224144D21;
	Tue,  8 Oct 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400621; cv=none; b=mjltXAtUDRsfV8qt52THV395fjn47l48jxmpZzgKk5FI+VeA+tnZ/hgrrpIsH7eAhNCG4VDis5x3xLE9v204u1deXaXb3D6ywzBYWnBqKZvc5luH+0xUds/6wksfE+qWFvTViBamwpTus9UD9LTnjxuZKXIdOzl05svMvVkYbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400621; c=relaxed/simple;
	bh=x0v6wKBxloqxd6ftXN0Rhhzo7IbMzrRL3YhX/jccxGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+iLcyAsNrcGaaVs5w0ySkjqRr3sVUw5bsbUcjXYhRonHT7UydtXNDIleQyXmBwJ8SVRKyT1MZBuqjm8e03HXP3XtnTXaHLpG39OvhkyAXci3mfCnyColF/GzjBT8AohprRJtIOXs/Uy9GF99eFH45dprA0BnavzLxF9P9f0MnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6db20e22c85so45577897b3.0;
        Tue, 08 Oct 2024 08:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400619; x=1729005419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNkp0597olvl4BH+GQsjOjO3dePD7p4cBzVhPvQBAu0=;
        b=WIKseKYYNHfk1nGaFWDUdJYhQbSsfcUR/ZGSUglFKA3NiOTkLUFg8/LL3sKj9xYu30
         0ARtcALzrjTCCUZ1C2e/7cpTwyPDlGsYn2Rxbp1mHHmu4W/e5540h/Ell/oC8R4p+fOO
         73UUTz7GF/9ObJLMQv3Q8fSOhNjO14rCy3qm1wvxSwSCt/556DJWr6u6lnMN12RtpAsU
         p3Hf3cX8CzIi08DVxdQQY3sIlbd41YechTE6UnnLerK8MX+4Qm870a1OkC7of1HwAg+K
         5+5/t5kS+fCqrqmKOLVNDDWOMTS90VELTTQhfNTRmRL7J1PRQ3HoC6WACM+B3I/BYqYF
         HK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZxsnTEp7eX4f4i/Fy2GQLnqAledGCydbwvua89w/Ht/u7rPYTRYI1Lh56mOy17YmwYN7ekMdbYZER@vger.kernel.org, AJvYcCV+b+yYkJ2g38tuRye3ERI2AJQvqHB9X6mCCC7uBlJ8n5WhPykPUCDWxhWfjnsvDBM//NOJtEU+mH9ly9q9@vger.kernel.org, AJvYcCVeYtxUOLLTtFRBzVk21YQ2tPaUZK7jHJsOQbDLHvZIrngqp5pIk4ovjusEi2ZbNEh67Wz0xY4isGFx@vger.kernel.org, AJvYcCVusz5u8dWyqZnoSRf3R2fyL1Yt3iDErXKH3dkjZSrutYApMpspFASULxA6ntYv7r5U3Ti5GkgOitQD@vger.kernel.org, AJvYcCVwci6IK2rrcgzUoslFFHmlguNGy1NtfU8IVv+xJeLYekGvZD21twK87LPqAM2/+zuOG9C1IfIshI8=@vger.kernel.org, AJvYcCWciWM5nv7qFX+DQTbsBx0RPViyi4SDAHEKUB5U9kP0zpwzkmGWAvHqvpV6WT6gE3rF39baxKhvNnmxywBKCtTSh3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+serDkK7WtJPcqrpt6HtzAqVFqmT+4ejmU2JGY+xz7NqyTmo
	2SwXWg2bRwLyyyG4lFG9kCG4XiW6NvdKuLhi3AhfBkqmk0Y80nB3Yjzfpn//
X-Google-Smtp-Source: AGHT+IEmwzQ4S21ySvIXl6lnzyeEe5/Tmdjn9/vqEVzOfpRH8NvZm0XibBuRYOEO0Uy0dRT2nJmMOg==
X-Received: by 2002:a05:690c:6a86:b0:6dd:fe5e:8828 with SMTP id 00721157ae682-6e2c72b2c16mr146723657b3.42.1728400615300;
        Tue, 08 Oct 2024 08:16:55 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e30e745d7esm3695727b3.74.2024.10.08.08.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:16:54 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d6891012d5so47861267b3.2;
        Tue, 08 Oct 2024 08:16:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF6Ko1eAfISunr5S7d2Yjd4Fd/x57pGQfwgXkKNc7e7HRu5bhUjVXVh2An2Z55Bviuu+0kAR0gIp40Iv5B@vger.kernel.org, AJvYcCV09BBm8FNLG10sCg9pF9njqXJwc4IjqrDNTIXboGvYd2Xq0tuZi1I0jiTfYFFmEmVOr7Z+qhcLEinD@vger.kernel.org, AJvYcCVLiH+I5QcKlBg5Vo4/f4cJbXD9/BJnqPQtDmuodr+Bk55ETA+SP3wMR6SjxUtbHSO9kDfwEfGdHZ8t@vger.kernel.org, AJvYcCVWjNnu7RDx1ZZMV2mkS8D3M89Awj27SDhX4BsCEYWXy/KhJeLAaR35Ir/r63f4lz/52PUcSTsWzwqT@vger.kernel.org, AJvYcCVsR4jc0UeCphLYY4QlE19OtC1F80fZIAqdbj5G20uREiWV36/7z9+abIon3xVqBWge8Ad0ukW+sUA=@vger.kernel.org, AJvYcCXmXP+9+bInS6s9nld1Plb7b0lkJTiT/zfq0M1L5dnn1W5GdTdMzNa7unmSpI2jDjl+2PivrQ6m2vKpFAoIqbvu5dk=@vger.kernel.org
X-Received: by 2002:a05:690c:f88:b0:6e2:3e17:1849 with SMTP id
 00721157ae682-6e2ecb69a8amr76258537b3.2.1728400613366; Tue, 08 Oct 2024
 08:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-16-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-16-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 17:16:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbNRO--0ZGO4owi3At5n1dTMMWo4PTaubyNWEkVnPFFA@mail.gmail.com>
Message-ID: <CAMuHMdXbNRO--0ZGO4owi3At5n1dTMMWo4PTaubyNWEkVnPFFA@mail.gmail.com>
Subject: Re: [PATCH 15/16] arm64: dts: renesas: rzg3s-smarc: Enable USB support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	ulf.hansson@linaro.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable USB support (host, device, USB PHYs and sysc).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> @@ -144,3 +188,20 @@ &sdhi1 {
>         max-frequency =3D <125000000>;
>         status =3D "okay";
>  };
> +
> +&sysc {
> +       status =3D "okay";
> +};
> +

To avoid regressions (/sys/devices/soc0/ disappearing), enabling sysc
is a dependency for "[PATCH 05/16] soc: renesas: sysc: Move RZ/G3S
SoC detection on SYSC driver", so I think it makes sense to change
its status to "okay" in r9a08g045.dtsi instead, and spin that off into
its own patch.  I am not super-worried, so doing the driver and DTS
changes in separate patches should be fine, as long as they meet each
other in next or upstream.

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


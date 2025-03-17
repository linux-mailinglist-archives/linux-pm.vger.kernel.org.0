Return-Path: <linux-pm+bounces-24213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94787A659BB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86633B6A2A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C81AA791;
	Mon, 17 Mar 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao9RUyOn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AA1A0BFD;
	Mon, 17 Mar 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230959; cv=none; b=HGZORtHtFaQHeFfP7iE9EjRaMzXD7l/IMyV5+iw5WRnRDWla57qXb3zp1OaaHGEUmXAn/KxF3E9BPIoPszq3QQDIEDgshf6GN72K2tjPyXTYTQDfCMi2Y7yWGHxa8chwvJ/OevuVuFr9PL4JwO+79hW2vYol7epAVLde+/tSdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230959; c=relaxed/simple;
	bh=wmAQpWrbnl5KpOhZB+M44f4YKrDesD193thOm41Mty4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gflkUaGVHjKXUyUlSvuzgLvZHx/0HYGazan4O8mqM79fJf1wDsveqXfeasaUpmXhz/g1Uts0GAk02+hMNKQ9F3C0C4FwarPvxou84Obbd2FYfigfN+ich7Sq1ODDFap7+VD1ihU4j46dFm5wHsBqZAbpT9SEu1/88m9mwUQxD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao9RUyOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D499C4CEF2;
	Mon, 17 Mar 2025 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742230958;
	bh=wmAQpWrbnl5KpOhZB+M44f4YKrDesD193thOm41Mty4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ao9RUyOnn62fb0KVAiHTegwxi15GPbyJbLSIAd0btxQAMQP+bXHtton1vYC2D7fec
	 nWNcR2F8rqhKkvJcAMAE1xiikaOPQAkDaa+FfNmive6OjF4K83g5frzYQtjBqEjcwi
	 5M+gIwBwGywIYIfYkWpIWdEhS4bp566w3h9KQwog5JBckbwP22hVk4eoj+ktBFs5N/
	 9sC8ryScjL/Dro5HAFlUB1KbFHwe6glbMpFqd8CWE5RMz+QG/wDYi6FmRx3YbSEVXx
	 lU129MhDtB5nccU/UMgxJublcx81OgUn9yYDImNVJAjfRxT65vGSIrtmJuZ+4v8i0T
	 +nZdtW6DmV5/g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso6828786a12.1;
        Mon, 17 Mar 2025 10:02:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXu0A4Dv5UnF/jtTpZ5cWgq0Kuh9aRBYKCrAwpnaWVtKVNoxVLS84L3+NKJ+PZD9HYF04kwq49mZo=@vger.kernel.org, AJvYcCUlxNNo4Ipi5ZpLxjtvKEJTBzGQ4BNLyrE3xnxMltn/7XOhNQVGVl3rSxauR47foWufrBlj5xzizaLC0qA=@vger.kernel.org, AJvYcCWntVQR5ZcoofVxfyTr2lD8MKiUWX2LTNhyQoRvQi2kCMwt4w6PBLJUx9IllpH1ybnrTIjTUqSMr6Q9Dg==@vger.kernel.org, AJvYcCXLLNtZd0fN1w6+qXtioaNk7lebOseVkNmsxV36l8mGL48nxOcbbEpeuhiy9EmbsDkGyXbC5I2ATYBS@vger.kernel.org, AJvYcCXTv7C7ycAjBluDBG7FTDh35aDMAwGNI+7c3f9oJfn0fiJ59rf1Rs+fTCvcuA6ag/nzbBg0ldtKJkdLz+4g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zHRx77Jd3KcI6/YIJ3sv5Z99hibtfDqssUMChq5BIYpZu7C1
	rAfvJVqJze03oIEZ9nC+FqBpcJp9DMKaF6hVXfJzgwG0FYkHUJp1hJxHCn0XQG3UkBnmUHKu4rP
	Nd3R2Tv/sv3xXvEfggXAqoY8EWA==
X-Google-Smtp-Source: AGHT+IELNK7EJqeju5Ff6Mi3w6hvTrNHJTNTnaKN8BlBDScpmQHS2FI/3UdKP632/dHKwxiBT7Jwm7K4RNzFWhl+jw0=
X-Received: by 2002:a05:6402:4409:b0:5e7:97d1:e371 with SMTP id
 4fb4d7f45d1cf-5eb1decc924mr428618a12.13.1742230956827; Mon, 17 Mar 2025
 10:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <20250221160322.GE824852@google.com>
In-Reply-To: <20250221160322.GE824852@google.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 17 Mar 2025 12:02:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+f23KniKZuTHkOq5a7WL=pBy6PwuQwXmbPXMjq3Qax4A@mail.gmail.com>
X-Gm-Features: AQ5f1JoasT_jUUldML7pER3fUWB0fDR2taZ4qNmmgf7ICMfbcDnTgm4IkhLwvaQ
Message-ID: <CAL_Jsq+f23KniKZuTHkOq5a7WL=pBy6PwuQwXmbPXMjq3Qax4A@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, Input, LEDs and Power
 due for the v6.15 merge window
To: Lee Jones <lee@kernel.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:03=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Enjoy!
>
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f0=
5b:
>
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
>
> are available in the Git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags=
/ib-mfd-input-leds-power-v6.15
>
> for you to fetch changes up to aebb5fc9a0d87916133b911e1ef2cc04a7996335:
>
>   leds: max77705: Add LEDs support (2025-02-20 16:38:37 +0000)
>
> ----------------------------------------------------------------
> Immutable branch between MFD, Input, LEDs and Power due for the v6.15 mer=
ge window
>
> ----------------------------------------------------------------
> Dzmitry Sankouski (7):
>       dt-bindings: power: supply: add maxim,max77705 charger
>       dt-bindings: mfd: Add maxim,max77705
>       power: supply: max77705: Add charger driver for Maxim 77705
>       mfd: simple-mfd-i2c: Add MAX77705 support
>       mfd: Add new driver for MAX77705 PMIC
>       Input: max77693 - add max77705 haptic support
>       leds: max77705: Add LEDs support

None of this seems to be in linux-next, but now we have users in .dts files=
.

Rob


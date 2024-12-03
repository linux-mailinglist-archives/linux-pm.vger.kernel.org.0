Return-Path: <linux-pm+bounces-18453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2549E1C02
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A614C161D56
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A51E47B9;
	Tue,  3 Dec 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE355tkF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625834F218;
	Tue,  3 Dec 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228515; cv=none; b=iqK+/b9j5V3KoGPkIXvD2cqVOzSnKWtGbDQz4/Q0UCT6+SX67/NJxvgBZxBRHGmhSqpogQ7wSVsySxFt94feNwCSIYcBPQGsDNsmYEdWbXGjlujfTnswzdfjTmFmYgNW34LZw82EkwJD7K++mx0rU+UEdTpvFQTm3koWv8IXQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228515; c=relaxed/simple;
	bh=MpIXVp6qOzjwdqyxitDOtzmLzxJa7XWFAuMvx362IEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMD7td/PtxMYf0l1emoAbLv2hfwH4DPqWlSXfKQDDp6GVtjlJ4oxNhqFEFdGw5Dgq0IAsri8bUg0NpoX8TYo2BltNI/8zPiBWU4UtWR/C1NlGxbLH3ayaxjAE/8AvJC+CNF5NimOR/WNJsadilQ/hRLu+cOyq5G+cy1miOESWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE355tkF; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85b988ec4f0so559818241.1;
        Tue, 03 Dec 2024 04:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733228513; x=1733833313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpIXVp6qOzjwdqyxitDOtzmLzxJa7XWFAuMvx362IEI=;
        b=BE355tkFrSSVnuJuQQMWEtC2yOodZU+b7z0fhvFbvXv6q8EFgk/GgJnokwMHFLnMTl
         z8Ce42MgXxAUz/KIAFejC7wsqaiEA3ZtbnMUl0+C71Puw8Qe6jClqJl/r+U3YG+VdUUB
         9HrUdy2Ss15Go3Mh0HEDykJHgT9o5Jzn7t+oMI+YiCchwOpVnzU+1AVDsTE3mB+jFuOB
         fMRxfHpP2f3a3It1ZuA+GprrKB5JHqfhpZ1tvEl0nmN/FJByu+zuBWNkhu6WMWM+aL0p
         GOnv4B0Wh/oZmBhmymQY3hr3BMnK51glLdaBbxetSTQT6h/axQVtxUwMG1M8bYtjIRax
         G/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228513; x=1733833313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpIXVp6qOzjwdqyxitDOtzmLzxJa7XWFAuMvx362IEI=;
        b=dp8psN6VqofIF0Wv4pkdj0Ia963Pv2jp8aKJDu0GOUn6AaqRQdjiSeowNIX1lsGIX8
         myWM2qOuX5C748ubcRtB1sMEu9SyPovH4E9/q2PQ56LLBWoUdPop/zowGdPtKwTx0+T0
         Sblh7V7opL8BumjaIPDgTVP/E35dY8HPjxlk5gSAWKeeNVEPGIdd4toB4h3y3BLyH8Ne
         Fs+c4b9SlG/DXZxTGgqjJxGYa3e3fLYoQQ3rGEkZrvRCkjG0NFf8W3Z3w45ZMBpy/13I
         dxTcbiJxi9KJ4th6Vy+ws+GLXhgx7oqSi84MM0b0eoEe0xE5NB0A9kidv7b3xKMi/at/
         B3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKznPFiUQE7aVd3gyBY28Kun8Zm7Ua5Tf2BlJ4lE30BG8Nttzdn/qL0oA0Tqhz/nKGssGOhvCvEZHr@vger.kernel.org, AJvYcCVLsCv6B6JUbKrLcA2lXhaVeX7FPXrf5ptlutTzCYx7r/okvwI8yesylfgpUyJ/F7iwA3Rq9SWY2/m2Nw==@vger.kernel.org, AJvYcCViwbvQHH8nsWF6b32WnGfrve1NOun58cgMFwHfcWdVlKWAHWv6TYuNTxrbxEXk8OQSFH/HWAqBCMK4a6nS@vger.kernel.org, AJvYcCWKNGCjxmhmEymIE9XmwNsEu+Z6sX5L9E20TVAGxJfGsRQxSGymaL1POiNXat1anrQuyoSqIRCyQE8=@vger.kernel.org, AJvYcCXQcA9twTyMGLaRyPfHUNzv+1ynmbCNnLiHTBcwvePYYbxOsFHFtW7x/TqrTvyXschfFwlA2vToM19ie2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxE7ygWV5ZBMXwUDH+vGABc7LJaao2jQozeN7l/IcsGsLNxTno
	xA18u+yfr8uaqBQ977JLaXeFpYjQb1xRZYvnH73nnNxnsARCMaSWI6OLx9yRuWAKORzX67w+IBE
	b3sS7Dpm3V4255LjIWZ3OXLIdRmY=
X-Gm-Gg: ASbGncuHLKnOtYJxjQLI+ympqPo4vwBEmjP9LiTPpXJ3FqI0yApalzkjHI2yx66rBx9
	R5cTflgg9A0bq35qolhlCOS6hjJLk5w==
X-Google-Smtp-Source: AGHT+IHvSfIxxZEFrMUMf9JkQ6m84tL4tuWoNpHCUoaLftm4kgpv9pueuEl2AvhcVOPltmicw6auZhK0Kuc4LSVYVTI=
X-Received: by 2002:a05:6102:38d4:b0:4af:48a6:79d4 with SMTP id
 ada2fe7eead31-4af971fc9c4mr2434948137.6.1733228513292; Tue, 03 Dec 2024
 04:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
 <20241202-starqltechn_integration_upstream-v9-9-a1adc3bae2b8@gmail.com> <b7e4162a-a7f7-462d-9dde-121eeb59d148@kernel.org>
In-Reply-To: <b7e4162a-a7f7-462d-9dde-121eeb59d148@kernel.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 3 Dec 2024 15:21:42 +0300
Message-ID: <CABTCjFDyoF7g-5tj_dr6k7ScB_313dwEmfdJ+49rwMYfN63x1Q@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] leds: max77705: Add LEDs support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 2 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 13:30, Krzy=
sztof Kozlowski <krzk@kernel.org>:
>
> On 02/12/2024 10:48, Dzmitry Sankouski wrote:
> > This adds basic support for LEDs for the max77705 PMIC.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >
> > ---
> > Changes for v8:
> > - join line where possible to fit in 100 chars
>
>
> Coding style asks for 80. checkpatch is not a coding style, unless this
> came from maintainer's review.
>

On v6 discussion, Lee Jones stated 'This is old guidance':
https://patchwork.kernel.org/project/linux-input/patch/20241007-starqltechn=
_integration_upstream-v6-7-0d38b5090c57@gmail.com/

--=20
Best regards and thanks for review,
Dzmitry


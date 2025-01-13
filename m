Return-Path: <linux-pm+bounces-20335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ADFA0B845
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F33A117F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15022A4F7;
	Mon, 13 Jan 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhBPV4cf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13143125B2;
	Mon, 13 Jan 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775366; cv=none; b=ruXrtcIqqaDMGY8H5knvh48FJHtIZvHvxXsxij40cG/t3M4WROJqheIYDrlC4S80yw5MCHHEtOwv/WO1TBhJ72sr0hfyN0ehOjrmlmvj1YTTrAYrVR+Z7kL8UcHc74BNshDDq8WgBwtPrkMCPCcUEwdMnBUe+liMDEQneQ81qQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775366; c=relaxed/simple;
	bh=x6ha5Ky2lC0qUjPPvUiU85NoPbXUXu7Yam+Wmm5D+wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyTITs+yUNDgqM1d5WEFtmHWE6q/rGTD4QmywMHWO+Yy4eho7rlcGkuYCymUhhwD2YLKfvmL+fbm6z16bz0Aorxif6nq1n+kCaL88uK7e9pI+pjhXfMjt9TshW0bkBDdrvc72DW1sKrUhhB9wJxroPqw1kue5eava0+PTfpN6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhBPV4cf; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-860f0e91121so2924293241.0;
        Mon, 13 Jan 2025 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736775364; x=1737380164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je3pBYcDo10F18n9QDSn0Ys9/NG5PE+POke78jldIrM=;
        b=hhBPV4cfvLoCgVEfI7rdrbL6jaXsW9wPnoB/RC5gqvbdj6DGmkdBeGeGAo8xnXoAJj
         n7h9s6wArRo1N6Q8bmdZlYiZMtAIu/AU8uYEIo9FCLADpDJtSsbuztuNVmZ1J9lgrPYe
         VKBViNKEyj2jdJ2CaKqLqC5Ss2HvQbiXRb82f3YBfcfX89rvlBOXVMkLeTxOPrwHJ2h0
         qySjBRAHA88fCILOp9e4H8iVak81lcJkD8b8cZDEiFF6yBWqexHDycp8NgELaFu2xjek
         ce9MUbfdNp0VReUwg87God4aMK7XqT2t+WEV3XAIfhAW/9y8htFpuxNs1B08px1jFMZe
         2y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775364; x=1737380164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Je3pBYcDo10F18n9QDSn0Ys9/NG5PE+POke78jldIrM=;
        b=igC+iMEcUzbfpCug2O7xbiQIJtS1C4IIsRTx7EM0qzxhZANQ0z0k2LVNxvMPbAm787
         fk3lifF3RMq00GQNBSvEQGFOlO3ulA4OSOBx3qVkIiIE21iEFH3HmTjAsFB9yMMWDIif
         tTrprYifIqQmHGI7VZ7YPJMSf0j9iwp2sHC4ax42hqsavbwSxtBC6o1Z0BhoaTBhQrXw
         3WwnGKiOkgDaltZ2UgUI6KGdEgLYQvqPKUclDWOg4nrgU+ZiKY/F9+zLwkt+GnPegmPG
         dFqO+4tNdhfZDC6QXmvFdtu3YCLTdW9pcE9JpgrxckToVzgtjASvalezKtCCtJxqyd33
         XGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWYIgNmmVWuVhj/BAtuHAdIBhK9vq5knBHSYDLtzA8yuycuXQvxmPkM1XPF1fUi3NY3/NHlELUqYVXRIYM=@vger.kernel.org, AJvYcCWZcXerMYeh2TQY9Aj3NMZQLmA507Wc+M8srGuLr6eQck3wPRCHyFYn2rRM73fvBzNHoY3fEBwSNaV2@vger.kernel.org, AJvYcCXM6Pas8qHNj2fvoJeGOAmfK2kzwZFA+KKV6BEBxUl8q6ndaMDDWSQxPeZUDp5OKEi2+pKvdL94xKXvdw==@vger.kernel.org, AJvYcCXdDO6sgM/hgDwUOe1G6Xb59QE7xDcEybfiCA4U/VQ6mjLCiRLB5UmfpKH6dQ7uq2lI6xdBN7VttXE=@vger.kernel.org, AJvYcCXdEHw0ed3LlqAz/X5CDSZnur8zbdFeiZsIsyAGYm+Lx/2Ny+12EiJIW6LAWrayH/LqnCUCf47ZxVcdeDJr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8R3I6Fg3LlU1r4VdUTQw50+u3yqK42JLbGkFHII+0T6jd+C1S
	aD5X9ubDoMPvbtVi4lOZfLMeYyF4dm5PhhUkKu7iOLRlx8b3DQFbm77OqYVFz1aQiKC58PlqyBz
	/fK1vGhZ6LJGMqPgOPvboQccLyEw=
X-Gm-Gg: ASbGncurQ43glo7p8u0WaWJLdoy+RIYNcfQ8Vpt+ixgBYZX/gXJgx2mZXvKOoCbRpGJ
	Vt+G6JHmGUHQYz0JfDwp/Nd3D2R/BciAG4Ok7mA==
X-Google-Smtp-Source: AGHT+IEJr+Arylij/5HPtp83Stfq9iUWZWYnxqY1tWSnXNDXdyAjXhsAoB35wLJqa7gStu8nZ23tfz0bjL9eH0NNvDs=
X-Received: by 2002:ac5:cb1c:0:b0:515:1fde:1cb1 with SMTP id
 71dfb90a1353d-51c7c818a5dmr11549565e0c.3.1736775363888; Mon, 13 Jan 2025
 05:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
 <20250109120158.GH6763@google.com> <20250109120308.GI6763@google.com> <CABTCjFCMky1kRZ0a8q999_WNdeOhqsDwtqxMCcWsmUoWv_rhDw@mail.gmail.com>
In-Reply-To: <CABTCjFCMky1kRZ0a8q999_WNdeOhqsDwtqxMCcWsmUoWv_rhDw@mail.gmail.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 13 Jan 2025 16:35:53 +0300
X-Gm-Features: AbW1kvZ2qog6kGbZ1YG6oeO5x7IGSNUtBvLoX71ZgTLHS-d-lGX3QVMqzXpEjpU
Message-ID: <CABTCjFArONRgDBjiDABHfRhp1OQnZRFoirx4gNAR=wB4VPBZvg@mail.gmail.com>
Subject: Re: [PATCH v14 07/10] mfd: simple-mfd-i2c: Add MAX77705 support
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 15:53, Dzmi=
try Sankouski <dsankouski@gmail.com>:
>
> =D1=87=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 15:03, Le=
e Jones <lee@kernel.org>:
> >
> > On Thu, 09 Jan 2025, Lee Jones wrote:
> >
> > > On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
> > >
> > > > Add MAX77705 support - fuel gauge and hwmon devices.
> > > > Hwmon provides charger input and system bus measurements.
> > > >
> > > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > > > ---
> > > > Changes in v13:
> > > > - remove compatible from cells
> > > > - change mfd compatible to match max77705 fuel gauge node
> > > > ---
> > > >  drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-=
i2c.c
> > > > index 6eda79533208..22159913bea0 100644
> > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > @@ -83,11 +83,22 @@ static const struct simple_mfd_data maxim_max59=
70 =3D {
> > > >     .mfd_cell_size =3D ARRAY_SIZE(max5970_cells),
> > > >  };
> > > >
> > > > +static const struct mfd_cell max77705_sensor_cells[] =3D {
> > > > +   { .name =3D "max77705-battery" },
> > > > +   { .name =3D "max77705-hwmon", },
> > > > +};
> >
> > Why not register these from the proper MFD driver?
> >
>
> Because the fuel gauge address is different from the max77705 mfd device.

In more details:

we had a discussion with Krzysztof about fuel gauge device
[1], [2], [3] and agreed that it should be modeled as a separate device,
because it has no common resources with max77705 device, and has separate
address. This means its node are out of MAX77705 mfd node, forming its own
MFD with shared i2c bus.

https://lore.kernel.org/lkml/55f32164-f504-4409-8ce2-6462b833da89@kernel.or=
g/
https://patchwork.kernel.org/project/linux-input/patch/20241202-starqltechn=
_integration_upstream-v9-3-a1adc3bae2b8@gmail.com/
https://patches.linaro.org/project/linux-leds/patch/20241217-starqltechn_in=
tegration_upstream-v12-2-ed840944f948@gmail.com/#951752

--=20
Best regards and thanks for review,
Dzmitry


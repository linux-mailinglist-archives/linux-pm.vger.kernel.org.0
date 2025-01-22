Return-Path: <linux-pm+bounces-20815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC6A194F6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 16:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30187A1917
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13547213E90;
	Wed, 22 Jan 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6ZmkyrV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDC14AD3F;
	Wed, 22 Jan 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559188; cv=none; b=MrjC8kvEUVxoe/0HqLWkTHXizduMBzf/m3qvLOCbmYhUvG8RNxgsqChM2PugISTJi4unlu1p84tLx6qnc5EKk5DUxUiP1IzE5zIpcNLOI3r2q/OaEAtEBW1jdZb8StJchZmv/OUxfux8vw4OKOYgLdFv56aMdgTVrDaAkAL4MzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559188; c=relaxed/simple;
	bh=Hw2fMyEc0mD0KGAvrjZ7XAAVrS0ZCn1jjJzhwZrVwBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzFtGTAxtU39T1nHtM6acLRW9ffah5e8JHmhZ7hfWwW8bewI24cFL5ATxLboorIbe/uY0XQd8vmfXIUUQR0oD6gpjrA0e0mkOvOnMRciU8obEYnnS3rBa1fXa9CvCrO7c5eMnEsb2igQchJ/GDKxckPA/0/J1JLGyRIxU5IBOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6ZmkyrV; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4affbc4dc74so4069893137.0;
        Wed, 22 Jan 2025 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737559185; x=1738163985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lpU57kzX6xm1n/A5ilQyKcz9kX/LPWchcpjfSi0e6c=;
        b=l6ZmkyrVVjdo+AkwonkneqUkjZUbjB7vr/uBSzN7P1shAKZMwSOOwTo3u2QmNUoOCQ
         QuHUPx+lZPBEkfnhIvbuRylPooeTFXAe5WR3rn0tTDjyqXXQntr6Xlz9n8kTGIEn1wae
         MpEX+J22yjFUJ4Dpx41S9Wz68EMHwuNxL+j7ycEcH8LBTxbodpIGGXjucvFjbz3+X42d
         Vq+SitcTTCObXbjp3e2SAY1nvNlpNh2FsMBa0znXLccPxOhFWsfwW7cC1q8w8m45qEwr
         WISWHxVQN7ICz9hOTrysiSzGEdrhEwtXtJHQ7J2qKQ0LkxdWpw5cUmuoUfMQWO+FiJ9P
         IjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559185; x=1738163985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lpU57kzX6xm1n/A5ilQyKcz9kX/LPWchcpjfSi0e6c=;
        b=buNnEnjU2JIhsKB2an8izFO2Wobh3eFcERXhYekANnoC94a+NbyXaQobqApoH2SwtM
         yIev3T+cLd27YE5IF+F5ejEgtSZDFyrnZ44/Ywsxlq15B0okOUqH9eWkizfHfswXXa8Q
         Aa6eQbmR/6rrUSfEGvFGC1IgBXZd20sPn8nexF4sUsLTgPLcTT7XvWuVM460ojB16mlG
         n6MrRc0N0+P0dNoYBtL44aDO3aNNku56zrNZvqGg0RZebp9iwsaGfCUxHhrp3sARuCsT
         hla4pp7jAnrsKQRvCz+oy2DpI3O5efBBTyh8CDqTI4+zdSACa+fpFI7kqQ+dFOG1Z55Y
         VQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6JeNsdEiyV+HJfR9ZtB2s5FSvPin8/Sp8rlr4SeWtJXw3Q2B61jZwun5uXSjNWgEyeq8i4V/lmVg3Qw==@vger.kernel.org, AJvYcCUr/TGeg6C/7Ntn3cjJ1S72xLuaCfb626yuF16lZe1pRPRGWjKqq8mZApQN95Fa9TRt1VUotJOeMe+PsLZg@vger.kernel.org, AJvYcCVrKBDlRqDvjRo1fgCWB5jDuwmRomHy2+GZq08gNlPoc5NSCaE2LMENoMVHGzVhP/470h55R1m2ECg9@vger.kernel.org, AJvYcCWdT91r4q5sIe0Isuc+AmmWpIF93QghmP3PnG6ZgfA7o29+VgNA+fWOcUX5GqCroVCLfd+owMta6iE=@vger.kernel.org, AJvYcCX2zp4ibkGMT3usbh0dgIIM/2fYh+xtrebUXt1UZUAspXpf0wJK3BQdvlVCSDit41LmXTeKGo8/4CDEuf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/bUvSPInSfHgJkSh/T5eYXjZJdgDrArdEdUq7fXlyMAhqNat
	WTTjHTPJOP5e5mqLIp16lDa2kEaPXWsSxih2RBReGV3cYlLfZe5I8FQF2PP6RaBpcXTTy/QQ/l0
	Jact0zJdGNljGcZYuT6vPEpjGSFo6mikTj0M=
X-Gm-Gg: ASbGncstagNoRc/iTwIjVnb0YeKtnSdhA6ChuqjaIX2xbks+ovlT+z93REdl2DeGRg3
	Xjuup2u9FNYucjjHCDUP1nqARSgh25yobmUKUq/uja+bxmX3S3w==
X-Google-Smtp-Source: AGHT+IF/9LBHhtXmfXdWr5Kvxv52FG642PNcPKWISvf0YHXBJ5aOnaRrvqUxYXhvvoPW9ZHHaa76RNotn7foQVaDVIk=
X-Received: by 2002:a05:6102:3c9b:b0:4b6:d833:63b2 with SMTP id
 ada2fe7eead31-4b6d834823dmr6718850137.10.1737559185272; Wed, 22 Jan 2025
 07:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
 <20250109120158.GH6763@google.com> <CABTCjFAky55btJz3B=K2kL5gSJD9BYi5t15jaA2ga5asVT=3NQ@mail.gmail.com>
 <20250121101531.GA1045870@google.com>
In-Reply-To: <20250121101531.GA1045870@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 22 Jan 2025 18:19:33 +0300
X-Gm-Features: AbW1kvatA4GcrF_L85FVLO9EmHFT0xc-4-zVysHVQ7JnwQGconCJsV8o4AhHVrI
Message-ID: <CABTCjFDRw9ZWWE=97neVcRofFOZfJ9fcn6dBXnCG4TbtMCzi5A@mail.gmail.com>
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

=D0=B2=D1=82, 21 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 13:15, Lee=
 Jones <lee@kernel.org>:
>
> On Wed, 15 Jan 2025, Dzmitry Sankouski wrote:
>
> > =D1=87=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 15:02, =
Lee Jones <lee@kernel.org>:
> > >
> > > On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
> > >
> > > > Add MAX77705 support - fuel gauge and hwmon devices.
> > > > Hwmon provides charger input and system bus measurements.
> > > >
> > > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > (...)
> > > >  static const struct of_device_id simple_mfd_i2c_of_match[] =3D {
> > > >       { .compatible =3D "kontron,sl28cpld" },
> > > >       { .compatible =3D "silergy,sy7636a", .data =3D &silergy_sy763=
6a},
> > > >       { .compatible =3D "maxim,max5970", .data =3D &maxim_max5970},
> > > >       { .compatible =3D "maxim,max5978", .data =3D &maxim_max5970},
> > > > +     { .compatible =3D "maxim,max77705-battery", .data =3D &maxim_=
mon_max77705},
> > >
> > > Drop the battery part from the MFD (group) name please.
> > >
> >
> > It will then conflict with MAX77705 mfd driver compatible.
>
> Where is that used?

In MAX77705 MFD patch:
https://patchwork.kernel.org/project/linux-pm/patch/20250117-starqltechn_in=
tegration_upstream-v16-5-11afa877276c@gmail.com/

--=20
Best regards and thanks for review,
Dzmitry


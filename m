Return-Path: <linux-pm+bounces-20145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF4A07622
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B0A167FE0
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A6218585;
	Thu,  9 Jan 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJwj5/fj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30497215074;
	Thu,  9 Jan 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427240; cv=none; b=GkQOMrwpPu4lRNgMsilwNeqSa40xSV8f/7IvHItuHQML91OBjKOmBycZq9XTL/V7paipvsokDKmfUnlRwMGxKVpMuRIW9W6J36eCTi9s6XkImtwmiadBTWWQEB6DerLCE8mCc9IjpFvQD5kbz1RL20DPs7pwAwAqJEYwXvA5cBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427240; c=relaxed/simple;
	bh=XngCrPFnKYJnX4wmtZJNVByjfsD6XAwJEe6yUvrW7Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucWbLF87LTs9ROz5CrdRg4KxYcDf/IBUjo4ngz4WskGf9t+hJrs8ZKq+UPGY8u8Op8JLVUVvKJ9dQUsKmszY7wfTLEbpLgU8iITEyRKaQZmBwxNYT+Uyma8BsJZ28uHzybd/3xl3nS6751zljUhzw4M7JWnrsmBcekGMQWJTlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJwj5/fj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85bad7be09dso524851241.0;
        Thu, 09 Jan 2025 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736427238; x=1737032038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOwGmglZgSOm6Gk1CXqHJczAaEbPrQw+u7E9D/ELwX8=;
        b=VJwj5/fj+JeUMhJvH+jUgP/k+YZKZ+62aBqpgRaCKX6GDNUHxlAZ+GwlSZsQDmPTZB
         TN5ZbyxgGVOQcRYrLO+5zduzohsMqEKPT/G+dYbppsV8DOLgaO8mpj67yJLF3Jv0fLhJ
         UHbzvOkvCimvjMUJg3szwebzPLOBPD7G6WJsbRdRbscJ8VQ4+7LxPboRU/1QJqjilyRL
         Djh042nA5Ogpkj+E17q25Qn3KeZ4X9+sVYniu5+VWjI2mX+n8QKU53fD99yuANrS6Lqr
         WsFZoSu8FyFH8mf1/eT6HsvcnpL9DkxR1f5d5KdtHu7LPQVi6y9lCOiuVPUKDnOMSOCw
         JjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736427238; x=1737032038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOwGmglZgSOm6Gk1CXqHJczAaEbPrQw+u7E9D/ELwX8=;
        b=pQi8owKthUGWHzvYKYHvPwNBs/+7g1WipoZpmiJ2dJURHPRVyz5sIgYNH9uCpnsuvO
         2/oYN0ycAYkEyLT2hTOjDmSD3z0tU7brDK4vt5BEBIqO4FaVGd7A3OJRm7bxaXPxcn/t
         jJERQPiFAXvxXUM9XIta1MSAjrnz+A109sa46pajEPlGQrHK7mwcAsTLx0pQlXX7xaN5
         Gp1ryl3pcxICLu0RsaX4tu43scM+rkZBk685r8n8uk2kIq+M1i0AAioaqlCOheirJOty
         EnvFo5rdPK9X97374fb38O8JaFLKkeDVU7WYbM+sGQJC+kdfddkeK+Y61LxaLCFXUMrY
         EEmA==
X-Forwarded-Encrypted: i=1; AJvYcCU/XyD0HbWhGnxFTvl7Jun1/weLMcVzoSfTzt1WV3CzfyJTvzezLN6s5sw0yNZaFivlOjreisZr2OKKXQ==@vger.kernel.org, AJvYcCVYxn/Mo0q/Gry25nD/81OENKqhrjg8ZCDuFiNAxPHnHlLtgx4/Q4oDSOUSxHu1qQGj35LWzQBEGFPYogQ=@vger.kernel.org, AJvYcCViGuItW0SwnG7JoJ7fpKQMGDI75U7VGxd+4H+XIqZBXR+T9DccAu0SQJ5gPeSRhvZKCNfqUgP3MsY=@vger.kernel.org, AJvYcCWyj5GyXXDJi1KikdHHNFhOlzdPJRRv25K+WGy4n6ScCzwimEjllgWgwOo/YJZA39I3ys0VutrGxYcf@vger.kernel.org, AJvYcCXDVT6jiKRj0lhfhZhc2O1bgEYT3MUijXzSYwmO7lvx637gMvJO8YuBfxDo2vifHb5UDd76b3YrnNYzrTNU@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFvOl+rE/g6bToGcTskE/Fmv4RxkZgmVjpzo9gIW0pg7NjCmR
	arXYyAwembbRB0eOLAsFCqPUbCjG6B2f1dmV0ed1+WXkDg/XDwQRV//521sI2VJqp8qE3rqZPKq
	fd3w0sPETJY7OHc3zgpqUt5W+hjc=
X-Gm-Gg: ASbGncvfPXRHzAMKWmhm/ZiWxVW3i/ePQTEC5EfxxpBMXmc7ULZDUHkNNfPUwEqu79W
	3P46ibr5vfWcCWezbLynVLSMznzU3Qq1/I1HF/w==
X-Google-Smtp-Source: AGHT+IH1XwcQ9+xLozO4Q3bu65QRU8W1LZuyVdusoys5faul4KaN3rPauBxadAiPSUOGB0xJz1gY3MkUHKo9TFNuZko=
X-Received: by 2002:a05:6102:d87:b0:4af:c5c8:bb4c with SMTP id
 ada2fe7eead31-4b3d0e0f3eemr5260422137.16.1736427237410; Thu, 09 Jan 2025
 04:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
 <20250109120158.GH6763@google.com> <20250109120308.GI6763@google.com>
In-Reply-To: <20250109120308.GI6763@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 9 Jan 2025 15:53:44 +0300
X-Gm-Features: AbW1kvbYBA43BadlmghIi3O6FKD8wTkjV5Cw7rRDl9rkqTnWC7Han4ju5QPlKqg
Message-ID: <CABTCjFCMky1kRZ0a8q999_WNdeOhqsDwtqxMCcWsmUoWv_rhDw@mail.gmail.com>
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

=D1=87=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 15:03, Lee =
Jones <lee@kernel.org>:
>
> On Thu, 09 Jan 2025, Lee Jones wrote:
>
> > On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
> >
> > > Add MAX77705 support - fuel gauge and hwmon devices.
> > > Hwmon provides charger input and system bus measurements.
> > >
> > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > > ---
> > > Changes in v13:
> > > - remove compatible from cells
> > > - change mfd compatible to match max77705 fuel gauge node
> > > ---
> > >  drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2=
c.c
> > > index 6eda79533208..22159913bea0 100644
> > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > @@ -83,11 +83,22 @@ static const struct simple_mfd_data maxim_max5970=
 =3D {
> > >     .mfd_cell_size =3D ARRAY_SIZE(max5970_cells),
> > >  };
> > >
> > > +static const struct mfd_cell max77705_sensor_cells[] =3D {
> > > +   { .name =3D "max77705-battery" },
> > > +   { .name =3D "max77705-hwmon", },
> > > +};
>
> Why not register these from the proper MFD driver?
>

Because the fuel gauge address is different from the max77705 mfd device.

--=20
Best regards and thanks for review,
Dzmitry


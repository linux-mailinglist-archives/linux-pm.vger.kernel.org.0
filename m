Return-Path: <linux-pm+bounces-7462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3C8BA571
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 04:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7A71F22653
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A421BF2A;
	Fri,  3 May 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXsYY1Wy"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22873F4FB
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714704954; cv=none; b=b3Ob7rdP6/ANc/fAC25gcEDBiMTg85UYKRlRAdgvFeiljIlSY6Xo+Pp5E+jU9OsefzQhiXay2u9L7cCSmUh73EjOUse3r9JklmSV6rab1/Sz8eXDLlZIsgX13o2XGm4+0CzKWPulUqI4c1Qp12CkC50VgryD4bv3jHaMhB27CjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714704954; c=relaxed/simple;
	bh=jT5s7YWR+A/p4LavrGBG6VAx4FlLFrdIZ9nf8Q/OMQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3176WVzNWnz84rWECRI/7rcs3iqN6BUVYT57onRSuo/LRA5/B3yrh6ufNMyqtXDHg1F4t4Fm/isX9wkF+a5Lb57VLreCtQ+HmP0jj3gjhSmh/Z9h6JVyAPEnYE/8nu7cUqKINrPSJAEna/yEVGCTdneI0UuKi54DkceiKUHQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXsYY1Wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714704951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwYPftRdc+ypJrZIwEf9pDQCg1OQOYFdRop7yZ9w5nc=;
	b=WXsYY1Wykbcy660Y46AN+FLrEmWSzIbjzMe8ZEclUz9viI6FufaNCubHMaMQwQkPwSmf3j
	6sufh8mE+ayF9abZ8SN3Yxg+8FIMU3JY5iVHZ2IKVL681+vrDtT+zSHW06FP6+mFOrG2Dd
	HNvr93R6C1K8Ldp6n7kJYDP4VbbEE6I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-FB7xoXOOPm6ER7v_6aCxhA-1; Thu, 02 May 2024 22:55:48 -0400
X-MC-Unique: FB7xoXOOPm6ER7v_6aCxhA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so3279902a91.0
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2024 19:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714704947; x=1715309747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwYPftRdc+ypJrZIwEf9pDQCg1OQOYFdRop7yZ9w5nc=;
        b=m22lnyJMBP+5rYabO8jsmCXz7v3i2lJAiHT7Br31VVFiQFqvxE3gODVV8XzCEV1pnA
         4GEUdyQf08SKBqF8wSU0jHNaYJzJwp3g0qf1MwAYRjmK2m03qaHqEvuUNxhFlZW9Y5cX
         0sThWx0BqaGC1Dpjb57rcH3A8p57pB7Z/1s7xx7dko/1Kp9T6A+is5xbQqDdG+5PQldI
         JiRC/hD9vGr5uUuBHbr/lKBJddAOYA6QhMRlZQA1TFUUq6DOyXNN37NvPxjlN57tyh1F
         uLMWPpeZbPySFZJeaBvxICbz8AfxQDuOoHZJcSSc1QAKnup6sgv+IsFl+Wk/lQXcEowm
         ywtA==
X-Forwarded-Encrypted: i=1; AJvYcCXOcQRPganwveTQ+HGFHgbpwC53ynXmotqNKD4dJVnxL2YHvQM9nkIMnWkIWtmj1n6V2ZZE4Oa+gf6uRnhQVCGAZlcmG88RVJo=
X-Gm-Message-State: AOJu0Yyo6j71u8Ku8qyln85oXzLjaWxk3rKr8lju3Dl7ziEWoDzSDR7h
	IzHFgROJK47gNzoLo4wKv4yP304pNL2zYTp5BrcmM6MVhkPe7kTTAdc3Vd4Nl9X0rkAAoVyEy1S
	51smzJVBmDQIoWDZnlAHiyqpHxT0jEo7VggwXGKq5USV5fjERDLuxMuBrmTWbPHUGjJkSA2CQBX
	Zhg+Mr5hi2QtMnuXV09NSsLxQUSDjN24A=
X-Received: by 2002:a17:90b:1487:b0:2b2:9660:7d44 with SMTP id js7-20020a17090b148700b002b296607d44mr1487486pjb.25.1714704947133;
        Thu, 02 May 2024 19:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwF7yIf+v2KN0XWVj2yqlaGxRq0b/5Y9aBa/NRwhgqBjRU0s+VYd3wqnkkstVZyYiuuahaMVp6cWCPQy+n1PM=
X-Received: by 2002:a17:90b:1487:b0:2b2:9660:7d44 with SMTP id
 js7-20020a17090b148700b002b296607d44mr1487476pjb.25.1714704946751; Thu, 02
 May 2024 19:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424065212.263784-1-hpa@redhat.com> <20240424065212.263784-3-hpa@redhat.com>
 <3e103075-c170-42e3-928b-41d3bb11e6e8@redhat.com>
In-Reply-To: <3e103075-c170-42e3-928b-41d3bb11e6e8@redhat.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Fri, 3 May 2024 10:55:35 +0800
Message-ID: <CAEth8oEbJZwUVeghgDpM3DzddY7DvGOnfXVMgQNrXG4XLr1y=Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026
 and 2027
To: Hans de Goede <hdegoede@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 7:08=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 4/24/24 8:52 AM, Kate Hsuan wrote:
>
> Maybe start the commit message with:
>
> Add an i2c_device_id id_table to match manually instantiated
> (non device-tree / ACPI instantiated) KTD202x controllers as
> found on some x86 boards.
>
> ?

Thank you for reviewing it.
I'll revise the commit message in the v8 patch.

>
> > This table shows the maximum support LED channel for KTD2026 and KTD-20=
27.
> > The 3-channel LED controller KTD2026 controls R/G/B three LEDs. The
> > 4-channel LED controller KTD2027 controls R/G/B and flashing LEDs.
>
> Other then that this looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
> >
> > Datasheet: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/leds/rgb/leds-ktd202x.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-kt=
d202x.c
> > index f1c810c415a4..60ca6ec34336 100644
> > --- a/drivers/leds/rgb/leds-ktd202x.c
> > +++ b/drivers/leds/rgb/leds-ktd202x.c
> > @@ -606,6 +606,13 @@ static void ktd202x_shutdown(struct i2c_client *cl=
ient)
> >       regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RST=
R_RESET);
> >  }
> >
> > +static const struct i2c_device_id ktd202x_id[] =3D {
> > +     {"ktd2026", KTD2026_NUM_LEDS},
> > +     {"ktd2027", KTD2027_NUM_LEDS},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ktd202x_id);
> > +
> >  static const struct of_device_id ktd202x_match_table[] =3D {
> >       { .compatible =3D "kinetic,ktd2026", .data =3D (void *)KTD2026_NU=
M_LEDS },
> >       { .compatible =3D "kinetic,ktd2027", .data =3D (void *)KTD2027_NU=
M_LEDS },
> > @@ -621,6 +628,7 @@ static struct i2c_driver ktd202x_driver =3D {
> >       .probe =3D ktd202x_probe,
> >       .remove =3D ktd202x_remove,
> >       .shutdown =3D ktd202x_shutdown,
> > +     .id_table =3D ktd202x_id,
> >  };
> >  module_i2c_driver(ktd202x_driver);
> >
>


--=20
BR,
Kate



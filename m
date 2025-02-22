Return-Path: <linux-pm+bounces-22713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C3A40603
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DED116A0F4
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431BD201026;
	Sat, 22 Feb 2025 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz6myFUY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158B1FBE80;
	Sat, 22 Feb 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208367; cv=none; b=CPtykh0VCKxS90sgn4gCn9vcENbbZqm7F6wUVNniW27y2CVoGZB6SdTHQbSPkijXUVwltU9it7lkwQdmVHVmptcFDe0ozJ+KrHNRcDkWCtFnKQWE8w0Qxk6x7o4Xk0HwzM2x+VXPpbNsMIxVkfG+7z8VpLjC+pkQWgfzOxT87r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208367; c=relaxed/simple;
	bh=dFvwOZ5dC15JFZ0LBEBtNHa5Vae+Ru0PUsBlKdvzXME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPVVqPeQMD9z8sHCAJuhh4cZtRtuho4fp4c05LdJOSNM4ExbvCbLJpo1uRaMDgCG6yrGDfTITSsf6VYIa4aqPA4Wddr+eh3KxbSLXyfXUDF5bXsoGG6dYVPh15hrJkHz7bKYRNz0P9sspFzE2WKSyCFPoa3wkkf7igFPA/PsAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz6myFUY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so19228385e9.3;
        Fri, 21 Feb 2025 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740208363; x=1740813163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTAsnwOgTop98RwuXEKcTakuBncufoIvq2Qgi1NzXxk=;
        b=bz6myFUYcmX4+FD2GhqLeVlpFq6GXGTMs/uOmRzJ7gEDWYCw5B6sSJmJ93CD/xwnWI
         nXbnBOI8mvM94w8btFYa+yPOGapqt/U+R+xoOFibYjuY5sMcawwxTPWVPwGMZnXy6194
         07bTEqpff8Lk7KHoI3OMifpESwO8K0+z6XNOATl+2CKdKcAy9K7+skUw9GnT/hc5oq2A
         qIvlUEBKqiogwO9RHMuFIPPTfufLZFVbz5XEOvhpTRFuiQzecbQHwnNWl8Hjw9K7lML4
         AQQwr4nmYwgFaKorcycxk4Mwq+USu+regqWtPlOnfZWuo6Jleo3Ow5pGyZBMBJN7Euxd
         Rsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740208363; x=1740813163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTAsnwOgTop98RwuXEKcTakuBncufoIvq2Qgi1NzXxk=;
        b=i/bc8uh9PwQqHdv7vfKqo4rgoxNWyjgYcLrLMlnBpC50XWQOfFcgHZoPKWPwKfqnzm
         NlnUmmbP9fmKzwTeRvwZ5WFqBFi4G7k1TAHpPTbDFEclfOXB3SEJSfP/Z2Db/823rhuj
         jTEeSY3WJmX6ZMcQjvK3efGOdu0ycytnMcU11+mkD+nggkClEsXpegGiJUvhLjZ72m8I
         nliihvyy303XXsUN6LeKKjsUfFSa6xH/LSgFCcrcrZGt0C7MLN01yYANVoxD5vEXTxUD
         OpRbpWYOX+JFQYeT+H9jaw3emX1zJQRz/TPiwCtcjMBmymGzIJzLFerepjdXa0vyA9LU
         E2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWiLBKuv7pFbJUt7XmSux+ttQwlW0QZd9tMHuan8blEqTcYV9jMYf1nyQ8SsO3OvXdo8ZV6jIMX37N@vger.kernel.org, AJvYcCW0RJPQUFd4+Y07fB4yUX4ibTn4tcWU0JjBJ4a9bDPk4XFNRoA3sVISoXK3Xbh31e6JQHBNfBcdIR4=@vger.kernel.org, AJvYcCW6bWWApdlNCXjQZdUXJcbsIgXoUpU7GlGAj9v3RauQEG/ny4XmiYfSwhcZi6I2AcHG8MCCFHhnXspqp4/N@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGjfPHcbk2Qbqzd1jp9/I9YHY+4Z/HGrjqY9zdfsa0bQ9SfPE
	DzugKzMurLtuYQv8fgcvJZTgTuwoulQZNBBQOe9tY0mjlc80zhJip9wcqycSz8U64wNvydBua59
	WX1abdsD2MksXaDCxJHKttKpCCL8=
X-Gm-Gg: ASbGnct5WPMKzQTgXd34wBkZpd75r/1XCIVnVaaMtFWV4Mbe+qt4LNfhfHEiSU8z91w
	pmWi7uYKufuWGuOSyfY2d30Ow091rEfRLloYqDpcKi457tR/5JeTCSM1SSuwYUOHOYCbUjvyaTC
	QhtLu1SUe/
X-Google-Smtp-Source: AGHT+IFpeHsH0roklyL6OX+DAA5G9pNCA9k7IH5a5JKagExdTufcff0WuC0tA9KCn/3LNJ8ta82SQMehiWE81TylpUQ=
X-Received: by 2002:a05:6000:2c3:b0:38f:287a:43e2 with SMTP id
 ffacd0b85a97d-38f6e74f577mr5088199f8f.11.1740208363580; Fri, 21 Feb 2025
 23:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082817.56339-1-clamor95@gmail.com> <20250219082817.56339-2-clamor95@gmail.com>
 <20250221211301.GA83357-robh@kernel.org>
In-Reply-To: <20250221211301.GA83357-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 22 Feb 2025 09:12:32 +0200
X-Gm-Features: AWEUYZkCxMZZPVvPpKV9x65X2mUq-ivSm95fUrOfZvJCZWbN17EBW1rBtHAh8yA
Message-ID: <CAPVz0n11um0ebY8_fn9owxo_pp+jbykFFYxhDA=BwZccvcJZgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 21 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 23:13 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 19, 2025 at 10:28:16AM +0200, Svyatoslav Ryhel wrote:
> > Since device is a thermal sensor it needs '#io-channel-cells' to allow
> > exposure of thermal data via IIO means.
>
> This looks odd. The consumer is also a producer? What in DT would be the
> 2nd consumer. If you don't have a consumer in the DT, then you don't
> need '#io-channel-cells'.
>

No, this binding in general describes converting of iio adc data into
thermal data, using device specific conversion table. Resulting
thermal data is exposed as thermal sensor cell for thermal zone
binding. What I did is that I just exposed thermal data as temp iio
channel (processed). Real use case: I own an embedded device which has
a dedicated sensor for battery temperature control, but to indicate
the temperature is used adc channel of that sensor and adc data is
converted using a device specific table into temperature. Basically
this fits existing generic-adc-thermal setup to create a thermal zone,
but along with all that, the fuel gauge which monitors battery can
accept iio temp channel to expose battery temperature. This is what I
am adding here.

adc sensor > generic-adc-thermal > temp channel > battery gauge

> I would like to see Jonathan's buy in on this.
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.ya=
ml
> > index 12e6418dc24d..4bc2cff0593c 100644
> > --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yam=
l
> > +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yam=
l
> > @@ -30,6 +30,9 @@ properties:
> >    io-channel-names:
> >      const: sensor-channel
> >
> > +  '#io-channel-cells':
> > +    const: 1
>
> You have to document what is in the cells.
>
> > +
> >    temperature-lookup-table:
> >      description: |
> >        Lookup table to map the relation between ADC value and temperatu=
re.
> > @@ -60,6 +63,7 @@ examples:
> >          #thermal-sensor-cells =3D <0>;
> >          io-channels =3D <&ads1015 1>;
> >          io-channel-names =3D "sensor-channel";
> > +        #io-channel-cells =3D <1>;
> >          temperature-lookup-table =3D <
> >                (-40000) 2578
> >                (-39000) 2577
> > --
> > 2.43.0
> >


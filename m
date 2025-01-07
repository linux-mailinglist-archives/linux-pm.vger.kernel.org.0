Return-Path: <linux-pm+bounces-20000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1357A03A68
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 09:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B26165102
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEC1E0499;
	Tue,  7 Jan 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ3xLirp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD681DF75E;
	Tue,  7 Jan 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240348; cv=none; b=eZDMdPHTaSXA7PYAkZ3DjOGNFnVBuO+m4LIWNM8Xv56JTEPhBpXRMpN631WSKUbpDLmMQjMZuJurVaKzMjYLgklkKYxcidEMw/ok0/HZSRGgSgl6Kv0TGONEREQeF5q46spx7MsYrsuETfSpNVPNZidWv/ACuASS4WllqEltbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240348; c=relaxed/simple;
	bh=rVcs0O05Z6Z2YXLoN5/VeJ1DYaF7H5xd1FgGhvI8wto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpPC0tYGpTHX4gJrU0mLBC5VW3onM0xRMFUAZpW2yg7VUQfa2IYmdN9Bc9lC9CrZo0C+U8HVRmOWN81bxJEL5q+PMnIBj2mSWSAKeOtXKKlRmNIybxU8jEeLZTNFs/0rQg7MPalT7XnBMq9k12+/7ipE3LwI3miMLx4nLP1kltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ3xLirp; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afd56903b7so3952040137.1;
        Tue, 07 Jan 2025 00:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240346; x=1736845146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5k3NToxRQQt5hVWAtotCRABNSeI0vG4aDCdlGfh6uQ=;
        b=ZJ3xLirpTYPMmHrSocDtzrCK/3ZF4YWNu+Hn1+qZPcVLNOABZlKVgiBBi50LlxuKN3
         ToqDAaS0fAZGiBDWF7/lDl9yP3PWzGqtcFxeATjJsEnVs5163WTRos/zDwwtDHkf/oBY
         +aB92C+uqUYlcZHvG5LPLyWJk5GWN5qvo6et0EADO0OsaR1MQvVHJZpZH5gZv8NkXcW2
         gFmE/gGe3TrTzXRIjd84YLsIQrH825Q47njj7eaSCxQ6ml6kFFV6be+EWOPQv92hmADA
         EZNtv+8dqbCN2OFpbFsFCxb+ChY5539ykAT55z49Rh/VZ9FfteqyHKUn/ncgAAD7VVVk
         Hlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240346; x=1736845146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5k3NToxRQQt5hVWAtotCRABNSeI0vG4aDCdlGfh6uQ=;
        b=VfrVWncPu2YCPzRPuPvtBOj23VS8iZoaBmDhj76IWGS+ZuDv61sm+My8s3sNh/gxYr
         0lSjC92onJLVIGp/GTWerQdGyJattlSKZkdQRJfHdHPm2eNtY72/Ifby7iDH77GXB+rK
         xzKYPnxs59Je1nEOoMF4afKPDLXeOb70gHe0ZCtKqVLDYP3B07Tf/qkr4i9qNTJTk291
         6X/4Tp2e2ID4RaDrapWnIxTP9+PacdxXsbh8C8PVuyGUtJgj3K6P5ymZMdYsbjMrMlc7
         /zAZ8WWAq2lOKSxC7Sf0dMA2cATc2BDXldvpXunjAtI/coH/C8+Sq+/FPMt6yDQaa7vQ
         uVwg==
X-Forwarded-Encrypted: i=1; AJvYcCVeVdAUhBC4M5ddpLSmeFvKSOi3cRc5we9E3X+Y2qY6pU3jNR/Fouxke5AG+g4n9soBDNdoDMkhQJVPmPhH@vger.kernel.org, AJvYcCVrbwd1XYRQ7waKmyEVgYeTc5MWjZ8KSKizzYdSAM+WoDfBCUZqbOaDjmQqxrN2LWqx01RtHI9o5QELQA==@vger.kernel.org, AJvYcCWUtbqKzBQsxuD5rSyi62xNLuuZzIK2KbE914/PVEkvFEJGHvTHZZmcynUsE8etfhlnTtoETsRp7s0=@vger.kernel.org, AJvYcCX9JYPEHAYJe87SIBddEtz1IXbEkfj8PRKc5iA9QR0X2tnd5ZYxBwPDWCmJ5Jlvexo454lO5Qrk5VaVUEk=@vger.kernel.org, AJvYcCXzz+rPXhqyOmjGBwBoGf4Rnd5XroJqU+8rL8F/gDFLHK6POC+KXwTMGMHbLZPjvITLS7LTFPGR7AB8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaduh7U0P6fQ0wspqemwW3BLCRugM6IEc1qJetKGQHZ5SR/iCc
	886xyDmyZ6A1z53K4HWivVICjrtQsVdgiZtPy/PUWyzsns2WBe6aNFY64VQRMk6CRcwSS0/5y1U
	a7m8k9Dw2nIix5jV5NRHxvNXhIAV+v94g
X-Gm-Gg: ASbGncuQAXLTt5UGWMx1RbaRNbBx/i3zoHFZ+5gr0L4wSdE8ANBzyHRDk7SNyfoDERj
	fGi8OdczxUR5p0In5s3tvsQGprXbIUUc47qeZ8g==
X-Google-Smtp-Source: AGHT+IF5brQYvtQ3S6qRtqDr9WJ51+hPCQzRYcrNLEaCVJqsUR025KhhTE/hiP11YXIVKUN2EXRpdYEOMY/j9oh77a4=
X-Received: by 2002:a05:6102:38ce:b0:4af:f6e5:2b46 with SMTP id
 ada2fe7eead31-4b2cc359cebmr41352893137.9.1736240346057; Tue, 07 Jan 2025
 00:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
 <20241223-starqltechn_integration_upstream-v13-4-fbc610c70832@gmail.com> <olmxsr65fdrf7pphcqzjtrrayzfkt7zl4merqz2fkjpu75uqfx@362mo7yd6pcv>
In-Reply-To: <olmxsr65fdrf7pphcqzjtrrayzfkt7zl4merqz2fkjpu75uqfx@362mo7yd6pcv>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 7 Jan 2025 11:58:55 +0300
X-Gm-Features: AbW1kvbEmY_6GA3HRxAHsMtSxnmmLROnBqk0uj9HJOptpgKh_rK26FlK2qAaSJM
Message-ID: <CABTCjFBui7HMRb--5R0c1LCzmD8fx=C2wPzu-CPN0pw5FUE6mA@mail.gmail.com>
Subject: Re: [PATCH v13 04/10] dt-bindings: mfd: add maxim,max77705
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 23 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 18:52, Krz=
ysztof Kozlowski <krzk@kernel.org>:
(...)
> > +
> > +  leds:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      Up to 4 LED channels supported.
> > +
> > +    patternProperties:
> > +      "^led@[0-3]$":
>
> 0-2? 1-3? Preferred is the first, because we index unit addresses from
> 0.

max77705 supports 4 led channels, i.e. rgbw, hence 0-3.

>
> Please move "patternProperties" after the "properties:" block.
> Compatible should be the first thing visible to the reader.
>

ok

(...)
> > +
> > +        patternProperties:
> > +          "^led@[0-3]$":
>
> Same - 0-2
>

max77705 supports 4 led channels, i.e. rgbw, hence 0-3.

--=20
Best regards and thanks for review,
Dzmitry


Return-Path: <linux-pm+bounces-22780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B190EA41755
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 09:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FD1659CA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A4193074;
	Mon, 24 Feb 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pem/BUQ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CC1885BE;
	Mon, 24 Feb 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385741; cv=none; b=auATGsGXl5tFt9qh/hlMCt2LjsrJu7C2jcn2JFteWa58TppqvD85EB7Ux3NTvHGY420XJY5eyhRPFUMd+jRgYRSpXjhmXovOFjOhouzXDkSlrvRSAjZ3Jg/jlxxfT8HY9Tyb0AqfsT/NoQlOiy17ULbTBikiy+e7sVGA+6njxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385741; c=relaxed/simple;
	bh=ZOzS5ePfs2wqnQwaHHVLoHlsMugiC9XxRRqay/PfBEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NT/HU9jIOp201m2cv9UwQgtuygNnvWNV1MNwiBwQ3fCryflGrK9MZ11D8tBF2dAKm2aGUdc2RmJOq6BIGkjBxiXZHr19NuqlOXev6OepPvp3OSQCP50BIvXPIyNB5WSz/QXq5x9c20UpSlxyHwSBbrLWuzkIAemnnYIEWZvK+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pem/BUQ9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so35428225e9.2;
        Mon, 24 Feb 2025 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740385738; x=1740990538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeUpkBXOAOON5JiTXjKn2K+ajfDw9d+t/rTiJshEKqI=;
        b=Pem/BUQ963ffXqESFX2rlOd2JGA6EOouddiIRT/ebvHdabjxPOLdZycDmLLIrw2GLJ
         nOGoXeX2JGkRP4b78Opy0HcrnyVZohOEjNufP5QX+unA+IfDOvrKm1EmEBykrfp1S+Xi
         pSVr1PsByVoxX6SPhJNuUC0g+Y0lm81lMYncnBTTaF8CFYdK4LX4woAAxbWMtVnQbTZB
         OFPeJj5fhQk1eCbIzOpg2iNNHbUo4m5qR7IDGPX6miLatcFg2aIuJtAyDG2h63paNNxQ
         LRKYSpkvJFcGH9TyYGzn7N+H+a65kr4dvby24wbyjDJxUicGknPN6fwYvY8vVRMFdv/9
         PIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385738; x=1740990538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeUpkBXOAOON5JiTXjKn2K+ajfDw9d+t/rTiJshEKqI=;
        b=cAvNxISPtFlohnhWhVAd6bTI6hCyjBq0xjKtYeAVALp/BSom46djB9gkJSPQC4pGgB
         TtBgwMnUJWUo/ewQZNPOWPXFYJGHj3nNJQgTxHDHwuVeBvmafO9lu6q1+q2IouiGreK8
         aIVUk9B6vYhA4jMvVwGmohMP9LiKv8J4jkNBa/sT/TKpHy5x80daTEH60DiorTCn6AT6
         13b+rKv7a9SAStV7N+pVZQM+n4TsA0I14C94bd6guQ0AIXTK7zs8n7d1HTdNLQc3KnbR
         3ZfXZHrKlFC5KVaAfcJY7vLfCBjoftNzdlLg5jQzRcf9eyoQmW30rW6LkwYpJc472q5C
         Jv8A==
X-Forwarded-Encrypted: i=1; AJvYcCVBb1pSMMi6xcEc1aotNskJkcb0/mR+qgw3ASOzrGl3ZBpGJ3cCoVf9wWlhPrCyq81sX3cC5jxr9Zo=@vger.kernel.org, AJvYcCWCAgo5eFlvRnz8EbPiLP4tnRoUMjJrREDzVD3Ydm7fUgRCUiu2u8yIn6z5Ov1Wrgq4X5eChBCljS0lEKuD@vger.kernel.org, AJvYcCWnhueo2FaHchE3Bir23z9ufe5byoepCCiEJZMrF+QTkmzVTubAfvIE4Ztl9NZMoQo8jR3jeAfN/UhL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/d9ayKL4Hly2mQTls/8gPpiDU0VeywL6Nc7mtssrP7Wl3y/vG
	370tWuuX69KqA0rZQPYGYAjHkGVO+mYrZFxyMnB7RLmZ5vym7b7XmL2rRqx5TA6H21ZKw67NbW2
	lF/AYlx7dw3cRX03fizWiRh//+TgFzg==
X-Gm-Gg: ASbGncsZ50HdGoTk0Urm6r/sTdnT9OP0088yYUvSVZhBc7MUfprjcUdn8qqLMjJKZ6f
	+OhvS8BDU5OnGuhoNc342aHNvgHlAXCZSlFu/eMjPsqL6z63C3uVECR/rHQ+NWyRxFmlfhzD5d8
	KqVvOFkCMu
X-Google-Smtp-Source: AGHT+IEtAU+dlnMtSfvksOPhXdPHkYJFcwo31JwYoBHG6jmxYEzoHL6k769hg6gQ5C67vkNz9p4IbdFoWWoaqpf5PS0=
X-Received: by 2002:a5d:684f:0:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-38f6f095095mr8953802f8f.39.1740385737842; Mon, 24 Feb 2025
 00:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221095943.57297-1-clamor95@gmail.com> <20250221095943.57297-2-clamor95@gmail.com>
 <20250223-daft-amethyst-pogona-e9edcc@krzk-bin> <CAPVz0n0-6ea0mzWig-gPx+8fuPgM7iWkZpnpMnp-9+Lq5oCdDw@mail.gmail.com>
 <2b0500e7-70e2-4bfe-ae72-ebab0f060eeb@kernel.org> <CAPVz0n2CMzU1bqV_jiTw+VgLUSB-CdEwF6uPS7aJzaPN+eGhmg@mail.gmail.com>
 <7084415c-63f8-429d-999a-ed84c4586e26@kernel.org>
In-Reply-To: <7084415c-63f8-429d-999a-ed84c4586e26@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 24 Feb 2025 10:28:46 +0200
X-Gm-Features: AWEUYZm99jN8cS1jvHJ3f8i2oLX4vLfsBaRRXdZoQkwqRLcGwD5sdIo7VSGvaaU
Message-ID: <CAPVz0n0efveB7-WRcN5i=sCiJpgZ54p0F9shAOG=Sd6nuLQVUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 24 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 10:23 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 23/02/2025 15:28, Svyatoslav Ryhel wrote:
> >>>>> +  extcon:
> >>>>> +    description:
> >>>>> +      Special device used to detect type of plug.
> >>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>
> >>>> You rather miss proper connector or ports. Which device pins are
> >>>> describbed here?
> >>>>
> >>>
> >>> This is an optional phandle to extcon, which can detect plug type. If
> >>
> >> I know what is this, you just wrote. extcon property is not allowed an=
ymore.
> >>
> >
> > There is no helper for obtaining extcon via graph endpoint I am aware
> > of. Can you provide an example of graph parsing extcon helper?
>
> Most of recent drivers have the same problem and they solved it somehow
> without introducing 'extcon' property.
>
> >
> >>> extcon is provided, charger then can change its setup to better
> >>> provide supply to the battery. If no extcon is provided, device itsel=
f
> >>> can detect only the fact of charger without details about type.
> >>
> >>
> >>>
> >>>>
> >>>>> +
> >>>>> +  maxim,fcharge-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      Fast-Charge current limit
> >>>>> +    minimum: 250000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1550000
> >>>>> +
> >>>>> +  maxim,fcharge-timer-hours:
> >>>>> +    description: |
> >>>>> +      Fast-Charge timer in hours. Setting this value 3 and lower o=
r 11 and
> >>>>> +      higher will disable Fast-Charge timer.
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>> +    default: 5
> >>>>> +
> >>>>> +  maxim,fcharge-rst-threshold-high:
> >>>>> +    description:
> >>>>> +      Set Fast-Charge reset threshold to -100 mV
> >>>>> +    type: boolean
> >>>>> +
> >>>>> +  maxim,in-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      Input current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>> +
> >>>>> +  maxim,topoff-timer-minutes:
> >>>>> +    description:
> >>>>> +      Top-Off timer minutes
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>> +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
> >>>>> +    default: 30
> >>>>> +
> >>>>> +  maxim,topoff-current-threshold-microamp:
> >>>>> +    description:
> >>>>> +      Top-Off current threshold
> >>>>> +    enum: [50000, 100000, 150000, 200000]
> >>>>> +    default: 50000
> >>>>> +
> >>>>> +  maxim,fcharge-usb-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      Fast-Charge USB current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>> +
> >>>>> +  maxim,fcharge-ac-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      Fast-Charge AC current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>> +
> >>>>> +  maxim,usb-in-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      USB Input current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>> +
> >>>>> +  maxim,ac-in-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      AC Input current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>
> >>>> For all or most of these you miss monitored batter.
> >>>>
> >>>
> >>> This is a charger, it does not monitor battery. There is a fuel gauge
> >>> for that or a battery monitor.
> >>>
> >> What does charger charge? Battery or something else?
> >>
> >
> > Anything it is linked to. Moreover ref to power supply is not needed
>
> Not true. I opened datasheet and it clearly says:
> "1-Cell Li+ charger".
>
> It cannot charge other things properly, so it cannot charge "anything".
> It only charges batteries.
>
> "The MAX8971 is a compact, high-frequency, high-effi-
> ciency switch-mode charger for a one-cell lithium-ion (Li+)
> battery. "
>
> > since properties from there are not relevant to this driver.
>
> We talk about hardware here.
>
> > monitored-battery refers to a simple battery cell, which has nothing
> > to do with charger and power-supplies is irrelevant since this device
>
> battery cell has everything to do with charger because it describes the
> characteristic of what device you are charging: e.g. maximum input
> current or top-off currents, which you define here as well.
>
> You are duplicating some properties and adding some which are not DT at
> all (all timers). Look how other devices do it.
>

OK

>
> Best regards,
> Krzysztof


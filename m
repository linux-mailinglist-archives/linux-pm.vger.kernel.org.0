Return-Path: <linux-pm+bounces-23050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1FA47B1D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EF116AAE6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF514215F44;
	Thu, 27 Feb 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnlIKAPm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CA1A3144;
	Thu, 27 Feb 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654230; cv=none; b=SYt6CJ11Efk+CxogWKferaIqOlHV4h9XCIPQo+3u2r3iRhOIkru+PkLNuI8zp97PMTuRKCG2/psAsDnNx4UHsSpvvXCD7U4eQNWI+jcdFWTOAf5S7sOescELtypGYD0VKaTVZ4v+U4eQeUkss5ErHfUzcRVnvmMSmLBx7bbfaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654230; c=relaxed/simple;
	bh=fOx1fZDmWCp1Ci9WatOi+x02LNpZCXXhd2brVay/wW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emdqyRg2lyb+UETj/8ViHYeoCm11kjWsw3orvh73iOOLZsuVhLZljXC2U55jiRhj0pr6A1p4ZOYuz+XBnENXylNbjlNhAN95Y7O7lkPJKUuXOxDsWFL+SuCP9aod5WS1g/ozv1KBW/I7uI6QQNVTciNF6gwD166w8/yr2JP4nKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnlIKAPm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so397384f8f.0;
        Thu, 27 Feb 2025 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740654227; x=1741259027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hadUX4u1GfKPIphHcn1Ek4Hr3PvIl5P+IUNn+8yOy8=;
        b=KnlIKAPmwD3vvaO3JU1AVjajh1nVZOfH+c8TDwJ+ijTP4OnyCEdOiVuCeFMs3IcZ8W
         VSpFgSSY26QbfeE3sCJfSC7k3QU4weWUJN00imB+2MeMcpYk8IWhpN5ea45M7g8sGq87
         3S9xrHX+F8sCE8pQeMZJAIkyBJjs/cYSa30yaxUMtlqzy4IS1awzw9bPrcrYbfQv/zAq
         c1nxou1w5kzEhMRAYyH5mtxsc0BQzv/sQ0/y0lFCusp2hSh7LpZSc1X2py88De5z19Wz
         yqoo3wefFiKuQ2sW1YJBQI/pzJ1QUxFepfAD6uEVwTLf/ryNmBYweIpzDll/IonuUOwk
         iF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740654227; x=1741259027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hadUX4u1GfKPIphHcn1Ek4Hr3PvIl5P+IUNn+8yOy8=;
        b=hVSFhvlPZtkKLIRQdhxffznPMhTzv6I+0whYZV1WJ5oxvMZ6TQJXeYlVflr1W8cWHp
         gYRFV1gt1RjFw4GMkIaLSTtSYA5FuaGyvUfEBoohJjuZOWoQVsvD5w2BWdLgQhYMACYo
         OiRknkr47/Ln8yZQCenda2I9URAVq/cfpNtKK3j8D6DQpOrfSHxrBPYe8S4X0JyZyGdf
         BcLWNW3aA5iA0OZModa7xndktYyMrOHz6iA4rcJFIih9VPJgCPSei+O66qQEw3fSaG6b
         lC9hWLgius1tazCBFqOHUURybiJTfehiTz+VUNFLJ9/eQ/7z+wptjXaY2bmGM4PXEXRl
         rGhg==
X-Forwarded-Encrypted: i=1; AJvYcCVUYHTyRoYlCYydz7y7AVxl/YlbtCiC3LGioZ4ed4bTu6ryc+53B01rlyRs9lJosmUb2akuuLfcaVcF@vger.kernel.org, AJvYcCWuCIZUBj6+IyLqm8mhAhXE6z9IJZxf37D9FB94eunhTTL4GSnZALdPRirSJlz/GHWCtyO/7oEV0Hczb0cd@vger.kernel.org, AJvYcCXICg/yLdJYOjPXL2HtcL77nSaO6HxyDcqROJqtWfPBQ09DtImj92PRWboyNPfgvWAknfNGhbKVNSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/QQQfaZ/ul1vI5QfzOQ98SHayf3mZRXFw+k9gbjPyFvYgRUI
	bKE+DXWDYeia7uIPyRHbA/udWW9S3W72VnzlL5U4xDsxb4gCf2tTShzbnpvYEoGHqCHcl15YCaa
	yMtglOyy/lYwiiL5bdkkzuloQ2yI=
X-Gm-Gg: ASbGncsXfW6zETt8hbv1UHyjciiWwsX2SVYzK2mECYovJVzGjTjJwerqCG63PuZ8iGC
	ts89g8FihBlVxIvrT37TLeJg6dyNJr+k1/fDadpzNTRaZO1lQfETBKmjaPHWLSkd+W2RadNb/zo
	r8tC/6WHBv
X-Google-Smtp-Source: AGHT+IEEj51ZFF7H+ooOf776nU/dJ5DP50cQZhn9gIcpUHIVdKCAo09sypcuCvEs89ahCT8lxT6lgDEZJMVz7+RRv6o=
X-Received: by 2002:a05:6000:2183:b0:390:dfe0:1320 with SMTP id
 ffacd0b85a97d-390dfe014b3mr2847546f8f.33.1740654227006; Thu, 27 Feb 2025
 03:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226093700.44726-1-clamor95@gmail.com> <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
In-Reply-To: <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 27 Feb 2025 13:03:34 +0200
X-Gm-Features: AQ5f1JppDCYqF1QXS5_vIgWet2sbqWFV8cK5PQx5sC6AY4BBWfoZ9BSho_RZCb0
Message-ID: <CAPVz0n2kfxTJUkqrtLia6xBJ8t+fwjujjsc9k=mOk-P06bJH7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 27 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 12:45 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 26, 2025 at 11:36:59AM +0200, Svyatoslav Ryhel wrote:
> > +  maxim,fcharge-current-limit-microamp:
> > +    description:
> > +      Fast-Charge current limit
> > +    minimum: 250000
> > +    default: 500000
> > +    maximum: 1550000
> > +
> > +  maxim,fcharge-timer-hours:
> > +    description:
> > +      Fast-Charge timer in hours. Setting this value 3 and lower or 11=
 and higher
> > +      will disable Fast-Charge timer.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 5
>
> You still did not answer why this is board specific. This was rejected
> in the past because of that reason and nothing here changed. Nothing
> will change without detailed explanation, so use other interfaces if you
> need user-space to configure it (see other drivers, e.g. maxim)
>

Btw, I have used this awesome example you have provided. Take a look

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml?h=3Dv6.=
14-rc4

Oh, I wonder why it uses so much values which duplicate battery? I
know, it lacks battery, I assume that is why?

> > +
> > +  maxim,fcharge-rst-threshold-high:
> > +    description:
> > +      Set Fast-Charge reset threshold to -100 mV
> > +    type: boolean
> > +
> > +  maxim,in-current-limit-microamp:
> > +    description:
> > +      Input current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,topoff-timer-minutes:
> > +    description:
> > +      Top-Off timer minutes
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
> > +    default: 30
>
> Same.
>
> > +
> > +  maxim,topoff-current-threshold-microamp:
> > +    description:
> > +      Top-Off current threshold
> > +    enum: [50000, 100000, 150000, 200000]
> > +    default: 50000
> > +
> > +  maxim,fcharge-usb-current-limit-microamp:
> > +    description:
> > +      Fast-Charge USB current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,fcharge-ac-current-limit-microamp:
> > +    description:
> > +      Fast-Charge AC current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,usb-in-current-limit-microamp:
> > +    description:
> > +      USB Input current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,ac-in-current-limit-microamp:
> > +    description:
> > +      AC Input current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
>
> Half of these properties as well are not suitable and duplicate existing
> sysfs interface.
>
> And for remaining, still no battery.
>
> Best regards,
> Krzysztof
>


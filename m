Return-Path: <linux-pm+bounces-22749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B25A40EBE
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 12:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199A73B29D2
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B22066FD;
	Sun, 23 Feb 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/9Ngnfy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B252063F4;
	Sun, 23 Feb 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311828; cv=none; b=QLEZkWF9NMJD4dEbJa6Nis/NWaKrahXZ9Lbb0inCxw7VtktdPxXOmHv2eA3hL+J16LyaPsbtEeTfQlAiWohAMXUHaI3DBqAcgWWtqN3RbClbpCsMiKerS5WwVvgoG4rmtyDNgYnGG+xTVpRDyeDCDK2gepfDdMAWT1Xzdho7/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311828; c=relaxed/simple;
	bh=lQCWaTYzbOlez/0mA2hci+myzNPdFuo5HQXOrHOHrds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7M5Ph9Rguc+FvH2JU8de/4QOdzhmpzb1Pw+I5CXsK61IP8oqHakFuYR1IjnbIfElJMZMG1c2//As4AlOQY3ECDm3/z1dWoQj89XOH0lHlLuy+1SX58SAfp897pH0J2Vd25XrsVl7sI/Ut/NwFxfYqUWALo3Dhfp3ETvYzKgnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/9Ngnfy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2f391864so1939170f8f.3;
        Sun, 23 Feb 2025 03:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740311825; x=1740916625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8eYCTx6g/rWtouEkr7hfTZ953yzJSDo4S/RZug6h5Y=;
        b=X/9NgnfyB9qTalnR16miuaVnOPxfmRK87aqPSBzIjnIR7GpIrsoTdcRJjOdb7OZm6h
         Q7to2dnOlY95Zo1fGebAHTtkq/NCiUdGcSJuRekKlyEHUlo/yfNH6/y1ANp8/30IBXWb
         B8t/UFY7rvl5kIrSiPKkFHf//IJdAGG1zCECwSMxLtT92YYwI1bAivoPddb058UqpITz
         47fC7Rs5JBXB5hIEbGTr7QbuVg7jFeQQdOvfub8bi1wMTbwc3ohgt3YmF4pZOw8ArG2S
         RYZ/Bx3Ar+XNm09KZmEylvqmBNpnr/EyqimqYedGi0WKnUDdz6PGRi5H/63CQ7VmZlDF
         kTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740311825; x=1740916625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8eYCTx6g/rWtouEkr7hfTZ953yzJSDo4S/RZug6h5Y=;
        b=wGtkojI7+oBfwy3wnFkOlfXZo4Ci6JlFwvYFtZoPUAbqZc3bad0Nk/8ncWvXlXBvqK
         YWIXqKnAZabeeR+KCYeMwEhR7SkF3rFUxFnSWysSbTo95GlKzzAOmI+YnhlQCRuHp9wi
         ABO7FhaWHTnHjor9nPbij41/H4bE1ZeZQ3UrVTjOiP8oLm4RPp+pqseF7LFdRCVH1Ubx
         PxYshz1sx53NBKjaobOxkX0UXyTTfk5KXY3uLqkvXMsoSmR7rjdw+wgRJb/yUVWi5SrV
         0XxuHIRKgRYxc0iozeI+/VIT4+CI3WUM8cL6sunSQn6u1n5ooYl4pNZ86P6+tKcrHEaf
         VNKw==
X-Forwarded-Encrypted: i=1; AJvYcCUDKw4zDH6TU8JrgBCnvmnMkHirWBi7QLyZnRMbk2WJQ/EWR25XF8kX9fI0mISs5B14EABP6MCxWB1l72to@vger.kernel.org, AJvYcCV3ZZslzNJrxBsoMmiwAv4UdWUhCHUP/IKYr0RhX+gYPN/ak+2JVi19jGaxXZExqapQoAVGiPzcXbg=@vger.kernel.org, AJvYcCXtdE6HtDRJdSWUME+xpOiV0d1wPUZk+qWfJLKvk9kXqIJv+9TuLHQtAo1iax9JVz+BRjzOfhVjRL/r@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXLdvc+0wF5cJX7Qlm5gDq7ADrSOvswlqPBsAm4zN7ApVLCAY
	6zrF6PNv2ofNvKsp7hMYgg+ODCd5yiAJOKeSSCqzsofse6Y/aKOFOdB6SRM6pMD9JNVrBTWSvHT
	ByeXTK4R0vyWAh710DnrsD80Nt94l2g==
X-Gm-Gg: ASbGncsZVo7D31NCFj1y1qDLpE4Fif6bYVJPm4Ts14PN55G+BKRYCSPMhfsah+6dxwa
	kj3g2TPxWYpHCYbBD2yJylyvd9/8EQpPcok73oElDo3td3pnMsDejJt/80RZYEaF1RtXkbSvUR9
	0edwfWhqsz
X-Google-Smtp-Source: AGHT+IFVv5dy/4Xqxq8iD5kk+CIJUzGwiLe/xbSp9WFqHJXyw+a/z8rOuQxKjpLwOkZRBAAIUrIj6cipgwtdbU3ux5s=
X-Received: by 2002:a05:6000:1786:b0:38f:3e8d:dd42 with SMTP id
 ffacd0b85a97d-38f6f0d6ccemr8802825f8f.53.1740311824931; Sun, 23 Feb 2025
 03:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221095943.57297-1-clamor95@gmail.com> <20250221095943.57297-2-clamor95@gmail.com>
 <20250223-daft-amethyst-pogona-e9edcc@krzk-bin>
In-Reply-To: <20250223-daft-amethyst-pogona-e9edcc@krzk-bin>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 13:56:53 +0200
X-Gm-Features: AWEUYZkfvYcch_1aNStlN9muMfJObH5X6HuMk7Wcyr3lcUKdC3EtJi3Rm4g00mc
Message-ID: <CAPVz0n0-6ea0mzWig-gPx+8fuPgM7iWkZpnpMnp-9+Lq5oCdDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:43 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Feb 21, 2025 at 11:59:42AM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for Maxim MAX8971 charger.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/power/supply/maxim,max8971.yaml  | 133 ++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/maxi=
m,max8971.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max89=
71.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > new file mode 100644
> > index 000000000000..26b37e6f662f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX8971 IC charger
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mod=
e
> > +  charger for a one-cell lithium-ion (Li+) battery.
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max8971
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  extcon:
> > +    description:
> > +      Special device used to detect type of plug.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> You rather miss proper connector or ports. Which device pins are
> describbed here?
>

This is an optional phandle to extcon, which can detect plug type. If
extcon is provided, charger then can change its setup to better
provide supply to the battery. If no extcon is provided, device itself
can detect only the fact of charger without details about type.

>
> > +
> > +  maxim,fcharge-current-limit-microamp:
> > +    description:
> > +      Fast-Charge current limit
> > +    minimum: 250000
> > +    default: 500000
> > +    maximum: 1550000
> > +
> > +  maxim,fcharge-timer-hours:
> > +    description: |
> > +      Fast-Charge timer in hours. Setting this value 3 and lower or 11=
 and
> > +      higher will disable Fast-Charge timer.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 5
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
> For all or most of these you miss monitored batter.
>

This is a charger, it does not monitor battery. There is a fuel gauge
for that or a battery monitor.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
>
> Missing allOf with ref to power supply.
>
> > +additionalProperties: false
>
> unevaluatedProperties instead, see other bindings.
>
> Best regards,
> Krzysztof
>


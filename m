Return-Path: <linux-pm+bounces-22753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA0A40F43
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA3C18959E2
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353A206F18;
	Sun, 23 Feb 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu2MPVzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F031C860A;
	Sun, 23 Feb 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320901; cv=none; b=U2RnHxbQloOwZQwuw8SV59Jq4WLwkM0CO+whxwg9jtZMT9quOddjvhQoYj4lPnjJ7um3iu452gXis5qrpDnvzPjhSJs9pvb6O3RV80X/wJMi3h988p9qjda0UjDCv9nHTZ/lhxqrmjWXaLr2UlyZqiBK6PDmkThYx+R4FpjHrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320901; c=relaxed/simple;
	bh=ALdr17ylxkoeGmsulIqGgUfzXIoH8d3NSl1FgMfYOaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbGxR8rkx5BbGnd9LkucPeWjCG53Uks556xqzwdjKMIcYR3JWlO2wbOtbJ9qC0P+S20sf86XUQJJ1hHEG1m9v6fFCoggdQHEpZqceoyDa5S5pxHRzfJrdIqlNnfgxeyOYyUD4Msc8tnnOxOJAcR73sjVjYo/UnZ5BNOf7JoGru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu2MPVzf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f286b5281so1738108f8f.1;
        Sun, 23 Feb 2025 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740320898; x=1740925698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbhke7qI6ser1bUyNhL2A0rIuINLbPSiTTYbMisJjaY=;
        b=Nu2MPVzf4wLtRe5ZSovMyrKWdss40ZbOYRZqiY4IcJPXh2GKjp+7+fdCaqSmN1quoT
         AL0bKON5dP/699f2vsA2N7Fo3BLUbTs3Tq3ng4k5WZGyWsq4FQRD0YM51GPfmdC54kPF
         lFcSvu781C113fImiM1Df79dIvIiQhzoZM+og5PlBaKe4mHM0Tdm5+3tvdqCU+aQpLae
         6uMK1Q2aii1DLMOHFkxeRf+aV8xs4F+eUnqU8i6h98nBSp8uZ7SR1PkodlGW2e/9usFS
         cPHQazCb5I4IjMuvktcymZTQnhaLbn3Eg2mWr17ocjf4gmVyMqs8Rz1idsI9+8DUkakT
         daog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740320898; x=1740925698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbhke7qI6ser1bUyNhL2A0rIuINLbPSiTTYbMisJjaY=;
        b=Ge2WZyGr0q2NY644M8kUJkiste8qMHovnS1PRfuvDt/pG7Bt9xaJR/FxXkE7YWQcPo
         AOWREoOKNkZJrq+KOHRzBH4OL5E3LRmH/vb2t0EK/qz+mK2YuYWrfBCLiWBsd0LPGiTo
         fStABJ4YEMjz1XnZNXY+sCHeT0Rymo4Xs/DphZbodKUAoMlFmUhSUZm+RMeYhBtapCc2
         7jKlOQBWNUQzr9yl2kXhISfEMhpvczgGhrIASqvegSBiJ32ZS9TigniVyS165blQR8KI
         XDUvt7oT5OIS0ojMz1aOwYzDGE58wrF5XBIE8vA1yjCML5VE6pYvrzYdizWA5uR0VNcp
         erjw==
X-Forwarded-Encrypted: i=1; AJvYcCUwvBYyQnyF4D0Uu1yC/BGbWeapFncVexpnhZagumBFhv6rLRiTiUPOEdah8fTr9Ft6pdOWoV64i3pc@vger.kernel.org, AJvYcCVMe0ylLJDsW6aQuklip57YSiNzoGz2ltrV9k7Sfsgd6iG1zUU2KNw19OofEfvgorWwd/+Y3EYqxl4=@vger.kernel.org, AJvYcCXcaKY+AZGeellKxDAFrwwvCBO/LBri/QZULmiqjy6WA/zdts5vnuaMLs8itu5sPqsqyh1/LwwQGhQomDZK@vger.kernel.org
X-Gm-Message-State: AOJu0YxyawfcLNRWBkQdWR4zD4wJQHIabOq0JitjewIW6vSlMIed1L8k
	xWUCFpKqr4lhgHRvO5ywbH8qM3Jjh9bUOf4WOCLZ6y0DHWwHO45eek+AC1xfqoFRCZrdXTvrTeL
	mhZEVOdI+DI0RdpkH3GnrecbtfstdOJG6
X-Gm-Gg: ASbGncvkPwJbM+9hccBs9xSqZYzDlniRujnsE+ImH9STxKy92CJq0M5CDabW5TwXxu/
	lh1ztFWDxNTh4oF1gY0mrlt5JQ+jrvqJ0XezStzSSeZoCSWH4WmsjbYh/g7iMX6hIwEYevp2lAi
	HuOkvfElyB
X-Google-Smtp-Source: AGHT+IFtgGx/eUfVIwS4WW0fnl4k1BN/ejTPbfOEjHuKoxgGUAnP7JVKvCgDsBNPJZY9DOPpSiYVjCl2T46SdT9+8Fk=
X-Received: by 2002:a5d:5f92:0:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-38f70827d08mr7653725f8f.43.1740320897913; Sun, 23 Feb 2025
 06:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221095943.57297-1-clamor95@gmail.com> <20250221095943.57297-2-clamor95@gmail.com>
 <20250223-daft-amethyst-pogona-e9edcc@krzk-bin> <CAPVz0n0-6ea0mzWig-gPx+8fuPgM7iWkZpnpMnp-9+Lq5oCdDw@mail.gmail.com>
 <2b0500e7-70e2-4bfe-ae72-ebab0f060eeb@kernel.org>
In-Reply-To: <2b0500e7-70e2-4bfe-ae72-ebab0f060eeb@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 16:28:06 +0200
X-Gm-Features: AWEUYZnmmRiuQNcX_aspEi-JkaTPX5awMNjebQlQsFVxIIQjuuB8KRzj0X9pl9A
Message-ID: <CAPVz0n2CMzU1bqV_jiTw+VgLUSB-CdEwF6uPS7aJzaPN+eGhmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:14 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 23/02/2025 12:56, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:43 =
Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Fri, Feb 21, 2025 at 11:59:42AM +0200, Svyatoslav Ryhel wrote:
> >>> Add bindings for Maxim MAX8971 charger.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>  .../bindings/power/supply/maxim,max8971.yaml  | 133 ++++++++++++++++=
++
> >>>  1 file changed, 133 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/power/supply/ma=
xim,max8971.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max=
8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.ya=
ml
> >>> new file mode 100644
> >>> index 000000000000..26b37e6f662f
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.ya=
ml
> >>> @@ -0,0 +1,133 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Maxim MAX8971 IC charger
> >>> +
> >>> +maintainers:
> >>> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> >>> +
> >>> +description:
> >>> +  The MAX8971 is a compact, high-frequency, high-efficiency switch-m=
ode
> >>> +  charger for a one-cell lithium-ion (Li+) battery.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: maxim,max8971
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  extcon:
> >>> +    description:
> >>> +      Special device used to detect type of plug.
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>
> >> You rather miss proper connector or ports. Which device pins are
> >> describbed here?
> >>
> >
> > This is an optional phandle to extcon, which can detect plug type. If
>
> I know what is this, you just wrote. extcon property is not allowed anymo=
re.
>

There is no helper for obtaining extcon via graph endpoint I am aware
of. Can you provide an example of graph parsing extcon helper?

> > extcon is provided, charger then can change its setup to better
> > provide supply to the battery. If no extcon is provided, device itself
> > can detect only the fact of charger without details about type.
>
>
> >
> >>
> >>> +
> >>> +  maxim,fcharge-current-limit-microamp:
> >>> +    description:
> >>> +      Fast-Charge current limit
> >>> +    minimum: 250000
> >>> +    default: 500000
> >>> +    maximum: 1550000
> >>> +
> >>> +  maxim,fcharge-timer-hours:
> >>> +    description: |
> >>> +      Fast-Charge timer in hours. Setting this value 3 and lower or =
11 and
> >>> +      higher will disable Fast-Charge timer.
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    default: 5
> >>> +
> >>> +  maxim,fcharge-rst-threshold-high:
> >>> +    description:
> >>> +      Set Fast-Charge reset threshold to -100 mV
> >>> +    type: boolean
> >>> +
> >>> +  maxim,in-current-limit-microamp:
> >>> +    description:
> >>> +      Input current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>> +
> >>> +  maxim,topoff-timer-minutes:
> >>> +    description:
> >>> +      Top-Off timer minutes
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
> >>> +    default: 30
> >>> +
> >>> +  maxim,topoff-current-threshold-microamp:
> >>> +    description:
> >>> +      Top-Off current threshold
> >>> +    enum: [50000, 100000, 150000, 200000]
> >>> +    default: 50000
> >>> +
> >>> +  maxim,fcharge-usb-current-limit-microamp:
> >>> +    description:
> >>> +      Fast-Charge USB current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>> +
> >>> +  maxim,fcharge-ac-current-limit-microamp:
> >>> +    description:
> >>> +      Fast-Charge AC current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>> +
> >>> +  maxim,usb-in-current-limit-microamp:
> >>> +    description:
> >>> +      USB Input current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>> +
> >>> +  maxim,ac-in-current-limit-microamp:
> >>> +    description:
> >>> +      AC Input current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>
> >> For all or most of these you miss monitored batter.
> >>
> >
> > This is a charger, it does not monitor battery. There is a fuel gauge
> > for that or a battery monitor.
> >
> What does charger charge? Battery or something else?
>

Anything it is linked to. Moreover ref to power supply is not needed
since properties from there are not relevant to this driver.
monitored-battery refers to a simple battery cell, which has nothing
to do with charger and power-supplies is irrelevant since this device
is on its own a power-supplies for battery/fuel gauge.

> Best regards,
> Krzysztof


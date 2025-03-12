Return-Path: <linux-pm+bounces-23912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A2A5DC1C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73DC17294C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5D24168E;
	Wed, 12 Mar 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJfgyygt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ABA23F411;
	Wed, 12 Mar 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780745; cv=none; b=HK1rcKHsTVblbaztwFv0jjPajaizFOSrT63YxbRONSnEvCGgoUDLf0733OSAT96ykRz2zutenx2nJso9CVlU95FUdMrHkVPq6RIG1rh/hUK4AnJTxW/DMpzBhPaJgOhrV/VpIZtbyw+eG27vZrhLl7kjAJRXEh2jq53cuKOvg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780745; c=relaxed/simple;
	bh=2+E249FoMxeCPtng7rCF3Mn0z7RfCf3h+Vca3R9nky8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hc7m2bvGCTEcWpFGjQlIpTot1XPqV8BTlr6o61cvrGClpsnNh6dPjylBlvNMqkQ/IxX1eKw5NETENeaMEi0y0qQc/z2Eosg2myyJo5VOQfNo8cGGmy/RvIwz6ogrp8CpwFjpWEwz6E/eKN9oOIdWm8bMl0+LlLE/wcHxrKBjVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJfgyygt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0154C4CEED;
	Wed, 12 Mar 2025 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741780744;
	bh=2+E249FoMxeCPtng7rCF3Mn0z7RfCf3h+Vca3R9nky8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oJfgyygtRo4YfzZIpKTQx5huLeuEx676YcqWcsXT0VH3VkMbeqmdqDNVh6qHIzZSz
	 HzaLwjW1T9+SYNVSiJbvkwtsF8AA1axicWAGUfoMSNPls//Vb//5Lmh5indWZhEYfQ
	 INbpin4GnMfb77i3j2GLT84pDjC+f5Uhej7TloEfofddldjmUCwLTGl0F9ElKQKrDK
	 wnVPor30O9w82lK57+t5VktPDIFPbu+8qFIu4wRgVRs+kfBOeJt2Gr3DH6mfU3Y6ca
	 g3c1VdTaHuWCUyJQJg4HyYFCf+vjV6CcoesBGxPXMyWiqDGWJNyDDmPglK1ili4CwF
	 qo2V+Ky+sEBZQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1621742a12.0;
        Wed, 12 Mar 2025 04:59:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH0R8fwcF39ADD/iD4+4uJQrvFV5A0aLkO6NAfxYfxxNc9Tb4K/6X7e1aQ5FXMis3EmnL62MjGGTMMgg25@vger.kernel.org, AJvYcCVHeWQdUivgkBQCgFbgbw+6jCUXeBJMyY8NNA0CDKd6KVym3y0Yz0bJxTFBBcMSN6Cj87tvzMs2bMU=@vger.kernel.org, AJvYcCVlgUjXmmFItQnWPjPTgTOGF3E0P5X2w3FnXNxZvwNLR3nKSPJnHfMUdOe/fNG8x7hptZevFzkBDmOV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ud5VmgMjp46bcfshrG/LGQjBiGtEy4TiBxKoFDfZ2Ml1OkCt
	kjscM5VFsC/bq3HBI6hPvRFFzWW/fwm4OduV2R7pKP0IaecoKChLENGphAdxlfpfwUqjJfWsAz6
	mBjXuf+zicaUKikkD9KWz5yHs8w==
X-Google-Smtp-Source: AGHT+IH5BQD7ITN/g2eBCi7T0dAu5ljpqR2DL4+BQ5AiD3G98QJvLyb/xuTbUHCaciB5iJ/2IYVIIXj4q33YzTwu+gA=
X-Received: by 2002:a05:6402:280d:b0:5e5:9c04:777 with SMTP id
 4fb4d7f45d1cf-5e762900175mr9572561a12.6.1741780743338; Wed, 12 Mar 2025
 04:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310080237.7400-1-clamor95@gmail.com> <20250310080237.7400-2-clamor95@gmail.com>
 <20250311193732.GA4183071-robh@kernel.org> <CAPVz0n09ZP1i2tasdTvnt8RvjhALvUYjv9u_EGRtnXPOYQtuqQ@mail.gmail.com>
In-Reply-To: <CAPVz0n09ZP1i2tasdTvnt8RvjhALvUYjv9u_EGRtnXPOYQtuqQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 12 Mar 2025 06:58:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK53DY7xV8eFBpf+zpN8qPT2bYaR5Z1pyzSgdi1z5yXHg@mail.gmail.com>
X-Gm-Features: AQ5f1JqxwbCmUdSE4dbkfReQ51RA6N_SE-HhOIL5Mfs-CfN5v7Ilewsjv3M2Q0Q
Message-ID: <CAL_JsqK53DY7xV8eFBpf+zpN8qPT2bYaR5Z1pyzSgdi1z5yXHg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:03=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> =D0=B2=D1=82, 11 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 21:37 Ro=
b Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Mar 10, 2025 at 10:02:36AM +0200, Svyatoslav Ryhel wrote:
> > > Add bindings for Maxim MAX8971 charger.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../bindings/power/supply/maxim,max8971.yaml  | 64 +++++++++++++++++=
++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/supply/ma=
xim,max8971.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max=
8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.ya=
ml
> > > new file mode 100644
> > > index 000000000000..d7b3e6ff6906
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.ya=
ml
> > > @@ -0,0 +1,64 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Maxim MAX8971 IC charger
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description:
> > > +  The MAX8971 is a compact, high-frequency, high-efficiency switch-m=
ode charger
> > > +  for a one-cell lithium-ion (Li+) battery.
> > > +
> > > +allOf:
> > > +  - $ref: power-supply.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: maxim,max8971
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  monitored-battery: true
> > > +
> > > +  maxim,usb-connector:
> >
> > Just 'connector', so when we have a 3rd case, we don't have a 3rd
> > vendor.
> >
>
> Please, please be explicit and specific, you could not tell me this in
> v3, you could but you decided to fuck up v4 as well. So wise.
> Additionally, if you want a generic 'connector' which can be
> referenced as 'connector: true' then add one, ATM this is classified
> under your own terms as 'vendor property' and needs a vendor prefix.

I don't care for your attitude, so I will be reviewing the 20+ other
bindings a day I have to review and not yours.

Rob


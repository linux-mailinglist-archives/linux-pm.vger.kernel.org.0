Return-Path: <linux-pm+bounces-31771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15907B18812
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 22:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997FD1C27797
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB121770B;
	Fri,  1 Aug 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2dRz8Ks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFA128395;
	Fri,  1 Aug 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079754; cv=none; b=KchftT99adF81mPW7tbPJcI+xCOk444LHPJdt00KDTIJFUfp9Ucfsjfdhwn5yiJJwtq7P5K5wxVoHr780zGWdHkEltvRwkEu+vFanIHeHkD6QOHc4Ul6DBxbiasgX0VAUOZQNZIc2Dpt3Jgg2SAt813b8vvUY27h+F4nqNXKGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079754; c=relaxed/simple;
	bh=MBKqTrl7De+//6Sthfsz709YwDUNOv8L2Db7Ke4xXWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpMTklMIKtU8+45WuFuiB/yIcJoxBHgxin5IWamVq234TaQg0QwDwDry29YI2xshX/ojQhp6UlkoCWl6nqPnkUBMP7WG+cI5rnhO1AS9YND4G1RmsteHob4IYY7VTgLD7VY74Z5GH/lhWkyFFJ4zR7kFXvf/ybSTxCE5heZ3hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2dRz8Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC8DC4CEF8;
	Fri,  1 Aug 2025 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754079754;
	bh=MBKqTrl7De+//6Sthfsz709YwDUNOv8L2Db7Ke4xXWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X2dRz8KsPcFAIvrgyvpuXjzwWt7NUAzIVzoAFgZPOHXMcBnQB/ns+D3rmUEPewuwj
	 4l0tJlZ0W2flmq9RAT/KKBAXwNaGcd/itess8hy9/F8PUCXEJdOOCAn/jQddu8idej
	 b6a+FnQYPX3ji1FfmyqfibpTTJnXLz1YkmWz94e25WY3JzwevDII56V0c3XOHNm0eo
	 C6bBTcyydZ3BTitYkdBlGCbngd8nM1UaevSOLIpz5bcKlW86JpiybJlW8PJ1IrZsCb
	 BNLidNqFe+THMNJfr3GrJhVF9gNssxjPmQR3r6hhMATSx++nwcXZUl13544816Seur
	 NSW1f+2WKOmpA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af939afe5efso101382366b.2;
        Fri, 01 Aug 2025 13:22:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQjr2NXpAOmlafEDUV874WCdgKFNnOKHaK9+DhZl143nYLzdnrfKWN+etp8kLHNHakFgnL5CnwS5YC@vger.kernel.org, AJvYcCW3dT4f3PWIOa4GWMWI42CgF5DARgn0YKOUJki03u/KQAr2XW5D2w72so8F8qBXr+1lLF8atupIy7kZfhsI@vger.kernel.org, AJvYcCWBIO08eWOyJx6KTbhaHYr3qr3Hf8TsTFiiYTogm4cRdZX6fy+WR/JVo07BKI2qaNbuDQdGUpy3yn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwUe8Sxzjt3YyVfE/cxX5UwkY5blvDFOYN/Oc9ginzTkFDIJP
	sHNGvAPBBMxfsZf5FIPbXL+LWPgbu0HiHWuqJBsy/b9p5cL4XuOH0zh2WFutLBLpQiSTm7QIBzQ
	xdUTvOfbIHtvhVdmUfpgSufsfVmZZfQ==
X-Google-Smtp-Source: AGHT+IF2FQeKqn3oxGhmUb/arfH4bLPa8tvubqqolJ6Gmcd5eN4grlIXOWVZzTj5MlHwqbzfRxzIVzfSZDCYorxRVRE=
X-Received: by 2002:a17:906:730d:b0:af2:7ccd:3429 with SMTP id
 a640c23a62f3a-af93ffb9343mr121622166b.9.1754079752556; Fri, 01 Aug 2025
 13:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230030.2892116-1-robh@kernel.org> <87qzxv5d7z.fsf@bootlin.com>
In-Reply-To: <87qzxv5d7z.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Aug 2025 15:22:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+fV-W+PqZpvns5oFNyGXxKYYrHe1ipG7gj6dN-c2JJ6g@mail.gmail.com>
X-Gm-Features: Ac12FXzhED1_iNtqGkETiImlxD5HzfkBaY0XhZLrcDQxDOWi_frU1iKEaFUuOE4
Message-ID: <CAL_Jsq+fV-W+PqZpvns5oFNyGXxKYYrHe1ipG7gj6dN-c2JJ6g@mail.gmail.com>
Subject: Re: [PATCH] dt-binding: thermal: Convert marvell,armada-ap806-thermal
 to DT schema
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:27=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi Rob,
>
> Sorry for the delay, I don't know why I forgot these.
>
> ...
>
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - marvell,armada-ap806-thermal
> > +      - marvell,armada-ap807-thermal
> > +      - marvell,armada-cp110-thermal
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: overheat interrupt
> > +    maxItems: 1
> > +
> > +  '#thermal-sensor-cells':
> > +    description: Cell represents the channel ID. There is one sensor p=
er
> > +      channel. O refers to the thermal IP internal channel.
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> IIRC on these Marvell designs, there was one (or more, I don't remember)
> Application Processor (AP) and several Co-Processors (CP).
>
> [On the AP]
> The AP8XX overheat interrupt was not directly wired to the GIC but was
> going through another intermediate IRQ controller named SEI (System
> Error Interrupt).
>
>       Thermal overheat IRQ -> SEI -> GIC
>
> [On the CP]
> There was one interrupt controller per CP11X named ICU, which would be
> connected to the top level GIC through MSIs. The ICU was however split
> into several sub-controllers reaching different areas on the GIC.
>
>                                       MSI
>       Thermal overheat IRQ -> ICU SEI -> GIC
>
> As the OS could not guess the internal connexions, I believe we had to
> include in the bindings the parent IRQ chip we were connected to. In the
> case of the thermal over heat interrupts, they were all going through an
> SEI controller (System Error Interrupt) which, if I still remember
> correctly, was not the default parent, hence the use of
> interrupts-parent/interrupts-extended in the examples.
>
> This is all a bit cloudy in my mind, but I believe these properties
> matter and with 'additionalProperties: false' and without
> interrupts-parent/interrupts-extended allowed, a real world DT
> snippet would not pass the binding checks.

'interrupt-parent' is implicitly allowed anywhere. Who is the parent
is outside the scope of the binding given it can vary.

> > +examples:
> > +  - |
> > +    thermal-sensor@80 {
> > +        compatible =3D "marvell,armada-ap806-thermal";
> > +        reg =3D <0x80 0x10>;
> > +        interrupts =3D <18>;
>
> I do not know how accurate the example must be, but maybe the example
> shall reflect the SEI connection as well.

No one has cared about converting the Marvell bindings, so *shrug*.

Really, the whole example should be deleted when/if the parent is
properly documented.

Rob


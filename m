Return-Path: <linux-pm+bounces-24470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0031EA6E095
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAD3B1CC7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D5264605;
	Mon, 24 Mar 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzqFxv3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C0263F5D;
	Mon, 24 Mar 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835974; cv=none; b=X3huWlP3q2Lci33RsEG2AasavigT/jueXFzIska1NgVnd7CY52zEOtaTdHfE1aiFb6vDkfsU5epRQ7bhEQn/5AtJ5Y04Uf7nQABMJRU+HILxhyoaqVELs4nKgKI6n92AyoTW0GPQvKCw31C20BTKv5zUd9OUxDl10Dsr5sTU558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835974; c=relaxed/simple;
	bh=41GT6Nz+bc0ecmxG6gaQLa2C9sVbGLrHlvcO4fqGlIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOuWEFjhbHWxGjfZgSgiHA+h5il2hUYFgRRbTBO5KL2bRsIhB7vmBiowRhj07CTJIOtXExgpoUcotFZWc1Gdate7YeXHorkvC04nWTK9eYv/0sl5pKgBfa0q/gHuIr4ufIjgquhefHDUaBdWGr1rq1x/ck9HSogk0dBJUUeQEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzqFxv3h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912baafc58so3689492f8f.1;
        Mon, 24 Mar 2025 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835971; x=1743440771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFk3IdcSKxayCGlsiOfhMmx3PWLJAwIckQnSX27bd3Y=;
        b=QzqFxv3hxj6K90kVavWZF7KFkPPitvqTsDgB6WJl0r9RQK66ZOv/sj1PMZakyHdEB0
         kHEpN6Ex9t5H0pd3eiPSOWD8xVUjhWlRUUboIzk1Bsg3Wpf7A/3NYe/csPrzIRnKsGMW
         3Zz7YciE11MFizr1uOzyZKBbOazvgwh2H5ZsQBcBVYK8H0hDmqg3/LrSUBQHGm9ED3PN
         9ua0kTbLofi1JtnJN4iMejPgbO3Ft7/0gjc/6U/+U6Hsb7kgS14PDWQ8Xi3jjPxcTFLC
         X1sDgHeMF70P61ggJygVsb9G3pziKgCeO8/j+X/7T9BDxxo4931Ktuh/TCJ4UggkfVPK
         ptdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835971; x=1743440771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFk3IdcSKxayCGlsiOfhMmx3PWLJAwIckQnSX27bd3Y=;
        b=Z38RttQ2PyDJWfaTBp+imA5AIEtjx2A/k1/bjPwyVE5kulJwp0VL1kRlhz6jrWqoxH
         YzVAHPvZ/OvPNUOIIBg1VLbY4XUxOVpoJ+bRYtWYoOyKuxWJRCWlTPWCXxjMGRYbsUS8
         ga6juqSSGUZt6bTzICZmUDj8gRDijkrOCIoHegnM8XmgNOILkksBrySb4InXp/fYLEfJ
         h11QbHcKJCM4XLETYXUMgFaTYrAuZP/6k/HgxwKBP3xzOZCz5+8eHdjj4/1YC7Lecj3C
         FoJpigpOHhhxl479f+Qk1u1C9vIBV+0VvVVyVxDdLRUuzNDl7CQnCcOpDwquLBeUoABl
         V3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU2lirtyqylRC24oovI95KEK0XClD0i35yRioPC7ssqU7lRK3lb1Vjsuroevdf336JJ4F8k4480QPI=@vger.kernel.org, AJvYcCV9+PwBI81rSjem3o08F+1LtAZ7WyXez0OL9YQV4R4wh4e1DreNmTXT5Hy/KPejwf6rt15GITy4VEZhiQuz@vger.kernel.org, AJvYcCW+hcyfDFUTwL2If53omPhbF1AahLvuxkkWtntXGUXTrBiojieHX5ZE1ByehhPxifiOCbcXqmrIWLNi@vger.kernel.org, AJvYcCWniksdc1Tr9GdO8ERtObsrcVCPoj56URriR3tOcO7lAvTd9tjZB8kAyQyAlhdUhiJLAayZBfIv+/6+8sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kMHwvF+slHZlqUCOPDalAMET3YLv0s+ubjA+X615R5jgEOAt
	ptXDoPv9DoZBmZ0SqcMwE+hLwGFLU9U18++PASi6OBr/W1Iq+GEeodjJiIgWVE/OW5NoDL/8R84
	Mb2CKp/H12vCBKBkUNjOCKPmQjIc=
X-Gm-Gg: ASbGncuBJCI28JcBqRDwvm2B0Asdk40lrKEuwel5/EjVJjxY8RJkfDNx5I1zDxG3mCx
	T0ISVByENTpbIsID6IpJUGkukg6cd7nU2WJ/xdy0EImXwpiOX21c/ifWR5aRHdN82DjTZBhTdcf
	RsWS1OaGwCwIfyshJ4sIP0Sn41TJA=
X-Google-Smtp-Source: AGHT+IGFs85m2tb0CvbZ1cteIaSaWqbwx3SiFJBR4bxFXClC5PSNDvwcxnvalrKmwApXl+dNsAqoYgLQtb4T1r/VDvY=
X-Received: by 2002:a05:6000:400e:b0:391:3f94:dc9e with SMTP id
 ffacd0b85a97d-3997f90394emr14378665f8f.16.1742835970541; Mon, 24 Mar 2025
 10:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323071424.48779-1-clamor95@gmail.com> <20250323071424.48779-3-clamor95@gmail.com>
 <20250324165257.GA458528-robh@kernel.org>
In-Reply-To: <20250324165257.GA458528-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 24 Mar 2025 19:05:58 +0200
X-Gm-Features: AQ5f1JqjtDObBIN6HWXp4Xb-bKxDpiwv0AZaLd-JroEnLNLYqWC2vlIVyshRnAE
Message-ID: <CAPVz0n3=-QL1_NGP31WX_4LQBt5-T47BbU_yn6td1zk9C2T=iA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: mfd: Document Infineon/Cypress
 CG7153AM MCU
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 24 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:52 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Mar 23, 2025 at 09:14:22AM +0200, Svyatoslav Ryhel wrote:
> > Add binding for Cypress CG7153AM embedded controller. Pegatron implemen=
ted
> > a custom configuration of this MCU in their Chagall tablets, utilizing =
it
> > for battery monitoring.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/mfd/cypress,cg7153am.yaml        | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/cypress,cg715=
3am.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yam=
l b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> > new file mode 100644
> > index 000000000000..f8469b5e3816
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/cypress,cg7153am.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Infineon/Cypress Semicon CG7153AM Microcontroller
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  The CG7153AM, an 8-bit programmable microcontroller from Infineon/Cy=
press
> > +  Semiconductor, communicates over I2C and is implemented in devices l=
ike the
> > +  Pegatron Chagall tablet for fuel gauge and battery control functions=
.
> > +
> > +$ref: /schemas/power/supply/power-supply.yaml
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - pegatron,chagall-ec # Pegatron Chagall tablet device
> > +          - const: cypress,cg7153am
> > +      - items:
> > +          const: cypress,cg7153am
>
> Is this just some general purpose uC which could be used for anything
> and the interface exposed is Pegatron's invention. If so, then I'd drop
> the cypress,cg7153am compatible. What use would it be to software?
>

Yeah, Cypress made an MPU, Pegatron used it as a base to make a fuel gauge.

You propose smth like this?

      - items:
          - enum:
              - pegatron,chagall-ec # Pegatron Chagall tablet device
          - const: cypress,cg7153am

Without oneOf and second item or remove cypress,cg7153am entirely and
submit as pegatron,chagall-ec.yaml? Just to be clear.

I am fine with removing oneOf and items: const: cypress,cg7153am, but
I would like to preserve cypress,cg7153am as second compatible since
this is an actual MCU model.

Thanks.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  monitored-battery: true
> > +  power-supplies: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        embedded-controller@10 {
> > +            compatible =3D "pegatron,chagall-ec", "cypress,cg7153am";
> > +            reg =3D <0x10>;
> > +
> > +            monitored-battery =3D <&battery>;
> > +            power-supplies =3D <&mains>;
> > +        };
> > +    };
> > +...
> > --
> > 2.43.0
> >


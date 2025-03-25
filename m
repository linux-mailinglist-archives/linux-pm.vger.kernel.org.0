Return-Path: <linux-pm+bounces-24490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1613A6E9E2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 07:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BF5169529
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BC20459C;
	Tue, 25 Mar 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpkDX5jg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5C2E3367;
	Tue, 25 Mar 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885839; cv=none; b=ddsXeOa6L+61kDg/exAhUDC5i11vLH1RvOqUhrX2ZgMa+53jIjTD5H8gY4Koqnc8rml6lD0h09ZW7/P0Femuvoq9oge5aYoybl5mZhvbIfyF29ZGmgNCv7osm/3qvluNtsAfH9VUH9NTiPe1jCUpjLBOhynUWF7zutKUAbwZuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885839; c=relaxed/simple;
	bh=nubJe1Q57sCtS7tpBsPUyLcnGFJgq8kTtTqgavzVXpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdmRKhi+Hk9UXMkkQKYB0m0sCjxCEO4iam36bg9SFWubLek9tvXPHFNu+2pzSra+BRPoRCadRM23NFbyBVjakJ+24pMcAQfyW88mRXe4ELl5PcjeLV8fAi3K2iGNEaKHBnza+A6ePKqOKM7llbpShitlxAQ/NvSggPXjTPHsvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpkDX5jg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso47706965e9.2;
        Mon, 24 Mar 2025 23:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742885836; x=1743490636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k65APOhnqHaRwVdf0hVouqcw3j31GIBJHVdTpUSuBKE=;
        b=VpkDX5jg4qTBIMwXM9i6vVYbTZJHC84rRsoX+2ASkhNOa0BTIUe3qM0Q4UASzvAzpG
         ffXrYImXxcHaZE9d4yivQRDlRslLCrhOIJjesH/CpqYXWss/yk8Pdlv+qqtLKlY4wwsq
         +PdQIzd698csZ/oSmGPSQkwbbySRprKh/TnttfjkJojoSE7WuKMQZUJVt5Yh5+SIrykv
         w8779gBoeEkHAYmDApoPe08AGuQh33CIP8TkQV6wIydi5AT2993DIviP8w3r4xKv9RON
         m2wqnCrRNxvKDJzkHFMsl/izbuYwqCaybbmfHfEeJk5CYuQ6sMHMobKeTLKtVd40vMQJ
         LdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742885836; x=1743490636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k65APOhnqHaRwVdf0hVouqcw3j31GIBJHVdTpUSuBKE=;
        b=KUWTDaSGczDu5/Fm9MO4vQD3XEtCtCXY/BUl235m/oouA42bmtD0TYnDFOEfxfg1ss
         DbKwKiUN61lAnpUL6KyrglXgTgR7bpUF2S5hPAnhG3BRmlJwxWEYIRqOK0lcbBZNM4Gp
         eKgvPPpU7fncWluEAnAhbnkn4yqaQyw0j7OZ9T6/FRHnEfFEy3kIFTv8mTCzPhMzK2d7
         +gvERTit+8hOqorFPqA09Q61YAFK4kmJ8LsUYgRXSiGyxYaYGLZTjB90t07ZVSk/tLBW
         35HoGBv180qswePd6w4/vbNeKYLs//8UdQZ7Dykf7wdGXawQucui/AcauqgCKdyfJd0h
         PNEg==
X-Forwarded-Encrypted: i=1; AJvYcCV0x3FjibiodwyOfevSAs82NUD6fVoyCTqURc4V6sOsDWtUFe+AAZ1e/OCHjTqi1v6ndWID+GE6BKMnuSw=@vger.kernel.org, AJvYcCV3nrO3rihXJmgHikwzrjzCdWkZ0BCC8PSsndi5fqny2afy2yxuG1ubbu9k300tgpAVO7xbwYSwgg4YBQ2V@vger.kernel.org, AJvYcCWTWOzQTO0HUc4mMoGxcsjcwaKGs8YrDossiQCqZbadyvTsZ/TdBTUm0YfQPPj118LMDGBXKHwgBFBM@vger.kernel.org, AJvYcCWfsUEgsdVWSYPa+RBgHry9dMTTmq3Jit/FK3kAUf6SZm2WKdBm75MaPMFXxUdrK4eJg5jjX3WYNrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xd7/ftBzPjfLP1Dm9WoGiQYXMIKNu/0jQ9tNkjOHqd00zmJu
	7mA1GfRXN/OKmdbQQF2mkV7mfb6XOKVwiZe/nkbV2h9CfpaMqknZiOevPi299SXt71QS+6e7Hsu
	UmFzwjotFHaC+4N7Iwep4AVa6ISE=
X-Gm-Gg: ASbGncu+CftbwCHOAMJbu6ui8gN1QQyTXNPk0+Kel45OTmXLTvhNot4ZCDWmJgN+MFx
	8Y7WoSd25wfm6y0oGeI826Ps9YIWtMZ3DxMKMhDqtcjc8+S6AxRa514igiG5/Enm7kUj8c8BB85
	5+MgBoqTyDPKPe2Eycky7GifAAPk06iXyFTu2/wA==
X-Google-Smtp-Source: AGHT+IEn8uK6OcuXe4+4ZV0D1Yn8fN0XMYuQo7Z4S5x5OfABVLsYnevDbVXea+6E55YkcHbDVu4xegboKjhKSnnhnbE=
X-Received: by 2002:a05:600c:4512:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43d509ed7d2mr158951395e9.7.1742885835643; Mon, 24 Mar 2025
 23:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323071424.48779-1-clamor95@gmail.com> <20250323071424.48779-3-clamor95@gmail.com>
 <20250324165257.GA458528-robh@kernel.org> <CAPVz0n3=-QL1_NGP31WX_4LQBt5-T47BbU_yn6td1zk9C2T=iA@mail.gmail.com>
 <CAL_JsqLCW+zE2LfsVybuxn_xu1JwtLSXSbMNj-YYfVgtYhZcaQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLCW+zE2LfsVybuxn_xu1JwtLSXSbMNj-YYfVgtYhZcaQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Mar 2025 08:57:04 +0200
X-Gm-Features: AQ5f1Jo76E6Mm4Px7njxt-5XyFnOQUvdYlcF9GwjoI1ZpO7vOF99PZtNXOIgaYg
Message-ID: <CAPVz0n2EwGhCb3r7JTfM38YjyFmejeVbVRGxASqQ7EUH7MY9VQ@mail.gmail.com>
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

=D0=B2=D1=82, 25 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 05:00 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Mar 24, 2025 at 12:06=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> >
> > =D0=BF=D0=BD, 24 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:52 =
Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, Mar 23, 2025 at 09:14:22AM +0200, Svyatoslav Ryhel wrote:
> > > > Add binding for Cypress CG7153AM embedded controller. Pegatron impl=
emented
> > > > a custom configuration of this MCU in their Chagall tablets, utiliz=
ing it
> > > > for battery monitoring.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../bindings/mfd/cypress,cg7153am.yaml        | 55 +++++++++++++++=
++++
> > > >  1 file changed, 55 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/cypress,c=
g7153am.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mfd/cypress,cg7153am=
.yaml b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> > > > new file mode 100644
> > > > index 000000000000..f8469b5e3816
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> > > > @@ -0,0 +1,55 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mfd/cypress,cg7153am.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Infineon/Cypress Semicon CG7153AM Microcontroller
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +description:
> > > > +  The CG7153AM, an 8-bit programmable microcontroller from Infineo=
n/Cypress
> > > > +  Semiconductor, communicates over I2C and is implemented in devic=
es like the
> > > > +  Pegatron Chagall tablet for fuel gauge and battery control funct=
ions.
> > > > +
> > > > +$ref: /schemas/power/supply/power-supply.yaml
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - pegatron,chagall-ec # Pegatron Chagall tablet devi=
ce
> > > > +          - const: cypress,cg7153am
> > > > +      - items:
> > > > +          const: cypress,cg7153am
> > >
> > > Is this just some general purpose uC which could be used for anything
> > > and the interface exposed is Pegatron's invention. If so, then I'd dr=
op
> > > the cypress,cg7153am compatible. What use would it be to software?
> > >
> >
> > Yeah, Cypress made an MPU, Pegatron used it as a base to make a fuel ga=
uge.
> >
> > You propose smth like this?
> >
> >       - items:
> >           - enum:
> >               - pegatron,chagall-ec # Pegatron Chagall tablet device
> >           - const: cypress,cg7153am
> >
> > Without oneOf and second item or remove cypress,cg7153am entirely and
> > submit as pegatron,chagall-ec.yaml? Just to be clear.
> >
> > I am fine with removing oneOf and items: const: cypress,cg7153am, but
> > I would like to preserve cypress,cg7153am as second compatible since
> > this is an actual MCU model.
>
> I would just drop the cypress compatible entirely. It needs to be
> useful to a client (OS) in some way. If you said something like the
> firmware downloading is defined by Cypress or some other feature, then
> it would make sense. Otherwise, how this interface is implemented is
> irrelevant. I can't think of any other embedded controller where we
> have a compatible for the underlying MCU.
>

So I will move this schema to power supplies and name it
pegratron,chagall-ec.yaml along with suggested changes in the
compatible and descriptions.

> Rob


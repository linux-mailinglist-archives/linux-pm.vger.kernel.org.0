Return-Path: <linux-pm+bounces-24488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F907A6E872
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97A57A25A6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D43176AB5;
	Tue, 25 Mar 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkxmB9m5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D929408;
	Tue, 25 Mar 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742871612; cv=none; b=a34ov0Thwede/CuxNqyzH89JT3ksfsIlWPleCne2F2HtvxuYGlqfZtSfF5Pn8YIaO+idnuocl1s7ngA/e7kU2KGPfXhvPYXlz89Mp7LbZ1ej6JHGKcm/7VEattD+nCaNOGIqpfU1tK/ORjRELEF1WvvAvvCvBEKP4/liYCAaWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742871612; c=relaxed/simple;
	bh=kdPMBibLH/yez18tp3tlaahIu5VsHTU259fGn/4jyQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJVlngQVp9TtJUkFsA79Om4H203Qgd9g0jN2ieQG9Pjjzo0PHcIov0xvovBYhpRhEsC9QBY/iswT01xVl38ThSCL53v5vEGjqfkiMAY0GqPtJVrXdAYhD0Ms7iQBMxCMHwPWfjvr4zbBgUPQHL1qtDJrwJ+EyrHS4wHr5/VbPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkxmB9m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EADC4CEDD;
	Tue, 25 Mar 2025 03:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742871612;
	bh=kdPMBibLH/yez18tp3tlaahIu5VsHTU259fGn/4jyQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DkxmB9m513BCDmqfq6M8Mm5MX+1h0K8ISn8PTtOoIPerDR7um/wMv77YtmWfmz2nZ
	 fjdYCty2HfSs7IQhWAE2XeRbRDhIfywHUOhIqQI25Gm8k3agUI41LnWtZ+k/+LtAm3
	 OKhs4vvF938iEX8bNDOFs0TcFc9RxDiEmSKBuX+wz9zMbvM0dCbp0Gb4j3Q/qV9X5o
	 qfZKM/HH5IA3HwuBa3Y+r6cYuIqGiYxFYnbpdR4Gd4/Q6w7tLIBZlCW30g0EL3ZgES
	 +vLaPw0vMR8sjRiCc8CdjtdIOVMG5CDsrySX0WMgS6/XmHU2tTll/R8gnH+0Sxgops
	 UqTnqvH8kX6Dw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so9032138a12.3;
        Mon, 24 Mar 2025 20:00:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy9sZMEQ55VYyBZLxDQv/KqTS7Xpsit4B5cwOUJE2HxpTO/f+9u9PX8xc/KGgCekaMl/Eq/1IoC5Hs5UqL@vger.kernel.org, AJvYcCVwT6Mdp758LfbQjmJlTkg4M3JE8D1i7u16qWoXCZjm9NUU8/NhG8zhy2dbcv9/gbbY4vvvM86HWaQC@vger.kernel.org, AJvYcCXSALVGQOZvw4MiHI2vTqN9sufvDnYMmiqer7BMYV4zFuHOAKSk36GxACzoEv+DPoKLl+XcfqdYE4wcux4=@vger.kernel.org, AJvYcCXldsxGbKjjJ8FOPNg0uDm7vD06am/c5AzWDKm09PMDuEruiqkrPZLi3qFRG57fdEKvXhzYmgnHtD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV91zKGomy1X/ttxjO9C3Ct85fyf2oL4j2DaFDLYZdy0NY6QVw
	tdA8lUEbVUXHW9Ubk6pomJwOGK8K9yPuagIQbHyXZT3/idAE0mu8yiPmrbJQ9uKIoVxAMwRo9uI
	IA3lCy+AtBhz2YzH2SOAfbq+PAg==
X-Google-Smtp-Source: AGHT+IE3QSDPASR1s+nvT5rVlKy95tLrHztKiVeza2RPpLc3nhGJkSRj8CDw6TvAGMN64kzNpUhRLGwyYJxd3/EHS/k=
X-Received: by 2002:a17:907:2d92:b0:ac2:7cf9:71a0 with SMTP id
 a640c23a62f3a-ac3f251fba6mr1525711466b.48.1742871610756; Mon, 24 Mar 2025
 20:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323071424.48779-1-clamor95@gmail.com> <20250323071424.48779-3-clamor95@gmail.com>
 <20250324165257.GA458528-robh@kernel.org> <CAPVz0n3=-QL1_NGP31WX_4LQBt5-T47BbU_yn6td1zk9C2T=iA@mail.gmail.com>
In-Reply-To: <CAPVz0n3=-QL1_NGP31WX_4LQBt5-T47BbU_yn6td1zk9C2T=iA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Mar 2025 21:59:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCW+zE2LfsVybuxn_xu1JwtLSXSbMNj-YYfVgtYhZcaQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpysCtkCUgcjLane3iayaPg4HSVsmHDOlKr6Lj27dEl2msQmnjpD8eCuPc
Message-ID: <CAL_JsqLCW+zE2LfsVybuxn_xu1JwtLSXSbMNj-YYfVgtYhZcaQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: mfd: Document Infineon/Cypress
 CG7153AM MCU
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:06=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> =D0=BF=D0=BD, 24 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:52 Ro=
b Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sun, Mar 23, 2025 at 09:14:22AM +0200, Svyatoslav Ryhel wrote:
> > > Add binding for Cypress CG7153AM embedded controller. Pegatron implem=
ented
> > > a custom configuration of this MCU in their Chagall tablets, utilizin=
g it
> > > for battery monitoring.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../bindings/mfd/cypress,cg7153am.yaml        | 55 +++++++++++++++++=
++
> > >  1 file changed, 55 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/cypress,cg7=
153am.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/cypress,cg7153am.y=
aml b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> > > new file mode 100644
> > > index 000000000000..f8469b5e3816
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> > > @@ -0,0 +1,55 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/cypress,cg7153am.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Infineon/Cypress Semicon CG7153AM Microcontroller
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description:
> > > +  The CG7153AM, an 8-bit programmable microcontroller from Infineon/=
Cypress
> > > +  Semiconductor, communicates over I2C and is implemented in devices=
 like the
> > > +  Pegatron Chagall tablet for fuel gauge and battery control functio=
ns.
> > > +
> > > +$ref: /schemas/power/supply/power-supply.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - pegatron,chagall-ec # Pegatron Chagall tablet device
> > > +          - const: cypress,cg7153am
> > > +      - items:
> > > +          const: cypress,cg7153am
> >
> > Is this just some general purpose uC which could be used for anything
> > and the interface exposed is Pegatron's invention. If so, then I'd drop
> > the cypress,cg7153am compatible. What use would it be to software?
> >
>
> Yeah, Cypress made an MPU, Pegatron used it as a base to make a fuel gaug=
e.
>
> You propose smth like this?
>
>       - items:
>           - enum:
>               - pegatron,chagall-ec # Pegatron Chagall tablet device
>           - const: cypress,cg7153am
>
> Without oneOf and second item or remove cypress,cg7153am entirely and
> submit as pegatron,chagall-ec.yaml? Just to be clear.
>
> I am fine with removing oneOf and items: const: cypress,cg7153am, but
> I would like to preserve cypress,cg7153am as second compatible since
> this is an actual MCU model.

I would just drop the cypress compatible entirely. It needs to be
useful to a client (OS) in some way. If you said something like the
firmware downloading is defined by Cypress or some other feature, then
it would make sense. Otherwise, how this interface is implemented is
irrelevant. I can't think of any other embedded controller where we
have a compatible for the underlying MCU.

Rob


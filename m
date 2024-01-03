Return-Path: <linux-pm+bounces-1805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A9823732
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 22:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6784C282284
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA21D6AC;
	Wed,  3 Jan 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrSnE4AW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99FC1D69F;
	Wed,  3 Jan 2024 21:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55517C433CA;
	Wed,  3 Jan 2024 21:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704317980;
	bh=LWx123NZ1ObXk+US3se5dBAsEYkeO/OWi0jTs+LLqD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JrSnE4AWZjQOIxvVz75isiEFo/ckO4WGHAQVfy8UyVxxNTp8NqFxr9HAAHS3BWj2b
	 zFAHEkbTZxRdkekIn6ktQaV0Z7tX7o8W545RaF13Ry4dNZFjXLouSHobRLB2lqlr7U
	 gou4/9fhcAr7E50W0DX+7w0miBXPz0sU3E/S8P3ViDt7IifmQdA+rRs2N40sBrJeKn
	 7xHfNUKO/AeKDbeNxAh1mNKcwdmD/xBhawDG0WYdbzPSlVs9WhOOwlrID8WzwNZn0o
	 jSt0RUK1jfdbw+lXg43PMTsemifynVoKdh/DAttSvjMSp/jheczQq4zss/g2JYXVen
	 8KS8/xzfw/RMw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso190856e87.0;
        Wed, 03 Jan 2024 13:39:40 -0800 (PST)
X-Gm-Message-State: AOJu0YyqnxVGNoVHvN3bcYLw0wWoGKYheHaA9gmeQEK1epSXLO3/XZjX
	dESBGYlEuaQ7HQeb6Ro0TonPN2l4ck9G8s09IA==
X-Google-Smtp-Source: AGHT+IGU/DVjS9ZEcFLWx7hc1PdqIq8lvoA9bpoKv+PWURLpzZr+N9VqACO4Wv1xLvDstW8/gtOGPhFzW/ZZIPPwI8w=
X-Received: by 2002:ac2:5fa6:0:b0:50e:7e5d:672e with SMTP id
 s6-20020ac25fa6000000b0050e7e5d672emr1023259lfe.24.1704317978482; Wed, 03 Jan
 2024 13:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928222130.580487-1-festevam@gmail.com> <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
 <20231209-singular-tighten-eef5f7909dcd@spud> <a591318fbba10b764075e9395ddd9f7f@denx.de>
 <20231210-stimulant-halogen-e3aaca2279c5@spud> <20231210153749.GA4141628-robh@kernel.org>
 <20231214-smoked-extending-a76e33621470@spud>
In-Reply-To: <20231214-smoked-extending-a76e33621470@spud>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jan 2024 14:39:26 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJ=5zU8NurxJ_b0DKOy6=fo1==yYh=A42R4nvXsCJEKXA@mail.gmail.com>
Message-ID: <CAL_JsqJ=5zU8NurxJ_b0DKOy6=fo1==yYh=A42R4nvXsCJEKXA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
To: Conor Dooley <conor@kernel.org>
Cc: Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org, 
	rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:13=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sun, Dec 10, 2023 at 09:37:49AM -0600, Rob Herring wrote:
> > On Sun, Dec 10, 2023 at 02:52:45PM +0000, Conor Dooley wrote:
> > > On Sat, Dec 09, 2023 at 05:59:17PM -0300, Fabio Estevam wrote:
> > > > Hi Conor,
> > > >
> > > > On 09/12/2023 17:23, Conor Dooley wrote:
> > > >
> > > > > You're adding the constraints and items at the wrong level AFAICT=
.
> > > > > I think something like the below better matches your constraints?
> > > >
> > > > Thanks for your example.
> > > >
> > > > With your change the fsl,imx93-tmu case works correctly:
> > > > if I pass the number of fsl,tmu-range entries different than 7,
> > > > dt_binding_check correctly complains.
> > > >
> > > > However, if I pass 7 entries to fsl,qoriq-tmu it should complain as=
 it
> > > > expects 4, but it
> > >
> > > btw, unrelated - minItems seems (from a grep) like it needs to be 2 n=
ot
> > > 4.
> > >
> > > > does not.
> > > >
> > > > On top of your patch:
> > > >
> > > > --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > > > +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> > > > @@ -104,7 +104,7 @@ additionalProperties: false
> > > >  examples:
> > > >    - |
> > > >      tmu@f0000 {
> > > > -        compatible =3D "fsl,imx93-tmu";
> > > > +        compatible =3D "fsl,qoriq-tmu";
> > > >          reg =3D <0xf0000 0x1000>;
> > > >          interrupts =3D <18 2 0 0>;
> > > >          fsl,tmu-range =3D <0x000a0000 0x00090026 0x0008004a 0x0001=
006a 0 0
> > > > 0>;
> > > >
> > > > make dt_binding_check DT_SCHEMA_FILES=3Dqoriq-thermal.yaml
> > > >   LINT    Documentation/devicetree/bindings
> > > >   DTEX
> > > > Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dts
> > > >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > >   DTC_CHK
> > > > Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dtb
> > > >
> > > > Any suggestions?
> > >
> > > I dunno. I spent far far longer than I would like to admit trying to =
fix
> > > this. Firstly my suggestion here is crap I think and only applies to
> > > ___matrices___. I think it needs to be the way you had it in your dif=
f,
> > > but I cannot figure out why it doesn't apply the maxItems constraint.
> > >
> > > Perhaps Rob or Krzysztof can figure out what we were overlooking.
> > > The diff in question was something like:
> >
> > I suspect something is going afoul in the fixups. Will look at it
> > tomorrow.
>
> Did you manage to figure out what was causing this btw?

Yes. There's not really an immediate fix I see. The issue is in the
if/then schemas we don't have enough information to know the type of
fsl,tmu-range. To work correctly, it needs to be transformed to:

fsl,tmu-range:
  items:
    minItems: 7
    maxItems: 7

This goes back to everything gets encoded into a 2 dim matrix, but the
schemas try to hide this encoding. My plan here is to eventually drop
doing that and decode properties to their correct type. That will drop
a lot of the fixups. I have patches to do that, but then it has other
corner cases.

So short term, I'd just leave things such that they don't warn or just
drop the conditional.

Rob


Return-Path: <linux-pm+bounces-411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D159F7FBF93
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C394282A27
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE7058AD2;
	Tue, 28 Nov 2023 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMNENkx2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0A5ABA8;
	Tue, 28 Nov 2023 16:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B4C43391;
	Tue, 28 Nov 2023 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701190232;
	bh=EzBRlUdWtojgmIuIil4jL3QpKF01LdWaXfWJK6/lfmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VMNENkx24ar0AG4kwNEYcgD1fSGnUzsV5M3CHnUFO95egvPKXcs8CIHswGVwlfl6l
	 nDNUPK0lTZI8jfaobG+zK7b7Dp6uVnpUviAqkN/DgWbmdpde6NAUe3HyN5izn6spz7
	 jXm+ILJ1pPgniPvCDQdM98lrg7evfKgcI447CfDBcvIg20BiPRB9IJCP+ad/whBVRH
	 Tu7vVFazyKvv9jkDxDUxyEtK487wPU0/bBku1chV3NOHAxVTn8qp4nWuFO00vaPNv9
	 z4TcY8HLzyWggufLvtv6djLehkO8/O9oyZ0+vvkMSjMHqM0EPnL7RSYmrvcDUU4Rit
	 7Ixxt6GfZ3kfw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso7977219e87.2;
        Tue, 28 Nov 2023 08:50:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yw6Tfjv6VyEfmRJq+v0VYIR5oArlA8g92/48L4C+D91cQN+H2CP
	J3GYtJ7MPKBC3H49m0nCTf8snycmZwChMzaKkQ==
X-Google-Smtp-Source: AGHT+IHKVOIZpOAytolK6Nl+aWI1xmuii6vKwSdFNSAZfLUktVONq4m16q+G98GlafInI1ClKOH6O12EgOfFC3bMslQ=
X-Received: by 2002:a05:6512:929:b0:508:1a25:a190 with SMTP id
 f9-20020a056512092900b005081a25a190mr8734195lft.23.1701190230229; Tue, 28 Nov
 2023 08:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com> <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <20231128143309.38a4ce61@donnerap.manchester.arm.com> <4e90608e-aca5-4b57-be76-350ad54f9e7c@linaro.org>
 <20231128161010.26657e76@donnerap.manchester.arm.com>
In-Reply-To: <20231128161010.26657e76@donnerap.manchester.arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 28 Nov 2023 10:50:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9J1=+gZ83QyedAWbFN=AwSB8ue+o4TM7F6yu5_62z3g@mail.gmail.com>
Message-ID: <CAL_Jsq+9J1=+gZ83QyedAWbFN=AwSB8ue+o4TM7F6yu5_62z3g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
To: Andre Przywara <andre.przywara@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Martin Botka <martin.botka@somainline.org>, Bob McChesney <bob@electricworry.net>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Icenowy Zheng <icenowy@aosc.io>, Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 10:10=E2=80=AFAM Andre Przywara <andre.przywara@arm=
.com> wrote:
>
> On Tue, 28 Nov 2023 15:48:18 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
> Hi,
>
> (adding Maxime for the syscon question below)
>
> > On 28/11/2023 15:33, Andre Przywara wrote:
> > > On Tue, 28 Nov 2023 08:43:32 +0100
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > >> On 28/11/2023 01:58, Andre Przywara wrote:
> > >>>
> > >>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_no=
de *node)
> > >>> +{
> > >>> + struct device_node *syscon_node;
> > >>> + struct platform_device *syscon_pdev;
> > >>> + struct regmap *regmap =3D NULL;
> > >>> +
> > >>> + syscon_node =3D of_parse_phandle(node, "syscon", 0);
> > >>
> > >> Nope. For the 100th time, this cannot be generic.

Unless it is the 100th time for the submitter, please just point to
the documentation.

Can we simply ban "syscon" as a property name? It looks like we have
65 cases in upstream dts files. Maybe that's doable. This is where we
need levels of warnings with okay for existing vs. don't use in new
designs.

> > > OK. Shall this name refer to the required functionality (temperature
> > > offset fix) or to the target syscon node (like allwinner,misc-syscon)=
.
> > > The problem is that this is really a syscon, as in: "random collectio=
n of
> > > bits that we didn't know where else to put in", so "syscon" alone act=
ually
> > > says it all.
> >
> > Every syscon is a "random collection of bits...", but not every "random
> > collection of bits..." is a syscon.
> >
> > Your target device does not implement syscon nodes. Your Linux
> > implementation does not use it as syscon. Therefore if something does
> > not look like syscon and does not behave like syscon, it is not a sysco=
n.
> >
> > I looked at the bit and this is SRAM, not syscon. I am sorry, but it is
> > something entirely different and we have a binding for it: "sram", I th=
ink.
>
> Well, it's somehow both: On the face of it it's a SRAM controller, indeed=
:
> it can switch the control of certain SRAM regions between CPU access and
> peripheral access (for the video and the display engine). But then it's
> also a syscon, because on top of that, it also controls those random bits=
,
> for instance the EMAC clock register, and this ominous THS bit.
> I guess in hindsight we should have never dropped that "syscon" string
> then, but I am not sure if adding it back has side effects?
>
> And as I mentioned in the cover letter: modelling this as some SRAM
> region, as you suggest, might be an alternative, but it doesn't sound rig=
ht
> either, as I don't think it really is one: I just tried in U-Boot, and I
> can write and read the whole SRAM C region just fine, with and without th=
e
> bit set. And SRAM content is preserved, even with the thermal sensor
> running and the bit cleared (or set).
>
> So adding the "syscon" to the compatible would fix most things, but then
> we need to keep the open coded lookup code in dwmac-sun8i.c (because olde=
r
> DTs would break otherwise).

Really, I'd like to get rid of the "syscon" compatible. It is nothing
more than a flag for Linux to create a regmap.

Not a fully baked idea, but perhaps what is needed is drivers that
request a regmap for a node simply get one regardless. That kind of
throws out the Linux driver model though. Alternatively with no
"syscon" compatible, we'd have to have table(s) of 100s of compatibles
in the kernel.

Rob


Return-Path: <linux-pm+bounces-517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833017FDDF8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E6282817
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F213C6AB;
	Wed, 29 Nov 2023 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210DBC;
	Wed, 29 Nov 2023 09:09:27 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso4343042b3a.0;
        Wed, 29 Nov 2023 09:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277766; x=1701882566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XT90raft4qh6RNwHKuCeh4qMI9GaXwyHHdgJokFFRM=;
        b=jW4t5B2YuSjsBdsfdm4zS1QdyGH+YOAriQonDxIksfkCgtcNlsJ5Em9ubq07SEsH9u
         DwP1ePdxZFMJyNTZLqKO04Z1mYE8S2+qjDrUEhhuLa2guWq+Ia/Ym57Pzkr5XIS+3Yln
         jjHI5oLfUmOcu6xSnVFHpI+IILKVw99Tzq/Us1xd73dLZmC2OI/qqdNmojK5bqgvdR2p
         EiAsFalQ2axjVLTgV9EPMyq3Nvm4QjWfmpwnZU6jjfNfsKsFIu9waGMZekd0mHTct2uw
         437AfnHOmbhIAui9QHtPpJP7vNDccdZh/rTye+ekGbp7ea6QBEwh25qsyHuaidgL0sg+
         1NPQ==
X-Gm-Message-State: AOJu0YzP5bfNiZ12bO/GJTN3d0CmwOkGmu/u9t1Lp1/B2F6fl1S3kQbE
	op/Tsrru8VLIPM9TfGf9/w+6R+rr8EI=
X-Google-Smtp-Source: AGHT+IEbMICfQfeTrstDLSoCiW8838DofX7bwUGIRGE9Y1Mo1mnNHfY48zKbQyy3iyZZtM7b07v82g==
X-Received: by 2002:a05:6a00:3a0b:b0:6cb:bb92:1ce6 with SMTP id fj11-20020a056a003a0b00b006cbbb921ce6mr23371392pfb.18.1701277766286;
        Wed, 29 Nov 2023 09:09:26 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id f44-20020a056a000b2c00b006c4d1bb81d6sm10952626pfu.67.2023.11.29.09.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 09:09:24 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-285bcb577d6so3621571a91.3;
        Wed, 29 Nov 2023 09:09:23 -0800 (PST)
X-Received: by 2002:a17:90b:3884:b0:285:d803:8945 with SMTP id
 mu4-20020a17090b388400b00285d8038945mr10586265pjb.46.1701277763468; Wed, 29
 Nov 2023 09:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com> <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <20231128143309.38a4ce61@donnerap.manchester.arm.com> <4e90608e-aca5-4b57-be76-350ad54f9e7c@linaro.org>
 <20231128161010.26657e76@donnerap.manchester.arm.com> <CAL_Jsq+9J1=+gZ83QyedAWbFN=AwSB8ue+o4TM7F6yu5_62z3g@mail.gmail.com>
 <a097a613-14c1-4a53-bbe1-c44964e7ecaa@arm.com>
In-Reply-To: <a097a613-14c1-4a53-bbe1-c44964e7ecaa@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 30 Nov 2023 01:09:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64mEyk_hZ=9wExzN5oF3frB7EimTHBSc_c98_pHO6inuA@mail.gmail.com>
Message-ID: <CAGb2v64mEyk_hZ=9wExzN5oF3frB7EimTHBSc_c98_pHO6inuA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Thu, Nov 30, 2023 at 1:03=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi,
>
> On 28/11/2023 16:50, Rob Herring wrote:
> > On Tue, Nov 28, 2023 at 10:10=E2=80=AFAM Andre Przywara <andre.przywara=
@arm.com> wrote:
> >>
> >> On Tue, 28 Nov 2023 15:48:18 +0100
> >> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> (adding Maxime for the syscon question below)
> >>
> >>> On 28/11/2023 15:33, Andre Przywara wrote:
> >>>> On Tue, 28 Nov 2023 08:43:32 +0100
> >>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>>> On 28/11/2023 01:58, Andre Przywara wrote:
> >>>>>>
> >>>>>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_n=
ode *node)
> >>>>>> +{
> >>>>>> + struct device_node *syscon_node;
> >>>>>> + struct platform_device *syscon_pdev;
> >>>>>> + struct regmap *regmap =3D NULL;
> >>>>>> +
> >>>>>> + syscon_node =3D of_parse_phandle(node, "syscon", 0);
> >>>>>
> >>>>> Nope. For the 100th time, this cannot be generic.
> >
> > Unless it is the 100th time for the submitter, please just point to
> > the documentation.
> >
> > Can we simply ban "syscon" as a property name? It looks like we have
> > 65 cases in upstream dts files. Maybe that's doable. This is where we
> > need levels of warnings with okay for existing vs. don't use in new
> > designs.
> >
> >>>> OK. Shall this name refer to the required functionality (temperature
> >>>> offset fix) or to the target syscon node (like allwinner,misc-syscon=
).
> >>>> The problem is that this is really a syscon, as in: "random collecti=
on of
> >>>> bits that we didn't know where else to put in", so "syscon" alone ac=
tually
> >>>> says it all.
> >>>
> >>> Every syscon is a "random collection of bits...", but not every "rand=
om
> >>> collection of bits..." is a syscon.
> >>>
> >>> Your target device does not implement syscon nodes. Your Linux
> >>> implementation does not use it as syscon. Therefore if something does
> >>> not look like syscon and does not behave like syscon, it is not a sys=
con.
> >>>
> >>> I looked at the bit and this is SRAM, not syscon. I am sorry, but it =
is
> >>> something entirely different and we have a binding for it: "sram", I =
think.
> >>
> >> Well, it's somehow both: On the face of it it's a SRAM controller, ind=
eed:
> >> it can switch the control of certain SRAM regions between CPU access a=
nd
> >> peripheral access (for the video and the display engine). But then it'=
s
> >> also a syscon, because on top of that, it also controls those random b=
its,
> >> for instance the EMAC clock register, and this ominous THS bit.
> >> I guess in hindsight we should have never dropped that "syscon" string
> >> then, but I am not sure if adding it back has side effects?
> >>
> >> And as I mentioned in the cover letter: modelling this as some SRAM
> >> region, as you suggest, might be an alternative, but it doesn't sound =
right
> >> either, as I don't think it really is one: I just tried in U-Boot, and=
 I
> >> can write and read the whole SRAM C region just fine, with and without=
 the
> >> bit set. And SRAM content is preserved, even with the thermal sensor
> >> running and the bit cleared (or set).
> >>
> >> So adding the "syscon" to the compatible would fix most things, but th=
en
> >> we need to keep the open coded lookup code in dwmac-sun8i.c (because o=
lder
> >> DTs would break otherwise).
> >
> > Really, I'd like to get rid of the "syscon" compatible. It is nothing
> > more than a flag for Linux to create a regmap.
>
> Yeah, so thinking about it indeed feels a bit like we are changing the
> DT here to cater for some Linux implementation detail. After all we
> already access the regmap successfully in dwmac-sun8i.c, is that
> approach frowned upon (because: driver model) and just tolerated because
> it's already in the code base?
>
> > Not a fully baked idea, but perhaps what is needed is drivers that
> > request a regmap for a node simply get one regardless. That kind of > t=
hrows out the Linux driver model though. Alternatively with no
> > "syscon" compatible, we'd have to have table(s) of 100s of compatibles
> > in the kernel.
>
> So do you mean to either just remove the explicit syscon compatible
> check in syscon_node_to_regmap(), or replace it with a check against a
> list of allowed devices?

There is already device_node_to_regmap() which skips the check. It still
bypasses the driver model though.

> Wouldn't it be sufficient to leave that check to the (syscon-like)
> devices, by them exporting a regmap in the first place or not? And we
> can do filtering of accesses there, like we do in sunxi_sram.c?
>
> Cheers,
> Andre
>
>
> >
> > Rob


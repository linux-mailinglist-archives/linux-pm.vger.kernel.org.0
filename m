Return-Path: <linux-pm+bounces-346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C67FB540
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F2A1C210EF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F73D39A;
	Tue, 28 Nov 2023 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F76D45;
	Tue, 28 Nov 2023 01:09:34 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b837d974ecso3248260b6e.2;
        Tue, 28 Nov 2023 01:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701162574; x=1701767374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1bBKfqAHcjtu3PVaC+NxvAALk+R4fESRpmVw3GnKYA=;
        b=K8w3pyNp3V7eI3TGNTzCFHrC0ZLdLEeBGze1pA7HjO1TjnLi/PdCxPkbaBxAWJgmEe
         6cMzYWgLeCvaphuf9QrBzMJtjlz3cEyVwEJilpltl9LcvyU616/9waHhUca3Fa9bKJDQ
         XCnJYlaaRU2Wog0MeP9JnJgIiSsATjkcRsVbj+qcS57ow4p5nDqElks577OezrN5R01B
         /HPaQhvyL1QVL/Ni9yCu7TER1+R/PC/pwyBAhV5NcxsZUYAtlCdMKwnoTf/llLED1j5S
         ROC8iwYpDMlOWhWSBea/x4gypD6e9EBEg75tf92vr8mtiuEv8UclKWBUofqVC2+rlq3x
         pRsw==
X-Gm-Message-State: AOJu0YxxvhtmUX34oX36hnZpnGufVnB/VLwSNVKdA1IKUggN9BhTqvtq
	ncQC75uT/m8UAUsdeDO8Q0P+WRweN7Pd2g==
X-Google-Smtp-Source: AGHT+IEA913EhPCpikBq++116cjmPSj8WBTfzPn6npeiwy6XBj4TpI2ij1oJ9Yer0e24/UaFKbuEjA==
X-Received: by 2002:a05:6808:1483:b0:3a7:1e3e:7f97 with SMTP id e3-20020a056808148300b003a71e3e7f97mr18565404oiw.4.1701162573607;
        Tue, 28 Nov 2023 01:09:33 -0800 (PST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b0068be3489b0dsm8767053pfo.172.2023.11.28.01.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:09:32 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cf856663a4so36140405ad.3;
        Tue, 28 Nov 2023 01:09:32 -0800 (PST)
X-Received: by 2002:a17:90a:e7c8:b0:285:b6cb:6ab1 with SMTP id
 kb8-20020a17090ae7c800b00285b6cb6ab1mr8458811pjb.28.1701162572407; Tue, 28
 Nov 2023 01:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com> <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <CAGb2v66YpYBS78C7H-O3zef2NTs+7=ec3A7jrZ+DxjYEyBmWxQ@mail.gmail.com>
 <9045f837-3370-46e9-8631-7464c796d643@linaro.org> <CAGb2v66PFNz++d3_5smYBL_BRirYhu4SvX0j36y0JsmXHT33OQ@mail.gmail.com>
 <CAGb2v66L+sW-GQ4HvR-rXsG=JTi6vKt-9P-y1=vPqh0e5gKiOg@mail.gmail.com>
In-Reply-To: <CAGb2v66L+sW-GQ4HvR-rXsG=JTi6vKt-9P-y1=vPqh0e5gKiOg@mail.gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Nov 2023 17:09:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Om8xqpgacbXV9Qf0tbV5qDcSOs7gW-uqSh2HD3Hhu3A@mail.gmail.com>
Message-ID: <CAGb2v64Om8xqpgacbXV9Qf0tbV5qDcSOs7gW-uqSh2HD3Hhu3A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Martin Botka <martin.botka@somainline.org>, Bob McChesney <bob@electricworry.net>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 5:02=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Nov 28, 2023 at 4:59=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> wrot=
e:
> >
> > On Tue, Nov 28, 2023 at 4:30=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 28/11/2023 08:50, Chen-Yu Tsai wrote:
> > > > On Tue, Nov 28, 2023 at 3:43=E2=80=AFPM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 28/11/2023 01:58, Andre Przywara wrote:
> > > >>>
> > > >>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_=
node *node)
> > > >>> +{
> > > >>> +     struct device_node *syscon_node;
> > > >>> +     struct platform_device *syscon_pdev;
> > > >>> +     struct regmap *regmap =3D NULL;
> > > >>> +
> > > >>> +     syscon_node =3D of_parse_phandle(node, "syscon", 0);
> > > >>
> > > >> Nope. For the 100th time, this cannot be generic.
> > > >>
> > > >>> +     if (!syscon_node)
> > > >>> +             return ERR_PTR(-ENODEV);
> > > >>> +
> > > >>> +     syscon_pdev =3D of_find_device_by_node(syscon_node);
> > > >>> +     if (!syscon_pdev) {
> > > >>> +             /* platform device might not be probed yet */
> > > >>> +             regmap =3D ERR_PTR(-EPROBE_DEFER);
> > > >>> +             goto out_put_node;
> > > >>> +     }
> > > >>> +
> > > >>> +     /* If no regmap is found then the other device driver is at=
 fault */
> > > >>> +     regmap =3D dev_get_regmap(&syscon_pdev->dev, NULL);
> > > >>> +     if (!regmap)
> > > >>> +             regmap =3D ERR_PTR(-EINVAL);
> > > >>
> > > >> Aren't you open-coding existing API to get regmap from syscon?
> > > >
> > > > Not really. This is to get a regmap exported by the device. Syscon'=
s regmap
> > > > is not tied to the device at all.
> > >
> > > I am talking about open-coding existing API. Look at syscon.h.
> >
> > The underlying implementation is different.
> >
> > syscon maintains its own mapping of device nodes to regmaps, and create=
s
> > regmaps when none exist. The regmap is not tied to any struct device.
> > syscon basically exists outside of the driver model and one has no cont=
rol
> > over what is exposed because it is meant for blocks that are a collecti=
on
> > of random stuff.
>
> My bad. I failed to realize there is a platform device driver for syscon,
> in addition to the existing "no struct device" implementation.

Actually that doesn't do anything on DT platforms as of commit bdb0066df96e
("mfd: syscon: Decouple syscon interface from platform devices"). All the
regmaps are, as I previously stated, not tied to any struct device.

> > Here the provider device registers the (limited) regmap it wants to pro=
vide,
> > tying the new regmap to itself. The consumer gets it via the dev_get_re=
gmap()
> > call. The provider has a main function and isn't exposing that part of =
its
> > register map to the outside; only the random bits that were stuffed in =
are.
> >
> > > > With this scheme a device to could export just enough registers for=
 the
> > > > consumer to use, instead of the whole address range.
> > > >
> > > > We do this in the R40 clock controller as well, which has some bits=
 that
> > > > tweak the ethernet controllers RGMII delay...
> > >
> > > Not related.
> >
> > Related as in that is possibly what this code was based on, commit
> > 49a06cae6e7c ("net: stmmac: dwmac-sun8i: Allow getting syscon regmap
> > from external device").
> >
> >
> > ChenYu


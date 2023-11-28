Return-Path: <linux-pm+bounces-345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D27FB528
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 10:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766E51C2105C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF46358AC;
	Tue, 28 Nov 2023 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E94138;
	Tue, 28 Nov 2023 01:02:17 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cd89f2af9dso2171454b3a.1;
        Tue, 28 Nov 2023 01:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701162136; x=1701766936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4LAqQU1wA4ivqpHWCEk999ohmlO5witUfv7lMNY8w=;
        b=ay7PexDe4DsSp5nukg2FXhnshzElb2eeKRLzmyL/1YZksQpesgFNoVU5Eb8+g/5y7c
         EiJLYQNJdh1LSdeyF27M54b4Kvdehxz47vCbdSLaXbs5rN/cBIwhTEYX/pRndymRigXm
         33mjWzTz0SyAbHtLDTsmkiyMhcxmnzh1PbVhsqoxpBJIXcAtJ6mDFtjVA3NZRHZNJ1mc
         gA5QJVQCt1Ong8rr/8v5CHCsIiGPx4g56hlhFPH1SwXx2kdCi8PYsU3UmAASTfXq5czz
         wezgGGS8f2mvmgzLQKZNyphOxHsSoGN/TB7QtfNOh1hQF00mh3d2wG5RymFSVbzXeUiv
         eyPg==
X-Gm-Message-State: AOJu0YwjJoXZgYfi1EgHNBazi2+NXCgOIreRFiyowM2ZOB6E8xBsQ40J
	RKZg8hP+Vn7jfgHMapkTJIthCVNflMkEyw==
X-Google-Smtp-Source: AGHT+IECKBKEKAkqEOQCB1OnF84IxcjfemRETNwPwTWoUhJ0h8o9qv7+fV0sluONo2LkHN3d5x4viA==
X-Received: by 2002:a05:6a21:6d98:b0:18c:376d:fbe8 with SMTP id wl24-20020a056a216d9800b0018c376dfbe8mr12664526pzb.41.1701162136014;
        Tue, 28 Nov 2023 01:02:16 -0800 (PST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com. [209.85.215.169])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001cfd2b088fasm3079588plg.134.2023.11.28.01.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:02:14 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c206572eedso4098635a12.0;
        Tue, 28 Nov 2023 01:02:14 -0800 (PST)
X-Received: by 2002:a17:90b:33cb:b0:285:d550:994b with SMTP id
 lk11-20020a17090b33cb00b00285d550994bmr5940155pjb.40.1701162133957; Tue, 28
 Nov 2023 01:02:13 -0800 (PST)
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
In-Reply-To: <CAGb2v66PFNz++d3_5smYBL_BRirYhu4SvX0j36y0JsmXHT33OQ@mail.gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Nov 2023 17:02:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v66L+sW-GQ4HvR-rXsG=JTi6vKt-9P-y1=vPqh0e5gKiOg@mail.gmail.com>
Message-ID: <CAGb2v66L+sW-GQ4HvR-rXsG=JTi6vKt-9P-y1=vPqh0e5gKiOg@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 4:59=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Nov 28, 2023 at 4:30=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 28/11/2023 08:50, Chen-Yu Tsai wrote:
> > > On Tue, Nov 28, 2023 at 3:43=E2=80=AFPM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 28/11/2023 01:58, Andre Przywara wrote:
> > >>>
> > >>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_no=
de *node)
> > >>> +{
> > >>> +     struct device_node *syscon_node;
> > >>> +     struct platform_device *syscon_pdev;
> > >>> +     struct regmap *regmap =3D NULL;
> > >>> +
> > >>> +     syscon_node =3D of_parse_phandle(node, "syscon", 0);
> > >>
> > >> Nope. For the 100th time, this cannot be generic.
> > >>
> > >>> +     if (!syscon_node)
> > >>> +             return ERR_PTR(-ENODEV);
> > >>> +
> > >>> +     syscon_pdev =3D of_find_device_by_node(syscon_node);
> > >>> +     if (!syscon_pdev) {
> > >>> +             /* platform device might not be probed yet */
> > >>> +             regmap =3D ERR_PTR(-EPROBE_DEFER);
> > >>> +             goto out_put_node;
> > >>> +     }
> > >>> +
> > >>> +     /* If no regmap is found then the other device driver is at f=
ault */
> > >>> +     regmap =3D dev_get_regmap(&syscon_pdev->dev, NULL);
> > >>> +     if (!regmap)
> > >>> +             regmap =3D ERR_PTR(-EINVAL);
> > >>
> > >> Aren't you open-coding existing API to get regmap from syscon?
> > >
> > > Not really. This is to get a regmap exported by the device. Syscon's =
regmap
> > > is not tied to the device at all.
> >
> > I am talking about open-coding existing API. Look at syscon.h.
>
> The underlying implementation is different.
>
> syscon maintains its own mapping of device nodes to regmaps, and creates
> regmaps when none exist. The regmap is not tied to any struct device.
> syscon basically exists outside of the driver model and one has no contro=
l
> over what is exposed because it is meant for blocks that are a collection
> of random stuff.

My bad. I failed to realize there is a platform device driver for syscon,
in addition to the existing "no struct device" implementation.


ChenYu

> Here the provider device registers the (limited) regmap it wants to provi=
de,
> tying the new regmap to itself. The consumer gets it via the dev_get_regm=
ap()
> call. The provider has a main function and isn't exposing that part of it=
s
> register map to the outside; only the random bits that were stuffed in ar=
e.
>
> > > With this scheme a device to could export just enough registers for t=
he
> > > consumer to use, instead of the whole address range.
> > >
> > > We do this in the R40 clock controller as well, which has some bits t=
hat
> > > tweak the ethernet controllers RGMII delay...
> >
> > Not related.
>
> Related as in that is possibly what this code was based on, commit
> 49a06cae6e7c ("net: stmmac: dwmac-sun8i: Allow getting syscon regmap
> from external device").
>
>
> ChenYu


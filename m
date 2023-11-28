Return-Path: <linux-pm+bounces-344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1857FB50F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 09:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8612AB2149C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114A35889;
	Tue, 28 Nov 2023 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0908F4;
	Tue, 28 Nov 2023 00:59:32 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b88f2a37deso10192b6e.0;
        Tue, 28 Nov 2023 00:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161972; x=1701766772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5icATiMvArGEI8Y7AopIfPdtrmtXjYdJv85ysHZJSc=;
        b=Sbu8SKovFwguGqD94rRPlTDz5sbW4TnIgtcX3BULA9rTMtxG1WJ6vRPYmKB+XWDAZn
         bkTupumy/97o+Ksu/zzyOnsp9+8Ui3XxaaXDMU/IcVPg9Tezl81A5WsdfhSJsZpFprBw
         ldgMNBzkuTH3QS4c2+FoN2RUk9zz8cM5V5NpIHfk9PN9Arn3B/c3TNMI7H3Tnz6zoptB
         dWjoiaWJtae1WOedOB6MoNcuvFYzb1va9qrS7llRjyhi3gV3P85nufM+5W13ciRzKqE7
         Zv1C6MrCZKZGIxcx5xta9jWhQgDgonGdolZZ6aoxCymSvgfgAnciXBITX2uZ8m96oCsd
         2DYA==
X-Gm-Message-State: AOJu0YwlXDQdnhkbQT9pA+Zy8pgaVXOYC4Tia4VaHYqtGWkNH/mTDN4Z
	6NBjKIh6TBNP3E+lAuUpNSJZ7pHUWmvWYg==
X-Google-Smtp-Source: AGHT+IEyJKuLetr5g5lqrJ40Vc/Zrifb+B+Y+KMxXQlExiw/P3q9fTbW5nyM/kNMIt4j+0GDAiU3Bg==
X-Received: by 2002:a05:6808:1910:b0:3b8:5bee:6ba7 with SMTP id bf16-20020a056808191000b003b85bee6ba7mr15528667oib.7.1701161971760;
        Tue, 28 Nov 2023 00:59:31 -0800 (PST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b006c0316485f9sm8507213pfa.64.2023.11.28.00.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:59:31 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c239897895so3522741a12.2;
        Tue, 28 Nov 2023 00:59:31 -0800 (PST)
X-Received: by 2002:a05:6a21:81a9:b0:18b:cd15:b832 with SMTP id
 pd41-20020a056a2181a900b0018bcd15b832mr12679124pzb.42.1701161971126; Tue, 28
 Nov 2023 00:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com> <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <CAGb2v66YpYBS78C7H-O3zef2NTs+7=ec3A7jrZ+DxjYEyBmWxQ@mail.gmail.com> <9045f837-3370-46e9-8631-7464c796d643@linaro.org>
In-Reply-To: <9045f837-3370-46e9-8631-7464c796d643@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Nov 2023 16:59:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v66PFNz++d3_5smYBL_BRirYhu4SvX0j36y0JsmXHT33OQ@mail.gmail.com>
Message-ID: <CAGb2v66PFNz++d3_5smYBL_BRirYhu4SvX0j36y0JsmXHT33OQ@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 4:30=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/11/2023 08:50, Chen-Yu Tsai wrote:
> > On Tue, Nov 28, 2023 at 3:43=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 28/11/2023 01:58, Andre Przywara wrote:
> >>>
> >>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node=
 *node)
> >>> +{
> >>> +     struct device_node *syscon_node;
> >>> +     struct platform_device *syscon_pdev;
> >>> +     struct regmap *regmap =3D NULL;
> >>> +
> >>> +     syscon_node =3D of_parse_phandle(node, "syscon", 0);
> >>
> >> Nope. For the 100th time, this cannot be generic.
> >>
> >>> +     if (!syscon_node)
> >>> +             return ERR_PTR(-ENODEV);
> >>> +
> >>> +     syscon_pdev =3D of_find_device_by_node(syscon_node);
> >>> +     if (!syscon_pdev) {
> >>> +             /* platform device might not be probed yet */
> >>> +             regmap =3D ERR_PTR(-EPROBE_DEFER);
> >>> +             goto out_put_node;
> >>> +     }
> >>> +
> >>> +     /* If no regmap is found then the other device driver is at fau=
lt */
> >>> +     regmap =3D dev_get_regmap(&syscon_pdev->dev, NULL);
> >>> +     if (!regmap)
> >>> +             regmap =3D ERR_PTR(-EINVAL);
> >>
> >> Aren't you open-coding existing API to get regmap from syscon?
> >
> > Not really. This is to get a regmap exported by the device. Syscon's re=
gmap
> > is not tied to the device at all.
>
> I am talking about open-coding existing API. Look at syscon.h.

The underlying implementation is different.

syscon maintains its own mapping of device nodes to regmaps, and creates
regmaps when none exist. The regmap is not tied to any struct device.
syscon basically exists outside of the driver model and one has no control
over what is exposed because it is meant for blocks that are a collection
of random stuff.

Here the provider device registers the (limited) regmap it wants to provide=
,
tying the new regmap to itself. The consumer gets it via the dev_get_regmap=
()
call. The provider has a main function and isn't exposing that part of its
register map to the outside; only the random bits that were stuffed in are.

> > With this scheme a device to could export just enough registers for the
> > consumer to use, instead of the whole address range.
> >
> > We do this in the R40 clock controller as well, which has some bits tha=
t
> > tweak the ethernet controllers RGMII delay...
>
> Not related.

Related as in that is possibly what this code was based on, commit
49a06cae6e7c ("net: stmmac: dwmac-sun8i: Allow getting syscon regmap
from external device").


ChenYu


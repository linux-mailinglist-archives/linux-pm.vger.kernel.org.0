Return-Path: <linux-pm+bounces-336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033797FB330
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 08:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341691C20C0A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A01214280;
	Tue, 28 Nov 2023 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB0183;
	Mon, 27 Nov 2023 23:51:03 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1cfd04a6e49so14393655ad.0;
        Mon, 27 Nov 2023 23:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157863; x=1701762663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZTbUDFfHVLDwriMDujX8TewNkfqrMRUeFStaGwrzB8=;
        b=DSHtglary/FfCQ/oZWkKZXeUs4vxynYMRKpbHpwVx8hbOIb3O72DEmdwHrOPXBT946
         FySSqTcFjQ6ffTzGivsvaN9SjMZC4u1BAN1DTfcHw8wRyRN0wZC3cxTcE0v/T6eTtT2M
         yJPYKz9E4SJWTYNCpqavMeu1NJrOwZZhmJPM7vVOmbMn2OT4F3P+C8AByLrxYxf78i6w
         1YUXyNrGkJ+3+wDzf48PpCKYtrj63lkk8n72iPrdUS9XkowkDC3TRGuN/B/E92RFL0GS
         mtiRwmC3m4GlnIdKMJdsQt5toXw/TgQkTsILrvvPFHVI3n3fsnib49sahtPZ42YdXzHD
         FJvQ==
X-Gm-Message-State: AOJu0YwsgkWvtUXdnidl5CmOX3mwufjNLDQP7pEJ1xI70cGo1oeS+xbA
	oG6TzUzULHXGYPGnGWTSl6ml1R++o1/rkw==
X-Google-Smtp-Source: AGHT+IFGZFs/ZH2HamEBGS4ZFy53/u/C7TfZwOPX9dXIxFFt2zezxRvp1gL7gbUfAbneYEKHQhHfZA==
X-Received: by 2002:a17:903:2303:b0:1d0:1e4:cd5a with SMTP id d3-20020a170903230300b001d001e4cd5amr619390plh.3.1701157862781;
        Mon, 27 Nov 2023 23:51:02 -0800 (PST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001bbb8d5166bsm9614339plb.123.2023.11.27.23.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 23:51:02 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5bdfbd69bd5so4499353a12.1;
        Mon, 27 Nov 2023 23:51:02 -0800 (PST)
X-Received: by 2002:a17:90a:ca08:b0:283:967c:4e6 with SMTP id
 x8-20020a17090aca0800b00283967c04e6mr25448690pjt.12.1701157862365; Mon, 27
 Nov 2023 23:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com> <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
In-Reply-To: <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Nov 2023 15:50:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v66YpYBS78C7H-O3zef2NTs+7=ec3A7jrZ+DxjYEyBmWxQ@mail.gmail.com>
Message-ID: <CAGb2v66YpYBS78C7H-O3zef2NTs+7=ec3A7jrZ+DxjYEyBmWxQ@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 3:43=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/11/2023 01:58, Andre Przywara wrote:
> >
> > +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node *=
node)
> > +{
> > +     struct device_node *syscon_node;
> > +     struct platform_device *syscon_pdev;
> > +     struct regmap *regmap =3D NULL;
> > +
> > +     syscon_node =3D of_parse_phandle(node, "syscon", 0);
>
> Nope. For the 100th time, this cannot be generic.
>
> > +     if (!syscon_node)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     syscon_pdev =3D of_find_device_by_node(syscon_node);
> > +     if (!syscon_pdev) {
> > +             /* platform device might not be probed yet */
> > +             regmap =3D ERR_PTR(-EPROBE_DEFER);
> > +             goto out_put_node;
> > +     }
> > +
> > +     /* If no regmap is found then the other device driver is at fault=
 */
> > +     regmap =3D dev_get_regmap(&syscon_pdev->dev, NULL);
> > +     if (!regmap)
> > +             regmap =3D ERR_PTR(-EINVAL);
>
> Aren't you open-coding existing API to get regmap from syscon?

Not really. This is to get a regmap exported by the device. Syscon's regmap
is not tied to the device at all.

With this scheme a device to could export just enough registers for the
consumer to use, instead of the whole address range.

We do this in the R40 clock controller as well, which has some bits that
tweak the ethernet controllers RGMII delay...


ChenYu


Return-Path: <linux-pm+bounces-11338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975393A279
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043651F23FE0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8D154435;
	Tue, 23 Jul 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nvu9xkiW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B815252E
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744238; cv=none; b=Xo/KcazlF0YuK0aAUAK20rZ30xFPaRK6IWH+cOHqBFBooRLEO8NST072C9Lip+9qIAtkZ04MCEDvAEREqJPt7xVCf9UO/L0GdP76LWsEpSPXFA3/qOc1vvyso7G5x/GayyiJVOdAK3ZRZSxEv4fpWzsCbnqHhrBFfEXyWofjJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744238; c=relaxed/simple;
	bh=D9+b60LC1tfU5iylwRPsHJ6vdTPquP5bMApeaOGOToI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=O4SM/iAxA966cD1ei5FDOHmOiQkjm514j1PUS+GeBL4t+ME6OydButX8dZFAhrk5FSJB72B7d34QRJBbTuIzfZdQulg6/bfDF0bFD0ukRKE92PBioeZcwDEJoC9zXa3/8Psar3ozOpoeVsx8L0gUWlr8QFFtUSnmOjFj66dsiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Nvu9xkiW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240723141715euoutp0272d1bd2f59f5df36fe0c29bb0c85c144~k3UKCdQK70468704687euoutp02C
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240723141715euoutp0272d1bd2f59f5df36fe0c29bb0c85c144~k3UKCdQK70468704687euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721744235;
	bh=D9+b60LC1tfU5iylwRPsHJ6vdTPquP5bMApeaOGOToI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nvu9xkiWguodMcmhY/OmqOOi5FHZf+WLKuIGTr5S+NIIAcwW9di3FCTmZ6OqFVGXs
	 lp8Gpgy+XPp8T4IXIEl5lld9jeA/OeiCzGDlerf13jdegJ+l/m1u2uDUUjGkbPddcd
	 Rt1jfMv89a+yhaScivdJf1Qf4hxaurb8i2wExJ7Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240723141714eucas1p29e6d0d859490a697f6049b6fae3e3a5e~k3UJtxDVo2443924439eucas1p2b;
	Tue, 23 Jul 2024 14:17:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.1A.09875.A6BBF966; Tue, 23
	Jul 2024 15:17:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240723141714eucas1p1de8e11114883d4dadbffec2a102f92fc~k3UJTApHF1287512875eucas1p1K;
	Tue, 23 Jul 2024 14:17:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240723141714eusmtrp1dbac3798ddb7a3a0639b57c1bb3c7803~k3UJSU0Sl1462214622eusmtrp1R;
	Tue, 23 Jul 2024 14:17:14 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-72-669fbb6a9d30
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.56.08810.A6BBF966; Tue, 23
	Jul 2024 15:17:14 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240723141713eusmtip15ccceb3ea2122bec3b6b23f1dd9f196a~k3UIfOtAi2621426214eusmtip1d;
	Tue, 23 Jul 2024 14:17:13 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 3/6] drivers/thermal/exynos: check IS_ERR(data->clk)
 consistently
Date: Tue, 23 Jul 2024 16:17:05 +0200
Message-ID: <20240723141707.374772-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4=NnmSNp30mm04-38j8r9Uy2MUbq28Ua7=aT13uo=NH=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djP87pZu+enGaw5ZGTxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52Mdm8bxvH5ODgMeaeWsYPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H
	35ZVjB6fN8kFcERx2aSk5mSWpRbp2yVwZSx5so+pYD1rxbuHjYwNjItYuhg5OSQETCSmXOpi
	7WLk4hASWMEo0XPsOhuE84VR4sXVjSwQzmdGiWeNDYxdjBxgLY+uSkPElzNKzH+9nBnCaWWS
	WPTqKyvIXDYBA4kHb5axg9giAnoS62a+YgcpYhbYzCJx4elMVpBJwgLhEn8+KIGYLAKqEqub
	EkHKeQVsJR627mODOE9eond/HxOIzSkQKNHa/ZwZokZQ4uTMJ2AvMAPVNG+dDXaDhMBkTolr
	C9dCNbtI/F32BOpPYYlXx7ewQ9gyEqcn90DF8yVmbH7PAvFYhcTdg14QprXExzPMICazgKbE
	+l36EMWOEiuarzJBVPBJ3HgrCHEAn8SkbdOZIcK8Eh1tQhDVqhLH90xihrClJZ603Ibq9JB4
	f1R+AqPiLCSfzELyySyEtQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJrXT/45/
	2cG4/NVHvUOMTByMhxglOJiVRHifvJqbJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUgg
	PbEkNTs1tSC1CCbLxMEp1cDEaqQavKDs0d4ZnYsV5sdfz/UNCmjen2d5mm/Cgf6X0ssv7DFj
	WS2Ueir/RcmNWOH69pV5JpPUEtRipVvTk01bwu9Ne3HVKfWCRPrEUocPtTFPj6+ojwu6dvC5
	9r7GP4fZ5zj0vDup0TAzMH49p++7or3+uWfO9/69LyC5av2S0qALN9qnGsUevWPD+sfXU1ay
	XtmL4Wj6/vTY6JWbtr6fZ5yYlDDLObjlJKdq+Z/uE8phXI/rt8z95iMe9ZB/ydvJHlz/LFv3
	qJq1PY8OWPHm3aPe7XVzH/hsqrxq8G75nX9ntdONbj1NeHdR78filyorrXmUb5iqNb7zvO75
	q/yx9x6lmbFtzjetZ75sceFTYinOSDTUYi4qTgQAm78d69kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7pZu+enGWx7IWXxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52Mdm8bxvH5ODgMeaeWsYPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H
	35ZVjB6fN8kFcETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZSx5so+pYD1rxbuHjYwNjItYuhg5OCQETCQeXZXuYuTiEBJYyihxevp69i5GTqC4
	tMThL1OgbGGJP9e62EBsIYFmJonJaxVBbDYBA4kHb5aB1YgI6Emsm/mKHWQQs8BBFom+11eY
	QRYIC4RKbP/mAGKyCKhKrG5KBCnnFbCVeNi6jw1ivLxE7/4+JhCbUyBQorX7OTPEKh6JVxv2
	M0LUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6hUn5haX5qXrJefn
	bmIExuC2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrxPXs1NE+JNSaysSi3Kjy8qzUktPsRoCnT2
	RGYp0eR8YBLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgMv2w
	Y62cuXb0ydulP8ODFqZ0xE08fsdzy/vWwLVB0X0mrLM4XzP5/D/4QqgkjH3V3VWzs/14duxu
	eGialfvVYv/6G4/nPV5w0HDB70fK7TFFJ5wyvmhyGd/JZWwr2VqXV6fwuv7koy4d6/NGKle1
	3kua/OhXz4xOdzkauab7keye/BTmFZNny9ekKQYIK/ec3nZt610mnmwF9hLOnVdcUm+VNnxT
	d7hQdmJCXvm38mlm694nVRzxunOUxaXmxutlmzsPnhMy3/nuRFRFrFBg1W/5fYdZHLXfHVxu
	b51p3CY4IVvDVWih7MXww094I0u+yvi1n14fkKJWsHrL5sK3BzhUHPMeBptetFMRf12mxFKc
	kWioxVxUnAgAV77yLUoDAAA=
X-CMS-MailID: 20240723141714eucas1p1de8e11114883d4dadbffec2a102f92fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240723141714eucas1p1de8e11114883d4dadbffec2a102f92fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240723141714eucas1p1de8e11114883d4dadbffec2a102f92fc
References: <CGME20240723141714eucas1p1de8e11114883d4dadbffec2a102f92fc@eucas1p1.samsung.com>

> Also, if it's only optional for Exynos850 (and not optional for other
> chips), maybe it would be a good idea to use *_optional_* API only for
> Exynos850 case, so that the driver's behavior for those chips stays
> unchanged.

Probably should just set the clock to NULL in case of 850 then?

> Btw, from the downstream kernel code [1] I can see that the only TMU
> clock present in Exynos850 is
> GOUT_BLK_PERI_UID_BUSIF_TMU_IPCLKPORT_PCLK (which I was able to
> confirm in TRM). But it's not enabled in clk-exynos850.c driver right
> now. Do you want me by chance to send the patch adding it?

Would be very grateful :) If nothing else, it would be useful for
testing.


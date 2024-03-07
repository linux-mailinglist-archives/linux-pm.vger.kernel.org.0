Return-Path: <linux-pm+bounces-4769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A27874E56
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 12:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E1D1F2864A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055CB12839C;
	Thu,  7 Mar 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X3UhcUky"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78515129A61
	for <linux-pm@vger.kernel.org>; Thu,  7 Mar 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812477; cv=none; b=qyOKlaMprhdAr7Qq5fQsnWPnxo2rU0LemfsIXTRHqDgjwYm4imXf2s0i3ksywI9MC1A6ydW2vPy6rGr8u8/FvWfuUQKz1RWgJcNMrwrl6IcXEhcuadVisWL00oPEKcEIJ1M0jAiXpaB0DKAUx5ptddQS4zrEQ1gjJ1bChC95Qk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812477; c=relaxed/simple;
	bh=S+OOB+GK6VFrLU913soTUn1itPxHtbfjSIr8cNPFaSs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Dm1BEukqe6zcv6GWycLxGdGKOFTf+heMMaZRuM54T4TyEVt82z1PEAuzIxPGAjfo7L8MRWwOKFpfcBG6tGkGpWOnwgO6R/nGiM1y0FslWPBS51BQsRT6zIbBqUrAkzYVktr12FBZS5qt0DXuRhPGCyjjywP12pzZKKNTL+/h/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X3UhcUky; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240307115427epoutp014602dbbc4cb83059e3508b77ca917f36~6eWFbAxX92752027520epoutp01H
	for <linux-pm@vger.kernel.org>; Thu,  7 Mar 2024 11:54:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240307115427epoutp014602dbbc4cb83059e3508b77ca917f36~6eWFbAxX92752027520epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709812467;
	bh=S+OOB+GK6VFrLU913soTUn1itPxHtbfjSIr8cNPFaSs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=X3UhcUkyX80pkHsHAEJRyj7zhb+q855DKIx+31ZXPs9w3nLzshOEj4/e8I/bpTezF
	 haCg3ESDGQnXeAuSv0xzC95wNsE0y8IMXRObpIa0xj5K3DImzhiN542uHzc4suvsXj
	 xzOqaoTZYqZCvEUNyAyKKaVgwyTy+2nixucktkJo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240307115426epcas1p4cbca85f882d1daff4f2bc0c8469a9925~6eWEZNKax0713107131epcas1p4j;
	Thu,  7 Mar 2024 11:54:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Tr74x4l5Qz4x9Pv; Thu,  7 Mar
	2024 11:54:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.D0.10211.1FAA9E56; Thu,  7 Mar 2024 20:54:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240307115424epcas1p3dae7021656de57990d7b9c84b06229bd~6eWCse3-00080400804epcas1p3B;
	Thu,  7 Mar 2024 11:54:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240307115424epsmtrp27a490503a98e3f1df497644f7709d732~6eWCrvFlE0263602636epsmtrp2X;
	Thu,  7 Mar 2024 11:54:24 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-3c-65e9aaf134ec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.23.18939.0FAA9E56; Thu,  7 Mar 2024 20:54:24 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240307115424epsmtip1801a154e2cadb80324364524bbc607d7~6eWCVpCVq0677806778epsmtip19;
	Thu,  7 Mar 2024 11:54:24 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= <u.kleine-koenig@pengutronix.de>,
	"'MyungJoo Ham'" <myungjoo.ham@samsung.com>, "'Kyungmin Park'"
	<kyungmin.park@samsung.com>
Cc: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Alim
	Akhtar'" <alim.akhtar@samsung.com>, <linux-pm@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
 <kernel@pengutronix.de>, "'Matthias Brugger'" <matthias.bgg@gmail.com>,
	"'AngeloGioacchino Del Regno'" <angelogioacchino.delregno@collabora.com>,
	<linux-mediatek@lists.infradead.org>, "'Chen-Yu Tsai'" <wens@csie.org>,
	"'Jernej	Skrabec'" <jernej.skrabec@gmail.com>, "'Samuel Holland'"
	<samuel@sholland.org>, <linux-sunxi@lists.linux.dev>
In-Reply-To: <cover.1709587301.git.u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 0/5] PM / devfreq: Convert to platform remove callback
 returning void
Date: Thu, 7 Mar 2024 20:54:24 +0900
Message-ID: <002101da7086$32fe0dd0$98fa2970$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFzxRFSFHCd7QkDGmNm1eZX/JQK7QIZjy18sei1t8A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmnu7HVS9TDZYvUrB4MG8bm8WllRIW
	z+evY7RYNXUni8Xe11vZLc42vWG32PT4GqvF5eaLjBafe48wWsw4v4/JYsq+XWwWTS3GFrcb
	V7BZPH/UyWZxe+JkRoufh84zOQh47Li7hNFjw6PVrB47Z91l97hzbQ+bx+Yl9R4vNs9k9Oj/
	a+DRt2UVo8err3MZPT5vkgvgisq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
	yEvMTbVVcvEJ0HXLzAF6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFqgV5yY
	W1yal66Xl1piZWhgYGQKVJiQnbFj1RTmgi6piq5XUQ2MayW7GDk5JARMJG5+72LqYuTiEBLY
	wShx7slUFgjnE6PEh8Y5THDO5QeHmGBaLk2/D2YLCexklDizKBGi6CWjREvfBqB2Dg42AR2J
	BT9CQeIiAiuA4hPOsYM0MAtsYJH4+CAXxOYUcJJYc6uJDcQWFoiWaOifAmazCKhI3Jh+iRnE
	5hWwlNh/dh87hC0ocXLmExaIOdoSyxa+ZoY4SEHi59NlrCC2iICVxPctL6FqRCRmd7Yxgxwh
	IfCFQ+L4ob1sEA0uEn9ezmWEsIUlXh3fwg5hS0l8fgdSA9IwmVHi4uvXUN3rGSU2rmyBWmcs
	sX/pZCaQN5kFNCXW79KH2MYn8e5rDytIWEKAV6KjTQiiWhkYcnehIScpsbi9kw2ixENi1jKX
	CYyKs5C8NgvJa7OQvDALYdcCRpZVjGKpBcW56anFhgUm8MhOzs/dxAhO41oWOxjnvv2gd4iR
	iYPxEKMEB7OSCC+LxctUId6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwPzCR5JfGGJpYGJmZG
	xiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwhe/JDLO/XP3sX8W6V0wOYv/Xh3rM
	jJjrt+/EreqDpx5dY419wmz3Q9+k2KZ9t6nz04MJZ9YvXx48tcZzacbkt5qdPSIvrNI85h85
	/UXozf1zAaVPNi+V7NkVd+DqX4VvD+9f+sj4cPGhvb175qxTvzp9lcqMberXd4ova/6T8Sr4
	5QQ1je56udmyqbf0eTr79zoGc7Zv/Sc6RyvrYdUHh8X6nVxJx8Mm2v7cm+5/+czBxZk71Let
	WTuDiym7TyXJJ7BMZdnp+8qmFx8d88/kiPp86O3dF/EWmZUN7ToMGz+qn5l278KpbnWJoy5n
	X71tEVvpy576c9v/0KgtTste/dIp2ebdnatXemp/1EaWPfFKLMUZiYZazEXFiQCRPAmGbAQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO6HVS9TDZrvyVo8mLeNzeLSSgmL
	5/PXMVqsmrqTxWLv663sFmeb3rBbbHp8jdXicvNFRovPvUcYLWac38dkMWXfLjaLphZji9uN
	K9gsnj/qZLO4PXEyo8XPQ+eZHAQ8dtxdwuix4dFqVo+ds+6ye9y5tofNY/OSeo8Xm2cyevT/
	NfDo27KK0ePV17mMHp83yQVwRXHZpKTmZJalFunbJXBlrJj7k6WgU7hizWKTBsZ3/F2MnBwS
	AiYSl6bfZ+pi5OIQEtjOKHF33iVGiISkxLSLR5m7GDmAbGGJw4eLIWqeM0rMu97MAhJnE9CR
	WPAjFCQuIrCCUeLLkxXMIA6zwC4WiUsrzjNDdExmlOi//RtsKqeAk8SaW01sILawQKTE/PO9
	7CA2i4CKxI3pl5hBbF4BS4n9Z/exQ9iCEidnPmEBsZkFtCWe3nwKZy9b+JoZ4lIFiZ9Pl7GC
	2CICVhLft7yEqhGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZVjGKphYU56bnJhcY6hUn5haX
	5qXrJefnbmIEx7JW0A7GZev/6h1iZOJgPMQowcGsJMLLYvEyVYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjivck5nipBAemJJanZqakFqEUyWiYNTqoEpq9Hg6/oJvg4SVj8ZdnUp1ChNq/WWVb22
	I9duhdlz79yDV64md+15wPjEZsK7VFHdU+Y7Rf+0nX/eO+EcxxHeCre7QsofpD59tfV2Wd/n
	sFCxSsn48sOMJ6r8Eu7bn6x57Tz98+Ome7n3njx6vuCyjckcK+/Q+Y1SznFCN7d6RWlHHEpW
	DGOZXmizvVM8QXxf5NT3r98IXnzF/t9Fryjwm25yQE3izkrnJZwax1ruLPVdF2YbfYFp00Xz
	iKtMguX1sf6WOXUcklme82e9Orb4xRadKm0lHoO7bkFb1JwCv0xddUAgOPGc+uR3E/wWvSrg
	WflIrct99sqn6ba2hxLNOYX2a/YoqObsSNQ6Wa3EUpyRaKjFXFScCAD6dlbgVAMAAA==
X-CMS-MailID: 20240307115424epcas1p3dae7021656de57990d7b9c84b06229bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240304212922epcas1p3f9a8c4fdf976f6d6266e3129bfcfb00c
References: <CGME20240304212922epcas1p3f9a8c4fdf976f6d6266e3129bfcfb00c@epcas1p3.samsung.com>
	<cover.1709587301.git.u.kleine-koenig@pengutronix.de>



> -----Original Message-----
> From: Uwe Kleine-K=C3=B6nig=20<u.kleine-koenig=40pengutronix.de>=0D=0A>=
=20Sent:=20Tuesday,=20March=205,=202024=206:29=20AM=0D=0A>=20To:=20Chanwoo=
=20Choi=20<cw00.choi=40samsung.com>;=20MyungJoo=20Ham=0D=0A>=20<myungjoo.ha=
m=40samsung.com>;=20Kyungmin=20Park=20<kyungmin.park=40samsung.com>=0D=0A>=
=20Cc:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>;=20Alim=
=20Akhtar=0D=0A>=20<alim.akhtar=40samsung.com>;=20linux-pm=40vger.kernel.or=
g;=20linux-arm-=0D=0A>=20kernel=40lists.infradead.org;=20linux-samsung-soc=
=40vger.kernel.org;=0D=0A>=20kernel=40pengutronix.de;=20Matthias=20Brugger=
=20<matthias.bgg=40gmail.com>;=0D=0A>=20AngeloGioacchino=20Del=20Regno=20<a=
ngelogioacchino.delregno=40collabora.com>;=20linux-=0D=0A>=20mediatek=40lis=
ts.infradead.org;=20Chen-Yu=20Tsai=20<wens=40csie.org>;=20Jernej=20Skrabec=
=0D=0A>=20<jernej.skrabec=40gmail.com>;=20Samuel=20Holland=20<samuel=40shol=
land.org>;=20linux-=0D=0A>=20sunxi=40lists.linux.dev=0D=0A>=20Subject:=20=
=5BPATCH=200/5=5D=20PM=20/=20devfreq:=20Convert=20to=20platform=20remove=20=
callback=0D=0A>=20returning=20void=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20=0D=
=0A>=20this=20series=20converts=20all=20drivers=20below=20drivers/devfreq=
=20to=20struct=0D=0A>=20platform_driver::remove_new().=20See=20commit=205c5=
a7680e67b=20(=22platform:=20Provide=20a=0D=0A>=20remove=20callback=20that=
=20returns=20no=20value=22)=20for=20an=20extended=20explanation=20and=20the=
=0D=0A>=20eventual=20goal.=0D=0A>=20=0D=0A>=20All=20conversations=20are=20t=
rivial,=20because=20their=20.remove()=20callbacks=20returned=0D=0A>=20zero=
=20unconditionally.=0D=0A>=20=0D=0A>=20There=20are=20no=20interdependencies=
=20between=20these=20patches,=20so=20they=20could=20be=20picked=0D=0A>=20up=
=20individually.=20But=20I'd=20hope=20that=20they=20get=20picked=20up=20all=
=20together=20by=20the=0D=0A>=20devfreq=20maintainers.=0D=0A>=20=0D=0A>=20B=
est=20regards=0D=0A>=20Uwe=0D=0A>=20=0D=0A>=20Uwe=20Kleine-K=C3=B6nig=20(5)=
:=0D=0A>=20=20=20PM=20/=20devfreq:=20exynos-nocp:=20Convert=20to=20platform=
=20remove=20callback=20returning=0D=0A>=20void=0D=0A>=20=20=20PM=20/=20devf=
req:=20exynos-ppmu:=20Convert=20to=20platform=20remove=20callback=20returni=
ng=0D=0A>=20void=0D=0A>=20=20=20PM=20/=20devfreq:=20mtk-cci:=20Convert=20to=
=20platform=20remove=20callback=20returning=20void=0D=0A>=20=20=20PM=20/=20=
devfreq:=20rk3399_dmc:=20Convert=20to=20platform=20remove=20callback=20retu=
rning=0D=0A>=20void=0D=0A>=20=20=20PM=20/=20devfreq:=20sun8i-a33-mbus:=20Co=
nvert=20to=20platform=20remove=20callback=20returning=0D=0A>=20void=0D=0A>=
=20=0D=0A>=20=20drivers/devfreq/event/exynos-nocp.c=20=7C=206=20++----=0D=
=0A>=20drivers/devfreq/event/exynos-ppmu.c=20=7C=206=20++----=0D=0A>=20=20d=
rivers/devfreq/mtk-cci-devfreq.c=20=20=20=7C=206=20++----=0D=0A>=20=20drive=
rs/devfreq/rk3399_dmc.c=20=20=20=20=20=20=20=20=7C=206=20++----=0D=0A>=20=
=20drivers/devfreq/sun8i-a33-mbus.c=20=20=20=20=7C=206=20++----=0D=0A>=20=
=205=20files=20changed,=2010=20insertions(+),=2020=20deletions(-)=0D=0A>=20=
=0D=0A>=20base-commit:=2067908bf6954b7635d33760ff6dfc189fc26ccc89=0D=0A>=20=
--=0D=0A>=202.43.0=0D=0A>=20=0D=0A=0D=0AApplied=20it.=20Thanks.=0D=0A=0D=0A=
Best=20Regards,=0D=0AChanwoo=20Choi=0D=0A=0D=0A=0D=0A


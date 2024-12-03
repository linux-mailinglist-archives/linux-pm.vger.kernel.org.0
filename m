Return-Path: <linux-pm+bounces-18395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EAE9E10AF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 02:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAED281D0A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25068C11;
	Tue,  3 Dec 2024 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q47MkIi5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615D2500C5
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188332; cv=none; b=Gb4+l28gX27UYZ9shf5CkF1r0KulwYz7NO8ZBefhtKmZ/I64caeiJJhg9fL9xMeFCTK3Ds/YoozZOKJTa3n9i56G8SZJnMabocSxWSEYRjPrdgAGwLipdilStIJe0yWyKHzAjwiVuvYxTgdL3DamZA3V56+ThCIlfASORp/eH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188332; c=relaxed/simple;
	bh=B4Sx+xF70GMxFfVfB9+wAhK7C2qf9G7NzE3Mpx8R8Ig=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=YDsLc6Zh9BSmTy7EyY3ZU9/Hacri7gMe43dttHHTZhF4cSFDpZemn+buIhGFnCQs2jCbI50XETrej61iBJkH3iZm5qiWXkThUdo5UwZRVJJyEW01Jq1TaUhMaCcwT1VDbQ8kJdA2yWq/k4sLaADd0YByDGyzw9VS0qy1v6rcVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q47MkIi5; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241203011202epoutp02672f9062755e7ada653523579b828b81~NhZixBGvJ2625826258epoutp02P
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 01:12:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241203011202epoutp02672f9062755e7ada653523579b828b81~NhZixBGvJ2625826258epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733188322;
	bh=B4Sx+xF70GMxFfVfB9+wAhK7C2qf9G7NzE3Mpx8R8Ig=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=Q47MkIi51uODx3/CT6Q5FUz+Go1ClLbVJvRDEBbxZGs6wXQabwVAVl7J9WWVFumuY
	 qZW2hY8XRyINHB7cVBnguJHqgeqosM00gk6EBuWH7P9T0mUZZ0VGM9ASeF9ajqhQZL
	 4bnayb3AdxaljCkxVh/NSvVR7q2q6vNIun42TFgQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241203011201epcas1p30b33f73d2a3087a0b1488e64741ef1fc~NhZiF4eJl1180511805epcas1p37;
	Tue,  3 Dec 2024 01:12:01 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.134]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y2N0c5g3Pz4x9Q2; Tue,  3 Dec
	2024 01:12:00 +0000 (GMT)
X-AuditID: b6c32a4c-ad1fe70000007bf7-93-674e5ae0de6d
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.AB.31735.0EA5E476; Tue,  3 Dec 2024 10:12:00 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH] devfreq: Switch back to struct
 platform_driver::remove()
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park
	<kyungmin.park@samsung.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, ALIM AKHTAR
	<alim.akhtar@samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241130135813.895628-2-u.kleine-koenig@baylibre.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241203011200epcms1p3fbf79a0ca20c982ea472c5f19a2bfbee@epcms1p3>
Date: Tue, 03 Dec 2024 10:12:00 +0900
X-CMS-MailID: 20241203011200epcms1p3fbf79a0ca20c982ea472c5f19a2bfbee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmvu6DKL90g+OXdCwezNvGZnFppYTF
	9S/PWS2ez1/HaHH+/AZ2i7NNb9gtNj2+xmpxufkio8Xn3iOMFjPO72OymLJvF5tFU4uxxfNH
	nWwW879+YrP4eeg8kwO/x/sbreweO+4uYfTY8Gg1q8fOWXfZPTat6mTz2Lyk3uPF5pmMHn1b
	VjF6vPo6l9Hj8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxU
	WyUXnwBdt8wcoCeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWmBXrFibnFpXnp
	enmpJVaGBgZGpkCFCdkZU/auYi/Yz1tx/VZSA+MJni5GTg4JAROJX13v2boYuTiEBPYwSvy4
	P5+1i5GDg1dAUOLvDmGQGmEBf4nz7+4zgthCAkoSDTf3MUPE9SU6HmwDi7MJ6Eps3XCXBWSO
	iMAcRommf9+YQRxmgZmsEmu6fzNDbOOVmNH+lAXClpbYvnwrWDengLPEpDswNaISN1e/ZYex
	3x+bzwhhi0i03jsLVSMo8eDnbqi4pETfnb1MIMskBLYxSuw4MocNwtnPKDHlYRvUJH2JM3NP
	soHYvAK+Eh/3bwS7gkVAVaLh/WWoqS4SG1dPA7OZBbQlli18zQwKCmYBTYn1u/QhwnwS7772
	sMI8s2PeEyYIW03i0O4lUKtkJE5PXwg10kPi2/UlzJDg7WKUuHXlJcsERvlZiBCehWTbLIRt
	CxiZVzFKpRYU56anJhsWGOrmpZbD4zU5P3cTIzgpa/nsYPy+/q/eIUYmDsZDjBIczEoivMvX
	e6cL8aYkVlalFuXHF5XmpBYfYjQF+nUis5Rocj4wL+SVxBuaWBqYmBkZm1gYmhkqifOeuVKW
	KiSQnliSmp2aWpBaBNPHxMEp1cDUpRL54bBF82k73dxg2TnTEr9050dHKEoF87RsP8S9l++u
	fRWnN+v5cKOWBd5zLq4o+bij7fHz9xfZ53zjP6S1+vNto123rj2wXlP2t3fT5+kOi3q9dU7X
	X6pZ9lDDvla3+8xVgYjeVPUt02O8Lie+Ydyv99s4IOVma8HD6aaWCjkmd9a0zD/6+f/ZdM2k
	83Evj/CLseXwitRoWx1Kmui1VShkM2vK/iuV+zjPcSaq9e09rGvVKa3PrnjQU3DigfpnV9lL
	Jd/aRIhO/zNTKn+mMceMbaf/yz3Uu1tfoqD6OOFp5MXJTkyL306Y7eKWE3ucM+pHxuZmoe3Z
	17wivh8qNDTTOW4lmLuucd6RMl0lluKMREMt5qLiRACtT/jpUwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241130135828epcas1p405d9dbb7df745f6aa81ae2033b9a281a
References: <20241130135813.895628-2-u.kleine-koenig@baylibre.com>
	<CGME20241130135828epcas1p405d9dbb7df745f6aa81ae2033b9a281a@epcms1p3>

>After commit 0edb555a65d1 (=22platform: Make platform_driver::remove()
>return void=22) .remove() is (again) the right callback to implement for
>platform drivers.
>
>Convert all platform drivers below drivers/devfreq to use .remove(),
>with the eventual goal to drop struct platform_driver::remove_new(). As
>.remove() and .remove_new() have the same prototypes, conversion is done
>by just changing the structure member name in the driver initializer.
>
>While touching these drivers, make the alignment of the touched
>initializers consistent.
>
>Signed-off-by: Uwe Kleine-K=C3=B6nig=20<u.kleine-koenig=40baylibre.com>=0D=
=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=
=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A=0D=0A>---=0D=0A>Hello,=0D=0A>=0D=0A>th=
is=20is=20based=20on=20Friday's=20next,=20feel=20free=20to=20drop=20changes=
=20that=20result=20in=0D=0A>a=20conflict=20when=20you=20come=20around=20to=
=20apply=20this.=20I'll=20care=20for=20the=20fallout=0D=0A>at=20a=20later=
=20time=20then.=20(Having=20said=20that,=20if=20you=20use=20b4=20am=20-3=20=
and=20git=20am=0D=0A>-3,=20there=20should=20be=20hardly=20any=20conflict.)=
=0D=0A>=0D=0A>This=20is=20merge=20window=20material.=0D=0A>=0D=0A>Best=20re=
gards=0D=0A>Uwe=0D=0A>=0D=0A>=20drivers/devfreq/event/exynos-nocp.c=20=7C=
=206=20+++---=0D=0A>=20drivers/devfreq/event/exynos-ppmu.c=20=7C=206=20+++-=
--=0D=0A>=20drivers/devfreq/mtk-cci-devfreq.c=20=20=20=7C=204=20++--=0D=0A>=
=20drivers/devfreq/rk3399_dmc.c=20=20=20=20=20=20=20=20=7C=208=20++++----=
=0D=0A>=20drivers/devfreq/sun8i-a33-mbus.c=20=20=20=20=7C=202=20+-=0D=0A>=
=205=20files=20changed,=2013=20insertions(+),=2013=20deletions(-)=0D=0A>=0D=
=0A


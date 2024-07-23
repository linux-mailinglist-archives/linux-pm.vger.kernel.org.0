Return-Path: <linux-pm+bounces-11339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8192F93A27E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52CE1C22BD2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEEB155336;
	Tue, 23 Jul 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qalrJsB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A52155327
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744247; cv=none; b=cM1rJTr/CKtwIyrWlsmWay60pXxszPJnAtnv+ubtXIySidfY6reT5jfd6uBJg7HUmXaHJA0bOVoZEjcCaS9FenhkgxiyNctOX3m/tWyHHsckEQFquHDdIyxQYPV0j1eZBrLeuaqmkhMfBJZxyDea3yllH+gYAxaK3vRg3do42ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744247; c=relaxed/simple;
	bh=10bl8tiaEBBnCOrnlBMrvSDtSEqa0TY1siP8CD6YMD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=i29H+acIBO7g9UK/9n5R2ILEkthBpWIKPLlGI67A2qJvw9rO/PMgCw/DWPgloVZObKDAJd+sp3JZI7hmABYYbJzqBK9a71XVEkfcHuUS8ivIKiDpaWCmodTcFrUrClTAuiwXC9axJ90HFp6JLk5oNjoGnGGOWogpsZ000ydkSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qalrJsB2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240723141724euoutp02e967b42e875c56aaef702d4d0bf39d3d~k3USLEnx20378203782euoutp02Y
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240723141724euoutp02e967b42e875c56aaef702d4d0bf39d3d~k3USLEnx20378203782euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721744244;
	bh=OjEes0gy0Xr25v3nLnZ/Vv7Q7TRCUEMjplYfFYeqS4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qalrJsB2Hz8WSGFYJgVEgYLGo1FjUWZkafTL8VOgYn4WyrIPnQPUilNaVjAtJsZJo
	 ufwJdPyLIgpsmU9npIJMTUahFAvqtIDxHTNc1pDSV2heKyAAKM/pWs+4aglz8z6jHZ
	 ndqTtD0mJUSqXvmMlds5fSPnmFbQTcYycFpTfz2E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240723141723eucas1p239a29843eb1899e124dfb14bcab9ff12~k3URzUZBF1691016910eucas1p2D;
	Tue, 23 Jul 2024 14:17:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 52.12.09620.37BBF966; Tue, 23
	Jul 2024 15:17:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240723141723eucas1p18f5675128aa380857f4c854b5a851e34~k3URVxnaE1304213042eucas1p1Z;
	Tue, 23 Jul 2024 14:17:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240723141723eusmtrp1060523108b462f8c2af0620a03c93547~k3URVEq9B1523215232eusmtrp1C;
	Tue, 23 Jul 2024 14:17:23 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-28-669fbb731e4e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 21.66.08810.37BBF966; Tue, 23
	Jul 2024 15:17:23 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240723141722eusmtip1cdf2a1f16c40bcd12afa0363945ea782~k3UQlCSpw2618026180eusmtip1e;
	Tue, 23 Jul 2024 14:17:22 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Rob Herring <robh@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Date: Tue, 23 Jul 2024 16:17:14 +0200
Message-ID: <20240723141715.374786-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723030840.GA226948-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djP87rFu+enGZx9I2/xYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52MfmwO+xZt4aRo+ds+6yeyze85LJY9OqTjaPO9f2sHlsXlLv0bdlFaPH
	501yARxRXDYpqTmZZalF+nYJXBnLnt1hLnjEVHFv7QnWBsYepi5GTg4JAROJazs+sncxcnEI
	CaxglPh26jsrhPOFUWJ3ywxGCOczo8SEjRcYYVoatv1jBbGFBJYzSnx6aA1htzJJLP/pDGKz
	CRhIPHizjB3EFhFQlPjdNg1sKrPAFBaJqz2/wZqFBQokLn1sYu5i5OBgEVCVuNlcChLmFbCV
	2Nj9mQVil7xE7/4+sFM5BcwkOlomskDUCEqcnPkEzGYGqmneOpsZZL6EQDunxOq+/ewQzS4S
	K840QB0tLPHq+BaouIzE6ck9UAvyJWZsfs8CcoOEQIXE3YNeEKa1xMczYJcxC2hKrN+lD1Hs
	KLFkxip2iAo+iRtvBSEO4JOYtG06M0SYV6KjTQiiWlXi+J5JzBC2tMSTltvQIPeQuHToK8sE
	RsVZSF6ZheSVWQh7FzAyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMZqf/Hf+6g3HF
	q496hxiZOBgPMUpwMCuJ8D55NTdNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6Yklq
	dmpqQWoRTJaJg1OqgWnd+7XW2W/qo9Z5fLnVGFS4aaWN1GKfcyUd00PW3NdPmvhp8S7TL4Lt
	JmFJG7blhW/buPVETt7KhVwrbs1PONA59XBy3Iu/19teJXrk21ir90e5TTsWsGyhBQ8v++lb
	Rk5+lTrai3U3GTyd8/L16ZeRrX92bHpbl66bcStKQ1v2plVnRpVS6FIz6zfbw5wivNaeW+AV
	/tvkyLYUFXG3mOUHJsjVTTvoeGDDkQjV857iXSpnGDh3L6xvPdX03iWF5aOt8pW/bZ/kZ71Z
	Un3C7Lw63y7u/LPmnhu6xdZu2uDe5BZ34dfSI2v5bs1sW8hnxSZh+EOobEqCXrzFpi3KzsZe
	YULJUaKze0y2PBBr3KPEUpyRaKjFXFScCADwg+kd1QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7rFu+enGSzezGLxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52MfmwO+xZt4aRo+ds+6yeyze85LJY9OqTjaPO9f2sHlsXlLv0bdlFaPH
	501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
	ehnLnt1hLnjEVHFv7QnWBsYepi5GTg4JAROJhm3/WLsYuTiEBJYySvS87GaHSEhLHP4yBcoW
	lvhzrYsNoqiZSeLRtk8sIAk2AQOJB2+WgRWJCChK/G6bxgpiMwssYJG4faIGxBYWyJNY0XMP
	qJ6Dg0VAVeJmcylImFfAVmJj92cWiPnyEr37+8AO4hQwk+homQgWFxLgkXi1YT8jRL2gxMmZ
	T1ggxstLNG+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNv27Gf
	m3cwznv1Ue8QIxMH4yFGCQ5mJRHeJ6/mpgnxpiRWVqUW5ccXleakFh9iNAU6eyKzlGhyPjD+
	80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamEwOMAsw7XN4eXaF
	2BN3rnx17YeZb24sbl3Xfef4u+6rVjExbzICoxd2nw/74KfXX2zRe0LzkUbnsz0/FutnOF17
	dfoL/7yGcE1xORnenGe8Vw136fD6n179KaX6XFWDA+uVVzohyV3/czsdXyTL3Owpnxggxhiz
	Y+K7udduX162cGlna6BVe90J6TkHvJhczMLsX+6fsqruna/35QNPFmXpbLrOfsF+J8fipYJM
	qgcjXuy2ytqbfMBj6ruHn/jnzrmhel3/64+atFd+sx1E50sIsR69Lfwsnn9V0Jz+eYLxIuUC
	cmmt93W3tb0pD8rJDg9xti+t5UxLWSjh0uKiW3yOpzh9uZxTmO7T4+87lViKMxINtZiLihMB
	kCdvz0cDAAA=
X-CMS-MailID: 20240723141723eucas1p18f5675128aa380857f4c854b5a851e34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240723141723eucas1p18f5675128aa380857f4c854b5a851e34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240723141723eucas1p18f5675128aa380857f4c854b5a851e34
References: <CGME20240723141723eucas1p18f5675128aa380857f4c854b5a851e34@eucas1p1.samsung.com>

Hi :)

> > +      temperature thresholds. The trip points will be set dynamically in
> > +      runtime, which means there is no limit on the number of trip points.
> 
> How can the hardware change how many trip points it supports?

Would just removing the whole "The trip points..." sentence be ok? I see
how it is more confusing than helpful.


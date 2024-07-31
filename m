Return-Path: <linux-pm+bounces-11776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49BC9437A1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 23:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31E31C214F8
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C110F16C6BE;
	Wed, 31 Jul 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EBwyZod7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B916A949
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460500; cv=none; b=Cjzyk99hXP/QFLuGUAUF5DVHBFI2w0HND/bc3SZVgePm92ZQvGAK/AhKt1fjlMJcwFOYCqe+QgSGl6xJOWQBoWK1Af0BV/O46M4AbIxQcE04yfNB1EyqH5pb0NZOToLeihSOGQFvimPqVPf5Wyo6fQ2+io6GJTFoCab/kqCBtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460500; c=relaxed/simple;
	bh=h/SR/zFNxMgNVWfQua2p0HQlYGiWaqX45ftRH9jGwBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=PAytxlLJr4lYPAHnstTz9D4y7fzALO9KUI1aJfS1IizPmtO9X49PgdiI0TBpVqdxwfR1HRFj0mbiOIEyGwiqwJ653mJ3U6RxhCdvWKAvTF4Xy4hTf8nLOfwBxxloc7vgrz0sMPrWrpflN7ukzWrJHW0/FF5LwHpa8HBM02HoXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EBwyZod7; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240731211457euoutp02ad3a674f85ba1d4bfcd639e8d6e5f616~naLJQS4qS1333913339euoutp02C
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 21:14:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240731211457euoutp02ad3a674f85ba1d4bfcd639e8d6e5f616~naLJQS4qS1333913339euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722460497;
	bh=h/SR/zFNxMgNVWfQua2p0HQlYGiWaqX45ftRH9jGwBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBwyZod75MQRBmRgYa1vcDfX9MijEtQ6s8vSxootrMcRU4FVGM1razu7iZGvn6HU6
	 v9CcW0h23sRr8/yadfKuGVyXCaL3+1RR8J2txREQv4KDTCWl2/zd6yQm3JbugHsoIW
	 AXgFXBWJJGAONEqQNSdFpIpe/XAv4Xaccf4nEJrw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240731211456eucas1p1701bf4a649782f1e3ad81f5eb7041252~naLIjIa7p1067210672eucas1p1C;
	Wed, 31 Jul 2024 21:14:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.3C.09620.059AAA66; Wed, 31
	Jul 2024 22:14:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43~naLH2aZVu1067210672eucas1p1B;
	Wed, 31 Jul 2024 21:14:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731211455eusmtrp2b187e7bffe084776589f7978e306d293~naLHwlQ_X0260402604eusmtrp2s;
	Wed, 31 Jul 2024 21:14:55 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-56-66aaa950f64f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.B3.09010.F49AAA66; Wed, 31
	Jul 2024 22:14:55 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240731211454eusmtip12570cc01591dcea1b234e75eee8438d9~naLG0NL2f2993929939eusmtip1e;
	Wed, 31 Jul 2024 21:14:54 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Rob Herring
	<robh@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Date: Wed, 31 Jul 2024 23:14:42 +0200
Message-ID: <20240731211444.59315-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4=WsGikZ6qOi8dWg4wFsVbhp29cv=DKP06jc4TQn=yUeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87oBK1elGXzZqGbxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr4+CJY0wFM7gqZiy5y97AuJ6ji5GTQ0LA
	RGLP4W72LkYuDiGBFYwSu473sIEkhAS+MEpsnOcEkfjMKHHu7htmmI43z06yQCSWM0r8fXef
	FcJpZZL4d78frJ1NwEDiwZtlQHM5OEQE/CVWvBcFqWEW2MEiMevGcrC4sECxxPUPIiDlLAKq
	EpeuvmYEsXkFbCQm919hhVgmL9G7v48JxOYUCJS48O8JG0SNoMTJmU9YQGxmoJrmrbOhjpvN
	KXF2aQWE7SLxbMUiFghbWOLV8S3sELaMxP+d85kg7HyJGZvfs4CcIyFQIXH3oBeEaS3x8Qwz
	iMksoCmxfpc+RLGjxLTzUxghKvgkbrwVhNjPJzFp23RmiDCvREebEES1qsTxPZOgzpKWeNJy
	G2qlh8TvZbPZJjAqzkLyySwkn8xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZG
	YHo7/e/41x2MK1591DvEyMTBeIhRgoNZSYRX6OTKNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	qinyqUIC6YklqdmpqQWpRTBZJg5OqQamgmXbJl2ZYafXtuik00mheTGP17Fc7mhw1I55/yjv
	5j6VeO+NDRfPPjb1kLDjZDrks75A5JY2b12k62q3MKauYzaFi39Fnzd/rGcmFaN68Itu14Y7
	M9/GaVicnWpw/y0vXzB/xH1mvW8bDwvYx009MGWJ+kw941vKH7Xa3f5Fb2GdWtAX7bBsRc6t
	4//enzhzI1AvoLNtetUf/WM/Ok9a8ftoLD62rHrix2v2hid2Xn81y5qrQiX3skDQJgXLWzsV
	UzqD9bTXz/z3I/T/bQXufQ+9/9m4BM+NKG36K9d9vEdz0dYf7e+q96S+2+OYcYojnOVD2QvW
	5CtTt9tnbep1aA5fdCyu+/tU/fS9ik+MlFiKMxINtZiLihMB+Ey0Q94DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7r+K1elGTy+ZWDxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEv4+CJY0wFM7gqZiy5y97AuJ6ji5GTQ0LAROLNs5MsXYxcHEICSxklPjx+
	yw6RkJY4/GUKlC0s8edaFxtEUTOTxLZjjawgCTYBA4kHb5aBFYkI+Ev0bu5gBSliFjjGIrH9
	8C0WkISwQKHEuUsPwRpYBFQlLl19zQhi8wrYSEzuv8IKsUFeond/HxOIzSkQKHHh3xM2EFtI
	gEfi1Yb9UPWCEidnPgGbyQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L
	10vOz93ECIzKbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4hU6uTBPiTUmsrEotyo8vKs1JLT7E
	aAp090RmKdHkfGBayCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRq
	YEru5UoU/e8QYj7LNO1Z5+sJ4Yd0bG6sY2A9PGdq4yeDWdMyHtlf+PuvR0n+PrP+L90dC9tf
	L0k5wSOyTWj633WndnPHmSYxzP2v/1vHi6eKSURdaeeV5ovPi2IXHj0bejTty2GZZ0csOyZF
	LN+gKb73SOHz568zjRR22eyyNdtQNSV5/4XwazteTDNhqp2XMuH381V1YYGMBVPVt0ov+y8r
	v3FqsM61d9pnPObcmaPonHLhxZVnPxUDZhi6T5y578yqHB75V4nRG7/Oz6io+ro+xqDtbp7/
	ikf5Uufk7qjfvtSgPuXSmZAel6sd+/553spUUg6vyfPJSZjDxpF0yIv3zfP5/I9UIp7uObPq
	J9tOJZbijERDLeai4kQA0meQOVMDAAA=
X-CMS-MailID: 20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43
References: <CGME20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43@eucas1p1.samsung.com>

> Do I understand it correctly that the patch actually removes an
> outdated description of *driver* implementation, and not outdated
> hardware description?

Correct.

> If so, then maybe it makes sense to rework the
> patch title and commit message in a way Rob suggests. I.e. rather than
> stating that the patch removes an outdated information, instead
> mention it removes *software* (driver) description which was
> incorrectly added earlier. Because bindings are only meant for
> hardware description and should be completely independent of driver's
> side of things. Also in that case it probably doesn't make much sense
> referencing that commit for using set_trips ops. Just my two cents.

Makes sense, what do you think about this?

dt-bindings: thermal: samsung,exynos: remove driver-specific information

The number of supported trip points was only limited by the driver
implementation at the time, which mapped each trip point defined in the
devicetree source file to a hardware trip point. An implementation that
does not have this limitation is possible; indeed, that is how the
driver works currently. Therefore, this information should be removed
from the bindings description, which are meant to be independent from
the details of the driver implementation.


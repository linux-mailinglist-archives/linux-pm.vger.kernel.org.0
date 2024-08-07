Return-Path: <linux-pm+bounces-11962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F194A34B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6D01F21174
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ABC1C9ECF;
	Wed,  7 Aug 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pCKrWt83"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BB1E495
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020547; cv=none; b=c7AW/bn78RGr2J2/t0M9NBiEYhwNVjFOILxElLL7Z7jFqfcMaEpdgJKXWPl0gZNm8Yc4UC29ved9uwyr2LhPQWHzOUzkFmOmiYGvHtoW+9S4LHfiDR6C6VUgFVqgjrosWh2xxEKpvBSIBjQrdYD3Q8yKp5+MKNIDuXzB85Fg2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020547; c=relaxed/simple;
	bh=ydViUa81z/MED+vTuwwGkyUA+ss3lOP7nUpzN9Z+avc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=YCGmWCl1oMVuDYKtYgfo5p9kp76F3lc/xhS3AvMTyfs9GPtySWmBungw98kId9HM0tqCBecVk2IjIgRz184PY627IQ+jyFAn9Zd3oi3HyGpX/oceMxGzfS+cGLZzMqafU5o6pZOmlB0YFqgiva/bK0zE3nioD8Gfd0UFCjPEV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pCKrWt83; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084902euoutp026866fcd7d123765b3258305f2bff94ed~pZg3yDodM3094830948euoutp02h
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240807084902euoutp026866fcd7d123765b3258305f2bff94ed~pZg3yDodM3094830948euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020542;
	bh=MOYRKPD2Qr+yDzENL6SzfGEa1/AbZtSculzGBSu5X+8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pCKrWt83Kp+f80iyVuRzYUfgGilTtugTdxHFkKhG/Aotk0Kl/86rFhgUpGFdXkKui
	 8l3BAZppbk1OGYWFaWj9Pe2Y+aC9nS+SwZ+K67OcKvrbwDLwrh7FbHL0IQKtXp/zgc
	 3QQIC6eOJp7Lh9w12TNTFeOndFCKbq8JErFsSO4w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807084901eucas1p14acd38612f949e8448705916cb7d4da4~pZg3G0kf72042420424eucas1p1B;
	Wed,  7 Aug 2024 08:49:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 41.02.09624.DF433B66; Wed,  7
	Aug 2024 09:49:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240807084901eucas1p1feb6a9a89cd6b358380f35f0e3228dfe~pZg2dFlrb0113701137eucas1p1Q;
	Wed,  7 Aug 2024 08:49:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240807084901eusmtrp25940bdc4f5cec1c9708e3ed2db8cb053~pZg2bwBZS2292322923eusmtrp2w;
	Wed,  7 Aug 2024 08:49:01 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-fb-66b334fd4fcd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.CC.09010.CF433B66; Wed,  7
	Aug 2024 09:49:00 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084900eusmtip2724d3180f0b4cd5c0de842f4ef2259a8~pZg1eD8U-1785517855eusmtip20;
	Wed,  7 Aug 2024 08:48:59 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 0/6] Add initial Exynos850 support to the thermal driver
Date: Wed,  7 Aug 2024 10:48:19 +0200
Message-ID: <20240807084829.1037303-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7p/TTanGby7qG7xYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoErY/PB6IK7XBUP7zxhb2C8wdHFyMkhIWAi
	8e/pXZYuRi4OIYEVjBLzGu8wQzhfGCUmdjWxQjifGSVmnjwK5HCAtWz/DBVfzihxYtdjKKeV
	SWL/7K+MIHPZBAwkHrxZxg6SEBFYzCjR+OMdWBWzwBNmiZ+vFoNVCQt4S7z/vJMVxGYRUJXY
	9bSBGcTmFbCTaP2zlxniQnmJ3v19TBBxQYmTM5+wgNjMQPHmrbPBjpUQaOaUePpuKyNEg4vE
	i6OvmSBsYYlXx7ewQ9gyEv93zoeK50vM2PyeBeKfCom7B70gTGuJj2eYQUxmAU2J9bv0IYod
	JS5NfscMUcEnceOtIMQBfBKTtk2HCvNKdLQJQVSrShzfMwnqdmmJJy23oVZ6SHS17we7XUgg
	VmLXsjksExgVZiF5axaSt2Yh3LCAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYJI7
	/e/4px2Mc1991DvEyMTBeIhRgoNZSYS3OXxTmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5
	VCGB9MSS1OzU1ILUIpgsEwenVAPTgvsSZq2Xo7t/VPdEM4d7/FIWnPv4l3DAVDb1dydu9DO6
	y86f+yHu9qmnsd9zrn+fdzwhbFrAkkVVe/Y8YjpbOt/icoT10+M67bMuSUz8cIjx45u6nzkP
	9x1cU90kvfGr/OWo8H8pfScXn7xx5ebf0NDddolV6nt+TfLYNp/7Yduu1m9vp5QquOd9d166
	reneqvSpTXfE3CycHp24Kl+4eI5arkSBxF+HsLpqoUb5KbEGM9bbntZwbfMIXSKvvv5oTtGs
	iY8+Zd22iVXInPV5lsifmNmR1S9Ecsx9av8xPVUNZ0hctb1YzezFnD3P3wa8MomvZepYmFzO
	N9f3tHHy34BHTKX/FOyLkxqXimnrKbEUZyQaajEXFScCAE23CHThAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7p/TDanGby5bGXxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEvY/PB6IK7XBUP7zxhb2C8wdHFyMEhIWAisf0zaxcjF4eQwFJGicXdUxi7
	GDmB4tISh79MYYewhSX+XOtigyhqZpL4umcmG0iCTcBA4sGbZWBFIgLLGSU2t3uA2MwC75gl
	2s/7gdjCAt4S7z/vZAWxWQRUJXY9bWAGsXkF7CRa/+xlhlggL9G7v48JIi4ocXLmExaIOfIS
	zVtnM09g5JuFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwPjaduznlh2MK199
	1DvEyMTBeIhRgoNZSYS3OXxTmhBvSmJlVWpRfnxRaU5q8SFGU6D7JjJLiSbnAyM8ryTe0MzA
	1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qByemsRYpBxspdfM02ekckn7ho
	vzWs2r1n98U30SFrcuIMz4s1/9WZEfTBzC/z09TGuVtOsfd+ijMT3qWxzrR1pvy5D5dfFhxz
	Psa/Jf9vebJoZuEzER2R418ttWLVJl47PfGk6OxCnz9VgdESG320Dp3yfzNlg259fOultcdf
	tHIJHT8Q90LC8e7ElbYfH/ff5eXhuKK27tvmyHUsD3yzvv10On8nrHbBtWKWyTFy3BbM2+ff
	fR2Vv3PCwrij+xiSjjqpzIqZ9Vxh/8On2py+N7bbnDmyc+/yRzFK8xr+cT3t2rdfaPrBRaFW
	wQsLOBd9tlgU9WVf4LnPQvZNWSJN8dNZIh7Nntq4bSNHfGCQWbgSS3FGoqEWc1FxIgDG+eYY
	OAMAAA==
X-CMS-MailID: 20240807084901eucas1p1feb6a9a89cd6b358380f35f0e3228dfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084901eucas1p1feb6a9a89cd6b358380f35f0e3228dfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084901eucas1p1feb6a9a89cd6b358380f35f0e3228dfe
References: <CGME20240807084901eucas1p1feb6a9a89cd6b358380f35f0e3228dfe@eucas1p1.samsung.com>

This series adds initial Exynos850 support to the thermal driver
together with its requirements (sanitize_temp_error fix, adding the new
string to dt-bindings), while also cleaning up a bit (improving power
management support and removing some outdated information from
dt-bindings).

Changelog:
 v3:
   - Reworded the commit message of the dt-binding information removal
     change
 v2:
   - Reimplemented to use the Exynos850 TMU clock: removed the patch to
     make the clock optional and changed dt-bindings change accordingly
   - Improved the Exynos850 implementation itself (style and one correct
     register offset)
   - Removed conditional compilation in favor of pm_sleep_ptr
   - Shortened dt-bindings description

Mateusz Majewski (6):
  drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
  drivers/thermal/exynos: use pm_sleep_ptr instead of conditional
    compilation
  drivers/thermal/exynos: improve sanitize_temp_error
  dt-bindings: thermal: samsung,exynos: add exynos850-tmu string
  drivers/thermal/exynos: add initial Exynos850 support
  dt-bindings: thermal: samsung,exynos: remove driver-specific
    information

 .../thermal/samsung,exynos-thermal.yaml       |   8 +-
 drivers/thermal/samsung/exynos_tmu.c          | 219 ++++++++++++++++--
 2 files changed, 199 insertions(+), 28 deletions(-)

-- 
2.45.1



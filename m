Return-Path: <linux-pm+bounces-14011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C097517D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213871F22535
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39A187FE1;
	Wed, 11 Sep 2024 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fNKA+/nm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F57187355
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056715; cv=none; b=XTHVTMzUbXz/CkhccV6l4IH9Sm6s/bxTihIY9zn6sXq1WHIaae5fXZZHmSbK7cvJZLr2qXPdr3dCMeNGS5OSW4UO/fAzO64IQamyCFe9CQ0/szWlU/jWeGzuKQ4d40QSWC46gkik+VWF7WYIm09VH9DmdyG6CK2dKmroLRlQ8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056715; c=relaxed/simple;
	bh=3Swu0Hd8jz4hEyhWca91c8oRCzGFb39Ieire6DVvOcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=bTa/KsgRYGmDxXNRba6hX7zE9+I/AJTt8G6kRRUSl3vKG5Mn4UCjUyf6gpmSZbNia0EPQdwCxznJSiNKc3dLtZ7xphSOStaf6iZk9MRVd9jaqaM40m8lnhzYZUoIr9OiELF+umzj7yKLcJkLlXfpIw/FEBv4fy092REp1oMPrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fNKA+/nm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121150euoutp01be8e0f3f29911d53420dcc1f21e3e617~0L27s1RGI0990809908euoutp019
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240911121150euoutp01be8e0f3f29911d53420dcc1f21e3e617~0L27s1RGI0990809908euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056710;
	bh=JJQazKGbc8eC2nG+ZbcooFNwFLYJU5Lc7hKXABWosA0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fNKA+/nmBKhKHJzuyF8FWdSl58z8dJc+Hlx3qOG+oKKa59ke+STT8Jr4rSdeGtsXY
	 aPINrwDJBzjrpnTEZ4Nx4qhbFo1gh0CT1n7wHbr7PiA5OqmiKdqUzpb5kxlZOApR+J
	 z7Bg6wDmnYrhtuIThBh600ranJrJ+DHuyzA6+h/c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121149eucas1p28d2864cd11bd828ddde8f104984bc07d~0L27EVQ8j1734517345eucas1p25;
	Wed, 11 Sep 2024 12:11:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.38.09620.50981E66; Wed, 11
	Sep 2024 13:11:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183~0L26qYr0i1735817358eucas1p25;
	Wed, 11 Sep 2024 12:11:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121149eusmtrp2398e0023dca67fda0474c1fd19aeca81~0L26pn7zv2688526885eusmtrp2T;
	Wed, 11 Sep 2024 12:11:49 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-66-66e189054cb8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.E9.14621.50981E66; Wed, 11
	Sep 2024 13:11:49 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121148eusmtip14c9e2adaadac8aea8c6f73d897d0f577~0L25vfIki0847908479eusmtip1g;
	Wed, 11 Sep 2024 12:11:48 +0000 (GMT)
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
	Moon <linux.amoon@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 0/7] Add initial Exynos850 support to the thermal driver
Date: Wed, 11 Sep 2024 14:11:23 +0200
Message-ID: <20240911121136.1120026-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7qsnQ/TDJ78MrV4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XaI3fZLeZ+mcps8X/PDnaLJw/72Cye9+1jchDyWDNvDaPHzll32T0W73nJ5LFpVSeb
	x51re9g8Ni+p9+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6MGbvnshSs4Kl4t3oKcwPjH84u
	Rk4OCQETiWMPb7CD2EICKxglPi8N62LkArK/MEq8PfqPGcL5zChxYskeZpiOcz1HWCESyxkl
	mrvXQjmtTBLP77xjBKliEzCQePBmGTtIQkRgMaNE4493YFXMAhNZJNa/6Qaq4uAQFvCWuP8j
	B6SBRUBVYuOHrWCH8ArYSRz79YAdYp28xMU1z9kg4oISJ2c+YQGxmYHizVtng90nIdDMKbHi
	z2ZWiAYXibZJz6FsYYlXx7dADZKR+L9zPhOEnS8xY/N7FpAbJAQqJO4e9IIwrSU+nmEGMZkF
	NCXW79KHKHaU6Ll+lB2igk/ixltBiAP4JCZtm84MEeaV6GgTgqhWlTi+ZxI0qKQlnrTchlrp
	IXFp9zRoQMdKHG+7yjqBUWEWkrdmIXlrFsINCxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl
	5+duYgSmu9P/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEePvt7qUJ8aYkVlalFuXHF5XmpBYfYpTm
	YFES51VNkU8VEkhPLEnNTk0tSC2CyTJxcEo1MOVdj5nzzKjmydqbKrP4Fp5h6dis7h3KlCqg
	EHX44HzBzuOMhZmpmgzmwrF6RTVSlTKhSwXbUpyOnCjj7nt75vjGthqe07Xm1gd7BA+4yxra
	ru8tX9Qc+fKqWtPx3PdB8w5VXLi5luvjzIMsot8chHhnrU7/c2o9ry3PxGKesA91LtNfhU75
	vVjBfucX9Ve9W8xaSirf77loYy7PwPP0h+fc6xy8r6/kHngpP+FhOWvy78X8aouK9rd+Vn60
	8t79449KbhTvNzI3fFjjH+eq+f1yypm/z1alrH14537Ajk3avvGzzLjrJUKNLx9wmL1nRd+v
	45HLbPJLbOqN/u9PW3br1IJ9Rif//v6/X+va1VIlluKMREMt5qLiRACnbczx5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7qsnQ/TDGa0y1g8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLtkbvsFnO/TGW2+L9nB7vFk4d9bBbP+/YxOQh5rJm3htFj56y77B6L97xk8ti0qpPN
	4861PWwem5fUe/RtWcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayV
	kamSvp1NSmpOZllqkb5dgl7GjN1zWQpW8FS8Wz2FuYHxD2cXIyeHhICJxLmeI6xdjFwcQgJL
	GSVWbDrLDpGQljj8ZQqULSzx51oXG0RRM5PEm91dYAk2AQOJB2+WgdkiAssZJTa3e4AUMQvM
	ZZHofL0aKMHBISzgLXH/Rw5IDYuAqsTGD1vB6nkF7CSO/XoAtUBe4uKa52wQcUGJkzOfsIDY
	zEDx5q2zmScw8s1CkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYLRtO/Zz8w7G
	ea8+6h1iZOJgPMQowcGsJMLbb3cvTYg3JbGyKrUoP76oNCe1+BCjKdB9E5mlRJPzgfGeVxJv
	aGZgamhiZmlgamlmrCTO63b5fJqQQHpiSWp2ampBahFMHxMHp1QDk8BVuYd8sdr1ulb1H/60
	XX1dvW9F4K1WRd2Lcayh30MPv4vWcXq/7/rfpP9V0914om6+mimZmTid30U6c7vl/N+BiTvv
	dRb27Xzo2eO4W/7bmwXvH3+XO7r0o9016QBOvXbXR2Zn5v9wkdncGd5Vp/12m75RsLOyW7CA
	gErfv//rk2bPZGabzVo9Zd35VPFNt1x3xZtwbtoupcH2NFLptHWWolryLZfQ/J4pwqL+AXM6
	r5xeVJgnt3Nl9u+fqjEcOqavD12YIVX5b/e6Cy7eurfv7zapM//fEe2hUi3iq7nxi0r1OmOr
	xKULz7WJ90u1MDZ1Vp84sOT11wWtyTM/u/+xqjFwXSRRLV/Uc3CzEktxRqKhFnNRcSIAVZre
	RT8DAAA=
X-CMS-MailID: 20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183
References: <CGME20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183@eucas1p2.samsung.com>

This series adds initial Exynos850 support to the thermal driver
together with its requirements (sanitize_temp_error fix, adding the new
string to dt-bindings), while also cleaning up a bit (improving power
management support and removing some outdated information from
dt-bindings).

Changelog:
 v4:
   - Cleaned up sanitize_temp_error a bit more
   - Modified exynos_tmu_update_temp to match sanitize_temp_error
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


Mateusz Majewski (7):
  drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
  drivers/thermal/exynos: use pm_sleep_ptr instead of conditional
    compilation
  drivers/thermal/exynos: improve sanitize_temp_error
  drivers/thermal/exynos: reuse data->temp_mask in
    exynos_tmu_update_temp
  dt-bindings: thermal: samsung,exynos: add exynos850-tmu string
  drivers/thermal/exynos: add initial Exynos850 support
  dt-bindings: thermal: samsung,exynos: remove driver-specific
    information

 .../thermal/samsung,exynos-thermal.yaml       |   8 +-
 drivers/thermal/samsung/exynos_tmu.c          | 237 +++++++++++++++---
 2 files changed, 209 insertions(+), 36 deletions(-)

-- 
2.45.2



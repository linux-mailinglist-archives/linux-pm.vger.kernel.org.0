Return-Path: <linux-pm+bounces-18466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413159E214B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3BF1B42300
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504F1F7554;
	Tue,  3 Dec 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TrBeCDr6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5731F1307
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233331; cv=none; b=XVPIIXDRzwp1E+QKQbG9/EKnDCD96MRVYpYFlqtKjjoPpWXRhET98rMODDRbJC88VAxlq7U1XW+yM5yqw/eZxb47wEwiplhfduOB+c6Il6gbM2340cEIfmV3ElEAEvXs5DYpBPTubkQfC6gQ66WpBOh3wtJ0AMup8yhZDogfGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233331; c=relaxed/simple;
	bh=LGeuU1gvSlUDj4IGxOzNM8mvaHEFlSPXotB2cBgCBrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=l+dpsW/sAD7voDgkTEGD/BYpndnIfKusSRRbAxMPsd4u7z/DuecR7mJUDEyT3hNoggJQIJNJxZBfM+ZpfLxEdVXs3Let2zhayPEqHjQf2DD6TqL6ztY7Sinz6qLWqd/ge0b+t7VqisW1dhNJGJLOGhsZ9YCKgVMKYFagUQ2H7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TrBeCDr6; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134203euoutp0252dc452ef1e5094c5f4aa2788c2e2587~NroY8BQ_z3036030360euoutp02e
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241203134203euoutp0252dc452ef1e5094c5f4aa2788c2e2587~NroY8BQ_z3036030360euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233323;
	bh=C1YLKXMYJWNZMzoNJUKXej7WlTB7xuYAcg1TSDjxMiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrBeCDr6GBchQjRh8i0P6OPbiql4ArAsTRAXMdW77Kiki3oqfbxKr9CCg/BMb8ZIu
	 ZVVzljO1Iiu4r3CLa12rFx7IJwiQb9i4O9LbxAiS2cZHrGQdGHZ+621h4LpUu2x/vj
	 j/4jGIO5KHqGgOP0M26JclfL6atIDnEaq9pivJ7Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241203134202eucas1p13d3e780c1032802d499834a2bce8b35c~NroYWlNp_3153231532eucas1p1C;
	Tue,  3 Dec 2024 13:42:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id E9.8F.20409.AAA0F476; Tue,  3
	Dec 2024 13:42:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134202eucas1p26bdcec486ee42440ded94ff801678ba0~NroX52d1g2020620206eucas1p2J;
	Tue,  3 Dec 2024 13:42:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241203134202eusmtrp256be97aceec313eaab0d31b20d247ded~NroX4_iV_3025130251eusmtrp2R;
	Tue,  3 Dec 2024 13:42:02 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-97-674f0aaa8e05
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.D8.19920.9AA0F476; Tue,  3
	Dec 2024 13:42:01 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134200eusmtip2c8f6618d426dbca2d7ad94b36f2e1bc3~NroWljBDI3160631606eusmtip2G;
	Tue,  3 Dec 2024 13:42:00 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v1 10/14] drm/imagination: Add support for IMG BXM-4-64
 GPU
Date: Tue,  3 Dec 2024 14:41:33 +0100
Message-Id: <20241203134137.2114847-11-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BUZRyd79679152WrqsIN+ARu6EFDMgOM30GUX0QO9MM5TkZDWULnED
	iueuhBiNBgsI7O7AhqUrBhi6tBNuvHZ4ijxiI2yFVRYyHhZorKKIsAWh0C53Lf87v3PO7zvn
	N/PRuLiO9KETUw5wshRpkoQUEsa+ZXOQXvhGfEhRgS/6aeQ0hppWtBT6vsOMoYpeswBNWBox
	dMU+R6Jz1wcpNNPxBYGsNacolNtnIJFNO0GieeWEAF1uLSfRgqoXIOOCgkS1veMUMtgrMFQ1
	30Sg6uZWgPILzwrQ0M+RyHZZiaN87eNorb2ZQqvWOgKdvNNJocbZUgEy1e5Fis4yImIzOzea
	R7GzNhvB9hxdpNiOvyoJtkU7TrHKlouArdcXkuyYtZ1kv+nfzU4WmzC2ofowq6jtw9i588Mk
	q27UA9aSO0KxDQOfvenxnvCFOC4p8VNOti18vzDhx/MhaWeFB21rd8ARMEkXATcaMs/CM/MP
	iCIgpMVMDYCDbbW4UxAziwCOq1N5YQHAootq6uGGtv4r14YOwIL6BsAPswBWdZ0DThfJbIfX
	dBUCp+DJ3MLhqP1X0jngzJ8AGqfLSadrA7MbTq1Y1jHB+MPOMet6hoiJgONlJgGf5wc7u35Z
	L+Xm4G8dKxLwHg/Yf2KacGLc4cltOok7AyBzRgjbSm67yr4Gq0svuB7aAG+aGl38JrjWUoHx
	OBVea7qH8zgbtihNLhwGx8z/OMrRjoBnoKF1G0+/DMcmW9dpyLjD0dsefAV3qDF+jfO0CB7N
	F/PurfCYUvVfqLnG6AploU6tw0vAFu0jx2gfOUb7f24lwPXAm8uQJ8dz8u0pXGawXJosz0iJ
	D/4wNbkeOH71wKppsRnobs4HdwOMBt0A0rjEU6QzvB4vFsVJsw5xstR9sowkTt4NfGlC4i3y
	j/PjxEy89AD3CcelcbKHKka7+RzB8iQCw5ORh4ayspkR0fHy3srfPgjKxAOuDtzX+lqiQq9H
	ts+sRqsC8nRpp37Y/3Tb75qPrLZd331eErM3fWciMi8MadKfv2u0L0esvltMNbidvo8mYqx+
	l26I/9Z4V6CD/W/tq3ruqn1ApFj+o2Crb6FXivtIaVyOysvH8x0vxasf73DPjI7W60c1bV++
	dKktVhIAh3OKY4ZjNRuJHVPKB/XSF1N7wmIzHsuUh2/2T+5ZtGQnZl+ImhIlTH/7VNgTG2ei
	22dDAmsmvbtUuKV3iRmcCpeuLF0JihlYKssq6Qq9q/bKgXtm3vbrENdtCtwZSZn2vLJlV0Tw
	YZSU3nNv5f2oGxJCniANDcRlcum/d8cb0UQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7orufzTDSZOtbI4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZRzdZ1CwjKvi5f93jA2M9zm6GDk5JARMJGZtmsbSxcjFISSwlFGi694/doiEjMS1
	7pcsELawxJ9rXWwQRa8YJU6+aQIrYhMwkniwfD4rSEJEoJNF4u3mtYwgDrPAW0aJ6zM3grUL
	C/hLPO/sZgSxWQRUJfbfuQbWzSvgIHF3ynFWiBXyEvsPnmUGsTmB4q+ndoHFhQTsJXb8PcwK
	US8ocXLmE7CZzED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
	wLSy7djPzTsY5736qHeIkYmD8RCjBAezkgjv8vXe6UK8KYmVValF+fFFpTmpxYcYTYHunsgs
	JZqcD0xseSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFxcEo1MG30Vdtk
	/IPVkG9h1vvukpNm4ofebYtZqGWw7VVkjLxd/tXywivWPfkfHvJt38pj9FthuqejI5+E2uwP
	HNf3l1doNP5tvBHFdeyw5iEOda6vIraqnpPfqCz2/zzlsdDDY5Vei7pakqdo+zZYPn5Zf8h5
	3dRz+vwRv5kktporuu68+UtT/eoCO9/kK7NPM0b8Vr325cvFU+bTFplPn5r7hPEd1wrDQMF/
	oUECy15uXrFixqlQ7pflVpuysuUZns1Zq30xJ3p689TT7fuTmV494JVsuGxRl7/ZSVyhofv7
	NnbdhauMfrOmaAkmGgi4uDe/XRVXvdzmgXhXvKpZ6L/z6wKqd+4zZZLzMn7LK/KXR4mlOCPR
	UIu5qDgRAM3RsNu0AwAA
X-CMS-MailID: 20241203134202eucas1p26bdcec486ee42440ded94ff801678ba0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134202eucas1p26bdcec486ee42440ded94ff801678ba0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134202eucas1p26bdcec486ee42440ded94ff801678ba0
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134202eucas1p26bdcec486ee42440ded94ff801678ba0@eucas1p2.samsung.com>

The IMG BXM-4-64 GPU is integrated into the T-Head TH1520 SoC. This
commit adds the compatible string "img,img-bxm-4-64" to the device tree
match table in the drm/imagination driver, enabling support for this
GPU.

By including this GPU in the compatible devices list, the driver can
initialize and manage the BXM-4-64 GPU on the TH1520 SoC, providing
graphics acceleration capabilities upstream.

This commit doesn't touch the img,powervr-rogue.yaml on purpose, as the
new dt-bindings schema was proposed [1], but not merged yet.

Link: https://lore.kernel.org/all/20241118-sets-bxs-4-64-patch-v1-v2-1-3fd45d9fb0cf@imgtec.com/ [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 85ee9abd1811..8633a3a315b7 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1475,6 +1475,7 @@ static void pvr_remove(struct platform_device *plat_dev)
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "img,img-axe", .data = NULL },
+	{ .compatible = "img,img-bxm-4-64", .data = NULL },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.34.1



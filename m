Return-Path: <linux-pm+bounces-20713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDECA1717D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C81884E58
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC91F151F;
	Mon, 20 Jan 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ncbd0a/k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570621F0E46
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393701; cv=none; b=tuOMECyx7pkO7Kw56o/FPzHdk3QvI3K5FYaugAuZdswwnnzIQPSpTJ7MID5Hr7qtJWQJZplGNMzlbZPl3HL2qaKMJtoiHyfEOl1A7E4G9gLBBMs+b+qu3DVIbXFfQKx3HuczLt88BTvM5pFvT6Hk5hCme2m0iOU/E3cdBChAauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393701; c=relaxed/simple;
	bh=lZP1PRVLM6i78+XC1Fl2U/8+AhqJAzU23UmSlaq2SZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SmNzcraXCyEW6pY+MW2/gmfTe9rxpqmMS6b/tyRnoE/sbHHCLzEoH9yCErRM4tqEMdIIsUBjW9xh6uoMFwIrRhpDADZR1dS31e77AuSHOiFJbCTSADD1QsuGcs2zYfD59WTdkhEQ+iXA/EWYBIBf/C0r8yUwdw3qjzVvmERxq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ncbd0a/k; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250120172136euoutp0151725b820acb9a12c0a95f669c99905c~cdlyoTc3G2441324413euoutp01Z
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250120172136euoutp0151725b820acb9a12c0a95f669c99905c~cdlyoTc3G2441324413euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737393696;
	bh=nuwkiED4lPbpZKtXLcNkHTpLcBgX1IbFQaBo7zxmeMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ncbd0a/komMMaFPIL5gfXYx3ENroZwR+rbaJqffPRKS6EtBrfG4hjoId2CwKDgYUl
	 j8NK60PIN6vtS/Ti6+1oFpOiwK5FbVYLxzzYSZxVySlH0VTM5GagVckKRlMVnZ0Kke
	 7BE8cWvEwmemw0XDGjUY7vpBhsOCe4w2fvjS8M4s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250120172136eucas1p2f45e75bc4a379046a1dbdf76402b116c~cdlyNSo7J3178431784eucas1p2T;
	Mon, 20 Jan 2025 17:21:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 89.66.20397.0268E876; Mon, 20
	Jan 2025 17:21:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250120172135eucas1p22f50d9db3fb656fbaf6ccc096dcb8c9f~cdlxzu3UW1088710887eucas1p2B;
	Mon, 20 Jan 2025 17:21:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250120172135eusmtrp21c3eeefc05f360d12fd0707b075015f4~cdlxy7IGV0490804908eusmtrp27;
	Mon, 20 Jan 2025 17:21:35 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-61-678e862064ef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.A5.19654.F168E876; Mon, 20
	Jan 2025 17:21:35 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172134eusmtip1538a3bfd29b585a5de5b7340c6e72a35~cdlwdp3Z-0819408194eusmtip1r;
	Mon, 20 Jan 2025 17:21:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC v3 12/18] drm/imagination: Add support for IMG BXM-4-64 GPU
Date: Mon, 20 Jan 2025 18:21:05 +0100
Message-Id: <20250120172111.3492708-13-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120172111.3492708-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjNe+/l3kuTukuB8KKLmxXnWDJgDPGdMj+iS66Z2ebGNMoYdvOm
	CLSQFvzaDJBSRrFS0U2kyECGoysr+NEi7aiNgFQ3KSBSdIPCDxdoZSICuuEGo1zd/HfO857n
	OeckL42LzORieq88m1PIJRliUkA0dfzV9frLhSXSmEofjq7112DI8kRPoR/tLgxVtbsCkOem
	GUO3psdJ1PB7N4VG7fkEchsqKaTqaCSRV+8h0YTWE4B6badJNHm0HaCmyQISmdoHKdQ4XYWh
	MxMWAtU22wAq1HwfgHp+fgcNeq4RyNurxVGh/gU019JMoVn3eQJV3HdQyDxWGoCcph2owPE1
	sWEpO35bTbFjXi/BthVNUaz9UTXBWvWDFKu13gDsBaOGZAfcLST77fVt7NARJ8ZerM1lC0wd
	GKv7J4Ydv9xHsiVmI2BvqvqpD0S7BAl7uIy9+zhF9LrdglSHrRzLqqcPdLnqyDygoooBTUMm
	Dmp0qBgIaBFjALDuXB7JkykAe/ssRDEInCeTAPqOBfuxf6HUWRzAi+oAvHG/kuDJGICDVjPp
	V5FMLByuq1pQhTBqAqqv5gM/wZkRAJvunib95sHMFqh5tMa/QDAr4MjAyYVlIbMB5vdeBLzd
	S9BxpRP348D5+eM+O8VrguD18rsL8fB5jcpSgfvvQ8YkgGNuI8aX2wwrhln+TjD0Oc0Uj1+E
	c9YqjMeZcNjyEOfxl9CqdT7Fa+GAa2YhJs5EwkZbND/eCIe6y3D++iJ4+48gPsEieLzp2VgI
	iwpFvPoV+I326H+mLkPTU1MW1lfrsGNgmf65Lvrnuuj/960GuBGEcTlKmZRTvinn9kcpJTJl
	jlwa9Xmm7AKY/9i/zDqnm4HBNxHVCjAatAJI4+IQYegDrVQk3CM5eIhTZKYocjI4ZStYQhPi
	MGGNQy0VMVJJNpfOcVmc4tkrRgcuzsOsJ+M/2/auMbxWJD0U+9b0kbgS25MIphLlzqiSHs6E
	RgrfW34WtcV2m8p8gvg2Z3RjxKhGnbzS9NXyXeLElq65NctmZZfEZWHe7FzFWaWgPCbi4/gz
	q13rXl3fYOsZaNyUl/XdgwZ58hJ7X704nd4dq756vmLL7IfbHWn3dPvYpM0JBys6LW4QeQf/
	WzLy51bWF6JzDq5MuNTdGXrYUPR+qaw5f3j7r2lV1hObbq0KS/wo9wdp8lSQ7fGV9p92eE58
	URvXOmrcuPOTtjup6w8n2VIcSz8dYYp7wn/D3cTEqXOJ/UMRQJy8sz4zqCZ9ZP8kaU9722tY
	lbJaG741+8C9y2NrxYQyVfLGa7hCKfkXz7s3x0cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7rybX3pBuebFC1OXF/EZLH19yx2
	izV7zzFZzD9yjtXi3qUtTBZXvr5ns1j39AK7xYu9jSwW11bMZbdoPraezeLlrHtsFh977rFa
	XN41h83ic+8RRottn1vYLNYeuctusf7rfCaLhR+3slgs2bGL0aKtcxmrxcVTrhZ3751gsXh5
	uYfZom0Wv8X/PTvYLf5d28hiMfvdfnaLLW8mslocXxtu0bJ/CouDnMf7G63sHm9evmTxONzx
	hd1j77cFLB47Z91l9+jZeYbRY9OqTjaPO9f2sHnMOxnocb/7OJPH5iX1Hi1rjzF59P818Hi/
	7yqbR9+WVYwel5qvswcIRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehl7N81k6lgNUfF+XPL2RoYm9m7GDk5JARMJCYe72LtYuTiEBJYyihx9usK
	RoiEjMS17pcsELawxJ9rXWwQRa8YJX713WIGSbAJGEk8WD6fFcQWEVjMIrF3XyVIEbPAW0aJ
	6zM3AnVzcAgLeEp0frMCqWERUJV4fmcaG4jNK+Ag0Xh5M9QyeYn9B8+CzeQEin+/uhfsOiEB
	e4k7V7sZIeoFJU7OfAJ2EDNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQv
	XS85P3cTIzC9bDv2c8sOxpWvPuodYmTiYDzEKMHBrCTCK/qhJ12INyWxsiq1KD++qDQntfgQ
	oynQ3ROZpUST84EJLq8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6p
	Bia9/oLj23UTvfVDnFWXqAXMMLmx6GTa2ap3J9SLmFpiHsf+P6fxdELjrMKSHWY+nY+LLr71
	kL1jY831x8DhW1q7R8DDZYd3cN0RM/m3Ok/WtZmjKcDRTO3aS7s/qe/vZvTO2GD+QE40ssj6
	Qp5apf7hVJFQlzX/L69er32/6OXcFyv+pfM2OXKV3D2csi6zLvdaH89rj/BDC0rM5ey6eVzL
	xPZI2DJfmu945+z0Ncc+GtUvnXzn+fYDHM3OB2+Y3z7G3aNyK70+qMSr6M01K2POhfOPS0jU
	rYk1+LCgXnMR54XH+9Pv/lexvm8+73hMnXXmJI+jP0T11p651CArtCEwyZHLxZl366WlXJsl
	mZVYijMSDbWYi4oTATY/yji4AwAA
X-CMS-MailID: 20250120172135eucas1p22f50d9db3fb656fbaf6ccc096dcb8c9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172135eucas1p22f50d9db3fb656fbaf6ccc096dcb8c9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172135eucas1p22f50d9db3fb656fbaf6ccc096dcb8c9f
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172135eucas1p22f50d9db3fb656fbaf6ccc096dcb8c9f@eucas1p2.samsung.com>

The IMG BXM-4-64 GPU is integrated into the T-Head TH1520 SoC. This
commit adds the compatible string "img,img-bxm" to the device tree match
table in the drm/imagination driver, enabling support for this GPU.

By including this GPU in the compatible devices list, the driver can
initialize and manage the BXM-4-64 GPU on the TH1520 SoC, providing
graphics acceleration capabilities upstream.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 85ee9abd1811..91af060bb3e0 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1475,6 +1475,7 @@ static void pvr_remove(struct platform_device *plat_dev)
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "img,img-axe", .data = NULL },
+	{ .compatible = "img,img-bxm", .data = NULL },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.34.1



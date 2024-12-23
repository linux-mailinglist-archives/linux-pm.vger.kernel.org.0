Return-Path: <linux-pm+bounces-19669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998B9FAE91
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51D0161DE1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30F1B6CFA;
	Mon, 23 Dec 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LjG13qpF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0E1B21B9
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958581; cv=none; b=YJ/UXwp90nlT2zwSJwD9UYD99oWF31tKkkdkiErkbBEbvGeLRTM6BLQlRlxVYFXlLKpuWPjN8iUcgwfELUaJ49rRO2nlcnec9CnXMZ6OE7ujPIhsxFo30UpiEktxX+80gCxSTAyndOT76eyZHMs9Iv0eZx8Pf1Bm/Eipwq/WKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958581; c=relaxed/simple;
	bh=NFfKkgU99HMpvDuK/njlZT3zcdPGI0KfAyQxrz92GRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=s+Y/v6I9EZbrEsYr85MC99q0+PsdrnnfAIOMzaeoROLsO5v32XJsquuen/u1am7BHTs4BGW2pXybLNHJv+tTF6mlxVsfPYhcvZHBg3vl/1A+rnvNjsVERWvDTykZQJot3LfesiBaN0ZJzLdlqg+/0InJfzc0tv+BJMXWfbWJlrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LjG13qpF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241223125615euoutp02040f9a073e46ecb46a80a7d8cf696218~Tz6HZ8X7H1017710177euoutp02i
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241223125615euoutp02040f9a073e46ecb46a80a7d8cf696218~Tz6HZ8X7H1017710177euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734958575;
	bh=+f3X/DCuFdKKzA9Co4hfqONzYJgQc/PdEIk3SwP3lE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjG13qpF6jsbDr5cR4CyLNoTs6ZyblpQQocej/kgKTbR4OXgisqaUo3q5+PeNQKCL
	 NvYAK+2TACMKWbtFqx+oKyhnXjcKuMQxWW8Mi/IAS8mRiPOZWUvdrAlxSAcP3EqrTX
	 N1UTwNyX+hohmZ09MZ9L/oYwDhV8gg4KOfcC3P/I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241223125614eucas1p24a133876e24d4d9de287258d7191d048~Tz6G23CfT2931129311eucas1p2H;
	Mon, 23 Dec 2024 12:56:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 82.52.20397.EED59676; Mon, 23
	Dec 2024 12:56:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241223125614eucas1p181b9db4e69de9915f0234fb1d1348465~Tz6GUEjq82329123291eucas1p1W;
	Mon, 23 Dec 2024 12:56:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241223125614eusmtrp142ae161a920ace4fad8475e6dbdedc55~Tz6GQ_f2c2059320593eusmtrp1v;
	Mon, 23 Dec 2024 12:56:14 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-98-67695dee1701
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.83.19654.EED59676; Mon, 23
	Dec 2024 12:56:14 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125612eusmtip2fb75917172dcee314c8bcd874d070cbc~Tz6E0sqm43262732627eusmtip2f;
	Mon, 23 Dec 2024 12:56:12 +0000 (GMT)
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
Subject: [RFC PATCH v2 10/19] drm/imagination: Add reset controller support
 for GPU initialization
Date: Mon, 23 Dec 2024 13:55:44 +0100
Message-Id: <20241223125553.3527812-11-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223125553.3527812-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG851zek5hKR6ObnwyIhEHcUQB0cxvgTQQZ3L+2AWTZU7DLs16
	UsnKxRYGOpaBXAZYQAQhq1ysGFoIFMS2FiYQK9KKkzEulUwobMNsdQwCiAxMYW0Pbv73fM/7
	e/K8b/IJccZEBgqTUtI5RYpEHkL6EqaBtZ/2z3+SJItq1h5CtodXMWR8rqZQa88Qhhr6hwTI
	MWLA0NjKAon0j4cp9GdPLoHsujoK5Q20k8ipdpBoUeUQoNHuWhItl/YDZFrOJ1Fb/xSF2lca
	MKRZNBLomrkboMLiJgH6efAomnLYCOQcVeGoUL0Nbd4yU2jDfp1Al+f7KGSYqxAga9txlN9X
	RcTtYhcmCih2zukk2DtFTym259kVgu1ST1GsqutHwHa2FJPspP0WydbfO8ZOn7di7I1r37L5
	bQMYW+6KYhd6x0m2zNAC2JG8h1QCc9I3VsrJk77iFJHiz31PfXdXi6U92J015hzBckBeUAnw
	EUL6EFQ1lRMezdA6AMddshLg69ZPAbyuXRPwj2UAf1NpqBeJ+sZOnE9oAay9EcJDcwDODWtI
	z4Cko+GMtsGb3kEXELDgbi7wPHD6DwBNs7VeajsthXn5MwKPJuhQWHezw7uIiI6DteYqkq8L
	hn23H3jrfNx+a8kE4Bl/eO/7WS+Pu5k842XcUwDpZl+oLysX8OF3oMVVjPN6O3xiNWzdEATv
	V6oIXqfCGePSFpMNu1TWLR0DJ4fW3UsI3QVvwvbuSN6Oh6tlDZTHhrQfnPjbn1/BD1401eC8
	LYJFhQxPh8FLqtL/Sod0JozXLLxqnsYugN3ql45Rv3SM+v/eKwBvAQFchjJZxikPpnCZEUpJ
	sjIjRRbxRWpyJ3B/7fsb1hUz0D1ZjLAATAgsAArxkB0iC5MkY0RSyZmznCL1M0WGnFNawOtC
	IiRAFCoN5hhaJknnvuS4NE7xYooJfQJzsDP2ivnm4x8PiWoGR5ilsQQ0+k95Y+VOa/yFwXaV
	s6dCIzlm8Qv7VMaco1KOxGQuHY0aN23G2Q0FWVn1f40Zo/XR3b/rfsh5b1/TrsRH08aThD7t
	rVcV07/6h3e25EuGzwX3igIr48Oow+8G+cXTuWLhM3PH6Yt7GquKR2IL37AxTKSra89C7Gbg
	keyymzXZqLHdWP3YZJPHTx6MqXb8sg4zxNXK6rB9uWvkcAwUpEHxgdc4Qt7xoSvZVWpM9++k
	zgcczqmL1mQ9R4mntxXp61cnbBs2f6C5vX62T9yyqr8zqxbvDf3oG8nXOz8IDJIm9L4f/krr
	pROZ++cSHW8/CiGUpyQHwnGFUvIvZKabokkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7rvYjPTDY6c4bI4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVrcvXeCxeLl
	5R5mi7ZZ/Bb/9+xgt/h3bSOLxex3+9kttryZyGpxfG24Rcv+KSwOch7vb7Sye7x5+ZLF43DH
	F3aPvd8WsHjsnHWX3aNn5xlGj02rOtk87lzbw+Yx72Sgx/3u40wem5fUe7SsPcbk0f/XwOP9
	vqtsHn1bVjF6XGq+zh4gFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CX0X50OVPBWcWKKy8vMTUwNst0MXJySAiYSMxbvIkZxBYSWMoocbfZCyIu
	I3Gt+yULhC0s8edaF1sXIxdQzStGiQ83GllBEmwCRhIPls8Hs0UEFrNI7N1XCVLELPCWUeL6
	zI1g3cICSRKHm/rYQGwWAVWJuds3gMV5BRwk5uyYwgaxQV5i/8GzYFdwAsXXdN1ghLjIXuLf
	qQ9sEPWCEidnPgHrZQaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn
	525iBKaXbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4DwllpgvxpiRWVqUW5ccXleakFh9iNAW6
	eyKzlGhyPjDB5ZXEG5oZmBqamFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnVwMRx
	qDm2wHzB5l8e85zu3eINW7Wmf1q//TaxjqypZSKXVLdwXjXz2uBYmrvErUnQ48PGlLmHfBV1
	trWUpv70ljv2RPphQgJLb3F7WEDCwfN1GRoCZ27vTzvcJ5GfwHSN93vO12TNRZ3FkZ9S3zjs
	j3L5yWhwzrarI768V+7w9Ic7dwgxtH5TWRAn80ut78pOq7PT0ucwcUyy90390h304MLk46+t
	1q2ruHrVZvcm+2bndfOeX221rWLRehseeuL7wjN7lOYo7GG4qyNT3H/w3q4Ngp/j9PoPWPf4
	T9DUWbwpYfM/pXOcYZycXwqUypYEbNKLYrijXPLu8kwWV/aJPxg8583boZR4ec+6XPeOciWW
	4oxEQy3mouJEALV9NhS4AwAA
X-CMS-MailID: 20241223125614eucas1p181b9db4e69de9915f0234fb1d1348465
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125614eucas1p181b9db4e69de9915f0234fb1d1348465
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125614eucas1p181b9db4e69de9915f0234fb1d1348465
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125614eucas1p181b9db4e69de9915f0234fb1d1348465@eucas1p1.samsung.com>

Certain platforms, such as the T-Head TH1520 and Banana Pi BPI-F3,
require a controlled GPU reset sequence during the power-up procedure
to ensure proper initialization. Without this reset, the GPU may remain
in an undefined state, potentially leading to stability or performance
issues.

This commit integrates a dedicated reset controller within the
drm/imagination driver. By doing so, the driver can coordinate the
necessary reset operations as part of the normal GPU bring-up process,
improving reliability and ensuring that the hardware is ready for
operation.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/pvr_device.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_device.h |  9 +++++++++
 drivers/gpu/drm/imagination/pvr_power.c  | 15 ++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 1704c0268589..83a8ba70a30e 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -120,6 +121,21 @@ static int pvr_device_clk_init(struct pvr_device *pvr_dev)
 	return 0;
 }
 
+static int pvr_device_reset_init(struct pvr_device *pvr_dev)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	struct reset_control *reset;
+
+	reset = devm_reset_control_get_optional_exclusive(drm_dev->dev, "gpu");
+	if (IS_ERR(reset))
+		return dev_err_probe(drm_dev->dev, PTR_ERR(reset),
+				     "failed to get gpu reset line\n");
+
+	pvr_dev->reset = reset;
+
+	return 0;
+}
+
 /**
  * pvr_device_process_active_queues() - Process all queue related events.
  * @pvr_dev: PowerVR device to check
@@ -509,6 +525,11 @@ pvr_device_init(struct pvr_device *pvr_dev)
 	if (err)
 		return err;
 
+	/* Get the reset line for the GPU */
+	err = pvr_device_reset_init(pvr_dev);
+	if (err)
+		return err;
+
 	/* Explicitly power the GPU so we can access control registers before the FW is booted. */
 	err = pm_runtime_resume_and_get(dev);
 	if (err)
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index 6d0dfacb677b..f6576c08111c 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -131,6 +131,15 @@ struct pvr_device {
 	 */
 	struct clk *mem_clk;
 
+	/**
+	 * @reset: Optional reset line.
+	 *
+	 * This may be used on some platforms to provide a reset line that needs to be de-asserted
+	 * after power-up procedure. It would also need to be asserted after the power-down
+	 * procedure.
+	 */
+	struct reset_control *reset;
+
 	/** @irq: IRQ number. */
 	int irq;
 
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index ba7816fd28ec..87a955600d8b 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -252,6 +253,9 @@ pvr_power_device_suspend(struct device *dev)
 	clk_disable_unprepare(pvr_dev->sys_clk);
 	clk_disable_unprepare(pvr_dev->core_clk);
 
+	if (pvr_dev->reset)
+		err = reset_control_assert(pvr_dev->reset);
+
 err_drm_dev_exit:
 	drm_dev_exit(idx);
 
@@ -282,16 +286,25 @@ pvr_power_device_resume(struct device *dev)
 	if (err)
 		goto err_sys_clk_disable;
 
+	if (pvr_dev->reset) {
+		err = reset_control_deassert(pvr_dev->reset);
+		if (err)
+			goto err_mem_clk_disable;
+	}
+
 	if (pvr_dev->fw_dev.booted) {
 		err = pvr_power_fw_enable(pvr_dev);
 		if (err)
-			goto err_mem_clk_disable;
+			goto err_reset_assert;
 	}
 
 	drm_dev_exit(idx);
 
 	return 0;
 
+err_reset_assert:
+	reset_control_assert(pvr_dev->reset);
+
 err_mem_clk_disable:
 	clk_disable_unprepare(pvr_dev->mem_clk);
 
-- 
2.34.1



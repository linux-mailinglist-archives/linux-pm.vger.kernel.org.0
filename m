Return-Path: <linux-pm+bounces-36770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F90C05605
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 11:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 310F24F5138
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981D3054E5;
	Fri, 24 Oct 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="idr7lAAe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1B2FB63F
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298588; cv=none; b=sc2bkeiT4aDGHauETaRfkp3XW+tuYF4jYeoao6T/3Yy8rzybLcqq/VZQvF6JP871dfxZ91n1fCN/OauKWrrrsaGoMoB7Gw8tIVAKGKrsbUaGu6Wq2JezHguSlzWFEsFQ52NlopZknWQWTVLVu6If+Uz8/9/QMfRpJXoTiKqdry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298588; c=relaxed/simple;
	bh=IhwFcLohg6CKFfqE7EDdE2jMLoyb02JJ0wyha3Wr1cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ciRbSdSfiqcqPJJIOIAFHjCMdor/eCvrdew4zPbs834AEj4o9/iSUMtJTWMMUA8i18FY6kzT227mt+ox6IBfgkB2R47G7VzXRb0xqTT2qduJrYfI+RtIfkFSvWPWAr5Mo5EiNeXCZeEe6VYPqKoN/sdV1vAQozolhMU30/WSryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=idr7lAAe; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251024093618euoutp022be645511fd93b73e8aee24dfbf19a57~xY7moP44Y3109631096euoutp02x
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 09:36:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251024093618euoutp022be645511fd93b73e8aee24dfbf19a57~xY7moP44Y3109631096euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761298578;
	bh=ERmBh8xYiDTbvxZ7jovH95wfR/eqlSI7mH3VZQ40nNM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=idr7lAAeHj3cE08helkfkXeCVQed8SvbyIeVFsCUnJ8U0eVgMBVikdkO0L5K9l/Cl
	 tif7KXj4ZfaBUzSFlsWF7mkX9oAsMIankUuKA2xYGr4XxiXJO9L+CXW0KMV/i/34cH
	 uihW/51e54r3KKg9qb3hdbj+JsMkgSUStQkCpEFg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9~xY7mU8nQK3107431074eucas1p2n;
	Fri, 24 Oct 2025 09:36:17 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251024093617eusmtip29ebfba4ee32bac7b05eb047c444494d7~xY7l7mEAJ2834328343eusmtip2Z;
	Fri, 24 Oct 2025 09:36:17 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, =?UTF-8?q?Andr=C3=A9=20Draszik?=
	<andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH] pmdomain: samsung: Rework legacy splash-screen handover
 workaround
Date: Fri, 24 Oct 2025 11:36:03 +0200
Message-Id: <20251024093603.3484783-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
X-EPHeader: CA
X-CMS-RootMailID: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
References: <CGME20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9@eucas1p2.samsung.com>

Limit the workaround for splash-screen handover handling to the affected
power domains in legacy ARM 32bit systems and replace forcing a
sync_state by explicite power domain shutdown. This approach lets
compiler to optimize it out on newer ARM 64bit systems.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 0745658aebbe ("pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index f53e1bd24798..8e7ac1ab0780 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -128,6 +128,16 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
 
+	/*
+	 * Some Samsung platforms with bootloaders turning on the splash-screen
+	 * and handing it over to the kernel, requires the power-domains to be
+	 * reset during boot.
+	 */
+	if (IS_ENABLED(CONFIG_ARM) &&
+	    of_device_is_compatible(np, "samsung,exynos4210-pd") &&
+	    (strstr(pd->pd.name, "LCD") || strstr(pd->pd.name, "DISP")))
+		exynos_pd_power_off(&pd->pd);
+
 	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
@@ -146,15 +156,6 @@ static int exynos_pd_probe(struct platform_device *pdev)
 				parent.np, child.np);
 	}
 
-	/*
-	 * Some Samsung platforms with bootloaders turning on the splash-screen
-	 * and handing it over to the kernel, requires the power-domains to be
-	 * reset during boot. As a temporary hack to manage this, let's enforce
-	 * a sync_state.
-	 */
-	if (!ret)
-		of_genpd_sync_state(np);
-
 	pm_runtime_enable(dev);
 	return ret;
 }
-- 
2.34.1



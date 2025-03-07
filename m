Return-Path: <linux-pm+bounces-23655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13806A57395
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 22:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F186C189B2DD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3A257AFC;
	Fri,  7 Mar 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="S61nIiBK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE561991CF;
	Fri,  7 Mar 2025 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382636; cv=none; b=qC4dMH5hqNsxfCY2U+8tdhidMLo30xeuqy3PCUEVHc/EcHjpIIpdvxlMdoloVaKjsKbFpDiu93Azva+MH1WotG6nteZ+6bqJIjD4x5rFqfu88mILoZQ8Oob1In60+Q9TOs5EF1SOS1wUyxINa+JoT0N+xiS7k7gkJ4oJIhqbai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382636; c=relaxed/simple;
	bh=RS93ZbOAzMBBEDO9HzJjyF6X9D+u1i2KDyI+wUFunHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Km61NYGThclHquM+toOJn2DeZv+DZB2ATIkTxx3+zPqAYNSxvf0BkT91ajEuqDdyu6kJzI1OxhlWHSrVr2LDbnCAiKv7YN1AcPlqCPC5V1U5a0Zmydw3t7+gYqUV5VwgRXF+FKxjRLW+fBB/XIc+hkHwHlLD37k8tTyGSgtqrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=S61nIiBK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=GCO72uFmx6xppf23halPg7wu85+M0x1vkpq7t0HjnaY=; b=S61nIiBK9LpSHHz4
	vdCtaZbtM+6E9svrmcRFezvO94kaloCq4Y3TyWz3wPP+KCLrGS2VZfsjiaBpiWcaKnrb7rhhJa/he
	LvOqWNl4ojW/B6sX+Ub0pLfx3SYf47Rm4EBLtpQ8TJ4z7rEk/Nuhths4CuFKURpXILZc0RMyPEkOv
	Rn3RLl99dGExtwRnD2JVINbKLG0MoOlYghfMlCztDteohxBtFH6g3eyVZS9o6kNWRNEFAxn6kpFUZ
	dPsbez6j40Aa3OVmwIwkodkJFJK3sk2Wz8rgMfEFbf5z8wjomT7q8gpMmHwwjPisDgG4NKg9mrs5V
	FuC58brd+IVzSzgtKQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqfAa-003WBC-0z;
	Fri, 07 Mar 2025 21:23:48 +0000
From: linux@treblig.org
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: gregkh@linuxfoundation.org,
	dakr@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] PM: clk: Remove unused pm_clk_remove
Date: Fri,  7 Mar 2025 21:23:47 +0000
Message-ID: <20250307212347.68785-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pm_clk_remove() is currently unused.
It hasn't been used since at least 2011 when it was renamed from
pm_runtime_clk_remove by
commit 3d5c30367cbc ("PM: Rename clock management functions")

Remove it.

Note that the __pm_clk_remove is still used and is left in.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/base/power/clock_ops.c | 40 ----------------------------------
 include/linux/pm_clock.h       |  4 ----
 2 files changed, 44 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 97a53215a274..b69bcb37c830 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -343,46 +343,6 @@ static void __pm_clk_remove(struct pm_clock_entry *ce)
 	kfree(ce);
 }
 
-/**
- * pm_clk_remove - Stop using a device clock for power management.
- * @dev: Device whose clock should not be used for PM any more.
- * @con_id: Connection ID of the clock.
- *
- * Remove the clock represented by @con_id from the list of clocks used for
- * the power management of @dev.
- */
-void pm_clk_remove(struct device *dev, const char *con_id)
-{
-	struct pm_subsys_data *psd = dev_to_psd(dev);
-	struct pm_clock_entry *ce;
-
-	if (!psd)
-		return;
-
-	pm_clk_list_lock(psd);
-
-	list_for_each_entry(ce, &psd->clock_list, node) {
-		if (!con_id && !ce->con_id)
-			goto remove;
-		else if (!con_id || !ce->con_id)
-			continue;
-		else if (!strcmp(con_id, ce->con_id))
-			goto remove;
-	}
-
-	pm_clk_list_unlock(psd);
-	return;
-
- remove:
-	list_del(&ce->node);
-	if (ce->enabled_when_prepared)
-		psd->clock_op_might_sleep--;
-	pm_clk_list_unlock(psd);
-
-	__pm_clk_remove(ce);
-}
-EXPORT_SYMBOL_GPL(pm_clk_remove);
-
 /**
  * pm_clk_remove_clk - Stop using a device clock for power management.
  * @dev: Device whose clock should not be used for PM any more.
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 45c3f3ccbaf8..c3b46fa358d3 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -42,7 +42,6 @@ extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
 extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
 extern int of_pm_clk_add_clks(struct device *dev);
-extern void pm_clk_remove(struct device *dev, const char *con_id);
 extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
@@ -75,9 +74,6 @@ static inline int of_pm_clk_add_clks(struct device *dev)
 {
 	return -EINVAL;
 }
-static inline void pm_clk_remove(struct device *dev, const char *con_id)
-{
-}
 #define pm_clk_suspend	NULL
 #define pm_clk_resume	NULL
 static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
-- 
2.48.1



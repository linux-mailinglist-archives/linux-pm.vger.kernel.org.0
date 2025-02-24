Return-Path: <linux-pm+bounces-22756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F1A4128D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 02:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3A316C4B7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 01:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC71F95C;
	Mon, 24 Feb 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GmT+2TVn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A501E531;
	Mon, 24 Feb 2025 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740359188; cv=none; b=MvAjBVbEEwuAF97oOvUJrx65Go7JQ2LBRW69952yzo6ZFsj9/1HKVp1GRk27Lpp1REXaQQyDr0BrUqUhN63Adn7vPtbEM3TyCTYfwJfD1i4ntMizc6Q4Wrp/OqthSqITYvFq076h2aPHOVTFjYssVK3iZScTszS7q8+wvB6Fz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740359188; c=relaxed/simple;
	bh=qUeK+DYw5QF7WI/ac9EdaemNttm99t9FTfp+FTey2PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jw3cr5aX+IAtnnTKsAOU4/Ot00UnppkIEhsZEGlmzY0PedKFS2lQkv3MMBxCD1KKrhUd1Vh+Hw9rSv2edwG4ALfaDIsJ8VtfV2RtQnmaPvezeufl9VIWWaccUgDBXuv0DFrRrFGUd4BCvQMw4g49cSlPuHQV+nA3KY/j7F1KrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GmT+2TVn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=YU6no+TiJHJTVS/tbpucp7wHn/glcgmEOL9eoE0ZnhM=; b=GmT+2TVn+jv6oSbq
	lbl3JRbL14WAYDDuMxu3atrnhyqpU1TjMJkYfFZrUi0PmGy8SvvC3+uPJkeP8ZmUw49MMLVsh6O84
	n9J87KE+m4PeyguoO+LIZjBfRNCTGuZ5kHVWbsmhp5B3UOPIj2ICvGou2F81/uZ4J8dKK7riuoNfw
	CbU8fmNcpsNVdkDMWKfCvuwMylXDAvIPLz2hKwvXBLglCMix82zQWxYmm8aQWtDa/dGCvBag5G0h6
	AVgNBgdfQsLCS0IroEkfIRpz/A4WreT0pKAoXohuMzd/ppcOHxCc4ATuDi2qbd8N9H3AkfTMFAgV6
	sJRkiueuechTgljXDQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tmMvF-000Eec-1f;
	Mon, 24 Feb 2025 01:06:13 +0000
From: linux@treblig.org
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] PM: clk: remove unused of_pm_clk_add_clk
Date: Mon, 24 Feb 2025 01:06:10 +0000
Message-ID: <20250224010610.187503-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of of_pm_clk_add_clk() was removed by 2019's
commit fe00f8900ca7 ("irqchip/gic-pm: Update driver to use clk_bulk APIs")

Remove it.

Note that the plural version of_pm_clk_add_clks() is still being
used and is left.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/base/power/clock_ops.c | 33 ---------------------------------
 include/linux/pm_clock.h       |  1 -
 2 files changed, 34 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index e18ba676cdf6..97a53215a274 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -259,39 +259,6 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(pm_clk_add_clk);
 
-
-/**
- * of_pm_clk_add_clk - Start using a device clock for power management.
- * @dev: Device whose clock is going to be used for power management.
- * @name: Name of clock that is going to be used for power management.
- *
- * Add the clock described in the 'clocks' device-tree node that matches
- * with the 'name' provided, to the list of clocks used for the power
- * management of @dev. On success, returns 0. Returns a negative error
- * code if the clock is not found or cannot be added.
- */
-int of_pm_clk_add_clk(struct device *dev, const char *name)
-{
-	struct clk *clk;
-	int ret;
-
-	if (!dev || !dev->of_node || !name)
-		return -EINVAL;
-
-	clk = of_clk_get_by_name(dev->of_node, name);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = pm_clk_add_clk(dev, clk);
-	if (ret) {
-		clk_put(clk);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_pm_clk_add_clk);
-
 /**
  * of_pm_clk_add_clks - Start using device clock(s) for power management.
  * @dev: Device whose clock(s) is going to be used for power management.
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 68669ce18720..45c3f3ccbaf8 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -41,7 +41,6 @@ extern int pm_clk_create(struct device *dev);
 extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
 extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
-extern int of_pm_clk_add_clk(struct device *dev, const char *name);
 extern int of_pm_clk_add_clks(struct device *dev);
 extern void pm_clk_remove(struct device *dev, const char *con_id);
 extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
-- 
2.48.1



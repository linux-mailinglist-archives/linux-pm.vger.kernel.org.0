Return-Path: <linux-pm+bounces-30104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A39AF8ABF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 10:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBB93AE987
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F52EF66F;
	Fri,  4 Jul 2025 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GluMr4ia"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3D2ED870;
	Fri,  4 Jul 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615692; cv=none; b=sT7gw5sEBZxSSO//eIo3VkPNoliNsqLxZizR7OrqCbZ1lCBtF3zNZ4TWhFZ1RrDr6FY96e+FI7VChjsBAZ8R9dt489kXu/AIgfxMZ1PChUosVziuohZo5Z0NCrCdayur18M7KFOR+B8SQt3yr44sXKhYfccBE9mHuxsiAMVVfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615692; c=relaxed/simple;
	bh=z1WU7aXqnXZQeYjv9jg8ZGRmWpkJQr3gpOv29qe4/Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5PL6nieeyLkdVkZ6sfq+Y6ZgQwCL7Yv0fDH4cANycvHm1usF4xzbUFBecfKjhpurVUT2xdsjQ1K5v2agxUkrCnFAQfMC+7S2A8c5s75Zbnjl2fYDUZVntyW8+aI+GKTju4XRdvQCGqW7tUbloK4HbwtkZ7H/GutKJ58bIGA47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GluMr4ia; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615691; x=1783151691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z1WU7aXqnXZQeYjv9jg8ZGRmWpkJQr3gpOv29qe4/Xk=;
  b=GluMr4iaTHcpI/haVvDFT+LJAWVPaCJABECMKIe8ar+P4hJequX8UTAC
   4KhtJultc0/urCTQPjOHxj1WQYTNj9A5wWCxjs3DzVMj+AdyVViCw8ul1
   ogmp0WJFdLUp8wFI8fvJf3OEw3Bi5sTpjEMfR8yseqmhImUXE1xDddjGS
   BQBoh0y5TPHwMl1adreI5jkYJR5D4EMQK2QsrSyV2NpLWnv73PlcNNGCC
   x7EGRfe6bsY/K/2q2ALrI5mUvpfm39rcMYBYfg3o4tdO9CDtc/EkUjskF
   NmkzqJzxKc/+sgNwU9Q1mXS+QvsGWdwYfuT1JSxUyZmVibeLJdSV/s0t4
   g==;
X-CSE-ConnectionGUID: fAdWTSibTaq4jNlm6yGSFA==
X-CSE-MsgGUID: 0fuwQJeDTAmQlPb5YNQUdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194215"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194215"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:47 -0700
X-CSE-ConnectionGUID: XHyrtIOfR5yd2sGnu7Nx4A==
X-CSE-MsgGUID: Wt9qK+XmSAGm2W2+KMQOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616607"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:44 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 8063744A4B;
	Fri,  4 Jul 2025 10:54:42 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 54/80] power: supply: bq24190: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:42 +0300
Message-Id: <20250704075442.3221283-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/power/supply/bq24190_charger.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2c3804e1207e..e1510c7fdab3 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -504,7 +504,6 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	else
 		count = sysfs_emit(buf, "%hhx\n", v);
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
@@ -535,7 +534,6 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 	if (ret)
 		count = ret;
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
@@ -562,7 +560,6 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 	else
 		ret = bq24190_charger_set_charge_type(bdi, &val);
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -605,7 +602,6 @@ static int bq24296_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 	}
 
 out:
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -638,7 +634,6 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 				BQ24190_REG_POC_CHG_CONFIG_MASK,
 				BQ24190_REG_POC_CHG_CONFIG_SHIFT, &val);
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	if (ret)
@@ -675,7 +670,6 @@ static int bq24296_vbus_is_enabled(struct regulator_dev *dev)
 				BQ24296_REG_POC_OTG_CONFIG_MASK,
 				BQ24296_REG_POC_OTG_CONFIG_SHIFT, &val);
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	if (ret)
@@ -1376,7 +1370,6 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 		ret = -ENODATA;
 	}
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1419,7 +1412,6 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 		ret = -EINVAL;
 	}
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1682,7 +1674,6 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 		ret = -ENODATA;
 	}
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1713,7 +1704,6 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 		ret = -EINVAL;
 	}
 
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1861,7 +1851,6 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 		return IRQ_NONE;
 	}
 	bq24190_check_status(bdi);
-	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 	bdi->irq_event = false;
 
@@ -2188,7 +2177,6 @@ static int bq24190_probe(struct i2c_client *client)
 
 	enable_irq_wake(client->irq);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -2275,7 +2263,6 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 	bq24190_register_reset(bdi);
 
 	if (error >= 0) {
-		pm_runtime_mark_last_busy(bdi->dev);
 		pm_runtime_put_autosuspend(bdi->dev);
 	}
 
@@ -2300,7 +2287,6 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 
 	if (error >= 0) {
-		pm_runtime_mark_last_busy(bdi->dev);
 		pm_runtime_put_autosuspend(bdi->dev);
 	}
 
-- 
2.39.5



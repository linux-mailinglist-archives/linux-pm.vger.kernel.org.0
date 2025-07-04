Return-Path: <linux-pm+bounces-30105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB27AF8AAD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 10:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EDE188AE47
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F182F199C;
	Fri,  4 Jul 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqwWl0I9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0362EFD89;
	Fri,  4 Jul 2025 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615697; cv=none; b=S8x+dbsu5FRAXajPCFHebmU/jCDO7ycBYXEjrEHcNlMDBevpsDxh+KHypwi6HcS0XeEWYDi0tE8tG25BLPEBXkc/B/MBjAA3LnI8s5puW2Mg4KGSvqpJ0eWrvLJ0ruH8rBExtX2IgYPRgs02wvLS7OIOgkKaKQlSTLjIkXmpOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615697; c=relaxed/simple;
	bh=RIcCzYI0omisWFmazd0VVo2FRQVujzPyYzOVgfw8bqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MinmPCeaslNPxAf4PGS8cgSx0itxN9tRYlpV/lcAXzdPlvZuULJgW9mFWnxWsm29N/22A4dMN3IiYQ/6ssWlegWGtY1LKAV8JFrL3LEzLDVR9IMLvenLaT8mkGBv56WXUw/pykrRd+EnPmwQehr3/I2+8xTPVrjjPTJbvpuC6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqwWl0I9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615695; x=1783151695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RIcCzYI0omisWFmazd0VVo2FRQVujzPyYzOVgfw8bqU=;
  b=mqwWl0I9ibhLYvlBirTdSdWx6FTAlLYkytS8w83HjBq1ae+seaFiARkc
   uDPI1Rhp4L3ek6Y3Oh9ZeXjNu9N+tCkSyQCAXQ9M1kMBxCVr/drU88kLr
   KorVUUFrkVINxizGp9AEztanG9WuIPWPpGng1XwjqtFRcPKlY1qDOSsBm
   8sxqYT9qGIaP/CTv9Q4i5+pB1tIsHgGW+dBCeQiH4F6PKT59/UHyTrFWj
   GFeXph3e1cCe5g455HCWLBFjmrpia+tjOwTX2b++pGG+roUenvEwQm1fT
   WjLCgkP7JzLpxYwK31vR2eoV6bRh6WA/p22nkiKLW7vrTmmDjJ/IQPwyI
   Q==;
X-CSE-ConnectionGUID: ZbCvDpDYSKqhYYJ1Kz6ktg==
X-CSE-MsgGUID: 7v9BHGmeSUOHvqrA9GDaXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194227"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194227"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:47 -0700
X-CSE-ConnectionGUID: kNh7sPjLQEKh+YsQsQJClw==
X-CSE-MsgGUID: 4T0DHlcURkeMStImsUv7Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616612"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:45 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 1751144BAC;
	Fri,  4 Jul 2025 10:54:43 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 55/80] power: supply: twl4030_charger: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:42 +0300
Message-Id: <20250704075442.3221330-1-sakari.ailus@linux.intel.com>
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

 drivers/power/supply/twl4030_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 9dcb5457bef4..04216b2bfb6c 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -512,7 +512,6 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 		ret |= twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
 					TWL4030_BCIMDKEY);
 		if (bci->usb_enabled) {
-			pm_runtime_mark_last_busy(bci->transceiver->dev);
 			pm_runtime_put_autosuspend(bci->transceiver->dev);
 			bci->usb_enabled = 0;
 		}
-- 
2.39.5



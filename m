Return-Path: <linux-pm+bounces-22531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144CA3D2BE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 09:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BE23AAB37
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EDA1E9B29;
	Thu, 20 Feb 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljXsI9/p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63A1E9B1C;
	Thu, 20 Feb 2025 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038633; cv=none; b=u7q7gQEIDUmlEGIOTGASetd2hbTvy6UST08m0gL00YxsRPyicTL+PpHeNYwlmD/XwuzIor0Ray6gmcrRG4JOjD8n92M+ABh4aMOF8ZAfk5/I1/mzLz5kkCcArDcclGGO4YyVfmQP4yyrBCXGNEQ987/l4K8ZUqEK2LLo9h3nyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038633; c=relaxed/simple;
	bh=PlKeq7DFHjk5vBXjduffQcg/qaBGTbWGBDcBlOgsNaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMM+lVZaGqMxFeRAZjdLYOVvC41wFlkep4SNs6OpiL2jfKwl/hxO7u0Q2RjzibDA8AYVb2TkV9me/aGqGUtW/ocI5b3FA0n+6Blviw16fbhGgh8vdmmOLM8be64C0pIktXKnU4EhicundAso2+qC0bQZ0B4N9WZYPHUly9TqxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljXsI9/p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740038631; x=1771574631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PlKeq7DFHjk5vBXjduffQcg/qaBGTbWGBDcBlOgsNaA=;
  b=ljXsI9/pMX9eYOK42JNDWaSqi+0VJEw4/azgRrrZePdblP5M8RJ5sFo/
   btWljDCkwq9Zqu4niyELV6+lBGBiVr2k1BiiKtGta88jRdOjQoMtE/5zK
   8hEgzHKR3FM/glUD76km5tv0hBzH69GZOzN+gBuuBUzb2H7ffUTJMsCeJ
   7lAyTAlaYg6e/YpCHe3yuhfXFAQVSB7wtAERHwlLgfqOtwBOIGf5qDff/
   pDWbY3hBti89OdYcs3bna+bwaIqvfMQDdbR/aglxMQGrN7wWJL/s9md4u
   UGHvw7EoxQcU/HQORQm2OJjV6aeheqgFsX+GVgbilFixebptYJ9J1qugS
   g==;
X-CSE-ConnectionGUID: 1CHVAOlfRQq+BF+W/rqZXw==
X-CSE-MsgGUID: +EzCcbj2QwuHCNh+Td2Fug==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43636435"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="43636435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:03:51 -0800
X-CSE-ConnectionGUID: 78NuxiliRKG/hvK9AjBDZA==
X-CSE-MsgGUID: aYFGEHQSR0eOuBAGFKs3fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120073039"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2025 00:03:49 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	paul@crapouillou.net,
	andriy.shevchenko@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] PM: Discard runtime_xx() handles using pm_ptr()
Date: Thu, 20 Feb 2025 13:33:18 +0530
Message-Id: <20250220080318.2660840-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discard runtime_xx() handles in RUNTIME_PM_OPS() using pm_ptr() macro
and drop unnecessary CONFIG_PM ifdeffery.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
PS: I'm not very confident about this but thought I'd give it a try.

 include/linux/pm.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 78855d794342..416561c60e81 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -334,9 +334,9 @@ struct dev_pm_ops {
 	.restore_noirq = pm_sleep_ptr(resume_fn),
 
 #define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-	.runtime_suspend = suspend_fn, \
-	.runtime_resume = resume_fn, \
-	.runtime_idle = idle_fn,
+	.runtime_suspend = pm_ptr(suspend_fn), \
+	.runtime_resume = pm_ptr(resume_fn), \
+	.runtime_idle = pm_ptr(idle_fn),
 
 #ifdef CONFIG_PM_SLEEP
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
@@ -359,12 +359,8 @@ struct dev_pm_ops {
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
-#ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
-#else
-#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
-#endif
 
 #define _DEFINE_DEV_PM_OPS(name, \
 			   suspend_fn, resume_fn, \
-- 
2.34.1



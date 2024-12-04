Return-Path: <linux-pm+bounces-18542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AD9E3C3C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBAC28212E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB120ADCF;
	Wed,  4 Dec 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsGdNooP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A41F756C;
	Wed,  4 Dec 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321331; cv=none; b=hVVJqJea0eqfNI9UzTOb4nEs6yga9SKlhsNXR6OEb+s2Se+eOGUMioBp8kT4NJxc7doi5JDfsEe3GNO+JSHBtZoxjCx4ext65p1qHCVopiKt1W1f0aPN8rtU0LnxFR5sEp7u96bGMT3+ecjDN3xOGpQkcau29AaKrrQVLERY5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321331; c=relaxed/simple;
	bh=EoJPcegiCvqGtrUMOmWNUZkvi6nJNOkiK9y7RqMqaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6yt9NLuo2/uzfAT6SGB98ijUi212QvjY0ssabQYYZeWSceyhWtPs+Ct5zg5AAJeXjXx7pS1pDGNCdDcNDOXcY08ImVnHf8s5nlj+lfqv1QfoKrF8dY79Jujt6jX5sU+Ylst6kzrO0yjyuooGjhD7RXAT327lkQnYMYli4PkOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsGdNooP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321330; x=1764857330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EoJPcegiCvqGtrUMOmWNUZkvi6nJNOkiK9y7RqMqaPY=;
  b=XsGdNooPfHIMaOmjfEc7YNSn87opC9QJNvkqc2Ktd6huAEUyMhsSXhHZ
   YGqe+HM5o2kz6+SWeU1xBv33q105uCnHGTUgvOWzot6ugTWIwPqSsjMKD
   A/6r+I5f54BudttEogHL6eWC/GS4gY0LdS7XRQ2gGqMGlhSPYOHY43Rg3
   3lP6xhcks71sIYO6L4w2OewPwg4E5eMskVdoxUa0h/Vje2vTe5WILyJZh
   HwuksmyxPJ4rTK0fcD8fYUIZ5KDxccsw49VLUFAji7AUZ8WLMgJSHMey7
   EXYNMPzBy108zX2g6yu+o66ykLXT987aV59mjZs24M+wnTjgljIgj9qvi
   w==;
X-CSE-ConnectionGUID: z9eYiT02QgKhqkJ4XMLn9A==
X-CSE-MsgGUID: QE7pt1glSGOkx9/6kSCamw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56071383"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="56071383"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:50 -0800
X-CSE-ConnectionGUID: 8n5Em5uiSCmSiqWVX/3ZWg==
X-CSE-MsgGUID: /zftLhZISJCHCiupBU62QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98202789"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:47 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v8 3/4] intel_idle: Provide the default enter_dead() handler
Date: Wed,  4 Dec 2024 15:08:27 +0100
Message-ID: <20241204140828.11699-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent Intel platforms require idle driver to provide information about
the MWAIT hint used to enter the deepest idle state in the play_dead
code.

Provide the default enter_dead() handler for all of the platforms and
allow overwriting with a custom handler for each platform if needed.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 drivers/idle/intel_idle.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..c6874a6dbe95 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/smp.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -227,6 +228,16 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+static __cpuidle void intel_idle_enter_dead(struct cpuidle_device *dev,
+					    int index)
+{
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	struct cpuidle_state *state = &drv->states[index];
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	mwait_play_dead(eax);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -1798,6 +1809,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
 		state->enter = intel_idle;
+		state->enter_dead = intel_idle_enter_dead;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
 }
@@ -2143,10 +2155,12 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		if (intel_idle_max_cstate_reached(cstate))
 			break;
 
-		if (!cpuidle_state_table[cstate].enter &&
-		    !cpuidle_state_table[cstate].enter_s2idle)
+		if (!cpuidle_state_table[cstate].enter)
 			break;
 
+		if (!cpuidle_state_table[cstate].enter_dead)
+			cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
+
 		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",
-- 
2.47.1



Return-Path: <linux-pm+bounces-21410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5034A29558
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A4A168B5B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC61ADC7C;
	Wed,  5 Feb 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ3ZrYUt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEDC193086
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770743; cv=none; b=NK4VE2BalVNQf3HJo8bf9LcbhGZZGEyEPSLnTlUmsUuT5gk8ii2yvjNHexja93kYZY8xlOXl1Slu+IHzkeqUj0s431lVc5v7icLphmgoyKsOajysLK8VeGt0sm3wm6l3ZTlS2cHF8D2D15Gp2/rq4siiMHGO0ps8OKu8eBucBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770743; c=relaxed/simple;
	bh=6oyjRcE4ai1K7dxPIDALUI2reL9g3dxSTCbQ07JCtK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLtM/jS5HsOr7jcxthkxtiOfH+46KBNNfpHrmIjuyFMgIjm04FYRsQvMFh4SN5EJ7CfcF7Ts8IRH7aBTmBlTD99Uu+I+/3O2KbdbfjbGviXs/yd7zWUIkBHPw0XldEHyrEYrhjflJ+ZTjBrsTQM3P0QMi2qvzyn1XM0pOiHQnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ3ZrYUt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738770743; x=1770306743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6oyjRcE4ai1K7dxPIDALUI2reL9g3dxSTCbQ07JCtK8=;
  b=bQ3ZrYUtl62QgvIKQlGyWyHO2BESbkQpG8mjnrgEUvFq459H9XZBYy5p
   xUo5tfVWTWs6ztxRkP9jYI9tBO3GSfanHrD9hspnXK6FFr8TPFBNhoQAt
   mC+ayqYvnYesXzql3sIutrkRGg6ywBW+2T+Y2QEWiETmwsDJ3gtcudAN8
   50Fq/eebXmORb25HXZ7o1muHWxn03hiwK2ESd87Y1ImAB7GX6rgRVDcPf
   9CxbrbsSzcGTL2YA8OpmNtuzaQVAW1RpG9pyCJpf7tOunFbngb+oJicqN
   1f6tdvJNj8AVlhcodMQ7+9Rz/Y9QKcLdn+8okE/t6b9xYVnFEJN6G/7ZJ
   g==;
X-CSE-ConnectionGUID: kz1xkUPoR82kVsuo1v/zgw==
X-CSE-MsgGUID: t7HvquXwQLSjxrqnguxs8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50331003"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="50331003"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:52:22 -0800
X-CSE-ConnectionGUID: nHReDnSxRrinMfgtljsblg==
X-CSE-MsgGUID: yl6C2V57RUCWzn9AfSwF3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111516318"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa009.fm.intel.com with ESMTP; 05 Feb 2025 07:52:20 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com
Subject: [PATCH v11 3/4] intel_idle: Provide the default enter_dead() handler
Date: Wed,  5 Feb 2025 17:52:10 +0200
Message-ID: <20250205155211.329780-4-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205155211.329780-1-artem.bityutskiy@linux.intel.com>
References: <20250205155211.329780-1-artem.bityutskiy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Recent Intel platforms require idle driver to provide information about
the MWAIT hint used to enter the deepest idle state in the play_dead
code.

Provide the default enter_dead() handler for all of the platforms and
allow overwriting with a custom handler for each platform if needed.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..e59073efb6fa 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -57,6 +57,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/smp.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -228,6 +229,15 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+static void intel_idle_enter_dead(struct cpuidle_device *dev, int index)
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
@@ -1800,6 +1810,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
 		state->enter = intel_idle;
+		state->enter_dead = intel_idle_enter_dead;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
 }
@@ -2149,6 +2160,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		    !cpuidle_state_table[cstate].enter_s2idle)
 			break;
 
+		if (!cpuidle_state_table[cstate].enter_dead)
+			cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
+
 		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",
-- 
2.47.1



Return-Path: <linux-pm+bounces-18259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8339DEC0F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D955BB225C6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A671A3038;
	Fri, 29 Nov 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c27wDUc1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09F1A2C0E;
	Fri, 29 Nov 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904579; cv=none; b=hLfs6UBUjs1syeqnWpu3KXUqo3a8FriLnD5Lkhxo4qMHkVijYjkiwKh+I8K2GaIfwfpX4KITqTiEv3TLqVDrv2xH4bmDN3ZqUPWxfTKoVvvpe2Rrd+/T8bIN8+FYmrhctPBskKx9dFTTtW8LnTvKk7tvaYwoSgjXZ03+d/ahMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904579; c=relaxed/simple;
	bh=EoJPcegiCvqGtrUMOmWNUZkvi6nJNOkiK9y7RqMqaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhW+Sne/gIHqOmy7zQSGyTFu3476dvK06BcdfwEzSqlMKOSm0ph6u03uA7cVfw5lYambegzGcFTDis84xwTCeOqqyAGA0hM3r28tM1C/fnbni0XjN+DwMuHVHZEnZegfK4+RwLRtX5u1rha5A2JRAygCFl5fJ0jtv6AuLR1cLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c27wDUc1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732904578; x=1764440578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EoJPcegiCvqGtrUMOmWNUZkvi6nJNOkiK9y7RqMqaPY=;
  b=c27wDUc19I6eGJThyFb1OeIdB+uU897oB6dmYQlTmLlOJyW30xJfvoqu
   bvDjP06ZSe/FDba6Jr+wsWFhhEADUa0nPqfTmPH9GUQfjpEBAXRACadAD
   hrAH5sxsh+vgLAnqFD5IqXtkn5iKPojiNbn+VZVBJ5PTKbJ4wjxrPjZCe
   GLSCr2d1Xs7GM+zElqZX37M3s8SJR9razo0Xo7JUFKcPBpvhZ4DGNyJkp
   iE330Gz8thYx2gVkSX37Zecqjt6cgwpKusK87Ba0Emj8ZLu6jFYLJw+Xq
   7bp6tDK9GFIWcYPTpJ49lEmMOJlrrTXAdJl/rjqgeczQVgUlADHUs8T0D
   A==;
X-CSE-ConnectionGUID: 9TdqRY2WS5+PV80R7PFUDA==
X-CSE-MsgGUID: MQ9lN38LShmgmKc2xI0BEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36811957"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="36811957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:58 -0800
X-CSE-ConnectionGUID: nCtpS7gvQB64W95nzELOaQ==
X-CSE-MsgGUID: lnGwPQe+Q76z2PTUSIifzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="92422158"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.203])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:55 -0800
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
Subject: [PATCH v7 3/4] intel_idle: Provide the default enter_dead() handler
Date: Fri, 29 Nov 2024 19:22:31 +0100
Message-ID: <20241129182232.14987-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
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



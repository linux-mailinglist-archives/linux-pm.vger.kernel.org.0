Return-Path: <linux-pm+bounces-18169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2CA9DAB99
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 17:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72988281F46
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26751200BBF;
	Wed, 27 Nov 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt3vq59K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AB20101D;
	Wed, 27 Nov 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724159; cv=none; b=toU7QJisp5ww04uM5UH459YKm0lQJF9mEGFKmhW5iVI2/tkv44nRuOGGskQCga8xOWUupf1cFq3+8w2z3Oq7ecTnJBiW/OblTbDDUwb9Ln8vuNpRkyMJ2juhFdTDIz2fC+V+PLtw9DLje2nL7WHtDNLkgZ0Pc3Rds3XzUJMKSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724159; c=relaxed/simple;
	bh=IZig5JtFcVJFRtGodHb1nn1SdFNHH+WZ6d68k4Fox6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeJGLLX8fq2AG2j/SPxC9S3w3WjcTGQ043HWsPSjRbaWTsxj7iiIVROqW6OKNw22aqkk+PwarIMjQ8QmMssrdbtqv4HcJGpWBejy8KN2IZ01j5hW/mdpDxam9sFg6f1vJzUa4Ho8MVtg2M5i+IwU7TZxB0cSoDZ90F4gAoPEN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt3vq59K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732724157; x=1764260157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZig5JtFcVJFRtGodHb1nn1SdFNHH+WZ6d68k4Fox6I=;
  b=kt3vq59K3/htemCf3F6cHaSS8DMuqD8IpLF8ZW+91QOTSmfodUen+9Q1
   Idx6wp4LrRgbbi7XoYJVQWjrhiOIwSpePgQo+/YX0CnzYJzrQJrmwN97Q
   wmaZPU2o+aq99lQV5Msx4WgpNknNvUR9Y6OtcyYp8CjG6FOHYmoyuhz9D
   VDDCopZJgmNbs4PQQwB44lZZf6x1U70dmCK/SD1zmS8zo+zj56G2u12Pf
   R4eWDmZh6SOCXSI7WJsOxzTLzhgjzHAoXnmaten752et3PIgFdhGe3FNk
   2ndSh9ccRsYS0TTx6DzNX9CYa0slr/8z0KP+EpKhvRhckEZFk4XQjIoCM
   Q==;
X-CSE-ConnectionGUID: dSwsIgv6SRKgEehUNX4d5A==
X-CSE-MsgGUID: 5fXuWngkQO6MXO/A/pEsYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43597607"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43597607"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:57 -0800
X-CSE-ConnectionGUID: WK6Tvta8S7Ox6lohOTRQ7Q==
X-CSE-MsgGUID: TJ2XPXdCTf6GBiC9ZWt3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97042461"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:54 -0800
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
Subject: [PATCH v6 3/4] intel_idle: Provide the default enter_dead() handler
Date: Wed, 27 Nov 2024 17:15:17 +0100
Message-ID: <20241127161518.432616-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
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
index ac4d8faa3886..291efa733356 100644
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
+	mwait_play_dead_with_hint(eax);
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



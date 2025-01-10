Return-Path: <linux-pm+bounces-20202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0ADA08FEA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06E4188DC6F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEE20DD42;
	Fri, 10 Jan 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/G3atF4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F420C46A;
	Fri, 10 Jan 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510413; cv=none; b=eMplFm8sQsqctcNwrlxMXXOxTlB+woBBXhJ2caY9zXTbH1nEYK89P4xCha2KtWvfgTTfDU9wWVsTLLvmS0hynps3FmZV21hlxPIoD/QSR6zLohQV+DL3oBeFNUYZxcie0QdtlGF60yErykbL8hgMwRaJoN9SsXQaHeNZCw0Fmpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510413; c=relaxed/simple;
	bh=kj1bIFBj+0jK5qfGbApkxVGD+FeRiYTmTZOiNfascT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCXvRPTMPSlXkR1uBwCvUpEEdPwQb/mZjY94W2cX462XX8jsp4hzkltkKEHoNBUUo8SSHvmLw/BA4Rasq4c0b0UIVzjEw/J9aHsJojH5zKLPa0aGc23Moernw71XSECq2ROewnLzDQZDjezvQD6r5AIKZFCn+PT/Iyb0wB7TbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/G3atF4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736510411; x=1768046411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kj1bIFBj+0jK5qfGbApkxVGD+FeRiYTmTZOiNfascT8=;
  b=m/G3atF4SoY0VW2+3eYVdJHqNnrGYDk0z4F0da1r26T/y+E+tQ3nIfJ0
   tW6q1YXzN2EGizLWvxg7YiBvkjEwjeBqZiaedYTIsj5NTcQYoZWU5mMRU
   QcVTMUjQ3eGTYs6ofZbSAmJlu2tf440hRTiZVQiJHIUjYmXCi1toPjZi1
   EB78vZjmuPK0TjzJFbvcs/d5qft3KMFtspt/vf+076A3wsGKVZYu+EYFw
   Vp8sUQZi/eS6RgcsJ54BQV04h292jt0uPKAQjtENPvazyAcbFTYwdoRnV
   +0Oyyzw/KLnElreGbKCepur7CM54unlvrJt/P93xP5VO6EU4GZWUmwH04
   g==;
X-CSE-ConnectionGUID: 9bQI3sc+TjCg/DyL8bnvAA==
X-CSE-MsgGUID: LXANB5sBS56lsIRpqfSnlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40743784"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40743784"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:11 -0800
X-CSE-ConnectionGUID: VwN6rGoqRnmIrecIKNMC0A==
X-CSE-MsgGUID: J83eLX0ARleZRAiG+VYJNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108636033"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:08 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v9 3/4] intel_idle: Provide the default enter_dead() handler
Date: Fri, 10 Jan 2025 12:59:52 +0100
Message-ID: <20250110115953.6058-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
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
 drivers/idle/intel_idle.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..53711ba59a56 100644
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
@@ -2147,6 +2159,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
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



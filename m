Return-Path: <linux-pm+bounces-21404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F6A294D1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E75D188DAF8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7218FC9D;
	Wed,  5 Feb 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3nIo/Gb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81055CA64
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768868; cv=none; b=tfhrN8plOHxkQT/tgbSrxAq8n4PAHDePzwsG0/JKZGmEi009kfy2ZLlk8975xLsl08YgpIRzi0ct1oiF9LTFAIE4ybVI92Piqv2Y3N+51awR2KE7RJo7rmFqgFzgJOrgnqfvm1nkfZMvtY+m3+GRkEST5xwGJOdYTiDp8SyC9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768868; c=relaxed/simple;
	bh=TWm3TIWnOhFXJN/WTqyntRa56wJddFgOeIx/dPRUwHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1rlr/iTV/4nTsI1XcDIZgiKQHnw+/6Xx2J0RpQzNIXw0C8dbxid13SP0Q/jEN1+dG7RF8qU9hzfZKefSq+6dX/SNBd60oXMRruJ66yg8rJbzy9e2Eo9aH0sea/iCUIRVgIDOn1R/B1ojQks5kHHYTujDwKsiE4y3M2sF60gxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3nIo/Gb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768866; x=1770304866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TWm3TIWnOhFXJN/WTqyntRa56wJddFgOeIx/dPRUwHQ=;
  b=H3nIo/GbsT2Avyzs0ocnwE6tTS7z1NCR/2dPLFkmV4D/T84cMjFvGpQI
   NlKBh0otrOhPdSkFGksEiP1ndMxT0CokVo64G0M9zZssaJPKnLQAFKe69
   Dvei9aKZNCtPCq6skTdxyVocqXJ558VGk8Foc/ZhWZ/JJRugNTRIMdWyY
   MP+m56xDB7qMQRpw4uy7CwBfjH78byKCoFkFiN2SjcOSlAWBmdAO7OETm
   HAG/2jUqQOh2/1FM7K5JoL4epY4XyGKYLIpGkLk9cXUOVTqJf7vbsbzWE
   1OYqQeRQphGqBeD2E6JpRIpYJDY0cFf40u3h1rYwd4+x3mkRbBVedi36Y
   w==;
X-CSE-ConnectionGUID: GkAY6qMFSQKiR20DI3HFtQ==
X-CSE-MsgGUID: SbCTvzx1Ro621FOt6BtUdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39498162"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39498162"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:21:05 -0800
X-CSE-ConnectionGUID: ymXg2qESTu+4tgM/kbBNhA==
X-CSE-MsgGUID: 82GsB5IiSLGhT8ktgUL+PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111109565"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2025 07:21:04 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com
Subject: [PATCH v10 3/4] intel_idle: Provide the default enter_dead() handler
Date: Wed,  5 Feb 2025 17:20:55 +0200
Message-ID: <20250205152057.171030-4-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
References: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
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

Based on patches from Patryk Wlazlyn <patryk.wlazlyn@gmail.com>.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
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



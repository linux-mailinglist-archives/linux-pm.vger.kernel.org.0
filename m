Return-Path: <linux-pm+bounces-18052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325A39D8631
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23F1165050
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74951AC459;
	Mon, 25 Nov 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLW50sqh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF61ACDE8;
	Mon, 25 Nov 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540853; cv=none; b=A2wT0cNsiHn8mg2V5TfSrh4l6GCKmqe2Wg8T/fLV0+Ue3zCkDaXkhzBpBQILW7XMW5UymJ4ZgQOL11R7kpWgRRGrKpc4PEIYzp3+UfGQpZeokB3Bord0JPG3kdqoWHfiomPS4gbpWoJY8UHlmGkBHwPOk8qABAUB1V8/I8xX7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540853; c=relaxed/simple;
	bh=oWtQwGipsMqqo+z9NwC+tp18oJA88l1mfYAtb0kGkeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC7dDryW58+XfJ2M+6EC5OWHRVaFEUW2fxXP09QXVD1WBRUExC/dnTU3CHcjgM2dNBxCcfSXDl8Ulw61lu4wbLEtu0u90fwAJ+NIpoBQEmJ7qX0j5FOuteoF74z9KM+mGp8LiaGkKzghkkBVFLHnNbzOT1pVj7aKI4a7Aff+dGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLW50sqh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540852; x=1764076852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWtQwGipsMqqo+z9NwC+tp18oJA88l1mfYAtb0kGkeU=;
  b=jLW50sqh6kUq9f+jnMxT6YVV1Z82ppuT+roB5Ewcj+JWqdbYY7pjiVuT
   I6XCX11gLluIrrQYGK3ehIkyDLagFc+FmC+t3Dr6dXOZf4C1CmPkKGnIk
   cuIAj3PvHTx9QM/p0OaygazWWnVX76nG+VQcI0RWLDEYAeFpwTikczGMi
   EWNX9MCUHxrw3mjEhKUOp9axvHqh3z7V/U563NrkAjC5HBTw4KXt6mVZn
   RstPcY5kETsgOZ2h59Z6tu9iyy/PhmFsPUC323qmrvuHtDPe8gXuqGlOk
   8GIPW4IQxSJp+op/HxPQ8pVaxw7yZEYwLFCBGq9ziiWirINhKXsDrDqke
   Q==;
X-CSE-ConnectionGUID: 1slZmeGVRaOpJFCAR7uZEw==
X-CSE-MsgGUID: mXOcVVR0RGeCsLxCDct7lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145444"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145444"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:52 -0800
X-CSE-ConnectionGUID: RrzuxBCFQsGge6htfLMmsQ==
X-CSE-MsgGUID: qRPbCf7vSD2MlJzrA6UvQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161688"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:47 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	gautham.shenoy@amd.com
Subject: [RFC PATCH v4 2/8] cpuidle: Change :enter_dead() driver callback return type to void
Date: Mon, 25 Nov 2024 14:20:22 +0100
Message-ID: <20241125132029.7241-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After a previous change, cpuidle_play_dead(), which is the only caller
of idle state :enter_dead() callbacks, ignores their return values, so
they may as well be void.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/processor_idle.c | 7 ++-----
 include/linux/cpuidle.h       | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 831fa4a12159..ce728cf7e301 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -578,7 +578,7 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
  * @dev: the target CPU
  * @index: the index of suggested state
  */
-static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
+static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
@@ -591,11 +591,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			io_idle(cx->address);
 		} else
-			return -ENODEV;
+			return;
 	}
-
-	/* Never reached */
-	return 0;
 }
 
 static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..a9ee4fe55dcf 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -61,7 +61,7 @@ struct cpuidle_state {
 			struct cpuidle_driver *drv,
 			int index);
 
-	int (*enter_dead) (struct cpuidle_device *dev, int index);
+	void (*enter_dead) (struct cpuidle_device *dev, int index);
 
 	/*
 	 * CPUs execute ->enter_s2idle with the local tick or entire timekeeping
-- 
2.47.0



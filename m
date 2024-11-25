Return-Path: <linux-pm+bounces-18053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0D9D881F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B8B3BAB5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A91AF0C0;
	Mon, 25 Nov 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE2u2/z0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977421AE005;
	Mon, 25 Nov 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540858; cv=none; b=osWsuaDxwWYBmUAfn55OxElzQ2MMlUKmtLZCIOngJgaEClfNtD+QaMZlY0RMZ4JpCd/hDO3JOjYW6gReTPLwHjeyETTty19T3xxAAnEylQaUbXDXeNXDVZSFeyu7v/3BYD1JU1feIAgbe9sW2ghIoIEhb5v1mBIgLd1Qg/lp4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540858; c=relaxed/simple;
	bh=ySAUFoVjetQHqEoSldpuSYe7PRSTVKbbx/RG/H/AMIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfhzA5M24qXsbE0UYVTHE0kMKIT2mO1tvZbtUontqJo6WbQ0fQDXJQDers4nMnaTidP2VkIxgf7PEPOuCQC23wyYsDF3Kbvk36HuntXjjLwU/bUWkh0ptP7ZZvXG2aPlJstjGs6a4tUTXSZsS37CIcAqnyckn17SOSUkN0Upu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE2u2/z0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540857; x=1764076857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySAUFoVjetQHqEoSldpuSYe7PRSTVKbbx/RG/H/AMIw=;
  b=TE2u2/z0Tbs7FyFbAgITe1Kfgn8/Xwlu+DUJu1/tXrQWeF9QIJPV4wVs
   GOhVyIt3R4ghrWwBaYpi/syhbALTslTf/TZ3s2Po4BJL0UDIEqu3IGR9N
   3wVG8hdmIcXxk8TXdWpJsQvjF4jg9rpiBG9HT9xZ058dDtZelt/UAwLLx
   l5kNhNB7Kf76EylsbiZmVztNG+aHSCvYfKI9nhQionrNbcvmi2Nj83cwr
   le6tN2MBEFXM6FUynhc3BTC1gMagcKqgmOenXxeF7W6LTwC8G48XBwrUt
   BfEkTarc5IhObMBDisimgF7r3XiEXndeNbsAojpgMrNnPuGdU+89i0e42
   A==;
X-CSE-ConnectionGUID: DrOZguQBTSqCeLTK0UBZDA==
X-CSE-MsgGUID: Zw+uMc7oSe2U2CdggNLAEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145454"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145454"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:57 -0800
X-CSE-ConnectionGUID: p/czT652RnGVEN9V36iX4w==
X-CSE-MsgGUID: Kl1SW9T8RA+j61kxDK+9Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161693"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:52 -0800
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
Subject: [RFC PATCH v4 3/8] ACPI: processor_idle: Use acpi_idle_play_dead() for all C-states
Date: Mon, 25 Nov 2024 14:20:23 +0100
Message-ID: <20241125132029.7241-4-patryk.wlazlyn@linux.intel.com>
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

Notice that acpi_processor_setup_cstates() can set state->enter_dead to acpi_idle_play_dead() for all C-states unconditionally and remove the
confusing C-state type check done before setting it.

No intentional functional impact.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/processor_idle.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ce728cf7e301..698897b29de2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -800,12 +800,12 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 		state->enter = acpi_idle_enter;
 
 		state->flags = 0;
-		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2 ||
-		    cx->type == ACPI_STATE_C3) {
-			state->enter_dead = acpi_idle_play_dead;
-			if (cx->type != ACPI_STATE_C3)
-				drv->safe_state_index = count;
-		}
+
+		state->enter_dead = acpi_idle_play_dead;
+
+		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
+			drv->safe_state_index = count;
+
 		/*
 		 * Halt-induced C1 is not good for ->enter_s2idle, because it
 		 * re-enables interrupts on exit.  Moreover, C1 is generally not
-- 
2.47.0



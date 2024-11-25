Return-Path: <linux-pm+bounces-18056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E799D8641
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A04B28495E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC31B21A9;
	Mon, 25 Nov 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MV4RL0o3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D91B21B8;
	Mon, 25 Nov 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540871; cv=none; b=afqNU7fo/iUYeUBYaAHWhoN0gZzoKwH58wPQZQlvnFg/8OkQ0ArHywvDcFW8OuW2wELmuJ3IF+9sWC+unaesqAM/FjgmQ+wL6qL2ZO4ve4cT1tG6WLOixqG6Isbqoii1X1Ko0GBVJVnyB0Fxqer57s92K0FpQFqrHCj7sAsLhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540871; c=relaxed/simple;
	bh=nK+FjxLYCzmOviioR/C/S44LMaHEzHb2qOLPW+eGqHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlQfmQ5PpEgbl4pqXXMSH6F+SU8uu3T8Mq2sfg5pVpSf70GqlcwrvrvhJrPLWD3USCibFkUFImFMTo3bPzE4amslfRPEbeqyGJHnpL5DbnOzTgnV5NVxgp1bEZ/O0u1J1+JPxZGmTRoL0JjRhUKkBgqrZairUuIE8IGTFlVXlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MV4RL0o3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540871; x=1764076871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nK+FjxLYCzmOviioR/C/S44LMaHEzHb2qOLPW+eGqHY=;
  b=MV4RL0o3HTizuI//mbA9mssnSwAxS928woD7PVc7RrElsX2iqK2G7pH4
   M5J+w23gAXTI+6aZ7Oi7smg8Y1Ut+EYjn5iD0G0vYj0Rouy8jqiGrMNN9
   UAz1LHrYMU4C1aq8Z1GR3+tHDtvBwFuiimK+u4XNv/TMYeeHTOHX8tWPv
   AtVjLkppjKAhHpJonmrPSnNd7y8QQT5t9kpWCtwT2jmCV8QqYEzYAXfm6
   My6MM5/zGDuXlHQP3feQemvTGRELQ21Qi1XcT1KiDtI6y5mRjvmTvmmAx
   NnGa5Z5FV6uARGKT5st71WwXMb9YDH0HCyjanPTqIffecLKZLx8u3qX/E
   Q==;
X-CSE-ConnectionGUID: M5lU2zavQEq0k61rKR9krw==
X-CSE-MsgGUID: f3ts6vNKTCyFppUxo8yl/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145491"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145491"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:10 -0800
X-CSE-ConnectionGUID: lN4oCRZ6RUuEvF/X2Drt4Q==
X-CSE-MsgGUID: K2Ita2/6QzSaHz6fpDtnmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161766"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:06 -0800
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
Subject: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for SRF
Date: Mon, 25 Nov 2024 14:20:26 +0100
Message-ID: <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>
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

Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
    C6S  (hint 0x22)
    C6SP (hint 0x23)

Hints 0x20 and 0x21 are skipped entirely, causing the generic
implementation in mwait_play_dead() to compute the wrong hint, when
looking for the deepest cstate. As a result, package with an offlined
CPU can never reach PC6.

Define the enter_dead() handler for SRF.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 drivers/idle/intel_idle.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..c2ca01e74add 100644
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
@@ -1391,6 +1402,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1399,6 +1411,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 10,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
@@ -1408,6 +1421,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 270,
 		.target_residency = 700,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6SP",
@@ -1417,6 +1431,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 310,
 		.target_residency = 900,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
-- 
2.47.0



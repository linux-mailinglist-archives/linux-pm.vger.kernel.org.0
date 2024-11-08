Return-Path: <linux-pm+bounces-17205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE49C1CFE
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7313AB243D4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AC1EABB1;
	Fri,  8 Nov 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As/Zb1/X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554F1E909E;
	Fri,  8 Nov 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068978; cv=none; b=rYpTXbWZlDtOE8bWSfBGBP/bZFDMnffl4jBiGwCaKD17h/dq8sR9hNqQPdBPTjCq/U8I5D0a4IbHeF8g/btUb4PT6y7oFWgMrOA/7hTIntXxk/C0MllsAaAql+7JRFgHMdHpN7TAcUwmhQDvis5rP+M0/vveF5v571Y4GpPJChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068978; c=relaxed/simple;
	bh=L38I2+o6gnX1T6/er6wZJJ8AUf3mBfnVxYyqd8usKPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7MYCsffFcq7lRC2NbeV4nIf6SQpOTwTuJeY4SHxETWaseo3ApHqUdYhbf3TNT9Ui12VphuxANhrHpMC7tgqAWCFdGpJcqDlmX24jyfBQZxyu4KQsJSRY8CApUXeeRIzkAxQnMUkrHVN2fHI29wjN+cGVaEokB8AGaxnYgJrLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As/Zb1/X; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068977; x=1762604977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L38I2+o6gnX1T6/er6wZJJ8AUf3mBfnVxYyqd8usKPE=;
  b=As/Zb1/X2yKAS5VadxYiKL6frvhKt5bbcldA6GGT1n9zKb/bmUL41J1g
   fH8dQdZqXP5D22BR5BIDuloOtL/eufTh3vDINvcGy7aFxc11FNtfwV3c3
   lwvFpRnupMiz/7LbXRGAUfDM/Rqmv33JkWSmIATIghk6Cer8xWZEd6Eph
   tZ+u9SS+CJviQdh6tx6GC1eBO/1tgfWlOchrJcZaeDSEjBA4nAec0Y2u0
   QvBKrg8cJ56rljomDS1GEoOf6xUqn+dc8jC/LseCI6IbTwz8eA8p1ZyQ6
   fVWfFRl+rFXBHZtG+TiYBDi96mQhmqJVcLcWFA3cqffyfLbePKZaXTeTo
   w==;
X-CSE-ConnectionGUID: h9aHjMmIT2mZykpqGV1lbQ==
X-CSE-MsgGUID: gegJLLa5QzaYaUdznr6D+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53510370"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53510370"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:37 -0800
X-CSE-ConnectionGUID: YczP97SkQNOo7VhFmMiK4g==
X-CSE-MsgGUID: ilEkI6JxR/+gbnobEl4f6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85921168"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:34 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
Date: Fri,  8 Nov 2024 13:29:09 +0100
Message-ID: <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
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
 drivers/idle/intel_idle.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9aab7abc2ae9..bd67959e5e8b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/smp.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -221,6 +222,17 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+static __cpuidle int intel_idle_enter_dead(struct cpuidle_device *dev,
+					   int index)
+{
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	struct cpuidle_state *state = &drv->states[index];
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	/* Retruns only in case of an error. */
+	return mwait_play_dead_with_hint(eax);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -1303,6 +1315,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1311,6 +1324,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 2,
 		.target_residency = 10,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
@@ -1319,6 +1333,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 270,
 		.target_residency = 700,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6SP",
@@ -1327,6 +1342,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.exit_latency = 310,
 		.target_residency = 900,
 		.enter = &intel_idle,
+		.enter_dead = &intel_idle_enter_dead,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
-- 
2.47.0



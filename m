Return-Path: <linux-pm+bounces-18051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57069D862F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AD01648FB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433A1ABEC6;
	Mon, 25 Nov 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuuJ1Emg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6C1ABEBF;
	Mon, 25 Nov 2024 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540849; cv=none; b=NUilGviX+Ctkxayi0uz7Xfx1G2nDna51toxZ/2C3cWi2gfXmLE3vouqyguis3yxiUjVtUAzaK2OsfiUhY8kFdS2XY/zFMfzt0bNKjNIdoZRb41FxPQl3PhRrtcKHR/qERuPt5zMK9jT6+UytWHarkSmqb+MTBEONKt3uF3tbtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540849; c=relaxed/simple;
	bh=teDKZrKy/w1Opc/KP13wrYLNIVP1b7k45GEBotf70e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFP57cNCPIATcrOInCxa3PeOEGiTWSz1Cx7pXDyikqyRyuoic91jiPBlsKAAwyYRvyD75G5njomi2kVPeMoIJF1vgF5K3uMv630CpzCP2dn1rbcEL01AWebKcqKwERfimMcrTQ6bFBgnnsqRLWikBpJKP580mbpD5NH/PxeuZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuuJ1Emg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540848; x=1764076848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=teDKZrKy/w1Opc/KP13wrYLNIVP1b7k45GEBotf70e0=;
  b=cuuJ1EmgwWqW+2AwLWMg+T/hf5UvFLfDN370IycYqmxEN8sSFSbFcfx+
   OptcUC1x7E+vsyh5d0uH1U7xILceoq5+0fVU/MW0zPwOgpw8VzomKwGCg
   DeN8MfFe7PnHkhiEUTO5QIzWboYJj7rjrg5KpyRiBI+xm5V93l1QHqpIK
   ZoKul0bryTjSGzSk6MCvFxCjH/LYAcxbWNgy5FKJAbMcM2UJJlQADyShz
   vV7hWmqGHfTQ96QMWenPpaQdwTR41U7R6y0ms/9+TkBT5PxRUMB6ZJPY/
   hlbNG3ISwBO1vsCl7QpnUl3Q2387mPN/tsF+dGZjGcNWgYPOuB8+Vl9Zd
   w==;
X-CSE-ConnectionGUID: GhvcXuxAREymYUO320xAnw==
X-CSE-MsgGUID: GbuMMR30TxKeJ+4RUkn0ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145430"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:47 -0800
X-CSE-ConnectionGUID: ULMhK4RAQjK4mHBa7pke3g==
X-CSE-MsgGUID: ElAhKrukTC2vKpKFPMKCzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161674"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:43 -0800
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
Subject: [RFC PATCH v4 1/8] cpuidle: Do not return from cpuidle_play_dead() on callback failures
Date: Mon, 25 Nov 2024 14:20:21 +0100
Message-ID: <20241125132029.7241-2-patryk.wlazlyn@linux.intel.com>
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

If the :enter_dead() idle state callback fails for a certain state,
there may be still a shallower state for which it will work.

Because the only caller of cpuidle_play_dead(), native_play_dead(),
falls back to hlt_play_dead() if it returns an error, it should
better try all of the idle states for which :enter_dead() is present
before failing, so change it accordingly.

Also notice that the :enter_dead() state callback is not expected
to return on success (the CPU should be "dead" then), so make
cpuidle_play_dead() ignore its return value.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpuidle/cpuidle.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 06ace16f9e71..0835da449db8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -69,11 +69,15 @@ int cpuidle_play_dead(void)
 	if (!drv)
 		return -ENODEV;
 
-	/* Find lowest-power state that supports long-term idle */
-	for (i = drv->state_count - 1; i >= 0; i--)
+	for (i = drv->state_count - 1; i >= 0; i--) {
 		if (drv->states[i].enter_dead)
-			return drv->states[i].enter_dead(dev, i);
+			drv->states[i].enter_dead(dev, i);
+	}
 
+	/*
+	 * If :enter_dead() is successful, it will never return, so reaching
+	 * here means that all of them failed above or were not present.
+	 */
 	return -ENODEV;
 }
 
-- 
2.47.0



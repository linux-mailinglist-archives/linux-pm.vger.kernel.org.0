Return-Path: <linux-pm+bounces-36867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC35C0BC75
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 05:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BB93B83DF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 04:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912D2D0C89;
	Mon, 27 Oct 2025 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gc6df/Os"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D65221DAE
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761540213; cv=none; b=CFbuZ/TGE6HP7Z4ZSaXG03ZpgdGrCbD0qLG+mld7QiHWkX2m5yyoC6eoMwQIM3wmBM/S4XQbguSKrMEn1ilWKb0jGLZxojqLHlJksHAin4mQd6qovcY67JGP7A3uv0aUzakXqdKoTIYGz6dvp+A5yjvYh2aAeSXGiTzpy1BCPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761540213; c=relaxed/simple;
	bh=8bfXAdq9mfBL34nfT6v8WgMOaMsrGDQQ3VU68s7RVwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULFwthY5lW6EEgDaEczBFyQU2XeBB1K6OdbSRjCCe1MIiYO1fzMxaO37Y41APsGJgKET9fzxMWnJ1N/p7FJ1A+JlLMr6hL4UI2HcWpnlxuQpOV0YWThmF9+dtYJpqitiuaB8gX5P8HOj7HMeMcOSwMPkKXxUbOS0sz6X3EbwJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gc6df/Os; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761540212; x=1793076212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8bfXAdq9mfBL34nfT6v8WgMOaMsrGDQQ3VU68s7RVwM=;
  b=Gc6df/OsehfWw96kaE+6Vnbv2fA3wPjYqxH/IUsJYxg+F4ou0C00FOPK
   RdtGQjMsGjxYuLJ7SvUQEXKYBeVMI05ZjqvW61D6p+ZovmRpNWJ9HsOxR
   n2Eb7cYN7Ymvx+fc/Mb1qmed969mA39nblcC/Ks9TpgcAGYlSBJY5gXc/
   gN9AU1Ep83sb3dCNwBa/w7raotevpWbIVDuLSFx0WU+bVwDBJlkdSrXYg
   HnS+g2svV2HExNG+ab393fudZDMdpAI8RVtGst0a9X+T6F7Bi6yAqjjQJ
   x+KqU99CKKZw7dMOk6mR1Vrn8XUW+zaz11cdehTMWILerNH+0USEVGNsl
   Q==;
X-CSE-ConnectionGUID: b2pFNU2uRTmqOISggIkAtQ==
X-CSE-MsgGUID: XLiLYLR3TMGxL9M3jOB7DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51191036"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="51191036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 21:43:31 -0700
X-CSE-ConnectionGUID: lZevFk0qRYKlnHrcbdjHog==
X-CSE-MsgGUID: ADI8BRu0SKuuMmINdhtoQQ==
X-ExtLoop1: 1
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa003.fm.intel.com with ESMTP; 26 Oct 2025 21:43:29 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v3] PM: Delete timer before removing wakeup source from list
Date: Mon, 27 Oct 2025 10:11:27 +0530
Message-Id: <20251027044127.2456365-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace timer_delete_sync() with timer_shutdown_sync() and move
it before list_del_rcu() in wakeup_source_remove() to improve the
cleanup ordering and code clarity. This change ensures that the
timer is stopped before removing the wakeup source from the
events list, providing a more logical cleanup sequence.

While the current ordering is functionally correct, stopping the timer
first makes the cleanup flow more intuitive and follows the general
pattern of disabling active components before removing data structures.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v3:
- Use timer_shutdown_sync() instead of timer_delete_sync() to prevent
  timer re-arming as per review feedback
- Remove timer.function clearing as timer_shutdown_sync() handles it

Changes in v2:
- Reframed as cleanup/improvement rather than fix

 drivers/base/power/wakeup.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..ab3eee23a52d 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -189,17 +189,11 @@ static void wakeup_source_remove(struct wakeup_source *ws)
 	if (WARN_ON(!ws))
 		return;
 
+	timer_shutdown_sync(&ws->timer);
 	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
-
-	timer_delete_sync(&ws->timer);
-	/*
-	 * Clear timer.function to make wakeup_source_not_registered() treat
-	 * this wakeup source as not registered.
-	 */
-	ws->timer.function = NULL;
 }
 
 /**
-- 
2.34.1



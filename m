Return-Path: <linux-pm+bounces-35275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25677B999E9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FA51883F5A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25A2E7BA9;
	Wed, 24 Sep 2025 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmGKQ3CN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC802E2EE7
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713965; cv=none; b=nHSQF7hKax7NWRymJXYpOsLxNyJvJufkKEB+gm7AWenjfOFy1mpJqiHI8lIGo4WAKozDiapOX8zpIBEAzAmsKajGdM0/T/0F7RxcqR78PhfqfldBGtZhbqUryGharutk4VjWInPW6pmz67kKG+emh//BEBeuVixPegQwjJLnFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713965; c=relaxed/simple;
	bh=E9iiZiJDIgxuwpwyDvufAzqDLedD0WMc1GFk0Lctfpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GvNXLjFM5HwC3C6rJg82EoMSPqNIab42FU2Jbuiwct30RzQRvxVppy2v85sRiA6XMkCdRRGRMMhv1zVHRYXfO7B5X2Ijh3SFrN3+6OF4dNCpKb+IrtwWPRBi+bT1pih4z/AGJY88O8TvuZ0DPQ9RaT/oAEElIVC8L+3N+Y9GfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmGKQ3CN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758713964; x=1790249964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E9iiZiJDIgxuwpwyDvufAzqDLedD0WMc1GFk0Lctfpo=;
  b=XmGKQ3CNAOS0F/3w9EF0oWeAjzIjk5akSisO0EwGLPxH8VM+5vkIwM2G
   lPxXl3nBTbFzLAcorxThb3aJC2XrjKiHPJ1je0lbNgxpX0S4JEZqWlrhn
   nfC3ALqkhqVdkMGXUGHVDA/Lixu+rqh/QlrbnP5ETiM9fv3NzCi3TqPyi
   Xhc1HUUiYPUhe9V3Ous6PsLGKTiYRC25GDhw5t3Mv4w9DIYWwLTvmYvLX
   PMg576x6BoDMz6mcS6Uj2W7CT/qrCGy39CnkJGPOiYM3HEKz8nfepjJ7q
   SBjODxum42ZvOLl1zc8jUi7RWbzTg61eBEUS7SfI4j97xD0CljxqRalqm
   A==;
X-CSE-ConnectionGUID: Bfq+DkldTkOFdW0CkpeYLA==
X-CSE-MsgGUID: JuDLj3/fReatbGqIE0uNRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64645409"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64645409"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 04:39:23 -0700
X-CSE-ConnectionGUID: GWDdXYT8SOOZR6EF90hfvA==
X-CSE-MsgGUID: kl9ZdWGNSpi2WtJXqL6T8A==
X-ExtLoop1: 1
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Sep 2025 04:39:20 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] PM: Delete timer before removing wakeup source from list
Date: Wed, 24 Sep 2025 17:07:37 +0530
Message-Id: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move timer_delete_sync() before list_del_rcu() in wakeup_source_remove()
to improve the cleanup ordering and code clarity. This change ensures
that the timer is stopped before removing the wakeup source from the
events list, providing a more logical cleanup sequence.

While the current ordering is functionally correct, stopping the timer
first makes the cleanup flow more intuitive and follows the general
pattern of disabling active components before removing data structures.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Reframed as cleanup/improvement rather than fix

 drivers/base/power/wakeup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..ae6ec9f04b61 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -189,12 +189,11 @@ static void wakeup_source_remove(struct wakeup_source *ws)
 	if (WARN_ON(!ws))
 		return;
 
+	timer_delete_sync(&ws->timer);
 	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
-
-	timer_delete_sync(&ws->timer);
 	/*
 	 * Clear timer.function to make wakeup_source_not_registered() treat
 	 * this wakeup source as not registered.
-- 
2.34.1



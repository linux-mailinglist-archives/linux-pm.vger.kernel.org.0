Return-Path: <linux-pm+bounces-35112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F219B8D4C4
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 06:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578BA17EBA8
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BE226861;
	Sun, 21 Sep 2025 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoT0f80g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655412E1E9
	for <linux-pm@vger.kernel.org>; Sun, 21 Sep 2025 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758428841; cv=none; b=tOBZ1qU+u5yLVp+Ic2O0kZCl3AD5TGllAlcaFpIWI1kqQg5OLgQQIAQn8Vb6A7+bcTMnadAGIdN+9rA+9m1S/20p6xnxuTGsuZX1VaXscqKJtk4SnHaB3HUxEhOiEZb5TYIcIZ73W+ODtQCZnUhvTtLJFDkBA6eBZQOXm3a/vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758428841; c=relaxed/simple;
	bh=H9oadypKOkeIAoJbakTVN2hwOaNJUuRaIQl7knV0/24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPBw4XP5GYQrQB1xOD4FhqHOWZ3Xj2n4Pzc3QNOsqW2np5CxnXcAVejsD6qS5O86LslIMQ2EWe2jiJ/aYeJHKaMQT0SYJ7hdWRTv7BuvL5G/VMOJaKWzbOeXGOttBJ+zGedfEjK7i3GHuHNLYEgqoPNViQq7ek4AbE1cHFCaKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoT0f80g; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758428840; x=1789964840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H9oadypKOkeIAoJbakTVN2hwOaNJUuRaIQl7knV0/24=;
  b=IoT0f80gWZThX3LTLlc88/8DBd+4siki2GXBu+zb3HAs5oTPcz1uaYYw
   aH3e0AlPDRSFX1afkYNM+qin5vcSXTvMpfsxWQZsqvSAgkyHT9yY6//uv
   Le2lJd+WyYSaBGUkq2kKdKgsdHLF8qIdfb09SKALy00VyzvgdzBO3/HlB
   W1aQ1Mbobv9ZufKpZhaTHEUcXx/4BBkOtnx86LeeSToKJC5xb0dDNLRNo
   /p/YqI7p1pLyu3Xa+vMfRbJeZeprwssd9EFSAkktHec0kJZ9VGDKduPo0
   F9XH/rLM2j38WMaQfnG+AAHVDKZfWx/fuQntFe0B3AVJiiBFDk0+aDc6W
   A==;
X-CSE-ConnectionGUID: HmXa+HPCTMybC18B42eGyw==
X-CSE-MsgGUID: +knNxPtaSRKbfEHn9G3LRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="60843983"
X-IronPort-AV: E=Sophos;i="6.18,282,1751266800"; 
   d="scan'208";a="60843983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 21:27:19 -0700
X-CSE-ConnectionGUID: YvKmRz0lQIqausTWiHy3sA==
X-CSE-MsgGUID: wm3Qy22KQy+f7RdGnEDAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,282,1751266800"; 
   d="scan'208";a="180601079"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 20 Sep 2025 21:27:17 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PM: Delete timer before removing wakeup source from list
Date: Sun, 21 Sep 2025 09:55:37 +0530
Message-Id: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move timer_delete_sync() before list_del_rcu() in wakeup_source_remove()
to ensure proper cleanup ordering. This prevents the timer callback from
executing after the wakeup source has been removed from the events list.

The previous order could allow the timer callback to access the wakeup
source entry after removal but before timer deletion, potentially causing
use-after-free issues or list corruption.

Deleting the timer first ensures that no callbacks can execute during
the wakeup source removal process, providing safer cleanup semantics.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
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



Return-Path: <linux-pm+bounces-32077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539CB1F22C
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 07:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E674E044B
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 05:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E29F1B0413;
	Sat,  9 Aug 2025 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6jG818/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178515665C
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716006; cv=none; b=Z/zcpBSin9gWS5G1lOoS3ZoHzBeOuijxoRm1a8ReIFDLV3CdNckqK7PiZDO3d99XJP9xVJkqTFGsrOktU4SGks/bKUOYvXV4vlPyjREbFMObX7zApXaN/sCNpK99UQkb6PEF6RSgQD3UIqJeC9KX0hd2e6BrbAVjTliycTjKlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716006; c=relaxed/simple;
	bh=0UxUSal8Djvz5U+liARQJlrLCNZUeLTXV2bunpNaKUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=poLGmWBIpbmQiShAt616hVYwNZIfb4hQby9itqQD3EflJ+mNmqmfBA/me1Ui25uMs4nWFZLg1Ftw+x/VvS1ru5DBuBpQ05CTpzs6emdn58cC9ShFB+5P0YlPV16VZiUVikVfzs1542+ncMazMrrQ126AapGWCh+lwtSTaP89m40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6jG818/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716004; x=1786252004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0UxUSal8Djvz5U+liARQJlrLCNZUeLTXV2bunpNaKUM=;
  b=Y6jG818/3cdjOQOCjr/AEK4CyL4Z4GDmckLW5E2incNImcpyodcvcMZU
   1b1zlZ74sBzvRABuqYhG8H7f0ldNm+WJ2Z+4Pmb6ofHsurbkwDvsurJtj
   0JbJ9B5M77v0viOfcpyvdqmypH+NPX+csIRye+buYLfwYcXxF4S1EFlFe
   UdQctrZpWueXyhff2JAdh1gh6gsTYf1Oqug90C+SsFxlSJuc5KHpp3XYE
   JLa38Apfx21eA/Rr1FIz/pUjYOVerFr7hU5krLxM9ZAVPxxf0Xu06B9vm
   6c3p2OWclXAH3Z8khIXvECtH2+OtDCq5CsCftj30LTANwpN5lRyLdTT/3
   Q==;
X-CSE-ConnectionGUID: NEfa0uakSyGiaflok8cRfw==
X-CSE-MsgGUID: A7cmxnsPRyupbCr9lopWQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56932370"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56932370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:06:44 -0700
X-CSE-ConnectionGUID: sm2DYEDRRtmzgCV+7nq7uA==
X-CSE-MsgGUID: GumYJH06QY6tpiKjtOQpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="164703240"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa006.jf.intel.com with ESMTP; 08 Aug 2025 22:06:43 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: Fix incorrect sorting of PMT telemetry
Date: Sat,  9 Aug 2025 10:35:15 +0530
Message-Id: <20250809050515.3916872-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pmt_telemdir_sort() comparison function was returning a boolean
value (0 or 1) instead of the required negative, zero, or positive
value for proper sorting. This caused unpredictable and incorrect
ordering of telemetry directories named telem0, telem1, ..., telemN.
Update the comparison logic to return -1, 0, or 1 based on the
numerical value extracted from the directory name, ensuring correct
numerical ordering when using scandir.

This change improves stability and correctness when iterating PMT
telemetry directories.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4ace93866fd9..7077efdb6424 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1889,7 +1889,7 @@ int pmt_telemdir_sort(const struct dirent **a, const struct dirent **b)
 	sscanf((*a)->d_name, "telem%u", &aidx);
 	sscanf((*b)->d_name, "telem%u", &bidx);
 
-	return aidx >= bidx;
+	return (aidx > bidx) ? 1 : (aidx < bidx) ? -1 : 0;
 }
 
 const struct dirent *pmt_diriter_next(struct pmt_diriter_t *iter)
-- 
2.34.1



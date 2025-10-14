Return-Path: <linux-pm+bounces-36058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE9BD8C3F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17874FD7EB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D92F6164;
	Tue, 14 Oct 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlZ+Yhx+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC062F60B6
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437645; cv=none; b=UhD0/o4JpWOFMmL2KaHoD+Yz3A0q6yC3K91UaBMeojkbJdLv7y1jrw5LyE8cp1txGKCnwgIV9k7OFLlW1dI4DI0Snna7ZIMT6P9bA8V9va7lTVQ+OfGtYJQ2KvkdzOUdI36+GnyUlrytodtKHL+5GyAKCnqKWwWjr8JCvIn3pUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437645; c=relaxed/simple;
	bh=XfHYBYtUiuN62UEeB1HH/QMYo6SMY+oi0W0Fke8RKEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GaPOdoqYKL8qki/dJtii5KvfRYD2j/fUDUy9QYmMCeRzw0gBzuvoqrqfY67Yg4q6NnwukiMuVOjEIK/wKIeUTLwF1u/vGnUJekmScLt6TwYRvZRO1Td+NpncKfQUYYuYbka/jB+qgWOBHE3J8Eqx5uQKnwzjThhDLsQFr/+N8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlZ+Yhx+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760437644; x=1791973644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XfHYBYtUiuN62UEeB1HH/QMYo6SMY+oi0W0Fke8RKEM=;
  b=IlZ+Yhx+6EO9NvrT8SMaz9Dmw1xzSKCE/YXNI8QrxdgJ/hntQ2ItcJEN
   HMGbKqQptSS67sLjjwvRbJOGGS9ojmTSZPXK0efBmCuw9XxsHSwWlGhLx
   XDG1mfgx3LdJxT4MO1UvaufV4HvbimLuaz+dyzHhqpD3479pEDX7i+h9T
   WSaGSM+GL0gSOBrgwcftopS1LB8RsdFYYhjCgCV3DxYA6bjdlQWKcmhcZ
   24SkLolZn4+lhizkpLtDlgD1KYqYk7rjP1JsHpAHJXfVjEW+FS30sQwPt
   3TzoXNbSdgSG4W4+edcWu7DgT+L2YBiYq/MVRunG285ry7qB9kZdkkXr3
   g==;
X-CSE-ConnectionGUID: ircHQLmmRWiIRn22BKKZhg==
X-CSE-MsgGUID: fpn0WGyST3G5oomDTs6wRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85214158"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="85214158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 03:27:23 -0700
X-CSE-ConnectionGUID: j6F/T0piQ8exo3Nc6eilXA==
X-CSE-MsgGUID: v0hz/MyhRNOHttQqYRT4kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="181857474"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa008.jf.intel.com with ESMTP; 14 Oct 2025 03:27:22 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: Add Wildcat Lake platform support
Date: Tue, 14 Oct 2025 15:55:28 +0530
Message-Id: <20251014102528.1220586-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INTEL_WILDCATLAKE_L to the platform data table with Lunar Lake features
to enable turbostat support for this Intel platform.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f2512d78bcbd..f59bffa6025c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1210,6 +1210,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
 	{ INTEL_PANTHERLAKE_L, &lnl_features },
+	{ INTEL_WILDCATLAKE_L, &lnl_features },
 	{ INTEL_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
 	{ INTEL_ATOM_AIRMONT, &amt_features },
-- 
2.34.1



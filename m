Return-Path: <linux-pm+bounces-18412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C19E149B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C8A282C15
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34D199235;
	Tue,  3 Dec 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HStLTfRo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B614389F;
	Tue,  3 Dec 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212281; cv=none; b=Sj4jpW/oAfF8tTpcrAsyEOTFnCghTQnMvqfu/ptgYQv6M65haQJ+jYctrrr012ubYdNp04KnpMkp4HuD3C+O60mnkzaYEdIWB6y83DCaIG7rzC85EeEk2iB+ZhvZ8Xhfgvumlo2Bfwgo68uDd1xqgJ7tXsNY1FdZmww1GzFFL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212281; c=relaxed/simple;
	bh=YK5PQc2Gdt7Umaut3Cs1wIcHAQhwiZ8j7lJAoblrO9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfKipbAFDNpUppjS+RtStD8PmKbRI0aj3v8K1iZPTtkyV3dRkbTyjQJP71lbYFOf+e4+c/YI+VsF/K4j1VqCw7gLsdrGup71N35og8/JvOlB5x2rNELHs/idrw4s9rh7pmNtp/x9U5TwWwLXIvDwEwikFa2EG4KBpY7mNO294Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HStLTfRo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212280; x=1764748280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YK5PQc2Gdt7Umaut3Cs1wIcHAQhwiZ8j7lJAoblrO9g=;
  b=HStLTfRoGcoV1XHR70UsmKyBDCYUH4NPiPHhO853QWybFlcJrSpNOHsn
   DABRIGcjSbpu0jRKWmBZF8D3Z01irQndsgSHbcY6Kfi1rX5N61KODqfZg
   yidF1Zo5qPiLhmM0N4wYpFB+K+ocsHVoNa8F/mF9TkJHWvZpVOx7S84ac
   TbOXqiHZEb63/wWBN4oHFBXw8rCEP4jmtu42w4eAvOIEWno2DrSPdJS63
   tTOX6/7v5klpJ1YsPNP0pjIF6PBkfsfD9Mux6jj3g9Hhjg+yVeRxB5LUP
   1V0p2a7Zcv36I1EzW7okb4zbEKYIh9HyOKVcIU7J2anQhXtmek7g+UHfJ
   w==;
X-CSE-ConnectionGUID: cMFY1tdyRVyFfO3jNPdGww==
X-CSE-MsgGUID: eawJz99NTtCplZURW5Mf+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50822847"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50822847"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:51:19 -0800
X-CSE-ConnectionGUID: 9QHA8wSHQDOMatwmTBM38w==
X-CSE-MsgGUID: D5lL1Zs3QqyqEASzBbQM+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124183016"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 23:51:18 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/4] tools/power turbostat: Exit on unsupported Intel models
Date: Tue,  3 Dec 2024 15:51:16 +0800
Message-ID: <20241203075119.584419-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075119.584419-1-rui.zhang@intel.com>
References: <20241203075119.584419-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turbostat requires per-platform enabling for Intel CPU models due to
platform-specific features. When running on unsupported Intel CPU
models, turbostat currently operates with limited default features,
which can lead to users unknowingly using an outdated version of the
tool.

Enhance turbostat to exit by default when run on unsupported Intel CPU
models, with a clear message to users, informing them that their CPU
model is not supported and advising them to update to the latest version
of turbostat for full functionality.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e203f109dd2e..bb65c5e1273c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1079,6 +1079,13 @@ void probe_platform_features(unsigned int family, unsigned int model)
 			return;
 		}
 	}
+
+	fprintf(stderr, "Unsupported platform detected.\n"
+		"\tTo get latest turbostat support, please contact\n"
+		"\t   lenb@kernel.org\n"
+		"\tor pull from\n"
+		"\t   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat\n");
+	exit(1);
 }
 
 /* Model specific support End */
-- 
2.43.0



Return-Path: <linux-pm+bounces-33220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE55B393C6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 08:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D2F1BA248E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 06:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8B277C86;
	Thu, 28 Aug 2025 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeGi1TJZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9924A046
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362690; cv=none; b=aq5cHRbGkoAdHqSATEhmtPz83zkq1ZOmV+JPQzHO2QgQEvYs76g2f6MiC4CDnyMlegzkqOaiIwF2QVpHcnTvpsb3sVGU4EQDYXEDQT9n7VE2GIH5PFj+k6zZeaCbrb4EkYQN/UN1dkQhB7eNJzgRlNVY1wG2jXOugZyFzBmYwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362690; c=relaxed/simple;
	bh=qgBWDECWtTK0m5bpCqPKT5MClF1rSC6eMMOmnCBjXWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZt8FoxFMMvDULszufvUOMCQdrzCBV8WTX3ks+C9m9B6C6fmP1XwC1y12OJy0LOS89CIVPj8Y9VWx/5mw4pX/c6M72HxnERff/aIvH2fpjlYRN6Q79Lp/vhblHf0uaJ21rgKYmh0A6ykzsV8wzc9RSVzfxL2f9iPUjlponeUoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeGi1TJZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756362690; x=1787898690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qgBWDECWtTK0m5bpCqPKT5MClF1rSC6eMMOmnCBjXWo=;
  b=TeGi1TJZ43NR76JM0+ASrhrqqtaDmma3nzjcr5FBysCTOvlCepbZt/GG
   bL4cIhKyTMdj2H2MhP99/lWvc8dlWq2zaSuApFJ2PQvIONIZt5xvsPvmE
   T66Jr3mBlugAls2TMb5TJFaTeaXtij4lcN9nrjMhGL8S4DhAIaSjSeDNH
   7RhG3bl5MDJjNUThWXKjN9E+htSzbj26t6jcmy0kN7QctYiGlxVNgOAU1
   tgit+7chG9FSazfYwlxwttQmT85t9QZXGqdaYYptqdS2ZJiQ3XKHi+aub
   dlKDyaergKIN3r0KysHGPDCTwWSHSpuG1S3CpI9cL1SHFFZpwWY8z1X01
   w==;
X-CSE-ConnectionGUID: bFJ4uwacTeWBIIvHTzoDlw==
X-CSE-MsgGUID: ehyhguvASridz005hPEohQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69715507"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69715507"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:31:29 -0700
X-CSE-ConnectionGUID: fr8Z17/iSSyEEZi67WEbaQ==
X-CSE-MsgGUID: j5KrTSlGSgWPYe7XTn1frA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174365640"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 27 Aug 2025 23:31:26 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/cpupower: fix error return value in cpupower_write_sysfs()
Date: Thu, 28 Aug 2025 12:00:00 +0530
Message-Id: <20250828063000.803229-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpupower_write_sysfs() function currently returns -1 on
write failure, but the function signature indicates it should
return an unsigned int. Returning -1 from an unsigned function
results in a large positive value rather than indicating
an error condition.

Fix this by returning 0 on failure, which is more appropriate
for an unsigned return type and maintains consistency with typical
success/failure semantics where 0 indicates failure and non-zero
indicates success (bytes written).

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/lib/cpupower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index ce8dfb8e46ab..d7f7ec6f151c 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -56,7 +56,7 @@ unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen)
 	if (numwritten < 1) {
 		perror(path);
 		close(fd);
-		return -1;
+		return 0;
 	}
 
 	close(fd);
-- 
2.34.1



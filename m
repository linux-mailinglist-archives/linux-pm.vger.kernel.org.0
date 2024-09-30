Return-Path: <linux-pm+bounces-14926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D48989C8D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E75F1C21884
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E517E01C;
	Mon, 30 Sep 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmgOj39y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1AF178CCA;
	Mon, 30 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684390; cv=none; b=X+q5H3aY3ZgOq9hhOsHH3vGlqPkeLrTVR9dSsGQEWQuyMQSsJCxKs4MioIHhRyZDgRxELuTC0jrCNw29Dob2TD9rXo8ksW7AwB/rdaM73kUOWy+DOGxIQBaWxl2DbdHFGFd7+2XNyhJ27juDPZXJPBKhZy8rs9M6krT0st2cOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684390; c=relaxed/simple;
	bh=w0jLDzy95ysPhd7nXSw/LGQtr8lMj9+9LTOOTudlOUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZQw4lWIisQo0clD3W7j43qrri0q8UAfHvbP2mrlr6H9BqdQFy72DmALdqo6YbMk+2I6xcka//wOgo2OuT90RitBxHSxxDs2NkK7+91rxZnI0eapglTh6GBZHoGgoIL3iEFAFW34ZSueBgauUUYzwrziSlr8iogzewYl2wZyQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmgOj39y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684388; x=1759220388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0jLDzy95ysPhd7nXSw/LGQtr8lMj9+9LTOOTudlOUg=;
  b=NmgOj39yVK+hOpZjRPY2msINphbmjC3NbXONrJ8tfEDEqRKotVuBxWxp
   EDZzHtdHBiWvuDjg2qmQUy/uJIjHOJOEPbGrH1kMCNjykCG280xxRYKuI
   0SewYcflXYc6U5lYsKFvQw/V907QhKQQ0pw34AP3jf89f5zAUbaBzXzBq
   7kUxMftAkQ//cYP3m5/a7xO8cJiQ0rEYDDvWKVxWTwyaT1PzGTNLgcW11
   dHeB2KGGVql0jXctPkdXUUo4+eUTzD6hpSs2zTI+CXtqBqAMyG/UxqGGl
   F2IXQ/kywSvVjDqiCSoSWQT/iFzIIAO29WNIvuYKCXwPLKAKJTkV5uCwd
   w==;
X-CSE-ConnectionGUID: 9BTQTAZ0SB2wv5ab25Q9zw==
X-CSE-MsgGUID: NjPItvR+Qe+IXfHG7Xbthg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638963"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:34 -0700
X-CSE-ConnectionGUID: NFUJ900GRhm8m5rC8KQ0dA==
X-CSE-MsgGUID: t84cBhS4RjCsPsUL6pAfTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549434"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:26 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 3/6] powercap: intel_rapl_tpmi: Ignore minor version change
Date: Mon, 30 Sep 2024 16:17:58 +0800
Message-Id: <20240930081801.28502-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
References: <20240930081801.28502-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware definition of every TPMI feature contains a major and minor
version. When there is a change in the MMIO offset or change in the
definition of a field, hardware will change major version. For addition
of new fields without modifying existing MMIO offsets or fields, only the
minor version is changed.

Driver is developed to support RAPL functionality for a major and minor
version. If the hardware changes major version, since offsets and
definitions are changed, driver cannot continue to provide RAPL interface
to users. Driver can still function with a minor version change as it will
just miss the new functionality added by the hardware. The current
implementation doesn't ignore any version change.

If there is mismatch with the minor version, continue with an information
log message. If there is mismatch with the major version, log error and
exit.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 7435df083ea4..645fd1dc51a9 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -15,7 +15,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#define TPMI_RAPL_VERSION 1
+#define TPMI_RAPL_MAJOR_VERSION 0
+#define TPMI_RAPL_MINOR_VERSION 1
 
 /* 1 header + 10 registers + 5 reserved. 8 bytes for each. */
 #define TPMI_RAPL_DOMAIN_SIZE 128
@@ -154,11 +155,21 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 	tpmi_domain_size = tpmi_domain_header >> 16 & 0xff;
 	tpmi_domain_flags = tpmi_domain_header >> 32 & 0xffff;
 
-	if (tpmi_domain_version != TPMI_RAPL_VERSION) {
-		pr_warn(FW_BUG "Unsupported version:%d\n", tpmi_domain_version);
+	if (tpmi_domain_version == TPMI_VERSION_INVALID) {
+		pr_warn(FW_BUG "Invalid version\n");
 		return -ENODEV;
 	}
 
+	if (TPMI_MAJOR_VERSION(tpmi_domain_version) != TPMI_RAPL_MAJOR_VERSION) {
+		pr_warn(FW_BUG "Unsupported major version:%ld\n",
+			TPMI_MAJOR_VERSION(tpmi_domain_version));
+		return -ENODEV;
+	}
+
+	if (TPMI_MINOR_VERSION(tpmi_domain_version) > TPMI_RAPL_MINOR_VERSION)
+		pr_info("Ignore: Unsupported minor version:%ld\n",
+			TPMI_MINOR_VERSION(tpmi_domain_version));
+
 	/* Domain size: in unit of 128 Bytes */
 	if (tpmi_domain_size != 1) {
 		pr_warn(FW_BUG "Invalid Domain size %d\n", tpmi_domain_size);
-- 
2.34.1



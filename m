Return-Path: <linux-pm+bounces-22551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A47A3DE2C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4053B7551
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C41FC7F5;
	Thu, 20 Feb 2025 15:17:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CB1CCEF0
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064629; cv=none; b=aI8foNjs/YBHCP+bQnUI9EGXFHs+S225hGGXiXsbWZKyjqc2zGwdIcVeCDmsOk1cSyHQfSbXUxbw/MnmMMtC9ctkfumUY+vXZBeleKk2Ta9jcAJV1xCAcsX805Y5uHB0LrI91BKJ8Lwgjl0tvflll3DzZQhOz8JJEljGk8Ms+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064629; c=relaxed/simple;
	bh=S9Eo/bCr7zsbr/0ujIrSEO/6+MGFMa7WgRCcFPNfEmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBFCXCn4S1qRLjZTofqbeDaKR17rbrFOmPPA+z5lIMKBzFDmyI9XHouEV4nUIAcmSIwOQe8G+doKVlvWtCT+Xwl0dTPMli8t/dvUH+1iEX+4oW00JL9LnQ8yb1IFb2kd6CR9mg69MRMSp7BCTl21WCNMx5/GoYbWskkY5a/AWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: Vl8eU7pJQPmNoMpUvm7Ccg==
X-CSE-MsgGUID: 6LIBOxvrQwenaNQ8NPNoZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40703685"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40703685"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:17:08 -0800
X-CSE-ConnectionGUID: uhLEUpDMTQ2v6eZpSGKrAQ==
X-CSE-MsgGUID: rsEIXBuTR6y7s7aAWhXLHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145922162"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 07:17:06 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2 2/3] Documentation: admin-guide: pm: document intel_idle C1 demotion
Date: Thu, 20 Feb 2025 17:17:01 +0200
Message-ID: <20250220151702.2153579-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220151702.2153579-1-dedekind1@gmail.com>
References: <20250220151702.2153579-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Document the intel_idle driver sysfs file for enabling/disabling C1
demotion.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_idle.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 39bd6ecce7de..30a3ed1e38fa 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -38,6 +38,27 @@ instruction at all.
 only way to pass early-configuration-time parameters to it is via the kernel
 command line.
 
+Sysfs Interface
+===============
+
+The ``intel_idle`` driver exposes the following ``sysfs`` attributes in
+``/sys/devices/system/cpu/cpuidle/``:
+
+``intel_c1_demotion``
+	Enable or disable C1 demotion for all CPUs in the system. This file is
+	only exposed on platforms that support the C1 demotion feature and where
+	it was tested. Value 0 means that C1 demotion is disabled, value 1 means
+	that it is enabled. Write 0 or 1 to disable or enable C1 demotion for
+	all CPUs.
+
+	The C1 demotion feature involves the platform firmware demoting deep
+	C-state requests from the OS (e.g., C6 requests) to C1. The idea is that
+	firmware monitors CPU wake-up rate, and if it is higher than a
+	platform-specific threshold, the firmware demotes deep C-state requests
+	to C1. For example, Linux requests C6, but firmware noticed too many
+	wake-ups per second, and it keeps the CPU in C1. When the CPU stays in
+	C1 long enough, the platform promotes it back to C6. This may improve
+	some workloads' performance, but it may also increase power consumption.
 
 .. _intel-idle-enumeration-of-states:
 
-- 
2.47.1



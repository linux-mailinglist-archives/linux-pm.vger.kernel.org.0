Return-Path: <linux-pm+bounces-21943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754CCA3215F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189043A36BC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B7205AA5;
	Wed, 12 Feb 2025 08:42:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25220551A
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349757; cv=none; b=cWHa2EUwHrT2ReKRlIYx3i7C3UIg1wV8v5filAaE9Pmiml5BFfOIzkDcP87wAZ4Co8ualvKbPgAT6S2XCQrO6sV5bTW/5B8OGXLeLm754TsE66Yu7JjF5KKBaanq1RgAL3Q42wdTJG+ElRGDZyNCndvMl1RfBgmkzKuzqtJ9fnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349757; c=relaxed/simple;
	bh=H8roSqKkRwv78+4qwapfAtEItuMiP3RYokGiLLLQwPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daIX2qsYNo6484MBxuBTMGC6CjCHpM8O00pJTrmac8SDAXhBYL0QjpntsbysvNYVflV0aIM9IUIAE/v32pBRw5fRFCHDJXYX2kc5I6bDJh+SHHrHK6bJdt5sDhMjerD2Sd8NQT3Rq8YxKQajHxLQyHEtvktYzF4afzwSUkR+tDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: n8QGC92bQAGYCIkYdWB/og==
X-CSE-MsgGUID: e/rzSuI6RIChpf0EXTLLHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43920854"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43920854"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:42:35 -0800
X-CSE-ConnectionGUID: Zw0wgpcpQpW3WHgWMq8WxQ==
X-CSE-MsgGUID: GDLYsaF+RaqG6n+cIGM8Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116849093"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2025 00:42:34 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 2/2] Documentation: admin-guide: pm: document intel_idle C1 demotion
Date: Wed, 12 Feb 2025 10:42:32 +0200
Message-ID: <20250212084232.2349984-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212084232.2349984-1-dedekind1@gmail.com>
References: <20250212084232.2349984-1-dedekind1@gmail.com>
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
index 39bd6ecce7de..a1daa0fe045a 100644
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
+``c1_demotion``
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



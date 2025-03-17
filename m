Return-Path: <linux-pm+bounces-24175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4963A651E9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D1A173145
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2223FC6B;
	Mon, 17 Mar 2025 13:55:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06323ED62
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219748; cv=none; b=q0xgr7jlDzZatZceJBLQoGytjciiDLJrtv7j8Br4mjkrP9EjxtpQIjbc1JgJ6FbbTK7dM4HvDhLL49rSGJATPLbQF7PudlSDGq1fcoxDlpozygqP1XV/LC0ZXQAYlSOiYf88UDExVsNRfcPK/cFsz5cWOkfLKAzoP43+vy7Xd/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219748; c=relaxed/simple;
	bh=u9vODP8v8WgPk/9sAW1h8ebtIALXZ7YfXOpE32DjU80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5+dvvF8J36yLiysxdy4xH6VikkzffDciDGEjvl3+uGBNua4Iiz7gG4vOtpZX4iQ36dGzA4nRx1W8ccursEf0CTF6VSl3udNKd9WSEZlkPzJhvVCApEDvXzT4L04o7HbWmHFYA6EiB2gGzXlFqD/EU/EtCUeSGVsxhjhMHkbddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: JXN1PUbLQ1ewTyqqnqUiXg==
X-CSE-MsgGUID: uT4KdloFQ1+zAeuTe4rBkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43515490"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43515490"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:55:46 -0700
X-CSE-ConnectionGUID: W3uA1tPIRGKQ2iE9/hVKng==
X-CSE-MsgGUID: RnibvvxzQFS0xx4YbtRNiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127115532"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa005.jf.intel.com with ESMTP; 17 Mar 2025 06:55:45 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v3 2/3] Documentation: admin-guide: pm: Document intel_idle C1 demotion
Date: Mon, 17 Mar 2025 15:55:40 +0200
Message-ID: <20250317135541.1471754-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317135541.1471754-1-dedekind1@gmail.com>
References: <20250317135541.1471754-1-dedekind1@gmail.com>
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
index 5940528146eb0..ed6f055d4b148 100644
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
2.48.1



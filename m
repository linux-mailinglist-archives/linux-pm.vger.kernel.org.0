Return-Path: <linux-pm+bounces-24176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0D9A651EB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3850E3A5440
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F623FC75;
	Mon, 17 Mar 2025 13:55:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B823FC54
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219749; cv=none; b=CZWfE/6ILBS6WDb/dSc9jOPJJSIGUqfxSvZGS3538Ck5sAbGpO1f5IRDo6FtxwIU8tbrtjEUceg0cPm4H6hSJ7ljkS+a4Q1mNKR9zdGg8gPCbpv/rjLbP8E8n2MKXZIxtbiyYZCnewKG5WarP6vE2QOJEPZIvSX8A6zCwKn01U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219749; c=relaxed/simple;
	bh=JMIsGb8VYvJt2YUNg0dD2giiZhtZIXhCHFEA09ePRnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gATl053UGeOvWZaVih921vYJrfLt2RzsECa7MCKG/tE9Jy18DqH4erKOqambDcmDOcBUsE4Ay6XlZsBxV2Q/nAudAhxonbPo/bR1SxNXk36zmpPyf3445mLSOE3j8rIcXP85u+OjQpTAnMdXEI2uodgCcBHxDMS4c6lsLUJSC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: ijx/P0RARrWb3NyDpnwbcQ==
X-CSE-MsgGUID: xWkNb2pVQ8iOrsYxloRfKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43515494"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43515494"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:55:48 -0700
X-CSE-ConnectionGUID: 21NeatP0SdKO10ieyr/e4w==
X-CSE-MsgGUID: rwTB/OscTZKKeDJBljKiBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127115538"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa005.jf.intel.com with ESMTP; 17 Mar 2025 06:55:46 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v3 3/3] Documentation: ABI: testing: document the new cpuidle sysfs file
Date: Mon, 17 Mar 2025 15:55:41 +0200
Message-ID: <20250317135541.1471754-4-dedekind1@gmail.com>
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

Mention the new 'intel_c1_demotion' sysfs file in the "cpuidle" section
and refer to "Documentation/admin-guide/pm/intel_idle.rst" for more
information.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b1..6c4934d3f4db3 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -111,6 +111,7 @@ What:		/sys/devices/system/cpu/cpuidle/available_governors
 		/sys/devices/system/cpu/cpuidle/current_driver
 		/sys/devices/system/cpu/cpuidle/current_governor
 		/sys/devices/system/cpu/cpuidle/current_governer_ro
+		/sys/devices/system/cpu/cpuidle/intel_c1_demotion
 Date:		September 2007
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Discover cpuidle policy and mechanism
@@ -132,7 +133,11 @@ Description:	Discover cpuidle policy and mechanism
 
 		current_governor_ro: (RO) displays current idle policy.
 
-		See Documentation/admin-guide/pm/cpuidle.rst and
+		intel_c1_demotion: (RW) enables/disables the C1 demotion
+		feature on Intel CPUs.
+
+		See Documentation/admin-guide/pm/cpuidle.rst,
+		Documentation/admin-guide/pm/intel_idle.rst, and
 		Documentation/driver-api/pm/cpuidle.rst for more information.
 
 
-- 
2.48.1



Return-Path: <linux-pm+bounces-22552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBDA3DE2D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727293B7CEC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C21FBCB6;
	Thu, 20 Feb 2025 15:17:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F51FCF45
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064632; cv=none; b=fg0Bt/SrAM48Ul+w8DcTeU5ysuG2+Ev8Hhc5z+p9hyqGwtPnGl9ly2Bd8Un9T6o3KO79n/4fdchGFh3vmYcilNF/cokduCLeyR8mcjMF4eLP99Wp8EbtxAmSappAGTs2ZVucB86ba5TBRPbtqBHlYa37ZT/tHmun+FhveoTpt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064632; c=relaxed/simple;
	bh=PXoYHkEdPAb3AjmCxOMExyOHH7/x1aVNJbN4ZdnZqGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1QdXGNjX+HulF5twOeuwv3ITsPL5sp9Y2B48Q2kqwaEi14yly/lYEv9X2pAdpen0q/2nEkVOdjeh+jc9quK8FTmy9axBsPIq5KsakXiKxcmNlWrv+rj+yBqWugKUHclJhgWe72QQ1FtFxpznBfAiulTkNfsdt/O1K6pCY8qmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 8TCoN4jmT/OJ13oHCjauwQ==
X-CSE-MsgGUID: TRCYpyZVRz+1TrnGffc8nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40703691"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40703691"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:17:09 -0800
X-CSE-ConnectionGUID: 82ANJJk1T7CDOOe34aMP3g==
X-CSE-MsgGUID: HbqJuClbSn+DpLjoF7uCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145922164"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 07:17:07 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2 3/3] Documentation: ABI: testing: document the new cpuidle sysfs file
Date: Thu, 20 Feb 2025 17:17:02 +0200
Message-ID: <20250220151702.2153579-4-dedekind1@gmail.com>
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

Mention the new 'intel_c1_demotion' sysfs file in the "cpuidle" section
and refer to "Documentation/admin-guide/pm/intel_idle.rst" for more
information.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b..6c4934d3f4db 100644
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
2.47.1



Return-Path: <linux-pm+bounces-22549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771F7A3DE2B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9823B64E6
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBEB1F9F62;
	Thu, 20 Feb 2025 15:17:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3D19D06E
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064628; cv=none; b=Cl9/6xpOWu8q6f8blEcSpyLWdtfiTXmNJL/zt3CYYMaC9rk3aipbO4qx1+GzTo2QMfiK/tOlqNZTtBsiq58uGrNT8mSMQF0CuRMirsx1lRrAXeUrNek6dtJ5HTlHnt90E55zIY3OrLzJJBytwSM5QPSUYrqu1oJORFJlwxwi2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064628; c=relaxed/simple;
	bh=rEOO6Z3rG2YU1nqmIZQxTUiGja17lOTj19n41yTheak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5+E4pMh2sbUajdpwGPu/i/DLROEGTHhVh8Q0b2CPKTo6uxWEIJ0guXgtdSGwjB0skYEtDQSrQApe5l4VcHWugiF+O6Tpg6F+172h5UhdJFb4VjCor81v2N81/eGSVHB63T5LjkaDsnqiX9igw92aNHAStBxP5TwF4PnyIxT0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: nQaI+42MQROxm2gq+HWPCw==
X-CSE-MsgGUID: FM8eAqW4Sa+mRvr3zwaHFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40703675"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40703675"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:17:06 -0800
X-CSE-ConnectionGUID: tLIuKnptRKa2csB7ZDweBA==
X-CSE-MsgGUID: 2dCFGxIdQciZui016o0FiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145922157"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 07:17:03 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/3]  intel_idle: Add C1 demotion on/off sysfs knob
Date: Thu, 20 Feb 2025 17:16:59 +0200
Message-ID: <20250220151702.2153579-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Version 2 of the patch. Find version 1 here:
https://patches.linaro.org/project/linux-pm/list/?series=260892

I believe I addressed all the comments except for this one from Rafael
Wysocki:

"This is not the only place where MSR_PKG_CST_CONFIG_CONTROL gets updated.
The other one is drivers/platform/x86/intel/pmc/cnp.c

There is no real conflict because the PMC core thing happens during system
suspend/resume on client platforms, but this is kind of duplicated code.
Any chance to consolidate this?"

This comment I am trying to address in a separate RFC patch that I am going
to send very soon.

Changelog

v1->v2:
  * Address comments from Rafael Wysocki:
    1. Rename the sysfs file from 'c1_demotion' to 'intel_c1_demotion'
    2. Add a commentary about reading the feature only for 1 CPU.
    3. Update Documentation/API (new patch 3/3).


Artem Bityutskiy (3):
  intel_idle: Add C1 demotion on/off sysfs knob
  Documentation: admin-guide: pm: document intel_idle C1 demotion
  Documentation: ABI: testing: document the new cpuidle sysfs file

 .../ABI/testing/sysfs-devices-system-cpu      |   7 +-
 Documentation/admin-guide/pm/intel_idle.rst   |  21 ++++
 drivers/idle/intel_idle.c                     | 103 ++++++++++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

-- 
2.47.1



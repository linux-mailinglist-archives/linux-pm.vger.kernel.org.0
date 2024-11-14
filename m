Return-Path: <linux-pm+bounces-17541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A09C8484
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A989B235A2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133E1F7060;
	Thu, 14 Nov 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6tx49jP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840C1F6688
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571412; cv=none; b=kHVLDpVvd36mGTOz+28C/m21fLHsmIx+naKveHcJ9yjjH35/kBYGf6wE6tcFMCKDKjKig694v3eszrzMVmp6BeRK1nYcZH+VsJtflIgKCD1me03GTzPEw44Ly/BrFra40ZJ3iM8dGwXHw+wLOVzFq6emidVmzIsidv1w4EVIFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571412; c=relaxed/simple;
	bh=8KjvoTA9FFiJrrMA6CJizb+VcL+FjT/zZx7w4ZnmG2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pu6HdD+Q11e7tL8d6hz3+ShhlRZdDEDBJQ1KJvbqc6kELCiTtUDmXLe4A7oj3T2F8IXdwhX6WGsdleUSofP23AuSzKNopXOexFxW5Vz3ADRiqFZyy7gJibYatOX/AlPIs8pXaG5XibOLyx47jiVYgxo2YQce1Ts37EVpUx9RljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6tx49jP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571411; x=1763107411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KjvoTA9FFiJrrMA6CJizb+VcL+FjT/zZx7w4ZnmG2w=;
  b=E6tx49jPLyZ7DVW6k1sDUnxRbN9m1CE90KO+qNn8i65Gt1hZFNQAXEG+
   gVfnoS5ospQB23fWVdEjb7Ves9lQc9A9++idhXJcTwc2GTc5lQdBLQBJv
   QpHuOiLTxD7Kx1U73wzwJeF1RrxdC8s0+Zzfv56+glSAnnsfpGof2r4o3
   zyZH5vk7R6rpiTeBz//1vgWEwWPwzCEBRkoZYhLwjrSLbr9zwEI8N/br6
   Q1LJFG5OZ1MWmIjfgQET0izB4GW2mndYZfFv+kInw1aw9nOqKouf0Fk5u
   HOA/u+vtGGN6p1dnOcFtMjuOLgwHxCSL2RR6vrFQPIobfYvSR9Puh6P0g
   A==;
X-CSE-ConnectionGUID: t/3r41zlSqakePUgcp40AA==
X-CSE-MsgGUID: V8BbbejBSCi+t3IXtSaMTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600444"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600444"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:23 -0800
X-CSE-ConnectionGUID: HViRJhZJTPSXhJfgjk/dbg==
X-CSE-MsgGUID: 9SsIddKeSsCktipUdGqWEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627480"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:22 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 07/10] tools/power turbostat: Remove unnecessary fflush() call
Date: Thu, 14 Nov 2024 15:59:43 +0800
Message-ID: <20241114075946.118577-8-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114075946.118577-1-rui.zhang@intel.com>
References: <20241114075946.118577-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The graphics sysfs knobs are read-only, making the use of fflush()
before reading them redundant.

Remove the unnecessary fflush() call.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8a45b1c4c225..4956f4b837d1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5747,12 +5747,11 @@ int snapshot_graphics(int idx)
 	case GFX_ACTMHz:
 	case SAM_MHz:
 	case SAM_ACTMHz:
-		if (gfx_info[idx].fp == NULL) {
+		if (gfx_info[idx].fp == NULL)
 			gfx_info[idx].fp = fopen_or_die(gfx_info[idx].path, "r");
-		} else {
+		else
 			rewind(gfx_info[idx].fp);
-			fflush(gfx_info[idx].fp);
-		}
+
 		retval = fscanf(gfx_info[idx].fp, "%d", &gfx_info[idx].val);
 		if (retval != 1)
 			err(1, "MHz");
-- 
2.43.0



Return-Path: <linux-pm+bounces-39158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDEBC9EC5F
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3659E34B31B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29DC2F0C48;
	Wed,  3 Dec 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDF2FBGG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792102EFD9C
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759199; cv=none; b=IETLod0wNmAwHaFM5UhnB7MGt4szjvvdCJYB09w26GSWikKTdcL3mVN/zh11/ajnGDOZG39EskBZCfYwYa0Byz0kX3LMPWRcFlgq0cX1ZgbVtxLst9zXz7PuJYExZBaGPd7PWCgJivrWPTpAZqHNrhd4Nit1tO3DWeyUEExlD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759199; c=relaxed/simple;
	bh=GGZhwm3fZEh3eNMKAWxACMtFmV9vNXfTw8c8TAmBf7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYri+i0CmCCbnjCurY2nAw01PpmvS8OdODq1VeoNBpTkPeuzJmUGBX/PuyGHh24o41xgGZjDHuRTo3TujERbykFW6q/UH1DWYCGM6wtfDAbsC+2XVhG+I3nV3TkHDBROX5jHo+DzFg7I0MawNVUVp7iolvJU3SnWI+Xl4vyGRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDF2FBGG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764759197; x=1796295197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GGZhwm3fZEh3eNMKAWxACMtFmV9vNXfTw8c8TAmBf7Y=;
  b=ZDF2FBGGBjA64zOJWSefxtt0z4PPv6hOx+FCfzGoUMC3MuIa89/PsTRS
   qSQro1eBimNg0RCMV+7W3bBwmwz9zwS1tQY1Rm7cJ6Kx85cYGFwgv/Elv
   yXTcJmiakqBX+ORNN/GUEkCYPUd+GnmjaY3fM7yv72iAMd0B0wSSpO4fE
   /e95vb0V1ipCkdkQrf4oEOnqGZTALRjEFhNvaaXesWWjRwPE6QPt+l79M
   5r0C2JHY8YuRIYmdLP8StoakYazdUMJ2uuy83JBsGlJ84W3TxZ+LJwniW
   5OQdf7y/2TAr4WoezMDl3ftA3qhcVSbKdL8pNJWUjgYmbsK84f+YD19dH
   A==;
X-CSE-ConnectionGUID: DnpByNHEQemamNBnpdlf5w==
X-CSE-MsgGUID: 5YlqD258TfSSsqDfekxhqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84342142"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84342142"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 02:53:17 -0800
X-CSE-ConnectionGUID: eqkv4iS+RbqcvXJYSdfRCw==
X-CSE-MsgGUID: S1WEWP8pRUeRAlw7WsUkmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="198811282"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2025 02:53:15 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/thermal: Remove unreachable SIGKILL handler
Date: Wed,  3 Dec 2025 16:20:50 +0530
Message-Id: <20251203105050.3768446-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SIGKILL cannot be caught or handled by signal handlers per POSIX;
the kernel delivers it unconditionally. Drop the dead code path
that attempts to register cleanup for SIGKILL.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/thermal/tmon/tmon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216a27f4..277d031eb797 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -104,10 +104,6 @@ static void tmon_sig_handler(int sig)
 		printf("sigterm, exit and clean up\n");
 		fflush(stdout);
 		break;
-	case SIGKILL:
-		printf("sigkill, exit and clean up\n");
-		fflush(stdout);
-		break;
 	case SIGINT:
 		printf("ctrl-c, exit and clean up\n");
 		fflush(stdout);
-- 
2.34.1



Return-Path: <linux-pm+bounces-39676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E888CCD719
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282EC303D33B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 19:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2754286897;
	Thu, 18 Dec 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnCVz1gZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB6246781;
	Thu, 18 Dec 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087514; cv=none; b=bS0eSOQuvjgOfX06CtdPuIi2VvFACD4pPR5n4x+ROE9RE3IW5w6Wx3qxdCxZkyvFBjUD6gyMVUMCwu/k38CFnoG1pbsy6r8c4pZ1FWTWGoKEQzwInaDXrQYG0YZRYhNx97OLZ7YEmtAwl+ZKOWs4ZuJ7u+xk2kZWqjGcgGbvO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087514; c=relaxed/simple;
	bh=pvFe6vx//Wo4DSX9RXu/NixqTb4wBens/vBG15XPzpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLb0MiTql73+CWY4YtuTrTWN91/1uwcZvFK7zBd2pDQp33ULMvjx0DVC/GycwgzUYS1CnywET+1QRoyjH+kwdj0ybd5EWprFMoPXVkrOju8A7muhtER8B1oC0xSlH/dF8Btm+Pj6w6tf4M2KmibGOH7+lq2J1ZhChkIl409ij5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnCVz1gZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766087513; x=1797623513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pvFe6vx//Wo4DSX9RXu/NixqTb4wBens/vBG15XPzpI=;
  b=JnCVz1gZ6xcLfPfrlYoDxoNvkcVD4Jvuo+rRczROlDbiuhhZnI0XefLf
   5n3gKFpHaZhlJtPfb0EUF43t4qtKQX2U3JZdkIB/LJvBDbXinIRsHc/T9
   cSIJbWjP9ohWJ8XLMaFNuN+KBKSti3mLac85wByF83PG/R80fio2Et2Rz
   m0HDMhs1i0/b4o1hHdAhvClRg6zEVq3QWPMY2ZIlZvYLIMmAJ5jc42SRT
   jddsoG5kQo9ERl4dUZTwHckLtXNgVyqocFyOFuVAgCZkFjByYLgTMVakP
   75Re90MjU7xO79sTzJFBo8VI73jzm0vF43mr3rBju1jKjynGeN/0Lrs0T
   w==;
X-CSE-ConnectionGUID: Qdu6V9pWSgqgtTGT1sOfSA==
X-CSE-MsgGUID: 6dLbA03zSia2iZ/vNp7DWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67803073"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="67803073"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 11:51:53 -0800
X-CSE-ConnectionGUID: TOyejrb7R8evnyK/WA541A==
X-CSE-MsgGUID: G2X3d30yRduL/8sgjqt3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="199143510"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa009.fm.intel.com with ESMTP; 18 Dec 2025 11:51:52 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: intel_tcc_cooling: Add CPU models in the support list
Date: Thu, 18 Dec 2025 11:51:50 -0800
Message-ID: <20251218195150.3872795-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Panther Lake, Wildcat Lake and Nova Lake CPU models in the support
list.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index f352ecafbedf..92de161e359a 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -65,6 +65,10 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
 	{}
 };
 
-- 
2.51.0



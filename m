Return-Path: <linux-pm+bounces-34755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A7B5A120
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A608E521A63
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D22F5A03;
	Tue, 16 Sep 2025 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xnn8ARJf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48E26E6FB;
	Tue, 16 Sep 2025 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050024; cv=none; b=p++NtuswKVus07X3cZJ27/KwithnU/Fp5kmuqzuXbQQU62Iwr5qeWvXuF8+nTDgX7LfQZZM7eplnmxVE3hfLnljqg/t4MlbSJjhjNGvY55Elk03NZfyp+XeSOCeMFkTKjS+wvZ9epYFXQH0Ja4cfV26B/MhxrDO+XnqHDgkk+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050024; c=relaxed/simple;
	bh=4H86ltejAj4xv3Dw7e4TEmv58rhAupO55xtgdM1BKZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ORnBYZPcIB3H2dK1ebZ/hqCgxiCX9n2rz5b7yK2uzKk4IFOYtZxe6rSzW64Zrtxn5/929J5IiJs08hDkw0+PthkAWPRsXI/1cjCSibqQtxqVtjMuXa5JdlvefnqbXEt7px7cyv+PBYhkp78lI+KoUH3LTVgtTBUd6oKjAaP+ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xnn8ARJf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758050023; x=1789586023;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4H86ltejAj4xv3Dw7e4TEmv58rhAupO55xtgdM1BKZ8=;
  b=Xnn8ARJfYdxYVGNiAmbxKYB+dQYzx4c2tPxf/BWHhOrVM6gO7TlbSiLr
   x9G4JtgOOCGCb+c5ECwTdz9BBbD4g9zFJwErMOxHHcTQ49HKFxw9pq8GK
   hb46LYb4kDtYKSRYa5AKdnRFv8hlt3RFnUQfRFcL793FhJGnJJ+dBSGBu
   vImeIMGITh1fyVFklVxxVyYOMI6+g7Wuz4N1BSfgW2/BHiv44Lz5oguGY
   goEJXM8rA3GcIwnmqAWSxBru7SciazxdoHnCh+x5GzNN5vjAFKwGsv7TJ
   z1qpCFyI7sLH7u6l36dZgeFHqPtsU+u7w0PVzSSZW2m5W3IsT/bGopK5E
   A==;
X-CSE-ConnectionGUID: pJtCI0czSUudhylZIRlLtQ==
X-CSE-MsgGUID: dzrsNPo5Qeae9s1ITfQTSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60486687"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60486687"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:13:42 -0700
X-CSE-ConnectionGUID: VG1XlTvuTcaB2lgyu4GJUg==
X-CSE-MsgGUID: AuwKAfJPQiuNAbpBtjA+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174595260"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.111.195])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:13:42 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] platform/x86:intel/pmc: Replace dev_warn() with dev_dbg()
Date: Tue, 16 Sep 2025 12:13:32 -0700
Message-ID: <20250916191339.1748512-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_warn() with dev_dbg() to reduce unnecessary warning messages.
When the low power mode priority register contains invalid data, the Intel
PMC Core driver can still utilize the default priority list. This scenario
is more suited for debug information rather than warning.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index de2dbf4ad65e0..5729810e5a485 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1244,7 +1244,7 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 		for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
 			pri_order[mode_order[mode]] = mode;
 	else
-		dev_warn(&pmcdev->pdev->dev,
+		dev_dbg(&pmcdev->pdev->dev,
 			 "Assuming a default substate order for this platform\n");
 
 	/*
-- 
2.43.0



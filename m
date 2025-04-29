Return-Path: <linux-pm+bounces-26342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9582EA9FE07
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238D5468000
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB361E98E1;
	Tue, 29 Apr 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNFvWA2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BA132103;
	Tue, 29 Apr 2025 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884885; cv=none; b=L3Si9gIlGKdYTCVT/kf1TKdRnKJIQzG8ZR6ZDObowaXHB104V1JaDvz3mwVdkvA0Nn5jcV9CpCqiPCsJGoEqEHN5T+miKEZ2lI+zTc5vCVvtUsr9JkVwPZUOdEHESKT720Yn3TltzM+Dattz7n0mLgUmqFJPhbmoW8gtTZOL8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884885; c=relaxed/simple;
	bh=0BgsvW88VTK+wdGffZRIbYuC9twTBq1CLwH0v2LeS34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JO8Hvpi7UylheWPR/dZhrmKM0C8Gco6OYIIU5MnGP9Bas2z80W02BpPCBLuzZsTruociUiv4HLiLLYcwSvprshegkJPqWJN7FgE1r/Kpyy6NPQL0xRAmd2rZW4qKxlOZ4H1fjpK9JHYH+mS7LTEzjjz0uZvXR2QDKADQeBq3JyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNFvWA2L; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745884884; x=1777420884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0BgsvW88VTK+wdGffZRIbYuC9twTBq1CLwH0v2LeS34=;
  b=hNFvWA2LumFqd02j+lAYbQTe0W3V3qOU7Y1hMiSqVMjCCFatbj7Ji81J
   wyJ+dh8lH1mFXb8T40TBwODjoLer7HZU+8tmMqPJpqzdwvQrD47iY4hZS
   G6+N/bbFbbg2PlVD57jy5d9tJX4uKopUJpTBNjfhAPL9tXKRmsxfbquiW
   gVKO4Xk5JveNC5Ho179s+sPr5KSDN+DbaoKvDwstqpky/dBAsvgkkXP0E
   ecv0J7BD4/C4PZynEROT8SDrkTpjVALDplqg8BHbA9SunGaZPa/71CLux
   xTFZ2cr87Dd9qoHyOtSnlBPFfid3xDLOAwyn6bYQM+D/KdzDbpDw4Vy1S
   A==;
X-CSE-ConnectionGUID: /shm+8TWQCqDayAtLKaqmg==
X-CSE-MsgGUID: Ih8kd0FJQ8Cw4gSZr5i7yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58864060"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58864060"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:01:19 -0700
X-CSE-ConnectionGUID: fWQCOVC6QBmRqPgfpJio5w==
X-CSE-MsgGUID: bn8uVPpNSV2ME2CrU33kxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133386497"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa009.jf.intel.com with ESMTP; 28 Apr 2025 17:01:19 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] thermal: int340x: processor_thermal: Platform temperature control documentation
Date: Mon, 28 Apr 2025 17:01:10 -0700
Message-ID: <20250429000110.236243-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
References: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update documentation of attributes for platform temperature control.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Change the sysfs folder name
- Add comment about singe user level manager

 .../driver-api/thermal/intel_dptf.rst         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 8fb8c5b2d685..ec5769accae0 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -191,6 +191,27 @@ ABI.
 	User space can specify any one of the available workload type using
 	this interface.
 
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/ptc_0_control`
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/ptc_1_control`
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/ptc_2_control`
+
+All these controls needs admin privilege to update.
+
+``enable`` (RW)
+	1 for enable, 0 for disable. Shows the current enable status of
+	platform temperature control feature. User space can enable/disable
+	hardware controls.
+
+``temperature_target`` (RW)
+	Update a new temperature target in milli degree celsius for hardware to
+	use for the temperature control.
+
+Given that this is platform temperature control, it is expected that a
+single user-level manager owns and manages the controls. If multiple
+user-level software applications attempt to write different targets, it
+can lead to unexpected behavior.
+
+
 DPTF Processor thermal RFIM interface
 --------------------------------------------
 
-- 
2.49.0



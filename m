Return-Path: <linux-pm+bounces-23685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69EA57D49
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DFD1893525
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0362153DE;
	Sat,  8 Mar 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLty0f+W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6D214207;
	Sat,  8 Mar 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459119; cv=none; b=CVuZsjB+pyuXwLj8tcKYp3JbsF8UY9URrC0YbqIozm6+jKk1K4x1ALvIfKUqpiX+57RM8JIucr0YjWW0kBf4LWNFDfwigpst6XGJ4jgF6e5lfxGDaH2EJXWIZOG5Q6Q10BnshdQvRARDPidB6gOqqlmvHrKqT9blyObKHamc0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459119; c=relaxed/simple;
	bh=de80fhR1oga+j2cwNsqZ/kApwvosfVY97WNh0bbPtBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6G2tby+PFPiSeq394NX4W7UpwgysrZmano8vfU6He6Kiu/DfW+NzF4yAd4/n9/Bt6qm592S/aAqJG+Db7ZP+SXyAGIxedmp8mFevRsJGl6HIdmac1yuZiFp1ys0ZvfkeNhaEVgHXMfK0i2UEsTr4gRr3uom3rbVRn0oFW88fXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLty0f+W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459118; x=1772995118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=de80fhR1oga+j2cwNsqZ/kApwvosfVY97WNh0bbPtBs=;
  b=YLty0f+WViXqIV2bWxLoVvJsURKbhVu9Muglq/6Zi3LDOuLwxeof95fN
   8nPHC7C3m6f4ZJ3SwAzQwd320QA+3PArIs+aUlPiCrFazI5SGWfRYRMpk
   sljjQN8jo4HyaMNJNw1aO+T/9RTjFG1VOlZXHEIr//AefXx3tb9nVxz8E
   6okTVMONTmMXy5wLGu4lzajo1kfsLrN2pj7e66w2zQXzZt4SpUUioDb1D
   GD0YgdkgwvRloyj/GT6r8s3GbKGVb7Xnda6LM/piGp4MwWa5rygUVHgk1
   APDZF3Rw2VEq1BRPcwC6t1O5oVGdPnauV3450klFq+bkN30R4KjMFnXPo
   g==;
X-CSE-ConnectionGUID: yTTJyaxhTxutmSHBMgiRQQ==
X-CSE-MsgGUID: 52sZjydiSnmR8vLGHzwL4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46148342"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="46148342"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:38:33 -0800
X-CSE-ConnectionGUID: V8H7uIZ2QGWb45+uhTBHHA==
X-CSE-MsgGUID: Qa1G200QQ9WcvJg3oY+sdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="119584471"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa006.jf.intel.com with ESMTP; 08 Mar 2025 10:38:33 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: int340x: processor_thermal: Platform temperature control documentation
Date: Sat,  8 Mar 2025 10:38:12 -0800
Message-ID: <20250308183812.118311-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
References: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
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
 Documentation/driver-api/thermal/intel_dptf.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 8fb8c5b2d685..e7e387d60b7e 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -191,6 +191,21 @@ ABI.
 	User space can specify any one of the available workload type using
 	this interface.
 
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_0_control`
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_1_control`
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_2_control`
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
 DPTF Processor thermal RFIM interface
 --------------------------------------------
 
-- 
2.48.1



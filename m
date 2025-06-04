Return-Path: <linux-pm+bounces-28128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931FFACE5C7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 22:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3364189682C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF41DFD86;
	Wed,  4 Jun 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7EPpmVX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EED1C54AF;
	Wed,  4 Jun 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069330; cv=none; b=W/OtSA+qp7y2ZcpzXYq/40gzZR0ox6yMlwAoK8r370A4PWKxvdonOQlK/nuTazwb4jFDzMtnrhuqXqOjYzvok0rNo6m5I+FGHnGeqvMv+tBU8E7rlFFRYBqTcxTczm+uw9VlkSsLGT40JpfgJWvQjxwlc4Ub9/upYJdqsa+24O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069330; c=relaxed/simple;
	bh=n7Ll+iaHU0bxbwueRco6qGvImE5BAZNtflNd9zLL9NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VMRwWGvEmvUgtL6kn6mRrJxG/u/K/63ywoYyvj/M+ggP97exU5BwKYRcXBi1omMo9DL8Haz0WhDaAPPNAPaqm90/c7BkXNAcm4IhYJPNHmLqksa42KWmF/rWXT8VLodAsl1fLIoBf2+HA2fWGR2pI5jKROVXptUiiOI0OaFO81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7EPpmVX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749069328; x=1780605328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n7Ll+iaHU0bxbwueRco6qGvImE5BAZNtflNd9zLL9NE=;
  b=Z7EPpmVX7IcSH9xFb4HIYBfhk6F1Biqb486fiKHPmbkLN5swZmFqP7NL
   8J8oFdDDjUiX9n90F0EZ/yMEdSA5q8S6Cq6Hk7KkN+d943YGwKcCsAtH1
   eLIHMFPSXMk8z3Uu4NFNQL+zP48h+XOZsuNs3WHRjH5oLUNlLGP8h+Chk
   elMnU0ccze1Ar4+EvHCEOaWJ9TEPNrltvSfSes7KDepp5/yK6BkYKsG7k
   TpuCEgh3o1FwUqxkOJWgwKX6QFQEauAl8vPfLs5yeSIJpSX7v1foWdyuY
   GZ4vU+TXJTg7oOIAkdhTmMPvS5pWfeLzTEzDviQTKd+H97TuSaNiL71ic
   Q==;
X-CSE-ConnectionGUID: TkQQ/zyAQRKLjx54t4v1+A==
X-CSE-MsgGUID: q2snWP+mTfe/j7s0BrsIvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61788242"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="61788242"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 13:35:25 -0700
X-CSE-ConnectionGUID: +1DDiTRUQ8qN0blVkGmhGQ==
X-CSE-MsgGUID: 6bLjv8J5QeixvevJD71iUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="168461793"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jun 2025 13:35:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] thermal: intel: int340x: Add performance control for platform temperature control
Date: Wed,  4 Jun 2025 13:35:17 -0700
Message-ID: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add additional attribute to control performance of platform temperature
control feature. Two attributes are added:

gain: 0-7 levels, with 0 being most aggressive.
	7 – graceful, favors performance at the expense of temperature
	overshoots
	0 – aggressive, favors tight regulation over performance

min_performance_level: A value from 0-255. Specifies minimum Performance
	level below which the there will be no throttling.
	0 - all levels of throttling allowed including survivability
	actions.
	255 - no throttling allowed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/driver-api/thermal/intel_dptf.rst   | 10 ++++++++++
 .../platform_temperature_control.c                | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index ec5769accae0..794f5cce548e 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -206,6 +206,16 @@ All these controls needs admin privilege to update.
 	Update a new temperature target in milli degree celsius for hardware to
 	use for the temperature control.
 
+``gain`` (RW)
+	A value in the range 0-7. Sets the aggressiveness of control loop.
+	7 – graceful, favors performance at the expense of temperature overshoots.
+	0 – aggressive, favors tight regulation over performance.
+
+``min_performance_level`` (RW)
+	Minimum Performance level below which the there will be no throttling.
+	0 - all levels of throttling allowed including survivability actions.
+	256 - no throttling allowed.
+
 Given that this is platform temperature control, it is expected that a
 single user-level manager owns and manages the controls. If multiple
 user-level software applications attempt to write different targets, it
diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 2d6504514893..6cd05783a52d 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -49,7 +49,7 @@ struct mmio_reg {
 };
 
 #define MAX_ATTR_GROUP_NAME_LEN	32
-#define PTC_MAX_ATTRS		3
+#define PTC_MAX_ATTRS		5
 
 struct ptc_data {
 	u32 offset;
@@ -57,6 +57,8 @@ struct ptc_data {
 	struct attribute *ptc_attrs[PTC_MAX_ATTRS];
 	struct device_attribute temperature_target_attr;
 	struct device_attribute enable_attr;
+	struct device_attribute gain_attr;
+	struct device_attribute min_performance_level_attr;
 	char group_name[MAX_ATTR_GROUP_NAME_LEN];
 };
 
@@ -78,6 +80,8 @@ static u32 ptc_offsets[PTC_MAX_INSTANCES] = {0x5B20, 0x5B28, 0x5B30};
 static const char * const ptc_strings[] = {
 	"temperature_target",
 	"enable",
+	"gain",
+	"min_performance_level",
 	NULL
 };
 
@@ -177,6 +181,11 @@ PTC_SHOW(temperature_target);
 PTC_STORE(temperature_target);
 PTC_SHOW(enable);
 PTC_STORE(enable);
+PTC_SHOW(gain);
+PTC_STORE(gain);
+PTC_SHOW(min_performance_level);
+PTC_STORE(min_performance_level);
+
 
 #define ptc_init_attribute(_name)\
 	do {\
@@ -193,9 +202,13 @@ static int ptc_create_groups(struct pci_dev *pdev, int instance, struct ptc_data
 
 	ptc_init_attribute(temperature_target);
 	ptc_init_attribute(enable);
+	ptc_init_attribute(gain);
+	ptc_init_attribute(min_performance_level);
 
 	data->ptc_attrs[index++] = &data->temperature_target_attr.attr;
 	data->ptc_attrs[index++] = &data->enable_attr.attr;
+	data->ptc_attrs[index++] = &data->gain_attr.attr;
+	data->ptc_attrs[index++] = &data->min_performance_level_attr.attr;
 	data->ptc_attrs[index] = NULL;
 
 	snprintf(data->group_name, MAX_ATTR_GROUP_NAME_LEN,
-- 
2.49.0



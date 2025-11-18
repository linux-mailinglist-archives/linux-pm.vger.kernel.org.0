Return-Path: <linux-pm+bounces-38192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C8CC6BE19
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 23:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C2754E7F67
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9F28DB56;
	Tue, 18 Nov 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpXpTggl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BCE1FD4;
	Tue, 18 Nov 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505389; cv=none; b=f+ktDppeYg3Q+6Kqb4KLEPGbV3FaM6IG+P0TmXi2tNgLEKJ7FHXbByB2DgAt8QuXGE+hwkoEt0vLU4H9Pv9L+WVEcK3lyNGIEMNOK9Zlw/bSUWop7nnlLa1ZM5gJeIcvAUaixf0e3kOeRhL/npN9v2fD5QJGibtmbWc4EFQtPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505389; c=relaxed/simple;
	bh=4d7MX1whtq6+TcTCFIYoNmUkaDKM3v7BcC/5WjB9lr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOZkGZc/PwqU/IHWXW/ObMqQrOQr9yIXSdsrlx+peOXkshbmzKbswSOO03r9/2L2yab+fLgmX/C9/XD4mRw7DC5CM1n0ofnZEviN6dlh6mV+bTho3SqOOlXX7S9zCWBHxd8jSMe0Cz3GyEDlaigPXK/AzuQb7dR9fATkXC+RkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpXpTggl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763505388; x=1795041388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4d7MX1whtq6+TcTCFIYoNmUkaDKM3v7BcC/5WjB9lr4=;
  b=TpXpTgglDx/qfDHTkhLNX3JC9kno16Qp7VenPBE/gkBzj+wczRUEbAAX
   udklC/8j9y/DAKJO5jAr0haUJB1mZp8DMLH6NybQ8uYRcfqWS2KygejWG
   xPvN5gfeyZgdW57mM8sRxx46lkCPxi/oqcjsYM7fnvAixCL6X8zo7fn47
   z3A/sbQlavbkHqBz4QvNWYRz+l88bVn6adhTSoc6hhy3kQX6CfqiFl/Nu
   LGrwP71mJ2++rikJWzpr7aWWxhroupad7EpXxNugTa40PqMCe60979tL6
   OBY3ahdMO/usIt6NwjV+DHk2gVbR/PEuPG9jS2uvv6U7lv9ZL+F/PSA59
   Q==;
X-CSE-ConnectionGUID: dQXHhrtcTmqWUcnSvbYQJw==
X-CSE-MsgGUID: XA2ee8tqQ6a5+8N69HgZpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69392577"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69392577"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 14:36:27 -0800
X-CSE-ConnectionGUID: kXsO1TCVQMSFe7vhePqajg==
X-CSE-MsgGUID: gROB/VIdQ3uuB7O4Kl5fUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195810857"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2025 14:36:25 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: corbet@lwn.net,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] docs: driver-api/thermal/intel_dptf: Add new workload type hint
Date: Tue, 18 Nov 2025 14:36:19 -0800
Message-ID: <20251118223620.554798-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for longer term classification of workload type for
power or performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../driver-api/thermal/intel_dptf.rst         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index c51ac793dc06..916bf0f36a03 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -409,3 +409,26 @@ based on the processor generation.
 		Limit 1 from being exhausted.
 
 	4 – Unknown: Can't classify.
+
+	On processors starting from Panther Lake additional hints are provided.
+	The hardware analyzes workload residencies over an extended period to
+	determine whether the workload classification tends toward idle/battery
+	life states or sustained/performance states. Based on this long-term
+	analysis, it classifies:
+
+	Power Classification: If the workload exhibits more idle or battery life
+	residencies, it is classified as "power".
+
+	Performance Classification: If the workload exhibits more sustained or
+	performance residencies, it is classified as "performance".
+
+	This approach enables applications to ignore short-term workload
+	fluctuations and instead respond to longer-term power vs. performance
+	trends.
+
+	Residency thresholds for this classification are CPU generation-specific.
+	Classification is reported via bit 4 of the workload_type_index:
+
+	Bit 4 = 1: Power classification
+
+	Bit 4 = 0: Performance classification
-- 
2.51.0



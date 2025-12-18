Return-Path: <linux-pm+bounces-39685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE7CCDD22
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 294C1304E16E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F110330B26;
	Thu, 18 Dec 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAXnf4fZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305C330B28;
	Thu, 18 Dec 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096769; cv=none; b=FBjG54XEPH7jf2u9CBXszzlno8cL7zbcf53hUv6KpIhPZE3pj85QGjvKpS0lxt4HVN8JctLNrP6oGjiV4KZ/WeSbfYWjhvkFGNEAYIuv/C0rK9RU4NfzmIbQu0VOF28L8sRlvW48+OTFQRdkpKJapgHuB0qPtLY8mcj/J/wAEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096769; c=relaxed/simple;
	bh=4LtYpCyVDKzWmXT2Tf1Gc4V2QKmYERRi5BXHQj+fbeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdLzgmyIk5mlYBqj9CDPQbHo5Z90qyD92RmsxXzAU56COZSyE9hs7Uq6702avMvnWxgQCyEmX2rG2fdQVfhvhTCHkymCWH5MD2VBldzyn8Wl7E0EMOAX3gI2Xk7kV3auz2a2uXv1ik4Axv/t8GPIwTTAZBClU1B7rwpHL0uSQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAXnf4fZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766096767; x=1797632767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4LtYpCyVDKzWmXT2Tf1Gc4V2QKmYERRi5BXHQj+fbeg=;
  b=iAXnf4fZ6c1oelIFSjB4e65eg9WJfainwiruAD1/2f30YVXBr7Wf4khV
   oTfq7xGK5Cqtbavh3M1DHGLHeie+f4Sk1k8pCTrhyAkX6sfyXoBtZy64n
   IPGgtByBCKcuJuoXnyGvbXlcmm8BctP6KnMkTNNEpm/vmBzS7nF2sVFcQ
   4R38KgSTr36n/JGnaSYndJxOAgwe32VtqMG3accwZMRzye0RfWJIQyB9T
   xo4DMToi3UBhy6lahed1uQ/iRuHyfk7vsbesO8KH1hDcyaiKyKfboF5wg
   WN9L+e3pXEW6cDDBSqutPbhodMu3bi2TCsWRaiCm/YE+s0mNFPYbnhp0s
   A==;
X-CSE-ConnectionGUID: yIEfC8knQ1uZNVxzLGbCDQ==
X-CSE-MsgGUID: ggOXqNaMRIyzzDqiO2QcTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79519089"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="79519089"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:26:06 -0800
X-CSE-ConnectionGUID: 6ochN985T1yap94RDgDVlA==
X-CSE-MsgGUID: j7Eh5p78QHCibmyVo1Dtyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="197851496"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa006.jf.intel.com with ESMTP; 18 Dec 2025 14:26:06 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] thermal: int340x: Enable slow workload type hints
Date: Thu, 18 Dec 2025 14:25:57 -0800
Message-ID: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add attribute to enable slow workload type hints.

Srinivas Pandruvada (2):
  thermal: int340x: processor_thermal: Enable slow workload type hints
  thermal: intel: selftests: workload_hint: Support slow workload hints

 .../driver-api/thermal/intel_dptf.rst         |  3 +
 .../processor_thermal_wt_hint.c               | 61 +++++++++++++--
 .../intel/workload_hint/workload_hint_test.c  | 74 +++++++++++++------
 3 files changed, 108 insertions(+), 30 deletions(-)

-- 
2.51.0



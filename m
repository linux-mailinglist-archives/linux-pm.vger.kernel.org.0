Return-Path: <linux-pm+bounces-13088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84EC9634C7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D82286D4E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B71AED52;
	Wed, 28 Aug 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhSxQBhd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291561AE847;
	Wed, 28 Aug 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884182; cv=none; b=c02wSRuEP8xR3AhkuUxy6GeyAqB7fRL7yjqjAOzo2WXilwlhGZReghRnp79xlcykhepBS/IO6+9Fgmf7IxD6VRIuY5rQ22+Qmji0jiAuI8jNviRJZWvwPquXaurpo0q0XIB3ozbCRfXDSj7r3d1aQiHyq47Veo+LeHTyJ8SGZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884182; c=relaxed/simple;
	bh=mwQ+bjyJKxWu0yhXwQ0J+xkAjkHvBD1Evep4EVrAUlI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKsLBZTZbJXYKPv8v3hBw/u8raRG/Wi6qMbXBJAki7HeOmPFTN1EsFLMEsgRzidvdkU5jruJBAfTx7tk15pxePJPVrkGLrQSI2cbxqBXq8Psu6GCkH3u0vxgfcZRDegUCf7Q2cUs5RpyLoQ05xhFswV/YY9aWHWGhurecRXYqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhSxQBhd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884181; x=1756420181;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mwQ+bjyJKxWu0yhXwQ0J+xkAjkHvBD1Evep4EVrAUlI=;
  b=FhSxQBhdHPToHMhsRRP3w10m9g6cHTZUW14wTtcWC8mDQgCe0hzpLxH1
   26SHU+Ltmqjv51krqvnlTGCQBe5PNbWLVPcS/e6YS+BYruzwO8MLAQjI9
   8b3uzM/YrKxvxga5Z0TSMyEdab344OackCvIHmTNeaBeIc4Vy4Rw22Cg0
   i/t6ci3Pkp+eTjmGg49XnfUckozz+PlQ06Al7wRNo/g2+cT4McSWZxWj+
   z9hJoLfdq+COfLh6NxablE8QORuZegSzbJ8X7ByIv3kezuKtBjkHdgaES
   TPr30aBxHxhB2Op0eQvzpLeVfPorJPOtK47yNRmWzDjnXowisUUkzj/0f
   A==;
X-CSE-ConnectionGUID: b19JEi1fTm+yQ2YTzNu9Uw==
X-CSE-MsgGUID: w2yJUOEmT8ycCwti9WJLaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406481"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406481"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:40 -0700
X-CSE-ConnectionGUID: YB4adtKmSTe0G8UNvqh4Mw==
X-CSE-MsgGUID: /R/ckrm4Sz+toBDYvwx1qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271811"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:40 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 07/11] platform/x86:intel/pmc: Check return value of ioremap
Date: Wed, 28 Aug 2024 15:29:22 -0700
Message-ID: <20240828222932.1279508-8-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of ioremap operation and return ENOMEM when
the operation fails for better error handling.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 73c727042ca6..f625d39d1aa3 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -84,6 +84,9 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
 	ssram_base = ssram_pcidev->resource[0].start;
 	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
 
+	if (!tmp_ssram)
+		return -ENOMEM;
+
 	if (pmc_idx != PMC_IDX_MAIN) {
 		/*
 		 * The secondary PMC BARS (which are behind hidden PCI devices)
-- 
2.43.0



Return-Path: <linux-pm+bounces-21355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75965A28012
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E622A3A108D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD75CA52;
	Wed,  5 Feb 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dp21a4+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915F80B;
	Wed,  5 Feb 2025 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714569; cv=none; b=mK1PfBQNFde3uTMxknomYY1QB7/BFGh00sAqtBvMZYq/+G8XlHF+jebTVIM7rzdmblPgNT8ychtnjofIRweBXCBTAb5mU2JFFAZcEZaMifaWycZ7MERqQGpcBjWe02tqdm3urpEFMEg1YL7AW6D+brefO6RS9uZOuLE/W7LRGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714569; c=relaxed/simple;
	bh=yNjKm0ryVmsmgF8cOHIgjNV/kYzW222nLIGfjCHjwdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUcvZLqPv9ja2Jy+0cU8yrxiqigzH2B4lfoOBga7kokAYDXkIsHYWgBfnfWdHqFs8vtGjYDq0g8FNUqvrpHqf7y8H833bCzpnHSRThWLbjlc8LyNwx9OvKWn0J61vRTwuz7xSc24LFgJsGaKemgpmld4TWU71BPgYnwo2RwvBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dp21a4+C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738714569; x=1770250569;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yNjKm0ryVmsmgF8cOHIgjNV/kYzW222nLIGfjCHjwdM=;
  b=Dp21a4+CUU/15c0KfH1qVEb+fppEYBHZLMsgggzqcaJpaq83PM6/oP1v
   /4+p9+5LEwzqEzpVGdYehBukdOJE8pfRHSKHt6j2dHl+bYFArvZDD7xOt
   gdrLO84yVEphL0HaU2lQ3Ze2shkhLL6U9WnXNlDQIFd2RqmFp/1MaaBnG
   jqYFTomnBtSO86OCRW12Wcy6dQJNGa6JSUGZ+cFPu8P5bkoiefxzptIiQ
   AxAWpKoHqriJF5N59PbQaa1Nrt+MygYdfMD7TNIlUqsbQoQ5y1D9SUvNK
   QpZIu3U1kLjw9Zjd9wXxpQas7eGK9ZlvFDs95K5aMzR3IaWJRzjbrQQKO
   Q==;
X-CSE-ConnectionGUID: GdhYuItXSgKC3DVkMtCwuw==
X-CSE-MsgGUID: 5Dbxx1TGT6ah+1nxuai8Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39372359"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39372359"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:07 -0800
X-CSE-ConnectionGUID: 3KDu1Ax5SfaLzJVqDKES4w==
X-CSE-MsgGUID: AbqRtbfMSIOR/99t/hh4xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110635682"
Received: from tfalcon-desk.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.214])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:05 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 2/5] platform/x86/intel/pmc: Remove duplicate enum
Date: Tue,  4 Feb 2025 16:15:54 -0800
Message-ID: <20250205001601.689782-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205001601.689782-1-xi.pardee@linux.intel.com>
References: <20250205001601.689782-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate enum PMC_IDX_SOC. PMC_IDX_SOC has the same value
as PMC_IDX_MAIN. Replace it with PMC_IDX_MAIN to avoid confusion.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 1 -
 drivers/platform/x86/intel/pmc/lnl.c  | 2 +-
 drivers/platform/x86/intel/pmc/mtl.c  | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 05dec4f5019f3..ad976cc83ecae 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -693,7 +693,7 @@ static int arl_resume(struct pmc_dev *pmcdev)
 
 int arl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 	int func = 0;
 	bool ssram_init = true;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a1886d8e1ef3e..a0f6cc427ddca 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -430,7 +430,6 @@ struct pmc_dev {
 
 enum pmc_index {
 	PMC_IDX_MAIN,
-	PMC_IDX_SOC = PMC_IDX_MAIN,
 	PMC_IDX_IOE,
 	PMC_IDX_PCH,
 	PMC_IDX_MAX
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index be029f12cdf40..09b13df90d685 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -553,7 +553,7 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
 	int ret;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 
 	lnl_d3_fixup();
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 02949fed76e91..07687a3e436d5 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -992,7 +992,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 	int func = 2;
 	bool ssram_init = true;
-- 
2.43.0



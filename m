Return-Path: <linux-pm+bounces-25042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE4A83020
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920A81B66719
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0754627C851;
	Wed,  9 Apr 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5E78Dlp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F527BF6D;
	Wed,  9 Apr 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225867; cv=none; b=QgELJ+iA6VtLDRA3NpHO+o9MoXyF6n5miIYNHLY+IdlnPaO9qXEYyZQ9+Bt+kqCmkZFV8APzk/Hz42jvl1dT/37qvAOvIqVuATG8R2xm3ENBAGllphcbNvg9Abr1pK+2bejWUb4D/C8L0R4xhlO3fGCOGJjIFOtUz6wtQIqowk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225867; c=relaxed/simple;
	bh=AT2vgmWyIWLdGzF2njAXl8bh/qs7YhQFypNLOfWhyBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYHFETJVjh+WJDQchPEAZIlTOQa6maUIbwqfYOFJuMez1sVrngXOdjjo3dehKaxuRyOu/VYmX9Smzz8KkmwdRfVKOuZpW9sm4GPXX1+scawfzblJQxa63ukLRgGJy1Oz9LE7hZEnYfZeEfaYXliGpJcOBtJ7c2XbyGAW7yO0dVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5E78Dlp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225866; x=1775761866;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=AT2vgmWyIWLdGzF2njAXl8bh/qs7YhQFypNLOfWhyBY=;
  b=D5E78Dlpfh8bkCz+OgX/AuFg/1fjdbU5bOOXLyQxnQQJnXp+TmMJvb+M
   HmwRYZ+MPTF1f/jfFg7woTflWQ9h/NA2sCxS26W9Uwrtoc0NBfRwzQQxf
   jm9FiqaAW8m/vKz0+bB4rTQn/U/CKlRWeiPm9QP+KfhTuhHaJG1UKzAN9
   508Q6dIivhYGXG7zpfEzBy+rFoExKIdeJxCGMB3RhlvvGSQbFhbKJuiUG
   QV8WG6xSu9nribch9enior3QkNKHxeZzQ7nr5x/eHLBhNpuxrtd2Ysdd0
   3qYktxg+LctW/AhmISx/ktq91GS5uDbG/jBofaE3mUgjMEi9sXtXRViLe
   w==;
X-CSE-ConnectionGUID: 2H6lHVL8QdWHw5SyHEz/0g==
X-CSE-MsgGUID: 2JqdKQ9CTHOqOxiSZJgfsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386782"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386782"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:03 -0700
X-CSE-ConnectionGUID: JVaO46B7QS6BkoQP6AZdIw==
X-CSE-MsgGUID: h3lszR/6TImibLIIxmWQwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401277"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:02 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 6/8] platform/x86:intel/pmc: Remove unneeded io operations
Date: Wed,  9 Apr 2025 12:10:48 -0700
Message-ID: <20250409191056.15434-7-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove ioremap and iounmap operations that are not needed. ioremap
and iounmap operations are handled by the caller of the pmc_add_pmt
function.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 10ead4398a68..7b8443092b20 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -36,13 +36,7 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 	u32 dvsec_offset;
 	u32 table, hdr;
 
-	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-	if (!ssram)
-		return;
-
 	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
-	iounmap(ssram);
-
 	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
 	if (!dvsec)
 		return;
-- 
2.43.0



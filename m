Return-Path: <linux-pm+bounces-9403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EE90C293
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 05:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE7D1F23B40
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B319B5B8;
	Tue, 18 Jun 2024 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFGFHc/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563594EB37;
	Tue, 18 Jun 2024 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682690; cv=none; b=Wn9AHi2FpJk/Wqsp+Ma6rFiVKaRZdelB224RIebA7rqf6jcvhWasR+ixvoC4V5VsvtWNvx7GY1nukZL77OPxFZFlVavSKQ+S1k5XPEGSJ4Ql7x4S8O9akpoR23cvVhqGW+jVhbAfiwvI7xSTlV1VUp0w1US8s0eJ5ucd+p5wTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682690; c=relaxed/simple;
	bh=3tTbkVgdJaRODlProAcTfPKU/QGbmkxNQAPgShfrGEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koIHGOalyaZqfrZuREIzDmsFsOXDPARzQIo4PuhK1S7DtjNKvdNqJZlvGKbJfcNnAbCusfw2v0OplFLkc66AXrskkAoisNls5Hgv/nnirFWrl0TlH05kXnJ3GpFowXHmPQgfa2+FdEZWSYj5iVwMQiEfCXgBRfijmVXDtGxftOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFGFHc/t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718682688; x=1750218688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tTbkVgdJaRODlProAcTfPKU/QGbmkxNQAPgShfrGEE=;
  b=SFGFHc/ta3lmv4VkAzqjxUpRT7xRQf51m7ueB/rKEoQrt3Oq4ZxlUH44
   2ewKsg5SETAkau+ajXvdp795C9JXJ9/3/UCS66sBisaY4U4cDeCWOyxgb
   zeL0eQhl2aXLAMU48ye9ZWDi4GxWivIQ1tTlV+UAlup/B9W5YDnLy5ux+
   2VjWPHSVz6IasAVAQMJIgs22sPCZT40XW1Czpf8c/4RreDmV9zlzt4wJM
   m/SsmX4jq+g/XivQ1LWJEqqQ+APqeLE/nxjbn3dpNq61d5Q22pW7Mo36w
   LOzRqSa3FzTq+4DminetqSr6cI7fnihUF4GvDENa+yOKaDbQ+w24ZV0Oz
   Q==;
X-CSE-ConnectionGUID: XTVkQtIMR1uvqD1gnhwQLw==
X-CSE-MsgGUID: uGL3B47SQ56Tu9jy3tMKGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="18449838"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="18449838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 20:51:24 -0700
X-CSE-ConnectionGUID: 4bkENZLMT7WlFqRj6k++iw==
X-CSE-MsgGUID: SKhoJPOqS9y+C2Fw1HYbUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41522552"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa009.jf.intel.com with ESMTP; 17 Jun 2024 20:51:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] x86/cpufeatures: Add HWP highest perf change feature flag
Date: Mon, 17 Jun 2024 20:51:20 -0700
Message-ID: <20240618035122.438822-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
References: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CPUID[6].EAX[15] is set to 1, this CPU supports notification for
HWP (Hardware P-states) highest performance change.

Add a feature flag to check if the CPU supports HWP highest performance
change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..4674ba5310b2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -361,6 +361,7 @@
 #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
 #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
+#define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */
 #define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
-- 
2.44.0



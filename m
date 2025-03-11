Return-Path: <linux-pm+bounces-23850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A33A5C464
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411DE1899FC5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E725DD02;
	Tue, 11 Mar 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6JS0tpJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07E25DB0B;
	Tue, 11 Mar 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705329; cv=none; b=QjMLrBjqkRd+kfe2GDPcn/0/PBaX49uV+vP0y285vah9F9PYmY6xPgN5kqKE787xZ5nyzRwb6DITPiIo7abJT2TN1SKDiYMGcWelHw8H8qHSyeXskw/wdqAwlejmD5fA9Yrt+8snhUz/Fr5pUgFnY0WIpMJon1S8qpv8PdxG6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705329; c=relaxed/simple;
	bh=Gw274Q7YoUgbXnVwSweOM2+zHmkdsP+cM3iaEd6DPjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWvnBC52q5AFJ456YoupLl8nYqhzejs6d8LXOuKSfB4MxAec+LsldaZ11fvBFflVV5SFoX3bz6A8OwFqrsxTDrVOjIWbB3/SrW94fmr/l2iKExj4fOcBIWF1nQn4uD2znZLKmN6NjtEWGDhpGqhgqf9wpIJLPL0TB0R6CjBgw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6JS0tpJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705327; x=1773241327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gw274Q7YoUgbXnVwSweOM2+zHmkdsP+cM3iaEd6DPjA=;
  b=F6JS0tpJFVE2G6eYpmfZrEiwivfylX7viJBPztQz+9lqraWndgaUKKh1
   tsa7uXMUsKO6cTtSDVvHruYO/z1xjehFXrdincenOwHYjhV9hRqrdLEib
   b9fGHYeqvkHvDZfinXp/MXGaplnFNDYlaMNNdmcf5D0ek125NzJNkEKsu
   5YHTpEbTVQf6EHs+WGrC6mOXZROFbkEeJje80YldigDqN01MSuSASHDTt
   z20gkSDyscC6J8zU9ogG+f2GPkdWWHjUf9WxlELynML0rXu/EkUm+7trM
   3lmHvJ54gws/rfIp9ZFczMcynUDKE2CXfhhynsfEKocJ5VsbElxdt0vsK
   g==;
X-CSE-ConnectionGUID: oCMSsQS+QROpiWht8Awmig==
X-CSE-MsgGUID: HNNgdYKWQFG3gOSDF89Wtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41917407"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="41917407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:06 -0700
X-CSE-ConnectionGUID: 98SD0B52SBGEi+F7wBrf4g==
X-CSE-MsgGUID: jxdD4NWJR2GWsAT06arfBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125388467"
Received: from ghakimel-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.184])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:05 -0700
Date: Tue, 11 Mar 2025 08:02:05 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v8 1/5] x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()
Message-ID: <20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20250311-add-cpu-type-v8-0-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-add-cpu-type-v8-0-e8514dcaaff2@linux.intel.com>

The comments needs to reflect an implementation change.

No functional change.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index ba32e0f44cba..9ebc263832ff 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -209,9 +209,11 @@
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
- * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
+ * X86_MATCH_VFM_STEPS - Match encoded vendor/family/model and steppings
+ *			 range.
  * @vfm:	Encoded 8-bits each for vendor, family, model
- * @steppings:	Bitmask of steppings to match
+ * @min_step:	Lowest stepping number to match
+ * @max_step:	Highest stepping number to match
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.

-- 
2.34.1




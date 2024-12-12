Return-Path: <linux-pm+bounces-19094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A719EDFAE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F223D168E6A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C961205E0F;
	Thu, 12 Dec 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksjFBKEY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A99205ADB;
	Thu, 12 Dec 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986675; cv=none; b=NWIHv9TxHKh1SZtGYVSQX1kU2yx6Bw8iqMHOO8PnAc0CS1iZ3lDY3Y683K7bO9G6wqRLZUrXL2ddMfsXNqb9L0EfVJF0Z90++Xhhfo4jl6VTp2drDCiGQWOMisf9kcu8lZzbG5lQOo7YulykGkqXGLD59BifjegQGgdt8LO9YfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986675; c=relaxed/simple;
	bh=L8x6s19dFRr4bXJXyW+6h1Gqfby5uQmxBh/Ho0pWOJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+QCW+Shrl3oawmJHOJOCnufCvmz630tsC1e2rPWF8kB8s018tJ9kFzME6b+sxJMLl6URSsspsAZcOWsDEncm+X3+l8odt1tEs0c36jul0VneIYSaZRWh0QDRkafcfTWUIy3+3YcMs8bwLcBLsTPlIMn3uOO6sbLhm2JQc7+UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksjFBKEY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986674; x=1765522674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8x6s19dFRr4bXJXyW+6h1Gqfby5uQmxBh/Ho0pWOJk=;
  b=ksjFBKEYJ48HsyztWYfXsrRhi7X91sEeQrGMDvbT21TCVMjZmlmgPJIt
   0MzPc96lxhkPLOS209mq7+j8nPGR7i7klu6caWukl/BqMOOyt5823dRaA
   y7sxyXiKEVn0f00iuZkyT6JpnyaF1SImiLwjU1J93bbSBBxk9WODDeF9Z
   fFWKjkOfiroWccQEqLDjdqN87BXxs+gZnDSKQF74ZHgHkXCa8gXTryGJD
   nFKld+dfMzYSmpfbpx0E8u31kAh/hK2t3ZXDlrZ+tKBrYjC+5EQSA6IDl
   cdQZOykSr6sEJI285P+HXBwGV0o/oYj6ekeDrAudcgkWYCvlkx9bYvp1d
   w==;
X-CSE-ConnectionGUID: h3GHG+3HST2VfZCkbrY2/w==
X-CSE-MsgGUID: rQjZszWYSqqJ0ZqMe2dIbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34533464"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34533464"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:54 -0800
X-CSE-ConnectionGUID: uWIDYJwiQx+6Cy0FIETfqQ==
X-CSE-MsgGUID: M/yDwRLCT/q3EJYq2Lp6Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96223552"
Received: from unknown (HELO desk) ([10.125.145.3])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:53 -0800
Date: Wed, 11 Dec 2024 22:57:52 -0800
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
Subject: [PATCH v5 6/9] x86/cpu: Add cpu_type to struct x86_cpu_id
Message-ID: <20241211-add-cpu-type-v5-6-2ae010f50370@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>

In addition to matching vendor/family/model/feature, for hybrid variants it
is required to also match cpu-type also. For example some CPU
vulnerabilities like RFDS only affects a specific cpu-type.

To be able to also match CPUs based on their type, add a new field cpu_type
to struct x86_cpu_id which is used by the CPU-matching tables. Introduce
X86_CPU_TYPE_ANY for the cases that don't care about the cpu-type.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 33 +++++++++++++++++++++++----------
 include/linux/mod_devicetable.h      |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index dee45332b682..f50377a32cb6 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -75,13 +75,14 @@
  * into another macro at the usage site for good reasons, then please
  * start this local macro with X86_MATCH to allow easy grepping.
  */
-#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _data) { \
+#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _cpu_type, _data) { \
 	.vendor		= _vendor,					\
 	.family		= _family,					\
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
 	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
+	.cpu_type	= _cpu_type,					\
 	.driver_data	= (unsigned long) _data				\
 }
 
@@ -98,7 +99,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data)	\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,		\
-		      feature, data)
+		      feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
@@ -112,7 +113,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)		\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FEATURE - Macro for matching vendor and CPU feature
@@ -125,7 +126,7 @@
  */
 #define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)				\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, X86_FAMILY_ANY, X86_MODEL_ANY,	\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_FEATURE - Macro for matching a CPU feature
@@ -136,7 +137,7 @@
  */
 #define X86_MATCH_FEATURE(feature, data)					\
 	X86_MATCH_CPU(X86_VENDOR_ANY, X86_FAMILY_ANY, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
@@ -150,7 +151,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)			\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,	\
-		      X86_FEATURE_ANY, data)
+		      X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM - Match vendor and family
@@ -163,7 +164,7 @@
  */
 #define X86_MATCH_VENDOR_FAM(vendor, family, data)				\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -174,7 +175,7 @@
  */
 #define X86_MATCH_VFM(vfm, data)						\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm),	VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
@@ -186,7 +187,7 @@
  */
 #define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)				\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      steppings, X86_FEATURE_ANY, data)
+		      steppings, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -198,7 +199,19 @@
  */
 #define X86_MATCH_VFM_FEATURE(vfm, feature, data)				\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_CPU_TYPE - Match encoded vendor/family/model/cpu-type
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @cpu_type:	CPU type e.g. P-core, E-core on Intel
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ */
+#define X86_MATCH_VFM_CPU_TYPE(vfm, cpu_type, data)			\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),	\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, cpu_type, data)
 
 /*
  * Match specific microcode revisions.
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4338b1b4ac44..b8a2e88f966f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -692,6 +692,7 @@ struct x86_cpu_id {
 	__u16 feature;	/* bit index */
 	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
 	__u16 flags;
+	__u8  cpu_type;
 	kernel_ulong_t driver_data;
 };
 
@@ -701,6 +702,7 @@ struct x86_cpu_id {
 #define X86_MODEL_ANY  0
 #define X86_STEPPING_ANY 0
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
+#define X86_CPU_TYPE_ANY 0
 
 /*
  * Generic table type for matching CPU features.

-- 
2.34.1




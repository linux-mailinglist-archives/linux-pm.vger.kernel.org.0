Return-Path: <linux-pm+bounces-12294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41C95406A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F8E288CA4
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598F1448E8;
	Fri, 16 Aug 2024 04:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp4I4/Q0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1379B7E;
	Fri, 16 Aug 2024 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781209; cv=none; b=UFnxgkzHAdRnrP1BPQydNx9/itI7HOQWGFXfI1TyDItCYsMG8y5fsY1rUjLF46M/2869M1XwqI830NjU/Uzy3XMRhRQ8bDsilUlE/uEXgeJoDi9JYednkbWHQ1XpoPN/YsKPs1FFTWK88GQv+SIBh7Q/luEwaWmO2sf+cQQw1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781209; c=relaxed/simple;
	bh=aVEkr1V4UzKWN35PXkpxzpfEFpiWzISpXGqN8Ebf6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiFO0gSSm8UE8m4Yd8w0poODxKEaLGgBv4q97ugmboD/5HzaYWzx6TjwWkFJhcIuzifQBbFZG4mkG1dzYd6BEl/MPkuWEdoCBcH4+EW9sd73TtXsjuMrGU75jRRSJ5tcqXqBXeTWhGhDYYk+KzCl7tJBM0D4T1yn6maP9trISLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp4I4/Q0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781207; x=1755317207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aVEkr1V4UzKWN35PXkpxzpfEFpiWzISpXGqN8Ebf6ZA=;
  b=hp4I4/Q0MwkJUUouw5u9AwrmGeiCH6tnhJ/5nDvyewQqoWmLMZ74p1r9
   /LF/h5RFDjItBBpI+wQZI6vfAJiozLACxt5s2ZUFyTRmL8pXlruWIJvEi
   39BySkts4JJus1zmmEAERl7UEWK8k8401FbVrmK3TWEXrN1SBg366f8cF
   LI8sm7LmKmdZQMhRjJt9jm0SpjIbcj2exyeZe4kwJQRVlf4d2zfFmS88T
   IrwoqWuH7i7ph/s+CVPmFdbXX9wyf8ztb/x7ND2h4hZ1ujdnt0qzTAKSl
   dYXXoPVtvUCanKxnkf0NUQMDnxcRbUyaprDHhG+RdZcXeEwC/4rXwSEoN
   A==;
X-CSE-ConnectionGUID: CBRu9kJVS/SuEbVAl8bmNA==
X-CSE-MsgGUID: ovbBKkfmRMCy2efBjt/wzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25826226"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="25826226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:47 -0700
X-CSE-ConnectionGUID: hbUKCQiISYWenZhnCsE4dw==
X-CSE-MsgGUID: mW39zOtzQPSR3SBiVuj8Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59571845"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:46 -0700
Date: Thu, 15 Aug 2024 21:06:45 -0700
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
Subject: [PATCH v3 06/10] x86/cpu: Name CPU matching macro more generically
 (and shorten)
Message-ID: <20240815-add-cpu-type-v3-6-234162352057@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>

To add cpu-type to the existing CPU matching infrastructure, the base macro
X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE need to append _CPU_TYPE. This
makes an already long name longer, and somewhat incomprehensible.

To avoid this, rename the base macro to X86_MATCH_CPU. The macro name
doesn't need to explicitly tell everything that it matches. The arguments
to the macro already hints what it matches.

For consistency, use this base macro to define X86_MATCH_VFM and friends.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 104 +++++++++++------------------------
 1 file changed, 31 insertions(+), 73 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 3831f612e89c..4bdf4baefbc0 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -58,7 +58,7 @@
 
 #define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
- * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
+ * X86_MATCH_CPU -  Base macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
  *		The name is expanded to X86_VENDOR_@_vendor
  * @_family:	The family number or X86_FAMILY_ANY
@@ -75,19 +75,7 @@
  * into another macro at the usage site for good reasons, then please
  * start this local macro with X86_MATCH to allow easy grepping.
  */
-#define X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
-						    _steppings, _feature, _data) { \
-	.vendor		= X86_VENDOR_##_vendor,				\
-	.family		= _family,					\
-	.model		= _model,					\
-	.steppings	= _steppings,					\
-	.feature	= _feature,					\
-	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
-	.driver_data	= (unsigned long) _data				\
-}
-
-#define X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
-						    _steppings, _feature, _data) { \
+#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _data) { \
 	.vendor		= _vendor,					\
 	.family		= _family,					\
 	.model		= _model,					\
@@ -107,13 +95,10 @@
  * @_data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
-	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
-						X86_STEPPING_ANY, feature, data)
+#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data)	\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,		\
+		      feature, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
@@ -124,13 +109,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)	\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family,		\
-					   X86_MODEL_ANY, feature, data)
+#define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)		\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
+		      X86_STEPPING_ANY, feature, data)
 
 /**
  * X86_MATCH_VENDOR_FEATURE - Macro for matching vendor and CPU feature
@@ -140,12 +122,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)			\
-	X86_MATCH_VENDOR_FAM_FEATURE(vendor, X86_FAMILY_ANY, feature, data)
+#define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)				\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, X86_FAMILY_ANY, X86_MODEL_ANY,	\
+		      X86_STEPPING_ANY, feature, data)
 
 /**
  * X86_MATCH_FEATURE - Macro for matching a CPU feature
@@ -153,12 +133,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_FEATURE(feature, data)				\
-	X86_MATCH_VENDOR_FEATURE(ANY, feature, data)
+#define X86_MATCH_FEATURE(feature, data)					\
+	X86_MATCH_CPU(X86_VENDOR_ANY, X86_FAMILY_ANY, X86_MODEL_ANY,		\
+		      X86_STEPPING_ANY, feature, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
@@ -169,13 +147,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)		\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,	\
-					   X86_FEATURE_ANY, data)
+#define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)			\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,	\
+		      X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM - Match vendor and family
@@ -185,12 +160,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments to X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set of wildcards.
  */
-#define X86_MATCH_VENDOR_FAM(vendor, family, data)			\
-	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, X86_MODEL_ANY, data)
+#define X86_MATCH_VENDOR_FAM(vendor, family, data)				\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_INTEL_FAM6_MODEL - Match vendor INTEL, family 6 and model
@@ -209,8 +182,8 @@
 	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
 
 #define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
-	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-						     steppings, X86_FEATURE_ANY, data)
+	X86_MATCH_CPU(X86_VENDOR_INTEL, 6, INTEL_FAM6_##model,		\
+		      steppings, X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -218,15 +191,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * Stepping and feature are set to wildcards
  */
-#define X86_MATCH_VFM(vfm, data)			\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM(vfm, data)						\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm),	VFM_MODEL(vfm),		\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
@@ -235,15 +203,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * feature is set to wildcard
  */
-#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		steppings, X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)				\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
+		      steppings, X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -252,15 +215,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * Steppings is set to wildcard
  */
-#define X86_MATCH_VFM_FEATURE(vfm, feature, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		X86_STEPPING_ANY, feature, data)
+#define X86_MATCH_VFM_FEATURE(vfm, feature, data)				\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
+		      X86_STEPPING_ANY, feature, data)
 
 /*
  * Match specific microcode revisions.

-- 
2.34.1




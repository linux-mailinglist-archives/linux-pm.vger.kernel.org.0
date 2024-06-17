Return-Path: <linux-pm+bounces-9304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3690A93E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E828A397
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6B194A53;
	Mon, 17 Jun 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHDdkrX6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A063194A4B;
	Mon, 17 Jun 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615518; cv=none; b=j+8KbSjtPEvqNd2y2B7iBlaLic/rzI05Zu3+cW71VQjFUOQgJ+nyRH4ASfAY0Axk4F7k0ydW+yVBsviG7/lEmdCR3QJCeZXCWqdmRFgfRHjY36/pCRfN2lzH/0GxcqPbhfim31PewilytcUj5Tcz4npXdaNCYXi0GLQApiSVygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615518; c=relaxed/simple;
	bh=dICdfkf46oAmgYjY31aLjuAhyvRDFoVGYY5rQoiN7wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsjWpvfC6+StSLpse8FgZkB+PXnCqa4F5Ou4o+qYca6sR/2Bf3HTt/OsvTMbBxSDxge9FR5PO4s/woy6GoLq+BuorA2HjFdmQ20WOpz1fe8IHlm2wpnSleCGdxou1V3MUTKp4uiYHaMzbmo2db47jdCwusrTWideGk2lxGOnvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHDdkrX6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615517; x=1750151517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dICdfkf46oAmgYjY31aLjuAhyvRDFoVGYY5rQoiN7wQ=;
  b=cHDdkrX6zs3AalPr3v+LmjVIjEEsVolmrrDIt0bM8PovYmBLwexbFgaN
   8gvJgMMPup1653B0ttwL2mPYQbvPkMYt0kVcFGHX0myWSBnDmx7/rlf7Q
   TiBiP8WLp3J3Cf0BPV5+uh1wsaEsWtGGq/pwRDqD6DIWgB4bZMpQPaO15
   VVj50PBKhXllsNym6VHq+Cpa/CxsWNSon/DngbUVpqG2vSuZPMudOIUU+
   pke9lJiDHQJww9Y2SKeAceeqFNj0RKZ7dl18e6KrL7mLHag4Lljq8kTzk
   jVze9aRW43RzTTzIBmdWSNH8GplZqSBvRDMmHZUe9CzI8pkqS4sK38leW
   Q==;
X-CSE-ConnectionGUID: 9xUKCrw+R5yi/4BPyGLC1g==
X-CSE-MsgGUID: IWp9RWK2TbuHhBTdSxeKDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19257243"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19257243"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:57 -0700
X-CSE-ConnectionGUID: XKNUOJymTeCfiFSxlteieQ==
X-CSE-MsgGUID: hvZvYviGQ82X+FYC3ePhxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41260378"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:57 -0700
Date: Mon, 17 Jun 2024 02:11:56 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH PATCH 6/9] x86/cpu: Add cpu_type to struct x86_cpu_id
Message-ID: <20240617-add-cpu-type-v1-6-b88998c01e76@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>

In addition to matching vendor/family/model/feature, for hybrid variants it
is required to also match cpu-type also. For example some CPU
vulnerabilities only affect a specific cpu-type. RFDS only affects Intel
Atom parts.

To be able to also match CPUs based on cpu-type add a new field cpu_type to
struct x86_cpu_id which is used by the CPU-matching tables. Introduce
X86_CPU_TYPE_ANY for the cases that don't care about the cpu-type.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 35 ++++++++++++++++++++++++-----------
 include/linux/mod_devicetable.h      |  2 ++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 6c8f4cf03cae..08c2efa6dfdf 100644
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
  * X86_MATCH_INTEL_FAM6_MODEL - Match vendor INTEL, family 6 and model
@@ -183,7 +184,7 @@
 
 #define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
 	X86_MATCH_CPU(X86_VENDOR_INTEL, 6, INTEL_FAM6_##model,		\
-		      steppings, X86_FEATURE_ANY, data)
+		      steppings, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -194,7 +195,7 @@
  */
 #define X86_MATCH_VFM(vfm, data)						\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm),	VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
@@ -206,7 +207,7 @@
  */
 #define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)				\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      steppings, X86_FEATURE_ANY, data)
+		      steppings, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -218,7 +219,19 @@
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




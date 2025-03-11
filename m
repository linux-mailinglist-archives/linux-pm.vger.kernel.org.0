Return-Path: <linux-pm+bounces-23852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F2A5C46B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9130178331
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1125E440;
	Tue, 11 Mar 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRsE992e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932125DAEF;
	Tue, 11 Mar 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705360; cv=none; b=Xb5Vjsw46eVKWkXITPcuqVLbhEU7HLXdx/4SeAUp1nSv2tJO7+i9uCXtECADq+oA0Vw8MAaVpEwa1+eo4OffpoT+FrApg3lYnqGzsmsAy07LQWjgNb0P4lZahxfhO+ZVtJTo0s72FSKlQkSsA48sAY6nXFqf72zmoQyMfXmXTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705360; c=relaxed/simple;
	bh=1xzgPaIVTKd3kJ0RH1k1vY+x5MN32kaFJxGhbP75sWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFO0zS+56V8fxJgKpveVXqWx+z5nYVCBqTGiP9ccIS8tK6hmT1UBy4UurOZVQl6w04Tkwp9T4Jxr9y9ZKDUmMAoqk9eCIL6oGEZHcSva/zMefLiCBSfP4jjLIffZqz9zttkI5wglmQYXWxYUlFfq9U4JKHPigfc65IQx1VanYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRsE992e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705359; x=1773241359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1xzgPaIVTKd3kJ0RH1k1vY+x5MN32kaFJxGhbP75sWM=;
  b=SRsE992erd4wmv7PquQjvH7XFzzCaQzc8D0YAhXnErgoS8GINJulxc4n
   W0OupvYNQQmJIny77snIQTVCakN2xnVcaYSlg/vLMwD5MokKGLdq2UMoC
   3TKz4dQOzmR0IipPt8x9N5fK8HGwLTrrlhmjm0Y8ky1H12eByaYb7sQNc
   dpXOAtAN9VmaD2e00H/Em28unWp4So1wInkcI37/VG+K1wt6uB1uBvcmS
   jCn/SsM/zK8D5rwAz9zm5E4EgTH4eeTAjmHkWxtA6ovaahu8DT+KARy6Z
   XEM1UNcjODDn3b46VgdEz4yga4HzrT4s4MXT72B1nQqbGXHfMtVS2avuo
   w==;
X-CSE-ConnectionGUID: fH+vdpUxRtOmprrrKukTpg==
X-CSE-MsgGUID: Kg7JEKEgSaSKMUaXlbC/RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53373347"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53373347"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:38 -0700
X-CSE-ConnectionGUID: 7kdbi+JXQf63S/tUDWCmuw==
X-CSE-MsgGUID: Lgre5NjZTVq9j6lB4/SAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="124958192"
Received: from ghakimel-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.184])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:37 -0700
Date: Tue, 11 Mar 2025 08:02:36 -0700
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
Subject: [PATCH v8 3/5] x86/cpu: Add cpu_type to struct x86_cpu_id
Message-ID: <20250311-add-cpu-type-v8-3-e8514dcaaff2@linux.intel.com>
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

In addition to matching vendor/family/model/feature, for hybrid variants it
is required to also match cpu-type also. For example some CPU
vulnerabilities like RFDS only affects a specific cpu-type.

To be able to also match CPUs based on their type, add a new field cpu_type
to struct x86_cpu_id which is used by the CPU-matching tables. Introduce
X86_CPU_TYPE_ANY for the cases that don't care about the cpu-type.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 32 +++++++++++++++++++++++---------
 include/linux/mod_devicetable.h      |  2 ++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 45489b034cd6..6be777a06944 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -74,13 +74,14 @@
  * into another macro at the usage site for good reasons, then please
  * start this local macro with X86_MATCH to allow easy grepping.
  */
-#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _data) { \
+#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _type, _data) { \
 	.vendor		= _vendor,					\
 	.family		= _family,					\
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
 	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
+	.type		= _type,					\
 	.driver_data	= (unsigned long) _data				\
 }
 
@@ -96,7 +97,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)		\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FEATURE - Macro for matching vendor and CPU feature
@@ -109,7 +110,7 @@
  */
 #define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)				\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, X86_FAMILY_ANY, X86_MODEL_ANY,	\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_FEATURE - Macro for matching a CPU feature
@@ -120,7 +121,7 @@
  */
 #define X86_MATCH_FEATURE(feature, data)					\
 	X86_MATCH_CPU(X86_VENDOR_ANY, X86_FAMILY_ANY, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
@@ -134,7 +135,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)			\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,	\
-		      X86_FEATURE_ANY, data)
+		      X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM - Match vendor and family
@@ -147,7 +148,7 @@
  */
 #define X86_MATCH_VENDOR_FAM(vendor, family, data)				\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -158,7 +159,7 @@
  */
 #define X86_MATCH_VFM(vfm, data)						\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm),	VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
@@ -173,7 +174,8 @@
  */
 #define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)			\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      __X86_STEPPINGS(min_step, max_step), X86_FEATURE_ANY, data)
+		      __X86_STEPPINGS(min_step, max_step), X86_FEATURE_ANY,	\
+		      X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -185,7 +187,19 @@
  */
 #define X86_MATCH_VFM_FEATURE(vfm, feature, data)				\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_CPU_TYPE - Match encoded vendor/family/model/type
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @type:	CPU type e.g. P-core, E-core
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ */
+#define X86_MATCH_VFM_CPU_TYPE(vfm, type, data)				\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),	\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, type, data)
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index d67614f7b7f1..bd7e60c0b72f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -692,6 +692,7 @@ struct x86_cpu_id {
 	__u16 feature;	/* bit index */
 	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
 	__u16 flags;
+	__u8  type;
 	kernel_ulong_t driver_data;
 };
 
@@ -703,6 +704,7 @@ struct x86_cpu_id {
 #define X86_STEP_MIN 0
 #define X86_STEP_MAX 0xf
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
+#define X86_CPU_TYPE_ANY 0
 
 /*
  * Generic table type for matching CPU features.

-- 
2.34.1




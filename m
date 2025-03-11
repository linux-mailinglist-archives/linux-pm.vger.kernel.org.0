Return-Path: <linux-pm+bounces-23851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118DA5C466
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E897A1B35
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3625E448;
	Tue, 11 Mar 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3rMw32A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7925DAE8;
	Tue, 11 Mar 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705347; cv=none; b=ZOhyPafDXATJ8Qb2B4T4clo8lvaqjZlK1zNg615o2NzDGLKHSVfb4LRFIGmUKi3OvOsMgMdPcmuE1C/B3b/oJOo8eLHLYWM4FjL8RDKRMRqXlqFWLKGXiYBHL06b30XYeadcQSBM+MYvoegJpLQQF+02uBCFOpX/eCO6GSR3V2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705347; c=relaxed/simple;
	bh=coDGYA3G+yyYMnLYZxfS8hKebjAu/7The5gGiic6xpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVEOAe259Hp6fgJUkdIaCSl/R8cWbknxyTvwwTvB6N5uU/DFcGAkOYQUNvk4nfrW0N973/khBAp6/k5I7M4Np4LmMuX1+Vec5s42g1KzmB5BnBZrKT60VP8fxlGk/x8AXag8td19hmrwWEkcjas1sMiwVUwjEIzPNuzwy6GTQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3rMw32A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705344; x=1773241344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=coDGYA3G+yyYMnLYZxfS8hKebjAu/7The5gGiic6xpY=;
  b=b3rMw32Aik6E4R9EDODTw76jBMOE5Qfb/2NqNL+Nl4BqE6eq2uh96L62
   xyVhbWUQo0RxvXIGhNgrxofT5puYXb0MS+GaguwLE98mLWuUxRhN3OR3n
   eJQy3kS4zVfh9J7JPbkS6/fDDZF6D902Gj+DuE+hnhkH1uPuBGNlog/6I
   nYx/fCTDQuqZZfrpQAgyNmlnfyWNOdMZ8ftMM8/gYmmh5epGzto0UpbU4
   /ETMDXM520B3ZwcKK6aHuLNcO312lJiNGQdvJf8JwYSVQvfVGMUu+B2Ki
   DdrGPmW58q8CMKbxJ4hsm0drG1QczrZNog7ymmHb58/+LL0GqEWRcSY4o
   A==;
X-CSE-ConnectionGUID: mZ5ufaBQTcG2JvdBsDSK5w==
X-CSE-MsgGUID: c7ppipNIQRqTsoR52JYn8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41917447"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="41917447"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:21 -0700
X-CSE-ConnectionGUID: iOMH0CoKR9qhkb0VGUQIPA==
X-CSE-MsgGUID: qtHltlHCT5igNO7pqzrtmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125388480"
Received: from ghakimel-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.184])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:21 -0700
Date: Tue, 11 Mar 2025 08:02:20 -0700
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
Subject: [PATCH v8 2/5] x86/cpu: Name CPU matching macro more generically
 (and shorten)
Message-ID: <20250311-add-cpu-type-v8-2-e8514dcaaff2@linux.intel.com>
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

To add cpu-type to the existing CPU matching infrastructure, the base macro
X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE need to append _CPU_TYPE. This
makes an already long name longer, and somewhat incomprehensible.

To avoid this, rename the base macro to X86_MATCH_CPU. The macro name
doesn't need to explicitly tell everything that it matches. The arguments
to the macro already hints that.

For consistency, use this base macro to define X86_MATCH_VFM and friends.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 110 +++++++++--------------------------
 1 file changed, 26 insertions(+), 84 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 9ebc263832ff..45489b034cd6 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -57,7 +57,7 @@
 #define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
 
 /**
- * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
+ * X86_MATCH_CPU -  Base macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
  *		The name is expanded to X86_VENDOR_@_vendor
  * @_family:	The family number or X86_FAMILY_ANY
@@ -74,19 +74,7 @@
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
@@ -96,24 +84,6 @@
 	.driver_data	= (unsigned long) _data				\
 }
 
-/**
- * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Macro for CPU matching
- * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
- *		The name is expanded to X86_VENDOR_@_vendor
- * @_family:	The family number or X86_FAMILY_ANY
- * @_model:	The model number, model constant or X86_MODEL_ANY
- * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
- * @_data:	Driver specific data or NULL. The internal storage
- *		format is unsigned long. The supplied value, pointer
- *		etc. is casted to unsigned long internally.
- *
- * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
- * set to wildcards.
- */
-#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
-	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
-						X86_STEPPING_ANY, feature, data)
-
 /**
  * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
  * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
@@ -123,13 +93,10 @@
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
@@ -139,12 +106,10 @@
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
@@ -152,12 +117,10 @@
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
@@ -168,13 +131,10 @@
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
@@ -184,12 +144,10 @@
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
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -197,15 +155,10 @@
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
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
@@ -217,16 +170,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * feature is set to wildcard
  */
-#define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(		\
-		VFM_VENDOR(vfm),				\
-		VFM_FAMILY(vfm),				\
-		VFM_MODEL(vfm),					\
-		__X86_STEPPINGS(min_step, max_step),		\
-		X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)			\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
+		      __X86_STEPPINGS(min_step, max_step), X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -235,15 +182,10 @@
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
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);

-- 
2.34.1




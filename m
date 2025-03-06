Return-Path: <linux-pm+bounces-23537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED700A5435B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 08:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE441894417
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD681C6FF3;
	Thu,  6 Mar 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FE8stspL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C851917CD;
	Thu,  6 Mar 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245171; cv=none; b=V7tJxsWA5I/8kLkkvg5ceOA765IGXaJeJx4SnTaOeqQlQKUC83cELDGnKec9m58Vq6WKZdsYsLt2UqDsIp9kwn3zK6y/jBQdU2Fo3gShR5TbW1P9ydyZ14vF4Uru6c7P8HSoRbBRP8kKxl8sV+BeU5zw5X1L2Ma5Uq25ceaTO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245171; c=relaxed/simple;
	bh=BfCpvXPQPn7mcskR6IEtxlwl46LOxQ6OOV0rkXcU5do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHRhM8au6JZhcLhJ5Y+cBcRLe/8wbRmv2h0IzK0gnOWoCkj0v9wkvR5dQ4CzoBGeqA93mUs8UqevbB6kDWvpxO4YvtpCnzG/UES5wVg0FtTZiDWYejdv3Hay8eq1E1Z9NyNQUd3dO8OTsnb2AtkprIbhuic9k5xmwYgAyA2DV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FE8stspL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741245170; x=1772781170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BfCpvXPQPn7mcskR6IEtxlwl46LOxQ6OOV0rkXcU5do=;
  b=FE8stspL8jmm79iAUz0l+IlwzYfLAQB2tcnmNfei8wXl681Few6sg7+U
   5k7TxAx9inYKnIyGT1ElifhjsYPfaQv2P9ML3M+ma1Z6NaIFVjQ5HuUJy
   aBy42mL0mnsCrnjz+K0nq4OEhKMqldOF8knIOVZx6DfZZ+kf7cmCZRkye
   WoA5zPBFW8SJNv3DXcrtLC9QZtY9fQIrqdY3r+5XUwnyRjucVQphpWwNJ
   tzsttjLp6kVgZRvajIFGHuCcljaaeAwOe3itqd1gZHSEQHdJIkEcy6q38
   dXF967VbmT0uuiSH5yr6rG8xyDkYI9HDtJIyZ3M337+vl9fMBB3cZ/5Gj
   w==;
X-CSE-ConnectionGUID: 16BdQ/ZbSyeAaHUORHAR4g==
X-CSE-MsgGUID: QRrWPt8FS3eh/LzrBGs7aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41490161"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41490161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:12:49 -0800
X-CSE-ConnectionGUID: 2xfomYqyTUG2CkFXqS9P+w==
X-CSE-MsgGUID: AWk+Tr2AQOybelNYBXIKMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="124032134"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:12:48 -0800
Date: Wed, 5 Mar 2025 23:12:47 -0800
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
Subject: [PATCH v6 1/5] x86/cpu: Name CPU matching macro more generically
 (and shorten)
Message-ID: <20250305-add-cpu-type-v6-1-4741735bcd75@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>

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
 arch/x86/include/asm/cpu_device_id.h | 101 ++++++++++-------------------------
 1 file changed, 29 insertions(+), 72 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index ba32e0f44cba..bb5acba69bd1 100644
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
@@ -106,13 +94,10 @@
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
@@ -123,13 +108,10 @@
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
@@ -139,12 +121,10 @@
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
@@ -152,12 +132,10 @@
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
@@ -168,13 +146,10 @@
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
@@ -184,12 +159,10 @@
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
@@ -197,15 +170,10 @@
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
@@ -215,16 +183,10 @@
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
@@ -233,15 +195,10 @@
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




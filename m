Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81277180ACD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 22:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgCJVqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 17:46:25 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49224 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbgCJVqY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 17:46:24 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cTDw1Tq3zFdmM;
        Tue, 10 Mar 2020 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583876784; bh=stbRd6S/nM+SmSD6AtycsqKYC18n7tohdkTgbGMLfTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sHx5S/kDQQsB4kBIeSgf+XlR9aeF4xQSC2VmxxtIolgRZFthiRcCT+E+j8vjwxApz
         Iu63iX3UWlCavj9nknOwkguhQtwh/EjY7jBaTOoWBFDopQcAz0T7kNMajLpC7j+DBX
         L91bx6doFKUMQ08OxBoFRh4TeBlwPlDAyd+KnNO4=
X-Riseup-User-ID: 97FBB299D1AA66348E4076D3E7B7381D8F06234A9706F0A2D772C9261D8C0D82
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cTDv6tL4zJrlc;
        Tue, 10 Mar 2020 14:46:23 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 08/10] cpufreq: intel_pstate: Enable VLP controller based on ACPI FADT profile and CPUID.
Date:   Tue, 10 Mar 2020 14:42:01 -0700
Message-Id: <20200310214203.26459-9-currojerez@riseup.net>
In-Reply-To: <20200310214203.26459-1-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For the moment the VLP controller is only enabled on ICL platforms
other than server FADT profiles in order to reduce the validation
effort of the initial submission.  It should work on any other
processors that support HWP though (and soon enough on non-HWP too):
In order to override the default behavior (e.g. to test on other
platforms) the VLP controller can be forcefully enabled or disabled by
passing "intel_pstate=vlp" or "intel_pstate=no_vlp" respectively in
the kernel command line.

v2: Handle HWP VLP controller.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 Documentation/admin-guide/pm/intel_pstate.rst |  7 ++++++
 drivers/cpufreq/intel_pstate.c                | 25 +++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0c9894247015..9bc55fc2752e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1828,6 +1828,11 @@
 			per_cpu_perf_limits
 			  Allow per-logical-CPU P-State performance control limits using
 			  cpufreq sysfs interface
+			vlp
+			  Force use of VLP P-state controller.  Overrides selection
+			  derived from ACPI FADT profile.
+			no_vlp
+			  Prevent use of VLP P-state controller (see "vlp" parameter).
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 67e414e34f37..da6b64812848 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -669,6 +669,13 @@ of them have to be prepended with the ``intel_pstate=`` prefix.
 	Use per-logical-CPU P-State limits (see `Coordination of P-state
 	Limits`_ for details).
 
+``vlp``
+	Force use of VLP P-state controller.  Overrides selection derived
+	from ACPI FADT profile.
+
+``no_vlp``
+	Prevent use of VLP P-state controller (see "vlp" parameter).
+
 
 Diagnostics and Tuning
 ======================
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a01eed40d897..050cc8f03c26 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3029,6 +3029,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 
 static int no_load __initdata;
 static int no_hwp __initdata;
+static int vlp __initdata = -1;
 static int hwp_only __initdata;
 static unsigned int force_load __initdata;
 
@@ -3193,6 +3194,7 @@ static inline void intel_pstate_request_control_from_smm(void) {}
 #endif /* CONFIG_ACPI */
 
 #define INTEL_PSTATE_HWP_BROADWELL	0x01
+#define INTEL_PSTATE_HWP_VLP		0x02
 
 #define ICPU_HWP(model, hwp_mode) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_HWP, hwp_mode }
@@ -3200,12 +3202,15 @@ static inline void intel_pstate_request_control_from_smm(void) {}
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
 	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
 	ICPU_HWP(INTEL_FAM6_BROADWELL_D, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(INTEL_FAM6_ICELAKE, INTEL_PSTATE_HWP_VLP),
+	ICPU_HWP(INTEL_FAM6_ICELAKE_L, INTEL_PSTATE_HWP_VLP),
 	ICPU_HWP(X86_MODEL_ANY, 0),
 	{}
 };
 
 static int __init intel_pstate_init(void)
 {
+	bool use_vlp = vlp == 1;
 	const struct x86_cpu_id *id;
 	int rc;
 
@@ -3222,8 +3227,19 @@ static int __init intel_pstate_init(void)
 			pstate_funcs.update_util = intel_pstate_update_util;
 		} else {
 			hwp_active++;
-			pstate_funcs.update_util = intel_pstate_update_util_hwp;
-			hwp_mode_bdw = id->driver_data;
+
+			if (vlp < 0 && !intel_pstate_acpi_pm_profile_server() &&
+			    (id->driver_data & INTEL_PSTATE_HWP_VLP)) {
+				/* Enable VLP controller by default. */
+				use_vlp = true;
+			}
+
+			pstate_funcs.update_util = use_vlp ?
+				intel_pstate_update_util_hwp_vlp :
+				intel_pstate_update_util_hwp;
+
+			hwp_mode_bdw = (id->driver_data &
+					INTEL_PSTATE_HWP_BROADWELL);
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			goto hwp_cpu_matched;
 		}
@@ -3301,6 +3317,11 @@ static int __init intel_pstate_setup(char *str)
 	if (!strcmp(str, "per_cpu_perf_limits"))
 		per_cpu_limits = true;
 
+	if (!strcmp(str, "vlp"))
+		vlp = 1;
+	if (!strcmp(str, "no_vlp"))
+		vlp = 0;
+
 #ifdef CONFIG_ACPI
 	if (!strcmp(str, "support_acpi_ppc"))
 		acpi_ppc = true;
-- 
2.22.1


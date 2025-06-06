Return-Path: <linux-pm+bounces-28214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16504AD0A59
	for <lists+linux-pm@lfdr.de>; Sat,  7 Jun 2025 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8218B1726AA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101923ED56;
	Fri,  6 Jun 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codesensesolutions.com header.i=joe.walter@codesensesolutions.com header.b="zjb+416c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BD42A83;
	Fri,  6 Jun 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253337; cv=none; b=PLYIJNxj5LDM8+4oyr2YwQslDYnkgUjPkjkUsN2NsS5JqLZikHTJEGvbFU5c4h6tC6CMpUJ0PQk2RqdNSIuuONygPH4UvshKFurXpRvPpqQYtWNO28/uj/ZCZMesRAcs0gpSpO+cqcxiGwkTCz/RonIdGAGy7Qh9yu0hS5kpF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253337; c=relaxed/simple;
	bh=C+IR39tUkiTTCkYcCBh9yKbjRvfgTXZzNOf0olfsY2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMsTREQqlCH0eHvrYclMWm5sOOCdBdQSSsvV+Pa9DcNfi8rFEXewsfeXDW+13/PFy4UiXSJP/WAEexVoWSZbrZ5/NrqFpf6iW6JLWaFYdUN63GfDXizv1ne55JVR/CHy71qwBDMPRnKebiDeMAQyVOIV8lwdWqw1lnPSWLsKNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesensesolutions.com; spf=pass smtp.mailfrom=codesensesolutions.com; dkim=pass (2048-bit key) header.d=codesensesolutions.com header.i=joe.walter@codesensesolutions.com header.b=zjb+416c; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesensesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codesensesolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codesensesolutions.com; s=s1-ionos; t=1749253333; x=1749858133;
	i=joe.walter@codesensesolutions.com;
	bh=pQc42KUwgUGS2WmegoHpY8vL7gP3oEBUaiYeFR/4kEU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=zjb+416cjfA7p7tRTUMQlYA0s6YDBM0i0oqaC8AU2OaWfSflCkguOKKzRlxcAuS6
	 ICBc7yqG2qeHzlFf3V4kJaSyqmwgbOdEgqTE6cdzthxls0/L8FDDkyGrGRb7UHqCp
	 9/4bDhDFZgKpZyAREmlRWxqccbAoiOKYubE91ZrtnY1HO500m8SvuMhCiY+Gpqh50
	 Zvc2Grkvn1Ofvj5yr+YsBndVSnMEEmNdEPEL9q8qZrUAIIaJnUjvyWQZ/y8WSFOUl
	 fX0F557POdkZhz/9kAvCon2oR6eK57MOSEw3iMudHdl4G2BRttGtb5VZ53DiRAXKI
	 RwRbU082CwS8KXYRqA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from jennycraig-lappy ([50.225.178.2]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LufTy-1uo75S2j0y-015Ev5;
 Sat, 07 Jun 2025 01:16:46 +0200
From: Joe Walter <joe.walter@codesensesolutions.com>
To: srinivas.pandruvada@linux.intel.com,
	rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Walter <joe.walter@codesensesolutions.com>
Subject: [PATCH] cpufreq: intel_pstate: Add DMI quirk for Dell Inspiron systems
Date: Fri,  6 Jun 2025 16:15:30 -0700
Message-ID: <20250606231530.3032-1-joe.walter@codesensesolutions.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b7KUDsQQohqjJEPY3hwinrLqrGma3HlyZ//5hJXZdUkCbxMasKf
 tA5PM14YqECe8vVZvIpNJyBqexiAClOqvYSFcmqQVVsdhMW5Og+aDg4/PcQmonElTqKwyJl
 e6pKz4BPZaLwlaHc2eToT+H2e8ywh8AZl2VobclYF+sy1gy07s58FxXPrsGQSPrE3AJEg0x
 XPR7A92SnruTgA+4IakLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GgFBluPKg9M=;rD/a9TXfcYdxfMvNOJTUkrceQBq
 qWt1ysC7kgkujgoCQYQyZKxLtkR/uNa6C2uTjEcesblAUjeXna64Z8UHNBItKdfKL8Qs1vLNw
 0gI5DTrwcSJlMqLXTcTBnQ+vVg3Ki8O2nR7+tM+LFhmnCmIKqTLVTUs3Nw+ZTmsyGGDk1A0Jw
 //wmpPX898uhz4662RcFg2J/qyMTnyMrbCrTmKmtZtW6XNA6+3B7O3+9nWvBiNJ/MdwTvJFOL
 fRYGOK4SrHzkG1Z1ai8oUUQFNh7Weit38lVS9QCFyrIGQNivQCJJbhCVmzte/Rrddq4nq3vbe
 zrkUQfx9SDjJka6Iho2FQuDsrpiWDzF9clUkkwY6a6krOd7aklwQFRrZDdc4elu8cotiNN/FM
 mB+8dr3fQWTye1FG38BipHLq6i+1voZrMQp+DH5BVWfXBOEY/CMwJROpCXeNxEIPYqHstZjfV
 lL0/Xa5aemtC9BZkVEszplMeYRuhbdjqJcgYxM1jdOiTywabhs70iMZfc55VRgB3jnYOIFh/Y
 B/JHc0urEyeK7vm4GdP5HVYYP0HtZqNkoN0wEF+rm2e3Mz1JolLlMEPwqyVVgCTDTYnjN3E3N
 Itm0pk4tGJcT8br0P6BHxDvJ+uSM8cQxpzxTTBbYPF5LuKEb6gz4D54yiMeEUqdidQrh652JP
 fEA3wnkb9W55ineoefbKk11iR7KwEeVc0gOXYod5ic3rpvSIrV4rqao1yukmcYBJj3+/REBFd
 Tz1PCA+dvgfd4MbNHVWa0qgkAdu5WXMPqgGlWcEJO2VFKtpV4YJDyA5fFmIo7/ChzRq79bnwZ
 HX4JwjJSXGC1yVs8hCEmz9DBwvtVIZ7jsi8hAQHGqfJLU9OoSNbzNYz2X6bIq+GZYRAHRN+70
 mxJjjPcbH9uJrqrqUzpVxo9xCC/by/At3mD/uD/vmlR0Niog5vZ3FkpyVlDN1neAexIvKowqM
 p4QLqb8rOCRSCo5Vg+6OcBF6q4EOkdxM41zY2D4lrR5vTlmutUtdgiBjnwFpuVo94m9PrYu24
 JYJQ7pV/m/tb2HhMiMwvuVcxHL5+C+eL+L+vJEn0GDWxibDEQNl4NCIZtfnYvR9ns0u3oFRTb
 uMZd82VlG87d4dLPtWXLz9PQzVzU3YnJWH5TfmUUyu+d9UkXLrt2g5csgDNjfaBokFVdmEKUt
 Se/hji7SGPTKeQM00KKK5C31mYWNdyUM/rn/6vG28IPh4qE2boAHhWEMInwpZusBRsd1dGbKD
 bqhrtJ1oAlSOzbJ8Oy/ibTVpqoWz6jspkWNaxiebZhBvT/nLNkUnCEaNSEszvYA5imgEZW5Su
 BOoZeYcPgtD4gl/3sGBYZF4aU916tw5K5frSg01r7NF7+VVTDSvJZuoa+MLKriTgPFIlWGaG2
 j4cq9vsJqZC9H9/T8wdkAHOHIroQU9JhuMiqU=

Some Dell Inspiron systems experience frequency scaling issues with
intel_pstate driver where the CPU gets locked at 900MHz after load.

Add DMI quirk table to detect affected Dell Inspiron models and prevent
intel_pstate from loading, allowing acpi-cpufreq to handle frequency
scaling instead.

Affected models:
- Dell Inspiron 15 7000 Gaming
- Dell Inspiron 7567
- Dell Inspiron 7559

Tested-by: Joe Walter <joe.walter@codesensesolutions.com>
Signed-off-by: Joe Walter <joe.walter@codesensesolutions.com>
=2D--
 drivers/cpufreq/intel_pstate.c | 65 ++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate=
.c
index 1b1f62ccec92..3aeb04755afa 100644
=2D-- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -28,7 +28,6 @@
 #include <linux/pm_qos.h>
 #include <linux/bitfield.h>
 #include <trace/events/power.h>
-#include <linux/dmi.h>
 #include <linux/units.h>
=20
 #include <asm/cpu.h>
@@ -48,6 +47,7 @@
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
+#include <linux/dmi.h>
 #endif
=20
 #define FRAC_BITS 8
@@ -299,25 +299,6 @@ struct pstate_funcs {
=20
 static struct pstate_funcs pstate_funcs __read_mostly;
=20
-/* DMI quirk table for systems that should prefer acpi-cpufreq over intel=
_pstate */
-static int intel_pstate_prefer_acpi_cpufreq(const struct dmi_system_id *i=
d)
-{
-	pr_info("Preferring acpi-cpufreq for %s due to performance issues with i=
ntel_pstate\n",
-		id->ident);
-	return 1;
-}
-
-static const struct dmi_system_id intel_pstate_acpi_cpufreq_prefer[] =3D =
{
-	{
-		.callback =3D intel_pstate_prefer_acpi_cpufreq,
-		.ident =3D "Dell Inspiron 15 7000 Gaming",
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 15 7000 Gaming"),
-		},
-	},
-	{ }
-};
 static bool hwp_active __ro_after_init;
 static int hwp_mode_bdw __ro_after_init;
 static bool per_cpu_limits __ro_after_init;
@@ -2799,6 +2780,41 @@ static const struct x86_cpu_id intel_pstate_cpu_ids=
[] =3D {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
=20
+/* DMI quirk table for systems that should prefer acpi-cpufreq over intel=
_pstate */
+static int intel_pstate_prefer_acpi_cpufreq(const struct dmi_system_id *i=
d)
+{
+	pr_info("Detected %s, preferring acpi-cpufreq\n", id->ident);
+	return 0;
+}
+
+static const struct dmi_system_id intel_pstate_acpi_cpufreq_prefer[] =3D =
{
+	{
+		.ident =3D "Dell Inspiron 15 7000 Gaming",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 15 7000 Gaming"),
+		},
+		.callback =3D intel_pstate_prefer_acpi_cpufreq,
+	},
+	{
+		.ident =3D "Dell Inspiron 7567",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7567"),
+		},
+		.callback =3D intel_pstate_prefer_acpi_cpufreq,
+	},
+	{
+		.ident =3D "Dell Inspiron 7559",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7559"),
+		},
+		.callback =3D intel_pstate_prefer_acpi_cpufreq,
+	},
+	{}
+};
+
 #ifdef CONFIG_ACPI
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst =3D=
 {
 	X86_MATCH(INTEL_BROADWELL_D,		core_funcs),
@@ -3825,6 +3841,12 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
=20
+
+	/* Early DMI check - prevent intel_pstate on problematic systems */
+	if (dmi_check_system(intel_pstate_acpi_cpufreq_prefer)) {
+		pr_info("intel_pstate: system prefers acpi-cpufreq, not loading\n");
+		return -ENODEV;
+	}
 	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
 		return -ENODEV;
=20
@@ -3887,9 +3909,6 @@ static int __init intel_pstate_init(void)
 		pr_info("Invalid MSRs\n");
 		return -ENODEV;
 	}
-/* Check for systems that should prefer acpi-cpufreq */
-	if (!default_driver && dmi_check_system(intel_pstate_acpi_cpufreq_prefer=
))
-		default_driver =3D &intel_cpufreq;
 	/* Without HWP start in the passive mode. */
 	if (!default_driver)
 		default_driver =3D &intel_cpufreq;
=2D-=20
2.48.1



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7645D94930
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfHSPwk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 11:52:40 -0400
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:35192
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfHSPwk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 11:52:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clvX/ejfKynAE7X2tkHdtIc+nSw3rxeEn08A2PTQg++hUknJQgBTD/b+8rQVhEaCk6RaWLuzIoS/r9MujxjiNNy3d66GOwS7eBI3qZi29RgGIlvmVYzJseMMwr/z7Xg9dAHBUt4y2+3k6sqhKtw7+dhDERveG8V8ncVkeA3xiW40b2FddXS6aOqKmXFvChE59d5v3zI4p7orVRUrOm4bfD5k7EUNc/HC79htIhoxSQL17Ina1sqikcG/AD/hZTDVg+2N4YZdLVOKcmAI2mQV6m0PYKSDwTPm57/ShZtRVwRi1FUt6z0xbESqPU91/302/Kgc7Fbc/J2c9J7NFBwY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4RSbITFg37i5t/g2I27LkGHufAimryAMFNJjmIwi40=;
 b=kNuLX0dQSOfjGzVxRUPz6Ak9hzNSh7+I+ugpPJmgbEDTH5/+Ji8SRnBl9oGacDGdDadfabqx6QYrgsJKJgVa/HMqRKbBuW6m+wyxkPaULyHAQOrvGGX9UXF2PqcszhAY/XNvDeQO6rbcIc5XyqmiaV9XdiXkC5CX+ZyyxrxVqlKaBgIsf/jCbdnSUsN7cZmdOCgn1i1a694Dxk+EXz48mUFL9my7YEp0t9mAoh9yek4Xe3M+PA0VpSgCi3gQNRrwHA0EARbEyOXEU9Joc1A0MNMpVrdRjEjjU8OwxntgMy8DVZmq7DCmYuiU8b3BWXEBLTznHxgOWReDzzLQPfuSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4RSbITFg37i5t/g2I27LkGHufAimryAMFNJjmIwi40=;
 b=rrOddpr0/WMShQW7rBV6rwbJq3geVCQPHnVQU76im3MONvn1rUEYiAyP9Q/owouwMG7GJii95N9/mYDVc09MudWf1I4/ZxMqTvdi56k9XPIzQRm+8sbAsTgR/lofl2b1Ja252m1HPU3p7kRfJMSqwcgXJ4cn81CHH50dn2c3u8s=
Received: from BYAPR12MB3158.namprd12.prod.outlook.com (20.179.92.19) by
 BYAPR12MB2680.namprd12.prod.outlook.com (20.176.255.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 15:52:35 +0000
Received: from BYAPR12MB3158.namprd12.prod.outlook.com
 ([fe80::39b9:76bd:a491:1f27]) by BYAPR12MB3158.namprd12.prod.outlook.com
 ([fe80::39b9:76bd:a491:1f27%6]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 15:52:35 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Thread-Topic: [PATCH v2] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family
 15h/16h
Thread-Index: AQHVVqYeBvEEiSebgUWOgoB4Tc5XXA==
Date:   Mon, 19 Aug 2019 15:52:35 +0000
Message-ID: <7543af91666f491547bd86cebb1e17c66824ab9f.1566229943.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN6PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:805::31) To BYAPR12MB3158.namprd12.prod.outlook.com
 (2603:10b6:a03:132::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c216cc-5edd-4af4-30c4-08d724bd40e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2680;
x-ms-traffictypediagnostic: BYAPR12MB2680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2680E73C0EDBDDBCD9CEA4AAECA80@BYAPR12MB2680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(66946007)(2501003)(7416002)(2201001)(36756003)(86362001)(66446008)(64756008)(66556008)(66476007)(66066001)(14454004)(7736002)(81166006)(8936002)(50226002)(81156014)(478600001)(8676002)(256004)(186003)(14444005)(6506007)(26005)(386003)(102836004)(486006)(476003)(2616005)(305945005)(53936002)(4326008)(71190400001)(71200400001)(6436002)(118296001)(25786009)(6486002)(6512007)(3846002)(6116002)(2906002)(99286004)(52116002)(54906003)(316002)(5660300002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:BYAPR12MB3158.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9PWYyjE8+Dsz++wSgDuwkXstKKZmsatoexsA3iDG3GJyWoOA2xXrweHPizqTJlx5Oot5MwyAoILt3e82GGT75a/xGrtKuTS0sxGjRYJgXrpwPUtm7uVkTqBHgEcGjXJH6IoqIOX+EQrBV1qJqL87GXzwtdFaW2COVU0Yn1XfQL3cRqz9gq85f7bSNstGhyRQMiUTYNj/Fbw5W3tgb/SUEBSP7B7gXew1ioyFOsUjmIxNuviXrqXqUACwkCua8cEvhhHjE+D3l126+wbStSfmBZCFotQcyNlyaurGTj9fX1PgxfQh1Vk2X8hAkNDtG/w/RnfYqr+pXp64SADqfV8uxmz0LtQb31CylKpufUAd/TrhcWMaC2qP+P1SrDOxYx0PKtCWKki0GNFEBY1M595jDcI9OO85IdYibyDEaBkZwEE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C179DE4EF1B914399249FE1CAE3D69B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c216cc-5edd-4af4-30c4-08d724bd40e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 15:52:35.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYLF9aByy7OvpLfypzuiSLouSxjVrAhO88zAAPCUoSCENd/zHCMwX9Icaggh2jpnRfzyJi2GbqTz41CdjHLPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

There have been reports of RDRAND issues after resuming from suspend on
some AMD family 15h and family 16h systems. This issue stems from a BIOS
not performing the proper steps during resume to ensure RDRAND continues
to function properly.

RDRAND support is indicated by CPUID Fn00000001_ECX[30]. This bit can be
reset by clearing MSR C001_1004[62]. Any software that checks for RDRAND
support using CPUID, including the kernel,  will believe that RDRAND is
not supported.

Update the CPU initialization to clear the RDRAND CPUID bit for any family
15h and 16h processor that supports RDRAND. If it is known that the family
15h or family 16h system does not have an RDRAND resume issue or that the
system will not be placed in suspend, the "rdrand_force" kernel parameter
can be used to stop the clearing of the RDRAND CPUID bit.

Additionally, update the suspend and resume path to save and restore the
MSR C001_1004 value to ensure that the RDRAND CPUID setting remains in
place after resuming from suspend.

Note, that clearing the RDRAND CPUID bit does not prevent a processor
that normally supports the RDRAND instruction from executing the RDRAND
instruction. So any code that determined the support based on family and
model won't #UD.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

---

Changes from v1:
- Changed rdrand_force option to rdrand=3Dforce option
- Only do this for configuratons with CONFIG_PM_SLEEP=3Dy
- Various name clarifications
- Added a check to verify change in case the kernel is running virtualized
- More verbose messaging
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/kernel/cpu/amd.c                     | 66 ++++++++++++++
 arch/x86/power/cpu.c                          | 86 ++++++++++++++++---
 4 files changed, 147 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 47d981a86e2f..4c1971960afa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4090,6 +4090,13 @@
 			Run specified binary instead of /init from the ramdisk,
 			used for early userspace startup. See initrd.
=20
+	rdrand=3D		[X86]
+			force - Override the decision by the kernel to hide the
+				advertisement of RDRAND support (this affects
+				certain AMD processors because of buggy BIOS
+				support, specifically around the suspend/resume
+				path).
+
 	rdt=3D		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h
index 6b4fc2788078..271d837d69a8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -381,6 +381,7 @@
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
+#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3afe07d602dd..29f0cdfbdca5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -804,6 +804,64 @@ static void init_amd_ln(struct cpuinfo_x86 *c)
 	msr_set_bit(MSR_AMD64_DE_CFG, 31);
 }
=20
+static bool rdrand_force;
+
+static int __init rdrand_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "force"))
+		rdrand_force =3D true;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("rdrand", rdrand_cmdline);
+
+static void clear_rdrand_cpuid_bit(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Saving of the MSR used to hide the RDRAND support during
+	 * suspend/resume is done by arch/x86/power/cpu.c, which is
+	 * dependent on CONFIG_PM_SLEEP.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_SLEEP))
+		return;
+
+	/*
+	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
+	 * RDRAND support using the CPUID function directly.
+	 */
+	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)
+		return;
+
+	msr_clear_bit(MSR_AMD64_CPUID_FN_1, 62);
+
+	/*
+	 * Verify that the CPUID change has occurred in case the kernel is
+	 * running virtualized and the hypervisor doesn't support the MSR.
+	 */
+	if (cpuid_ecx(1) & BIT(30)) {
+		pr_info_once("BIOS may not properly restore RDRAND after suspend, but hy=
pervisor does not support hiding RDRAND via CPUID.\n");
+		return;
+	}
+
+	clear_cpu_cap(c, X86_FEATURE_RDRAND);
+	pr_info_once("BIOS may not properly restore RDRAND after suspend, hiding =
RDRAND via CPUID. Use rdrand=3Dforce to reenable.\n");
+}
+
+static void init_amd_jg(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Some BIOS implementations do not restore proper RDRAND support
+	 * across suspend and resume. Check on whether to hide the RDRAND
+	 * instruction support via CPUID.
+	 */
+	clear_rdrand_cpuid_bit(c);
+}
+
 static void init_amd_bd(struct cpuinfo_x86 *c)
 {
 	u64 value;
@@ -818,6 +876,13 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 			wrmsrl_safe(MSR_F15H_IC_CFG, value);
 		}
 	}
+
+	/*
+	 * Some BIOS implementations do not restore proper RDRAND support
+	 * across suspend and resume. Check on whether to hide the RDRAND
+	 * instruction support via CPUID.
+	 */
+	clear_rdrand_cpuid_bit(c);
 }
=20
 static void init_amd_zn(struct cpuinfo_x86 *c)
@@ -860,6 +925,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x10: init_amd_gh(c); break;
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
+	case 0x16: init_amd_jg(c); break;
 	case 0x17: init_amd_zn(c); break;
 	}
=20
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 1c58d8982728..915bb1639763 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 #include <linux/perf_event.h>
 #include <linux/tboot.h>
+#include <linux/dmi.h>
=20
 #include <asm/pgtable.h>
 #include <asm/proto.h>
@@ -23,7 +24,7 @@
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
-#include <linux/dmi.h>
+#include <asm/cpu_device_id.h>
=20
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -393,15 +394,14 @@ static int __init bsp_pm_check_init(void)
=20
 core_initcall(bsp_pm_check_init);
=20
-static int msr_init_context(const u32 *msr_id, const int total_num)
+static int msr_build_context(const u32 *msr_id, const int num)
 {
-	int i =3D 0;
+	struct saved_msrs *saved_msrs =3D &saved_context.saved_msrs;
 	struct saved_msr *msr_array;
+	int total_num;
+	int i, j;
=20
-	if (saved_context.saved_msrs.array || saved_context.saved_msrs.num > 0) {
-		pr_err("x86/pm: MSR quirk already applied, please check your DMI match t=
able.\n");
-		return -EINVAL;
-	}
+	total_num =3D saved_msrs->num + num;
=20
 	msr_array =3D kmalloc_array(total_num, sizeof(struct saved_msr), GFP_KERN=
EL);
 	if (!msr_array) {
@@ -409,19 +409,30 @@ static int msr_init_context(const u32 *msr_id, const =
int total_num)
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0; i < total_num; i++) {
-		msr_array[i].info.msr_no	=3D msr_id[i];
+	if (saved_msrs->array) {
+		/*
+		 * Multiple callbacks can invoke this function, so copy any
+		 * MSR save requests from previous invocations.
+		 */
+		memcpy(msr_array, saved_msrs->array,
+		       sizeof(struct saved_msr) * saved_msrs->num);
+
+		kfree(saved_msrs->array);
+	}
+
+	for (i =3D saved_msrs->num, j =3D 0; i < total_num; i++, j++) {
+		msr_array[i].info.msr_no	=3D msr_id[j];
 		msr_array[i].valid		=3D false;
 		msr_array[i].info.reg.q		=3D 0;
 	}
-	saved_context.saved_msrs.num	=3D total_num;
-	saved_context.saved_msrs.array	=3D msr_array;
+	saved_msrs->num   =3D total_num;
+	saved_msrs->array =3D msr_array;
=20
 	return 0;
 }
=20
 /*
- * The following section is a quirk framework for problematic BIOSen:
+ * The following sections are a quirk framework for problematic BIOSen:
  * Sometimes MSRs are modified by the BIOSen after suspended to
  * RAM, this might cause unexpected behavior after wakeup.
  * Thus we save/restore these specified MSRs across suspend/resume
@@ -436,7 +447,7 @@ static int msr_initialize_bdw(const struct dmi_system_i=
d *d)
 	u32 bdw_msr_id[] =3D { MSR_IA32_THERM_CONTROL };
=20
 	pr_info("x86/pm: %s detected, MSR saving is needed during suspending.\n",=
 d->ident);
-	return msr_init_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
+	return msr_build_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
 }
=20
 static const struct dmi_system_id msr_save_dmi_table[] =3D {
@@ -451,9 +462,58 @@ static const struct dmi_system_id msr_save_dmi_table[]=
 =3D {
 	{}
 };
=20
+static int msr_save_cpuid_features(const struct x86_cpu_id *c)
+{
+	u32 cpuid_msr_id[] =3D {
+		MSR_AMD64_CPUID_FN_1,
+	};
+
+	pr_info("x86/pm: family %#hx cpu detected, MSR saving is needed during su=
spending.\n",
+		c->family);
+
+	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
+}
+
+static const struct x86_cpu_id msr_save_cpu_table[] =3D {
+	{
+		.vendor =3D X86_VENDOR_AMD,
+		.family =3D 0x15,
+		.model =3D X86_MODEL_ANY,
+		.feature =3D X86_FEATURE_ANY,
+		.driver_data =3D (kernel_ulong_t)msr_save_cpuid_features,
+	},
+	{
+		.vendor =3D X86_VENDOR_AMD,
+		.family =3D 0x16,
+		.model =3D X86_MODEL_ANY,
+		.feature =3D X86_FEATURE_ANY,
+		.driver_data =3D (kernel_ulong_t)msr_save_cpuid_features,
+	},
+	{}
+};
+
+typedef int (*pm_cpu_match_t)(const struct x86_cpu_id *);
+static int pm_cpu_check(const struct x86_cpu_id *c)
+{
+	const struct x86_cpu_id *m;
+	int ret =3D 0;
+
+	m =3D x86_match_cpu(msr_save_cpu_table);
+	if (m) {
+		pm_cpu_match_t fn;
+
+		fn =3D (pm_cpu_match_t)m->driver_data;
+		ret =3D fn(m);
+	}
+
+	return ret;
+}
+
 static int pm_check_save_msr(void)
 {
 	dmi_check_system(msr_save_dmi_table);
+	pm_cpu_check(msr_save_cpu_table);
+
 	return 0;
 }
=20
--=20
2.17.1


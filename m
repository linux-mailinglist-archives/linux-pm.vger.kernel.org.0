Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A48DFAB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfHNVRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 17:17:50 -0400
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:6014
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728364AbfHNVRt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 17:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9IW+rbhbXi1DsSEGVlIC6Bdk5AlOalmQp+9DSyrWLOXmNNp/fSHBVCxtIDN1XcLMdmD7FKRdn1NeIGebw4XLNm7iF4yPspBPdxhbZHRKQ2uflhertw5BvwSya9rgdLdAgio1xzV/u8nhPE2JeRd2toCYkJDCnmnVfAIF1VIWsgj7Eo3SNhJD3PHJefKKeisp8gbxhoyUlId14MvBk+1TyZ8UN4sWYeGMNE5wxE0q5yF2yqHyqqXgSQEjKswUWaZB9mM9iRZanNPDgLNWjEwafrsIiekGd8VYrShsw+Bx18QOZr7n1FyJ9pOL6jW9a9yyI5AWTvnEF63viklRUcLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxc/b5MBXxYBY7r8W8lqFgeqEB9988tTDe8NesdUoEI=;
 b=BPrZNbJzlz3BZxYHCF4PULcf/RTVVjL247bLSv3id2Rgtty0vL7niO8Hi09zJe3/lRMI4x9DDuWsEM1pmFXVFV+n7kWj2bP0btuTvXnUiHy+RE0LXNzJoSn9oqiab0dISB1+XIgQ3B8QIQ4db3NOfGMNyduYao8m5vOMxMV0GBgbzY9vJAamwvbrBtzcVsziIWCxxXBnO6oJqmhsszrJy/Avk/tCk5Lw8hP6cBUypTPsxlxUtECQv566ksQq/mgJ46AQ6F/fG2IhDc1IU00nZAhzT8j/bBSqdbYm1hIYoJTyK1DLP9s46qw4VI0MyDS1bdPKdHWVewZiIUTHEok5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxc/b5MBXxYBY7r8W8lqFgeqEB9988tTDe8NesdUoEI=;
 b=vJeFSvHB5CGgQcDu1JUuF6SiURKqtrDtiJ51dEv21hrUJUhCf2hNCvosHQFkB/QhUYHO8VitUOvJQsmJyKikkec6EZal0V0eESvAac+quRCUHnEUmtFJCBCgdA5pCirpXrvDeYuRAiK7/DV7b2+FGueFYm0Kw5EVm9UBRHDq0Hw=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3612.namprd12.prod.outlook.com (20.178.199.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.22; Wed, 14 Aug 2019 21:17:41 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 21:17:41 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Thread-Topic: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family
 15h/16h
Thread-Index: AQHVUuW0/upDXQeDUkyQJLUEYNL76Q==
Date:   Wed, 14 Aug 2019 21:17:41 +0000
Message-ID: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN6PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:805:de::15) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9527c2c-4b96-4330-e67e-08d720fcd75b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3612;
x-ms-traffictypediagnostic: DM6PR12MB3612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3612D15B363047B249B18F9EECAD0@DM6PR12MB3612.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(7416002)(7736002)(2616005)(486006)(25786009)(476003)(3846002)(6116002)(14444005)(256004)(102836004)(50226002)(2906002)(8936002)(305945005)(54906003)(110136005)(99286004)(71200400001)(52116002)(71190400001)(386003)(6506007)(4326008)(2201001)(478600001)(81156014)(66556008)(64756008)(66446008)(316002)(118296001)(26005)(81166006)(66066001)(5660300002)(86362001)(8676002)(6436002)(36756003)(6486002)(2501003)(53936002)(66946007)(186003)(66476007)(14454004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3612;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SmpOrkqgqxRdkcKwMdHb+4VYXFW8uec608uPfuKAJ6Gzf/YxiJWDcixSHgdVbmepTYOHSyXOExuMjKIVkapjD5m+5rU4RBSS04WevmDK2/O5eRwB1er59rNQ2Q3m42hmo+g2HDbJkbpNfnxy362NKO+CMkYxlk+L4GmUoBQQvJfxrzKi50ZSASMEFx2Xb/jgE1TrzgbtIqPEX3hAtdHy7FXThyhYV9CMH9NQzTK3sPYY4EDpmyGbjBW9j/TcPFgCVVlZOxf+5rRa3vWFvogDygs0lPE640S/4vOkxMCSLCRyH6zsJgPEnqM3IfpSq9nkuMH1CsbGzKn6CX1iwxtrbsm/8T1n/0nlZbKl4ltAfnQDG6LU5srHWHYPnO5EARIHmtGJxzevMVWQRtj75shhVaQPB6TnFHxyZdCTvlY5Ttk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <533022FAEB72864080AFE58FAAD5CCB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9527c2c-4b96-4330-e67e-08d720fcd75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 21:17:41.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LSAjM1/gvUum1Uj3ivbLULanpmyWK7kw2/3hJl0bY8L4+4nE1Fva5ghMahCNgx4LgHuWLvDyvR0V7L6qnHRAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

There have been reports of RDRAND issues after resuming from suspend on
some AMD family 15h and family 16h systems. This issue stems from BIOS
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
 .../admin-guide/kernel-parameters.txt         |  8 ++
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/kernel/cpu/amd.c                     | 42 ++++++++++
 arch/x86/power/cpu.c                          | 83 ++++++++++++++++---
 4 files changed, 121 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 47d981a86e2f..f47eb33958c1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4090,6 +4090,14 @@
 			Run specified binary instead of /init from the ramdisk,
 			used for early userspace startup. See initrd.
=20
+	rdrand_force	[X86]
+			On certain AMD processors, the advertisement of the
+			RDRAND instruction has been disabled by the kernel
+			because of buggy BIOS support, specifically around the
+			suspend/resume path. This option allows for overriding
+			that decision if it is known that the BIOS support for
+			RDRAND is not buggy on the system.
+
 	rdt=3D		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h
index 6b4fc2788078..29ae2b66b9e9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -381,6 +381,7 @@
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
+#define MSR_AMD64_CPUID_FN_00000001	0xc0011004
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3afe07d602dd..86ff1464302b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -804,6 +804,40 @@ static void init_amd_ln(struct cpuinfo_x86 *c)
 	msr_set_bit(MSR_AMD64_DE_CFG, 31);
 }
=20
+static bool rdrand_force;
+
+static int __init rdrand_force_cmdline(char *str)
+{
+	rdrand_force =3D true;
+
+	return 0;
+}
+early_param("rdrand_force", rdrand_force_cmdline);
+
+static void init_hide_rdrand(struct cpuinfo_x86 *c)
+{
+	/*
+	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
+	 * RDRAND support using the CPUID function directly.
+	 */
+	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)
+		return;
+
+	msr_clear_bit(MSR_AMD64_CPUID_FN_00000001, 62);
+	clear_cpu_cap(c, X86_FEATURE_RDRAND);
+	pr_info_once("hiding RDRAND via CPUID\n");
+}
+
+static void init_amd_jg(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Some BIOS implementations do not restore proper RDRAND support
+	 * across suspend and resume. Check on whether to hide the RDRAND
+	 * instruction support via CPUID.
+	 */
+	init_hide_rdrand(c);
+}
+
 static void init_amd_bd(struct cpuinfo_x86 *c)
 {
 	u64 value;
@@ -818,6 +852,13 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 			wrmsrl_safe(MSR_F15H_IC_CFG, value);
 		}
 	}
+
+	/*
+	 * Some BIOS implementations do not restore proper RDRAND support
+	 * across suspend and resume. Check on whether to hide the RDRAND
+	 * instruction support via CPUID.
+	 */
+	init_hide_rdrand(c);
 }
=20
 static void init_amd_zn(struct cpuinfo_x86 *c)
@@ -860,6 +901,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x10: init_amd_gh(c); break;
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
+	case 0x16: init_amd_jg(c); break;
 	case 0x17: init_amd_zn(c); break;
 	}
=20
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 1c58d8982728..146c4fd90c3d 100644
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
@@ -409,19 +409,27 @@ static int msr_init_context(const u32 *msr_id, const =
int total_num)
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0; i < total_num; i++) {
-		msr_array[i].info.msr_no	=3D msr_id[i];
+	if (saved_msrs->array) {
+		/* Copy previous MSR save requests */
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
@@ -436,7 +444,7 @@ static int msr_initialize_bdw(const struct dmi_system_i=
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
@@ -451,9 +459,58 @@ static const struct dmi_system_id msr_save_dmi_table[]=
 =3D {
 	{}
 };
=20
+static int msr_save_cpuid_features(const struct x86_cpu_id *c)
+{
+	u32 cpuid_msr_id[] =3D {
+		MSR_AMD64_CPUID_FN_00000001,
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


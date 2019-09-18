Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22E7B683C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfIRQfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 12:35:04 -0400
Received: from mail-eopbgr680067.outbound.protection.outlook.com ([40.107.68.67]:39077
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbfIRQfD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 12:35:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz95R/mTwT5cS+d/vrmGfqdRRu+ZWop7F8/D5BCSCWPr4gnkVd3LNteGNzckrqoIPXcEoLHzQnqMTFF8b1GML7kf92+IM3gxe05L6N+duTbupYtTtjv2pzLnRUl6Z2Fh7++BoQlN0nab6F0yO8UN4jcFlqW0UP1X4XxjVdarKVqJgmyvqzgqfgiU0BcSd7Y6uCP1rE+dOE4DPO1k7gt4H3NNRmq6aiodEHfuikq6fd3NQT2DnMEnX4S9YALDLICr2RlR0CtJz3kCLd0jUYSHiv//W13VdwI7L39oM7MyPbX458Ykw56WBNoUe4qlcRZ6BSS4RGUvyuGCTdGMQob5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hduTgWIiFppcB1vbJEnSVFfBPqfPrnsL/zGlB8y8Gp4=;
 b=hdVvunUe/SjxpFW1gg1XZwmKpx5Pw7piOVx3E5Wfy1B/1gzbCygXYtfW8wZ77Fn9LQ+BI92H8T5KNMLn9fXxjuG3m7Sum0/ACMSxZqB4q8Zaw/SlmkcbKNaexNwxXWd56o95V3uvte5GB6C4lq7+BYoECQxeMZwo4OvqnRovjTVrg8Zt0B4M2STLSxAYS0ETgogjdIiMZSu1ZFrcIyyQH9bKO1WXQP8tblI+upkO7fbHhs2w3bgRnBvC3KzZXWtZfPbjIBfe2p3NDT5ERMJDtLEMGz4huymfao5Klwuh6E9J8vgEM2nyZvmfJYphkIfSDpiQZktyPE7pxkE5D37tLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hduTgWIiFppcB1vbJEnSVFfBPqfPrnsL/zGlB8y8Gp4=;
 b=G9WtOfnBJ1CLVymEXqTf3+qCEZJCWBL76ycekWrq2yePPLnG95YllZTVivgl+vU5Bk/GVKSfGxkzCPY0ygDz+sMIxA9OnzTyhCs/Zss0AL2CupVueiv/00HZsAFwY0Vl8QXD79BtgEd/cscGo9N9MvPVaUhyANp6LHyRWDnYiEk=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 18 Sep 2019 16:35:00 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfd:68de:f647:8b1f]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfd:68de:f647:8b1f%7]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 16:35:00 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Pu Wen <puwen@hygon.com>, Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 2/2] Update cpupower to use the RDPRU instruction
Thread-Topic: [PATCH 2/2] Update cpupower to use the RDPRU instruction
Thread-Index: AQHVbj8CkLjjoC195k6Z0xrn14yRmA==
Date:   Wed, 18 Sep 2019 16:34:59 +0000
Message-ID: <20190918163445.129103-2-Janakarajan.Natarajan@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
In-Reply-To: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc16f252-59c6-48d5-e313-08d73c56253f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:|SN6PR12MB2815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815719BC02262F8FB2CC602E78E0@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(66446008)(64756008)(316002)(66476007)(66556008)(446003)(7416002)(25786009)(11346002)(305945005)(7736002)(476003)(2616005)(486006)(26005)(186003)(76176011)(99286004)(1076003)(52116002)(6506007)(386003)(81156014)(86362001)(102836004)(81166006)(8936002)(50226002)(8676002)(2501003)(66946007)(4326008)(478600001)(14454004)(6486002)(110136005)(54906003)(66066001)(3846002)(2906002)(6512007)(71190400001)(256004)(36756003)(71200400001)(5660300002)(14444005)(6436002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Ifvlyea1XI9BXqRtFTh9PGTYp6KPL7N73f8rsJdAy9I93J8RWxTyM6Od7XGEj+OKQs6vsTNq5BN9OO0Ga8OabzsgVNWvQD7p2d/YvYsBoBsUCp642veWjD/2cAyBNcGDYNUP7Cb/w/j54l9BGQ2SnmAJ0VPetWMNP5qtIbO07+28+vdiB5azJ0IpEkhMbBv9GkZQeagDXEiPKcVEHDEJYE0/i7pX7nUT3FCaYY1wsIFt6wMLFp4TwhFn9fGQ/DBOH2IW4TaYzVW2V5pIF20/KPaZgWNNkZn/nk8x60of04GNRibxnZikWe5JCPT3SsPeEyc9f9sQukeOziSdoVmFRfsiZsxBXNuCwGGEPx/8iDMyxcM/CUx8zjSX9aTXkA7fIMCppGnnqRDi/CDYe/7oW5Gea3zhlTRRlLOGYL5s+I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc16f252-59c6-48d5-e313-08d73c56253f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:34:59.1439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKR4N3l6D+wEuSwJ2d3uS39375Zn4gz2cW6fFdACYhxWag6twcDDwuZxqJgzFRT422qnu3W0CDacaaZnEDXvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AMD Zen 2 introduces the RDPRU instruction which can be used to access some
processor registers which are typically only accessible in privilege level
0. ECX specifies the register to read and EDX:EAX will contain the value re=
ad.

ECX: 0 - Register MPERF
     1 - Register APERF

This has the added advantage of not having to use the msr module, since the
userspace to kernel transitions which occur during each read_msr() might
cause APERF and MPERF to go out of sync.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c    |  4 ++++
 tools/power/cpupower/utils/helpers/helpers.h  |  1 +
 .../utils/idle_monitor/mperf_monitor.c        | 20 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupo=
wer/utils/helpers/cpuid.c
index 5cc39d4e23ed..73bfafc60e9b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -131,6 +131,10 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >=3D 0x80000007 &&
 		    (cpuid_edx(0x80000007) & (1 << 9)))
 			cpu_info->caps |=3D CPUPOWER_CAP_AMD_CBP;
+
+		if (ext_cpuid_level >=3D 0x80000008 &&
+		    cpuid_ebx(0x80000008) & (1 << 4))
+			cpu_info->caps |=3D CPUPOWER_CAP_AMD_RDPRU;
 	}
=20
 	if (cpu_info->vendor =3D=3D X86_VENDOR_INTEL) {
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpu=
power/utils/helpers/helpers.h
index 357b19bb136e..c258eeccd05f 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -69,6 +69,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN =3D 0, X86_V=
ENDOR_INTEL,
 #define CPUPOWER_CAP_HAS_TURBO_RATIO	0x00000010
 #define CPUPOWER_CAP_IS_SNB		0x00000020
 #define CPUPOWER_CAP_INTEL_IDA		0x00000040
+#define CPUPOWER_CAP_AMD_RDPRU		0x00000080
=20
 #define CPUPOWER_AMD_CPBDIS		0x02000000
=20
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tool=
s/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 8b072e39c897..faee00c078b0 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -20,6 +20,10 @@
 #define MSR_APERF	0xE8
 #define MSR_MPERF	0xE7
=20
+#define RDPRU ".byte 0x0f, 0x01, 0xfd"
+#define RDPRU_ECX_MPERF	0
+#define RDPRU_ECX_APERF	1
+
 #define MSR_TSC	0x10
=20
 #define MSR_AMD_HWCR 0xc0010015
@@ -90,6 +94,8 @@ static int mperf_get_tsc(unsigned long long *tsc)
 static int get_aperf_mperf(int cpu, unsigned long long *aval,
 			   unsigned long long *mval)
 {
+	unsigned long low_a, high_a;
+	unsigned long low_m, high_m;
 	cpu_set_t set;
 	int ret;
=20
@@ -100,6 +106,20 @@ static int get_aperf_mperf(int cpu, unsigned long long=
 *aval,
 		return 1;
 	}
=20
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_RDPRU) {
+		asm volatile(RDPRU
+			     : "=3Da" (low_a), "=3Dd" (high_a)
+			     : "c" (RDPRU_ECX_APERF));
+		asm volatile(RDPRU
+			     : "=3Da" (low_m), "=3Dd" (high_m)
+			     : "c" (RDPRU_ECX_MPERF));
+
+		*aval =3D ((low_a) | (high_a) << 32);
+		*mval =3D ((low_m) | (high_m) << 32);
+
+		return 0;
+	}
+
 	ret =3D read_msr(cpu, MSR_APERF, aval);
 	ret |=3D read_msr(cpu, MSR_MPERF, mval);
=20
--=20
2.17.1


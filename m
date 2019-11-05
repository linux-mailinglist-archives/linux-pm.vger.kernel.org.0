Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1EF03ED
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 18:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390373AbfKERRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 12:17:13 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56513
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389901AbfKERRE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 12:17:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLAho5RXQGsxLilJ+6WxlbxmNQam1SV0zlw/7Tn/bWgVf75jjO8i7Ua5vqmhETYnVwEFxphX+H+2KbgnhUQdlfs++G/Y59kxNQx+29UcoPvnzm0mz4vk0OTr1cqVhrH0GRk+++49PXYefkY5uBVSzx6mV46KsJiB52mflxpZqaDPhld1vCzg4EdxnNBcsAHezb1MVK9v6r+m8ak6LHVcggKBvzZl+XDhE/kKqFmq5t4JUY0WvXRSQL8eeocu/bSWULadSeAIy3jprXXpMg0utsOYlBUiXNakc7vUiI1S6+JTZn9XFY1TDbKwWkp98iHUTwmMvf+UoQ5Z4soDJQZO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK1do0UMvZg1l4rp6NXADndfvRnIZug9mRlyJZXTBv8=;
 b=I2B+RZykzUD7DF8MPnLh/yfJGJfk8kvYVHAgvZn+LrQadMRw2Z+cjU8Cw4tVVpwaiP/bKYwBclJfRpbmKKY3w+AZbfqb1H0I/us3ivfay/eBYiUiH5gaa0lA27Fk7y3VJV63FwmaanjAJha51q4e3DLRp2srZLNrNlJjrN0xtqu9VoBzinBR3YABmdlA051TiYoy7xYvkDPlcg60OsCNzrr/sYKMbi7wJ6irAs3p8Zyqa+/RxlCCIVU8oYWO9ck57tvwveAJvGMQ4ne8g0/vwzAsaJ4rNz+uDW0zm2LJcYZ/fQTAjVywVGeY+hi0U7inppmIfBkwoB1Ykn4qQNxxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK1do0UMvZg1l4rp6NXADndfvRnIZug9mRlyJZXTBv8=;
 b=fKPu7I6QKVr/bouN1Es5I9PPEtCmOKdFUjjYkHReHQD7DH1pR61Z2QytmiO01QhLFb2iFgl0imalk/4qPtK4hFoxt2EFhs2gmVsDO4RWjh6NprfU6jetTLgivG+nGs8nhxAjNFAaHpTCAE7rzWHU4ZPuaRZLU4SwHX143Io7zsg=
Received: from BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) by
 BN7PR12MB2786.namprd12.prod.outlook.com (20.176.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 17:16:55 +0000
Received: from BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2]) by BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 17:16:55 +0000
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
Subject: [PATCHv3 3/4] cpupower: mperf_monitor: Update cpupower to use the
 RDPRU instruction
Thread-Topic: [PATCHv3 3/4] cpupower: mperf_monitor: Update cpupower to use
 the RDPRU instruction
Thread-Index: AQHVk/zSL+q9KumTBEmBzP52ALZGsw==
Date:   Tue, 5 Nov 2019 17:16:55 +0000
Message-ID: <4d3fa3e39dfee029715f1f787c880485943594c9.1572972259.git.Janakarajan.Natarajan@amd.com>
References: <cover.1572972259.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1572972259.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:5:15b::32) To BN7PR12MB2723.namprd12.prod.outlook.com
 (2603:10b6:408:2d::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79e58b12-d534-48b3-0c12-08d76213f533
x-ms-traffictypediagnostic: BN7PR12MB2786:|BN7PR12MB2786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27862B76E27B08C143E3AB25E77E0@BN7PR12MB2786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(66476007)(8676002)(486006)(186003)(64756008)(110136005)(8936002)(2616005)(4326008)(2501003)(76176011)(102836004)(14454004)(52116002)(25786009)(6506007)(66446008)(256004)(86362001)(14444005)(5660300002)(386003)(99286004)(36756003)(316002)(50226002)(54906003)(26005)(81156014)(81166006)(11346002)(446003)(476003)(478600001)(6436002)(71200400001)(71190400001)(6486002)(118296001)(6512007)(66946007)(66066001)(7736002)(3846002)(2906002)(66556008)(6116002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2786;H:BN7PR12MB2723.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCRX/WDOzpwltN8Z3hmwCN6iTwWfRpEfipReJ/wwjcS4sQtfsW2idedbbgJO86DhGHXfLFr6xocd2jANBWo/Pst48JOhcdnh7EBYOQTaZta44unL4ib017gq70LdoTZiiNYNEkDQyClo9NhqgYbXx42knfdrvNdElZWOq9ieamm8ch0LsP8PO4q0ArV8xKm9bLhPsKIGiremhZ+OTXXikbgZVS3mH02ncAda9+lPluxqE8KdiJZTThqYKttqiu+Rmi15ydlNwPor1QMINDnQolvlYIztcsYLgTFij6JinrLC3T3JjqVogGyQ8I6y7ufMJzgl376K/dtbhh2gerDyoOSpspqgndYcab2yUpvs3C6pF9/yjPupK7HZ4G2o4YBDV624C/kftKLoY67sPHQS97Zx7QQychD/+npAs7gT+qHytqFdSVNI+o/3ks5nUUu1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e58b12-d534-48b3-0c12-08d76213f533
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 17:16:55.6139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFtT7JVG8wSHWyEcDlSvFmN+TLBJAQ7Q5bJOo/Jzn4lRsy3mSHx+AzYqJgSsl/wMH4ZP7smVaGtLLM4me8eSjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2786
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

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
index afb2e6f8edd3..e7d48cb563c0 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -19,6 +19,10 @@
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
@@ -89,6 +93,8 @@ static int mperf_get_tsc(unsigned long long *tsc)
 static int get_aperf_mperf(int cpu, unsigned long long *aval,
 				    unsigned long long *mval)
 {
+	unsigned long low_a, high_a;
+	unsigned long low_m, high_m;
 	int ret;
=20
 	/*
@@ -101,6 +107,20 @@ static int get_aperf_mperf(int cpu, unsigned long long=
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
 	ret  =3D read_msr(cpu, MSR_APERF, aval);
 	ret |=3D read_msr(cpu, MSR_MPERF, mval);
=20
--=20
2.17.1


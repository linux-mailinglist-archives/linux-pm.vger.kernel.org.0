Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB605D4886
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfJKTiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 15:38:05 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:9201
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728855AbfJKTiE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 15:38:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9fHagc0iVsfEOQTbKn6ZnUbqndBBkKI3IFADStGFcijTMDK1qediz9MeC63xV95ao047P9hVembWG3U5spkdFq/ltooti0cIYr7FH8M+PA3zakfy5TTIvhfKWH06LpuYFcpVioP8Z2EyjP8MMa9vh9dU12pxPcfQupSAGrMR46jLo+9FjxsL2eQqFVEj5y0A57L0ekukK5ebLPkDqCjOotUT8eNUNgCl1KWGJumROXZG4bnv3EGvuwrg8bQR49UZ4SFObzs3lel38Ls7L4VvsUWPONLbPBUSB6EO8ugGY1nXKvTcDllmNgjZGE8XTSW+ufo8DlIQDyg/7OUjijuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yReWJ4dZmW/J+JEredsPyL3lErY8lOxXgyyHf5MN9MM=;
 b=Av4TDkB7p5npym2zHRvCbfXOlKt+Qui6zAka3rM0H+Me7g1k9s/YRRc2W6GtlWbaCDYKArKtwSwgPJeLLoUlA4ONfSIzdHp6GVx6vMCTZ2DAB7DvvR0Ca3y/bJ75s/TLGrMPOtslJNBzZzyDIgVEFYgdujBBP80Ihu0yIyyf5qnLdw9wEZ3UlOQTCInrrrLaHHg3Ti/kpIXMWh9FrK8S2No5BnTSO2Cu4OQGYWK7RotBcn72ErxrKov6rNI9dwN8sbdo/8JTqTQ0uT0YLthHla78dW1sCUCOO+mRJNS1d90mCxtn6v8vkHJKqCsZoR985EqBTz4Q+O5SBNH/Mu21CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yReWJ4dZmW/J+JEredsPyL3lErY8lOxXgyyHf5MN9MM=;
 b=YJ6hRpYJbBrKazMp+P6OfzV31I/hif/h56rGqWT9rm3JlFAvbBUnF6f+OGuXYA1a7seK2uYTPyI+yrh4gEMRxK+Ho4wkJrgHonL0ztZ3UZdpKfbWfIDZkYV5+dZeafpVf9sgkPcrAtplUF9rt/H1lb3yAndkeCeZf2kE7FnA9z8=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 19:38:01 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 19:38:01 +0000
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
Subject: [PATCHv2 3/3] cpupower: mperf_monitor: Update cpupower to use the
 RDPRU instruction
Thread-Topic: [PATCHv2 3/3] cpupower: mperf_monitor: Update cpupower to use
 the RDPRU instruction
Thread-Index: AQHVgGthg6tj/ze14EONVJfxrVQgLA==
Date:   Fri, 11 Oct 2019 19:37:56 +0000
Message-ID: <7e36d927d8aa9a956b3cb7d9c65df4354f5fd490.1570819652.git.Janakarajan.Natarajan@amd.com>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c62563-dce0-488f-d095-08d74e8283f0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2816:|SN6PR12MB2816:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2816007E22B6573DD688916FE7970@SN6PR12MB2816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(386003)(7736002)(14454004)(6666004)(6506007)(36756003)(11346002)(6116002)(476003)(2616005)(2501003)(478600001)(25786009)(3846002)(446003)(486006)(2906002)(52116002)(66556008)(66946007)(64756008)(99286004)(102836004)(66476007)(66446008)(76176011)(186003)(26005)(7416002)(305945005)(118296001)(6512007)(316002)(8936002)(8676002)(6436002)(54906003)(110136005)(6486002)(81166006)(81156014)(256004)(50226002)(71190400001)(71200400001)(4326008)(86362001)(66066001)(5660300002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cekM5Gpw3VobxiICJqUsNwxWAl4+jMS2/zJ49l8OfROxqGlkkP36sQ9EqaNLunYUZkDIVvhPUoAebdk14nb8gn32KO0ZT6E6HRTbDh+l7Y0b2DiN9jOK0e2nwArsVYk9VCmF4+BD1dRgZ4CTDPDLnlivr3W5QJkiJ7A9aB3zT2HOo0X/Nn2akzSK3KKE0YlLm6zwbEn7fwfssd9SkqvilLCOuF1O8KPouZcVwOyBhVdZ2z0Wd5eqZsh+y7cY/yFSl6SHqUfR3mNqovTgMx8VjtFttxCV8NN6ma42RzHhVBqYTB++jsgRisIPUwRmeVbNQskJwQ+1egZiHEolWiDEWeFNzJAY31BVrw/V81Oby615S7r3EywKr6rFp/xs4ry6MJlCQNidR4ac2UYfVN0+utbWRFj7bJmKZCLbuYCJPQs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c62563-dce0-488f-d095-08d74e8283f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 19:37:56.6244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhyXvaZE3IpiztW7iImg0ecRPdhAkhOJmTmfu1beGl9oZjRPchqM52veEX+VHksc90n0TQJAN3bXZd/xwjECCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
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


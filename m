Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F1B683A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfIRQfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 12:35:02 -0400
Received: from mail-eopbgr700052.outbound.protection.outlook.com ([40.107.70.52]:33376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfIRQfB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 12:35:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1sYaLhKT0L6bmdvFfn3JALGQMFhawyzDvly6kLI2hFjG7VtqIrpd3EYWaIYLK4lOw2/lSMZMeaBkC4LKViD5TrrX0LbRRlW1WJUTU2pgVYoDg5Wniz5cchY+hVL3MBAgWqG+YVLXS3EmorHJRag22ZBj/ASTkp9Han8Q9SsF5ViQuFkqtj6RDRmD4F++2aZnuclm20V14iG0TffuTdh6fpPnRnZVCt43r2A8qlCjUGmAneZZNEH+Xk/3WZYxAqXVjSWrVC316qxJpu/2ywhxmGSPfSGaGAyzsJ3vklyI1D7rUWw/UFBu+AUHs2T0B5cJa7nWeLW2vqeYICXXWibdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwzCOjwhf0PbXHtzqmAZ3eLJgT4OkrEfC0Jgm5CffY4=;
 b=IibXulgswwEwB3/jyz7rMMCSwnrYhcu8uWUddMa3Cj1BLpgM1+zkD742QW3pkQYMCI4OZF2G+VpxgQDuN2B+50qKFF5rhrI/lfHg6FVBVc2yf6btS98FdrDwrBMY/aRVakuNm2UcRvXV1QoFgQYcpFOlKh6vpeoJGaDW4xIaXYiTcPWp6RzruJZJBV24WCA4xrMGacClRVq/Klf3IkURV+LqQZhcMsfM4BOO03afCa1uvQpKXaxCphNCh333NxRZjF51NJ9gL23mJuTg78WVTlfkqVIE5y8D6wz0icSLUUTm+VRvVlJGYq4jmfn30EfcszRx40f2IE22InQz+7yMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwzCOjwhf0PbXHtzqmAZ3eLJgT4OkrEfC0Jgm5CffY4=;
 b=miBeeSVz8PHONDK/55e8xsAAyguRiscor0tCtK69YgJ0+oLrQG6P8Nvf0sV4WCbJ/ov5xsRhOUzkZadZOQycUqDPQtj0yvIzQf2QDdCG8aNEL6GG/rOO3whtRqR2D2kNhxl1WTUAz1avq6zJifUUpXZNPQb49PoZvpLrfZZwT/Y=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.102.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Wed, 18 Sep 2019 16:34:58 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfd:68de:f647:8b1f]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfd:68de:f647:8b1f%7]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 16:34:57 +0000
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
Subject: [PATCH 1/2] Modify cpupower to schedule itself on cores it is reading
 MSRs from
Thread-Topic: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Index: AQHVbj8CzXj8hQvM60aQ8slBTBcq3w==
Date:   Wed, 18 Sep 2019 16:34:57 +0000
Message-ID: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: f325311e-4a9b-4ab2-a1ae-08d73c56248b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2605;
x-ms-traffictypediagnostic: SN6PR12MB2605:|SN6PR12MB2605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26058EBBFFBA1197E15EBF60E78E0@SN6PR12MB2605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(189003)(25786009)(110136005)(81166006)(6506007)(186003)(1076003)(478600001)(71190400001)(36756003)(66066001)(50226002)(71200400001)(81156014)(66476007)(64756008)(316002)(66446008)(6512007)(7416002)(66556008)(4326008)(66946007)(102836004)(8676002)(386003)(52116002)(6486002)(26005)(6436002)(86362001)(476003)(7736002)(54906003)(14454004)(8936002)(305945005)(256004)(99286004)(3846002)(5660300002)(486006)(2906002)(2616005)(6116002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2605;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lkwvsA/CmlOatuXih+GMb2EG6d22Takqx18+rJq5ixHa1AZVdf8Lp5ovVNcjJV7TNXt5Fqx9SkZWWz85/u1F1FQK0T1I80H0RorbNdXEFMN87y00FTldfg6ILyxMAHQg0cSAsIv3LDlgm6gv0Zh5nXvF0hQ+YLSylDXWGACgLTnkPtOjhshg4qiYlsIoGQNBOjErAw5ShuXqapLlFULUM5APO8EFHEQefdF/nBCAU62VC1o9EMKxHjnebLP367o8aI45xUrLb3yuTPeIhVjconcrTAsySTozCa5tZOQoHKrJq2xmDvDrRtOki/v1YFE2aAzukWENgZ9mQc52H5B54SiZET2xkhnj69bXffw2qQfuvO7dSa3O8QVPnm9XOnGgxbU1RLw/4u5NYfWlgZDtQ25wNV8x/nWusCe7q4UEWb4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f325311e-4a9b-4ab2-a1ae-08d73c56248b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:34:57.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWFoT12rY+X7kJCAeNkPLdfkc2OcywuMV5MbuOIeMHkJipo6+R5EbJIRbF1/I4OqpQYDzGzT0t+aUMbSlEPMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Modify cpupower to schedule itself on each of the cpus in the system and
then get the APERF/MPERF register values.

This is advantageous because an IPI is not generated when a read_msr() is
executed on the local logical CPU thereby reducing the chance of having
APERF and MPERF being out of sync.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 .../utils/idle_monitor/mperf_monitor.c        | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tool=
s/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 44806a6dae11..8b072e39c897 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <limits.h>
+#include <sched.h>
=20
 #include <cpufreq.h>
=20
@@ -86,15 +87,33 @@ static int mperf_get_tsc(unsigned long long *tsc)
 	return ret;
 }
=20
+static int get_aperf_mperf(int cpu, unsigned long long *aval,
+			   unsigned long long *mval)
+{
+	cpu_set_t set;
+	int ret;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	if (sched_setaffinity(getpid(), sizeof(set), &set) =3D=3D -1) {
+		dprint("Could not migrate to cpu: %d\n", cpu);
+		return 1;
+	}
+
+	ret =3D read_msr(cpu, MSR_APERF, aval);
+	ret |=3D read_msr(cpu, MSR_MPERF, mval);
+
+	return ret;
+}
+
 static int mperf_init_stats(unsigned int cpu)
 {
-	unsigned long long val;
+	unsigned long long aval, mval;
 	int ret;
=20
-	ret =3D read_msr(cpu, MSR_APERF, &val);
-	aperf_previous_count[cpu] =3D val;
-	ret |=3D read_msr(cpu, MSR_MPERF, &val);
-	mperf_previous_count[cpu] =3D val;
+	ret =3D get_aperf_mperf(cpu, &aval, &mval);
+	aperf_previous_count[cpu] =3D aval;
+	mperf_previous_count[cpu] =3D mval;
 	is_valid[cpu] =3D !ret;
=20
 	return 0;
@@ -102,13 +121,12 @@ static int mperf_init_stats(unsigned int cpu)
=20
 static int mperf_measure_stats(unsigned int cpu)
 {
-	unsigned long long val;
+	unsigned long long aval, mval;
 	int ret;
=20
-	ret =3D read_msr(cpu, MSR_APERF, &val);
-	aperf_current_count[cpu] =3D val;
-	ret |=3D read_msr(cpu, MSR_MPERF, &val);
-	mperf_current_count[cpu] =3D val;
+	ret =3D get_aperf_mperf(cpu, &aval, &mval);
+	aperf_current_count[cpu] =3D aval;
+	mperf_current_count[cpu] =3D mval;
 	is_valid[cpu] =3D !ret;
=20
 	return 0;
--=20
2.17.1


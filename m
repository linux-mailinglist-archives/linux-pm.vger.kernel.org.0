Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED2F03E7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbfKERRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 12:17:04 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56513
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389105AbfKERRD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 12:17:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikJYA0aApXi730NECE44PoHlle4dPm4jUC8w680hhJ4a2qAV7y0D+DToNjmtZoATYhFPi0ubG+zvhI/YgJ2TNaCi1Sa6gpLDTpHWMfHt3yzoUDdoQC0Px8KOxNQ8IBsPaT60EhgxFrhG4ugBhzxK3dN6hvi4xuV/sXsm+yeNbJP4XlRHuoZM3sXrdeMz+XnErleS78ZnRRKI14kIoxk8RDXuxsxb064ivtpN7UAG52hzl6o0WyHJBXB25SK/tS/1Oshq5RJEZ/SkZGsQeyYbGHzsXNxxfGayYtpSOttNtDmErLA/b1ye3JOG6H/eLnGou6xgUjJ6wmm8kFg1Krzhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MnQA7XwtiG6sNawd4xNB7L/UvJZe7u2DpyyjLMqtBI=;
 b=kGsvHlOOJ/LWnDsNYZJc3f3SEw6wjdzWat8CXpKEXJnw9hbqj6oxRnk4/BS+5MHrtWXqqGfg4JHxttE0Xfrx/K5iEP2bwUMEiylgoukbEg/cwonFmNN6kyxDuQ2DPd5+1/u8e7i7lZidIl4rfPBAbQwF2im1KNfsPVQpbGr9GcEqeaYzW4J3MxJWds6Y8hoTIFYCl9ZHMMvoCwLZinrOzwFViPc810REyysx8bysyRwMJSVxrlz6FxVIdwuXpzP7gJW63VSVRU2Jk5UsQ3A7Nk3G1IPE9aBJs9imQ32/SysoCUSZORHxFZcStnz/LeiS7sjdzNtp9ssjiEcPpsco+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MnQA7XwtiG6sNawd4xNB7L/UvJZe7u2DpyyjLMqtBI=;
 b=UM1uWtgcU9ZyF4KbusBEg3UH4LHQcyaS7Qw9M/KftNN34CI02ulzt7cAUquMdBF8hK6hMWnLZmz3XF647a9DBFCZVjdFeDR2MskneBKAB/EkA8Hi8kq1WyEOBRN0c0FlX1uFIqak883NhvneWYPhmcfvpMoeGzegFIWER1Mgexc=
Received: from BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) by
 BN7PR12MB2786.namprd12.prod.outlook.com (20.176.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 17:16:54 +0000
Received: from BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2]) by BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 17:16:54 +0000
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
Subject: [PATCHv3 2/4] cpupower: mperf_monitor: Introduce per_cpu_schedule
 flag
Thread-Topic: [PATCHv3 2/4] cpupower: mperf_monitor: Introduce
 per_cpu_schedule flag
Thread-Index: AQHVk/zR+vnkD5VtgEqElxquzH70xA==
Date:   Tue, 5 Nov 2019 17:16:54 +0000
Message-ID: <80f9f97d26896d18fcdbff20fd70d2e7ff2066d6.1572972259.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: f05e3ae7-436d-40a5-c86c-08d76213f44a
x-ms-traffictypediagnostic: BN7PR12MB2786:|BN7PR12MB2786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2786717040D651C0D6DCF930E77E0@BN7PR12MB2786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(66476007)(8676002)(486006)(186003)(64756008)(110136005)(8936002)(2616005)(4326008)(2501003)(76176011)(102836004)(14454004)(52116002)(25786009)(6506007)(66446008)(256004)(86362001)(14444005)(5660300002)(386003)(99286004)(36756003)(316002)(50226002)(54906003)(26005)(81156014)(81166006)(11346002)(446003)(476003)(478600001)(6436002)(71200400001)(71190400001)(6486002)(118296001)(6512007)(66946007)(66066001)(7736002)(3846002)(2906002)(66556008)(6116002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2786;H:BN7PR12MB2723.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O37YMYKpaer6V6OSWxj0JTOUPaLwiqRtXmXabbpsmEcytOH/2xQbX3THXgVxQtS0E0NmKtRF0ze/Ui1noUsykN720TcTcf4bOV3+Dp6YI6vpgvMqwv7wI+YH+ezybN1zwq4Syh2GArbNK+HayEBuzD8yemMR2N2YAa2gllPqalqPWPY25r2cnAutUdxrA8K0bN5/zJ8F8mTg322tlRu+0WaD7jJP51ApOtMwSEKND22mraWQvty+GAb2v7y+ZivHGmSCZpiOFLbAyYzucE7Hr48LpwcYah+OoDv+3SXDy86qD5XfKmYnNnKuQTo4EISf/5OusfET6zz9WyjY/KGe4bEYVFVYT9aBowko2Lf0lMxAy+kgVJEQHsqRET+jMXsYL2MEL2UbUVdZ7GW5isuRoNYodq/WYRdukhdo5kaYQc1OsA9pU61qT10J8f4dgOF5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05e3ae7-436d-40a5-c86c-08d76213f44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 17:16:54.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1po9gGHc7l9ATVns8iZ/jG11Za0FwQrj0biZuYUmMy1MLBTLDqAozy6J5o10pa5OCCus463rqVotoCqtRy1IcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2786
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

The per_cpu_schedule flag is used to move the cpupower process to the cpu
on which we are looking to read the APERF/MPERF registers.

This prevents IPIs from being generated by read_msr()s as we are already
on the cpu of interest.

Ex: If cpupower is running on CPU 0 and we execute

    read_msr(20, MSR_APERF, val) then,
    read_msr(20, MSR_MPERF, val)

    the msr module will generate an IPI from CPU 0 to CPU 20 to query
    for the MSR_APERF and then the MSR_MPERF in separate IPIs.

This delay, caused by IPI latency, between reading the APERF and MPERF
registers may cause both of them to go out of sync.

The use of the per_cpu_schedule flag reduces the probability of this
from happening. It comes at the cost of a negligible increase in cpu
consumption caused by the migration of cpupower across each of the
cpus of the system.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 .../utils/idle_monitor/cpupower-monitor.h     |  1 +
 .../utils/idle_monitor/mperf_monitor.c        | 42 ++++++++++++++-----
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/t=
ools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index 9b612d999660..5b5eb1da0cce 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -62,6 +62,7 @@ struct cpuidle_monitor {
 	unsigned int overflow_s;
 	struct {
 		unsigned int needs_root:1;
+		unsigned int per_cpu_schedule:1;
 	} flags;
 };
=20
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tool=
s/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 7cae74202a4d..afb2e6f8edd3 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -86,15 +86,35 @@ static int mperf_get_tsc(unsigned long long *tsc)
 	return ret;
 }
=20
+static int get_aperf_mperf(int cpu, unsigned long long *aval,
+				    unsigned long long *mval)
+{
+	int ret;
+
+	/*
+	 * Running on the cpu from which we read the registers will
+	 * prevent APERF/MPERF from going out of sync because of IPI
+	 * latency introduced by read_msr()s.
+	 */
+	if (mperf_monitor.flags.per_cpu_schedule) {
+		if (bind_cpu(cpu))
+			return 1;
+	}
+
+	ret  =3D read_msr(cpu, MSR_APERF, aval);
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
@@ -102,13 +122,12 @@ static int mperf_init_stats(unsigned int cpu)
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
@@ -305,6 +324,9 @@ struct cpuidle_monitor *mperf_register(void)
 	if (init_maxfreq_mode())
 		return NULL;
=20
+	if (cpupower_cpu_info.vendor =3D=3D X86_VENDOR_AMD)
+		mperf_monitor.flags.per_cpu_schedule =3D 1;
+
 	/* Free this at program termination */
 	is_valid =3D calloc(cpu_count, sizeof(int));
 	mperf_previous_count =3D calloc(cpu_count, sizeof(unsigned long long));
--=20
2.17.1


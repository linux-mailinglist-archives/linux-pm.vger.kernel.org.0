Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6003BD4888
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfJKTiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 15:38:08 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:9201
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728974AbfJKTiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 15:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb0/1IyY9llDvmeLZJDDzdUyeqcXgfJe5GT655LDsIhM4Mrd3Sh8E1cRK6tG3FCNPH5pdZO4ug0fRcgpxqRDw1JkFpiLpYtA12NIJ2tipv38OT97rT8P+WbBE9pFulpJBOEoLfkwCA11ICNcz2u3g7h6h8G6fC4mY6Tv/tRDYyVcW0zz5oqtsb9L9CmEC/2C5/Fdw/hrWvU/OC8vas0fBGaeCs4OgQo3AZZZSUrMaVZrxWofScj+TC3OJOzvV2492yezqid91IwkT1CY2zjbhMUchmy4LVbfacnLjkHbT6xk2G+LxATxJZFm9+O790Gwut76x8Mpx+4xJh8X9jHwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9p0P0Toe6zw87H3a09vvXCta+K80/rdZcAk6pOfK1c=;
 b=SBXp3y0kj8tFYHZs1KAH6M8jJ0Myb0oMOSj2bTvgYmEJO9L0eS9tIpB9wEy5FPA31TsbAsPTe7OjfEJHzTH2BtfsI/GBFLops2Z11cG269Xt0lxnAhcGoCQPCiYEs6Lsl8AB/nLXIjfuP0Trr/QGq1+72C0ZijBZDso+jlaeUSsfiVEfaM9YgH8oAzMz4D8LaJoSeLsNV4+ZTB9UnG3QpSPgJNbCSoWaqirxSnznqsjqxbSFB5sMHY7FnPz1zTCEsOfFUXVHLenaAdx/qA88ywmkTfVY1xt8aaKGbhE1ICpT9NIhE51t3D+Cgqojrn3iRTDjhgRs36AcBTghgTnWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9p0P0Toe6zw87H3a09vvXCta+K80/rdZcAk6pOfK1c=;
 b=UNbf2toR0VBuwJ0pzKoeMdvlt1Pyw4vsVUOxV2C3NZYW+Yybx9TgnqFdPRTIVNEdpFQMOTc9l6olSOWfWWeVopxvdD8+txTfYjIVT1oEv3OuYrYrrrQTOiAKcR3kZtWozcJ59MfieEbufIMShyfn8RANDw7ZpMF5w6+QwX6DFVU=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 19:37:56 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 19:37:56 +0000
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
Subject: [PATCHv2 2/3] cpupower: mperf_monitor: Introduce per_cpu_schedule
 flag
Thread-Topic: [PATCHv2 2/3] cpupower: mperf_monitor: Introduce
 per_cpu_schedule flag
Thread-Index: AQHVgGthysllBZ56ukW20e1QLXbBzQ==
Date:   Fri, 11 Oct 2019 19:37:55 +0000
Message-ID: <bb4b0e4137b62651b9d028925fa8f09ca5fbd989.1570819652.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: aa19112c-cdec-4356-3147-08d74e828366
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2816:|SN6PR12MB2816:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB281609B366D770F04C0D08A5E7970@SN6PR12MB2816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(386003)(7736002)(14454004)(6506007)(36756003)(11346002)(6116002)(476003)(2616005)(2501003)(478600001)(25786009)(3846002)(446003)(486006)(2906002)(52116002)(66556008)(66946007)(64756008)(99286004)(102836004)(66476007)(66446008)(76176011)(186003)(26005)(7416002)(305945005)(118296001)(6512007)(316002)(8936002)(8676002)(6436002)(54906003)(110136005)(6486002)(81166006)(81156014)(256004)(50226002)(71190400001)(71200400001)(4326008)(86362001)(66066001)(5660300002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XTTwVaZ14uVQcWewoxBR9/H4c/sBaMmh1GU+juO/z6siLSWNkhl76igCuLVRIJzfUWD3HU6NvX1c1iv+9epb2FaXLQLCkSFtE3WQc9Q3/TM7djTNetvI1+iZBsyurqCX4gK4+58F0wvW8G5jhVJdDMS/z6bw/1bLnRzGJUjC18PETfVN74jO/0gcZl6wS0IV1CrGaNiqu0ssCmyO0mNXAilaY4zKCqL4Ku0Mj6J1g8qoWVOJsTaFwweWdD2F50D9GKnhJetd8ymqdH76C3o5YiZV6O4l9tyHP8EYPLszdJu7UAXVEuEGOY6vtDeOa6s2gyxWElis4Jd2Xjgqe/fO0rmzkIY971T3OnVrAcJl/W7c7R8i5oQ01uqzy8aMSCL59F9/Qd4DUmeIR/TqpUeh6AedutgJD8aAI9N2s/UxJw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa19112c-cdec-4356-3147-08d74e828366
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 19:37:55.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCbbig3UoMH+9LtEcdFtK91+KkaWSzeKyqBacKTOHBF5Mu45Y6MrjA9BMfG/TnWdhWpuZ1PMjaoQJFYwJu8M8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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


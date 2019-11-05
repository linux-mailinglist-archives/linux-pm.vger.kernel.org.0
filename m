Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63333F03EF
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 18:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbfKERRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 12:17:02 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56513
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728399AbfKERRB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 12:17:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHu08hzsCbsEapEBW3SGnAMezHxFxu6X6vSSsJypdHuSingaQFYjleaKfATpATG0SVrJruIXwoJcTDK9sUtiJj853M6UWbvNC6yryFO3wKxFhau+XrKwYAkMelXMKyr0PM+Fm5oHqflpTkV+Gz8Kh/VLC7xhQXYDHcYS7VohSFXYqu0wjA7vBmGMXqVadl+xvDxYSM9WCjdSdYhx6kaB6vhxrHVOpyZxW1uSg5qH0NyJn287xbPr6+LFCqpuu9TfujZLFE0bOM8OFCQIX1kATP8dfe0B7KG6P8LbPjNaY6f7iStWZZoEqXkN9kEz8XPPvXXbd79Vh3ztZ5yNaWgSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYmxxPqzX0cTThFkFSc7L+fKOY5WnuBqPHXomRRbh8w=;
 b=Nr9Dcq5wcPv0YrW0MSh+xmLvb3M5G3Suvix6XxH+YjDuGtOE2cYpC9MF+yzfHZHlqpoaCwnzhPW6WENkd7WmTOQVV+Z5LA8IpJPF6COtpjaU8qb+g6RjHMm2nCxKEzqYGHl566Hw/viLsXvy74TwDOuXayr2UmblYYwDNzTZlMIWkEUYeCwy9RJ1Sy1jcO2M4Ph1vhDQLdHJN+ixijUO1SO9lybDsse7/9DzqWeJgFqTpOV08E6F6XVUMOWsuYo7dK/y2TdRVLSNfApCDT3i8pLm/C8zJH+1O3oDz0+kEoOwnZ5QNFf2okrk9AYDy4MN1fZutmk1inQ6oZIg9ywF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYmxxPqzX0cTThFkFSc7L+fKOY5WnuBqPHXomRRbh8w=;
 b=oFZL3Pv0rC9H1eJJwpbtxdtUGCreCC1yPUWbhna7LKVCsOD4nkc7chiWEUywM6ARy7yRksL10z5st0J3nJCobwWbQCkcIghHL1Ph+gXcFpl9W0QzJU1iftnUJME2zPvZTkxQPhCdTBvxAoU6uSPC3G7bNFjFKWX31DEfliDWM6w=
Received: from BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) by
 BN7PR12MB2786.namprd12.prod.outlook.com (20.176.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 17:16:52 +0000
Received: from BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2]) by BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 17:16:52 +0000
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
Subject: [PATCHv3 1/4] cpupower: Move needs_root variable into a sub-struct
Thread-Topic: [PATCHv3 1/4] cpupower: Move needs_root variable into a
 sub-struct
Thread-Index: AQHVk/zRfml/KAHxmEW24IdZvuO/vQ==
Date:   Tue, 5 Nov 2019 17:16:52 +0000
Message-ID: <1112f464e0cfde6eaf80793fe5fa2a5e82fd26cf.1572972259.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: f8c930ac-c0d9-47bc-ff67-08d76213f349
x-ms-traffictypediagnostic: BN7PR12MB2786:|BN7PR12MB2786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2786AD562E722D4B77CA9B3DE77E0@BN7PR12MB2786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(66476007)(8676002)(486006)(186003)(64756008)(110136005)(8936002)(2616005)(4326008)(2501003)(76176011)(102836004)(14454004)(52116002)(25786009)(6506007)(66446008)(256004)(86362001)(14444005)(5660300002)(386003)(99286004)(36756003)(316002)(50226002)(54906003)(26005)(81156014)(81166006)(11346002)(446003)(476003)(478600001)(6436002)(71200400001)(71190400001)(6486002)(118296001)(6512007)(66946007)(66066001)(7736002)(3846002)(2906002)(66556008)(6116002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2786;H:BN7PR12MB2723.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZFjucjHbd8cDTO+JobTw6+zRxDSnglcmLvgMMwep5vbJtQgMRV+7hiNMbXDFMjQggarPvLvpL5VD3LRGahGmg9c9LkDPLVHfXGigdGhZVR3iiBQ3ic7AwAurURWVjfKenj84wspNB0rhifsws3Vcyozoii28kQeW24M3DCf3vFlo3GnPlBeFBs8FVxWwou/dN0QpQz4OMLC5KM6W8/Q+4f/cLUNUfn1HD7i+y4bAOejJQ0wplAIe9FY24HIrAMowbBaFP0ZZQhypTn/CMmBZ3ndoM+TggYX1LHUxJnaMxczOvb9O8CdVGI8Fx/daD+9erPh8ZR3Q9Dkb1I2SBCySc/GH2RE5qdk+PSsuvmUC7xjjLTDS2xzoBL0yHBP7Ez0iVCRnEQPgLCmMvyylGj1+kDKpd3e1C53mmxNs0MGcrRTbNUfUIYI3pQo1GCicAE2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c930ac-c0d9-47bc-ff67-08d76213f349
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 17:16:52.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41tycKsJKvTNE/Do20NBfEIDXG+caJ70C0HcitOMmL0bFKvRj+/fZA7wg/G64FrII9AoKoXLDHp7mBdx5tJbog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2786
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

Move the needs_root variable into a sub-struct. This is in preparation
for adding a new flag for cpuidle_monitor.

Update all uses of the needs_root variable to reflect this change.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c  | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h | 4 +++-
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c     | 2 +-
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    | 2 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c         | 2 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c         | 2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/to=
ols/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 3f893b99b337..33dc34db4f3c 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -328,7 +328,7 @@ struct cpuidle_monitor amd_fam14h_monitor =3D {
 	.stop			=3D amd_fam14h_stop,
 	.do_register		=3D amd_fam14h_register,
 	.unregister		=3D amd_fam14h_unregister,
-	.needs_root		=3D 1,
+	.flags.needs_root	=3D 1,
 	.overflow_s		=3D OVERFLOW_MS / 1000,
 };
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tool=
s/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index f634aeb65c5f..3c4cee160b0e 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -207,6 +207,6 @@ struct cpuidle_monitor cpuidle_sysfs_monitor =3D {
 	.stop			=3D cpuidle_stop,
 	.do_register		=3D cpuidle_register,
 	.unregister		=3D cpuidle_unregister,
-	.needs_root		=3D 0,
+	.flags.needs_root	=3D 0,
 	.overflow_s		=3D UINT_MAX,
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/t=
ools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index d3c3e6e7aa26..6d44fec55ad5 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -408,7 +408,7 @@ int cmd_monitor(int argc, char **argv)
 		dprint("Try to register: %s\n", all_monitors[num]->name);
 		test_mon =3D all_monitors[num]->do_register();
 		if (test_mon) {
-			if (test_mon->needs_root && !run_as_root) {
+			if (test_mon->flags.needs_root && !run_as_root) {
 				fprintf(stderr, _("Available monitor %s needs "
 					  "root access\n"), test_mon->name);
 				continue;
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/t=
ools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index a2d901d3bfaf..9b612d999660 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -60,7 +60,9 @@ struct cpuidle_monitor {
 	struct cpuidle_monitor* (*do_register) (void);
 	void (*unregister)(void);
 	unsigned int overflow_s;
-	int needs_root;
+	struct {
+		unsigned int needs_root:1;
+	} flags;
 };
=20
 extern long long timespec_diff_us(struct timespec start, struct timespec e=
nd);
diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools=
/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index 7c7451d3f494..885740a654e6 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -188,7 +188,7 @@ struct cpuidle_monitor intel_hsw_ext_monitor =3D {
 	.stop			=3D hsw_ext_stop,
 	.do_register		=3D hsw_ext_register,
 	.unregister		=3D hsw_ext_unregister,
-	.needs_root		=3D 1,
+	.flags.needs_root	=3D 1,
 	.overflow_s		=3D 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tool=
s/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 44806a6dae11..7cae74202a4d 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -333,7 +333,7 @@ struct cpuidle_monitor mperf_monitor =3D {
 	.stop			=3D mperf_stop,
 	.do_register		=3D mperf_register,
 	.unregister		=3D mperf_unregister,
-	.needs_root		=3D 1,
+	.flags.needs_root	=3D 1,
 	.overflow_s		=3D 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c b/tools/pow=
er/cpupower/utils/idle_monitor/nhm_idle.c
index be7256696a37..114271165182 100644
--- a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
@@ -208,7 +208,7 @@ struct cpuidle_monitor intel_nhm_monitor =3D {
 	.stop			=3D nhm_stop,
 	.do_register		=3D intel_nhm_register,
 	.unregister		=3D intel_nhm_unregister,
-	.needs_root		=3D 1,
+	.flags.needs_root	=3D 1,
 	.overflow_s		=3D 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
diff --git a/tools/power/cpupower/utils/idle_monitor/snb_idle.c b/tools/pow=
er/cpupower/utils/idle_monitor/snb_idle.c
index 968333571cad..df8b223cc096 100644
--- a/tools/power/cpupower/utils/idle_monitor/snb_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
@@ -192,7 +192,7 @@ struct cpuidle_monitor intel_snb_monitor =3D {
 	.stop			=3D snb_stop,
 	.do_register		=3D snb_register,
 	.unregister		=3D snb_unregister,
-	.needs_root		=3D 1,
+	.flags.needs_root	=3D 1,
 	.overflow_s		=3D 922000000 /* 922337203 seconds TSC overflow
 					       at 20GHz */
 };
--=20
2.17.1


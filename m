Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F01D4884
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfJKTiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 15:38:02 -0400
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:56032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728855AbfJKTiC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 15:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7X6gsEoDo2kq7gzs1jP+rOp2O1UzZBRCnxD0sUYgYs6LUVjxYJSIIr0bPMdkwrE8us2wJm+6qsqjfTuwAIlys80tQLWmLhiYExbVvHQb9xNzFpCvrAVaCS5Mh9/DH71Q5JlTwUGvyMy7ECOmfTHGCHIPXsh1MXfTYXB53aR5rLRHvj3qmqJXmL5V0PVoOXSCZocJU13EkaVtT7+HQuNwilrKTtD5Dgp2hfG9htZr9x4lFAGjeiRbOoRftitThA549t16rw/pMJHhYHpL3e2WOxmr0GD/O06VBN/UTAFr5VQXAZeZjZH9/bMEI5fCQF487+rl1vJPAJbfPVgiuQJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACAyW8CIZo0tVKU2H6xb3D0xVOs9eIBlNou8qipt1S4=;
 b=leXwkhaeYJAfJ8GCkZ1dulXoOLaS3N8kQE7VM2XwY6oavkWKE+gDNqhSbjZBnHm1vqAGIr5PHECoaBxZ1R8DNLqserES3JiHn2+iomRx8zlAJQTHCb1qPF8wohGGPg4LyvSqMLHfegCT7qVQpCDzXImSBMEqV0OZR5iPQ4aFdQzjL393Kv6RP2NxdlOqWkKvN4SpEm33hlpBKRmpVCqUMF8Obt/INR5ntQV3S6FSlu/kv1SdakeqTuYF7QupqDhvqKG1c/dF9n/J2F2WxpqAi4wSkP/dgzagcfNws0c5UIGxeokfdoNFlqiZGyHlmcUSdd32ufT94509TvQlL8n66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACAyW8CIZo0tVKU2H6xb3D0xVOs9eIBlNou8qipt1S4=;
 b=G3FpO+66X0IfBOEZDkjS6WjGpeRfdT+EX8hNMoMJPh3n9q5hThIXPmfnr653Z3VBnmdUYlRMjXoBzlO1IeL9iK8YPDY2Y8bOjwFB+Qvf6Q9Kh/u0B2GjZDJ037nCmRJ2NCGuoxs8CCi4IC1PkXiBxws/FrPgQstjy4nTq45Hz9k=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2717.namprd12.prod.outlook.com (52.135.103.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 19:37:55 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 19:37:55 +0000
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
Subject: [PATCHv2 1/3] cpupower: Move needs_root variable into a sub-struct
Thread-Topic: [PATCHv2 1/3] cpupower: Move needs_root variable into a
 sub-struct
Thread-Index: AQHVgGtg5WQe0V/RMEmYZw4sn+hrYA==
Date:   Fri, 11 Oct 2019 19:37:54 +0000
Message-ID: <75d2b90caf54d0fb4c81f413915db04f3d22f425.1570819652.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 695fe0c0-188d-40e4-9481-08d74e8282f4
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2717:|SN6PR12MB2717:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2717D170BE8F2B46EBF9E123E7970@SN6PR12MB2717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(64756008)(66476007)(25786009)(305945005)(4326008)(66446008)(6486002)(66556008)(476003)(81156014)(81166006)(5660300002)(36756003)(66946007)(478600001)(6512007)(7736002)(7416002)(6436002)(110136005)(54906003)(316002)(14454004)(86362001)(99286004)(486006)(2906002)(2501003)(26005)(102836004)(186003)(118296001)(8676002)(14444005)(256004)(71190400001)(71200400001)(66066001)(3846002)(52116002)(76176011)(6506007)(386003)(6116002)(8936002)(2616005)(446003)(11346002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2717;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1bvEhNiFlqRBVNhxOuy2nvHN2z/3IphEZvlX5FcVnL8dcLmSF/nC03TUi1QMVPAD1hmVSIr9nfVK/z+TomSG+6ctQMKpAtFTvyfQY7VxZ8gWkI/vGh6dLPKp7C+nOksFvRaOW4DznsJhztnTUv2nAf5dBVVTAO4lgoF88wZ1oO8d1rbASHCuaQz+2jhgvyfT5r1VmJnd5398GGnhIdVGCXtPcZTEai89/EYaNCKTYmfLCZEZLHLGsxShiA/wVqi4s5yedm5ZpS52gEphdrkXKO3gQ887uyr/TCv6SIm5YzwHiaiR6eGFge48hv+z9qSRoUlUggi+J/t8TIOxdOCTV5txAuTeYncMufLE7p9jwprzk80kbN52+LGQnGsYLOmCAoTspuK/vWf6R3wiaG5xBWHeCo1E4FE5u4LkMyPW3U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695fe0c0-188d-40e4-9481-08d74e8282f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 19:37:54.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJC2mr/INWYguc6HeZB7cGvHwY3mjtolcxz14+E8AlshnIsFc5Te+G6LQjYpJl4lHRzrQiWnURr8ySzZKLZnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABF3E92FC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ2WVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:21:30 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com ([40.107.73.79]:6655
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfJ2WVa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 18:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogeX8tNkoxqdFLrLDONgUCszspluyqhW40Qdq7kdO1XeLbcJ0x53Zvcprcu5wCBM4k+brzHFQNAFPYca3FvHdpR+uOaAT0n4aTCwgK1wKSwcPK5N6J292+w1qlqyppXrtzRcPsQBpt9B9B+NmQI4a8lsLwslzzAqM1mBXMb6hzIeLHLSFf1Le9h7pUWaGh4q71oeU2gQGRf+C2pw/RqnsUEjjEKzLoVd5kubuMhOj6OgVLgoWoDRvrTb1UT1byG/JJM7tpQao2UpQbGLaHDvm/im55rz6lH2pWdHzVIHSIZoOgjv6GLJ7glB/NBb/A8Qh2oiE+0ckldoj68deo4+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQg2+ClM/8ea/P8kFQrRTnCZltiWEtatT7zySZCXYTQ=;
 b=DEHqsMACt6Il24JClGe25keUCSHW8ktcd7xGKLy9g0LvfChmwGidN+PfB01KeSd2Y7OLEzuV/Gk2tak0C0uehFg3TadqoM0Pu3cNpGpKk34EcQCVB/jPklzidhG449M/tMKcm/1W/ZHp5tvMycnHNcMrR9wVPmyFvuQdPa9uYVBD4qyU7DTOGcgM+S/9gFm0/tzwg2mfZmCB7H+8CQrch+3JX5214A1Do5/5AFWG+aAICNhvjpyctgDG6zz68s0G7dcjUky2PwCfLBd2N/plzwgtuoHCcZ2Ycjjg9xuJcW+1zlvXCvmGJAlLGqCJkuzjViWoOOfhf6YtkhHJLTeSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQg2+ClM/8ea/P8kFQrRTnCZltiWEtatT7zySZCXYTQ=;
 b=CF7rgPq6Y4FW0z07G4IEDxH8070CACt9m5618zYTlqTiLKo3KrBwKKJKY2BsI63wNkcX1NXM5P26yxWaDu9x5Xcj4+mqWJkIB0rmwL1Mr0UmDjfp3n77vtPhQdJK1mBzdNCF+O7112xWGKM3pLwlYETCZpvSRvtMi1ceHNuBUg4=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2847.namprd12.prod.outlook.com (52.135.104.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 22:21:24 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 22:21:24 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH] Update ToDo with ideas for per_cpu_schedule handling
Thread-Topic: [PATCH] Update ToDo with ideas for per_cpu_schedule handling
Thread-Index: AQHVjqcyPJ6FVY/x+0GlDNczus3zcg==
Date:   Tue, 29 Oct 2019 22:21:24 +0000
Message-ID: <20191029222112.43040-1-Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:805:2a::36) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aacf3d0f-b9eb-4a1c-2d19-08d75cbe5528
x-ms-traffictypediagnostic: SN6PR12MB2847:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB284779B2C03962A38D16237CE7610@SN6PR12MB2847.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(3846002)(1076003)(52116002)(6512007)(71190400001)(66066001)(71200400001)(486006)(305945005)(316002)(7736002)(15650500001)(8936002)(25786009)(6486002)(2906002)(6436002)(50226002)(36756003)(476003)(110136005)(54906003)(4326008)(2616005)(6506007)(66946007)(66476007)(386003)(64756008)(26005)(66556008)(14454004)(8676002)(66446008)(99286004)(81166006)(186003)(81156014)(5660300002)(86362001)(478600001)(6116002)(2501003)(256004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2847;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uly/PAy41Wv006HScuBaGYALPTmAuSiaKhPtOV2SFDcKzQsdIy8WV4zJ88Jx6YRhjnG+qnqnwsDUK8wJVqMQHqHsQ7djPrKHs6Qdvi0QKACBNX+M2S3u5RuHVOzM0qEq857+FTLBfmEouT4wi/IerVExIOMZ3w8zWxdC9ruPe01KpIC3qxE8pJ8qB4sXXwFksXLWisA8Dvh/wqhnjwhICE9imzyPpWv/ajZIidYQ+GF2GL0ydaDfdFgJx8r9fngMNQVpRRdhXNShrfXQqF5g6dQMW8KqF1ZzPE0hTyLPZuuXoNZwGb3PWnOT8KxW4XNW1dmTFxj1Hpdwr79OO8dD+LEbY29IINBK7yoPkIgJxQAGSnD/feEB32xcvUe9msSbYEl0kbTCK+dZxVnYIlkRLWhRSLWdaEagLgTpJXGhiyqYQNJNFzPRHOJY3YOVUKtt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf3d0f-b9eb-4a1c-2d19-08d75cbe5528
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 22:21:24.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbnUz0tOHOL8/qq9g2QElC4gPMeqGUV0mTo377/b0Hit+iRsyXFr8n3EC9vfFOPkKPeo2mPWBFFtoAi5/Fi0nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re-structure the code to better handle the per_cpu_schedule mechanism,
which was introduced when updating cpupower for AMD Zen based processors.

Based on Thomas Renninger's feedback/ideas.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 tools/power/cpupower/ToDo | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/ToDo
index 6e8b89f282e6..3f12ee451403 100644
--- a/tools/power/cpupower/ToDo
+++ b/tools/power/cpupower/ToDo
@@ -8,3 +8,17 @@ ToDos sorted by priority:
 - Add another c1e debug idle monitor
   -> Is by design racy with BIOS, but could be added
      with a --force option and some "be careful" messages
+- Add cpu_start()/cpu_stop() callbacks for monitor
+  -> This is to move the per_cpu_schedule logic from inside
+     the monitor to outside it. This can be given higher
+     priority in fork_it. The per_cpu logic allows the
+     cpupower process to move to each cpu before taking
+     measurements.
+- Fork as many processes as there are CPUs in case the
+  per_cpu_schedule flag is set.
+  -> Bind forked processes to each cpu.
+  -> Execute start measures via the forked processes on
+     each cpu.
+  -> Run test executable in a forked process.
+  -> Execute stop measures via the forked processes on
+     each cpu.
--=20
2.17.1


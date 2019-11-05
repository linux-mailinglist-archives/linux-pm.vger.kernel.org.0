Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A746AF03EA
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbfKERRH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 12:17:07 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56513
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390284AbfKERRG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 12:17:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0g4G2YTrky2fuoXdgafGvU+a3i7mOtYYiogOVz1qMorOPSBPCc4RRW34n2KMtZwsFHDg0nV059bu6vgREyL/yeYCeQFXqVOqN2++Vbphb46uJSuR3loIrDr1Vb6ZIE0hxmk3JXFjRxPFWCZOW0CQsMt5MJOiUgvL5l1R+TCFUfOxyufuMOhKJWfhj74TGYKfeVzD4YUyH3WSWiJBpo4KCp8O/HJWLgg8rLqNvTJGR2TcUlieN1MS9V2JDlHgTjEONJp/fS2FpPOCMgJS5i6GMQA2Cr+QsbJoiBzbDb209fg/f6Kw47YJcchlTsW0TxSrxUetBlrOJKSKZHXM1Gf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eswBfVLGOqCu5lrUEtE1wjugqlM/4ej6ShQtln606s=;
 b=a902ni0/UiCJzAYSM1SrM1h8O73mR6kEjrpOxKeZyu4rdt1TqUzZow3AvjfCX41syKyCwKjBhmLyl95z4IpXvv67ubJj2+gbgP1yR1anhe2Vpnats76MITMX9CtaUW4oZH9uGxWgbE9s6yRmFKh+T4zpf27ZyHQSaKDlqJvW9u/mKO+2HZ8n8YuTzwxHN6asVHi5iXNhB7n15+eIVRZfvhBLhd07Tv6++ut0WVBkbLbrx0bgPb1+znRoX1z//FAYU4Qlw3w5ta9KXukBnzqxEQgBVxCV3ABd0doUBK58pVSlnEIR0MNkDLRADoZTrDrOiJxvTGxRShsL56+51F9diQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eswBfVLGOqCu5lrUEtE1wjugqlM/4ej6ShQtln606s=;
 b=fDBrzKogLRthdHbURFZ/B1muPmoyra5F2PwwU489iGLGcVOfyUZ+/GLA7jsj1xCgZ+cvOEhXwRSiRMUa/sPpL/TLTu9qSB/3NOy9UPeUpA2zd+MnU2FZ8sri9aTy3ijCFCBdJt/J/ttHOJTHQiGUQQaNg8jj7LJol03B8KcfDUQ=
Received: from BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) by
 BN7PR12MB2786.namprd12.prod.outlook.com (20.176.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 17:16:58 +0000
Received: from BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2]) by BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 17:16:57 +0000
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
Subject: [PATCHv3 4/4] cpupower: ToDo: Update ToDo with ideas for
 per_cpu_schedule handling
Thread-Topic: [PATCHv3 4/4] cpupower: ToDo: Update ToDo with ideas for
 per_cpu_schedule handling
Thread-Index: AQHVk/zT/E4eW+y3B0G/7bUbBjUCmA==
Date:   Tue, 5 Nov 2019 17:16:57 +0000
Message-ID: <8994b7701058a590cfe718efe408a10d6c3e8217.1572972259.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: cfac7ce4-6c98-48e8-8cc4-08d76213f61a
x-ms-traffictypediagnostic: BN7PR12MB2786:|BN7PR12MB2786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2786E37E11F1517984E20601E77E0@BN7PR12MB2786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(66476007)(8676002)(486006)(186003)(64756008)(110136005)(8936002)(2616005)(4326008)(2501003)(76176011)(102836004)(14454004)(52116002)(25786009)(6506007)(66446008)(256004)(86362001)(5660300002)(386003)(99286004)(36756003)(316002)(50226002)(54906003)(26005)(81156014)(81166006)(11346002)(446003)(476003)(478600001)(6436002)(71200400001)(71190400001)(6486002)(118296001)(6512007)(66946007)(66066001)(7736002)(3846002)(2906002)(66556008)(6116002)(7416002)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2786;H:BN7PR12MB2723.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HNweVXMtyJzP+xM1FYlGspSHuvGHU6Io+AFwOWmJir4L+IfqqYFaSfiUm3vnyu8AMTGwK3G5DhsWyONMg03LEiGUWETt01CLDRyiWbmqUP6m7FOQFfQS9ZTpMceqS/iM6MCy1HyujJd64zT8XbMZFMYxtOKD+ig4hlAROaTthY0PZgtSDqUM767o2weGKp6x45XckXMj+GlEa+SpL7hiknScUgpBc0DeK28EcM1FHlJA6T/vhATaVgUyLKM02gCO1+EyHTBsHAY3PcRLdN9fKUmmxoZtL1Ikcqp6YQBr7LRmwUFvcWNNSEpieY809PAwC811gA4co+9MDG34+ZU+exnTuKi7cN4bsoY2WO4Pilv03aaz2clmCbce7bAl7GIkDYcHmwKzsP+m1oIh4CW+2O+aZvysSZmTHKrbriw1kVrdf/0T2o/FmSBLQJTxzleC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfac7ce4-6c98-48e8-8cc4-08d76213f61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 17:16:57.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RfUhTZA1VXuiro+wmJOk8RNJzxYDRoTv7dVkIl9HK9vmRk33MYQkjPB4aFmz5t/4YWMyKa5HN4P3uMAUKMXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2786
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

Based on Thomas Renninger's feedback/ideas. Re-structure the code
to better handle the per_cpu_schedule mechanism which was introduced
when adding support for AMD Zen based processors.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 tools/power/cpupower/ToDo | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/ToDo
index 6e8b89f282e6..b196a139a3e4 100644
--- a/tools/power/cpupower/ToDo
+++ b/tools/power/cpupower/ToDo
@@ -8,3 +8,17 @@ ToDos sorted by priority:
 - Add another c1e debug idle monitor
   -> Is by design racy with BIOS, but could be added
      with a --force option and some "be careful" messages
+- Add cpu_start()/cpu_stop() callbacks for monitor
+  -> This is to move the per_cpu logic from inside the
+     monitor to outside it. This can be given higher
+     priority in fork_it.
+- Fork as many processes as there are CPUs in case the
+  per_cpu_schedule flag is set.
+  -> Bind forked process to each cpu.
+  -> Execute start measures via the forked processes on
+     each cpu.
+  -> Run test executable in a forked process.
+  -> Execute stop measures via the forked processes on
+     each cpu.
+  This would be ideal as it will not introduce noise in the
+  tested executable.
--=20
2.17.1


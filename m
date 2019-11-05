Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61C8F03E3
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 18:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfKERQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 12:16:59 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56513
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730895AbfKERQ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 12:16:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eut02WVwaOBlq79PLUht/VYNk3haiZsVX8itLTFG6A5YwibRdAENRDzF6ANa0HU8KtqIwUmJTz8XT0bQ/bmtr0SpGQOKVjeYpwygjhXF1IGmr6PS2jWU3v9hCHMfdeD1C3JE0E0MOZLKHFb0CFRC5lwCinB06vwFv392+NbJ+0lAi4gKSmMJXcV7bUrihulG80E0mu45WwhopQU898Ub07m69gsttdgoz1I0XLU5Fe/vSDKSlHcTJV7ZgvNMpYqU+KEnK6IZCtjHSVF5bMLeN4xsXX+0A6wqXmNOcwndyfLyaPwlBCdxFEo+taiGBNSrBMkLMaeFaozxwdrv7g3V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UKH0Zsq5d/hMXgWQ1VZ+BFQpGpvoPdLk75VUtjMfgQ=;
 b=djbCdoLgP1x9DWX6OojzNSY5hbMHuw8y08jgXJLgVFtc94YDvq1iQGtXCjbQ2ingjFpNoSmJ5JiVjtV8WWEdsTOw8ul4byeE8LA/BDLZnahTT4XHpvLnmiN8tcy35IyGBc/KI64+HLI5qCXjZKjsGEi2wSv02D8OlW79U/ZaQ1qR2VejwYICSUvSZCgyNqUjIrLMq6Q+PwbqNp0caKOJLDn0bjG370mSWkxtxgzQ1apkZ1gIlVRSFhtGHBpbbo4uZGCl4JDiDiSoKyqMzhCl4tm1Iff4jx3PWuiTWLu0kDb0mBNZlph6EQlRDQSNB87ShHVQxN3u4FrUUKT6Bw1YLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UKH0Zsq5d/hMXgWQ1VZ+BFQpGpvoPdLk75VUtjMfgQ=;
 b=g7nglYbbmcXRkT76S3iff/5ewVnEUqFOOb9uACWd/WXh4+9Ln3GLJMibmQbGb4vRfly0dQuQxbxLfRPHZXitwfk9C7SzkY0cDKuvV8tN3gEzhK+vGDUaiHtvNijTzZx2NIuSuCpF7oWW/r8q3KeP7toOpX6y02ktbqW6vMMPFyE=
Received: from BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) by
 BN7PR12MB2786.namprd12.prod.outlook.com (20.176.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 17:16:51 +0000
Received: from BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2]) by BN7PR12MB2723.namprd12.prod.outlook.com
 ([fe80::20d2:c1ff:3fa9:4df2%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 17:16:51 +0000
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
Subject: [PATCHv3 0/4] Update cpupower and make it more accurate
Thread-Topic: [PATCHv3 0/4] Update cpupower and make it more accurate
Thread-Index: AQHVk/zP5nDc82SGf06fFkvzZ280xA==
Date:   Tue, 5 Nov 2019 17:16:50 +0000
Message-ID: <cover.1572972259.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 4c81738f-fd65-48fc-c2ee-08d76213f24f
x-ms-traffictypediagnostic: BN7PR12MB2786:|BN7PR12MB2786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2786787BF0031A9E8845E341E77E0@BN7PR12MB2786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(66476007)(8676002)(486006)(186003)(64756008)(110136005)(8936002)(2616005)(4326008)(2501003)(102836004)(14454004)(52116002)(25786009)(6506007)(66446008)(256004)(86362001)(14444005)(5660300002)(386003)(99286004)(36756003)(316002)(50226002)(54906003)(26005)(81156014)(81166006)(476003)(478600001)(6436002)(71200400001)(71190400001)(6486002)(6512007)(66946007)(66066001)(7736002)(3846002)(2906002)(66556008)(6116002)(7416002)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2786;H:BN7PR12MB2723.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDDOCtr88JWDaw8u/P6baQTb2HjrdxGk6P21XCcymIHarxcN9Nj/WMY7ZckPBf7Qr2PhVXRQVve7dplslgAGmZc6VgdaVPy6hzqkLCRK1eUhjoQGPCXd7CSsgI7vVhiAFjDLGh55zD2jKv+nayQOlILEvq5Eui4TyciWZP+oeOUvj8D3VI9k5lDfIlk3Hbs/smfbo2aOse00Atg3FRO6QIR7kOTjam0+2kY6YSFhWX7Tt5mMew5qBlgUO9xm339xO3/RdbROcioVskHlzKwYeCWYR55K2Q+kpfL6RTAnaxCvHvSffLS3gkQQmt0IoaJJ/KqxLGyvoKJFaLuwiC7LvKRuhWkbJTuwk3XrHq7hllQXadg1oBLbS1u7cpKoNiH0oBVDaffIo7oqYoSQSJTgg0nhVWDCtIFtRh3LyJhhA4OX7VoIxOdvupbZRBLv1LES
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c81738f-fd65-48fc-c2ee-08d76213f24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 17:16:50.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poX3x7uId+KcyyxsnKGkoTzWtzMN4utYGzst4OpnP/iE6PPxu1jOGGnxhKgI6sUF5QvnXuesFynGtMj1NJ7rsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2786
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset updates cpupower to make it more accurate by removing
the userspace to kernel transition and read_msr initiated IPI delays.

The first patch does a little re-arrangement of variables in the
cpuidle_monitor struct to prepare for a new flag.

The second patch introduces a per_cpu_schedule flag which, when set,
will allow cpupower to move to each of the cpus in the system. The
advantage of this is that the IPI latency is removed when reading the
APERF/MPERF registers, since an IPI is not generate for rdmsrs when
the source and destination cpus are the same for the IPI.

The third patch introduces the RDPRU instruction, which will allow
cpupower to not use the msr module for APERF/MPERF register reads.
This will remove the userspace to kernel transition delays when
reading the APERF/MPERF registers.

The fourth patch updates the ToDo file with ideas for further improving
the code handling the per_cpu_schedule flag.

v1->v2:
* Added cover letter.
* Used bind_cpu instead of rewriting the same code.
* Move needs_root to flag sub-struct.
* Introduce per_cpu_schedule flag.

v2->v3:
* Added ToDo patch to this set.
* Fix checkpatch warnings.

Janakarajan Natarajan (4):
  cpupower: Move needs_root variable into a sub-struct
  cpupower: mperf_monitor: Introduce per_cpu_schedule flag
  cpupower: mperf_monitor: Update cpupower to use the RDPRU instruction
  cpupower: ToDo: Update ToDo with ideas for per_cpu_schedule handling

 tools/power/cpupower/ToDo                     | 14 ++++
 tools/power/cpupower/utils/helpers/cpuid.c    |  4 ++
 tools/power/cpupower/utils/helpers/helpers.h  |  1 +
 .../utils/idle_monitor/amd_fam14h_idle.c      |  2 +-
 .../utils/idle_monitor/cpuidle_sysfs.c        |  2 +-
 .../utils/idle_monitor/cpupower-monitor.c     |  2 +-
 .../utils/idle_monitor/cpupower-monitor.h     |  5 +-
 .../utils/idle_monitor/hsw_ext_idle.c         |  2 +-
 .../utils/idle_monitor/mperf_monitor.c        | 64 +++++++++++++++----
 .../cpupower/utils/idle_monitor/nhm_idle.c    |  2 +-
 .../cpupower/utils/idle_monitor/snb_idle.c    |  2 +-
 11 files changed, 82 insertions(+), 18 deletions(-)

--=20
2.17.1


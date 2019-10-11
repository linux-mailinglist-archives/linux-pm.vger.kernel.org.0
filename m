Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F127D4882
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 21:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfJKTh5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 15:37:57 -0400
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:56032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728799AbfJKTh4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 15:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLJ0m5uEGuEslbAk/G8iJIXqkaWVTTUqOuvsP5JAFAvFTswcGsGdwj5Wwnvv/bNmxoVYB0DUm21xuR1AltInOZFfa9qf1whoMfE1ZRaYa18rRqWc46c0NJ2TLiXm5R+Nm1dDLDmJQ3ZU4emoWIPzD1Rvz2ggkuXumsLb4pFVoJtEyEpabNWDe18eYxaPL+nLxoOcfIDCtkgD38PXvAwGP6owMQ0RGyqnjsIgdy47QJ2pFqaKaLyTseaZSFEEGK1/GnL1mF29TDfwVtTq7+bCmEaDuLkzbBoZ2fKO7raIYHTllauUXx+dke3cuJXkvueOL1VDOsU0Q8oqOMGiiZ1CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNU7wPFGNXR8UmyjgIioJ3a3aCdjtCLYCUg0e/BEfQU=;
 b=Z9bbd4B8AL+WyVAYbdNjHvQ8WX1PKSenJf3Lb6GQE614dOq0tlnmmoww1CL36zwJk1j59BicA1WipgZtONtStpVr+Pbe6k5trYAd0JnnGueL4sTolMgksVf55JkNuM8yJrMNydCDlPJRYSjamRB+M1f8nLSQZk3/q8t5KXIEMUc5Ve6EPy0kGk3EsMXSMfbkVG4qys4t62n+CGb6rD1gbUthiK4hzqvm8UWpkvPuvZ2IAA9O/RhFbfv6tHZ3kagKjSQ6lYfN709G70InyM28oBmSS9hBvJNq7V/RqXrSVEMQtPwvhDG30GRYVcEvtUCWhzsMLprBWJu7cRRJK9+GfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNU7wPFGNXR8UmyjgIioJ3a3aCdjtCLYCUg0e/BEfQU=;
 b=R2bRf+I07K01Pw/lNSAqNdOJGmOCdiznzj5AOSXmRX5ih/HnRKXVtTAs9DE4iSGMU6phXHoe4+y4e3XIe5/vjuqhprEm/H/q/1GJwbVIvHknXpnp+ukgcOxwFLes4tZUNv0Z7JrmlwybOafcqaTbfcV3cnvxaZR+1GgAL32/TxY=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2717.namprd12.prod.outlook.com (52.135.103.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 19:37:54 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 19:37:54 +0000
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
Subject: [PATCHv2 0/3] Update cpupower and make it more accurate
Thread-Topic: [PATCHv2 0/3] Update cpupower and make it more accurate
Thread-Index: AQHVgGtgGy3CWOpXjkaZczBU7MWRIg==
Date:   Fri, 11 Oct 2019 19:37:54 +0000
Message-ID: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: ccc15f69-441d-4f1c-97bb-08d74e82828a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2717:|SN6PR12MB2717:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27173ACE16377FDE81097B4AE7970@SN6PR12MB2717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(64756008)(66476007)(25786009)(305945005)(4326008)(66446008)(6486002)(66556008)(476003)(81156014)(81166006)(5660300002)(36756003)(66946007)(478600001)(15650500001)(6512007)(7736002)(7416002)(6436002)(110136005)(54906003)(316002)(14454004)(86362001)(99286004)(486006)(2906002)(2501003)(26005)(102836004)(186003)(8676002)(14444005)(256004)(71190400001)(71200400001)(66066001)(3846002)(52116002)(6506007)(386003)(6116002)(8936002)(2616005)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2717;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aptHa4/UQ/O4JWSBaN6ACtAD87DS2zHjFW5e1px7T2d434UVcVT+HCwHoliMzWbckvxuNiZktkgMDp9FsaLknN77bOyddeyEbsm/b7t8SY60fAe5xFFuokNwf0GCZ3IlfDRj1ZjEMw/+cRR5EUy1rV0XOaZcpRl7rbA2JxpQTjJhWxBNUuIt6YfluayMHWu5AyRK+Ia187pag37XIu16sSZ+5KUlhMD39Y208z/MBQ1UH55O8foV7Sgqx9Yhr8yYqY04Ufln7APHeobOnlTsSAU/AlNoDTeoOdk7EUurSGIVZqKUlfGFTNvr7KW280SK8i3ogvyj6v6ydTmN8KRGPuByYfhduygXRf5W7DZdY+Z5OyEVPNMAu/X9j+s/ifR59q7Gp3/8ny/jzi2CZBBaUmIP7hMuHtJkgUKH8UKOfg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc15f69-441d-4f1c-97bb-08d74e82828a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 19:37:54.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTXPfSXg93auFV3nE2RKWHTFGN8rxcwh+F7ZLHuKaqKLFw0OnK8BRwwrjBXmTmPHlhB9PBS6Wqn9ABkPT9mv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset updates cpupower to make it more accurate by removing
the userspace to kernel transitions and read_msr initiated IPI delays.

The first patch does a little re-arrangement of variables in the
cpuidle_monitor struct to prepare for a new flag.

The second patch introduces a per_cpu_schedule flag which, when set,
will allow cpupower to move to each of the cpus in the system. The
advantage of this is that the IPI latency is removed when reading
the APERF/MPERF registers, since an IPI is not generated for rdmsrs
when the source and destination cpus are the same for the IPI.

The third patch introduces the RDPRU instruction, which will allow
cpupower to not use the msr module for APERF/MPERF register reads.
This will remove the userspace to kernel transition delays when
reading the APERF/MPERF registers.

v1->v2:
* Added cover letter.
* Used bind_cpu instead of rewriting the same code.
* Moved needs_root to flag sub-struct.
* Introduced per_cpu_schedule flag.

Janakarajan Natarajan (3):
  cpupower: Move needs_root variable into a sub-struct
  cpupower: mperf_monitor: Introduce per_cpu_schedule flag
  cpupower: mperf_monitor: Update cpupower to use the RDPRU instruction

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
 10 files changed, 68 insertions(+), 18 deletions(-)

--=20
2.17.1


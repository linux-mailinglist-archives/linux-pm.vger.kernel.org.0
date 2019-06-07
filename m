Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1705D391FD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfFGQ2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 12:28:10 -0400
Received: from mail-eopbgr770085.outbound.protection.outlook.com ([40.107.77.85]:8430
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbfFGQ2J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 12:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/s0x6pLNd9mZ7Ply+zCPVO3iyziLOBoPlJ4pp7WMFA=;
 b=Ebzijz9Ps2X8idVTHUWaaTntfQNBd7wf3hzn/7KojyhToGEXxLmXmgwFnFJ+4n6fgs4lQC3uiZ4yTk+kjb6OnGYfkkcplNSdg2s8auvrEu2hsvsO+UajQ+abDbVeFQtDiNXOTe14T9rosa5MYj0dwJS5WkN4DqkXod5a2nbtKtY=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2765.namprd12.prod.outlook.com (52.135.107.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 16:28:07 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 16:28:07 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
Thread-Topic: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
Thread-Index: AQHU4zDAw6kMdRt2pEeSvDZqbzvAVaZKM7PQgEahSNA=
Date:   Fri, 7 Jun 2019 16:28:07 +0000
Message-ID: <SN6PR12MB2639ABA1421E220FF5813738F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
 <SN6PR12MB26394D7FEE4582FD19860104F8230@SN6PR12MB2639.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB26394D7FEE4582FD19860104F8230@SN6PR12MB2639.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20debb43-90c5-4df8-28fa-08d6eb651fa7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2765;
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-microsoft-antispam-prvs: <SN6PR12MB27657EE964778CCDB68EF7DAF8100@SN6PR12MB2765.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(13464003)(6116002)(76116006)(81166006)(8676002)(81156014)(66476007)(64756008)(66556008)(4326008)(2906002)(66446008)(6246003)(8936002)(9686003)(25786009)(66066001)(55016002)(86362001)(3846002)(53936002)(5660300002)(71200400001)(71190400001)(52536014)(229853002)(305945005)(2501003)(7736002)(486006)(76176011)(74316002)(256004)(68736007)(102836004)(66946007)(6506007)(54906003)(99286004)(110136005)(72206003)(33656002)(14444005)(73956011)(478600001)(316002)(26005)(476003)(186003)(7696005)(14454004)(446003)(11346002)(53546011)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2765;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eLg/fOW1lXODxHPmRaj7sYkdOJmcpHlhNDfkj1MM+AM86AUdopT2Vk0hmIbL5xGdYAWUTlWGzd/pHI9eQZCUZYDyKppdcYjw28jKzTIRbDKeKDE1cImQ/7Ao2nEUSbjsoOcF69IkuV94n9AsoWH6jbDvbki4nz5ghRgsnQks/p7B5afsth0IA8mp3t61PEc7rKLpHncPcwZ6KumkONFuoh8Bw2haJxkr/Hs01n0SoJTxquJDkxCAjR7roWyOebPXk4h3aszucJrlh+E6CfX7+N64boddhZDyMAqWsyKDsDdoxoXl1ZzldGYh2dqIZ1dKwcnabd2p2ToxgcOt6bAMVDrfe2x9i6oJYQjWLp4uMPtXNvPtnKSkwbYVbEun3SnRowPxThGUWVQCE9GIvifw743VkTS/3FuzeTh7gSPPn9Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20debb43-90c5-4df8-28fa-08d6eb651fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 16:28:07.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Sent: Tuesday, April 23, 2019 12:53 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-pm@vger.kernel.org; len=
.brown@intel.com
> Cc: linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
> Subject: RE: [PATCH] tools/power turbostat: Make interval calculation per=
 thread to reduce jitter
>=20
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kerne=
l.org> On Behalf Of Ghannam, Yazen
> > Sent: Monday, March 25, 2019 12:33 PM
> > To: linux-pm@vger.kernel.org
> > Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.or=
g; lenb@kernel.org
> > Subject: [PATCH] tools/power turbostat: Make interval calculation per t=
hread to reduce jitter
> >
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Turbostat currently normalizes TSC and other values by dividing by an
> > interval. This interval is the delta between the start of one global
> > (all counters on all CPUs) sampling and the start of another. However,
> > this introduces a lot of jitter into the data.
> >
> > In order to reduce jitter, the interval calculation should be based on
> > timestamps taken per thread and close to the start of the thread's
> > sampling.
> >
> > Define a per thread time value to hold the delta between samples taken
> > on the thread.
> >
> > Use the timestamp taken at the beginning of sampling to calculate the
> > delta.
> >
> > Move the thread's beginning timestamp to after the CPU migration to
> > avoid jitter due to the migration.
> >
> > Use the global time delta for the average time delta.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
>=20
> Hi Len,
>=20
> Any comments on this patch?
>=20

Hi Len,

Just wanted to check in. Do you have any comments on this patch?

Thanks,
Yazen

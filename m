Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B1352021
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhDATun (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:50:43 -0400
Received: from mail-dm6nam11on2100.outbound.protection.outlook.com ([40.107.223.100]:16831
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234062AbhDATun (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 15:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdFtOQPooGXZ/+7zcZOaAUnaqfve2duqDNIU6B2NDVYCBjHGdMrXMx796A28OmIfKNQAWXeEA/99mDfaj6SDqTfdWzcs8lT9RcSNX2/9J/unSz0Xixi5x3BSX2sTzjj12dnxDB/t+x9v9BdAQfvCrx+161n4bfCLgi98kXYLJKZEFrTJfCtlffhCaw91C8ZTloVzSlpqmjos+fHtn1Mj+r2+aZPx/Y4QGzhO0e8Wl623lKw1pqV6UmXbWtQuwDPqy5klz71Q2fH0q5DPibZJ/bdrpb6zdYoF0zBwaIVGIsNf8+nxpOGrgoiuOQOMrRGcEFUYTE16GB/l1SV0eeg3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD299SDxZW8BSIm4ktv1Cfw5J3Tau2eiC5MHieyurIw=;
 b=WbEQLr4Ti+xoX9Bp1bJgr8pMr0QP+r9RTgeJaq1FVjre/44osnaF1E3XfukR6XFlXJnYUAyv4M2u6PhfqeNPYkuKweNmVQ8xM39JJgmVYZ4XND69cMoue6Zd98sNzoSmO5XpDzzNO353dDCKXBqvSVg01rClHa9+F4ScBD7NaoG85rlD++Xz5Tgtk3zKewLiL3dQqWRwjA1KzOT1mZvWAgjA8Zn9hTQ9zB88Oh5iXuqEXg8YDvWORz/oMxujIGD9YGoo+oYcCufF/GWmpZPYps6HDlqfv4c9rwAXSxest43DMZNJtLKcIxX9rGAxesQA817HCVtgpuzyQCqBI+FH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD299SDxZW8BSIm4ktv1Cfw5J3Tau2eiC5MHieyurIw=;
 b=HkW0NVzmiv0Dqhr6Zh8wPtZhVUjd4k875WHiT4TUpBgksGIbErwKY166oQMMgqH1BRR+eL7gykVafw9uzaZ8uzn0udgd+040Z0w8bvs7RWV5qlYoOo4VqLSp45WbR54VYUvTKdNJvPYNhR1QqAEngEFae2RJpW9m9Svi8CX1E0A=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MW4PR21MB1939.namprd21.prod.outlook.com
 (2603:10b6:303:76::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.1; Thu, 1 Apr
 2021 19:50:41 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4020.010; Thu, 1 Apr 2021
 19:50:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Chris von Recklinghausen <crecklin@redhat.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "simo@redhat.com" <simo@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Thread-Topic: [PATCH v2 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Thread-Index: AQHXJxYhzW3+9PxxoUavzmBfwhC66KqgEbAw
Date:   Thu, 1 Apr 2021 19:50:41 +0000
Message-ID: <MW2PR2101MB0892DC42B3FFA456968E0F24BF7B9@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <20210401164145.8051-1-crecklin@redhat.com>
 <20210401164145.8051-2-crecklin@redhat.com>
In-Reply-To: <20210401164145.8051-2-crecklin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee9d046f-86b3-40dd-9af4-fb3b259c4d11;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-01T19:48:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:5df2:4327:6490:f40a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41901a95-bf1a-4831-c543-08d8f5476e67
x-ms-traffictypediagnostic: MW4PR21MB1939:
x-microsoft-antispam-prvs: <MW4PR21MB1939486A24D7A8DF5560B3EEBF7B9@MW4PR21MB1939.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2kmmt2E+YxXax6eb+c/H8xmsOGkna041+AMuFNCCO2uKlfNi+iEn+KrZ2ut+P87g6Ym6It8i3CkzNaffZExSf3nX/DlOpVRZ1IdOO/M+/qQKlesWOzxspQQaDWIWGvh7Xhh+gh713ZeDi/32xYWE2YMDDmDXBcyM/PH82wk4v0OG+OGdGnfKmIeM9bsgzeU17nMowgompptoD4BVJ8OvYljyuG29G5a83v9XPJKUMpjHjThyWJougDtzHOWafEn9is0OgRxUTG5eDChkaZoPjkPAzy9AaOJ+tx3EwBcMAk5PGXcE1WBi6IEyn9JkG/hv6Aa0VVjxSM+eSITkGNuGP/Nzosbag1csh4lGmOgzuQc8RQr5EZiWjeEbzy5//44YHmQrId1ilrz1DHpxYaZXvJSueH8YfWxnS6jBUxeuvf7IFU/qJMx/8nPOVMzasilhKZUVhkdw+s1QfmpXH4uh2iwWwD2eDRgA2EpXqLd8v+IcvpnAbOKM84iy+MMkXL0F7Ucwyk4/6+KjAFPQ6nSNfVqEEseQq9h9dQpJtJdcXjg8+42fzrcgKSMSM+3gF90tOAqrldw7YvWfet7XmukRodaXFtvXV0y1KmyiTSqyWF49pZWBPxxjocq2fiW8KzItQXdyMKeHG/9C8SDMzqFRDrFBZLWU2DHgPtXVe82mQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(8936002)(4744005)(478600001)(83380400001)(8990500004)(9686003)(10290500003)(316002)(2906002)(8676002)(110136005)(55016002)(6506007)(53546011)(71200400001)(7696005)(86362001)(52536014)(66946007)(76116006)(64756008)(66476007)(66556008)(66446008)(33656002)(38100700001)(82950400001)(82960400001)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j4xrXveSF2V1rgE/Ped2r9jDohcgsCSUPIat76bBUIdmDUPGaBuod6w0NC5d?=
 =?us-ascii?Q?nKNp7mudRm/3yFRQW5GSrYw4OdlUPHUvYTa5EJzz2GyvCpAkYHHSR4KhAepk?=
 =?us-ascii?Q?98kosiuhkH2uVTRbDkL3sJ2EF0ZHKe4XdSE7je94+JlHuAAawmhcw535B7Ip?=
 =?us-ascii?Q?WjMCZUmH9rmUg2htJ7sN5WiZ7DS84G0tgiqECf2hsmDKyV3tEoLtUHqcSRh+?=
 =?us-ascii?Q?kmf1Hm7U828bE8d4ZAl9kia9FFeCn5WRPIsdtwYZa+XALNstkvMBibJoz1NT?=
 =?us-ascii?Q?zHh98xxN+kn9eKLb1JiScGhckXjA7STFZYvdmSFrtZGhj0IdrNvOiuw8aVJr?=
 =?us-ascii?Q?qgRhFY5aC48Oh1IPXtcU/aByUElS5GSn7R7qsScfa1hQMJ+blZxmEM8kCZt4?=
 =?us-ascii?Q?f5SEVl1eqKa3Itqbs5A7UrkW04BFxAZXBIhmBJctiuOMpezp80Ape6EFPRpW?=
 =?us-ascii?Q?Sh9pkcekMO+LWTTm6baVXJKD4j2pPLmnVo8wewVxeHwXj2xdBlr1Jyr4Gb70?=
 =?us-ascii?Q?qmIs8oFW+qLnFa59f9ohGfLnfajQBwTTxIu67k/PCobbWSKPd6i0ohmoQVbS?=
 =?us-ascii?Q?OI0OVnWTY5vwWSiYJA3OZ5H8owJPxi2GAzgO9QHR34GerB532GLPEVyjYzZL?=
 =?us-ascii?Q?9ZwsH3XoxF6UUB5pQ7X3ssLulC7fxQCenHNCGNdz6wogAgUinXhixuJMBtZF?=
 =?us-ascii?Q?mOSJmS09mvzruQaPn8/b3yt1PHwcRt2bde+OsGgLGgtHPloIP5cxBNwGDrh4?=
 =?us-ascii?Q?daYeyekzxBODkNVJkZT1WECJr5MK3Fs27rvI6TOeh55qJKXxJp4qYpgJre69?=
 =?us-ascii?Q?bKml8c6TOvwSb42iEYz98QJdTHj/TOUxJMhnYxF26L2mgDLw/dQLYErutCMR?=
 =?us-ascii?Q?Fg7/6Z5OVGdoLyEVuXPFvsek0fgVbBPz5AsTYaRcs18xdTD/O6rYSQiQbraO?=
 =?us-ascii?Q?e3VW3J/IAh5tJulaUoILyzNmd0QYZNTmohrXoQNTXGuG5/rMcNUQT+9AAF0L?=
 =?us-ascii?Q?W02dJ48HAj817bIx8Ms+dACy7+UsjZbbnxYpqn3t8FYtMTNauhY8ZvVTZ4vx?=
 =?us-ascii?Q?SmJlOU273gp2lfxQsmDKg0NGQ1PfahAoec435uT9H+Tkt/pAlhyegFgvmWiX?=
 =?us-ascii?Q?5wVOJct0LHSdV6qn3o5yGvXamSDd0GQUuFX+nD0Rul2agCBh4RvJ+ZSyIOet?=
 =?us-ascii?Q?DikoU3Dqj33S8UGomGn/MZNsjX+VWxUmcSaG0ZHrGT7oP3iIOVRcKV7FTcfN?=
 =?us-ascii?Q?asMlSqCcR1rocozIG00JinF4ZPTikiBcz22JcADsLi62h5zBv48zIsxoVYPG?=
 =?us-ascii?Q?YeDJojYr2AByBbHgu/sJ4UlaDCTn4JkyReJwroQQAG31rkjrigVkgikewMD5?=
 =?us-ascii?Q?xzZzD5SF+2AV14hfAr77epsr6dgR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41901a95-bf1a-4831-c543-08d8f5476e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 19:50:41.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPHD6UsFyN763J64MK0RWtOJy2oekVGfZBtOB03mhwBLo59rjweCq31DGXuSQLoyFUKzojHLFoDSTXMRNUY5fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1939
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Chris von Recklinghausen <crecklin@redhat.com>
> Sent: Thursday, April 1, 2021 9:42 AM
> To: ardb@kernel.org; simo@redhat.com; rafael@kernel.org; Dexuan Cui
> <decui@microsoft.com>; linux-pm@vger.kernel.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2 1/1] use crc32 instead of md5 for hibernation e820 int=
egrity
> check
>=20
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
>=20
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memor=
y
> map
>        by md5 digest")
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> ---
>  arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

Thanks Chris and all! This patch looks good to me.

Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>


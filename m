Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611F834D9F6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2WNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 18:13:40 -0400
Received: from mail-bn8nam12on2132.outbound.protection.outlook.com ([40.107.237.132]:46176
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230420AbhC2WNL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Mar 2021 18:13:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iisxVQGWlXS3Pa7OE3dXBxYQIuWzT3iHJyB8f/8LO7Sshzc4ztXeWWfpa7VD7n7xitGu35LUofq/gQ+Jzs0SWt/Q5cevI8jG5UqXNsDx1U7gGQHG6eRIyeJ0YJlbHXpN+t92PfiwyMrCu1gPzDRLcvMF9K0kDaJTZM0oFPyxSFq1gYQ0xvVmIa9u3TgjfSHEJMXj44LoohCtBms5J1Cc2mSuJxBP6RmTiYOBB13NmaQfIqCMYgCynH0cc9LjUxrimKkqzBq+Wgy80xFdz+hk/vxvNkf+lGPJ+xIQqvxygT6CKETFx8BS3LdC6auaupwL9QNqIr4tP4ON6sCS0roLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbn1I5q/FvIwTXH/B4dftxpCRGZNpmHUxA0yxVOayuU=;
 b=nVghqpDl89t9NmiN9KG/UtDzP/hCxuc0gnZiIAezZ7y3MYffX/MAyKGc1p+fbvQnltNz9Bt4ap2Xfkj+6oxzIBMaizjMTWaWnyvDjk4snAxzUH4cdq54pbKPSQZH+5QSaMa/gASiC+bcXtXnh62+9BqnEPBMn1JCXcKSVMCGetyDUfNKRhAZ+NPr/x/JRLSXDndaLip9OlZASMv+Pp8IJ/F08ISpy1/qDVC9Acet+aDaRsfjCNmdTIKMklOtewg5cnVCLfV+gRKnUt06btR1do20NYn66CrMfV3IP0KQ0ZDd/A1EbYMbASRbCAmmORPF0GgHPWP8qJxXYupRWBkRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbn1I5q/FvIwTXH/B4dftxpCRGZNpmHUxA0yxVOayuU=;
 b=L2+wbnLuDY2V4imPrv5/7VeBlQYxflr28JUkhvYZ3QrqlYmseONUaIhCrjAQ0darjkr5cavVlZoZ7Qe5KXBUtH3oaxWitwhcs53O7+hzXzwpHpAsgL7Y/7EB5CMFyGnxq3kMB73dDKtlaUhjuBIc2Jm19/PjHIZYQZQFRUO2DBU=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MW4PR21MB1891.namprd21.prod.outlook.com
 (2603:10b6:303:79::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.0; Mon, 29 Mar
 2021 22:13:05 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%5]) with mapi id 15.20.3999.019; Mon, 29 Mar 2021
 22:13:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'linux-pm@vger.kernel.org'" <linux-pm@vger.kernel.org>
CC:     "crecklin@redhat.com" <crecklin@redhat.com>,
        "'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Fix hibernation in FIPS mode?
Thread-Topic: Fix hibernation in FIPS mode?
Thread-Index: Adck6GAij1diypNgRmmEYf3qOm+JwQ==
Date:   Mon, 29 Mar 2021 22:13:05 +0000
Message-ID: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2044ee86-d711-45bf-862c-54c30f2521df;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-29T22:00:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:e965:792d:4f45:db60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77c6ca3e-b59a-41e0-2c4b-08d8f2ffd387
x-ms-traffictypediagnostic: MW4PR21MB1891:
x-microsoft-antispam-prvs: <MW4PR21MB1891FB9532DD37775CC09DA2BF7E9@MW4PR21MB1891.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6eFFUTPDe+kGADfmmBCJ4t/w+o91C3mawx5S6LNILcpHCB3EFTn/J2aF42v2TDxvo6f7AY77GpHUzlTX0DXDTNXICJx6VNDtLa+7OWGQTvVGiclHKXGXP+S8EgdTVjIOjiC9dUb3gkb8f6S6+g0qCeZ6aCD9+sOr8aOTENysN+sIS1Sv6UC8WGEj0D3Zk+5EsxZJ0iiMryMTX2fa1zbRMToZCR0xmey+OtJ4VOfrZ+t2nKaxKElx7v9z4HBZHcB32v0bZyJv+3dmygn1UOc2bmfge4I3HjIjSMgtF/mOJWHGGt58wcYCRM2eLQM2HP0Do82vs0HLc9zV1Eo0Qswcwz80Pt1kgIdOpsPxsCbwGYCzlv+Yc8JBAeWTnbhNlx0ZHyuVHpne6pSmi91cCOeEoi4B+/Q6jDABs2i6IV+pxaD7PVlv75TccMyuryaa+APFIgy1AOeaaimT9x0TQVbxEsXPpBpvH4SDFmrbJrE7tWslzX3xxyOU1EJz+UqSidibnc8USpHVZgsiv0thEnbCBLyM8J+Sw88Cyhe6hxllbEhz0ekAMHszpg21mQn8ttJU57lyGJmG9TDvzKbOQ4kd2ZDFNVEFTbclsFxi7JnF7OZfxgw2a12+dF0cxsTc4c0AY97j0g7lRoZmpzvBmUWfd1MD85eEh1Gp/tjBvyDRtER5bjrXQvlyvM0REtqBBPdY1nm9FV+TPpwdYHZ9AA7DWWe25hbtadG+jaC8aypqGEPeHJTADQZoePucF6DOJmol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(2906002)(5660300002)(4744005)(7696005)(82950400001)(33656002)(186003)(52536014)(6506007)(6916009)(86362001)(82960400001)(54906003)(966005)(8676002)(38100700001)(4326008)(71200400001)(9686003)(66946007)(316002)(64756008)(8990500004)(66446008)(55016002)(66556008)(478600001)(66476007)(8936002)(10290500003)(76116006)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9EEenop0lELbAl2FjY7SiTmXU8eWbb5gG5xLW7RJ9MP+9P8XnyZz5rLGuRi7?=
 =?us-ascii?Q?qh5kQdGLbMyF/07GJmf2/HVwqgFs3xLjh8Uli15EAK7B/i2UqrdGrm/yAvHm?=
 =?us-ascii?Q?tMNUUNpGzsY9U6V9FMLI0Yd1t8y8vaNe0NkpuJ9Vc+GBsLiiw5ECKbzAGa2u?=
 =?us-ascii?Q?q/Xfq9fiZe+ntImrBtutRYtf2T0x8RMNubr5pvNb12mry8ncOu4IBDd0h7jP?=
 =?us-ascii?Q?YCS25H6RZ8UZr2H1h5KovVlfSSwBi9bnsI+Cz54pPPFv8EP3N5eQ6S/VIZ/X?=
 =?us-ascii?Q?BpbkYhqoN64bI53PitAU+dBx7jfR6lqoApjezqrxMXJebZ3SavTFqGO5VcUt?=
 =?us-ascii?Q?RSislKOnYhTeEhUmb7op7juZCnuRb6aPr0ENI2DGyGyqWVtqWHcyXtsbuRPf?=
 =?us-ascii?Q?nfyP/FjqwHsewtzcS6mgQ6CctH75DFhK/E1kDVzMI4x7e/P29s1nTvXfFNXa?=
 =?us-ascii?Q?Zl9c72pSoG1phZLJmOv8hxRIOkzQqLf2qTZycM0c+xm9Q/BZYlS46cvTG5Zy?=
 =?us-ascii?Q?y03AkShgcm61I856XzxfZcL7u1W/ElZUJBj8d9dqx6IAnWGL0wUJSHNmtUcK?=
 =?us-ascii?Q?fHd+P69+T3X8Q2ICM74SKOE/SX2s01g4Ceq0yGlkd0Y3dHQcfR/7+SXCuZgh?=
 =?us-ascii?Q?5kGzo9dqoByXOoonYHS8mXeCDpHzzoxy1R7EdeMfAv5qm1LURpEjtA0L73M9?=
 =?us-ascii?Q?dGO1J85HoJrwbPw9QlsoTmKQmofINDqBkcXaFN6CYQvb2sr2Dg6CuwfRI6uv?=
 =?us-ascii?Q?YZjC4fXey6O5VzyNqOJ0SzQ5BM6TsCMbzvzlybo48zz4Zmwf9CtQCR8JSbXF?=
 =?us-ascii?Q?JalkXaoKt6d4tpd2YaZj/E+Jd0v/+fTcpwIKbHVoq+nXLPy5+8tCBc+9gzOb?=
 =?us-ascii?Q?O8RzDGLO0VVrsl831/0c6ZOvrgK8/G0fGxddAc40aJ+ZvK0OvMU2CEA+UqI3?=
 =?us-ascii?Q?93N1XFtvqITF6y8Lh7UJNIRFRLg5vcMPWdqR0yhd6YofxSS7p4usF0OdrolX?=
 =?us-ascii?Q?tdJvwhao6Erc3nuYkEQvaNwaEY1tTD75Opbe/i0LSrDVxP49glENAoDdTrI1?=
 =?us-ascii?Q?CPFFdgl56DUk2/gct/nRS5VRwf8mxv3UxdXIzETH3mCO68fmKzMS47wLwtKC?=
 =?us-ascii?Q?dCb+ve2B/9iR9gCzgRVH38zuvP4R/JaIwZquYJx31Ghaiq+DkcWlRTMA33w6?=
 =?us-ascii?Q?0sFp+350B073DOjYTvbDZ7ij0R2qVwTK6ZkB+ce6cXurXxMQB8B806IH2nnI?=
 =?us-ascii?Q?qANYMye7qKqsEVgS+tDhDDvtFhO5nZET85dlDE7mnmItCcWAQvnVa5iwEEuh?=
 =?us-ascii?Q?zXby9tHtAfCTXFbFxx2nIRHa9ymYOVUB2ixGBxOBc5n53D8zw9WXalKcQVUH?=
 =?us-ascii?Q?KsnL7hDuaCUWLpoyr0EtIdwESLxN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c6ca3e-b59a-41e0-2c4b-08d8f2ffd387
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 22:13:05.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1sc111Q4y4Ab0ExRkGG2F9oRnhK9JiY/zn9TRN87JaahU9fpvim+ZnOhOK4N8/2/WT63kl+0k8IFjeNb5jWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1891
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
MD5 was marked incompliant with FIPS in 2009:
a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips=
 mode")
a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")

But hibernation_e820_save() is still using MD5, and fails in FIPS mode
due to the 2018 patch:
749fa17093ff ("PM / hibernate: Check the success of generating md5 digest b=
efore hibernation")

As a result, hibernation doesn't work when FIPS is on.

Do you think if hibernation_e820_save() should be changed to use a
FIPS-compliant algorithm like SHA-1?

PS, currently it looks like FIPS mode is broken in the mainline:
https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html

Thanks,
-- Dexuan


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8A4548AF
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbhKQOae (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 09:30:34 -0500
Received: from mail-tycjpn01on2136.outbound.protection.outlook.com ([40.107.114.136]:39489
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237710AbhKQOad (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Nov 2021 09:30:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmKvfVDmT/roO45pkOCK1PER+vXIDmnEalCGGrJbPFBmPreslp6nnWvkxp6CPL22JGKVUaRJAN2VF4aOkqphkSF8zWwMenAgrwUoRb4Zb5jAOrzODWWJpd9QBJo2ivqxRU1qsTHyYLXECTcGHDduQYARjQKpVJBKQOrq/J1HLnY4WaDNUmga5Nb1M/GHwTmvI7xQRVKNwp2psuNvY0/OD78bciZ+RZX5d1PFW6cMZzjlKDYXJio7yB41YgiAMTZBLJ5qlYkF9PXb6jMiBnmBtiAnzGLhRvWTeLGR1ur6trIXnyQ+14wSj2kZNSEdETV9GSn5f+Nf2JlsbM0MJiSZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YejMA0aGN89NMtqVBDLod8EYxOPyCpArhcFye8Wmvrc=;
 b=ZRls0LN+DGvN7q5LBaBJfdDtTraITX6VjGsPuEcOwElY8E5l8m41VlY1e814Dyn/OTUiw6uFOGaT/NCU+2a45lsiOx940C55FKPpYIRr7ghwCvcIThiqYuFCnVAMHQ4VcGoJzu8/D42Obd8CIvzPRnZnwp7C4qkdcEVxU9xtI7HXcA158IB8TDgy1m05ASE9e7IleMJ7lWwfnQj4NMy4kifz7W9lCWK+iaT+i4uMcS5t2OI9qKbhH1VZSRko1VE+ybZMUbnz33kCp3iguuHTo7ozs2TTu+D+leP1UIbcL43vXrGuuUQHdePlnKoSrwib507pJrzFpvoz1jNJNB2AWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YejMA0aGN89NMtqVBDLod8EYxOPyCpArhcFye8Wmvrc=;
 b=okBDJwQ/0s7dcyKboEYkGI71u1E9RbzE2TJEJXSu9N1vUn0StCG/b/KpiZ2W6dgEwqsKKSriFn1ZKqjIwhZVgk5jfo6K6qyw3xnH31AB0wdgBwasprLpI+g6KKNPaqhBF4F8dkRYecq+f8sPf0jTNfdzcQq1Penl3LDzK9XctVo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6181.jpnprd01.prod.outlook.com (2603:1096:604:d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 14:27:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%8]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 14:27:31 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
Thread-Topic: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
Thread-Index: AQHX2v0oE66oWNNWJkWwQPaKhKKvwqwHZ6gAgAABsSCAAFr/AIAAAEkw
Date:   Wed, 17 Nov 2021 14:27:31 +0000
Message-ID: <OS0PR01MB5922295A2899E87AAB8E8F0E869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211116151750.24857-1-biju.das.jz@bp.renesas.com>
 <20211116151750.24857-4-biju.das.jz@bp.renesas.com>
 <YZTAEIv2AcURBA1Q@oden.dyn.berto.se>
 <OS0PR01MB5922E694037C0A488BF6F5D3869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YZUN0L/emoeCLQnW@oden.dyn.berto.se>
In-Reply-To: <YZUN0L/emoeCLQnW@oden.dyn.berto.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56dea2f6-c26f-473c-d505-08d9a9d6640f
x-ms-traffictypediagnostic: OS3PR01MB6181:
x-microsoft-antispam-prvs: <OS3PR01MB6181A9B0323AECD36705952D869A9@OS3PR01MB6181.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuRGTGttxmZHKOGJqwVZqmvBcpzzZuJIj2nvj51Pn3l5yUYSfvcFbhQXB+JYTTEZTxfu+71FJnT4M68CPhcQ+iMxSZue3pmiZanwKeLE0K/Ebv8sixzyb6fWCgFALNqTsxtZw37Ia8X0UAaaqWUVpiRL9ForTGDGACxTB3jmnAvO9TzjBfVi38L3NW5pYLsvfe02zh8Y0rtM8rh2/lpb65pcEhwqOkfRD8A5R2XwieTX7bjLR9mwUeaBWdO1SLDHiu/CU0JrMABVjleM/oD1bBkeYS3Yw6v9d0dXyyDKa26xOzxO2HHrGjexaM8K1U3uU62JGded65KwyzVhJR13xoeDKwgZ4jSHzpFb2Q0/2j3xHB2C+5qThz1WNY66COgZvZSXErgs4dRTPAZ+SiSvgi+FgIeqTHKSgfIHwHKjGDdBCfnpyj4IY6nbe1f4lsKLXLKOJSSmLUKAjO54tFIm7AQ8H1n7h0aCdiHjDEjYLp6zzKaFlK9pXP2/FQk910ICK3Y96rsZN89tQrAxQP17LUxe9Hy4kMfY2LFOij24RS/Fq/qkwTUlXTVUjn+py9sMsaY1tchalhUFuYN8nWpP0pj27v3KbvCRNIx7by4OQxo6uODhLr7u4w2jf4dHGAnNY6vAyrsgaVNcqOnUAptGoKqASpbBGJJYrIFFT95tYU/gVKeUzw8+1LIvtBLmcdDg0XJtixZ8VtYkAdYdEZmbRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(316002)(4326008)(2906002)(4001150100001)(38070700005)(54906003)(33656002)(6916009)(7696005)(83380400001)(122000001)(38100700002)(86362001)(26005)(5660300002)(8936002)(71200400001)(508600001)(52536014)(8676002)(55016002)(66946007)(186003)(76116006)(64756008)(66556008)(66476007)(66446008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zIUSBO1oFmeay7njS3It56EpmJNULS7ERI4UPIFJUoYsHk3AB0oa7cLGQ0?=
 =?iso-8859-1?Q?WeT9YOvj3QaiyUVPaVyG3mWEG4+g8JezQR76kmwwCMLlsFyPlskuijktKn?=
 =?iso-8859-1?Q?NeKB5sVE54zfzorx4Z0B9Sh7IM6KQNpemaapH34rXYEkeTEVMfAuVLpWE5?=
 =?iso-8859-1?Q?SUwL2YJvj2ObOHuYTgtAUU+IkS3n8l13pyItWRCxEdQ5dCnQ7es2hhZZek?=
 =?iso-8859-1?Q?IDYcCUrGDJNdOReCqoY2JKPpwvs6xwEri4vIHRlh/CUq3pxrI+341H2AXC?=
 =?iso-8859-1?Q?OEcmzJ9lWnEA273uoeN2JGQWUMm+cp+jQTQg1+dlzO9chBFbVhxOllKKzT?=
 =?iso-8859-1?Q?+Kf+GhCgLjAT8USIxOWHKy5Lnk1uAIFuX35XCv2NBB2gLG9e6749Dav/O1?=
 =?iso-8859-1?Q?1iNyrcXDzhWYlWfA5nCmhL/9amWOgEaooywsLMeFX9+/qjdoOr/r167vUr?=
 =?iso-8859-1?Q?IrsXn3ZnHpkHFmXAgSYyDRk/sqQqBwjw4Orf2XLdhhCzv0dFALvNOBHBs9?=
 =?iso-8859-1?Q?jsAQDyGy1aRGtNmqqvJFWTicw3NsFUR/FEs8GZ1nFgmzTzDSVX4uJbwZsL?=
 =?iso-8859-1?Q?wuW24O8ComlQZ0WDRUeQc932nZNM5jL7QryjepQ9AKK89CLeFcn5c2NDMm?=
 =?iso-8859-1?Q?X0W6tlJz0M1aigk2GD9qbY0YQeooueVAOCMWStLqyM3wv8gWsfhmfnkv7j?=
 =?iso-8859-1?Q?qJCMWgudZxO5jooh9pviDSAvx2PntzspgRTasa9UehTNUyI51qILrPmjG0?=
 =?iso-8859-1?Q?RcNhZYEafshL/l1dvRO1voN9UZZo0SbQ9PeEbHY6872X/TzS3gId/oWCDU?=
 =?iso-8859-1?Q?X4d5S9eb2Al0piCebCnifnpsZsCmmdIxlGVcvsEdTHi+Aek2c0PBgHkKq/?=
 =?iso-8859-1?Q?NJmA2kNtEKRtW3ioICDLPQpJ8PWlu58v32gipZb9DG8dLVfJ5aWYrcOf/H?=
 =?iso-8859-1?Q?JvSdiZJvHQubJM3WOeV05IB/UfnQtjmCbTQ0Wi2B1Nx7Fx5BNAjQZIthwW?=
 =?iso-8859-1?Q?zV2nAh8d1bIl+M/LxUxssfKptvairT/4cWqmVhEGXrBPMbR6moVDhLjLDJ?=
 =?iso-8859-1?Q?pT1dJnlZcpzMtSfueWfe5gtIhaB/FWLZQdVfOgUmKXtEvvvOuSELr0J9v5?=
 =?iso-8859-1?Q?TgPpcT2+3yU5+qhQdxuxOIrdp+GlkJXMV0VgjWV5Oe0naLckDhyIadvthQ?=
 =?iso-8859-1?Q?envAxxuVOHsXseZLhG73vmPADJxNLfM62t4PFnc4Y8VnPDpOup1D9QkqbZ?=
 =?iso-8859-1?Q?sKi6F4Oq8ZC+c5X8ubsaS0ruS4tWQ6dLIGKDRYIdIdRniI8sEb4f65inUe?=
 =?iso-8859-1?Q?HMx46mmySz+yozvYHDASfqZLhF9cfRt8RPPstH8HiXdIVTw2hYPd07u2GE?=
 =?iso-8859-1?Q?RCUhYSCH3pFVAwLBnSC5PhCYxqqcoDRJC9BBBO+jeHsg22+obQv7HCIlbM?=
 =?iso-8859-1?Q?uM+TVnAqpBPeWOOUNFfXJnCWVdcqToYBEF00ea7aT9uBMiM5Mu1yVR/zVr?=
 =?iso-8859-1?Q?3740ldwnZyPIorGdeAyNJmgS3q1K97khsj5fQ5AKEyaqwMVbpJY+bFR27g?=
 =?iso-8859-1?Q?GQOsku6azCropK88ustmaZlCqhM4i6ZowGRD/pMEMA76RRem2OjzagQ61C?=
 =?iso-8859-1?Q?YtFdXZ13hDrtoUAGB48Tq5H+FEDkd2b2GjD5RRnmnyDh6kFGx8HNXwkzow?=
 =?iso-8859-1?Q?vPAMee1fKq2dFQSaw5uTbzXb9aonCsQPCwySanmxR7MnukUahZmIBxN2FC?=
 =?iso-8859-1?Q?Ik4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dea2f6-c26f-473c-d505-08d9a9d6640f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 14:27:31.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZG4x64Ac5HEvd9u/UX2yCf68HrOEJ2VSh7xsFtoSlHph1Opm1pc9ny1ECQf602A3+nR9u+Hom1XX/NmKqd7vtb9ykOi5Zn8E1XPlNPnT10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6181
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

> Subject: Re: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
>=20
> Hi Biju,
>=20
> On 2021-11-17 08:55:15 +0000, Biju Das wrote:
> > Another separate question, I have in my mind is how do we test trip
> > points for negative temperature?
>=20
> I think this is two different questions.
>=20
> > This TSU doesn't have any interrupts and we need to use polling, The
> > range is -40 to 125 degrees.
>=20
> For tripping a trip-point polling or interrupt works. The only difference
> is in the worst case polling will detect that i past the trop-point
> <pollig-delay> later. For testing triggering of trippoints (high or low) =
I
> don't think we need to care about this.
>=20
> To actually test it we have two options.
>=20
> 1. Put the SoC in a good freezer and, alternately open an office branch
>    in the arctics :-)
>=20
> 2. Use the thermal emulation framework.
>=20
>     echo $temprature_in_mcelcius > /sys/class/thermal/$zone/emul_temp
>=20
>   If the temperature set using this is above/below a trippoint the
>   associated action will happen. A good demo of this is to try on Gen3
>   where you can observe the cooling device state changes as the
>   different trip points are triggerd in:
>=20
>       /sys/class/thermal/$cool/cur_state
>=20
>   And of course if you set a temperature that trips the critical point
>   the system will shutdown.

This I have tested with thermal IPA (writable_trips and thermal statistics)=
 and
I can see the cooling state transitions around trip temperature.

>=20
> > If it goes below -40, I guess we need to shutdown the system.
> > On device tree we normally specify only positive temperature.
> > How do we handle this?
>=20
> I have not tested it but would it not be as simple as adding a second
> critical trippoint at -40 ?

OK. This can happen only from a cold start(where the temp is below -40).
So at this point, I am not sure whether we should not rely on TSU values
as the value from TSU may not linear or it is beyond SoC characteristics
And so we should do a shutdown.

Regards,
Biju

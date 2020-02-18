Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE73162481
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgBRK2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 05:28:13 -0500
Received: from mail-eopbgr1410138.outbound.protection.outlook.com ([40.107.141.138]:41568
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgBRK2N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 05:28:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je7CORM9BnzCfIoLTr5oYXK2jc+2i1jwJo4J3MnVbCTJmYnPegtnex067/FsZwHU/OwSZnueUIysH/+iXkGwyChVv0fHhR3rhFxBuGvHgpI1aHSYmSCaaWCK8Aa0p5LVIl+S9fDJ0kQVRzdiUkT8zbpinBJEt+Z67WjdOiSypHWkP4FwrqKmZ9KPNPPbZbRms72ChMg2iBsnute1p+5gm7X71Q4kafZbg3wlbazkLZ1T8Jv1iP1vrv1Nu/lkAmXcIoT2kGD7vQVbjyW3/axuIxQsat8JVAWQsyd1eE7nqbsTTVAYT7gnW8uZRz8vxpYs6aw73E/hGPA+iLZ90z8zBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mebq2VlUGMUaXUxKvQqbGAlqWPaHzBLYdqsi0zKUe8w=;
 b=IXn4/dR0z04tF2B3ItwAMcYrmg0CUGr9GB27++4fG6A2sL4Ibcv1rkxAOSAoPEd5kZFUV8HFgX7GZfeTcSUROFLVNH386s8S4tSajr8UIJ6A2TF76IJJar1iXX169GdaY4Mmm3IKGfnvl2qq8DAxScATH2u+PA1oL5w2vzvHH3Lr3suHElKfhWeF6Mg/vUfkb1YuAG/3BA3qVpgffrHcX3WJA3qz0qLkDRbomDurgIFlRIZ/SuIp8e5EUQxv8/9ou2jwD3NNWLQ7z3S3UWpNa3nlSdvHAgTeY01Acv8pEFaBmKIaSqpjw8bkZpWoy86TkEvBlNqwqO0WjMpKG8Lwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mebq2VlUGMUaXUxKvQqbGAlqWPaHzBLYdqsi0zKUe8w=;
 b=fRFCwfYX6tk2gtp8tXrGghriPilzEKQOs7sadluF41JQLhTAoos/JWGTrTq0FUCGd4/N3Egq2IvoZhUmNVXVULVtl3KnjnWDxnZ7iTYPhnlHI4f7UZpok3eSBhOPzxsR9l4raPBr/Qc8T3DBp7kV5AIjW2Sut2biLodKQxAv9xU=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2045.jpnprd01.prod.outlook.com (52.133.179.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 10:28:10 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 10:28:10 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-1?Q?Niklas_S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Thread-Topic: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Thread-Index: AQHV5MmmLymxK/lC2USJviU/BgNMZagfB0oAgAAkTgCAAOfAAIAAAooggACrKQCAAADSEA==
Date:   Tue, 18 Feb 2020 10:28:10 +0000
Message-ID: <TYAPR01MB454433742064C6F15555BFA2D8110@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdUdBVwAbG8Qicg3_aKvwjq91QJWS5FQwM6NPdgbyP2Wzw@mail.gmail.com>
 <20200217101114.GO3013231@oden.dyn.berto.se>
 <87zhdg2293.wl-kuninori.morimoto.gx@renesas.com>
 <TYAPR01MB4544C2F924EA24C7F6394267D8110@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20200218102224.GA812084@oden.dyn.berto.se>
In-Reply-To: <20200218102224.GA812084@oden.dyn.berto.se>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f42aa9f5-df2d-46e9-928c-08d7b45d40b2
x-ms-traffictypediagnostic: TYAPR01MB2045:|TYAPR01MB2045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB20459631780D60558743795DD8110@TYAPR01MB2045.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(6506007)(53546011)(2906002)(478600001)(9686003)(186003)(110136005)(316002)(76116006)(7696005)(66946007)(26005)(86362001)(33656002)(55016002)(71200400001)(54906003)(6636002)(8676002)(4326008)(64756008)(52536014)(81156014)(81166006)(66476007)(5660300002)(66556008)(8936002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2045;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1SwCjkk1HxqOgLqV4zj9NHDwv5Me8Qz/811WtXrt8xqKxOR0FfRD1cO2edNl0yeEMo5eAaZ7hoKyp81b/MlcpmabNUOpms71u6LakTbbAcK3cYP8VoY4+rfpXnioPQNxD6Alt3Sgbj9LLsrEE2TX3SYdZG6ZU6Pq2aKGYoB6peHhhvyftEzJeYOdL0JEz6NaxZ/ofe6WWBqconmBLUIEwBucl2SJSLGgjeuFZHW3uMxYNGb3SOffN5sq8XKbdtmJiP9zUriabKeAXOsl2V0bBmgqaFloVwCj19bAreZzlYDoP1CBKcOMbvd/Gr0Wza2MvgnoA7x/ic9ZlNeqFR165paH8F9aV5PC10zkbWihGt6ZWOXvKmNEhYG4A/uR56bPA0lk5sKwUPWUy1A5OPgIUNOMWBzFSbzTwiHKom8NFHyTj0s9/sTlH+O/fpzPvOK
x-ms-exchange-antispam-messagedata: fw/QbyxM8QX8FsZ29YWb6DNX98KVACfZyl4/Jr6fpOvrdAcUYMkKa12Q5kTu2PSOhHAUa/CgScAwKXe9k7eSVy0CDnIOu3A5f/0SFqLUSM1mGxfdTGX9dvwoXxIJ5IEXLP2PftzRbrgD7tGyYfyjsw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42aa9f5-df2d-46e9-928c-08d7b45d40b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 10:28:10.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSJNiMHQIpPk4X3rdX/45Hd98ed8a6JIYUeQdVBmmdRihHXDYxnN2inqO6pyINWi0m2RuAKOLXz7D/+rTorVzcs5iitrBZ4WOM8iY6jj85klZkPtv+9Qodb/C1T11hhn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2045
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Niklas-san,

> From: Niklas S=F6derlund, Sent: Tuesday, February 18, 2020 7:22 PM
>=20
> Hello Morimoto-san and Shimoda-san,
>=20
> Thanks for your feedback.
>=20
> On 2020-02-18 00:11:03 +0000, Yoshihiro Shimoda wrote:
> > Hi Niklas-san,
> >
> > > From: Kuninori Morimoto, Sent: Tuesday, February 18, 2020 9:01 AM
> > >
> > > Hi Niklas
> > >
> > > > > +renesas@???
> > > >
> > > > I have not used the +renesas@ for my other entry in MAINTAINERS for
> > > > R-Car VIN and wish them to be the same. I have do not mind if that =
is
> > > > with or without the +renesas tag.
> > > >
> > > > @Shimoda-san: What would you and Renesas prefer I use?
> > >
> > > Please use +renesas@ for Author when you post patches.
> > > We don't mind for other mail address, like MAINTAINERS.
> >
> > I have the same opinion with Morimoto-san.
>=20
> Ok thanks, good to know my view align with yours.
>=20
> Could one or both of you provide an Acked-by tag for this patch to bless
> it?

Oops. I should have provided it when I replied...

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda


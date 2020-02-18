Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1B161E21
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 01:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgBRALH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 19:11:07 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:38421
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgBRALH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Feb 2020 19:11:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AShLImpaWseK2QjYksQHdQ6bMrpwVCwLNIZq4WkjTqFsdishd5i8D8dF9hVnRC2bSuV9jcKl8s73GGXVhQipfnb3mNyasU4WqNpJXV9dgJP6Q79qgOzkhxoN/hCYk6Jp9zd95ic6V+1boK/y59dBtySr58JHEqBpe8A5rkn5Ms7buT0jA3Mn7fVLsUi6+lVqvEdgQb86GVXL5Y0JwMFFWFIojbw7nKsgfZCGJ13fvG1jQu2xsXGk/GVjRL3A0ReDIe4dXwNGJOpWWV9QAdGspSNDQURmB2dDPTfMvuC7DEDjYWDd2kHoyJboAdmIob4DwtaYwOZaymsDH+ZcoVxG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASdxIR7Yzk07fNbtoH1uXp1qjJJ2LqBFdakThHDBlxU=;
 b=VNaOS8FatGYTfZhUhlnsVi1V/oBQqvTTdUIeK9lAxYrd1Kk8ftSeyYYAlJcPp1vivOYB1seG8/MGf2MloVZ5rIE4APF9NTNyc/5pU2Qlr5W9MSfUNqhFFms92DeiOlk19cWNOsHsRsl46IxH8ZP/r+V5HNmzINtb0SCsUIL9e+xLuEiWIY0qk9EOAUbPM6JPaO9Q6z98GyceM1aRNHaMToJJu0xOKWIY4TsVx/JydSFVp/kShocyRLnP2DUZTaGtJtK8dQpXu3ttHv5R9S1BeBNtS8rxsIW09QMzD3++lbbUCP2+xtGGmkm4EHDdWg3rL+cWlCWaYoiLcRey//mR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASdxIR7Yzk07fNbtoH1uXp1qjJJ2LqBFdakThHDBlxU=;
 b=f/5DW0QaI/FLWAE/3Cr2PMkdNdH/MkWgs6W9tHqieRHGIavggt4K7oMwv8l7ytaTu1ZMdzZatnvcPJUvZTUCWtUfNv/mXo4oHu0Kp7uBbVzc5mJMBtExCXb0QhZHi9AdDejYWfqohhafJhVW+Uh2cRQDXZ4AGISNpV4cx1Rz10c=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4799.jpnprd01.prod.outlook.com (20.179.175.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 00:11:03 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 00:11:03 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?iso-8859-1?Q?Niklas_S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Thread-Topic: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Thread-Index: AQHV5MmmLymxK/lC2USJviU/BgNMZagfB0oAgAAkTgCAAOfAAIAAAoog
Date:   Tue, 18 Feb 2020 00:11:03 +0000
Message-ID: <TYAPR01MB4544C2F924EA24C7F6394267D8110@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
        <CAMuHMdUdBVwAbG8Qicg3_aKvwjq91QJWS5FQwM6NPdgbyP2Wzw@mail.gmail.com>
        <20200217101114.GO3013231@oden.dyn.berto.se>
 <87zhdg2293.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zhdg2293.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3083474-ced8-4726-5194-08d7b4070ac2
x-ms-traffictypediagnostic: TYAPR01MB4799:|TYAPR01MB4799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB47995EDC3A869F675B7BE120D8110@TYAPR01MB4799.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(55236004)(71200400001)(186003)(86362001)(5660300002)(478600001)(4744005)(6506007)(4326008)(52536014)(316002)(33656002)(2906002)(81156014)(76116006)(26005)(110136005)(7696005)(54906003)(66476007)(64756008)(66446008)(66556008)(55016002)(8676002)(66946007)(9686003)(81166006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4799;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFbt5w6EyA4+6/G5UDVHNocEOKdX3sYbvfeGXBY+6X0PwKaumieydtDCag8nz/SEjmIuYsXwqrfIzwu+Su9EG+t3vi/s5ELd3Q0ynLTNYeYedctUUp2uKQKOA/9D9hsavLQV54xvZq+eo2ypY+tjo4T2pCHRuArMPD5Wp9pqtbD92E5MofS/Kp6LilQTP+fRWqWAKqGDPy4QxztXTD9TPHmBdkSJzG8qBWuTtALfcNw4mWfAy4ct9rrcDwkTZLjHckfbQY8FTexoGUccJ9Jx9yI+wLwaT/6MbpTzl95neZNqxGTa41jOSIBFyXBOjQUDhtMlwiaUKY8i5EDwXvale5lFN5jn8Tmrj5GGN1BT8IXcuxIdEQRNO4vbjCp1I049q+Xp6OCs3yQegVr4Usdon1VQorBw9GFCJoylevzusEgJOthd/Rn/cgAe2KC1nJme
x-ms-exchange-antispam-messagedata: FWaZxp6UW3WBpHlHgZdqXEOQmBm+EXKZlaaXjZg+CFtKMK9+x7GNcePBmc8axhQnsyVKNi27CvXvWOEgu6YJ4M5NfbZS2wtR76EfUhJAlcIuCOGAJUxRA44dAnX0sMxXsFbFPUtGb9iw2biaV/f67g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3083474-ced8-4726-5194-08d7b4070ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 00:11:03.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kb0L9bkRPqhbr6eXPL+5SbFQPEIUWtwsblJff0ErbNcrPql8NIRIa0woxj3PRMPPz+7IM70ut/K27fCgwBU7DKwbOEylGjSJD4Htpu6J6PMI97/IOvySJbmo+lWktMe8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4799
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas-san,

> From: Kuninori Morimoto, Sent: Tuesday, February 18, 2020 9:01 AM
>=20
> Hi Niklas
>=20
> > > +renesas@???
> >
> > I have not used the +renesas@ for my other entry in MAINTAINERS for
> > R-Car VIN and wish them to be the same. I have do not mind if that is
> > with or without the +renesas tag.
> >
> > @Shimoda-san: What would you and Renesas prefer I use?
>=20
> Please use +renesas@ for Author when you post patches.
> We don't mind for other mail address, like MAINTAINERS.

I have the same opinion with Morimoto-san.

Best regards,
Yoshihiro Shimoda

> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto

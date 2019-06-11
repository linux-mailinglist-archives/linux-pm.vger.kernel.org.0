Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFF4186A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfFKWuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 18:50:37 -0400
Received: from mail-eopbgr730126.outbound.protection.outlook.com ([40.107.73.126]:14512
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391638AbfFKWug (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 18:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyT2XrMU4bdbnRm2CT2ytKqdkRyAcSjYROHEyXXGKQ0=;
 b=hzo/7M2nh/X1jQiXQXYRv9jZuZFm1w7fJdaX5dPO/JAt341TlujQOCBX93l/am4oGTDuAHWE7b/d/oDo41i6QB4spR6THl8qkRPpB7lFZqTMBh/icpAizHgGjnMCtYOFRWLZrx3SRWAwch0tG4sakP8HUF3R0dAyOkx4voG/Fg8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1373.namprd22.prod.outlook.com (10.174.162.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Tue, 11 Jun 2019 22:50:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40%2]) with mapi id 15.20.1987.010; Tue, 11 Jun 2019
 22:50:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "od@zcrc.me" <od@zcrc.me>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] MIPS: Remove dead code
Thread-Topic: [PATCH v2 5/5] MIPS: Remove dead code
Thread-Index: AQHVIICnCC0E6RPYlEOSw1p5P/LHgKaXDw4A
Date:   Tue, 11 Jun 2019 22:50:15 +0000
Message-ID: <20190611225013.bkqmxczedrbg3nlk@pburton-laptop>
References: <20190611180757.32299-1-paul@crapouillou.net>
 <20190611180757.32299-5-paul@crapouillou.net>
In-Reply-To: <20190611180757.32299-5-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::40) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fd418ed-ddff-412e-d2d5-08d6eebf2b6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1373;
x-ms-traffictypediagnostic: MWHPR2201MB1373:
x-microsoft-antispam-prvs: <MWHPR2201MB13730A7FCC2AEB989577EE31C1ED0@MWHPR2201MB1373.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(396003)(376002)(346002)(366004)(199004)(189003)(99286004)(76176011)(386003)(52116002)(6506007)(305945005)(8676002)(6512007)(9686003)(71200400001)(71190400001)(6486002)(81156014)(81166006)(1076003)(7736002)(229853002)(42882007)(6436002)(2906002)(3846002)(478600001)(186003)(102836004)(6916009)(11346002)(446003)(26005)(6116002)(14454004)(66476007)(64756008)(66946007)(476003)(6246003)(66446008)(73956011)(4326008)(44832011)(53936002)(66066001)(25786009)(486006)(58126008)(33716001)(68736007)(8936002)(7416002)(5660300002)(66556008)(256004)(54906003)(558084003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1373;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8E7OdQeWsInO3p8XTAMKxDXMH/exr3E8NvZyDObbCa7Ire6CTSEZk0xxMVtbF6dLE+DPxUpgIudW4VskoUrHYWGUA7WAUSIVr5jrQpH7kbwDxg9t7JGvOA6RtiLj0tHj1qv3IRBfUTv9yE6yJsF36a+FWmclTJ3MxgW4UZARajmlt045Xb0rokqRFH4JF0NcUYi7sLNims8V2H9ZCyRPFakfP/5QnvWo1fqJAN7RVcg8Yh+6hz28bEldVLpzPhN5YasNvFWru4Radc5S+wmLqUnJma54pgsDDLKgZbbx/gdaXUIinKpCGByH7owlb5PkYCHkm+1zti5Njl169HRFiFsLHPmqM/WNvxatSqCAOV2n2O1/yETLbxyTo39mvtc4H5b+pg8ckBNvnYpg/Mt0nHgx/QecEkXxZaWEwLJuKdk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D8F45445836954CAB4CD679FBCC66DF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd418ed-ddff-412e-d2d5-08d6eebf2b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 22:50:15.9425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1373
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Paul,

On Tue, Jun 11, 2019 at 08:07:57PM +0200, Paul Cercueil wrote:
> Remove the unused <asm/mach-jz4740/clock.h> include.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Presuming this goes via the clk tree:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF3176F31
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 07:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCCGQG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 01:16:06 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:57762
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727426AbgCCGQG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 01:16:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwd8hbTs6+x1c0JHE2bAAcweuQd2A1jsM6O0Q+WeGspavKf7vBOxIOSqKqjT4Rodo51BBrQo41R8toWWNKzLt+Wy/YR/cOfOG0eiqiQg7VZzgLtcdQAisTbXM5Z2DuOYcM4KbNuCQnK4sYxIpkdYd+27YUER/F3WDCtG5V8QGkn7UZNADllUsVmGc1H8qsCKLi5pJ9Q0Ivs2gXzvbEuxgsyB0P7+UrXk5QsKEAXom34z5Ij4hdru2vTEp6p34iVW0Pz+HHQtI9tR3uDUOSgxXRdQJlEdvOCdYJpMzm1vz6zZTyuUhjnKGdOqWOLaWLYzUSHd5Pg7Jzk3R6gbotoTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQJH8eVrJTmgv9yhZbRpk0PKjGnyD0myRVUaM1wn4og=;
 b=BM5QnQ+S18Bhjq0ZVQZfDUBEDHkaOZc8ecIEllmxIVBQ0f3wzWQpsORtg9bPeIQPVxXwa8AYsvun1M7LWTHovFoqNrZbkec/VvMU3GduY15bP2Q4uWTiFuhhsRiZ3U4zBBmnIz9MYQ80m1gcJ9gXz481SMBdatMu6hXjXXBugETpDlxIKHb1WfMhb9aJP8datGUpg0WXoe+6D0Fqe4SGEKjuANsKTiFC9RU3YytBiDZ/2oY6/hnEnV4LVERXIM9W70hkY5FoXVhL+0oYcZbmMUgZIhaFdNKRGp3d0HjOQPPC6sKokWbDyNgdPQMVu4hageV1s9HanSsVBxNR8lOm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQJH8eVrJTmgv9yhZbRpk0PKjGnyD0myRVUaM1wn4og=;
 b=D44FedmNw0KjmFpM0DTADyfGhV2lNnZQIJaKtX7EF7E7yunxotliUa34sOyp66jntOtnpdId8LoLZUbvLBNcGrudSjBwMHPE00mQCCXUQ5sRoCiZKapX+FnMO+KbGHs4VH1sr2cYwql7AR48684wK8ARu0xh0Qf3MsYP84HrkXI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6881.eurprd04.prod.outlook.com (52.132.215.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 06:16:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 06:16:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
Thread-Topic: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
Thread-Index: AQHV8QJkDs1b7gEXw0mPCPayRF0Q4Kg2W/SAgAABb8A=
Date:   Tue, 3 Mar 2020 06:16:03 +0000
Message-ID: <AM0PR04MB4481FDAD041F6476FFFC0F6788E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
 <20200303054547.4wpnzmgnuo7jd2qa@vireshk-i7>
In-Reply-To: <20200303054547.4wpnzmgnuo7jd2qa@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1aa7a1c6-2be4-4963-9232-08d7bf3a59fd
x-ms-traffictypediagnostic: AM0PR04MB6881:|AM0PR04MB6881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68810DBBF10F0CBD7848960B88E40@AM0PR04MB6881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(7416002)(54906003)(86362001)(4326008)(316002)(33656002)(53546011)(8676002)(6506007)(71200400001)(81156014)(7696005)(81166006)(8936002)(6916009)(66476007)(5660300002)(52536014)(66946007)(64756008)(9686003)(66446008)(66556008)(55016002)(44832011)(2906002)(4744005)(76116006)(478600001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6881;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kq9u7fWzbqJEWzfXOWhF1/ABQhfy3l4vnwsBdZ+UfYSR8n5RscehzaisJBg7BcwK8a4SwD1SpUL1t/iboBmg8YdoQynFMHoxTge6KaG5eBQ8bybs4CHh0xuY0GcJTviJtLIMh1UMFN3nSorrw2y7tkhKTwVbq5yC1wTz3ae84ZpoI5I2MjAtf1goK96ln2TLL3K1rfgRWtd/yc7LwNG+XVQXdAEkqFlqzUc9BxRrSsQ9IG55o6YRj6paCkmwXrZ4QU1vi5xyTM9NzMgkg7j9YREr7QSEfqc0xF0J8nWxOVsP0w01suBopVxaT+KaonhtJYt029In3F0+FZNYDERM82KWcwP8JBPGs9ushncMSqqdqULqycbxD4+UwxK9B2ZPL5PDu0LQXbkgEmWgkrEyL2OxL87mdo6pg+AV1gdM4fW7x4GJiKNn1fxT55ThRQ7D
x-ms-exchange-antispam-messagedata: NJmObuxTmiL5veKVUIGku0zG+hJ9r+hk5h3j1pdHR2u8h9OlnYHtSyFcPbM+2PQW2TTVrDWwq2iIOz/D6pYyOOPLDw9UXLcZurUrg1FPd7jZOSjGEn+uSt8iobjE4ADtjos2lknTIvygtLiRUimUdw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa7a1c6-2be4-4963-9232-08d7bf3a59fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 06:16:03.3943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSLbgHuPHeijrHC80RaA146NQmNPPz3gJ6Wq0nW/aFswp3fCu0ALUBHJLRldxAHWbjvt/u8CvfHGzy3OPLdRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6881
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

> Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
>=20
> On 03-03-20, 10:14, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use nvmem API is better compared with direclty accessing OCOTP register=
s.
> > nvmem could handle OCOTP clk, defer probe.
> >
> > Patch 1/3 is dts changes to add nvmem related properties Patch 2/3 is
> > a bug fix Patch 3/3 is convert to nvmem API
>=20
> Should I apply patch 2 and 3 ? And you can take 1/3 via ARM Soc tree as t=
his
> shouldn't break anything.

Please take patch 2 and 3. Without patch 1, it just use legacy method,
not break things.

Thanks,
Peng.

>=20
> --
> viresh

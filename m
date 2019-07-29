Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEA786AB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfG2Htu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 03:49:50 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:45191
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfG2Htu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 03:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki1/D6WtsSogiXvtv4PvCJCyAVSpniqnMNJ0hWxogBLAJe6HQ1TPihTmkBLjF0mPFbYVB7HFoLQY8eoMkKGGvmtUm31FhSFzxgPvoDAjyRgPe3C/9tNMdhIgHjws/9KnrwpqQqCC08ltPh9zdfXQ0qWLbOS0ueJXjm0EaCt00i8t8IcngLnakgqldpmSrdPc592wcKhdS9F7p1TbI/F9DMFS2c4xhVbuw/0ie+K4mUHiTYuTU9q75XuEKT+Gvf6aX4JQpGiHpeOmCX+6yPBzemOGtJ9l7bml1RDjp7G25WG1OEC8ZsEha+5UYXt5w/U/FqBDTRlVI93dyUmfxt5f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTvtcN/CLQs6tL8Y6bdfQsZg7VVWDqgB2ZU02nYsfNI=;
 b=MW2dg8gyzHYzHKrHhJlTV38vk6GxuYE23agZbiYHLHNgfibOU5aZ3iFAJnVB6fxMu/jYLM3TtjY2AKb0cZMB57i/bg1UI6Zl+2qnryGuDLbJOoc9lo5FEK8PjA7vcERe/eim/p+7VNic5eab1C2ItwvNbMdJIhpuE5/pB3us1s34JyoFIBhUEt3aVlWRUE/STHs7lUQxOFoS4SXwT3kODkmjPZXtQ3Rb8zvcuUB0frJqFJ8aiJFnevZ1fR/zU+ksDK9pmBKD4XZuUP4yv7LCVgexAByz5iU/rO0Q6qOUfvOFPyIvhOYpVqijaorhKHrSRX1cCks1rLT6yZ/M4O6ugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTvtcN/CLQs6tL8Y6bdfQsZg7VVWDqgB2ZU02nYsfNI=;
 b=AQyT1gIO4fHwutwRXp8IJ/4a5PiEE2/Lo4uKtFpJKMXY3/OhBSRNvy0nunT46tqB07OJC4Sl5ffhpr+Bk81wL02n4apncS8nLHuOaCrGkIC9zKcxeuGzTEeW7Lx/5HIQYuqbJ1+J/eUhqNM0XTPH3hfG0ImVSEtuBOdeJcfXT9g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 29 Jul 2019 07:49:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 07:49:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Abel Vesa <abel.vesa@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Topic: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Thread-Index: AQHVMu9Qagn4ZAj9sUKncGzfKuws0abdnJEAgAB74HCAAAwBAIAAo0oAgAIrlTCAAFrfgIAABfvAgAACIoCAAAA8AIAAB3VQ
Date:   Mon, 29 Jul 2019 07:49:43 +0000
Message-ID: <DB3PR0402MB3916F32F03E542AEFBD39A43F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175>
 <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com>
 <DB3PR0402MB391627F725AA7237BCACBE87F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZBrmikenTvnh7syhy=PDPcTL3fn2TJ+ya=ToZ+SFmH5tw@mail.gmail.com>
 <CAEnQRZDSjmcU8Q7+kMeFf12tx0NuMNjrcsgnXayvHpu4ChwHGA@mail.gmail.com>
In-Reply-To: <CAEnQRZDSjmcU8Q7+kMeFf12tx0NuMNjrcsgnXayvHpu4ChwHGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c879750-2cc1-423d-a2b0-08d713f951e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB3PR0402MB3897E8708A7E4BFF1F69D450F5DD0@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(43544003)(189003)(199004)(486006)(3846002)(76176011)(33656002)(71190400001)(71200400001)(44832011)(446003)(76116006)(66476007)(66556008)(64756008)(66446008)(316002)(66946007)(229853002)(7696005)(6116002)(6916009)(7416002)(476003)(99286004)(53546011)(26005)(25786009)(6506007)(102836004)(11346002)(86362001)(2906002)(8676002)(54906003)(5660300002)(6306002)(55016002)(966005)(478600001)(74316002)(7736002)(14454004)(305945005)(81156014)(66066001)(81166006)(53936002)(9686003)(6246003)(68736007)(14444005)(52536014)(186003)(256004)(8936002)(6436002)(4326008)(45080400002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: smg9KVH8T0GIkC9PwV3yRgI8jCLuQByiYl6/hGIss7QYu3f32EAA0r+lK0MS5rf8Ti+7JzfS1YgqjFqqxWUS31snFTficf9pkI3f2n2kePRTeBYcrkXLi+uGk/TtrWLu0bMlvhlpnCf5hkQ7InVVbIuXCfKKNAmrlPw70/LrSIAUjE+KPbc/K+hnkd3srAX0LM+waF2B4n1Bx3WN0Cs/Jqq0mfDThdemgUFMwFfHJu14hZTz6FVvHCyFtTCWiHwvM+PLQ7xlg0nZVuYspIG63Sv2Axitan0ELyQyIxXyn32h3DwxLYTJq4qoSpUsBIEO5ikNymbpegnXthZZscHWK3I7kGlGmlhJs8CW0MCWPM3/aAJyEF2Cfatg32yh65YLK3kZ8hWQV48WUlLvUFcf55lcELf0jIrDNbQ4bsEa+Rg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c879750-2cc1-423d-a2b0-08d713f951e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 07:49:43.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIE1vbiwgSnVsIDI5LCAyMDE5IGF0IDEwOjIwIEFNIERhbmllbCBC
YWx1dGEgPGRhbmllbC5iYWx1dGFAZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IDxzbmlw
Pg0KPiA+ID4gPiBZb3VyIGV4cGxhbmF0aW9uIG1ha2VzIGEgbG90IG9mIHNlbnNlLiBXZSB3aWxs
IHRha2UgY2FyZSB0b2RheSBvZg0KPiA+ID4gPiBBYmVsJ3MgcGF0Y2guDQo+ID4gPiA+IFdoYXQg
ZG8geW91IHRoaW5rIGFib3V0IEZhYmlvJ3MgcGF0Y2g/IEkgYWxzbyB0aGluayB0aGlzIGlzIGEg
dmFsaWQgcGF0Y2g6DQo+ID4gPiA+DQo+ID4gPHNuaXA+DQo+ID4NCj4gPiA+DQo+ID4gPiBIbW0s
IHdoZW4gZGlkIEZhYmlvIHNlbnQgb3V0IHRoaXMgcGF0Y2g/IEkgY2FuIE5PVCBmaW5kIGl0Li4u
DQo+ID4gPiBJIGFsc28gaGF2ZSBhIHBhdGNoIGluIHRoaXMgc2VyaWVzICgjNC82KSBkb2luZyBz
YW1lIHRoaW5nIG9uIEp1bHkgNXRoLi4uDQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGENCj4gPiA+
DQo+IHRjaHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTEwMzI3ODMlMkYmYW1wO2RhdGE9MDIl
N0MwMSU3Q2Fuc28NCj4gbi5odQ0KPiA+ID4NCj4gYW5nJTQwbnhwLmNvbSU3QzA0OGQ4Njk1YjNk
YzRjZWVmNmJkMDhkNzEzZjU1ZThhJTdDNjg2ZWExZDNiYzINCj4gYjRjNmZhDQo+ID4gPg0KPiA5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjk5OTgxNjg4MDExODY3NCZhbXA7c2RhdGE9MUhJ
TVEwbA0KPiBpS3BFRlMNCj4gPiA+IDZQMldTRyUyRkg5ZXZzcHhJZHhBdkZtYWtsSDF3b0RrJTNE
JmFtcDtyZXNlcnZlZD0wDQo+ID4NCj4gPiBIZSBkaWRuJ3Qgc2VuZCB0aGUgcGF0Y2ggeWV0LiBJ
dCB3YXMganVzdCBhIHJlcXVlc3QgZm9yIHRlc3QgaGVyZToNCj4gPg0KPiA+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGY29k
ZS4NCj4gPiBidWxpeC5vcmclMkZwZDg4anAtDQo+IDgxMjM4MSZhbXA7ZGF0YT0wMiU3QzAxJTdD
YW5zb24uaHVhbmclNDBueHAuY29tJTdDMA0KPiA+DQo+IDQ4ZDg2OTViM2RjNGNlZWY2YmQwOGQ3
MTNmNTVlOGElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzDQo+IDUlN0MwDQo+ID4g
JTdDMCU3QzYzNjk5OTgxNjg4MDExODY3NCZhbXA7c2RhdGE9cDcwbWdDRHVjQ2dMSjhUVFJNbjNh
JTINCj4gRms2OEZYR1FlaVINCj4gPiBGUjBmVlNWN0psbyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+
DQo+ID4gQnV0LCBub3cgSSBzZWUgaXMgZXhhY3RseSBsaWtlIHlvdXIgcGF0Y2ggaGVyZToNCj4g
DQo+IC4uLiBwcmVzc2VkIHNlbmQgdG8gZWFybHkuDQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm8NCj4g
cmclMkZsa21sJTJGMjAxOSUyRjclMkY1JTJGMTkmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1
YW5nJQ0KPiA0MG54cC5jb20lN0MwNDhkODY5NWIzZGM0Y2VlZjZiZDA4ZDcxM2Y1NWU4YSU3QzY4
NmVhMWQzYmMyYjRjNmYNCj4gYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTk5ODE2ODgw
MTE4Njc0JmFtcDtzZGF0YT1jaVdqOHkNCj4gV1B2a0laNW5pJTJCb2hadWFxQVhmOVBiMkZDV2hw
OUdRaHBNd0FZJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBXZSBhcmUgYWxsIHNldCB0aGVuLiBU
aGFua3MgQW5zb24gZm9yIGNsYXJpZmljYXRpb25zIQ0KDQpUaGFua3MsIHNvIHdlIGFyZSBhbGwg
Y2xlYXIgYWJvdXQgdGhpcyBpc3N1ZSwgbmVlZCB0byB3YWl0IHRoZXJtYWwgbWFpbnRhaW5lciB0
byByZXZpZXcNCnRoZSByZXN0IHBhdGNoIGluIHRoaXMgc2VyaWVzLCBidXQgSSBkaWQgTk9UIHJl
Y2VpdmUgYW55IHJlc3BvbnNlIGZyb20gdGhlcm1hbCBzdWItc3lzdGVtDQptYWludGFpbmVyIGZv
ciByZWFsbHkgbG9uZyB0aW1lLCBOT1Qgc3VyZSB3aGVuIHRoZSB0aGVybWFsIHBhdGNoZXMgY2Fu
IGJlIGFjY2VwdGVkLg0KDQpBbnNvbg0KDQo=

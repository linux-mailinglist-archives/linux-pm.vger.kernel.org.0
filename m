Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDD1A35CC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgDIOWx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 10:22:53 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:61187
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbgDIOWx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 10:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr0ZjtxvQQcqXgxdOCNVcfWUemoJKUctp1lHDRzZR3gw8EfgE14QtvstiMZQpJ+CpDqvDPue48GOYQ1mXPBooFRLq21WPsXe5z22KubCwq7dWyvJlvpYD+45ot0qe/D/aza1xmg+4it1FV5IdZ19SeYUs1EG901Q6Mj6rpkOm/YMVvOyEjxCZx1V8v32JCux6nUe/od2KjfAJTcfbjToW8zYa3Xn1xP8AV8K/nksASDOBfl0sZoIn6VTeP2ibVUyvTD64R4bW4g6dXWbEq81nwuj5stqXkRfYI4MCinS9PRz3/q+PaJDqegCC0kGLo2yE2AV+uH8fE+QoLFg0BrsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/vvbJOc422qaHUzuJHahQtiGQDqmsMBSmQoxoXqzik=;
 b=jvI2nENBYBC7/8WDKS0WMNK98dakk8sRqENqNbQJtJudD35bgxV5Nba1YGYromOMa2zi+cyP//BdIw2RjmwO7MgY/DQJk99EdbVT+cVEL+hqzTCqeBOOEUuXYPtNHS0gbMxEKTl7QQC4i1W+t7SefA56AlY/PO/7LTGua5xpV3wMfSAapCue5Gt8SE0KmwYWjTN/j1G/KO8/Y62JjVFRCfrlMtJRE+JDM/N8pMcdjsu6xsiYqD5yDaSHz5S5DCvDzdv5CPmNyhWWSb9nxBPEmEIcBrSL/hc8WJVSjLWsYZ5SFKxQXvYcB4lcVnODdeqwvdsN6OibdgBILm64fPhCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/vvbJOc422qaHUzuJHahQtiGQDqmsMBSmQoxoXqzik=;
 b=Bq2k6W69k4Lp9/3Es60f+33tXIQeLe3jMfNwJuqpLbeXcKOM7Ukk1KaxJyHlMEhIl4CCqGWF2xPrpoPD4Rzh3F54RwON2cL0o+8VKtqYS179koncB+PGmVJ1X+m+m1k7NlPYh02fJe88kSPmBe6UhO/62+8PbFg2rFaq1tMWqaM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3819.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 9 Apr
 2020 14:22:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2878.017; Thu, 9 Apr 2020
 14:22:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: thermal: Convert i.MX8MM to json-schema
Thread-Topic: [PATCH] dt-bindings: thermal: Convert i.MX8MM to json-schema
Thread-Index: AQHWDh6eVqsQPsFREUa3AYHCzbRZsKhw0f+AgAAEthA=
Date:   Thu, 9 Apr 2020 14:22:35 +0000
Message-ID: <DB3PR0402MB39160A94CD5E97AA79E2DB5AF5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1586402293-30579-1-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerNonZ7qJi8Qihmj87QteEnxTF0PRS6vw5GPemMurOfS9Q@mail.gmail.com>
In-Reply-To: <CAHLCerNonZ7qJi8Qihmj87QteEnxTF0PRS6vw5GPemMurOfS9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37f53c12-7536-41cc-1f4b-08d7dc917353
x-ms-traffictypediagnostic: DB3PR0402MB3819:|DB3PR0402MB3819:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB381961BECCE7802F59E0BB26F5C10@DB3PR0402MB3819.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(52536014)(66476007)(53546011)(4326008)(66556008)(76116006)(8676002)(54906003)(66946007)(7696005)(8936002)(64756008)(316002)(6506007)(71200400001)(44832011)(81166007)(9686003)(6916009)(45080400002)(33656002)(26005)(55016002)(66446008)(5660300002)(81156014)(2906002)(86362001)(186003)(83080400001)(7416002)(478600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vxf/BhmByAUtb2CFhaVrYdZ73U2yElqd14vJEtt6hH9LGmYMte6nBskdKB/C/QrW55iCLaKKy9gaoghjbHkSDCnUoq/0kj4T01XELoEJstYL/mNqG0944D/EDPNuL3YJbl+7rYwwfqAoJS1SFvxaTC1SdeeZsfxL3YS85+r8eJql+AzRZtSTvmtTLeoXG8M8/ki2tAjWJDhRcnWAkKzolV7hKVTCXZAfMSzJup022qIG5RzUFiHLhoUKnngdREW4XSjuNmXtjqwurxK+SCGD81FlME+grwYfltN3mh83+12M6+EqvCGrZr1DQXVD4csnCj/L/B864UwlvFql+hQuO2I45TIxW2UNVdnmcF32e6ahVrNcjY8vz/zB3kHLC8t1Z7oNGkC3K3QEcHv6uclXuGs9KHKECU4MPB/AbyIpqhXAf1nBuLK1+gxTP2TPqujEz7BmA67/iYWSEl4762JXDwOBBJduM1+e5zVNtAdC3txCAForaOqQOp2hZHjKgIq8C1hSTLFhcmeAu6KH+Bn9Ig==
x-ms-exchange-antispam-messagedata: ovaxsw5qxxciUpLLA7mob7T///Cu+N0G7ZV7i+8kkUQZpt5qW5QaKJ6hxRX8aFOh8gmTcWgruD+SiEzlfDwqn3eD9o/w7+hS8emR9QgZZ0XjHxItd2ownM2avSh9p9+EuSHYgMB6hSrD1Rq0WvglLQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f53c12-7536-41cc-1f4b-08d7dc917353
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 14:22:35.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T52ULGU6/1REWtfilU23XxGrpAAQ5eM4AckaAkvy6d3AGdJFuCan46qqUAViEtYcLIF82oKasPjlVawe/xnUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3819
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFtaXQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogdGhlcm1hbDog
Q29udmVydCBpLk1YOE1NIHRvIGpzb24tc2NoZW1hDQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IE9u
IFRodSwgQXByIDksIDIwMjAgYXQgODo1NiBBTSBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBDb252ZXJ0IHRoZSBpLk1YOE1NIHRoZXJtYWwgYmlu
ZGluZyB0byBEVCBzY2hlbWEgZm9ybWF0IHVzaW5nDQo+ID4ganNvbi1zY2hlbWENCj4gDQo+IFdv
dWxkIGl0IGJlIHBvc3NpYmxlIHRvIGhhdmUgYSBzaW5nbGUgeWFtbCBmaWxlIGZvciBhbGwgaS5N
WCB0aGVybWFsIHNlbnNvcnMgYnkNCj4gcGxheWluZyB3aXRoIHJlcXVpcmVkIGFuZCBvcHRpb25h
bCBwcm9wZXJ0aWVzID8NCg0KaS5NWCBTb0NzIGhhdmUgbWFueSBkaWZmZXJlbnQgdGhlcm1hbCBz
ZW5zb3IgSVAgYW5kIGhlbmNlIGRpZmZlcmVudCB0aGVybWFsIGRyaXZlcg0KaXMgdXNlZCwgYW5k
IGRpZmZlcmVudCBpLk1YIHRoZXJtYWwgZHJpdmVycyBoYXZlIGRpZmZlcmVudCBEVCBiaW5kaW5n
cywgc28gaXMgaXQgZ29vZCB0bw0KcHV0IGFsbCBvZiB0aGVtIGludG8gc2luZ2xlIHlhbWwgZmls
ZT8gRm9yIGV4YW1wbGUsIGlteF90aGVybWFsLmMgaXMgZm9yIGkuTVg2LzcgU29DcyB3aGljaA0K
ZG8gTk9UIHVzZSBvZl90aGVybWFsIGZyYW1ld29yaywgaW14OG1tX3RoZXJtYWwuYyBpcyBmb3Ig
aS5NWDhNTS9pLk1YOE1QIHdoaWNoDQp1c2Ugb2ZfdGhlcm1hbCBmcmFtZXdvcmsuDQoNCklmIHB1
dHRpbmcgYWxsIG9mIHRoZW0gaW50byAxIHlhbWwgZmlsZSwgaXQgd2lsbCBiZSBhbG1vc3QgbGlr
ZSBqdXN0IHB1dHRpbmcgMiBmaWxlcyB0b2dldGhlciwgSQ0KUGVyc29uYWxseSBkb24ndCB0aGlu
ayBpdCBpcyBhIGdvb2QgaWRlYS4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdGhlcm1hbC9pbXg4bW0tdGhlcm1hbC50eHQgfCAxNSAtLS0tLS0NCj4gPiAgLi4uL2Jp
bmRpbmdzL3RoZXJtYWwvaW14OG1tLXRoZXJtYWwueWFtbCAgICAgICAgICAgfCA1Mw0KPiArKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygr
KSwgMTUgZGVsZXRpb25zKC0pICBkZWxldGUgbW9kZQ0KPiA+IDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9pbXg4bW0tdGhlcm1hbC50eHQNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Ro
ZXJtYWwvaW14OG1tLXRoZXJtYWwueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvaW14OG1tLXRoZXJtYWwudHh0
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9pbXg4bW0t
dGhlcm1hbC50eHQNCj4gPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAzNjI5
ZDNjLi4wMDAwMDAwDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3RoZXJtYWwvaW14OG1tLXRoZXJtYWwudHh0DQo+ID4gKysrIC9kZXYvbnVsbA0KPiA+IEBAIC0x
LDE1ICswLDAgQEANCj4gPiAtKiBUaGVybWFsIE1vbml0b3JpbmcgVW5pdCAoVE1VKSBvbiBGcmVl
c2NhbGUgaS5NWDhNTSBTb0MNCj4gPiAtDQo+ID4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
LS0gY29tcGF0aWJsZSA6IE11c3QgYmUgImZzbCxpbXg4bW0tdG11IiBvciAiZnNsLGlteDhtcC10
bXUiLg0KPiA+IC0tIHJlZyA6IEFkZHJlc3MgcmFuZ2Ugb2YgVE1VIHJlZ2lzdGVycy4NCj4gPiAt
LSBjbG9ja3MgOiBUTVUncyBjbG9jayBzb3VyY2UuDQo+ID4gLS0gI3RoZXJtYWwtc2Vuc29yLWNl
bGxzIDogU2hvdWxkIGJlIDAgb3IgMS4gU2VlIC4vdGhlcm1hbC50eHQgZm9yIGEgZGVzY3JpcHRp
b24uDQo+ID4gLQ0KPiA+IC1FeGFtcGxlOg0KPiA+IC10bXU6IHRtdUAzMDI2MDAwMCB7DQo+ID4g
LSAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4bW0tdG11IjsNCj4gPiAtICAgICAgIHJlZyA9
IDwweDMwMjYwMDAwIDB4MTAwMDA+Ow0KPiA+IC0gICAgICAgY2xvY2tzID0gPCZjbGsgSU1YOE1N
X0NMS19UTVVfUk9PVD47DQo+ID4gLSAgICAgICAjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MD47
DQo+ID4gLX07DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3RoZXJtYWwvaW14OG1tLXRoZXJtYWwueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvaW14OG1tLXRoZXJtYWwueWFtbA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uNTNhNDJiMw0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhl
cm1hbC9pbXg4bW0tdGhlcm1hbC55YW1sDQo+ID4gQEAgLTAsMCArMSw1MyBAQA0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0N
Cj4gPiArJGlkOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRnNjaGVt
YXMlMkZ0aGVybWFsJTJGaW14OG1tLXRoZXJtYWwueWFtbCUyMyZhbXA7ZGF0YQ0KPiA9MDIlNw0K
PiA+DQo+ICtDMDElN0NBbnNvbi5IdWFuZyU0MG54cC5jb20lN0NiMTkwZTA0OTEzMGU0OWUwNzUw
ZDA4ZDdkYzhlNDgNCj4gYTMlN0M2ODZlDQo+ID4NCj4gK2ExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzNzIyMDM3NTk2Mzg4ODQ1NyZhbQ0KPiBwO3NkYXRhPXMNCj4gPg0K
PiArUzglMkZSMmolMkJUMVVtRHFYRklQUHpQZ1dzMjZsTWl3VzNzYVRxNHFsWkFVcyUzRCZhbXA7
cmVzZXJ2ZQ0KPiBkPTANCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4g
K2NldHJlZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9MDIlN0Mw
MSU3Q0Fucw0KPiBvbi5IdWENCj4gPg0KPiArbmclNDBueHAuY29tJTdDYjE5MGUwNDkxMzBlNDll
MDc1MGQwOGQ3ZGM4ZTQ4YTMlN0M2ODZlYTFkM2JjDQo+IDJiNGM2ZmE5Mg0KPiA+DQo+ICtjZDk5
YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyMjAzNzU5NjM4OTg0NTQmYW1wO3NkYXRhPXRYSWg5ZCUN
Cj4gMkJzemNFeEgwDQo+ID4gKzdpYzdzJTJCcUp5VWRiRTBhSE0zdEglMkJ3a1dnbmJoUSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiA+ICsNCj4gPiArdGl0bGU6IE5YUCBpLk1YOE0gTWluaSBUaGVybWFs
IEJpbmRpbmcNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAg
ICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tdG11DQo+ID4g
KyAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLXRtdQ0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGRl
c2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIEFkZHJlc3MgcmFuZ2Ugb2YgVE1VIHJlZ2lzdGVycy4N
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgZGVzY3JpcHRp
b246IHwNCj4gPiArICAgICAgVE1VJ3MgY2xvY2sgc291cmNlLg0KPiA+ICsgICAgbWF4SXRlbXM6
IDENCj4gPiArDQo+ID4gKyAgIyBTZWUgLi90aGVybWFsLnR4dCBmb3IgZGV0YWlscw0KPiANCj4g
RG9uJ3QgcG9pbnQgdG8gdGhlcm1hbC50eHQgYW55bW9yZS4gdGhlcm1hbC50eHQgd2lsbCBiZSBy
ZXBsYWNlZCBieQ0KPiB0aGVybWFsLSoueWFtbCBmaWxlcyBhdCBzb21lIHBvaW50IHNvb24uDQoN
Ck9LLCB3aWxsIHJlbW92ZSBpdC4NCg0KPiANCj4gPiArICAiI3RoZXJtYWwtc2Vuc29yLWNlbGxz
IjoNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gMA0KPiANCj4gRG9uJ3QgeW91IGhhdmUg
bXVsdGlwbGUgc2Vuc29ycyBjb25uZWN0ZWQgdG8gdGhpcyBjb250cm9sbGVyPyBJbiB0aGF0IGNh
c2UsIDANCj4gd29uJ3QgYmUgYSB2YWxpZCB2YWx1ZS4NCg0KaW14OG1tX3RoZXJtYWwgZHJpdmVy
IGlzIGZvciBpLk1YOE1NIGFuZCBpLk1YOE1QLCBpLk1YOE1NIE9OTFkgaGFzIDEgc2Vuc29yLA0K
d2hpbGUgaS5NWDhNUCBoYXMgMiBzZW5zb3JzLCB0aGF0IGlzIHdoeSBJIHB1dCBib3RoIDAgYW5k
IDEgaGVyZS4NCg0KVGhhbmtzLA0KQW5zb24NCg0K

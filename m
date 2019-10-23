Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC6E1016
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 04:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbfJWChY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 22:37:24 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:3811
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389051AbfJWChY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 22:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ2bttHNbzcCx5L3NRReJr3i2ELPwvkw9TwBv8LwjVIdMVqDGuC7v3hMv6eCwjJYv9lIXXTEQOcDhMlh4P63qmVFheaAkphjECqTVViClEApcs1RZ/B+UO5F8cHUIc+ptOj9nA+MaFNFD/o8PLmKjaw/nqdNIgsgdC02Tbbwb9bPovF0lIYGtpcXxFCyN02FAbSKUxfuRm7wa5UVBJMFuSEzJypsNvjEZ/f9UOZPk1eE3CeGEOUh2kEvmVSHFFeQzs5vQaJqjmgdO72uUyr9z9ko8U9iCYIEMb1BwYvRCu6YikhJpL/FQ/UjLgd54sXkZbqpyOtuh9vYsIubmEIzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh2biVIVfhA03zkXP8icbrosSEithgWaWh6JGKPFRtw=;
 b=gWApdZzDlviFXy+PMBTYTQP92BMOBr0pMbXrcr7xvAjCtUu+YvLqeK8nJDu5zHP4e3k/j56zg5+WAQFGISQb4ADg5f5zWbVI9BtY/7jr6QnzRcYf+5N/Dk2BpbPWVqNB7dBeF+5rG8dqgz5caXA8VEOHYCZgBI+tt+IQ4oBzr2dP5+d4diM9hqhrBKtnclvBDBHcd9xMHT22AYM3dfmr4WkdmdQQSwRA5UwLLh+/q3kAKOJO3o/trWnrdW8QBDgdiIog/wQqUj1ATrIa1LKVekFYFKU9R3Jsexw1stNRg7a0R8X6MpaxI3AodzNGrbigvvhGA6kPbhCT5NVr1xhIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh2biVIVfhA03zkXP8icbrosSEithgWaWh6JGKPFRtw=;
 b=d5Lmir6vgOvDH7T7mUqmnGujxKaSjpiyk7yu+gcWv5r631Xjfj529UveuGl1K3qFOaihP2wtuV6Tsg9CqFneG6cH5gvkKWBPe9P9+yudQ23fqXdh2MvYTjY9Sbh4An9cSoE7F51Ri5d1l/Q17ITUINRs6s1W4eUZBx4fYLUaV7o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 02:37:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 02:37:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHVJXvnLQPj9qjL2U2LZTWuyBDONqaqeq9ggC7WvJCAjvj14A==
Date:   Wed, 23 Oct 2019 02:37:18 +0000
Message-ID: <DB3PR0402MB391666ED47460B81E1C3FEC7F56B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
 <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c98c0b6-bb53-45eb-acbc-08d75761ec43
x-ms-traffictypediagnostic: DB3PR0402MB3899:|DB3PR0402MB3899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB389977405500819AD06631DAF56B0@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(199004)(189003)(305945005)(7736002)(6436002)(14454004)(6506007)(3846002)(55016002)(186003)(446003)(26005)(9686003)(6116002)(99286004)(102836004)(4326008)(66476007)(81166006)(76116006)(64756008)(478600001)(229853002)(52536014)(86362001)(66556008)(8676002)(81156014)(5660300002)(476003)(74316002)(486006)(8936002)(2201001)(66946007)(66446008)(11346002)(256004)(316002)(44832011)(25786009)(2906002)(7416002)(110136005)(71190400001)(71200400001)(7696005)(6246003)(2501003)(76176011)(33656002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sam8MXfDIk2xbu9RlsSvRuVlDoZzysCbFs5Ej3dIS/FADIgPwyvg8JKNLvMUgnu1oJiCIWADm01fSll/Oa/lTXUoh2ct2jHkessGAnDRvkUkI20/5VVWJ3eUu7jrYy4YdWptanrDhYYRKhqltA49eDF3d8eXpIV9VS8tfpDEivXzr9recDWrEEbVVdj9PolBk6O4UvbJNc6k1jeu6Foqv0vJ6myWscow3WZPz6TXQvnyJVjh9dmiq1wN7+GH+mEAKl706ebdqCgjb1duGUaVafoGQa3LjsqtP/qyTy1Y5dH5ABUhKRlQxdvpTXIu+g49m3b9sVmrNzn26m9+JNRTYv+viY4nZvOhN6G4bY6DoNdWIIteV4a9x3EiQLcUfoYaMQaJMSVzULN5DcMLiFmuOs0yCzxxPNPViZZ2UTWIiIJ9AQihndfMb3gs8e3wk4bZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c98c0b6-bb53-45eb-acbc-08d75761ec43
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 02:37:18.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMuLBW6G/PU57RrzReqMrwSH8LI/fVPwhgyv15wYjD7dyZ9nZmJIT7roFaf9pXJsbo3Zr5hwR35vZmgqSQHaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UGluZyBhZ2FpbiwgaXQgaGFzIGJlZW4gMyBtb250aHMgcGFzc2VkLg0KDQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggVjE1IDEvNV0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgdGhlcm1hbCBiaW5k
aW5nDQo+IA0KPiBQaW5nLi4uDQo+IA0KPiA+IEhpLCBEYW5pZWwvUnVpL0VkdWFyZG8NCj4gPiAJ
Q291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHBhdGNoIHNlcmllcz8NCj4gPg0K
PiA+IEFuc29uDQo+ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+ID4NCj4gPiA+IE5YUCBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENv
cnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0ZW0NCj4gPiA+IGNvbnRyb2xsZXIsIHRoZSBzeXN0
ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2Ygc3lzdGVtIHBvd2VyLA0KPiA+ID4gY2xvY2sg
YW5kIHRoZXJtYWwgc2Vuc29ycyBldGMuIG1hbmFnZW1lbnQsIExpbnV4IGtlcm5lbCBoYXMgdG8N
Cj4gPiA+IGNvbW11bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdl
IHVuaXQpIElQQyB0byBnZXQNCj4gPiA+IHRlbXBlcmF0dXJlIGZyb20gdGhlcm1hbCBzZW5zb3Jz
LCB0aGlzIHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9yDQo+ID4gPiBpLk1YIHN5c3RlbSBjb250
cm9sbGVyIHRoZXJtYWwgZHJpdmVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiBSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gTm8gY2hhbmdlLg0KPiA+ID4g
LS0tDQo+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1
LnR4dCAgICAgICAgfCAxNg0KPiA+ICsrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2Nh
bGUvZnNsLHNjdS50eHQNCj4gPiA+IGluZGV4IGE1NzVlNDIuLmZjMzg0NGUgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9m
c2wsc2N1LnR4dA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiA+IEBAIC0xNTUsNiArMTU1LDE3IEBAIFJl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiA+ICAt
IHRpbWVvdXQtc2VjOiBjb250YWlucyB0aGUgd2F0Y2hkb2cgdGltZW91dCBpbiBzZWNvbmRzLg0K
PiA+ID4NCj4gPiA+ICtUaGVybWFsIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3Rv
Y29sDQo+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gPiArDQo+ID4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4g
PiA+ICstIGNvbXBhdGlibGU6CQkJU2hvdWxkIGJlIDoNCj4gPiA+ICsJCQkJICAiZnNsLGlteDhx
eHAtc2MtdGhlcm1hbCINCj4gPiA+ICsJCQkJZm9sbG93ZWQgYnkgImZzbCxpbXgtc2MtdGhlcm1h
bCI7DQo+ID4gPiArDQo+ID4gPiArLSAjdGhlcm1hbC1zZW5zb3ItY2VsbHM6CVNlZQ0KPiA+ID4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCj4g
PiA+ICsJCQkJZm9yIGEgZGVzY3JpcHRpb24uDQo+ID4gPiArDQo+ID4gPiAgRXhhbXBsZSAoaW14
OHF4cCk6DQo+ID4gPiAgLS0tLS0tLS0tLS0tLQ0KPiA+ID4gIGFsaWFzZXMgew0KPiA+ID4gQEAg
LTIyMiw2ICsyMzMsMTEgQEAgZmlybXdhcmUgew0KPiA+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNs
LGlteDhxeHAtc2Mtd2R0IiwgImZzbCxpbXgtc2Mtd2R0IjsNCj4gPiA+ICAJCQl0aW1lb3V0LXNl
YyA9IDw2MD47DQo+ID4gPiAgCQl9Ow0KPiA+ID4gKw0KPiA+ID4gKwkJdHNlbnM6IHRoZXJtYWwt
c2Vuc29yIHsNCj4gPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXRoZXJtYWwi
LCAiZnNsLGlteC1zYy0NCj4gPiA+IHRoZXJtYWwiOw0KPiA+ID4gKwkJCSN0aGVybWFsLXNlbnNv
ci1jZWxscyA9IDwxPjsNCj4gPiA+ICsJCX07DQo+ID4gPiAgCX07DQo+ID4gPiAgfTsNCj4gPiA+
DQo+ID4gPiAtLQ0KPiA+ID4gMi43LjQNCg0K

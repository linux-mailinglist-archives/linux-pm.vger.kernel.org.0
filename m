Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1534133EA8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 07:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFDF4H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 01:56:07 -0400
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:64398
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbfFDF4G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 01:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLJR2noZj+wGG6nhOvygNVfsmoFck9iq4oUOu/BWka4=;
 b=h8vNoRaFa2SvKch5Dh/J5csll9XWZrbDuJgIXU+si+u20MQWpSKRfEAQ2ID+e1Ev2g5HXVYteQWOxdBjmvUlnDblJylXOXcTn02xM2exx9gnbK/shx4HX4B6xzo12ml6U9twVfKkxNR8c/vNwVX/rYMCpgH1AlXQsyEEUafenSE=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4160.eurprd04.prod.outlook.com (52.133.15.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Tue, 4 Jun 2019 05:56:02 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0%6]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 05:56:02 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: thermal: Make cooling-maps property optional
Thread-Topic: [PATCH] dt-bindings: thermal: Make cooling-maps property
 optional
Thread-Index: AQHVCwLUH4zad13tsE2wQPY/IOtNWqaLHhGg
Date:   Tue, 4 Jun 2019 05:56:02 +0000
Message-ID: <VI1PR04MB43335AE882F7898F4DDD1A23F3150@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190515093647.47656-1-andy.tang@nxp.com>
In-Reply-To: <20190515093647.47656-1-andy.tang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97805db3-16c1-44ec-5685-08d6e8b15386
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4160;
x-ms-traffictypediagnostic: VI1PR04MB4160:
x-microsoft-antispam-prvs: <VI1PR04MB416033AB65AB2A428F35904BF3150@VI1PR04MB4160.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(13464003)(189003)(53936002)(2201001)(26005)(486006)(44832011)(446003)(11346002)(76176011)(256004)(86362001)(68736007)(102836004)(6506007)(54906003)(229853002)(3846002)(71190400001)(53546011)(7696005)(33656002)(66066001)(110136005)(71200400001)(6116002)(99286004)(186003)(81156014)(8676002)(81166006)(9686003)(476003)(305945005)(2501003)(4326008)(14454004)(478600001)(55016002)(8936002)(316002)(7736002)(6436002)(73956011)(66946007)(2906002)(76116006)(25786009)(6246003)(66446008)(74316002)(66476007)(66556008)(64756008)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4160;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LgC3BEr+Wm2cq0H0Cjm/RLqL3lRrglBWzUVqNjchEZ2jaKy56++nw8qnuSJ06hciJc/bAqwq2p8A7WKfzfY3NCG94fc9YppKLeT/0+sO5HGZJluBr6wkpwce/pwppqr6cAKP4qhdOINZ8YlKY6AZxSpQM6Qpn5MzgoQ9tf5yXaUpji1xiLv0xCCMtYAHp8FlvbeVS0tLPKSoRrvo/rc5kbthEDGY5wRDbPzvhgGNinG3V2V8tllRkrdQp6zpr8/zRDtdMRTsh1V/YTQ71lGrD4DGVVOQ7DFC2sQWLwo7+nAYKsc6PHjsRkENRkVWAVPPHl4fvVbVSW6W3uLbihdcZ1W4ohFuDwQd9/IWuDtzVcjpKeZ310pOg2HwncREwSdpxy7kMgVj0Z+1/Uhjbbuw9BNJHu7dB33qWe8I/2N7FHs=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97805db3-16c1-44ec-5685-08d6e8b15386
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 05:56:02.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andy.tang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4160
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgRWR1YmV6dmFsLCBSdWksDQoNCkFueSBmdXJ0aGVyIGNvbW1lbnRzPw0KDQpCUiwNCkFuZHkN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdWFudGlhbiBUYW5nIDxh
bmR5LnRhbmdAbnhwLmNvbT4NCj4gU2VudDogMjAxOcTqNdTCMTXI1SAxNzozNw0KPiBUbzogcnVp
LnpoYW5nQGludGVsLmNvbTsgZWR1YmV6dmFsQGdtYWlsLmNvbQ0KPiBDYzogcm9iaCtkdEBrZXJu
ZWwub3JnOyBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsN
Cj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhw
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkdC1iaW5kaW5nczogdGhlcm1hbDogTWFrZSBjb29s
aW5nLW1hcHMgcHJvcGVydHkgb3B0aW9uYWwNCj4gDQo+IFRoZXJlIG1heSBiZSBubyBjb29saW5n
IGRldmljZSBvbiBzeXN0ZW0sIG9yIHRoZXJlIGFyZSBubyBlbm91Z2ggY29vbGluZw0KPiBkZXZp
Y2VzIGZvciBlYWNoIHRoZXJtYWwgem9uZSBpbiBtdWx0aXBsZSB0aGVybWFsIHpvbmUgY2FzZXMg
c2luY2UgY29vbGluZw0KPiBkZXZpY2VzIGNhbid0IGJlIHNoYXJlZC4NCj4gU28gbWFrZSB0aGlz
IHByb3BlcnR5IG9wdGlvbmFsIHRvIHJlbW92ZSBzdWNoIGxpbWl0YXRpb25zLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IC0tLQ0KPiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC90aGVybWFsLnR4dCAgICAgICAgfCAgICA0
ICsrLS0NCj4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL3RoZXJtYWwudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3RoZXJtYWwvdGhlcm1hbC50eHQNCj4gaW5kZXggY2ExNGJhOS4uNjk0ZTgzNCAxMDA2NDQNCj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50
eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhl
cm1hbC50eHQNCj4gQEAgLTE0MiwxMSArMTQyLDExIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+
ICAtIHRyaXBzOgkJQSBzdWItbm9kZSB3aGljaCBpcyBhIGNvbnRhaW5lciBvZiBvbmx5IHRyaXAg
cG9pbnQgbm9kZXMNCj4gICAgVHlwZTogc3ViLW5vZGUJcmVxdWlyZWQgdG8gZGVzY3JpYmUgdGhl
IHRoZXJtYWwgem9uZS4NCj4gDQo+ICsNCj4gK09wdGlvbmFsIHByb3BlcnR5Og0KPiAgLSBjb29s
aW5nLW1hcHM6CQlBIHN1Yi1ub2RlIHdoaWNoIGlzIGEgY29udGFpbmVyIG9mIG9ubHkgY29vbGlu
ZyBkZXZpY2UNCj4gICAgVHlwZTogc3ViLW5vZGUJbWFwIG5vZGVzLCB1c2VkIHRvIGRlc2NyaWJl
IHRoZSByZWxhdGlvbiBiZXR3ZWVuDQo+IHRyaXBzDQo+ICAJCQlhbmQgY29vbGluZyBkZXZpY2Vz
Lg0KPiAtDQo+IC1PcHRpb25hbCBwcm9wZXJ0eToNCj4gIC0gY29lZmZpY2llbnRzOgkJQW4gYXJy
YXkgb2YgaW50ZWdlcnMgKG9uZSBzaWduZWQgY2VsbCkgY29udGFpbmluZw0KPiAgICBUeXBlOiBh
cnJheQkJY29lZmZpY2llbnRzIHRvIGNvbXBvc2UgYSBsaW5lYXIgcmVsYXRpb24gYmV0d2Vlbg0K
PiAgICBFbGVtIHNpemU6IG9uZSBjZWxsCXRoZSBzZW5zb3JzIGxpc3RlZCBpbiB0aGUgdGhlcm1h
bC1zZW5zb3JzIHByb3BlcnR5Lg0KPiAtLQ0KPiAxLjcuMQ0KDQo=

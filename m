Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F7203D5
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfEPKqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 06:46:36 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:8352
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfEPKqg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 06:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ0NLhMKHR9t/W7fvUSdnYSAwn4/rOJk47JWqBmfgZk=;
 b=oBTNDtQ+cT/O7lslbH8XACk9RJ8MKqAlJuC32b/DBc2hHJSsuxuVoYzB1jxMqj8yBBBTh9B+sUMkM79rx6ghWAH+7y2suaEHY+1BMX5arFHg1o1OXNjuua5Tmfzmv4SaIPYzsTdeF6u7rGeNlfUD85rT2DmaaUOpQkcx7DQOmqI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 10:46:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 10:46:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Topic: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHU9AOc8iXKmYQeMUm4+FbUnbYclKY/+ukAgABUQSCALXAcAIAAAa8g
Date:   Thu, 16 May 2019 10:46:33 +0000
Message-ID: <DB3PR0402MB3916ABB2E6B07C3AE8AAA9FAF50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB421105BBF1B9A90B255D1F7A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163877C25E5BE7E10C96B7F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4211EF0D257E502C3BF917D0800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211EF0D257E502C3BF917D0800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd1097cb-8905-4e48-95c3-08d6d9ebc30d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB3787512B9F92D6356D969F2FF50A0@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(13464003)(189003)(199004)(86362001)(52536014)(186003)(8676002)(66476007)(64756008)(66446008)(305945005)(229853002)(71190400001)(71200400001)(2201001)(76116006)(81166006)(66946007)(73956011)(66556008)(2501003)(14454004)(66066001)(6436002)(81156014)(74316002)(4326008)(7736002)(33656002)(486006)(316002)(3846002)(6116002)(110136005)(53936002)(53546011)(8936002)(44832011)(6506007)(102836004)(7416002)(478600001)(68736007)(76176011)(6246003)(26005)(55016002)(5660300002)(9686003)(256004)(25786009)(2906002)(446003)(11346002)(476003)(7696005)(99286004)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SRKf5YGjpmOXU2F+3ANWF6q9un1oLxp0qzduqnQeb2Lkxt5D7A5Uu/eTmHCyHv/uVwXWjY1Dkzjhl3futH9JK2QiVL7WQMr1f0902mg7+ORlsOh+0cAvi4ROWaYDaO23XMHv9lbZYGqHxFb/iHbWOQqdhCPczOHxsdPxXw/A582cOdHaMvdjm3H9DBB34D/4GYC7yWrXPe1yuhsaGNBM6POrBaJtxvRiGLk8vvfuHBzVr36sBSKLqm1HwkCV5E+trvxt8iRdYIJCAXxErdCHe6gqHfU1kRVyWvfCKHlZbZiZtvUiyAx0RRS/Lm3RvNcML5W6b5Uptfte70lYkOj35gas6CJnRT9UWwVHTyqJ9mVniCyrMfS5jHmGw5dxvQ1lhJcyHKsdHR0BJ0Le45uih220nHqV7T0S6WoGN12bXiY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1097cb-8905-4e48-95c3-08d6d9ebc30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 10:46:33.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+
IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIwMTkgNjo0MCBQTQ0KPiBUbzogQW5zb24gSHVhbmcg
PGFuc29uLmh1YW5nQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0K
PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgY2F0YWxpbi5tYXJp
bmFzQGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207
IGVkdWJlenZhbEBnbWFpbC5jb207DQo+IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IHVsZi5o
YW5zc29uQGxpbmFyby5vcmc7IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNv
bT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gaGVpa29Ac250ZWNoLmRlOyBob3Jt
cytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgYWdyb3NzQGtlcm5lbC5vcmc7DQo+IG9sb2ZAbGl4b20u
bmV0OyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5j
b207DQo+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IG1hcmMudy5nb256YWxlekBmcmVl
LmZyOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
cG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYxMiAzLzVdIHRoZXJtYWw6IGlteF9zYzogYWRkIGku
TVggc3lzdGVtIGNvbnRyb2xsZXINCj4gdGhlcm1hbCBzdXBwb3J0DQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiA+ID4gKwkJaWYgKCFzZW5zb3IpDQo+ID4gPiA+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCQlyZXQgPSB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZChj
aGlsZCwNCj4gPiA+ID4gKwkJCQkJCSAgICAmc2Vuc29yX3NwZWNzLA0KPiA+ID4NCj4gPiA+IEl0
IGxvb2tzIGEgYml0IHN0cmFuZ2Ugd2h5IG5lZWQgc2Vuc29yX3NwZWNzIGFzIHlvdSBldmVuIGRp
ZCBub3QgdXNlIGl0Lg0KPiA+DQo+ID4gSXQgaXMgYmVjYXVzZSBwYXJzaW5nIHRoZSBwaGFuZGxl
IGFyZ3VtZW50cyBuZWVkcyBpdCwgc3VjaCBhcyB0aGUNCj4gPiB0aGVybWFsX3pvbmVfb2Zfc2Vu
c29yX3JlZ2lzdGVyKCkgZnVuY3Rpb24gbmVlZHMgdGhpcyBwb2ludGVyIHRvIGJlDQo+ID4gcGFz
c2VkIGJhY2sgdG8gY2hlY2sgdGhlIGVsZW1lbnRzIGFyZSB2YWxpZCBvciBOT1QsIHNvIHRoZSBB
UEkgZG9lcw0KPiA+IE5PVCBkZWZpbmUgaXQgYXMgbG9jYWwgc3RydWN0dXJlLiBUaGUgQVBJIE5P
VCBqdXN0IHJldHVybiB0aGUgc2Vuc29yDQo+ID4gaWQsIGJ1dCBhbHNvIHRoZSBvZl9waGFuZGxl
X2FyZ3MgYWRkcmVzcywgYWx0aG91Z2ggd2UgZG8gTk9UIG5lZWQgaXQgYXQgYWxsDQo+IGhlcmUu
DQo+IA0KPiBUaGUgbWFpbiBwcm9ibGVtIGlzIHRoaXMgb25lIGludHJvZHVjZWQgaW4gMi81IHdo
aWNoIG5lZWRzIGdldCBhY2sgZnJvbQ0KPiBtYWludGFpbmVyLg0KPiBGb3IgbWUsIEkgd291bGQg
c3VnZ2VzdCB0byBtYWtlIHNlbnNvcl9zcGVjcyB0cmFuc3BhcmVudCB0byB1c2VyIGlmIGl0J3MN
Cj4gcmVhbGx5IG5vdCBuZWVkZWQgYnkgdXNlcnMuDQo+IA0KPiBQbGVhc2UgdHJ5IHRvIG1ha2Ug
aXQgZWl0aGVyIG9wdGlvbmFsIG9yIGhpZGUgdG8gY29yZSB1c2VycyBhcyB3ZWxsLg0KPiBBbmQg
SSBndWVzcyB0aGUgbGF0ZXIgb25lIGlzIGRvYWJsZSBhZnRlciBhIGdsYW5jZSBhdCB0aGUgY29y
ZSBjb2RlLg0KDQpPSywgSSB3aWxsIGhpZGUgaXQgdG8gdXNlciBpZiBubyBvdGhlciBkaWZmZXJl
bnQgY29tbWVudHMuDQoNCkFuc29uLg0KDQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVuZw0K

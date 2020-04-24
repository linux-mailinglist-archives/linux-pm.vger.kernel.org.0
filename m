Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9571B6AF4
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 03:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgDXBsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 21:48:36 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:39211
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbgDXBsg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 21:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKglV45DVe+4sbB7NneZ+3WgOdYTLmmvGZRdJaChFj3cipl9LqBjl6pt72ndWMRlim2ll9+5d7va3qlvM1N4NRh02CputuwgBeTtvIqqP6sp+9sYRtnK9O8PmbbyT1i+1w0NP7W/0SrV7twGGK9AqKAzlcTQDWf/oGUxe/hs+3K2YKZCyrnCuLAWSSLkb80kwSNEiU7Zs6BoQ+0f+2edM1Dd8QUxHP7Ckx1RVUlKefEYeuUtzzpIaDuikcMjVInCKzTEiQcjAbw0+2J8we6+1YhTZIYa6sx0sBbnjW6PilHIOiAm9Ekc5Sll2eU+juuMgXgK0FyexwjRWCbFzWXCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAdfC+7//SVsOeukh5qKLzMjhoNGwMUIAErC2qIPCzU=;
 b=WUNNlXk/bWsbQ6X9TpTgN2T/WQksUZGeVtu/fR4qxQ1FBjg6g6dwuiPhkDXG8mIctqx/TIMcmznDadtf2UxYUYOv5jGcDrmriM4RKDlHnS7Rv9AaXaLXZ+I5lTBhSk+UJD5vSyGPR117jDgncvoA5mliENxGiCnEpRhKMTPrC6Ztii9tESalB6ZMbOXI7b4NvrRPfSNe16A+LqJsxlLgbmeq2Tkw612N4yUvpL9MhQvjGFMzefkbiiVk+Sh+rWtmcLMj1/6jYW2ocQQUmU/DlE0poV70b0/U4Zcbn76+FOj5fDdeO/z/Svw8Rbd5Zjs+E1RvziwpFUS4XD+/wCfJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAdfC+7//SVsOeukh5qKLzMjhoNGwMUIAErC2qIPCzU=;
 b=fnuAxhYKHVR36OCEhNky6295UGFS1lAQKAzws8n6sPr6q17ECtrx4gydWDSOJKgn0j4/77DasRpuYRuX5HdXJlAxPG9oO8GdPf9gcOxmZuErUwPdoYwxijS+2HSvaZKVpdO+vJRoJQbHreDDXk+6dSgilBv2PBDzULz1V9QW9/w=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5621.eurprd04.prod.outlook.com (2603:10a6:20b:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.28; Fri, 24 Apr
 2020 01:48:31 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 01:48:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
Thread-Topic: [PATCH V2] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
Thread-Index: AQHWGYYRe2oEYWZQzkWEzy9+aCACI6iG28YwgABuTwCAADcLEA==
Date:   Fri, 24 Apr 2020 01:48:31 +0000
Message-ID: <AM6PR04MB49665B1D0657ADCCA3B10FF780D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587656148-24581-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966AF54A95ACF4F33634AD080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916489B8ADCA1F487F7A748F5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916489B8ADCA1F487F7A748F5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0dc484e1-7ccf-4931-d2d4-08d7e7f197e6
x-ms-traffictypediagnostic: AM6PR04MB5621:|AM6PR04MB5621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB56213D28109A966B46BBDADD80D00@AM6PR04MB5621.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(26005)(33656002)(7416002)(2906002)(44832011)(4326008)(5660300002)(71200400001)(478600001)(186003)(316002)(64756008)(66446008)(66946007)(66556008)(76116006)(7696005)(6506007)(110136005)(86362001)(81156014)(8676002)(9686003)(55016002)(53546011)(8936002)(52536014)(66476007)(921003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kg4i2WXkz1dmPgwZtthLn/YFQr/Z8kPWuW+C5o5LY9jeaP3GO0fn13qa8HIq8Cuaz2UDsM5v2hqBiOVQN3kDoVIk/p/YmJfxpfk6Pg5GnnfA9CTdhgK42S3wnZW0MTxoQASrE9O5iZ66fqc7zJoYOt6kFydnw6TVuy3DB68cg8qF+HMCNNnmcQN60KVhjZ3ZXz8OCAcLDVw6sCWAANfuFxwkpdbuLKyknhvWvX7sh3F0/IGrrOSm9ib3eJDMFI+dKCCdfgULtxjc7Y3RA7R7dgtHaVVMJRasbQlbwwtd7vs0zTSxSMS3Mb+WwmbclVc+PsNY0GZr002t63mnW4H9o9En+zM9RIkstIDx9Gzk3ldsjk9nMMCr9svLN7a+Y6naRaeR6igie0uQUymctdE2H7SgSJ2oIGfmm89j9rdU5c6bAc61uw06Kth7dc714lHsOP/pzNEmt1wmWNHpjsOjB8uMtpU6H7UmSzKqaICkIDc=
x-ms-exchange-antispam-messagedata: MHPLN5rnmMVKthnhv52l7NOTMQx98jOOYChF0d9seHaUdcZg1+afL/aJlLoUc4BZOxnZ3qzx3NL9JyEJi23fYi6j43+rn82UH0JjmmzNgSL5XB8eCuJvtLAUakGY5O03lZvrq5Dmu5dzr3s4a/m1MQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc484e1-7ccf-4931-d2d4-08d7e7f197e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 01:48:31.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gabms8SEZsFVJIQYVA4nHJq7R+r3mQhMewOlkC8hlaip8A3ut5M17fH3S3Z/PWRhWJhiqHgdbYEOWGoOKBIcOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5621
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAyNCwgMjAyMCA2OjI5IEFNDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjJd
IGR0LWJpbmRpbmdzOiBmaXJtd2FyZTogaW14OiBNb3ZlIHN5c3RlbQ0KPiA+IGNvbnRyb2wgaW50
byBkdC1iaW5kaW5nIGhlYWRmaWxlDQo+ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDEx
OjM2IFBNDQo+ID4gPg0KPiA+ID4gaS5NWDggU29DcyBEVFMgZmlsZSBuZWVkcyBzeXN0ZW0gY29u
dHJvbCBtYWNybyBkZWZpbml0aW9ucywgc28gbW92ZQ0KPiA+ID4gdGhlbSBpbnRvIGR0LWJpbmRp
bmcgaGVhZGZpbGUsIHRoZW4NCj4gPiA+IGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3R5cGVz
LmgNCj4gPiA+IGNhbiBiZSByZW1vdmVkIGFuZCB0aG9zZSBkcml2ZXJzIHVzaW5nIGl0IHNob3Vs
ZCBiZSBjaGFuZ2VkIGFjY29yZGluZ2x5Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+ID4gWW91IHNlZW1zIGlnbm9y
ZWQgbXkgY29tbWVudHMgaW4gVjEuDQo+ID4gVXN1YWxseSB3ZSdkIGJldHRlciB0byBrZWVwIG9y
aWdpbmFsIGF1dGhvciB3aGVuIHNlbmRpbmcgcGF0Y2hlcyBpZiBubw0KPiA+IGZ1bmRhbWVudGFs
IGNoYW5nZXMuDQo+IA0KPiBIZXJlIGlzIHRoZSBkZXRhaWxzLCB0aGUgYWltIG9mIHRoaXMgcGF0
Y2ggaXMgdG8gZ2V0IHJpZCBvZiBiZWxvdyBwYXRjaCBpbiBpbnRlcm5hbA0KPiB0cmVlLCBJIGRp
ZCBOT1QgY2hlY2sgdGhlIGRldGFpbHMgb2YgaW50ZXJuYWwgdHJlZSBhbmQgZGlkIHRoZSBwYXRj
aCBtYW51YWxseSBhbmQNCj4gZGlkIE5PVCBjaGVjayBob3cgbWFueSBwYXRjaGVzIEkgbmVlZCBp
biBpbnRlcm5hbCB0cmVlIGluIG9yZGVyIHRvIG1ha2UgdGhlDQo+IGJ1aWxkIHBhc3NlZC4gQWZ0
ZXIgY2hlY2tpbmcgaXQsIGxvb2tzIGxpa2UgdGhlcmUgYXJlIDMgcGF0Y2hlcywgMiBhcmUgZnJv
bSB5b3UsDQo+IGFuZCAxIGZyb20gSmFja3kuIFNpbmNlIHRoZXNlIHBhdGNoZXMgbmVlZCB0byBi
ZSBzcXVhc2hlZCBpbnRvIDEgcGF0Y2gsIGFsc28gZml4DQo+IG1pbm9yIGNvbW1lbnQgaW4gY29k
ZSBhbmQgaW1wcm92ZSB0aGUgY29tbWVudCwgc28sIHNob3VsZCBJIHB1dCB5b3UgYXMNCj4gYXV0
aG9yIG9yIEphY2t5IGFzIGF1dGhvcj8/DQo+IA0KDQpBcyB0aGVyZSdyZSBubyBjb2RlIGNoYW5n
ZXMsIGZvciBzdWNoIGEgY2FzZSwgd2UgdXN1YWxseSBrZWVwIG9yaWdpbiBhdXRob3INCmFuZCBh
ZGQgSmFja3kgc2lnbm9mZiBhbmQgeW91IHNpZ25vZmYuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
PiBjb21taXQgY2I2NjAzOTk5MzY3YWVhZTU3MDA0NjM4YTRiOGU0M2VlNjE4ZGJlYw0KPiBBdXRo
b3I6IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4NCj4gRGF0ZTogICBNb24gTWFyIDkgMTQ6
NDE6NDQgMjAyMCArMDgwMA0KPiANCj4gICAgIHRoZXJtYWw6IGlteF9zY190aGVybWFsOiBmaXgg
dGhlIGJ1aWxkIGJyZWFrIGNhdXNlZCBub24gZXhpc3RlbnQgdHlwZXMuaA0KPiANCj4gICAgIFRo
ZSB0eXBlcy5oIGhhcyBiZWVuIG1vdmUgdG8gdGhlIGR0LWJpbmRpbmdzLywgc28gY29ycmVjdCB0
aGUgaW5jbHVkZWQNCj4gICAgIGhlYWRlciBmaWxlIHRvIGZpeCB0aGUgYnVpbGQgYnJlYWsuDQo=

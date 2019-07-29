Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CBA785F9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 09:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfG2HOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 03:14:35 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:6902
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfG2HOf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 03:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cft/3bLIRLGJQ+YkMVBCS8JWbEZc9RSuOaz3/bdmiLHv0bjZge+VtmWGk0u2aDHoScYqLfjSX4T41mRx7n+MnU/yJdiJHNwPEMaqNENFOiepuns0ukqE86/mldofjWGP3zTZNhEy4NHph10X4/iLY3l0y4mIt06rP+nsPA4Rb6VPaS8D852Di7dhK04SY7kWq048z1Bp2LLe6GQ4i69ei0AXNG474HqiMXKee+WP0XFrRWfZr6H2VN2Fitjec4ioJqPs84Z1oOgNTsNOalObkciTkIB7SPYGwnM8pzdBp7lZPTL0+z/yMqJe0VbWdHzb0H4Cx3nvRDi82+sPTXhwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLdx5SUaLLVIWl327Jr5CyBA38qiT4cwDwNZKmpHF6Y=;
 b=VBE/jyH/8l+xeCSW0lvQKGcgGNGAx92TQHXqXAJeAr1375ngvPLTT9VC5KcPNzhJus/0NocvIRGx1XkD/IJBSEtNZEXJPspGM3p0uRI95RTqIr0t2WeoSytAD7XxgeR8S5Cd2FpGpqmZF6sQBI3JB3h8tmZ18ZhihbVNkrd6SeYMM3YK7d4dMNhvSavORl5uXPrkNwkOV0I/teaUMuRSvUOBWQ+baNKY3EKTveC6a7/7xoK1bac9+bdyN9YZJo4n2jP38K+df7HTkXnJ4FbtHHpSHo+48jvS/bBVi8DZgW3JGm6biSb5pY15VkuvS4hnNFzHTc83VswhDZ9t/GZL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLdx5SUaLLVIWl327Jr5CyBA38qiT4cwDwNZKmpHF6Y=;
 b=J/4jDG72BVDQ2iTPecMo7XgnnIJboG3KtbwJPNjzAH5z37f+4gHj+QBiJLn0tAZSKeFBwJaYna8+Yx6HQXxX3UuU/fAS7QBbhNDRCPmTI1YVxrJfmmyu8dqexVWSfzcwiPt8cS532Lqgk5F9si7tZ5pfkWajNDG8X0vhuAPqp0M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 29 Jul 2019 07:14:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 07:14:28 +0000
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
Thread-Index: AQHVMu9Qagn4ZAj9sUKncGzfKuws0abdnJEAgAB74HCAAAwBAIAAo0oAgAIrlTCAAFrfgIAABfvA
Date:   Mon, 29 Jul 2019 07:14:28 +0000
Message-ID: <DB3PR0402MB391627F725AA7237BCACBE87F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175>
 <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com>
In-Reply-To: <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42e5f519-7ddf-46cc-36de-08d713f46520
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0402MB3642447CD3C0B20B869DD59AF5DD0@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(53754006)(43544003)(199004)(189003)(25786009)(54906003)(26005)(486006)(8676002)(7696005)(256004)(81166006)(81156014)(229853002)(76176011)(68736007)(99286004)(6246003)(4326008)(2906002)(6436002)(102836004)(186003)(71200400001)(53936002)(71190400001)(8936002)(6506007)(53546011)(316002)(476003)(9686003)(55016002)(3846002)(6116002)(33656002)(74316002)(66066001)(6306002)(66556008)(64756008)(44832011)(52536014)(5660300002)(305945005)(86362001)(66446008)(45080400002)(7736002)(66946007)(66476007)(76116006)(478600001)(14454004)(7416002)(6916009)(11346002)(966005)(446003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dRRa8hq693eaHfbWjXyBsrlxSDJq/lWPGIE/QjLpqbT/ecNdrvQHBnyTUO7If0kXR5BeK0jvwrzVXGUZ+W92Zsd8+yDt4bdH59GpQ1cFNqjTmdQs07vFntq1gppTfCPUK/j0ci02/NPfNU9K1IR6/OFM3KLKvocbqvt6nJKrfTDyHoEDgw8HW4kaI7UySZDu9u96mZMqEQY44gRcCBredzkiexyhN3WTiq+lSQPND8r/r67s109YDMUJRNqz2IhCsBwbutUPRW04e37/tk4SShDlJxY8CcnmxgXWzSUVDUxku+GPEEccsI6pZX0nVukXK0hsPylEfbeCHBxOJ6unxlQX6YJk4p4HviH+odiwBXCLszSDDhwMipkkIlGzKnFU7X4UaFGU2sN868uFEauKkkh/MlJSJJWdnZ/APv/9NVo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e5f519-7ddf-46cc-36de-08d713f46520
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 07:14:28.3943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIE1vbiwgSnVsIDI5LCAyMDE5IGF0IDQ6MjkgQU0gQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGksIEFiZWwvRGFu
aWVsDQo+ID4NCj4gPiA+IE9uIDE5LTA3LTI3IDA5OjMzOjEwLCBEYW5pZWwgQmFsdXRhIHdyb3Rl
Og0KPiA+ID4gPiBPbiBTYXQsIEp1bCAyNywgMjAxOSBhdCA5OjE5IEFNIEFuc29uIEh1YW5nIDxh
bnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBI
aSwgRGFuaWVsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82
XSBjbGs6IGlteDhtcTogUmVtb3ZlIENMS19JU19DUklUSUNBTA0KPiA+ID4gPiA+ID4gZmxhZyBm
b3IgSU1YOE1RX0NMS19UTVVfUk9PVA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEhpIGFsbCwN
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBsYXRlc3QgbGludXgtbmV4dCBoYW5ncyBhdCBib290
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGNvbW1pdCBmZGU1MGI5NmJlODIxYWM5NjczYTdl
MDA4NDdjYzQ2MDViZDg4ZjM0IChIRUFEIC0+DQo+ID4gPiBtYXN0ZXIsIHRhZzoNCj4gPiA+ID4g
PiA+IG5leHQtMjAxOTA3MjYsIG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKQ0KPiA+ID4gPiA+
ID4gQXV0aG9yOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4gPiA+
ID4gPiA+IERhdGU6ICAgRnJpIEp1bCAyNiAxNToxODowMiAyMDE5ICsxMDAwDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gICAgIEFkZCBsaW51eC1uZXh0IHNwZWNpZmljIGZpbGVzIGZvciAyMDE5
MDcyNg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBTdGVwaGVu
IFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gSSBrbm93IHRoaXMgaXMgY3JhenkgYnV0IHJldmVydGluZyBjb21taXQ6
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gY29tbWl0IDQzMWJkZDFkZjQ4ZWUyODk2ZWE5OTgw
ZDkxNTNlM2FlYWYwYzgxZWYNCj4gPiA+IChyZWZzL2Jpc2VjdC9iYWQpDQo+ID4gPiA+ID4gPiBB
dXRob3I6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gPiA+ID4gRGF0
ZTogICBGcmkgSnVsIDUgMTI6NTY6MTEgMjAxOSArMDgwMA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ICAgICBjbGs6IGlteDhtcTogUmVtb3ZlIENMS19JU19DUklUSUNBTCBmbGFnIGZvcg0KPiA+
ID4gPiA+ID4gSU1YOE1RX0NMS19UTVVfUk9PVA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAg
ICBJTVg4TVFfQ0xLX1RNVV9ST09UIGlzIE9OTFkgdXNlZCBmb3IgdGhlcm1hbCBtb2R1bGUsIHRo
ZQ0KPiA+ID4gZHJpdmVyDQo+ID4gPiA+ID4gPiAgICAgc2hvdWxkIG1hbmFnZSB0aGlzIGNsb2Nr
LCBzbyBubyBuZWVkIHRvIGhhdmUgQ0xLX0lTX0NSSVRJQ0FMDQo+IGZsYWcNCj4gPiA+ID4gPiA+
ICAgICBzZXQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBtYWtlcyB0aGUgYm9vdCB3b3JrIGFnYWluLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IEFueSBpZGVhPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBqdXN0IGZvdW5kIGlmIGRpc2FibGlu
ZyBTRE1BMSwgdGhlbiBrZXJuZWwgY2FuIGJvb3QgdXAsIGl0DQo+ID4gPiA+ID4gZG9lcyBOT1Qg
bWFrZSBzZW5zZSBUTVUgY2xvY2sgaXMgcmVsYXRlZCB0byBTRE1BMSwgSSB3aWxsIGNoZWNrDQo+
ID4gPiA+ID4gd2l0aCBkZXNpZ24NCj4gPiA+IGFuZCBnZXQgYmFjayB0byB5b3Ugc29vbi4NCj4g
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBBbnNvbiwNCj4gPiA+ID4NCj4gPiA+ID4gQXBw
bHlpbmcgQWJlbCdzIHBhdGNoOg0KPiA+ID4gPg0KPiA+ID4gPiBjb21taXQgODgxNmM0N2RiNmE4
MmY1NWJiNGQ2NGY2MmZkOWRkM2FmNjgwZjBlNCAoSEVBRCAtPiBtYXN0ZXIpDQo+ID4gPiA+IEF1
dGhvcjogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCj4gPiA+ID4gRGF0ZTogICBUdWUg
SnVuIDI1IDEyOjAxOjU2IDIwMTkgKzAzMDANCj4gPiA+ID4NCj4gPiA+ID4gICAgIGNsazogaW14
OG1xOiBNYXJrIEFIQiBjbG9jayBhcyBjcml0aWNhbA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgS2Vl
cCB0aGUgQUhCIGNsb2NrIGFsd2F5cyBvbiBzaW5jZSB0aGVyZSBpcyBubyBkcml2ZXIgdG8gY29u
dHJvbCBpdCBhbmQNCj4gPiA+ID4gICAgIGFsbCB0aGUgb3RoZXIgY2xvY2tzIHRoYXQgdXNlIGl0
IGFzIHBhcmVudCByZWx5IG9uIGl0IGJlaW5nIGFsd2F5cw0KPiBlbmFibGVkLg0KPiA+ID4gPg0K
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUga2VybmVsIGJvb3RzIHVwIGFnYWluLg0KPiA+
ID4gPg0KPiA+ID4gPiBJdCBtYWtlIHNvbWUgc2Vuc2UuIEkgZG9uJ3QgdW5kZXJzdGFuZCB0aG91
Z2ggd2h5IGhhdmluZw0KPiA+ID4gPiBJTVg4TVFfQ0xLX1RNVV9ST09UIGFzIGNyaXRpY2FsIGFs
c28gInVuaGFuZ3MiIHRoZSBrZXJuZWwuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT0ssIHNvIHRo
aXMgaXMgaG93IGl0IHdvcmtzLg0KPiA+ID4NCj4gPiA+IEJ5IHJlbW92aW5nIHRoZSBjcml0aWNh
bCBmbGFnIGZyb20gVE1VLCB0aGUgQUhCIGRvZXNuJ3Qgc3RheSBhbHdheXMgb24uDQo+ID4gPiBX
aXRoIG15IHBhdGNoIHRoZSBBSEIgaXMgbWFya2VkIGFzIGNyaXRpY2FsIGFuZCB0aGVyZWZvcmUg
c3RheXMgb24uDQo+ID4gPg0KPiA+ID4gVGhlIHNkbWExX2NsayBoYXMgYXMgcGFyZW50IHRoZSBp
cGdfcm9vdCB3aGljaCBpbiB0dXJuIGhhcyBhcyBwYXJlbnQNCj4gPiA+IHRoZSBhaGIgY2xvY2su
IEFuZCBJIHRoaW5rIHdoYXQgaGFwcGVucyBpcyBzb21lIHJlYWQgZnJvbSB0aGUgc2RtYQ0KPiA+
ID4gcmVnaXN0ZXJzIGhhbmdzIGJlY2F1c2UsIGZvciB3aGF0ZXZlciByZWFzb24sIGVuYWJsaW5n
IHRoZSBzZG1hMV9jbGsNCj4gPiA+IGRvZXNuJ3QgcHJvcGFnYXRlIHRvIGVuYWJsZSB0aGUgYWhi
IGNsb2NrLiBJIG1pZ2h0IGJlIHdyb25nIHRob3VnaC4NCj4gPiA+DQo+ID4NCj4gPiBJIGNhbiBl
eHBsYWluIHdoeSBBYmVsJ3MgcGF0Y2ggY2FuIGZpeCB0aGlzIGlzc3VlLCB0aGUgQUhCIGNsb2Nr
IGlzIGENCj4gPiBNVVNUIGFsd2F5cyBPTiBmb3Igc3lzdGVtIGJ1cywgd2hpbGUgaXQgZG9lcyBO
T1QgaGF2ZSBDTEtfSVNfQ1JJVElDQUwNCj4gPiBmbGFnIHNldCBmb3Igbm93LCB3aGVuIFNETUEx
IGlzIHByb2JlZCwgaXQgd2lsbCBlbmFibGUgaXRzIGNsb2NrLCBhbmQNCj4gPiB0aGUgY2xrIHBh
dGggaXMgc2RtYTFfY2xrLT5pcGdfcm9vdC0+YWhiLCBhZnRlciBTRE1BMSBwcm9iZWQgZG9uZSwg
aXQNCj4gPiB3aWxsIGRpc2FibGUgaXRzIGNsb2NrIHNpbmNlIG5vIG9uZSB1c2UgaXQsIGFuZCBp
dCB3aWxsIHRyaWdnZXIgdGhlDQo+ID4gYWhiIGNsb2NrIHRvIGJlIE9GRiwgYXMgaXRzIHVzZWNv
dW50IGlzIGFkZGVkIGJ5IDEgd2hlbiBwcm9iZSBhbmQNCj4gPiBkZWNyZWFzZWQgYnkgMSBhZnRl
cg0KPiA+IFNETUExIHByb2JlIGRvbmUsIHNvIHVzZWNvdW50PTAgd2lsbCB0cmlnZ2VyIEFIQiBj
bG9jayB0byBiZSBPRkYuDQo+ID4NCj4gPiBTbyBJIHRoaW5rIHRoZSBiZXN0IHNvbHV0aW9uIHNo
b3VsZCBiZSBhcHBseWluZyBBYmVsJ3MgcGF0Y2ggYXMgeW91DQo+ID4gbWVudGlvbmVkIHVwcGVy
LCB0aGUgVE1VIGNsb2NrIHBhdGNoIGlzIE5PVCB0aGUgcm9vdCBjYXVzZSwgaXQganVzdA0KPiA+
IHRyaWdnZXJzIHRoaXMgaXNzdWUgYWNjaWRlbnRseeKYuQ0KPiA+DQo+ID4gQnV0IEkgc2F3IEFi
ZWwncyBBSEIgcGF0Y2ggaXMgc3RpbGwgdW5kZXIgZGlzY3Vzc2lvbiwgc28gSSB0aGluayB3ZQ0K
PiA+IG5lZWQgdG8gc3BlZWQgaXQgdXAgYW5kIG1ha2Uga2VybmVsIGJvb3QgdXAgd29yayBmb3Ig
ZGV2ZWxvcG1lbnQuDQo+IEFIQi9JUEcgYXJlIGFsd2F5cyBjcml0aWNhbCBmb3IgaS5NWCBTb0Nz
Lg0KPiANCj4gVGhhbmtzIEFuc29uLA0KPiANCj4gWW91ciBleHBsYW5hdGlvbiBtYWtlcyBhIGxv
dCBvZiBzZW5zZS4gV2Ugd2lsbCB0YWtlIGNhcmUgdG9kYXkgb2YgQWJlbCdzDQo+IHBhdGNoLg0K
PiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCBGYWJpbydzIHBhdGNoPyBJIGFsc28gdGhpbmsgdGhp
cyBpcyBhIHZhbGlkIHBhdGNoOg0KPiANCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZjb2RlLmINCj4gdWxpeC5vcmclMkZw
ZDg4anAtDQo+IDgxMjM4MSZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29t
JTdDMjNiNGMyMWUzY2JjDQo+IDRmY2YyYTNjMDhkNzEzZjEzMWE4JTdDNjg2ZWExZDNiYzJiNGM2
ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCUNCj4gN0M2MzY5OTk3OTg5NDk2MjI5NjEmYW1wO3Nk
YXRhPUp4OUI0MHJKS3BRdmFrT0NmeCUyQjN2ODBOVHhQcVV3DQo+IEQ0cGRHb2pReFZJb1klM0Qm
YW1wO3Jlc2VydmVkPTANCg0KSG1tLCB3aGVuIGRpZCBGYWJpbyBzZW50IG91dCB0aGlzIHBhdGNo
PyBJIGNhbiBOT1QgZmluZCBpdC4uLg0KSSBhbHNvIGhhdmUgYSBwYXRjaCBpbiB0aGlzIHNlcmll
cyAoIzQvNikgZG9pbmcgc2FtZSB0aGluZyBvbiBKdWx5IDV0aC4uLg0KDQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzExMDMyNzgzLw0KDQpUaGFua3MuDQpBbnNvbg0KDQo=

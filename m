Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124959FD7A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1IwH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 04:52:07 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:37609
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfH1IwH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 04:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB0GCeD1Uvzhg/3tN9DSMVfYqFWqi1H/+cptXpTN4f4+rKenBg9TW+zbxs5NB+LL+5RlQjMINlKUZkrrnMvecf2YtjIV/gNonOavbHTDb5DHmimcTeDrWTFyq62dzQ70LZOslrGSbGXebc/e8r9WYB4D0yjvdweA2xknamPaM9aLo6lKtyZc7/DHQOK+sObXH6Tm/CNY8/jEG3Q7g8zqv1ZPDB9fyw0CBQ+lnvDIv9Q4LV5/H/TS53+/l/bge/5B6mONq9sq4SX9un6ziw1L6VWkD/rWssP9WLL9Mr4tjOnBJtOtegYyS2W1OqwTdyFYVVqD8qNRaKHHHZS2hSaxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB9oOmXUgWMAC3dNFwGEjZ+tjSkufJSAOXLzyrJhSEk=;
 b=fen03mkx3LW1rnWw2+V1DrxqY3/efg3uEBzYeQSdnrUhrTdJjofTxuA75BMBnhAjAsvdsgZ6DKZFpcyDKTCGxxR36tfs95KDR2YBhNwoRfEp2RAHmfZbiU2fl1z8xnIVJopHV87ZfIVrZlwPk2ROpJb9AeOMC/E+XF3ymQdbn+/mhcs1kYFTfsemes/mcMHVVdfb+lRIfOwuVqgB4lvNWJEnz2aGdb1SvVYmg2nuuBIwKdPrJVuioVAi4kx+qj/s23sc1xoAXrB2grpv8OE7NMjFy6YEyy0eG5ZBnxS2M/HS8eqTNcnUEttrA7gRC2/zMfV94n+mTP/ziux4qmbvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB9oOmXUgWMAC3dNFwGEjZ+tjSkufJSAOXLzyrJhSEk=;
 b=gE6YlKq+9qZlROZS54o06lSIWnG2Z+7H4N7Y/5km6Qf4NhGUEqv01mJFOxhnzuSIh/0byZ3zVq/m1PO6r9Hj48WGOMsKqgecwADMorvCqXvAxsONHPJ674rLNfRmKfc53NoKSyoIdnG8s0TyF4R11zhzOKPJX0yy6q+A6GJQ1z0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3914.eurprd04.prod.outlook.com (52.134.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 08:51:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 08:51:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacQaSEAgAAE+eA=
Date:   Wed, 28 Aug 2019 08:51:51 +0000
Message-ID: <DB3PR0402MB3916D1492F43D77E3679E3B1F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
In-Reply-To: <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52b736b2-607a-4513-814e-08d72b94f80e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3914;
x-ms-traffictypediagnostic: DB3PR0402MB3914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3914FF15CD3C27248E4F50C2F5A30@DB3PR0402MB3914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(4326008)(6246003)(25786009)(6436002)(7416002)(66446008)(66476007)(9686003)(66066001)(305945005)(52536014)(76116006)(229853002)(64756008)(66556008)(66946007)(256004)(3846002)(102836004)(44832011)(186003)(55016002)(14444005)(76176011)(6506007)(446003)(74316002)(53546011)(5660300002)(99286004)(26005)(486006)(476003)(7736002)(7696005)(11346002)(8936002)(33656002)(2906002)(71190400001)(71200400001)(8676002)(110136005)(6116002)(478600001)(81166006)(81156014)(14454004)(316002)(54906003)(53936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3914;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8fg2acVHbPbGShVV2DNvXfNTDfVYE3744yhJff7BkMBYYNfZIhueZy6V5ku3h3CC7JbeAaBZGdkS8zuA3fRqzo7NcjqbojNLa8F/lTDJpIHn7zmntj2bJq7+2g/EdMBdDLDJAPHVShuT5buw97mFsTF0lycBF+sTi7WuIBcnw8AcGVmpiECahuQIjQ7Ad233+304WqCmj3UT+hpoKkJZMNxxrQnY25MZSdqIUO99QniEE++i/Dwxx723yHUqOaS/AXnE1CKUMEnp7XUTB6ll8zkBVX7o6w+OrDX6zRbI63IFBJRV4xE9eqkEp0/ehg/akCbOx7v54yuUeSTUbOTYiTYEs4FWjnddY0whaZIJeu/3nd8fWQ5uJrJIsqYX0+UfZd9EX57V2VdvwGV/bKbSI9Aq9VPhQbP3kRU5DHpf5Qc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b736b2-607a-4513-814e-08d72b94f80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 08:51:51.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52RJ32Ubl57HbL9AXApju/sfO6APxcDwv/HhPmzhiUmA++olFYK9nvhz1xT1gxFsNEObXIYqhgFz00Y3myO8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+IE9uIFR1ZSwgMjAxOS0wOC0yNyBhdCAxMjo0MSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIDI3LjA4LjIwMTkgMDQ6NTEsIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+ID4gPiBJbiBhbiBlYXJsaWVyIHNlcmllcyB0aGUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWdz
IHdhcyByZW1vdmVkIGZyb20NCj4gPiA+ID4gdGhlIFRNVSBjbG9jayBzbyBpZiB0aGUgdGhlcm1h
bCBkcml2ZXIgZG9lc24ndCBleHBsaWNpdGx5IGVuYWJsZQ0KPiA+ID4gPiBpdCB0aGUgc3lzdGVt
IHdpbGwgaGFuZyBvbiBwcm9iZS4gVGhpcyBpcyB3aGF0IGhhcHBlbnMgaW4NCj4gPiA+ID4gbGlu
dXgtbmV4dCByaWdodCBub3chDQo+ID4gPg0KPiA+ID4gVGhlIHRoZXJtYWwgZHJpdmVyIHNob3Vs
ZCBiZSBidWlsdCB3aXRoIG1vZHVsZSwgc28gZGVmYXVsdCBrZXJuZWwNCj4gPiA+IHNob3VsZCBj
YW4gYm9vdCB1cCwgZG8geW91IG1vZGlmeSB0aGUgdGhlcm1hbCBkcml2ZXIgYXMgYnVpbHQtaW4/
DQo+ID4gPg0KPiA+ID4gPiBVbmxlc3MgdGhpcyBwYXRjaGVzIGlzIG1lcmdlZCBzb29uIHdlJ2xs
IGVuZCB1cCB3aXRoIGEgNS40LXJjMQ0KPiA+ID4gPiB0aGF0IGRvZXNuJ3QgYm9vdCBvbiBpbXg4
bXEuIEFuIGVhc3kgZml4IHdvdWxkIGJlIHRvIGRyb3AvcmV2ZXJ0DQo+ID4gPiA+IGNvbW1pdA0K
PiA+ID4gPiA5NTFjMWFlZjk2OTEgKCJjbGs6IGlteDhtcTogUmVtb3ZlIENMS19JU19DUklUSUNB
TCBmbGFnIGZvcg0KPiA+ID4gPiBJTVg4TVFfQ0xLX1RNVV9ST09UIikgdW50aWwgdGhlIHRoZXJt
YWwgcGF0Y2hlcyBhcmUgYWNjZXB0ZWQuDQo+ID4gPg0KPiA+ID4gSWYgdGhlIHRoZXJtYWwgZHJp
dmVyIGlzIGJ1aWx0IGFzIG1vZHVsZSwgSSB0aGluayBubyBuZWVkIHRvIHJldmVydA0KPiA+ID4g
dGhlIGNvbW1pdCwgYnV0IGlmIGJ5IGRlZmF1bHQgdGhlcm1hbCBkcml2ZXIgaXMgYnVpbHQtaW4g
b3IgbW9kDQo+ID4gPiBwcm9iZWQsIHRoZW4geWVzLCBpdCBzaG91bGQgTk9UIGJyZWFrIGtlcm5l
bCBib290IHVwLg0KPiA+DQo+ID4gVGhlIHFvcmlxX3RoZXJtYWwgZHJpdmVyIGlzIGJ1aWx0IGFz
IGEgbW9kdWxlIGluIGRlZmNvbmZpZyBhbmQgd2hlbg0KPiA+IG1vZHVsZXMgYXJlIHByb3Blcmx5
IGluc3RhbGxlZCBpbiByb290ZnMgdGhleSB3aWxsIGJlIGF1dG9tYXRpY2FsbHkgYmUNCj4gPiBw
cm9iZWQgb24gYm9vdCBhbmQgY2F1c2UgYSBoYW5nLg0KPiA+DQo+ID4gSSB1c3VhbGx5IHJ1biBu
ZnNyb290IHdpdGggbW9kdWxlczoNCj4gPg0KPiA+ICAgICAgbWFrZSBtb2R1bGVzX2luc3RhbGwg
SU5TVEFMTF9NT0RfUEFUSD0vc3J2L25mcy9pbXg4LXJvb3QNCj4gDQo+IHNvIHdlIG5lZWQgdGhp
cyBwYXRjaCBzaGlwcGVkIGluIHRoZSBiZWdpbm5pbmcgb2YgdGhlIG1lcmdlIHdpbmRvdywgcmln
aHQ/DQo+IGlmIHRoZXJlIGlzIGhhcmQgZGVwZW5kZW5jeSBiZXR3ZWVuIHBhdGNoZXMsIGl0J3Mg
YmV0dGVyIHRvIHNlbmQgdGhlbSBpbiBvbmUNCj4gc2VyaWVzLCBhbmQgZ2V0IHNoaXBwZWQgdmlh
IGVpdGhlciB0cmVlLg0KDQpUaGVyZSBpcyBubyBoYXJkIGRlcGVuZGVuY3kgaW4gdGhpcyBwYXRj
aCBzZXJpZXMuIFByZXZpb3VzIGZvciB0aGUgVE1VIGNsb2NrIGRpc2FibGVkDQpwYXRjaCwgc2lu
Y2UgdGhlcm1hbCBkcml2ZXIgaXMgYnVpbHQgYXMgbW9kdWxlIHNvIEkgZGlkIE5PVCBmb3VuZCB0
aGUgaXNzdWUuIFRoZSBwYXRjaA0Kc2VyaWVzIGlzIHRoZSBjb3JyZWN0IGZpeC4NCg0KVGhhbmtz
LA0KQW5zb24gDQoNCj4gDQo+IEJUVywgd2hvIGlzIG1haW50YWluaW5nIHFvcmlxIGRyaXZlciBm
cm9tIE5YUD8gSWYgQW5zb24gaXMgbWFpbnRhaW5pbmcgYW5kDQo+IGRldmVsb3BpbmcgdGhpcyBk
cml2ZXIsIGl0J3MgYmV0dGVyIHRvIHVwZGF0ZSB0aGlzIGluIHRoZSBkcml2ZXIgb3IgdGhlDQo+
IE1BSU5UQUlORVIgZmlsZSwgSSB3aWxsIHRha2UgdGhlIGRyaXZlciBzcGVjaWZpYyBwYXRjaGVz
IGFzIGxvbmcgYXMgd2UgaGF2ZQ0KPiBBQ0svUmV2aWV3ZWQtQnkgZnJvbSB0aGUgZHJpdmVyIG1h
aW50YWluZXIuDQo+IA0KPiB0aGFua3MsDQo+IHJ1aQ0KPiANCj4gPg0KPiA+IC0tDQo+ID4gUmVn
YXJkcywNCj4gPiBMZW9uYXJkDQoNCg==

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A9A0FAD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfH2Ctk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 22:49:40 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:54453
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfH2Ctj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 22:49:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYbk+KIwpzXObYCmJTwJshBAXfgO7Q1kILwJahdR0VIYFl4tFo3yYB8i/1bSslsdvMicfoJUTMiOSjQ/f9qR+74okJGJBMASAFhvE7Jee12BHTUwyCXjYLu04TPGvEaA8o9l8BCatrU1E+IIKHGsoFVi27SQghLQQBvVWvssfRf3t8/8RD3LI8anOCt5ufQ8LuO3/1ZJpTvSttXmua0Q3jWcvF0txCw6TXzXYDpGmcQj9+tyhrXNJDG+FIkISYgpns9LrodgxEMWRdDlRpOSQKYHxwY+vjHkPIAsLsFPbTD5wY8brsHWQ5HFATEWz+GSfclDXFpSOyQGh8ZA7BgFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJkFNnOFwvYqfDdSeAkg2VX+LHTBe+CkAIK3zLYSjSM=;
 b=IuPqKjHOPg/5L/F5aSDsGbPxmh/8bl1Zuei5ONQFOjOSUAyIQVB+2Jd257wX50J4j85wSJf6wu2MqK28SJnWiAAzYc5HDQqnSFaGhmcQ7jKSyYEfZHYZWwcbSqYwo8444cSJJV08MhAdnX2hwpfPEppLyH9+Fbe6w5qGdbWHqxgIap9O0WPeZHxGT+K27lqdLiP4+U+RLlmDThXuP99jzGxQiHTyoE5C6IXH5VJqP9Vie/HzivBauXE1wUBclN99ajCSgyC8WE3XLaiy+RBfHZK0vhRkD3UZ89IwECsM42K2al6jfo7ouJ5ZIWJbGUcom/OQeFahX4PLVDs9LzniZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJkFNnOFwvYqfDdSeAkg2VX+LHTBe+CkAIK3zLYSjSM=;
 b=LkeEdFyG0UVS13+VSct3tBinuBjNzfzIPT3I9wiYZ4QLnfayRvVmfysEAST1kT83xxlXS3B6gRsFN9PI2Oj6pSmhX0oqzgNNSCQ/yrdqUnCqWIJKetz5h4ZUoEMZbXPw1NfWwzlspQG969MiQu8x1vSONpq/3I8M7mN7K/ddc1A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Thu, 29 Aug 2019 02:49:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 02:49:32 +0000
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
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacQaSEAgAAE+eCAAAPjgIAAAXqAgAEnrCA=
Date:   Thu, 29 Aug 2019 02:49:32 +0000
Message-ID: <DB3PR0402MB3916372A08E2FF3A9C15E0A6F5A20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
         <DB3PR0402MB3916D1492F43D77E3679E3B1F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <3f268ab0e05b795c04dbb3490f0c93da998e3b2c.camel@intel.com>
 <DB3PR0402MB39168DA42F69336EB2B231E8F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39168DA42F69336EB2B231E8F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ba1ca74-d396-4099-5ffe-08d72c2b8543
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3756012A981634B8143C7B7BF5A20@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(4326008)(66446008)(64756008)(66556008)(14444005)(66476007)(44832011)(66946007)(76116006)(14454004)(256004)(81166006)(74316002)(8676002)(81156014)(66066001)(316002)(71200400001)(71190400001)(86362001)(6116002)(3846002)(8936002)(7416002)(11346002)(33656002)(229853002)(6436002)(110136005)(25786009)(486006)(6506007)(6246003)(9686003)(53546011)(476003)(55016002)(52536014)(446003)(102836004)(7696005)(99286004)(76176011)(2906002)(53936002)(7736002)(305945005)(26005)(478600001)(5660300002)(54906003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zrpacQTs9DZT7kOa6zE0vclBeKhPquf3Cgj6iIaabjLpVQMBbzbSCfg6gKd7xHwgrthFhYPBoSSmctoszSWoQ4IKwDRct40kJ+fSWNGx0izd9bGgQCmEZ12pQeOVhkl+2AmnnzAhb6AyYv3avYf9qUikRJC+NfOTdKa8ZfD4dM8h0GLtgO/ezK4c3s9AMPdhvZVfTbnTUVyonF/FXI/iYyHIyqEC0oMTN3cR/zASJKrL9VxemdDguLIK78IcV61ZXnDz9cLCUxb80ToP7do7M0FIurRWQh1KFbWVIE/+pgHBh9LKTqrSlwXD8qQCnyuTMOaWDmzt2MC3QTT4klgfSuxbsF/QcCTSdecutNEk4u6pznvroIYtsf0F32NLKoYY1OiOEv9J9b9Ax2+HUtojSoNH3pulEoOWKQ4Gz5uoxMk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba1ca74-d396-4099-5ffe-08d72c2b8543
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 02:49:32.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGDQYzNxqS+XsMMKiYEJCY0KXYkDG/DSra/udIDCdrEJf+7bCGFX1frAxkTZwENx5GwP/PxYosykhGsLrV7U0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+ID4gT24gV2VkLCAyMDE5LTA4LTI4IGF0IDA4OjUxICswMDAwLCBBbnNvbiBI
dWFuZyB3cm90ZToNCj4gPiA+IEhpLCBSdWkNCj4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgMjAxOS0w
OC0yNyBhdCAxMjo0MSArMDAwMCwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+ID4gPiA+IE9u
IDI3LjA4LjIwMTkgMDQ6NTEsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBJbiBh
biBlYXJsaWVyIHNlcmllcyB0aGUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWdzIHdhcyByZW1vdmVkDQo+
ID4gPiA+ID4gPiA+IGZyb20gdGhlIFRNVSBjbG9jayBzbyBpZiB0aGUgdGhlcm1hbCBkcml2ZXIg
ZG9lc24ndA0KPiA+ID4gPiA+ID4gPiBleHBsaWNpdGx5IGVuYWJsZSBpdCB0aGUgc3lzdGVtIHdp
bGwgaGFuZyBvbiBwcm9iZS4gVGhpcyBpcw0KPiA+ID4gPiA+ID4gPiB3aGF0IGhhcHBlbnMgaW4g
bGludXgtbmV4dCByaWdodCBub3chDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIHRoZXJt
YWwgZHJpdmVyIHNob3VsZCBiZSBidWlsdCB3aXRoIG1vZHVsZSwgc28gZGVmYXVsdA0KPiA+ID4g
PiA+ID4ga2VybmVsIHNob3VsZCBjYW4gYm9vdCB1cCwgZG8geW91IG1vZGlmeSB0aGUgdGhlcm1h
bCBkcml2ZXIgYXMNCj4gPiA+ID4gPiA+IGJ1aWx0LSBpbj8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IFVubGVzcyB0aGlzIHBhdGNoZXMgaXMgbWVyZ2VkIHNvb24gd2UnbGwgZW5kIHVwIHdp
dGggYSA1LjQtDQo+ID4gPiA+ID4gPiA+IHJjMQ0KPiA+ID4gPiA+ID4gPiB0aGF0IGRvZXNuJ3Qg
Ym9vdCBvbiBpbXg4bXEuIEFuIGVhc3kgZml4IHdvdWxkIGJlIHRvDQo+ID4gPiA+ID4gPiA+IGRy
b3AvcmV2ZXJ0IGNvbW1pdA0KPiA+ID4gPiA+ID4gPiA5NTFjMWFlZjk2OTEgKCJjbGs6IGlteDht
cTogUmVtb3ZlIENMS19JU19DUklUSUNBTCBmbGFnIGZvcg0KPiA+ID4gPiA+ID4gPiBJTVg4TVFf
Q0xLX1RNVV9ST09UIikgdW50aWwgdGhlIHRoZXJtYWwgcGF0Y2hlcyBhcmUNCj4gYWNjZXB0ZWQu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSWYgdGhlIHRoZXJtYWwgZHJpdmVyIGlzIGJ1aWx0
IGFzIG1vZHVsZSwgSSB0aGluayBubyBuZWVkIHRvDQo+ID4gPiA+ID4gPiByZXZlcnQgdGhlIGNv
bW1pdCwgYnV0IGlmIGJ5IGRlZmF1bHQgdGhlcm1hbCBkcml2ZXIgaXMNCj4gPiA+ID4gPiA+IGJ1
aWx0LWluIG9yIG1vZCBwcm9iZWQsIHRoZW4geWVzLCBpdCBzaG91bGQgTk9UIGJyZWFrIGtlcm5l
bCBib290DQo+IHVwLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIHFvcmlxX3RoZXJtYWwgZHJp
dmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlIGluIGRlZmNvbmZpZyBhbmQNCj4gPiA+ID4gPiB3aGVu
IG1vZHVsZXMgYXJlIHByb3Blcmx5IGluc3RhbGxlZCBpbiByb290ZnMgdGhleSB3aWxsIGJlDQo+
ID4gPiA+ID4gYXV0b21hdGljYWxseSBiZSBwcm9iZWQgb24gYm9vdCBhbmQgY2F1c2UgYSBoYW5n
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSB1c3VhbGx5IHJ1biBuZnNyb290IHdpdGggbW9kdWxl
czoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgbWFrZSBtb2R1bGVzX2luc3RhbGwgSU5TVEFM
TF9NT0RfUEFUSD0vc3J2L25mcy9pbXg4LXJvb3QNCj4gPiA+ID4NCj4gPiA+ID4gc28gd2UgbmVl
ZCB0aGlzIHBhdGNoIHNoaXBwZWQgaW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgbWVyZ2UNCj4gPiA+
ID4gd2luZG93LCByaWdodD8NCj4gPiA+ID4gaWYgdGhlcmUgaXMgaGFyZCBkZXBlbmRlbmN5IGJl
dHdlZW4gcGF0Y2hlcywgaXQncyBiZXR0ZXIgdG8gc2VuZA0KPiA+ID4gPiB0aGVtIGluIG9uZSBz
ZXJpZXMsIGFuZCBnZXQgc2hpcHBlZCB2aWEgZWl0aGVyIHRyZWUuDQo+ID4gPg0KPiA+ID4gVGhl
cmUgaXMgbm8gaGFyZCBkZXBlbmRlbmN5IGluIHRoaXMgcGF0Y2ggc2VyaWVzLiBQcmV2aW91cyBm
b3IgdGhlDQo+ID4gPiBUTVUgY2xvY2sgZGlzYWJsZWQgcGF0Y2gsIHNpbmNlIHRoZXJtYWwgZHJp
dmVyIGlzIGJ1aWx0IGFzIG1vZHVsZSBzbw0KPiA+ID4gSSBkaWQgTk9UIGZvdW5kIHRoZSBpc3N1
ZS4gVGhlIHBhdGNoIHNlcmllcyBpcyB0aGUgY29ycmVjdCBmaXguDQo+ID4gPg0KPiA+IEdvdCBp
dC4NCj4gPiB0aGUgY2xvY2sgcGF0Y2ggaXMgYWxzbyBxdWV1ZWQgZm9yIDUuNC1yYzEsIHJpZ2h0
Pw0KPiA+IEkgd2lsbCBhcHBseSB0aGlzIHNlcmllcyBhbmQgdHJ5IHRvIHB1c2ggaXQgYXMgZWFy
bHkgYXMgcG9zc2libGUNCj4gPiBkdXJpbmcgdGhlIG1lcmdlIHdpbmRvdy4NCj4gDQo+IFRoZSBj
bG9jayBwYXRjaCBpcyBhcyBiZWxvdyBpbiBMaW51eC1uZXh0IHRyZWUsIHdoaWxlIEkgZGlkIE5P
VCBzZWUgaXQgaW4gdjUuMy0NCj4gcmM2LCBzbyBpdCBzaG91bGQgYmUgcXVldWVkIGZvciA1LjQt
cmMxLCByaWdodD8NCj4gVGhhbmtzIGZvciB0YWtpbmcgdGhlIHBhdGNoIHNlcmllcyENCg0KU29y
cnkgZm9yIHB1c2hpbmcsIHNvIHlvdSB3aWxsIGFwcGx5IHRoaXMgcGF0Y2ggc2VyaWVzIHRvIGF2
b2lkIHRoZSBpLk1YOE1RIGtlcm5lbCBib290IHVwIGhhbmcNCmNhdXNlZCBieSBpbnNtb2QgcW9y
aXEgdGhlcm1hbCBkcml2ZXIsIHJpZ2h0PyBUaGVuIHdlIG5vIG5lZWQgdG8gcmV2ZXJ0IHRoYXQg
VE1VIGNsb2NrIHBhdGNoDQo5NTFjMWFlZjk2OTEgKCJjbGs6IGlteDhtcTogUmVtb3ZlIENMS19J
U19DUklUSUNBTCBmbGFnIGZvciBJTVg4TVFfQ0xLX1RNVV9ST09UIikuDQoNClRoYW5rcywNCkFu
c29uDQoNCj4gDQo+IA0KPiBjb21taXQgOTUxYzFhZWY5NjkxNDkxZGRmNGRkNWFhYjc2ZjI2NjVk
NTZiZDVkMw0KPiBBdXRob3I6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBE
YXRlOiAgIEZyaSBKdWwgNSAxMjo1NjoxMSAyMDE5ICswODAwDQo+IA0KPiAgICAgY2xrOiBpbXg4
bXE6IFJlbW92ZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBmb3IgSU1YOE1RX0NMS19UTVVfUk9PVA0K
PiANCj4gICAgIElNWDhNUV9DTEtfVE1VX1JPT1QgaXMgT05MWSB1c2VkIGZvciB0aGVybWFsIG1v
ZHVsZSwgdGhlIGRyaXZlcg0KPiAgICAgc2hvdWxkIG1hbmFnZSB0aGlzIGNsb2NrLCBzbyBubyBu
ZWVkIHRvIGhhdmUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcNCj4gICAgIHNldC4NCj4gDQo+ICAgICBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gICAgIFJl
dmlld2VkLWJ5OiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiAgICAgQWNrZWQtYnk6
IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gICAgIFNpZ25lZC1vZmYtYnk6IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gDQo+IGRyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1xLmMNCj4gDQo+IA0KPiBUaGFua3MsDQo+IEFuc29uDQo=

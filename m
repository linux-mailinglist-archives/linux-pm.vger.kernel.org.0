Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7F9FD70
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1Itt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 04:49:49 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:15965
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfH1Itt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 04:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx+c1mDHU/vrIJFYNAwsTzVRLMgKratPaomf9VsRRQ9GL9Pc+1Grh/Eavi+qQr3jdeSkMXz4Po8XcQg1dQIUauRqwQQW6uX63T0ndPg56Hlt30aRk2ljZ40du1ci1b/3dhtu4D10NjwBV7AP9/cksulyOhkDCW1K2E06QIVAHkpzcl9ynh/2N9T0DzCFvV2TfpzF9QQc+znHJouXLkwycDjCu/TmugkWJO2PyZB5MlVb1VSIV+YQv9XPxv+ssqeuBItK/fkVYT67IGGUIXg3/GPAevSHkIpNpFsi7i5n5aOiLwmD26ohtwKCRRc9uAZfmOOGjM+Sk0SlHCbrDyrqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7quiOdEkVI5Z36qWRv6XTFHjsfW3GhocFKQxMV6Tf6s=;
 b=Ms8w+OnDNnH5tWwx5B4VDTzXjTl/sXBXVslozbce/1Y4WvkLskNobaIUVSAK5RJgdkWCAEHjg2WSq3MkHnbUpfr6FS8VfDZGFrX2pY6YuD41Kg2eyOBmMm7GhVBxWCzeQke6zbfQNls9rGhw9ShIeNRvt1NUPtxNqLPYvpknFv6SYLLevm8YF9do8ahWDbZn+CpLSJiK3QVGat3DrtiNeF5kG31KpVta82C+nX8gEnDdt+XBNd5QdJujLMRK1YgJN+iYgYrGdds8AIon+UbIGGkGKLVn84zSfO/KgG28lnGEo0r60d4w59lGVxers3kjGEFI7auql4vMnbtNIWcBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7quiOdEkVI5Z36qWRv6XTFHjsfW3GhocFKQxMV6Tf6s=;
 b=CQFw8iLo8PlU4hpQldKNdZmvQBhcsvxHP0DV8hzbkP3N5/43BEzdEd514KReAoOIbdBnSeNGg/9EWsfgDK6rhQHoaPQStoc1EyRP6utLsXcoN3FTOD0ygm+XKCRy8AkH3YgDfThCt6knK+G7yrzfomTXpaKc5sauzBxQQPDL5wU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3914.eurprd04.prod.outlook.com (52.134.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 08:49:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 08:49:44 +0000
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
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacQaSEAgAAA+YCAAAF2wA==
Date:   Wed, 28 Aug 2019 08:49:44 +0000
Message-ID: <DB3PR0402MB3916045AFDDF4EFA9AD50842F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
 <afb235bf7390fb6fbd723c34b08feddd771d1f6c.camel@intel.com>
In-Reply-To: <afb235bf7390fb6fbd723c34b08feddd771d1f6c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ed47425-464e-4ffb-685c-08d72b94ac81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3914;
x-ms-traffictypediagnostic: DB3PR0402MB3914:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB39145E849BD7131F7BF264AFF5A30@DB3PR0402MB3914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(4326008)(6246003)(6306002)(25786009)(6436002)(7416002)(66446008)(66476007)(9686003)(66066001)(305945005)(52536014)(76116006)(45080400002)(229853002)(64756008)(66556008)(66946007)(256004)(3846002)(102836004)(44832011)(186003)(55016002)(14444005)(76176011)(6506007)(446003)(74316002)(53546011)(5660300002)(99286004)(26005)(486006)(476003)(7736002)(7696005)(11346002)(8936002)(33656002)(2906002)(71190400001)(71200400001)(8676002)(110136005)(6116002)(478600001)(81166006)(81156014)(14454004)(316002)(54906003)(53936002)(86362001)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3914;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lJJ7TtySO9WzHG04wVwIEE6G5/GDihEuj0PHhcrue7ZJf6ThASZkxwXH3tOidToo5nV9rcdLsstr0wjZBrhb9SimV3HgY+Z25nT8RObqFS5pBrS5XZ/aGhaWarP6Mj+f2KDneiNloH4wOMqLS6JEg6i/S7Z606aBHTZHqnsBn2g0H11zOThySPyH3VfQ/03D6xSf7NthU45d7TVJsDE4985Lef6cV/Mq3vehvQ3nOyNrb4zSdkZ6R6FNNeYHkZBI5kSExOiJ8Dj8gLoZwUk7BedKLMzgG8AuMrKIZsdNQjydyZGkq/ML9mV/YbqqXKqPzhHRhYAK1Mb/JxPRB86Hy64lZKsL+U0rih90sC6NblacKtd0xw+HStQI4GFmG0qAhCVPpKXzfvwib5TSU4qPljwdeongG+5lKOSHnzJDZcs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed47425-464e-4ffb-685c-08d72b94ac81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 08:49:44.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZkHoRg0luEw7DxO0MuKuQmJlKWEoY3j0PbMFPE5KH0cBdP1KTxyRYQSXTsoiJhVptBz9ao629NDj9ql1FNS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+IE9uIFdlZCwgMjAxOS0wOC0yOCBhdCAxNjozMiArMDgwMCwgWmhhbmcgUnVp
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOS0wOC0yNyBhdCAxMjo0MSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+ID4gT24gMjcuMDguMjAxOSAwNDo1MSwgQW5zb24gSHVhbmcgd3Jv
dGU6DQo+ID4gPiA+ID4gSW4gYW4gZWFybGllciBzZXJpZXMgdGhlIENMS19JU19DUklUSUNBTCBm
bGFncyB3YXMgcmVtb3ZlZCBmcm9tDQo+ID4gPiA+ID4gdGhlIFRNVSBjbG9jayBzbyBpZiB0aGUg
dGhlcm1hbCBkcml2ZXIgZG9lc24ndCBleHBsaWNpdGx5IGVuYWJsZQ0KPiA+ID4gPiA+IGl0IHRo
ZSBzeXN0ZW0gd2lsbCBoYW5nIG9uIHByb2JlLiBUaGlzIGlzIHdoYXQgaGFwcGVucyBpbg0KPiA+
ID4gPiA+IGxpbnV4LW5leHQgcmlnaHQgbm93IQ0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgdGhlcm1h
bCBkcml2ZXIgc2hvdWxkIGJlIGJ1aWx0IHdpdGggbW9kdWxlLCBzbyBkZWZhdWx0IGtlcm5lbA0K
PiA+ID4gPiBzaG91bGQgY2FuIGJvb3QgdXAsIGRvIHlvdSBtb2RpZnkgdGhlIHRoZXJtYWwgZHJp
dmVyIGFzIGJ1aWx0LWluPw0KPiA+ID4gPg0KPiA+ID4gPiA+IFVubGVzcyB0aGlzIHBhdGNoZXMg
aXMgbWVyZ2VkIHNvb24gd2UnbGwgZW5kIHVwIHdpdGggYSA1LjQtcmMxDQo+ID4gPiA+ID4gdGhh
dCBkb2Vzbid0IGJvb3Qgb24gaW14OG1xLiBBbiBlYXN5IGZpeCB3b3VsZCBiZSB0byBkcm9wL3Jl
dmVydA0KPiA+ID4gPiA+IGNvbW1pdA0KPiA+ID4gPiA+IDk1MWMxYWVmOTY5MSAoImNsazogaW14
OG1xOiBSZW1vdmUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcgZm9yDQo+ID4gPiA+ID4gSU1YOE1RX0NM
S19UTVVfUk9PVCIpIHVudGlsIHRoZSB0aGVybWFsIHBhdGNoZXMgYXJlIGFjY2VwdGVkLg0KPiA+
ID4gPg0KPiA+ID4gPiBJZiB0aGUgdGhlcm1hbCBkcml2ZXIgaXMgYnVpbHQgYXMgbW9kdWxlLCBJ
IHRoaW5rIG5vIG5lZWQgdG8NCj4gPiA+ID4gcmV2ZXJ0IHRoZSBjb21taXQsIGJ1dCBpZiBieSBk
ZWZhdWx0IHRoZXJtYWwgZHJpdmVyIGlzIGJ1aWx0LWluIG9yDQo+ID4gPiA+IG1vZCBwcm9iZWQs
IHRoZW4geWVzLCBpdCBzaG91bGQgTk9UIGJyZWFrIGtlcm5lbCBib290IHVwLg0KPiA+ID4NCj4g
PiA+IFRoZSBxb3JpcV90aGVybWFsIGRyaXZlciBpcyBidWlsdCBhcyBhIG1vZHVsZSBpbiBkZWZj
b25maWcgYW5kIHdoZW4NCj4gPiA+IG1vZHVsZXMgYXJlIHByb3Blcmx5IGluc3RhbGxlZCBpbiBy
b290ZnMgdGhleSB3aWxsIGJlIGF1dG9tYXRpY2FsbHkNCj4gPiA+IGJlIHByb2JlZCBvbiBib290
IGFuZCBjYXVzZSBhIGhhbmcuDQo+ID4gPg0KPiA+ID4gSSB1c3VhbGx5IHJ1biBuZnNyb290IHdp
dGggbW9kdWxlczoNCj4gPiA+DQo+ID4gPiAgICAgIG1ha2UgbW9kdWxlc19pbnN0YWxsIElOU1RB
TExfTU9EX1BBVEg9L3Nydi9uZnMvaW14OC1yb290DQo+ID4NCj4gPiBzbyB3ZSBuZWVkIHRoaXMg
cGF0Y2ggc2hpcHBlZCBpbiB0aGUgYmVnaW5uaW5nIG9mIHRoZSBtZXJnZSB3aW5kb3csDQo+ID4g
cmlnaHQ/DQo+ID4gaWYgdGhlcmUgaXMgaGFyZCBkZXBlbmRlbmN5IGJldHdlZW4gcGF0Y2hlcywg
aXQncyBiZXR0ZXIgdG8gc2VuZCB0aGVtDQo+ID4gaW4gb25lIHNlcmllcywgYW5kIGdldCBzaGlw
cGVkIHZpYSBlaXRoZXIgdHJlZS4NCj4gPg0KPiA+IEJUVywgd2hvIGlzIG1haW50YWluaW5nIHFv
cmlxIGRyaXZlciBmcm9tIE5YUD8gSWYgQW5zb24gaXMgbWFpbnRhaW5pbmcNCj4gPiBhbmQgZGV2
ZWxvcGluZyB0aGlzIGRyaXZlciwgaXQncyBiZXR0ZXIgdG8gdXBkYXRlIHRoaXMgaW4gdGhlIGRy
aXZlcg0KPiA+IG9yIHRoZSBNQUlOVEFJTkVSIGZpbGUsIEkgd2lsbCB0YWtlIHRoZSBkcml2ZXIg
c3BlY2lmaWMgcGF0Y2hlcyBhcw0KPiA+IGxvbmcgYXMgd2UgaGF2ZSBBQ0svUmV2aWV3ZWQtQnkg
ZnJvbSB0aGUgZHJpdmVyIG1haW50YWluZXIuDQoNCkkgYW0gTk9UIHN1cmUgd2hvIGlzIHRoZSBx
b3JpcSBkcml2ZXIgZnJvbSBOWFAsIHNvbWUgb2Ygb3VyIGkuTVggU29DcyB1c2UNCnFvcmlxIHRo
ZXJtYWwgSVAsIHNvIEkgaGF2ZSB0byBhZGQgc3VwcG9ydCBmb3IgdGhlbS4gIFRoZSBmaXJzdCBt
YWludGFpbmVyIGZvcg0KdGhpcyBkcml2ZXIgaXMgaG9uZ3Rhby5qaWFAbnhwLmNvbSwgYnV0IEkg
Y2FuIE5PVCBmaW5kIGl0IGZyb20gTlhQJ3MgbWFpbCBzeXN0ZW0sDQpOT1Qgc3VyZSBpZiBoZSBp
cyBzdGlsbCBpbiBOWFAuIFRoZSBNQUlOVEFJTkVSIGZpbGUgZG9lcyBOT1QgaGF2ZSBpbmZvIGZv
ciB0aGlzDQpEcml2ZXIncyBtYWludGFpbmVyLCBzbyBob3cgdG8gdXBkYXRlIGl0PyBKdXN0IGNo
YW5nZSB0aGUgbmFtZSBpbiBkcml2ZXI/IE9yIGxlYXZlDQppdCBhcyB3aGF0IGl0IGlzPw0KDQog
TU9EVUxFX0FVVEhPUigiSmlhIEhvbmd0YW8gPGhvbmd0YW8uamlhQG54cC5jb20+Iik7DQogTU9E
VUxFX0RFU0NSSVBUSU9OKCJRb3JJUSBUaGVybWFsIE1vbml0b3JpbmcgVW5pdCBkcml2ZXIiKTsN
CiBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQoNCj4gDQo+IEFuZCBhbHNvLCBjYW4geW91IHBy
b3ZpZGUgeW91ciBmZWVkYmFjayBmb3IgdGhpcyBvbmU/DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNoDQo+IHdv
cmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTA5NzQxNDclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fu
c29uLmgNCj4gdWFuZyU0MG54cC5jb20lN0M4ODdlN2M5MGY3Yzk0M2ZmMGQ5YjA4ZDcyYjkyYWVh
MSU3QzY4NmVhMWQzYmMyDQo+IGI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MDI1
NzgxMzI1MjAzMzg0JmFtcDtzZGF0YT1YZw0KPiB0WDZtUGRBNTBOYmIlMkZtblMyb20yYkpOZXBU
ZDF0aDZIbWZ3R3VVOUh3JTNEJmFtcDtyZXNlcnZlDQo+IGQ9MA0KDQpJIGNhbiB0YWtlIGEgbG9v
ayBhdCBpdCBsYXRlci4NCg0KVGhhbmtzLA0KQW5zb24NCg==

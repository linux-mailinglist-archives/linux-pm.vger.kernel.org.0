Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB0105019
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfKUKNR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 05:13:17 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:37963
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfKUKNR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Nov 2019 05:13:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lua2v3jfJsG7Cb6TKrseDmomwCLJgtvEs+bsvVt0X8/GpAYYllJjnmODKfwslK+ooJjbXDF5jPdNQKqhqHmhvRvznp8BAPA5Diqs68U2KML0VqNPkog6atZhclB/INLObeTOemqQAbGFmRTPwyUlymWL1fVavTi9EjdbCSBWhNRM7sd+bbgNII8yENJ87uYofoZo8/BK8FaFuF5hR8jGUM5GG4MvGL6ljpklbqL7w9nhlBMal77F5IB1zSZm/+rVW/J0IGAtqxWJdNtY8V03R8Yr/mbBmy9xQr5qT04Tb6w08Rq+GH6st8Phnvj5AXPkovgwy4Mw2fvYcK10tWae/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObALxsBqR0e0P8gavx56fWeZwRIHw5TAfwQfqCqiZaQ=;
 b=biBgesekysITnFA3xEMUAqcMUqiazJVvQwrT/Yq0sDhKI9ztnOR87mObph14homJP49b2bPo6oufMeRh24ZWL3H1i3IhHy90wJhptzNqmK1oA9ApG86ILt/iObcBSvgxRtKJDDvzJWmj6G4wb6v0Yw++4pt3iVSDhSIzt+YmO8WBoEcZrO0oRrkrpBvOoKGGobcv1YnWH5OlF7nZTQYSkyEc/HmzOzUm/BbV/VVybsE0ytTQdOhC0BT01jvquJ5ELi2ggexza4ntFRKh2ZuT8n+Ag+b0WB/ad0eiwHZDdndxz6QIrd0olXA1eX4f8tgf2nRFDpcOhF2heWtKHJnYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObALxsBqR0e0P8gavx56fWeZwRIHw5TAfwQfqCqiZaQ=;
 b=ZNUjccpBinlVLPN41+Pv3cwHT6P25ivFIrViE7u0s0AOqfBRuxus3TbDzfk8MFir3jHodUjOxWhtnPZVGMN/G8T3lZsmTw1x7p6ca6lSGMLpia2RQbT/38O4QyVvMPPq8voMU+cNnLFilyhBuOjvKOUK5I5FYU5wSF3PYRIH9Dk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Thu, 21 Nov 2019 10:13:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360%5]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 10:13:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Jacky Bai <ping.bai@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPA=
Date:   Thu, 21 Nov 2019 10:13:12 +0000
Message-ID: <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
In-Reply-To: <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 411b9836-fc2f-432e-e4c0-08d76e6b6b03
x-ms-traffictypediagnostic: DB3PR0402MB3771:|DB3PR0402MB3771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB37719BC6A339A5B3F6287DFFF54E0@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(102836004)(7736002)(6506007)(229853002)(6436002)(26005)(6246003)(71190400001)(71200400001)(81166006)(4326008)(25786009)(76116006)(3846002)(6116002)(66556008)(66446008)(305945005)(66476007)(316002)(44832011)(11346002)(446003)(186003)(55016002)(9686003)(66066001)(76176011)(54906003)(7696005)(99286004)(66946007)(256004)(81156014)(5024004)(8676002)(74316002)(64756008)(8936002)(478600001)(14454004)(52536014)(6916009)(86362001)(5660300002)(2906002)(14444005)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L396D8OAjcam6+yU13vPXzGxzlSV0UhPRhXbAI0wirL+vbiEukUdQjR/OrlMkzBnZEdDV+HrEcJb1gHZuIXjoWCMMf6kz55lVi5DtX/Y6cGs77BCB+2kTKHKrM8OoppUSzKXe/noHdP/km3o/M7BGdiMDbfjRgp55+vvX6+ABjb4SFEH1126W1i6aQPy+gljYct9i1mfpfW8vOooGIoolmspv0lQJTA5/X3oU2w9WUTlVUVsz1LNizmOoXW6DaMakedGUeXcELt+GMm63IotVQdyEPRCg1r4cX/o/ZaVRt8bU48GQAr4/WK2hj+o6iMUyfxEE4yvhMpHAfdHCndmf+UADBsMJ7Fv/DbtdcZy0nUbIAw+zLXKSpALm+hdUGM44mGSD19lg405xNgYaNMxq77VU5x0QVXxJx9t+w5T4DI+hWv9V6xk6t+14C2u93fn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b9836-fc2f-432e-e4c0-08d76e6b6b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 10:13:12.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHoOS27gqbFCU7MfWT+xa/LOkKUO8Vo4qs4er70qWg0yeKO/3F5UUECHsfsaxfNL017KvA9s8cI9LQ1rb3dZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIFZpcmVzaCBmb3IgeW91ciBxdWljayByZXNwb25zZS4NClRoZSBvdXRwdXQgb2YgY3B1
ZnJlcSBpbmZvIGFyZSBhcyBiZWxvdywgc29tZSBtb3JlIGluZm8gZm9yIHlvdSBhcmUsIG91ciBp
bnRlcm5hbCB0cmVlIGlzIGJhc2VkIG9uIHY1LjQtcmM3LA0KYW5kIHRoZSBDUFUgaG90cGx1ZyBo
YXMgbm8gaS5NWCBwbGF0Zm9ybSBjb2RlLCBzbyBmYXIgd2UgcmVwcm9kdWNlZCBpdCBvbiBpLk1Y
OFFYUCwgaS5NWDhRTSBhbmQgaS5NWDhNTi4NCldpdGggY3B1ZnJlcSBkaXNhYmxlZCwgbm8gaXNz
dWUgbWV0Lg0KSSBhbHNvIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZSB3aXRoIHY1LjQtcmM3LA0KV2ls
bCBjb250aW51ZSB0byBkZWJ1ZyBhbmQgbGV0IHlvdSBrbm93IGlmIGFueSBuZXcgZm91bmQuDQoN
Cj4gU3ViamVjdDogUmU6IEFib3V0IENQVSBob3QtcGx1ZyBzdHJlc3MgdGVzdCBmYWlsZWQgaW4g
Y3B1ZnJlcSBkcml2ZXINCj4gDQo+ICtSYWZhZWwgYW5kIFBNIGxpc3QuDQo+IA0KPiBQbGVhc2Ug
cHJvdmlkZSBvdXRwdXQgb2YgZm9sbG93aW5nIGZvciB5b3VyIHBsYXRmb3JtIHdoaWxlIEkgYW0g
aGF2aW5nIGEgbG9vaw0KPiBhdCB5b3VyIHByb2JsZW0uDQo+IA0KPiBncmVwIC4gL3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS8qLyoNCg0Kcm9vdEBpbXg4cXhwbWVrOn4jIGdyZXAgLiAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxLyovKg0KL3N5cy9kZXZpY2VzL3N5c3RlbS9j
cHUvY3B1ZnJlcS9vbmRlbWFuZC9pZ25vcmVfbmljZV9sb2FkOjANCi9zeXMvZGV2aWNlcy9zeXN0
ZW0vY3B1L2NwdWZyZXEvb25kZW1hbmQvaW9faXNfYnVzeTowDQovc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9jcHVmcmVxL29uZGVtYW5kL3Bvd2Vyc2F2ZV9iaWFzOjANCi9zeXMvZGV2aWNlcy9zeXN0
ZW0vY3B1L2NwdWZyZXEvb25kZW1hbmQvc2FtcGxpbmdfZG93bl9mYWN0b3I6MQ0KL3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9vbmRlbWFuZC9zYW1wbGluZ19yYXRlOjEwMDAwDQovc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL29uZGVtYW5kL3VwX3RocmVzaG9sZDo5NQ0KL3N5
cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kwL2FmZmVjdGVkX2NwdXM6MCAxIDIg
Mw0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kwL2NwdWluZm9fY3VyX2Zy
ZXE6OTAwMDAwDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvY3B1aW5m
b19tYXhfZnJlcToxMjAwMDAwDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGlj
eTAvY3B1aW5mb19taW5fZnJlcTo5MDAwMDANCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZy
ZXEvcG9saWN5MC9jcHVpbmZvX3RyYW5zaXRpb25fbGF0ZW5jeToxNTAwMDANCi9zeXMvZGV2aWNl
cy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9saWN5MC9yZWxhdGVkX2NwdXM6MCAxIDIgMw0KL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kwL3NjYWxpbmdfYXZhaWxhYmxlX2ZyZXF1
ZW5jaWVzOjkwMDAwMCAxMjAwMDAwDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3Bv
bGljeTAvc2NhbGluZ19hdmFpbGFibGVfZ292ZXJub3JzOm9uZGVtYW5kIHVzZXJzcGFjZSBwZXJm
b3JtYW5jZSBzY2hlZHV0aWwNCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9saWN5
MC9zY2FsaW5nX2N1cl9mcmVxOjkwMDAwMA0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJl
cS9wb2xpY3kwL3NjYWxpbmdfZHJpdmVyOmNwdWZyZXEtZHQNCi9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdWZyZXEvcG9saWN5MC9zY2FsaW5nX2dvdmVybm9yOm9uZGVtYW5kDQovc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvc2NhbGluZ19tYXhfZnJlcToxMjAwMDAwDQov
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvc2NhbGluZ19taW5fZnJlcTo5
MDAwMDANCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9saWN5MC9zY2FsaW5nX3Nl
dHNwZWVkOjx1bnN1cHBvcnRlZD4NCmdyZXA6IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZy
ZXEvcG9saWN5MC9zdGF0czogSXMgYSBkaXJlY3RvcnkNCg0KDQpDUFVIb3RwbHVnOiA0NTI0IHRp
bWVzIHJlbWFpbmluZw0KWyA1OTU0LjQ0MTgwM10gQ1BVMTogc2h1dGRvd24NClsgNTk1NC40NDQ1
MjldIHBzY2k6IENQVTEga2lsbGVkLg0KWyA1OTU0LjQ4MTczOV0gQ1BVMjogc2h1dGRvd24NClsg
NTk1NC40ODQ0ODRdIHBzY2k6IENQVTIga2lsbGVkLg0KWyA1OTU0LjUzMDUwOV0gQ1BVMzogc2h1
dGRvd24NClsgNTk1NC41MzMyNzBdIHBzY2k6IENQVTMga2lsbGVkLg0KWyA1OTU1LjU2MTk3OF0g
RGV0ZWN0ZWQgVklQVCBJLWNhY2hlIG9uIENQVTENClsgNTk1NS41NjIwMTVdIEdJQ3YzOiBDUFUx
OiBmb3VuZCByZWRpc3RyaWJ1dG9yIDEgcmVnaW9uIDA6MHgwMDAwMDAwMDUxYjIwMDAwDQpbIDU5
NTUuNTYyMDczXSBDUFUxOiBCb290ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDAwMDEg
WzB4NDEwZmQwNDJdDQpbIDU5NTUuNTk2OTIxXSBEZXRlY3RlZCBWSVBUIEktY2FjaGUgb24gQ1BV
Mg0KWyA1OTU1LjU5Njk1OV0gR0lDdjM6IENQVTI6IGZvdW5kIHJlZGlzdHJpYnV0b3IgMiByZWdp
b24gMDoweDAwMDAwMDAwNTFiNDAwMDANClsgNTk1NS41OTcwMThdIENQVTI6IEJvb3RlZCBzZWNv
bmRhcnkgcHJvY2Vzc29yIDB4MDAwMDAwMDAwMiBbMHg0MTBmZDA0Ml0NClsgNTk1NS42NDU4Nzhd
IERldGVjdGVkIFZJUFQgSS1jYWNoZSBvbiBDUFUzDQpbIDU5NTUuNjQ1OTIxXSBHSUN2MzogQ1BV
MzogZm91bmQgcmVkaXN0cmlidXRvciAzIHJlZ2lvbiAwOjB4MDAwMDAwMDA1MWI2MDAwMA0KWyA1
OTU1LjY0NTk4Nl0gQ1BVMzogQm9vdGVkIHNlY29uZGFyeSBwcm9jZXNzb3IgMHgwMDAwMDAwMDAz
IFsweDQxMGZkMDQyXQ0KQ1BVSG90cGx1ZzogNDUyMyB0aW1lcyByZW1haW5pbmcNClsgNTk1Ni43
Njk3OTBdIENQVTE6IHNodXRkb3duDQpbIDU5NTYuNzcyNTE4XSBwc2NpOiBDUFUxIGtpbGxlZC4N
ClsgNTk1Ni44MDk3NTJdIENQVTI6IHNodXRkb3duDQpbIDU5NTYuODEyNDgwXSBwc2NpOiBDUFUy
IGtpbGxlZC4NClsgNTk1Ni44NDk3NjldIENQVTM6IHNodXRkb3duDQpbIDU5NTYuODUyNDk0XSBw
c2NpOiBDUFUzIGtpbGxlZC4NClsgNTk1Ny44ODIwNDVdIERldGVjdGVkIFZJUFQgSS1jYWNoZSBv
biBDUFUxDQpbIDU5NTcuODgyMDg5XSBHSUN2MzogQ1BVMTogZm91bmQgcmVkaXN0cmlidXRvciAx
IHJlZ2lvbiAwOjB4MDAwMDAwMDA1MWIyMDAwMA0KWyA1OTU3Ljg4MjE1M10gQ1BVMTogQm9vdGVk
IHNlY29uZGFyeSBwcm9jZXNzb3IgMHgwMDAwMDAwMDAxIFsweDQxMGZkMDQyXQ0KDQoNCkxvb3Bp
bmcgaGVyZSwgbm8gaGFuZywgY2FuIHJlc3BvbnNlIHRvIGRlYnVnIGNvbnNvbGUuLi4uIGlmIGF0
dGFjaGluZyBKVEFHLCBJIGNhbiBzZWUgdGhlIENQVTENCldpbGwgYnVzeSB3YWl0aW5nIGZvciBp
cnFfd29yayB0byBiZSBmcmVlLi4NCg0KDQpBbnNvbg0K

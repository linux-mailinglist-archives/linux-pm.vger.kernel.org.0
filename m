Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F8D5938
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfJNBKS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 21:10:18 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:2855
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729359AbfJNBKR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Oct 2019 21:10:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHKAdcly/sgzIqkwyP8jVKUO7Ob5PsDIQuBxekmwbnbj3v4J5AYJqfBciNCfT7Mi8tNJqG+jWQg1vF0TZA2NY7yCJswQorLcWm77xqzY9xcH5UepEtC9LhymHSOkXUAUpxN8GqcWC82gGbqup+fMlmom904dNzCwG8klXU+ZdNSnOKJkem9YeDH4BZvaz7J/HNziWRF089bBZQK3/7x3r/EHq8h22rTCPd0XxUPjGQDfOnImF4fI8sSzyxrHP6rWeVs/L+uDXPR9+tkdE5NUjEM5ZXfHcgqWS9mkbqyCtF8hE51vMbEtodvgyYXyBbpE5uGjgoI2fD9NRtCI8VRqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRINY6/ZFvlxfckW4avObIN+Tre43nmTV/SpdCFl1wc=;
 b=nKe3VQOrKHr+QyxdMFB4B0pkld6OHa/CptVGOS6iYICHJ3HGHNZgRg/x8B9jKvIY/ZxDzQmcKcpvbb0gGDg2IFoC5+asQm9zmznmR7aQbH3As+0syqlsGvh3+GlQL/l2RgymHvjf/lJyCBlMEWtT6GDuiXgL2pOaIhV87ypZKFCbRbK8Rm4E6OX2mr7TUpCqTM7qoWT3gDCs7K9f/wGvj0slzkV0plMUsoDIOxyrTp3WArWCJSCduOP9RTVlCaigyj+d8UoI8mNZRDW5vF3m0j4zGFomjHVzKgqI7Aox8gSCqjRcnSR4vRkQ6efBA5vNEScyQ+aqR8eq1ZVlBWGAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRINY6/ZFvlxfckW4avObIN+Tre43nmTV/SpdCFl1wc=;
 b=KDQCkEcwuQAsc9I9jgSOUFQVHvIENOPbBqyb/pd9FB5yZgnfMtCCAjWLcLV3txtT5zi0HiioEn59mlab/U5HEwUMiep/hsivPC8+Z3Etli2BFp92Y+ZB+BQhfX8rFzyUJPu+iA+8dEn2g0PzrEOU/QtJgUYs4bOOq1H3WY+iALc=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5774.eurprd04.prod.outlook.com (20.178.127.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 01:10:10 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::6daf:7995:e6c0:dee6]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::6daf:7995:e6c0:dee6%7]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 01:10:10 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     Leo Li <leoyang.li@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3] thermal: qoriq: add thermal monitor unit
 version 2 support
Thread-Topic: [EXT] Re: [PATCH v3] thermal: qoriq: add thermal monitor unit
 version 2 support
Thread-Index: AQHVf9niNavc4TcFHEWIYsU/zLImLKdVgacAgAPWxMA=
Date:   Mon, 14 Oct 2019 01:10:09 +0000
Message-ID: <VI1PR04MB433321D01B6123684C0FB31CF3900@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20191011020534.334-1-andy.tang@nxp.com>
 <d981c4e8-9d80-aec2-b804-38435e256629@linaro.org>
In-Reply-To: <d981c4e8-9d80-aec2-b804-38435e256629@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dba8548-d2a8-4c5d-7048-08d750434251
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5774:|VI1PR04MB5774:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5774651CC913FDD30DE08193F3900@VI1PR04MB5774.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(13464003)(199004)(966005)(81166006)(81156014)(54906003)(6436002)(45080400002)(476003)(99286004)(446003)(478600001)(26005)(11346002)(486006)(74316002)(44832011)(7696005)(3846002)(6116002)(2501003)(8676002)(316002)(52536014)(66066001)(256004)(110136005)(2906002)(86362001)(76116006)(66946007)(33656002)(7736002)(71200400001)(71190400001)(229853002)(53546011)(2201001)(14454004)(5660300002)(305945005)(25786009)(76176011)(186003)(55016002)(8936002)(6636002)(9686003)(6246003)(6306002)(102836004)(6506007)(66476007)(66556008)(66446008)(64756008)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5774;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0xL9rhRDl1mb8C4SRKaGrtJehUYsidwUzMSTnxInbcFMF5E0UvUVsIM5y8d0jnubrzdF9atzPlYIo0FuieWHKtORjBGwBnxEJzZvcBCxd64pOUGzmE60lRGW7t0+TD4q8Eplq9Io/MjzQXVv+5Xzb53T1Gyo94J/1X31H2aJCbRACbH7paAOIPuwuLatqZsNeZaMeBRSBCwViMq8Nepmt0A+GcpI2JHQzKPfUs509FkZ3FNvu8ryETBg9yx4uPkpZUJxzQLyfK4ASCmnNDWc5AZ0oc1DdIz0Pq0pf6mZie6jByRgnlSCxveJUvPsO1xwPCL5NDCcYGLV+C2Rh0KME7BWsrfzW1xL5/8iPQu7a/0jkhKIMV4vl5Ph3wR1/UnP49LG/qNAAFu7Jf5yha1z6uB3or7UBRsxApZ3lZZAelWPIWdwzmVsVzZk9TpJCT2fh7XTq7JiCoBt5ssVmQDug==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba8548-d2a8-4c5d-7048-08d750434251
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 01:10:10.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cExsLVRxrVq2Shv3lq/w5UjMhANBW9oSfVnGgW+wcE+VDFPy1iTvp0w/USzyPASO6u9OnZIrlgy9s3XY+4fxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5774
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIERhbmllbCBmb3IgeW91ciBoZWxwLi4NCg0KQlIsDQpBbmR5DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMTnlubQxMOaciDEx5pelIDIyOjMyDQo+IFRvOiBBbmR5
IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgZWR1YmV6dmFsQGdtYWlsLmNvbTsNCj4gcnVpLnpo
YW5nQGludGVsLmNvbTsgQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENI
IHYzXSB0aGVybWFsOiBxb3JpcTogYWRkIHRoZXJtYWwgbW9uaXRvciB1bml0DQo+IHZlcnNpb24g
MiBzdXBwb3J0DQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDExLzEwLzIwMTkg
MDQ6MDUsIFl1YW50aWFuIFRhbmcgd3JvdGU6DQo+ID4gVGhlcm1hbCBNb25pdG9yIFVuaXQgdjIg
aXMgaW50cm9kdWNlZCBvbiBuZXcgTGF5c2NhcGUgU29DLg0KPiA+IENvbXBhcmVkIHRvIHYxLCBU
TVV2MiBoYXMgYSBsaXR0bGUgZGlmZmVyZW50IHJlZ2lzdGVyIGxheW91dCBhbmQNCj4gPiBkaWdp
dGFsIG91dHB1dCBpcyBmYWlybHkgbGluZWFyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXVh
bnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gSGkgWXVhbnRpYW4sDQo+IA0KPiBJJ3Zl
IGFwcGxpZWQgdGhlIHBhdGNoIHRvIHRoZSAndGVzdGluZycgYnJhbmNoIFsxXS4gSWYgZXZlcnl0
aGluZyBpcyBmaW5lLCBpdCBzaG91bGQNCj4gYmUgYXBwbGllZCB0byB0aGVybWFsL25leHQgYnJh
bmNoIGJ5IEVkdWFyZG8vUnVpLg0KPiANCj4gVGhhbmtzDQo+IA0KPiAgIC0tIERhbmllbA0KPiAN
Cj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXINCj4gbmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4
JTJGa2VybmVsJTJGZ2l0JTJGdGhlcm1hbCUyRmxpbnV4LmdpdCUyRmwNCj4gb2clMkYlM0ZoJTNE
dGVzdGluZyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQwbnhwLmNvbSU3Qw0KPiAxNTc0
NWE4YTQxMzM0Y2ZkZWUxMTA4ZDc0ZTU3ZDI1YiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVj
MzANCj4gMTYzNSU3QzAlN0MwJTdDNjM3MDY0MDExNDAyMTU4MDI3JmFtcDtzZGF0YT00UG03RENW
ZjlwU3pVTCUNCj4gMkJrUWcwNVRNcndGM1dpb2hJZHVPZWkyU2lxM0JNJTNEJmFtcDtyZXNlcnZl
ZD0wDQo+IA0KPiANCj4gLS0NCj4gDQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gbGluYXJvLm9yZyUyRiZh
bXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQwbnhwLmNvbSU3QzE1NzQ1YThhDQo+IDQxMzM0
Y2ZkZWUxMTA4ZDc0ZTU3ZDI1YiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdD
MA0KPiAlN0MwJTdDNjM3MDY0MDExNDAyMTY4MDI1JmFtcDtzZGF0YT01UFZFemVSSW0lMkZ3SHBw
Vm9VT3ZqSzkNCj4gS0k5NzdGQkpyWE9qT0hNU1ZtSWJRJTNEJmFtcDtyZXNlcnZlZD0wPiBMaW5h
cm8ub3JnIOKUgiBPcGVuIHNvdXJjZQ0KPiBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MNCj4gDQo+IEZv
bGxvdyBMaW5hcm86DQo+IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gZmFjZWJvb2suY29tJTJGcGFnZXMlMkZM
aW5hcm8mYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG54DQo+IHAuY29tJTdDMTU3NDVh
OGE0MTMzNGNmZGVlMTEwOGQ3NGU1N2QyNWIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyYw0KPiBkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzA2NDAxMTQwMjE2ODAyNSZhbXA7c2RhdGE9eCUyQjI5S3YN
Cj4gaEZIQ25GeiUyQkhnVVhsNUdrcVVKU0c2S3I4YmNYYXhaJTJCbVJVbnMlM0QmYW1wO3Jlc2Vy
dmVkPTA+DQo+IEZhY2Vib29rIHwNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGdHdpdHRlDQo+IHIuY29tJTJGJTIzISUy
RmxpbmFyb29yZyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQwbnhwLmNvbQ0KPiAlN0Mx
NTc0NWE4YTQxMzM0Y2ZkZWUxMTA4ZDc0ZTU3ZDI1YiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzUNCj4gYzMwMTYzNSU3QzAlN0MwJTdDNjM3MDY0MDExNDAyMTY4MDI1JmFtcDtzZGF0YT1wTmNl
SFBjZ2QzcjdubA0KPiBkQUd5b0tsWDBCNVFzWnFBVG4waUhaRE1LSiUyRnZZJTNEJmFtcDtyZXNl
cnZlZD0wPiBUd2l0dGVyIHwNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGbGluYXJv
LWJsb2clMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG54cC5jbw0KPiBtJTdDMTU3
NDVhOGE0MTMzNGNmZGVlMTEwOGQ3NGU1N2QyNWIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OQ0K
PiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzA2NDAxMTQwMjE2ODAyNSZhbXA7c2RhdGE9QVZka3pK
N3RFQWVIDQo+IDFvbEc2VktmVnY5Zm5nQ3dWeG41Uzc2THJTVUR3cmclM0QmYW1wO3Jlc2VydmVk
PTA+IEJsb2cNCg0K

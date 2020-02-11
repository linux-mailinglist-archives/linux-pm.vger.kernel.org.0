Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14C4158926
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 05:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBKEUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 23:20:18 -0500
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:31041
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbgBKEUR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Feb 2020 23:20:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLM3qDM7F8fdh+dxzQiD6UdfbTpY9okJEIsd42kC8v1E3XDLWMGeMF3VXG2EI2TSGLvy/54tA5wb/8Jbq3aUPUwPELDHj8QHrsVXI5rPE6m+PWxS7g79lJAsubIyqbs+ZJHo5WPtN+YAkSmyWoTQumDJMFDRBX8h7kZkdSzee3oXtL9y4yDgGNcyVfsvdI/fFl0VBo9dfV3MOW3C9GMLm6qBlgZ4ICFngtLrZa5/AFfY9zlu4GjbYDRe975UJoL+BmlBte11/aQBK9kwZLWM7CMMryKq8V41sTLY7lh1bYBnbrCPJtI/CSpEXmwcFaeZfSp4urR30mxbJrA+VY/c5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/carO9uuCEehySi4K74CpVG0F7cIrwbM5kGbbU2W8I=;
 b=N3GtuZP10DTXSlf0y8LpTGaPOJ95Ce0QjMCm95YOBkwySQiZsP3frIP6+4Vl9FVthvbbqLbZ9oz+twcqo5S+fBwksn6D6nKuInrAXHHC80Cl0O14m9cHCv1sgNOHgQaWjDaNI3A4VACRaTVSSLN+EF4m6sRblCPfoalOT/nq4iKiLkR46QTbJyiHapM4EplZmtb2rEir53OK7lUuOAd5hPTe8xkyveudSh1Oa08TwhnvtNFsJ/svoIOxBPtx8Ru6Q681eIJ2u8ADza+g500Lh8zPBCWuqAhOVMWfFDoYMWUhxF9bthqiWkzFGfPOBmo88pKkLwWW/0vG3omGvd/Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/carO9uuCEehySi4K74CpVG0F7cIrwbM5kGbbU2W8I=;
 b=eJkBZhbuDm2U/CSS1HIP5mdsv09BobCockfF5S8B+DLbgxvPRjDiJEdAseEuCx8wfcROzyFHPD5cj6UNCAMRCN7wT6FgZYDZvJdJlovTHquNkrHxMCk6z+l83EILEFQXfIksnEDXb64QDY3WTlUtPE9yjK+aVgEt9yaBfx8i5TM=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5261.eurprd04.prod.outlook.com (20.177.50.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 04:20:14 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 04:20:14 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9w
Date:   Tue, 11 Feb 2020 04:20:14 +0000
Message-ID: <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
In-Reply-To: <20200207070544.geurecsy4i22xpzl@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63464b9b-de42-4ea8-9bed-08d7aea9b151
x-ms-traffictypediagnostic: VI1PR04MB5261:
x-microsoft-antispam-prvs: <VI1PR04MB52617801ECBE78F9F34B6E7AF3180@VI1PR04MB5261.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(4326008)(71200400001)(186003)(26005)(54906003)(5660300002)(316002)(66556008)(66446008)(76116006)(66946007)(66476007)(64756008)(8936002)(53546011)(478600001)(6506007)(8676002)(81156014)(81166006)(9686003)(2906002)(33656002)(6916009)(55016002)(86362001)(44832011)(7696005)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5261;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yqUZ7YmnooJV6MR3iZl8QattdOUORJVWHHVBXrqCzQvRFRn2JxmZ3obq7QmrHoOOmUB+eLVdVW9r2LHW5hVwjoZ35oyLgf0rIk6BFcSYwRodq0CXABa12+0ysHhcRcjjoqFXQ7hg+CpQN9PJBEKZPdW+YXg51rXi9A0X6epQcikeMKeQMw02FdanHx2rPXsKLEhy0BgkXGY69jN2vLNRmAr02mhaZTQDMbRixLCt/ZS3ivoecr6FVr114gNl41mtlSk5EJWl0T/jLpp3Zhe5Sz4+x69+PpYvZgL4z/B7zeQqZxXlyMkk+3Q9zK3B54CgI1TfE3amdB63YRTZ9Pes0pjU+Au3z2pbOzp4GaddJP+LnMOzrUeunz5HSy033sMMaORf29whn2eLDAs9iuRgUQgummmpNia57JP117U77X3EYq6tG1GGDPjwGEQZgurg
x-ms-exchange-antispam-messagedata: ELKT8Q1OYsDa0L/MnmB2yBwsgIH4Cg8e2IJO32oydwczNMWVMKptwg0JfdWsOITcseP/tp/IHWFBcaUksOAZONXmXVxFpwKKUBVxvtd+H/pbc+xFL+Pco8NCj1YkIPPhGx+R/6cPAvWzOXNuiUoODg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63464b9b-de42-4ea8-9bed-08d7aea9b151
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 04:20:14.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2k4wGNd3E03SFXJtty/pdO3KtPf48LSJPjfx3hUa0EQOFqRmbIFBNYFwUyi7yXl5c60Ov7GOI09iIjOCBag0OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5261
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoLA0KDQpJIGNoZWNrZWQgdGhlIGNsayBwYXJ0LCBubyBpc3N1ZSB3YXMgZm91bmQu
DQpJIGRpZCBmb3VuZCBhIG9kZCB0aGluZyBpbiBjcHVmcmVxIGRpcmVjdG9yeS4NCg0KIyBjYXQg
c2NhbGluZ19hdmFpbGFibGVfZnJlcXVlbmNpZXMNCjE2MDAwMDAgMTAwMDAwMCA4MDAwMDAgNTAw
MDAwDQojIGNhdCBzY2FsaW5nX21heF9mcmVxDQo1MDAwMDANCg0KV2h5IHRoZXJlIGlzIGEgMTYw
ME1oeiBmcmVxdWVuY3kgYXZhaWxhYmxlLCBidXQgdGhlIG1heCBmcmVxIGlzIG9ubHkgNTAwTT8N
CkhvdyB0aGUgbWF4IGZyZXEgaXMgc2V0Pw0KDQpUaGFua3MsDQpBbmR5DQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc+DQo+IFNlbnQ6IDIwMjDE6jLUwjfI1SAxNTowNg0KPiBUbzogQW5keSBUYW5nIDxhbmR5
LnRhbmdAbnhwLmNvbT4NCj4gQ2M6IHJqd0Byand5c29ja2kubmV0OyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBBc2sgZm9yIGhlbHAgYWJvdXQgY3B1
ZnJlcSBpc3N1ZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAwNy0wMi0yMCwg
MDY6MDMsIEFuZHkgVGFuZyB3cm90ZToNCj4gPiBIaSBWaXJlc2gsDQo+ID4NCj4gPiBJIGhhdmUg
dHJpZWQgcGVyZm9ybWFuY2UgZ292ZXJub3IsIGNwdSBmcmVxdWVuY3kgaXMgYXQgdGhlIGxvd2Vz
dA0KPiBmcmVxdWVuY3kuDQo+ID4gSSBhbHNvIHRyaWVkIG9uZGVtYW5kIGdvdmVybm9yIHdpdGgg
aGlnaCBjcHUgbG9hZCwgY3B1IGZyZXF1ZW5jeSBkb2Vzbid0DQo+IGluY3JlYXNlIHRvby4NCj4g
Pg0KPiA+IHJvb3RAbG9jYWxob3N0On4jIGNhdA0KPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1
L2NwdTAvY3B1ZnJlcS9zY2FsaW5nX2dvdmVybm9yDQo+ID4gcGVyZm9ybWFuY2UNCj4gPiByb290
QGxvY2FsaG9zdDp+IyBjYXQNCj4gPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWZy
ZXEvc2NhbGluZ19hdmFpbGFibGVfZnJlcXVlbmNpZXMNCj4gPiAxNjAwMDAwIDEwMDAwMDAgODAw
MDAwIDUwMDAwMA0KPiA+IHJvb3RAbG9jYWxob3N0On4jDQo+ID4gcm9vdEBsb2NhbGhvc3Q6fiMg
Y2F0DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVmcmVxL3NjYWxpbmdfY3Vy
X2ZyZXENCj4gPiA1MDAwMDANCj4gPg0KPiA+IHJvb3RAbG9jYWxob3N0On4jIGNhdCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvc3RhdHMvKg0KPiA+IGNhdDogL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kwL3N0YXRzL3Jlc2V0OiBQZXJtaXNzaW9u
DQo+ID4gZGVuaWVkDQo+ID4gMTYwMDAwMCAyMTQNCj4gPiAxMDAwMDAwIDkxDQo+ID4gODAwMDAw
IDgyDQo+ID4gNTAwMDAwIDQ4MDA4OA0KPiA+IDI0MA0KPiA+ICAgIEZyb20gIDogICAgVG8NCj4g
PiAgICAgICAgICA6ICAgMTYwMDAwMCAgIDEwMDAwMDAgICAgODAwMDAwICAgIDUwMDAwMA0KPiA+
ICAgMTYwMDAwMDogICAgICAgICAwICAgICAgICAxNSAgICAgICAgMTAgICAgICAgIDEwDQo+ID4g
ICAxMDAwMDAwOiAgICAgICAgMjEgICAgICAgICAwICAgICAgICAyMiAgICAgICAgMTgNCj4gPiAg
ICA4MDAwMDA6ICAgICAgICAgNiAgICAgICAgMjMgICAgICAgICAwICAgICAgICA0NA0KPiA+ICAg
IDUwMDAwMDogICAgICAgICA3ICAgICAgICAyMyAgICAgICAgNDEgICAgICAgICAwDQo+IA0KPiBT
ZWUsIGZyZXF1ZW5jaWVzIGFyZSBnZXR0aW5nIGNoYW5nZWQgYWNjb3JkaW5nIHRvIHRoaXMgdGFi
bGUgKGF0IGxlYXN0IGZyb20NCj4gY3B1ZnJlcSdzIHBvaW50IG9mIHZpZXcpLCB3aGljaCBtZWFu
cyB0aGF0IGNwdWZyZXEgdHJhbnNpdGlvbnMgYXJlIHBhc3NpbmcNCj4ganVzdCBmaW5lLg0KPiAN
Cj4gSSBqdXN0IGhhZCBhIGxvb2sgYXQgdGhlIGRyaXZlciBhbmQgbWF5IGhhdmUgc29tZSBpZGVh
IG9uIHdoYXQncyBnb2luZyBvbi4NCj4gVGhlIGNwdWZyZXEgZHJpdmVyIGRvZXNuJ3QgcHJvZ3Jh
bSB0aGUgZnJlcXVlbmNpZXMsIGJ1dCBpbnN0ZWFkIGl0IGp1c3QNCj4gc3dpdGNoZXMgdGhlIHBh
cmVudCBjbGsgZm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kuIEFuZCB3aGVuIHlvdSB0cnkgdG8g
cmVhZA0KPiB0aGUgZnJlcXVlbmN5LCBhbGwgd2UgZG8gaXMgcmVhZCB0aGUgZnJlcXVlbmN5IGZy
b20gdGhlIGNsayBwb2ludGVyIHVzaW5nDQo+IGNsa19nZXRfcmF0ZSgpLg0KPiANCj4gU28sIGhl
cmUgYXJlIHRoZSB0aGluZ3Mgd2hpY2ggY2FuIGdvIHdyb25nLCBpbiBvcmRlciBvZiBob3cgSSB3
b3VsZCBsaWtlIHRvDQo+IGRlYnVnIHRoZW0uDQo+IA0KPiAtIFRoZSBmcmVxdWVuY3kgb2YgYWxs
IHBhcmVudCBjbG9ja3MgaXMgc2V0IHRvIDUwMCBNSHogYnkgc29tZW9uZSBhbmQNCj4gICBzbyBj
bGtfZ2V0X3JhdGUoKSBhbHdheXMgcmVwb3J0IHRoYXQgZGVzcGl0ZSBjaGFuZ2VzIHRvIHRoZSBz
dGF0cw0KPiAgIHRhYmxlLg0KPiANCj4gLSBjbGtfc2V0X3BhcmVudCgpIGlzbid0IHNldHRpbmcg
dGhlIHBhcmVudCBjb3JyZWN0bHkuDQo+IA0KPiBUcnkgcHV0dGluZyBzb21lIHByaW50IG1lc3Nh
Z2VzIHRvIHRoZSBkcml2ZXIgdG8gc2VlIGlmIHRhcmdldF9pbmRleCgpIHJvdXRpbmUNCj4gaXMg
YWJsZSB0byBzZXQgdGhlIHBhcmVudCBjbGsgcHJvcGVybHkgb3Igbm90Lg0KPiANCj4gLS0NCj4g
dmlyZXNoDQo=

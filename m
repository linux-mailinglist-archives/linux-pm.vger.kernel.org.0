Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276FF15523F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 07:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgBGGDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 01:03:17 -0500
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:16488
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbgBGGDR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Feb 2020 01:03:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXX50hC/lPZsdNMsmYz1uXlHWkSLFwrCKqxWIedkENwHX7woamtmwzr5pcDIqEbOnbviYmWreiRy+M429SWHFK90v469aJY4yKIWHWcLr0Eav20+wHASY2RcKx4jSC2WdAOSM+skKoXrjgD/YYB1ZQbK9ndNp00/S0J7lCPCkU5qs2lukutvozOkpqFLRa8RawXanv6BKNXKwbkeXeG93WpRYCwZTLomSknRzbXS8EhpY/PHxn3mRsNb1e7/jYc62rDqrEXGfzuuBhVoewZDaJiAMFhc95vYK8QMnGVJfjLRrkBElZQvdQHsaJdm5WsY1ypQIafbF6pcDOiGL0UNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdE0sfwdVzko5yqBJb9BK/klNDe9KDzULUBVbeLjdQ=;
 b=M1VMSwHv+y+xB0ixfVjEnKFibcS/TyDHU63URQFE32KUp7MaN84mfUZMxE5Dr5Rlh163WLdpUgjMyMVFzOBR94GP22fNgul2ODgHqj2lqeveU+FcyslP0NsFJs3lrKBeK7VSHcgUTCO0Z+cLS1T4tFOwb4Y1qNFoDnU0euezZ4Bug0sMVZwT+tnRe6IYfgiqbYaCZ7K1csu/nvmKuGBDwMvV3ZMtg4lOj2ECVmz7Gdhh9Jsw88F8K2mbPsXMeRBBxrkcV4dG9kBCH9V5/IcdiWX23uHRpUOC4GfV8AKHmD2g9Va8Wi78uaAjCkngLYcRycNYwnrOWKpXSds+D4oDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdE0sfwdVzko5yqBJb9BK/klNDe9KDzULUBVbeLjdQ=;
 b=p73CyyOV1aZLFyy4imt172fIbOjVm7A65kQu2GPIQfbrKrPqU+zHS4hrBW30fGMtjhCiSZOw8Y7dhCTAzen/YbkJnHW8DFQklxE4sQ/GdbwaZRicl62czFE13CKQWZhv0/Zx3PEecoQYooZmUQZjkjZmwPzErgPatik0kKjr5jg=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5789.eurprd04.prod.outlook.com (20.178.126.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 06:03:13 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 06:03:12 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEA=
Date:   Fri, 7 Feb 2020 06:03:12 +0000
Message-ID: <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
In-Reply-To: <20200207052321.povhuxrlm25ueoak@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4337e13-a67d-4bab-0d88-08d7ab936a4e
x-ms-traffictypediagnostic: VI1PR04MB5789:
x-microsoft-antispam-prvs: <VI1PR04MB57892F84C337A088014109BCF31C0@VI1PR04MB5789.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(55016002)(4326008)(33656002)(478600001)(53546011)(44832011)(6506007)(86362001)(7696005)(71200400001)(9686003)(6916009)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(186003)(8936002)(26005)(54906003)(52536014)(8676002)(81166006)(81156014)(5660300002)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5789;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgKaCrctF4rQIAU3LRhEP6tU6RZvesXh0V8T1U2zAbw/tPdB4xwAU/TxvOZ2gLnJXngHFqJ+iuJbo4ctgSZBbEq+Yw6kFfWgOGKJkvN+GT9w0MxyuvYLGMLATnQsQs7rZEDkCBtSmR0Ir0EvIE8cDF8v1hoZ519NX7nRXvL3wXHPM0A0gjlS2lanEdI7Sl3pcRTFfNS/NKXeKyeNjTtwwIQfDABaXdx0ADZuvfAcSl8ykUt30wKERDUdHYiVVUDXIzNOm5ILKIrad/+op+4pBi7Ch1RMMGBgGbBtes6lL3BtR2a+cAUFqjUh6y9j/9TK7pQxoll72ZvR4z/HM1Lv3itX6FKGDKyowXr5MhuPMe16kcLQw4JNXGY+kI/USFIwB8x+iZR/wbzihEgwjY0CFjZorRQAMwY179TyOdMVDXgav5AWgCz2osazdPfELned
x-ms-exchange-antispam-messagedata: 0kKZ7rKgRoGlg3UsUOQH2+iHTcldlxnjDkzhwFQnpK6yIarvbTqMceRmK/w71IwNZMoUh3oZBe80T8IDTSzZ8axomd/nPxx4TBt1UhOnzgf1fH5SPnh6FLZ+VyGzNze48eAhH2PI03w5g8q+oWuuUQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4337e13-a67d-4bab-0d88-08d7ab936a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 06:03:12.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Uihm6uPfy9q+6QIo+qTinfOig1LULh+EX6rraA/Alt+AwL1zy32o0EHAux8NR66jJ2anlMRRYYtr7voC2RQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5789
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoLA0KDQpJIGhhdmUgdHJpZWQgcGVyZm9ybWFuY2UgZ292ZXJub3IsIGNwdSBmcmVx
dWVuY3kgaXMgYXQgdGhlIGxvd2VzdCBmcmVxdWVuY3kuDQpJIGFsc28gdHJpZWQgb25kZW1hbmQg
Z292ZXJub3Igd2l0aCBoaWdoIGNwdSBsb2FkLCBjcHUgZnJlcXVlbmN5IGRvZXNuJ3QgaW5jcmVh
c2UgdG9vLg0KDQpyb290QGxvY2FsaG9zdDp+IyBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUv
Y3B1MC9jcHVmcmVxL3NjYWxpbmdfZ292ZXJub3INCnBlcmZvcm1hbmNlDQpyb290QGxvY2FsaG9z
dDp+IyBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVmcmVxL3NjYWxpbmdfYXZh
aWxhYmxlX2ZyZXF1ZW5jaWVzDQoxNjAwMDAwIDEwMDAwMDAgODAwMDAwIDUwMDAwMA0Kcm9vdEBs
b2NhbGhvc3Q6fiMNCnJvb3RAbG9jYWxob3N0On4jIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2Nw
dS9jcHUwL2NwdWZyZXEvc2NhbGluZ19jdXJfZnJlcQ0KNTAwMDAwDQoNCnJvb3RAbG9jYWxob3N0
On4jIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvc3RhdHMvKg0K
Y2F0OiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvc3RhdHMvcmVzZXQ6
IFBlcm1pc3Npb24gZGVuaWVkDQoxNjAwMDAwIDIxNA0KMTAwMDAwMCA5MQ0KODAwMDAwIDgyDQo1
MDAwMDAgNDgwMDg4DQoyNDANCiAgIEZyb20gIDogICAgVG8NCiAgICAgICAgIDogICAxNjAwMDAw
ICAgMTAwMDAwMCAgICA4MDAwMDAgICAgNTAwMDAwDQogIDE2MDAwMDA6ICAgICAgICAgMCAgICAg
ICAgMTUgICAgICAgIDEwICAgICAgICAxMA0KICAxMDAwMDAwOiAgICAgICAgMjEgICAgICAgICAw
ICAgICAgICAyMiAgICAgICAgMTgNCiAgIDgwMDAwMDogICAgICAgICA2ICAgICAgICAyMyAgICAg
ICAgIDAgICAgICAgIDQ0DQogICA1MDAwMDA6ICAgICAgICAgNyAgICAgICAgMjMgICAgICAgIDQx
ICAgICAgICAgMA0KQlIsDQpBbmR5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gU2VudDogMjAy
MMTqMtTCN8jVIDEzOjIzDQo+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBD
Yzogcmp3QHJqd3lzb2NraS5uZXQ7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogQXNrIGZvciBoZWxwIGFib3V0IGNwdWZyZXEgaXNzdWUNCj4gDQo+IENhdXRp
b246IEVYVCBFbWFpbA0KPiANCj4gT24gMDctMDItMjAsIDA1OjA5LCBBbmR5IFRhbmcgd3JvdGU6
DQo+ID4gSGkgVmlyZXNoLA0KPiA+DQo+ID4gQ3B1ZnJlcSBmYWlsZWQgdG8gd29yayBvbiBvdXIg
Ym9hcmQuIENQVSBmcmVxdWVuY3kga2VlcHMgYXQgdGhlIGxvd2VzdA0KPiBmcmVxdWVuY3kgd2hh
dGV2ZXIgZ292ZXJub3IgSSBjaG9vc2UuDQo+IA0KPiBIYXZlIHlvdSB0cmllZCBwZXJmb3JtYW5j
ZSBnb3Zlcm5vciA/IEZyZXEgc2hvdWxkIG1vdmUgdG8gaGlnaGVzdCBmcmVxDQo+IHRoZXJlIGZv
ciBzdXJlLg0KPiANCj4gSG93IGRvIHlvdSBjaGVjayB0aGUgZnJlcXVlbmN5ID8gV2l0aG91dCBz
aWduaWZpY2FudCBsb2FkIHlvdSB3b24ndCBzZWUgdGhlDQo+IGZyZXEgbW92ZW1lbnQuDQo+IA0K
PiBBbHNvIGhhdmUgYSBsb29rIGF0IHRoZSBwb2xpY3kwL3N0YXRzLyBkaXJlY3RvcnkuIEl0IHdp
bGwgc2hvdyB0aGUgZGV0YWlscyBvZiBmcmVxDQo+IHN3aXRjaGluZyBwcm9wZXJseSwgaW5jbHVk
ZSB0aGUgdHJhbnNpdGlvbnMgdGhhdCBoYXZlIGhhcHBlbmVkLg0KPiANCj4gPiBIYXJkd2FyZSBw
bGF0Zm9ybTogbHMxMDQzYXJkYiBib2FyZCAoNCBjb3JlcyBhcm02NCBhcmNoKQ0KPiA+IFNvZnR3
YXJlOiBsaW51eCBrZXJuZWwgdjUuNC4zICsgdWJ1bnR1IDE4MDQuDQo+ID4NCj4gPiBUZXN0IGxv
ZzoNCj4gPiByb290QGxvY2FsaG9zdDp+IyBlY2hvIHBlcmZvcm1hbmNlID4NCj4gPiAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWZyZXEvc2NhbGluZ19nb3Zlcm5vcg0KPiA+IHJvb3RA
bG9jYWxob3N0On4jIGNhdA0KPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1ZnJl
cS9zY2FsaW5nX2N1cl9mcmVxDQo+ID4gNTAwMDAwDQo+ID4gcm9vdEBsb2NhbGhvc3Q6fiMgY2F0
DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVmcmVxL3NjYWxpbmdfYXZhaWxh
YmxlX2ZyZXF1ZW5jaWVzDQo+ID4gMTYwMDAwMCAxMDAwMDAwIDgwMDAwMCA1MDAwMDANCj4gPg0K
PiA+IEFsbCB0aGUgcGFyYW1ldGVycyB5b3UgbWF5IG5lZWQ6DQo+ID4gcm9vdEBsb2NhbGhvc3Q6
fiMgZm9yIGVudHJ5IGluIGBscw0KPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEv
cG9saWN5MC9gIDsgZG8gZWNobyAkZW50cnk7ICBjYXQNCj4gPiAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9jcHVmcmVxL3BvbGljeTAvJGVudHJ5OyBkb25lIGFmZmVjdGVkX2NwdXMNCj4gPiAwIDEg
MiAzDQo+ID4gY3B1aW5mb19jdXJfZnJlcQ0KPiA+IDUwMDAwMA0KPiA+IGNwdWluZm9fbWF4X2Zy
ZXENCj4gPiAxNjAwMDAwDQo+ID4gY3B1aW5mb19taW5fZnJlcQ0KPiA+IDUwMDAwMA0KPiA+IGNw
dWluZm9fdHJhbnNpdGlvbl9sYXRlbmN5DQo+ID4gMzENCj4gPiByZWxhdGVkX2NwdXMNCj4gPiAw
IDEgMiAzDQo+ID4gc2NhbGluZ19hdmFpbGFibGVfZnJlcXVlbmNpZXMNCj4gPiAxNjAwMDAwIDEw
MDAwMDAgODAwMDAwIDUwMDAwMA0KPiA+IHNjYWxpbmdfYXZhaWxhYmxlX2dvdmVybm9ycw0KPiA+
IHVzZXJzcGFjZSBvbmRlbWFuZCBwZXJmb3JtYW5jZSBzY2hlZHV0aWwgc2NhbGluZ19jdXJfZnJl
cQ0KPiA+IDUwMDAwMA0KPiA+IHNjYWxpbmdfZHJpdmVyDQo+ID4gcW9yaXFfY3B1ZnJlcQ0KPiA+
IHNjYWxpbmdfZ292ZXJub3INCj4gPiBwZXJmb3JtYW5jZQ0KPiA+IHNjYWxpbmdfbWF4X2ZyZXEN
Cj4gPiA1MDAwMDANCj4gPiBzY2FsaW5nX21pbl9mcmVxDQo+ID4gNTAwMDAwDQo+ID4gc2NhbGlu
Z19zZXRzcGVlZA0KPiA+IDx1bnN1cHBvcnRlZD4NCj4gPiBzdGF0cw0KPiA+IGNhdDogL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kwL3N0YXRzOiBJcyBhIGRpcmVjdG9yeQ0K
PiA+DQo+ID4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGluc3RydWN0IG1lIGhvdyB0byBpbnZlc3Rp
Z2F0ZSB0aGlzIGlzc3VlPw0KPiA+DQo+ID4gQlIsDQo+ID4gQW5keQ0KPiANCj4gLS0NCj4gdmly
ZXNoDQo=

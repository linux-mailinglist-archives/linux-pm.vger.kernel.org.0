Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F109E465A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393196AbfJYIzz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 04:55:55 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:23901
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393107AbfJYIzz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 04:55:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVk8rMp2DISFb1gZ046vxKA+YcoErIHpRYcXW5J4Vj18ZCkDbfocuMG1/bb8xV85hIHmLKkAE2IBkKKg6IJTpru1yoVSbg1h69UoVqLoYJ53BxTf3l1TDhTURFF6DNaFgEnT1n5ABWUHbJaGIGZQ2YJHNRJI69i4HFCs/uIZLWSia0vDJWAM97Aaxk+FSEb7wUhWD/Ho3kXbEsaty7UrV1JjIbzgnzcrf5p0ij6UDKH6HQEz5Cdn9n7tlxNaiTuWvL6paF4xFDqt0iy8/8oXc23s5Iu++3xz0CZZlbGV34WSR7UGMjvUPXa3HjTUKzZa3QncoSO4MvNPIyfl56bnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbQ7dfnH2ENhgioxdkxbFcH59N7g3WaOBKQcTNfC4KI=;
 b=GWZkmi5UrBtBfmbRD7S26IjoEdz+jZLpannrhOyntF3xOuKqlPui7BoWd+UHsJAwzDD9CW6Z1E9/U8WCbjq92KutCjPDLxH30mfS94UKknhsqxvvnP7VAb7tm7mHADGBn9CyX6svJr0LclTPExEq5P+kXnCT3tQgqRVzO7xM0Cj86NMJLc2mAK1eUgMlj4Ug588uRZ9rqgQEWp2veFUrDSixF7g+PlVI5CRkPDhCrToBqzyiYnng3pOD1GD5yjYYExVCoaSj8L/3POSBBnmT/UShTdZt2/8R6PiuXnmXen6F1FNUGnW4kqliEZcEhzxHfvrqmDrwlp/gEtc990vXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbQ7dfnH2ENhgioxdkxbFcH59N7g3WaOBKQcTNfC4KI=;
 b=oMmS0h04VubK5h/DqNeEBc6mO6us9MENj7K6HumO36AlKOn00D1r/KASeDs6j+oi8qc+CIvYOnaG80c8dcjFEO4C965F57cpUBcvmPKiFH0YWdyOI8QhpXcXAHMdJS1MleZTJv84Vg7U/XFj02oGSZfVfFBNU4o4ZqfvulwrjK0=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.50.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 08:55:51 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::6daf:7995:e6c0:dee6]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::6daf:7995:e6c0:dee6%7]) with mapi id 15.20.2347.030; Fri, 25 Oct 2019
 08:55:50 +0000
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
Thread-Index: AQHVf9niNavc4TcFHEWIYsU/zLImLKdVgacAgBWiRXA=
Date:   Fri, 25 Oct 2019 08:55:50 +0000
Message-ID: <VI1PR04MB433343FC044316EE12F9678DF3650@VI1PR04MB4333.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54c82a1e-2428-4bb4-35b5-08d7592922d8
x-ms-traffictypediagnostic: VI1PR04MB4718:|VI1PR04MB4718:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB47183F086C22833E6B1A4344F3650@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(13464003)(6636002)(316002)(76176011)(66446008)(25786009)(305945005)(66476007)(66556008)(64756008)(26005)(14454004)(66946007)(6246003)(66066001)(229853002)(5660300002)(76116006)(110136005)(6506007)(53546011)(6436002)(966005)(102836004)(186003)(7696005)(52536014)(86362001)(2201001)(99286004)(54906003)(8936002)(33656002)(256004)(2501003)(71190400001)(71200400001)(4326008)(3846002)(2906002)(74316002)(486006)(44832011)(45080400002)(446003)(478600001)(476003)(6306002)(9686003)(55016002)(11346002)(81166006)(8676002)(81156014)(6116002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4718;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4K7wIczJvSUCNoGm81eyUmaNuntgZdEQ7C9zakFUubLQSn5z6ui7Ywx2bYOUFwBRbMVwRw/UdUi20YIBw+oVVMk/aiY47U/WaMlP6wAqE02WjLUt3daoVV/bu/ZG0x4fAxUBBYGvzCDu+vwzCdBESxzJX0RCE3gFnhdYcicWSjk2QfK6t8ZSv1m+YcCjsTrm2M+EAJ++elBpHwOovevEtYl1al1D0CUTeGz/G67Ui0A20OJKUCgnUIHbLSpXJ+fyyGdw6CVUFkv33de//J1HSxb7IO6pcJjX69nwgSNeIcy3xZhGGk5x7+q01QBL7F9XTdRxzDTFZBbjJunphJO2lwx9dFvthCSoSWpxE+9+/G/5kCAGzlfiraHbErgZu1I6wgszXx6QzbhOZzW3tXbypAKAiTi2i5o3UiV+I94/GyacUdary+f96tCmdS4EcMTh0Xkxe5HKfWURbw0zAiQ4XGlmaL+J3rxUBCPc//OyA0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c82a1e-2428-4bb4-35b5-08d7592922d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 08:55:50.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgzMF7008W1sNGsQ6tw7oF0tXoyxbCtcfh2bwlMYpOII5LOneo2CbjMHSD8Aahwyixk12nhorT7JFO2NHgEyRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMTnlubQxMOaciDEx5pel
IDIyOjMyDQo+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgZWR1YmV6dmFsQGdt
YWlsLmNvbTsNCj4gcnVpLnpoYW5nQGludGVsLmNvbTsgQW5zb24gSHVhbmcgPGFuc29uLmh1YW5n
QG54cC5jb20+DQo+IENjOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHYzXSB0aGVybWFsOiBxb3JpcTogYWRkIHRoZXJtYWwgbW9uaXRv
ciB1bml0DQo+IHZlcnNpb24gMiBzdXBwb3J0DQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4g
DQo+IE9uIDExLzEwLzIwMTkgMDQ6MDUsIFl1YW50aWFuIFRhbmcgd3JvdGU6DQo+ID4gVGhlcm1h
bCBNb25pdG9yIFVuaXQgdjIgaXMgaW50cm9kdWNlZCBvbiBuZXcgTGF5c2NhcGUgU29DLg0KPiA+
IENvbXBhcmVkIHRvIHYxLCBUTVV2MiBoYXMgYSBsaXR0bGUgZGlmZmVyZW50IHJlZ2lzdGVyIGxh
eW91dCBhbmQNCj4gPiBkaWdpdGFsIG91dHB1dCBpcyBmYWlybHkgbGluZWFyLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gSGkgWXVh
bnRpYW4sDQo+IA0KPiBJJ3ZlIGFwcGxpZWQgdGhlIHBhdGNoIHRvIHRoZSAndGVzdGluZycgYnJh
bmNoIFsxXS4gSWYgZXZlcnl0aGluZyBpcyBmaW5lLCBpdCBzaG91bGQNCj4gYmUgYXBwbGllZCB0
byB0aGVybWFsL25leHQgYnJhbmNoIGJ5IEVkdWFyZG8vUnVpLg0KSSBoYXZlIG5vdCBzZWVuIHRo
ZSBwYXRjaCBhcHBsaWVkLg0KTWF5IEkga25vdyBpZiB0aGlzIHBhdGNoIGhhcyBiZWVuIGFwcGxp
ZWQ/DQoNCkJSLA0KQW5keQ0KDQo+IA0KPiBUaGFua3MNCj4gDQo+ICAgLS0gRGFuaWVsDQo+IA0K
PiBbMV0NCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcg0KPiBuZWwub3JnJTJGcHViJTJGc2NtJTJGbGludXgl
MkZrZXJuZWwlMkZnaXQlMkZ0aGVybWFsJTJGbGludXguZ2l0JTJGbA0KPiBvZyUyRiUzRmglM0R0
ZXN0aW5nJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmclNDBueHAuY29tJTdDDQo+IDE1NzQ1
YThhNDEzMzRjZmRlZTExMDhkNzRlNTdkMjViJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MA0KPiAxNjM1JTdDMCU3QzAlN0M2MzcwNjQwMTE0MDIxNTgwMjcmYW1wO3NkYXRhPTRQbTdEQ1Zm
OXBTelVMJQ0KPiAyQmtRZzA1VE1yd0YzV2lvaElkdU9laTJTaXEzQk0lM0QmYW1wO3Jlc2VydmVk
PTANCj4gDQo+IA0KPiAtLQ0KPiANCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBsaW5hcm8ub3JnJTJGJmFt
cDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmclNDBueHAuY29tJTdDMTU3NDVhOGENCj4gNDEzMzRj
ZmRlZTExMDhkNzRlNTdkMjViJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
DQo+ICU3QzAlN0M2MzcwNjQwMTE0MDIxNjgwMjUmYW1wO3NkYXRhPTVQVkV6ZVJJbSUyRndIcHBW
b1VPdmpLOQ0KPiBLSTk3N0ZCSnJYT2pPSE1TVm1JYlElM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlDQo+IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9s
bG93IExpbmFybzoNCj4gPGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBmYWNlYm9vay5jb20lMkZwYWdlcyUyRkxp
bmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQwbngNCj4gcC5jb20lN0MxNTc0NWE4
YTQxMzM0Y2ZkZWUxMTA4ZDc0ZTU3ZDI1YiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjDQo+IGQ5OWM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM3MDY0MDExNDAyMTY4MDI1JmFtcDtzZGF0YT14JTJCMjlLdg0K
PiBoRkhDbkZ6JTJCSGdVWGw1R2txVUpTRzZLcjhiY1hheFolMkJtUlVucyUzRCZhbXA7cmVzZXJ2
ZWQ9MD4NCj4gRmFjZWJvb2sgfA0KPiA8aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ0d2l0dGUNCj4gci5jb20lMkYlMjMhJTJG
bGluYXJvb3JnJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmclNDBueHAuY29tDQo+ICU3QzE1
NzQ1YThhNDEzMzRjZmRlZTExMDhkNzRlNTdkMjViJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NQ0KPiBjMzAxNjM1JTdDMCU3QzAlN0M2MzcwNjQwMTE0MDIxNjgwMjUmYW1wO3NkYXRhPXBOY2VI
UGNnZDNyN25sDQo+IGRBR3lvS2xYMEI1UXNacUFUbjBpSFpETUtKJTJGdlklM0QmYW1wO3Jlc2Vy
dmVkPTA+IFR3aXR0ZXIgfA0KPiA8aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cuDQo+IGxpbmFyby5vcmclMkZsaW5hcm8t
YmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nJTQwbnhwLmNvDQo+IG0lN0MxNTc0
NWE4YTQxMzM0Y2ZkZWUxMTA4ZDc0ZTU3ZDI1YiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+
IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MDY0MDExNDAyMTY4MDI1JmFtcDtzZGF0YT1BVmRreko3
dEVBZUgNCj4gMW9sRzZWS2ZWdjlmbmdDd1Z4bjVTNzZMclNVRHdyZyUzRCZhbXA7cmVzZXJ2ZWQ9
MD4gQmxvZw0KDQo=

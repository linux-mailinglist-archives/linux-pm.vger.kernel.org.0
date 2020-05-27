Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6E1E35B3
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgE0Ccv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 22:32:51 -0400
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:17728
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbgE0Ccv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 May 2020 22:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2bklFr/St8j0ArlnGBq4+glDSSHvw6RetEEWrSq564HVBN4/v58Cfo2ESYW4MrSWCCkkPJ45F3SEm7F8s/w7+zjywfWG1rT462+neioSM5SGyteVhjyl2a5BpOxY/JqvT8vscS55+liNvMD23+ttfP7gQOVjXSVybK0vEKhQ0Z8nfgLWw5VGkQVEop0KdKS9bNO7ZXj7wo/Af+xPQQY57FrhdKpvSxWlFK3bcMLAPEDe+mdHV5JkMB7HGIgYac+jmT5vUylqYJjUxkiBINKBD3UKczXdVHaxYk98OE6WMWRb1drYUnLcPg+pQYvuuKruybI3hxran1cmbo41ipLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNHDgFVxyS/HsK2qKBCJJPRQieOr+LF/xKo2r3jZK3k=;
 b=DHZo8+kh6hG6TE+ZiAAZ6IbZb0RPCZkC/BvaQOgrgOJhxipuituGy97TFgGb1D/Npd+D+buwMSvDdyIwZIWJXbqxPeThHx4+vC7tolcghtWKrBbTCCNKsZ7k69JjY9WPYDFuhQNLz0PdqsMYBcptMHyPFgniLPpSDnxDycCnayTdo4E2g0z1fCyLF/X7NeoEauwghPnSepjvfl9epVteooCzqJq/CmoadvDQlIoeE0+sTc+5o5MbZ6loQOjZPAM9CBMCHay4W35STbkFeK6XwX+F4MeDYNrZw4PsUmfUgqgakUyaKg4lBd0PZYv4asoAEHvUeUeNDrY7YLkMqq0ADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNHDgFVxyS/HsK2qKBCJJPRQieOr+LF/xKo2r3jZK3k=;
 b=k+jicMKeiFbopMkawv12QyyXIaHF3oft15onG97AvBSb1V/nCAwrk5Re4qlJl7OvxaUJhK0LdXolqraUBG8dqPNDuxPl4EgGTPrj44NbjK+Uuo2N1iz6O2Nvcsn3+mzTJtGN3vbUquTLleZLWuQYS5Uf2XEaqaEUJru76kq+8eo=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB4287.eurprd04.prod.outlook.com (2603:10a6:803:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 02:32:47 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::7545:cf5d:b8b0:4ab0]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::7545:cf5d:b8b0:4ab0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 02:32:46 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: add wakeup feature for GPIO
 CD pin
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: add wakeup feature for GPIO
 CD pin
Thread-Index: AQHWMzlj8iuPPeiCeUWHAbogE7JD/ai6PzCAgAD2RbA=
Date:   Wed, 27 May 2020 02:32:46 +0000
Message-ID: <VI1PR04MB5294F37036E7E8427E8D560490B10@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1590481839-28603-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFqjZdN0zv2iW+Rq6WZSo56HfyPFYHvg-JvzYZPy_eTSBQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqjZdN0zv2iW+Rq6WZSo56HfyPFYHvg-JvzYZPy_eTSBQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25f55447-6e43-4288-5fa9-08d801e63e25
x-ms-traffictypediagnostic: VI1PR04MB4287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42874334834006E5BBDA4EC390B10@VI1PR04MB4287.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CGVMWrhz2klElMeMWdCl8SkCdNQ/TMaRmcemyyjUEP+WvRBlz1+o/kG65VaUiJIZ7HD04upsXYrQefhcjC6OwXwNhH37y+FZ5i9r92FXumpTrgMLxCcXaprM6P4xOSQYDNqdp2n6Z7F5mfwB/jB0+BO2Ve1em5b6Jgql8GpixVg3DkeakGqe99v99qgLmLkz9torj7YNr7sO8H9hMltfZy12Fl4hE6HPoKFq6A73SdDjy7+O0nbY2pdV83Gp/WGaURcGRpAFF6k/Tdq5FpjFf3i4T3U7v8WElnAYdX0Mt94Ck88ghZ8ml6Eu7G1RjAfE09H7hyon+vqJAlNTN1+Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(8676002)(316002)(26005)(66946007)(76116006)(186003)(66476007)(71200400001)(83380400001)(66556008)(66446008)(64756008)(8936002)(9686003)(86362001)(33656002)(4326008)(55016002)(5660300002)(7696005)(6916009)(54906003)(2906002)(478600001)(52536014)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SZusxnVTjf2y4ztvJU0Av/a/2EbN99lFkKNeKlc9WQFY0G18ByoeFtWj45vycJukInr2zbCvPcuFALDw77dY4tsUGRiMEbIVCbvOYE/sHtSy0Andc+cdN7N06O5c38gy2fbooZkY732ihh8SNlIszl6zEhTvLk4D4pIHDmOwX4Nos52RKso0hrLPuiR7L8i2j3zMs3W8cvEya6RMTnbMhRr98xRG4ZWTNGz6dBLG271g3LgZM1Ti+oG9BUWM/hvlvLs0xd8nMddR+Gu8kyeSwTw7ACaRPqJmGYjLmEWFuvO/XrQ8jP+q/5IvwsnkCaMiJMhomkOISikzqCBikRvpQwStvwxpRol7exuFIhHqXfdCQbjRU1MGGzA7yaI8i+xoup03mXjMlJ4rhHDAgkNfheL3vSbNbyApCeYy4YI7IAGw9194wwWVPKlDagjTerfjPcF9eLgJzkYmMzFaAay+W2T6z/qfpVOFP2Z2+8lWFxg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f55447-6e43-4288-5fa9-08d801e63e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 02:32:46.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGZDl7a2Kb2kRKEK4XCEFv28qyulbm9kVkDyy2Lc8qjdpgkBEN5s9yPd5uLM6Zs6T9cflzGgFYTFQ3bo/W9buw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4287
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMOW5tDXmnIgyNuaXpSAxOTo0Mw0KPiBUbzog
Qk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogQWRyaWFuIEh1bnRlciA8YWRy
aWFuLmh1bnRlckBpbnRlbC5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPiBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsNCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgU2FzY2hhIEhh
dWVyDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBMaW51eCBQTQ0KPiA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPjsgUmFmYWVs
IEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBt
bWM6IGhvc3Q6IHNkaGNpLWVzZGhjLWlteDogYWRkIHdha2V1cCBmZWF0dXJlIGZvciBHUElPDQo+
IENEIHBpbg0KPiANCj4gKyBSYWZhZWwsIGxpbnV4LXBtDQo+IA0KPiBPbiBUdWUsIDI2IE1heSAy
MDIwIGF0IDEwOjQxLCA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206
IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IFdoZW4gdXNlIHRoZSBz
cGVjaWZpYyBHUElPIHRvIGRldGVjdCB0aGUgY2FyZCBpbnNlcnQvcmVtb3ZlLCB3ZSBjYW4NCj4g
PiBhbHNvIGFkZCB0aGUgR1BJTyBhcyBhIHdha2V1cCBzb3VyY2UuIFdoZW4gc3lzdGVtIHN1c3Bl
bmQsIGluc2VydCBvcg0KPiA+IHJlbW92ZSB0aGUgY2FyZCBjYW4gd2FrZXVwIHRoZSBzeXN0ZW0u
DQo+IA0KPiBZZXMsIHRoaXMgbWFrZXMgcGVyZmVjdCBzZW5zZSEgSG93ZXZlci4uLg0KPiANCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDE5ICsrKysr
KysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1lc2RoYy1pbXguYw0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0K
PiA+IGluZGV4IDUzOThhZjQ4MjRjMy4uN2FmOWQ4N2Q0MjQ1IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gQEAgLTE1OTksNiArMTU5OSwxMSBAQCBzdGF0aWMg
aW50IHNkaGNpX2VzZGhjX2lteF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICAgICAgICAgaWYgKGVzZGhjX2lzX3VzZGhjKGlteF9kYXRhKSkgew0KPiA+ICAgICAg
ICAgICAgICAgICBob3N0LT5xdWlya3MyIHw9DQo+IFNESENJX1FVSVJLMl9QUkVTRVRfVkFMVUVf
QlJPS0VOOw0KPiA+ICAgICAgICAgICAgICAgICBob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF8x
XzhWX0REUiB8DQo+ID4gTU1DX0NBUF8zXzNWX0REUjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgIC8qIEdQSU8gQ0QgY2FuIGJlIHNldCBhcyBhIHdha2V1cCBzb3VyY2UgKi8NCj4gPiArICAg
ICAgICAgICAgICAgaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfQ0RfV0FLRTsNCj4gPiArICAg
ICAgICAgICAgICAgZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5kZXYsIHRydWUpOw0KPiA+ICsN
Cj4gDQo+IC4uLiBpZiB0aGUgZGV2aWNlIGlzIGF0dGFjaGVkIHRvIGEgZ2VucGQgKGEgUE0gZG9t
YWluKSwgdGhpcyBtYXkgY2F1c2UgaXQgdG8gc3RheQ0KPiBwb3dlcmVkIG9uIGluIHRoZSBzeXN0
ZW0gc3VzcGVuZCBzdGF0ZS4gTm90IHN1cmUgaWYgdGhhdCBjYW4gY2F1c2UgYSBwcm9ibGVtDQo+
IGZvciB5b3U/IFdhc3RpbmcgZW5lcmd5Pw0KPiANCj4gSW4gYW55IGNhc2UsIEkgdGhpbmsgaXQn
cyB3cm9uZyB0byBtYWtlICImcGRldi0+ZGV2IiB3YWtldXAgY2FwYWJsZSwgbGlrZSB0aGlzLg0K
PiBFc3BlY2lhbGx5IGFzIGF0IGl0J3MgdGhlIEdQSU8gY29udHJvbGxlciB0aGF0IG1hbmFnZXMg
dGhlIHN5c3RlbSB3YWtldXAgaXJxLg0KDQpZZXMsIHRoYXQncyByZWFzb25hYmxlLiANCg0KDQo+
IA0KPiA+ICAgICAgICAgICAgICAgICBpZiAoIShpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBF
U0RIQ19GTEFHX0hTMjAwKSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBob3N0LT5xdWly
a3MyIHw9DQo+IFNESENJX1FVSVJLMl9CUk9LRU5fSFMyMDA7DQo+ID4NCj4gPiBAQCAtMTczNCw4
ICsxNzM5LDE1IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
DQo+ICpkZXYpDQo+ID4gICAgICAgICAgICAgICAgIG1tY19yZXR1bmVfbmVlZGVkKGhvc3QtPm1t
Yyk7DQo+ID4NCj4gPiAgICAgICAgIHJldCA9IHNkaGNpX3N1c3BlbmRfaG9zdChob3N0KTsNCj4g
PiAtICAgICAgIGlmICghcmV0KQ0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gcGluY3RybF9w
bV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2KTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gcGluY3Ry
bF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2KTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4g
KyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGRldmlj
ZV9tYXlfd2FrZXVwKGRldikpDQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IG1tY19ncGlvX3Nl
dF9jZF93YWtlKGhvc3QtPm1tYywgdHJ1ZSk7DQo+IA0KPiBXaXRoIHRoZSBhYm92ZSBzYWlkLCBJ
IHRoaW5rIHRoZSBiZXN0IGF2YWlsYWJsZSBhcHByb2FjaCBhdCB0aGlzIHBvaW50LCBpcyB0byBq
dXN0DQo+IGNhbGwgbW1jX2dwaW9fc2V0X2NkX3dha2UoKSAtIGFuZCBqdXN0IHNraXAgY2hlY2tp
bmcgZGV2aWNlX21heV93YWtldXAoKS4NCj4gDQo+IEJUVywgbW1jX2dwaW9fc2V0X2NkX3dha2Uo
KSBjYWxscyBlbmFibGVfaXJxX3dha2UoKSwgd2hpY2ggZG9lc24ndCByZXF1aXJlDQo+IHRoZSAi
ZGV2IiB0byBiZSB3YWtldXAgY2FwYWJsZS4gU28gdGhpcyBpcyBmaW5lIQ0KPiANCj4gWWVzLCBp
dCBtZWFucyB0aGF0IHRoZSBJUlEgd2lsbCBiZSBjb25maWd1cmVkIGFzIGEgc3lzdGVtIHdha2V1
cCwgd2l0aG91dA0KPiBsZXR0aW5nIHVzZXIgc3BhY2UgdG8gaGF2ZSBhIHNheSBhYm91dCBpdC4g
SSBndWVzcyB3ZSBjYW4gbGl2ZSB3aXRoIHRoYXQNCj4gbGltaXRhdGlvbi4NCj4gDQoNCk9rYXks
IEkgd2lsbCBzZW5kIGEgdjIgcGF0Y2ggYWNjb3JkaW5nIHRvIHlvdXIgc3VnZ2VzdGlvbi4NCg0K
VGhhbmtzIQ0KSGFpYm8gQ2hlbg0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9
DQo+ID4gQEAgLTE3NTksNiArMTc3MSw5IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgICAgICAgIGlmIChob3N0LT5tbWMtPmNhcHMyICYg
TU1DX0NBUDJfQ1FFKQ0KPiA+ICAgICAgICAgICAgICAgICByZXQgPSBjcWhjaV9yZXN1bWUoaG9z
dC0+bW1jKTsNCj4gPg0KPiA+ICsgICAgICAgaWYgKCFyZXQgJiYgZGV2aWNlX21heV93YWtldXAo
ZGV2KSkNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gbW1jX2dwaW9fc2V0X2NkX3dha2UoaG9z
dC0+bW1jLCBmYWxzZSk7DQo+ID4gKw0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0K
PiA+ICAjZW5kaWYNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMN
Cj4gVWZmZQ0K

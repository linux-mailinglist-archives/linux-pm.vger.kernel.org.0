Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD71F324F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 04:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFICeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 22:34:25 -0400
Received: from mail-eopbgr1300129.outbound.protection.outlook.com ([40.107.130.129]:6223
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgFICeZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 22:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLY4/zQwVK5s/xq4L+Ak7xcEUlZJxk4HreSKFQ8uf/A4O3BKQlVwBPbIFfOS3Gq/bpvAWVSL2pnAmO8lSBrh6lZql4EE7ahZMdYf75vHqt7qVa2mx+4+N7BuqJvu0IQqA8J7LRItZLedAynPX2tEHugU6reIlSprl3+4aczQ6aGrRqD3DFQuL2p1x0nAYGeIaDv0btvIELauQQ5adz8rdPtMDc8dCGh7tkTsD9oWG6zSloXewxd9z9SRpU+Oolo5jDCjedbU8UbS5vFfUVHYpncX66XzjmUSPE9Z8eTHBqWp4Rp4f0aC1d0acyT7fXxnUZjDVyV72q6Y5H3XJZVkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIBcqR58oyE6R63FMHWpKRfXW64ov7QqSNZEjkGcEhU=;
 b=VrLWsfH2wmTXfBWqS42pRgvum5BWmRMn5CeUciGk/L1PGtpnLBjxBrq07ruoUVnXwXyFv1gWL2zmC4+zMQpkEvsmPhcz3dwhAVwt67gG7h/HxjWolxeWrtOY5Q5Wv9mBzRES+QQFAiSZf+iKWxUdEiVhdb1AIOsQtyHUwGlNcZoEjgpxzLKSwheVmyJTvCKpe5u9nIqQBlcEnZIxyZbRR8QDLaKHvAdg8+z6ML3zzkJLRI3sBQdVxU8UWshGeg6+qvlbFteTRy58WYjdwpfePLb/V1MZ/TFC0Ej0acyYxHF+qrAHjh7zYNS9PsrJfHuET0SuF3Px+Sj48aq6AQupEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIBcqR58oyE6R63FMHWpKRfXW64ov7QqSNZEjkGcEhU=;
 b=ZtukJy1SBoKDiD4PMfP33i54TlORyLgfW1nbrt/ablhaAJuKP6caDmSEP90KtzJxIO8LC5yuIk3IagMDYevmpWrALInHCuh5LOuzIFzSvykyDDmlhOVVCP3ofXLXnne4C6I6lWf7mqlJAC5WamRpYSe3yBGrAHATxzMuRn6fqMg=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3386.jpnprd01.prod.outlook.com (2603:1096:404:d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Tue, 9 Jun
 2020 02:34:20 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 02:34:20 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dien Pham <dien.pham.ry@renesas.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Van Do <van.do.xw@renesas.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] thermal: rcar_gen3_thermal: Fix undefined temperature if
 negative
Thread-Topic: [PATCH] thermal: rcar_gen3_thermal: Fix undefined temperature if
 negative
Thread-Index: AQHWPYXYPBDXHyG8gEWwtXrFuGWaDKjOl4qAgAD0HAA=
Date:   Tue, 9 Jun 2020 02:34:20 +0000
Message-ID: <TY2PR01MB36923211263DA7F54A814AF4D8820@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1591614776-20333-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXT0qofW38-g79TSiy1nUBhrWNPfbViKRyWSFdme=oD0g@mail.gmail.com>
In-Reply-To: <CAMuHMdXT0qofW38-g79TSiy1nUBhrWNPfbViKRyWSFdme=oD0g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b762723f-a389-4266-f63c-08d80c1d9d47
x-ms-traffictypediagnostic: TY2PR01MB3386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB33862482771F0B15F2D1916BD8820@TY2PR01MB3386.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APoFPScJBUH7S28JLKP21cBad4WYsAFxb8rspmunn2TtW+eu2HpMbAuvR0LFKTsB5Bwj5ySBNZ7BVgBuGzdRXgV9JthBpnzhtpjXxrnGMElXbA1iAqDCxqXjGoAnlKSOfBz9L41IlZ29LtIdwK17IkKml6tnN+4LUjXxUbeEahdnpfRMDRGhN0zJEyMgYhNe7K4lZbiS4vf6JuF8++tNNKbGgq6koy+ZiQMHPpSwE3kbjHLTMNJs7nCUssJCMMkOkdrNRixSuKfv32DK/qLdXuAZj8EtX52copJQH8vm4hyqJHGkHtuV7pBr9VKnagHdpQp8GBBFIlfLObjC3X6ICw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(86362001)(8676002)(2906002)(4326008)(33656002)(5660300002)(55236004)(8936002)(6506007)(52536014)(26005)(76116006)(66946007)(66446008)(66556008)(186003)(64756008)(66476007)(110136005)(55016002)(71200400001)(316002)(478600001)(83380400001)(54906003)(7696005)(6636002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: P5Kjp2tTgcF/EMBA2n7upVcWBUyA3YF7E6xOzypo6rPmT3KkWs+OUxqeC6IIFiVLd1r/K5wPSkyIaRLv83Kz0/c8U8EyTTV5JsrewXHoQTfQiNDojqHa2x7M+AGI705knxwlfSNR8+NpYeEHWVKOtoQ+nn3cNikFQSEDcFyPuGPFSpNE051x/EsUW4ZtQh7//EoWOJB4egpc+k+ZP23TBgjJrqCF7alMVBSFMgasEAQAcVju5tlunfk5nuevXmtlvZoK1fQcTofyghhTMzlMGABqkuz21VSKnJZKp/yx2AZMfUTxN615XPiRymMU2Xv6Al9n5gH/WRSXXUL6Adr+xT8TVdm765vYKXkHkJ3GJ7Wp/fZuNou1MTUWySl6GZH9CPKFLpJD19UolkESZPaJTL1HXjMvh3gwp8DYu7M1E6TcHip0r/FKdZl++cPiTiZpd0nFeVNNJqHLJgyVEqGiDM54qXnnJKDxB5AtB7BimZL6MQSvu5l8Kd63neiJBJSj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b762723f-a389-4266-f63c-08d80c1d9d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 02:34:20.3430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aRWR4NnKTHrCw1QYfX0lTP8pdx8vtQTfI8NpoUCWg3VZwaGcAj3MxlGqtTLimAV4SeU2DZzmbi88ChKiLpwP+tCqPc4gVNtfsZ9i8NiytTJOOMAe0Ajo4PyghgeowbX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3386
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gRnJvbTog
R2VlcnQgVXl0dGVyaG9ldmVuLCBTZW50OiBNb25kYXksIEp1bmUgOCwgMjAyMCA4OjM4IFBNDQo8
c25pcD4NCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4zX3RoZXJtYWwuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9yY2FyX2dlbjNfdGhlcm1hbC5jDQo+ID4gQEAgLTE2Nyw3
ICsxNjcsNyBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuM190aGVybWFsX2dldF90ZW1wKHZvaWQgKmRl
dmRhdGEsIGludCAqdGVtcCkNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IHJjYXJfZ2VuM190
aGVybWFsX3RzYyAqdHNjID0gZGV2ZGF0YTsNCj4gPiAgICAgICAgIGludCBtY2Vsc2l1cywgdmFs
Ow0KPiA+IC0gICAgICAgdTMyIHJlZzsNCj4gPiArICAgICAgIGxvbmcgcmVnOw0KPiANCj4gImxv
bmciIGlzIDY0LWJpdCwgc28gImludCIgc2hvdWxkIGJlIHN1ZmZpY2llbnQuDQoNCk9vcHMuDQoN
Cj4gPiAgICAgICAgIC8qIFJlYWQgcmVnaXN0ZXIgYW5kIGNvbnZlcnQgdG8gbWlsaSBDZWxzaXVz
ICovDQo+ID4gICAgICAgICByZWcgPSByY2FyX2dlbjNfdGhlcm1hbF9yZWFkKHRzYywgUkVHX0dF
TjNfVEVNUCkgJiBDVEVNUF9NQVNLOw0KPiANCj4gSG93ZXZlciwgcmNhcl9nZW4zX3RoZXJtYWxf
cmVhZCgpIGRvZXMgcmV0dXJuIHUzMiwgc28ga2VlcGluZyB1MzIgZm9yDQo+IHJlZyBsb29rcyBt
b3JlIGxvZ2ljYWwgdG8gbWUuDQo+IA0KPiBTdWNjZXNzaXZlIGxpbmVzIGFyZToNCj4gDQo+ICAg
ICAgICAgaWYgKHJlZyA8PSB0aGNvZGVbdHNjLT5pZF1bMV0pDQo+ICAgICAgICAgICAgICAgICB2
YWwgPSBGSVhQVF9ESVYoRklYUFRfSU5UKHJlZykgLSB0c2MtPmNvZWYuYjEsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdHNjLT5jb2VmLmExKTsNCj4gICAgICAgICBlbHNlDQo+
ICAgICAgICAgICAgICAgICB2YWwgPSBGSVhQVF9ESVYoRklYUFRfSU5UKHJlZykgLSB0c2MtPmNv
ZWYuYjIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHNjLT5jb2VmLmEyKTsN
Cj4gDQo+IFBlcmhhcHMgaXQncyBzYWZlciB0byBhZGQgYW4gY2FzdCB0byBGSVhQVF9JTlQoKSwg
c28gaXQgYWx3YXlzIHJldHVybnMNCj4gaW50LCBhbmQvb3IgYWRkIGNhc3RzIHRvIEZJWFBUX0RJ
VigpLCBzbyBvbmx5IHNpZ25lZCB2YWx1ZXMgYXJlIHBhc3NlZA0KPiB0byBESVZfUk9VTkRfQ0xP
U0VTVD8NCj4gVGhhdCB3b3VsZCBwcmV2ZW50IHRoZSBpc3N1ZSBmcm9tIHJlYXBwZWFyaW5nIGxh
dGVyLg0KDQpUaGVyZSBpcyBub3QgcmVsYXRlZCB0byB0aGUgaXNzdWUgYnV0LCB0aGNvZGVbXSBp
cyBhbHNvIGludC4NClNvLCBpZiB3ZSB1c2UgY2FzdHMsIHdlIHdpbGwgc2VlIGEgbG90IG9mIGNh
c3RzIGxpa2UgYmVsb3c6DQotLS0NCnN0YXRpYyBpbnQgcmNhcl9nZW4zX3RoZXJtYWxfZ2V0X3Rl
bXAodm9pZCAqZGV2ZGF0YSwgaW50ICp0ZW1wKQ0Kew0KCXN0cnVjdCByY2FyX2dlbjNfdGhlcm1h
bF90c2MgKnRzYyA9IGRldmRhdGE7DQoJaW50IG1jZWxzaXVzLCB2YWw7DQoJdTMyIHJlZzsNCg0K
CS8qIFJlYWQgcmVnaXN0ZXIgYW5kIGNvbnZlcnQgdG8gbWlsaSBDZWxzaXVzICovDQoJcmVnID0g
cmNhcl9nZW4zX3RoZXJtYWxfcmVhZCh0c2MsIFJFR19HRU4zX1RFTVApICYgQ1RFTVBfTUFTSzsN
Cg0KCWlmICgoaW50KXJlZyA8PSB0aGNvZGVbdHNjLT5pZF1bMV0pDQoJCXZhbCA9IChpbnQpRklY
UFRfRElWKChpbnQpRklYUFRfSU5UKHJlZykgLSB0c2MtPmNvZWYuYjEsDQoJCQkJdHNjLT5jb2Vm
LmExKTsNCgllbHNlDQoJCXZhbCA9IChpbnQpRklYUFRfRElWKChpbnQpRklYUFRfSU5UKHJlZykg
LSB0c2MtPmNvZWYuYjIsDQoJCQkJdHNjLT5jb2VmLmEyKTsNCi0tLQ0KDQpJJ20gdGhpbmtpbmcg
dGhlIG5hbWUgInJlZyIgaXMgbm90IGdvb2QgYmVjYXVzZSBpdCBzaG91bGQgYmUgdGhlIHNhbWUg
dHlwZSBhcw0KcmNhcl9nZW4zX3RoZXJtYWxfcmVhZCgpLiBCdXQsIGlmIHdlIHVzZSBvdGhlciBu
YW1lIGxpa2UgImludCBjdGVtcDsiLCB3ZSBjYW4gdXNlDQppdCBsaWtlIGJlbG93LiBXaGF0IGRv
IHlvdSB0aGluaz8NCi0tLQ0Kc3RhdGljIGludCByY2FyX2dlbjNfdGhlcm1hbF9nZXRfdGVtcCh2
b2lkICpkZXZkYXRhLCBpbnQgKnRlbXApDQp7DQoJc3RydWN0IHJjYXJfZ2VuM190aGVybWFsX3Rz
YyAqdHNjID0gZGV2ZGF0YTsNCglpbnQgbWNlbHNpdXMsIHZhbDsNCglpbnQgY3RlbXA7DQoNCgkv
KiBSZWFkIHJlZ2lzdGVyIGFuZCBjb252ZXJ0IHRvIG1pbGkgQ2Vsc2l1cyAqLw0KCWN0ZW1wID0g
aW50KHJjYXJfZ2VuM190aGVybWFsX3JlYWQodHNjLCBSRUdfR0VOM19URU1QKSAmIENURU1QX01B
U0spOw0KDQoJaWYgKGN0ZW1wIDw9IHRoY29kZVt0c2MtPmlkXVsxXSkNCgkJdmFsID0gRklYUFRf
RElWKEZJWFBUX0lOVChjdGVtcCkgLSB0c2MtPmNvZWYuYjEsDQoJCQkJdHNjLT5jb2VmLmExKTsN
CgllbHNlDQoJCXZhbCA9IEZJWFBUX0RJVihGSVhQVF9JTlQoY3RlbXApIC0gdHNjLT5jb2VmLmIy
LA0KCQkJCXRzYy0+Y29lZi5hMik7DQotLS0NCg0KPiBCVFcsIHJjYXJfZ2VuM190aGVybWFsX21j
ZWxzaXVzX3RvX3RlbXAoKSByZXR1cm5zIGEgdmFsdWUgdG8gc3RvcmUgaW4gYQ0KPiByZWdpc3Rl
ciwgaGVuY2UgSSB0aGluayBpdCBzaG91bGQgcmV0dXJuIHUzMiBpbnN0ZWFkIG9mIGludC4NCg0K
SSB0aGluayBzby4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBHcntv
ZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0K
PiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0
DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1l
ciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

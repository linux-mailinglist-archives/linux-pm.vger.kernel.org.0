Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CE1F38E3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFILAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 07:00:16 -0400
Received: from mail-eopbgr1320099.outbound.protection.outlook.com ([40.107.132.99]:23220
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgFILAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jun 2020 07:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr/oiTbYUMX5U/7iQWh2sU1U1fC9EpoxDVtEKel4qQevc1fWJcFcmN5Nmgr9WuGj5w+u5U+ZgmfMxSHnfgXhyv0r4qeesoACKctuaDrLtIcPnSAnswlNUf8H5LAcQBrPPzKjvZltAf7kF+qnRG2x+bwSyIouJN0+ymwIQP2Sa6eCZKdh+5iCjFrmMNSPH9g1Lm3dmZBf8mEZBUvZcD7HXSLFUNnNZHYeng8slS8REX2aPvRpqdhtM5Sl60e9bP387eA7lgHM0gKJ7cNOH6oageNeywTUj27UL/WJY3b6JoA8Ceer2KlAIWDM1AoqRw3v30ho8ILIB4/vRZXrjVVB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VejbkOQRgETE/yrYVH+/bNZ+c0pR/GyGmMcAws66Ss=;
 b=I/AgbNwHKRbAQyfCj6Iz6sNvh1FT/j/5wZhe1hYUJRAhMQczQI/z76p8MRAF/pUjCDtKVy50QU1XQRYsbGiP3vtyHimW3f1U87typkBLEFNCmmmkTRa0RFiM5TzW3xG7vv+ZA7vc79McQ7fNCj/m+vCKVMjPw8DxPHKMs7ssMjVg4Ai4ym5xLUcxkahM9pQXRTAczF1+VQxXs0A6/JoMnj6iREHz0sXPEGRxcVaQ30UEuFxFwe7kK1V/4UiRWTy2zjW3eiMdfb9CgmkDV1+vpInvT8Ngk4BRyNTqZlG2rJsv2ZQjM1ez335th9/cWtsyoMRTCXVQYte/UyTQ1bTYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VejbkOQRgETE/yrYVH+/bNZ+c0pR/GyGmMcAws66Ss=;
 b=p14FN5PL/rRPXZB8ajSwDdiVAU/8EQi17w8a4bdxu8EuXpH/xIVi93kZr4C/WIPZ5T1KBrCyD6uhlh5SFfKkCdkzlNMK5ErScBGSqzEM7691/DjiECgnFN60Y9EPwIXpYLYkoQwyKTRDvTBixTDtzYn3BAvgu5/8Me/K5FPIQuI=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB5097.jpnprd01.prod.outlook.com (2603:1096:404:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 11:00:09 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 11:00:09 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Dien Pham <dien.pham.ry@renesas.com>,
        Zhang Rui <rui.zhang@intel.com>,
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
Thread-Index: AQHWPYXYPBDXHyG8gEWwtXrFuGWaDKjOl4qAgAD0HACAAFdNgIAAO8Ww
Date:   Tue, 9 Jun 2020 11:00:08 +0000
Message-ID: <TY2PR01MB369226D0A29A2429AD1BDAC4D8820@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1591614776-20333-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXT0qofW38-g79TSiy1nUBhrWNPfbViKRyWSFdme=oD0g@mail.gmail.com>
 <TY2PR01MB36923211263DA7F54A814AF4D8820@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAMuHMdWSZNXk_bXvWzgt6aEtuOtox9sXyP36bG=Z_8KNiwkmHw@mail.gmail.com>
In-Reply-To: <CAMuHMdWSZNXk_bXvWzgt6aEtuOtox9sXyP36bG=Z_8KNiwkmHw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a84176c1-49db-4be2-9ee2-08d80c64468b
x-ms-traffictypediagnostic: TY2PR01MB5097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB50977D69B40EFEB2A51AF841D8820@TY2PR01MB5097.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9khmYjrvLSA4b/+KG3PJvrdUcU8H9U+GSDAVcJWQofO1JpU6VRNKYNB7DK+UH5u3J6kNd0S5GO30xCBx5YlnpbcMgxOCPXjLrYdqDv2x27UvnvGTasiZ8+aeYjEM0RX0XQ/OQx0DzSm/f2uYaSzOMgqmCatDCEh9ag4/2ChsQ29heOnZDlBztJGfVwYk9mHwPtVVRkRJqokaQwN0OfInwE//dF9B6irWOW6y2hxbvil5S0KPKgOSO/Ig5QbxAJQQ8L+VNavp2b9g80XBNhztlJMuIjg0n9+s2AkJxVTREEZhRTAvvBVQ7W2mAWhaG5Y85VMvcvvxnoqsvFBRetMKcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(52536014)(9686003)(2906002)(64756008)(316002)(86362001)(8676002)(8936002)(5660300002)(54906003)(55016002)(66946007)(186003)(66556008)(66476007)(33656002)(26005)(6506007)(7696005)(6916009)(55236004)(53546011)(4326008)(71200400001)(66446008)(83380400001)(76116006)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eB7wqJAI7Xg4P++C7kX49uY+oOvz4/HbM2VE7NZmehebQ8cdaVKhx9j5zEXUI6yLcJzHRtdN6qvBLTMa9TlAbG30s9UAEHDMN8HNNg3BJMiem+MVajPOsVc0rwLFOpc9ZI9lYayHk1+bFL+XR1lh7/ECZmWcBSgxZ74i6a3H04B98j9aLjtHRV2RsabfPFDkoQGNfB9KjpfV+aYmdTJjXr1A3vkI0kOGQjLFH52yFhAiKug/y1wY3NO6O0kzBYaxNjojFU+VffF2oUIV5BTJ0M3KBR0Ah7Y5u8oD0AgNTyG0pYusExPvPDZZPop0YdDEf/nOTTtfRQpbA0X7D958dfJACQ5vYHpWV65z745oH1HZMo6SYJDr5ZUuALeuwX12bI6dZIMpmel5imYOYm9D55XNRph3PDaJoQu/pQBMwWeCHryjs7K0u4YYMgp0m0qKnz1nOD9QPu8o9E8yowBMltksHTPJ8VLnZwAw1zc22RxFha7pwlyMWiMD9duDaso+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84176c1-49db-4be2-9ee2-08d80c64468b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 11:00:09.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjx0cG08BsT9AgiRzE3gUxcuwtvKRb0r5Bdl1aKgk3CdUgPt6vhnCLDq5LaUMjwsXmek4YX7gfxQD/4muzxI/Ijkd3pg0NtmA0JpykdaX/hzD79txLtt7EjVk98iNuLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5097
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgSnVuZSA5LCAyMDIwIDQ6MjQgUE0NCj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4gT24g
VHVlLCBKdW4gOSwgMjAyMCBhdCA0OjM0IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3NoaWhp
cm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBHZWVydCBVeXR0
ZXJob2V2ZW4sIFNlbnQ6IE1vbmRheSwgSnVuZSA4LCAyMDIwIDg6MzggUE0NCj4gPiA8c25pcD4N
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL3JjYXJfZ2VuM190aGVybWFsLmMNCj4gPiA+
ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3JjYXJfZ2VuM190aGVybWFsLmMNCj4gPiA+ID4gQEAg
LTE2Nyw3ICsxNjcsNyBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuM190aGVybWFsX2dldF90ZW1wKHZv
aWQgKmRldmRhdGEsIGludCAqdGVtcCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gICAgICAgICBzdHJ1
Y3QgcmNhcl9nZW4zX3RoZXJtYWxfdHNjICp0c2MgPSBkZXZkYXRhOw0KPiA+ID4gPiAgICAgICAg
IGludCBtY2Vsc2l1cywgdmFsOw0KPiA+ID4gPiAtICAgICAgIHUzMiByZWc7DQo+ID4gPiA+ICsg
ICAgICAgbG9uZyByZWc7DQo+ID4gPg0KPiA+ID4gImxvbmciIGlzIDY0LWJpdCwgc28gImludCIg
c2hvdWxkIGJlIHN1ZmZpY2llbnQuDQo+ID4NCj4gPiBPb3BzLg0KPiA+DQo+ID4gPiA+ICAgICAg
ICAgLyogUmVhZCByZWdpc3RlciBhbmQgY29udmVydCB0byBtaWxpIENlbHNpdXMgKi8NCj4gPiA+
ID4gICAgICAgICByZWcgPSByY2FyX2dlbjNfdGhlcm1hbF9yZWFkKHRzYywgUkVHX0dFTjNfVEVN
UCkgJiBDVEVNUF9NQVNLOw0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIsIHJjYXJfZ2VuM190aGVybWFs
X3JlYWQoKSBkb2VzIHJldHVybiB1MzIsIHNvIGtlZXBpbmcgdTMyIGZvcg0KPiA+ID4gcmVnIGxv
b2tzIG1vcmUgbG9naWNhbCB0byBtZS4NCj4gPiA+DQo+ID4gPiBTdWNjZXNzaXZlIGxpbmVzIGFy
ZToNCj4gPiA+DQo+ID4gPiAgICAgICAgIGlmIChyZWcgPD0gdGhjb2RlW3RzYy0+aWRdWzFdKQ0K
PiA+ID4gICAgICAgICAgICAgICAgIHZhbCA9IEZJWFBUX0RJVihGSVhQVF9JTlQocmVnKSAtIHRz
Yy0+Y29lZi5iMSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHNjLT5j
b2VmLmExKTsNCj4gPiA+ICAgICAgICAgZWxzZQ0KPiA+ID4gICAgICAgICAgICAgICAgIHZhbCA9
IEZJWFBUX0RJVihGSVhQVF9JTlQocmVnKSAtIHRzYy0+Y29lZi5iMiwNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdHNjLT5jb2VmLmEyKTsNCj4gPiA+DQo+ID4gPiBQZXJo
YXBzIGl0J3Mgc2FmZXIgdG8gYWRkIGFuIGNhc3QgdG8gRklYUFRfSU5UKCksIHNvIGl0IGFsd2F5
cyByZXR1cm5zDQo+ID4gPiBpbnQsIGFuZC9vciBhZGQgY2FzdHMgdG8gRklYUFRfRElWKCksIHNv
IG9ubHkgc2lnbmVkIHZhbHVlcyBhcmUgcGFzc2VkDQo+ID4gPiB0byBESVZfUk9VTkRfQ0xPU0VT
VD8NCj4gPiA+IFRoYXQgd291bGQgcHJldmVudCB0aGUgaXNzdWUgZnJvbSByZWFwcGVhcmluZyBs
YXRlci4NCj4gPg0KPiA+IFRoZXJlIGlzIG5vdCByZWxhdGVkIHRvIHRoZSBpc3N1ZSBidXQsIHRo
Y29kZVtdIGlzIGFsc28gaW50Lg0KPiA+IFNvLCBpZiB3ZSB1c2UgY2FzdHMsIHdlIHdpbGwgc2Vl
IGEgbG90IG9mIGNhc3RzIGxpa2UgYmVsb3c6DQo+IA0KPiBTb3JyeSBmb3IgYmVpbmcgdW5jbGVh
cjogSSBsaXRlcmFsbHkgbWVhbnQgdG8gYWRkIGNhc3RzIHRvIHRoZSBtYWNyb3MsDQo+IG5vdCB0
byB0aGUgY2FsbGVycy4gIElmIHRoZSBtYWNyb3MgYXJlIHNhZmUgYWdhaW5zdCB0aGlzIGlzc3Vl
LCB0aGVuIHRoZQ0KPiBjYWxsZXJzIGRvbid0IGhhdmUgdG8gY2FyZSBhbnltb3JlLg0KPiBCdXQg
dGhpcyBtaWdodCBiZSBvdmVya2lsbCwgYXMgdGhlIGlzc3VlIGlzIHByZXNlbnQgaW4gb25lIHBs
YWNlIG9ubHkuDQoNCkkgZ290IGl0Lg0KDQo+ID4gSSdtIHRoaW5raW5nIHRoZSBuYW1lICJyZWci
IGlzIG5vdCBnb29kIGJlY2F1c2UgaXQgc2hvdWxkIGJlIHRoZSBzYW1lIHR5cGUgYXMNCj4gPiBy
Y2FyX2dlbjNfdGhlcm1hbF9yZWFkKCkuIEJ1dCwgaWYgd2UgdXNlIG90aGVyIG5hbWUgbGlrZSAi
aW50IGN0ZW1wOyIsIHdlIGNhbiB1c2UNCj4gPiBpdCBsaWtlIGJlbG93LiBXaGF0IGRvIHlvdSB0
aGluaz8NCj4gPiAtLS0NCj4gPiBzdGF0aWMgaW50IHJjYXJfZ2VuM190aGVybWFsX2dldF90ZW1w
KHZvaWQgKmRldmRhdGEsIGludCAqdGVtcCkNCj4gPiB7DQo+ID4gICAgICAgICBzdHJ1Y3QgcmNh
cl9nZW4zX3RoZXJtYWxfdHNjICp0c2MgPSBkZXZkYXRhOw0KPiA+ICAgICAgICAgaW50IG1jZWxz
aXVzLCB2YWw7DQo+ID4gICAgICAgICBpbnQgY3RlbXA7DQo+ID4NCj4gPiAgICAgICAgIC8qIFJl
YWQgcmVnaXN0ZXIgYW5kIGNvbnZlcnQgdG8gbWlsaSBDZWxzaXVzICovDQo+ID4gICAgICAgICBj
dGVtcCA9IGludChyY2FyX2dlbjNfdGhlcm1hbF9yZWFkKHRzYywgUkVHX0dFTjNfVEVNUCkgJiBD
VEVNUF9NQVNLKTsNCj4gDQo+IE5vIG5lZWQgZm9yIGEgY2FzdCB0byBpbnQgaGVyZSwgYXMgYXNz
aWdubWVudCB0byBjdGVtcCB0YWtlcyBjYXJlDQo+IG9mIHRoYXQuDQoNClRoYW5rIHlvdSBmb3Ig
eW91ciBjb21tZW50LiBJJ2xsIHJlbW92ZSB0aGlzIGNhc3QuDQoNCj4gPg0KPiA+ICAgICAgICAg
aWYgKGN0ZW1wIDw9IHRoY29kZVt0c2MtPmlkXVsxXSkNCj4gPiAgICAgICAgICAgICAgICAgdmFs
ID0gRklYUFRfRElWKEZJWFBUX0lOVChjdGVtcCkgLSB0c2MtPmNvZWYuYjEsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0c2MtPmNvZWYuYTEpOw0KPiA+ICAgICAgICAgZWxz
ZQ0KPiA+ICAgICAgICAgICAgICAgICB2YWwgPSBGSVhQVF9ESVYoRklYUFRfSU5UKGN0ZW1wKSAt
IHRzYy0+Y29lZi5iMiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzYy0+
Y29lZi5hMik7DQo+IA0KPiBUaGF0IHdvdWxkIHdvcmsgdG9vLg0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgcmV2aWV3ISBJJ2xsIHN1Ym1pdCB2MiBwYXRjaCBsYXRlci4NCg0KQmVzdCByZWdhcmRzLA0K
WW9zaGloaXJvIFNoaW1vZGENCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0g
VGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3Jn
DQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

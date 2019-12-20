Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF102127FA2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfLTPmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 10:42:37 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9663 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfLTPmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 10:42:17 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: QGXlQ01Tv3Rm0uYjYsifKeytlMki4JMM2fbrvsq+lVC+74i7BEx8zqlOfZZCBDDx99PNhRRois
 reIQraPA8o5pX829ABeEU9qWMIsIJvbnv0Vx6QPSlfsQlBf5ipZ+m9qwX4V5UMFBgjBxFVCS6r
 AqWTpQUtwcjdYEQ70lRA8cE1rTD419uY1vdHLWKMJzxv1Ys+rIieKnq50C/gqBEnqqXMUEFIqd
 dgzVVa4Ldqf4DmAPui8ynxP2QQDBwHVXDjv4kiDfDmlZdOzr/5t/VfJvn5RB1HeYJUuRPArcUx
 I6A=
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="59175751"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2019 08:42:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Dec 2019 08:42:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 20 Dec 2019 08:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXyQrxuLrWq5jSKQJTNQSZvaGDJFBF12VbiKhsYgJSYYOEagKBB4kl41TIZihcHfKMhwxJ+CPBKCJ5rjlh3GB3FVtTg9G3c2pyQW1Dcki8Ytn9f1y5+aDSYJ0VcezbS+CoBWi1ZqRxmrmkOaB567WpFvpw9Gxhu/HVrOxoaA/v7X0lPF+wiRq6w4bzpuZ/U+YwBly0lQa9Clohvt6pl2xwI5ZNAa/ftX4op+Ln+90hPO1LscylpKlI4Dqa/vY2UZ7yGeuudmorub7jVY6lHTAsX1VylCzSBmQWzYwfmJK6dW3hnZEJWysxsV1wM58xUUBcZWPTwHZHpWhvICuaX0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOpqmFIKEzpepvnf2Ut7dbRynroMXnXS6O4ONIkrAIM=;
 b=Y2CG1/I3hp3k9DLhAFdG4u9dTzefRnVEtO8ibJG4hr33FOSJTwFfH5oM85ptuTRXNdRxpoYBte98CoYH5UHqPEdY3H5uaIYQ61g9b+dbemodyqn+MpjZsIRukXdOkZltefCwP9aHINfJ8w3a31AF4FYmscBlMCvprapRIoDP4dpM4QMACwMyGFooRD2uMUMKcrnd85bowSEzxh3SPewm9k3LnQ26mqB7yvu043dY/YipvEkmBObyJKqZQwf0iZlVPTeFsLDFxkscg59D6deeAOglZaptuO8fzqEI3p7TyenAXKSDlJFynklvLzUtYAm2jBUozE/ejSh2yATs1aO6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOpqmFIKEzpepvnf2Ut7dbRynroMXnXS6O4ONIkrAIM=;
 b=JkvasgdiNZRe5S7oeFOWsKnMco6AcaZR9tY9gxCpEFYvVC6Y76eQiY1aQMOzfUKsdgiXIhufzVphLceuz4Hr6Ei8vY9jx9uetEwH50ECTbr1kKPnT4qmY6UBf+kxnr3zxYkVPyR3DmR8L/AWVbqW7Qq8dRVt1r8vb1lg3Iog3Vk=
Received: from SN6PR11MB2830.namprd11.prod.outlook.com (52.135.91.21) by
 SN6PR11MB2909.namprd11.prod.outlook.com (52.135.126.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 15:42:10 +0000
Received: from SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::9439:53a6:d896:d176]) by SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::9439:53a6:d896:d176%7]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 15:42:10 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] power: reset: at91-poweroff: introduce struct
 shdwc_reg_config
Thread-Topic: [PATCH v2 1/2] power: reset: at91-poweroff: introduce struct
 shdwc_reg_config
Thread-Index: AQHVt0qOlx7ofyKccU+5Noka4mrDhqfDKX0A
Date:   Fri, 20 Dec 2019 15:42:10 +0000
Message-ID: <b7618ccceecacc45565854b5a038fe044aad85e5.camel@microchip.com>
References: <1576855878-13213-1-git-send-email-claudiu.beznea@microchip.com>
         <1576855878-13213-2-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1576855878-13213-2-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c56d138-c072-45db-bab8-08d785632d44
x-ms-traffictypediagnostic: SN6PR11MB2909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB29097D5B62A8809D6CC69E25E02D0@SN6PR11MB2909.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(110136005)(5660300002)(186003)(54906003)(71200400001)(4326008)(316002)(86362001)(6486002)(76116006)(91956017)(66446008)(64756008)(66556008)(66476007)(66946007)(36756003)(81166006)(81156014)(8676002)(6512007)(2906002)(2616005)(26005)(8936002)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2909;H:SN6PR11MB2830.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONKDL/wtW8NmBxTNfycob5aBj9yDtTjBq/x44c9P0/qUCe6BkWnS0IF4V2pvCxO2JLjfRDb7ask5gKEtL9pJws8VoiEIfESfybe/YF9tsjrRsw4IVapH25pGslVnBtXgvu8DTkqqSpuKLFJKdhIcrZ/EeSQg2pylXFUezIEMn0mWojMCiKBqVIdELZPrp/RaX9pOhUOn62/yU/SBotxygcXQuYQTa+hkPnb2FHdHe0f09leSo4J8B6jJ+kH/khbLflKLjME2kFlSznaOD4tp2WpLgEetI/iK67YwSmtCC8jYpH3j2zAqFNe4i7IE+IvFIAsLbV528tBMrm8mmybQEGo6fZVJMY7TpxG5v3GcKkE7exLwxYniPa45tUG7EGHmM7FEdnPREdI6FaLir8TEw1y3ChkJCu33AzuhmwUVvVVRqafwch+LhnmqPzM13Ncc
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3215EFB51EA0243AACDB5A50D323273@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c56d138-c072-45db-bab8-08d785632d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 15:42:10.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2gaHUGJZEgta9hKvIrspmS3JNqm1W5jcsR3UJd8SVp7Do/fLCwUxoSxMNj0PLUN5LhIpjW/Wr3ul+b2jfmWwuNQmakwXMabUkXzSbcb9e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2909
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TGUgdmVuZHJlZGkgMjAgZMOpY2VtYnJlIDIwMTkgw6AgMTc6MzEgKzAyMDAsIENsYXVkaXUgQmV6
bmVhIGEgw6ljcml0IDoNCj4gVGhpcyBkcml2ZXIgdXNlcyBBVDkxX1BNQ19NQ0tSIGluIHBvd2Vy
b2ZmKCkgZnVuY3Rpb24uIEJ1dCB0aGUNCj4gU0FNOVg2MCdzIFBNQyB2ZXJzaW9ucyBtYXBzIEFU
OTFfUE1DX01DS1IgZnVuY3Rpb25hbGl0eSBhdCBkaWZmZXJlbnQNCj4gb2Zmc2V0IGNvbXBhcmVk
IHRvIHRoZSBTQU1BNUQyJ3Mgb25lLiBUaGlzIHBhdGNoIHByZXBhcmVzIHRoZSBmaWVsZA0KPiBz
byB0aGF0IGRpZmZlcmVudCBBVDkxX1BNQ19NQ0tSJ3Mgb2Zmc2V0cyB0byBiZSBpbnRyb2R1Y2Vk
IGluDQo+IHN0cnVjdCByZWdfY29uZmlnIHNvIHRoYXQgcHJvcGVyIG9mZnNldCB0byBiZSB1c2Vk
IGZvciBBVDkxX1BNQ19NQ0tSDQo+IGJhc2VkIG9uIGNvbXBhdGlibGUgc3RyaW5nLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5j
b20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtc2FtYTVkMl9zaGR3Yy5j
IHwgNTQgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+IC0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYw0KPiBiL2RyaXZlcnMv
cG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMNCj4gaW5kZXggMWMxOGY0NjVhMjQ1Li44
NDgwNmQyMDg0NmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1h
NWQyX3NoZHdjLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hk
d2MuYw0KPiBAQCAtNjYsNyArNjYsNyBAQA0KPiAgDQo+ICAjZGVmaW5lIFNIRFdfQ0ZHX05PVF9V
U0VECSgzMikNCj4gIA0KPiAtc3RydWN0IHNoZHdjX2NvbmZpZyB7DQo+ICtzdHJ1Y3Qgc2hkd2Nf
cmVnX2NvbmZpZyB7DQo+ICAJdTggd2t1cF9waW5faW5wdXQ7DQo+ICAJdTggbXJfcnRjd2tfc2hp
ZnQ7DQo+ICAJdTggbXJfcnR0d2tfc2hpZnQ7DQo+IEBAIC03NCw4ICs3NCwxMiBAQCBzdHJ1Y3Qg
c2hkd2NfY29uZmlnIHsNCj4gIAl1OCBzcl9ydHR3a19zaGlmdDsNCj4gIH07DQo+ICANCj4gK3N0
cnVjdCByZWdfY29uZmlnIHsNCj4gKwlzdHJ1Y3Qgc2hkd2NfcmVnX2NvbmZpZyBzaGR3YzsNCj4g
K307DQo+ICsNCj4gIHN0cnVjdCBzaGR3YyB7DQo+IC0JY29uc3Qgc3RydWN0IHNoZHdjX2NvbmZp
ZyAqY2ZnOw0KPiArCWNvbnN0IHN0cnVjdCByZWdfY29uZmlnICpyY2ZnOw0KPiAgCXN0cnVjdCBj
bGsgKnNjbGs7DQo+ICAJdm9pZCBfX2lvbWVtICpzaGR3Y19iYXNlOw0KPiAgCXZvaWQgX19pb21l
bSAqbXBkZHJjX2Jhc2U7DQo+IEBAIC05NSw2ICs5OSw3IEBAIHN0YXRpYyBjb25zdCB1bnNpZ25l
ZCBsb25nIGxvbmcgc2R3Y19kYmNfcGVyaW9kW10gPSB7DQo+ICBzdGF0aWMgdm9pZCBfX2luaXQg
YXQ5MV93YWtldXBfc3RhdHVzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+
ICAJc3RydWN0IHNoZHdjICpzaGR3ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICsJ
Y29uc3Qgc3RydWN0IHJlZ19jb25maWcgKnJjZmcgPSBzaGR3LT5yY2ZnOw0KPiAgCXUzMiByZWc7
DQo+ICAJY2hhciAqcmVhc29uID0gInVua25vd24iOw0KPiAgDQo+IEBAIC0xMDYsMTEgKzExMSwx
MSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYXQ5MV93YWtldXBfc3RhdHVzKHN0cnVjdA0KPiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKCFyZWcpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAt
CWlmIChTSERXX1dLX1BJTihyZWcsIHNoZHctPmNmZykpDQo+ICsJaWYgKFNIRFdfV0tfUElOKHJl
ZywgJnJjZmctPnNoZHdjKSkNCj4gIAkJcmVhc29uID0gIldLVVAgcGluIjsNCj4gLQllbHNlIGlm
IChTSERXX1JUQ1dLKHJlZywgc2hkdy0+Y2ZnKSkNCj4gKwllbHNlIGlmIChTSERXX1JUQ1dLKHJl
ZywgJnJjZmctPnNoZHdjKSkNCj4gIAkJcmVhc29uID0gIlJUQyI7DQo+IC0JZWxzZSBpZiAoU0hE
V19SVFRXSyhyZWcsIHNoZHctPmNmZykpDQo+ICsJZWxzZSBpZiAoU0hEV19SVFRXSyhyZWcsICZy
Y2ZnLT5zaGR3YykpDQo+ICAJCXJlYXNvbiA9ICJSVFQiOw0KPiAgDQo+ICAJcHJfaW5mbygiQVQ5
MTogV2FrZS1VcCBzb3VyY2U6ICVzXG4iLCByZWFzb24pOw0KPiBAQCAtMjE1LDYgKzIyMCw3IEBA
IHN0YXRpYyB1MzIgYXQ5MV9zaGR3Y19nZXRfd2FrZXVwX2lucHV0KHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYsDQo+ICBzdGF0aWMgdm9pZCBhdDkxX3NoZHdjX2R0X2NvbmZpZ3VyZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBzaGR3YyAqc2hk
dyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiArCWNvbnN0IHN0cnVjdCByZWdfY29u
ZmlnICpyY2ZnID0gc2hkdy0+cmNmZzsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRl
di0+ZGV2Lm9mX25vZGU7DQo+ICAJdTMyIG1vZGUgPSAwLCB0bXAsIGlucHV0Ow0KPiAgDQo+IEBA
IC0yMjcsMTAgKzIzMywxMCBAQCBzdGF0aWMgdm9pZCBhdDkxX3NoZHdjX2R0X2NvbmZpZ3VyZShz
dHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQltb2RlIHw9IEFUOTFfU0hEV19X
S1VQREJDKGF0OTFfc2hkd2NfZGVib3VuY2VyX3ZhbHVlKHBkZXYsDQo+IHRtcCkpOw0KPiAgDQo+
ICAJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImF0bWVsLHdha2V1cC1ydGMtdGltZXIi
KSkNCj4gLQkJbW9kZSB8PSBTSERXX1JUQ1dLRU4oc2hkdy0+Y2ZnKTsNCj4gKwkJbW9kZSB8PSBT
SERXX1JUQ1dLRU4oJnJjZmctPnNoZHdjKTsNCj4gIA0KPiAgCWlmIChvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2wobnAsICJhdG1lbCx3YWtldXAtcnR0LXRpbWVyIikpDQo+IC0JCW1vZGUgfD0gU0hEV19S
VFRXS0VOKHNoZHctPmNmZyk7DQo+ICsJCW1vZGUgfD0gU0hEV19SVFRXS0VOKCZyY2ZnLT5zaGR3
Yyk7DQo+ICANCj4gIAlkZXZfZGJnKCZwZGV2LT5kZXYsICIlczogbW9kZSA9ICUjeFxuIiwgX19m
dW5jX18sIG1vZGUpOw0KPiAgCXdyaXRlbChtb2RlLCBzaGR3LT5zaGR3Y19iYXNlICsgQVQ5MV9T
SERXX01SKTsNCj4gQEAgLTIzOSwzMCArMjQ1LDM0IEBAIHN0YXRpYyB2b2lkIGF0OTFfc2hkd2Nf
ZHRfY29uZmlndXJlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJd3JpdGVs
KGlucHV0LCBzaGR3LT5zaGR3Y19iYXNlICsgQVQ5MV9TSERXX1dVSVIpOw0KPiAgfQ0KPiAgDQo+
IC1zdGF0aWMgY29uc3Qgc3RydWN0IHNoZHdjX2NvbmZpZyBzYW1hNWQyX3NoZHdjX2NvbmZpZyA9
IHsNCj4gLQkud2t1cF9waW5faW5wdXQgPSAwLA0KPiAtCS5tcl9ydGN3a19zaGlmdCA9IDE3LA0K
PiAtCS5tcl9ydHR3a19zaGlmdAk9IFNIRFdfQ0ZHX05PVF9VU0VELA0KPiAtCS5zcl9ydGN3a19z
aGlmdCA9IDUsDQo+IC0JLnNyX3J0dHdrX3NoaWZ0ID0gU0hEV19DRkdfTk9UX1VTRUQsDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHJlZ19jb25maWcgc2FtYTVkMl9yZWdfY29uZmlnID0gew0KPiAr
CS5zaGR3YyA9IHsNCj4gKwkJLndrdXBfcGluX2lucHV0ID0gMCwNCj4gKwkJLm1yX3J0Y3drX3No
aWZ0ID0gMTcsDQo+ICsJCS5tcl9ydHR3a19zaGlmdAk9IFNIRFdfQ0ZHX05PVF9VU0VELA0KPiAr
CQkuc3JfcnRjd2tfc2hpZnQgPSA1LA0KPiArCQkuc3JfcnR0d2tfc2hpZnQgPSBTSERXX0NGR19O
T1RfVVNFRCwNCj4gKwl9LA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBzaGR3
Y19jb25maWcgc2FtOXg2MF9zaGR3Y19jb25maWcgPSB7DQo+IC0JLndrdXBfcGluX2lucHV0ID0g
MCwNCj4gLQkubXJfcnRjd2tfc2hpZnQgPSAxNywNCj4gLQkubXJfcnR0d2tfc2hpZnQgPSAxNiwN
Cj4gLQkuc3JfcnRjd2tfc2hpZnQgPSA1LA0KPiAtCS5zcl9ydHR3a19zaGlmdCA9IDQsDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHJlZ19jb25maWcgc2FtOXg2MF9yZWdfY29uZmlnID0gew0KPiAr
CS5zaGR3YyA9IHsNCj4gKwkJLndrdXBfcGluX2lucHV0ID0gMCwNCj4gKwkJLm1yX3J0Y3drX3No
aWZ0ID0gMTcsDQo+ICsJCS5tcl9ydHR3a19zaGlmdCA9IDE2LA0KPiArCQkuc3JfcnRjd2tfc2hp
ZnQgPSA1LA0KPiArCQkuc3JfcnR0d2tfc2hpZnQgPSA0LA0KPiArCX0sDQo+ICB9Ow0KPiAgDQo+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhdDkxX3NoZHdjX29mX21hdGNoW10g
PSB7DQo+ICAJew0KPiAgCQkuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLXNoZHdjIiwNCj4g
LQkJLmRhdGEgPSAmc2FtYTVkMl9zaGR3Y19jb25maWcsDQo+ICsJCS5kYXRhID0gJnNhbWE1ZDJf
cmVnX2NvbmZpZywNCj4gIAl9LA0KPiAgCXsNCj4gIAkJLmNvbXBhdGlibGUgPSAibWljcm9jaGlw
LHNhbTl4NjAtc2hkd2MiLA0KPiAtCQkuZGF0YSA9ICZzYW05eDYwX3NoZHdjX2NvbmZpZywNCj4g
KwkJLmRhdGEgPSAmc2FtOXg2MF9yZWdfY29uZmlnLA0KPiAgCX0sIHsNCj4gIAkJLypzZW50aW5l
bCovDQo+ICAJfQ0KPiBAQCAtMzAzLDcgKzMxMyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGF0OTFf
c2hkd2NfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAl9DQo+ICAN
Cj4gIAltYXRjaCA9IG9mX21hdGNoX25vZGUoYXQ5MV9zaGR3Y19vZl9tYXRjaCwgcGRldi0+ZGV2
Lm9mX25vZGUpOw0KPiAtCWF0OTFfc2hkd2MtPmNmZyA9IG1hdGNoLT5kYXRhOw0KPiArCWF0OTFf
c2hkd2MtPnJjZmcgPSBtYXRjaC0+ZGF0YTsNCj4gIA0KPiAgCWF0OTFfc2hkd2MtPnNjbGsgPSBk
ZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+ICAJaWYgKElTX0VSUihhdDkxX3NoZHdj
LT5zY2xrKSkNCg==

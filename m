Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D918C10AB66
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 09:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfK0IGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 03:06:50 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:30834 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 03:06:50 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cEn3BCW7Uuj0AkbwTggZTqMcHGbEeOQxN1mAcz+spnMpYex10ZqcW9JQlnSfNcdIlm062fnn+u
 jwQuf1klLt+TcTLdJgxYPaGOuBkCNoBbBdsDfOK3vOW8ps1mgEynd3imxNZnIUleYaYcNorbRH
 WQNXSaUzRLp0mZT7A+IaRUnzdNh5cY1N7vePX5yWIbHq7ve6CvMtK5jrlWS2rJy0QRudhk8fP/
 etBLFhc+VoT2SMiuKAp5SPOLpY+9x5BgxMgE6Z8goAonr84zDPi2ksj8Q59lcU7uZN53E4H6sU
 /Yo=
X-IronPort-AV: E=Sophos;i="5.69,248,1571727600"; 
   d="scan'208";a="59896014"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2019 01:06:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Nov 2019 01:06:49 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 27 Nov 2019 01:06:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgwFyAUGae+i7FaqqWETWc5iyT2qknNy9gr7pSZH/PNb6JgqApF106MgwCXF8TcBjfemOdyv4vURW6/fLNVuGC9S0ElgZYbvCp/Lr8SmtCKwCZrLJMbohLszgjjK4vePlAXfxtAKG18UsuD1qkbG8xbIGkxAbeF28cyEeEpMtn1xmjKU4rREcwgdFIB5cDkhL9gx2rmqYLGVS10c1C2KJ9GBuq+GF9KLG9ABVTliXqTEwjWCdEB/XWXwUPuZWvhSvBJkJtp4P8G2XsfOREVlByiOZPeDnB3iac70T2oBUlVA3KS3kCVFLkOYyLe5l3gV0tq8HblzSryXuPK1lYN+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFoNGerMwswENxEytknQZ4rMUdnBluCgi09EJXd8PaY=;
 b=A272i20iIWCi2KdgqB5yc2BS6MVVpRk8BoStZP+peiwTAaCgcuKDc8gTKG2XvuYWukUgpW/OdJpfW+DM7td4I3ONElUgWGNDtgJoBFiqhkWzARRkF66l//AQyEBaDS26tC2aNNyJPPgkm7/OoL4CDbcoFVknGxtM1AmX/ru/p1pn9teUXW51osyKlPeGHvWtvvtwTU3Dbt2njPfdr9OECcI/fbBev2PYVZBhc9UQguxifnrFCZmFj+74wFpTSo34a14Kmp+BYi2G1eAMOxBmOn5GJoSiAH4TSgoZbY/j/HSNI1uAwVHNd1ns9Mpi1lLfsdbhyQ/J2q+wblpQBdFbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFoNGerMwswENxEytknQZ4rMUdnBluCgi09EJXd8PaY=;
 b=oqmssPLH1njjr/n997Q8w8L2aBZVQl3R2+3z9xF4/pF8hv+VOoQ2yIJdiIfTEx3pKA9HvUGrOmegrf95Q/7AOAOgGAtlT7GdUWOwU9D7i5zHCGynU0uILrcrfE/iCfiM8pj8BP6xJ5EQoxNxDoc8TgfiP/Td6RAVQ0uDa6d96cs=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB4396.namprd11.prod.outlook.com (52.132.251.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 08:06:48 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 08:06:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <linux@armlinux.org.uk>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 02/17] ARM: at91: pm: move SAM9X60's PM under its own
 SoC config flag
Thread-Topic: [PATCH v2 02/17] ARM: at91: pm: move SAM9X60's PM under its own
 SoC config flag
Thread-Index: AQHVpKCFd9tGDLZ9XESHiYu6fIDZcaeeqfCA
Date:   Wed, 27 Nov 2019 08:06:47 +0000
Message-ID: <10705ea9-7a0f-5af4-e383-293fabed6b89@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
 <1574773941-20649-3-git-send-email-claudiu.beznea@microchip.com>
 <20191126212841.GR299836@piout.net>
In-Reply-To: <20191126212841.GR299836@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::38) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191127100639338
x-originating-ip: [86.120.233.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2581c52f-e0c1-4f18-542a-08d77310c01f
x-ms-traffictypediagnostic: DM6PR11MB4396:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB43969BFA91147413F91288D187440@DM6PR11MB4396.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(52116002)(71200400001)(3846002)(6116002)(31696002)(256004)(76176011)(102836004)(2906002)(54906003)(53546011)(86362001)(316002)(36756003)(966005)(478600001)(6506007)(26005)(6512007)(64756008)(66066001)(66556008)(66476007)(66446008)(66946007)(386003)(99286004)(6916009)(229853002)(14454004)(5660300002)(6436002)(6306002)(5024004)(8936002)(6246003)(446003)(186003)(11346002)(6486002)(25786009)(2616005)(305945005)(8676002)(71190400001)(81166006)(81156014)(4326008)(7736002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4396;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gf+P8JU4oh/Aq808K5PkVnNblvnx6wbu6L32Wrs0AVBOWi0v8qrjhBNeXt96+E7u+7ONnQZPJeDMw135WVdUx4N79cAI4LJCSnljDlhTxLuHPaaJc9bcwoXaaFdBSfNwRMP8WxtgcU9TdnQzdVf3iRvE5uxHy7tU3kupzotBrfxYCXHYA8QE0HNX2oT61LLBxu8GmXyEFPm65HI/zbwTkvU/RzBR9N924a5IO1wJZYrnur567EiWFjUu25o+N7VMRPzn4IKUZh+Eb3w3myJMZ1B343MPCcwYyrvS8dlW0zNxgW9gVjmkI4FI5bO8UOERzTVwNk+SidiW+Z6HEM0HtLSFtn6C2n1JmSsLLZfBFpCNaUC2Hwn9jw/RLPhSyiLY8wt4JbMK6EsonvByVdDlFxHiLz9Ifgxu0OMMQJqr7sUyOM3dh7ZWvd9HX0+tvonhVACQ3z9FAlhPDLRtez8/tNlGe73Xsvul6otUremuY/E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76575997DE6394499B36B0C039107732@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2581c52f-e0c1-4f18-542a-08d77310c01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 08:06:47.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WYMyb/Lw9mlYev8BaXaFh8KIsOvulEFfZpEXqBL8whak+b4rsJYN5bJUkq6XMaBYxCIC0TkzJ6drytaGFapfkqvLlNeu+CywBs6unisCbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4396
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDI2LjExLjIwMTkgMjM6MjgsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI2LzExLzIwMTkgMTU6MTI6
MDYrMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBNb3ZlIFNBTTlYNjAncyBQTSBwYXJ0
IHVuZGVyIFNvQyBjb25maWcgZmxhZy4gVGhpcyBhbGxvd3MgdGhlIGJ1aWxkaW5nDQo+PiBvZiBT
QU05WDYwIHBsYXRmb3JtIHdpdGhvdXRoIGRlcGVuZGluZyBvbiBDT05GSUdfU09DX0FUOTFTQU05
IGZsYWcsDQo+PiBhbGxvd2luZyB1cyB0byBzZWxlY3Qgb25seSBuZWNlc3NhcnkgY29uZmlnIGZs
YWdzIGZvciBTQU05WDYwLg0KPj4NCj4gDQo+IEknbSByZWFsbHkgd29uZGVyaW5nLCBob3cgbXVj
aCBzcGFjZSBkb2VzIHRoYXQgcmVhbGx5IHNhdmU/DQo+IA0KPiBUaGUgbmV0IGJlbmVmaXQgc2Vl
bXMgdG8gYmUgdmVyeSBzbWFsbC4uLg0KDQpOb3QgdGhhdCBtdWNoLCBpbmRlZWQuIFdlIHdhbnQg
dG8gYmUgaW5kZXBlbmRlbnQgb2YgU09DX0FUOTFTQU05Lg0KDQo+IA0KPj4gU2lnbmVkLW9mZi1i
eTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0N
Cj4+ICBhcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUgICB8ICAxICsNCj4+ICBhcmNoL2FybS9t
YWNoLWF0OTEvYXQ5MXNhbTkuYyB8IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gIGFyY2gvYXJt
L21hY2gtYXQ5MS9wbS5jICAgICAgIHwgIDIgKy0NCj4+ICBhcmNoL2FybS9tYWNoLWF0OTEvc2Ft
OXg2MC5jICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICA0IGZp
bGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLWF0OTEvc2FtOXg2MC5jDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9NYWtlZmlsZSBiL2FyY2gvYXJtL21hY2gtYXQ5MS9N
YWtlZmlsZQ0KPj4gaW5kZXggZGU2NDMwMWRjZmYyLi5mNTY1NDkwZjFiNzAgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUNCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gt
YXQ5MS9NYWtlZmlsZQ0KPj4gQEAgLTYsNiArNiw3IEBADQo+PiAgIyBDUFUtc3BlY2lmaWMgc3Vw
cG9ydA0KPj4gIG9iai0kKENPTkZJR19TT0NfQVQ5MVJNOTIwMCkgKz0gYXQ5MXJtOTIwMC5vDQo+
PiAgb2JqLSQoQ09ORklHX1NPQ19BVDkxU0FNOSkgICArPSBhdDkxc2FtOS5vDQo+PiArb2JqLSQo
Q09ORklHX1NPQ19TQU05WDYwKSAgICArPSBzYW05eDYwLm8NCj4+ICBvYmotJChDT05GSUdfU09D
X1NBTUE1KSAgICAgICAgICAgICAgKz0gc2FtYTUubw0KPj4gIG9iai0kKENPTkZJR19TT0NfU0FN
VjcpICAgICAgICAgICAgICArPSBzYW12Ny5vDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtYXQ5MS9hdDkxc2FtOS5jIGIvYXJjaC9hcm0vbWFjaC1hdDkxL2F0OTFzYW05LmMNCj4+
IGluZGV4IGJmNjI5YzkwYzc1OC4uN2U1NzIxODlhNWViIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9h
cm0vbWFjaC1hdDkxL2F0OTFzYW05LmMNCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9hdDkx
c2FtOS5jDQo+PiBAQCAtMzEsMjEgKzMxLDMgQEAgRFRfTUFDSElORV9TVEFSVChhdDkxc2FtX2R0
LCAiQXRtZWwgQVQ5MVNBTTkiKQ0KPj4gICAgICAgLmluaXRfbWFjaGluZSAgID0gYXQ5MXNhbTlf
aW5pdCwNCj4+ICAgICAgIC5kdF9jb21wYXQgICAgICA9IGF0OTFfZHRfYm9hcmRfY29tcGF0LA0K
Pj4gIE1BQ0hJTkVfRU5EDQo+PiAtDQo+PiAtc3RhdGljIHZvaWQgX19pbml0IHNhbTl4NjBfaW5p
dCh2b2lkKQ0KPj4gLXsNCj4+IC0gICAgIG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxhdGUoTlVM
TCwgTlVMTCwgTlVMTCk7DQo+PiAtDQo+PiAtICAgICBzYW05eDYwX3BtX2luaXQoKTsNCj4+IC19
DQo+PiAtDQo+PiAtc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IHNhbTl4NjBfZHRfYm9hcmRfY29t
cGF0W10gX19pbml0Y29uc3QgPSB7DQo+PiAtICAgICAibWljcm9jaGlwLHNhbTl4NjAiLA0KPj4g
LSAgICAgTlVMTA0KPj4gLX07DQo+PiAtDQo+PiAtRFRfTUFDSElORV9TVEFSVChzYW05eDYwX2R0
LCAiTWljcm9jaGlwIFNBTTlYNjAiKQ0KPj4gLSAgICAgLyogTWFpbnRhaW5lcjogTWljcm9jaGlw
ICovDQo+PiAtICAgICAuaW5pdF9tYWNoaW5lICAgPSBzYW05eDYwX2luaXQsDQo+PiAtICAgICAu
ZHRfY29tcGF0ICAgICAgPSBzYW05eDYwX2R0X2JvYXJkX2NvbXBhdCwNCj4+IC1NQUNISU5FX0VO
RA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9wbS5jIGIvYXJjaC9hcm0vbWFj
aC1hdDkxL3BtLmMNCj4+IGluZGV4IGQ1YWY2YWVkYzAyYy4uNTZhNmE0OWIxOWUyIDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMNCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gt
YXQ5MS9wbS5jDQo+PiBAQCAtODA1LDcgKzgwNSw3IEBAIHZvaWQgX19pbml0IGF0OTFybTkyMDBf
cG1faW5pdCh2b2lkKQ0KPj4NCj4+ICB2b2lkIF9faW5pdCBzYW05eDYwX3BtX2luaXQodm9pZCkN
Cj4+ICB7DQo+PiAtICAgICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NPQ19BVDkxU0FNOSkpDQo+
PiArICAgICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NPQ19TQU05WDYwKSkNCj4+ICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPj4NCj4+ICAgICAgIGF0OTFfcG1fbW9kZXNfaW5pdCgpOw0KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW05eDYwLmMgYi9hcmNoL2FybS9tYWNoLWF0
OTEvc2FtOXg2MC5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAw
MDAwLi5kOGM3MzlkMjU0NTgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtYXQ5MS9zYW05eDYwLmMNCj4+IEBAIC0wLDAgKzEsMzQgQEANCj4+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4+ICsvKg0KPj4gKyAqIFNldHVwIGNvZGUgZm9yIFNB
TTlYNjAuDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTkgTWljcm9jaGlwIFRlY2hu
b2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyAqDQo+PiArICogQXV0aG9yOiBD
bGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+ICsgKi8NCj4+
ICsNCj4+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxh
dGZvcm0uaD4NCj4+ICsNCj4+ICsjaW5jbHVkZSA8YXNtL21hY2gvYXJjaC5oPg0KPj4gKyNpbmNs
dWRlIDxhc20vc3lzdGVtX21pc2MuaD4NCj4+ICsNCj4+ICsjaW5jbHVkZSAiZ2VuZXJpYy5oIg0K
Pj4gKw0KPj4gK3N0YXRpYyB2b2lkIF9faW5pdCBzYW05eDYwX2luaXQodm9pZCkNCj4+ICt7DQo+
PiArICAgICBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlKE5VTEwsIE5VTEwsIE5VTEwpOw0K
Pj4gKw0KPj4gKyAgICAgc2FtOXg2MF9wbV9pbml0KCk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRp
YyBjb25zdCBjaGFyICpjb25zdCBzYW05eDYwX2R0X2JvYXJkX2NvbXBhdFtdIF9faW5pdGNvbnN0
ID0gew0KPj4gKyAgICAgIm1pY3JvY2hpcCxzYW05eDYwIiwNCj4+ICsgICAgIE5VTEwNCj4+ICt9
Ow0KPj4gKw0KPj4gK0RUX01BQ0hJTkVfU1RBUlQoc2FtOXg2MF9kdCwgIk1pY3JvY2hpcCBTQU05
WDYwIikNCj4+ICsgICAgIC8qIE1haW50YWluZXI6IE1pY3JvY2hpcCAqLw0KPj4gKyAgICAgLmlu
aXRfbWFjaGluZSAgID0gc2FtOXg2MF9pbml0LA0KPj4gKyAgICAgLmR0X2NvbXBhdCAgICAgID0g
c2FtOXg2MF9kdF9ib2FyZF9jb21wYXQsDQo+PiArTUFDSElORV9FTkQNCj4+IC0tDQo+PiAyLjcu
NA0KPj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVk
IExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiAN
Cg==

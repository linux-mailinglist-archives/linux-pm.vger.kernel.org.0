Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7600810AE62
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0LAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 06:00:36 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:45507 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK0LAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 06:00:32 -0500
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
IronPort-SDR: BzSn+z6L3iDnUhacot7RWCvxo3MDxn+XZYt4n57ssvPqctJGOAfAUJkBzwtGO1+StmBpodNmDc
 neG9D5Vhh1XemuSZJGcHQVkBE3nedKksuIE8FWd5sdHEo5ttD79g/7Bvn7HSICRVPyow4QgZ5L
 IBlQb29T8yqyQ0ytl9TMfvQ9enLJ6CMyzYlur2LTzzpbFihzsF6b6UTrCs6lcVvhuF+mq8xjEG
 BnhnmdYxSayqfT53MZQbQvocD8RbpRxOaGnBhug7cA2RlmlprNzBf6kgLk8MrPvhy4xVyocaoa
 daQ=
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="59919477"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2019 04:00:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Nov 2019 04:00:30 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 04:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTsfJyEaaNBXPzxf97mGKu8a13cDTJbP8yN6XmiwhHvThtNC8QfjQD+9PUrE3eUjnkerYe8loT5F87y4CSM2GZYvj1DpkJiFkh22YlZixslS9i9+T7/09cEhcki+jjKsZmxAxtLfb+Jdp6g7fZs13twEukB8kFAH8uXHXr6HWD93xEibRfqsnEkOiTT1mnqT0udnADzALCVAyy2u4kr+wkK3nZFM1DSUEA092y49izz+zc0lAXWObC5/C/wIxOo4WukXaPTjp4TviYa1mgw9QN8Kbmm5u0Y7gzXbH9JDG4COHMoJ6yzg+M3Wn7QbrvRLpCAHmdUsgnpfYLPKWhLkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmhKquvNSYE+AUF6UEz8pUjhur0pNHVzdRDCK0gvU7Y=;
 b=gwr4BuCwCYPSrocowLMQ9YurD5Orb6+g6FySC3WE8xk3L9Z6BLWd/gN/fpYo9XaxXwTUJu/NZv4DnxkZUpXe65PnZzmfCytFkC0Yp0evfFM46j5UH1ruBIcZo4wXJ7ma3Wpf3v0P2O/a72kuBt4qjEJ3PgocKpf7yu9xaEd9tjxctupcn02Q7s7h7OYjuEKWECRrJDue0hc1u4DOjSiOVBxcKIPDcWJMmXBSOExNCeJ1Li0KZ/CXbA60gZQGz1Ormi+0OU654/f4plmpttf606gsb1sBRGq4kduClIorcG5ay2gQDHsNRLkiQHlATfVcoWTqoY6qpm0G//fmKvEHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmhKquvNSYE+AUF6UEz8pUjhur0pNHVzdRDCK0gvU7Y=;
 b=fTSjqPKHDzvaYej1xYSz3o2pWdg3ifCeBDqknQgxg3dDhXrtj1wFyMjsjxva9lVO66t4+VsgGPfQ6v5IMj4/bqbkcMNER7NMZf1jPhy2iPnibkcrLmZycOj4N7luVHZi58YnFkx1ro44OVCZ6zqG/oirGn9ppOShnXqtOuiLVww=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3418.namprd11.prod.outlook.com (20.177.219.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 11:00:27 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 11:00:26 +0000
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
Thread-Index: AQHVpKCFd9tGDLZ9XESHiYu6fIDZcaeeqfCAgAAhugCAAA7LgA==
Date:   Wed, 27 Nov 2019 11:00:26 +0000
Message-ID: <dea74fd0-de8b-96b5-b71c-a77a98d72c3f@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
 <1574773941-20649-3-git-send-email-claudiu.beznea@microchip.com>
 <20191126212841.GR299836@piout.net>
 <10705ea9-7a0f-5af4-e383-293fabed6b89@microchip.com>
 <20191127100722.GI299836@piout.net>
In-Reply-To: <20191127100722.GI299836@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::18) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191127130019556
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b027fe-0472-4e47-54c3-08d773290226
x-ms-traffictypediagnostic: DM6PR11MB3418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3418FA2A9BE3A6422567E8CF87440@DM6PR11MB3418.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(366004)(346002)(199004)(189003)(966005)(66946007)(4326008)(66446008)(6916009)(66476007)(64756008)(66556008)(478600001)(71190400001)(2906002)(71200400001)(6116002)(256004)(3846002)(76176011)(25786009)(7736002)(52116002)(5024004)(102836004)(14444005)(8936002)(81156014)(81166006)(31686004)(305945005)(8676002)(229853002)(86362001)(66066001)(6512007)(6306002)(5660300002)(6436002)(386003)(6506007)(11346002)(2616005)(31696002)(36756003)(53546011)(6246003)(14454004)(26005)(446003)(54906003)(186003)(6486002)(99286004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3418;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EW+m6/JenC0FM+DwBY3abChwqJhzh9qCOyuD7G5D+6RPlrNSAGHu/jcmABFBdJ8yFBgBUswsN3P5A2bEcNAs+UtOjWJEmj6wXfUa98nyfhes+bm9qzfiUkavSe5e/0fRz2tr8bu4ihNwFJb7t4eDBgUMxQ3PabSm9TZ57vQdYKDff6R+0/Y0LHyqiDzB5HdDit2+xHOooSc/6n+cqDdOJ43DWExxqqI6poNxbGMDrrC2EZEJid3bhxgxFbMIVqicwaHLGLG2FjJ5YetWEQKUpYFkjk/utdrzXod6HRNow+K7DTlf92Gbnl+E3Lr1SBT4CXWeEdt7E/AdML1dRkQE1mqgxjuK/PQAg5fkb25/4nYiMplB2csQCDP0pUQd+sYIRcipsiwnNWpz/FTRGT4nPyKcJqhO4GkwLWdJiaMFRgucYyEih+YkoRd9yVS/D/AxcPQrGdN73+JVaI+fMCPM4V50/mbpl/ZckYIA7iF6PBY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF2927522DE2994A9E0308BBC3711455@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b027fe-0472-4e47-54c3-08d773290226
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 11:00:26.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njRJwm6/BmUC/f+l+wgedlmBLNKNHJ3AjEiKYkozt/aO+gx2ryaZV52C+2xcDdw5z0a9/NrWQAvkQ+ETL5OMc2CvgaLGTQWI7y178rTPkdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3418
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDI3LjExLjIwMTkgMTI6MDcsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI3LzExLzIwMTkgMDg6MDY6
NDcrMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pg0KPj4g
T24gMjYuMTEuMjAxOSAyMzoyOCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+Pj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAyNi8xMS8yMDE5IDE1OjEy
OjA2KzAyMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+PiBNb3ZlIFNBTTlYNjAncyBQTSBw
YXJ0IHVuZGVyIFNvQyBjb25maWcgZmxhZy4gVGhpcyBhbGxvd3MgdGhlIGJ1aWxkaW5nDQo+Pj4+
IG9mIFNBTTlYNjAgcGxhdGZvcm0gd2l0aG91dGggZGVwZW5kaW5nIG9uIENPTkZJR19TT0NfQVQ5
MVNBTTkgZmxhZywNCj4+Pj4gYWxsb3dpbmcgdXMgdG8gc2VsZWN0IG9ubHkgbmVjZXNzYXJ5IGNv
bmZpZyBmbGFncyBmb3IgU0FNOVg2MC4NCj4+Pj4NCj4+Pg0KPj4+IEknbSByZWFsbHkgd29uZGVy
aW5nLCBob3cgbXVjaCBzcGFjZSBkb2VzIHRoYXQgcmVhbGx5IHNhdmU/DQo+Pj4NCj4+PiBUaGUg
bmV0IGJlbmVmaXQgc2VlbXMgdG8gYmUgdmVyeSBzbWFsbC4uLg0KPj4NCj4+IE5vdCB0aGF0IG11
Y2gsIGluZGVlZC4gV2Ugd2FudCB0byBiZSBpbmRlcGVuZGVudCBvZiBTT0NfQVQ5MVNBTTkuDQo+
Pg0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzIHdoeT8gSSBkb24ndCBzZWUgdGhlIHRlY2huaWNhbCBi
ZW5lZml0IGJ1dCBJDQo+IGRlZmluaXRpdmVseSBzZWUgdGhlIG1haW50ZW5hbmNlIGJ1cmRlbiBv
ZiBoYXZpbmcgdHdvIHNlcGFyYXRlIGNvbmZpZ3MNCj4gZG9pbmcgYWxtb3N0IHRoZSBzYW1lIHRo
aW5nLg0KDQpBcyBJIHNhaWQgYWJvdmU6IHRvIGJlIGFibGUgdG8gYnVpbGQgU0FNOVg2MCB3aXRo
b3V0IGRlcGVuZGluZyBvbg0KU09DX0FUOTFTQU05IGFuZCB0byBsaW1pdCB0aGUgbGVnYWN5IChp
biB0ZXJtIG9mIGRyaXZlcnMpIGNvbWluZyB3aXRoDQpTT0NfQVQ5MVNBTTkuDQoNCldvdWxkIHlv
dSBwcmVmZXIgdGhlIG90aGVyIHdheSBhcm91bmQgbGlrZSBJIGhhZCBpbiB0aGUgMXN0IHZlcnNp
b246DQoNCitjb25maWcgU09DX1NBTTlYNjANCisJYm9vbCAiU0FNOVg2MCINCisJZGVwZW5kcyBv
biBTT0NfQVQ5MVNBTTkNCisJc2VsZWN0IEFUTUVMX0FJQzVfSVJRDQorCXNlbGVjdCBIQVZFX0FU
OTFfR0VORVJBVEVEX0NMSw0KKwlzZWxlY3QgSEFWRV9BVDkxX1NBTTlYNjBfUExMDQorCWhlbHAN
CisJICBTZWxlY3QgdGhpcyBpZiB5b3UgYXJlIHVzaW5nIE1pY3JvY2hpcCdzIFNBTTlYNjAgU29D
DQoNCg0KDQo+IA0KPj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGFyY2gvYXJtL21hY2gt
YXQ5MS9NYWtlZmlsZSAgIHwgIDEgKw0KPj4+PiAgYXJjaC9hcm0vbWFjaC1hdDkxL2F0OTFzYW05
LmMgfCAxOCAtLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4gIGFyY2gvYXJtL21hY2gtYXQ5MS9wbS5j
ICAgICAgIHwgIDIgKy0NCj4+Pj4gIGFyY2gvYXJtL21hY2gtYXQ5MS9zYW05eDYwLmMgIHwgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgNCBmaWxlcyBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybS9tYWNoLWF0OTEvc2FtOXg2MC5jDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUgYi9hcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZp
bGUNCj4+Pj4gaW5kZXggZGU2NDMwMWRjZmYyLi5mNTY1NDkwZjFiNzAgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2FyY2gvYXJtL21hY2gtYXQ5MS9NYWtlZmlsZQ0KPj4+PiArKysgYi9hcmNoL2FybS9tYWNo
LWF0OTEvTWFrZWZpbGUNCj4+Pj4gQEAgLTYsNiArNiw3IEBADQo+Pj4+ICAjIENQVS1zcGVjaWZp
YyBzdXBwb3J0DQo+Pj4+ICBvYmotJChDT05GSUdfU09DX0FUOTFSTTkyMDApICs9IGF0OTFybTky
MDAubw0KPj4+PiAgb2JqLSQoQ09ORklHX1NPQ19BVDkxU0FNOSkgICArPSBhdDkxc2FtOS5vDQo+
Pj4+ICtvYmotJChDT05GSUdfU09DX1NBTTlYNjApICAgICs9IHNhbTl4NjAubw0KPj4+PiAgb2Jq
LSQoQ09ORklHX1NPQ19TQU1BNSkgICAgICAgICAgICAgICs9IHNhbWE1Lm8NCj4+Pj4gIG9iai0k
KENPTkZJR19TT0NfU0FNVjcpICAgICAgICAgICAgICArPSBzYW12Ny5vDQo+Pj4+DQo+Pj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvYXQ5MXNhbTkuYyBiL2FyY2gvYXJtL21hY2gt
YXQ5MS9hdDkxc2FtOS5jDQo+Pj4+IGluZGV4IGJmNjI5YzkwYzc1OC4uN2U1NzIxODlhNWViIDEw
MDY0NA0KPj4+PiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvYXQ5MXNhbTkuYw0KPj4+PiArKysg
Yi9hcmNoL2FybS9tYWNoLWF0OTEvYXQ5MXNhbTkuYw0KPj4+PiBAQCAtMzEsMjEgKzMxLDMgQEAg
RFRfTUFDSElORV9TVEFSVChhdDkxc2FtX2R0LCAiQXRtZWwgQVQ5MVNBTTkiKQ0KPj4+PiAgICAg
ICAuaW5pdF9tYWNoaW5lICAgPSBhdDkxc2FtOV9pbml0LA0KPj4+PiAgICAgICAuZHRfY29tcGF0
ICAgICAgPSBhdDkxX2R0X2JvYXJkX2NvbXBhdCwNCj4+Pj4gIE1BQ0hJTkVfRU5EDQo+Pj4+IC0N
Cj4+Pj4gLXN0YXRpYyB2b2lkIF9faW5pdCBzYW05eDYwX2luaXQodm9pZCkNCj4+Pj4gLXsNCj4+
Pj4gLSAgICAgb2ZfcGxhdGZvcm1fZGVmYXVsdF9wb3B1bGF0ZShOVUxMLCBOVUxMLCBOVUxMKTsN
Cj4+Pj4gLQ0KPj4+PiAtICAgICBzYW05eDYwX3BtX2luaXQoKTsNCj4+Pj4gLX0NCj4+Pj4gLQ0K
Pj4+PiAtc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IHNhbTl4NjBfZHRfYm9hcmRfY29tcGF0W10g
X19pbml0Y29uc3QgPSB7DQo+Pj4+IC0gICAgICJtaWNyb2NoaXAsc2FtOXg2MCIsDQo+Pj4+IC0g
ICAgIE5VTEwNCj4+Pj4gLX07DQo+Pj4+IC0NCj4+Pj4gLURUX01BQ0hJTkVfU1RBUlQoc2FtOXg2
MF9kdCwgIk1pY3JvY2hpcCBTQU05WDYwIikNCj4+Pj4gLSAgICAgLyogTWFpbnRhaW5lcjogTWlj
cm9jaGlwICovDQo+Pj4+IC0gICAgIC5pbml0X21hY2hpbmUgICA9IHNhbTl4NjBfaW5pdCwNCj4+
Pj4gLSAgICAgLmR0X2NvbXBhdCAgICAgID0gc2FtOXg2MF9kdF9ib2FyZF9jb21wYXQsDQo+Pj4+
IC1NQUNISU5FX0VORA0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMg
Yi9hcmNoL2FybS9tYWNoLWF0OTEvcG0uYw0KPj4+PiBpbmRleCBkNWFmNmFlZGMwMmMuLjU2YTZh
NDliMTllMiAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMNCj4+Pj4g
KysrIGIvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMNCj4+Pj4gQEAgLTgwNSw3ICs4MDUsNyBAQCB2
b2lkIF9faW5pdCBhdDkxcm05MjAwX3BtX2luaXQodm9pZCkNCj4+Pj4NCj4+Pj4gIHZvaWQgX19p
bml0IHNhbTl4NjBfcG1faW5pdCh2b2lkKQ0KPj4+PiAgew0KPj4+PiAtICAgICBpZiAoIUlTX0VO
QUJMRUQoQ09ORklHX1NPQ19BVDkxU0FNOSkpDQo+Pj4+ICsgICAgIGlmICghSVNfRU5BQkxFRChD
T05GSUdfU09DX1NBTTlYNjApKQ0KPj4+PiAgICAgICAgICAgICAgIHJldHVybjsNCj4+Pj4NCj4+
Pj4gICAgICAgYXQ5MV9wbV9tb2Rlc19pbml0KCk7DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLWF0OTEvc2FtOXg2MC5jIGIvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbTl4NjAuYw0KPj4+
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ4YzczOWQy
NTQ1OA0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9z
YW05eDYwLmMNCj4+Pj4gQEAgLTAsMCArMSwzNCBAQA0KPj4+PiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjArDQo+Pj4+ICsvKg0KPj4+PiArICogU2V0dXAgY29kZSBmb3IgU0FN
OVg2MC4NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTkgTWljcm9jaGlwIFRl
Y2hub2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4+PiArICoNCj4+Pj4gKyAqIEF1
dGhvcjogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pj4+
ICsgKi8NCj4+Pj4gKw0KPj4+PiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+Pj4+ICsjaW5jbHVk
ZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4+Pj4gKw0KPj4+PiArI2luY2x1ZGUgPGFzbS9tYWNo
L2FyY2guaD4NCj4+Pj4gKyNpbmNsdWRlIDxhc20vc3lzdGVtX21pc2MuaD4NCj4+Pj4gKw0KPj4+
PiArI2luY2x1ZGUgImdlbmVyaWMuaCINCj4+Pj4gKw0KPj4+PiArc3RhdGljIHZvaWQgX19pbml0
IHNhbTl4NjBfaW5pdCh2b2lkKQ0KPj4+PiArew0KPj4+PiArICAgICBvZl9wbGF0Zm9ybV9kZWZh
dWx0X3BvcHVsYXRlKE5VTEwsIE5VTEwsIE5VTEwpOw0KPj4+PiArDQo+Pj4+ICsgICAgIHNhbTl4
NjBfcG1faW5pdCgpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgY29uc3QgY2hhciAq
Y29uc3Qgc2FtOXg2MF9kdF9ib2FyZF9jb21wYXRbXSBfX2luaXRjb25zdCA9IHsNCj4+Pj4gKyAg
ICAgIm1pY3JvY2hpcCxzYW05eDYwIiwNCj4+Pj4gKyAgICAgTlVMTA0KPj4+PiArfTsNCj4+Pj4g
Kw0KPj4+PiArRFRfTUFDSElORV9TVEFSVChzYW05eDYwX2R0LCAiTWljcm9jaGlwIFNBTTlYNjAi
KQ0KPj4+PiArICAgICAvKiBNYWludGFpbmVyOiBNaWNyb2NoaXAgKi8NCj4+Pj4gKyAgICAgLmlu
aXRfbWFjaGluZSAgID0gc2FtOXg2MF9pbml0LA0KPj4+PiArICAgICAuZHRfY29tcGF0ICAgICAg
PSBzYW05eDYwX2R0X2JvYXJkX2NvbXBhdCwNCj4+Pj4gK01BQ0hJTkVfRU5EDQo+Pj4+IC0tDQo+
Pj4+IDIuNy40DQo+Pj4+DQo+Pj4NCj4+PiAtLQ0KPj4+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290
bGluDQo+Pj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPj4+IGh0dHBz
Oi8vYm9vdGxpbi5jb20NCj4+Pg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIEJvb3Rs
aW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jv
b3RsaW4uY29tDQo+IA0K

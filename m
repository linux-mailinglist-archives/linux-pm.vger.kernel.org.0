Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5810D473
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 11:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfK2K5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 05:57:48 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3000 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2K5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 05:57:48 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: naqoJRT3fpe7t89hrKXOTYjV3j/yUEiEsisXubHPRfXrb74jcgI/q9tRWHcJhpHMyYv819G7FI
 z69iOhDX+cxhbqsBxVztbpNMzZZYtjXHQeDGHM0dCZAzezGE5DTnzHaz5Nk74y68Ganp6pRWzT
 0NyQetGHzINyWI2cn7nSs5WhRo3UcwpuNOyp+FfJdTB0rN8bKioJp6Brdc6pFmgReAptX4mRlu
 umpMyZyKYveu7LWXfwjOK7f91aAnuxjw8Eg2giNmjxXjcwUHdIjTBkVL6opSLMG3b5/EXslq5+
 r78=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="57273289"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 03:57:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 03:57:46 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 29 Nov 2019 03:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKc0agaIKmA+bqWMS+WDobciHdeWvlkSteYd9plic2g4KTspxG9NvlPb/quKz23BDR+cZJT1M5E7CdqaZN5X6ViUHHKzqvQeIt+VRfqSZnjDqmJq7ZxrjXKIYPrliLdw1JrgFDEQw9ML1OZbkbaxQ1LyagtAh1NwXpZnRpO6xhAuJbLM3f8tQJOPV4EP4uTQWXUWeI2HoK4gaWozD26sqAzx7yhywJv9KZbmhtI1nXJuoSkUy817RDDta7MHUkC0R1kStIp0WSYBfZy4p5mSjNkF/xbsnWHv6uvOPwjyTf75TI8HengHz9rCdv3jm2kP9wnihR80PtsUVKdZpYoEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN32HTsrbJ+oLqIii+6COmhZOL7UbsPDBR4aZinOdac=;
 b=CIBq9sGeagZcu0YtcdlLet4b27juaGJN+r3Q+vmzJjSkKUN+q7SocgPYknAX8ZKJjRPffj9h/EZZOxE2GSRrPCQVK3jTus6omNOvK37FLSYFUeLIQX/vCpwZ8F079aDbq9Q7jeItjYl0jAC/XAemrKiT+if/zM7rSbK2YbCOfyEE05GmsFnAAowQ+5qhWiOYozYdVQNgjr/HAYANby/rsvvtJDAvtaj2Yfq+WABzXHVoMvT6vcD+BSfdxoqI6XiQmGFexpKL3cDn7T4hmv1bE4NeuGRWHBRNtnnDR9RVX1YNdcfmrnARKmgKXhf12ArVk5DqkdoPcrU1w6xaPPrIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN32HTsrbJ+oLqIii+6COmhZOL7UbsPDBR4aZinOdac=;
 b=nGRonSCdBRkzf+UF6lTC1rue9sCW70s10crA/FO3u+DhJYk+gLLA0YpoZXt3tbbvp4GeXk3Kz3KxTDmfDPqjsbG+V94lOV0bYqg5emDIOG3mapHTwBZmeS8yPakKibxaoCAlHJSSHwB0iTUINOpN0ymDz5ZUWYTA3+4O8KYnh9U=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB4332.namprd11.prod.outlook.com (52.132.250.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 10:57:45 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 10:57:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <kamel.bouhara@bootlin.com>, <sre@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Thread-Topic: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Thread-Index: AQHVpqPUrVvL4JbtF0GEzLdoaJ+YqA==
Date:   Fri, 29 Nov 2019 10:57:45 +0000
Message-ID: <034c9d01-633a-eeaa-f61f-d185be7227f2@microchip.com>
References: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
In-Reply-To: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::42) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129125738470
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffffde53-59f9-4c90-746c-08d774baf6bb
x-ms-traffictypediagnostic: DM6PR11MB4332:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB433220C984C7705A0B23593887460@DM6PR11MB4332.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(25786009)(6512007)(36756003)(31696002)(66946007)(305945005)(7736002)(478600001)(229853002)(316002)(66066001)(6486002)(6436002)(110136005)(99286004)(5660300002)(66446008)(54906003)(64756008)(256004)(8676002)(102836004)(52116002)(2616005)(386003)(11346002)(53546011)(8936002)(6246003)(3846002)(446003)(26005)(186003)(66556008)(76176011)(2501003)(81156014)(4326008)(71190400001)(86362001)(6506007)(66476007)(14454004)(81166006)(2906002)(14444005)(71200400001)(31686004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4332;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oy434Nw8vwyLK55aVa1ABmG1dV+EpXstdIdEKRt5Oj2IJ25S7eGcSqtMAx2NIM92rZvrFzdhynJx+ML7jBznbmqC0Am+SssfFHThr77xnEJxyAZgCEeea6+8QN9s6VHMlNaKTuaqnwqyZ9oX1J8qtCPA3SXs8HCiqvFmjHIWlj0nDvgpX7qBT1UudM4b9RafgjLG28OnjUbupqjU6YhQ01iDib7jwOWW9y+jzeHqRZeJ++fcbwuMafqhj4RXyynBdn6dxb/TgC9Fgri7d3UrNoMTaWqtqKU1C6Igid6+PteQYWtBVnPj5xeYK6L6E3zSg7fqQqi9BZffhsPnNZdVoIdmOe1EmcCYqysIEpaK8gZU54DukX3QKT6jHyfB3lOfOJEFQofZZNIg7DcHQbIjvepnhuTdr1bhJGgjsmchA9/F7XKOjA7np66IbUaX09v/
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7DF38D6827FD4095E36D72FB5464F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffffde53-59f9-4c90-746c-08d774baf6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 10:57:45.0962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0rTItfevz9OpieE4ZXUHdKqhtxf7mLEUBJPahXOuwNr8Qg4q4DM3222VsRHfFbGTCGXQhS2MJCneBcojU1oktHDPd8oqI15EenESPRgUtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4332
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgS2FtZWwsDQoNCk9uIDE3LjEwLjIwMTkgMTU6NDAsIEthbWVsIEJvdWhhcmEgd3JvdGU6DQo+
IFRoaXMgcGF0Y2ggZXhwb3J0IHRoZSBwb3dlciBvbiByZWFzb24gdGhyb3VnaCB0aGUgc3lzZnMg
aW50ZXJmYWNlIGFuZA0KPiBpbnRyb2R1Y2Ugc29tZSBnZW5lcmljIHJlc2V0IHNvdXJjZXMuDQo+
IFVwZGF0ZSB0aGUgQUJJIGRvY3VtZW50YXRpb24gdG8gbGlzdCBjdXJyZW50IHBvd2VyIG9uIHNv
dXJjZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYW1lbCBCb3VoYXJhIDxrYW1lbC5ib3VoYXJh
QGJvb3RsaW4uY29tPg0KPiAtLS0NCj4gIC4uLi9zeXNmcy1kZXZpY2VzLXBsYXRmb3JtLXBvd2Vy
LW9uLXJlYXNvbiAgICB8IDE0ICsrKysrKw0KPiAgZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJl
c2V0LmMgICAgICAgICAgICAgIHwgNDQgKysrKysrKysrKysrKy0tLS0tLQ0KPiAgaW5jbHVkZS9s
aW51eC9wb3dlci9wb3dlcl9vbl9yZWFzb24uaCAgICAgICAgIHwgMTkgKysrKysrKysNCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZpY2VzLXBs
YXRmb3JtLXBvd2VyLW9uLXJlYXNvbg0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGlu
dXgvcG93ZXIvcG93ZXJfb25fcmVhc29uLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtcGxhdGZvcm0tcG93ZXItb24tcmVhc29uIGIv
RG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZpY2VzLXBsYXRmb3JtLXBvd2VyLW9u
LXJlYXNvbg0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjgz
ZGFlYjliMWFhMg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rl
c3Rpbmcvc3lzZnMtZGV2aWNlcy1wbGF0Zm9ybS1wb3dlci1vbi1yZWFzb24NCj4gQEAgLTAsMCAr
MSwxNCBAQA0KPiArV2hhdDoJCS9zeXMvZGV2aWNlcy9wbGF0Zm9ybS8uLi4vcG93ZXJfb25fcmVh
c29uDQo+ICsNCj4gK0RhdGU6CQlPY3RvYmVyIDIwMTkNCj4gK0tlcm5lbFZlcnNpb246CTUuNA0K
PiArQ29udGFjdDoJS2FtZWwgQm91aGFyYSA8a2FtZWwuYm91aGFyYUBib290bGluLmNvbT4NCj4g
K0Rlc2NyaXB0aW9uOglUaGlzIGZpbGUgc2hvd3Mgc3lzdGVtIHBvd2VyIG9uIHJlYXNvbi4NCj4g
KwkJVGhlIHBvc3NpYmxlIHNvdXJjZXMgYXJlOg0KPiArCQlHZW5lcmFsIFN5c3RlbSBQb3dlci1P
TiwgUlRDIHdha2V1cCwgV2F0Y2hkb2cgdGltZW91dCwNCj4gKwkJU29mdHdhcmUgUmVzZXQsIFVz
ZXIgcHJlc3NlZCByZXNldCBidXR0b24sDQo+ICsJCUNQVSBDbG9jayBmYWlsdXJlLCAzMi43Njhr
SHogT3NjaWxsYXRvciBGYWlsdXJlLA0KPiArCQlMb3cgcG93ZXIgbW9kZSBleGl0LCBVbmtub3du
Lg0KPiArDQo+ICsJCVRoZSBmaWxlIGlzIHJlYWQgb25seS4NCj4gKw0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMgYi9kcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0
OTEtcmVzZXQuYw0KPiBpbmRleCA0NGNhOTgzYTQ5YTEuLjNjYjJkZjQwYWYzNyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMNCj4gKysrIGIvZHJpdmVycy9w
b3dlci9yZXNldC9hdDkxLXJlc2V0LmMNCj4gQEAgLTE3LDcgKzE3LDcgQEANCj4gICNpbmNsdWRl
IDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVib290Lmg+DQo+IC0NCj4gKyNpbmNsdWRlIDxsaW51
eC9wb3dlci9wb3dlcl9vbl9yZWFzb24uaD4NCj4gICNpbmNsdWRlIDxzb2MvYXQ5MS9hdDkxc2Ft
OV9kZHJzZHIuaD4NCj4gICNpbmNsdWRlIDxzb2MvYXQ5MS9hdDkxc2FtOV9zZHJhbWMuaD4NCj4g
DQo+IEBAIC0xNDYsNDIgKzE0Niw0MiBAQCBzdGF0aWMgaW50IHNhbXg3X3Jlc3RhcnQoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICp0aGlzLCB1bnNpZ25lZCBsb25nIG1vZGUsDQo+ICAJcmV0dXJuIE5P
VElGWV9ET05FOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyB2b2lkIF9faW5pdCBhdDkxX3Jlc2V0X3N0
YXR1cyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiArc3RhdGljIGNvbnN0IGNoYXIg
KmF0OTFfcmVzZXRfcmVhc29uKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+
ICAJY29uc3QgY2hhciAqcmVhc29uOw0KPiAgCXUzMiByZWcgPSByZWFkbChhdDkxX3JzdGNfYmFz
ZSArIEFUOTFfUlNUQ19TUik7DQo+IA0KPiAgCXN3aXRjaCAoKHJlZyAmIEFUOTFfUlNUQ19SU1RU
WVApID4+IDgpIHsNCj4gIAljYXNlIFJFU0VUX1RZUEVfR0VORVJBTDoNCj4gLQkJcmVhc29uID0g
ImdlbmVyYWwgcmVzZXQiOw0KPiArCQlyZWFzb24gPSBQT1dFUl9PTl9SRUFTT05fR0VORVJBTDsN
Cj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBSRVNFVF9UWVBFX1dBS0VVUDoNCj4gLQkJcmVhc29uID0g
Indha2V1cCI7DQo+ICsJCXJlYXNvbiA9IFBPV0VSX09OX1JFQVNPTl9SVEM7DQo+ICAJCWJyZWFr
Ow0KPiAgCWNhc2UgUkVTRVRfVFlQRV9XQVRDSERPRzoNCj4gLQkJcmVhc29uID0gIndhdGNoZG9n
IHJlc2V0IjsNCj4gKwkJcmVhc29uID0gUE9XRVJfT05fUkVBU09OX1dBVENIRE9HOw0KPiAgCQli
cmVhazsNCj4gIAljYXNlIFJFU0VUX1RZUEVfU09GVFdBUkU6DQo+IC0JCXJlYXNvbiA9ICJzb2Z0
d2FyZSByZXNldCI7DQo+ICsJCXJlYXNvbiA9IFBPV0VSX09OX1JFQVNPTl9TT0ZUV0FSRTsNCj4g
IAkJYnJlYWs7DQo+ICAJY2FzZSBSRVNFVF9UWVBFX1VTRVI6DQo+IC0JCXJlYXNvbiA9ICJ1c2Vy
IHJlc2V0IjsNCj4gKwkJcmVhc29uID0gUE9XRVJfT05fUkVBU09OX1VTRVI7DQo+ICAJCWJyZWFr
Ow0KPiAgCWNhc2UgUkVTRVRfVFlQRV9DUFVfRkFJTDoNCj4gLQkJcmVhc29uID0gIkNQVSBjbG9j
ayBmYWlsdXJlIGRldGVjdGlvbiI7DQo+ICsJCXJlYXNvbiA9IFBPV0VSX09OX1JFQVNPTl9DUFVf
RkFJTDsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBSRVNFVF9UWVBFX1hUQUxfRkFJTDoNCj4gLQkJ
cmVhc29uID0gIjMyLjc2OCBrSHogY3J5c3RhbCBmYWlsdXJlIGRldGVjdGlvbiI7DQo+ICsJCXJl
YXNvbiA9IFBPV0VSX09OX1JFQVNPTl9YVEFMX0ZBSUw7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2Ug
UkVTRVRfVFlQRV9VTFAyOg0KPiAtCQlyZWFzb24gPSAiVUxQMiByZXNldCI7DQo+ICsJCXJlYXNv
biA9IFBPV0VSX09OX1JFQVNPTl9MT1dfUE9XRVI7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6
DQo+IC0JCXJlYXNvbiA9ICJ1bmtub3duIHJlc2V0IjsNCj4gKwkJcmVhc29uID0gUE9XRVJfT05f
UkVBU09OX1VOS05PV047DQo+ICAJCWJyZWFrOw0KPiAgCX0NCj4gDQo+IC0JZGV2X2luZm8oJnBk
ZXYtPmRldiwgIlN0YXJ0aW5nIGFmdGVyICVzXG4iLCByZWFzb24pOw0KPiArCXJldHVybiByZWFz
b247DQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXQ5MV9y
YW1jX29mX21hdGNoW10gPSB7DQo+IEBAIC0yMDQsNiArMjA0LDE3IEBAIHN0YXRpYyBzdHJ1Y3Qg
bm90aWZpZXJfYmxvY2sgYXQ5MV9yZXN0YXJ0X25iID0gew0KPiAgCS5wcmlvcml0eSA9IDE5MiwN
Cj4gIH07DQo+IA0KPiArc3RhdGljIHNzaXplX3QgcG93ZXJfb25fcmVhc29uX3Nob3coc3RydWN0
IGRldmljZSAqZGV2LA0KPiArCQkJCSAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwN
Cj4gKwkJCQkgICAgY2hhciAqYnVmKQ0KPiArew0KPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gKw0KPiArCXJldHVybiBzcHJpbnRm
KGJ1ZiwgIiVzXG4iLCBhdDkxX3Jlc2V0X3JlYXNvbihwZGV2KSk7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBERVZJQ0VfQVRUUl9STyhwb3dlcl9vbl9yZWFzb24pOw0KPiArDQo+ICBzdGF0aWMgaW50
IF9faW5pdCBhdDkxX3Jlc2V0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICB7DQo+ICAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2g7DQo+IEBAIC0yNDgsNyAr
MjU5LDE0IEBAIHN0YXRpYyBpbnQgX19pbml0IGF0OTFfcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+IA0KPiAtCWF0OTFf
cmVzZXRfc3RhdHVzKHBkZXYpOw0KPiArCXJldCA9IGRldmljZV9jcmVhdGVfZmlsZSgmcGRldi0+
ZGV2LCAmZGV2X2F0dHJfcG93ZXJfb25fcmVhc29uKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRl
dl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCBjcmVhdGUgc3lzZnMgZW50cnlcbiIpOw0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCWRldl9pbmZvKCZwZGV2LT5kZXYsICJTdGFy
dGluZyBhZnRlciAlcyByZXNldFxuIiwNCj4gKwkJIGF0OTFfcmVzZXRfcmVhc29uKHBkZXYpKTsN
Cj4gDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Bv
d2VyL3Bvd2VyX29uX3JlYXNvbi5oIGIvaW5jbHVkZS9saW51eC9wb3dlci9wb3dlcl9vbl9yZWFz
b24uaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjk5Nzhj
Yzc1NzQyNw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcG93ZXIvcG93
ZXJfb25fcmVhc29uLmgNCj4gQEAgLTAsMCArMSwxOSBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPiArLyoNCj4gKyAqIEF1dGhvcjogS2FtZWwgQm91
aHJhIDxrYW1lbC5ib3VoYXJhQGJvb3RsaW4uY29tPg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYg
UE9XRVJfT05fUkVBU09OX0gNCj4gKyNkZWZpbmUgUE9XRVJfT05fUkVBU09OX0gNCj4gKw0KPiAr
I2RlZmluZSBQT1dFUl9PTl9SRUFTT05fR0VORVJBTCAiR2VuZXJhbCINCj4gKyNkZWZpbmUgUE9X
RVJfT05fUkVBU09OX1JUQyAiUlRDIHdha2V1cCINCj4gKyNkZWZpbmUgUE9XRVJfT05fUkVBU09O
X1dBVENIRE9HICJXYXRjaGRvZyB0aW1lb3V0Ig0KPiArI2RlZmluZSBQT1dFUl9PTl9SRUFTT05f
U09GVFdBUkUgIlNvZnR3YXJlIg0KPiArI2RlZmluZSBQT1dFUl9PTl9SRUFTT05fVVNFUiAiVXNl
ciINCj4gKyNkZWZpbmUgUE9XRVJfT05fUkVBU09OX0NQVV9GQUlMICJDUFUgQ2xvY2sgRmFpbHVy
ZSINCj4gKyNkZWZpbmUgUE9XRVJfT05fUkVBU09OX1hUQUxfRkFJTCAiMzIuNzY4ayBDcnlzdGFs
IG9zY2lsbGF0b3IgRmFpbHVyZSINCj4gKyNkZWZpbmUgUE9XRVJfT05fUkVBU09OX0xPV19QT1dF
UiAiTG93IHBvd2VyIGV4aXQiDQo+ICsjZGVmaW5lIFBPV0VSX09OX1JFQVNPTl9VTktOT1dOICJV
bmtub3duIg0KPiArDQo+ICsjZW5kaWYgLyogUE9XRVJfT05fUkVBU09OX0ggKi8NCg0KSXMgdGhp
cyBuZXcgaGVhZGVyIG5lY2Vzc2FyeT8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0K
PiAtLQ0KPiAyLjIzLjANCj4gDQo+IA0K

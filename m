Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9656A10D494
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfK2LPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:15:22 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4777 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:15:21 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: u5/hn2/4mpykZoYvjM3Pd1UIsg/4tTZfhwQv7r8tqtbuw7vm9uupFBEV6l0iEWL1ApkSyQLGqo
 LZCEJ12pd4BNmTwFdxRQMGb6KfkwmUcuZZON/VPex63W2vhLTTO4M/4e95r5qymcgRgCO2HDI8
 ZMiUYryedQwWAYXaG+Y8RN7e9DG0ks1flV3mN0DmLatgs1VUQRjHCH9wFrX11RwK6pPbmP1dzJ
 JjEP2kA0+iTw0HVHhTIR/PaigraVt4SGmww0aTxnFAgZVNRPgVa06tHJjeWvH25x5hTrQ10TXm
 Nw8=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="57276019"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 04:15:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 04:15:19 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 29 Nov 2019 04:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/8VtkJb9imnVHg8x1xK5Kf0fu8n8lvLQ5RpPKi0dBj/0LXxEHDcT5VqN4H8M9MKrHjBQDuo7bnUlo3AfLatKzTadOK/hiMdvGMoz3239PgVIFeJp939ux6swUr6saMIMRRi+xueuR1Und61BWKVFXUeqLhpI9LsJAwqXaZwXjNGnsRXAQdqpSJSDq3ibsYnEVPw5E+r1GQZVDE6S5jDeQNggOckwVceYm66EqcB+5V6ihpiOvXiZy0MhVj1OOgFt9J1Pjr1M0+fW24/mhLd6Gs8F7z3Xc8Zoip5+XV9wR28LPtXWf612ibpd7iQKM5T6AgKgihjPizca/5zia+RAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkUt9w7CPOxidC9msuoeI3Otip4NRh24RmoGfoom8C8=;
 b=nJ39GAG9HKV4XHIVIg/Sa+Tf0+AlstAudw3OtFODR6INO67GnEyRxeHU/Q8PoLppZ4So3eWwfMyAtR+WF3xJD5bouibEuSyrBVWepKM39jmUK04Mx9VyuaYiqXVuw+NT5T69b1MFZpdVCAXIjgcWOu62cQMksYWEGOAQw1L3QcaDVj1+pqOaGfYDi7BI8WiIcLqmaLQDgDZi6A2IP40xKweS6Un3TJiAEPmuq2YgXWnCvUzYYEzmluXNh5Kix/OOcEmPcscCbXRiDxt6Nxe/6gkYUvdesopmMSoQogghZc9rYZLVk5AEtr1kn4aunizaYWOSuu5O06x8NUZfDudlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkUt9w7CPOxidC9msuoeI3Otip4NRh24RmoGfoom8C8=;
 b=in74dIPa1w3L5iawUniJPoM0cwATT7y5sy1bNlua6rBbxh6MRLoTB6d9VCv7ajLKCcNU76itAk0nnwS8jiUZQnGuqg3cnDOI0tQij2TNus+CEEcMPl45+ailnpoM35G5CKiO0ur+lTJBn2yofTenySoY+0npyd4Ady1IPFx6nbc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1883.namprd11.prod.outlook.com (10.175.87.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 11:15:18 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2495.014; Fri, 29 Nov
 2019 11:15:18 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <kamel.bouhara@bootlin.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sre@kernel.org>,
        <Ludovic.Desroches@microchip.com>, <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Thread-Topic: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Thread-Index: AQHVhOg1ctfVLowJVU2Cc9kl1+OI1KeiPdiAgAABb4CAAANmgA==
Date:   Fri, 29 Nov 2019 11:15:18 +0000
Message-ID: <00f4e9a2-f6bd-9242-cafd-9c0c4f4dc619@microchip.com>
References: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
 <034c9d01-633a-eeaa-f61f-d185be7227f2@microchip.com>
 <20191129110253.GX299836@piout.net>
In-Reply-To: <20191129110253.GX299836@piout.net>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::31) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129131503049
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b3afca4-ce3f-47d7-24c1-08d774bd6a5a
x-ms-traffictypediagnostic: DM5PR11MB1883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1883A785AE98481031B61469E8460@DM5PR11MB1883.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(53546011)(6506007)(386003)(6486002)(186003)(26005)(11346002)(102836004)(71200400001)(71190400001)(446003)(2616005)(6436002)(86362001)(31696002)(14444005)(256004)(52116002)(76176011)(5660300002)(36756003)(66446008)(64756008)(66556008)(66476007)(66946007)(31686004)(6512007)(6636002)(8676002)(81156014)(81166006)(6306002)(8936002)(6246003)(966005)(14454004)(4326008)(7736002)(305945005)(66066001)(316002)(54906003)(99286004)(110136005)(2906002)(478600001)(6116002)(25786009)(229853002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1883;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mNqYDLfqju4NbHsTWcOmehm1Dp8oXMSJEv3sDhGwbOQLixx4BQ23dwvlRHGtOhczy4fycHpeeWPNjEHAZ9vYDKKoj1Eq3pd9/zSllp8WIWfzBcNNylEk3SAEItb3qEaHeClTc2Swbva8KLeud0gEkAcVEqH0PeNibmHKYjp2bG5rEcWUdC+Ry0KqxMIgiNWhAehEaOB8qDKiO81cWm65BUq8tVNyXKBwUyl1JnDX+mgUvGuJEhNQELRBXKgnjQMWB1yt8LWM7kwWPPW/5UQSS/1f7J2C3mmcfkDhi/6DhoFVyexZ0KYkBiydl7KtF5nOZzr76dcxbb3xCdzj78yHSWtsn5EMAQ2kHujlYT6qxgHD9CLFKDr/sg6QnO6twZikeuFbadiF0uWHjT9lLCqCAy4K2z5SXyAYm5vctM3iHD4UCo55Mo9HY5tIrNr2ou31rzV94HxeMpelB4Nmsy86bMA9k1CH1XoI/dTS8L2y4U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <272A4C50138D21468F19C7FC4700AD6A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3afca4-ce3f-47d7-24c1-08d774bd6a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 11:15:18.0576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTh7pcR7nuiVNagjILDdW4KGBmKNl3D8mZ53LaueGZ8HzabEBOtv5+EWTLK+DNCiFmFs0frykdXweg4EONdfFVDiXkIIGXCF8lorQPpxsZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1883
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDI5LjExLjIwMTkgMTM6MDIsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KDQo+IE9u
IDI5LzExLzIwMTkgMTA6NTc6NDUrMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+IEhpIEthbWVsLA0KPj4NCj4+IE9uIDE3LjEwLjIwMTkgMTU6NDAsIEthbWVsIEJv
dWhhcmEgd3JvdGU6DQo+Pj4gVGhpcyBwYXRjaCBleHBvcnQgdGhlIHBvd2VyIG9uIHJlYXNvbiB0
aHJvdWdoIHRoZSBzeXNmcyBpbnRlcmZhY2UgYW5kDQo+Pj4gaW50cm9kdWNlIHNvbWUgZ2VuZXJp
YyByZXNldCBzb3VyY2VzLg0KPj4+IFVwZGF0ZSB0aGUgQUJJIGRvY3VtZW50YXRpb24gdG8gbGlz
dCBjdXJyZW50IHBvd2VyIG9uIHNvdXJjZXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBLYW1l
bCBCb3VoYXJhIDxrYW1lbC5ib3VoYXJhQGJvb3RsaW4uY29tPg0KPj4+IC0tLQ0KPj4+ICAgLi4u
L3N5c2ZzLWRldmljZXMtcGxhdGZvcm0tcG93ZXItb24tcmVhc29uICAgIHwgMTQgKysrKysrDQo+
Pj4gICBkcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtcmVzZXQuYyAgICAgICAgICAgICAgfCA0NCAr
KysrKysrKysrKysrLS0tLS0tDQo+Pj4gICBpbmNsdWRlL2xpbnV4L3Bvd2VyL3Bvd2VyX29uX3Jl
YXNvbi5oICAgICAgICAgfCAxOSArKysrKysrKw0KPj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2NCBp
bnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtcGxhdGZvcm0tcG93ZXItb24t
cmVhc29uDQo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9wb3dlci9wb3dl
cl9vbl9yZWFzb24uaA0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rl
c3Rpbmcvc3lzZnMtZGV2aWNlcy1wbGF0Zm9ybS1wb3dlci1vbi1yZWFzb24gYi9Eb2N1bWVudGF0
aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtcGxhdGZvcm0tcG93ZXItb24tcmVhc29uDQo+
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjgzZGFlYjli
MWFhMg0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0
aW5nL3N5c2ZzLWRldmljZXMtcGxhdGZvcm0tcG93ZXItb24tcmVhc29uDQo+Pj4gQEAgLTAsMCAr
MSwxNCBAQA0KPj4+ICtXaGF0OiAgICAgICAgICAgICAgL3N5cy9kZXZpY2VzL3BsYXRmb3JtLy4u
Li9wb3dlcl9vbl9yZWFzb24NCj4+PiArDQo+Pj4gK0RhdGU6ICAgICAgICAgICAgICBPY3RvYmVy
IDIwMTkNCj4+PiArS2VybmVsVmVyc2lvbjogICAgIDUuNA0KPj4+ICtDb250YWN0OiAgIEthbWVs
IEJvdWhhcmEgPGthbWVsLmJvdWhhcmFAYm9vdGxpbi5jb20+DQo+Pj4gK0Rlc2NyaXB0aW9uOiAg
ICAgICBUaGlzIGZpbGUgc2hvd3Mgc3lzdGVtIHBvd2VyIG9uIHJlYXNvbi4NCj4+PiArICAgICAg
ICAgICBUaGUgcG9zc2libGUgc291cmNlcyBhcmU6DQo+Pj4gKyAgICAgICAgICAgR2VuZXJhbCBT
eXN0ZW0gUG93ZXItT04sIFJUQyB3YWtldXAsIFdhdGNoZG9nIHRpbWVvdXQsDQo+Pj4gKyAgICAg
ICAgICAgU29mdHdhcmUgUmVzZXQsIFVzZXIgcHJlc3NlZCByZXNldCBidXR0b24sDQo+Pj4gKyAg
ICAgICAgICAgQ1BVIENsb2NrIGZhaWx1cmUsIDMyLjc2OGtIeiBPc2NpbGxhdG9yIEZhaWx1cmUs
DQo+Pj4gKyAgICAgICAgICAgTG93IHBvd2VyIG1vZGUgZXhpdCwgVW5rbm93bi4NCj4+PiArDQo+
Pj4gKyAgICAgICAgICAgVGhlIGZpbGUgaXMgcmVhZCBvbmx5Lg0KPj4+ICsNCj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMgYi9kcml2ZXJzL3Bvd2VyL3Jl
c2V0L2F0OTEtcmVzZXQuYw0KPj4+IGluZGV4IDQ0Y2E5ODNhNDlhMS4uM2NiMmRmNDBhZjM3IDEw
MDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jDQo+Pj4gKysr
IGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMNCj4+PiBAQCAtMTcsNyArMTcsNyBA
QA0KPj4+ICAgI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4+PiAgICNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4+PiAgICNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4N
Cj4+PiAtDQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9wb3dlci9wb3dlcl9vbl9yZWFzb24uaD4NCj4+
PiAgICNpbmNsdWRlIDxzb2MvYXQ5MS9hdDkxc2FtOV9kZHJzZHIuaD4NCj4+PiAgICNpbmNsdWRl
IDxzb2MvYXQ5MS9hdDkxc2FtOV9zZHJhbWMuaD4NCj4+Pg0KPj4+IEBAIC0xNDYsNDIgKzE0Niw0
MiBAQCBzdGF0aWMgaW50IHNhbXg3X3Jlc3RhcnQoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICp0aGlz
LCB1bnNpZ25lZCBsb25nIG1vZGUsDQo+Pj4gICAgICByZXR1cm4gTk9USUZZX0RPTkU7DQo+Pj4g
ICB9DQo+Pj4NCj4+PiAtc3RhdGljIHZvaWQgX19pbml0IGF0OTFfcmVzZXRfc3RhdHVzKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4gK3N0YXRpYyBjb25zdCBjaGFyICphdDkxX3Jl
c2V0X3JlYXNvbihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAgew0KPj4+ICAg
ICAgY29uc3QgY2hhciAqcmVhc29uOw0KPj4+ICAgICAgdTMyIHJlZyA9IHJlYWRsKGF0OTFfcnN0
Y19iYXNlICsgQVQ5MV9SU1RDX1NSKTsNCj4+Pg0KPj4+ICAgICAgc3dpdGNoICgocmVnICYgQVQ5
MV9SU1RDX1JTVFRZUCkgPj4gOCkgew0KPj4+ICAgICAgY2FzZSBSRVNFVF9UWVBFX0dFTkVSQUw6
DQo+Pj4gLSAgICAgICAgICAgcmVhc29uID0gImdlbmVyYWwgcmVzZXQiOw0KPj4+ICsgICAgICAg
ICAgIHJlYXNvbiA9IFBPV0VSX09OX1JFQVNPTl9HRU5FUkFMOw0KPj4+ICAgICAgICAgICAgICBi
cmVhazsNCj4+PiAgICAgIGNhc2UgUkVTRVRfVFlQRV9XQUtFVVA6DQo+Pj4gLSAgICAgICAgICAg
cmVhc29uID0gIndha2V1cCI7DQo+Pj4gKyAgICAgICAgICAgcmVhc29uID0gUE9XRVJfT05fUkVB
U09OX1JUQzsNCj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICBjYXNlIFJFU0VUX1RZ
UEVfV0FUQ0hET0c6DQo+Pj4gLSAgICAgICAgICAgcmVhc29uID0gIndhdGNoZG9nIHJlc2V0IjsN
Cj4+PiArICAgICAgICAgICByZWFzb24gPSBQT1dFUl9PTl9SRUFTT05fV0FUQ0hET0c7DQo+Pj4g
ICAgICAgICAgICAgIGJyZWFrOw0KPj4+ICAgICAgY2FzZSBSRVNFVF9UWVBFX1NPRlRXQVJFOg0K
Pj4+IC0gICAgICAgICAgIHJlYXNvbiA9ICJzb2Z0d2FyZSByZXNldCI7DQo+Pj4gKyAgICAgICAg
ICAgcmVhc29uID0gUE9XRVJfT05fUkVBU09OX1NPRlRXQVJFOw0KPj4+ICAgICAgICAgICAgICBi
cmVhazsNCj4+PiAgICAgIGNhc2UgUkVTRVRfVFlQRV9VU0VSOg0KPj4+IC0gICAgICAgICAgIHJl
YXNvbiA9ICJ1c2VyIHJlc2V0IjsNCj4+PiArICAgICAgICAgICByZWFzb24gPSBQT1dFUl9PTl9S
RUFTT05fVVNFUjsNCj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICBjYXNlIFJFU0VU
X1RZUEVfQ1BVX0ZBSUw6DQo+Pj4gLSAgICAgICAgICAgcmVhc29uID0gIkNQVSBjbG9jayBmYWls
dXJlIGRldGVjdGlvbiI7DQo+Pj4gKyAgICAgICAgICAgcmVhc29uID0gUE9XRVJfT05fUkVBU09O
X0NQVV9GQUlMOw0KPj4+ICAgICAgICAgICAgICBicmVhazsNCj4+PiAgICAgIGNhc2UgUkVTRVRf
VFlQRV9YVEFMX0ZBSUw6DQo+Pj4gLSAgICAgICAgICAgcmVhc29uID0gIjMyLjc2OCBrSHogY3J5
c3RhbCBmYWlsdXJlIGRldGVjdGlvbiI7DQo+Pj4gKyAgICAgICAgICAgcmVhc29uID0gUE9XRVJf
T05fUkVBU09OX1hUQUxfRkFJTDsNCj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICBj
YXNlIFJFU0VUX1RZUEVfVUxQMjoNCj4+PiAtICAgICAgICAgICByZWFzb24gPSAiVUxQMiByZXNl
dCI7DQo+Pj4gKyAgICAgICAgICAgcmVhc29uID0gUE9XRVJfT05fUkVBU09OX0xPV19QT1dFUjsN
Cj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICBkZWZhdWx0Og0KPj4+IC0gICAgICAg
ICAgIHJlYXNvbiA9ICJ1bmtub3duIHJlc2V0IjsNCj4+PiArICAgICAgICAgICByZWFzb24gPSBQ
T1dFUl9PTl9SRUFTT05fVU5LTk9XTjsNCj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAg
ICB9DQo+Pj4NCj4+PiAtICAgZGV2X2luZm8oJnBkZXYtPmRldiwgIlN0YXJ0aW5nIGFmdGVyICVz
XG4iLCByZWFzb24pOw0KPj4+ICsgICByZXR1cm4gcmVhc29uOw0KPj4+ICAgfQ0KPj4+DQo+Pj4g
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhdDkxX3JhbWNfb2ZfbWF0Y2hbXSA9
IHsNCj4+PiBAQCAtMjA0LDYgKzIwNCwxNyBAQCBzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2Nr
IGF0OTFfcmVzdGFydF9uYiA9IHsNCj4+PiAgICAgIC5wcmlvcml0eSA9IDE5MiwNCj4+PiAgIH07
DQo+Pj4NCj4+PiArc3RhdGljIHNzaXplX3QgcG93ZXJfb25fcmVhc29uX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjaGFyICpidWYpDQo+Pj4gK3sNCj4+PiArICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPj4+ICsNCj4+PiArICAgcmV0dXJuIHNwcmlu
dGYoYnVmLCAiJXNcbiIsIGF0OTFfcmVzZXRfcmVhc29uKHBkZXYpKTsNCj4+PiArfQ0KPj4+ICsN
Cj4+PiArc3RhdGljIERFVklDRV9BVFRSX1JPKHBvd2VyX29uX3JlYXNvbik7DQo+Pj4gKw0KPj4+
ICAgc3RhdGljIGludCBfX2luaXQgYXQ5MV9yZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPj4+ICAgew0KPj4+ICAgICAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAq
bWF0Y2g7DQo+Pj4gQEAgLTI0OCw3ICsyNTksMTQgQEAgc3RhdGljIGludCBfX2luaXQgYXQ5MV9y
ZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPj4+ICAgICAgfQ0KPj4+DQo+Pj4gLSAgIGF0OTFfcmVzZXRfc3RhdHVz
KHBkZXYpOw0KPj4+ICsgICByZXQgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoJnBkZXYtPmRldiwgJmRl
dl9hdHRyX3Bvd2VyX29uX3JlYXNvbik7DQo+Pj4gKyAgIGlmIChyZXQpIHsNCj4+PiArICAgICAg
ICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3VsZCBub3QgY3JlYXRlIHN5c2ZzIGVudHJ5XG4i
KTsNCj4+PiArICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+ICsgICB9DQo+Pj4gKw0KPj4+ICsg
ICBkZXZfaW5mbygmcGRldi0+ZGV2LCAiU3RhcnRpbmcgYWZ0ZXIgJXMgcmVzZXRcbiIsDQo+Pj4g
KyAgICAgICAgICAgIGF0OTFfcmVzZXRfcmVhc29uKHBkZXYpKTsNCj4+Pg0KPj4+ICAgICAgcmV0
dXJuIDA7DQo+Pj4gICB9DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcG93ZXIvcG93
ZXJfb25fcmVhc29uLmggYi9pbmNsdWRlL2xpbnV4L3Bvd2VyL3Bvd2VyX29uX3JlYXNvbi5oDQo+
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjk5NzhjYzc1
NzQyNw0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3Bvd2VyL3Bv
d2VyX29uX3JlYXNvbi5oDQo+Pj4gQEAgLTAsMCArMSwxOSBAQA0KPj4+ICsvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+Pj4gKy8qDQo+Pj4gKyAqIEF1dGhvcjog
S2FtZWwgQm91aHJhIDxrYW1lbC5ib3VoYXJhQGJvb3RsaW4uY29tPg0KPj4+ICsgKi8NCj4+PiAr
DQo+Pj4gKyNpZm5kZWYgUE9XRVJfT05fUkVBU09OX0gNCj4+PiArI2RlZmluZSBQT1dFUl9PTl9S
RUFTT05fSA0KPj4+ICsNCj4+PiArI2RlZmluZSBQT1dFUl9PTl9SRUFTT05fR0VORVJBTCAiR2Vu
ZXJhbCINCj4+PiArI2RlZmluZSBQT1dFUl9PTl9SRUFTT05fUlRDICJSVEMgd2FrZXVwIg0KPj4+
ICsjZGVmaW5lIFBPV0VSX09OX1JFQVNPTl9XQVRDSERPRyAiV2F0Y2hkb2cgdGltZW91dCINCj4+
PiArI2RlZmluZSBQT1dFUl9PTl9SRUFTT05fU09GVFdBUkUgIlNvZnR3YXJlIg0KPj4+ICsjZGVm
aW5lIFBPV0VSX09OX1JFQVNPTl9VU0VSICJVc2VyIg0KPj4+ICsjZGVmaW5lIFBPV0VSX09OX1JF
QVNPTl9DUFVfRkFJTCAiQ1BVIENsb2NrIEZhaWx1cmUiDQo+Pj4gKyNkZWZpbmUgUE9XRVJfT05f
UkVBU09OX1hUQUxfRkFJTCAiMzIuNzY4ayBDcnlzdGFsIG9zY2lsbGF0b3IgRmFpbHVyZSINCg0K
SGksDQoNCkxvb2tzIHJhdGhlciBvZGQgdG8gaGF2ZSBhIGhhcmRjb2RlZCBjcnlzdGFsIHZhbHVl
IGluc2lkZSBhIGdlbmVyaWMgaGVhZGVyLg0KQWxzbyBob3cgaXMgUkVBU09OX0NQVV9GQUlMIHJl
bGF0ZWQgdG8gQ1BVIENsb2NrID8NCg0KRXVnZW4NCg0KPj4+ICsjZGVmaW5lIFBPV0VSX09OX1JF
QVNPTl9MT1dfUE9XRVIgIkxvdyBwb3dlciBleGl0Ig0KPj4+ICsjZGVmaW5lIFBPV0VSX09OX1JF
QVNPTl9VTktOT1dOICJVbmtub3duIg0KPj4+ICsNCj4+PiArI2VuZGlmIC8qIFBPV0VSX09OX1JF
QVNPTl9IICovDQo+Pg0KPj4gSXMgdGhpcyBuZXcgaGVhZGVyIG5lY2Vzc2FyeT8NCj4+DQo+IA0K
PiBZZXMgYmVjYXVzZSB3ZSB3YW50IG90aGVyIGRyaXZlcnMgdG8gYmUgYWJsZSB0byByZXVzZSB0
aGVtIGFzLWlzIHNvIHRoZQ0KPiBBQkkgaXMgc3RhYmxlLg0KPiANCj4gLS0NCj4gQWxleGFuZHJl
IEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmlu
Zw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQo+IA0K

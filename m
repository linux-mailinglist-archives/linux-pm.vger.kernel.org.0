Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DFA17D785
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 01:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCIApe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 20:45:34 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:30693
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgCIApd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Mar 2020 20:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH7iAURSpw39b8JPLJ5h9YaMn60Yu5Gxox2LcWqf1Xu1bE6q7pOVLJ7MMAVGFjYbXGaxTdPZeBQqfDTHFQf4hl96kHLk4Rui9ffeOqGaQzuPOrbiHjGeeAaAJUWradhmKF/oQgKTitkeX3cbOKJBbUXeVvjIiHu7O8+dSLyUZ/ADx01QSixv5TNtrzTryEug9fKiZRVm1TcKXElODCa1163y6CtA8XTMr1zexY9KbQuPdiPD+7GrIeXMpKDjyla5SVttmAPgpMwTDi1z5hcexOL6yMraOjpJfYFtWxCDLl6rChf0Ps+MEcTXEZEll662BmnO/PfZn9pH2hKAJjygiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZYlF98l73Xk1yo7Rhbc2KoRItKsdu1F7yHHdelc+eY=;
 b=cWz+MKr13ZctPUlWFNcwcMO4ER8aqND3TJXWqseSQCGtC5OmniwlUmd5UPxoq0budCKRroXA5e5LSMYnZJ+zGnW1V6+BtYUDXnqOFve35vBAzmK5notr6yxKUVsGB3kTCbLY1msKi4MJFRin3YpKtQ88P6aR6NiVuVuKJ+IAw9refkBLac7M9r7x0ZaEgNK9Mimb5wLg+SL7Yz4NXtvT+DLEVeTGTtsIsLNwKjUvWjdCV5uvoHPIqN+cR4xq5UP86JQPOI5u0AoVmcJLdsr6SAtj1AxXkSemjn+z5z26O9KyODAfApyBviXqeeX3+QMuNFp1LDMxYLdadd5KYLHrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZYlF98l73Xk1yo7Rhbc2KoRItKsdu1F7yHHdelc+eY=;
 b=H/6vRhTwITjSysWJJuYIUWWEDUXwWW7VmvsB5idKJuPXDt4l/HiX/BRgy1ZCmRDgMdJkflE2VCWuU3UBbjYbDPVPiEwn8jV5Km7xh/4ZDq8IgarRewvc2cW/D60HiYwyfmo2E9UXIPfRNAXYl1vIv4zTphEJJsOwybHRNu5QLR4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 00:45:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 00:45:27 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V2 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9CBLTCB9eihrjkCYi2RNsTJEoqg/Y1uAgAAMPsA=
Date:   Mon, 9 Mar 2020 00:45:27 +0000
Message-ID: <DB3PR0402MB3916F180023599ED4A983384F5FE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
 <63862bdf-874f-86d3-3bb5-b41185efffe1@roeck-us.net>
In-Reply-To: <63862bdf-874f-86d3-3bb5-b41185efffe1@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34605ca5-822f-42bf-c6a5-08d7c3c32967
x-ms-traffictypediagnostic: DB3PR0402MB3897:|DB3PR0402MB3897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38971F0DC5BECD0BBDC0D824F5FE0@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(55016002)(81156014)(53546011)(33656002)(86362001)(81166006)(4326008)(7416002)(7696005)(9686003)(6506007)(8676002)(110136005)(52536014)(186003)(5660300002)(316002)(66556008)(66946007)(76116006)(64756008)(66446008)(71200400001)(44832011)(2906002)(8936002)(478600001)(26005)(66476007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MltNxdzNZzVv3au0ow2A2tTKaqp4dlSDABEsWLk4K1x2N4gzi+GLS01rLYQiMsb867z7STu7sqSCY0IyKsV4ZfghuBzBN2o5DOKXZU3n1j6Cvn4wzDvniCU7qyDVeSCbPEa//JEpV+OI69FmZYMJDDZHhp0p8NaZ2hbN22K4K1/yWMtGB42C67JumBIqX10GrivwDBYgGUB11H+QF3olOW9i/T8xyLDedUDBOLxg6o8Y0P/Wbi0oEJZLl7GJTKlfmPfv41aGeYDhRCyfZwmkk8KqErQJ+H2oRJbIDdsHhKicajMhXwBgq3prskFWVrWQoBniMEiEXX/Lm7RC8GTLOAejsrl1kCi5T2dgIMi5lYVoYA7HsDxWoWiI3VOqJaYhj5+7VHBkiZZVyEhSMFZAk7Z2uygaDJUuw3NQGb9/cyDMS2b+ga3+lcE+16z/ynakKK63XSkdIydra4T0d6JrsiV/kJgRby78NNc5Nmp3IS0ZO0DeP/mMSgQt6+BRFWKa
x-ms-exchange-antispam-messagedata: YU58KKl3vaoVxREzRLp5YFXeN3UFbUkJ2Pby+hAy93gaWCSUVVs8EBDlL1cDBUEh/afcoemJahS90JIDdnNXuGzPxkyzs0wS+ClH1trOxH9BfkSjsqahoe0VjaasD0v+ixGLtW6MCNRjjQfNQb3Qjw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34605ca5-822f-42bf-c6a5-08d7c3c32967
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 00:45:27.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPquhdx4QlX7BKfZJKfSskTPlUvBD+ETs5nNWalIRr7AbS80ykmNn+5GK4AAg8Af3NNE86eYwhBcnwFoCu2Bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEd1ZW50ZXINCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDEvN10gZmlybXdhcmU6IGlt
eDogQWRkIHN0dWJzIGZvciAhQ09ORklHX0lNWF9TQ1UNCj4gY2FzZQ0KPiANCj4gT24gMy82LzIw
IDU6MjUgUE0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEFkZCBzdHVicyBmb3IgdGhvc2UgaS5N
WCBTQ1UgQVBJcyB0byBtYWtlIHRob3NlIG1vZHVsZXMgZGVwZW5kaW5nIG9uDQo+ID4gSU1YX1ND
VSBjYW4gcGFzcyBidWlsZCB3aGVuIENPTVBJTEVfVEVTVCBpcyBlbmFibGVkLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gbmV3IHBhdGNoLg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lt
eC9pcGMuaCB8IDExICsrKysrKysrKysrDQo+ID4gaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgv
c2NpLmggfCAxOSArKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzAg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmlybXdh
cmUvaW14L2lwYy5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9pcGMuaA0KPiA+
IGluZGV4IDg5MTA1NzQuLjNmZmYwZTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9m
aXJtd2FyZS9pbXgvaXBjLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9p
cGMuaA0KPiA+IEBAIC0zNCw2ICszNCw3IEBAIHN0cnVjdCBpbXhfc2NfcnBjX21zZyB7DQo+ID4g
IAl1aW50OF90IGZ1bmM7DQo+ID4gIH07DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19JTVhfU0NV
DQo+ID4gIC8qDQo+ID4gICAqIFRoaXMgaXMgYW4gZnVuY3Rpb24gdG8gc2VuZCBhbiBSUEMgbWVz
c2FnZSBvdmVyIGFuIElQQyBjaGFubmVsLg0KPiA+ICAgKiBJdCBpcyBjYWxsZWQgYnkgY2xpZW50
LXNpZGUgU0NGVyBBUEkgZnVuY3Rpb24gc2hpbXMuDQo+ID4gQEAgLTU1LDQgKzU2LDE0IEBAIGlu
dCBpbXhfc2N1X2NhbGxfcnBjKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHZvaWQNCj4gKm1zZywg
Ym9vbCBoYXZlX3Jlc3ApOw0KPiA+ICAgKiBAcmV0dXJuIFJldHVybnMgYW4gZXJyb3IgY29kZSAo
MCA9IHN1Y2Nlc3MsIGZhaWxlZCBpZiA8IDApDQo+ID4gICAqLw0KPiA+ICBpbnQgaW14X3NjdV9n
ZXRfaGFuZGxlKHN0cnVjdCBpbXhfc2NfaXBjICoqaXBjKTsNCj4gPiArI2Vsc2UNCj4gPiArc3Rh
dGljIGlubGluZSBpbnQgaW14X3NjdV9jYWxsX3JwYyhzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB2
b2lkICptc2csDQo+ID4gK2Jvb2wgaGF2ZV9yZXNwKSB7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBpbXhfc2N1X2dldF9oYW5kbGUoc3RydWN0IGlteF9z
Y19pcGMgKippcGMpIHsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+
ICAjZW5kaWYgLyogX1NDX0lQQ19IICovDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2ku
aA0KPiA+IGluZGV4IDE3YmE0ZTQuLjQ2ODhiNjAgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJl
L2lteC9zY2kuaA0KPiA+IEBAIC0xNiw4ICsxNiwyNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgv
ZmlybXdhcmUvaW14L3N2Yy9taXNjLmg+ICAjaW5jbHVkZQ0KPiA+IDxsaW51eC9maXJtd2FyZS9p
bXgvc3ZjL3BtLmg+DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19JTVhfU0NVDQo+ID4gIGludCBp
bXhfc2N1X2VuYWJsZV9nZW5lcmFsX2lycV9jaGFubmVsKHN0cnVjdCBkZXZpY2UgKmRldik7ICBp
bnQNCj4gPiBpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxv
Y2sgKm5iKTsgIGludA0KPiA+IGlteF9zY3VfaXJxX3VucmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICpuYik7ICBpbnQNCj4gPiBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUo
dTggZ3JvdXAsIHUzMiBtYXNrLCB1OCBlbmFibGUpOw0KPiA+ICsjZWxzZQ0KPiA+ICtzdGF0aWMg
aW5saW5lIGludCBpbXhfc2N1X2VuYWJsZV9nZW5lcmFsX2lycV9jaGFubmVsKHN0cnVjdCBkZXZp
Y2UNCj4gPiArKmRldikgew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArc3RhdGljIGlu
bGluZSBpbnQgaW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Js
b2NrDQo+ID4gKypuYikgew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArc3RhdGljIGlu
bGluZSBpbnQgaW14X3NjdV9pcnFfdW5yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3QNCj4gPiArbm90
aWZpZXJfYmxvY2sgKm5iKSB7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtzdGF0aWMg
aW5saW5lIGludCBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUodTggZ3JvdXAsIHUzMiBtYXNrLCB1
OA0KPiA+ICtlbmFibGUpIHsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBJdCB3b3Vs
ZCBwcm9iYWJseSBiZSBtb3JlIGFwcHJvcHJpYXRlIHRvIHJldHVybiBlcnJvcnMgZnJvbSB0aGUg
c3R1Yg0KPiBmdW5jdGlvbnMuDQoNCkFncmVlZCwgaW1wcm92ZSB0aGVtIGluIFYzIHBhdGNoIHNl
cmllcy4NCg0KVGhhbmtzLA0KQW5zb24NCg==

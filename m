Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A221866CD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 09:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgCPIo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 04:44:27 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:31936
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730075AbgCPIo1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 04:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHs4xJvZ1S7egWTlfa6eCclpRlQFY0F2S9C9rRxL8l1Lc4GXq2Yb4keVZthEADLFqVlXBL88z98GLl9HEFt6ydx7Ak4LEKnsMV4rXHMzS3JaUHNoCldCwwl/Rkez64fVdQRNbHyFmVd/X5RXB+kyEB8KcFZuGZXJ+aSbOKUaqLhSJJqtJbwdgvcgVOM+vHhXMXhXz/bGzmcaP6Ros5tFg8l3npoxMixaY548uCjNGVq42G4to3cx4DOc0cIRH7ZyX6wqYZljh02qx5ifyoaGbuqbprTvdwk7g866aOnl+DYjD+/m4/nrgX1ATYsGgtYlZgpCPUKn+4H33s4TE0yX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg4VIhVXYMXP7TWkV2q51SFSYMEaSvUQMe3m9YWsX00=;
 b=eiDkwSJ8w4Fuj0cdyIL4KhhiLaJDgbdSr/jER59QSXlFB9qBx25XpaudDiKK8lVrCdgQOHdYgHrdDZxxA6pP3hXgAwsnCdHpQZgGltVPuWn6Y9GO0X9lmJZkgQ+MLAhsWr0/NcclalE3ChUPTD+g+zRfS3oi2191ShnCCE4ZsxGCFg3QLO4684TFU+Mxlg8FPCH3UFTaY3s+d7kcOfYsxRngrCd1TGGhL5sA/zJbNxGs8dlNw0ydx4UmkYTfBkglMVMRq2nhOygpiub5g4TNVvEBJPxq7i0NseeKFlBDuFrlUfrJ5SxJKN56+zOgi/QI689GN51dYl7b3x3rLC9NUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg4VIhVXYMXP7TWkV2q51SFSYMEaSvUQMe3m9YWsX00=;
 b=VMXHQvoPMQvn3EbW2Al+fvHkkt55UljWEGi70YlA65uwD6P2SHwEH32Ywj4ZF63fZd41M8BpwDzwUOKQMAXuK2opbm5Nyrw77MCxCffZj7ycRW/CDtADnd2+1lM1Cbjq8RQfHi1+m6XgR6sjfuvZeQdjDo0YUmvM0wdAUsxHv1E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Mon, 16 Mar 2020 08:44:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 08:44:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAopwQCAACFfgIAABHaAgAADEYCAAAR+AIAASuWQgAAKpACAAABIoA==
Date:   Mon, 16 Mar 2020 08:44:10 +0000
Message-ID: <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
In-Reply-To: <20200316084056.GG4518@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 253ef0de-ffb7-4f42-b670-08d7c9863295
x-ms-traffictypediagnostic: DB3PR0402MB3689:|DB3PR0402MB3689:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36893B6CF1DD7D7ADEE38D87F5F90@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(316002)(52536014)(7416002)(86362001)(26005)(33656002)(186003)(7696005)(6916009)(6506007)(54906003)(66946007)(66446008)(64756008)(9686003)(55016002)(66556008)(66476007)(76116006)(478600001)(4326008)(71200400001)(2906002)(5660300002)(44832011)(81166006)(81156014)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3CNHR7kYClQQtUTbFix7ZOCYkPUsCa7rZlYN+6hwOybGB7499qm46C00Yi99G2Nwl8uZ4U8Gl2nQlP2MtqHaFveNmqZDUACmBLJep2bm5uP1vMhWOWd75x7FVfMY2so+7u4H8EC0XmH3r+FSazPDSibLpr6YvfYKDWsKRFuDBttjIpgb72VcJTscPm87uPDU6rSp8luKmMZI79mWMJWlafgeRc1aBks5eWEZRUVofk464osg9n9uPpq6AZ6j6oYY6hKkz7ZukD82vBFtIA3Zrlbi23VZEsX5aiq3D7Gzvo4737S9bUygllIcwl9zutxNJ+Z91pBsgBLC6JfXr7J0sqIMpsbbU2exQRVCgD9rn62RUJtkth6lxXUbojvcIAFFy4eLT6CAVwO4ica2Xi0FELeN9gcQy10O8mDTC9t0mA+kdX0RZo5BplqL4F/kTbb
x-ms-exchange-antispam-messagedata: gU4ZJ27MMFAAu6f/QF7R6g3hwmJiKgA5AaMyxzKAINosPytypBE0piQReN1Xywjfs2caD5TZtbjCNu+LESI5bQe779gCZZHI+s6UjwiIAhlBfGP5UOpBL+lSsi6wpuSQz36IB9cM3VuGQy0YtJie+Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ef0de-ffb7-4f42-b670-08d7c9863295
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 08:44:10.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCpXcGjEZwvEjjzyfT81ZjIxtNi+NhcyPgWCflhIyDogj+pLe3tI+gckafrsslbyvzH24Z67oD5rl4hWSeKgJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAxLzddIGZpcm13YXJlOiBpbXg6IEFkZCBzdHVi
cyBmb3IgIUNPTkZJR19JTVhfU0NVDQo+IGNhc2UNCj4gDQo+IE9uIDE2LzAzLzIwMjAgMDg6MDQ6
MTcrMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gSGksIFNoYXduDQo+ID4NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS83XSBmaXJtd2FyZTogaW14OiBBZGQgc3R1YnMgZm9yDQo+
ID4gPiAhQ09ORklHX0lNWF9TQ1UgY2FzZQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgTWFyIDE2LCAy
MDIwIGF0IDAzOjE4OjQzQU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiBKdXN0IHNl
bnQgb3V0LiBPbmUgbW9yZSB0aGluZywgSSB0aGluayBhbGwgZHJpdmVycyBkZXBlbmRzIG9uDQo+
ID4gPiA+IElNWF9TQ1Ugc2hvdWxkIG5vdCBoYXZlIENPTVBJTEVfVEVTVCBpZiB3ZSBwbGFuIG5v
dCB0byBhZGQgZHVtbXkNCj4gPiA+ID4gZnVuY3Rpb25zLiBJIHNlZSB5b3UgcGlja2VkIHVwIEFu
c29uJ3MgcGF0Y2ggaW4gaW14L2RyaXZlcnMgYnJhbmNoLA0KPiBwbGVhc2UgY2hlY2sgbW9yZS4N
Cj4gPiA+DQo+ID4gPiBIYSwgeWVzLiBDT01QSUxFX1RFU1Qgc2hvdWxkIGJlIGRyb3BwZWQgZm9y
IElNWF9TQ1VfUEQgaW4gQW5zb24ncw0KPiBwYXRjaC4NCj4gPiA+IFRoYW5rcyBmb3IgcmVtaW5k
aW5nLg0KPiA+DQo+ID4gSSBzdGlsbCBOT1QgcXVpdGUgdW5kZXJzdGFuZCB3aHkgd2Ugd29uJ3Qg
c3VwcG9ydCBDT01QSUxFX1RFU1QgZm9yIFNDVQ0KPiA+IGRyaXZlcnMsIHdpdGggd2hvc2Ugc3R1
YnMsIHRoZSBidWlsZCBzaG91bGQgYmUgT0ssIGlmIHRoZXJlIGlzIGFueQ0KPiA+IGJ1aWxkIGVy
cm9yLCB3ZSBzaG91bGQgdHJ5IHRvIGZpeCBpdCwgTk9UIGp1c3QgcmVtb3ZlIHRoZSBDT01QSUxF
X1RFU1QNCj4gc3VwcG9ydCwgYW55IHNwZWNpYWwgcmVhc29uPw0KPiA+DQo+IA0KPiBDT01QSUxF
X1RFU1QgaXMgc3VwcG9ydGVkIGFzIGxvbmcgYXMgSU1YX1NDVSBpcyBzZWxlY3RlZCBsaWtlIGlz
IGl0IGZvciBhbnkNCj4gZHJpdmVyIGRlcGVuZGluZyBvbiBhbnkgYnVzLg0KDQpCdXQgd2l0aG91
dCBoYXZpbmcgIiB8fCBDT01QSUxFX1RFU1QgIiBpbiBrY29uZmlnLCBDT01QSUxFX1RFU1Qgd2ls
bCBOT1QgYmUgc3VwcG9ydGVkLA0KSSB0aGluayBhcyBsb25nIGFzIHdlIGhhdmUgc3R1YnMgZm9y
IHRob3NlIFNDVSBBUElzLCBhbGwgZHJpdmVycyBkZXBlbmRpbmcgb24gSU1YX1NDVSBjYW4NCnN1
cHBvcnQgQ09NUElMRV9URVNUIGluZGVwZW5kZW50bHkuDQoNCkFuc29uICANCg==

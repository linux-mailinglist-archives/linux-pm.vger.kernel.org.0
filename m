Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9304D17CA87
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 02:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGBgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 20:36:47 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:14246
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgCGBgr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 20:36:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILvWHR+ST0m81eaKsSkqN2KQVjSXBaglMEm2z1WR+f1aV8tD70gDjv2uyclX1CheHvubj48W+OWpwXjpssMTr1g6GmKeZ95Gr3mS1fM03JuRBf5lK8uH3QxHV1bMun3+Uiv99+2789FBu1JMk9ORWcccUYKF8TW10M05cg49j2lACrcmmqaYn21YtQ7YaqWgj1DC6syOxB+WnnUmn12/q59tNCZ8rnt/hxQmWLQFIIty3yC8ftXNlVBKGi2/xmrUstkr19xiCuIWtip0ZBZl1r+vMyU+dNOhyb03hjoOwdI7M0r75jKfIwtNZDCnfBnQnPXsG2HqTxCa76LToQAywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6khbcMqOFAgFLGrsIlKsHz+X5UCJ4twK4ocS3k+hH4=;
 b=Wtej2Nhcd/6if5iWYfKURBmil5+OQZwysXtOL3IoEe7hPcoXhnKwjuZqDYqVOpBXHlEFx/5Rf853fmZ2gldPTSw8ens3ubBbJRXvPW+pCIljp2ifZ15aytAp/4U1qmSxVQU2Asw4vo1XKkPBJgJ0aFDx8gO9ag5TUS0ZorC0aQIVHwgaL5R0wP09UjZ5HRTnsItRYOCfZQiHCTN63ux+7zOrwhMfd2QgvFIqa9sTAYK2gJBQBRfcMoSQUo1hjm44EN1jiWhngR7OAgO+Me39tK3sq9LO+3mE5Y22kpN54z1gz1/Bi4ck0VQOKGHivB5THHY90EVw6dfF0HiQPWZNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6khbcMqOFAgFLGrsIlKsHz+X5UCJ4twK4ocS3k+hH4=;
 b=GrgDu1DERfL7Crs+GayMBboL4yco6Y2KebhR2+wnY1DH0rBZb/1T3BQWAqOsooniRQW14+J0P1PKybTb2RymSAoXzEZJc7EBWo5cx8zZk/EFIHF5k5hK8lCcXmHvABlzt3vzQrcCx/zrjLiL9827GmfBKEQHCroOEtkSiiH3fx8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Sat, 7 Mar 2020 01:36:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Sat, 7 Mar 2020
 01:36:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?utf-8?B?Um9uYWxkIFRzY2hhbMOkcg==?= <ronald@innovation.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
 KEYBOARD_IMX_SC_KEY
Thread-Topic: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
 KEYBOARD_IMX_SC_KEY
Thread-Index: AQHV887MNanm8ugiD0KiUbBo9lnYDag79IUAgAAJFwCAABOKAIAASDdQ
Date:   Sat, 7 Mar 2020 01:36:39 +0000
Message-ID: <DB3PR0402MB39164192146D17327A45DA6CF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
 <20200306211538.GA8060@piout.net>
In-Reply-To: <20200306211538.GA8060@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae50851e-c2c5-4169-da48-08d7c237fbce
x-ms-traffictypediagnostic: DB3PR0402MB3882:|DB3PR0402MB3882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38825E84B78724440E0DDE6BF5E00@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(55016002)(76116006)(7416002)(9686003)(8936002)(54906003)(52536014)(316002)(7696005)(478600001)(71200400001)(4326008)(86362001)(26005)(110136005)(66446008)(64756008)(66946007)(66556008)(5660300002)(66476007)(53546011)(6506007)(44832011)(2906002)(8676002)(33656002)(81156014)(81166006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3882;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1myGFHIZrCm5TeldWy47hVU/DbljG98VjrAbojOsVyqq9ebjvRJG/gMR/USSVKD4objwRL1ZterLHPKcUlD6CKeOgtvoZ9dF6TZcIJ8ypgYL6B03T/vb6GwraaqBiR8gbAqMWeE5LkhKPYMSq/j9rFYIwi3lg4cvoTAzSLVvp890sSf0nthN8MeYhOMFO60mPwuqzoPYyMJVqbdY5p63onzp7WYZAH8Dsd/8/9wCk+boCLdcAeY+/+pA2/WggS+PKYWlAiS8EtBpGqlLZrulbqdDWCvT5XdE9o4L8fSCRi4hvJxXjBg4EChtEsDsqHxrhYZRVPooZ2CZJx+uj9jAiBUJXWGOcAI7hLDjpSadC9gqA7B76k/U6wp+CqTb3n9HPqUO2C5ekyPF6hBho6ldmU0J1Ra6jlFOCUfq/68XWxQhs8OOtTjI/ndTmQ/bgUOI
x-ms-exchange-antispam-messagedata: wEnk5ULSEK1yZAXUnyS6RTMR1axprM+qXUGWyYFCG/0aPEE7o+ZJUdw+UTaj0IBS+0ut7mEp3PFLTySQka/M0fGoThYCIHKDvpd3JuTgqB6ws7wfq0iEoJPp/2gIls8WO8LnOwfqoKvAWQGI2w0Z0w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae50851e-c2c5-4169-da48-08d7c237fbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 01:36:39.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkT7tseAPuzwjXyIOkLnpO54cjgXl9rEWACrCCAiZWr7bbAntTbQdN4Vx3j6vaVZ5gbC3Js2QCSxhVJTqZYF3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSBpbnB1dDoga2V5Ym9h
cmQ6IGFkZCBDT01QSUxFX1RFU1Qgc3VwcG9ydCBmb3INCj4gS0VZQk9BUkRfSU1YX1NDX0tFWQ0K
PiANCj4gT24gMDYvMDMvMjAyMCAxMjowNTo0Mi0wODAwLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6
DQo+ID4gT24gRnJpLCBNYXIgNiwgMjAyMCBhdCAxMTozMyBBTSBEbWl0cnkgVG9yb2tob3YNCj4g
PiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gRnJp
LCBNYXIgMDYsIDIwMjAgYXQgMTE6NDI6MzRQTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gPiA+IEFkZCBDT01QSUxFX1RFU1Qgc3VwcG9ydCB0byBpLk1YIFNDIGtleWJvYXJkIGRyaXZl
ciBmb3IgYmV0dGVyDQo+ID4gPiA+IGNvbXBpbGUgdGVzdGluZyBjb3ZlcmFnZS4NCj4gPiA+ID4N
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+ID4gPg0KPiA+ID4gQXBwbGllZCwgdGhhbmsgeW91Lg0KPiA+DQo+ID4gQWN0dWFsbHksIG5v
dDoNCj4gPg0KPiA+IEVSUk9SOiAiaW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIiDQo+ID4g
W2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvaW14X3NjX2tleS5rb10gdW5kZWZpbmVkIQ0KPiA+IEVS
Uk9SOiAiaW14X3NjdV9nZXRfaGFuZGxlIiBbZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nf
a2V5LmtvXQ0KPiB1bmRlZmluZWQhDQo+ID4gRVJST1I6ICJpbXhfc2N1X2NhbGxfcnBjIiBbZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nfa2V5LmtvXQ0KPiB1bmRlZmluZWQhDQo+ID4gRVJS
T1I6ICJpbXhfc2N1X2lycV91bnJlZ2lzdGVyX25vdGlmaWVyIg0KPiA+IFtkcml2ZXJzL2lucHV0
L2tleWJvYXJkL2lteF9zY19rZXkua29dIHVuZGVmaW5lZCENCj4gPiBFUlJPUjogImlteF9zY3Vf
aXJxX2dyb3VwX2VuYWJsZSINCj4gPiBbZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nfa2V5
LmtvXSB1bmRlZmluZWQhDQo+ID4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLm1vZHBv
c3Q6OTQ6IF9fbW9kcG9zdF0gRXJyb3IgMQ0KPiA+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTI4Mjog
bW9kdWxlc10gRXJyb3IgMg0KPiA+DQo+ID4gSWYgeW91IHdhbnQgdG8gZW5hYmxlIGNvbXBpbGUg
dGVzdCBjb3ZlcmFnZSB5b3UgbmVlZCB0byBwcm92aWRlIHN0dWJzDQo+ID4gZm9yIHRoZSBhYm92
ZSBmdW5jdGlvbnMuDQo+ID4NCj4gDQo+IG9yIHNlbGVjdCBJTVhfU0NVDQo+IA0KPiBvciBsZWF2
ZSBvdXQgQ09NUElMRV9URVNUIGZyb20gdGhlIGluZGl2aWR1YWwgZHJpdmVycyBhcyBoYXZpbmcN
Cj4gQ09NUElMRV9URVNUIGZvciBJTVhfU0NVIGlzIGVub3VnaCB0byBiZSBhYmxlIHRvIHNlbGVj
dCB0aGUgZHJpdmVycy4NCg0KVGhhbmtzLCBJIGFscmVhZHkgYWRkZWQgdGhlIENPTVBJTEVfVEVT
VCBmb3IgSU1YX1NDVSB3aGljaCBpcyBpbiB0aGlzIHNhbWUgcGF0Y2ggc2VyaWVzLA0Kd2l0aG91
dCB0aGF0IElNWF9TQ1UgQ09NUElMRV9URVNUIHBhdGNoLCB0aGUgYnVpbGQgd2lsbCBmYWlsZWQs
IHNvIGluIFYyLCBJIGFsc28gYWRkZWQNCnRoZSBzdHVicyBpbnRvIHRob3NlIElNWCBTQ1UgQVBJ
cyB0byBtYWtlIHN1cmUgZXZlbiBJTVhfU0NVIGlzIE5PVCBlbmFibGVkLCBtb2R1bGVzDQp3aXRo
IENPTVBJTEVfVEVTVCBjYW4gc3RpbGwgcGFzcyBidWlsZCwgcGxlYXNlIGhlbHAgcmV2aWV3IFYy
IHBhdGNoIHNldC4NCg0KVGhhbmtzLA0KQW5zb24NCg==

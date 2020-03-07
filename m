Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4817CA06
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 02:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCGBBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 20:01:24 -0500
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:9697
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgCGBBY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 20:01:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLbFmuDDosB79CitMeowxCMP+UEsPTEWokaib8nknw326zdwDDFIPh5WBK+iPBPVh8FiUoaiJZSU6OZJWpwi0AF2ybRO3JIxyLHDVMdkKBtagM+3TPO99Id/aNgEeSiuLQEUdcZatp8xFSAfF4WMixJcN2y66m/i5xMHzu+JqtCWyEFKqGOYuJPsVYHuQP/lIk+f8rN4sIaBfee63F4KZQFNeXSPOn5RGlsgUgmtYokYhLbqzw7x8CGWcxS2ye2lVDZL9b1Wj7av8QRr0pW7FyyNHX+l/SN9Jxmqp65FQpv0/VwgeTdOt7ADAV221FTxixrplMnxxqXuXWWt/B3pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX6jb+CyQCnFTzT9UUvEEGYqdw1fUSw4wqB+g0WroqQ=;
 b=kR3nCZW3roU5SSx6sfhBriDA/ByxauM4wmFoBQWtCUHNv16M/rRwwhWwoyuV1gtcVsbXhO3+jGqqmlNN9ncKqf3q45BIMciA/+Jo6L7h+67xqIg20lQ07iJZtwKkyyJj2MpO+DJF5X+8xM/c/vBQMvccQb9f7SdWyUT8GNhOXdug6eL4je3gHEIpNoDGtjypi9nJyIFZ6p3pvSATcLCD/WNCEDyXvh12kNVkmgmCFhsILO+YcOr2e7II16MPNHYwgzhSueMsdRiFUrk4F5urFYYAdnnUkV85p3GnRc88DWobtD+4lBbBQQmjg8u8B7WEAZJ0mH3iye0upSatP6/lSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX6jb+CyQCnFTzT9UUvEEGYqdw1fUSw4wqB+g0WroqQ=;
 b=mq5svQXi+zXLwfK07t23auYGiAD4j+LnUbA5HITcBu3zsEgvKf8OrAaEhEeAj+OrUEhQQYVyD7zDqLTuXanKkCT//+svXW5ObZELEklm/5lmFmsYdHSYAV0XvOO8ZSAgunEnzoRqeuTY1dcCjJDwIDuwWOzhqjVGA3Z4oq1BDRA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Sat, 7 Mar 2020 01:01:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Sat, 7 Mar 2020
 01:01:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Thread-Index: AQHV887MNanm8ugiD0KiUbBo9lnYDag79IUAgAAJFwCAAEHEgIAADikAgAACUZA=
Date:   Sat, 7 Mar 2020 01:01:19 +0000
Message-ID: <DB3PR0402MB3916D31AEF0CEA8E4DC42BC3F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
 <DB3PR0402MB3916EA7BAACBBE64F2609DB6F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200307005146.GM217608@dtor-ws>
In-Reply-To: <20200307005146.GM217608@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61be2b08-8adb-4a00-aebe-08d7c2330be2
x-ms-traffictypediagnostic: DB3PR0402MB3865:|DB3PR0402MB3865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3865D0ACC089E26CDA2EEB14F5E00@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(66946007)(66476007)(55016002)(8936002)(66446008)(66556008)(64756008)(6916009)(81156014)(186003)(9686003)(81166006)(26005)(8676002)(86362001)(44832011)(33656002)(2906002)(5660300002)(71200400001)(316002)(478600001)(4326008)(53546011)(54906003)(7416002)(7696005)(6506007)(76116006)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjmGSarB8sNSH8SAxJ9nuJ+ZPh8i3Bi5l7eMtj39BNgpvWwbfPFEKqBLXakQRhcPCrkEoVtdxZfIXidveEcRhpWSjQrcL4jiDvE6n7lWURIomBP2RggWbmbhWLPv/xFLLdFjRvRzT9WV6nVkEe/HL7L/nb8ZxK8V7iAN1qN+O4UKB0oEXlN59s9aLs8hRPAM4K+54cUXXuaXO4Z3scfpNxxny36n43Q4zUyF5E3R8/RULywPJHx7Kpq5BBTrV7nb1DUmR9DJ4bpaFkxfcLs2/Mjy4ZgTCRzzWmqiYu5gGdPVVGJ20Jql60jDFTrUJM2eaB4P9VgYpmbwEhFP4F7UN5XHLb9IwbqOyMGBXR0Uks8+l2MagmZgKYs3kWCDV+gvZWD9fSY/cih6CfB4cXutHSem0w8p4UFZWTlqRu4gnjDeIvcOazH6Odol2WauHjpj
x-ms-exchange-antispam-messagedata: 9/0+ky0YwM6huviQIGajw6qgV2gmEcVEnB69+I83fZQf2fJOys40kgV8OeM5KFeb8T8Jbld1mEpKeCyC9pvGGcbQHmuOYfUQgHXREF0NzpLHg83485spUGkecWccO8TztbmJCH5b5rjJx6YfasbJYg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61be2b08-8adb-4a00-aebe-08d7c2330be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 01:01:19.3760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pf5jboyHfPB1E0Up2kCn3dMaEdPHgpxjqjoZ9aBUbQCXx1QhbKI8P5sNkp0ukOR8ybNpmDmgqNYmXXvet2n3yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERtaXRyeQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSBpbnB1dDoga2V5Ym9hcmQ6
IGFkZCBDT01QSUxFX1RFU1Qgc3VwcG9ydCBmb3INCj4gS0VZQk9BUkRfSU1YX1NDX0tFWQ0KPiAN
Cj4gT24gU2F0LCBNYXIgMDcsIDIwMjAgYXQgMTI6MTg6MzhBTSArMDAwMCwgQW5zb24gSHVhbmcg
d3JvdGU6DQo+ID4gSGksIERtaXRyeQ0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDMv
NV0gaW5wdXQ6IGtleWJvYXJkOiBhZGQgQ09NUElMRV9URVNUIHN1cHBvcnQNCj4gPiA+IGZvciBL
RVlCT0FSRF9JTVhfU0NfS0VZDQo+ID4gPg0KPiA+ID4gT24gRnJpLCBNYXIgNiwgMjAyMCBhdCAx
MTozMyBBTSBEbWl0cnkgVG9yb2tob3YNCj4gPiA+IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29t
PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gRnJpLCBNYXIgMDYsIDIwMjAgYXQgMTE6NDI6
MzRQTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gQWRkIENPTVBJTEVfVEVT
VCBzdXBwb3J0IHRvIGkuTVggU0Mga2V5Ym9hcmQgZHJpdmVyIGZvciBiZXR0ZXINCj4gPiA+ID4g
PiBjb21waWxlIHRlc3RpbmcgY292ZXJhZ2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+
ID4gQXBwbGllZCwgdGhhbmsgeW91Lg0KPiA+ID4NCj4gPiA+IEFjdHVhbGx5LCBub3Q6DQo+ID4g
Pg0KPiA+ID4gRVJST1I6ICJpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllciINCj4gPiA+IFtk
cml2ZXJzL2lucHV0L2tleWJvYXJkL2lteF9zY19rZXkua29dIHVuZGVmaW5lZCENCj4gPiA+IEVS
Uk9SOiAiaW14X3NjdV9nZXRfaGFuZGxlIiBbZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nf
a2V5LmtvXQ0KPiA+ID4gdW5kZWZpbmVkIQ0KPiA+ID4gRVJST1I6ICJpbXhfc2N1X2NhbGxfcnBj
IiBbZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nfa2V5LmtvXQ0KPiA+ID4gdW5kZWZpbmVk
IQ0KPiA+ID4gRVJST1I6ICJpbXhfc2N1X2lycV91bnJlZ2lzdGVyX25vdGlmaWVyIg0KPiA+ID4g
W2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvaW14X3NjX2tleS5rb10gdW5kZWZpbmVkIQ0KPiA+ID4g
RVJST1I6ICJpbXhfc2N1X2lycV9ncm91cF9lbmFibGUiDQo+ID4gPiBbZHJpdmVycy9pbnB1dC9r
ZXlib2FyZC9pbXhfc2Nfa2V5LmtvXSB1bmRlZmluZWQhDQo+ID4gPiBtYWtlWzFdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUubW9kcG9zdDo5NDogX19tb2Rwb3N0XSBFcnJvciAxDQo+ID4gPiBtYWtl
OiAqKiogW01ha2VmaWxlOjEyODI6IG1vZHVsZXNdIEVycm9yIDINCj4gPiA+DQo+ID4gPiBJZiB5
b3Ugd2FudCB0byBlbmFibGUgY29tcGlsZSB0ZXN0IGNvdmVyYWdlIHlvdSBuZWVkIHRvIHByb3Zp
ZGUNCj4gPiA+IHN0dWJzIGZvciB0aGUgYWJvdmUgZnVuY3Rpb25zLg0KPiA+DQo+ID4gVGhlc2Ug
aS5NWCBTQ1UgZHJpdmVycyBkZXBlbmRzIG9uIElNWF9TQ1UsIEkgYWxyZWFkeSBhZGQgdGhlDQo+
ID4gQ09NUElMRV9URVNUIHRvIElNWF9TQ1UgZHJpdmVyIGFzIHdlbGwsIHRoYXQgaXMgd2h5IEkg
cHV0IHRoZXNlIHBhdGNoZXMgaW4NCj4gYSBwYXRjaCBzZXJpZXMuDQo+IA0KPiBBZGRpbmcgInx8
IENPTVBJTEVfVEVTVCIgeW91IGFyZSByZW1vdmluZyBoYXJkIGRlcGVuZGVuY3kgb24gSU1YX1ND
VSwNCj4gd2hpY2ggYXMgeW91IGNhbiBzZWUgY2FuIHJlc3VsdCBpbiBicm9rZW4gYnVpbGQuDQo+
IA0KPiA+IE1heWJlDQo+ID4gSSBjYW4gYWRkIHN0dWJzIGFzIHdlbGwgdG8gbWFrZSBzdXJlIGJ1
aWxkIHBhc3NlZCBldmVuIHdoZW4gSU1YX1NDVSBpcw0KPiBOT1QgY29tcGlsZWQ/DQo+ID4gV2ls
bCBzZW5kIFYyIHRvIGFkZCBzdHVicywgaXQgbWFrZXMgbW9yZSBzZW5zZS4NCj4gDQo+IEl0IGlz
IHVwIHRvIHlvdSB3aGV0aGVyIHlvdSBtYWtlIElNWF9TQ1UgYnVpbGRhYmxlIHdpdGggQ09NUElM
RV9URVNUIGFuZA0KPiBsZWF2ZSB0aGUgc3ViLWRyaXZlciBhcyBpcywgb3IgYWRkIHRoZSBzdHVi
cyBhbmQgbWFrZSBzdWItZHJpdmVycyBidWlsZGFibGUNCj4gZXZlbiB3aXRob3V0IElNWF9TQ1Ug
YmVpbmcgcHJlc2VudC4NCg0KVGhhbmsgeW91LCBJIGFscmVhZHkgYWRkZWQgQ09NUElMRV9URVNU
IHRvIElNWF9TQ1UgZHJpdmVyLCBhbmQgSSB3aWxsIGFsc28gYWRkDQpzdHVicyBmb3IgdGhvc2Ug
QVBJcyBpbiBWMi4NCg0KVGhhbmtzLA0KQW5zb24NCg==

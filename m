Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE52317CB89
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 04:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCGDd7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 22:33:59 -0500
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:6237
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgCGDd7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 22:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE0V8OKClMyHoyqDFlDvAltzMVaUhA0XLgZKmz092hHWa6VewmLjV2VeOpJnl7++zJnZHGB+G9ea30uxp76SRBu2zggkrR5L7x4hRexnvnrtFHrqklDnexcE2n6IZDPIxe7jBC9uNCVualYNJmt1M62PeTjNv0EtqC2cf426/rgupHQZMG6Gng3EsbVhEsUAjAnY5LM98KWvHSN3CBGxOqRZc/O4v92+56ccJx6ceyV39OsYmAdfL2E4TfdzfaVewZciQSSLgA19N57D3UkfVENr3WvntPK19CQ5Ff5qdRI/2lzkIh0mBqeC1bqFJ32mkxeK6l4IKq0EDBrP3eCiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLEiQOSUtp8iJ2N1iOGEfwWkny4ppPuBUaLFRdJtzIs=;
 b=D/sLdFOHLEVPC8ZrYa4ieqb04rKv4KIo/3nfg7wF1OBRVwHza3CGqULDR+BYKpjgVP3a5U1pqKI1uSSprBy3HfqJpE/uDR6vTydO0tbplT0Mj0E7tSKaGinNQdiDDdUUMvDcZ/qnhmy4Jt+vN0Z05xjHyAivQmiG+Ibm7QXGUhtxKp/yf7CKOiLZnB6uTZMVa4QAnLoN6KjGIq/MVuFmi9gMI3Pie8SdiSSc+7SyPLbR00eHaimywYZJL6be1KM/V/c0wi87QCZEAisAAgkD2dtpys6sWolqnY8e4nAP7aMg1gTkoazmV5guns6nZz0FQK4pPcJNgKChBW0eaAzmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLEiQOSUtp8iJ2N1iOGEfwWkny4ppPuBUaLFRdJtzIs=;
 b=RyTYxwpioisoiuqSHVfbGnan8DDtOl3ozbunALvMp9TdfHDXC1JC4EXg8oBriV/ueyH8k7px4WKUk0vYK7uASklKkRNVeHBtm/CCAMi2LUaNIkEz6PeZGbTxkKXYlTqUJDU5k8qR3tSU165DKhyqFJWkfolnzQCCSRBFJqwVEdE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Sat, 7 Mar 2020 03:33:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Sat, 7 Mar 2020
 03:33:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
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
Thread-Index: AQHV887MNanm8ugiD0KiUbBo9lnYDag79IUAgAAJFwCAABOKAIAASDdQgAAXQQCAAAmasA==
Date:   Sat, 7 Mar 2020 03:33:54 +0000
Message-ID: <DB3PR0402MB3916FCC28C5E49FE571226A3F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
 <20200306211538.GA8060@piout.net>
 <DB3PR0402MB39164192146D17327A45DA6CF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200307025720.GA52231@piout.net>
In-Reply-To: <20200307025720.GA52231@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 550d3af9-9582-4b68-e2f6-08d7c2485cbc
x-ms-traffictypediagnostic: DB3PR0402MB3899:|DB3PR0402MB3899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3899927EAF5A63E2B147C2E9F5E00@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(86362001)(33656002)(55016002)(7416002)(71200400001)(76116006)(2906002)(6916009)(53546011)(6506007)(66446008)(7696005)(66556008)(66946007)(64756008)(54906003)(44832011)(81166006)(8936002)(9686003)(478600001)(81156014)(52536014)(316002)(186003)(26005)(4326008)(8676002)(5660300002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFS+73QNtgV8NnFmcIbuKfy8DKK6TDU5De6RPfr8Vshxf8ymbtYhknxb4uMj/S8KznPlIdSjyLgOBlc/ZHblo1B1M03doWUSFXqDw1f+cu3J14TDVlKoRPfLLpRgdYAQueq0aztGNAFb8GY+dbeTBHQkSO46JSxs3JrcBPry+UP7TKq2mIBfgxb0EQc9t89ZshHsWiQujehVlfNInl+Nrt/IhcSDmmD0uCTjVst5NBLj4UYf5nlk+LsTSMzAVr67aEKEVig9PTsGyEwf7Py8434gR0s7DWZUmT1q700+fw6w8ht5txiyja7s1ritbkUp8/G26P+uuxOhqCZf8sV48WadApgddFl732JRNroDXVHjwWNSTInukfGY1gRb7mRVozMjFknZpS/9jJfPRM+W5+Q3iBfKov9MFyQ5PZ/OJ7OilaWHb+BZAewELfomM8T0
x-ms-exchange-antispam-messagedata: phVcIBbvcq4rTZjuciAmylQ1fTJ2CJmkljLkevfUpZwn0O72yD/zl7gdzoip+GEctXtO3qJL1q/BqFCSuVczx8IEHKYCz1HMlf5FECa08izQi2Lsd2k4DKZ1AHnH+kNWIqf3G1tKEXRydCD/BLFZ7A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550d3af9-9582-4b68-e2f6-08d7c2485cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 03:33:54.4841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gtvQISnmNRpnTO+aFhi+9RN3EJ6cb/j/L4Z5bHiOuOpwmNWeeqFQvWENGtQ9TenDsgvEnyo4PX2r7lB4oUrTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSBpbnB1dDoga2V5Ym9h
cmQ6IGFkZCBDT01QSUxFX1RFU1Qgc3VwcG9ydCBmb3INCj4gS0VZQk9BUkRfSU1YX1NDX0tFWQ0K
PiANCj4gT24gMDcvMDMvMjAyMCAwMTozNjozOSswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
PiBIaSwgQWxleGFuZHJlDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSBpbnB1
dDoga2V5Ym9hcmQ6IGFkZCBDT01QSUxFX1RFU1Qgc3VwcG9ydA0KPiA+ID4gZm9yIEtFWUJPQVJE
X0lNWF9TQ19LRVkNCj4gPiA+DQo+ID4gPiBPbiAwNi8wMy8yMDIwIDEyOjA1OjQyLTA4MDAsIERt
aXRyeSBUb3Jva2hvdiB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBNYXIgNiwgMjAyMCBhdCAxMToz
MyBBTSBEbWl0cnkgVG9yb2tob3YNCj4gPiA+ID4gPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+
IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJpLCBNYXIgMDYsIDIwMjAgYXQgMTE6
NDI6MzRQTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBBZGQgQ09NUElM
RV9URVNUIHN1cHBvcnQgdG8gaS5NWCBTQyBrZXlib2FyZCBkcml2ZXIgZm9yIGJldHRlcg0KPiA+
ID4gPiA+ID4gY29tcGlsZSB0ZXN0aW5nIGNvdmVyYWdlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gQXBwbGllZCwgdGhhbmsgeW91Lg0KPiA+ID4gPg0KPiA+ID4gPiBB
Y3R1YWxseSwgbm90Og0KPiA+ID4gPg0KPiA+ID4gPiBFUlJPUjogImlteF9zY3VfaXJxX3JlZ2lz
dGVyX25vdGlmaWVyIg0KPiA+ID4gPiBbZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nfa2V5
LmtvXSB1bmRlZmluZWQhDQo+ID4gPiA+IEVSUk9SOiAiaW14X3NjdV9nZXRfaGFuZGxlIiBbZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nfa2V5LmtvXQ0KPiA+ID4gdW5kZWZpbmVkIQ0KPiA+
ID4gPiBFUlJPUjogImlteF9zY3VfY2FsbF9ycGMiIFtkcml2ZXJzL2lucHV0L2tleWJvYXJkL2lt
eF9zY19rZXkua29dDQo+ID4gPiB1bmRlZmluZWQhDQo+ID4gPiA+IEVSUk9SOiAiaW14X3NjdV9p
cnFfdW5yZWdpc3Rlcl9ub3RpZmllciINCj4gPiA+ID4gW2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
aW14X3NjX2tleS5rb10gdW5kZWZpbmVkIQ0KPiA+ID4gPiBFUlJPUjogImlteF9zY3VfaXJxX2dy
b3VwX2VuYWJsZSINCj4gPiA+ID4gW2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvaW14X3NjX2tleS5r
b10gdW5kZWZpbmVkIQ0KPiA+ID4gPiBtYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUubW9k
cG9zdDo5NDogX19tb2Rwb3N0XSBFcnJvciAxDQo+ID4gPiA+IG1ha2U6ICoqKiBbTWFrZWZpbGU6
MTI4MjogbW9kdWxlc10gRXJyb3IgMg0KPiA+ID4gPg0KPiA+ID4gPiBJZiB5b3Ugd2FudCB0byBl
bmFibGUgY29tcGlsZSB0ZXN0IGNvdmVyYWdlIHlvdSBuZWVkIHRvIHByb3ZpZGUNCj4gPiA+ID4g
c3R1YnMgZm9yIHRoZSBhYm92ZSBmdW5jdGlvbnMuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gb3Ig
c2VsZWN0IElNWF9TQ1UNCj4gPiA+DQo+ID4gPiBvciBsZWF2ZSBvdXQgQ09NUElMRV9URVNUIGZy
b20gdGhlIGluZGl2aWR1YWwgZHJpdmVycyBhcyBoYXZpbmcNCj4gPiA+IENPTVBJTEVfVEVTVCBm
b3IgSU1YX1NDVSBpcyBlbm91Z2ggdG8gYmUgYWJsZSB0byBzZWxlY3QgdGhlIGRyaXZlcnMuDQo+
ID4NCj4gPiBUaGFua3MsIEkgYWxyZWFkeSBhZGRlZCB0aGUgQ09NUElMRV9URVNUIGZvciBJTVhf
U0NVIHdoaWNoIGlzIGluIHRoaXMNCj4gPiBzYW1lIHBhdGNoIHNlcmllcywgd2l0aG91dCB0aGF0
IElNWF9TQ1UgQ09NUElMRV9URVNUIHBhdGNoLCB0aGUgYnVpbGQNCj4gPiB3aWxsIGZhaWxlZCwg
c28gaW4gVjIsIEkgYWxzbyBhZGRlZCB0aGUgc3R1YnMgaW50byB0aG9zZSBJTVggU0NVIEFQSXMN
Cj4gPiB0byBtYWtlIHN1cmUgZXZlbiBJTVhfU0NVIGlzIE5PVCBlbmFibGVkLCBtb2R1bGVzIHdp
dGggQ09NUElMRV9URVNUDQo+IGNhbiBzdGlsbCBwYXNzIGJ1aWxkLCBwbGVhc2UgaGVscCByZXZp
ZXcgVjIgcGF0Y2ggc2V0Lg0KPiA+DQo+IA0KPiBNeSBwb2ludCBpcyB0aGF0IHRoZXJlIGlzIG5v
IG5lZWQgZm9yIHRoZSBzdHVicy4gU2ltcGx5IGhhdmUgQ09NUElMRV9URVNUDQo+IGZvciBJTVhf
U0NVIGFzIHRoaXMgaXMgZW5vdWdoIHRvIGV4dGVuZCBjb3ZlcmFnZSB0byBhbGwgdGhlIGRyaXZl
cnMgYW5kDQo+IHNpZ25pZmljYW50bHkgcmVkdWNlcyB0aGUgY29kZSBzaXplIHZlcnN1cyB3aGF0
IHlvdSBkaWQgaW4gdjIuDQoNCk9LLCB0aGVuIEkgdGhpbmsgVjEgcGF0Y2ggc2V0IGlzIGFscmVh
ZHkgd2hhdCB5b3UgZXhwZWN0ZWQsIHBhdGNoIDEvNSBhZGRzIHRoZSBDT01QSUxFX1RFU1QNCmZv
ciBJTVhfU0NVLiBJIHRoaW5rIG1haW50YWluZXJzIGNhbiBqdXN0IHBpY2sgdXAgdGhlIFYxIHBh
dGNoIHNldC4NCg0KVGhhbmtzLA0KQW5zb24NCg==

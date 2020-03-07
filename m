Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C844917C997
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 01:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCGASo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 19:18:44 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:60182
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbgCGASo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 19:18:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEcOXu3fzYIA0yIoQ+V7kqWGrkUkAvU3OMqQKKQanU/vv5WAsLVqHQ+YRUOcRI4zqMNtA59HH3etpbQefSlybjNFOj9sCEjeUUg35Fv+NyBS68lfdW3U2ideyWeG4P0YqvBvkbNxJeGwUs+2IIa/buIfRR2ZsUhkPc4ubBtL3pXw2VeOO2Dgu0vyu0mCKHDqsY0LySuR7y+2X8zonMOT1uIcYuF/CExj3PjAmBhX4umIHUb/mflI3K56MI/cz5Quba+9mz0ALYGJhaRk2mVGmh5GTNcaZlj6w7qsHDIePl47kk5HPsoB/nb/viG7e0eIAHyG2vS84YSzoeoM+yeTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf9mR5PdB0GN4wMHEMbzXtq/OqaYUAcb6mIj9y+EvyM=;
 b=ZwmzBkOyUXBJBH+etCKNjSz1WI9dFVvCAvEBk5AIEIkrAK0XxWfJwR3bcjkfsSTCU5NsnFPK3KemB9rbXszmzb4zMQ9MTmrRS1E1lY5s5EsGr0B2c3GEy2CnDJrII9t044Qqcff66vuZecSoZJbCxCKMfpl1tzrscjbx6pVimRy7r3ILYmrC8W2Q+7O9ef0OOt6dU8vZB/gX/7eSmtzUzxgnT+4DqNSvrDkEuBhcsL6h64YB2ZlpMffXxrDWDbu8yHzpKItDUEXSys7aIOcjxB3tW7u8rLX3iZE1CE2AON/UviddCY6+YvJI4Azvfzr1tcYALU0Lbg+PvhHFraYBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf9mR5PdB0GN4wMHEMbzXtq/OqaYUAcb6mIj9y+EvyM=;
 b=qWC7iIR1cf/7ExNUtGxAZ0xAmwams6ozb8+aFzySwL97HlOUtrNXa2QmSsaumiETt5Mv5noO8PtLGo3VWUgMq/IeO3kWAsa9H0GQYH1rRc4TNYtdfF67EHyWRMmViSr18WDr8iRIwdy8FObweaqSBnTScEK8Z7XCuSgjGRxpHos=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Sat, 7 Mar 2020 00:18:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Sat, 7 Mar 2020
 00:18:39 +0000
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
Thread-Index: AQHV887MNanm8ugiD0KiUbBo9lnYDag79IUAgAAJFwCAAEHEgA==
Date:   Sat, 7 Mar 2020 00:18:38 +0000
Message-ID: <DB3PR0402MB3916EA7BAACBBE64F2609DB6F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
In-Reply-To: <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51e1c290-77a6-40e8-695d-08d7c22d15cf
x-ms-traffictypediagnostic: DB3PR0402MB3818:|DB3PR0402MB3818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38180894FE9FFB08CA126914F5E00@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(71200400001)(33656002)(66946007)(6916009)(44832011)(52536014)(7416002)(2906002)(64756008)(66476007)(86362001)(66556008)(26005)(316002)(66446008)(4326008)(81156014)(81166006)(186003)(8676002)(5660300002)(54906003)(7696005)(55016002)(53546011)(478600001)(6506007)(9686003)(8936002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGw99w86PNgBMGKP/RgnaO4f5u1JAq5PLFHmypOyPqBXp0SUcN0n4481mjALOpXwMDFnaEqfqlv/kP4q2AMUOQaDrWTT06QUciNOCgSNnm9IfJGUY4QaTKdU9Wcq+JSuOkYwCAWb1DJ557Lm3Q6Mk0HI14kN7A7/tMJMJfxkdp+dOoskXYmTau29L8qg2f2DXSli4eONlLdSrl3yh8NqHV6c07AYwedOC6/RynS8DCjdQdscq1preteHKHW8dKjm2ZlFA396XeOPJZ/0D/scuxHYMwDt6E6EKx28lmNbm5eVAeM2DPJgCSGZM+2Jc2XoBTtVHI/1YPXbWiHqrdbG/6LeJQD/nJH2Eda7I4x2DlOF6/9lv1QJZ7UVgvRHnvJQ58HWXAMR9cgM1iCpzTatnO/yHDVXDiPYVLUiae9t5kT6rrI9HQEh8jyYDjnxhHsD
x-ms-exchange-antispam-messagedata: 4zZHg2zNODRJrryfGOQ+r4vwtVyZFkDatkndTMe+NkFLt5jlZMBFJ8mOR/Wumqqcpzw+ZN0B99vAXyJ+o2LdxzMq5RK4QNrd/kwvlXOILpluFoms4MtQb2NufDLfVhyW1vw9Pu35dc8V6LvEOKKeVQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e1c290-77a6-40e8-695d-08d7c22d15cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 00:18:38.9916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsHwqEr6oKNXNBzZsE23Ram/kLBAq9Am0wTksjFivWnNDGLaTKZf+qH5l/YE4ORLFB0uH3+WWd39SIyhXad4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERtaXRyeQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSBpbnB1dDoga2V5Ym9hcmQ6
IGFkZCBDT01QSUxFX1RFU1Qgc3VwcG9ydCBmb3INCj4gS0VZQk9BUkRfSU1YX1NDX0tFWQ0KPiAN
Cj4gT24gRnJpLCBNYXIgNiwgMjAyMCBhdCAxMTozMyBBTSBEbWl0cnkgVG9yb2tob3YNCj4gPGRt
aXRyeS50b3Jva2hvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCBNYXIgMDYs
IDIwMjAgYXQgMTE6NDI6MzRQTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiBBZGQg
Q09NUElMRV9URVNUIHN1cHBvcnQgdG8gaS5NWCBTQyBrZXlib2FyZCBkcml2ZXIgZm9yIGJldHRl
cg0KPiA+ID4gY29tcGlsZSB0ZXN0aW5nIGNvdmVyYWdlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+ID4gQXBwbGll
ZCwgdGhhbmsgeW91Lg0KPiANCj4gQWN0dWFsbHksIG5vdDoNCj4gDQo+IEVSUk9SOiAiaW14X3Nj
dV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIiDQo+IFtkcml2ZXJzL2lucHV0L2tleWJvYXJkL2lteF9z
Y19rZXkua29dIHVuZGVmaW5lZCENCj4gRVJST1I6ICJpbXhfc2N1X2dldF9oYW5kbGUiIFtkcml2
ZXJzL2lucHV0L2tleWJvYXJkL2lteF9zY19rZXkua29dDQo+IHVuZGVmaW5lZCENCj4gRVJST1I6
ICJpbXhfc2N1X2NhbGxfcnBjIiBbZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfc2Nfa2V5Lmtv
XQ0KPiB1bmRlZmluZWQhDQo+IEVSUk9SOiAiaW14X3NjdV9pcnFfdW5yZWdpc3Rlcl9ub3RpZmll
ciINCj4gW2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvaW14X3NjX2tleS5rb10gdW5kZWZpbmVkIQ0K
PiBFUlJPUjogImlteF9zY3VfaXJxX2dyb3VwX2VuYWJsZSINCj4gW2RyaXZlcnMvaW5wdXQva2V5
Ym9hcmQvaW14X3NjX2tleS5rb10gdW5kZWZpbmVkIQ0KPiBtYWtlWzFdOiAqKiogW3NjcmlwdHMv
TWFrZWZpbGUubW9kcG9zdDo5NDogX19tb2Rwb3N0XSBFcnJvciAxDQo+IG1ha2U6ICoqKiBbTWFr
ZWZpbGU6MTI4MjogbW9kdWxlc10gRXJyb3IgMg0KPiANCj4gSWYgeW91IHdhbnQgdG8gZW5hYmxl
IGNvbXBpbGUgdGVzdCBjb3ZlcmFnZSB5b3UgbmVlZCB0byBwcm92aWRlIHN0dWJzIGZvcg0KPiB0
aGUgYWJvdmUgZnVuY3Rpb25zLg0KDQpUaGVzZSBpLk1YIFNDVSBkcml2ZXJzIGRlcGVuZHMgb24g
SU1YX1NDVSwgSSBhbHJlYWR5IGFkZCB0aGUgQ09NUElMRV9URVNUDQp0byBJTVhfU0NVIGRyaXZl
ciBhcyB3ZWxsLCB0aGF0IGlzIHdoeSBJIHB1dCB0aGVzZSBwYXRjaGVzIGluIGEgcGF0Y2ggc2Vy
aWVzLiBNYXliZQ0KSSBjYW4gYWRkIHN0dWJzIGFzIHdlbGwgdG8gbWFrZSBzdXJlIGJ1aWxkIHBh
c3NlZCBldmVuIHdoZW4gSU1YX1NDVSBpcyBOT1QgY29tcGlsZWQ/DQpXaWxsIHNlbmQgVjIgdG8g
YWRkIHN0dWJzLCBpdCBtYWtlcyBtb3JlIHNlbnNlLg0KDQpUaGFua3MsDQpBbnNvbg0K

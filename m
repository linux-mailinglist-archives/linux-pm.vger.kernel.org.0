Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8373117E150
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCINhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 09:37:13 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:64514
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbgCINhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 09:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw9yB7A08OHbVPwGalgIY9UeK57fLLjwXkuVkuS0Cfz+GIYmDeRV0m+VHmcr3cFzHUn+yOBWfAZ7cm9F+MRvaSU1APj9fyqycwHKLdKygi4PWf43W4nOzx1DREm+7c7aU7PUrVp5+t6MX1i/CTbUo8v/qFiG2Aqp8Y7AoTxxCnT4qT+q3T9F3LpVIZwLUTwBk+C8IIggho+eLWXmb8ftzpaUIL8D9akwpXKokmD/8zS2g0fno33+1jC0gz8QkfE/xQUiOegVVt4VW7xMuOBqRmhk/WjuDI/kl/kUI/76xF8f87AXTmqoZIuPISGAW1yJCKzuDrNCGUf/J7F1wb0OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zaGIN+vMn6CQ7AMDzBnDfmCSotkEzqv3Hb3T2hzfRY=;
 b=AfZ0Fl9hWYpIZI+PIjjbncfrJDQy9hpgpctxvysDiH/8dYtXkeNB6tz+okk60l1GSgxkE1aYog/Ct/btbZ+f4qYGCZ5puLo0Ue/KTSqX78mqWurDMu2BrBzOReDjsggmMAkFhtR095X0ybo3HfS1oknWJ9bFnn7HUYcGj6ADdq9EDOkYrOJ62LZmBTtPoXgynyInztXtzT4yJt4r6OsjDSpz7Y0pyWI3BZlUdXw3JPPuDGRLvq/FxIDOVBjTJAmaEvGryX+ltLxoyV7QorQdKtRzeZ0SlHOowMHdpjIz+IJvlc6kAzrmGr3qxurQILj+L+JJldIJlEOy38cgZtkYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zaGIN+vMn6CQ7AMDzBnDfmCSotkEzqv3Hb3T2hzfRY=;
 b=AtqoN+FX+0p35to28knoJpw9BjEWjaz+6DjbBqGPttFnK1KDA54ttvQ5TdVRasw+Sl9sLgfLyC9d5ccqlaJYVVEuSV/LYMDCEOdb5CbpvUzw7dPB4AIVfg+lNIuuXXIq7W42emN5RcD/DbutqOkUjBbxoAja1KcfNIgJ9BgdJoo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 13:37:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:37:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
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
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahAGiGAgAAnYQCAAAHeEA==
Date:   Mon, 9 Mar 2020 13:37:09 +0000
Message-ID: <DB3PR0402MB3916AE9BA2DEDA066DF0FCCDF5FE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <20200309110609.GE3563@piout.net>
 <1ad38cdb-bf0d-1c19-b233-15a5857bd6fa@roeck-us.net>
In-Reply-To: <1ad38cdb-bf0d-1c19-b233-15a5857bd6fa@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d9fe1ca-2e10-4ffc-34f0-08d7c42ef78f
x-ms-traffictypediagnostic: DB3PR0402MB3898:|DB3PR0402MB3898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3898C32BB528FB881D7C4C80F5FE0@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(52536014)(8936002)(478600001)(33656002)(44832011)(7416002)(2906002)(81166006)(81156014)(8676002)(4744005)(316002)(71200400001)(7696005)(86362001)(110136005)(66446008)(54906003)(66476007)(26005)(5660300002)(6506007)(53546011)(66946007)(66556008)(76116006)(55016002)(4326008)(64756008)(186003)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVrf0xUjhbn7vMkpRw8Z0QweYAFgF2reVg3oEcpwRIBP4zbXCvO3V9q77eR/d93a7DHafwgjV8cpMR6mAWPp4QrReVuVc90R9NMXtmMI8KOkBnBV3wkLU7OkzxA52b0oSi6j42QuuqdfPNykD7rC+J69mFrRlzRsxe7lGWiXQHUpgUvQ89OlBHEbQ2jBbTO1BxhIqFUOOVt54wczZkA8Fqk6T00I8Qvw3T5nOsEN49N26AwhSq+T/fO8A9meKdt6ED86UHpXwrqC/9UB/d4YxeRozMan9gLMTI0pdC9xyfmsdZXIqgn51o054+ranTSt9hHeMZHHKatNYH3dupIV+OeCtgCqTvJLI9L3H1aIZ7JgHhbVGji7abIKDkoHcRouW5xzHphssB1zHCigZHc1yKR6IPt0Qp37HVSkBOsbCUF5KrsUdTO+8ctDIR7eZo56
x-ms-exchange-antispam-messagedata: C05c6USiZ6HarBI6x/Y6/GM1g+6pqn3jMIxG7faApeoC4m2toOZej+Lx4M1V615ls/O+QTXS0y/nbKt4NSOZ9mTmDKSVt6NgRFgynE2H+64A0aiyjsrW4EEhmghiaWznIBFpTmBBz1QH1eDyD8T8+w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9fe1ca-2e10-4ffc-34f0-08d7c42ef78f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 13:37:09.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgvCLy9koV3zP3CA0mJu7Lb30m0hlz/ghnlMCLYEEfxPPgtJQ7qWShxoh7gbIlIDQbaggqw97cowwO5NxMlRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAxLzddIGZpcm13YXJlOiBpbXg6IEFkZCBzdHVi
cyBmb3IgIUNPTkZJR19JTVhfU0NVDQo+IGNhc2UNCj4gDQo+IE9uIDMvOS8yMCA0OjA2IEFNLCBB
bGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4gPiBPbiAwOS8wMy8yMDIwIDA4OjM4OjE0KzA4MDAs
IEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+PiBBZGQgc3R1YnMgZm9yIHRob3NlIGkuTVggU0NVIEFQ
SXMgdG8gbWFrZSB0aG9zZSBtb2R1bGVzIGRlcGVuZGluZyBvbg0KPiA+PiBJTVhfU0NVIGNhbiBw
YXNzIGJ1aWxkIHdoZW4gQ09NUElMRV9URVNUIGlzIGVuYWJsZWQuDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gQ2hhbmdlcyBzaW5jZSBWMjoNCj4gPj4gCS0gcmV0dXJuIGVycm9yIGZvciBzdHVicy4NCj4g
Pg0KPiA+IEknbSBub3Qgc3VyZSB3aHkgeW91IGFyZSBzZW5kaW5nIHYzIHdpdGggdGhlIHN0dWJz
IGFzIHdlIGRldGVybWluZWQNCj4gPiB0aGF0DQo+ID4gMi83IGlzIGVub3VnaCB0byBjb21waWxl
IGFsbCB0aGUgZHJpdmVycyB3aXRoIENPTVBJTEVfVEVTVC4NCj4gPg0KPiA+DQo+IDIvNyBhbG9u
ZSBpcyBub3Qgc3VmZmljaWVudC4gV2l0aCBvbmx5IDIvNywgb25lIGNhbiBleHBsaWNpdGx5IGNv
bmZpZ3VyZQ0KPiBJTVhfU0NVPW4sIENPTVBJTEVfVEVTVD15LCBhbmQgZ2V0IGxvdHMgb2YgY29t
cGlsZSBmYWlsdXJlcy4gR3JhbnRlZCwgb25lDQo+IHNob3VsZCBub3QgZG8gdGhhdCwgYnV0IDBk
YXkgZG9lcyAoSSBkb24ndCBrbm93IGlmIHRoYXQgaXMgdGhlIHJlc3VsdCBvZg0KPiBSQU5EQ09O
RklHKSwgYW5kIEkgYW0gbm90IGxvb2tpbmcgZm9yd2FyZCBoYXZpbmcgdG8gZGVhbCB3aXRoIHRo
ZSBmYWxsb3V0Lg0KDQpTbyB0aGUgVjMgcGF0Y2ggc2VyaWVzIGxvb2tzIGJldHRlciwgYWRkaW5n
IHN0dWJzIGNhbiBjb3ZlciB2YXJpb3VzIGNvcm5lciBjYXNlcy4NCg0KQW5zb24NCg==

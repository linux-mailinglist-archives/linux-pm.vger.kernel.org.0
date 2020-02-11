Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633B1158A02
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 07:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgBKGXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 01:23:06 -0500
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:63750
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbgBKGXG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Feb 2020 01:23:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv7TFxYJ/+ptMLlKzf/IYDQMlmTkcXDNquQHEE9qFtVGIsDVyL53fa9/NUgdDzqL8Pw24/5sGz2Qf/osoe3JD7lPwruws+kZ70fvqcobwZ/n7qnA+ahaDKAtgKWCy4bayUC53HeqmUYZLCVyUP5MDxgfkgWcotcUEYIv4C97so82hy+F9fDjbJWD1UuzXlvaXHXSIBu1lpT+RKhuSoouspN1+Xn5atlS/kzLYBnpi5qfcZt8+fRDGuszYuvs/tburRQIuLfx4WOoHQXrfsLkHujPlYnl3eRvn9ncHD0nr3Q9hAf2iXL6+3qNumpsGNEAr4IRlKZEjTm+LXWl3tZnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRR02yCJC08BP+MSbmbQB6RIECGIDZp11YTg8SyUBwM=;
 b=SobVPmwotowfesw1ukJWaiS/BFiCdMCQecQ+CRugVdhm7F9aj3+xFomn9cbONEoBjw7o3OAkRCFNs1Xp48wYwav6mHewvhNCG+GI0cl5jNJhDlmAmyPZ6EoP5tJNVax4x8GCazPIkzNoLm3mQlxXGFVKIxwhAQU27GQGl9/9wGlDUosAZWGU/y5LbeEwsYLjurpEczQlF3bIlje7kN1VU4wooROuBpQXMfNkNcP2U4KtogD5vJCXl1JE+LKQS1bEAsEP2MHBPZ4oIgaOCniBJLOwz/q0D2kZRvZyx27peV+nu31GYbNZrNwej3/495ENURHml7Mpwbbj5ZRDkpS/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRR02yCJC08BP+MSbmbQB6RIECGIDZp11YTg8SyUBwM=;
 b=QPNL9ZpHGr3yf8mPZJMw1PupRuwDG7UyEj1i5gxE7DrO4FJMRfBEPB0MWODqPSXMKe82JpNGjqkfb62Tv/sbJlnyvGV5sVQnYmb+1zk5bvpb+YFTPHX/rN/ET/fH3q0VmuyqfcEseLBdk0LLN7yAlhVMm3kFXY1RzbZaFk+WgQk=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB6958.eurprd04.prod.outlook.com (52.133.246.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 06:23:02 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 06:23:02 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QA==
Date:   Tue, 11 Feb 2020 06:23:01 +0000
Message-ID: <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
In-Reply-To: <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3160905-e284-4e1e-7ba0-08d7aebad8ee
x-ms-traffictypediagnostic: VI1PR04MB6958:
x-microsoft-antispam-prvs: <VI1PR04MB69584A12E6125ECDC3897569F3180@VI1PR04MB6958.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(44832011)(316002)(66946007)(76116006)(6916009)(64756008)(66556008)(66476007)(9686003)(52536014)(5660300002)(66446008)(55016002)(478600001)(54906003)(6506007)(4326008)(53546011)(33656002)(8936002)(7696005)(186003)(26005)(81166006)(81156014)(8676002)(2906002)(86362001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6958;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrEyaoSZjlMqFeOzEdl6hbUpqjAYYrgfZ/it6jlN1KZJvs1JqGVCyhzaB7ekQLZ5DojFXymQze0aKWhTQH7494ImAMKP/CN+SV81qhV8Kr6C4YmckNA8P2T1+aOBTMl83Ox9Cn3zKHrHGaOVmcetJ06G/burOiOYX+SLafOlBdXFh1jZAGMX9TnSHWjZfWekY7bAOeEkfiKlQEoePb+pNtRazZkwSDkve/AXOfn60E5Zi1TW/ughpA73H7uSUO0iKUlQTNiGj8YI7u7rvrp8+ZwopQmSkAyzHsxmv0ypyoJtD7RDHL+hZYjEBjDgGIwUj76INZAkqJCYXSNQJnRpMcFr2ty0akPEpmypVt8LZZ5rZDIVPESbXqfcxJvWxXOtr498TLVxKA6iq2Tj41RclKZF46JxvStQQMc59VA8JyX/vmKoDxNwSfMEXp6IEKet
x-ms-exchange-antispam-messagedata: Rv4RDA0kRCu1LXtniHe6+o9mEz2o1W+VSEWOuB+Zhy53caI9loQHRAgES/rvxqmy8v+jH8Nf9SM0oy8MG10HcH3hsgLYBZ+aNWs10UDEXfNkaW5BDRLQNd+dLHB0uf84teHl7umakquQHL2JP2UTUA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3160905-e284-4e1e-7ba0-08d7aebad8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 06:23:02.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj9V3asRZdsZpEr0UX6nqhVsOwSaVM0T+FPowUiIq5umysM5zam33e/iKCb8DdzTEZHHpWE9XHwD18+A71TW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6958
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGluc3RydWN0aW9uLiBJIGd1ZXNzIGl0IHdhcyBjYXVzZWQgYnkgUU9T
Lg0KSSB0cnkgdG8gY2hhbmdlIHNjYWxpbmdfbWF4X2ZyZXEuIGl0IGNhbiBiZSB3cml0dGVuLCBi
dXQgaGF2ZSBubyBlZmZlY3QuDQoNCkkgYW0gZ29pbmcgdG8gdHJhY2sgdG8gZGV2X3BtX3Fvc19h
ZGRfcmVxdWVzdCgpIGFzIHlvdSBzdWdnZXN0ZWQuDQpCZWZvcmUgdGhhdCwgSSBhbSBhbHNvIHdv
bmRlcmluZyB3aGF0IHRoZSBmYWN0b3IgaXQgY291bGQgYmUgdG8gbGltaXQgdGhlIGNwdSBtYXgg
ZnJlcXVlbmN5Pw0KDQpCUiwNCkFuZHkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiBTZW50OiAy
MDIwxOoy1MIxMcjVIDEzOjUzDQo+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0K
PiBDYzogcmp3QHJqd3lzb2NraS5uZXQ7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IEFzayBmb3IgaGVscCBhYm91dCBjcHVmcmVxIGlzc3VlDQo+IA0K
PiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDExLTAyLTIwLCAwNDoyMCwgQW5keSBUYW5n
IHdyb3RlOg0KPiA+IEhpIFZpcmVzaCwNCj4gPg0KPiA+IEkgY2hlY2tlZCB0aGUgY2xrIHBhcnQs
IG5vIGlzc3VlIHdhcyBmb3VuZC4NCj4gPiBJIGRpZCBmb3VuZCBhIG9kZCB0aGluZyBpbiBjcHVm
cmVxIGRpcmVjdG9yeS4NCj4gPg0KPiA+ICMgY2F0IHNjYWxpbmdfYXZhaWxhYmxlX2ZyZXF1ZW5j
aWVzDQo+ID4gMTYwMDAwMCAxMDAwMDAwIDgwMDAwMCA1MDAwMDANCj4gPiAjIGNhdCBzY2FsaW5n
X21heF9mcmVxDQo+ID4gNTAwMDAwDQo+IA0KPiBBaGgsIHNvcnJ5IGFib3V0IHRoYXQgYXMgSSBt
dXN0IGhhdmUgbm90aWNlZCBpdCBlYXJsaWVyLg0KPiANCj4gPiBXaHkgdGhlcmUgaXMgYSAxNjAw
TWh6IGZyZXF1ZW5jeSBhdmFpbGFibGUsIGJ1dCB0aGUgbWF4IGZyZXEgaXMgb25seQ0KPiA1MDBN
Pw0KPiA+IEhvdyB0aGUgbWF4IGZyZXEgaXMgc2V0Pw0KPiANCj4gSG1tLCBJIGFtIG5vdCBzdXJl
IHdoeSB0aGlzIGhhcHBlbmVkLiBDYW4geW91IHRyeSB0byB3cml0ZSAxNjAwMDAwIHRvDQo+IHNj
YWxpbmdfbWF4X2ZyZXE/IFRoaXMgd2lsbCBmaXggaXQgaWYgdGhlIHVzZXJzcGFjZSBpcyByZXNw
b25zaWJsZSBmb3IgdGhpcw0KPiBsaW1pdGF0aW9uIGFuZCB5b3UgbmVlZCB0byBmaW5kIHdoaWNo
IHBhcnQgb2YgeW91ciB1c2Vyc3BhY2UgaXMgY2F1c2luZyBpdC4NCj4gDQo+IEVsc2UgdGhpcyBp
cyBjb21pbmcgZnJvbSB3aXRoaW4ga2VybmVsIGFuZCB5b3UgbmVlZCB0byB0cmFjayBjYWxscyB0
bw0KPiBkZXZfcG1fcW9zX2FkZF9yZXF1ZXN0KCkgYW5kIGNoZWNrIGFsbCBjYWxscyByZWxhdGVk
IHRvIGZyZXEgcW9zDQo+IGNvbnN0cmFpbnRzLg0KPiANCj4gLS0NCj4gdmlyZXNoDQo=

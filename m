Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E719C9DBFB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 05:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfH0DYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 23:24:38 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:29279
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728025AbfH0DYi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 23:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT7JL70hYQod+WjsYN63USj0mbcHWZNgf8+GZ4QsvikMcFmFiV58K/q5swODSw7BXAzqSztRVBgGvu91ep/hToZOqtBEqowlxW2kHn5VzLTdKhk4uN+MLQFi8gAiXC7WYeruUrA07Oah1DlK7S7mlsr1UOTao020gq2XKQCxB33SNkvZr+ZziTXklExZIBiWBa52MYIyPZx72A+CjuTINek/D1YfS5OpmOQR1Zs3iU6MDqrtA1cJrnhrFuxDEdkjIm8gUhwZADJkiGJZbawLVVavDWkHJ1Golf5IIZ0wJYHsB7gJish/FDuyc3eLYWhPRmbF2XvrdD8nDOpMi2AtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=001s0diK1VvirVMc+LELwzOoXsfz0ONkd3No11tepVk=;
 b=RItsdnnPhl7jX7q208xKXitpG330PjaZXhLyvKNxN34yNGYPFq1y4/vuYsoFM5yDcvMqdsK5z0Kqn2MM8N9bgo1hjGGOZaE4pYxonSkVz5F/W//rlkCQpV5Qu4wDH5LLK+Kxtxkx2UcVPY+zSNG/PwlshlKusYudZ0UfWAu0/OCI/nksYpubkkCTy4E2K/LSGYSkXTIQu97cCHDmOhLBiGwvux/8DW/2AxTKg5JfZcaRkWiYyQJtHAEZZX0Sp49CtcpEneaOrVDSHp9iCoUEvU9rGXefOUdX5kQShgrdRskOWtdQD/Vud6GWban2NDl2dySb0Dkg28Eq8Ud3CFaTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=001s0diK1VvirVMc+LELwzOoXsfz0ONkd3No11tepVk=;
 b=DNMomTvEDgStMdE2+oyhvT7j913581jGoga2jUmKCJycuvAVbkrmG+e8f/ace0J1H75c49SXdgfFTV+iV9lRsn8zz3pqe1t42CpdkhItazIZNjJZuthg7qsq6swFGJXZcykYY+36jul8rWGIOFFIEg1hCI1a0DEk979QV6whilg=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3767.eurprd04.prod.outlook.com (52.133.31.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 03:24:30 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c9d3:4e41:12b7:892]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c9d3:4e41:12b7:892%5]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 03:24:30 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacOZc9ggAAW0QCAAAIRwA==
Date:   Tue, 27 Aug 2019 03:24:30 +0000
Message-ID: <AM6PR0402MB39115FEE1E53EC047F54C4F6F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <57ecab7c3600802d544683fcb968f9455b2b25d8.camel@intel.com>
In-Reply-To: <57ecab7c3600802d544683fcb968f9455b2b25d8.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b3d7bf-36e2-4bc2-0566-08d72a9e12f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR0402MB3767;
x-ms-traffictypediagnostic: AM6PR0402MB3767:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3767B06F3FFC764835D0D9F3F5A00@AM6PR0402MB3767.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(26005)(102836004)(53546011)(6506007)(76176011)(186003)(11346002)(305945005)(7696005)(74316002)(486006)(476003)(44832011)(2906002)(66574012)(446003)(14444005)(256004)(110136005)(8936002)(81156014)(81166006)(6246003)(8676002)(25786009)(99286004)(33656002)(6436002)(7416002)(7736002)(6306002)(55016002)(4326008)(53936002)(9686003)(229853002)(52536014)(966005)(478600001)(14454004)(66476007)(66446008)(64756008)(66556008)(54906003)(66946007)(66066001)(76116006)(71200400001)(86362001)(3846002)(71190400001)(6116002)(5660300002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3767;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTYLf79x23IS9Ln04Ai9LJJFtacnZ1YDxlQfZ2rL/n+AiDKWfWd9dZq7mdl0I8nEl0nfPYBhZsYj33eeKBZ6GsTkEKLJuhFwvlUjtFFkvLXTG3GxQK/88Z41WsCVLxVQb7EpqVCtymL8cMFJTYBsl/aPC6z9pdfSEZjuyUmz0NutKJbpHUu0UxDRlaeMJJ2Jes6GV4Ra1QoRirKxR1al9woDwaNqBgZgnSpR1H51OOWLKIkvRRc5lf2cfJKKNZl7fYnukFti9V3rws7KVKtNYQ/A4wj1vCBNT4lpKxTgBGYNUpAY+CwxGqQ+Tg1MuP9jDPVU12AGibOZkj1+Bp40/X1A+MEulUHOHEXRp826fJEmzp8rb6uNceMiL33TJ9klPGDhEAcjoImi2Kp4cxqyQO9/LO1jWeBRhfOVbaMZlr4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b3d7bf-36e2-4bc2-0566-08d72a9e12f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 03:24:30.6344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0Z0t9IhIhoDSHCTjvxP58bPOtmSxfFTf7M9kvALaT6sNPgXbbOYm5Ogmo+ufK7JcLudo41HwsZCLByR9YC/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3767
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+IE9uIFR1ZSwgMjAxOS0wOC0yNyBhdCAwMTo1MSArMDAwMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gPiBPbiA3LzMwLzIwMTkgNTozMSBBTSwgQW5zb24uSHVhbmdAbnhwLmNv
bSB3cm90ZToNCj4gPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+ID4gPiA+DQo+ID4gPiA+IFNvbWUgcGxhdGZvcm1zIGxpa2UgaS5NWDhNUSBoYXMgY2xvY2sg
Y29udHJvbCBmb3IgdGhpcyBtb2R1bGUsDQo+ID4gPiA+IG5lZWQgdG8gYWRkIGNsb2NrIG9wZXJh
dGlvbnMgdG8gbWFrZSBzdXJlIHRoZSBkcml2ZXIgaXMgd29ya2luZw0KPiA+ID4gPiBwcm9wZXJs
eS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBHdWlkbyBHw7xudGhlciA8YWd4QHNp
Z3hjcHUub3JnPg0KPiA+ID4NCj4gPiA+IFRoaXMgc2VyaWVzIGxvb2tzIGdvb2QsIGRvIHlvdSB0
aGluayBpdCBjYW4gYmUgbWVyZ2VkIGluIHRpbWUgZm9yDQo+ID4gPiB2NS40Pw0KPiA+ID4gVG9k
YXkgd2FzIHY1LjMtcmM2Lg0KPiA+DQo+ID4gSWYgdGhlIHF1ZXN0aW9uIGlzIGZvciBtZSwgdGhl
biBJIGFtIE5PVCBzdXJlLCB0aGUgdGhlcm1hbCBwYXRjaGVzIGFyZQ0KPiA+IHBlbmRpbmcgdGhl
cmUgZm9yIGFsbW9zdCBoYWxmIHllYXIgYW5kIEkgZGlkIE5PVCByZWNlaXZlIGFueSByZXNwb25z
ZSwNCj4gDQo+IHdoaWNoIHBhdGNoIHNlcmllcyB5b3UncmUgcmVmZXJyaW5nIHRvPw0KDQpCZWxv
dyBpLk1YOFFYUCBwYXRjaCBzZXJpZXMsIEkgbWVhbnQgSSBzdGFydGVkIGl0IGZyb20gbGFzdCB5
ZWFyLCB0aGUgbGF0ZXN0IHJlc2VuZA0KdmVyc2lvbiBpcyAyIG1vbnRocyBhZ286IA0KDQpodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDAwODA5LyANCg0KDQo+IA0KPiA+ICBs
b29rcyBsaWtlIG5vIG9uZQ0KPiA+IGlzIG1haW50YWluaW5nIHRoZSB0aGVybWFsIHN1Yi1zeXN0
ZW0/DQoNCkJlbG93IHR3byBwYXRjaCBzZXJpZXMgYXJlIGFsc28gcGVuZGluZyB0aGVyZSBmb3Ig
c29tZSB0aW1lOg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDMyNzc3
LyANCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTAzMTI5Ny8gDQoNCj4g
Pg0KPiANCj4gRWR1YXJkbyBpcyBtYWludGFpbmluZyBhbGwgdGhlIHRoZXJtYWwtc29jIGRyaXZl
ciBjaGFuZ2VzLiBUaHVzIEkgdXN1YWxseQ0KPiBmaWx0ZXJlZCBvdXQgdGhlIHNvYyBkcml2ZXIg
cGF0Y2hlcyBpbiBteSBtYWlsYm94Lg0KPiANCj4gVGhlIGxhc3QgZW1haWwgZnJvbSBFZHVhcmRv
IGlzIHRoYXQgaGUgaXMgb2ZmbGluZSBkdXJpbmcgdGhpcyBKdWx5IGFuZCB3aWxsIGJlDQo+IGJh
Y2sgYW5kIHRha2luZyBwYXRjaGVzIGluIEF1Z3VzdC4NCj4gDQo+IEkgd2lsbCBkb3VibGUgY2hl
Y2sgd2l0aCBFZHVhcmRvIGFueXdheS4NCg0KVGhhbmtzLCBlc3BlY2lhbGx5IG91ciBpLk1YOFFY
UCB0aGVybWFsIGRyaXZlciBwYXRjaCwgSSBzdGFydGVkIGl0IGZyb20gbGFzdCB5ZWFyIGFuZA0K
ZHVlIHRvIHNvbWUgZGlmZmVyZW50IG9waW5pb24gZnJvbSBkaWZmZXJlbnQgcmV2aWV3ZXJzLCB0
aGlzIHBhdGNoIHNlcmllcyB2ZXJzaW9uIGlzDQp1cCB0byB2MTUsIGJ1dCBJIGRpZCBOT1QgcmVj
ZWl2ZSByZXNwb25zZSBzaW5jZSBKdW5lLCBhcHByZWNpYXRlZCBpZiB5b3UgZ3V5cyBjYW4gdGFr
ZQ0KYSBsb29rIGF0IHRoaXMsIEkgcGluZyBpdCBtYW55IHRpbWVzIGJ1dCBubyBmZWVkYmFjay4g
VGhhbmtzIQ0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDAwODA5Lw0K
DQpBbnNvbi4NCg0KPiANCj4gdGhhbmtzLA0KPiBydWkNCj4gDQo+IA0KPiA+ID4NCj4gPiA+IElu
IGFuIGVhcmxpZXIgc2VyaWVzIHRoZSBDTEtfSVNfQ1JJVElDQUwgZmxhZ3Mgd2FzIHJlbW92ZWQg
ZnJvbSB0aGUNCj4gPiA+IFRNVSBjbG9jayBzbyBpZiB0aGUgdGhlcm1hbCBkcml2ZXIgZG9lc24n
dCBleHBsaWNpdGx5IGVuYWJsZSBpdCB0aGUNCj4gPiA+IHN5c3RlbSB3aWxsIGhhbmcgb24gcHJv
YmUuIFRoaXMgaXMgd2hhdCBoYXBwZW5zIGluIGxpbnV4LW5leHQgcmlnaHQNCj4gPiA+IG5vdyEN
Cj4gPg0KPiA+IFRoZSB0aGVybWFsIGRyaXZlciBzaG91bGQgYmUgYnVpbHQgd2l0aCBtb2R1bGUs
IHNvIGRlZmF1bHQga2VybmVsDQo+ID4gc2hvdWxkIGNhbiBib290IHVwLCBkbyB5b3UgbW9kaWZ5
IHRoZSB0aGVybWFsIGRyaXZlciBhcyBidWlsdC1pbj8NCj4gPg0KPiA+ID4NCj4gPiA+IFVubGVz
cyB0aGlzIHBhdGNoZXMgaXMgbWVyZ2VkIHNvb24gd2UnbGwgZW5kIHVwIHdpdGggYSA1LjQtcmMx
IHRoYXQNCj4gPiA+IGRvZXNuJ3QgYm9vdCBvbiBpbXg4bXEuIEFuIGVhc3kgZml4IHdvdWxkIGJl
IHRvIGRyb3AvcmV2ZXJ0IGNvbW1pdA0KPiA+ID4gOTUxYzFhZWY5NjkxICgiY2xrOiBpbXg4bXE6
IFJlbW92ZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBmb3INCj4gPiA+IElNWDhNUV9DTEtfVE1VX1JP
T1QiKSB1bnRpbCB0aGUgdGhlcm1hbCBwYXRjaGVzIGFyZSBhY2NlcHRlZC4NCj4gPg0KPiA+IElm
IHRoZSB0aGVybWFsIGRyaXZlciBpcyBidWlsdCBhcyBtb2R1bGUsIEkgdGhpbmsgbm8gbmVlZCB0
byByZXZlcnQNCj4gPiB0aGUgY29tbWl0LCBidXQgaWYgYnkgZGVmYXVsdCB0aGVybWFsIGRyaXZl
ciBpcyBidWlsdC1pbiBvciBtb2QNCj4gPiBwcm9iZWQsIHRoZW4geWVzLCBpdCBzaG91bGQgTk9U
IGJyZWFrIGtlcm5lbCBib290IHVwLg0KPiA+DQo+ID4gQW5zb24uDQo+ID4NCj4gPiA+DQo+ID4g
PiBNZXJnaW5nIHBhdGNoZXMgb3V0LW9mLW9yZGVyIHdoZW4gdGhleSBoYXZlIGhhcmQgKGJvb3Qt
YnJlYWtpbmcpDQo+ID4gPiBkZXBlbmRlbmNpZXMgYWxzbyBicmVha3MgYmlzZWN0Lg0KPiA+ID4N
Cj4gPiA+IC0tDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gTGVvbmFyZA0KDQo=

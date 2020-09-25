Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625B5278ADD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgIYOab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 10:30:31 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:63758
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728410AbgIYOab (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 10:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv8gYjfSpDZ0XGzrSP6rcPWBYREWQ0lbTKYnRutO8RsT95y+6lkgGyT4CJtFCFtQtjUBGncjXLb9x3IglExW8yq4hsyTKumZo+LSZuMcXumrWQTpP5aZsTWnmzaIoQvABWtUpzbDts9OE8F7M/GlvNlRPAT096HnEa4wITH2yWAmWOp5rLTBxVqfqw9UjVvbNLC8W2D7rOYC123lX7HoneiCucVfbc+vqXeLCGBajMtgm8sFL05q7WZc4ic0vpEZlmcQQIwnPX5nb72uMSMYyMqwJrvDW7pTF2feSc8qXUzqzvDMpVZlkZ+yZ+4ehxK03yhk2Xf5peftOTKBUfhUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwqLRgFH0khosbnbIKjBeM5gCKo57UVlLehlnY1Z7no=;
 b=GpumDvXSM8/mRqlhs161PW29piB5XR47uZDZj7AwRBQkZUNugKZ521k+vZscX8zUF0ykwZDf7LIFaZr0etQZcqQ8GYZo/qMwveR+7S9boS7bkX3ek7/v2Vky1U3+8F8JAoOmfPmsVUS3wmbB8ydn6rzGwvTs5983K0pEjRUPEo4PIyIgm2xpuT6uIqUxPHqo5UVoN4QitfJO/u5QG8MbcEBueoy9qmOB2f3+xESfH13ppXubq6MXJmGpHDI5tvthjoE27jniUQJOzIsgFVKQx4OQRbolSpDjgiBpaqWYN8ghL4emsiwa6I2bGRgHxIDaNQPU+SwprhkVoc56IH20Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwqLRgFH0khosbnbIKjBeM5gCKo57UVlLehlnY1Z7no=;
 b=NZNq0R5u1O1NmGmCKytwC9xQ41eMxE+b2Mvn4CjJ2SDgD8M0BK8Igzv2NLpln5rspenti4ijR7NQUIY3CZOBXYqnfUcze36zm+hnycv6UZWAaDctOyjiFWg+6TqMbYzTQYj/okpUsd0l+UbWksY4RLSLgmrcx4tjaZe3NXTqnCE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4938.eurprd04.prod.outlook.com (2603:10a6:10:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 14:30:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.022; Fri, 25 Sep
 2020 14:30:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
Thread-Topic: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
Thread-Index: AQHWkmLFcQ7E31u+qkClkMyHDfUTbal43m5QgABgSgCAACooEA==
Date:   Fri, 25 Sep 2020 14:30:26 +0000
Message-ID: <DB6PR0402MB2760B91DB92A5307E12D59BB88360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
 <20200924110449.329523-4-ulf.hansson@linaro.org>
 <DB6PR0402MB2760BD51916BEA5DB80A268188360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAPDyKFrrLq6mPCsSoRBBmgMxSvC4xeiSedi1c5CsEWF=+f73mw@mail.gmail.com>
In-Reply-To: <CAPDyKFrrLq6mPCsSoRBBmgMxSvC4xeiSedi1c5CsEWF=+f73mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.220.79.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90d7092c-9c97-4992-6958-08d8615f8be6
x-ms-traffictypediagnostic: DB7PR04MB4938:
x-microsoft-antispam-prvs: <DB7PR04MB49383F0FFFDF6DD477F1B13588360@DB7PR04MB4938.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvVAfM5Bo85Lo8vwEqhkNMoVGTR9FDLnuPWMykG+7vtLK48oBza4klZwbiDpxX1RqaRdRgd1ZYWAKjsAna1In9vRi/Y1I6/3NfZJB4ahQAM/foxJ6wxVVuxYAJRZamB0U2t5yXiBxoaEg/AEogj1DL/3pCA4ETghO83Sai/dSQScuyn846gbafTzsMlmaqHF+CF8JG0T5AV4GO5k9JnTTs7xRkCZfDMdzz7pl+WEFpWWuD41T03yo8j+GlgudcvWaYiijYzC4VRfpb/lXpwTPszlTKbh+opYLDF2yKERdqwI/GW3Osl6BQBbO4nWz7lOIB3eIT/EZp7b53g2tecHsqqqcr9ETSck2cx9mOkKHnaqgELfIXKYqZbfD7y0oCaC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(2906002)(55016002)(6506007)(8936002)(83380400001)(4326008)(316002)(8676002)(33656002)(7696005)(54906003)(86362001)(9686003)(66556008)(44832011)(66476007)(478600001)(64756008)(52536014)(66446008)(26005)(76116006)(66946007)(6916009)(7416002)(186003)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: h1CAoFPqFvMSMT+84v0bsT+1aAdkRMKwQ7KanwaANytu5odGXNNNSVbU+BxQSVD08z8Tzgt4izd2PdLsghnCRgExfXWtMJutQt09it15AoOcnQKEN+954UBRMmK8UWlPyggbhLuCj/UZfCGD1IMPz/wM5TWiH9opmkXbRTOi/Whk9R+q0cwwUCFTOwmIpcM9PqiUFxvK7UOHvKaOHUmgZsUJ8KRRI+qUnuG6mIsDDHjuPuCqfvC0oGjSqebfM7hTtKa5VDXpIBwJi7bPpRfAMbQHCrQP0sLbXqYubf5EXxZnjjXe04pQuycaBOAgd13L7Oe4d8NyOMAt6FHy0GFtKM4i9n+46xmzDL3S5SUV3xA+64ZlxGGskDFWPsFVfNYjYa8efokQt2sf9YQwLBm+A9kC9eyxGR4xBSt/VXGZ4tvxqMTBO3i8ZL2sdA/vNngs36DK+3EGM1V4QKgEy5uFPGW+efvlEMagZTZM+JaJopkN5M/voRtIdm/R1890OTwTH7h4dZmeOh/x4EI+5NasC3alsauy0JM3PbXc1o27ShlF4pSQDeUigNi/Z52mU0WmkJkl06PxrfDWrlTwUVbkT5ZIsJOv1kI24Y7/AfjpV1SfxrGqt/wVKYmvd1oOCm7gII2Vpbvs4X4VywRSuvHaqQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d7092c-9c97-4992-6958-08d8615f8be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 14:30:26.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KedDlhzOpw0bVCYgdM+L/pu1zgfXWidEDOdHwskLPzpu6FSyRaalDWn1WQbp/T0OvtA7dq5mu1HZTkNe5YS38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4938
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gUE0gLyBEb21haW5zOiBBZGQgc3VwcG9ydCBm
b3IgUE0gZG9tYWluIG9uL29mZg0KPiBub3RpZmllcnMgZm9yIGdlbnBkDQo+IA0KPiBPbiBGcmks
IDI1IFNlcCAyMDIwIGF0IDA4OjA4LCBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBIaSBVbGYsDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzNdIFBN
IC8gRG9tYWluczogQWRkIHN1cHBvcnQgZm9yIFBNIGRvbWFpbg0KPiA+ID4gb24vb2ZmIG5vdGlm
aWVycyBmb3IgZ2VucGQNCj4gPiA+DQo+ID4gPiBBIGRldmljZSBtYXkgaGF2ZSBzcGVjaWZpYyBI
VyBjb25zdHJhaW50cyB0aGF0IG11c3QgYmUgb2JleWVkIHRvLA0KPiA+ID4gYmVmb3JlIGl0cyBj
b3JyZXNwb25kaW5nIFBNIGRvbWFpbiAoZ2VucGQpIGNhbiBiZSBwb3dlcmVkIG9mZiAtIGFuZA0K
PiA+ID4gdmljZSB2ZXJzZSBhdCBwb3dlciBvbi4gVGhlc2UgY29uc3RyYWludHMgY2FuJ3QgYmUg
bWFuYWdlZCB0aHJvdWdoDQo+ID4gPiB0aGUgcmVndWxhciBydW50aW1lIFBNIGJhc2VkIGRlcGxv
eW1lbnQgZm9yIGEgZGV2aWNlLCBiZWNhdXNlIHRoZQ0KPiA+ID4gYWNjZXNzIHBhdHRlcm4gZm9y
IGl0LCBpc24ndCBhbHdheXMgcmVxdWVzdCBiYXNlZC4gSW4gb3RoZXIgd29yZHMsDQo+ID4gPiB1
c2luZyB0aGUgcnVudGltZSBQTSBjYWxsYmFja3MgdG8gZGVhbCB3aXRoIHRoZSBjb25zdHJhaW50
cyBkb2Vzbid0IHdvcmsNCj4gZm9yIHRoZXNlIGNhc2VzLg0KPiA+DQo+ID4gQ291bGQgdGhlIG5v
dGlmaWNhdGlvbiBiZSBhZGRlZCBiZWZvcmUvYWZ0ZXIgcG93ZXIgb24sIGFuZA0KPiA+IGJlZm9y
ZS9hZnRlciBwb3dlciBvZmY/IG5vdCBqdXN0IGFmdGVyIHBvd2VyIG9uIGFuZCBiZWZvcmUgcG93
ZXIgb2ZmPw0KPiA+DQo+ID4gT3VyIFNvQyBoYXMgYSByZXF1aXJlbWVudCB0aGF0IGJlZm9yZSBw
b3dlciBvbi9vZmYgdGhlIHNwZWNpZmljDQo+ID4gbW9kdWxlLCB0aGUgY29ycmVzcG9uZGluZyBj
bGsgbmVlZHMgdG8gYmUgb24gdG8gbWFrZSBzdXJlIHRoZSBoYXJkd2FyZQ0KPiA+IGFzeW5jIGJy
aWRnZSBjb3VsZCBmaW5pc2ggaGFuZHNoYWtlLg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGNvbW1l
bnRzIQ0KPiANCj4gTWF5IEkgYXNrLCB0byBiZSBzdXJlIC0gZG9lcyB0aGUgY2xvY2sgY29ycmVz
cG9uZCB0byB0aGUgZ2VucGQgcHJvdmlkZXIgb3IgaXMgaXQNCj4gYSBjbG9jayBmb3IgdGhlIGdl
bnBkIGNvbnN1bWVyIGRldmljZT8NCg0KSXQgaXMgdGhlIGNsb2NrIGZvciB0aGUgZ2VucGQgY29u
c3VtZXIgZGV2aWNlLg0KDQo+IA0KPiBJZiB0aGUgZm9ybWVyLCBjb3VsZG4ndCB0aGUgY2xvY2sg
YmUgbWFuYWdlZCBmcm9tIHRoZSAtPnBvd2VyX29ufG9mZigpDQo+IGNhbGxiYWNrcyBmb3IgdGhl
IGdlbnBkIHByb3ZpZGVyPw0KDQpTYWRseSBub3QgZm9ybWVyLg0KDQpPdXIgY3VycmVudCBzb2x1
dGlvbiBpcyB0byBhZGQgYSBjbG9jayBwcm9wZXJ0eSB0byB0aGUgcG93ZXIgZG9tYWluIG5vZGUo
TlhQIEFSTSBTSVANCmJhc2VkIHBvd2VyIGRvbWFpbiBkcml2ZXIpLCBhbmQgd2hlbiBwb3dlcl9v
bi9vZmYsIHdlIGVuYWJsZS9kaXNhYmxlIHRoZSBjbG9ja3MuDQoNCkJ1dCB3ZSBhcmUgbW92aW5n
IHRvIHVzZSBTQ01JIHBvd2VyIGRvbWFpbiwgYW5kIGxlYXZlIHRoZSBjbG9jayBpbiBMaW51eCwN
ClNjbWkgcG93ZXIgZG9tYWluIGRyaXZlciBpcyBhIGdlbmVyaWMgZHJpdmVyLCBhbmQgd2UgYXJl
IG5vdCBhYmxlIHRvIG1peCBjbG9jaw0KcGFydHMgaW4gdGhlIGRyaXZlciB3aGljaCBpcyBiYWQu
DQoNCllvdXIgcGF0Y2ggZ2l2ZXMgbWUgYSBsaWdodCB0aGF0IGlmIHdlIGNvdWxkIHVzZSBub3Rp
ZmljYXRpb24gdG8gbGV0IGNvbnN1bWVyDQpkZXZpY2UgZHJpdmVyIGRvIHRoZSBjbG9jayBlbmFi
bGUvZGlzYWJsZSBmb3IgZWFjaCBwb3dlciBvbiBhbmQgcG93ZXIgb2ZmLg0KVGhhdCB3b3VsZCBi
ZSBncmVhdC4NCg0KDQpUaGFua3MsDQpQZW5nLg0KPiANCj4gPg0KPiA+IFNvIHdlIG5lZWQgY2xr
X3ByZXBhcmVfb24vb2ZmIHRvIGd1YXJkIHBvd2VyIG9uIGFuZCBwb3dlciBvZmYgYXMgYmVsb3c6
DQo+ID4NCj4gPiBjbGtfcHJlcGFyZV9vbg0KPiA+IHBvd2VyIG9uDQo+ID4gY2xrX3ByZXBhcmVf
b2ZmDQo+ID4NCj4gPiBjbGtfcHJlcGFyZV9vbg0KPiA+IHBvd2VyIG9mZg0KPiA+IGNsa19wcmVw
YXJlX29mZg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcuDQo+ID4NCj4gDQo+IFsuLi5dDQo+
IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K

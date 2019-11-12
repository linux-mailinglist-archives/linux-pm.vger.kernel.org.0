Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59887F970F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 18:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLRZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 12:25:34 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:44799
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbfKLRZd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 12:25:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0klk/ijCcYdi8/4ohD3BKAx4raE00XHW4iTxQnc3vsUk6z9RqvjkOLATg5k7gM3gUdWT90MGcUZF2a+7p3xkEpony2WNV85Mv3GBGudOvBDXn8qkO6QHI4kyCvJ8OSP99lAzv5SP5uohJbZHnuJi9YgY+3vEQCy6IaGTdKBegm8t1v5tQl/8IcUPnKNdR9BVVsjqkY9gWocghU9C+vHdXAibJdB5hbCXCx/XqEMtPQnWImVbUGAutV1uASo6tNF11272V0cNXNnHOagwb7r7mrV/uCqPe8aNqyL17fdJp/h3GDhGiEf0qym/5xMm7LAXs2FCoXIYcG1op9vxH3nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AvQRflm4HGSQWp+eTuYiUeQHTWG+h/aVgCj8MiKQt8=;
 b=DAa15yOvmbcmM5N4WSnurlwHpBiRaXR8AtTM2fP0m11b4eFYupxayJ4Xxknb3PDeQVCwNQLGptNtmJSVJ7oI8IKOaFMW641zbbdzaRiOt1FJw1diUgViVGSvm9J5B6L/8MSleAd9mWjDUEGVlNai4KufuAeKLJ/pQdry2vIaaBb26Y1v4ItLH/hjxsFhRoDKL2k0JMWC6LFtzTWU3IJ6pP3sY+WSMWZiRv00kv6hhRS/aotERfD7W5wok/FxvZnSr+LTjf5BgDPDfxJqRm7v8EIkgtZLv0nh6LFk62zNmvlK+V7WexfuNbgxAJ+0+2lOYpakIUSM9KNWq84CIznX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AvQRflm4HGSQWp+eTuYiUeQHTWG+h/aVgCj8MiKQt8=;
 b=DV/DdlRaVOQnQjh4+ck08bA2mFAfYFVyQmm0lGw+CyCMZp+qAN4JhaQIXY8jK+/VAQNACAtlHDcI8n+alk8Ick3xv4BIYSKMx8a8oZyWQwEiXU9S2DM/RaAWAAzAcveVw78venl0QvF7WMlHH9S5D68AqJ3QsT4cBQulX2+vs+s=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6286.eurprd04.prod.outlook.com (20.179.25.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 17:25:24 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 17:25:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v5 05/10] interconnect: Add imx core driver
Thread-Topic: [PATCH RFC v5 05/10] interconnect: Add imx core driver
Thread-Index: AQHVkD3dVE6j1m56S06P4p/GMpEdwA==
Date:   Tue, 12 Nov 2019 17:25:24 +0000
Message-ID: <VI1PR04MB702319F8E1A9D6362DA12A2FEE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
 <3f8b65aa7a7eabaedeee27d5bcf8220982ac3597.1572562150.git.leonard.crestez@nxp.com>
 <4fa190b5-b040-b093-9313-e9ccbc9b1da5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8dc3a06-de46-48ac-7cf5-08d767954d80
x-ms-traffictypediagnostic: VI1PR04MB6286:|VI1PR04MB6286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6286146DBD75896AE5257712EE770@VI1PR04MB6286.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(51914003)(5660300002)(110136005)(54906003)(8936002)(256004)(2906002)(14444005)(86362001)(7736002)(66066001)(81156014)(81166006)(76116006)(91956017)(8676002)(7416002)(305945005)(52536014)(6246003)(4326008)(55016002)(71200400001)(71190400001)(99286004)(9686003)(478600001)(6116002)(3846002)(33656002)(66556008)(64756008)(25786009)(446003)(476003)(229853002)(74316002)(26005)(44832011)(486006)(186003)(102836004)(6436002)(76176011)(6506007)(316002)(14454004)(66946007)(66476007)(7696005)(53546011)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6286;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: puc8X2ekUzdSA/58i+8SdaEFYQdggjSD9gUYXkMkL5m/OZymGdUW66d9q6+1uaYMkOsYYjMJKfHSdpUSd2hHVQGVWQywGTg8UzIyXSqOTcZrGIzTFv9NPyv2g5VrEUJJVKzzVAN3fhJRQnr5i6hE13GyzuiLH1y8SnEn4rsvSdjMcAeNxX8cF4wmGmod2ACz3dokKrDTnOKXtp1BLqIHeiJ5v9RhrLrx7KsoBPOCWS4Qly0qAHHG4JCc5U9zoF47Hj7b1ymvxUysoDfIQD/pMhUM3UPP2daw7qAubfd2o3LBxG6cyg6goBFvpShx/wtg4mk6YaoffZ4QTYpywuZ5cAhXc/7Ehgyby9qjZeDtXYFwnHOjXkK75IAWTBFUKLpe0KMpmo5QUuMIe4AsvlyCMAzzEL/lP+KxboH9MheO5/gWjTQEshtGZrK/IJJK0Kq+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dc3a06-de46-48ac-7cf5-08d767954d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 17:25:24.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ig/rCv93DZVAIA0nzn1V8Op8BU76cGM7bUvGInvnLNEQrn27cv9kV/pEpEh3/XWO4NFabJHBmuElfF3sppD4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6286
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTIuMTEuMjAxOSAxNzowOCwgR2VvcmdpIERqYWtvdiB3cm90ZToKPiBIaSBMZW9uYXJkLAo+
IAo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoIQo+IAo+IE9uIDEuMTEuMTkg0LMuIDA6NTIg0YcuLCBM
ZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciBpLk1YIFNvQyBm
YW1pbHkgdG8gaW50ZXJjb25uZWN0IGZyYW1ld29yay4KPj4KPj4gUGxhdGZvcm0gZHJpdmVycyBj
YW4gZGVzY3JpYmUgdGhlIGludGVyY29ubmVjdCBncmFwaCBhbmQgc2V2ZXJhbAo+PiBhZGp1c3Rt
ZW50IGtub2JzIHdoZXJlIGljYyBub2RlIGJhbmR3aWR0aCBpcyBjb252ZXJ0ZWQgdG8gYQo+PiBE
RVZfUE1fUU9TX01JTl9GUkVRVUVOQ1kgcmVxdWVzdC4KPj4KPj4gVGhlIGFkanVzdGFibGUgbm9k
ZXMgYXJlIGZvdW5kIGJhc2VkIG9uIGFuICJpbnRlcmNvbm5lY3Qtbm9kZS1pZCIKPj4gcHJvcGVy
dHkgYnkgc2Nhbm5pbmcgdGhlIGVudGlyZSBkZXZpY2UgdHJlZS4KPiAKPiBBcmUgdGhlIGFkanVz
dGFibGUgbm9kZXMgU29DIHNwZWNpZmljPyBDYW4gd2UgaGF2ZSB0aGVtIGhlcmUgaW4gdGhlIGRy
aXZlcgo+IGluc3RlYWQgb2Ygc2Nhbm5pbmcgdGhlIGVudGlyZSBkZXZpY2UgdHJlZT8KPiAKPj4g
VGhlIGludGVyY29ubmVjdCBwcm92aWRlciBkb2Vzbid0IG5lZWQgYW4gdmlydHVhbCBPRiBub2Rl
LCBpbnN0ZWFkIHRob3NlCj4+IHNhbWUgYWRqdXN0YWJsZSBub2RlcyBhcmUgcmVnaXN0ZXJlZCBh
cyBwcm94aWVzIHdoaWNoIHhsYXRlIHRvIHRoZQo+PiBwbGF0Zm9ybS1sZXZlbCBwcm92aWRlci4K
Pj4KPj4gVGhlIHBsYXRmb3JtIGRldmljZSBmb3IgdGhlIGludGVyY29ubmVjdCBuZWVkcyB0byBi
ZSByZWdpc3RlcmVkIGZyb20gYQo+PiBTT0MgZHJpdmVyIChzaW1pbGFyIHRvIGNwdWZyZXEpLgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcmUgQmFpbG9uIDxhYmFpbG9uQGJheWxpYnJlLmNv
bT4KPj4gU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhw
LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9pbnRlcmNvbm5lY3QvS2NvbmZpZyAgICAgIHwgICAx
ICsKPj4gICBkcml2ZXJzL2ludGVyY29ubmVjdC9NYWtlZmlsZSAgICAgfCAgIDEgKwo+PiAgIGRy
aXZlcnMvaW50ZXJjb25uZWN0L2lteC9LY29uZmlnICB8ICAgNSArCj4+ICAgZHJpdmVycy9pbnRl
cmNvbm5lY3QvaW14L01ha2VmaWxlIHwgICAxICsKPj4gICBkcml2ZXJzL2ludGVyY29ubmVjdC9p
bXgvaW14LmMgICAgfCAyNzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAgZHJp
dmVycy9pbnRlcmNvbm5lY3QvaW14L2lteC5oICAgIHwgIDYwICsrKysrKysKPj4gICA2IGZpbGVz
IGNoYW5nZWQsIDM0MSBpbnNlcnRpb25zKCspCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvaW50ZXJjb25uZWN0L2lteC9LY29uZmlnCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvaW50ZXJjb25uZWN0L2lteC9NYWtlZmlsZQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14LmMKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9pbnRlcmNvbm5lY3QvaW14L2lteC5oCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ludGVy
Y29ubmVjdC9LY29uZmlnIGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvS2NvbmZpZwo+PiBpbmRleCBi
NmVhOGYwYTYxMjIuLmY1N2U3N2I4NzMxYyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pbnRlcmNv
bm5lY3QvS2NvbmZpZwo+PiArKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9LY29uZmlnCj4+IEBA
IC0xMCw3ICsxMCw4IEBAIG1lbnVjb25maWcgSU5URVJDT05ORUNUCj4+ICAgCSAgSWYgdW5zdXJl
LCBzYXkgbm8uCj4+ICAgCj4+ICAgaWYgSU5URVJDT05ORUNUCj4+ICAgCj4+ICAgc291cmNlICJk
cml2ZXJzL2ludGVyY29ubmVjdC9xY29tL0tjb25maWciCj4+ICtzb3VyY2UgImRyaXZlcnMvaW50
ZXJjb25uZWN0L2lteC9LY29uZmlnIgo+PiAgIAo+PiAgIGVuZGlmCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2ludGVyY29ubmVjdC9NYWtlZmlsZSBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L01ha2Vm
aWxlCj4+IGluZGV4IDI4ZjJhYjA4MjRkNS4uMjBhMTNiN2ViMzdmIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2ludGVyY29ubmVjdC9NYWtlZmlsZQo+PiArKysgYi9kcml2ZXJzL2ludGVyY29ubmVj
dC9NYWtlZmlsZQo+PiBAQCAtMiw1ICsyLDYgQEAKPj4gICAKPj4gICBpY2MtY29yZS1vYmpzCQkJ
CTo9IGNvcmUubwo+PiAgIAo+PiAgIG9iai0kKENPTkZJR19JTlRFUkNPTk5FQ1QpCQkrPSBpY2Mt
Y29yZS5vCj4+ICAgb2JqLSQoQ09ORklHX0lOVEVSQ09OTkVDVF9RQ09NKQkJKz0gcWNvbS8KPj4g
K29iai0kKENPTkZJR19JTlRFUkNPTk5FQ1RfSU1YKQkJKz0gaW14Lwo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L0tjb25maWcgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9p
bXgvS2NvbmZpZwo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAu
LjdkODFkM2M4M2E2MQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2RyaXZlcnMvaW50ZXJjb25u
ZWN0L2lteC9LY29uZmlnCj4+IEBAIC0wLDAgKzEsNSBAQAo+PiArY29uZmlnIElOVEVSQ09OTkVD
VF9JTVgKPj4gKwlib29sICJpLk1YIGludGVyY29ubmVjdCBkcml2ZXJzIgo+PiArCWRlcGVuZHMg
b24gQVJDSF9NWEMgfHwgQ09NUElMRV9URVNUCj4+ICsJaGVscAo+PiArCSAgR2VuZXJpYyBpbnRl
cmNvbm5lY3QgZHJpdmVyIGZvciBpLk1YIFNPQ3MKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW50
ZXJjb25uZWN0L2lteC9NYWtlZmlsZSBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9NYWtlZmls
ZQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmJiOTJmZDlm
ZTRhNQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9N
YWtlZmlsZQo+PiBAQCAtMCwwICsxIEBACj4+ICtvYmotJChDT05GSUdfSU5URVJDT05ORUNUX0lN
WCkgKz0gaW14Lm8KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9pbXgu
YyBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9pbXguYwo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0
NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjdkMjQ4ZTAxZGNmMAo+PiAtLS0gL2Rldi9udWxsCj4+
ICsrKyBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9pbXguYwo+PiBAQCAtMCwwICsxLDI3MyBA
QAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4gKy8qCj4+ICsgKiBJ
bnRlcmNvbm5lY3QgZnJhbWV3b3JrIGRyaXZlciBmb3IgaS5NWCBTb0MKPj4gKyAqCj4+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMTksIEJheUxpYnJlCj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTksIE5Y
UAo+PiArICogQXV0aG9yOiBBbGV4YW5kcmUgQmFpbG9uIDxhYmFpbG9uQGJheWxpYnJlLmNvbT4K
Pj4gKyAqIEF1dGhvcjogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4K
Pj4gKyAqLwo+PiArCj4+ICsjaW5jbHVkZSA8bGludXgvZGV2ZnJlcS5oPgo+PiArI2luY2x1ZGUg
PGxpbnV4L2RldmljZS5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L2ludGVyY29ubmVjdC1wcm92aWRl
ci5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L29m
Lmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4+ICsjaW5jbHVkZSA8
bGludXgvcG1fcW9zLmg+Cj4+ICsKPj4gKyNpbmNsdWRlICJpbXguaCIKPj4gKwo+PiArLyogcHJp
dmF0ZSBpY2NfcHJvdmlkZXIgZGF0YSAqLwo+PiArc3RydWN0IGlteF9pY2NfcHJvdmlkZXIgewo+
PiArCXN0cnVjdCBkZXZpY2UgKmRldjsKPiAKPiBXaGF0IGRldmljZSBpcyB0aGlzPyBUaGVyZSBp
cyBhbHJlYWR5IGEgKmRldiBpbiBzdHJ1Y3QgaWNjX3Byb3ZpZGVyLgo+IFBsZWFzZSBhZGQga2Vy
bmVsLWRvYy4KClRoaXMgaXMgc2V0IGFzIGljY19wcm92aWRlci0+ZGF0YSBhbmQgdXNlZCBmb3Ig
eGxhdGUgYnV0IGl0IGNhbiBiZSAKcmVtb3ZlZCBlbnRpcmVseSBpZiBkcml2ZXIgc3dpdGNoZXMg
dG8gaWNjX3hsYXRlX29uZWNlbGwuCgo+PiArLyogcHJpdmF0ZSBpY2Nfbm9kZSBkYXRhICovCj4+
ICtzdHJ1Y3QgaW14X2ljY19ub2RlIHsKPj4gKwljb25zdCBzdHJ1Y3QgaW14X2ljY19ub2RlX2Rl
c2MgKmRlc2M7Cj4+ICsJc3RydWN0IGRldmZyZXEgKmRldmZyZXE7Cj4+ICsJc3RydWN0IGRldl9w
bV9xb3NfcmVxdWVzdCBxb3NfcmVxOwo+PiArfTsKPj4gKwo+PiArc3RhdGljIGludCBpbXhfaWNj
X2FnZ3JlZ2F0ZShzdHJ1Y3QgaWNjX25vZGUgKm5vZGUsIHUzMiB0YWcsCj4+ICsJCQkgICAgIHUz
MiBhdmdfYncsIHUzMiBwZWFrX2J3LAo+PiArCQkJICAgICB1MzIgKmFnZ19hdmcsIHUzMiAqYWdn
X3BlYWspCj4+ICt7Cj4+ICsJKmFnZ19hdmcgKz0gYXZnX2J3Owo+PiArCSphZ2dfcGVhayA9IG1h
eCgqYWdnX3BlYWssIHBlYWtfYncpOwo+PiArCj4+ICsJcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4g
K3N0YXRpYyBzdHJ1Y3QgaWNjX25vZGUgKmlteF9pY2NfeGxhdGUoc3RydWN0IG9mX3BoYW5kbGVf
YXJncyAqc3BlYywgdm9pZCAqZGF0YSkKPj4gK3sKPj4gKwlzdHJ1Y3QgaW14X2ljY19wcm92aWRl
ciAqZGVzYyA9IGRhdGE7Cj4+ICsJc3RydWN0IGljY19wcm92aWRlciAqcHJvdmlkZXIgPSBkZXZf
Z2V0X2RydmRhdGEoZGVzYy0+ZGV2KTsKPj4gKwl1bnNpZ25lZCBpbnQgaWQgPSBzcGVjLT5hcmdz
WzBdOwo+PiArCXN0cnVjdCBpY2Nfbm9kZSAqbm9kZTsKPj4gKwo+PiArCWxpc3RfZm9yX2VhY2hf
ZW50cnkobm9kZSwgJnByb3ZpZGVyLT5ub2Rlcywgbm9kZV9saXN0KQo+PiArCQlpZiAobm9kZS0+
aWQgPT0gaWQpCj4+ICsJCQlyZXR1cm4gbm9kZTsKPj4gKwo+PiArCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgaW50IGlteF9pY2Nfbm9kZV9zZXQoc3RydWN0
IGljY19ub2RlICpub2RlKQo+PiArewo+PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IG5vZGUtPnBy
b3ZpZGVyLT5kZXY7Cj4+ICsJc3RydWN0IGlteF9pY2Nfbm9kZSAqbm9kZV9kYXRhID0gbm9kZS0+
ZGF0YTsKPj4gKwl1NjQgZnJlcTsKPj4gKwo+PiArCWlmICghbm9kZV9kYXRhLT5kZXZmcmVxKQo+
PiArCQlyZXR1cm4gMDsKPj4gKwo+PiArCWZyZXEgPSAobm9kZS0+YXZnX2J3ICsgbm9kZS0+cGVh
a19idykgKiBub2RlX2RhdGEtPmRlc2MtPmFkai0+YndfbXVsOwo+IAo+IFdoeSB0aGUgc3VtIG9m
IGF2ZXJhZ2UgYW5kIHBlYWsgYmFuZHdpZHRoPwoKV2hhdCBlbHNlPwoKQXZlcmFnZXMgZnJvbSBh
bGwgcGF0aCByZXF1ZXN0cyBhcmUgYWRkZWQgYW5kIHRoZSBtYXgoKSBvZiBhbGwgcGVyLXBhdGgg
CnBlYWsgcmVxdWVzdHMgaXMgYWRkZWQgb24gdG9wLiBUaGUgYXZlcmFnZSBCVyBpcyBndWFyYW50
ZWVkIHRvIGJlIApjb25zdW1lZCAoZm9yIGV4YW1wbGUgYSBkaXNwbGF5IGNvbnRyb2xsZXIpIGFu
ZCB0aGUgQlcgZm9yIG9jY2FzaW9uYWwgCmJ1cnN0cyAoc3VjaCBhcyBVU0IpIHNob3VsZCBiZSBy
ZXNlcnZlZCBvbiB0b3Agb2YgdGhhdC4KClVzaW5nIG1heChhdmcsIHBlYWspIGhlcmUgd291bGQg
bWFrZSByZXF1ZXN0cyBmb3IgcGVhayBCVyBsYXJnZWx5IAppbmVmZmVjdGl2ZSB3aGVuIHRoZXJl
J3MgYWxzbyBhIGxhcmdlICJhdmciIHJlcXVlc3QuCgo+PiArCWRvX2RpdihmcmVxLCBub2RlX2Rh
dGEtPmRlc2MtPmFkai0+YndfZGl2KTsKPj4gKwlkZXZfZGJnKGRldiwgIm5vZGUgJXMgZGV2aWNl
ICVzIGF2Z19idyAldWtCcHMgcGVha19idyAldWtCcHMgbWluX2ZyZXEgJWxsdWtIelxuIiwKPj4g
KwkJCW5vZGUtPm5hbWUsIGRldl9uYW1lKG5vZGVfZGF0YS0+ZGV2ZnJlcS0+ZGV2LnBhcmVudCks
Cj4+ICsJCQlub2RlLT5hdmdfYncsIG5vZGUtPnBlYWtfYncsIGZyZXEpOwo+PiArCj4+ICsJaWYg
KGZyZXEgPiBTMzJfTUFYKSB7Cj4+ICsJCWRldl9lcnIoZGV2LCAiJXMgY2FuJ3QgcmVxdWVzdCBt
b3JlIHRoYW4gUzMyX01BWCBmcmVxXG4iLAo+PiArCQkJCW5vZGUtPm5hbWUpOwo+PiArCQlyZXR1
cm4gLUVSQU5HRTsKPj4gKwl9Cj4+ICsKPj4gKwlkZXZfcG1fcW9zX3VwZGF0ZV9yZXF1ZXN0KCZu
b2RlX2RhdGEtPnFvc19yZXEsIGZyZXEpOwo+PiArCj4+ICsJcmV0dXJuIDA7Cj4+ICt9Cj4+ICsK
Pj4gK3N0YXRpYyBpbnQgaW14X2ljY19zZXQoc3RydWN0IGljY19ub2RlICpzcmMsIHN0cnVjdCBp
Y2Nfbm9kZSAqZHN0KQo+PiArewo+PiArCXJldHVybiBpbXhfaWNjX25vZGVfc2V0KGRzdCk7Cj4+
ICt9Cj4+ICsKPj4gK3N0YXRpYyBpbnQgaW14X2ljY19ub2RlX2luaXRfZGV2ZnJlcShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4+ICsJCQkJICAgICBzdHJ1Y3QgaWNjX25vZGUgKm5vZGUpCj4+ICt7Cj4+
ICsJc3RydWN0IGlteF9pY2Nfbm9kZSAqbm9kZV9kYXRhID0gbm9kZS0+ZGF0YTsKPj4gKwlzdHJ1
Y3QgZGV2aWNlX25vZGUgKmRuOwo+PiArCXUzMiBub2RlX2lkOwo+PiArCWludCByZXQ7Cj4+ICsK
Pj4gKwkvKiBGaW5kIG5vZGVzIGJhc2VkIG9uIGludGVyY29ubmVjdC1ub2RlLWlkIHByb3BlcnR5
ICovCj4+ICsJZm9yX2VhY2hfbm9kZV93aXRoX3Byb3BlcnR5KGRuLCAiaW50ZXJjb25uZWN0LW5v
ZGUtaWQiKSB7Cj4+ICsJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRuLCAiaW50ZXJjb25u
ZWN0LW5vZGUtaWQiLAo+PiArCQkJCQkgICAmbm9kZV9pZCk7Cj4+ICsJCWlmIChyZXQgIT0gMCkK
Pj4gKwkJCWNvbnRpbnVlOwo+PiArCj4+ICsJCWlmIChub2RlX2lkID09IG5vZGUtPmlkKSB7Cj4+
ICsJCQlvZl9ub2RlX2dldChkbik7Cj4+ICsJCQlicmVhazsKPj4gKwkJfQo+PiArCX0KPj4gKwo+
PiArCWlmICghZG4pCj4+ICsJCXJldHVybiAwOwo+PiArCj4+ICsJZGV2X2luZm8oZGV2LCAibm9k
ZSAlc1slZF0gaGFzIGRldmljZSBub2RlICVwT0ZcbiIsCj4+ICsJCQlub2RlLT5uYW1lLCBub2Rl
LT5pZCwgZG4pOwo+PiArCW5vZGVfZGF0YS0+ZGV2ZnJlcSA9IGRldmZyZXFfZ2V0X2RldmZyZXFf
Ynlfbm9kZShkbik7Cj4gCj4gQWgsIHNvIHlvdSBuZWVkIHRvIGdldCB0aGUgZGV2ZnJlcSBub2Rl
cz8gU28gbG9va2luZyBhdCB0aGUgbmV4dAo+IHBhdGNoZXMgaXQgc2VlbXMgdGhhdCBub2MgYW5k
IGRkcmMgYXJlIHRoZSBvbmx5IGFkanVzdGFibGUgbm9kZXM/CgpJIHdhbnQgdG8gYWRkIG1vcmUg
c2NhbGFibGUgbm9kZXMgaW4gdGhlIGZ1dHVyZS4gaW14OG1xLzhtbS84bW4gaGF2ZSAKYWRkaXRp
b25hbCBOSUNzIChBWEkgc3dpdGNoZXMgd2l0aCBhIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbikg
YW5kIAp1cGNvbWluZyBpbXg4bXAgd2lsbCBoYXZlIGFkZGl0aW9uYWwgTk9DcyBhbmQgc2NhbGFi
bGUgTlRUUCBsaW5rcy4KCj4gTWF5YmUgd2Ugc2hvdWxkIG1vZGVsIHRoZW0gYm90aCBhcyBpbnRl
cmNvbm5lY3QgcHJvdmlkZXJzLCBhcyB0aGV5Cj4gc2VlbSB0byBiZSBkZWFsaW5nIHdpdGggdGhl
IGJhbmR3aWR0aC9mcmVxdWVuY3kgcmVxdWlyZW1lbnRzIGFuZAo+IGNoYW5naW5nIHRoZSBjbG9j
ayByYXRlcy4KClRoZSBkZHJjIGlzIG5vdCByZWFsbHkgYW4gaW50ZXJjb25uZWN0LCBpdCBvbmx5
IGhhcyBhbiBBWEkgc2xhdmUgcG9ydC4gCkluIHRoZW9yeSBpdCBjb3VsZCByZWdpc3RlciBpdHNl
bGYgYXMgYSBzaW5nbGUtbm9kZSBpY2MgcHJvdmlkZXIgc29sZWx5IApzbyB0aGF0IGl0IGNhbiBo
YW5kbGUgdGhlICJzZXQiIGNhbGwgYnV0IHRoYXQgc2VlbXMgaGFja3kuCgpDdXJyZW50IGljYyBk
cml2ZXIgaW1wbGVtZW50YXRpb25zIHNlbmQgYWdncmVnYXRlZCBCVyByZXF1ZXN0cyB0byBhIApz
ZXBhcmF0ZSBjb250cm9sbGVyIGFuZCBpbnRlcm5hbGx5IGl0IGNoYW5nZXMgc29tZSBmcmVxdWVu
Y2llcywgY29ycmVjdD8gCldoYXQgSSdtIGRvaW5nIGlzIGltcGxlbWVudGluZyB0aGUgZnJlcXVl
bmN5IGFkanVzdG1lbnQgcGFydCBpbnNpZGUgdGhlIAprZXJuZWwgYXMgZGV2ZnJlcSBkcml2ZXJz
LiBUaGVzZSBkZXZpY2VzIGhhdmUgdGhlaXIgb3duIE9GIG5vZGVzIHdpdGggCk9QUCB0YWJsZXMg
YW5kIHN1cHBseSByZWd1bGF0b3JzIGFuZCBnb3Zlcm5vcnMgKGJhc2VkIG9uIGJhbmR3aXRoIApt
ZWFzdXJlbWVudCkuCgpJdCBtYWtlcyBhIGxvdCBvZiBzZW5zZSB0byBsYXllciB0aGUgImludGVy
Y29ubmVjdCIgb24gdG9wIG9mICJzY2FsYWJsZSAKbm9kZXMiLgoKLS0KUmVnYXJkcywKTGVvbmFy
ZAo=

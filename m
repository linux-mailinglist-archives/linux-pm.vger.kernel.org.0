Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0499182
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfHVK6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 06:58:07 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:3255
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387951AbfHVK6H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Aug 2019 06:58:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j45ZuUgEDODS/IDXwGGdtCl8qiBh+DgX8QNWNbS679VaLpCRO3GPj5oI0nTGS1FI0+mIzyoGK9ZxJ3N6EO5DQtWV4BOm4hVo+yZN2YKhZkHPqNEEONq1D47QvNJqegsyy04ph3eq5H9/eMM9vPemEiiN0ozP2HAbgPxAxiYDRYDANb0rIMmEHqYARTQOslpob+Vb0wZLU6/t8EBXG6r9KWkeOln2OcKslkdJcbUShSOYA8Zb7s/nL0GTIg2htRXVEo6wIG2I9ybUiDvKQPNJM5hRA99hEA25r53Jdfo6ac+3ZO+HcapqFoYR9UN5VDS6YsyLCTEyCRTmGBDlLvFRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2GIGHbPEAZk9Iv0op9AZPWrgo3rOWZD8gkoBGfCay0=;
 b=Q9uMF6bAf4NoXFaA+47V0/+POQLct2AtyTU0DELF1jdRitu9ErBElFR8NKwar6OuokBniCTOa+ypS+wAOiLZzeNxMc4x4qZNFno2K/Z9pe723e+8YmSzw1gAuYYsmulP9Pl+Qtk2xOM6iFtEMTiIlwZoprn/hllQ2GTztlcEEJoDtD4JKd41HLc5ZP28xQDKUFdO4V3fNphbriv/1xe2OYghRqZAid5OgkdG2sfoHP5j4T7GWJn0ctzfcyyXtc8c05CGDTugR3m1J589DDNK76nTkFFSuwyPR7nmj/5U4nDHMVAdgEQWsUKunctpv0inKXi4t7CVp6bmeLk1aj8FxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2GIGHbPEAZk9Iv0op9AZPWrgo3rOWZD8gkoBGfCay0=;
 b=MhONwxMdu/fKiKyyNCqfTNNBAhaewBm2c8Fe5qNZLP7t2qVDSb+cA+3r0AJOU+FHnYPfpwX1wJlXwFILo5KNC6iwqmKn6khcD9Br9803VAGwe9hcSCtLh5WWyTAH84ySl4sgJRSh8QpsrqJg6wufvNi7qMLyFGUXLFJIcD9ghhU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4381.eurprd04.prod.outlook.com (20.177.55.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 10:58:03 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 10:58:03 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
Thread-Topic: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
Thread-Index: AQHVV8RskIGk1lt2FkKxkb2XApS7YQ==
Date:   Thu, 22 Aug 2019 10:58:02 +0000
Message-ID: <VI1PR04MB7023D551332373BE98CA60E8EEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566314535.git.leonard.crestez@nxp.com>
 <CGME20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1@epcas4p3.samsung.com>
 <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
 <e2ba9b0d-1930-0d2a-c262-72f0f85c86d0@samsung.com>
 <VI1PR04MB7023A7AC7DDE349BF6D2D2C9EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <921d9eb8-aa38-6e67-ac2e-55e01bf630f5@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fe6671b-fad7-44b0-9f2f-08d726ef9aaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4381;
x-ms-traffictypediagnostic: VI1PR04MB4381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB438145DAD72D7B411ED89E0FEEA50@VI1PR04MB4381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(51444003)(7416002)(229853002)(74316002)(305945005)(53936002)(71200400001)(6246003)(52536014)(14454004)(4326008)(25786009)(91956017)(66946007)(186003)(44832011)(33656002)(256004)(5660300002)(14444005)(476003)(76116006)(478600001)(66476007)(7736002)(53546011)(6506007)(26005)(446003)(66556008)(66446008)(102836004)(486006)(64756008)(55016002)(6436002)(9686003)(81156014)(3846002)(7696005)(6116002)(71190400001)(76176011)(54906003)(110136005)(8936002)(316002)(2906002)(86362001)(8676002)(66066001)(99286004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4381;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pHrHwrT3zPlQXGF3U7SUlVnCwiU7A3bItz9LRg18S33vcjkgHV5Cn4r7B4sJoblI0HOT9lJApYhSWQTwYKEv8HGjQCaRlH/5drKuDUQdFHAXGaV6xnfssNUOh7su+gcJclhSK5REAJXX6kZ4/QvThH750HiPK5V1nrOmwBJ2MRAvTl9GRNLndCyxTnqOnGJjKv4CMe4nBkUkQv8WbjUEtSE/W1PNfDSN2qJnRSARfOng9WeCvAYOW0KYUbGbsNNYriDlZyG5PK/9h9/lEJynblZXQB5weDPpKEKTWaFK8kTuV8CJWxiWBKyZ6Z+nHFhgKS/4yPfRQX+XDwdUAq4ZISWTiOWDuPmzZuu+QXPPlG7dsBdWRlplBp2ewDEuRnsdE4eg1DWxvN2l/OiKukeh//YA+Z920wTzgFGGOjQUfYE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe6671b-fad7-44b0-9f2f-08d726ef9aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 10:58:02.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeAJq1L0phIUv8/E5KZaBCdKVblC7XtIbciL6NReHWGdaZUbohmFKnsJGZ+oKFFCgsY6HGtMw4R6fQqfF6n+mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4381
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gOC8yMi8yMDE5IDE6MDMgUE0sIENoYW53b28gQ2hvaSB3cm90ZToKPiBPbiAxOS4gOC4gMjEu
IOyYpO2bhCAxMDowMywgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+PiBPbiAyMS4wOC4yMDE5IDA1
OjAyLCBDaGFud29vIENob2kgd3JvdGU6Cj4+PiBPbiAxOS4gOC4gMjEuIOyYpOyghCAxMjoyNCwg
TGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+Pj4+IE5vdyB0aGF0IGRldmZyZXEgc3VwcG9ydHMgZGV2
X3BtX3FvcyByZXF1ZXN0cyB3ZSBjYW4gdXNlIHRoZW0gdG8gaGFuZGxlCj4+Pj4gdGhlIG1pbi9t
YXhfZnJlcSB2YWx1ZXMgc2V0IGJ5IHVzZXJzcGFjZSBpbiBzeXNmcywgc2ltaWxhciB0byBjcHVm
cmVxLgo+Pj4+Cj4+Pj4gU2luY2UgZGV2X3BtX3FvcyBoYW5kbGVzIGZyZXF1ZW5jaWVzIGFzIGtI
eiB0aGlzIGNoYW5nZSByZWR1Y2VzIHRoZQo+Pj4+IHByZWNpc2lvbiBvZiBtaW5fZnJlcSBhbmQg
bWF4X2ZyZXEuIFRoaXMgc2hvdWxkbid0IGludHJvZHVjZSBwcm9ibGVtcwo+Pj4+IGJlY2F1c2Ug
ZnJlcXVlbmNpZXMgd2hpY2ggYXJlIG5vdCBhbiBpbnRlZ2VyIG51bWJlciBvZiBrSHogYXJlIGxp
a2VseQo+Pj4+IG5vdCBhbiBpbnRlZ2VyIG51bWJlciBvZiBIeiBlaXRoZXIuCj4+Pj4KPj4+PiBU
cnkgdG8gZW5zdXJlIGNvbXBhdGliaWxpdGl0eSBieSByb3VuZGluZyBtaW4gdmFsdWVzIGRvd24g
YW5kIHJvdW5kaW5nCj4+Pj4gbWF4IHZhbHVlcyB1cC4KPj4+Pgo+Pj4+IFNpbXBsaWZ5IHRoZSB7
bWluLG1heH1fZnJlcV9zdG9yZSBjb2RlIGJ5IHNldHRpbmcgIm51bGwiIHZhbHVlcyBvZiAwIGFu
ZAo+Pj4+IE1BWF9TMzIgcmVzcGVjdGl2ZWx5IGluc3RlYWQgb2YgY2xhbXBpbmcgdG8gd2hhdCBm
cmVxIHRhYmxlcyBhcmUKPj4+PiBhY3R1YWxseSBzdXBwb3J0ZWQuIFZhbHVlcyBhcmUgYWxyZWFk
eSBhdXRvbWF0aWNhbGx5IGNsYW1wZWQgb24KPj4+PiByZWFkYmFjay4KPj4+Pgo+Pj4+IEFsc28g
c2ltcGxpZnkgYnkgZHJvcGluZyB0aGUgbGltaXRhdGlvbiB0aGF0IHVzZXJzcGFjZSBtaW5fZnJl
cSBtdXN0IGJlCj4+Pj4gbG93ZXIgdGhhbiB1c2Vyc3BhY2UgbWF4X2ZyZXEsIGl0IGlzIGFscmVh
ZHkgZG9jdW1lbnRlZCB0aGF0IG1heF9mcmVxCj4+Pj4gdGFrZXMgcHJlY2VkZW5jZS4KPj4+Pgo+
Pj4+IEBAIC0xMzU4LDMzICsxMzcxLDIwIEBAIHN0YXRpYyBzc2l6ZV90IG1pbl9mcmVxX3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4+Pj4g
ICAgCj4+Pj4gICAgCXJldCA9IHNzY2FuZihidWYsICIlbHUiLCAmdmFsdWUpOwo+Pj4+ICAgIAlp
ZiAocmV0ICE9IDEpCj4+Pj4gICAgCQlyZXR1cm4gLUVJTlZBTDsKPj4+PiAgICAKPj4+PiAtCW11
dGV4X2xvY2soJmRmLT5sb2NrKTsKPj4+PiAtCj4+Pj4gLQlpZiAodmFsdWUpIHsKPj4+PiAtCQlp
ZiAodmFsdWUgPiBkZi0+bWF4X2ZyZXEpIHsKPj4+PiAtCQkJcmV0ID0gLUVJTlZBTDsKPj4+PiAt
CQkJZ290byB1bmxvY2s7Cj4+Pj4gLQkJfQo+Pj4KPj4+IEFjdHVhbGx5LCB0aGUgdXNlciBjYW4g
aW5wdXQgdGhlIHZhbHVlIHRoZXkgd2FudC4KPj4+IFNvLCB0aGUgYWJvdmUgY29kZSBpcyBub3Qg
bmVjZXNzYXJ5IGJlY2F1c2UgdGhlIGRldmZyZXEtPnNjYWxpbmdfbWF4X2ZyZXEKPj4+IGlzIG5l
dmVyIG92ZXJmbG93IGZyb20gc3VwcG9ydGVkIG1heGltdW0gZnJlcXVlbmN5LiBUaGUgZGV2ZnJl
cS0+c2NhbGluZ19tYXhfZnJlcQo+Pj4gaXMgYmFzZWQgb24gT1BQIGVudHJpZXMgZnJvbSBEVC4K
Pj4+Cj4+PiBCdXQsIGlmIHdlIHJlcGxhY2UgdGhlIGV4aXN0aW5nIHJlcXVlc3Qgd2F5IG9mIGRl
dmZyZXEtY29vbGluZy5jCj4+PiB3aXRoIGRldl9wbV9xb3MsIGRldmZyZXEtPnNjYWxpbmdfbWF4
X2ZyZXEgZG9lc24ndCBndWFyYW50ZWUKPj4+IHRoZSBzdXBwb3J0ZWQgbWF4aW11bSBmcmVxdWVu
Y3kuID4KPj4+IFdlIG5lZWQgdG8ga2VlcCB0aGUgc3VwcG9ydGVkIG1pbl9mcmVxL21heF9mcmVx
IHZhbHVlIHdpdGhvdXQgZGV2X3BtX3Fvcwo+Pj4gcmVxdWlyZW1lbnQgYmVjYXVzZSB0aGUgZGV2
X3BtX3FvcyByZXF1aXJlbWVudCBtaWdodCBoYXZlIHRoZSBvdmVyZmxvdyB2YWx1ZS4KPj4+IHRo
ZSBkZXZfcG1fcW9zIGRvZXNuJ3Qga25vdyB0aGUgc3VwcG9ydGVkIG1pbmltdW0gYW5kIG1heGlt
dW0gZnJlcXVlbmN5Cj4+PiBvZiBkZXZmcmVxIGRldmljZS4KPj4KPj4gSSdtIG5vdCBzdXJlIEkg
dW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLiBNeSBwYXRjaCBhbGxvd3MgdXNlciB0byBzZXQKPj4g
ZW50aXJlbHkgYXJiaXRyYXJ5IG1pbi9tYXggcmF0ZXMgYW5kIHRoaXMgaXMgZ29vZCBiZWNhdXNl
IHdlIGFscmVhZHkKPj4gaGF2ZSBhIHdlbGwtZGVmaW5lZCB3YXkgdG8gaGFuZGxlIHRoaXM6IG1h
eCBvdmVycmlkZXMgbWluLgo+Pgo+PiBUaGUgc2NhbGluZ19taW5fZnJlcSBhbmQgc2NhbGluZ19t
YXhfZnJlcSB2YXJpYWJsZXMgY2FuIGp1c3QgYmUga2VwdAo+PiBhcm91bmQgaW5kZWZpbml0ZWx5
IG5vIG1hdHRlciB3aGF0IGhhcHBlbnMgdG8gdGhlcm1hbC4gVGhleSdyZSBqdXN0IGEKPj4gY2Fj
aGUgZm9yIGRldl9wbV9vcHBfZmluZF9mcmVxX2NlaWwgYW5kIGRldl9wbV9vcHBfZmluZF9mcmVx
X2Zsb29yLgo+IAo+IFRoaXMgcGF0Y2ggZG9lc24ndCBjaGVjayB0aGUgcmFuZ2Ugb2YgaW5wdXQg
dmFsdWUKPiB3aXRoIHRoZSBzdXBwb3J0ZWQgZnJlcXVlbmNpZXMgb2YgZGV2ZnJlcSBkZXZpY2Uu
Cj4gCj4gRm9yIGV4YW1wbGUsCj4gVGhlIGRldmZyZXEwIGRldmljZSBoYXMgdGhlIGZvbGxvd2lu
ZyBhdmFpbGFibGUgZnJlcXVlbmNpZXMKPiAxMDAwMDAwMDAgMjAwMDAwMDAwIDMwMDAwMDAwMAo+
IAo+IGFuZCB0aGVuIHVzZXIgZW50ZXJzIHRoZSA1MDAwMDAwMDAgYXMgZm9sbG93aW5nOgo+IGVj
aG8gNTAwMDAwMDAwID4gL3N5cy9jbGFzcy9kZXZmcmVxL2RldmZyZXEwL21pbl9mcmVxCj4gCj4g
SW4gcmVzdWx0LCBnZXRfZWZmZWN0aXZlX21pbl9mcmVxKCkgd2lsbCByZXR1cm4gdGhlIDUwMDAw
MDAwMC4KPiBJdCBpcyB3cm9uZyB2YWx1ZS4gaXQgc2hvdyB0aGUgdW5zdXBwb3J0ZWQgZnJlcXVl
bmN5IHRocm91Z2gKPiBtaW5fZnJlcSBzeXNmcyBwYXRoLgoKVGhyb3VnaCBkZXZfcG1fcW9zIGRl
dmljZXMgY2FuIGFsc28gYXNrIGZvciBhIGZyZXEgaGlnaGVyIHRoYW4gdGhlIAptYXhpbXVtIE9Q
UCBhbmQgdW5saWtlIHN5c2ZzIHRoZXJlIGlzIG5vIHdheSB0byByZWplY3Qgc3VjaCByZXF1ZXN0
cywgCmluc3RlYWQgUE0gcW9zIGNsYWltcyBpdCdzIGJhc2VkIG9uICJiZXN0IGVmZm9ydCIuCgpU
aGVyZSBhcmUgbWFueSByZXF1ZXN0cyBpbiB0aGUga2VybmVsIGZvciAiUE1fUU9TX0NQVV9ETUFf
TEFURU5DWSAwIiBhbmQgCkkgdGhpbmsgdGhhdCBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1ksIE1B
WF9TMzIgaXMgYSByZWFzb25hYmxlIHdheSBmb3IgYSAKZGV2aWNlIHRvIHJlcXVlc3QgIm1heCBw
ZXJmb3JtYW5jZSIgZnJvbSBkZXZmcmVxLgoKUmVqZWN0aW5nIG1pbiA+IG1heCBpcyBjb21wbGlj
YXRlZCAod2hhdCBoYXBwZW5zIHRvIHJlamVjdGVkIHJlcXVlc3RzIAp3aGVuIG1heCBnb2VzIGJh
Y2sgdXA/KSBhbmQgSSB0aGluayBpdCdzIGJldHRlciB0byBqdXN0IHN0aWNrIHdpdGggYSAKIm1h
eCBvdmVycmlkZXMgbWluIiBwb2xpY3kgc2luY2UgaXQgY2FuIGFscmVhZHkgZGVhbCB3aXRoIGNv
bmZsaWN0cy4KCkRvIHlvdSBoYXZlIGEgdXNlY2FzZSBmb3IgcmVqZWN0aW5nIG91dC1vZi1yYW5n
ZSBtaW5fZnJlcSBmcm9tIAp1c2Vyc3BhY2U/IGNwdWZyZXEgYWxzbyBhY2NlcHRzIGFyYml0cmFy
eSBtaW4vbWF4IHZhbHVlcyBhbmQgaGFuZGxlcyB0aGVtLgoKSW4gdGhlb3J5IHBtX3FvcyBjb3Vs
ZCBiZSBleHRlbmRlZCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gInNvZnQiIApyZXF1ZXN0cyAo
Y3VycmVudCBiZWhhdmlvcikgYW5kICJoYXJkIiByZXF1ZXN0cyB3aGljaCByZXR1cm4gZXJyb3Jz
IGlmIAp0aGV5IGNhbid0IGJlIGd1YXJhbnRlZWQgYnV0IHRoaXMgaXMgZmFyIG91dCBvZiBzY29w
ZS4KCi0tClJlZ2FyZHMsCkxlb25hcmQK

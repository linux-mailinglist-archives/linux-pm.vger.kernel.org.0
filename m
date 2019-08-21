Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8997A44
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 15:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfHUNDa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 09:03:30 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:41703
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUND3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Aug 2019 09:03:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYhVDZua8OwbGRHrdvM2spIhgyucLyMerCv7x3As54AoTrX2i5N1o5FfmGgr2LSsC4qFSj5E13xgbfw4NhZHHiPGrt09z2HYkjcJ8LjIOMg0iHvM0SdNJIhMlnxFkR5L4q6mew+VGEf1x45XjZ3tht2bdiZJK4L7z/b5zlXFLK6Zh2mM/1oYaWbZ4LPqkQ3FODmmqf3oXbVg/mwibC2umFKK2IUiUhmVLc9LY+Wsw+9O75imJcxj1uoxVzVJBWno4f1F2puEA29ZfsOXNs4zshsDTq+DEgng4Rwx25L1ngQsJOo1vHnkAIdrDS98sXP0bOd+CLOIIvfzw61JsN4IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LvKmHlGfjeNiCB6hk09YYdW88aZ5Md519hlj+tPGdo=;
 b=eAzsoXBQddjHl/XbUXicsuT/VTubEPFvDnM3Z9pGk7P8Go+03xvyfSlZKnFtjQGhw/ZuqgP+MPYgEhCj8giL8lKmvHoCaSvQvdU8m8Sygon6VSqCH8u4cKm7ZarIOD3PHFjOXsASD4VF5GwENUH7SNEf91QDI4LmsV9NCBIRK2uBfo/Qxqg2m8cd/o6DGfmgnWq35qPvci71H4y0tQ6BX/dibsBuEYPDqtV3qyFKOBEmEDfUZoUodfAZ2pPE+yES9Mket0ngqbZ1Tj3zZYRZGSNXSO7imMOYPCZ5+qQSXCwo+Rbhx/EdrYuYaYFMcEfskL8EluwgvFIIqwNCUJ762w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LvKmHlGfjeNiCB6hk09YYdW88aZ5Md519hlj+tPGdo=;
 b=tBnYZbXjlIqJQNBfDYMahrZ0TgdE2T4Xmyy/Uh7i6BxYMrgCxzE+fhPdGMQq+bmx3mvaE+EjTXfvnv64ckg9Ue6Urgd9nsZIjlNL6G6iCNOXb2d6IRCb+hOZ5OYeVBUj38Fw3aHnqOJ06F6owPZpNSj+fQJQXIrsi0Pb6B8AsPw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5871.eurprd04.prod.outlook.com (20.178.205.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 13:03:24 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 13:03:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
Thread-Topic: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
Thread-Index: AQHVV8RskIGk1lt2FkKxkb2XApS7YQ==
Date:   Wed, 21 Aug 2019 13:03:24 +0000
Message-ID: <VI1PR04MB7023A7AC7DDE349BF6D2D2C9EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566314535.git.leonard.crestez@nxp.com>
 <CGME20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1@epcas4p3.samsung.com>
 <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
 <e2ba9b0d-1930-0d2a-c262-72f0f85c86d0@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd76a5f2-f2d6-4151-7e88-08d72637f35b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5871;
x-ms-traffictypediagnostic: VI1PR04MB5871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB58713E21302F33A76AE33D58EEAA0@VI1PR04MB5871.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(66946007)(186003)(76116006)(66446008)(64756008)(66556008)(66476007)(14454004)(91956017)(7416002)(53936002)(102836004)(66066001)(6246003)(8676002)(53546011)(316002)(9686003)(478600001)(33656002)(446003)(7736002)(305945005)(6506007)(99286004)(256004)(476003)(71200400001)(71190400001)(3846002)(6116002)(25786009)(7696005)(2906002)(110136005)(81156014)(6436002)(44832011)(74316002)(14444005)(55016002)(86362001)(76176011)(52536014)(8936002)(486006)(4326008)(5660300002)(229853002)(81166006)(54906003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5871;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hWjHr8B5ndnKSTd/ryZol8kWIuDWDnDOTag1jSYJQYpl5S0btMNzxPo37FBkju9yeCUuuk9sDBb+iTxRkEzbBM/v4H/W5C0dkYcj2f6FcMfQMB0FKceAz8+n5In5UXMnZqzlwWMrYh7+6OpnKXzrbaC8FwJWEL+1tV7wK8QVf9NV4Ci4OLf2wpyhIlu8n4lDttUaJgD4e0uNtViBSTIY0xxlRag+f722qT/gJjLHYnSVdu4zm59UxaQOV/7Du53tIzEo6hPMciVWpbTAYEr7FCjVR2yWvMl2em+mB9HRIQIqceqf6XAP3murrmpAiPPc51JKLFhFdv/K5mL00fWmV9nx8ENHD9aFoucj77oyRcc4YLNKTJ4gKOGe1f8AMUifRShIgkGUmPP9Eo5AErk4ae+RlwS8dbOkNPkkwVr61nQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd76a5f2-f2d6-4151-7e88-08d72637f35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 13:03:24.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjUt7QsgyL7edfIKG8PudD2gmpYdZhcwem9t5HgYvfmyhjPmV2ZiIeUwq7effNBPcjgSXmRkRyjZ2jFTLOIGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5871
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjEuMDguMjAxOSAwNTowMiwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IE9uIDE5LiA4LiAyMS4g
7Jik7KCEIDEyOjI0LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+IE5vdyB0aGF0IGRldmZyZXEg
c3VwcG9ydHMgZGV2X3BtX3FvcyByZXF1ZXN0cyB3ZSBjYW4gdXNlIHRoZW0gdG8gaGFuZGxlCj4+
IHRoZSBtaW4vbWF4X2ZyZXEgdmFsdWVzIHNldCBieSB1c2Vyc3BhY2UgaW4gc3lzZnMsIHNpbWls
YXIgdG8gY3B1ZnJlcS4KPj4KPj4gU2luY2UgZGV2X3BtX3FvcyBoYW5kbGVzIGZyZXF1ZW5jaWVz
IGFzIGtIeiB0aGlzIGNoYW5nZSByZWR1Y2VzIHRoZQo+PiBwcmVjaXNpb24gb2YgbWluX2ZyZXEg
YW5kIG1heF9mcmVxLiBUaGlzIHNob3VsZG4ndCBpbnRyb2R1Y2UgcHJvYmxlbXMKPj4gYmVjYXVz
ZSBmcmVxdWVuY2llcyB3aGljaCBhcmUgbm90IGFuIGludGVnZXIgbnVtYmVyIG9mIGtIeiBhcmUg
bGlrZWx5Cj4+IG5vdCBhbiBpbnRlZ2VyIG51bWJlciBvZiBIeiBlaXRoZXIuCj4+Cj4+IFRyeSB0
byBlbnN1cmUgY29tcGF0aWJpbGl0aXR5IGJ5IHJvdW5kaW5nIG1pbiB2YWx1ZXMgZG93biBhbmQg
cm91bmRpbmcKPj4gbWF4IHZhbHVlcyB1cC4KPj4KPj4gU2ltcGxpZnkgdGhlIHttaW4sbWF4fV9m
cmVxX3N0b3JlIGNvZGUgYnkgc2V0dGluZyAibnVsbCIgdmFsdWVzIG9mIDAgYW5kCj4+IE1BWF9T
MzIgcmVzcGVjdGl2ZWx5IGluc3RlYWQgb2YgY2xhbXBpbmcgdG8gd2hhdCBmcmVxIHRhYmxlcyBh
cmUKPj4gYWN0dWFsbHkgc3VwcG9ydGVkLiBWYWx1ZXMgYXJlIGFscmVhZHkgYXV0b21hdGljYWxs
eSBjbGFtcGVkIG9uCj4+IHJlYWRiYWNrLgo+Pgo+PiBBbHNvIHNpbXBsaWZ5IGJ5IGRyb3Bpbmcg
dGhlIGxpbWl0YXRpb24gdGhhdCB1c2Vyc3BhY2UgbWluX2ZyZXEgbXVzdCBiZQo+PiBsb3dlciB0
aGFuIHVzZXJzcGFjZSBtYXhfZnJlcSwgaXQgaXMgYWxyZWFkeSBkb2N1bWVudGVkIHRoYXQgbWF4
X2ZyZXEKPj4gdGFrZXMgcHJlY2VkZW5jZS4KPj4KPj4gQEAgLTEzNTgsMzMgKzEzNzEsMjAgQEAg
c3RhdGljIHNzaXplX3QgbWluX2ZyZXFfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKPj4gICAKPj4gICAJcmV0ID0gc3NjYW5mKGJ1ZiwgIiVs
dSIsICZ2YWx1ZSk7Cj4+ICAgCWlmIChyZXQgIT0gMSkKPj4gICAJCXJldHVybiAtRUlOVkFMOwo+
PiAgIAo+PiAtCW11dGV4X2xvY2soJmRmLT5sb2NrKTsKPj4gLQo+PiAtCWlmICh2YWx1ZSkgewo+
PiAtCQlpZiAodmFsdWUgPiBkZi0+bWF4X2ZyZXEpIHsKPj4gLQkJCXJldCA9IC1FSU5WQUw7Cj4+
IC0JCQlnb3RvIHVubG9jazsKPj4gLQkJfQo+IAo+IEFjdHVhbGx5LCB0aGUgdXNlciBjYW4gaW5w
dXQgdGhlIHZhbHVlIHRoZXkgd2FudC4KPiBTbywgdGhlIGFib3ZlIGNvZGUgaXMgbm90IG5lY2Vz
c2FyeSBiZWNhdXNlIHRoZSBkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVxCj4gaXMgbmV2ZXIgb3Zl
cmZsb3cgZnJvbSBzdXBwb3J0ZWQgbWF4aW11bSBmcmVxdWVuY3kuIFRoZSBkZXZmcmVxLT5zY2Fs
aW5nX21heF9mcmVxCj4gaXMgYmFzZWQgb24gT1BQIGVudHJpZXMgZnJvbSBEVC4KPiAKPiBCdXQs
IGlmIHdlIHJlcGxhY2UgdGhlIGV4aXN0aW5nIHJlcXVlc3Qgd2F5IG9mIGRldmZyZXEtY29vbGlu
Zy5jCj4gd2l0aCBkZXZfcG1fcW9zLCBkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVxIGRvZXNuJ3Qg
Z3VhcmFudGVlCj4gdGhlIHN1cHBvcnRlZCBtYXhpbXVtIGZyZXF1ZW5jeS4gPgo+IFdlIG5lZWQg
dG8ga2VlcCB0aGUgc3VwcG9ydGVkIG1pbl9mcmVxL21heF9mcmVxIHZhbHVlIHdpdGhvdXQgZGV2
X3BtX3Fvcwo+IHJlcXVpcmVtZW50IGJlY2F1c2UgdGhlIGRldl9wbV9xb3MgcmVxdWlyZW1lbnQg
bWlnaHQgaGF2ZSB0aGUgb3ZlcmZsb3cgdmFsdWUuCj4gdGhlIGRldl9wbV9xb3MgZG9lc24ndCBr
bm93IHRoZSBzdXBwb3J0ZWQgbWluaW11bSBhbmQgbWF4aW11bSBmcmVxdWVuY3kKPiBvZiBkZXZm
cmVxIGRldmljZS4KCkknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi4gTXkg
cGF0Y2ggYWxsb3dzIHVzZXIgdG8gc2V0IAplbnRpcmVseSBhcmJpdHJhcnkgbWluL21heCByYXRl
cyBhbmQgdGhpcyBpcyBnb29kIGJlY2F1c2Ugd2UgYWxyZWFkeSAKaGF2ZSBhIHdlbGwtZGVmaW5l
ZCB3YXkgdG8gaGFuZGxlIHRoaXM6IG1heCBvdmVycmlkZXMgbWluLgoKVGhlIHNjYWxpbmdfbWlu
X2ZyZXEgYW5kIHNjYWxpbmdfbWF4X2ZyZXEgdmFyaWFibGVzIGNhbiBqdXN0IGJlIGtlcHQgCmFy
b3VuZCBpbmRlZmluaXRlbHkgbm8gbWF0dGVyIHdoYXQgaGFwcGVucyB0byB0aGVybWFsLiBUaGV5
J3JlIGp1c3QgYSAKY2FjaGUgZm9yIGRldl9wbV9vcHBfZmluZF9mcmVxX2NlaWwgYW5kIGRldl9w
bV9vcHBfZmluZF9mcmVxX2Zsb29yLgoKQlRXOiBJIG5vdGljZWQgdGhhdCBzY2FsaW5nX21pbl9m
cmVxIGFuZCBzY2FsaW5nX21heF9mcmVxIGFyZSB1cGRhdGVkIGluIApkZXZmcmVxX25vdGlmaWVy
X2NhbGwgYnV0IGRldmZyZXEtPm5iIGlzIG5vdCByZWdpc3RlcmVkIGJ5IGRlZmF1bHQsIG9ubHkg
CndoZW4gYSBkcml2ZXIgcmVxdWVzdHMgaXQgZXhwbGljaXRseS4gSXMgdGhlcmUgYSByZWFzb24g
Zm9yIHRoaXM/CkJlY2F1c2UgSSdkIGNhbGwgZGV2X3BtX29wcF9yZWdpc3Rlcl9ub3RpZmllciBp
bnNpZGUgZGV2ZnJlcV9hZGRfZGV2aWNlIAphbmQgcmVtb3ZlIGFsbCB0aGUgZGV2ZnJlcV9yZWdp
c3Rlci91bnJlZ2lzdGVyX25vdGlmaWVyIEFQSXMuCgotLQpSZWdhcmRzLApMZW9uYXJkCg==

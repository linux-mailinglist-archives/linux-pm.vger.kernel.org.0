Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB1C3062
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 11:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfJAJjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 05:39:25 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:18577
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729537AbfJAJjZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Oct 2019 05:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdTzqDYpAebljJ0+fmFCo+B3b4zcswBCdRTxabM7q98YGxwo7kcN7/Vl7hzfY9Gl67D0FvbFY6Fwkxz77IAadzxIXewmnZaIExFZ9Vr+4a9GCM2fV13JceiD6md94/cpdQ0FUJj8dXBySAap5JE5WmzD46MuwOJpQhc5GFuFlwEEb0ZkF2UUvp+ilu1pQ8vkkWDY0ef5boo/lZZn8VzTZpDSQEx78Ya5M6pEnr0purS6nD389xbNs1G/X+30OglUZvFdIx3xDD3LU8s23z/EJh/oVRIkAcmc2k7DGTkxVyX9NunZh16V5iCYnApgEKMBw1TKLbr3CypTxtg1hhCfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmlIZHrXg2AWgg1RP9VKH5dMXdNROy+vTcmUGpfg9FM=;
 b=SwlzgDtCN4VTscr0QgKNhe/vZD7ApF7CK8XaTGKuU2drJRQ353s4WrKDHNKruf8hoA0NVU8x4MicQ5BXzSAKamITGOHIM3xTMMTs6weXDGxgA9h6QQ0Pl+jU5SfgDo9lFyClnwUIvKO8DiG9U9UftM/FaQnD8E0zPqF0FN9WeskSQrrBVFht3EiaJSezXpSzZDDsbqwYqfnaNJRujN6aTxbyknsivJUI9g+gS64ZfnMtwQasXqjOnHX3ALyeVKN45fHmRUqQdxB4V/Wy4tTgrWC8/BZEG8WsboZ5kZ9B264oWdHSQk5jZQrbpHTyuQYO4kJZaaPlSsgkkd0Sd7+AXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmlIZHrXg2AWgg1RP9VKH5dMXdNROy+vTcmUGpfg9FM=;
 b=okowUuNLG5UFTDtlApRKwJeDfHVZ3LDswI3xYOxPrSkblKHvypgKbk2I7TDKHQSBcgHO/wLRqaEqVCSdyUt2BLumpPEB0B3ic1r3Ibvm8z5zWffeS2AQaX7zft9A2JmEMcASCfKm4aT8WGY4IQLsVvzdyU9+A6AMYJa2UvaN2cw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4557.eurprd04.prod.outlook.com (20.177.55.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 09:39:17 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 09:39:17 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
Thread-Topic: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
Thread-Index: AQHVcsB0h3rfWi61w06V80OWKl85wg==
Date:   Tue, 1 Oct 2019 09:39:17 +0000
Message-ID: <VI1PR04MB7023C82B1F961BAF859831E3EE9D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
 <CGME20190924101145epcas4p37f7d25b8743c25520b33fa392cd80d45@epcas4p3.samsung.com>
 <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
 <40885624-8f11-4eea-d5bf-d6bb50fa44dd@samsung.com>
 <VI1PR04MB7023573BA3D5C5D521DB689CEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <5f12931b-92f8-15d8-8498-f02a7c2e999f@samsung.com>
 <VI1PR04MB702397D04A0F2FFE8111E341EE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <2c0f7b6f-97df-9548-dde5-dda95f6a447c@samsung.com>
 <VI1PR04MB7023F003BBE96894FEB0C7AFEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <bb942624-f6ad-56c8-5a7c-32ed77d1f789@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0739df7-9efd-4163-7ced-08d746533a7d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB4557:|VI1PR04MB4557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4557D995ACE4B9BCF207577CEE9D0@VI1PR04MB4557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(51444003)(189003)(199004)(99286004)(76176011)(66066001)(14454004)(30864003)(7696005)(2906002)(9686003)(55016002)(110136005)(316002)(44832011)(486006)(54906003)(476003)(446003)(52536014)(33656002)(5660300002)(25786009)(86362001)(4326008)(102836004)(6506007)(53546011)(6246003)(186003)(76116006)(64756008)(91956017)(26005)(66476007)(478600001)(66446008)(66556008)(66946007)(74316002)(7416002)(71190400001)(71200400001)(6116002)(3846002)(81166006)(81156014)(8936002)(14444005)(8676002)(256004)(229853002)(305945005)(6436002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4557;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUaj+le2E6Mng8HFD+Wp/8ECEgAymFoNpIBNJn1FCa7HtaLMngyYIBp3kX5qHR5OFOtGJxbGXqDImfldmHgKSdZX1WHaPgCHcfuxKD2sbGGMS1wycZdBIzeubH3ITdBr0e7/p+3iPUZZOHCaI/00mlQnFtqPYQMdOvZQt0r7QtLQ5QEiIaJM/GF6pzBvts6HGbzapNfjwwM5Zf0bPyqE+3QqaiiOsdvXhFPEICdO/txi1e+NAhadFRS5A9Tu2PNUYz4TlsubcOF9uCJre8aJoWStmM/XXldT5LvL9pTyMTKEv3MaCttL5CfqLRUUwEM2snowb9Riiizyy4+0qQ+djTCq1AiOQ15Fi8DWiJi+hcY1lxjIuP5T0g+OJviHQ5vJRqDvsx9jWB7YbHp1sG1UkU8dyCRaD5Zt0LcOH1NjNuE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0739df7-9efd-4163-7ced-08d746533a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 09:39:17.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDFZVeKdJSK3gDQJrMDjm1I7XmZIzt5JPqrxIAEaTFvT0LizrLqCeRzvcHMmkGP1vBA1yBT8VWthq2UxTg0+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4557
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjAxOS0xMC0wMSAxMjozNyBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhpLAo+IAo+IE9u
IDE5LiA5LiAzMC4g7Jik7ZuEIDEwOjE2LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+IE9uIDIw
MTktMDktMjcgNDo0NSBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+Pj4gT24gMTkuIDkuIDI2LiDs
mKTtm4QgMTA6NDMsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToKPj4+PiBPbiAyMDE5LTA5LTI2IDQ6
MDcgQU0sIENoYW53b28gQ2hvaSB3cm90ZToKPj4+Pj4gT24gMTkuIDkuIDI2LiDsmKTsoIQgNjox
OCwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+Pj4+Pj4gT24gMjUuMDkuMjAxOSAwNToxMSwgQ2hh
bndvbyBDaG9pIHdyb3RlOgo+Pj4+Pj4+IE9uIDE5LiA5LiAyNC4g7Jik7ZuEIDc6MTEsIExlb25h
cmQgQ3Jlc3RleiB3cm90ZToKPj4+Pj4+Pj4gUmVnaXN0ZXIgbm90aWZpZXJzIHdpdGggdGhlIFBN
IFFvUyBmcmFtZXdvcmsgaW4gb3JkZXIgdG8gcmVzcG9uZCB0bwo+Pj4+Pj4+PiByZXF1ZXN0cyBm
b3IgREVWX1BNX1FPU19NSU5fRlJFUVVFTkNZIGFuZCBERVZfUE1fUU9TX01BWF9GUkVRVUVOQ1ku
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IE5vIG5vdGlmaWVycyBhcmUgYWRkZWQgYnkgdGhpcyBwYXRjaCBi
dXQgUE0gUW9TIGNvbnN0cmFpbnRzIGNhbiBiZQo+Pj4+Pj4+PiBpbXBvc2VkIGV4dGVybmFsbHkg
KGZvciBleGFtcGxlIGZyb20gb3RoZXIgZGV2aWNlcykuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4+Pj4+
Pj4+IFJldmlld2VkLWJ5OiBNYXR0aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9yZz4KPj4+
Pj4+Pj4gLS0tCj4+Pj4+Pj4+ICAgICAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDc1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+Pj4+PiAgICAgIGluY2x1
ZGUvbGludXgvZGV2ZnJlcS5oICAgfCAgNSArKysKPj4+Pj4+Pj4gICAgICAyIGZpbGVzIGNoYW5n
ZWQsIDgwIGluc2VydGlvbnMoKykKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+Pj4+Pj4+
IGluZGV4IGVlZTQwM2U3MGM4NC4uNzg0ZjNlNDA1MzZhIDEwMDY0NAo+Pj4+Pj4+PiAtLS0gYS9k
cml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9k
ZXZmcmVxLmMKPj4+Pj4+Pj4gQEAgLTIyLDE1ICsyMiwxOCBAQAo+Pj4+Pj4+PiAgICAgICNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KPj4+Pj4+Pj4gICAgICAjaW5jbHVkZSA8bGlu
dXgvbGlzdC5oPgo+Pj4+Pj4+PiAgICAgICNpbmNsdWRlIDxsaW51eC9wcmludGsuaD4KPj4+Pj4+
Pj4gICAgICAjaW5jbHVkZSA8bGludXgvaHJ0aW1lci5oPgo+Pj4+Pj4+PiAgICAgICNpbmNsdWRl
IDxsaW51eC9vZi5oPgo+Pj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L3BtX3Fvcy5oPgo+Pj4+Pj4+
PiAgICAgICNpbmNsdWRlICJnb3Zlcm5vci5oIgo+Pj4+Pj4+PiAgICAgIAo+Pj4+Pj4+PiAgICAg
ICNkZWZpbmUgQ1JFQVRFX1RSQUNFX1BPSU5UUwo+Pj4+Pj4+PiAgICAgICNpbmNsdWRlIDx0cmFj
ZS9ldmVudHMvZGV2ZnJlcS5oPgo+Pj4+Pj4+PiAgICAgIAo+Pj4+Pj4+PiArI2RlZmluZSBIWl9Q
RVJfS0haCTEwMDAKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiAgICAgIHN0YXRpYyBzdHJ1Y3QgY2xhc3Mg
KmRldmZyZXFfY2xhc3M7Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAgICAgLyoKPj4+Pj4+Pj4g
ICAgICAgKiBkZXZmcmVxIGNvcmUgcHJvdmlkZXMgZGVsYXllZCB3b3JrIGJhc2VkIGxvYWQgbW9u
aXRvcmluZyBoZWxwZXIKPj4+Pj4+Pj4gICAgICAgKiBmdW5jdGlvbnMuIEdvdmVybm9ycyBjYW4g
dXNlIHRoZXNlIG9yIGNhbiBpbXBsZW1lbnQgdGhlaXIgb3duCj4+Pj4+Pj4+IEBAIC0xMDksMTAg
KzExMiwxMSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBmaW5kX2F2YWlsYWJsZV9tYXhfZnJlcShz
dHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4+Pj4+Pj4gICAgICBzdGF0aWMgdm9pZCBnZXRfZnJl
cV9yYW5nZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPj4+Pj4+Pj4gICAgICAJCQkgICB1bnNp
Z25lZCBsb25nICptaW5fZnJlcSwKPj4+Pj4+Pj4gICAgICAJCQkgICB1bnNpZ25lZCBsb25nICpt
YXhfZnJlcSkKPj4+Pj4+Pj4gICAgICB7Cj4+Pj4+Pj4+ICAgICAgCXVuc2lnbmVkIGxvbmcgKmZy
ZXFfdGFibGUgPSBkZXZmcmVxLT5wcm9maWxlLT5mcmVxX3RhYmxlOwo+Pj4+Pj4+PiArCXVuc2ln
bmVkIGxvbmcgcW9zX21pbl9mcmVxLCBxb3NfbWF4X2ZyZXE7Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+
Pj4+ICAgICAgCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmRldmZyZXEtPmxvY2spOwo+Pj4+Pj4+PiAg
ICAgIAo+Pj4+Pj4+PiAgICAgIAkvKgo+Pj4+Pj4+PiAgICAgIAkgKiBJbml0IG1pbi9tYXggZnJl
cXVlbmN5IGZyb20gZnJlcSB0YWJsZS4KPj4+Pj4+Pj4gQEAgLTEyNSwxMCArMTI5LDE4IEBAIHN0
YXRpYyB2b2lkIGdldF9mcmVxX3JhbmdlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxLAo+Pj4+Pj4+
PiAgICAgIAl9IGVsc2Ugewo+Pj4+Pj4+PiAgICAgIAkJKm1pbl9mcmVxID0gZnJlcV90YWJsZVtk
ZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUgLSAxXTsKPj4+Pj4+Pj4gICAgICAJCSptYXhfZnJl
cSA9IGZyZXFfdGFibGVbMF07Cj4+Pj4+Pj4+ICAgICAgCX0KPj4+Pj4+Pj4gICAgICAKPj4+Pj4+
Pj4gKwkvKiBjb25zdHJhaW50cyBmcm9tIFBNIFFvUyAqLwo+Pj4+Pj4+Cj4+Pj4+Pj4gQXMgSSBj
b21tZW50ZWQgb24gcGF0Y2g0LAo+Pj4+Pj4+ICdjb25zdHJhaW50cycgLT4gJ0NvbnN0cmFpbnQn
IGJlY2F1c2UgZmlyc3QgdmVyYiBoYXZlIHRvIGJlIHVzZWQKPj4+Pj4+PiBhcyB0aGUgc2lndWxh
ciB2ZXJicy4KPj4+Pj4+Cj4+Pj4+PiBBbHJlYWR5IGRpc2N1c3NlZCBmb3IgYW5vdGhlciBwYXRj
aDsgSSB3aWxsIG1vZGlmeSB0byAiQXBwbHkgY29uc3RyYWludHMKPj4+Pj4+IGZyb20gUE0gUW9T
IiBpbnN0ZWFkLgo+Pj4+Pgo+Pj4+PiBJIGFncmVlIHRoZSBuZXcgY29tbWVudCB3aXRoICdBcHBs
eSBjb25zdHJhaW50cyAuLi4gJy4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4gSSBwcmVmZXIgdG8gdXNl
IGZvbGxvd2luZyBjb21tZW50czoKPj4+Pj4+Pgo+Pj4+Pj4+IAkvKiBDb25zdHJhaW50IG1pbmlt
dW0vbWF4aW11bSBmcmVxdWVuY3kgZnJvbSBQTSBRb1MgY29uc3RyYWludHMgKi8KPj4+Pj4+Pgo+
Pj4+Pj4+PiArCXFvc19taW5fZnJlcSA9IGRldl9wbV9xb3NfcmVhZF92YWx1ZShkZXZmcmVxLT5k
ZXYucGFyZW50LAo+Pj4+Pj4+PiArCQkJCQkgICAgIERFVl9QTV9RT1NfTUlOX0ZSRVFVRU5DWSk7
Cj4+Pj4+Pj4+ICsJcW9zX21heF9mcmVxID0gZGV2X3BtX3Fvc19yZWFkX3ZhbHVlKGRldmZyZXEt
PmRldi5wYXJlbnQsCj4+Pj4+Pj4+ICsJCQkJCSAgICAgREVWX1BNX1FPU19NSU5fRlJFUVVFTkNZ
KTsKPj4+Pj4+Pj4gKwkqbWluX2ZyZXEgPSBtYXgoKm1pbl9mcmVxLCBIWl9QRVJfS0haICogcW9z
X21pbl9mcmVxKTsKPj4+Pj4+Pj4gKwkqbWF4X2ZyZXEgPSBtaW4oKm1heF9mcmVxLCBIWl9QRVJf
S0haICogcW9zX21heF9mcmVxKTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiAgICAgIAkvKiBjb25zdHJh
aW50cyBmcm9tIHN5c2ZzICovCj4+Pj4+Pj4+ICAgICAgCSptaW5fZnJlcSA9IG1heCgqbWluX2Zy
ZXEsIGRldmZyZXEtPm1pbl9mcmVxKTsKPj4+Pj4+Pj4gICAgICAJKm1heF9mcmVxID0gbWluKCpt
YXhfZnJlcSwgZGV2ZnJlcS0+bWF4X2ZyZXEpOwo+Pj4+Pj4+PiAgICAgIAo+Pj4+Pj4+PiAgICAg
IAkvKiBjb25zdHJhaW50cyBmcm9tIE9QUCBpbnRlcmZhY2UgKi8KPj4+Pj4+Pj4gQEAgLTYwNiwx
MCArNjE4LDQ5IEBAIHN0YXRpYyBpbnQgZGV2ZnJlcV9ub3RpZmllcl9jYWxsKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIsIHVuc2lnbmVkIGxvbmcgdHlwZSwKPj4+Pj4+Pj4gICAgICAJbXV0ZXhf
dW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsKPj4+Pj4+Pj4gICAgICAKPj4+Pj4+Pj4gICAgICAJcmV0
dXJuIHJldDsKPj4+Pj4+Pj4gICAgICB9Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICsvKioKPj4+
Pj4+Pj4gKyAqIHFvc19ub3RpZmllcl9jYWxsKCkgLSBDb21tb24gaGFuZGxlciBmb3IgUW9TIGNv
bnN0cmFpbnRzLgo+Pj4+Pj4+PiArICogQGRldmZyZXE6ICAgIHRoZSBkZXZmcmVxIGluc3RhbmNl
Lgo+Pj4+Pj4+PiArICovCj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHFvc19ub3RpZmllcl9jYWxsKHN0
cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+Pj4+Pj4+PiArewo+Pj4+Pj4+PiArCWludCBlcnI7Cj4+
Pj4+Pj4+ICsKPj4+Pj4+Pj4gKwltdXRleF9sb2NrKCZkZXZmcmVxLT5sb2NrKTsKPj4+Pj4+Pj4g
KwllcnIgPSB1cGRhdGVfZGV2ZnJlcShkZXZmcmVxKTsKPj4+Pj4+Pj4gKwltdXRleF91bmxvY2so
JmRldmZyZXEtPmxvY2spOwo+Pj4+Pj4+PiArCWlmIChlcnIpCj4+Pj4+Pj4+ICsJCWRldl9lcnIo
ZGV2ZnJlcS0+ZGV2LnBhcmVudCwKPj4+Pj4+Pj4gKwkJCQkiZmFpbGVkIHRvIHVwZGF0ZSBmcmVx
dWVuY3kgZm9yIFBNIFFvUyBjb25zdHJhaW50cyAoJWQpXG4iLAo+Pj4+Pj4+Cj4+Pj4+Pj4gSXMg
aXQgbm90IG92ZXIgODAgY2hhcj8KPj4+Pj4+Cj4+Pj4+PiBZZXMgYnV0IGNvZGluZyBzdHlsZSBl
eHBsaWNpdGx5IGZvcmJpZHMgYnJlYWtpbmcgc3RyaW5ncy4KPj4+Pj4+Cj4+Pj4+Pj4+ICsJCQkJ
ZXJyKTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArCXJldHVybiBOT1RJRllfT0s7Cj4+Pj4+Pj4+ICt9
Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gKy8qKgo+Pj4+Pj4+PiArICogcW9zX21pbl9ub3RpZmllcl9j
YWxsKCkgLSBDYWxsYmFjayBmb3IgUW9TIG1pbl9mcmVxIGNoYW5nZXMuCj4+Pj4+Pj4+ICsgKiBA
bmI6CQlTaG91bGQgYmUgZGV2ZnJlcS0+bmJfbWluCj4+Pj4+Pj4+ICsgKi8KPj4+Pj4+Pj4gK3N0
YXRpYyBpbnQgcW9zX21pbl9ub3RpZmllcl9jYWxsKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIs
Cj4+Pj4+Pj4+ICsJCQkJCSB1bnNpZ25lZCBsb25nIHZhbCwgdm9pZCAqcHRyKQo+Pj4+Pj4+PiAr
ewo+Pj4+Pj4+PiArCXJldHVybiBxb3Nfbm90aWZpZXJfY2FsbChjb250YWluZXJfb2YobmIsIHN0
cnVjdCBkZXZmcmVxLCBuYl9taW4pKTsKPj4+Pj4+Pj4gK30KPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiAr
LyoqCj4+Pj4+Pj4+ICsgKiBxb3NfbWF4X25vdGlmaWVyX2NhbGwoKSAtIENhbGxiYWNrIGZvciBR
b1MgbWF4X2ZyZXEgY2hhbmdlcy4KPj4+Pj4+Pj4gKyAqIEBuYjoJCVNob3VsZCBiZSBkZXZmcmVx
LT5uYl9tYXgKPj4+Pj4+Pj4gKyAqLwo+Pj4+Pj4+PiArc3RhdGljIGludCBxb3NfbWF4X25vdGlm
aWVyX2NhbGwoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwKPj4+Pj4+Pj4gKwkJCQkJIHVuc2ln
bmVkIGxvbmcgdmFsLCB2b2lkICpwdHIpCj4+Pj4+Pj4+ICt7Cj4+Pj4+Pj4+ICsJcmV0dXJuIHFv
c19ub3RpZmllcl9jYWxsKGNvbnRhaW5lcl9vZihuYiwgc3RydWN0IGRldmZyZXEsIG5iX21heCkp
Owo+Pj4+Pj4+PiArfQo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICAgICAgLyoqCj4+Pj4+Pj4+ICAgICAg
ICogZGV2ZnJlcV9kZXZfcmVsZWFzZSgpIC0gQ2FsbGJhY2sgZm9yIHN0cnVjdCBkZXZpY2UgdG8g
cmVsZWFzZSB0aGUgZGV2aWNlLgo+Pj4+Pj4+PiAgICAgICAqIEBkZXY6CXRoZSBkZXZmcmVxIGRl
dmljZQo+Pj4+Pj4+PiAgICAgICAqCj4+Pj4+Pj4+ICAgICAgICogUmVtb3ZlIGRldmZyZXEgZnJv
bSB0aGUgbGlzdCBhbmQgcmVsZWFzZSBpdHMgcmVzb3VyY2VzLgo+Pj4+Pj4+PiBAQCAtNjIwLDEw
ICs2NzEsMTUgQEAgc3RhdGljIHZvaWQgZGV2ZnJlcV9kZXZfcmVsZWFzZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpCj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAgICAgCW11dGV4X2xvY2soJmRldmZyZXFf
bGlzdF9sb2NrKTsKPj4+Pj4+Pj4gICAgICAJbGlzdF9kZWwoJmRldmZyZXEtPm5vZGUpOwo+Pj4+
Pj4+PiAgICAgIAltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4+Pj4+Pj4gICAg
ICAKPj4+Pj4+Pj4gKwlkZXZfcG1fcW9zX3JlbW92ZV9ub3RpZmllcihkZXZmcmVxLT5kZXYucGFy
ZW50LCAmZGV2ZnJlcS0+bmJfbWF4LAo+Pj4+Pj4+PiArCQkJREVWX1BNX1FPU19NQVhfRlJFUVVF
TkNZKTsKPj4+Pj4+Pj4gKwlkZXZfcG1fcW9zX3JlbW92ZV9ub3RpZmllcihkZXZmcmVxLT5kZXYu
cGFyZW50LCAmZGV2ZnJlcS0+bmJfbWluLAo+Pj4+Pj4+PiArCQkJREVWX1BNX1FPU19NSU5fRlJF
UVVFTkNZKTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+Cj4+Pj4+Pj4gSnVzdCBwcmludCBlcnJvciB3aXRo
IGRldl9lcnIoKSB3aXRob3V0IHN0b3BwaW5nIHRoZSByZWxlYXNlIHN0ZXAuCj4+Pj4+Pj4KPj4+
Pj4+PiBJIHByZWZlciB0byBoYW5kbGUgdGhlIHJldHVybiB2YWx1ZSBpZiBrZXJuZWwgQVBJIHBy
b3ZpZGVzCj4+Pj4+Pj4gdGhlIGVycm9yIGNvZGUuCj4+Pj4+Cj4+Pj4+IEhvdyBhYm91dD8KPj4+
Pgo+Pj4+IE1vZGlmaWVkIHRvIGRldl93YXJuLiBUaGlzIGFsc28gYXBwbGllcyB0byBQQVRDSCA2
IHNvIEkgcmVwbGllZCB0aGVyZS4KPj4+Pgo+Pj4+Pj4+PiAgICAgIAlpZiAoZGV2ZnJlcS0+cHJv
ZmlsZS0+ZXhpdCkKPj4+Pj4+Pj4gICAgICAJCWRldmZyZXEtPnByb2ZpbGUtPmV4aXQoZGV2ZnJl
cS0+ZGV2LnBhcmVudCk7Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAgICAgCWtmcmVlKGRldmZy
ZXEtPnRpbWVfaW5fc3RhdGUpOwo+Pj4+Pj4+PiAgICAgIAlrZnJlZShkZXZmcmVxLT50cmFuc190
YWJsZSk7Cj4+Pj4+Pj4+IEBAIC03MzMsMTAgKzc4OSwyOCBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2
ZnJlcV9hZGRfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+Pj4+Pj4gICAgICAJaWYgKGVy
cikgewo+Pj4+Pj4+PiAgICAgIAkJcHV0X2RldmljZSgmZGV2ZnJlcS0+ZGV2KTsKPj4+Pj4+Pj4g
ICAgICAJCWdvdG8gZXJyX291dDsKPj4+Pj4+Pj4gICAgICAJfQo+Pj4+Pj4+PiAgICAgIAo+Pj4+
Pj4+PiArCS8qCj4+Pj4+Pj4+ICsJICogUmVnaXN0ZXIgbm90aWZpZXJzIGZvciB1cGRhdGVzIHRv
IG1pbi9tYXhfZnJlcSBhZnRlciBkZXZpY2UgaXMKPj4+Pj4+Pj4gKwkgKiBpbml0aWFsaXplZCAo
YW5kIHdlIGNhbiBoYW5kbGUgbm90aWZpY2F0aW9ucykgYnV0IGJlZm9yZSB0aGUKPj4+Pj4+Pj4g
KwkgKiBnb3Zlcm5vciBpcyBzdGFydGVkICh3aGljaCBzaG91bGQgZG8gYW4gaW5pdGlhbCBlbmZv
cmNlbWVudCBvZgo+Pj4+Pj4+PiArCSAqIGNvbnN0cmFpbnRzKS4KPj4+Pj4+Pj4gKwkgKi8KPj4+
Pj4+Pgo+Pj4+Pj4+IE15IHByZXZpb3VzIGNvbW1lbnQgaXMgbm90IGVub3VnaCB3aHkgSSBwcmVm
ZXIgdG8gcmVtb3ZlIGl0LiBTb3JyeS4KPj4+Pj4+PiBBY3R1YWxseSwgdW50aWwgbm93LCB0aGUg
ZGV2ZnJlcV9hZGRfZGV2aWNlKCkgZG9uJ3QgaGF2ZSB0aGUgZGV0YWlsZWQKPj4+Pj4+PiBjb21t
ZW50cyBiZWNhdXNlIHRoZSBsaW5lIGNvZGUgaXMgbm90IHRvbyBsb25nLiBCdXQsIGF0IHRoZSBw
cmVzZW50IHRpbWUsCj4+Pj4+Pj4gZGV2ZnJlcV9hZGRfZGV2aWNlKCkgaXMgdG9vIGxvbmcuIEl0
IG1lYW5zIHRoYXQgdGhlIGRldGFpbGVkIGNvbW1lbnQKPj4+Pj4+PiBhcmUgbmVjZXNzYXJ5Lgo+
Pj4+Pj4+Cj4+Pj4+Pj4gU28sIEknbGwgYWRkIHRoZSBkZXRhaWxlZCBjb21tZW50IGZvciBlYWNo
IHN0ZXAgb2YgZGV2ZnJlcV9hZGRfZGV2aWNlKCkKPj4+Pj4+PiBvbiBzZXBhcmF0ZSBwYXRjaCB0
byBrZWVwIHRoZSBzYW1lIHN0eWxlLiBJJ2xsIHNlbmQgdGhlIHBhdGNoIHRvIHlvdQo+Pj4+Pj4+
IGZvciB0aGUgcmV2aWV3Lgo+Pj4+Pj4KPj4+Pj4+IFRoaXMgaXMgdmVyeSBsaWtlbHkgdG8gcmVz
dWx0IGluIG1lcmdlIGNvbmZsaWN0cywgbWF5YmUgd2FpdCBmb3IgbXkKPj4+Pj4+IHNlcmllcyB0
byBnbyBpbiBmaXJzdD8KPj4+Pj4KPj4+Pj4gSSdsbCBzZW5kIHRoZSBzZXBhcmF0ZSBwYXRjaCBh
ZnRlciBmaW5pc2hlZCB0aGUgcmV2aWV3IG9mIHRoZXNlIHBhdGNoZXMuCj4+Pj4+IFNvLCBpZiB5
b3UgYWdyZWUsIHBsZWFzZSByZW1vdmUgdGhpcyBjb21tZW50IG9uIHRoaXMgcGF0Y2guCj4+Pj4+
Cj4+Pj4+IFlvdSBjYW4gcmV2aWV3IHRoZSBkZXRhaWxlZCBjb21tZW50cyBvbiBzZXBhcmF0ZSBw
YXRjaCB3aGVuIEkgc2VuZC4KPj4+PiBUaGlzIHBhdGNoIGFscmVhZHkgY29udGFpbnMgY29tbWVu
dHMgYW5kIHRoZXkgZXhwbGFpbiB0aGUgY29kZSBiZWluZwo+Pj4+IGFkZGVkLiBEb2Vzbid0IGl0
IG1ha2UgbW9yZSBzZW5zZSBmb3IgY29tbWVudHMgYW5kIGNvZGUgdG8gZ28gaW4gdG9nZXRoZXI/
Cj4+Pj4KPj4+PiBJIHRoaW5rIHRoZSBjb21tZW50IGlzIGEgcmVzb25hYmxlIGV4cGxhbmF0aW9u
IGFzIHRvIHdoeSBub3RpZmllcnMgYXJlCj4+Pj4gcmVnaXN0ZXJlZCBhdCB0aGF0IHNwZWNpZmlj
IHN0ZXAgaW4gdGhlIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlLgo+Pj4KPj4+IElmIHlvdSBhZGQg
dGhpcyBjb21tZW50IG9uIHRoaXMgcGF0Y2gsIE9LLiBqdXN0IEkgaGF2ZSBzb21lIGNvbW1lbnRz
Lgo+Pj4KPj4+IAkvKgo+Pj4gCSAqIFJlZ2lzdGVyIG5vdGlmaWVycyBmb3IgdXBkYXRlcyB0byBt
aW4vbWF4X2ZyZXEgYWZ0ZXIgZGV2aWNlIGlzCj4+PiAJICogaW5pdGlhbGl6ZWQgKGFuZCB3ZSBj
YW4gaGFuZGxlIG5vdGlmaWNhdGlvbnMpIGJ1dCBiZWZvcmUgdGhlCj4+Pgo+Pj4gSSB0aGluayB0
aGF0ICdkZXZpY2UgaXMgaW5pdGlhbGl6ZWQnIGlzIG5vdCBuZWVkZWQuCj4+PiBJdCBpcyBhbHdh
eXMgdHJ1ZSwgaXQgZG9uJ3QgbmVlZCB0byBhZGQgdGhlIGFkZGl0aW9uYWwgY29tbWVudHMuCj4+
PiBiZWNhdXNlIGRldl9wbV9xb3NfYWRkX25vdGlmaWVyKCkgbXVzdCBuZWVkIHRoZSAnZGV2ZnJl
cS0+ZGV2Jy4KPj4+IFRoZSB0aGlzIGNvZGUgcHJvdmUgdGhlIGNhbGwgc2VxdWVuY2UgYmV0d2Vl
biB0aGVtLgo+Pgo+PiBJbiB0aGVvcnkgaWYgYSBub3RpZmllciBpcyByZWdpc3RlcmVkIHRvbyBz
b29uIHRoZW4gaXQgY291bGQgY3Jhc2ggb24gYQo+PiBOVUxMIHBvaW50ZXIuIEJ1dCBsb29raW5n
IGF0IHRoZSBjb2RlIGl0IGZpcnN0IGNoZWNrcyB0aGF0ICJnb3Zlcm5vciAhPQo+PiBOVUxMKSBz
byBpdCB3b3VsZCBiZSBoYXJtbGVzcy4KPj4KPj4+Cj4+PiBBYm91dCAndXMnLCBkb24ndCB1c2Ug
J3dlJy4gVGhlIHN1YmplY3QgaXMgJ2RldmZyZXEnIG9yIG90aGVyIGRldmljZSBpbnN0ZWFkIG9m
IHVzLgo+Pj4KPj4+IAkgKiBnb3Zlcm5vciBpcyBzdGFydGVkICh3aGljaCBzaG91bGQgZG8gYW4g
aW5pdGlhbCBlbmZvcmNlbWVudCBvZgo+Pj4gCSAqIGNvbnN0cmFpbnRzKS4KPj4+ICAgIAkgKi8K
Pj4+Cj4+PiBBY3R1YWxseSwgaXQgZG9lc24ndCBtYXR0ZXIgdGhlIGluaXRpYWxpemF0aW9uIHN0
ZXAgYmV0d2VlbiBnb3Zlcm5vcgo+Pj4gYW5kIFBNX1FPUyByZWdpc3RyYXRpb24uCj4+Cj4+IElu
IHRoZW9yeSBQTSBRb1MgY29uc3RyYWludHMgY291bGQgYmUgbW9kaWZpZWQgYmV0d2VlbiBnb3Zl
cm5vciBzdGFydHVwCj4+IGFuZCBub3RpZmllciByZWdpc3RyYXRpb24gYW5kIHRoYXQgdXBkYXRl
IHdvdWxkIGJlIGxvc3QgKHVudGlsIHRoZSBuZXh0Cj4+IG9uZSkuCj4gCj4gRG9uJ3QgbG9zZSB0
aGUgYW55IG9mIFBNIFFvUyByZXF1ZXN0LiBVc2VyIGNhbiByZXF1ZXN0IHRoZSBhbnkgZnJlcXVl
bmN5Cj4gdGhyb3VnaCBQTVFvUyBhdCB0aGUgYW55IHRpbWUgYW5kIHRoZW4gZGV2ZnJlcSBjb25z
aWRlciB0aGUgY29uc3RyYWludHMKPiBmcm9tIFBNIFFvUy4KPiAKPiBBbHNvLCBhZnRlciBmaW5p
c2hlZCB0aGUgcmVnaXN0cmF0aW9uIG9mIGRldmZyZXEgZGV2aWNlLAo+IHRoZSB1c2VyIChvdGhl
ciBkZXZpY2UgZHJpdmVyIHJlcXVpcmVkIHRoZSBtaW4vbWF4IGZyZXEpCj4gY2FuIHJlcXVlc3Qg
dGhlIFBNIFFvUyBvbiByZWFsIHVzZS1jYXNlLgo+IAo+IEl0IGlzIGltcG9zc2libGUgdG8gZ2V0
IHRoZSBkZXZmcmVxIGluc3RhbmNlIGJlZm9yZSBmaW5pc2hlZAo+IHRoZSBkZXZmcmVxX2FkZF9k
ZXZpY2UoKSBiZWNhdXNlIHRoZSB1c2VyIGNhbiBhY2Nlc3MgdGhlIGRldmZyZXEgaW5zdGFuY2UK
PiBkZXZmcmVxX2dldF9kZXZmcmVxX2J5X3BoYW5kbGUoKSB3aGljaCB1c2UgJ2RldmZyZXFfbGlz
dCcuCj4gCj4gSWYgZGV2ZnJlcV9hZGRfZGV2aWNlKCkgaXMgbm90IGZpbmlzaGVkLCB0aGUgdXNl
ciBjYW5ub3QgZ2V0Cj4gdGhlIGFueSBkZXZmcmVxIGRldmljZSBmcm9tICdkZXZmcmVxX2xpc3Qn
LgoKUE0gUW9TIGNvbnN0cmFpbnRzIGFyZSBub3Qgb24gZGV2ZnJlcS0+ZGV2IGJ1dCBvbiB0aGUg
cGFyZW50IHNvIGluIAp0aGVvcnkgaXQncyBwb3NzaWJsZSB0byBhZGQgY29uc3RyYWludHMgZHVy
aW5nIGRldmZyZXEgaW5pdGlhbGl6YXRpb24uCgpNYWtpbmcgUE0gUW9TIHJlcXVlc3RzIGRvZXNu
J3QgcmVxdWlyZSBmZXRjaGluZyBkZXZmcmVxIGluc3RhbmNlcywgSSAKdGhpbmsgeW91IGNvdWxk
IGNhbGwgb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSB3aXRoIGEgcGhhbmRsZSBhbmQgcmVnaXN0ZXIg
CmNvbnN0cmFpbnRzIHRoYXQgd2F5LgoKPj4+IElmIHN0YXJ0IGdvdmVybm9yIGFuZCB0aGVuIHJl
Z2lzdGVyIFBNX1FPUywKPj4+IHRoZSBnb3Zlcm5vciBjYW4gZGVjaWRlIHRoZSBuZXcgZnJlcXVl
bmN5LiBBbmQgdGhlbiBQTV9RT1MgcmVxdWVzdAo+Pj4gdGhlIG5ldyBjb25zdHJhaW50cyBmb3Ig
bWluL21heCBmcmVxdWVuY3kuIE9uIHJlcXVlc3QgdGltZSBvZiBQTV9RT1MsCj4+PiBkZXZmcmVx
IGNhbiBkZXRlY3QgdGhpcyB0aW1lIGFuZCB0aGVuIGFwcGx5IHRoZSBjb25zdHJhaW50cyBmcm9t
IFBNX1FPUy4KPj4+IFRoZSB1c2VyIG9mIGRldmZyZXEncyBQTV9RT1MgbXVzdCBuZWVkIHRoZSBw
aGFuZGxlIG9yIGRldmljZSBpbnN0YW5jZQo+Pj4gb2YgZGV2ZnJlcSBkZWl2Y2UuIEl0IG1lYW5z
IHRoYXQgdXNlciBvZiBkZXZmcmVxJ3MgUE1fUU9TIGNhbiByZXF1ZXN0Cj4+PiB0aGUgYW55IGNv
bnN0cmFpbnRzIG9mIFBNX1FPU19NSU4vTUFYIHRocm91Z2ggUE1fUU9TIGludGVyZmFjZS4KPj4+
Cj4+PiBTbywgaXQgZG9lc24ndCBuZWVkIHRvIGFkZCB0aGUgZm9sbG93aW5nIGNvbW1lbnRzCj4+
PiBiZWNhdXNlIGZvbGxvd2luZyBjb21tZW50IGlzIG5vdCBhbHdheXMgbWFuZGF0b3J5Lgo+Pj4g
IiBnb3Zlcm5vciBpcyBzdGFydGVkICh3aGljaCBzaG91bGQgZG8gYW4gaW5pdGlhbCBlbmZvcmNl
bWVudCBvZiBjb25zdHJhaW50cykuIgo+Pj4KPj4+IEFsc28sIHlvdSBkb24ndCBuZWVkIHRvIHVz
ZSBwYXJlbnRoZXNlcyBvbiBjb21tZW50cy4KPj4+Cj4+PiBBY3R1YWxseSwgSSB0aGluayB0aGF0
IGZvbGxvd2luZyBjb21tZW50cyBhcmUgZW5vdWdoLgo+Pj4KPj4+IAkvKiBSZWdpc3RlciBQTSBR
b1Mgbm90aWZpZXJzIGZvciB1cGRhdGluZyB0byBtaW4vbWF4IGZyZXEgKi8KPj4KPj4gSSB0aG91
Z2h0IHRoYXQgZXhwbGFuaW5nIHdoeSBpdCdzIGRvbmUgYXQgdGhpcyBwYXJ0aWN1bGFyIHN0ZXAg
YnV0IEknbGwKPj4ganVzdCByZW1vdmUgaXQsIGRldmZyZXFfYWRkX2RldmljZSBjYW4gZ2V0IG1v
cmUgY29tbWVudHMgbGF0ZXIuCj4gCj4gT0suIFRoYW5rcy4KPiBJIHRoaW5rIHRoYXQgaWYgdGhl
IGNvbW1lbnQgY29udGFpbnMgd2hhdCBpcyBtZWFuaW5nIG9mIHRoZSBjb2RlLAo+IGl0IGlzIGVu
b3VnaC4KPiAKPiBBbHRob3VnaCBjaGFuZ2UgdGhlIHNlcXVlbmNlIGJldHdlZW4gZGV2X3BtX3Fv
c19hZGRfbm90aWZpZXIoKSBhbmQKPiB0cnlfdGhlbl9yZXF1ZXN0X2dvdmVybm9yKCksIGluIHRo
ZSByZWFsLWNhc2UsIHRoZSBhbnkgaXNzdWUKPiB3b3VsZCBub3QgaGFwcGVuLiBCZWNhdXNlIGFz
IEkgY29tbWVudGVkIGFib3ZlLCB0aGUgb3RoZXIgZGV2aWNlLWRyaXZlcgo+IGNhbm5vdCBnZXQg
dGhlIGRldmZyZXEgaW5zdGFuY2UgYmVmb3JlIGZpbmlzaGVkIHRoZSBkZXZmcmVxX2FkZF9kZXZp
Y2UuCj4gSXQgbWVhbnMgdGhhdCB0aGUgdXNlciBkZXZpY2UgZHJpdmVyIGNhbm5vdCByZXF1ZXN0
IHRoZSBhbnkgUE0gUW9TCj4gY29uc3RyYWludHMuCj4gCj4+Cj4+Pj4+Pj4+ICsJZGV2ZnJlcS0+
bmJfbWluLm5vdGlmaWVyX2NhbGwgPSBxb3NfbWluX25vdGlmaWVyX2NhbGw7Cj4+Pj4+Pj4+ICsJ
ZXJyID0gZGV2X3BtX3Fvc19hZGRfbm90aWZpZXIoZGV2ZnJlcS0+ZGV2LnBhcmVudCwgJmRldmZy
ZXEtPm5iX21pbiwKPj4+Pj4+Pj4gKwkJCQkgICAgICBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1kp
Owo+Pj4+Pj4+PiArCWlmIChlcnIpCj4+Pj4+Pj4+ICsJCWdvdG8gZXJyX2RldmZyZXE7Cj4+Pj4+
Pj4+ICsKPj4+Pj4+Pj4gKwlkZXZmcmVxLT5uYl9tYXgubm90aWZpZXJfY2FsbCA9IHFvc19tYXhf
bm90aWZpZXJfY2FsbDsKPj4+Pj4+Pj4gKwllcnIgPSBkZXZfcG1fcW9zX2FkZF9ub3RpZmllcihk
ZXZmcmVxLT5kZXYucGFyZW50LCAmZGV2ZnJlcS0+bmJfbWF4LAo+Pj4+Pj4+PiArCQkJCSAgICAg
IERFVl9QTV9RT1NfTUFYX0ZSRVFVRU5DWSk7Cj4+Pj4+Pj4+ICsJaWYgKGVycikKPj4+Pj4+Pj4g
KwkJZ290byBlcnJfZGV2ZnJlcTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiAgICAgIAltdXRleF9sb2Nr
KCZkZXZmcmVxX2xpc3RfbG9jayk7Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAgICAgCWdvdmVy
bm9yID0gdHJ5X3RoZW5fcmVxdWVzdF9nb3Zlcm5vcihkZXZmcmVxLT5nb3Zlcm5vcl9uYW1lKTsK
Pj4+Pj4+Pj4gICAgICAJaWYgKElTX0VSUihnb3Zlcm5vcikpIHsKPj4+Pj4+Pj4gICAgICAJCWRl
dl9lcnIoZGV2LCAiJXM6IFVuYWJsZSB0byBmaW5kIGdvdmVybm9yIGZvciB0aGUgZGV2aWNlXG4i
LAo+Pj4+Pj4+PiBAQCAtNzYwLDEwICs4MzQsMTEgQEAgc3RydWN0IGRldmZyZXEgKmRldmZyZXFf
YWRkX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAg
ICAgCXJldHVybiBkZXZmcmVxOwo+Pj4+Pj4+PiAgICAgIAo+Pj4+Pj4+PiAgICAgIGVycl9pbml0
Ogo+Pj4+Pj4+PiAgICAgIAltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4+Pj4+
Pj4gK2Vycl9kZXZmcmVxOgo+Pj4+Pj4+PiAgICAgIAlkZXZmcmVxX3JlbW92ZV9kZXZpY2UoZGV2
ZnJlcSk7Cj4+Pj4+Pj4+ICAgICAgCXJldHVybiBFUlJfUFRSKGVycik7Cj4+Pj4+Pj4+ICAgICAg
Cj4+Pj4+Pj4+ICAgICAgZXJyX2RldjoKPj4+Pj4+Pj4gICAgICAJLyoKPj4+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oIGIvaW5jbHVkZS9saW51eC9kZXZmcmVxLmgK
Pj4+Pj4+Pj4gaW5kZXggYzNjYmMxNWZkZjA4Li5kYWMwZGZmZWFiYjQgMTAwNjQ0Cj4+Pj4+Pj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvZGV2ZnJlcS5oCj4+Pj4+Pj4+IEBAIC0xMzQsMTAgKzEzNCwxMiBAQCBzdHJ1Y3QgZGV2ZnJl
cV9kZXZfcHJvZmlsZSB7Cj4+Pj4+Pj4+ICAgICAgICogQHRvdGFsX3RyYW5zOglOdW1iZXIgb2Yg
ZGV2ZnJlcSB0cmFuc2l0aW9ucwo+Pj4+Pj4+PiAgICAgICAqIEB0cmFuc190YWJsZToJU3RhdGlz
dGljcyBvZiBkZXZmcmVxIHRyYW5zaXRpb25zCj4+Pj4+Pj4+ICAgICAgICogQHRpbWVfaW5fc3Rh
dGU6CVN0YXRpc3RpY3Mgb2YgZGV2ZnJlcSBzdGF0ZXMKPj4+Pj4+Pj4gICAgICAgKiBAbGFzdF9z
dGF0X3VwZGF0ZWQ6CVRoZSBsYXN0IHRpbWUgc3RhdCB1cGRhdGVkCj4+Pj4+Pj4+ICAgICAgICog
QHRyYW5zaXRpb25fbm90aWZpZXJfbGlzdDogbGlzdCBoZWFkIG9mIERFVkZSRVFfVFJBTlNJVElP
Tl9OT1RJRklFUiBub3RpZmllcgo+Pj4+Pj4+PiArICogQG5iX21pbjoJCU5vdGlmaWVyIGJsb2Nr
IGZvciBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1kKPj4+Pj4+Pj4gKyAqIEBuYl9tYXg6CQlOb3Rp
ZmllciBibG9jayBmb3IgREVWX1BNX1FPU19NQVhfRlJFUVVFTkNZCj4+Pj4+Pj4+ICAgICAgICoK
Pj4+Pj4+Pj4gICAgICAgKiBUaGlzIHN0cnVjdHVyZSBzdG9yZXMgdGhlIGRldmZyZXEgaW5mb3Jt
YXRpb24gZm9yIGEgZ2l2ZSBkZXZpY2UuCj4+Pj4+Pj4+ICAgICAgICoKPj4+Pj4+Pj4gICAgICAg
KiBOb3RlIHRoYXQgd2hlbiBhIGdvdmVybm9yIGFjY2Vzc2VzIGVudHJpZXMgaW4gc3RydWN0IGRl
dmZyZXEgaW4gaXRzCj4+Pj4+Pj4+ICAgICAgICogZnVuY3Rpb25zIGV4Y2VwdCBmb3IgdGhlIGNv
bnRleHQgb2YgY2FsbGJhY2tzIGRlZmluZWQgaW4gc3RydWN0Cj4+Pj4+Pj4+IEBAIC0xNzYsMTAg
KzE3OCwxMyBAQCBzdHJ1Y3QgZGV2ZnJlcSB7Cj4+Pj4+Pj4+ICAgICAgCXVuc2lnbmVkIGludCAq
dHJhbnNfdGFibGU7Cj4+Pj4+Pj4+ICAgICAgCXVuc2lnbmVkIGxvbmcgKnRpbWVfaW5fc3RhdGU7
Cj4+Pj4+Pj4+ICAgICAgCXVuc2lnbmVkIGxvbmcgbGFzdF9zdGF0X3VwZGF0ZWQ7Cj4+Pj4+Pj4+
ICAgICAgCj4+Pj4+Pj4+ICAgICAgCXN0cnVjdCBzcmN1X25vdGlmaWVyX2hlYWQgdHJhbnNpdGlv
bl9ub3RpZmllcl9saXN0Owo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICsJc3RydWN0IG5vdGlmaWVyX2Js
b2NrIG5iX21pbjsKPj4+Pj4+Pj4gKwlzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgbmJfbWF4Owo+Pj4+
Pj4+PiAgICAgIH07Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAgICAgc3RydWN0IGRldmZyZXFf
ZnJlcXMgewo+Pj4+Pj4+PiAgICAgIAl1bnNpZ25lZCBsb25nIG9sZDsKPj4+Pj4+Pj4gICAgICAJ
dW5zaWduZWQgbG9uZyBuZXc7Cj4+Pgo+Pj4KPj4KPiAKPiAKCg==

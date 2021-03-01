Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B661D32760B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 03:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhCACRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Feb 2021 21:17:44 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:21566 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231730AbhCACRl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Feb 2021 21:17:41 -0500
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id 1212GjpF002954;
        Mon, 1 Mar 2021 10:16:45 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id 1212Gf8n020388;
        Mon, 1 Mar 2021 10:16:41 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn (172.23.18.10) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 1 Mar 2021
 10:16:26 +0800
Received: from cncheex01.Hygon.cn ([172.23.18.10]) by cncheex01.Hygon.cn
 ([172.23.18.10]) with mapi id 15.01.1466.003; Mon, 1 Mar 2021 10:16:26 +0800
From:   Wen Pu <puwen@hygon.cn>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "victording@google.com" <victording@google.com>,
        "kim.phillips@amd.com" <kim.phillips@amd.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: Re: [RFC PATCH] powercap: Add Hygon Fam18h RAPL support
Thread-Topic: [RFC PATCH] powercap: Add Hygon Fam18h RAPL support
Thread-Index: AQHXC3ZtcHkxrsdXYk+yZ96EVY24VKptM5qAgACxH4A=
Date:   Mon, 1 Mar 2021 02:16:26 +0000
Message-ID: <6543a335-e84c-29ea-e20b-c56bdd60d1c6@hygon.cn>
References: <20210225130129.21512-1-puwen@hygon.cn>
 <0a8f11cfbc761767b7a994f724af3dac124184c9.camel@linux.intel.com>
In-Reply-To: <0a8f11cfbc761767b7a994f724af3dac124184c9.camel@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.18.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEBAD4DD581A50478C89BF8CEE857CF8@Hygon.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: spam2.hygon.cn 1212GjpF002954
X-DNSRBL: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjAyMS8yLzI4IDIzOjQyLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3RlOg0KPiBPbiBUaHUs
IDIwMjEtMDItMjUgYXQgMjE6MDEgKzA4MDAsIFB1IFdlbiB3cm90ZToNCj4+IEVuYWJsZSBIeWdv
biBGYW0xOGggUkFQTCBzdXBwb3J0IGZvciB0aGUgcG93ZXIgY2FwcGluZyBmcmFtZXdvcmsuDQo+
Pg0KPiBJZiB0aGlzIHBhdGNoIGlzIHRlc3RlZCBhbmQgd29ya3Mgb24gdGhpcyBwcm9jZXNzb3Is
IG5vdCBzdXJlIHdoeSB0aGlzDQo+IGlzIFJGQz8NCg0KVGhpcyBwYXRjaCBpcyB0ZXN0ZWQgYW5k
IHdvcmtzIG9uIEh5Z29uIHByb2Nlc3Nvci4gVGhlICdSRkMnIGlzIGF1dG9tYXRlZA0KZ2VuZXJh
dGVkIGJ5IG15IHNjcmlwdCA7KQ0KDQpUaGFua3MsDQpQdSBXZW4NCg0KPiBUaGFua3MsDQo+IFNy
aW5pdmFzDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogUHUgV2VuIDxwdXdlbkBoeWdvbi5jbj4NCj4+
IC0tLQ0KPj4gIGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDEgKw0KPj4g
IGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9tc3IuYyAgICB8IDEgKw0KPj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93
ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPj4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3Jh
cGxfY29tbW9uLmMNCj4+IGluZGV4IGZkZGEyYTczNzE4Ni4uNzNjZjY4YWY5NzcwIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+PiArKysgYi9k
cml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4+IEBAIC0xMDY5LDYgKzEwNjks
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgcmFwbF9pZHNbXQ0KPj4gX19pbml0
Y29uc3QgPSB7DQo+PiAgDQo+PiAgCVg4Nl9NQVRDSF9WRU5ET1JfRkFNKEFNRCwgMHgxNywgJnJh
cGxfZGVmYXVsdHNfYW1kKSwNCj4+ICAJWDg2X01BVENIX1ZFTkRPUl9GQU0oQU1ELCAweDE5LCAm
cmFwbF9kZWZhdWx0c19hbWQpLA0KPj4gKwlYODZfTUFUQ0hfVkVORE9SX0ZBTShIWUdPTiwgMHgx
OCwgJnJhcGxfZGVmYXVsdHNfYW1kKSwNCj4+ICAJe30NCj4+ICB9Ow0KPj4gIE1PRFVMRV9ERVZJ
Q0VfVEFCTEUoeDg2Y3B1LCByYXBsX2lkcyk7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dl
cmNhcC9pbnRlbF9yYXBsX21zci5jDQo+PiBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9t
c3IuYw0KPj4gaW5kZXggNzgyMTNkNGI1YjE2Li5jYzNiMjI4ODFiZmUgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfbXNyLmMNCj4+ICsrKyBiL2RyaXZlcnMvcG93
ZXJjYXAvaW50ZWxfcmFwbF9tc3IuYw0KPj4gQEAgLTE1MCw2ICsxNTAsNyBAQCBzdGF0aWMgaW50
IHJhcGxfbXNyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4+ICpwZGV2KQ0KPj4gIAlj
YXNlIFg4Nl9WRU5ET1JfSU5URUw6DQo+PiAgCQlyYXBsX21zcl9wcml2ID0gJnJhcGxfbXNyX3By
aXZfaW50ZWw7DQo+PiAgCQlicmVhazsNCj4+ICsJY2FzZSBYODZfVkVORE9SX0hZR09OOg0KPj4g
IAljYXNlIFg4Nl9WRU5ET1JfQU1EOg0KPj4gIAkJcmFwbF9tc3JfcHJpdiA9ICZyYXBsX21zcl9w
cml2X2FtZDsNCj4+ICAJCWJyZWFrOw0KPg==

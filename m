Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F1232A29B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376840AbhCBINZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:13:25 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:51578 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S241409AbhCBCGn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Mar 2021 21:06:43 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id 122259uY080528;
        Tue, 2 Mar 2021 10:05:09 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id 122258QG080640;
        Tue, 2 Mar 2021 10:05:08 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn (172.23.18.10) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 2 Mar 2021
 10:04:53 +0800
Received: from cncheex01.Hygon.cn ([172.23.18.10]) by cncheex01.Hygon.cn
 ([172.23.18.10]) with mapi id 15.01.1466.003; Tue, 2 Mar 2021 10:04:53 +0800
From:   Wen Pu <puwen@hygon.cn>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "victording@google.com" <victording@google.com>,
        "kim.phillips@amd.com" <kim.phillips@amd.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: Re: [RFC PATCH] powercap: Add Hygon Fam18h RAPL support
Thread-Topic: [RFC PATCH] powercap: Add Hygon Fam18h RAPL support
Thread-Index: AQHXC3ZtcHkxrsdXYk+yZ96EVY24VKptM5qAgACxH4CAAMpAAIAAxNsA
Date:   Tue, 2 Mar 2021 02:04:53 +0000
Message-ID: <0994b1d7-3439-b513-7a87-c1463e04d311@hygon.cn>
References: <20210225130129.21512-1-puwen@hygon.cn>
 <0a8f11cfbc761767b7a994f724af3dac124184c9.camel@linux.intel.com>
 <6543a335-e84c-29ea-e20b-c56bdd60d1c6@hygon.cn>
 <CAJZ5v0jyHywkUhF87sNHXMtG=QBmO23LwAFW0aHQMJsFSr1y+g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jyHywkUhF87sNHXMtG=QBmO23LwAFW0aHQMJsFSr1y+g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.18.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <73347C359B143A4F84310334CBA43A37@Hygon.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: spam2.hygon.cn 122259uY080528
X-DNSRBL: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjAyMS8zLzEgMjI6MjAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBNb24sIE1h
ciAxLCAyMDIxIGF0IDM6MTggQU0gV2VuIFB1IDxwdXdlbkBoeWdvbi5jbj4gd3JvdGU6DQo+Pg0K
Pj4gT24gMjAyMS8yLzI4IDIzOjQyLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3RlOg0KPj4+IE9u
IFRodSwgMjAyMS0wMi0yNSBhdCAyMTowMSArMDgwMCwgUHUgV2VuIHdyb3RlOg0KPj4+PiBFbmFi
bGUgSHlnb24gRmFtMThoIFJBUEwgc3VwcG9ydCBmb3IgdGhlIHBvd2VyIGNhcHBpbmcgZnJhbWV3
b3JrLg0KPj4+Pg0KPj4+IElmIHRoaXMgcGF0Y2ggaXMgdGVzdGVkIGFuZCB3b3JrcyBvbiB0aGlz
IHByb2Nlc3Nvciwgbm90IHN1cmUgd2h5IHRoaXMNCj4+PiBpcyBSRkM/DQo+Pg0KPj4gVGhpcyBw
YXRjaCBpcyB0ZXN0ZWQgYW5kIHdvcmtzIG9uIEh5Z29uIHByb2Nlc3Nvci4gVGhlICdSRkMnIGlz
IGF1dG9tYXRlZA0KPj4gZ2VuZXJhdGVkIGJ5IG15IHNjcmlwdCA7KQ0KPiANCj4gV2VsbCwgY2Fy
ZSB0byByZXNlbmQgYXMgbm9uLVJGQywgdGhlbj8NCg0KT0ssIGFscmVhZHkgcmVzZW5kLiBUaGFu
a3MhDQoNCi0tIA0KUmVnYXJkcywNClB1IFdlbg==

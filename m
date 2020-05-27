Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C41E3F3E
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgE0KjQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 06:39:16 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:58142 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgE0KjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 06:39:15 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 418D167A7C7;
        Wed, 27 May 2020 12:39:13 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 27 May
 2020 12:39:12 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Wed, 27 May 2020 12:39:12 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: High interrupt latency with low power idle mode on i.MX6
Thread-Topic: High interrupt latency with low power idle mode on i.MX6
Thread-Index: AQHWNBMPiENrGmpy5EqtWjfM5SmInw==
Date:   Wed, 27 May 2020 10:39:12 +0000
Message-ID: <bc91129c-121c-a070-53b2-1f0bb6d4500a@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <74610AFAFACFA04C9CA7028EA7CC1B36@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 418D167A7C7.AEE78
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: daniel.lezcano@linaro.org, info@metux.net,
        kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tglx@linutronix.de
X-Spam-Status: No
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCm9uIG91ciBpLk1YNlVML1VMTCBib2FyZHMgcnVubmluZyBtYWlubGluZSBrZXJuZWxz
LCB3ZSBzZWUgYW4gaXNzdWUgd2l0aCANClJTNDg1IGNvbGxpc2lvbnMgb24gdGhlIGJ1cy4gVGhl
c2UgYXJlIGNhdXNlZCBieSB0aGUgcmVzZXR0aW5nIG9mIHRoZSANClJUUyBzaWduYWwgYmVpbmcg
ZGVsYXllZCBhZnRlciBlYWNoIHRyYW5zbWlzc2lvbi4gVGhlIFRYREMgaW50ZXJydXB0IA0KdGFr
ZXMgc2V2ZXJhbCBtaWxsaXNlY29uZHMgdG8gdHJpZ2dlciBhbmQgdGhlIHNsYXZlIG9uIHRoZSBi
dXMgYWxyZWFkeSANCnN0YXJ0cyB0byBzZW5kIGEgcmVwbHkgaW4gdGhlIG1lYW50aW1lLg0KDQpX
ZSBmb3VuZCBvdXQgdGhhdCB0aGVzZSBkZWxheXMgb25seSBoYXBwZW4gd2hlbiB0aGUgQ1BVIGlz
IGluICJsb3cgcG93ZXIgDQppZGxlIiBtb2RlIChBUk0gcG93ZXIgb2ZmKS4gV2hlbiB3ZSBkaXNh
YmxlIGNwdWlkbGUgc3RhdGUgMiBvciBwdXQgc29tZSANCmJhY2tncm91bmQgbG9hZCBvbiB0aGUg
Q1BVIGV2ZXJ5dGhpbmcgd29ya3MgZmluZSBhbmQgdGhlIGRlbGF5cyBhcmUgZ29uZS4NCg0KZWNo
byAxID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVpZGxlL3N0YXRlMi9kaXNhYmxl
DQoNCkl0IHNlZW1zIGxpa2UgYWxzbyBvdGhlciBpbnRlcmZhY2VzIChJMkMsIGV0Yy4pIG1pZ2h0
IGJlIGFmZmVjdGVkIGJ5IA0KdGhlc2UgaW5jcmVhc2VkIGxhdGVuY2llcywgd2UgaGF2ZW4ndCBp
bnZlc3RpZ2F0ZWQgdGhpcyBtb3JlIGNsb3NlbHksIA0KdGhvdWdoLg0KDQpXZSBjdXJyZW50bHkg
YXBwbHkgYSBwYXRjaCB0byBvdXIga2VybmVsLCB0aGF0IGRpc2FibGVzIGxvdyBwb3dlciBpZGxl
IA0KbW9kZSBieSBkZWZhdWx0LCBidXQgSSdtIHdvbmRlcmluZyBpZiB0aGVyZSdzIGEgd2F5IHRv
IGZpeCB0aGlzIA0KcHJvcGVybHk/IEFueSBpZGVhcz8NCg0KVGhhbmtzLA0KRnJpZWRlcg==

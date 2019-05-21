Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74C024D72
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEULCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 07:02:02 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:51106 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEULCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 07:02:02 -0400
X-AuditID: c0a8fbf4-519ff700000014c1-ea-5ce3daa70e1e
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 28.9E.05313.7AAD3EC5; Tue, 21 May 2019 13:01:59 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Tue, 21 May 2019 13:01:54 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 0/8] support ROHM BD70528 PMIC
Thread-Topic: [PATCH v14 0/8] support ROHM BD70528 PMIC
Thread-Index: AQHVAMcZ2S9oIqrnW0ecnOWL7FvEJaZ1ZiIA
Date:   Tue, 21 May 2019 11:01:53 +0000
Message-ID: <3a78cc77499d5027f527be51a7c40f6c5d70338c.camel@fi.rohmeurope.com>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <431A5F4502DF11498E73A4ADCF92A350@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOuff23lvgboeCcsTHtAkzkiiyEDkGY3Qb2dX4SkzMRkjqVa5c
        sj7YbWuoJqZmMyrMhWSYzYqABvBVN+iimwUUmmIQVEKGtSiotQ2I8RlUomK3e1sU/jnnO7/v
        fN/3O8nvsKTuNZ3OlphtomwWjHo6gWo/9c6z+OTtcOHSwDjG9X03Gbz/aSODXx7rpvDhUITG
        tf4bGnzvVSfAr/sPELhq4iSBX/x8V4P/qp0A+F9vNY3HDvkBvnK2n8bBPy4xOHL8GoEbbvUR
        uLqhi8J93fl4X5ufwdFAM4V7Wmw4PBolV83k3TVuwD8L7mP4Gvdu/qJriOE9Zw7S/GCgleZP
        u90a/uK4k+F/q3lD8GOeeZsSChJXbBNsOzeXFJuzVm5NlEarA3SpX1M23Plc4wRNmnKgZRHM
        QQ17WxScwOpgAKCR0NDkoQuga9VHmXLAsjRcgcoHYjAVLkfNfcmqloS9WlTb+KmKU+Ay1Om9
        TKk4Feai812DZBx/gSp/amJUTMEMdNdZGbvDwQ3oeNUgULEOfo1GLjhj9lqYj5rqYq0BOBcd
        dD4l4lFpyDM8PtkyRPWtvWQcz0Cj4ehkXY/a3oQo1YaEi9Cf3qy4dBWaOHV10mYBqqoIMfEO
        ktHVIxGqEsx0TUtwTald09SuaWrXNHUd0JwByCSUGIsFm5i9RBbtS2SLZFK27RaTB8Rn5uU/
        4D/fGh+ALNAncVFfuFCnEXZaHSYfmMUS+hncoSyl9Mk2S5FDEqySQbYbRasPIJbUp3I93Q8K
        dVyR4NglypYP1GyW0qdx77wdhTqoJn8viqWi/IGdw7J6xJUOKKbJslgslu0oMdqmaILVquYJ
        6alW0VwkyoLdJhnUUTFYlVlRqSQld2NQkXPWUsGkVOPSbpDNtp8IHSPZJx0jylo38LaG1FFm
        i1lMT+NWqnlQFUh288e4RyBNeXUKt1hlk5TP9NHtkRJEKEFzmViQTZii0p3gx105Be3mzzPs
        kSZ/8PCzxN9zf2hd+/B579Bq03BOSsTw9qvArS/n9OfJxr+9dWDPXu+6aNl364ce99dGzha3
        NebeyV6zNm+sucVm6DgibeIrte+jT77dcv/90usVwfz5mXnLTOduN4YLPlvO8q7MigwHAo6F
        wYauJKNU/8uv33T26CmrJGRnkrJV+B/6QzoeCQQAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gQWxsLA0KDQpPbiBUaHUsIDIwMTktMDUtMDIgYXQgMTI6MTEgKzAzMDAsIE1hdHRpIFZh
aXR0aW5lbiB3cm90ZToNCj4gUGF0Y2ggc2VyaWVzIGludHJvZHVjaW5nIHN1cHBvcnQgZm9yIFJP
SE0gQkQ3MDUyOCBQTUlDDQo+IA0KSnVzdCB0aG91Z2h0IEknZCBhc2sgaWYgdGhlcmUncyBhbnkg
Y2hhbmNlcyB0byBnZXQgdGhpcyBzZXJpZXMgaW4gNS4yPw0KSXQgc2VlbXMgdG8gbWUgdGhlIFdE
VCBwYXJ0IChwYXRjaCA4KSB3YXMgYWxyZWFkeSBtZXJnZWQgaW4gYnV0IHJlc3Qgb2YNCnRoZSBw
YXRjaGVzIHNlZW0gdG8gYmUgaW4gbGltYm8gc29tZXdoZXJlIDopDQoNCkkgZ3Vlc3MgbW9zdCBv
ZiB0aGUgcGF0Y2hlcyBoYXZlIHJlbGV2YW50IGFja3MgLSBzbyB3b25kZXIgaWYgdGhlIHJlc3QN
CmNhbiBnbyB0aHJvdWdoIExlZSdzIHRyZWU/IEkgYWRtaXQgSSBhbSBnZXR0aW5nIHNsaWdodGx5
IGltcGF0aWVudCAtDQpzb3JyeSBmb3IgdGhhdCA6XQ0KDQpCciwNCglNYXR0aSBWYWl0dGluZW4N
Cg==

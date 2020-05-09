Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29BE1CC256
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEIPSC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 11:18:02 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:44312 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgEIPSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 11:18:02 -0400
X-AuditID: c0a8fbf4-489ff70000004419-60-5eb6c9a8907b
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 58.B5.17433.8A9C6BE5; Sat,  9 May 2020 17:18:00 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Sat, 9 May 2020 17:17:59 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v12 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Thread-Topic: [PATCH v12 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Thread-Index: AQHWJU8mRcNXc963mUOdUoB6SvCrNaieTQ+AgAFw1gA=
Date:   Sat, 9 May 2020 15:17:59 +0000
Message-ID: <e03d5edd79103a047f579059223d2b0cc5ec00b9.camel@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
         <311fea741bafdcd33804d3187c1642e24275e3e5.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
         <20200508171751.GM4820@sirena.org.uk>
In-Reply-To: <20200508171751.GM4820@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF806614F32C1A4187941D13BD1C3CAE@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0gUURjHOzvj7vEydRw1j2sGLkE3vFI5iJa+GaQUYQ9Z2qija7kzMjtb
        6kOYS6JGpKgPbmuZuikbGC25mhqlGaZtpRhdhAJRCn3oIUvDsppxvD2d/zn/7/f9PzgfJOhl
        Lz0s4CVO5NlCg9aHfNrx2xXRMeLOjP7xi2LGP9QRTMPUjJZZeFupYSZ67Vpm/voQYOyOFyTz
        sk9K0qU8sn3SpTS7LCkuZ5U2Zd618zh52jchm5UunizI56MOn/M1PhmdJYrcuuLK8nJNGbDr
        qoE3xOgAnve0E9XAB9LoHcADf77q1MswwM6+JdmBUIsScPXHFSAQReCGpVatUkOgpxps7XJo
        FSMAZeD6Z2NALTqD7zVcWdXxuHFyklQ0iXbhJvvYSj2F0vCN9p+EomnkAdj6WFK0N4rF9sVW
        L0UDFIaryr5pFE2gYOz6suilTo1wW/8bQtVBeHb67+p7OO5e7CSVmQm0F9/vjVLRJOzpXiBV
        HY7rr03p1BH88UjjDFkDtts2Jdg2aNsm2raJtm2im4GXE2ATW1CYz0pcTKTIWSJFwWiSjxzB
        5ALqd/7oAf8Gjw4CDQSDIARqDEFUfIU7k96aLeSWGFmzMUu0FHLmQYAhYQikaosfZtJULltS
        yonCmhUKSUMwtXuq9iyNlKwLHFfEiWvuDggNmJp4ITf1F7l8rjivoFDasDXQW2nuow80c3wu
        J7IWyZil7EeWWV4QxfKTc28PyzhlLmJN8quKjoL9sGa2qYWAQ02OFoImeYHn9MFUspKElFKj
        hV8PmgPBEBgCKF5x/eSdXu8zJ0do5Ij57y4lQmI3LH0Z8E5GsfwdrqeUjRMSfW2E3ePZe3Xx
        YtjNhTKT/fwr4WBOeb408LWltyvJL/V175FSZ7n1ecet1kNxA3Ri7CWC1lekxex0bel3Xk4N
        sQJ3zrZj6ZPDyN2Z/vnu+Oyp7pEHL/NCp+veWw0Ve5aj2xxjtUwaU7lPWMoQ4IkoVGMgzUY2
        Zh8hmtn/YEBgqpADAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDUtMDggYXQgMTg6MTcgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIEZyaSwgTWF5IDA4LCAyMDIwIGF0IDA2OjQwOjQzUE0gKzAzMDAsIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gPiAgICAgQWRkIGEgS1VuaXQgdGVzdCBmb3IgdGhlIGxpbmVhcl9yYW5nZXMg
aGVscGVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBCcmVuZGFuIEhp
Z2dpbnMgPGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+DQo+IA0KPiBUaGlzIG5vdyBnZW5lcmF0
ZXM6DQo+IA0KPiBXQVJOSU5HOiBtb2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFKCkgaW4g
bGliL2xpbmVhcl9yYW5nZXMubw0KPiBzZWUgaW5jbHVkZS9saW51eC9tb2R1bGUuaCBmb3IgbW9y
ZSBpbmZvcm1hdGlvbg0KPiANCj4gd2hlbiB0aGUgdGVzdHMgYXJlIGJ1aWx0IGFzIGEgbW9kdWxl
IGFuZCBzZWxlY3QgdGhlIGxpYnJhcnkuDQoNCkkgc2VudCBhIGZpeCBhcyBhbiBpbmNyZW1lbnRh
bCBwYXRjaC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIGl0IGlzIG5vdA0KdGhlIHdheSB0byBnby4N
Cg0KQW5kIFNvcnJ5IGZvciB0aGUgdHJvdWJsZSENCg0KQmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFp
dHRpbmVuDQo=

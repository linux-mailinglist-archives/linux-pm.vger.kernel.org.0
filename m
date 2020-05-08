Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511F41CB436
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEHP7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:59:21 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:48196 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgEHP7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:59:20 -0400
X-AuditID: c0a8fbf4-489ff70000004419-49-5eb581d7fa7e
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 58.35.17433.7D185BE5; Fri,  8 May 2020 17:59:19 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Fri, 8 May 2020 17:59:19 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v12 09/11] power: supply: Support ROHM bd99954 charger
Thread-Topic: [PATCH v12 09/11] power: supply: Support ROHM bd99954 charger
Thread-Index: AQHWJVBjC/LXJEv7ik2ClbqzFKaKX6ieNxAA
Date:   Fri, 8 May 2020 15:59:18 +0000
Message-ID: <7a6c4afc9caf5437567c520d5f50ecf540d1c303.camel@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
         <6d2f82459c5331fa7d27f41e6645a55cc1e44837.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <6d2f82459c5331fa7d27f41e6645a55cc1e44837.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B2676C9C931EF41969BE989B42DDD39@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURiGOzPj7qzrxLiu7dEscgnSIE0LmkrC/oSWmlgQBWpjTo7pXpqd
        NQ2sjS7omqZdDBcVr2RKhYti2ma2mFZSIqXWD6MtkVRUaCVLIZtx8vLnnJfv+573PXA+HFVZ
        ZP54up5nOD2dqZV5Yl0NC/Ydw1dak3b2fNVQA5/uoNQ916iM+vUxD6E+dJTLKHdhN6DK619j
        VN8zPlIe1W4bkUdV2c1R9sZ8WZTbvjkeO6WMSKH5rGPpafrQA6eVbH5zEWK8rciuHvzjYQGz
        uBUocEjuhi5HqVzUKnIIwLJezgo8Bd0LYL77JmIFOC4jI6D1s1yUanIvbB7wFkdQsgWB1e5q
        VGR9yMOwyOZApJkj8HreQbGsJsPhN1vdkj1GboUt7U1A1AQZByeKp+RSVC2AfZPzS6yCZGFe
        v7c4A8hNMN8yjYgaJTXQPjbnIT2ZhHWOflTSvnD8+9//9UDYNvcYE21QMhg+6QiV0EhouTGH
        SjoQ3i1wyaUneMM3ZaNYMdhgW5NgW6Vta2jbGtq2hq4CHo0A6uj0zDSaZ8JCOMYcwhlYnXCd
        MejsQPrL2adg0RntBAgOnMAPR7S+xJYTrUmq9SmG1ByWNrHJnDmTMTkBxFGtmijJbklSEal0
        zkWGMyy3NuKYVkNsc5UkqkgxK4NhjAy33A3AcS0kXlwWTL05Jo3JPpueya+2EVwhmnv6q02M
        PpXhaDPPJovLkWwStkNseQm5rEXACZOR1glVCX0LwvDi8YoaFO+uqBfO4Znn9agK0xv0jL+G
        iFkvAKQIsGb9StwE0OBA60OkCPur8hLWesVtQghChCD3T7sYxNOrLX8LyGB+85ap0FKiK7fu
        /oOX7ExHza2xmoePoudT2s2GBNMuD2w80Bhr7XE5XMqKpjbefXxdDJU101mrzA6aaY1WxCvD
        LzX8WOgPrr42JDuKJkwHnDd2HrranWtNdL67sK9Aq6NGXu0ZlMdVquf9Ws99mXy/GBh7Mrxw
        f1uQo3i2UouZWDpsO8qZ6H9YqkInkwMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDUtMDggYXQgMTg6NTAgKzAzMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90
ZToNCj4gVGhlIFJPSE0gQkQ5OTk1NCBpcyBhIEJhdHRlcnkgTWFuYWdlbWVudCBMU0kgZm9yIDEt
NCBjZWxsIExpdGhpdW0tSW9uDQo+IHNlY29uZGFyeSBiYXR0ZXJ5IGludGVuZGVkIHRvIGJlIHVz
ZWQgaW4gc3BhY2UtY29uc3RyYWludCBlcXVpcG1lbnQNCj4gc3VjaA0KPiBhcyBMb3cgcHJvZmls
ZSBOb3RlYm9vayBQQywgVGFibGV0cyBhbmQgb3RoZXIgYXBwbGljYXRpb25zLiBCRDk5OTU0DQo+
IHByb3ZpZGVzIGEgRHVhbC1zb3VyY2UgQmF0dGVyeSBDaGFyZ2VyLCB0d28gcG9ydCBCQzEuMiBk
ZXRlY3Rpb24gYW5kDQo+IGENCj4gQmF0dGVyeSBNb25pdG9yLg0KPiANCj4gU3VwcG9ydCBST0hN
IEJEOTk5NTQgQ2hhcmdlciBJQy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5l
biA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5k
eSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQoNCkh1aC4g
SSBzaG91bGRuJ3QgZG8gd29yayBhdCB0aGUgRnJpZGF5IGV2ZW5pbmdzLi4uIEl0IHNlZW1zIEkg
ZGlkDQphY2NpZGVudGFsbHkgc2VuZCB0aGlzIHBhdGNoIHR3aWNlLiBIb3BlZnVsbHkgaXQgZG9l
cyBub3QgbWVzcyB1cCB0aGUNCnNlcmllcyBmb3IgeW91IC0gSSdkIHJhdGhlciBub3QgcmVzZW5k
IHRoaXMgYW55bW9yZS4uLiBQbGVhc2UgbGV0IG1lDQprbm93IGlmIEkgc2hvdWxkIGRvIHNvbWUg
Y29ycmVjdGl2ZSBhY3Rpb25zLg0KDQpTb3JyeSENCg0KQmVzdCBSZWdhcmRzDQotLU1hdHRpDQo=

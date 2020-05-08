Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8206C1CB056
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEHNad (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:30:33 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:45558 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgEHNac (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 09:30:32 -0400
X-AuditID: c0a8fbf4-489ff70000004419-c9-5eb55ef619d7
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 7A.F4.17433.6FE55BE5; Fri,  8 May 2020 15:30:30 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Fri, 8 May 2020 15:30:23 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/11] Support ROHM BD99954 charger IC
Thread-Topic: [PATCH v11 00/11] Support ROHM BD99954 charger IC
Thread-Index: AQHWJDVjiBpLAI2GnUi/Ov7DoQHufKieDA6AgAADpIA=
Date:   Fri, 8 May 2020 13:30:23 +0000
Message-ID: <e5d57de76a11d0f450d358af187b52699c246cc9.camel@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
         <20200508131719.GJ4820@sirena.org.uk>
In-Reply-To: <20200508131719.GJ4820@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDF085982B5E2A41AF4C7FC17215E545@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURiGOTOzs2fVseN4O2lJLkKYeKUfi5gKEphEBP6ILq6NOrqr7q7M
        rqEmKUjhhURLBTdvqEEZZK6Kt8haFEtJIVNLCtsSQX8oXlJQu8y43n6d93zv93zvgfNBkl2V
        eUGt3sQLei5TSTtQb5/tdARuqrvVIXMrclW1bZ5WbX4uJlST/XW0av3hEFDVPX1PqcYGTNF0
        bJ/5uzzW0lZCx65bfK6SNxwjkjjTnXhtmj448rajpmiyVZa1rcjpK0opBF8UpUABMTqPX3Vu
        yEuBA2TRNMBvdqYI+2UE4Mbud+IFQhpF4NKvcglwQ4G4eruFlnpIdJ/AzcUThGS4oki8MDO+
        3xSFFz/WALsOx01tjyhJU8gPN8z+FrUcMugKbr4oVVmkw909/XukAoXh8Y4ftKQBOo1LCpf3
        ppPIE1sWtmT2NyPc+nqCtGt3vPjr737dF/dsvaSkF5PIH7f3B9vRaFxjbpTZtS+uKrPtRTHI
        BX+onacqgIf5WIL5iDYfo83HaPMxugnI2gDWcdrMNM7EhwYJfHaQYNDoxCPZoLMA+xdu9IJ/
        1ktWQEBgBSchoXRnzlzrVrPOSYaUXA1n1CQK2Zm80QowJJVuTGVOl5plUrjcPF4wHFjekFJ6
        MmdtlQkskrIyeD6LFw7cUxAqMUMkiENdBD6Nz0nVZpqObAIqpOEOXm5GXp/CC1y2SZMoLUei
        UdwOyXISczduiThjzOJ0YtWOjoIAWLFY30zCofqnzSRL6Q163suTuewstiKpVZOtPwxaAp4Q
        KF0ZhbiwrJO4x4dzlsQIQoxYX7NIESbuyPIqBB3PDTF9UeFbbQX5ef5DL7IqfVTf4ogTMdEJ
        c94DkVrZvdjOCe9PvR4hI3k3gwcDumaGneLjonQZw8kt2+5+Nmo3YqAhrGIBGsYj11Y6op7U
        ULZO9Gc6epetqHJNvbC5qi1+vDyaXl5A/8x3ux7eP62KSB8cqy0vm7v7YCq8fVZJGTVc6DlS
        MHL/Ae37dv6EAwAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDUtMDggYXQgMTQ6MTcgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIFRodSwgTWF5IDA3LCAyMDIwIGF0IDA5OjAzOjA2QU0gKzAzMDAsIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gPiBTb3JyeSBmb2xrcyBmb3IgZXhjZXNzaXZlIGFtb3VudCBvZiBlbWFpbHMu
IEkgYW0gcmVzZW5kaW5nIHRoaXMNCj4gPiBvbmNlDQo+ID4gbW9yZSAoSSBhbHJlYWR5IHJlc2Vu
dCB2MTAgYW5kIHYxMSBoYXMgbm8gY2hhbmdlcyBidXQgd2FzIGp1c3QNCj4gPiByZWJhc2VkKQ0K
PiA+IGJlY2F1c2UgSSBhbSBhZnJhaWQgdGhlIHByZXZpb3VzIHZlcnNpb24gZGlkIG5vdCByZWFj
aCBNYXJrLiBJZg0KPiA+IHRoaXMgaXMNCj4gPiB0cnVlIC0gSSBhbSB0aGUgb25lIHRvIGJsYW1l
LiBJIHNlZSBJIHNlbnQgb3JpZ2luYWwgdjEwIHRvIGFsbA0KPiA+IG90aGVyDQo+IA0KPiBZb3Ug
cHJvYmFibHkgc2hvdWxkJ3ZlIG1lbnRpb25lZCBpbiB0aGlzIG1haWwgc29tZXRoaW5nIGFib3V0
DQo+IGFwcGx5aW5nDQo+IG9uIGEgc2hhcmVkIGJyYW5jaCAtIEkgaGFkIHNlZW4gdGhlIG1haWwg
YWJvdXQgdGhhdCBhbmQgd2FzIHBsYW5uaW5nDQo+IHRvDQo+IGhhbmRsZSB0aGVzZSB0aGlzIHdl
ZWsgYnV0IGlmIEknZCBtaXNzZWQgU2ViYXN0aWFuJ3MgbWFpbCBmcm9tDQo+IGVhcmxpZXINCj4g
aW4gdGhlIHdlZWsgSSdkIHByb2JhYmx5IGp1c3QgbG9vayBhdCB0aGlzIGFuZCByZWFsaXNlIEkn
ZCByZXZpZXdlZA0KPiBldmVyeXRoaW5nIHJlbGV2YW50IGluIGl0Lg0KDQpUaGFua3MgZm9yIHRo
ZSB0aXAuIEknbGwgdHJ5IHRvIGtlZXAgdGhpcyBpbiBtaW5kIGZvciB0aGUgZnV0dXJlIGFuZA0K
YWRkIGEgbm90ZSBhYm91dCBhcHBseWluZyBpbiBkaWZmZXJlbnQgdHJlZXMgdG8gY292ZXIgbGV0
dGVyLg0KDQotLU1hdHRpDQo=

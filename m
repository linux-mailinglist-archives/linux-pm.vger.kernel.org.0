Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39989168DA0
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBVIdi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Feb 2020 03:33:38 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:63840 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIdi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Feb 2020 03:33:38 -0500
X-AuditID: c0a8fbf4-473ff70000004419-98-5e50e76025e8
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 1D.FB.17433.067E05E5; Sat, 22 Feb 2020 09:33:36 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Sat, 22 Feb 2020 09:33:31 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/5] power: Add linear_range helper
Thread-Topic: [RFC PATCH v2 3/5] power: Add linear_range helper
Thread-Index: AQHV4wme66eB5zhCx021MSsNZTrvl6glpJmAgAE6GYA=
Date:   Sat, 22 Feb 2020 08:33:29 +0000
Message-ID: <9b01b4d2bd85b7abc3fd5e8c95f8086ee6d7a313.camel@fi.rohmeurope.com>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <1d333e88974571322c14cf3e881b9a854e94bd9d.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <CACRpkdY1oa859bkVrgwA4iai7982GL_EMxns5+wAhQr+ggf9Kw@mail.gmail.com>
In-Reply-To: <CACRpkdY1oa859bkVrgwA4iai7982GL_EMxns5+wAhQr+ggf9Kw@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F79A3125471ED4A9E3EA6F01CC32B60@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOttfLibfN8m2twEVmhZpgdIxlfikWRFiRH8TbKY9uthtn
        m1gUCJKp3aXrUpOVOdRug2WZRa0prkIxSZPsYq7CAglMFLXLOTuVfjr/8/yf//N74H0goTgp
        U0GD2c5yZsaokYWTj90znvi8L+k561pvKOlzw0EZfcXfLaXPzjZK6L62Ghk9fsIP6IaBXgld
        09BF0kce+uX08wf2tDBdS10L0N13vpXrPE2VMt1Qf7tMN+5Zni7NjNDuZezFuw2F5sTUvAh9
        c1+H3NquLKm+eA6UgllFFQiDGCXjn2UvpVUgHCrQK4ADV28R4k8XwNN3J+RVAEIZ0uKqQbkQ
        iEIp+GlXDSn0EKicxJPVF0nBUKJUfNt7ghSbNuPWug6pqDfigP+1RNAkWonbOt2EoCm0A997
        3igRYd8Abj5SHmoKQzvx1KA3RANoGa4sHQvVCRSNPZ8npeLaCF9r7yFEvQiPjvz6W4/BrZM3
        SWFpAq3Gt9oSxWga7hqdIEUdg88eG5aLOyzEgUtB8jRY7JxHcM6lnfPSznlp57x0PZA2AWxi
        DMZCxs4mJXCsI4Gz6E38Z5/F5AHi+/64B377tvmABAIfWAIlmkVU97v0HMWCvZb8A3rGps/l
        HEbW5gMYEpooKjZyR46CymcOHGQ5yz9rKSQ10dSq4TPZCiSw9rOsleX+uWoINZgKBPmhCzm2
        kC0pMBjtc7YEhgnDw1VRNtacz3KMw67PFQ4k18ZfiGBF8twNA3ycslkZE18Vo8/AWnh6tNZF
        QH9tg4tQkGaLmVVFU7su861IaNU7zP9BX0E0BBoldf4T70byR/5/zlceIeERK2AIYWfmLFUp
        uBARLBpS9nR+V+9U9w/EeF3xxx+9zezc8uH2GmvxUevhrN40hVlqDBZQU28qitUT1wuSR/f0
        uKTuTUWnErf3X1qf0Trx7sW0uqx468drY0VxMzhbXj1SW1/2/nGs3vvF1ZlxoWJjabY3uQ5p
        VQ/cqERbk/Vk8FB1XARzJeUOXKYhbXomaQ3B2Zg/LSZGHaEDAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TW9ybmluZyBMaW51cywNCg0KT24gRnJpLCAyMDIwLTAyLTIxIGF0IDE0OjQ5ICswMTAwLCBMaW51
cyBXYWxsZWlqIHdyb3RlOg0KPiBPbiBGcmksIEZlYiAxNCwgMjAyMCBhdCA4OjM3IEFNIE1hdHRp
IFZhaXR0aW5lbg0KPiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPiB3cm90ZToN
Cj4gDQo+ID4gTWFueSBkZXZpY2VzIGhhdmUgY29udHJvbCByZWdpc3RlcnMgd2hpY2ggY29udHJv
bCBzb21lIG1lYXN1cmFibGUNCj4gPiBwcm9wZXJ0eS4gT2Z0ZW4gYSByZWdpc3RlciBjb250YWlu
cyBjb250cm9sIGZpZWxkIHNvIHRoYXQgY2hhbmdlIGluDQo+ID4gdGhpcyBmaWVsZCBjYXVzZXMg
bGluZWFyIGNoYW5nZSBpbiB0aGUgY29udHJvbGxlZCBwcm9wZXJ0eS4gSXQgaXMNCj4gPiBub3QN
Cj4gPiBhIHJhcmUgY2FzZSB0aGF0IHVzZXIgd2FudHMgdG8gZ2l2ZSAnbWVhbmluZ2Z1bGwnIGNv
bnRyb2wgdmFsdWVzDQo+ID4gYW5kDQo+ID4gZHJpdmVyIG5lZWRzIHRvIGNvbnZlcnQgdGhlbSB0
byByZWdpc3RlciBmaWVsZCB2YWx1ZXMuIEV2ZW4gbW9yZQ0KPiA+IG9mdGVuIHVzZXIgd2FudHMg
dG8gJ3NlZScgdGhlIGN1cnJlbnRseSBzZXQgdmFsdWUgLSBhZ2FpbiBpbg0KPiA+IG1lYW5pbmdm
dWxsIHVuaXRzIC0gYW5kIGRyaXZlciBuZWVkcyB0byBjb252ZXJ0IHRoZSB2YWx1ZXMgaXQgcmVh
ZHMNCj4gPiBmcm9tIHJlZ2lzdGVyIHRvIHRoZXNlIG1lYW5pbmdmdWxsIHVuaXRzLg0KPiANCj4g
UmVuYW1lIG1lYW5pbmdmdWxsIC0+IG1lYW5pbmdmdWwNCj4gDQo+ID4gVGhpcyBpZGVhcyBpcyBz
dG9sLi4uIGJvcnJvd2VkIGZyb20gcmVndWxhdG9yIGZyYW1ld29yaydzDQo+ID4gcmVndWxhdG9y
X2xpbmVhcl9yYW5nZXMgaGFuZGxpbmcuDQo+IA0KPiBIZWhlIG1heWJlIG9uZSBkYXkgd2UgY2Fu
IG1vdmUgdGhlIHdob2xlIHRoaW5nIHRvIGxpYi8NCj4gYnV0IGxldCdzIHRha2Ugb25lIHN0ZXAg
YXQgYSB0aW1lLg0KPiANCj4gPiBQcm92aWRlIGEgbGluZWFyX3JhbmdlIGhlbHBlciB3aGljaCBj
YW4gZG8gY29udmVyc2lvbiBmcm9tIHVzZXINCj4gPiB2YWx1ZQ0KPiA+IHRvIHJlZ2lzdGVyIHZh
bHVlICdzZWxlY3RvcicuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVu
IDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4g
V2hlcmUgc2hvdWxkIHdlIHB1dCB0aGVzZT8NCj4gDQo+IFRoaXMgd29ya3MuDQo+IA0KPiBSZXZp
ZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KDQpVaC4u
IFNvcnJ5IGJ1dCBJIGRpZCBhbHJlYWR5IHNlbmQgdjMgd2hlcmUgSSBjaGFuZ2VkIHRoZSBhcHBy
b2FjaCB0bw0Kd2hhdCB3YXMgc3VnZ2VzdGVkIGJ5IE1hcmsuIEVnLCBJIHRyaWVkIHB1bGxpbmcg
dGhlIHJhbmdlIGNvZGUgb3V0IG9mDQpyZWd1bGF0b3IgZnJhbWV3b3JrIGFuZCB1c2VkIHRoYXQg
aW4gcG93ZXIvc3VwcGx5IHRvby4NCg0KQmFzaWMgaWRlYSBpcyBzdGlsbCB0aGUgc2FtZSAtIGJ1
dCBpbnN0ZWFkIG9mIHVzaW5nIG1pbl9zZWwgKyBhbW91bnQgb2YNCnZhbHVlcyBpbiByYW5nZSwg
dGhlIHZlcnNpb24gMyB1c2VzIG1pbl9zZWwgYW5kIG1heF9zZWwgYXMgcmVndWxhdG9ycw0KZGlk
LiBUaGF0IG1pbmltaXplZCBjaGFuZ2VzIHRvIG51bWVyb3VzIHJlZ3VsYXRvciBkcml2ZXJzIGRl
ZmluaW5nDQpyYW5nZXMuDQoNClNvcnJ5IGZvciBtYWtpbmcgeW91IHRvIGRvIHVubmVjZXNzYXJ5
IHJldmlld2luZy4NCg0KQmVzdCBSZWdhcmRzDQogICAgTWF0dGkgVmFpdHRpbmVuDQoNCg==

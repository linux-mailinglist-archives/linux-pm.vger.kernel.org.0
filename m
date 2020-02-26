Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3516F8DE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 08:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgBZH65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 02:58:57 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:63484 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBZH65 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 02:58:57 -0500
X-AuditID: c0a8fbf4-473ff70000004419-e3-5e56253ff69e
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 89.74.17433.F35265E5; Wed, 26 Feb 2020 08:58:55 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Wed, 26 Feb 2020 08:58:50 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 9/9] power: supply: Support ROHM bd99954 charger
Thread-Topic: [PATCH v4 9/9] power: supply: Support ROHM bd99954 charger
Thread-Index: AQHV67lhdTml9IRASUqjFOfVB9Uut6gsBxOAgAEF5AA=
Date:   Wed, 26 Feb 2020 07:58:49 +0000
Message-ID: <cce763015445ead7fbe5aafd929c52dedd375167.camel@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <529dd6298be245051f333ab4d9264902bf889aa6.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <c187bb77-e804-93bd-64db-9418be58f191@infradead.org>
In-Reply-To: <c187bb77-e804-93bd-64db-9418be58f191@infradead.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C94D26BEAFBF94BBBA6AD24B017A118@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsVyYMXvjbr2qmFxBvtOKFhMffiEzWL+kXOs
        Fs2L17NZfLvSwWRxedccNovPvUcYLZZev8hkMWfpCRaLuV+mMlu8vTOdxaJ17xF2i9O7Sxx4
        PNbMW8PosXPWXXaPzSu0PDat6mTz2D93DbvH501yAWxR3DZJiSVlwZnpefp2CdwZO5ZOYy64
        IlKxfvc/5gbGCSJdjJwcEgImEl2/97GA2EICVxklFp5h7GLkArJPMErMPD0TyOHgYBOwkei6
        yQ5SIyKQI7F6Uh8bSA2zwCMWieMzethAEsIC7hJfmnYwQhR5SJxY188EYVtJzDr9AKyZRUBV
        4tiiCWA1vAJ+Ep8uPmWHWHabUWLvh19gDZwCjhJvFm4Da2AUkJXobHgHFmcWEJfY9Ow7K8TV
        AhJL9pxnhrBFJV4+/gcVV5LY+/MhC8jRzAKaEut36UO0OkgcWX6dEcJWlJjS/ZAd4gZBiZMz
        n7BMYBSbhWTDLITuWUi6ZyHpnoWkewEj6ypGidzEzJz0xJJUQ72i1FK9ovyMXCCVnJ+7iRES
        4192MP4/5HmIkYmD8RCjJAeTkihvnnxYnBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3o1fQ+OE
        eFMSK6tSi/JhUtIcLErivOoPJ8YKCYDsyk5NLUgtgsnKcHAoSfBOkgYaKliUmp5akZaZU4KQ
        ZuLgBBnOJSVSnJqXklqUWFqSEQ9KH/HFwAQCkuIB2uukDNTOW1yQmAsUhWg9xajNMeHl3EXM
        HEfmLl3ELMSSl5+XKiXOy6kCVCoAUppRmge36BWjOAejkjDvTCWgLA8w2cPNeQW0ggloxeo/
        wSArShIRUlINjE1a14X8fS2uM8pXeMhGOU0JdPFpnRGarHDQpdRy/+1pnPMOlq7x7oqq6Q1o
        kGTYwqr7YsFOvca0Weu0K29NLPObH7OtP7dOVeGV7fFbkr+uvDZ0Zf+bpJno78s6TzpkbUxe
        3LlZj/tWGapvDjdT7+SNCzO0XLhUfMkUhwsqu7dou51fdzRSiaU4I9FQi7moOBEAFVnpXbMD
        AAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gUmFuZHksDQoNCk9uIFR1ZSwgMjAyMC0wMi0yNSBhdCAwODoyMSAtMDgwMCwgUmFuZHkg
RHVubGFwIHdyb3RlOg0KPiBPbiAyLzI1LzIwIDEyOjU1IEFNLCBNYXR0aSBWYWl0dGluZW4gd3Jv
dGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5L0tjb25maWcNCj4gPiBi
L2RyaXZlcnMvcG93ZXIvc3VwcGx5L0tjb25maWcNCj4gPiBpbmRleCA4NzgxYzY3NGVkMDcuLjBi
M2JhZDZmYzczNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9LY29uZmln
DQo+ID4gKysrIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvS2NvbmZpZw0KPiA+IEBAIC03MDIsNiAr
NzAyLDE2IEBAIGNvbmZpZyBDSEFSR0VSX0JENzA1MjgNCj4gPiAgCSBpbmZvcm1hdGlvbiBhbmQg
YWx0ZXJpbmcgY2hhcmdlciBjb25maWd1cmF0aW9ucyBmcm9tIGNoYXJnZXINCj4gPiAgCSBibG9j
ayBvZiB0aGUgUk9ITSBCRDcwNTI4IFBvd2VyIE1hbmFnZW1lbnQgSUMuDQo+ID4gIA0KPiANCj4g
SGksDQo+IA0KPiA+ICtjb25maWcgQ0hBUkdFUl9CRDk5OTU0DQo+ID4gKwl0cmlzdGF0ZSAiUk9I
TSBiZDk5OTU0IGNoYXJnZXIgZHJpdmVyIg0KPiA+ICsJZGVwZW5kcyBvbiBJMkMNCj4gPiArCXNl
bGVjdCBMSU5FQVJfUkFOR0VTDQo+ID4gKwlkZWZhdWx0IG4NCj4gDQo+IERyb3AgdGhlICJkZWZh
dWx0IG4iLCBzaW5jZSBpdCBpcyBhbHJlYWR5IHRoZSBkZWZhdWx0Lg0KPiANCj4gPiArCWhlbHAN
Cj4gPiArCSBTYXkgWSBoZXJlIHRvIGVuYWJsZSBzdXBwb3J0IGZvciBnZXR0aW5nIGJhdHRlcnkg
YW5kIGNoYXJnZXINCj4gPiArCSBpbmZvcm1hdGlvbiBhbmQgYWx0ZXJpbmcgY2hhcmdlciBjb25m
aWd1cmF0aW9ucyBmcm9tIHRoZSBST0hNDQo+ID4gKwkgQkQ5OTk1NCBjaGFyZ2VyIElDLg0KPiAN
Cj4gUGxlYXNlIGluZGVudCB0aGUgMyBsaW5lcyBvZiBoZWxwIHRleHQgd2l0aCBvbmUgYWRkaXRp
b25hbCBzcGFjZSAoMg0KPiB0b3RhbCkuDQo+IFNlZSBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29k
aW5nLXN0eWxlLnJzdDoNCj4gDQo+IDEwKSBLY29uZmlnIGNvbmZpZ3VyYXRpb24gZmlsZXMNCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gRm9yIGFsbCBvZiB0aGUgS2Nv
bmZpZyogY29uZmlndXJhdGlvbiBmaWxlcyB0aHJvdWdob3V0IHRoZSBzb3VyY2UNCj4gdHJlZSwN
Cj4gdGhlIGluZGVudGF0aW9uIGlzIHNvbWV3aGF0IGRpZmZlcmVudC4gIExpbmVzIHVuZGVyIGEg
YGBjb25maWdgYA0KPiBkZWZpbml0aW9uDQo+IGFyZSBpbmRlbnRlZCB3aXRoIG9uZSB0YWIsIHdo
aWxlIGhlbHAgdGV4dCBpcyBpbmRlbnRlZCBhbiBhZGRpdGlvbmFsDQo+IHR3bw0KPiBzcGFjZXMu
ICBFeGFtcGxlOjoNCj4gDQo+ICAgY29uZmlnIEFVRElUDQo+IAlib29sICJBdWRpdGluZyBzdXBw
b3J0Ig0KPiAJZGVwZW5kcyBvbiBORVQNCj4gCWhlbHANCj4gCSAgRW5hYmxlIGF1ZGl0aW5nIGlu
ZnJhc3RydWN0dXJlIHRoYXQgY2FuIGJlIHVzZWQgd2l0aCBhbm90aGVyDQo+IAkgIGtlcm5lbCBz
dWJzeXN0ZW0sIHN1Y2ggYXMgU0VMaW51eCAod2hpY2ggcmVxdWlyZXMgdGhpcyBmb3INCj4gCSAg
bG9nZ2luZyBvZiBhdmMgbWVzc2FnZXMgb3V0cHV0KS4gIERvZXMgbm90IGRvIHN5c3RlbS1jYWxs
DQo+IAkgIGF1ZGl0aW5nIHdpdGhvdXQgQ09ORklHX0FVRElUU1lTQ0FMTC4NCj4gDQo+ID4gKw0K
PiA+ICBjb25maWcgQ0hBUkdFUl9XSUxDTw0KPiA+ICAJdHJpc3RhdGUgIldpbGNvIEVDIGJhc2Vk
IGNoYXJnZXIgZm9yIENocm9tZU9TIg0KPiA+ICAJZGVwZW5kcyBvbiBXSUxDT19FQw0KPiANCj4g
dGhhbmtzLg0KDQpUaGFua3MgYWdhaW4gZm9yIHRoZSByZXZpZXcuIEknbGwgZml4IHRoZXNlIGZv
ciB0aGUgbmV4dCB2ZXJzaW9uIDopDQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0KDQo=

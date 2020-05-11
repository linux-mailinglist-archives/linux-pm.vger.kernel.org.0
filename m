Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F21CD220
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEKGzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 02:55:36 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:55700 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgEKGzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 02:55:36 -0400
X-AuditID: c0a8fbf4-473ff70000004419-d6-5eb8f6e6b998
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 72.17.17433.6E6F8BE5; Mon, 11 May 2020 08:55:34 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Mon, 11 May 2020 08:55:23 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>
CC:     "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Okada, Koki" <Koki.Okada@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pakanen, Risto" <Risto.Pakanen@fi.rohmeurope.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] lib: linear_ranges: Add missing MODULE_LICENSE()
Thread-Topic: [PATCH] lib: linear_ranges: Add missing MODULE_LICENSE()
Thread-Index: AQHWJhS/nV/flBZ5p0W1/MrmhCvg2qihmvaAgAC5rAA=
Date:   Mon, 11 May 2020 06:55:22 +0000
Message-ID: <6cc724a6fe5b84f74b381904d16b04b55a7c0a64.camel@fi.rohmeurope.com>
References: <20200509151519.GA7100@localhost.localdomain>
         <20200510195059.dijv6ysac42a6nuq@earth.universe>
In-Reply-To: <20200510195059.dijv6ysac42a6nuq@earth.universe>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC1CB52593135541B90CAAF6B0D25600@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOtrPp0dc5882l6UC6iJpgMkpFAnVC2O1DEOk66tGJu3G2
        hUoXIT94SXDMYhuORCeFRMKIWqakQ8ILFKPQkgwk8Rr1weWlUjvHk5dP7+99/s//+b/wPgQm
        qxPFEJUGC80YKJ1SJMUHn/zxJs+t+opPOb5IVYFPdkz1YGZWpFr92CBQfehrF6lWWoaBqr17
        BFdNLxfmiNW+aQ9Qv3JNi9UdXqva29MoUq944y4Kr4VkllCWm1cqKwyp2TdCtB7bhsAUjK+2
        ewPCOtAQ3wQIAsF0NDcd1gSkhAxOAHR/KojxlxGAHnYNCLkmEcxETZ/FHMphPnK2qbkWDD7F
        0DvHNluXEJEwF/38/kPAsRzmocWBCTHPZ9Bgx4qQYxwmIvebvxjHJCxEk802nGMZ1KPfgV4R
        xxKYhXxdzp06gLGosY6ficFo5J1b25mDIESe/vcYz1Fo8dvW/3oCern2DOfeicETqLcvlbfm
        oDHbNs5zAmprnhHzT4hAo85ZvBUcch1IcO27XQfcrgNu1wF3BxD2AKSnKnUVlIVOS2Foawpj
        1OrZo9So9wL+R4M+sO0v8AMBAfzgMCFQRpH9AV+xLKzEWFajpcxaDWPV0WY/QASmlJPqr6xG
        llE1tTRj3JUUBK6MJo/N2IpkkMuqomkTzeyqRwhCicjNX6wxgqEr6OrySp1lXxYQEm64NEZu
        pg1lNENZLVoNtx0aM7senBTK5uZzdtJsovRslbeOgSSiddHdiRHD7u5OTIYbjAY6Jpos8bCt
        kGvVWg17QUsgmgDKSNIRZNVQdq335iyxEQI2Ymb+BRdhofalmDrQUi+5HB6ekVykS1+/c3at
        yp9hDAPXa1Xx65ccj52Jzxcu5NvdJru9XizLjlPkGu/Vg1tT8O1Q8mRCXkJByurtq7G6cTDq
        vfvo9XjPwvx41LnlIW2tskdjW98wC7bK7acV1RnBrOMRHlOrX9EgjK86uqyhNzv702TqpPOl
        DiVu1lJpJzHGTP0DG62GQJMDAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TW9ybmluZyBmb2xrcywNCg0KT24gU3VuLCAyMDIwLTA1LTEwIGF0IDIxOjUwICswMjAwLCBTZWJh
c3RpYW4gUmVpY2hlbCB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiBTYXQsIE1heSAwOSwgMjAyMCBh
dCAwNjoxNToxOVBNICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gV2hlbiBsaW5l
YXJfcmFuZ2VzIGlzIGNvbXBpbGVkIGFzIG1vZHVsZSB3ZSBnZXQgd2FybmluZw0KPiA+IGFib3V0
IG1pc3NpbmcgTU9EVUxFX0xJQ0VOU0UoKS4gRml4IGl0IGJ5IGFkZGluZw0KPiA+IE1PRFVMRV9M
SUNFTlNFKCJHUEwiKSBhcyBpcyBzdWdnZXN0ZWQgYnkgU1BEWCBhbmQgRVhQT1JUcy4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5y
b2htZXVyb3BlLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBJIHNhdyBNYXJrIGFwcGxpZWQgdGhl
IGxpbmVhci1yYW5nZXMgcGF0Y2guIFNvIEkgc2VudCB0aGlzIGZpeCBhcw0KPiA+IGluY3JlbWVu
dGFsIHBhdGNoIC0gYnV0IEkgc3RpbGwgdXNlIHRoZSBzYW1lIExpbnVzIHRyZWUgYXMgYSBiYXNl
DQo+ID4gb2YNCj4gPiB0aGlzIGZpeCAtIHRoZSBsaW5lYXItcmFuZ2VzIGZpbGUgc2hvdWxkIGJl
IHVuY2hhbmdlZCBpbiByZWd1bGF0b3INCj4gPiB0cmVlLg0KPiA+IElmIHRoaXMgZG9lcyBub3Qg
YXBwbHkgSSBjYW4gY2xvbmUgcmVndWxhdG9yIHRyZWUgYW5kIGNyZWF0ZSB0aGlzDQo+ID4gZml4
IG9uDQo+ID4gaXQuDQo+ID4gDQo+ID4gSSBkb24ndCBrbm93IGlmIHRoaXMgaXMgdGhlIGNvcnJl
Y3Qgd2F5IHRvIGZpeCB0aGlzIGFzIHRoZSBsaW5lYXItDQo+ID4gcmFuZ2VzDQo+ID4gc2hvdWxk
IGJlIG1lcmdlZCB0byBwb3dlci1zdXBwbHkgdHJlZS4NCj4gPiANCj4gPiBJIGd1ZXNzIHdlIGNh
biBlaXRoZXI6DQo+ID4gLSBVc2UgdGhpcyBwYXRjaCB0byBmaXggcmVndWxhdG9yIHRyZWUgYW5k
IGNyZWF0ZSBmaXhlZCB0YWcgZm9yDQo+ID4gICBwb3dlci1zdXBwbHkoPykNCj4gPiAtIEFkZCB0
aGlzIGZpeCBpbiB0aGUgb3JpZ2luYWwgc2VyaWVzIGFuZCByZXNlbmQgd2hvbGUgc2VyaWVzKD8p
DQo+ID4gLSByZS1jcmVhdGUgdGhlIHNlcmllcyBhbmQgZHJvcCB0aGUgYWxyZWFkeSBhcHBsaWVk
IHBhdGNoZXMuIEFkZA0KPiA+IHRoaXMNCj4gPiAgIGZpeCBhcyBhIGZpeHVwIHBhdGNoIGluIG5l
dyBzZXJpZXMgYW5kIGFwcGx5IGl0IHRvIHBvd2VyLXN1cHBseQ0KPiA+IHRyZWUNCj4gPiAgIGFm
dGVyIHRoZSBsaW5lYXItcmFuZ2VzIGZyb20gcmVndWxhdG9yIGlzIG1lcmdlZCB0byBwb3dlci1z
dXBwbHkuDQo+ID4gDQo+ID4gIFBsZWFzZSBhZHZpZWNlIG1lIGlmIHRoaXMgcGF0Y2ggaXMgbm90
IHRoZSB3YXkgdG8gZ28uDQo+ID4gDQo+ID4gT2gsIGFuZCBJIGFtIHJlYWxseSBzb3JyeSBmb3Ig
dGhlIHRyb3VibGUuIEkgc2F3IEkgaGFkIHJlZ3VsYXRvcnM9eQ0KPiA+IGluIGFsbCBvZiBteSBj
b21waWxhdGlvbnMgZHVlIHRvIHNvbWUgcGluY29udHJvbCBkZXBlbmRlbmNpZXMuIFNvDQo+ID4g
bGluZWFyLXJhbmdlcyB3YXMgbm90IGJ1aWx0IGFzIG1vZHVsZSBpbiBhbnkgb2YgbXkgdGVzdA0K
PiA+IGNvbXBpbGF0aW9ucyA6KA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGVzdGluZyBNYXJrIQ0K
PiANCj4gUmV2aWV3ZWQtYnk6IFNlYmFzdGlhbiBSZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBj
b2xsYWJvcmEuY29tPg0KPiANCj4gSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBqdXN0IHF1ZXVl
IHRoaXMgdGhyb3VnaCB0aGUgcmVndWxhdG9yIHRyZWUuDQoNClRoYXQncyBhYnNvbHV0ZWx5IGZp
bmUgd2l0aCBtZS4gSXQganVzdCBtZWFucyB0aGF0IHRoZSBwb3dlci1zdXBwbHkNCnRyZWUgaGFz
IHRoaXMgY29tcGlsYXRpb24gaXNzdWUgdW50aWwgZml4IGFwcGxpZWQgdG8gcmVndWxhdG9yIHRy
ZWUNCmdldHMgbWVyZ2VkLiBCdXQgYXMgSSBzYWlkIGluIGFub3RoZXIgbWFpbCwgdGhpcyBpc3N1
ZSBpcyBleHBlY3RlZCB0bw0KYmUgdHJpZ2dlcmVkIG9ubHkgaW4gbGltaXRlZCBudW1iZXIgb2Yg
dGVzdCBidWlsZHMuDQoNCj4gQXBhcnQgZnJvbSB0aGF0IHlvdSBzaG91bGQgYWRkIGEgTUFJTlRB
SU5FUlMgZmlsZSBlbnRyeSBmb3IgdGhlDQo+IGxpbmVhcl9yYW5nZXMgbGliLiBNYWluIHVzZXIg
aXMgcmVndWxhdG9ycywgc28gZnV0dXJlIHBhdGNoZXMgc2hvdWxkDQo+IHByb2JhYmx5IGJlIHF1
ZXVlZCB0aHJvdWdoIGl0cyB0cmVlLg0KDQpUaGlzIGlzIHNvbWV0aGluZyBJIGhhdmUgYmVlbiB0
aGlua2luZyBpbiBnZW5lcmFsLiBJIGZlZWwgYSB0aW55IGJpdA0KYmFkIGFib3V0IGFkZGluZyBh
bGwgbXkgUk9ITSBjb21wb25lbnQgZHJpdmVycyB0byBiZSBtYWludGFpbmVkIGJ5DQpvdGhlcnMu
IEkgaGF2ZSByZWNlbnRseSBwb2xsdXRlZCB0aGUga2VybmVsIHdpdGggZmV3IGRyaXZlcnMgYW5k
IEkgZmVlbA0KSSBzaG91bGQgaGVscCBieSByZXZpZXdpbmcgcGF0Y2hlcyBmb3IgdGhvc2UuDQoN
CkkgbWlnaHQgYmUgYWJsZSB0byBzZXQtdXAgc29tZSBtYWNoaW5lcnkgdG8gY29tcGlsZSAoYW5k
IGFsc28gZG8gc29tZQ0KX3JlYWxseV8gbGltaXRlZCB0ZXN0aW5nKSBvZiB0aGUgY2hhbmdlcyB0
byB0aGVzZSBST0hNIGRyaXZlcnMgLSBhbmQNCnBvc3NpYmx5IHNldC11cCBhIGdpdCB0cmVlIGZv
ciB0aGVtLiBEbyB5b3UgdGhpbmsgaXQgd291bGQgYmUNCmJlbmVmaWNpYWw/IEkgdGhpbmsgd2Ug
Y2FuIGF0IHNvbWUgcG9pbnQgY29uc2lkZXIgaGF2aW5nIHNlcGFyYXRlDQptYWludGFpbmVyIGVu
dHJpZXMgZm9yIEJENzE4eDcsIEJENzA1MjgsIEJENzE4MjggYW5kIEJEOTk5NTQgKCsgc29tZQ0K
Y29taW5nIGRyaXZlcihzKSBpZiBpdCBoZWxwcy4NCg0KV2hhdCBjb21lcyB0byBsaW5lYXJfcmFu
Z2VzIC0gTWFyaywgY291bGQgeW91IGJlIGFkZGVkIGFzIGEgbWFpbnRhaW5lcg0KZm9yIGxpbmVh
cl9yYW5nZXMuYyBhbmQgdGVzdF9saW5lYXJfcmFuZ2VzLmMgKGF0IGxlYXN0IGZvciBub3c/KSBJ
IGNhbg0KdHJ5IGRvIHNvbWUgcmV2aWV3aW5nIHRvbyBpZiBpdCBoZWxwcy4NCg0KLS1NYXR0aQ0K

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3F16B99B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgBYGXi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 01:23:38 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:57586 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYGXi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 01:23:38 -0500
X-AuditID: c0a8fbf4-473ff70000004419-54-5e54bd689c0f
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 7D.20.17433.86DB45E5; Tue, 25 Feb 2020 07:23:36 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Tue, 25 Feb 2020 07:23:32 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 5/8] regulator: use linear_ranges helper
Thread-Topic: [RFC PATCH v3 5/8] regulator: use linear_ranges helper
Thread-Index: AQHV58CCun7qdt/zDkaUtOc73neHtagqMwKAgAE06AA=
Date:   Tue, 25 Feb 2020 06:23:31 +0000
Message-ID: <d5e63ea6935991d855e2ae12915b3b4614e8f3aa.camel@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <ba2eb2d7363b386136a546a769a6e2d077558094.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <20200224115751.GE6215@sirena.org.uk>
In-Reply-To: <20200224115751.GE6215@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E02D104186D47044A745BE5D96E6817C@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTYRjn3d1u59bFu6Xt1azwKqJEzUi6ykrsaxaEpEgYaWdebuk2uc3Q
        +seKIFeRklIezkQzypbSqPBrabI/tKIPK1KkYFbiVxYpShnanefXX+/zPr+v9+F9SExXQgSR
        Joud4y1sFk2o8dZ7k+4woycxZdMNz1qmxPeNYG57XyuZi1V1BDP+4bKCed9YRjCj17yAqf70
        TsGUVbfjjHOsBGMuebwq5mWTPUZjcJW7gKFB+KwyuGsKCEOL06UyjLpXxSuTNdFprP1MginD
        ErHrhMY4OVKrzG5W5xZ97wf54JbaAfxIBLcgZ7MAHEBN6uBHgLy9gkq+tAP0p+Kt0gFIkoDR
        yNGtkgT+MAyV/K0iJA4GR3D0sW8MSJxlcA+qb98tc/aiQc8FpVxvR3e7OmZqHK5DvuYWlUSn
        4GHU79TJUa8Auv9zeqbvBzejm/VpEh3Alaggf0Qh1RjUI3ffhFJ+M0R3mt9gch2ABr5OzfZp
        5PnjwyUbDG5AdY0RsjQGDXVNztqEoOIrvplJKKhFHaXf8EKwXFiUICyohUVqYZFaWKSuAMoa
        gMysKSuDtXOR4TyXE85bjWbxOGk1u4H8zWP1YLotrg0oSNAGAkkFHUAdaExM0S1Ns6bnGVmb
        MZXPyeJsbQCRGO1PHQJHUnRUOpt3luOtc9AKEqf11Hpf0XEdlLIyOS6b4+fQYJKkEWVqEk21
        PJfB5Z4yZdkXYAXpJ5mrg/xtnCWd49kcuzFV2o5Um7geErREzI16KsopWzZrFruy9AUIJQsH
        nJUY6XVWV2I63GK1cEF6ymUWqVCiGnMs80GDQE8Cehk1JQ23RNz1eZ9BMUIhRjz4lyBF2NkF
        KCgflCclj2qEfcPnivu/pIVcjxsqm3JNBP/YOhW95kbob/9nx04f6jhfn61VxhbkBUBtWOe2
        3BBN69UN8eNCUebDFhD1nO08ulq9v2ppaXCPqqeMjjkc1jpMFPYm7tif1OC3s7QwydfZoMWf
        HByvNSQ7Mn9Rn2KnA+NHNufmPZ7o1j+icZuRjdyI8Tb2P6IQL6KoAwAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gTWFyaywNCg0KT24gTW9uLCAyMDIwLTAyLTI0IGF0IDExOjU3ICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAyMCwgMjAyMCBhdCAwOTozNjozOEFNICswMjAwLCBN
YXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gQ2hhbmdlIHRoZSByZWd1bGF0b3IgaGVscGVycyB0
byB1c2UgY29tbW9uIGxpbmVhcl9yYW5nZXMgY29kZS4NCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUg
c3F1YXNoZWQgaW4gd2l0aCB0aGUgcHJldmlvdXMgY29tbWl0IHRvIGF2b2lkIGJ1aWxkDQo+IGJy
ZWFrcy4NCg0KSSBkb24ndCB0aGluayBzby4NCg0KT25seSBjaGFuZ2UgcmVxdWlyZWQgb24gaW5k
aXZpZHVhbCByZWd1bGF0b3IgZHJpdmVycyBzaG91bGQgYmUgcmVuYW1pbmcNCnRoZSBzdHJ1Y3Qg
cmVndWxhdG9yX2xpbmVhcl9yYW5nZSB0byBsaW5lYXJfcmFuZ2UuIFJlc3Qgb2YgdGhlIGNoYW5n
ZXMNCnNob3VsZCBiZSBpbnRlcm5hbCB0byByZWd1bGF0b3IgZnJhbWV3b3JrLCByaWdodD8NCg0K
RXZlbiB0aGUgbmFtaW5nIGNoYW5nZSBvZiB0aGUgbGluZWFyX3JhbmdlIHN0cnVjdCBtZW1iZXJz
IHNob3VsZCBub3QgYmUNCnZpc2libGUgdG8gdGhlc2UgZHJpdmVycyBhcyB0aGV5IHVzZSB0aGUg
aW5pdGlhbGl6ZXIgbWFjcm8gZm9yIHNldHRpbmcNCnRoZSB2YWx1ZXMuIEkgbXVzdCBhZG1pdCBJ
IGRpZG4ndCBjb21waWxlIF9hbGxfIHRoZSByZWd1bGF0b3IgZHJpdmVycw0Kd2hlbiBJIHRlc3Rl
ZCB0aGlzIHRob3VnaC4gSSB3aWxsIHRyeSBjb21waWxpbmcgYXQgbGVhc3QgbW9zdCBvZiB0aGUN
CnJlZ3VsYXRvciBkcml2ZXJzIGZvciBuZXh0IHZlcnNpb24gdGhvdWdoLiBBbmQgSSB0aGluayB0
aGUgZmVlZGJhY2sgZm9yDQp0aGlzIHNlcmllcyBoYXMgYmVlbiBtb3N0bHkgcG9zaXRpdmUgc28g
SSdsbCBhbHNvIGRyb3AgdGhlIFJGQyBmb3IgaXQuDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZh
aXR0aW5lbg0K

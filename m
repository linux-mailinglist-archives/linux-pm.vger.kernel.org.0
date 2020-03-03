Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A270C1770AF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCCIEQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 03:04:16 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:48760 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgCCIEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 03:04:15 -0500
X-AuditID: c0a8fbf4-473ff70000004419-ca-5e5e0f7e1834
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 57.74.17433.E7F0E5E5; Tue,  3 Mar 2020 09:04:14 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Tue, 3 Mar 2020 09:04:09 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
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
Thread-Index: AQHV58CCun7qdt/zDkaUtOc73neHtagqMwKAgAE06ACAAJmVgIAKguIA
Date:   Tue, 3 Mar 2020 08:04:08 +0000
Message-ID: <13a6781b02f847669d4923b1cbd069d112105070.camel@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <ba2eb2d7363b386136a546a769a6e2d077558094.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <20200224115751.GE6215@sirena.org.uk>
         <d5e63ea6935991d855e2ae12915b3b4614e8f3aa.camel@fi.rohmeurope.com>
         <20200225153309.GE4633@sirena.org.uk>
In-Reply-To: <20200225153309.GE4633@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <994A4A7EC2E7C440AB179A6703ECBB61@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsVyYMXvTbp1/HFxBlsn81lMffiEzWL+kXOs
        Fs2L17NZfLvSwWRxedccNovPvUcYLZZev8hkMWfpCRaLuV+mMlu07j3CbnF6d4kDt8eaeWsY
        PXbOusvusWlVJ5vH/rlr2D0+b5ILYI3itklKLCkLzkzP07dL4M74/W0zS8Ey7orjZ++yNTA2
        cHcxcnJICJhIzLh8k6WLkYtDSOAqo8SGK63sEM5xRonZx78BORwcbAI2El032UEaRAR0Jab+
        WswGUsMs8I5F4k7bQlaQGmEBZ4kdJ+whalwkXu1tYoWw3STWfp/PBmKzCKhI7Hz2DMzmFfCT
        OLr8DBPErt1MElO/TQdbwClgJHH21xomEJtRQFais+EdmM0sIC6x6dl3VoirBSSW7DnPDGGL
        Srx8/A8qriix/fs6FpB7mAU0Jdbv0ododZA4cPkFG4StKDGl+yE7xA2CEidnPmGZwCg2C8mG
        WQjds5B0z0LSPQtJ9wJG1lWMErmJmTnpiSWphnpFqaV6RfkZuUAqOT93EyMkor/sYPx/yPMQ
        IxMH4yFGSQ4mJVHeD/6xcUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeH05o+OEeFMSK6tSi/Jh
        UtIcLErivOoPJ8YKCYDsyk5NLUgtgsnKcHAoSfBy8MXFCQkWpaanVqRl5pQgpJk4OEGGc0mJ
        FKfmpaQWJZaWZMSD0kd8MTCBgKR4gPaa8QC18xYXJOYCRSFaTzFqc0x4OXcRM8eRuUsXMQux
        5OXnpUqJ817mBioVACnNKM2DW/SKUZyDUUmYdyIvUJYHmNrh5rwCWsEEtKLnOchrxSWJCCmp
        BkaTHWuvbvj//6lS9PfNr7rynrKU67vJRoZcSY8TiIw2LuOVasl4M1Px6n37L28dGg/WV4Sn
        dTO8dZE12tBX/qsiqlW75bXuy9ofpx+1fTh4eucDxeQ5Myy3byjO//ijaWr2gjN2h0viSvY2
        RzwUTrizbPqMXWvNjuxl59j1RjvnX7PtTYOVS+SVWIozEg21mIuKEwGLqjrGqgMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gTWFyaywNCg0KT24gVHVlLCAyMDIwLTAyLTI1IGF0IDE1OjMzICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAyNSwgMjAyMCBhdCAwNjoyMzozMUFNICswMDAwLCBW
YWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiANCj4gPiBPbmx5IGNoYW5nZSByZXF1aXJlZCBvbiBp
bmRpdmlkdWFsIHJlZ3VsYXRvciBkcml2ZXJzIHNob3VsZCBiZQ0KPiA+IHJlbmFtaW5nDQo+ID4g
dGhlIHN0cnVjdCByZWd1bGF0b3JfbGluZWFyX3JhbmdlIHRvIGxpbmVhcl9yYW5nZS4gUmVzdCBv
ZiB0aGUNCj4gPiBjaGFuZ2VzDQo+ID4gc2hvdWxkIGJlIGludGVybmFsIHRvIHJlZ3VsYXRvciBm
cmFtZXdvcmssIHJpZ2h0Pw0KPiANCj4gUmlnaHQsIGl0J3MgdGhhdCB0eXBlIHJlcGxhY2VtZW50
IHRoYXQgc2hvdWxkIGJlIGRvbmUgYXRvbWljYWxseS4NCg0KWWVzLiBBbmQgdGhlIHR5cGUgcmVw
bGFjZW1lbnQgaXMgZG9uZSBvbmx5IGluIHRoaXMgcGF0Y2ggd2hlcmUgdGhlDQpzdHJ1Y3QgaXMg
cmVtb3ZlZCBmcm9tIHJlZ3VsYXRvciBkcml2ZXIuaCBoZWFkZXIgLSBhbmQgdGhlIGxpbmVhcl9y
YW5nZQ0KaGVhZGVyIHByb3ZpZGluZyB0aGlzIG5ldyBzdHJ1Y3QgaXMgaW5jbHVkZWQuIFByZXZp
b3VzIHBhdGNoIGRpZCBub3QNCmNoYW5nZSB0aGUgdHlwZSAtIGp1c3QgcmVuYW1lZCB0aGUgc3Ry
dWN0Lg0KDQpBbnl3YXlzLCBJIGRpZCBjb21waWxlIHRlc3QgdGhlIHBhdGNoIHY0IGZvciB0aGVz
ZSBjb21taXRzIGFuZCB0aGVyZQ0Kd2VyZSBubyBwcm9ibGVtcyBpbiByZWd1bGF0b3IgZHJpdmVy
cy4gVGhlIEJENzA1MjggY2hhcmdlciBkcml2ZXIgaGFkDQphbiBpc3N1ZSBhcyB0aGUgbGluZWFy
X3JhbmdlIHN0cnVjdCB3YXMgZHVibGljYXRlZCB0aGVyZSAtIGJ1dCB0aGlzDQpzaG91bGQgYmUg
Zml4ZWQgYnkgdGhlIHY0IHdoZXJlIEkgYWRkZWQgb25lIGV4dHJhIHBhdGNoIGRvaW5nIHJlbmFt
aW5nDQpmb3IgdGhpcyBCRDcwNTI4IGNoYXJnZXIgaW50ZXJuYWwgc3RydWN0dXJlLg0KDQpCZXN0
IFJlZ2FyZHMNCglNYXR0aSBWYWl0dGluZW4NCg==

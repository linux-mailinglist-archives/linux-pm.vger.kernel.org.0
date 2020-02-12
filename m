Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB96615A16D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgBLG4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 01:56:51 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:50436 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgBLG4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 01:56:51 -0500
X-AuditID: c0a8fbf4-279ff70000001e6c-95-5e43a1b1bc91
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 30.5F.07788.1B1A34E5; Wed, 12 Feb 2020 07:56:49 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Wed, 12 Feb 2020 07:56:38 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Thread-Topic: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Thread-Index: AQHV4At5sLPMospsI0G2S3c08J9KoagWS84AgADGiAA=
Date:   Wed, 12 Feb 2020 06:56:37 +0000
Message-ID: <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20200211190614.GP4543@sirena.org.uk>
In-Reply-To: <20200211190614.GP4543@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1005ABD36C201B4FADF9E58B10F0093B@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsVyYMXvTbobFzrHGUw+ymYx9eETNov5R86x
        Wkz5s5zJ4vKuOWwWn3uPMFosvX6RyWLO0hMsFq17j7BbnN5d4sDpsWbeGkaPnbPusntsWtXJ
        5nHn2h42j8+b5AJYo7htkhJLyoIz0/P07RK4M7pbulgKbqlUfJl1laWB8YFyFyMnh4SAicTq
        BdOYuhi5OIQErjJKfNvQww6SEBI4wSjRddq8i5GDg03ARqLrJlhYREBXYuqvxWwg9cwCk1gk
        Lqz4ywKSEBZwlZj05CozRJGbxMnGi1C2lcTe13/YQGwWAVWJGe+2MYLYvAJ+Ev/PrWKE2HWG
        UeL7KUcQm1PASOL1hc1gvYwCshKdDe+YQGxmAXGJTc++s0IcLSCxZM95ZghbVOLl439QcSWJ
        vT8fsoDczCygKbF+lz5Eq4NE65SFjBC2osSU7ofsECcISpyc+YRlAqPYLCQbZiF0z0LSPQtJ
        9ywk3QsYWVcxSuQmZuakJ5akGuoVpZbqFeVn5AKp5PzcTYyQ2P2yg/H/Ic9DjEwcjIcYJTmY
        lER5X0Y4xwnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4RVvBMrxpiRWVqUW5cOkpDlYlMR51R9O
        jBUSANmVnZpakFoEk5Xh4FCS4GWcD9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIR
        D0oe8cXA9AGS4gHaa7sAZG9xQWIuUBSi9RSjOceEl3MXMXOcXLUESG6euxRIHgGRQix5+Xmp
        UuK8q0DaBEDaMkrz4Ja+YhTnYFQS5p0DkuUBJne4ma+A1jEBrbtu4gCyriQRISXVwKiVUpUS
        6z/hlJFJxMPqtfEv1XOjV9uVbogJt9Vu1tj2VrTvqkWUoPdDg4k6ydPFzBZd9HJu8Dw732xZ
        oTfnzUWLMlfetPqS7C8lucZ991S5o+ITl8o3XIjgCMqwt/RZCUwyEYWHr8+13Xkmo7jwm+TZ
        z4XHtPr2W+ycFmJwWftfdbqHSWm4EktxRqKhFnNRcSIAg8lG9asDAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TW9ybmluZyBNYXJrLA0KDQpPbiBUdWUsIDIwMjAtMDItMTEgYXQgMTk6MDYgKzAwMDAsIE1hcmsg
QnJvd24gd3JvdGU6DQo+IE9uIE1vbiwgRmViIDEwLCAyMDIwIGF0IDAyOjEzOjEzUE0gKzAyMDAs
IE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gDQo+ID4gUHJvdmlkZSBhIGxpbmVhcl9yYW5nZSBo
ZWxwZXIgd2hpY2ggY2FuIGRvIGNvbnZlcnNpb24gZnJvbSB1c2VyDQo+ID4gdmFsdWUNCj4gPiB0
byByZWdpc3RlciB2YWx1ZSAnc2VsZWN0b3InLg0KPiA+IE1hcmssIHRoaXMgaXMgbG9vc2VseSBi
b3VuZCB0byByZWdpc3RlciBoYW5kbGluZy4uLiBEbyB5b3UgdGhpbmsNCj4gPiB0aGUgcmVnbWFw
IGNvdWxkIGhvc3QgdGhlc2UgaGVscGVycz8NCj4gDQo+IFRoZXJlJ3Mgbm8gcmVhbCB0aWUgdG8g
cmVnbWFwIGhlcmUsIHNvbWV0aGluZyBsaWtlIHRoaXMgY291bGQgcXVpdGUNCj4gaGFwcGlseSBi
ZSB1c2VkIGJ5IG1lbW9yeSBtYXBwZWQgZGV2aWNlcyB3aGVyZSByZWdtYXAgaGFzIGxpbWl0ZWQN
Cj4gdXNlcw0KPiBhbmQgd291bGQgYmUgYSBsb3QgdG8gcHVsbCBpbi4gIEEgc2VwYXJhdGUgbGli
cmFyeSB3b3VsZCBwcm9iYWJseQ0KPiBtYWtlDQo+IG1vcmUgc2Vuc2UuDQoNClVnaC4gSSBrbm93
IHlvdSBhcmUgcmlnaHQuIEkgY2FuIGFkbWl0IHRoYXQgSSBqdXN0IHNhdyBpdCBlYXNpZXIgdG8g
Z2V0DQp0aGlzIGluY2x1ZGVkIGluIHNvbWV0aGluZyB0aGF0IGlzIGFscmVhZHkgZXhpc3Rpbmcg
KGJlc2lkZXMsIEkgaGF2ZQ0KZm91bmQgY28tb3BlcmF0aW5nIHdpdGggdGhlIHJlZ21hcC9yZWd1
bGF0b3IgbWFpbnRhaW5lciBwcmV0dHkNCnN0cmFpZ2h0Zm9yd2FyZCAtIHRoZXJlIGhhcyBiZWVu
IG5vIGV4dHJhIGhhc3NsZSByZXF1aXJlZCB0byBnZXQgdGhpbmdzDQpkb25lLCBqdXN0IHRoZSBu
ZWNlc3NhcnkgZml4ZXMpLiBJJ20gYSBiaXQgYWZyYWlkIHRoYXQgYWRkaW5nIGEgbmV3DQpwaWVj
ZSBvZiBsaWJyYXJ5IGp1c3QgZm9yIHRoaXMgbWlnaHQgcmVxdWlyZSBhIGxvdCBtb3JlIHNvY2lh
bA0KaW5mbHVlbmNpbmcgXl9eOyBCdXQgeW91IGFyZSBjb3JyZWN0LiBEZXZpY2VzIHdpdGggdGhp
cyBraW5kIG9mDQpyZWdpc3RlcnMgY2FuIGVhc2lseSBiZSBjb25uZWN0ZWQgdG8gbWVtb3J5IG1h
cHBlZCBidXMuDQoNCj4gTm90IHN1cmUgaG93IG1hbnkgdXNlcnMgdGhlcmUgd291bGQgYmUgb3V0
c2lkZSBvZiBwb3dlcg0KPiByZWxhdGVkIHN0dWZmLCBJIGRvbid0IHJlY2FsbCBzZWVpbmcgdGhl
IHBhdHRlcm4gZWxzZXdoZXJlLg0KDQpJIHRoaW5rIHRoZXJlIG11c3QgYmUgb3RoZXIgc3R1ZmYg
dG9vLiBCdW5jaCBvZiBOQ09zIChudW1lcmljDQpjb250cm9sbGVyIG9zY2lsbGF0b3JzKSBmcm9t
IG15IGNsb2NrL3N5bmNocm9uaXphdGlvbiByZWxhdGVkIGNhcmVlcg0KY29tZXMgdG8gbWluZCBm
aXJzdC4gQUZBSVIgdGhleSBoYWQgbGluZWFyIGZyZXF1ZW5jeSByZXNwb25zZS4gSW4NCmNvbXBh
cmlzb24gdHVuaW5nIGNsb2NrIHdpdGggREFDIHZvbHRhZ2Ugd2FzIG5vdCBsaW5hciAtIGFsdGhv
dWdoDQp2b2x0YWdlIGNoYW5nZSB3YXMgbGluZWFyIDopIEJ1dCBJIHdvdWxkIGV4cGVjdCB0aGF0
IHRoZXJlIGlzIGJ1bmNoIG9mDQp0aGluZ3MgKGFsdGhvdWdoIEkgY2FuIG5vdCBndWFyYW50ZWUg
aXQpLg0KDQo+IE5vdGUgYWxzbyB0aGF0IHdlIGFscmVhZHkgaGF2ZSBxdWl0ZSBleHRlbnNpdmUg
aGVscGVycyBmb3IgdGhpcyBzb3J0DQo+IG9mDQo+IHN0dWZmIGluIHRoZSByZWd1bGF0b3IgQVBJ
IHdoaWNoIEkgc2Vuc2UgbWF5IGhhdmUgYmVlbiBpbnZvbHZlZCBpbg0KPiB0aGlzDQo+IGltcGxl
bWVudGF0aW9uDQoNCllvdSBzZW5zZSB3ZWxsIHhEDQoNClRoaXMgaGFzIGJlZW4gaW5zcGlyZWQg
YnkgUkVHVUxBVE9SX0xJTkVBUl9SQU5HRVMgaW4gcmVndWxhdG9yDQpmcmFtZXdvcmsuIEkgdGhv
dWdodCBJIGRpZCB3cml0ZSB0aGF0IHRvIHNvbWV3aGVyZSBzbyB0aGF0IHRoZSBjcmVkaXRzDQp3
b3VsZCBnbyB0byByZWd1bGF0b3IgY29kZSA6KSBCdXQgbWF5YmUgSSBkaWQgb25seSB3cml0ZSB0
aGF0IHdoZW4gSQ0KZmlyc3QgaW50cm9kdWNlZCB0aGlzIGNvZGUgdG8gQkQ3MDUyOCBwb3dlci1z
dXBwbHkgY29kZS4NCg0KSSB0aG91Z2h0IHRoYXQgd2Ugc2hvdWxkIGFkZCBnZW5lcmljIGhlbHBl
cnMgYW5kIHRoYXQgdGhlIHJlZ3VsYXRvcg0KZnJhbWV3b3JrIGNvdWxkIHN3aXRjaCB0byB1c2Ug
dGhlbSBpbnRlcm5hbGx5IGlmIGl0IHNlZW1lZCBsaWtlIGEgZ29vZA0KaWRlYS4NCg0KQnV0IGFu
b3RoZXIgb3B0aW9uIC0gd2hpY2ggSSB0aG91Z2h0IG9ubHkgbm93IC0gd291bGQgYmUgdG8gc2Vl
IGlmDQpjdXJyZW50IHJlZ3VsYXRvciBpbXBsZW1lbnRhdGlvbiBjb3VsZCBiZSByZS1uYW1lZCB0
byBtb3JlIGdlbmVyaWMgYW5kDQpwbGFjZWQgdW5kZXIgc29tZSBtb3JlIGdlbmVyaWMgY29tcG9u
ZW50IChJIHRob3VnaHQgb2YgcmVnbWFwIGJ1dCBhcw0KeW91IHBvaW50ZWQgb3V0IHRoaXMgaXMg
ZXF1YWxseSB1c2VmdWxsIGZvciBkZXZpY2VzIGNvbm5lY3RlZCB0byBtZW1vcnkNCm1hcHBlZCBi
dXNlcyAtIHNvIG1heWJlIHVuZGVyIGxpYiAtIGlmIHN0YXRpYyBpbmxpbmUgZnVuY3Rpb25zIGlu
IGENCmhlYWRlciBhcmUgbm90IGEgZ29vZCBvcHRpb24pLiBJIGp1c3QgaGF2ZSBhIGZlZWxpbmcg
dGhhdCB0aGUgbGluZWFyLQ0KcmFuZ2VzIGlzIGN1cnJlbnRseSBraW5kIG9mIGVtYmVkZGVkIGlu
IHRoZSBjb2RlIHdoaWNoIGlzIGludGVybmFsIHRvDQpyZWd1bGF0b3IgZnJhbWV3b3JrIHNvIGl0
IGlzIHByb2JhYmx5IG5vdCBlYXNpbHkgZXh0cmFjdGVkIGZyb20NCnJlZ3VsYXRvciBjb2RlPw0K
DQo+ICBhbmQgdG8gYW4gZXh0ZW50IGluIEFMU0Egd2hpY2ggdGFrZXMgYSBkaWZmZXJlbnQgYXBw
cm9hY2gNCj4gd2l0aCBUTFZzIHNpbmNlIGl0IGJha2VkIHNlbGVjdG9ycyBkaXJlY3RseSBpbnRv
IHRoZSBBQkkuDQoNCkkndmUgbmV2ZXIgcGxheWVkIHdpdGggYW55IG1lZGlhIHN1YnN5c3RlbXMu
IFNvdW5kLCBjYW1lcmEgYW5kIHZpZGVvDQphcmUgY29tcGxldGVseSB1bmtub3duIHRvIG1lIDov
DQoNClNvIGlmIHdlIGRvIG5vdCBzdGFydCBwdWxsaW5nIHRoZSByYW5nZSBjb2RlIG91dCBvZiBy
ZWd1bGF0b3IgZnJhbWV3b3JrDQooZm9yIG5vdyBhdCBsZWFzdCkgLSBhbmQgaWYgd2UgZG8gbm90
IHBsYWNlIHRoaXMgdW5kZXIgcmVnbWFwIC0gdGhlbiBJDQpjYW4gZHJvcCB5b3Ugb3V0IG9mIHRo
ZSByZWNpcGllbnQgbGlzdCBmb3IgdGhpcyBjaGFyZ2VyIGRyaXZlciBpbiBvcmRlcg0KdG8gbm90
IHBvbGx1dGUgeW91ciBpbmJveCA7KSBIb3cgZG8geW91IGZlZWwgTWFyaywgZG8geW91IHdhbnQg
dG8gYmUNCmZvbGxvd2luZyB0aGlzIHNlcmllcz8NCg0KQmVzdCBSZWdhcmRzLA0KCU1hdHRpIFZh
aXR0aW5lbg0KDQo=

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2914F1CB785
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHSm3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 14:42:29 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:50642 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHSm2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 14:42:28 -0400
X-AuditID: c0a8fbf4-473ff70000004419-47-5eb5a8139f75
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id F6.55.17433.318A5BE5; Fri,  8 May 2020 20:42:27 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Fri, 8 May 2020 20:42:26 +0200
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
Thread-Index: AQHWJU8mRcNXc963mUOdUoB6SvCrNaieTQ+AgAAXoIA=
Date:   Fri, 8 May 2020 18:42:25 +0000
Message-ID: <a34578a06c991119519e53b0cf87f438fffcc808.camel@fi.rohmeurope.com>
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
Content-ID: <1958FFA8F02F1042A080BADFA512F3E6@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsVyYMXvTbrCK7bGGayfLWRx8cZkZoupD5+w
        WXy70sFkcXnXHDaLz71HGC3mLD3BYnF6d4kDu8fOWXfZPRZsKvXYtKqTzePzJrkAlihum6TE
        krLgzPQ8fbsE7oynh36yFRzgrLhxvYOtgXEBZxcjJ4eEgInE8Q2b2LsYuTiEBK4xSiy59pEN
        wjnOKDHz9VmWLkYODjYBG4mum+wgDSICuhJTfy0Gq2EWOMAk0bx1KRtIQlggWmLK4QuMEEUx
        EqunNjKC9IoIWEmcemEEEmYRUJF4/PUoM4jNK+An8WnmXhYQW0jgDKNE894SEJtTwEhizvfF
        rCA2o4CsRGfDOyYQm1lAXGLTs++sEEcLSCzZc54ZwhaVePn4H1RcUWL793VgJzMLaEqs36UP
        0eogcXfSQUYIW1FiSvdDdogTBCVOznzCMoFRbBaSDbMQumch6Z6FpHsWku4FjKyrGCVyEzNz
        0hNLUg31ilJL9YryM3KBVHJ+7iZGSGx+2cH4/5DnIUYmDsZDjJIcTEqivEGTt8YJ8SXlp1Rm
        JBZnxBeV5qQWH2KU4GBWEuGdWLElTog3JbGyKrUoHyYlzcGiJM6r/nBirJAAyK7s1NSC1CKY
        rAwHh5IE79FlQEMFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQckjvhiYPkBSPEB7
        VUHaeYsLEnOBohCtpxi1OSa8nLuImePI3KWLmIVY8vLzUqXEeWWWA5UKgJRmlObBLXrFKM7B
        qCTMywCS5QEmabg5r4BWMAGt+PxpE8iKkkSElFQDo3Ody+o6/6sn1Y5cNRBavmX6Jt6iq+Hy
        SdH3TRgagzsiHTb3Tr0QKdWeGxep3mPrfafTs/HKpNA/7YdnP+tPuvnjV+XEy5OLrn/a+dSE
        h3fpyQJd5Y1zq/ON+M5aGu66EZbRuFXUr04pMeOXVkpc1Tuf92zyNzNelUesfOaUezXF8drT
        Ln45JZbijERDLeai4kQAuefDho8DAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIE1hcmshDQoNCk9uIEZyaSwgMjAyMC0wNS0wOCBhdCAxODoxNyArMDEwMCwgTWFyayBC
cm93biB3cm90ZToNCj4gT24gRnJpLCBNYXkgMDgsIDIwMjAgYXQgMDY6NDA6NDNQTSArMDMwMCwg
TWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ICAgICBBZGQgYSBLVW5pdCB0ZXN0IGZvciB0aGUg
bGluZWFyX3JhbmdlcyBoZWxwZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFp
dHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEJyZW5kYW4gSGlnZ2lucyA8YnJlbmRhbmhpZ2dpbnNAZ29vZ2xlLmNvbT4NCj4gDQo+IFRo
aXMgbm93IGdlbmVyYXRlczoNCj4gDQo+IFdBUk5JTkc6IG1vZHBvc3Q6IG1pc3NpbmcgTU9EVUxF
X0xJQ0VOU0UoKSBpbiBsaWIvbGluZWFyX3Jhbmdlcy5vDQo+IHNlZSBpbmNsdWRlL2xpbnV4L21v
ZHVsZS5oIGZvciBtb3JlIGluZm9ybWF0aW9uDQo+IA0KPiB3aGVuIHRoZSB0ZXN0cyBhcmUgYnVp
bHQgYXMgYSBtb2R1bGUgYW5kIHNlbGVjdCB0aGUgbGlicmFyeS4NCg0KSSdtIHNvcnJ5LiBJIGRp
ZCBidWlsZCBhbGxtb2Rjb25maWcgYnVpbGQgYnV0IG1pc3NlZCB0aGUgd2FybmluZyA6LyBJDQpz
YXcgeW91IGFwcGxpZWQgMS01LiBEbyB5b3Ugd2FudCBhIHNpbmdsZSBpbmNyZW1lbnRhbCBwYXRj
aCB3aXRoDQpNT0RVTEVfTElDRU5TRSgpIG9yIHNob3VsZCBJIHJlc3VibWl0IG9mIHdob2xlIHNl
cmllcz8gR1BMIGlzIHRoZQ0KbGljZW5zZSBJIHdvdWxkIGxpa2UgdG8gdXNlIGZvciBsaW5raW5n
IGFuZCBTUERYIHNob3VsZCBjb3ZlciBtb3JlDQphY2N1cmF0ZSB2ZXJzaW9uIGluZm9ybWF0aW9u
Lg0KDQoNCkJlc3QgUmVnYXJkcw0KCS0tTWF0dGkNCg0K

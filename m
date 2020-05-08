Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3712C1CAE4E
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgEHNIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:08:39 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:45122 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgEHNIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 09:08:38 -0400
X-AuditID: c0a8fbf4-473ff70000004419-83-5eb559d3a558
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 6F.E4.17433.3D955BE5; Fri,  8 May 2020 15:08:35 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Fri, 8 May 2020 15:08:29 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Thread-Topic: [PATCH v11 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Thread-Index: AQHWJDWzYnC7ORyc4E2ZSac9GcVX7qieB1EAgAACQQA=
Date:   Fri, 8 May 2020 13:08:28 +0000
Message-ID: <c24d5f4c9d07ea9b54692a968020147d8cfe8bcb.camel@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
         <7e91212b3990ce503508bc1c83e13dc793b73668.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
         <20200508130022.GI4820@sirena.org.uk>
In-Reply-To: <20200508130022.GI4820@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F435822C72521A4CBEB0B115C32A2757@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRz3uTtvt+nJOWd7mmVtFKb5kmWxSkToi0JIIFFZaaeem6U3ud1E
        +2B+qXQhzMoPDs2wBFGYubR8CVqiVhpKGVKRpLQEJTNdaORbd54v+/T8n+f3Cs+fQJUeXw2R
        y/IMx9J5OlyBuRqXWqNGLrSnHxqvO6avmnDj+oWPZYh+pKsG13sqeoG+puENph/s5hPxpE77
        mCzJ2VSOJ3mcoWfQNL/4TJovTM01sDEJV/yMt8uPFjxQFHVVx5SCZbkVyAlIxcFnsw2IFSgI
        JTUK4JOVtY3LawDHxl7iVkAQOBUPrZ9lokBFRcGqf49wkYNSNxFYXzaMiEAQdRH2fxpAJNIl
        2Lw8tCE4ASsm533FGaP2wfYfrUCcSSoFzt19KpPC3gHo6HuFioCcOgwdU8vrJEDthuWlv9ZN
        UUoNnZOLvlJtCj5+MYxKczCc+r668a6FzxcdmFgapcJhS1eMJE2EMy6XTJq18P6dCZnUIRC+
        rXZjNrDD7pVg31bbvdR2L7XdS/0Q+DYBmE/n5hlonomN5hhLNGcy5gtHlinfCaRP/NMB1nqS
        ewBCgB6wk0B0weTec+3pyoBMU3axkTYbMzhLHmPuAZBAdSqysqgtXUlm08XXGc60CYUQmE5N
        hk1UXlZSYtY1hilguE10F0HoIOlzXjAN5BgDU5STm8dvwwghF80VGpWZYbMZjrbwxgxxPTLM
        wn6IkL+Q2yZ2Is0FdL7wKkkHwEHCNlVbjxK9tQ31qBJjTSyjUZOnAwQqJVKNFnYraBqoCaAL
        IkfFHv7CJm/5TAsRiBDhmXeKETy9DWlKQUXR6kxYVZ2/4YiVybjn4KP45mA256zL052W1Tb4
        O3TNFKWdHW8Kd8Qdt40Xumv+frkR1BhyUnPL3V5oc2FLjp8HDF9dq3PZPvundTlDgf5ZESv6
        vm+dka0JWjquOlJFdX+wJNO1ltQ9/SUlq+5T8o7arsaWzhTFwvurQ3aNDjMb6dgIlDPT/wFx
        c6QThgMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGEgdG9uIGZvciBoZWFkJ3MgdXAgTWFyayENCg0KT24gRnJpLCAyMDIwLTA1LTA4IGF0
IDE0OjAwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBPbiBUaHUsIE1heSAwNywgMjAyMCBh
dCAwOTowNjowOEFNICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gICAgIEFkZCBh
IEtVbml0IHRlc3QgZm9yIHRoZSBsaW5lYXJfcmFuZ2VzIGhlbHBlci4NCj4gDQo+IFRoaXMgZmFp
bHMgdG8gYnVpbGQgYW4geDg2IGFsbG1vZGNvbmZpZzoNCj4gDQo+IEVSUk9SOiBtb2Rwb3N0OiAi
bGluZWFyX3JhbmdlX3ZhbHVlc19pbl9yYW5nZV9hcnJheSINCj4gW2xpYi90ZXN0X2xpbmVhcl9y
YW5nZXMua29dIHVuZGVmaW5lZCENCj4gRVJST1I6IG1vZHBvc3Q6ICJsaW5lYXJfcmFuZ2VfZ2V0
X3NlbGVjdG9yX2hpZ2giDQo+IFtsaWIvdGVzdF9saW5lYXJfcmFuZ2VzLmtvXSB1bmRlZmluZWQh
DQo+IEVSUk9SOiBtb2Rwb3N0OiAibGluZWFyX3JhbmdlX2dldF9zZWxlY3Rvcl9sb3dfYXJyYXki
DQo+IFtsaWIvdGVzdF9saW5lYXJfcmFuZ2VzLmtvXSB1bmRlZmluZWQhDQo+IEVSUk9SOiBtb2Rw
b3N0OiAibGluZWFyX3JhbmdlX2dldF92YWx1ZV9hcnJheSINCj4gW2xpYi90ZXN0X2xpbmVhcl9y
YW5nZXMua29dIHVuZGVmaW5lZCENCj4gbWFrZVsyXTogKioqIFsvbW50L2tlcm5lbC9zY3JpcHRz
L01ha2VmaWxlLm1vZHBvc3Q6OTQ6IF9fbW9kcG9zdF0NCj4gRXJyb3IgMQ0KPiBtYWtlWzFdOiAq
KiogWy9tbnQva2VybmVsL01ha2VmaWxlOjEzMTk6IG1vZHVsZXNdIEVycm9yIDINCj4gbWFrZTog
KioqIFtNYWtlZmlsZToxODA6IHN1Yi1tYWtlXSBFcnJvciAyDQo+IA0KPiBUaGUgdGVzdCBjb2Rl
IG5lZWRzIHRvIHNlbGVjdCB0aGUgbGlicmFyeS4NCg0KSSdsbCBhZGQgdGhlIHNlbGVjdCBMSU5F
QVJfUkFOR0VTIHRvIEtDb25maWcgYW5kIHJlc2VuZC4NCg0KLS1NYXR0aQ0K

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7265E35DABB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbhDMJKS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 05:10:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59574 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244490AbhDMJKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 05:10:17 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-245-8IaK2en1PPGH7IkPhm3eng-1; Tue, 13 Apr 2021 10:09:54 +0100
X-MC-Unique: 8IaK2en1PPGH7IkPhm3eng-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 10:09:53 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 10:09:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'crecklin@redhat.com'" <crecklin@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Simo Sorce <simo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Thread-Topic: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Thread-Index: AQHXL9VCCex4AsP57EiPuHRRJN/3haqyKSig
Date:   Tue, 13 Apr 2021 09:09:53 +0000
Message-ID: <493d2c11820a4fc8b66db381fc4e7904@AcuMS.aculab.com>
References: <20210412140932.31162-1-crecklin@redhat.com>
 <YHSHPIXLhHjOu0jw@gmail.com>
 <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com>
 <YHSdgV6LIqSVxk+i@gmail.com>
 <CAMj1kXGZt8+5MVG-mNi67KsG8=4HCqEPs+RkrtzHusmCPFqSTg@mail.gmail.com>
 <862c8208-5809-9726-7e22-7a16fcd30edd@redhat.com>
In-Reply-To: <862c8208-5809-9726-7e22-7a16fcd30edd@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogQ2hyaXMgdm9uIFJlY2tsaW5naGF1c2VuDQo+IFNlbnQ6IDEyIEFwcmlsIDIwMjEgMjA6
NTENCi4uLg0KPiA+IFRoaXMgaXMgbm90IGFib3V0IEJJT1MgYnVncy4gSGliZXJuYXRpb24gaXMg
ZGVlcCBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGdyYWZ0ZWQgb250byBjb2xkIGJvb3QsIGFuZCBpdCBp
cyBwZXJmZWN0bHkgbGVnYWwgZm9yIHRoZSBmaXJtd2FyZSB0bw0KPiA+IHByZXNlbnQgYSBkaWZm
ZXJlbnQgbWVtb3J5IG1hcCB0byB0aGUgT1MgYWZ0ZXIgYSBjb2xkIGJvb3QuIEl0IGlzDQo+ID4g
TGludXggdGhhdCBkZWNpZGVzIHRoYXQgaXQgY2FuIHJlc3RvcmUgdGhlIGVudGlyZSBzeXN0ZW0g
c3RhdGUgZnJvbSBhDQo+ID4gc3dhcCBmaWxlLCBhbmQgY2Fycnkgb24gYXMgaWYgdGhlIGNvbGQg
Ym9vdCB3YXMganVzdCBhIFtmaXJtd2FyZQ0KPiA+IGFzc2lzdGVkXSBzdXNwZW5kL3Jlc3VtZS4N
Cj4gPg0KPiA+IFNvIGZvcmdpbmcgY29sbGlzaW9ucyBpcyAqbm90KiBhIGNvbmNlcm4gaGVyZS4g
TGV0J3MgYXZvaWQgYWNjaWRlbnRhbA0KPiA+IG9yIG1hbGljaW91cywgYXMgdGhvc2UgYWRqZWN0
aXZlcyBzZWVtIHRvIGNvbmZ1c2Ugc29tZSBwZW9wbGUuIFRoZQ0KPiA+IGJvdHRvbSBsaW5lIGlz
IHRoYXQgdGhlcmUgaXMgbm8gbmVlZCB0byBwcm90ZWN0IGFnYWluc3QgZGVsaWJlcmF0ZQ0KPiA+
IGF0dGVtcHRzIHRvIGhpZGUgdGhlIGZhY3QgdGhhdCB0aGUgbWVtb3J5IG1hcCBoYXMgY2hhbmdl
ZCwgYW5kIHNvDQo+ID4gdGhlcmUgaXMgbm8gcmVhc29uIHRvIHVzZSBjcnlwdG9ncmFwaGljIGhh
c2hlcyBoZXJlLg0KPiA+DQo+IEhvdyBhYm91dCA6DQo+IA0KPiBUaGUgY2hlY2sgaXMgaW50ZW5k
ZWQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIGEgcmVzdW1lICh3aGljaCBleHBlY3RzDQo+IGFu
IGlkZW50aWNhbCBlODIwIG1hcCB0byB0aGUgb25lIHNhdmVkIGluIHN1c3BlbmQpLCBhbmQgYSBj
b2xkIGJvb3QNCj4gKHdoaWNoIG5lZWQgbm90IGhhdmUgYW4gaWRlbnRpY2FsIGU4MjAgbWFwIHRv
IHRoYXQgc2F2ZWQgaW4gc3VzcGVuZCBpZg0KPiBhbnkgd2FzIGRvbmUgYXQgYWxsKS4gSXQgaXMg
bm90IG5lY2Vzc2FyeSBoZXJlIHRvIHByb3RlY3QgYWdhaW5zdA0KPiBkZWxpYmVyYXRlIGF0dGVt
cHRzIHRvIGhpZGUgdGhlIGZhY3QgdGhhdCB0aGUgbWVtb3J5IG1hcCBoYXMgY2hhbmdlZCwgc28N
Cj4gY3JjMzIgaXMgc3VmZmljaWVudCBmb3IgZGV0ZWN0aW9uLg0KDQpUaGF0IHNvcnQgb2YgaW1w
bGllcyB0aGF0IHRoZSAncmVzdW1lJyBhbmQgJ2NvbGQgYm9vdCcgYXJlDQpkaWZmZXJlbmNpYXRl
ZC4NCg0KQnV0IHRoZSBwcmV2aW91cyBjb21tZW50IHJhdGhlciBpbXBsaWVzIHRoYXQgaXQgaXMg
dGhlIHByZXNlbmNlDQpvZiBhIHZhbGlkIHNhdmVkIGltYWdlIHRoYXQgc2lnbmlmaWVzIGEgJ3Jl
c3VtZScuDQoNCkFuIGludGVyZXN0aW5nIGZhaWx1cmUgY2FzZSB3b3VsZCBiZSBtb3ZpbmcgdGhl
IGRpc2sgdG8gYQ0KZGlmZmVyZW50IHN5c3RlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


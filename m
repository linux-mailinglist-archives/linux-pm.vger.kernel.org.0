Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31842138AC
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGCKeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 06:34:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:52110 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCKeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 06:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593772460; x=1625308460;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=0Srq/iAR2iUQqpMVoPKme0CNYFUMN01gXdDZzTE2rCY=;
  b=n6S/0W6UNArFppp8bKR/324Oj1pszr7zSRRxD6M8/OpbVte/vT3N0U0c
   qj91vv0X9Iu15XUqqrFYNSbWWyg4l5xPh6taav+y/G0NUza6hC5jK2Iy9
   3uZd9ZrcxYF9tZ7DrPGrauuRFSMZ7PTnlNZO53i+s7WIxjP0rvc09Viuu
   I=;
IronPort-SDR: 2D1/tumB/7HHcZMwmN9toje8ocRF3zmcHHfNR6lLlpGTltLjmYMmsfvn/toPxerHzhWDnrHjwg
 cnXZtx9OTyXA==
X-IronPort-AV: E=Sophos;i="5.75,308,1589241600"; 
   d="scan'208";a="48880569"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Jul 2020 10:34:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id D8030A22EB;
        Fri,  3 Jul 2020 10:34:10 +0000 (UTC)
Received: from EX13D21EUA001.ant.amazon.com (10.43.165.41) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 3 Jul 2020 10:34:10 +0000
Received: from EX13D08EUB004.ant.amazon.com (10.43.166.158) by
 EX13D21EUA001.ant.amazon.com (10.43.165.41) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 3 Jul 2020 10:34:09 +0000
Received: from EX13D08EUB004.ant.amazon.com ([10.43.166.158]) by
 EX13D08EUB004.ant.amazon.com ([10.43.166.158]) with mapi id 15.00.1497.006;
 Fri, 3 Jul 2020 10:34:09 +0000
From:   "Catangiu, Adrian Costin" <acatan@amazon.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Thread-Topic: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Thread-Index: AQHWUSV8Vj3J0uAeZ0SEXb0Kg2s1Gw==
Date:   Fri, 3 Jul 2020 10:34:09 +0000
Message-ID: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.155]
Content-Type: text/plain; charset="utf-8"
Content-ID: <45074E3E0876EC46B53EBC2D2DB37D48@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Q3J5cHRvZ3JhcGhpYyBsaWJyYXJpZXMgY2FycnkgcHNldWRvIHJhbmRvbSBudW1iZXIgZ2VuZXJh
dG9ycyB0bw0KcXVpY2tseSBwcm92aWRlIHJhbmRvbW5lc3Mgd2hlbiBuZWVkZWQuIElmIHN1Y2gg
YSByYW5kb20gcG9vbCBnZXRzDQpjbG9uZWQsIHNlY3JldHMgbWF5IGdldCByZXZlYWxlZCwgYXMg
dGhlIHNhbWUgcmFuZG9tIG51bWJlciBtYXkgZ2V0DQp1c2VkIG11bHRpcGxlIHRpbWVzLiBGb3Ig
Zm9yaywgdGhpcyB3YXMgZml4ZWQgdXNpbmcgdGhlIFdJUEVPTkZPUksNCm1hZHZpc2UgZmxhZyBb
MV0uDQoNClVuZm9ydHVuYXRlbHksIHRoZSBzYW1lIHByb2JsZW0gc3VyZmFjZXMgd2hlbiBhIHZp
cnR1YWwgbWFjaGluZSBnZXRzDQpjbG9uZWQuIFRoZSBleGlzdGluZyBmbGFnIGRvZXMgbm90IGhl
bHAgdGhlcmUuIFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhDQpuZXcgZmxhZyB0byBhdXRvbWF0aWNh
bGx5IGNsZWFyIG1lbW9yeSBjb250ZW50cyBvbiBWTSBzdXNwZW5kL3Jlc3VtZSwNCndoaWNoIHdp
bGwgYWxsb3cgcmFuZG9tIG51bWJlciBnZW5lcmF0b3JzIHRvIHJlc2VlZCB3aGVuIHZpcnR1YWwN
Cm1hY2hpbmVzIGdldCBjbG9uZWQuDQoNCkV4YW1wbGVzIG9mIHRoaXMgYXJlOg0KIC0gUEtDUyMx
MSBBUEkgcmVpbml0aWFsaXphdGlvbiBjaGVjayAobWFuZGF0ZWQgYnkgc3BlY2lmaWNhdGlvbikN
CiAtIGdsaWJjJ3MgdXBjb21pbmcgUFJORyAocmVzZWVkIGFmdGVyIHdha2UpDQogLSBPcGVuU1NM
IFBSTkcgKHJlc2VlZCBhZnRlciB3YWtlKQ0KDQpCZW5lZml0cyBleGlzdCBpbiB0d28gc3BhY2Vz
Og0KIC0gVGhlIHNlY3VyaXR5IGJlbmVmaXRzIG9mIGEgY2xvbmVkIHZpcnR1YWwgbWFjaGluZSBo
YXZpbmcgYQ0KICAgcmUtaW5pdGlhbGl6ZWQgUFJORyBpbiBldmVyeSBwcm9jZXNzIGFyZSBzdHJh
aWdodGZvcndhcmQuDQogICBXaXRob3V0IHJlaW5pdGlhbGl6YXRpb24sIHR3byBvciBtb3JlIGNs
b25lZCBWTXMgY291bGQgcHJvZHVjZQ0KICAgaWRlbnRpY2FsIHJhbmRvbSBudW1iZXJzLCB3aGlj
aCBhcmUgb2Z0ZW4gdXNlZCB0byBnZW5lcmF0ZSBzZWN1cmUNCiAgIGtleXMuDQogLSBQcm92aWRl
cyBhIHNpbXBsZSBtZWNoYW5pc20gdG8gYXZvaWQgUkFNIGV4ZmlsdHJhdGlvbiBkdXJpbmcNCiAg
IHRyYWRpdGlvbmFsIHNsZWVwL2hpYmVybmF0ZSBvbiBhIGxhcHRvcCBvciBkZXNrdG9wIHdoZW4g
bWVtb3J5LA0KICAgYW5kIHRodXMgc2VjcmV0cywgYXJlIHZ1bG5lcmFibGUgdG8gb2ZmbGluZSB0
YW1wZXJpbmcgb3IgaW5zcGVjdGlvbi4NCg0KVGhpcyBSRkMgaXMgZm9yZW1vc3QgYWltZWQgYXQg
ZGVmaW5pbmcgYSB1c2Vyc3BhY2UgaW50ZXJmYWNlIHRvIGVuYWJsZQ0KYXBwbGljYXRpb25zIGFu
ZCBsaWJyYXJpZXMgdGhhdCBzdG9yZSBvciBjYWNoZSBzZW5zaXRpdmUgaW5mb3JtYXRpb24sDQp0
byBrbm93IHRoYXQgdGhleSBuZWVkIHRvIHJlZ2VuZXJhdGUgaXQgYWZ0ZXIgcHJvY2VzcyBtZW1v
cnkgaGFzIGJlZW4NCmV4cG9zZWQgdG8gcG90ZW50aWFsIGNvcHlpbmcuICBUaGUgcHJvcG9zZWQg
dXNlcnNwYWNlIGludGVyZmFjZSBpcw0KYSBuZXcgTUFEVl9XSVBFT05TVVNQRU5EICdtYWR2aXNl
KCknIGZsYWcgdXNlZCB0byBtYXJrIHBhZ2VzIHdoaWNoDQpjb250YWluIHN1Y2ggZGF0YS4gVGhp
cyBuZXdseSBhZGRlZCBmbGFnIHdvdWxkIG9ubHkgYmUgYXZhaWxhYmxlIG9uDQo2NGJpdCBhcmNo
cywgc2luY2Ugd2UndmUgcnVuIG91dCBvZiAzMmJpdCBWTUEgZmxhZ3MuDQoNClRoZSBtZWNoYW5p
c20gdGhyb3VnaCB3aGljaCB0aGUga2VybmVsIG1hcmtzIHRoZSBhcHBsaWNhdGlvbiBzZW5zaXRp
dmUNCmRhdGEgYXMgcG90ZW50aWFsbHkgY29waWVkLCBpcyBhIHNlY29uZGFyeSBvYmplY3RpdmUg
b2YgdGhpcyBSRkMuIEluDQp0aGUgY3VycmVudCBQb0MgcHJvcG9zYWwsIHRoZSBSRkMga2VybmVs
IGNvZGUgY29tYmluZXMNCk1BRFZfV0lQRU9OU1VTUEVORCBzZW1hbnRpY3Mgd2l0aCBBQ1BJIHN1
c3BlbmQvd2FrZSB0cmFuc2l0aW9ucyB0byB6ZXJvDQpvdXQgYWxsIHByb2Nlc3MgcGFnZXMgdGhh
dCBmYWxsIGluIFZNQXMgbWFya2VkIGFzIE1BRFZfV0lQRU9OU1VTUEVORA0KYW5kIHRodXMgYWxs
b3cgYXBwbGljYXRpb25zIGFuZCBsaWJyYXJpZXMgYmUgbm90aWZpZWQgYW5kIHJlZ2VuZXJhdGUN
CnRoZWlyIHNlbnNpdGl2ZSBkYXRhLiAgTWFya2luZyBWTUFzIGFzIE1BRFZfV0lQRU9OU1VTUEVO
RCByZXN1bHRzIGluDQp0aGUgVk1BcyBiZWluZyBlbXB0eSBpbiB0aGUgcHJvY2VzcyBhZnRlciBh
bnkgc3VzcGVuZC93YWtlIGN5Y2xlLg0KU2ltaWxhciB0byBNQURWX1dJUEVPTkZPUkssIGlmIHRo
ZSBwcm9jZXNzIGFjY2Vzc2VzIG1lbW9yeSB0aGF0IHdhcw0Kd2lwZWQgb24gc3VzcGVuZCwgaXQg
d2lsbCBnZXQgemVyb2VzLiAgVGhlIGFkZHJlc3MgcmFuZ2VzIGFyZSBzdGlsbA0KdmFsaWQsIHRo
ZXkgYXJlIGp1c3QgZW1wdHkuDQoNClRoaXMgcGF0Y2ggYWRkcyBsb2dpYyB0byB0aGUga2VybmVs
IHBvd2VyIGNvZGUgdG8gemVybyBvdXQgY29udGVudHMgb2YNCmFsbCBNQURWX1dJUEVPTlNVU1BF
TkQgVk1BcyBwcmVzZW50IGluIHRoZSBzeXN0ZW0gZHVyaW5nIGl0cyB0cmFuc2l0aW9uDQp0byBh
bnkgc3VzcGVuZCBzdGF0ZSBlcXVhbCBvciBncmVhdGVyL2RlZXBlciB0aGFuIFN1c3BlbmQtdG8t
bWVtb3J5LA0Ka25vd24gYXMgUzMuDQoNCk1BRFZfV0lQRU9OU1VTUEVORCBvbmx5IHdvcmtzIG9u
IHByaXZhdGUsIGFub255bW91cyBtYXBwaW5ncy4NClRoZSBwYXRjaCBhbHNvIGFkZHMgTUFEVl9L
RUVQT05TVVNQRU5ELCB0byB1bmRvIHRoZSBlZmZlY3RzIG9mIGENCnByaW9yIE1BRFZfV0lQRU9O
U1VTUEVORCBmb3IgYSBWTUEuDQoNCkh5cGVydmlzb3JzIGNhbiBpc3N1ZSBBQ1BJIFMwLT5TMyBh
bmQgUzMtPlMwIGV2ZW50cyB0byBsZXZlcmFnZSB0aGlzDQpmdW5jdGlvbmFsaXR5IGluIGEgdmly
dHVhbGl6ZWQgZW52aXJvbm1lbnQuDQoNCkFsdGVybmF0aXZlIGtlcm5lbCBpbXBsZW1lbnRhdGlv
biBpZGVhczoNCiAtIE1vdmUgdGhlIGNvZGUgdGhhdCBjbGVhcnMgTUFEVl9XSVBFT05GT1JLIHBh
Z2VzIHRvIGEgdmlydHVhbA0KICAgZGV2aWNlIGRyaXZlciB0aGF0IHJlZ2lzdGVycyBpdHNlbGYg
dG8gQUNQSSBldmVudHMuDQogLSBBZGQgcHJlcmVxdWlzaXRlIHRoYXQgTUFEVl9XSVBFT05GT1JL
IHBhZ2VzIG11c3QgYmUgcGlubmVkIChzbw0KICAgbm8gZmF1bHRpbmcgaGFwcGVucykgYW5kIGNs
ZWFyIHRoZW0gaW4gYSBjdXN0b20vcm9sbC15b3VyLW93bg0KICAgZGV2aWNlIGRyaXZlciBvbiBh
IE5NSSBoYW5kbGVyLiBUaGlzIGNvdWxkIHdvcmsgaW4gYSB2aXJ0dWFsaXplZA0KICAgZW52aXJv
bm1lbnQgd2hlcmUgdGhlIGh5cGVydmlzb3IgcGF1c2VzIGFsbCBvdGhlciB2Q1BVcyBiZWZvcmUN
CiAgIGluamVjdGluZyB0aGUgTk1JLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDE3MDgxMTIxMjgyOS4yOTE4Ni0xLXJpZWxAcmVkaGF0LmNvbS8NCg0KU2lnbmVkLW9mZi1i
eTogQWRyaWFuIENhdGFuZ2l1IDxhY2F0YW5AYW1hem9uLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGlu
dXgvbW0uaCAgICAgICAgICAgICAgICAgICAgIHwgIDIgKw0KIGluY2x1ZGUvdWFwaS9hc20tZ2Vu
ZXJpYy9tbWFuLWNvbW1vbi5oIHwgIDMgKw0KIGtlcm5lbC9wb3dlci9zdXNwZW5kLmMgICAgICAg
ICAgICAgICAgIHwgODIgKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBtbS9tYWR2aXNlLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE3ICsrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwg
MTA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2lu
Y2x1ZGUvbGludXgvbW0uaA0KaW5kZXggMDMzNGNhOTdjNTg0Li45MzllYjgwZmFiYmIgMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KQEAg
LTI5OCwxMSArMjk4LDEzIEBAIGV4dGVybiB1bnNpZ25lZCBpbnQga29ianNpemUoY29uc3Qgdm9p
ZCAqb2JqcCk7DQogI2RlZmluZSBWTV9ISUdIX0FSQ0hfQklUXzIJMzQJLyogYml0IG9ubHkgdXNh
YmxlIG9uIDY0LWJpdCBhcmNoaXRlY3R1cmVzICovDQogI2RlZmluZSBWTV9ISUdIX0FSQ0hfQklU
XzMJMzUJLyogYml0IG9ubHkgdXNhYmxlIG9uIDY0LWJpdCBhcmNoaXRlY3R1cmVzICovDQogI2Rl
ZmluZSBWTV9ISUdIX0FSQ0hfQklUXzQJMzYJLyogYml0IG9ubHkgdXNhYmxlIG9uIDY0LWJpdCBh
cmNoaXRlY3R1cmVzICovDQorI2RlZmluZSBWTV9ISUdIX0FSQ0hfQklUXzUJMzcJLyogYml0IG9u
bHkgdXNhYmxlIG9uIDY0LWJpdCBhcmNoaXRlY3R1cmVzICovDQogI2RlZmluZSBWTV9ISUdIX0FS
Q0hfMAlCSVQoVk1fSElHSF9BUkNIX0JJVF8wKQ0KICNkZWZpbmUgVk1fSElHSF9BUkNIXzEJQklU
KFZNX0hJR0hfQVJDSF9CSVRfMSkNCiAjZGVmaW5lIFZNX0hJR0hfQVJDSF8yCUJJVChWTV9ISUdI
X0FSQ0hfQklUXzIpDQogI2RlZmluZSBWTV9ISUdIX0FSQ0hfMwlCSVQoVk1fSElHSF9BUkNIX0JJ
VF8zKQ0KICNkZWZpbmUgVk1fSElHSF9BUkNIXzQJQklUKFZNX0hJR0hfQVJDSF9CSVRfNCkNCisj
ZGVmaW5lIFZNX1dJUEVPTlNVU1BFTkQJQklUKFZNX0hJR0hfQVJDSF9CSVRfNSkNCiAjZW5kaWYg
LyogQ09ORklHX0FSQ0hfVVNFU19ISUdIX1ZNQV9GTEFHUyAqLw0KIA0KICNpZmRlZiBDT05GSUdf
QVJDSF9IQVNfUEtFWVMNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMvbW1h
bi1jb21tb24uaCBiL2luY2x1ZGUvdWFwaS9hc20tZ2VuZXJpYy9tbWFuLWNvbW1vbi5oDQppbmRl
eCA2M2IxZjUwNmVhNjcuLmU1MjdkOTA5MDg0MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvdWFwaS9h
c20tZ2VuZXJpYy9tbWFuLWNvbW1vbi5oDQorKysgYi9pbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMv
bW1hbi1jb21tb24uaA0KQEAgLTY3LDYgKzY3LDkgQEANCiAjZGVmaW5lIE1BRFZfV0lQRU9ORk9S
SyAxOAkJLyogWmVybyBtZW1vcnkgb24gZm9yaywgY2hpbGQgb25seSAqLw0KICNkZWZpbmUgTUFE
Vl9LRUVQT05GT1JLIDE5CQkvKiBVbmRvIE1BRFZfV0lQRU9ORk9SSyAqLw0KIA0KKyNkZWZpbmUg
TUFEVl9XSVBFT05TVVNQRU5EIDIwCQkvKiBaZXJvIG1lbW9yeSBvbiBzeXN0ZW0gc3VzcGVuZCAq
Lw0KKyNkZWZpbmUgTUFEVl9LRUVQT05TVVNQRU5EIDIxCQkvKiBVbmRvIE1BRFZfV0lQRU9OU1VT
UEVORCAqLw0KKw0KIC8qIGNvbXBhdGliaWxpdHkgZmxhZ3MgKi8NCiAjZGVmaW5lIE1BUF9GSUxF
CTANCiANCmRpZmYgLS1naXQgYS9rZXJuZWwvcG93ZXIvc3VzcGVuZC5jIGIva2VybmVsL3Bvd2Vy
L3N1c3BlbmQuYw0KaW5kZXggYzg3NGE3MDI2ZTI0Li40MjgyYjdmMGRkMDMgMTAwNjQ0DQotLS0g
YS9rZXJuZWwvcG93ZXIvc3VzcGVuZC5jDQorKysgYi9rZXJuZWwvcG93ZXIvc3VzcGVuZC5jDQpA
QCAtMzIzLDYgKzMyMyw3OCBAQCBzdGF0aWMgYm9vbCBwbGF0Zm9ybV9zdXNwZW5kX2FnYWluKHN1
c3BlbmRfc3RhdGVfdCBzdGF0ZSkNCiAJCXN1c3BlbmRfb3BzLT5zdXNwZW5kX2FnYWluKCkgOiBm
YWxzZTsNCiB9DQogDQorI2lmZGVmIFZNX1dJUEVPTlNVU1BFTkQNCitzdGF0aWMgdm9pZCBtZW1v
cnlfY2xlYW51cF9vbl9zdXNwZW5kKHN1c3BlbmRfc3RhdGVfdCBzdGF0ZSkNCit7DQorCXN0cnVj
dCB0YXNrX3N0cnVjdCAqcDsNCisJc3RydWN0IG1tX3N0cnVjdCAqbW07DQorCXN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hOw0KKwlzdHJ1Y3QgcGFnZSAqcGFnZXNbMzJdOw0KKwl1bnNpZ25lZCBs
b25nIG1heF9wYWdlc19wZXJfbG9vcCA9IEFSUkFZX1NJWkUocGFnZXMpOw0KKw0KKwkvKiBPbmx5
IGNhcmUgYWJvdXQgc3RhdGVzID49IFMzICovDQorCWlmIChzdGF0ZSA8IFBNX1NVU1BFTkRfTUVN
KQ0KKwkJcmV0dXJuOw0KKw0KKwlyY3VfcmVhZF9sb2NrKCk7DQorCWZvcl9lYWNoX3Byb2Nlc3Mo
cCkgew0KKwkJaW50IGd1cF9mbGFncyA9IEZPTExfV1JJVEU7DQorDQorCQltbSA9IHAtPm1tOw0K
KwkJaWYgKCFtbSkNCisJCQljb250aW51ZTsNCisNCisJCWRvd25fcmVhZCgmbW0tPm1tYXBfc2Vt
KTsNCisJCWZvciAodm1hID0gbW0tPm1tYXA7IHZtYTsgdm1hID0gdm1hLT52bV9uZXh0KSB7DQor
CQkJdW5zaWduZWQgbG9uZyBhZGRyLCBucl9wYWdlczsNCisNCisJCQlpZiAoISh2bWEtPnZtX2Zs
YWdzICYgVk1fV0lQRU9OU1VTUEVORCkpDQorCQkJCWNvbnRpbnVlOw0KKw0KKwkJCWFkZHIgPSB2
bWEtPnZtX3N0YXJ0Ow0KKwkJCW5yX3BhZ2VzID0gKHZtYS0+dm1fZW5kIC0gYWRkciAtIDEpIC8g
UEFHRV9TSVpFICsgMTsNCisJCQl3aGlsZSAobnJfcGFnZXMpIHsNCisJCQkJaW50IGNvdW50ID0g
bWluKG5yX3BhZ2VzLCBtYXhfcGFnZXNfcGVyX2xvb3ApOw0KKwkJCQl2b2lkICprYWRkcjsNCisN
CisJCQkJY291bnQgPSBnZXRfdXNlcl9wYWdlc19yZW1vdGUocCwgbW0sIGFkZHIsDQorCQkJCQkJ
CWNvdW50LCBndXBfZmxhZ3MsDQorCQkJCQkJCXBhZ2VzLCBOVUxMLCBOVUxMKTsNCisJCQkJaWYg
KGNvdW50IDw9IDApIHsNCisJCQkJCS8qDQorCQkJCQkgKiBGSVhNRTogSW4gdGhpcyBQb0MganVz
dCBicmVhayBpZiB3ZQ0KKwkJCQkJICogZ2V0IGFuIGVycm9yLg0KKwkJCQkJICogSW4gdGhlIGZp
bmFsIGltcGxlbWVudGF0aW9uIHdlIG5lZWQNCisJCQkJCSAqIHRvIGhhbmRsZSB0aGlzIGJldHRl
ciBhbmQgbm90IGxlYXZlDQorCQkJCQkgKiBwYWdlcyB1bmNsZWFyZWQuDQorCQkJCQkgKi8NCisJ
CQkJCWJyZWFrOw0KKwkJCQl9DQorCQkJCS8qIEdvIHRocm91Z2ggcGFnZXMgYnVmZmVyIGFuZCBj
bGVhciB0aGVtLiAqLw0KKwkJCQl3aGlsZSAoY291bnQpIHsNCisJCQkJCXN0cnVjdCBwYWdlICpw
YWdlID0gcGFnZXNbLS1jb3VudF07DQorDQorCQkJCQlrYWRkciA9IGttYXAocGFnZSk7DQorCQkJ
CQljbGVhcl9wYWdlKGthZGRyKTsNCisJCQkJCWt1bm1hcChwYWdlKTsNCisNCisJCQkJCXB1dF9w
YWdlKHBhZ2UpOw0KKwkJCQkJbnJfcGFnZXMtLTsNCisJCQkJCWFkZHIgKz0gUEFHRV9TSVpFOw0K
KwkJCQl9DQorCQkJfQ0KKwkJfQ0KKwkJdXBfcmVhZCgmbW0tPm1tYXBfc2VtKTsNCisJfQ0KKwly
Y3VfcmVhZF91bmxvY2soKTsNCit9DQorI2Vsc2UNCitzdGF0aWMgdm9pZCBtZW1vcnlfY2xlYW51
cF9vbl9zdXNwZW5kKHN1c3BlbmRfc3RhdGVfdCBzdGF0ZSkNCit7DQorCS8qIG5vb3AgKi8NCit9
DQorI2VuZGlmIC8qIFZNX1dJUEVPTlNVU1BFTkQgKi8NCisNCiAjaWZkZWYgQ09ORklHX1BNX0RF
QlVHDQogc3RhdGljIHVuc2lnbmVkIGludCBwbV90ZXN0X2RlbGF5ID0gNTsNCiBtb2R1bGVfcGFy
YW0ocG1fdGVzdF9kZWxheSwgdWludCwgMDY0NCk7DQpAQCAtNDE1LDYgKzQ4NywxNiBAQCBzdGF0
aWMgaW50IHN1c3BlbmRfZW50ZXIoc3VzcGVuZF9zdGF0ZV90IHN0YXRlLCBib29sICp3YWtldXAp
DQogCWlmIChlcnJvcikNCiAJCWdvdG8gRGV2aWNlc19lYXJseV9yZXN1bWU7DQogDQorCS8qDQor
CSAqIEZJWE1FOiBGb3IgdGhpcyBQb0Mgd2UncmUgY2FsbGluZyB0aGlzIGVhcmx5IHRvIGJlIGFi
bGUgdG8NCisJICogZmF1bHQgaW4gcGFnZXMuIEZvciBhIGNvcnJlY3QgaW1wbGVtZW50YXRpb24g
d2UgaGF2ZSB0byBmaW5kIGENCisJICogd2F5IHRvIGRvIGl0IGxhdGVyLCBldmVudHVhbGx5IF9h
ZnRlcl8gZGlzYWJsaW5nIGRldmljZXMgYW5kDQorCSAqIHNlY29uZGFyeSBDUFVzLg0KKwkgKiBP
bmUgaWRlYSBpcyB0byBhZGQgcmVxdWlyZW1lbnQgb2YgaGF2aW5nIHRoZXNlIHBhZ2VzIHBpbm5l
ZA0KKwkgKiBzbyB0aGF0IHdlIGRvbid0IHdvcnJ5IGFib3V0IGZhdWx0aW5nLg0KKwkgKi8NCisJ
bWVtb3J5X2NsZWFudXBfb25fc3VzcGVuZChzdGF0ZSk7DQorDQogCWlmIChzdGF0ZSA9PSBQTV9T
VVNQRU5EX1RPX0lETEUgJiYgcG1fdGVzdF9sZXZlbCAhPSBURVNUX1BMQVRGT1JNKSB7DQogCQlz
MmlkbGVfbG9vcCgpOw0KIAkJZ290byBQbGF0Zm9ybV9lYXJseV9yZXN1bWU7DQpkaWZmIC0tZ2l0
IGEvbW0vbWFkdmlzZS5jIGIvbW0vbWFkdmlzZS5jDQppbmRleCA5NjhkZjNhYTA2OWYuLjI1MGI2
NTI3N2YxMSAxMDA2NDQNCi0tLSBhL21tL21hZHZpc2UuYw0KKysrIGIvbW0vbWFkdmlzZS5jDQpA
QCAtOTIsNiArOTIsMTkgQEAgc3RhdGljIGxvbmcgbWFkdmlzZV9iZWhhdmlvcihzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSwNCiAJY2FzZSBNQURWX0tFRVBPTkZPUks6DQogCQluZXdfZmxhZ3Mg
Jj0gflZNX1dJUEVPTkZPUks7DQogCQlicmVhazsNCisjaWZkZWYgVk1fV0lQRU9OU1VTUEVORA0K
KwljYXNlIE1BRFZfV0lQRU9OU1VTUEVORDoNCisJCS8qIE1BRFZfV0lQRU9OU1VTUEVORCBpcyBv
bmx5IHN1cHBvcnRlZCBvbiBhbm9ueW1vdXMgbWVtb3J5LiAqLw0KKwkJaWYgKHZtYS0+dm1fZmls
ZSB8fCB2bWEtPnZtX2ZsYWdzICYgVk1fU0hBUkVEKSB7DQorCQkJZXJyb3IgPSAtRUlOVkFMOw0K
KwkJCWdvdG8gb3V0Ow0KKwkJfQ0KKwkJbmV3X2ZsYWdzIHw9IFZNX1dJUEVPTlNVU1BFTkQ7DQor
CQlicmVhazsNCisJY2FzZSBNQURWX0tFRVBPTlNVU1BFTkQ6DQorCQluZXdfZmxhZ3MgJj0gflZN
X1dJUEVPTlNVU1BFTkQ7DQorCQlicmVhazsNCisjZW5kaWYNCiAJY2FzZSBNQURWX0RPTlREVU1Q
Og0KIAkJbmV3X2ZsYWdzIHw9IFZNX0RPTlREVU1QOw0KIAkJYnJlYWs7DQpAQCAtNzMxLDYgKzc0
NCwxMCBAQCBtYWR2aXNlX2JlaGF2aW9yX3ZhbGlkKGludCBiZWhhdmlvcikNCiAjaWZkZWYgQ09O
RklHX01FTU9SWV9GQUlMVVJFDQogCWNhc2UgTUFEVl9TT0ZUX09GRkxJTkU6DQogCWNhc2UgTUFE
Vl9IV1BPSVNPTjoNCisjZW5kaWYNCisjaWZkZWYgQ09ORklHX0FSQ0hfVVNFU19ISUdIX1ZNQV9G
TEFHUw0KKwljYXNlIE1BRFZfV0lQRU9OU1VTUEVORDoNCisJY2FzZSBNQURWX0tFRVBPTlNVU1BF
TkQ6DQogI2VuZGlmDQogCQlyZXR1cm4gdHJ1ZTsNCiANCi0tIA0KMi4xNy4xDQoNCg0KCgoKQW1h
em9uIERldmVsb3BtZW50IENlbnRlciAoUm9tYW5pYSkgUy5SLkwuIHJlZ2lzdGVyZWQgb2ZmaWNl
OiAyN0EgU2YuIExhemFyIFN0cmVldCwgVUJDNSwgZmxvb3IgMiwgSWFzaSwgSWFzaSBDb3VudHks
IDcwMDA0NSwgUm9tYW5pYS4gUmVnaXN0ZXJlZCBpbiBSb21hbmlhLiBSZWdpc3RyYXRpb24gbnVt
YmVyIEoyMi8yNjIxLzIwMDUuCg==


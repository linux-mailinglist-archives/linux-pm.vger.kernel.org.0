Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A85C8DEC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfJBQLq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 12:11:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58002 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfJBQLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 12:11:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-fpDrXPGCNbW9bKaxnI-L7w-1; Wed, 02 Oct 2019 17:11:42 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Oct 2019 17:11:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Oct 2019 17:11:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Parth Shah' <parth@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "pjt@google.com" <pjt@google.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "quentin.perret@arm.com" <quentin.perret@arm.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        "ggherdovich@suse.cz" <ggherdovich@suse.cz>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: RE: [Discussion v2] Usecases for the per-task latency-nice attribute
Thread-Topic: [Discussion v2] Usecases for the per-task latency-nice attribute
Thread-Index: AQHVd3v+R9Ga+faFYEWoOAwvBU0nZadHhPPg
Date:   Wed, 2 Oct 2019 16:11:41 +0000
Message-ID: <9645e7c625a84bfabac001fd6ef35559@AcuMS.aculab.com>
References: <2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com>
In-Reply-To: <2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: fpDrXPGCNbW9bKaxnI-L7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogUGFydGggU2hhaA0KPiBTZW50OiAzMCBTZXB0ZW1iZXIgMjAxOSAxMTo0NA0KLi4uDQo+
IDU+IFNlcGFyYXRpbmcgQVZYNTEyIHRhc2tzIGFuZCBsYXRlbmN5IHNlbnNpdGl2ZSB0YXNrcyBv
biBzZXBhcmF0ZSBjb3Jlcw0KPiAoIC1UaW0gQ2hlbiApDQo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiBBbm90aGVyIHVzZWNhc2Ugd2UgYXJlIGNvbnNpZGVyaW5nIGlzIHRvIHNlZ3JlZ2F0ZSB0aG9z
ZSB3b3JrbG9hZCB0aGF0IHdpbGwNCj4gcHVsbCBkb3duIGNvcmUgY3B1IGZyZXF1ZW5jeSAoZS5n
LiBBVlg1MTIpIGZyb20gd29ya2xvYWQgdGhhdCBhcmUgbGF0ZW5jeQ0KPiBzZW5zaXRpdmUuIFRo
ZXJlIGFyZSBjZXJ0YWluIHRhc2tzIHRoYXQgbmVlZCB0byBwcm92aWRlIGEgZmFzdCByZXNwb25z
ZQ0KPiB0aW1lIChsYXRlbmN5IHNlbnNpdGl2ZSkgYW5kIHRoZXkgYXJlIGJlc3Qgc2NoZWR1bGVk
IG9uIGNwdSB0aGF0IGhhcyBhDQo+IGxpZ2h0ZXIgbG9hZCBhbmQgbm90IGhhdmUgb3RoZXIgdGFz
a3MgcnVubmluZyBvbiB0aGUgc2libGluZyBjcHUgdGhhdCBjb3VsZA0KPiBwdWxsIGRvd24gdGhl
IGNwdSBjb3JlIGZyZXF1ZW5jeS4NCj4gDQo+IFNvbWUgdXNlcnMgYXJlIHJ1bm5pbmcgbWFjaGlu
ZSBsZWFybmluZyBiYXRjaCB0YXNrcyB3aXRoIEFWWDUxMiwgYW5kIGhhdmUNCj4gb2JzZXJ2ZWQg
dGhhdCB0aGVzZSB0YXNrcyBhZmZlY3QgdGhlIHRhc2tzIG5lZWRpbmcgYSBmYXN0IHJlc3BvbnNl
LiAgVGhleQ0KPiBoYXZlIHRvIHJlbHkgb24gbWFudWFsIENQVSBhZmZpbml0eSB0byBzZXBhcmF0
ZSB0aGVzZSB0YXNrcy4gIFdpdGgNCj4gYXBwcm9wcmlhdGUgbGF0ZW5jeSBoaW50IG9uIHRhc2ss
IHRoZSBzY2hlZHVsZXIgY2FuIGJlIHRhdWdodCB0byBzZXBhcmF0ZSB0aGVtLg0KDQpIYXMgdGhp
cyBiZWVuIGRpYWdub3NlZCBwcm9wZXJseT8NCkkgY2FuJ3QgcmVhbGx5IHNlZSBob3cgdGhlIGZy
ZXF1ZW5jeSBkcm9wIGZyb20gQVZYNTEyIHNpZ25pZmljYW50bHkgYWZmZWN0cyBsYXRlbmN5Lg0K
TW9zdCB0YXNrcyB0aGF0IHJlcXVpcmUgbG93IGxhdGVuY3kgcHJvYmFibHkgZG9uJ3QgZG8gYSBs
b3Qgb2Ygd29yay4NCkl0IGlzIG11Y2ggbW9yZSBsaWtlbHkgdGhhdCB0aGUgbGF0ZW5jeSBpc3N1
ZXMgaGFwcGVuIGJlY2F1c2UgdGhlIEFWWDUxMiB0YXNrcw0KYXJlIGRvaW5nIHZlcnkgZmV3IHN5
c3RlbSBjYWxscyBzbyBjYW4ndCBiZSBwcmUtZW1wdGVkIGV2ZW4gYnkgYSBoaWdoIHByaW9yaXR5
IHRhc2suDQpUaGlzICdmZWF0dXJlJyBpcyBoaW50ZWQgYnkgdGhpczoNCj4gMj4gVHVyYm9TY2hl
ZA0KPiAoIC1QYXJ0aCBTaGFoICkNCj4gPT09PT09PT09PT09PT09PT09PT0NCj4gVHVyYm9TY2hl
ZCBbMl0gdHJpZXMgdG8gbWluaW1pemUgdGhlIG51bWJlciBvZiBhY3RpdmUgY29yZXMgaW4gYSBz
b2NrZXQgYnkNCj4gcGFja2luZyBhbiB1bi1pbXBvcnRhbnQgYW5kIGxvdy11dGlsaXphdGlvbiAo
bmFtZWQgaml0dGVyKSB0YXNrIG9uIGFuDQo+IGFscmVhZHkgYWN0aXZlIGNvcmUgYW5kIHRodXMg
cmVmcmFpbnMgZnJvbSB3YWtpbmcgdXAgb2YgYSBuZXcgY29yZSBpZg0KPiBwb3NzaWJsZS4NCg0K
Q29uc2lkZXIgdGhpcyBleGFtcGxlIG9mIGEgcHJvY2VzcyB0aGF0IHJlcXVpcmVzIGxvdyBsYXRl
bmN5IChzdWIgMW1zIHdvdWxkIGJlIGdvb2QpOg0KLSBBIGhhcmR3YXJlIGludGVycnVwdCAob3Ig
dGltZXIgaW50ZXJydXB0KSB3YWtlcyB1cCBvbiB0aHJlYWQuDQotIFdoZW4gdGhhdCB0aHJlYWQg
d2FrZXMgaXQgd2FrZXMgdXAgb3RoZXIgdGhyZWFkcyB0aGF0IGFyZSBzbGVlcGluZy4NCi0gQWxs
IHRoZSB0aHJlYWRzICdiZWF2ZXIgYXdheScgZm9yIGEgZmV3IG1zIChwcm9jZXNzaW5nIFJUUCBh
bmQgb3RoZXIgYXVkaW8pLg0KLSBUaGV5IGFsbCBzbGVlcCBmb3IgdGhlIHJlc3Qgb2YgYSAxMG1z
IHBlcmlvZC4NCg0KVGhlIGFmZmluaXRpZXMgYXJlIHNldCBzbyBlYWNoIHRocmVhZCBydW5zIG9u
IGEgc2VwYXJhdGUgY3B1LCBhbmQgYWxsIGFyZSBTQ0hFRF9SUi4NCk5vdyBsb29wIGFsbCB0aGUg
Y3B1cyBpbiB1c2Vyc3BhY2UgKHJ1bjogd2hpbGUgOjsgZG8gOjsgZG9uZSkgYW5kIHNlZSB3aGF0
IGhhcHBlbnMgdG8gdGhlIGxhdGVuY2llcy4NCllvdSByZWFsbHkgd2FudCB0aGUgU0NIRURfUlIg
dGhyZWFkcyB0byBpbW1lZGlhdGVseSBwcmUtZW1wdCB0aGUgcnVubmluZyBwcm9jZXNzZXMuDQpC
dXQgSSBzdXNwZWN0IG5vdGhpbmcgaGFwcGVucyB1bnRpbCBhIHRpbWVyIGludGVycnVwdCB0byB0
aGUgdGFyZ2V0IGNwdS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53541E42A6
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgE0MuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 08:50:08 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:36550 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbgE0MuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 08:50:07 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 40AE967A7C0;
        Wed, 27 May 2020 14:50:02 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 27 May
 2020 14:50:01 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Wed, 27 May 2020 14:50:01 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: High interrupt latency with low power idle mode on i.MX6
Thread-Topic: High interrupt latency with low power idle mode on i.MX6
Thread-Index: AQHWNBMPiENrGmpy5EqtWjfM5SmIn6i7sUkAgAAPtYA=
Date:   Wed, 27 May 2020 12:50:01 +0000
Message-ID: <a6bb55aa-5c47-ba7a-2f74-56da4aef4a42@kontron.de>
References: <bc91129c-121c-a070-53b2-1f0bb6d4500a@kontron.de>
 <20200527115347.GL1551@shell.armlinux.org.uk>
In-Reply-To: <20200527115347.GL1551@shell.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F0691562A52040BE3F6D3F77FD5DB5@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 40AE967A7C0.AF726
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: daniel.lezcano@linaro.org, info@metux.net,
        kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tglx@linutronix.de
X-Spam-Status: No
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjcuMDUuMjAgMTM6NTMsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCBhZG1pbiB3cm90ZToN
Cj4gT24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMTA6Mzk6MTJBTSArMDAwMCwgU2NocmVtcGYgRnJp
ZWRlciB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IG9uIG91ciBpLk1YNlVML1VMTCBib2FyZHMgcnVu
bmluZyBtYWlubGluZSBrZXJuZWxzLCB3ZSBzZWUgYW4gaXNzdWUgd2l0aA0KPj4gUlM0ODUgY29s
bGlzaW9ucyBvbiB0aGUgYnVzLiBUaGVzZSBhcmUgY2F1c2VkIGJ5IHRoZSByZXNldHRpbmcgb2Yg
dGhlDQo+PiBSVFMgc2lnbmFsIGJlaW5nIGRlbGF5ZWQgYWZ0ZXIgZWFjaCB0cmFuc21pc3Npb24u
IFRoZSBUWERDIGludGVycnVwdA0KPj4gdGFrZXMgc2V2ZXJhbCBtaWxsaXNlY29uZHMgdG8gdHJp
Z2dlciBhbmQgdGhlIHNsYXZlIG9uIHRoZSBidXMgYWxyZWFkeQ0KPj4gc3RhcnRzIHRvIHNlbmQg
YSByZXBseSBpbiB0aGUgbWVhbnRpbWUuDQo+Pg0KPj4gV2UgZm91bmQgb3V0IHRoYXQgdGhlc2Ug
ZGVsYXlzIG9ubHkgaGFwcGVuIHdoZW4gdGhlIENQVSBpcyBpbiAibG93IHBvd2VyDQo+PiBpZGxl
IiBtb2RlIChBUk0gcG93ZXIgb2ZmKS4gV2hlbiB3ZSBkaXNhYmxlIGNwdWlkbGUgc3RhdGUgMiBv
ciBwdXQgc29tZQ0KPj4gYmFja2dyb3VuZCBsb2FkIG9uIHRoZSBDUFUgZXZlcnl0aGluZyB3b3Jr
cyBmaW5lIGFuZCB0aGUgZGVsYXlzIGFyZSBnb25lLg0KPj4NCj4+IGVjaG8gMSA+IC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTIvZGlzYWJsZQ0KPj4NCj4+IEl0IHNl
ZW1zIGxpa2UgYWxzbyBvdGhlciBpbnRlcmZhY2VzIChJMkMsIGV0Yy4pIG1pZ2h0IGJlIGFmZmVj
dGVkIGJ5DQo+PiB0aGVzZSBpbmNyZWFzZWQgbGF0ZW5jaWVzLCB3ZSBoYXZlbid0IGludmVzdGln
YXRlZCB0aGlzIG1vcmUgY2xvc2VseSwNCj4+IHRob3VnaC4NCj4+DQo+PiBXZSBjdXJyZW50bHkg
YXBwbHkgYSBwYXRjaCB0byBvdXIga2VybmVsLCB0aGF0IGRpc2FibGVzIGxvdyBwb3dlciBpZGxl
DQo+PiBtb2RlIGJ5IGRlZmF1bHQsIGJ1dCBJJ20gd29uZGVyaW5nIGlmIHRoZXJlJ3MgYSB3YXkg
dG8gZml4IHRoaXMNCj4+IHByb3Blcmx5PyBBbnkgaWRlYXM/DQo+IA0KPiBMZXQncyBleGFtaW5l
IGEgYmFzaWMgZmFjdCBhYm91dCBwb3dlciBtYW5hZ2VtZW50Og0KPiANCj4gVGhlIGRlZXBlciBQ
TSBtb2RlcyB0aGF0IHRoZSBzeXN0ZW0gZW50ZXJzLCB0aGUgaGlnaGVyIHRoZSBsYXRlbmN5IHRv
DQo+IHJlc3VtZSBvcGVyYXRpb24uDQo+IA0KPiBTbywgSSdtIG5vdCBzdXJwcmlzZWQgdGhhdCB5
b3UgaGF2ZSBoaWdoZXIgbGF0ZW5jeSB3aGVuIHlvdSBhbGxvdyB0aGUNCj4gc3lzdGVtIHRvIGVu
dGVyIGxvd2VyIHBvd2VyIG1vZGVzLiAgRG9lcyB0aGF0IG1lYW4gdGhhdCB0aGUga2VybmVsDQo+
IHNob3VsZCBub3QgcGVybWl0IGVudGVyaW5nIGxvd2VyIHBvd2VyIG1vZGVzIC0gbm8sIGl0J3Mg
cG9saWN5IGFuZA0KPiBhcHBsaWNhdGlvbiBkZXBlbmRlbnQuDQo+IA0KPiBJZiB0aGUgaGFyZHdh
cmUgaXMgZGVzaWduZWQgdG8gdXNlIHNvZnR3YXJlIHRvIG1hbmFnZSB0aGUgUlRTIHNpZ25hbA0K
PiB0byBjb250cm9sIHRoZSBSUzQ4NSByZWNlaXZlciwgdGhlbiBJJ20gYWZyYWlkIHRoYXQgeW91
ciByZXBvcnQgcmVhbGx5DQo+IGRvZXMgbm90IHN1cnByaXNlIG1lIC0gdGhyb3dpbmcgdGhhdCBh
dCBzb2Z0d2FyZSB0byBtYW5hZ2UgaXMgYSByZWFsbHkNCj4gc3R1cGlkIGlkZWEsIGJ1dCBpdCBz
ZWVtcyBsb3RzIG9mIHBlb3BsZSBkbyB0aGlzLiAgSSd2ZSBoZWxkIHRoaXMgdmlldw0KPiBzaW5j
ZSBJIHdvcmtlZCBvbiBhIHNhZmV0eSBjcml0aWNhbCBzeXN0ZW0gdGhhdCB1c2VkIFJTNDg1IGJh
Y2sgaW4gdGhlDQo+IDE5OTBzIChMb25kb24gVW5kZXJncm91bmQgSnViaWxlZSBMaW5lIEV4dGVu
c2lvbiBwdWJsaWMgYWRkcmVzcyBzeXN0ZW0uKQ0KPiANCj4gU28sIHdoYXQgd2UgaGF2ZSBoZXJl
IGlzIHNldmVyYWwgdGhpbmdzIHRoYXQgY29tZSB0b2dldGhlciB0byBjcmVhdGUgYQ0KPiBwcm9i
bGVtOg0KPiANCj4gMSkgaGlnaGVyIHBvd2VyIHNhdmluZ3MgcHJvZHVjZSBoaWdoZXIgbGF0ZW5j
eSB0byByZXN1bWUgZnJvbQ0KPiAyKSBsYWNrIG9mIGhhcmR3YXJlIHN1cHBvcnQgZm9yIFJTNDg1
IGhhbGYgZHVwbGV4IGNvbW11bmljYXRpb24gbmVlZGluZw0KPiAgICAgc29mdHdhcmUgc3VwcG9y
dA0KPiAzKSBhbiBhcHBsaWNhdGlvbiB0aGF0IG1ha2VzIHVzZSBvZiBSUzQ4NSBoYWxmIGR1cGxl
eCBjb21tdW5pY2F0aW9uDQo+ICAgICB3aXRob3V0IGRpc2FibGluZyB0aGUgaGlnaGVyIGxhdGVu
Y3kgcG93ZXIgc2F2aW5nIG1vZGVzDQo+IA0KPiBUaGUgcXVlc3Rpb24gaXMsIHdobyBzaG91bGQg
ZGlzYWJsZSB0aG9zZSBoaWdoZXIgbGF0ZW5jeSBwb3dlciBzYXZpbmcNCj4gbW9kZXMgLSB0aGUg
a2VybmVsLCBvciB1c2Vyc3BhY2U/DQo+IA0KPiBUaGUga2VybmVsIGtub3dzIHdoZXRoZXIgaXQg
bmVlZHMgdG8gcHJvdmlkZSBzb2Z0d2FyZSBjb250cm9sIG9mIHRoZQ0KPiBSVFMgc2lnbmFsIG9y
IG5vdCwgYnV0IHRoZSBrZXJuZWwgZG9lcyBub3Qga25vdyB0aGUgbWF4aW11bSBwZXJtaXNzaWJs
ZQ0KPiBsYXRlbmN5ICh3aGljaCBpcyBhcHBsaWNhdGlvbiBzcGVjaWZpYy4pICBTbywgdGhlIGtl
cm5lbCBkb2Vzbid0IGhhdmUNCj4gYWxsIHRoZSBpbmZvcm1hdGlvbiBpdCBuZWVkcy4gIEhvd2V2
ZXIsIHRoZXJlIGlzIGEgUW9TIHN1YnN5c3RlbSB3aGljaA0KPiBtYXkgaGVscCB5b3UuDQo+IA0K
PiBUaGVyZSdzIGFsc28gdHdlYWtzIGF2YWlsYWJsZSB2aWENCj4gL3N5cy9kZXZpY2VzL3N5c3Rl
bS9jcHUvY3B1Ki9wb3dlci9wbV9xb3NfcmVzdW1lX2xhdGVuY3lfdXMNCj4gDQo+IHdoaWNoIGNh
biBiZSBwb2tlZCB0byBjb25maWd1cmUgdGhlIGxhdGVuY3kgdGhhdCBpcyByZXF1aXJlZCwgYW5k
IHdpbGwNCj4gcHJldmVudCB0aGUgZGVlcGVyIFBNIHN0YXRlcyBiZWluZyBlbnRlcmVkLg0KDQpU
aGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4gVGhpcyBhbGwgbWFrZXMgcGVyZmVj
dCBzZW5zZSB0byBtZS4NCkkgd2lsbCBrZWVwIGluIG1pbmQgdGhhdCB3ZSBuZWVkIHRvIGNvbnNp
ZGVyIHRoaXMgYXNwZWN0IG9mIHBvd2VyIHNhdmluZyANCnZzLiBsYXRlbmN5IHdoZW4gZGVzaWdu
aW5nIHN5c3RlbXMgYW5kIGFsc28gdGhhdCB3ZSBuZWVkIHRvIHByb3ZpZGUgdGhlIA0KaW5mb3Jt
YXRpb24gZm9yIHRoZSBrZXJuZWwgdG8gZGVjaWRlIHdoaWNoIG9mIHRoZSB0d28gaXMgbW9yZSBp
bXBvcnRhbnQuDQoNCkFsc28gdGhhbmtzIGZvciBwb2ludGluZyBvdXQgdGhlIFFvUyBzdWJzeXN0
ZW0uIEknbSBub3QgcXVpdGUgc3VyZSBpZiBpdCANCndvdWxkIHdvcmsgZm9yIHVzIHRvIHVzZSBw
bV9xb3NfcmVzdW1lX2xhdGVuY3lfdXMgaW4gb3VyIHNwZWNpZmljIGNhc2UuIA0KVGhlIGFjdHVh
bCBsYXRlbmN5IHdlIG9ic2VydmUgaXMgc29tZXRoaW5nIGxpa2UgMiB0byAzIG1pbGxpc2Vjb25k
cyANCmxvbmdlciB3aXRoIGxvdyBwb3dlciBpZGxlIHRoYW4gd2l0aG91dCwgYnV0IHRoZSBleGl0
X2xhdGVuY3kgZm9yIGxvdyANCnBvd2VyIGlkbGUgc3BlY2lmaWVkIGluIHRoZSBjcHVpZGxlIGRy
aXZlciBpcyBvbmx5IDMwMCB1cy4NCg0KU28gYXMgZmFyIGFzIEkgY2FuIHNlZSB3aXRoIHRoaXMg
ZGlmZmVyZW5jZSBldmVuIGlmIHdlIHdvdWxkIHNldCANCnBtX3Fvc19yZXN1bWVfbGF0ZW5jeV91
cyB0byAxMDAwIHVzICh3aGljaCBzaG91bGQgYmUgZmFzdCBlbm91Z2ggZm9yIHRoZSANClJTNDg1
IHRvIHdvcmsgcHJvcGVybHkpLCB0aGUgbG93IHBvd2VyIGlkbGUgd291bGRuJ3QgYmUgZGlzYWJs
ZWQuDQoNCkl0J3MgcmF0aGVyIHRoaXMgZGlzY3JlcGFuY3kgYmV0d2VlbiB0aGUgbGF0ZW5jeSBz
ZXQgaW4gdGhlIGRyaXZlciBhbmQgDQp3aGF0IHdlIHNlZSBpbiByZWFsaXR5IHdoaWNoIG1ha2Vz
IG1lIHdvbmRlciBpZiB0aGVyZSdzIHNvbWV0aGluZyBJJ20gDQptaXNzaW5nLg==

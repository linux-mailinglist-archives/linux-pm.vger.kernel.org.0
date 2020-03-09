Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3517DC1D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 10:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgCIJHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 05:07:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:41673 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIJHn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 05:07:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 02:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="276438111"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2020 02:07:41 -0700
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.245]) by
 PGSMSX108.gar.corp.intel.com ([169.254.8.177]) with mapi id 14.03.0439.000;
 Mon, 9 Mar 2020 17:02:58 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3] intel_idle: Add Comet Lake support
Thread-Topic: [PATCH v3] intel_idle: Add Comet Lake support
Thread-Index: AQHV8TuIsnm0plXkJ0qxTNV1fBgP1Kg3rPoAgACovO2AABVjAIAHke5k
Date:   Mon, 9 Mar 2020 09:02:57 +0000
Message-ID: <6089B7674E6F464F847AB76B599E0EAA78AB6A98@PGSMSX102.gar.corp.intel.com>
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
 <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
 <CAJZ5v0j+bx5fh1wv738MNoui_SaZ-c21rDnZkWOqi_GCVg5stQ@mail.gmail.com>
 <F8C6368A-1537-482B-8FE5-350A18D936A8@intel.com>,<CAJZ5v0iBMiGKeFXRTLkR8oFQbdCJq0TnhpFZkMBK4gF0VNjumA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iBMiGKeFXRTLkR8oFQbdCJq0TnhpFZkMBK4gF0VNjumA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.41]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUmFmYWVsLA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cy4NCkkgaGF2ZSBzb21lIHF1ZXN0
aW9ucywgSSBhbSB3b25kZXJpbmcgaWYgeW91IGNhbiBzaGFyZSB1cHN0cmVhbSB0aG91Z2h0IHcu
ci50IHRoZSBmdXR1cmUgZGV2ZWxvcG1lbnQgb2YgaW50ZWxfaWRsZS4NCg0KIC0gSXQgbG9va3Mg
dG8gbWUgc2luY2UgdjUuNiBpbnRlbF9pZGxlIHdpbGwgcHJlZmVyIF9DU1Qgb2YgQUNQSSByYXRo
ZXIgdGhhbiB0aGUgZ2VuZXJhbCB0YWJsZSBlbWJlZGRlZCBpbiB0aGlzIGRyaXZlci4NCiAtIEFu
eSBwcm9zIGFuZCBjb25zIG9mIHVzaW5nIHRoZSB0YWJsZXMgb2YgX0NTVCBpbiBmaXJtd2FyZSBh
bmQgZW1iZWRkZWQgb25lIGluIHRoZSBrZXJuZWw/DQogLSBDYW4gdGhlIHRhYmxlIGluIF9DU1Qg
YXJjaGl2ZSBtb3JlIG9wdGltYWwgaWRsZSBzdGF0ZXMgbWFuYWdlbWVudD8gDQoNCklmIHRoZXJl
IGlzIGFscmVhZHkgYW55IHJlZmVyZW5jZSwgZG9jdW1lbnRzIEkgbWlzc2VkLCBraW5kbHkgZW5s
aWdodGVuIG1lIHRoZW4gSSB3b3VsZCBsaWtlIHRvIHJlYWQgaXQgZmlyc3QgYmVmb3JlIHJlZmlu
aW5nIHRoZSBxdWVzdGlvbnMuDQoNClRoYW5rcyBhbmQgdGFrZSBjYXJlLA0KSGFycnkNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCuW+njogUmFmYWVsIEouIFd5c29j
a2kgW3JhZmFlbEBrZXJuZWwub3JnXQ0K5a+E5Lu25pel5pyfOiAyMDIw5bm0M+aciDXml6Ug5LiK
5Y2IIDA1OjE0DQroh7M6IFBhbiwgSGFycnkNCuWJr+acrDogUmFmYWVsIEouIFd5c29ja2k7IExL
TUw7IEhhcnJ5IFBhbjsgSmFjb2IgUGFuOyBMZW4gQnJvd247IExpbnV4IFBNDQrkuLvml6g6IFJl
OiBbUEFUQ0ggdjNdIGludGVsX2lkbGU6IEFkZCBDb21ldCBMYWtlIHN1cHBvcnQNCg0KT24gV2Vk
LCBNYXIgNCwgMjAyMCBhdCAxMjo1NyBQTSBQYW4sIEhhcnJ5IDxoYXJyeS5wYW5AaW50ZWwuY29t
PiB3cm90ZToNCj4NCj4gSGkgUmFmYWVsLA0KPg0KPiBZZXMsIEkgc2tpcHBlZCBpdCBjb25zaWRl
cmluZyB0byBhbGlnbiBDTUwtVSBWMCBhbmQgQTAgc3RlcHBpbmcgdy8gdGhlIHNhbWUgdGFibGU7
IEkgc2VudCB2NCBmb3IgeW91ciByZXZpZXcuDQoNClNraXBwaW5nIHRoYXQgZmxhZyBpcyByaXNr
eSwgYmVjYXVzZSBpdCBtYXkgY2F1c2Ugc29tZSBDLXN0YXRlcyB0byBiZQ0KZW5hYmxlZCBvbiBz
eXN0ZW1zIHdoZXJlIHRoZXkgaGF2ZSBub3QgYmVlbiB2YWxpZGF0ZWQgKGUuZy4gc3lzdGVtcw0K
c2hpcHBpbmcgd2l0aCBvdGhlciBPU2VzIHdoaWNoIG9ubHkgdXNlIF9DU1QgQy1zdGF0ZXMpLiAg
VGhlcmUgd2VyZQ0KcHJvYmxlbXMgcmVsYXRlZCB0byB0aGF0IGluIHRoZSBwYXN0IHdoaWNoIGlz
IG9uZSBvZiB0aGUgcmVhc29ucyBmb3INCmFkZGluZyBfQ1NUIHN1cHBvcnQgdG8gaW50ZWxfaWRs
ZS4gIHVzZV9hY3BpIHNob3VsZCBiZSBzZXQgZm9yIGFsbCBuZXcNCnBsYXRmb3JtcyBnb2luZyBm
b3J3YXJkIGFzIGEgcnVsZS4NCg0KPiBJbiB0aGUgb3RoZXIgaGFuZCwgSSBhbSBwcm9wb3Npbmcg
dXNpbmcgX0NTVCBhcyBsb25nIHRlcm0gcGxhbiBpbiBDck9TIGRldiB0ZWFtcy4NCg0KVGhhdCBJ
IG9idmlvdXNseSBhZ3JlZSB3aXRoLiA6LSkNCg0KDQo+ID4gT24gTWFyIDQsIDIwMjAsIGF0IDE3
OjUzLCBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4g77u/T24gVHVlLCBNYXIgMywgMjAyMCBhdCAxMDoxMCBBTSBIYXJyeSBQYW4gPGhhcnJ5LnBh
bkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBBZGQgYSBnZW5lcmFsIEMtc3RhdGUgdGFi
bGUgaW4gb3JkZXIgdG8gc3VwcG9ydCBDb21ldCBMYWtlLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBIYXJyeSBQYW4gPGhhcnJ5LnBhbkBpbnRlbC5jb20+DQo+ID4+DQo+ID4+IC0tLQ0KPiA+
Pg0KPiA+PiBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgNyArKysrKysrDQo+ID4+IDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWRsZS9pbnRlbF9pZGxlLmMgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+ID4+IGlu
ZGV4IGQ1NTYwNjYwOGFjOC4uMDViY2U1OTVmYWZlIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJz
L2lkbGUvaW50ZWxfaWRsZS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMN
Cj4gPj4gQEAgLTEwNjcsNiArMTA2NywxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlkbGVfY3B1
IGlkbGVfY3B1X2RudiA9IHsNCj4gPj4gICAgICAgIC51c2VfYWNwaSA9IHRydWUsDQo+ID4+IH07
DQo+ID4+DQo+ID4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlkbGVfY3B1IGlkbGVfY3B1X2NtbCA9
IHsNCj4gPj4gKyAgICAgICAuc3RhdGVfdGFibGUgPSBza2xfY3N0YXRlcywNCj4gPj4gKyAgICAg
ICAuZGlzYWJsZV9wcm9tb3Rpb25fdG9fYzFlID0gdHJ1ZSwNCj4gPg0KPiA+IC51c2VfYWNwaSA9
IHRydWUsDQo+ID4NCj4gPiBtaXNzaW5nPyAgT3RoZXJ3aXNlIHlvdSBjYW4ganVzdCB1c2UgaWRs
ZV9jcHVfc2tsIGFzIGlzLCBjYW4ndCB5b3U/DQo+ID4NCj4gPj4gK307DQo+ID4+ICsNCj4gPj4g
c3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIGludGVsX2lkbGVfaWRzW10gX19pbml0Y29u
c3QgPSB7DQo+ID4+ICAgICAgICBJTlRFTF9DUFVfRkFNNihORUhBTEVNX0VQLCAgICAgICAgICAg
ICAgaWRsZV9jcHVfbmh4KSwNCj4gPj4gICAgICAgIElOVEVMX0NQVV9GQU02KE5FSEFMRU0sICAg
ICAgICAgICAgICAgICBpZGxlX2NwdV9uZWhhbGVtKSwNCj4gPj4gQEAgLTExMDUsNiArMTExMCw4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCBpbnRlbF9pZGxlX2lkc1tdIF9faW5p
dGNvbnN0ID0gew0KPiA+PiAgICAgICAgSU5URUxfQ1BVX0ZBTTYoQVRPTV9HT0xETU9OVF9QTFVT
LCAgICAgIGlkbGVfY3B1X2J4dCksDQo+ID4+ICAgICAgICBJTlRFTF9DUFVfRkFNNihBVE9NX0dP
TERNT05UX0QsICAgICAgICAgaWRsZV9jcHVfZG52KSwNCj4gPj4gICAgICAgIElOVEVMX0NQVV9G
QU02KEFUT01fVFJFTU9OVF9ELCAgICAgICAgICBpZGxlX2NwdV9kbnYpLA0KPiA+PiArICAgICAg
IElOVEVMX0NQVV9GQU02KENPTUVUTEFLRV9MLCAgICAgICAgICAgICBpZGxlX2NwdV9jbWwpLA0K
PiA+PiArICAgICAgIElOVEVMX0NQVV9GQU02KENPTUVUTEFLRSwgICAgICAgICAgICAgICBpZGxl
X2NwdV9jbWwpLA0KPiA+PiAgICAgICAge30NCj4gPj4gfTsNCj4gPj4NCj4gPj4gLS0NCj4gPj4g
Mi4yNC4xDQo+ID4+DQo=

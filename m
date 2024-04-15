Return-Path: <linux-pm+bounces-6395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C88A4D51
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 13:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7417AB22D18
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BD5D47E;
	Mon, 15 Apr 2024 11:07:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83015C902;
	Mon, 15 Apr 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179253; cv=none; b=uo+pjOWuL1TDWcaNp6DS6KkPqEpWtGsSIlNk0TQNmdp8OrcSbLgn93OBmGnkaMr58R82jHWKuyKQ4QgKDO9SmfYDdaaFr+Qspt1k+4Xiuv+UMtP2HFfEF3VmWSIAl33eGZR1SCrvK23vbd8NeZ0M2aIjV0/m1WHN96ZnGdZvIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179253; c=relaxed/simple;
	bh=c2FrNQnT9EbDw299igUBNnyZzCEtFHlloBla08k+358=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvomHs7q6tHyLQkIBCib7NTMjqMepsKr7lXadxnaWA4A9/PbMubIsTYWwM8e/pK1nPybaiwtenyhycyedqgEX2xbpZN7GfmpTos7zqWMe5EH9TN+QX8wZ/hBqzAl8R+ZQYL9uAYuR1r5W4vWmjBd7US1j2KixqP2W98dNxg2URE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJ48W1w6gz6JB3Z;
	Mon, 15 Apr 2024 19:05:31 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 39422140A08;
	Mon, 15 Apr 2024 19:07:25 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 12:07:24 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Mon, 15 Apr 2024 12:07:24 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Linuxarm <linuxarm@huawei.com>, "justin.he@arm.com" <justin.he@arm.com>,
	"jianyong.wu@arm.com" <jianyong.wu@arm.com>
Subject: RE: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Thread-Topic: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Thread-Index: AQHajOchpfPN+k2lSk2QcH/fNdeOvbFk5HgAgARCD2A=
Date: Mon, 15 Apr 2024 11:07:24 +0000
Message-ID: <23b8e7b66ea348f78779a7eb95ec468a@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
 <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8sDQoNCkVuZ2FnaW5nIGFmdGVyIGEgbG9uZyB0aW1lIChJJ3ZlIGJlZW4gYWxtb3N0IG9m
ZiBncmlkIGR1ZSB0byB2ZXJ5IGNoYWxsZW5naW5nIHBlcnNvbmFsIGNpcmN1bXN0YW5jZXMpLg0K
UGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQpUaGFua3MNClNhbGlsDQoNCj4gIEZy
b206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gIFNlbnQ6IEZyaWRh
eSwgQXByaWwgMTIsIDIwMjQgNzozMSBQTQ0KPiAgVG86IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gIENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7
IGxvb25nYXJjaEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiAgYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gIGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gIGt2bWFy
bUBsaXN0cy5saW51eC5kZXY7IHg4NkBrZXJuZWwub3JnOyBSdXNzZWxsIEtpbmcNCj4gIDxsaW51
eEBhcm1saW51eC5vcmcudWs+OyBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3Jn
PjsgTWlndWVsDQo+ICBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPjsgSmFtZXMgTW9yc2Ug
PGphbWVzLm1vcnNlQGFybS5jb20+Ow0KPiAgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdl
aS5jb20+OyBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tDQo+ICBwaGlsaXBwZUBsaW5hcm8u
b3JnPjsgQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT47IFdpbGwNCj4g
IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+
Ow0KPiAganVzdGluLmhlQGFybS5jb207IGppYW55b25nLnd1QGFybS5jb20NCj4gIFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjUgMDMvMThdIEFDUEk6IHByb2Nlc3NvcjogUmVnaXN0ZXIgZGVmZXJyZWQg
Q1BVcyBmcm9tDQo+ICBhY3BpX3Byb2Nlc3Nvcl9nZXRfaW5mbygpDQo+ICANCj4gIE9uIEZyaSwg
QXByIDEyLCAyMDI0IGF0IDQ6MzjigK9QTSBKb25hdGhhbiBDYW1lcm9uDQo+ICA8Sm9uYXRoYW4u
Q2FtZXJvbkBodWF3ZWkuY29tPiB3cm90ZToNCj4gID4NCj4gID4gRnJvbTogSmFtZXMgTW9yc2Ug
PGphbWVzLm1vcnNlQGFybS5jb20+DQo+ICA+DQo+ICA+IFRoZSBhcm02NCBzcGVjaWZpYyBhcmNo
X3JlZ2lzdGVyX2NwdSgpIGNhbGwgbWF5IGRlZmVyIENQVSByZWdpc3RyYXRpb24NCj4gID4gdW50
aWwgdGhlIEFDUEkgaW50ZXJwcmV0ZXIgaXMgYXZhaWxhYmxlIGFuZCB0aGUgX1NUQSBtZXRob2Qg
Y2FuIGJlDQo+ICA+IGV2YWx1YXRlZC4NCj4gID4NCj4gID4gSWYgdGhpcyBvY2N1cnMsIHRoZW4g
YSBzZWNvbmQgYXR0ZW1wdCBpcyBtYWRlIGluDQo+ICA+IGFjcGlfcHJvY2Vzc29yX2dldF9pbmZv
KCkuIE5vdGUgdGhhdCB0aGUgYXJtNjQgc3BlY2lmaWMgY2FsbCBoYXMgbm90DQo+ICA+IHlldCBi
ZWVuIGFkZGVkIHNvIGZvciBub3cgdGhpcyB3aWxsIG5ldmVyIGJlIHN1Y2Nlc3NmdWxseSBjYWxs
ZWQuDQo+ICA+DQo+ICA+IFN5c3RlbXMgY2FuIHN0aWxsIGJlIGJvb3RlZCB3aXRoICdhY3BpPW9m
ZicsIG9yIG5vdCBpbmNsdWRlIGFuIEFDUEkNCj4gID4gZGVzY3JpcHRpb24gYXQgYWxsIGFzIGlu
IHRoZXNlIGNhc2VzIGFyY2hfcmVnaXN0ZXJfY3B1KCkgd2lsbCBub3QgaGF2ZQ0KPiAgPiBkZWZl
cnJlZCByZWdpc3RyYXRpb24gd2hlbiBmaXJzdCBjYWxsZWQuDQo+ICA+DQo+ICA+IFRoaXMgbW92
ZXMgdGhlIENQVSByZWdpc3RlciBsb2dpYyBiYWNrIHRvIGEgc3Vic3lzX2luaXRjYWxsKCksIHdo
aWxlDQo+ICA+IHRoZSBtZW1vcnkgbm9kZXMgd2lsbCBoYXZlIGJlZW4gcmVnaXN0ZXJlZCBlYXJs
aWVyLg0KPiAgPiBOb3RlIHRoaXMgaXMgd2hlcmUgdGhlIGNhbGwgd2FzIHByaW9yIHRvIHRoZSBj
bGVhbnVwIHNlcmllcyBzbyB0aGVyZQ0KPiAgPiBzaG91bGQgYmUgbm8gc2lkZSBlZmZlY3RzIG9m
IG1vdmluZyBpdCBiYWNrIGFnYWluIGZvciB0aGlzIHNwZWNpZmljDQo+ICA+IGNhc2UuDQo+ICA+
DQo+ICA+IFtQQVRDSCAwMC8yMV0gSW5pdGlhbCBjbGVhbnVwcyBmb3IgdkNQVSBIUC4NCj4gID4N
Cj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9aVnl6JTJGVmU1cFB1OEFXb0FAc2hlbGwu
YXJtbGludXgub3JnLnVrLw0KPiAgPg0KPiAgPiBlLmcuIDViOTVmOTRjM2I5ZiAoIng4Ni90b3Bv
bG9neTogU3dpdGNoIG92ZXIgdG8NCj4gIEdFTkVSSUNfQ1BVX0RFVklDRVMiKQ0KPiAgPg0KPiAg
PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4gID4g
UmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+ICA+IFRlc3RlZC1i
eTogTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+ICA+IFRlc3RlZC1ieTog
VmlzaG51IFBhamp1cmkgPHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiAgPiBUZXN0
ZWQtYnk6IEppYW55b25nIFd1IDxqaWFueW9uZy53dUBhcm0uY29tPg0KPiAgPiBTaWduZWQtb2Zm
LWJ5OiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgPHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrPg0K
PiAgPiBDby1kZXZlbG9wZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25A
aHVhd2VpLmNvbT4NCj4gID4gU2lnbmVkLW9mZi1ieTogSm9hbnRoYW4gQ2FtZXJvbiA8Sm9uYXRo
YW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiAgPiAtLS0NCj4gID4gdjU6IFVwZGF0ZSBjb21taXQg
bWVzc2FnZSB0byBtYWtlIGl0IGNsZWFyIHRoaXMgaXMgbW92aW5nIHRoZQ0KPiAgPiAgICAgaW5p
dCBiYWNrIHRvIHdoZXJlIGl0IHdhcyB1bnRpbCB2ZXJ5IHJlY2VudGx5Lg0KPiAgPg0KPiAgPiAg
ICAgTm8gbG9uZ2VyIGNoYW5nZSB0aGUgY29uZGl0aW9uIGluIHRoZSBlYXJsaWVyIHJlZ2lzdHJh
dGlvbiBwb2ludA0KPiAgPiAgICAgYXMgdGhhdCB3aWxsIGJlIGhhbmRsZWQgYnkgdGhlIGFybTY0
IHJlZ2lzdHJhdGlvbiByb3V0aW5lDQo+ICA+ICAgICBkZWZlcnJpbmcgdW50aWwgY2FsbGVkIGFn
YWluIGhlcmUuDQo+ICA+IC0tLQ0KPiAgPiAgZHJpdmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMg
fCAxMiArKysrKysrKysrKysNCj4gID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
DQo+ICA+DQo+ICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0K
PiAgPiBiL2RyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5jIGluZGV4IDkzZTAyOTQwM2QwNS4u
Yzc4Mzk4Y2RkMDYwDQo+ICA+IDEwMDY0NA0KPiAgPiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaV9w
cm9jZXNzb3IuYw0KPiAgPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0KPiAg
PiBAQCAtMzE3LDYgKzMxNywxOCBAQCBzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF9pbmZv
KHN0cnVjdA0KPiAgPiBhY3BpX2RldmljZSAqZGV2aWNlKQ0KPiAgPg0KPiAgPiAgICAgICAgIGMg
PSAmcGVyX2NwdShjcHVfZGV2aWNlcywgcHItPmlkKTsNCj4gID4gICAgICAgICBBQ1BJX0NPTVBB
TklPTl9TRVQoJmMtPmRldiwgZGV2aWNlKTsNCj4gID4gKyAgICAgICAvKg0KPiAgPiArICAgICAg
ICAqIFJlZ2lzdGVyIENQVXMgdGhhdCBhcmUgcHJlc2VudC4gZ2V0X2NwdV9kZXZpY2UoKSBpcyB1
c2VkIHRvIHNraXANCj4gID4gKyAgICAgICAgKiBkdXBsaWNhdGUgQ1BVIGRlc2NyaXB0aW9ucyBm
cm9tIGZpcm13YXJlLg0KPiAgPiArICAgICAgICAqLw0KPiAgPiArICAgICAgIGlmICghaW52YWxp
ZF9sb2dpY2FsX2NwdWlkKHByLT5pZCkgJiYgY3B1X3ByZXNlbnQocHItPmlkKSAmJg0KPiAgPiAr
ICAgICAgICAgICAhZ2V0X2NwdV9kZXZpY2UocHItPmlkKSkgew0KPiAgPiArICAgICAgICAgICAg
ICAgaW50IHJldCA9IGFyY2hfcmVnaXN0ZXJfY3B1KHByLT5pZCk7DQo+ICA+ICsNCj4gID4gKyAg
ICAgICAgICAgICAgIGlmIChyZXQpDQo+ICA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ICA+ICsgICAgICAgfQ0KPiAgPiArDQo+ICA+ICAgICAgICAgLyoNCj4gID4gICAg
ICAgICAgKiAgRXh0cmEgUHJvY2Vzc29yIG9iamVjdHMgbWF5IGJlIGVudW1lcmF0ZWQgb24gTVAg
c3lzdGVtcyB3aXRoDQo+ICA+ICAgICAgICAgICogIGxlc3MgdGhhbiB0aGUgbWF4ICMgb2YgQ1BV
cy4gVGhleSBzaG91bGQgYmUgaWdub3JlZCBfaWZmDQo+ICA+IC0tDQo+ICANCj4gIEkgYW0gc3Rp
bGwgdW5zdXJlIHdoeSB0aGVyZSBuZWVkIHRvIGJlIHR3byBwYXRocyBjYWxsaW5nDQo+ICBhcmNo
X3JlZ2lzdGVyX2NwdSgpIGluIGFjcGlfcHJvY2Vzc29yX2dldF9pbmZvKCkuDQoNCg0KVGhpcyBp
cyBiZWNhdXNlIGFsbCBDUFVzIGFyZSBleHBlY3RlZCB0byBiZSAncHJlc2VudCcgZHVyaW5nIHRo
ZSBib290IHRpbWUgZm9yIEFSTTY0IGFyY2guDQpUaGlzIGlzIG5vdCB0cnVlIGZvciB4ODYgd29y
bGQgaS5lLiB0aGUgbG9naWNhbF9jcHVpZCBjb3VsZCAgYmUgaW52YWxpZCAoYW5kIHByZXNlbnQg
bWFzayBub3QNCnNldCkgZm9yIHRoZSB4ODYgYXJjaCBkdXJpbmcgdGhlIGJvb3QgdGltZS4gIEZh
a2luZyB0aGUgJ3ByZXNlbnQnIGJlaGF2aW9yIGF0IHRoZSB2aXJ0dWFsaXplcg0KbGV2ZWwgZm9y
IEFSTSBpcyBsaWtlIGludGVyZmVyaW5nIHdpdGggdGhlIGFyY2hpdGVjdHVyZSBhbmQgdGhlbiB0
d2Vha2luZyB0aGUga2VybmVsIHRvIGZpdA0KdGhhdCB1bmF1dGhvcml6ZWQgaGFjay4gVGhpcyBo
YXMgYSBwb3RlbnRpYWwgdG8gYnJlYWsgdGhlIGV4aXN0aW5nIGFuZCBmdXR1cmUgdmVyc2lvbiBv
ZiB0aGUNCkFSTSBhcmNoLiAoQmV0d2VlbiwgSSdtIG9uZSBvZiB0aGUgaW5pdGlhbCBvZmZlbmRl
ciBvZiBkb2luZyB0aGF0IGJ1dCBsYXRlciBjb3JyZWN0ZWQgdGhlDQphcHByb2FjaCBhZnRlciBt
YW55IGRpc2N1c3Npb25zIGFuZCBLVk0gRm9ydW0gcHJlc2VudGF0aW9ucyBhbG9uZyB3aXRoIEFS
TSApDQoNClRoZXJlZm9yZSwgaW4gQVJNIHdlIGtlZXAgYWxsIHRoZSBwcm9jZXNzb3IgYXMgcHJl
c2VudCBhbmQganVzdCB1c2UgX1NUQSBlbmFibGVkIGJpdCB0bw0KZGVjaWRlIHRoZSBvbmxpbmUn
aW5nIG9mIHRoZSBwcm9jZXNzb3IgYW5kIHRoaXMgcmVxdWlyZXMgYSBzZXBhcmF0ZSBoYW5kbGlu
Zy4NCg0KDQo+ICANCj4gIEp1c3QgYmVsb3cgdGhlIGNvbW1lbnQgcGFydGlhbGx5IHB1bGxlZCBp
bnRvIHRoZSBwYXRjaCBjb250ZXh0IGFib3ZlLCB0aGVyZQ0KPiAgaXMgdGhpcyBjb2RlOg0KPiAg
DQo+ICBpZiAoaW52YWxpZF9sb2dpY2FsX2NwdWlkKHByLT5pZCkgfHwgIWNwdV9wcmVzZW50KHBy
LT5pZCkpIHsNCj4gICAgICAgICAgIGludCByZXQgPSBhY3BpX3Byb2Nlc3Nvcl9ob3RhZGRfaW5p
dChwcik7DQo+ICANCj4gICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBGb3IgdGhlIHNha2Ugb2YgdGhlIGFyZ3VtZW50LCBmb2xk
IGFjcGlfcHJvY2Vzc29yX2hvdGFkZF9pbml0KCkgaW50byBpdCBhbmQNCj4gIGRyb3AgdGhlIHJl
ZHVuZGFudCBfU1RBIGNoZWNrIGZyb20gaXQ6DQo+ICANCj4gIGlmIChpbnZhbGlkX2xvZ2ljYWxf
Y3B1aWQocHItPmlkKSB8fCAhY3B1X3ByZXNlbnQocHItPmlkKSkgew0KPiAgICAgICAgICBpZiAo
aW52YWxpZF9waHlzX2NwdWlkKHByLT5waHlzX2lkKSkNCj4gICAgICAgICAgICAgICAgICByZXR1
cm4gLUVOT0RFVjsNCj4gIA0KPiAgICAgICAgICBjcHVfbWFwc191cGRhdGVfYmVnaW4oKTsNCj4g
ICAgICAgICAgY3B1c193cml0ZV9sb2NrKCk7DQo+ICANCj4gICAgICAgICByZXQgPSBhY3BpX21h
cF9jcHUocHItPmhhbmRsZSwgcHItPnBoeXNfaWQsIHByLT5hY3BpX2lkLCAmcHItPmlkKTsNCj4g
ICAgICAgICBpZiAocmV0KSB7DQo+ICAgICAgICAgICAgICAgICAgY3B1c193cml0ZV91bmxvY2so
KTsNCj4gICAgICAgICAgICAgICAgICBjcHVfbWFwc191cGRhdGVfZG9uZSgpOw0KPiAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgfQ0KPiAgICAgICAgIHJldCA9IGFyY2hf
cmVnaXN0ZXJfY3B1KHByLT5pZCk7DQo+ICAgICAgICAgaWYgKHJldCkgew0KPiAgICAgICAgICAg
ICAgICAgIGFjcGlfdW5tYXBfY3B1KHByLT5pZCk7DQo+ICANCj4gICAgICAgICAgICAgICAgICBj
cHVzX3dyaXRlX3VubG9jaygpOw0KPiAgICAgICAgICAgICAgICAgIGNwdV9tYXBzX3VwZGF0ZV9k
b25lKCk7DQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICB9DQo+ICAg
ICAgICBwcl9pbmZvKCJDUFUlZCBoYXMgYmVlbiBob3QtYWRkZWRcbiIsIHByLT5pZCk7DQo+ICAg
ICAgICBwci0+ZmxhZ3MubmVlZF9ob3RwbHVnX2luaXQgPSAxOw0KPiAgDQo+ICAgICAgICBjcHVz
X3dyaXRlX3VubG9jaygpOw0KPiAgICAgICAgY3B1X21hcHNfdXBkYXRlX2RvbmUoKTsNCj4gIH0N
Cj4gIA0KPiAgc28gSSdtIG5vdCBzdXJlIHdoeSB0aGlzIGNhbm5vdCBiZSBjb21iaW5lZCB3aXRo
IHRoZSBuZXcgY29kZS4NCj4gIA0KPiAgU2F5IGFjcGlfbWFwX2NwdSkgLyBhY3BpX3VubWFwX2Nw
dSgpIGFyZSB0dXJuZWQgaW50byBhcmNoIGNhbGxzLg0KDQoNCldlIGNhbm5vdCBiZWNhdXNlIGxv
Z2ljYWwgY3B1LWlkIGNhbiBuZXZlciBiZSBpbnZhbGlkIGFuZCBjcHVzIGNhbg0KbmV2ZXIgYmUg
aW4gTk9UIHByZXNlbnQgc3RhdGUgb24gQVJNIGFyY2guDQoNCg0KPiAgV2hhdCdzIHRoZSBkaWZm
ZXJlbmNlIHRoZW4/ICANCg0KDQpBYm92ZSBpcyB0aGUgcHJlY2lzZSBkaWZmZXJlbmNlLiBDaGFu
Z2luZyB0aGUgYmVoYXZpb3Igb2YgJ3ByZXNlbmNlJyBpbg0KdGhlIEFSTSBhcmNoaXRlY3R1cmUg
YWZ0ZXIgYm9vdCBpcyBub3QgYWxsb3dlZC4gV2l0aCB0aGUgbGF0ZXN0IGVmZm9ydHMsIHdlDQpo
YXZlIGFkZGVkIHRoZSBjb25jZXB0IG9mICdvbmxpbmUtY2FwYWJsZScgYml0IHdoaWNoIGNhbiBo
ZWxwIGluIGRlZmVyDQpvbmxpbmUnaW5nIHRoZSBDUFVzIGJ1dCB0aGVuIHRoaXMgaXMgbm90IHNh
bWUgYXMgbm90IGJlaW5nIHByZXNlbnQgYXQgdGhlDQpib290IHRpbWUuIA0KDQoNClRoZSBsb2Nr
aW5nLCB3aGljaCBzaG91bGQgYmUgZmluZSBpZiBJJ20gbm90DQo+ICBtaXN0YWtlbiBhbmQgbmVl
ZF9ob3RwbHVnX2luaXQgdGhhdCBuZWVkcyB0byBiZSBzZXQgaWYgdGhpcyBjb2RlIHJ1bnMgYWZ0
ZXINCj4gIHRoZSBwcm9jZXNzb3IgZHJpdmVyIGhhcyBsb2FkZWQgQUZBSUNTLg0KDQpBRkFJQ1Ms
IExvY2tpbmcgbG9va3MgdG8gYmUgb2theSB0byBtZSBhcyB3ZWxsLg0KDQpCZXN0IHJlZ2FyZHMN
ClNhbGlsLg0KDQo=


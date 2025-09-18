Return-Path: <linux-pm+bounces-34975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605FB85BA9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA97561AFA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5DB30EF9D;
	Thu, 18 Sep 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="CN/+O5LW"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8030FC0F;
	Thu, 18 Sep 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210272; cv=pass; b=q+n22WrWlSiZseYmjgLfB0llsiMJ8PG3LuqvCkIkcCqq41f3qOVZ7CKu7tmogQyaauuZh4KJV2NMzJ/2/pA4LEUEiUdKiL1KbOTGv9jcgH5wcjeR3R5SNIp71g5KVkoujHBxsVD9kRmyoyxhWgTs4VC3wK3LcqoEZRCywsK2g5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210272; c=relaxed/simple;
	bh=EWJtWOApJAqtUNZAqtKfwXuK0FQDLzg3oZD2uJiAT0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJlsYoDu4UED+I6/57CozoX6RLQkBAU9VdA6N4S8/Pvfpwnm0nqHQqZZn0FlZ9pgrpjQJmRtycBg+M6yWZthu4SpDbKM4F61PgvVDoR92J4LAZThGbSc9dkg5ggUMxwUEZWiiBx0REDsKGNoOLhS43EuTq8DrbXw4M1fHzi50JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=CN/+O5LW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758210253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQ31wtIcpxCw8STZH79II4sLLqH48GbSPk9x7K3sjgfEDTbqWhe56UdHLczAOBGwsTvuzA4yd6C1sXnNYWW/AOXBZtEsE8JAY+JqBT+NS74PrlOtow+YTXkysEW8KgJ7gyTb81oVXc4MO2aKFvp++X4tVvNeMmaiLcUpWv6dFgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758210253; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EWJtWOApJAqtUNZAqtKfwXuK0FQDLzg3oZD2uJiAT0A=; 
	b=Mk0hhPC8AgIxY4OsSjbzBOCmIYT7w5V2KeaWO2jfmY1vEQGWgSQePUO1XVe2kbTcXkzRPjAf4VkT2FXa79yYP0G/GyCIqFrR3lth4H4Wv4Q17OrgqUDs3jrLD7RneKyexwnpLJTYgKpZAyeFudMhkV0bUIMGA0rIUz+VMawDFRI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758210253;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=EWJtWOApJAqtUNZAqtKfwXuK0FQDLzg3oZD2uJiAT0A=;
	b=CN/+O5LWMbOCeFyTuDGFUMPqtohJt+8vkXQb7ALmD5996AUBib+/6cHShz3rjFwU
	EgQ4d9lmHvXqafp0TCz7xs3avkbN/T+zovTX0dDN99x4j8/3r4SzuUCWObEWlZn1hrQ
	tgvYAhiu/snLjwaB6OOIK5y6nGNIjPahoWQPUE7eadiW6TH+7cqqDtQrAwqN7TNP71k
	T0HKmfp+bulWDsZJligG8rXjcD6W2ZJFvWnZurmFLePg5q3aSXuVXzxwX0b+ZyftjSi
	s37RKrGmv2LcCMUCs/CqL29Vw5uVPI7QZFdQ5Y61BaZvTBdDjDxG3AnY9mAuTu40Hw/
	Bw12ONWGsA==
Received: by mx.zohomail.com with SMTPS id 1758210250244433.79672365963904;
	Thu, 18 Sep 2025 08:44:10 -0700 (PDT)
Message-ID: <89ed15328b73b191fe152cf8559b92239b5596bd.camel@icenowy.me>
Subject: Re: [PATCH 2/2] pmdomain: thead: create auxiliary device for
 rebooting
From: Icenowy Zheng <uwu@icenowy.me>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, Sebastian
 Reichel <sre@kernel.org>, Han Gao <rabenda.cn@gmail.com>, Yao Zi
 <ziyao@disroot.org>,  linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,  linux-pm@vger.kernel.org
Date: Thu, 18 Sep 2025 23:44:02 +0800
In-Reply-To: <CAPDyKFombYNFvTsChewQ6cFY2woS+vSb1YUV0Bp_+DcigrFFXA@mail.gmail.com>
References: <20250818074906.2907277-1-uwu@icenowy.me>
	 <20250818074906.2907277-3-uwu@icenowy.me>
	 <CAPDyKFombYNFvTsChewQ6cFY2woS+vSb1YUV0Bp_+DcigrFFXA@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

5ZyoIDIwMjUtMDktMDTmmJ/mnJ/lm5vnmoQgMTI6MTQgKzAyMDDvvIxVbGYgSGFuc3NvbuWGmemB
k++8mgo+IE9uIE1vbiwgMTggQXVnIDIwMjUgYXQgMDk6NDksIEljZW5vd3kgWmhlbmcgPHV3dUBp
Y2Vub3d5Lm1lPiB3cm90ZToKPiA+IAo+ID4gVGhlIHJlYm9vdCAvIHBvd2VyIG9mZiBvcGVyYXRp
b25zIHJlcXVpcmUgY29tbXVuaWNhdGlvbiB3aXRoIHRoZQo+ID4gQU9OCj4gPiBmaXJtd2FyZSB0
b28uCj4gPiAKPiA+IEFzIHRoZSBkcml2ZXIgaXMgYWxyZWFkeSBwcmVzZW50LCBjcmVhdGUgYW4g
YXV4aWxpYXJ5IGRldmljZSB3aXRoCj4gPiBuYW1lCj4gPiAicmVib290IiB0byBtYXRjaCB0aGF0
IGRyaXZlciwgYW5kIHBhc3MgdGhlIEFPTiBjaGFubmVsIGJ5IHVzaW5nCj4gPiBwbGF0Zm9ybV9k
YXRhLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBJY2Vub3d5IFpoZW5nIDx1d3VAaWNlbm93eS5t
ZT4KPiA+IC0tLQo+ID4gwqBkcml2ZXJzL3BtZG9tYWluL3RoZWFkL3RoMTUyMC1wbS1kb21haW5z
LmMgfCAzNQo+ID4gKysrKysrKysrKysrKysrKysrKystLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MzMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcG1kb21haW4vdGhlYWQvdGgxNTIwLXBtLWRvbWFpbnMuYwo+ID4gYi9kcml2ZXJzL3Bt
ZG9tYWluL3RoZWFkL3RoMTUyMC1wbS1kb21haW5zLmMKPiA+IGluZGV4IDkwNDBiNjk4ZTdmN2Yu
LjgyODVmNTUyODk3YjAgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BtZG9tYWluL3RoZWFkL3Ro
MTUyMC1wbS1kb21haW5zLmMKPiA+ICsrKyBiL2RyaXZlcnMvcG1kb21haW4vdGhlYWQvdGgxNTIw
LXBtLWRvbWFpbnMuYwo+ID4gQEAgLTEyOSwxMiArMTI5LDM5IEBAIHN0YXRpYyB2b2lkIHRoMTUy
MF9wZF9pbml0X2FsbF9vZmYoc3RydWN0Cj4gPiBnZW5lcmljX3BtX2RvbWFpbiAqKmRvbWFpbnMs
Cj4gPiDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoH0KPiA+IAo+ID4gLXN0YXRpYyB2b2lkIHRoMTUy
MF9wZF9wd3JzZXFfdW5yZWdpc3Rlcl9hZGV2KHZvaWQgKmFkZXYpCj4gPiArc3RhdGljIHZvaWQg
dGgxNTIwX3BkX3VucmVnaXN0ZXJfYWRldih2b2lkICphZGV2KQo+ID4gwqB7Cj4gPiDCoMKgwqDC
oMKgwqDCoCBhdXhpbGlhcnlfZGV2aWNlX2RlbGV0ZShhZGV2KTsKPiA+IMKgwqDCoMKgwqDCoMKg
IGF1eGlsaWFyeV9kZXZpY2VfdW5pbml0KGFkZXYpOwo+ID4gwqB9Cj4gPiAKPiA+ICtzdGF0aWMg
aW50IHRoMTUyMF9wZF9yZWJvb3RfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdAo+ID4g
dGgxNTIwX2Fvbl9jaGFuICphb25fY2hhbikKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgIHN0cnVj
dCBhdXhpbGlhcnlfZGV2aWNlICphZGV2Owo+ID4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoCBhZGV2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCphZGV2
KSwgR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKgwqDCoMKgIGlmICghYWRldikKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoCBhZGV2LT5uYW1lID0gInJlYm9vdCI7Cj4gPiArwqDCoMKgwqDCoMKgIGFkZXYtPmRldi5w
YXJlbnQgPSBkZXY7Cj4gPiArwqDCoMKgwqDCoMKgIGFkZXYtPmRldi5wbGF0Zm9ybV9kYXRhID0g
YW9uX2NoYW47Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHJldCA9IGF1eGlsaWFyeV9kZXZpY2Vf
aW5pdChhZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHJldCA9
IGF1eGlsaWFyeV9kZXZpY2VfYWRkKGFkZXYpOwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmV0KSB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdXhpbGlhcnlfZGV2aWNlX3VuaW5p
dChhZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4g
PiArwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIGRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldChkZXYsCj4gPiB0aDE1MjBfcGRfdW5yZWdpc3Rlcl9hZGV2LAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldik7Cj4gCj4gV2UgaGF2ZSBkZXZtX2F1eGlsaWFyeV9k
ZXZpY2VfY3JlYXRlKCkgbm93LCBJIHN1Z2dlc3Qgd2UgdXNlIHRoYXQKPiBpbnN0ZWFkLgoKU2hv
dWxkIEkgc2VuZCBhIHYyIHRvIGNvbnZlcnQgdG8gdXNlIHRoaXM/Cgo+IAo+IFRoYXQgc2FpZCwg
SSB0aGluayBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGNvbnZlcnQgdGhlIHB3cnNlcS1ncHUKPiBh
dXhpbGlhcnkgZGV2aWNlIHRvIGJlIHJlZ2lzdGVyZWQgd2l0aCBkZXZtX2F1eGlsaWFyeV9kZXZp
Y2VfY3JlYXRlKCkKPiB0b28sIGJ1dCB0aGF0J3MgYSBzZXBhcmF0ZSBjaGFuZ2UsIG9mIGNvdXJz
ZS4KPiAKPiA+ICt9Cj4gPiArCj4gPiDCoHN0YXRpYyBpbnQgdGgxNTIwX3BkX3B3cnNlcV9ncHVf
aW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBhdXhpbGlhcnlfZGV2aWNlICphZGV2Owo+ID4gQEAgLTE2OSw3ICsxOTYsNyBAQCBzdGF0aWMg
aW50IHRoMTUyMF9wZF9wd3JzZXFfZ3B1X2luaXQoc3RydWN0Cj4gPiBkZXZpY2UgKmRldikKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gwqDCoMKgwqDC
oMKgwqAgfQo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIHJldHVybiBkZXZtX2FkZF9hY3Rpb25fb3Jf
cmVzZXQoZGV2LAo+ID4gdGgxNTIwX3BkX3B3cnNlcV91bnJlZ2lzdGVyX2FkZXYsCj4gPiArwqDC
oMKgwqDCoMKgIHJldHVybiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LAo+ID4gdGgxNTIw
X3BkX3VucmVnaXN0ZXJfYWRldiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2KTsKPiA+
IMKgfQo+ID4gCj4gPiBAQCAtMjM1LDYgKzI2MiwxMCBAQCBzdGF0aWMgaW50IHRoMTUyMF9wZF9w
cm9iZShzdHJ1Y3QKPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgwqDCoMKgwqDCoMKg
IGlmIChyZXQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfY2xl
YW5fcHJvdmlkZXI7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqAgcmV0ID0gdGgxNTIwX3BkX3JlYm9v
dF9pbml0KGRldiwgYW9uX2NoYW4pOwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmV0KQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfY2xlYW5fcHJvdmlkZXI7Cj4gPiAr
Cj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+IAo+ID4gwqBlcnJfY2xlYW5fcHJvdmlk
ZXI6Cj4gPiAtLQo+ID4gMi41MC4xCj4gPiAKPiAKPiBPdGhlcndpc2UgdGhpcyBsb29rcyBnb29k
IHRvIG1lIQo+IAo+IEtpbmQgcmVnYXJkcwo+IFVmZmUKCg==



Return-Path: <linux-pm+bounces-16335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD19ADA2D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF8C1F22795
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB11547C6;
	Thu, 24 Oct 2024 02:53:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FB1CD3F;
	Thu, 24 Oct 2024 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738416; cv=none; b=DZot8zSFtsbE9U6agnE0LNaq7oaYgHJI0MEyAezvFsekhUiVqiQT4P4iVm4ZfhYxyq99h4xjVTMVvn3D0eNbAsjb9DRlNgYtmX557okYmlM9WOR8UVSEALqvqsKF5e/K0pVdTEqYQvTW6lhZ2xISrADZb/gk3F89afGeRSE8Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738416; c=relaxed/simple;
	bh=Duw9fuiCd+hXpJS1T6TXy+oFVFFxDWKTh1t/vdGLpQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwXttJrwdAGKIyRMZ6nh6Z2Q5RfGUenLAEEfmVYmZdthc4yOZ4wZpTCwGaSVEzx1FGSoDM0fimPLkd8rwjn4TRNo8obs1ffM7Vf5RXmUeJyapPOBfrzDa10fOFMTuZ8Bwnp+OnFWOFSy4G8wCNMVSX5iDHbC34lB3F5K6nilw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 246d27de91b311efa216b1d71e6e1362-20241024
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_B64
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c5615546-1293-48e7-ba32-0c5c79c13f11,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:c5615546-1293-48e7-ba32-0c5c79c13f11,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:fc7e1727143b517c0abfb78800b742b6,BulkI
	D:241024105327XGBM1VDO,BulkQuantity:0,Recheck:0,SF:841|17|19|64|66|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 246d27de91b311efa216b1d71e6e1362-20241024
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1425760498; Thu, 24 Oct 2024 10:53:26 +0800
Message-ID: <b122f847b55f3ff0fe50889bb80668583a72635b.camel@kylinos.cn>
Subject: Re: [PATCH v4] USB: Fix the issue of task recovery failure caused
 by USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: stern@rowland.harvard.edu
Cc: saranya.gopal@intel.com, gregkh@linuxfoundation.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
 rafael@kernel.org,  stanley_chang@realtek.com, tj@kernel.org,
 xiehongyu1@kylinos.cn,  xy521521@gmail.com, kernel test robot
 <lkp@intel.com>
Date: Thu, 24 Oct 2024 10:53:18 +0800
In-Reply-To: <20241024024038.26157-1-duanchenghao@kylinos.cn>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
	 <20241024024038.26157-1-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQWxhbiwKClRoZSBjdXJyZW50IHBhdGNoIGhhcyBiZWVuIHRlc3RlZCBvbiA2IG1hY2hpbmVz
IGFuZCBoYXMgcGFzc2VkIHRoZQp0ZXN0cywgd2l0aCBlYWNoIG1hY2hpbmUgdW5kZXJnb2luZyA1
MDAgY3ljbGVzIG9mIHRlc3RpbmcuCgpTYXJhbnlhIGFsc28gcmVwbGllZCBpbiB0aGUgZW1haWwg
dGhhdCBzaGUgY29uZHVjdGVkIDEsNTAwIHRlc3RzIGFuZAphbGwgd2VyZSBzdWNjZXNzZnVsLgoK
ClRoYW5rcwpEdWFuIENoZW5naGFvIAoK5ZyoIDIwMjQtMTAtMjTmmJ/mnJ/lm5vnmoQgMTA6NDAg
KzA4MDDvvIxEdWFuIENoZW5naGFv5YaZ6YGT77yaCj4gV2hlbiBhIGRldmljZSBpcyBpbnNlcnRl
ZCBpbnRvIHRoZSBVU0IgcG9ydCBhbmQgYW4gUzQgd2FrZXVwIGlzCj4gaW5pdGlhdGVkLAo+IGFm
dGVyIHRoZSBVU0ItaHViIGluaXRpYWxpemF0aW9uIGlzIGNvbXBsZXRlZCwgaXQgd2lsbCBhdXRv
bWF0aWNhbGx5Cj4gZW50ZXIKPiBzdXNwZW5kIG1vZGUuIFVwb24gZGV0ZWN0aW5nIGEgZGV2aWNl
IG9uIHRoZSBVU0IgcG9ydCwgaXQgd2lsbAo+IHByb2NlZWQgd2l0aAo+IHJlc3VtZSBhbmQgc2V0
IHRoZSBoY2QgdG8gdGhlIEhDRF9GTEFHX1dBS0VVUF9QRU5ESU5HIHN0YXRlLiBEdXJpbmcKPiB0
aGUgUzQKPiB3YWtldXAgcHJvY2VzcywgcGVyaXBoZXJhbHMgYXJlIHB1dCBpbnRvIHN1c3BlbmQg
bW9kZSwgZm9sbG93ZWQgYnkKPiB0YXNrCj4gcmVjb3ZlcnkuIEhvd2V2ZXIsIHVwb24gZGV0ZWN0
aW5nIHRoYXQgdGhlIGhjZCBpcyBpbiB0aGUKPiBIQ0RfRkxBR19XQUtFVVBfUEVORElORyBzdGF0
ZSwgaXQgd2lsbCByZXR1cm4gYW4gRUJVU1kgc3RhdHVzLAo+IGNhdXNpbmcgdGhlCj4gUzQgc3Vz
cGVuZCB0byBmYWlsIGFuZCBzdWJzZXF1ZW50IHRhc2sgcmVjb3ZlcnkgdG8gbm90IHByb2NlZWQu
Cj4gLQo+IFvCoMKgIDI3LjU5NDU5OF1bIDFdwqAgUE06IHBjaV9wbV9mcmVlemUoKTogaGNkX3Bj
aV9zdXNwZW5kKzB4MC8weDI4Cj4gcmV0dXJucyAtMTYKPiBbwqDCoCAyNy41OTQ2MDFdWyAxXcKg
IFBNOiBkcG1fcnVuX2NhbGxiYWNrKCk6IHBjaV9wbV9mcmVlemUrMHgwLzB4MTAwCj4gcmV0dXJu
cyAtMTYKPiBbwqDCoCAyNy42MDM0MjBdWyAxXcKgIGVoY2ktcGNpIDAwMDA6MDA6MDQuMTogcGNp
X3BtX2ZyZWV6ZSsweDAvMHgxMDAKPiByZXR1cm5lZCAwIGFmdGVyIDMgdXNlY3MKPiBbwqDCoCAy
Ny42MTIyMzNdWyAxXcKgIGVoY2ktcGNpIDAwMDA6MDA6MDUuMTogcGNpX3BtX2ZyZWV6ZSsweDAv
MHgxMDAKPiByZXR1cm5lZCAtMTYgYWZ0ZXIgMTcyMjMgdXNlY3MKPiBbwqDCoCAyNy44MTAwNjdd
WyAxXcKgIFBNOiBEZXZpY2UgMDAwMDowMDowNS4xIGZhaWxlZCB0byBxdWllc2NlIGFzeW5jOgo+
IGVycm9yIC0xNgo+IFvCoMKgIDI3LjgxNjk4OF1bIDFdwqAgUE06IHF1aWVzY2Ugb2YgZGV2aWNl
cyBhYm9ydGVkIGFmdGVyIDE4MzMuMjgyCj4gbXNlY3MKPiBbwqDCoCAyNy44MjMzMDJdWyAxXcKg
IFBNOiBzdGFydCBxdWllc2NlIG9mIGRldmljZXMgYWJvcnRlZCBhZnRlcgo+IDE4MzkuOTc1IG1z
ZWNzCj4gLi4uLi4uCj4gW8KgwqAgMzEuMzAzMTcyXVsgMV3CoCBQTTogcmVjb3ZlciBvZiBkZXZp
Y2VzIGNvbXBsZXRlIGFmdGVyIDM0NzMuMDM5Cj4gbXNlY3MKPiBbwqDCoCAzMS4zMDk4MThdWyAx
XcKgIFBNOiBGYWlsZWQgdG8gbG9hZCBoaWJlcm5hdGlvbiBpbWFnZSwgcmVjb3ZlcmluZy4KPiBb
wqDCoCAzMS4zNDgxODhdWyAxXcKgIFBNOiBCYXNpYyBtZW1vcnkgYml0bWFwcyBmcmVlZAo+IFvC
oMKgIDMxLjM1MjY4Nl1bIDFdwqAgT09NIGtpbGxlciBlbmFibGVkLgo+IFvCoMKgIDMxLjM1NjIz
Ml1bIDFdwqAgUmVzdGFydGluZyB0YXNrcyAuLi4gZG9uZS4KPiBbwqDCoCAzMS4zNjA2MDldWyAx
XcKgIFBNOiByZXN1bWUgZnJvbSBoaWJlcm5hdGlvbiBmYWlsZWQgKDApCj4gW8KgwqAgMzEuMzY1
ODAwXVsgMV3CoCBQTTogSGliZXJuYXRpb24gaW1hZ2Ugbm90IHByZXNlbnQgb3IgY291bGQgbm90
IGJlCj4gbG9hZGVkLgo+IAo+IFRoZSAiZG9fd2FrZXVwIiBpcyBkZXRlcm1pbmVkIGJhc2VkIG9u
IHdoZXRoZXIgdGhlIGNvbnRyb2xsZXIncwo+IHBvd2VyL3dha2V1cCBhdHRyaWJ1dGUgaXMgc2V0
LiBUaGUgY3VycmVudCBpc3N1ZSBuZWNlc3NpdGF0ZXMKPiBjb25zaWRlcmluZwo+IHRoZSB0eXBl
IG9mIHN1c3BlbmQgdGhhdCBpcyBvY2N1cnJpbmcuIElmIHRoZSBzdXNwZW5kIHR5cGUgaXMgZWl0
aGVyCj4gUE1fRVZFTlRfRlJFRVpFIG9yIFBNX0VWRU5UX1FVSUVTQ0UsIHRoZW4gImRvX3dha2V1
cCIgc2hvdWxkIGJlIHNldAo+IHRvCj4gZmFsc2UuCj4gCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+IENsb3NlczoKPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9vZS1rYnVpbGQtYWxsLzIwMjQxMDE1MTcyMi5yZmp0a25Sei1sa3BAaW50ZWwuY29tLwo+
IFNpZ25lZC1vZmYtYnk6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+Cj4g
U2lnbmVkLW9mZi1ieTogRHVhbiBDaGVuZ2hhbyA8ZHVhbmNoZW5naGFvQGt5bGlub3MuY24+Cj4g
LS0tCj4gwqBkcml2ZXJzL3VzYi9jb3JlL2hjZC1wY2kuYyB8IDE1ICsrKysrKysrKysrKystLQo+
IMKgaW5jbHVkZS9saW51eC9wbS5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKy0KPiDCoDIgZmls
ZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvY29yZS9oY2QtcGNpLmMgYi9kcml2ZXJzL3VzYi9jb3JlL2hjZC1w
Y2kuYwo+IGluZGV4IGEwOGYzZjIyOGU2ZC4uMzkwYjEyMjVmM2NjIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2NvcmUvaGNkLXBjaS5jCj4gKysrIGIvZHJpdmVycy91c2IvY29yZS9oY2QtcGNp
LmMKPiBAQCAtNDIyLDcgKzQyMiwxMiBAQCBzdGF0aWMgaW50IHN1c3BlbmRfY29tbW9uKHN0cnVj
dCBkZXZpY2UgKmRldiwKPiBwbV9tZXNzYWdlX3QgbXNnKQo+IMKgwqDCoMKgwqDCoMKgwqBib29s
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRvX3dha2V1cDsKPiDCoMKg
wqDCoMKgwqDCoMKgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dmFsOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZG9fd2FrZXVwID0gUE1TR19JU19BVVRPKG1z
ZykgPyB0cnVlIDoKPiBkZXZpY2VfbWF5X3dha2V1cChkZXYpOwo+ICvCoMKgwqDCoMKgwqDCoGlm
IChQTVNHX0lTX0FVVE8obXNnKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZG9f
d2FrZXVwID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqBlbHNlIGlmIChQTVNHX05PX1dBS0VVUCht
c2cpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkb193YWtldXAgPSBmYWxzZTsK
PiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRv
X3dha2V1cCA9IGRldmljZV9tYXlfd2FrZXVwKGRldik7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKg
LyogUm9vdCBodWIgc3VzcGVuZCBzaG91bGQgaGF2ZSBzdG9wcGVkIGFsbCBkb3duc3RyZWFtCj4g
dHJhZmZpYywKPiDCoMKgwqDCoMKgwqDCoMKgICogYW5kIGFsbCBidXMgbWFzdGVyIHRyYWZmaWMu
wqAgQW5kIGRvbmUgc28gZm9yIGJvdGggdGhlCj4gaW50ZXJmYWNlCj4gQEAgLTUyMSw2ICs1MjYs
MTEgQEAgc3RhdGljIGludCBoY2RfcGNpX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQo+IMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gc3VzcGVuZF9jb21tb24oZGV2LCBQTVNHX1NVU1BFTkQpOwo+
IMKgfQo+IMKgCj4gK3N0YXRpYyBpbnQgaGNkX3BjaV9mcmVlemUoc3RydWN0IGRldmljZSAqZGV2
KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHN1c3BlbmRfY29tbW9uKGRldiwgUE1TR19G
UkVFWkUpOwo+ICt9Cj4gKwo+IMKgc3RhdGljIGludCBoY2RfcGNpX3N1c3BlbmRfbm9pcnEoc3Ry
dWN0IGRldmljZSAqZGV2KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNpX2RldsKg
wqDCoMKgwqDCoMKgwqDCoMKgKnBjaV9kZXYgPSB0b19wY2lfZGV2KGRldik7Cj4gQEAgLTU5MCw2
ICs2MDAsNyBAQCBzdGF0aWMgaW50IGhjZF9wY2lfcmVzdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYp
Cj4gwqAjZWxzZQo+IMKgCj4gwqAjZGVmaW5lIGhjZF9wY2lfc3VzcGVuZMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgTlVMTAo+ICsjZGVmaW5lIGhjZF9wY2lfZnJlZXplwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE5VTEwKPiDCoCNkZWZpbmUgaGNkX3BjaV9zdXNwZW5k
X25vaXJxwqDCoE5VTEwKPiDCoCNkZWZpbmUgaGNkX3BjaV9wb3dlcm9mZl9sYXRlwqDCoE5VTEwK
PiDCoCNkZWZpbmUgaGNkX3BjaV9yZXN1bWVfbm9pcnHCoMKgwqBOVUxMCj4gQEAgLTYyNCw3ICs2
MzUsNyBAQCBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyB1c2JfaGNkX3BjaV9wbV9vcHMgPSB7Cj4g
wqDCoMKgwqDCoMKgwqDCoC5zdXNwZW5kX25vaXJxwqDCoD0gaGNkX3BjaV9zdXNwZW5kX25vaXJx
LAo+IMKgwqDCoMKgwqDCoMKgwqAucmVzdW1lX25vaXJxwqDCoMKgPSBoY2RfcGNpX3Jlc3VtZV9u
b2lycSwKPiDCoMKgwqDCoMKgwqDCoMKgLnJlc3VtZcKgwqDCoMKgwqDCoMKgwqDCoD0gaGNkX3Bj
aV9yZXN1bWUsCj4gLcKgwqDCoMKgwqDCoMKgLmZyZWV6ZcKgwqDCoMKgwqDCoMKgwqDCoD0gaGNk
X3BjaV9zdXNwZW5kLAo+ICvCoMKgwqDCoMKgwqDCoC5mcmVlemXCoMKgwqDCoMKgwqDCoMKgwqA9
IGhjZF9wY2lfZnJlZXplLAo+IMKgwqDCoMKgwqDCoMKgwqAuZnJlZXplX25vaXJxwqDCoMKgPSBj
aGVja19yb290X2h1Yl9zdXNwZW5kZWQsCj4gwqDCoMKgwqDCoMKgwqDCoC50aGF3X25vaXJxwqDC
oMKgwqDCoD0gTlVMTCwKPiDCoMKgwqDCoMKgwqDCoMKgLnRoYXfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgPSBoY2RfcGNpX3Jlc3VtZSwKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbS5oIGIv
aW5jbHVkZS9saW51eC9wbS5oCj4gaW5kZXggOTdiMGUyMzM2M2M4Li4yYTY3NmIyY2I2OTkgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9wbS5o
Cj4gQEAgLTU3MCw3ICs1NzAsOCBAQCBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBuYW1lID0geyBc
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB7IC5ldmVudCA9Cj4gUE1fRVZFTlRfQVVUT19SRVNV
TUUsIH0pCj4gwqAKPiDCoCNkZWZpbmUgUE1TR19JU19BVVRPKG1zZynCoMKgwqDCoMKgwqAoKCht
c2cpLmV2ZW50ICYgUE1fRVZFTlRfQVVUTykgIT0gMCkKPiAtCj4gKyNkZWZpbmUgUE1TR19OT19X
QUtFVVAobXNnKcKgwqDCoMKgKCgobXNnKS5ldmVudCAmIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUE1fRVZFTlRfRlJF
RVpFIHwgUE1fRVZFTlRfUVVJRVNDRSkpCj4gIT0gMCkKPiDCoC8qCj4gwqAgKiBEZXZpY2UgcnVu
LXRpbWUgcG93ZXIgbWFuYWdlbWVudCBzdGF0dXMuCj4gwqAgKgoK



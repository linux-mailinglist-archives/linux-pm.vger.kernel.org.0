Return-Path: <linux-pm+bounces-38114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D455AC632CB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 10:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AB3AB396
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965926ED4F;
	Mon, 17 Nov 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ALUf/nVb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DE26462E;
	Mon, 17 Nov 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371873; cv=none; b=Y5LjxfDioWgmrw+Ov2rH74h+kv2glZggRf3OU7mv7+GJ8c8P9zNWgO4CvCmcGiYOjQaRNTOPkR5fWDe2AKSFePEbxd2tq2QbZC1G2m6WGz5J2ha9I3VEkiszbaG7LUkxfJkBRdveuxqGfdTsHotKYvSo7v/XsFPyHf7VsunH4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371873; c=relaxed/simple;
	bh=9QRjyk/cjVzZE8w18YoaMyF20fk/O9vAFKuOFyC2bNs=;
	h=Message-ID:Subject:From:To:CC:Date:Content-Type:MIME-Version; b=rXTK7acxmW+/6FPLvV5En9N3U81qzzI9HMZBZQpScx2XmE6F1sfLYJK/96Vz1uI4Q4up6C93U2CvmSHMe8YMPMwSKr0WrEubZpOQbgrY8sIK4tFvuYmTsB62kzxmhiopt5IctRPj4gtJVBp/PXAlwy/vR5KClC9D0mMzUakf+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ALUf/nVb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 24415c4ac39811f0b33aeb1e7f16c2b6-20251117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=9QRjyk/cjVzZE8w18YoaMyF20fk/O9vAFKuOFyC2bNs=;
	b=ALUf/nVbClnlwJd00bWlGw87jFoXT0+QmKJ4rS7Uhc29n17qjsyREXeaaSpoI13BsSsvXplAQah08pvhOd+koCth0GwqXbjskSnK+rlc3lWZT/oDcsopAKThK4bs3K93Xh12cSpnbOoN6ZEkLpos8XScWdjcoXHcdCpnRtSDe7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6f32ed18-8e83-4989-8980-c2ea03ac2c04,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:6d008692-7fd3-4c6a-836a-51b0a70fa8fb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24415c4ac39811f0b33aeb1e7f16c2b6-20251117
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ya-jou.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 769305134; Mon, 17 Nov 2025 17:31:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 17 Nov 2025 17:31:04 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Mon, 17 Nov 2025 17:31:05 +0800
Message-ID: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
Subject: [REGRESSION] PM / sleep: Unbalanced suspend/resume on late abort
 causes data abort
From: Rose Wu <ya-jou.wu@mediatek.com>
To: <rafael.j.wysocki@intel.com>, <linux-pm@vger.kernel.org>,
	<regressions@lists.linux.dev>
CC: <saravanak@google.com>, <len.brown@intel.com>, <pavel@kernel.org>,
	<linux-kernel@vger.kernel.org>, wsd_upstream <wsd_upstream@mediatek.com>,
	<linux-mediatek@lists.infradead.org>,
	=?UTF-8?Q?=E5=A3=AB=E9=A1=8F_=E9=82=B1?= <artis.chiu@mediatek.com>,
	=?UTF-8?Q?=E9=9D=96=E6=99=BA_=E9=AB=98?= <Johnny-cc.Kao@mediatek.com>
Date: Mon, 17 Nov 2025 17:31:05 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGkgUmFmYWVsIGFuZCBBbGwsDQoNCkkgYW0gcmVwb3J0aW5nIGEgcmVncmVzc2lvbiBpbnRyb2R1
Y2VkIGJ5IHRoZSBjb21taXQNCjQ0MzA0NmQxYWQ2NjYwN2YzMjRjNjA0YjlmYmRmMTEyNjZmYThh
YWQgKFBNOiBzbGVlcDogTWFrZSBzdXNwZW5kIG9mDQpkZXZpY2VzIG1vcmUgYXN5bmNocm9ub3Vz
KSwgd2hpY2ggY2FuIGxlYWQgdG8gYSBrZXJuZWwgcGFuaWMgKGRhdGENCmFib3J0KSBpZiBhIGxh
dGUgc3VzcGVuZCBhYm9ydHMuDQpUaGUgY29tbWl0IG1vZGlmaWVzIGxpc3QgaGFuZGxpbmcgZHVy
aW5nIHN1c3BlbmQuIFdoZW4gYSBkZXZpY2Ugc3VzcGVuZA0KYWJvcnRzIGF0IHRoZSAibGF0ZSIg
c3RhZ2UsIGBkcG1fc3VzcGVuZGVkX2xpc3RgIGlzIHNwbGljZWQgaW50bw0KYGRwbV9sYXRlX2Vh
cmx5X2xpc3RgLg0KVGhpcyBjcmVhdGVzIGFuIGltYmFsYW5jZS4gRGV2aWNlcyBvbiB0aGlzIGxp
c3QgdGhhdCBoYWQgbm90IHlldA0KZXhlY3V0ZWQgYHBtX3J1bnRpbWVfZGlzYWJsZSgpYCBpbiBg
ZGV2aWNlX3N1c3BlbmRfbGF0ZSgpYCBhcmUgbm93DQppbmNvcnJlY3RseSBzdWJqZWN0ZWQgdG8g
YHBtX3J1bnRpbWVfZW5hYmxlKClgIGR1cmluZyB0aGUgc3Vic2VxdWVudA0KYGRldmljZV9yZXN1
bWVfZWFybHkoKWAgc2VxdWVuY2UuDQoNClRoaXMgY2F1c2VzIHR3byBpc3N1ZXM6DQoNCjEuIE51
bWVyb3VzIGVycm9yIG1lc3NhZ2VzIGluIGRtZXNnOiAiQXR0ZW1wdCB0byBlbmFibGUgcnVudGlt
ZSBQTSB3aGVuDQppdCBpcyBibG9ja2VkLiINCjIuIEEgY3JpdGljYWwgZmFpbHVyZSBmb3Igc2lt
cGxlLWJ1cyBkZXZpY2VzOiBXaGVuDQpgc2ltcGxlX3BtX2J1c19ydW50aW1lX3Jlc3VtZSgpYCBp
cyBjYWxsZWQgZm9yIGEgZGV2aWNlIHdob3NlIGJ1cyBpcw0KYE5VTExgLCB0aGUga2VybmVsIGF0
dGVtcHRzIHRvIGFjY2VzcyB0aGUgbnVsbCBidXMgc3RydWN0LCB0cmlnZ2VyaW5nIGENCmRhdGEg
YWJvcnQuDQoNClN0ZXBzIHRvIFJlcHJvZHVjZToNCg0KVGhlIGlzc3VlIGNhbiBiZSByZWxpYWJs
eSByZXByb2R1Y2VkIGJ5IGZvcmNpbmcgYSBsYXRlIHN1c3BlbmQgdG8NCmFib3J0Lg0KDQoxLiBB
cHBseSB0aGUgZm9sbG93aW5nIG1vZGlmaWNhdGlvbiB0byB0aGUgYGRldmljZV9zdXNwZW5kX2xh
dGUoKWANCmZ1bmN0aW9uIHRvIHNpbXVsYXRlIGEgd2FrZXVwIGV2ZW50Og0KLS0tIGEvZHJpdmVy
cy9iYXNlL3Bvd2VyL21haW4uYw0KKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYw0KQEAg
LTE1NjgsNyArMTU2OCw3IEBAIHN0YXRpYyBpbnQgZGV2aWNlX3N1c3BlbmRfbGF0ZShzdHJ1Y3Qg
ZGV2aWNlDQoqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUsIGJvb2wgYXN5bg0KIAlpZiAoYXN5bmNf
ZXJyb3IpDQogCQlnb3RvIENvbXBsZXRlOw0KIA0KLQlpZiAocG1fd2FrZXVwX3BlbmRpbmcoKSkg
ew0KKwlpZiAoMSkgeyAvKiBGb3JjZSBhYm9ydCBmb3IgdGVzdGluZyAqLw0KIAkJYXN5bmNfZXJy
b3IgPSAtRUJVU1k7DQogCQlnb3RvIENvbXBsZXRlOw0KIAl9DQoyLiBUcmlnZ2VyIGEgc3lzdGVt
IHN1c3BlbmQuDQozLiBUaGUgc3lzdGVtIHdpbGwgYXR0ZW1wdCB0byBzdXNwZW5kLCBhYm9ydCBh
dCB0aGUgbGF0ZSBzdGFnZSwgYW5kDQp0aGVuIHRyaWdnZXIgdGhlIGRhdGEgYWJvcnQgZHVyaW5n
IHRoZSByZXN1bWUgc2VxdWVuY2UuDQoNCkNhbGwgVHJhY2U6DQoNClVuYWJsZSB0byBoYW5kbGUg
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MNCjAwMDAw
MDAwMDAwMDAwMDgNCnBjIDogWzB4ZmZmZmZmZTM5ODhlODFlNF0gc2ltcGxlX3BtX2J1c19ydW50
aW1lX3Jlc3VtZSsweDFjLzB4OTANCmxyIDogWzB4ZmZmZmZmZTM5OGE4NDhkMF0gcG1fZ2VuZXJp
Y19ydW50aW1lX3Jlc3VtZSsweDQwLzB4NTgNCg0KQXMgYSBwb3RlbnRpYWwgZml4LCBJIGFtIHdv
bmRlcmluZyBpZiBhIGNvbmRpdGlvbmFsIGNoZWNrIGlzIG5lZWRlZCBpbg0KYGRldmljZV9yZXN1
bWVfZWFybHkoKWAgYmVmb3JlIGludm9raW5nIGBwbV9ydW50aW1lX2VuYWJsZSgpYCBmb3IgYQ0K
ZGV2aWNlPw0KDQpCZXN0IFJlZ2FyZHMsDQpSb3Nl



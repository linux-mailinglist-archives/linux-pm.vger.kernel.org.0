Return-Path: <linux-pm+bounces-43388-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBK+GZRKpWn17wUAu9opvQ
	(envelope-from <linux-pm+bounces-43388-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 09:30:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF51D4A5C
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 09:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E15C43005316
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAE383C72;
	Mon,  2 Mar 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="yVZjGLsC"
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E482E414;
	Mon,  2 Mar 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440206; cv=none; b=ENhPFKHmZVv31FmjIgZ8YxHGNhPMsqDqBe/sJ2pGIhq0UPO7lQFFkaAalBotnRtrGPOFSMESjUdULyO8TS2aipi2OK3VtAdVL+TMmJanxVNb0aPWkpx7ke+B03fPG53VY/iBbQL0CspH+1LxU4rhzQbX0skcvPq1i6uU26F6WjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440206; c=relaxed/simple;
	bh=umlwZBWplzk4fzVwI0YfaCGjtS3lIFTZNo9jxaL1c7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4qaVSxtA+oMXWGTy2HQZ7LDvS3kYFjEngjfpuBGinqFr6pCLydvDoa9SWFE9z8p7024pYzeyQAbIfh8CyFuJwDbcplphhdUt5G7xBP4lWJrFOlJd9Kmvb4j2zBwShh7YRqUdxYt91paFqiVnFqe+1agpUJjDeKa31RYXFCjszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=yVZjGLsC; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 6228Rual056518;
	Mon, 2 Mar 2026 16:27:56 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fPX8z6pHxz2PKf9X;
	Mon,  2 Mar 2026 16:26:59 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 2 Mar 2026
 16:27:55 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.048; Mon, 2 Mar 2026 16:27:55 +0800
From: =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= <Xuewen.Yan@unisoc.com>
To: Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        "xuewen.yan94@gmail.com" <xuewen.yan94@gmail.com>
Subject: =?utf-8?B?5Zue5aSNOiBGQUlMRUQ6IFBhdGNoICJQTTogc2xlZXA6IGNvcmU6IEF2b2lk?=
 =?utf-8?B?IGJpdCBmaWVsZCByYWNlcyByZWxhdGVkIHRvIHdvcmtfaW5fcHJvZ3Jlc3Mi?=
 =?utf-8?Q?_failed_to_apply_to_6.18-stable_tree?=
Thread-Topic: FAILED: Patch "PM: sleep: core: Avoid bit field races related to
 work_in_progress" failed to apply to 6.18-stable tree
Thread-Index: AQHcqeVdg+aiKUJfWEy4SPmQC5CCyrWa6KQA
Date: Mon, 2 Mar 2026 08:27:55 +0000
Message-ID: <bb8e350aa4354de8b4efa9f8aacd6f36@BJMBX01.spreadtrum.com>
References: <202603020138.6221cujX035744@SHSPAM01.spreadtrum.com>
In-Reply-To: <202603020138.6221cujX035744@SHSPAM01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 6228Rual056518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1772440087;
	bh=umlwZBWplzk4fzVwI0YfaCGjtS3lIFTZNo9jxaL1c7Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=yVZjGLsCaHoT3wdyJ3RwLGHeER5CKAJnzDZXcLJKvBSP/jwnwH27sXlytD/zO3obL
	 JGNmpHSdsHoUwEhKLLVwOqvdCD8yZnxfFIUl69SBFSpDw24bbdzR9acSxEuLiVFFmS
	 96bAbix13OFnE3gHj3iUjrwraTthTj+2auxNOKsyet1Ffe+lv6O/Mo2HnoGDffn20c
	 3Ch0FeHOr1cB03Wx4dZfJ6dzvnRB3VxnxIR4QveOshTiFjk32lkm0K9h0rlJzjnAOD
	 0Npgksb5PlxXBR+NwAJirQj4XRPEiPP4g+8TWclSnS7DAQXA2TQnbdGaLlL5/fFe6T
	 Vo/qBxBoPBX0g==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[unisoc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[unisoc.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43388-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,unisoc.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Xuewen.Yan@unisoc.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[unisoc.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7AF51D4A5C
X-Rspamd-Action: no action

SGkgU2FzaGEsDQoNClRoaXMgcGF0Y2ggc2hvdWxkIHByZWZlcmFibHkgYmUgbWVyZ2VkIGludG8g
dGhlIDYuMTgtc3RhYmxlIGJyYW5jaC4NCg0KVGhhbmtzIQ0KDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2
LS0tLS0NCuWPkeS7tuS6ujogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPiANCuWPkemA
geaXtumXtDogMjAyNuW5tDPmnIgx5pelIDk6MTcNCuaUtuS7tuS6ujogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZzsg6Zer5a2m5paHIChYdWV3ZW4gWWFuKSA8WHVld2VuLllhbkB1bmlzb2MuY29tPg0K
5oqE6YCBOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBs
aW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogRkFJTEVEOiBQYXRjaCAiUE06IHNsZWVw
OiBjb3JlOiBBdm9pZCBiaXQgZmllbGQgcmFjZXMgcmVsYXRlZCB0byB3b3JrX2luX3Byb2dyZXNz
IiBmYWlsZWQgdG8gYXBwbHkgdG8gNi4xOC1zdGFibGUgdHJlZQ0KDQoNCg0KDQpUaGUgcGF0Y2gg
YmVsb3cgZG9lcyBub3QgYXBwbHkgdG8gdGhlIDYuMTgtc3RhYmxlIHRyZWUuDQpJZiBzb21lb25l
IHdhbnRzIGl0IGFwcGxpZWQgdGhlcmUsIG9yIHRvIGFueSBvdGhlciBzdGFibGUgb3IgbG9uZ3Rl
cm0gdHJlZSwgdGhlbiBwbGVhc2UgZW1haWwgdGhlIGJhY2twb3J0LCBpbmNsdWRpbmcgdGhlIG9y
aWdpbmFsIGdpdCBjb21taXQgaWQgdG8gPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Lg0KDQpUaGFu
a3MsDQpTYXNoYQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0gb3JpZ2luYWwgY29tbWl0IGluIExpbnVz
J3MgdHJlZSAtLS0tLS0tLS0tLS0tLS0tLS0NCg0KRnJvbSAwNDkxZjNmOWY2NjRlN2UwMTMxZWI0
ZDJhOGIxOWM0OTU2MmU1YzY0IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogWHVld2Vu
IFlhbiA8eHVld2VuLnlhbkB1bmlzb2MuY29tPg0KRGF0ZTogV2VkLCA0IEZlYiAyMDI2IDEzOjI1
OjA5ICswMTAwDQpTdWJqZWN0OiBbUEFUQ0hdIFBNOiBzbGVlcDogY29yZTogQXZvaWQgYml0IGZp
ZWxkIHJhY2VzIHJlbGF0ZWQgdG8gIHdvcmtfaW5fcHJvZ3Jlc3MNCg0KSW4gYWxsIG9mIHRoZSBz
eXN0ZW0gc3VzcGVuZCB0cmFuc2l0aW9uIHBoYXNlcywgdGhlIGFzeW5jIHByb2Nlc3Npbmcgb2Yg
YSBkZXZpY2UgbWF5IGJlIGNhcnJpZWQgb3V0IGluIHBhcmFsbGVsIHdpdGggcG93ZXIud29ya19p
bl9wcm9ncmVzcyB1cGRhdGVzIGZvciB0aGUgZGV2aWNlJ3MgcGFyZW50IG9yIHN1cHBsaWVycyBh
bmQgaWYgaXQgdG91Y2hlcyBiaXQgZmllbGRzIGZyb20gdGhlIHNhbWUgZ3JvdXAgKGZvciBleGFt
cGxlLCBwb3dlci5tdXN0X3Jlc3VtZSBvciBwb3dlci53YWtldXBfcGF0aCksIGJpdCBmaWVsZCBj
b3JydXB0aW9uIGlzIHBvc3NpYmxlLg0KDQpUbyBhdm9pZCB0aGF0LCB0dXJuIHdvcmtfaW5fcHJv
Z3Jlc3MgaW4gc3RydWN0IGRldl9wbV9pbmZvIGludG8gYSBwcm9wZXIgYm9vbCBmaWVsZCBhbmQg
cmVsb2NhdGUgaXQgdG8gc2F2ZSBzcGFjZS4NCg0KRml4ZXM6IGFhN2E5Mjc1YWI4MSAoIlBNOiBz
bGVlcDogU3VzcGVuZCBhc3luYyBwYXJlbnRzIGFmdGVyIHN1c3BlbmRpbmcgY2hpbGRyZW4iKQ0K
Rml4ZXM6IDQ0MzA0NmQxYWQ2NiAoIlBNOiBzbGVlcDogTWFrZSBzdXNwZW5kIG9mIGRldmljZXMg
bW9yZSBhc3luY2hyb25vdXMiKQ0KU2lnbmVkLW9mZi1ieTogWHVld2VuIFlhbiA8eHVld2VuLnlh
bkB1bmlzb2MuY29tPg0KQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wbS8y
MDI2MDIwMzA2MzQ1OS4xMjgwOC0xLXh1ZXdlbi55YW5AdW5pc29jLmNvbS8NCkNjOiBBbGwgYXBw
bGljYWJsZSA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gWyByanc6IEFkZGVkIHN1YmplY3QgYW5k
IGNoYW5nZWxvZyBdDQpMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvQ0FCOGlwa19WWDJW
UG03MDZKd2ExPThOU0E3X2J0V0wyaWVYbUJnSHIySmNVTEVQNzZnQG1haWwuZ21haWwuY29tDQpT
aWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L3BtLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3BtLmggYi9pbmNsdWRlL2xpbnV4L3BtLmggaW5kZXggOThhODk5ODU4ZWNlZS4uYWZjYWFhMzdh
ODEyNiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcG0uaA0KKysrIGIvaW5jbHVkZS9saW51
eC9wbS5oDQpAQCAtNjgxLDEwICs2ODEsMTAgQEAgc3RydWN0IGRldl9wbV9pbmZvIHsNCiAgICAg
ICAgc3RydWN0IGxpc3RfaGVhZCAgICAgICAgZW50cnk7DQogICAgICAgIHN0cnVjdCBjb21wbGV0
aW9uICAgICAgIGNvbXBsZXRpb247DQogICAgICAgIHN0cnVjdCB3YWtldXBfc291cmNlICAgICp3
YWtldXA7DQorICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIHdvcmtfaW5fcHJvZ3Jlc3M7
ICAgICAgIC8qIE93bmVkIGJ5IHRoZSBQTSBjb3JlICovDQogICAgICAgIGJvb2wgICAgICAgICAg
ICAgICAgICAgIHdha2V1cF9wYXRoOjE7DQogICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAg
IHN5c2NvcmU6MTsNCiAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgbm9fcG1fY2FsbGJh
Y2tzOjE7ICAgICAgLyogT3duZWQgYnkgdGhlIFBNIGNvcmUgKi8NCi0gICAgICAgYm9vbCAgICAg
ICAgICAgICAgICAgICAgd29ya19pbl9wcm9ncmVzczoxOyAgICAgLyogT3duZWQgYnkgdGhlIFBN
IGNvcmUgKi8NCiAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgc21hcnRfc3VzcGVuZDox
OyAgICAgICAgLyogT3duZWQgYnkgdGhlIFBNIGNvcmUgKi8NCiAgICAgICAgYm9vbCAgICAgICAg
ICAgICAgICAgICAgbXVzdF9yZXN1bWU6MTsgICAgICAgICAgLyogT3duZWQgYnkgdGhlIFBNIGNv
cmUgKi8NCiAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgbWF5X3NraXBfcmVzdW1lOjE7
ICAgICAgLyogU2V0IGJ5IHN1YnN5c3RlbXMgKi8NCi0tDQoyLjUxLjANCg0KDQoNCg0K


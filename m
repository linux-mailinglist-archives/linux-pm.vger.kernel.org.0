Return-Path: <linux-pm+bounces-27439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B43ABE8CE
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 03:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95B3174D7E
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5EF13E02D;
	Wed, 21 May 2025 01:05:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BD433D1;
	Wed, 21 May 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789531; cv=none; b=cM0784nNgAh1JasTXq9wMWxOx8vdlfBEDQABG8CeIWMLJh+qe2FB7joWyJ8zA3G6acpHLTkJBDBIojouH6B79gP1zCcfDFNf1dZnhmaS2Qkyb1TrWQUPvWfIYhzkcTrvUmmyqQ8W3zj5wm/LzUOiN46tQdGk8L8XJyS/+xMnJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789531; c=relaxed/simple;
	bh=TuQEPklr/elKA3WJnQO6vCe1xfFFk7i3mgwQZ8uZuAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6rD/2wE4KxhDG8mxQkBiYW2XBGkAz3xjU5Ke13kO9y3l/BaIyTtOKFne9p/OrgcnubQ0qv+qJUSuXyCkQMfgC0tRHhWd54XIGg/FwoozZEFtbVhcu0zTwe182QXFlqm5xMHVELPw9wEciaP/PhneIc9nQIYUwuJMND601X7awg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b2Csr06Bjz27hjp;
	Wed, 21 May 2025 09:06:08 +0800 (CST)
Received: from kwepemh500007.china.huawei.com (unknown [7.202.181.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B4FF140276;
	Wed, 21 May 2025 09:05:19 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (7.202.194.97) by
 kwepemh500007.china.huawei.com (7.202.181.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 May 2025 09:05:19 +0800
Received: from kwepemk500012.china.huawei.com ([7.202.194.97]) by
 kwepemk500012.china.huawei.com ([7.202.194.97]) with mapi id 15.02.1544.011;
 Wed, 21 May 2025 09:05:19 +0800
From: "yubowen (H)" <yubowen8@huawei.com>
To: David Laight <david.laight.linux@gmail.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Zhanjie
	<zhanjie9@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"lihuisong (C)" <lihuisong@huawei.com>, "zhenglifeng (A)"
	<zhenglifeng1@huawei.com>, cenxinghai <cenxinghai@h-partners.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBjcHVmcmVxOiBVcGRhdGUgc3NjYW5mKCkgdG8ga3N0?=
 =?gb2312?Q?rtouint()?=
Thread-Topic: [PATCH] cpufreq: Update sscanf() to kstrtouint()
Thread-Index: AQHbyIz8BzWarTGXpkKCJGBgg/5qC7PZ99QAgAJPziA=
Date: Wed, 21 May 2025 01:05:18 +0000
Message-ID: <943bdb6ace1f4b92b9f26e78d7efbe30@huawei.com>
References: <20250519070938.931396-1-yubowen8@huawei.com>
 <20250519224648.41f2460d@pumpkin>
In-Reply-To: <20250519224648.41f2460d@pumpkin>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgRGF2aWQsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQpJIHRoaW5rIHNpbmNlIHJlYWRp
bmcgdGhlIGZyZXF1ZW5jeSB2YWx1ZSBnaXZlcyBvbmx5IHZhbHVlIGFuZCBub3QgdW5pdCwgdGhl
IGlucHV0IHNob3VsZCBzdGF5IGNvaGVyZW50IGFuZCBvbmx5IHRha2UgbnVtYmVycyBhcyB2YWxp
ZCBpbnB1dCBpbnN0ZWFkIG9mIGFjY2VwdGluZyBhbGwgdXNlciBpbnB1dCB3aXRoIG51bWJlcnMg
YXQgdGhlIGJlZ2lubmluZy4gSW4gYWRkaXRpb24sIHByZXZpb3VzIHBhdGNoZXMgaGF2ZSBjaGFu
Z2VkIG90aGVyIHBsYWNlcyB0aGF0IHVzZWQgc3NjYW5mKCkgaW4gdGhpcyBmaWxlIGFuZCBpdCBp
cyBiZXR0ZXIgdG8gc3RheSBjb25zaXN0ZW50Lg0KDQpXb3VsZCB5b3Ugc2F5IHRoYXQgdGhpcyBt
YWtlcyBzZW5zZT8NCg0KQmVzdCByZWdhcmRzLA0KDQpCb3dlbiBZdQ0KDQotLS0tLdPKvP7Urbz+
LS0tLS0NCreivP7IyzogRGF2aWQgTGFpZ2h0IDxkYXZpZC5sYWlnaHQubGludXhAZ21haWwuY29t
PiANCreiy83KsbzkOiAyMDI1xOo11MIyMMjVIDU6NDcNCsrVvP7IyzogeXVib3dlbiAoSCkgPHl1
Ym93ZW44QGh1YXdlaS5jb20+DQqzrcvNOiByYWZhZWxAa2VybmVsLm9yZzsgdmlyZXNoLmt1bWFy
QGxpbmFyby5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBaaGFuamllIDx6aGFu
amllOUBoaXNpbGljb24uY29tPjsgSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBo
dWF3ZWkuY29tPjsgbGlodWlzb25nIChDKSA8bGlodWlzb25nQGh1YXdlaS5jb20+OyB6aGVuZ2xp
ZmVuZyAoQSkgPHpoZW5nbGlmZW5nMUBodWF3ZWkuY29tPjsgY2VueGluZ2hhaSA8Y2VueGluZ2hh
aUBoLXBhcnRuZXJzLmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0hdIGNwdWZyZXE6IFVwZGF0ZSBzc2Nh
bmYoKSB0byBrc3RydG91aW50KCkNCg0KT24gTW9uLCAxOSBNYXkgMjAyNSAxNTowOTozOCArMDgw
MA0KQm93ZW4gWXUgPHl1Ym93ZW44QGh1YXdlaS5jb20+IHdyb3RlOg0KDQo+IEluIHN0b3JlX3Nj
YWxpbmdfc2V0c3BlZWQoKSwgc3NjYW5mIGlzIHN0aWxsIHVzZWQgdG8gcmVhZCB0byBzeXNmcy4N
Cj4gTmV3ZXIga3N0cnRveCBwcm92aWRlIG1vcmUgZmVhdHVyZXMgaW5jbHVkaW5nIG92ZXJmbG93
IHByb3RlY3Rpb24sIA0KPiBiZXR0ZXIgZXJyb3JoYW5kbGluZyBhbmQgYWxsb3dzIGZvciBvdGhl
ciBzeXN0ZW1zIG9mIG51bWVyYXRpb24uIEl0IGlzIA0KPiB0aGVyZWZvcmUgYmV0dGVyIHRvIHVw
ZGF0ZSBzc2NhbmYoKSB0byBrc3RydG91aW50KCkuDQoNClRoaXMgaXMgYSBVQVBJIGNoYW5nZS4N
ClNpbmNlIHRoZSB2YWx1ZSBpcyBhIGZyZXF1ZW5jeSB0aGVyZSBjb3VsZCBlYXNpbHkgYmUgc2Ny
aXB0cyB0aGF0IGFwcGVuZCBIeiB0byB0aGUgdmFsdWUuDQpZb3UncmUgbWFraW5nIHRoZW0gZmFp
bC4NCg0KCURhdmlkDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJvd2VuIFl1IDx5dWJvd2VuOEBo
dWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgfCA2ICsrKy0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVm
cmVxL2NwdWZyZXEuYyANCj4gaW5kZXggYmU3MjdkYTBiZTRkLi4wYzg0MmVkZDFhNzYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMNCj4gKysrIGIvZHJpdmVycy9jcHVm
cmVxL2NwdWZyZXEuYw0KPiBAQCAtOTIwLDkgKzkyMCw5IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3Jl
X3NjYWxpbmdfc2V0c3BlZWQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksDQo+ICAJaWYg
KCFwb2xpY3ktPmdvdmVybm9yIHx8ICFwb2xpY3ktPmdvdmVybm9yLT5zdG9yZV9zZXRzcGVlZCkN
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gLQlyZXQgPSBzc2NhbmYoYnVmLCAiJXUiLCAm
ZnJlcSk7DQo+IC0JaWYgKHJldCAhPSAxKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwlyZXQg
PSBrc3RydG91aW50KGJ1ZiwgMCwgJmZyZXEpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICANCj4gIAlwb2xpY3ktPmdvdmVybm9yLT5zdG9yZV9zZXRzcGVlZChwb2xpY3ksIGZy
ZXEpOw0KPiAgDQoNCg==


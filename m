Return-Path: <linux-pm+bounces-38152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D5C68378
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C52B4F1A8C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553952877D7;
	Tue, 18 Nov 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Uq3h2piF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE430ACEA;
	Tue, 18 Nov 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454682; cv=none; b=fA9vwNNp/AebThLa7gHY+UA2eskcs3xkoau0wQde/ugYM3hIA2yKdneFIV0NuKghxfFOl1W9Ho5as3d+oMevJ52otL+Z/ZPkgujuUSVoNN3cfo8kAT2nWgh5PYj6ZD+Vz2ED+cu9stqLbE2GNgeS35z0yFPXy/GyqKkVmsS05sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454682; c=relaxed/simple;
	bh=ftxHiNrtC+ti7V8R2Zi43QPvXWdUXaFm0pDBk/+vdC8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GL5LJIMrd56jR0iQPSr3Irr9i1EJbQxoBaCaJahoAAGFvBwbll61DRwrrsvWLvG7ZssDUv9fomguuXzNpWrBXPFd8vFZSzbq16swVFi23v/TPEtsU7GpUjGa9A1mZIYxh+9H6QbWTPXpobNGbJ4ZeiMTBhzRlmIEBqiWs94AngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Uq3h2piF; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef86c38ec45811f08ac0a938fc7cd336-20251118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ftxHiNrtC+ti7V8R2Zi43QPvXWdUXaFm0pDBk/+vdC8=;
	b=Uq3h2piFTZHcXCAfnM/BRZGrgCHSPP+I75AEPPf4LGUQOx/AhhA7vYwcAsCNHjRi1T/U80xysI5ZmGCcVWl/ArUFry5CdIGyr8ZmJn3MxMz3cbTWefeX3f17xhZIacl+B5l22/3FX1nGtSNhhKdV6P8MHijsLMIhTVa7y2zv1+0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1be82f83-b2e4-448c-8fad-def3a6e1b89c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:91ab0558-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ef86c38ec45811f08ac0a938fc7cd336-20251118
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ya-jou.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 994463458; Tue, 18 Nov 2025 16:31:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 18 Nov 2025 16:31:09 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 18 Nov 2025 16:31:09 +0800
Message-ID: <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
Subject: Re: [PATCH v1] PM: sleep: core: Fix runtime PM enabling in
 device_resume_early()
From: Rose Wu <ya-jou.wu@mediatek.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>
CC: <rafael.j.wysocki@intel.com>, <regressions@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, wsd_upstream <wsd_upstream@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, artis.chiu <artis.chiu@mediatek.com>,
	Johnny-cc.Kao <Johnny-cc.Kao@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 16:31:08 +0800
In-Reply-To: <5940388.DvuYhMxLoT@rafael.j.wysocki>
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
	 <CAJZ5v0jjQgoa8eRyQ-MVQW=FeOEVQP6YTsY7o49LV2wnO=xEDw@mail.gmail.com>
	 <5940388.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGksDQoNCk9uIE1vbiwgMjAyNS0xMS0xNyBhdCAxOTo1NyArMDEwMCwgUmFmYWVsIEouIFd5c29j
a2kgd3JvdGU6DQo+IA0KPiBNYWtlIHR3byBjaGFuZ2VzIHRvIGFkZHJlc3MgdGhpcyBwcm9ibGVt
Lg0KPiANCj4gRmlyc3QsIHJlb3JkZXIgZGV2aWNlX3N1c3BlbmRfbGF0ZSgpIHRvIG9ubHkgZGlz
YWJsZSBydW50aW1lIFBNIGZvciBhDQo+IGRldmljZSBpZiB0aGUgcG93ZXIuaXNfbGF0ZV9zdXNw
ZW5kZWQgZmxhZyBpcyBnb2luZyB0byBiZSBzZXQgZm9yIGl0Lg0KPiBJbiBhbGwgb2YgdGhlIG90
aGVyIGNhc2VzLCBkaXNhYmxpbmcgcnVudGltZSBQTSBmb3IgdGhlIGRldmljZSBpcyBub3QNCj4g
aW4gZmFjdCBuZWNlc3NhcnkuDQo+IA0KPiBTZWNvbmQsIG1ha2UgZGV2aWNlX3Jlc3VtZV9lYXJs
eSgpIG9ubHkgZW5hYmxlIHJ1bnRpbWUgUE0gZm9yIHRoZQ0KPiBkZXZpY2VzIHdpdGggdGhlIHBv
d2VyLmlzX2xhdGVfc3VzcGVuZGVkIGZsYWcgc2V0Lg0KPiANCg0KTXkgY29uY2VybiBpcyB3aXRo
IHRoZSBlcnJvciBwYXRoIGluIGRldmljZV9zdXNwZW5kX2xhdGUoKS4NCklmIGEgZGV2aWNlIGZh
aWxzIGl0cyBkcG1fcnVuX2NhbGxiYWNrKCksIGl0IGFwcGVhcnMgdGhhdCBpdHMNCnBvd2VyLmlz
X2xhdGVfc3VzcGVuZGVkIGZsYWcgaXMgbm90IHNldCwgcG90ZW50aWFsbHkgbGVhdmluZyBpdHMg
cnVudGltZQ0KUE0gZGlzYWJsZWQgZHVyaW5nIHRoZSByZXN1bWUgc2VxdWVuY2UuDQoNClJlZ2Fy
ZHMsDQpSb3Nl



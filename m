Return-Path: <linux-pm+bounces-24440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61056A6D350
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 04:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D639816DDF0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C416CD33;
	Mon, 24 Mar 2025 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T0rhMDyd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NMszDIYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FB2EB1D;
	Mon, 24 Mar 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742786486; cv=fail; b=CYBiENlcLhjGxjlfv+dKewlw+viUjkcj6fHcjTSKQ9uO028/pxIuGKumQrjudCUeMN+p2wBpDzumi/y8ZgMMXMxj71gIV1vjnv758t3DFjAFSpEjDk4War+mSmaDUCzGGyMyewVmdhDZWfZOjGbEgrxKzkkvWwxeM0ZotTBHfTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742786486; c=relaxed/simple;
	bh=fmVLvnc9S29jSWT92Lv7S+pjkMYqYzpiXk+gSv+0+ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0pANlgZcZZEZHA/qJ1cQTINobiEd73oQs9aEGV4XwXbRLSsN7yRCLtZa7RWKPcrDMqUhBCf5NUr4QqEabAjx7otogh5xHGuvCxNFNYtOJu/yWtweYmzeYZ/lbOmcFaZ1hvSGslXnslpaJCgjTadWOvgynJKqWQInFJ6TtEnD4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T0rhMDyd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NMszDIYj; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 096bc3be085f11f08eb9c36241bbb6fb-20250324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fmVLvnc9S29jSWT92Lv7S+pjkMYqYzpiXk+gSv+0+ks=;
	b=T0rhMDydbe7BLaKkJ9bj2sWi5HV6cAeNNfDQfAIgejLSxU7h0fvQwGfsSfRf34gIUvdSGRMvghCI2/+D40MhzHJmm3OmJKdKAPpCHFqx/v+FDh7U0Hc8jq+EDHj1k7Ix7V2QnSI8TJldWgLojqyqvF3pE85YoQeyIyfE1k8VCGU=;
X-CID-CACHE: Type:Local,Time:202503241121+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:30a5844d-f68b-43df-9284-a6eea4aea206,IP:0,UR
	L:0,TC:0,Content:4,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:4
X-CID-META: VersionHash:0ef645f,CLOUDID:b680bd8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 096bc3be085f11f08eb9c36241bbb6fb-20250324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2031182060; Mon, 24 Mar 2025 11:21:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 24 Mar 2025 11:21:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 24 Mar 2025 11:21:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjip3z1kPQ+k4IQ9c2C+Sn0//APjC3Lf7f4U1sg/Qdxc58iRInMXu1VF0Y80Pq4DC49MRcWfY0yHY1T8UFVlTNSQMZquG5A82YhKgmK3ry5pD8Fxwg4QThGC+6/qFcwDeDXQD2jtXtwZyDdDQ1iTFPta+wIaQO7nigaX126AGU2wm34hdn7RygX01wi4O/tIlAsNmOu1pKwb94Z+NaqjQR5JL/7dY02bUDfL7kNDxvW2EORbFeyuwEd8W1Xz0P35bBvTrxjm8+cd4Bkwm0ZbnKhd91OHX6rW8z4LBV/Xe21OdN/VE2+OgbM6VqQwgiDzjXvNOxBgT3Y9CDMGGU3Fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmVLvnc9S29jSWT92Lv7S+pjkMYqYzpiXk+gSv+0+ks=;
 b=MxfLMI0ZuScomDCkdExvDXMZ3Y8rHb+ZFUulIPUcwYW8sgqRYC+EQz/wvUBRyl8fRfveIuytgbNA/tOx3/dq+AQTlWo7JiUHcguV0nEGtmofXKMqijn/GwhKdgEIecwsiI931MQhjZuWwwZVbQxA8divCV5c4VUj8uLWwJMInvHDGI9xV5fE1z/qIMMYXwDsJ8DcvnASU4HfNUAhXcaY+qCezvfWYn17y5u9wU3m4VMQmDo9OLtme8W7ZPyeT96/dWbKw+KdKK2brSFGED2lRGGw0oUs2EKk7MYtd0yEOrcK0AGfNG61y4HDcV1hzwwZEpaC/Y5mvYIh1n6yYGPaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmVLvnc9S29jSWT92Lv7S+pjkMYqYzpiXk+gSv+0+ks=;
 b=NMszDIYjgR9e5OsqJpPwyv+b4iheQteDUmNr6VkpuaF0qJTCWZlgqaQ5lHatttf11dZ5xPsLszL5PycQRUATnYE1BtszXwMMixke/cpa32HO/jG5sq84/dx5WLJ9OOMn/ihngX8CEohEvfusE6d5rtbnaEORUbAYoqRFDMJuY5U=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by JH0PR03MB8114.apcprd03.prod.outlook.com (2603:1096:990:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 03:21:06 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 03:21:05 +0000
From: =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?=
	<Chun-Jen.Tseng@mediatek.com>
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "rafael@kernel.org"
	<rafael@kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "myungjoo.ham@samsung.com"
	<myungjoo.ham@samsung.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kyungmin.park@samsung.com"
	<kyungmin.park@samsung.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Thread-Topic: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Thread-Index: AQHbfrQ2e/+qwhbOe0mntrlJoHcSLbNOJJ+AgC3AXICAAVjNAIAACfiAgAAITgCABIoWAA==
Date: Mon, 24 Mar 2025 03:21:05 +0000
Message-ID: <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
	 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
	 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
	 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
	 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
	 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
	 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
In-Reply-To: <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|JH0PR03MB8114:EE_
x-ms-office365-filtering-correlation-id: 326f3ca1-3dbf-49e6-ccb1-08dd6a82e99c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0NJeWE4aTA5dHp6NGJ0M1dFZ0VqTm1qUzZQT3lkMlJwWFN0dTd3N1RmUmFD?=
 =?utf-8?B?RURWN2ttMEw1ZmgzWXA4L21GMEd4MVNZeDk0bGdyR1M3N3VNWWYzNkVtLzZO?=
 =?utf-8?B?R1hEL3pJRmdJTnk4ZytoNXY5MkZ4ODI1aVFEWndxamsrQnFxT0M2K0c0dVJR?=
 =?utf-8?B?Q2x6VlVtVXV2YkwzajRnSDZRcDVKb1RGenBvcUdKL2hTaGRLUnBGcDF5dDF5?=
 =?utf-8?B?UHRubTByOVE5TG1VZ3hlM05QL2xuc25NTXNZUkMvK3ZOclJwczI4cVhVMC84?=
 =?utf-8?B?RG5naHpEY1JoZ1NKM3ZmQTBqWFZBS2VPUE52WWVzTndYSEVoMUhPaTM5d1pP?=
 =?utf-8?B?R0dRcmtEZDg0U0crbUZwSHM3Q3hpcFV2ZzNPTC80ckEzbTNYb3BKMFJXNFJv?=
 =?utf-8?B?MGlTQ05yZ0pVa0VpM3NVQ1ZDUzNmaFh0TnFZeSsrNHE2QTlJb011cG5ibk9o?=
 =?utf-8?B?NDhJOEFaTnBQelYzZ0RsMkUyNFIxWFB2ZG9mc1NnRWlSNENhT1Q4TWovMkVB?=
 =?utf-8?B?N0ZFaDNBU1A3MG5WcTNtTWVBUFJ6Qk85SG1zeEk2NW9tOVBtb05wbWpicHBB?=
 =?utf-8?B?Q2tvY2Z2RXQxYWJrVnlDeVBIMW9Ua2ppd1F4Y0FuM1FtdFFRQjZMc0QrcjR0?=
 =?utf-8?B?UnFEcDl3QVZLM0syTklrTERwNUtOejU0Yk9MVmlZQituUEl5bkwxeDRwNXdX?=
 =?utf-8?B?ZUdCSXQ4UmtPVStHK2E1b1RiMENtMjBQNkh3Ym1SYU1RSHZtTGg3RHVNMVEz?=
 =?utf-8?B?MEQwQjNxLzRwU2FrVHE0dmFlaEFYNWR6cy81STFobmg0VXlJVjlOemZsajA5?=
 =?utf-8?B?c1QzczBKa3I4aVlVc0lVQ1JwK1RrbEI5SVhweTM4T1FPQ0xXZEd0MGtKUUhQ?=
 =?utf-8?B?bjNRdmIrMFB2Qnd0UXFvUDhmTEdKbERRdDVJT3FSVzV6TjRaVjg3d0tldnVV?=
 =?utf-8?B?cHFTMjlhcFRjbmpRMlZBRlliRFR5SVFXSkdlKzZyZnRrN2R0a2RKbHo4SHpY?=
 =?utf-8?B?T0pYamt6ZjdmK0tFL281UWMyS3lLakJieU41b1NvazhkVDZpU09mdUlkMDJR?=
 =?utf-8?B?dTJ5Q1B0SC9wRVBmUWltakx3TGZNV3FRSHV0L09zZXZjekM5MnRRV1FNd2Zu?=
 =?utf-8?B?TDVhTDJWSnJESktlNDFiNTlUak5HRkFSYjlhVmhTRkZmUThRcmorZVU3RU5H?=
 =?utf-8?B?RUxmK044SVhlcUdzVUtYS2gwYlU2VDVTVWd3Qkk0MmVJNjA5ZVh5dUtmMUR6?=
 =?utf-8?B?K3dselY1Ymx4UER4TnBzOTlCajRMLzk2OGJNbWR0SWY4T2lJdjVJangyU29x?=
 =?utf-8?B?VUhFMGpid091Y1V4QXloUjJpa3lSSHlta2NMT2o1cWlYUHlxV2VEa3FzWGpW?=
 =?utf-8?B?VDFnL25mWGtqeURvUnNBaWdTQmhzVkVwY0tWNjAycHRrUS9ISVN5R2p0eU4y?=
 =?utf-8?B?VkplcGRVRm1DUjZhZHdBMzc5ckp1dU44VTdTbk92NS9OdGd4dzBlWTZ4bGZY?=
 =?utf-8?B?RjVsVm4wVzRLeURJd2lFanlwMDVGTjFiTjVrVEVtUVZHdUJRUC9hTUh4V2F3?=
 =?utf-8?B?ZU9EZFI3ZWttVG50dEhTdmpRREJWMDVWUG84bzJlbS85eFNnOXNxUXZXZFJP?=
 =?utf-8?B?SGJWaXNxbXNrR1ZHbkc1ZHhodnUrNjlaL3ZlbTRNNWdIV0dvalE3SkN6QXZ0?=
 =?utf-8?B?TVU0Vm1WM24zRVk0OCs5bTg4RitET01jRmZKaWUzamsvc3g3eDB3empLZHJw?=
 =?utf-8?B?djV2TjZ4N3ZiZUN6aUFtUWFNT2tqWnlaNUlaR2hyZ3ZXaVhMeXlvaFhDV0ha?=
 =?utf-8?B?ZTJLOFFwNi9oc3RMczRheWhBL3krbnF1dkY2S0xhWG9tTjVRUTR2d1J5SDE5?=
 =?utf-8?B?S2l2ZGJRRjFpNjJvSndDemVDTzhTQXpocUlVQ09SZGdKOUZPVXJpdWNRSEc0?=
 =?utf-8?B?SEd0QkZoRkNpWHVBVm9iOVBvK2hMUWdVOG5hdXlVbGdHbHFZbkdpZXQ2cUQ1?=
 =?utf-8?Q?tkwX/BiF9nexmfKuH9TZYtB5FyRZP4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1dBNXErZmxxTi9kVWp6eGNxMDVMQk0wRUUzQ0RxZ1UwSlRRWktzaVVuN0ZG?=
 =?utf-8?B?aDNpRVdZZWJGZVhrWjhKUWY1aGFFS3RRMGVvS0ZkTGZuaEdFRUVETkJkd2Yy?=
 =?utf-8?B?dVoxcFZMT3lGVXRIVVpLUTI0WllLU3B3ZnNldFZnakdGZkUrQkg1QUtOaW81?=
 =?utf-8?B?dDJ2OGJicXA0dWNSUFZocVppZUNnUEJnT2dOanpoRjV3TEkycVRWSjA2R25Q?=
 =?utf-8?B?YmV2YlJpWjI1T3JYa3dlTjdENVRLdWQvRy9Oait3MXJybE91ZWtjMTkwWklO?=
 =?utf-8?B?QllYTXplTVlrL2RwcmtjRkxDM0I3ckQ2RVFhVGlIYUlMeUdqYTJWMmgzK1VU?=
 =?utf-8?B?WnB2ZmI0aHdwSmVmdXp6bkR2L0Z0VEt2b1ZnSWhsaFhXYW9US2E0dmhISTZT?=
 =?utf-8?B?dldjZDNHVjU3NzNIU3g0aXdzblZIZFpqUDdnTXpSVnJQWU11ZE55ZjlTTk0r?=
 =?utf-8?B?OWd3SDcrRzI0SkVGSzJucnZrWGxtOXloTlpyenFIbjQrZDYwOWdMNnRqa3Nj?=
 =?utf-8?B?ZElpV2hWZW5xaVZyS0xycE1MWGRxUWFXaVBaNzJlNm5IeC9NR0UvcFQ5K2dF?=
 =?utf-8?B?WlRBZW9oUkxVaUFmYWhaaVJqU0NneS9XQWlka2syNUQ3TE5wdnBMemwyeUV2?=
 =?utf-8?B?cFNPSlpNQ25Zb01idE5NRThHQmRXWkFuMUtBTFA5ZVlDWGRtQUpWU1hmUWFE?=
 =?utf-8?B?YjV1RHo2SmdQMGxXR1BKQVpOaGhCZzNWZUhrcnAySDF1bnBUODhqb3B1Ymsy?=
 =?utf-8?B?N0RJYkJ4OHphallpNEF2S2h2Sk5nSW1FTit0QVREWUJxdEl0WU5JN1E3azl2?=
 =?utf-8?B?bjljcVBYNFFUbnVXUzdmZUF3N2VjMURDdlhjVGljQ3djMytmRUtwTzZYOXpx?=
 =?utf-8?B?cFQydVBpL2t4Y2NVOUV3RytwdWJaZWplS3dncUxPZVpQMXVLTE4wbTNhQmNr?=
 =?utf-8?B?L045WnFhM1ZIZWtHY3gzci8wRzQ2ajJOWTAxa2VMdUhCS01IamFoQ2ZILytH?=
 =?utf-8?B?TmdyK250blp2aHhvaUtSLzBXYTFIK1Zma1lzVGpqVm12Z2ZmeVdSWG1WenF1?=
 =?utf-8?B?aDBqTjV6b2l3UHd4b3FKbnpCYVRkNDNZRldUdlNyWldJWWdTOC9lUG1pT1ND?=
 =?utf-8?B?ZDJkTVV1MDdmVkY0WFNVZGdVNGFoZ0YzYlN0QStoNVFaVWN1S3ZLbVZIK1VC?=
 =?utf-8?B?ZVU2K2hmZFRaS0s5dW5MSWF1RGZMdGRJeml3VFRpc202SHZhbFhMcUhmd2pI?=
 =?utf-8?B?bmd1bU9YVHp5UzVkd3JlV0hORmhxTkVxbG05QzFxZGxaSjcyb0tRTmFtQnNq?=
 =?utf-8?B?RENOcHVsMTM2NmVJb2hkcXNWR2c1eXJJemFZTXhza3BRVFRML1hmRDJHVlZR?=
 =?utf-8?B?aUFjeEgwcHJ1a3VMOE1Hc3QwVWE5cjJkVnFYdXBrMzdHVlZKQWk1bFB1Tm5j?=
 =?utf-8?B?U0x3WXpXNUZFTjdveXhvdU94dE5wbWw4UGoyZFo2L0dvdGhMdEp1WmRkbSth?=
 =?utf-8?B?TEpwaHZiUjdBb2t3bjhJOEVtTkZSMFRjU1gvNHUyTmpMcTZSWDdOaHl4UUFl?=
 =?utf-8?B?MjVSbGFpSzR4TnkvSWxMUm1TYXdiaWo3aUFmODRjVmxpd2x3ZWQ5WVUwanhH?=
 =?utf-8?B?c29tS01ONFRWRDZWdUhiMjFIV3E3aW02WlFIUUxybmIzNktHdExVRThIdHF3?=
 =?utf-8?B?ZGEycHFSZnlHSzh2c1pJTTd2TWk5UUdmYkZxYTQzWm12dEp5RG1aRG9tYjhI?=
 =?utf-8?B?U3cvc2dGcEZKY290Z3BZbGFmMFBKYnhPZnNja2o2SkdjS2x5U3h0blFkYXBF?=
 =?utf-8?B?MzRYN2RySGFROWlXVGNuKzl0dE9HRDZSZVhQcjEwNm5sczhyMExtTmlhZjhv?=
 =?utf-8?B?aWx0d3dsK1JTbWl5ZHJieTFBUWhBK1p4RDVXYU5wK0xuRW1FWWZld2dPQVFW?=
 =?utf-8?B?QWxzQ2tEOStTYUdnbm9pNTJ1NTRjbFBCTStyRHplTjh2M1I5ekYyK1A0Yzd2?=
 =?utf-8?B?SStKc21pMXYvdVRnQVhUWnZtVS9kU21HekFqV1JGTU5BMEFaOWExZ1JiUDlt?=
 =?utf-8?B?NWg1amlFR3NvMHo2RFFqYjdjOWdIQkRSWXE3RUNqVE1IUVNWRDl3V2QxMkF0?=
 =?utf-8?B?bmp5eTNWZFdrQklLWmVhM1hCSzdoNnJkcFEzVFVNSlFyWUIvOCtCUGQ5V1l4?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CEFE0CA75A3B34BAFB7AB326541FF38@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326f3ca1-3dbf-49e6-ccb1-08dd6a82e99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 03:21:05.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY3W42kubJlXlbowMInOV6DVFCkVL/5sN8xYYL+hahmWWcRbTPyZMNfy2cavRgcAlB8kbshPKpdmx88/6rRHn7MIGeTNZjfbD1Hfa7dyx94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8114

SGkgdmlyZXNoLA0KDQpJIHRoaW5rIHRoZSBiZXN0IGNvbmZpZ3VyYXRpb24gc2VxdWVuY2UgaXMg
YXMgZm9sbG93czoNCiAgY3B1ZnJlcSBwb2xpY3kgLT4gc2V0IGZyZXF1ZW5jeSAtPiBDQ0kgZ292
ZXJub3IgZ2V0DQpDUFVGUkVRX1BPU1RDSEFOR0UgTkIgLT4gY2hvb3NlIENDSSBmcmVxdWVuY3kg
LT4gc2V0IENDSSBmcmVxdWVuY3kNCg0KSG93ZXZlciwgaW4gZHJpdmVycy9kZXZmcmVxL2dvdmVy
bm9yX3Bhc3NpdmUuYyNMNzcsDQpnZXRfdGFyZ2V0X2ZyZXFfd2l0aF9jcHVmcmVxKCkgcmV0cmll
dmVzIHRoZSBjdXJyZW50IGZyZXF1ZW5jeSBvZiBlYWNoDQpwb2xpY3ksDQphbmQgaXQgZGV0ZXJt
aW5lcyB0aGUgQ0NJIGZyZXF1ZW5jeSBiYXNlZCBvbiB0aGUgZnJlcXVlbmN5IG9mIGVhY2gNCnBv
bGljeS4NCg0KQnV0IGlmIHBvbGljeS0wIGFuZCBwb2xpY3ktNiBlbnRlciBzaW11bHRhbmVvdXNs
eSwgdGhlIENDSSBnb3Zlcm5vcg0KbWlnaHQgZ2V0IGFuIGluY29ycmVjdCBmcmVxdWVuY3kuDQoN
CmNwdWZyZXEgcG9saWN5LTAgLT4gc2V0IGZyZXF1ZW5jeSAtPiBDQ0kgZ292ZXJub3IgZ2V0DQpD
UFVGUkVRX1BPU1RDSEFOR0UgTkIgLT4gY2hvb3NlIENDSSBmcmVxdWVuY3kgLT4gc2V0IENDSSBm
cmVxdWVuY3kNCj0+IGR1cmluZyB0aGlzIHRpbWUsIHRoZSBDQ0kgZ292ZXJub3IgZ2V0cyBwb2xp
Y3ktMCBhbmQgcG9saWN5LTYsIEJVVA0KcG9saWN5LTYgbWF5IGNoYW5nZSBmcmVxdWVuY3kgYnkg
Y3B1ZnJlcSBkcml2ZXIgYXQgdGhlIHNhbWUgdGltZS4NCg0KVGhlcmVmb3JlLCBJIHdhbnQgdG8g
Y2hhbmdlIGl0IHNvIHRoYXQgb25seSBvbmUgcG9saWN5IGNhbiBwZXJmb3JtIHRoZQ0Kc2V0IGZy
ZXF1ZW5jeSBhY3Rpb24gYXQgYSB0aW1lIHRvIGF2b2lkIENDSSBydW5uaW5nIGF0IHRoZSB3cm9u
Zw0KZnJlcXVlbmN5Lg0KDQpCUnMsDQoNCk1hcmsgVHNlbmcNCg0KT24gRnJpLCAyMDI1LTAzLTIx
IGF0IDExOjMxICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFp
bCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0K
PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+
IE9uIDIxLTAzLTI1LCAwNTozMiwgQ2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSkgd3JvdGU6DQo+
ID4gSSBhZGQgYSBnbG9iYWwgbG9jayByZWxhdGVkIHRvIHRoZSBDQ0kgZHJpdmVyLg0KPiA+IA0K
PiA+IFRoaXMgaXMgYmVjYXVzZSB0aGUgQ0NJIG5lZWRzIHRvIG9idGFpbiB0aGUgZnJlcXVlbmNp
ZXMgb2YgcG9saWN5LTANCj4gPiBhbmQNCj4gPiBwb2xpY3ktNiB0byBkZXRlcm1pbmUgaXRzIG93
biBmcmVxdWVuY3kuDQo+ID4gDQo+ID4gSWYgcG9saWN5LTAgYW5kIHBvbGljeS02IGFyZSBzZXQg
c2ltdWx0YW5lb3VzbHksIGl0IG1heSBjYXVzZSB0aGUNCj4gPiBDQ0kNCj4gPiB0byBzZWxlY3Qg
dGhlIHdyb25nIGZyZXF1ZW5jeS4NCj4gPiANCj4gPiBUaGVyZWZvcmUsIEkgaG9wZSB0byBjaGFu
Z2UgdGhlIHNldHRpbmcgZmxvdyB0byB0aGUgZm9sbG93aW5nOg0KPiA+IMKgwqAgcG9saWN5LTAg
b3IgcG9saWN5LTYgLT4gc2V0IGZyZXF1ZW5jeSAtPiBDQ0kgcmVjZWl2ZXMNCj4gPiBub3RpZmlj
YXRpb24gLQ0KPiA+IHNldCBDQ0kgZnJlcXVlbmN5DQo+IA0KPiBDYW4geW91IHBsZWFzZSBwb2lu
dCB0byB0aGUgY29kZSB3aGVyZSB0aGlzIHJhY2UgZXhpc3RzID8gSSBhbSBub3QNCj4gc3VyZSBJ
IGZ1bGx5IHVuZGVyc3RhbmQgaXQgYXMgb2Ygbm93LiBJZiB0aGUgcmFjZSBpcyBwcmVzZW50IGlu
DQo+IGFub3RoZXIgZHJpdmVyLCBDQ0kgPywgdGhlbiBzaG91bGRuJ3QgaXQgYmUgZml4ZWQgdGhl
cmUgaW5zdGVhZCA/DQo+IA0KPiAtLQ0KPiB2aXJlc2gNCg0K


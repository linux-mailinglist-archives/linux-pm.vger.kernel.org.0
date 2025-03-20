Return-Path: <linux-pm+bounces-24330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB041A6A13B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 09:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851D81669BF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA45221DBD;
	Thu, 20 Mar 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LHwN6VMP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nQtl8nl2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044B21129E;
	Thu, 20 Mar 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458949; cv=fail; b=OJJ9V5zqazHY1LHXYu2U/Ecfmm/mUSRkeUWTSa3CFtloQYIrv3mbk2fjGMA71SAHVwxiQEA3EH+yc+ZpHUDQFFRl7R8zcnqqSIrdQ/PxUx3VWsF+d597hqc8nCV3YhsYRvQTEVa5iAcUbGX3KG20n8PWPoQw8uR+mFwQiSBqgu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458949; c=relaxed/simple;
	bh=/n524x1/SkUkc6Yf088Hr1OG0oxJxNwQSeMrhCjphVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YpT+KgoO1QQVIELYXPSFIPxF3VEbFsttFc2I4oGQper3s6XjQ1SOpfzr8vbwzGBsUzm3mxMIYG7olj+MAoMmWV1mum7A9u8/jLfaurHfCKjU/7yNXXhWc9d6y/7m4bfUwUibtUfspLUobrZPDWZhG+nDsxqwu5wIr27OsNG4FhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LHwN6VMP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nQtl8nl2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 73bcba0a056411f0aae1fd9735fae912-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/n524x1/SkUkc6Yf088Hr1OG0oxJxNwQSeMrhCjphVs=;
	b=LHwN6VMPxIDxeXc0yIP5MbXh+CNMO10VGdGV+sQCB/mzaHb5Kji/ufXiNpAWgkLmR7T2hmVHstVKnnhtVzmtBkA5UB7PU/W5qWFoX6qx09iu1EmGitPkVFJKjm5pHdfBJamgt2qPKSXJ6mmsH/a0448ICONGuA9okSxhXsM/4Ro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:5a5fd1d3-73c3-4489-86e9-d6def7b4fba5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:48a894c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 73bcba0a056411f0aae1fd9735fae912-20250320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 312734015; Thu, 20 Mar 2025 16:22:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 16:22:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 16:22:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8dDrtl8dS1TCDQ2l0ugBZUGsH91ciZgndva94tAgmSIgtAi3YBHeHpeKnz7CIGBDzQUStksfFb96gIXgFQWMuubrewsK3edxpsLTdJ2W3lDbNG7pnbQR5y4/Xd2LbyoI3io6CXzABGfjzs+perCnOFH/CdIlgCdCYNTS3CK5cdQpZ9VUaL+Oz3qlNp1b7GTh9L7H6aCstDMakcdrVa7a5xGBbhRIs81bVZxWplFxWJmiUIcj7xgJePNWrhr5SjSosEYnActvrctaoZ0IzsFpQXZzDkJoqlEY6HCdUBphetkvr82ErJsHZRuq7HVjRh9+ZrLme4zwwYSCf09AiKKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n524x1/SkUkc6Yf088Hr1OG0oxJxNwQSeMrhCjphVs=;
 b=BJtjYynxRcqEjy3/DAJmis0CDqWaCyjWbeXQFddlcVXQP15TViJ+2Gw1i/NZJLXLAX+tN6JYn22R1mQ6lCMxaFptB1gv5ipAB14zjL8gwhmo1QOJeqZaaJoc5L37Jhopqy0BSDG7zZOZq/hxq7LQuBfaIGenBrVrwMlU3UxUoFTneXGFqmPn0b/qbbS5Ghaai0qUJB395vvQbfLNnyjsTwHjiw8klbw1OPe+IwZ+wYipaMkPEuUkgocFsAM5GYNUGY2eYgd3wIXaOusRvirlFgedrMb+3bykFdsSTFYXPUDh1+YY5Y1bEBNre0w87Gfe16zBoeFHaDfB9TiZBCN/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n524x1/SkUkc6Yf088Hr1OG0oxJxNwQSeMrhCjphVs=;
 b=nQtl8nl26XxV9GYvwWNmPfPfd7hJpZfWY0Npmmbo+41ykgjkQ+lvXDRPLJpz6TLJ+jbV1mY3FS7+jY6l7kTs0HS89ovC9sj/Pdtl8xqLP9OzHIJ1tLe3EAKDx4baoxsOKiHMLeOAKYglwvFzTPmlykS38YKH2UzIsfPSJLqfv9Y=
Received: from KL1PR0302MB5347.apcprd03.prod.outlook.com (2603:1096:820:4a::9)
 by TYSPR03MB7652.apcprd03.prod.outlook.com (2603:1096:400:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:22:20 +0000
Received: from KL1PR0302MB5347.apcprd03.prod.outlook.com
 ([fe80::b331:56a8:9e40:34e5]) by KL1PR0302MB5347.apcprd03.prod.outlook.com
 ([fe80::b331:56a8:9e40:34e5%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:22:20 +0000
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
Thread-Index: AQHbfrQ2e/+qwhbOe0mntrlJoHcSLbNOJJ+AgC3AXIA=
Date: Thu, 20 Mar 2025 08:22:20 +0000
Message-ID: <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
	 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
	 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
In-Reply-To: <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0302MB5347:EE_|TYSPR03MB7652:EE_
x-ms-office365-filtering-correlation-id: f543a6b7-f466-4795-6634-08dd67885574
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmgveHZoQ1haRFRMb3pnMEd4dURLTXZlYUlteFgyenRSV1BwcytXU3VQZUNB?=
 =?utf-8?B?K2Ewczd0UDdRbWVIY1J1QXlQaGhwM1oxTFJ2WTJISHMxemtjNXJQYnl1M0dN?=
 =?utf-8?B?dnI3T2RTUHFqZFBaMlFuVHc0eENkeEVjZ0VUdXlGSmI2WTZiMG51OXEwWU5S?=
 =?utf-8?B?UHpzRXRyV011T2hvZDFuaHJhTFIzUktHRnRPdmNRRUR1TWxlNEgrWnM4OGtG?=
 =?utf-8?B?RkdGUEF4SHVraTdjSllFRHNGYWVMajdEbkpDRkZvWTh2QUptK0V6dDJwQWdN?=
 =?utf-8?B?TGV5OTFrSDJnTjBDdVRxdDdnamp1VFVzSnF1VXV3YXVPK2pYYnM3L3R4VURx?=
 =?utf-8?B?U1hlTnNTMCtpOVZjeXFtNm85RklHa09wNERZbmxwd0k3TksxZ2t1eUdiWXpx?=
 =?utf-8?B?ME5YdFJNcys3clZZZnhZU09aeFhHbUtGYVUwSlFadldLUVFuVzdhUDc5aU1r?=
 =?utf-8?B?STRWa3M2N3hJUFd1VmlZMVkvNDhBNUNUM0VKM0M1Rm9MWTBNNVVFSFcyakls?=
 =?utf-8?B?SGtRT2hZUEZvUS9LT1NyTk1OOTdQZzFlcElONXNRa0owV0Y2T1p1em8wa3ZD?=
 =?utf-8?B?UTlKeDdPK2FJWUF4UkxDSEx6dmNGVkdTaGtkOVhSbUF0c0YrdkFRVVZRT1pK?=
 =?utf-8?B?UXJuVHc0YmJEVUpDTEVybytZd244eGtSdWdSMlZYV3JGUnlkaFk1a1RvWG9T?=
 =?utf-8?B?Ym9ISHJTcWN5UERra1h1MEwxZXdHRm1RNWRDQTZvYVlYcnFHNW1WYkhNY0xz?=
 =?utf-8?B?UCtXMHk4MGNpcS9HMU1PTWQwNkh3MHJ1QTRHaU9zb1llN1JrRjVSaFdCRjNj?=
 =?utf-8?B?U1pWTkpoVnNuc0t5QXpUcGZ1MEtCRUUzZXJPNThzOVljQS9acWpGRnEyRkp4?=
 =?utf-8?B?WG54WXlJenZUN1pZMWdHUnF6RnRJbTR1ZzZIZXdUeXVhWVFGZjNNWG4xSE5V?=
 =?utf-8?B?VndsWUlMcDRqSXRwU09CK2V1V0FaVU1FT1NXV0hVWVFDb2FTU0J0Q3JLcmVn?=
 =?utf-8?B?eFp5dDJDUVZpYmU2Q2Y5OU1peVNWNW5laUNHS1dRaEE1bXRMWlNMRGdac29x?=
 =?utf-8?B?NVpFRzMwczYrMFEvdm1ReWt3VGxmWlhIWTY1Q01ISUs1elVtTGJHa0FHS0FX?=
 =?utf-8?B?RURraU9RclgrdmExV1cxQnpJZXdJYk1ydUY2eUY5K0l6eEFUVG9Yb3M2czFR?=
 =?utf-8?B?aVlxcDZPWHdrWWNLQ1MyT2I3SFMvaW1salNsbEFlUks4dFNvc0dHMnVwdEM3?=
 =?utf-8?B?TmM3RSs3UjUrNmJML0lnQll0SUhjdlo3UFFDSXA0SUMrazVUUGEvNHRrWVAz?=
 =?utf-8?B?MnpMekIySDhJQjBxYnYwUHRPYm5QektqU2U3RzB6bG5BRFlpaXdseXdhU2lt?=
 =?utf-8?B?WlFqQ0thRCtEaGZod2R3eTkyZk1uWnh4UG1DSmVHa2c2bU1sVy9TTVNCOHhB?=
 =?utf-8?B?cWNuT3dIQmkrbi9weFNmVms3UGE0UWRxS3dpeUcwQUNRSXRiV0FIY2FtL2VG?=
 =?utf-8?B?UFRPdUNveU1tMGFaYUNhRmNLOEd2VUlraEpZWFkxT3l5YnJzK1hWMUxtYWdT?=
 =?utf-8?B?alFIRXNDckNyMk5uenB0TlpzTXBhaWhRT1VaVWQ1NWpuYjRsbWFZR2RIREMr?=
 =?utf-8?B?MlBGbUpETENlV0xrSlEvY202c3NvaGxSRXIzaWkySm5jRlRrcHVaVFJRc25F?=
 =?utf-8?B?TkV3WDRkMHZPenV0YkgzcnVscWJqNTNscmlkRmVqZWRFUmFvY1Ntb285bFd1?=
 =?utf-8?B?bjA2S0JXenF1eE1WLzhibzM2OTlERTAyVHNtMjFpdUdhc1g0ZksyQm5PSklI?=
 =?utf-8?B?b3d5NGZINkptSUJZVWxhNTB1emx4YTNQOHQ0SDBRZ0VDY2dPNnFCcDBibnlF?=
 =?utf-8?B?VUpmekxyMTlORVhCVm1CYkt5aFlsZmR1K1pkaVMrZVZBcjhXNFhpVEcreitv?=
 =?utf-8?B?OUhPNUdBckxWOEI4SXdzMS83bndFcXIyWHh2NDJxMHAxRmluM3ZldHN2WDF4?=
 =?utf-8?Q?NyK1M7ygYWgdVjHK1UwA8Jrcc+i1E4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0302MB5347.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmwxWFR3eExYQ1RmbDI1dFRwaVJqVE1iVDBwRHQ3V0xsa3paV0ZXa1Q4bVVS?=
 =?utf-8?B?NXVLV3p3VytuazNWNjR1NXhhOTE2aE9XVEhZenFsdE5qdFFOclFzbnVXOTAx?=
 =?utf-8?B?V3dFMGxlZ1poVHNpOERqUGlYenRZNjlRdDJTZmJGRCt1cGZnQnFXT2dTNTI4?=
 =?utf-8?B?UGpCWU12cHJaTlM1VjhhNm1GNkMyRFRvbXlsMk9uN1A2QWV6NUtuRHpKWkNF?=
 =?utf-8?B?c0EybWhqYUk2Z3RoeXhSMGJQQzVScENzMlAwWmxsMWdUTlZrVTVXQXk1VFg0?=
 =?utf-8?B?MXd5RzNsK1R0N2VmczluR0IyOTNIQ2llTUtqNnhCVDRjdkh0cUJ1Wm5vQldh?=
 =?utf-8?B?dzFyNTcvbEdOUmYrQTNvdW5VS0dyQ0xxRnl3aGhrbXBBbDdwbWtrVjJySTM0?=
 =?utf-8?B?ZmtCSUtwK3ovVW1lMmcyNUcvMEgrTVI5RWFwWHpIUGExRTlKMUJOazZXSStw?=
 =?utf-8?B?elI2L2Z4OGdza1dJeUlvU0Nra3FUQWxqVEk1N3RIbzZJSzJQbFdHUWtvQjVm?=
 =?utf-8?B?NXNyOEhDSlhGcXlSSUN2R1ZIdlpXSGw5MXZ1ODFSRjZqZXE2NU92VVhxcTF6?=
 =?utf-8?B?UmJtSXRjMnJNdXJ4QmRFYzJYRXNSa0xxd1dlRC9BeEc5eUxnVjM3M3RPRzYy?=
 =?utf-8?B?RUUxbkdQYnRvRWNWKzlraWsyWVYxNVVqdTdIbEtROEhwY1JQNUZZekpieVB5?=
 =?utf-8?B?eVdTY012ZWxGeTA4T3VaSEhWTlVKajdUcFdNcDZaR2dvdFltN0xScGNqTUFE?=
 =?utf-8?B?VlFlbklKK0cyUUVpY2V2djdoTU9EaUxCZ1ZMd3FyQitCSW9XYmRqeVZJRXBX?=
 =?utf-8?B?MDNydUtsU3VRcThlSnd2L090MXBVSnE4YndpNGVvQzFBU0FNZ1BrUDl1cGJj?=
 =?utf-8?B?VFAwWkhuZ0VOS1NuYWdHNlNEUVo2Qk55V3NSTGcxYVNPTElKRHh5Q0xMMXNu?=
 =?utf-8?B?bGQxdENhbkRVZFZsK2toaVlLRGdNSHQreXZZa1hhK3pkZVhuekUzTXZidWZG?=
 =?utf-8?B?bXc5YWpNbEJjaTVGbG56KzZHMXJNSTVhN1k2c2phSEpLMTN2VzRacGhycjU1?=
 =?utf-8?B?SmQ0bk1WR0t3dUVjWmc5WWk2UUlkVlNXajdxeEdWL21oTXBKSEp2Q1VBdzlS?=
 =?utf-8?B?SVNvNmtTb3hDejNoMU5NU0dtWU5JVmxxWXJ2bDkxdHJ3Q0IvZDB1TWcwMTh2?=
 =?utf-8?B?RHRrUUlnTkV1aEFLL2FUUkMrV1l6OHJSRTRDeHJYVUJhRUZveTJ6dDJKSVM3?=
 =?utf-8?B?S0VRSVArKzJmakdtdjE0ODFmUFVDcjFlOE9rdHo1MURRc0JFcmkrUkF1QTF3?=
 =?utf-8?B?RmtsVWRmN1FrN1d2eVM1ZVdmZFBJb0VzZFlXKzBvZno1amNjWEh4S0NsRTBv?=
 =?utf-8?B?QzhOQVRBcWxkWnF6dDJ3ckxiSkg0N2IxTTZUazg3Rko2STFCYU15ME45YVo2?=
 =?utf-8?B?NGI4YXdMRWk1ZnJlNVpXZUlDM3ppRUx6TU5LOHN6dHMzR0dMNnI2Um91Z1dr?=
 =?utf-8?B?N0hwbmVmNU1HQjkxM3lpc2k0TG5Kb2V4QW45Z1hXZzRTa0R4MC9ncDBKNDFK?=
 =?utf-8?B?NUJ4ZXRrakRNMjNWenowcEpDZ3RMdWZyUkZXWU95UmpxUkhtYm9RWUE2MWVK?=
 =?utf-8?B?L2MwUFdDUWNQNzJPbDF1cGJPV1dRNFZMckgweWJYUloxK3cwZEo0NjJCQWpE?=
 =?utf-8?B?dVdwZUd2VVBLZzRIckJ5R1lvZkVnbmNaL1J6OXlBV1EwTFpqby80VlFza2N5?=
 =?utf-8?B?bDJwQTQ3Y1FQY3I2RXFyRlp3ZG5oOHhDK1A5KzBkQnRLeUdVQ2M5TVVJekdT?=
 =?utf-8?B?MEtYUXZnTHdDeUFlUnFrNWdpS1c4eUhMbTZhcVlnVzYzUjVNc0Y1ZWlBUzZt?=
 =?utf-8?B?QVA3d2tYSHI2ZGZPUHNtZUN6SnB5RkpCVzZ1dEh2YjkvWUFyeGJOMG5ydDFI?=
 =?utf-8?B?WGNsK0dFZmdmb2c3Mkp2NnRDcFI3Q0JaZHg0REpVcm5sUHF5a1c5VTZTWE5V?=
 =?utf-8?B?VkVqVDc0Y0tXV0FyaEp1R0RDR0F6b0wrWnVaZUNMZk5sQllOVlEwYm9ZajBi?=
 =?utf-8?B?blFuVm41Yk1oNUlIbVlRWGxWZmxoQ284d2hrTlNsdEI1SStUdjJsSUhEcHBB?=
 =?utf-8?B?MFZUVEx4NDM2RGxrRTRmdVhWTHlMeHp0VFlBRTNkK1RkdTU3WEpxQXI5ZXRL?=
 =?utf-8?Q?DuosDzq+CosnypAPNZ7RJyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0670E04EAD66B44CB4212CC9D51C62F4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0302MB5347.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f543a6b7-f466-4795-6634-08dd67885574
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:22:20.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClyhLs3miv6zI+vYDtQ+5RJ3mqHIAFIZxL09COWzEb7fuw3S9huTIEPO6veoh8Uf1SmPA4Rr03gUMQWEFVi1Inww6rOeAPnMn1T67eMCS8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7652

SGkgdmlyZXNoLA0KDQpUaGFua3MgeW91ciByZXZpZXcgYW5kIHJlcGx5Lg0KDQpUaGUgc3RydWN0
IG10a19jcHVfZHZmc19pbmZvIGluc3RhbmNlIGlzIHBlci1wb2xpY3kgYW5kIHRoZSByZWdfbG9j
ayBpcw0KYWxzbyBpbiB0aGlzIHN0cnVjdHVyZS4gd2hlbiBJIGhhdmUgdHdvICJwb2xpY3ktMCIg
YW5kICJwb2xpY3ktNiIgdXNlDQp0aGUgc2FtZSBtdGtfY3B1ZnJlcV9zZXRfdGFyZ2V0KCkgZnVu
Y3Rpb24gYnV0IHRoZSBpbmZvLT5yZWdfbG9ja8KgDQppcyBmcm9tIDIgaW5zdGFuY2UocG9saWN5
LTAgYW5kIHBvbGljeS02KS4gd2hlbiB0aGUgcG9saWN5LTAgYW5kDQpwb2xpY3ktNiBjYWxsIHNl
dF90YXJnZXQgdGFyZ2V0LCB0aGUgbXV0ZXhfbG9jayBpcyBsb2NrZWQgYnkgcGVyLQ0KcG9saWN5
LiBTbywgSSBjaGFuZ2UgdG8gZ2xvYmFsIGxvY2sgYXZvaWQgcGVyLXBvbGljeSBsb2NrLg0KDQpC
UnMsDQoNCk1hcmsgVHNlbmcNCg0KT24gV2VkLCAyMDI1LTAyLTE5IGF0IDExOjEyICswNTMwLCBW
aXJlc2ggS3VtYXIgd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmll
ZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE0LTAyLTI1LCAxNTo0
MywgTWFyayBUc2VuZyB3cm90ZToNCj4gPiBJbiBtdGtfY3B1ZnJlcV9zZXRfdGFyZ2V0KCkgaXMg
cmUtZW50ZXIgZnVuY3Rpb24gYnV0IHRoZSBtdXRleCBsb2NrDQo+ID4gZGVjYWxyZSBpbiBtdGtf
Y3B1X2R2ZnNfaW5mbyBzdHJ1Y3R1cmUgZm9yIGVhY2ggcG9saWN5LiBJdCBzaG91bGQNCj4gPiBj
aGFuZ2UgdG8gZ2xvYmFsIHZhcmlhYmxlIGZvciBjcml0aWNhbCBzZXNzaW9uIGF2b2lkIHJhY2Ug
Y29uZGl0aW9uDQo+ID4gd2l0aCAyIG9yIG1vcmUgcG9saWN5Lg0KPiANCj4gQW5kIHdoYXQgZXhh
Y3RseSBpcyB0aGUgcmFjZSBjb25kaXRpb24gaGVyZSA/IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4N
Cj4gdGhhdCA/DQo+IFNpbmNlIHRoZSBzdHJ1Y3QgbXRrX2NwdV9kdmZzX2luZm8gaW5zdGFuY2Ug
aXMgcGVyLXBvbGljeSwgSSBkb24ndA0KPiB0aGluayB0aGVyZQ0KPiBpcyBhbnkgcmFjZSBoZXJl
Lg0KPiANCj4gVGhlIGxvY2sgd2FzIGludHJvZHVjZWQgZWFybGllciB0byBhdm9pZCBhIHBvdGVu
dGlhbCByYWNlIHdpdGgNCj4gbm90aWZpZXJzLCBidXQgaXQNCj4gaGFzIG5vdGhpbmcgdG8gZG8g
d2l0aCBjYWxsaW5nIHRhcmdldCBzaW11bHRhbmVvdXNseS4NCj4gDQo+IGNvbW1pdCBjMjEwMDYz
YjQwYWMgKCJjcHVmcmVxOiBtZWRpYXRlazogQWRkIG9wcCBub3RpZmljYXRpb24NCj4gc3VwcG9y
dCIpDQo+IA0KPiAtLQ0KPiB2aXJlc2gNCg==


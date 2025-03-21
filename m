Return-Path: <linux-pm+bounces-24364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF3DA6B412
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 06:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71413AF96B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 05:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701E1E7C1E;
	Fri, 21 Mar 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ndge8aXu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LbhH4mFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394F12E7F;
	Fri, 21 Mar 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535144; cv=fail; b=UCvd3x8J0Bjo7CR4E8GpoBBsDLSPWXJwDYCVAoAyMPfS99pxzhjok3Dk+7q+R8mnpbE6uKFfdR+zNo51okNJKipAz/2GwHgS4Oe2aRFGuSvzU9SH+0wQoyICEc40PCBJd85rLFtJJoC9kK9yMyFvc/85VCA7hi9iON4e20z8bJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535144; c=relaxed/simple;
	bh=xOQAxmn8sRMCBAs00gB+YoLzpax15o3joGvClGsWm0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HA6lfZ6PPWTQ6Oqs641d+85jSkZiDizVpzf6ezLHWefPKJf4Mm0Ogof1XhAvv/gAMP4FTaImwvsPuDpZBpQ3m5Ren2ncsoWjYrnpqhKB6+Lxd+d4Ti13q1IM+bisUwfYK++lZF+O+Yv6TfU4FIB2B+AUsgo9GiS0HjXDYq9gZLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ndge8aXu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LbhH4mFs; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d5b8cb02061511f0aae1fd9735fae912-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xOQAxmn8sRMCBAs00gB+YoLzpax15o3joGvClGsWm0A=;
	b=ndge8aXuTwJqpV+7bzVGre5B+BR/kWSEIpu6mBDrsbrSyy/AXVGg8ZOW+SNFkDrnGRYos8Y5DvwFqJJ5Ws3qAKErrEkMwideenpC105UUOjb8mkhyEhHDBXNa2HkeeeD5/+op9QU/FHL8k6vcosCWNbA7bO2g4yrVejm7LYgchc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:e5b9f3e6-3262-43bc-b4da-6a1ed32cab7b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:931a634a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d5b8cb02061511f0aae1fd9735fae912-20250321
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1574088914; Fri, 21 Mar 2025 13:32:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 13:32:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 13:32:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E512REBosaGYXwPihpLjVa25bo+o/z+6gGyqSgnAVPiw97eyp9ohKGTmG4IFRrk9ZPwYPHvnanPsTjEvrGSG1xKmU3EN0cDWsKRhORDkUK62yzeVu5bdoOS6IxxTyi4sgl9TSWLgoTwjG3xu2B7vW7HpnkhU8t8MFJ7t8h0AMm1lzsEYXc7v7oE1wJU2ThYJNCpsnlJFg95c7ZHtUcOvl2JnjnQN8FIYic6g/Le1aukw4HzVhzbXksdE9t4D6csWU48QXTQ/m8q50fC4Hvm1J6ufU8KL1L1TCPGwIo52Oi4RxFhSZiJzr4J6i3gI5MxaP67wQ0mJMbd0cdVTIH8AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOQAxmn8sRMCBAs00gB+YoLzpax15o3joGvClGsWm0A=;
 b=anKFmKVvYqkp4YaFnLjL/8aiRzCNAWu8qjnUJTiDSbIX5+NEmu+CKkbWvdnRvrc0g4qdsUWzXcdhWCT1g8l/9ZqnwYiRgYV9ObfnxyRO4itDJaqMdr4ntdEyl0E/S5o72vUiGBfHT9+H8bD44RYd2dkkNuWzu1aqHkSRiapSjw+pFa3vi/DP5spIVRmoqZQvjpqCo9VLeMBoBwbCYUFREpaZFzglWWiLrO6abnncsNrJg7Jgzlq2QN9NYNiB6w+G+KjPQUCcP9q72LohOrhW/nwXlNdv4B4pZcOWbTKfPjo2F9XzsBu3ZRIthnDi0zXXsxBCtjULd4B682OxcAcomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOQAxmn8sRMCBAs00gB+YoLzpax15o3joGvClGsWm0A=;
 b=LbhH4mFssN3UqqBTMnPj2Ys2FnhzKpOeSXLp0QTHUBT4IzAHhUE4m92jzSsxLnX1d2JA7bKVJT8bgdvhnKTdurNTV06db1Hr4Pq3f828mN0Bsv2vdv0QP5bNEUrt89NsjddtQ/LrCR429NSEQ61u5srLIpIRjIKA8ZNxLtszUYY=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by SEYPR03MB8552.apcprd03.prod.outlook.com (2603:1096:101:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 05:32:06 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 05:32:06 +0000
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
Thread-Index: AQHbfrQ2e/+qwhbOe0mntrlJoHcSLbNOJJ+AgC3AXICAAVjNAIAACfiA
Date: Fri, 21 Mar 2025 05:32:06 +0000
Message-ID: <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
	 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
	 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
	 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
	 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
In-Reply-To: <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|SEYPR03MB8552:EE_
x-ms-office365-filtering-correlation-id: 3ce457ff-6c7a-43c0-4ffb-08dd6839b7c8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2RyRUpucUhhcndtV2JPZm5zQzdCTk93cTlTTVB4TTB3YzZXRitaNFhBK25o?=
 =?utf-8?B?N1pjVjRYVXlUWTNNQTkrSis3USs0S2gwUlRYQVNpQm1RNVFDK1BSNW8wcXY0?=
 =?utf-8?B?eWRGS3lvSVRweXJPdTF1bXU5My9KK3ZsOHhYTU5GU3ozL3hTdlBHUUFUTzlB?=
 =?utf-8?B?MzExUmdDNGFwZnIyUkFNVkVZZk9rQnFiMFRvK2NrNVlTNXpxUURwM2RteXhG?=
 =?utf-8?B?dzJIeUlRNjR1MjNXQjZJMysvcEFTL3hUSytKaFJENzJqSHl3SVZocGNPR2lK?=
 =?utf-8?B?RlUrb1JUYTd6ZXJvUVF4N0RURFVCVm1jMnV5M1F2Y3dZR3IxenczTVlvTk1X?=
 =?utf-8?B?VW5McUZtbGdGVXc3THBxMXhHR0hqSkpUaHdLWS8rT29Nd2Y5aVJQbHd6Qm1h?=
 =?utf-8?B?aStOTEE4TldiendiNjZkVTM2eG53V1QzUFNRaUM2cEJHU0FRMG1XRXlIZjFa?=
 =?utf-8?B?dyt2NlBMZ2hNV1lqeHBpMVk3dFA4VUowU2JuK24yajFYenNzK3UrdVBZUlMx?=
 =?utf-8?B?RXc4ZlBYNVVCb3kwdUxXWnBTWlNGQ05VSHVEdFdlanVodFdLc1hXT1BycGpC?=
 =?utf-8?B?YmkycWplU2o4QU1UcHFFTGVDT3VnVVB6NEt5U2ZPZDg4V2dnUFkvaldjZDNN?=
 =?utf-8?B?bGtrT0ZMeEEwdUxmWXczYUZ3QkhpTXUxNWluMWJkWG5lTWlnY2IrTW1jbWF0?=
 =?utf-8?B?MTN0TnJvZWIwQnQzZmxBd1dLb2NPcjZyUExwV2V1T0xtUm05UnNmTkM3Q1pl?=
 =?utf-8?B?cVNETUxUZmx3ZndNZUhhekR1NnNLYW5Sc0xSSkZZNnBvbys2VkJnTW9rRmxJ?=
 =?utf-8?B?K0YxSDQ5Z0o0ZmFZdksxaWxmdjlidFFuMm1oc1diWjJhNEF3SkVxRE1oVUtO?=
 =?utf-8?B?dmNETEc1Rm5YM2p4SjhXYlNpeHRlMmJZVUt6bjVwUmVYcE9MOEVUbk5xRUd4?=
 =?utf-8?B?cjNrN1NxZ05IUUFtZUErMHVFWVQyYktEYnZIejgxMU5jeDhldnNPWFdJbDdh?=
 =?utf-8?B?LzBsVmpveW9xUTA0ZkpkTE5KcVp2cEJucmRYOFhLbmFSSGF6TkVsdzVmakhR?=
 =?utf-8?B?QXh0cklEQkVhQjh2Y1ZYdlFLTVdmQUtjZUx6Mk5GcW5LMEZyMXZMbEJGb1Nz?=
 =?utf-8?B?b2d0RlRPdTVLZVpYdy9OUC9kL0JHZXFlZ0lJZmJuRXRXQ3VvNGN3bGozeFhO?=
 =?utf-8?B?RXAzbVNldm9aTlFFV3pDd0F2ZU16Z0h1TVNpQldEclk1US96MFVUS2grYjBZ?=
 =?utf-8?B?TVhsMi9ldGIzMjdZUTFZYlNIRlV3Tm42Q1JuRXhVd3UzRmJyODg2NjZMRTAx?=
 =?utf-8?B?dVVnUEMrMEdMOVgzQTg4T2tWN0V6ajJLckh6VnFpSHJ3L0dsa25WZnNMUWZZ?=
 =?utf-8?B?dnBCT25xWXY2a2Z6dGNna0VvWitWSThzTEdOUUttUFdHVTdpNjRYcXFQZElJ?=
 =?utf-8?B?b21jQThyTzFpSkMzajJpMll0S0RjTkt1TU8zcnp2SXZ4TmdlWUxMQUJHMll0?=
 =?utf-8?B?MmJ5VVVJd0RNM1h5TG0xa3pLR3ZKNXd0eEpUZEVRYzUxa245dVRUakttYmpw?=
 =?utf-8?B?cGFjLy9XeGpNbURwVmpGVU5RNXhGeWtBM2lWS1c3eC9ydm1GYUcvYk1acnhr?=
 =?utf-8?B?T21jMEVPMlgrVllHaTk2RWpRd0xUTGw0Q1g0N052WDBOUmxFcGh5NGVPMTVv?=
 =?utf-8?B?MUtxTjUxVFVtV1dsQlk2bDdwUjBKN1FOUkd2a2pXcjQ1S050OXYveUlpZWly?=
 =?utf-8?B?NUNDWHQ5cmY4RU5ZcHRrK2MvT2JNS1pJYnlJMDBzcERRdkd3b2RjcTlnUDhQ?=
 =?utf-8?B?TS8vL2ZuK3RBaEdmaG1mZVdrZEFwMUR1c0FINjYvOXQwdENRUjNMOHlMNmdC?=
 =?utf-8?B?UXlKWS9mRFlEc0NURlNLR3JjejJYNzdBbEQrM1NQSnZhTUF0ZXJlNnJsZURV?=
 =?utf-8?B?ZmtydnQ1ejRIVEdldVZiUGhRa0R3SCszd2pjc3BkYlVvVjJKWVQzd3F4ejZt?=
 =?utf-8?Q?PKvHiofw0ISl7SvdaGTwZZkHXya2ek=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVhFOHVSR0hwdmxEU2VzZWlJYm9zUHpzUFRkU3RxdTFuVHVlNUtKK2trMDNm?=
 =?utf-8?B?aHNRNXc4Nmt2ZVZpT1I2ZUxnUEFFcDRlRTZlQ1RzTzdRS0xHT1dheUdlRm9P?=
 =?utf-8?B?TGFxdi9vQktoZzA1c1VKLzdVY3FuMExhc2RQK1E2QUVnQWlab3h3RlZuc3h1?=
 =?utf-8?B?T0haVTdGVGJybmMrYlhaMGFQeHEwb09kKzRtUklncE4zWmFBQ2tTbjhrTVNw?=
 =?utf-8?B?d1VPbXhIK1pqODZhYlUvQi9HUzRwQ2RLZWZlYzYzVjZHYVllMEpKTHgrcEF4?=
 =?utf-8?B?Z3M3MzBIOUZiMC9qOWN5cnI0czJqSk9HcGkzME5tNHhrakxpeWRNYzkwRHNC?=
 =?utf-8?B?YVpZVmVmL2ZFWTFQQS9ZOTZYWDVCRFc3ZWtsUzBLRjArSWwxUTFVbFRKSnpt?=
 =?utf-8?B?eENIQWdFWFNUUkpldFBqTkxiZXI1TU1aRk53NEhnWnZVMmFmNDIxVjBVci81?=
 =?utf-8?B?d1Arenh3VlUwdjdZQ21qcDRDNkFMd3RjSUtVRDVoRE5Jc3lwZTE2VFUrcHl0?=
 =?utf-8?B?aGxTdGVUVDZWdTNzL2FlRlhPWGtDamUybWF5dEtIbGtXNUc0Um5YZjV1Ymtw?=
 =?utf-8?B?d3F4YlhTb3JHY01OZmNvQjE1T3VGcmNHS2trdG5kSjE5V29CM0MrS2UrWGZv?=
 =?utf-8?B?UFBQL2NjOGppemtlcXJnalR0TmZDemsxVURIWXpjckZoaU9zY2pmL2lSQ2s3?=
 =?utf-8?B?dURsbnpDdUtDcjduTzgwNXZobTJvZzdjbnR2R2V3MWFGMWdtTXNnYiszYjdV?=
 =?utf-8?B?NWFVc1RqVExwQWdTa1NBaGt3Vit4K2JDOEJHN3QvMklidDlSUGluQkg5cTdD?=
 =?utf-8?B?Y29udDd4L3JsVjczdE9kWTBySWtEeHJ0NnJlT0VDYWM2OHZjcUZuNXkrOTZY?=
 =?utf-8?B?TXpLem9wUkdLcXRRc0I0M1o1UENnSFpURXY3SzZtS29RTFZPckhqZ3ZsUTdI?=
 =?utf-8?B?NHA5N0Vnc2FEd0oyNmE4SXpJM2FUQkYyc2g4RkNmU0lxbEI4RGJHQkFTUTZ0?=
 =?utf-8?B?cCtvdXRqOEhraFIzdWJsWCtTMC9PR3dwakVyNktrNlhwUzN2V2crN254azNE?=
 =?utf-8?B?T281Q0xoMFVqWnFwSm80R20zM211ME1zTzhTVXBaL3c4RUxxejBqTUtpL3Yz?=
 =?utf-8?B?ZE1rdU9XRXlyZE9jc0E1cFdRY0xSaUZZQ0FHbXdkYjJ2OHF4Y1dXYlNGYmt2?=
 =?utf-8?B?S2lOVS9tZDNzRUNnaklBRFhJQmwwVzF6QlpIVmRrdnE4U2JPY2FzaDJFVnQv?=
 =?utf-8?B?aExmOVNNVk9ud3RhVnh2d2tBSDNaejFIVytPQ01TRng2aEJTb0F4QWdqc1No?=
 =?utf-8?B?S2JxK0xRVGpRbzhYMGp2bGNkbnB6M2lRbFh6a0ZucDdHdHBqcnl4V3ZHMWll?=
 =?utf-8?B?SDhXWVNaV2dWT0I1YmV1ei8wNWZINEZURXd2eCt5bkJacjluR3JHTFFZR1dm?=
 =?utf-8?B?dVRmZkpjU0VkeGdHTGxvSDhCcFNURDZUMU91aG8wVzFrQ3JxM0d1VTZGNmdp?=
 =?utf-8?B?WGZRZmc4M1Y5ZFNSWGZqZDJPSXBNc1o1NTM0NHFwV2FLM21BTCtOcW1KaHFU?=
 =?utf-8?B?a2xDb2tZdXJ6VVpBaWp5WEN0SWVwTkJuemJJelJ6VGtGT1JuTU1lczd5RlBM?=
 =?utf-8?B?ekhxRnVQdm5la3REZDJ1SnRZM0JMVW9PSWNCZkdwMlBROXo1anlrNDBibjVa?=
 =?utf-8?B?b2FibnVFd0lEbVNFWjY0Znl3Y1lCeHdDM2JEWXo4SnJ5OVVWd1VuV2F4NjNH?=
 =?utf-8?B?bDVmYzZ0WEk0WVpCZHpUN1UyLzVwTnNjWE9sRXZGUnBpbXgvY0ZhTU01Ym5G?=
 =?utf-8?B?ZXAwWXVlWWpVbDV2T1NHWjhsaitiaFI0NkF2UXJhemhOYTRLbWhHQVBZU21n?=
 =?utf-8?B?T0oyeUNtYzhITlpnMVdOSnRMa0o4N3hTYk15clArWTJMY3dPY29oa1JqbWhW?=
 =?utf-8?B?L2k4dWkyNWVqaTI1ckNRZXpGdUJKSUlWUzRyTjBFTExBUWl4UndOdVRBV2o1?=
 =?utf-8?B?VVZ3RnlOcUtzZGhNUWFwYlhQelFkTzZRa0NNQW5jL2ppcUVKOTNLUzRFTUow?=
 =?utf-8?B?KzFhQ0lpMHFRSFYyY2gvc2VtQzIzazFZTWN5ZndrYXB0ZlVkSU45eU1SK25a?=
 =?utf-8?B?Vys5NEJCK1BzQnhQQ0JGbnlQbG04VkpYdllENUFuc1FQVDZUN1FSS1hrUjgw?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0385406C5BA4074CA769C3B14867FFF5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce457ff-6c7a-43c0-4ffb-08dd6839b7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 05:32:06.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmc5NNQl8Dvl9WrkGHcVdcoRvLtwG/+KxE3Ple44BCSUO2jbeBZ90NzaNKur2kWMqG1wP439kN9rZEpnrqLllkxEeK2+3y9Mhs/kP4Y66Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8552

SGkgdmlyZXNoLA0KDQpJIGFkZCBhIGdsb2JhbCBsb2NrIHJlbGF0ZWQgdG8gdGhlIENDSSBkcml2
ZXIuDQoNClRoaXMgaXMgYmVjYXVzZSB0aGUgQ0NJIG5lZWRzIHRvIG9idGFpbiB0aGUgZnJlcXVl
bmNpZXMgb2YgcG9saWN5LTAgYW5kDQpwb2xpY3ktNiB0byBkZXRlcm1pbmUgaXRzIG93biBmcmVx
dWVuY3kuDQoNCklmIHBvbGljeS0wIGFuZCBwb2xpY3ktNiBhcmUgc2V0IHNpbXVsdGFuZW91c2x5
LCBpdCBtYXkgY2F1c2UgdGhlIENDSQ0KdG8gc2VsZWN0IHRoZSB3cm9uZyBmcmVxdWVuY3kuDQoN
ClRoZXJlZm9yZSwgSSBob3BlIHRvIGNoYW5nZSB0aGUgc2V0dGluZyBmbG93IHRvIHRoZSBmb2xs
b3dpbmc6DQogICBwb2xpY3ktMCBvciBwb2xpY3ktNiAtPiBzZXQgZnJlcXVlbmN5IC0+IENDSSBy
ZWNlaXZlcyBub3RpZmljYXRpb24gLQ0KPiBzZXQgQ0NJIGZyZXF1ZW5jeQ0KDQpCUnMsDQoNCk1h
cmsgVHNlbmcNCg0KT24gRnJpLCAyMDI1LTAzLTIxIGF0IDEwOjI2ICswNTMwLCBWaXJlc2ggS3Vt
YXIgd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDIwLTAzLTI1LCAwODoyMiwgQ2h1bi1K
ZW4gVHNlbmcgKOabvuS/iuS7gSkgd3JvdGU6DQo+ID4gVGhlIHN0cnVjdCBtdGtfY3B1X2R2ZnNf
aW5mbyBpbnN0YW5jZSBpcyBwZXItcG9saWN5IGFuZCB0aGUNCj4gPiByZWdfbG9jayBpcw0KPiA+
IGFsc28gaW4gdGhpcyBzdHJ1Y3R1cmUuIHdoZW4gSSBoYXZlIHR3byAicG9saWN5LTAiIGFuZCAi
cG9saWN5LTYiDQo+ID4gdXNlDQo+ID4gdGhlIHNhbWUgbXRrX2NwdWZyZXFfc2V0X3RhcmdldCgp
IGZ1bmN0aW9uIGJ1dCB0aGUgaW5mby0+cmVnX2xvY2sNCj4gPiBpcyBmcm9tIDIgaW5zdGFuY2Uo
cG9saWN5LTAgYW5kIHBvbGljeS02KS4gd2hlbiB0aGUgcG9saWN5LTAgYW5kDQo+ID4gcG9saWN5
LTYgY2FsbCBzZXRfdGFyZ2V0IHRhcmdldCwgdGhlIG11dGV4X2xvY2sgaXMgbG9ja2VkIGJ5IHBl
ci0NCj4gPiBwb2xpY3kuIFNvLCBJIGNoYW5nZSB0byBnbG9iYWwgbG9jayBhdm9pZCBwZXItcG9s
aWN5IGxvY2suDQo+IA0KPiBZZXMsIHRoYXQncyB3aGF0IHlvdSBhcmUgZG9pbmcuIEkgYW0gYXNr
aW5nIHdoeSBhIGdsb2JhbCBsb2NrIGlzDQo+IHJlcXVpcmVkIGhlcmUgPw0KPiBJIHRoaW5rIHRo
ZSBwZXItcG9saWN5IGxvY2sgaXMgYWxsIHlvdSBuZWVkLg0KPiANCj4gLS0NCj4gdmlyZXNoDQoN
Cg==


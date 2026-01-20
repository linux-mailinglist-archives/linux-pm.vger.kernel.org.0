Return-Path: <linux-pm+bounces-41149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73313D3C01C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FA6D3E8D70
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFD36C0B0;
	Tue, 20 Jan 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciZWs0EA"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30585379983;
	Tue, 20 Jan 2026 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892519; cv=fail; b=CS5opxHTWtN63rWoxwqYhFgkzuuGcvLh6RfLV/hwKn1xyKwcnyznUAv329PS6uH+HFZgrODbpUF9ULuOEnPPFvsS87Obm/mCtDyTLS2o222E7048niSsBQQhQvY0bmEW+NdoNsukTi2M84aJVYAO9lh+WtrBvsPo6XywPWnUhPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892519; c=relaxed/simple;
	bh=S7TcajMiOFnAnmuCguFDB+JObJs1010+L64JL5/Z03Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPDjeEA7bImoSAnR9qowjRoYB1OqogkYU78VsKZASoTPnmg2WLMD7Ympu3u20XCkt9c8dNMNAmEWnUTCW9zOH7LLKQNke4qICkarjLeLfTh4wyFCV4/8egc7TH3E2fkd4xgGdSjOxSCCIPEFPpHqRsT8J/HHP5QuUc/OqF9ORWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciZWs0EA; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZtyH1tBB1CAgOHAWuPHvNyae+I53lX9PjUfgnWHJrtYz5DFgc3gyw/SzdodvR1EYVF4wMPls1Yl5MoVltfslGIPSkMMCMPG62sHswYSM9JzokGnmD6TUeDeVMsHy1yVsi138Ipxccgq89onkl2flgRJwK/A4IKcuDegWMWs9K3sdgpJD8bZ0eD67rHuriCa5gMEXCIEJ8v8JDYN2vrhasoy7cBbs8rPkUUvmjqBWuHxyY3LIeHUej+WRxuyzNHreO6O42+4C2fokpKxYwJDGe5vsf5VWp4bBkjMp+Y2Y4Wqc0gpMusrFp5UrGr/FZt4e8G518PDxLa9xxnwCkXubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8vP0vXVvYB2IiJ9CyvCQCyjbszFXg4gWbnQeMTwC3k=;
 b=hdofStaJc8qKP0FFJF8xPwcZ9hbbJRdxlfiIG/zwPJC8QC60e4DmljNIYzYkeghlTrv4yKz38yxkbNzxQgsvHX5yh0W6xht+Ul65blmTznGx3gNOo3jf47XKPjxmzAwUyTFfsvvIXHc/wLbvi7sszAs2F0s7P34jK2LdsDsLXhU5j1aSe1Jeij0cHmXo8SCA3Ra9l+FeYlhktMidfFQKr998WYRo1UzsUZ6NXjSYj30dLRKDCTLQmGQoghj54VnxDkdxJzYB6Q1YIbq5sW2WcwDUPGoO4rYsIRAmeHUylc0x4aIupO3FScl9dKV8Z/B4nrBtxkdf1HYU+GKHz5BJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8vP0vXVvYB2IiJ9CyvCQCyjbszFXg4gWbnQeMTwC3k=;
 b=ciZWs0EA4UcanoPDYmKvNj0/vrP5tQYkkXn+FAjPDQTtQ/GFqgLvexVTt/61lhCKHSyoLQLSyLkXINPH25E6roAzorFFf5uuo6x9c53AIIxCqWAKZtn7pWrtMcLh11I8dieakxNBLAFB5GKgZAkJXHOdt41zoq0RSDh87laBOlcsNJ/aqeODc9tN0UKFSjgZ+8nXMjUJYrtgWefokBqVjr32ULNCV4HXe4A64m/82z9/5ICz6zPMJOk9DY1AeKVZF8phrqjZyY0e0+SsPRJoT9QDIZzL+z5TMP/WjpO9m5YcG72Pt+eP8/KmsBFuDUa8eWQYXtWo+aWMf0r/6e82Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:01:42 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Tue, 20 Jan 2026
 07:01:42 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v4 06/12] clk: tegra: set up proper EMC clock implementation for
 Tegra114
Date: Tue, 20 Jan 2026 16:01:38 +0900
Message-ID: <25016696.6Emhk5qWAg@senjougahara>
In-Reply-To: <20251125120559.158860-7-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-7-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0320.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5f7b9f-5603-4665-42c8-08de57f1c438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXBmVitzazR3aVBJYXVPYlBLdVZ6alBnWmkrV3E3K2NwV3p3TFlzYlZTQUNG?=
 =?utf-8?B?Z3puTXRwd0daWXplRmdGUU5ubVRJa29xc2ZCWHpvZi9iMXJ4NEFub3Zoa0cx?=
 =?utf-8?B?MFVQTDFDZncvRytUY3hoN3lBUlBLdUNIZ0VUZzlQVnBXbE10alpHWlBIdVhm?=
 =?utf-8?B?SUVIRVlBYWhxdDRSeWc3My8ycGUxV0ZXL1VIQWpCOEJKUFdudVhna3o0c3Fs?=
 =?utf-8?B?SkFpUjhwTnhGeU90N1JFaVN3Z3orc1NFZ1JieVB2eGY4aEZyUXpLcjMvcmxp?=
 =?utf-8?B?Uyt2TUVrUXU0a3hDbU1TR0RYZ2xJMCt4Z3pOT2RxTDRUaG1ucFRJdDc5bDFI?=
 =?utf-8?B?OUNyZzhHazJuZ1VrbW00YW1QSG9JMUVIME04TUYzLy90bmduQzdjWDZOK1JW?=
 =?utf-8?B?T3ozQzBueHk2bkdhRFNUZ2tHUHJudHRENXh2SkUxejBpZ3dhU25LWXozazls?=
 =?utf-8?B?VGFxald5N0tkNjA4blozaXBhV1NYUXYrRjUra1dzVG03VTdSWXRTS01lVU1P?=
 =?utf-8?B?NExQaG8xR3BYTlp6MmRWT014MTd6K01BeS84SlV4NHVQRlh2QXkySkNkOHd2?=
 =?utf-8?B?RnJKV3Z6UWRkSUdoZUVHaGFJalQxVVZaZ3lnazVEK0JNVFNMdnhCL0FsOXEx?=
 =?utf-8?B?UVhObnJBOGlJeXI1VnZyeFhVeHZRZVhHVitWUUxoZVI5bHhjeVF0UFM5MUtC?=
 =?utf-8?B?ampDRm1ycmZ3TmtjRlViR1BldmV0Sjh5R1ZtYkl6UjE3dUNYb1FqT2RxTXdh?=
 =?utf-8?B?bEE4SzA5cWJ5T1VZN0FGcUZCVmlCdFFSd2JJOGErOStJakIxOHFuK3c0M0k3?=
 =?utf-8?B?RzFYVFJqTmwzT2s0Qkc5eHdtcmFQQnVhWUIrR0FpbXdNQ3Q5OUNpVUpxWnp6?=
 =?utf-8?B?THE0bGtQZEYrNk5oWVVnL0UyZmtQM1E2Z0U5VUlrRXora0tjdzd4SlRKZXl3?=
 =?utf-8?B?TmdwOEo0eSszckhCQjlMUzFWbU9xQ29VaHg1Wm56a2hlTVdMUlVOcHc0ZFBS?=
 =?utf-8?B?WGd3emlST3pZcGFQNnhFQ3gvcDdIK0c0TGRwTHFaaFlCWlVMam9qMVRGRWg5?=
 =?utf-8?B?V3RoZlZyaTlPVmg1c1lCQ2RBam8wMGFCZkpwRlRCTjJ6K2hWdDR0OFpHNm9m?=
 =?utf-8?B?ekVCZ0x6NmR5cm95UWEwMFIxNGhuRFo2UVBXRGZxOTVvemdaRVM4UitGSXBM?=
 =?utf-8?B?OXB3T1ZrbzhaQkZYQUMrRjJqY2Q1YkRwUzc3L2FQUysyS0Y0cHBFOFNNY1ly?=
 =?utf-8?B?OE1LNUNHVUluNGhZN1pPRDZJSng3YjNPcjNxWm9KaWZuc1h2Qm1nRUtCYnRk?=
 =?utf-8?B?VTJ5Z3ArMkxHTVVCUnlJRG5VeWh2bjJjYjEwOWsvcktDMXlPTDliREJzYmN5?=
 =?utf-8?B?eEpyQk9VWG16RWVqLzdraE9Nc1VZLzdNQi92Qno0SnAyZk12WTNHdi9tRENr?=
 =?utf-8?B?SVk0QUtpSHFmUXBPQmEyekFYMytFYWtnNVU0dmRiQmlzRDEzN1hTYVA1VE1Z?=
 =?utf-8?B?dVpmMnFUdS80RWFneEtTRHNIM1Y5YmVxZ1FEVjc1TGpRNWlXZnpicVIrZ3cw?=
 =?utf-8?B?SXdrTDJUSFNjWUlxQ2FlMFIvYzNOZis4VHphcmFMQ0xUdlBINEdaT1hqRGpa?=
 =?utf-8?B?bTM0M3BTaDYzeVg1aEoycXdEQkhvbU5RZUlFeHhKT2ZaanI4R0t6Mkx5czRk?=
 =?utf-8?B?SS9hWFlLNHFZMFRQVWRIakZYUkpLQzRHUE5XZEk1RE03ZzFTUGJ6bldpMzI4?=
 =?utf-8?B?blJPMDFBNm15TVliMGhGQlZaRzQ5YmtEajNTRjBsZEJCamp3WEVEaEhKSFFV?=
 =?utf-8?B?MGZrY3l2eTZZL1BOQWRmekxWdDA0Yzc2NDc4cEwxcERDdnJLUGVCaURoOHFL?=
 =?utf-8?B?cWJ3eGw2ZjZNT1hRRHVUWU50YVJseFNPVFc1VmdLanBQNUtmZm5ZQ3UwdCtY?=
 =?utf-8?B?ZDhTSm5vTFoyRTNpenh3dnBIc0p6eERpeTljSzhMTEoxN25ka2Q5WXMzWVlX?=
 =?utf-8?B?dXdLbytVbGhGSTBaZFlkZWk0amdlYmVMYjNMd0xpSXJkK045WkR1U1RIOGQ3?=
 =?utf-8?B?cXlseDNxOHV2MnF2dWQ3S2JqeEU2d0RGL1kxS2N4T1A3NGRkeTd1R1NML2dN?=
 =?utf-8?B?QUdXbVZrQWJodGpqQlNNcE1GQ0JHMEp2eTN0K1BiNWkycVMxL0RoNVdKa1N5?=
 =?utf-8?B?M1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FHM2E1ZHpseFU5UnFmZjBtSnVxSUdMVU9tOGFUMnNoa042MzdlM3dhNWJw?=
 =?utf-8?B?amIrT0lDN2Vsc2Mvb2I4LzlYS1FGS2EvUUFKMXd5ak42UTJ2VWhqWE1ZYjY2?=
 =?utf-8?B?eUVvV0wrS1lvMWtzUEE3Wk9qYU44RyszVC9xYVF5eHpoZzhndlJ3WXRyT1h3?=
 =?utf-8?B?clFsemxRYlIrZERSYThOdVFPRGl5RmRpYUlDcnp3MzRPWjdOQ3ZPV3Z3OVFG?=
 =?utf-8?B?UmlHYmYydm5kVHlqVnlCVXl0ZHRJelUwZEpPdmZ4MWFkNUNKZ0M1VlhoOXpu?=
 =?utf-8?B?OU9rNGxnT05ETDd5RG1VdkV0N2lGcEllcldOZXkzbS9Od0dvOWNxN2hzaDAx?=
 =?utf-8?B?TVp2NjJTQ1orNERKY01PT2haeDcwaVhGS1d5clM4SUI2OFU2Y1ZXRFZ5TGt4?=
 =?utf-8?B?TVE0ZHFFYmVWUy9JbEwySzAyanFKZVhXaEpicDJCZ0VMN3YvcVRobFNqcCtZ?=
 =?utf-8?B?WDFFRjZGV0RHOXlPYnpTSkNHcVlqc2lkbVk2TUVvZGxqMCt5dFF1VVFFTWhh?=
 =?utf-8?B?Z3pHbDRoVy9DNVdNVWJ6NHNaTGZzSzRTeTNEc2tORlNncG4wempGOWZOVVRV?=
 =?utf-8?B?Tm9BZzFRSjZXV2JGMTVwc0dDSUl4OUZjbndQZWFOUDZLblhnN2txQTVKRjZH?=
 =?utf-8?B?REo4ekcxQm54aFFvaHNiN0Z3aVhpR3JVeGlveDEwMzNnbmhuNzYwVWxyaDNV?=
 =?utf-8?B?SXhHVmh0RUFSdkpVenFMVE1LR2lrM1h3QzRseVpGczYzV2xUZUJrRlB5TlNV?=
 =?utf-8?B?Z3NIVktnTi96OERCeXpSNmtHQTBFS2s2bFhlZis3d1ZjTVc0QjZoNmIrcDRQ?=
 =?utf-8?B?clJYN1lCS2RvSURXM1BmMVRsNmRsa05tZTVrczNqZ0ZoS21hTjlYMVZ5WG9Y?=
 =?utf-8?B?eHVRRkR0dnpkYzRSM1FTQTNRNjMzSjd0TS9sMWJ6ZHgzRjhQQ2F5ZGZyOHJR?=
 =?utf-8?B?N1kwUi9UQjR3S0YzY01GUjJKbks0TWlLbk5JbWZOZXplbHZibVZ6ek9VWmU1?=
 =?utf-8?B?bkNveUhhb09mOTBQM0gyRlhWL0VITzVMOHAvNFpISUh1dEd5c3hUS012aTFw?=
 =?utf-8?B?MUFCcUNuS1FSc1VZYzBOdDFETVVjR0NUTU5QMUxpbERJN1lLSjRZaVFsWTZp?=
 =?utf-8?B?aU1ZSGd2cU10S2tBckg4bTZjWUFZaDhxZ3FKSHNJYWgvd1ZhUTBscXo3T2U2?=
 =?utf-8?B?RzdOeWN5TktJVnEyVmozMS9neHFpTlRtQ1lDOFBob0VTMmUwamVmL2M5bE1i?=
 =?utf-8?B?cllxRE5UbjhNQnNUU0hFajZjRC81eC9Nc3ZSTjdHSzVKc3VwblNnanE3cWFt?=
 =?utf-8?B?dUxSY2d0TUtWTHZuamlnTUtVN1JJRDQrbjE1Mkh6emxxMjZ2aFpJMjM4cmFx?=
 =?utf-8?B?R0NjWUpmd016bjI4alRMNHJta2N3YmlyeTNVa0VOdzd4Mjh1aTcrTFBxRTE2?=
 =?utf-8?B?YTE3eGIzVVd2ZGRyWDU4b0V6OHorVTZTUFY2MHpvbUVjbE1NaVlxSXRMNUZn?=
 =?utf-8?B?SEFxdUdLK2c0YmY2YXFUY0NCMzZGK0s1SjZZUmRRYllUNmtnd2xFeGNKOEJ1?=
 =?utf-8?B?OCszWmk4bG1PUE8yZDcxWnUwT2hoUjVZcEFMSzFicy81OXB5K3JRa0FidUJR?=
 =?utf-8?B?T0JiK3Q0cm1wb2JNRGE2SUc2WnlGajN6TnNiN3REVlhBQ3Yyd0VmQS8yZlFM?=
 =?utf-8?B?OCt4WG9ubitDbjhCdU5LVXI3VEphMW96MXVBQVFVZko4YWtMbE90dWFnNVBk?=
 =?utf-8?B?bmJHN3RPK2lFNVI4aDBWU0VkUFVCbTFyMjZyQW4vMmdRdi9JV045RDNkMXFE?=
 =?utf-8?B?alZwcElub2szdXJDNW9IQjRzcmY1WjZkUC9zWTkzVnhYSHF5Um5LSU1hRW45?=
 =?utf-8?B?UWN4Q2dJV1NkT1JWNldHNklmSWpLZForMHVITmJEYUN3VU1QakxWSDEzWnBI?=
 =?utf-8?B?Ym9rbGtlMVNzbEZUVUtTWUN4K0NUbnV5QWxETmdSdi9PTjMyakZmTDdnVXJ4?=
 =?utf-8?B?L25KcUg2YW03VDJDK21CR2RSWmxldlQ3N2lHYnBNVXRBMGhWN3VHdG5xNkh4?=
 =?utf-8?B?aTFMcEluVjIwZVIwMVB6Yy9NQjBzbno0MnJ1amdBTU5TY1dJY2VHSTR3dDM0?=
 =?utf-8?B?bFlyb2VwUW5hMmsxWnFYV0kvSTlZRWl3dGhIcUVITjR2WDZPSzhHd2dGUGJN?=
 =?utf-8?B?THZRNWIzQTZkckg4MXc1NGtRVVV1REErMFIzejFSUVFPKzk4TkxPL3RvRE9i?=
 =?utf-8?B?dzBvenpOeEd6SnBTYW1uWVRsMUJnajlwYkllV1lkWGhKZEVpUTRJOVF2amV3?=
 =?utf-8?B?ZDdRdVRpeTJCUzBjV3pkMkdZUklIZWJMTGJKL1NmMTdCZDNOd09TM1JUYjFX?=
 =?utf-8?Q?bBS4YjMVLTTL9tZEAhhMA2ktG3mX1M1a8MUPS5Zfm/HFw?=
X-MS-Exchange-AntiSpam-MessageData-1: DfEd+IIOz9BkjQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5f7b9f-5603-4665-42c8-08de57f1c438
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:01:42.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uVNfrPYvyZ50PiKAyp5FgrnOmt7P57VryvYvMlLklWf28E8sUIFNH/6KSCvR0qdfmCSXdsqUyCSG0LifdQxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Remove current emc and emc_mux clocks and replace them with the proper EM=
C
> clock implementation for correct EMC driver support.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra114.c | 39 ++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-teg=
ra114.c
> index 8bde72aa5e68..853ef707654a 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -622,10 +622,6 @@ static const char *mux_plld_out0_plld2_out0[] =3D {
>  };
>  #define mux_plld_out0_plld2_out0_idx NULL
> =20
> -static const char *mux_pllmcp_clkm[] =3D {
> -	"pll_m_out0", "pll_c_out0", "pll_p_out0", "clk_m", "pll_m_ud",
> -};
> -
>  static const struct clk_div_table pll_re_div_table[] =3D {
>  	{ .val =3D 0, .div =3D 1 },
>  	{ .val =3D 1, .div =3D 2 },
> @@ -672,7 +668,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] =
__initdata =3D {
>  	[tegra_clk_csi] =3D { .dt_id =3D TEGRA114_CLK_CSI, .present =3D true },
>  	[tegra_clk_i2c2] =3D { .dt_id =3D TEGRA114_CLK_I2C2, .present =3D true =
},
>  	[tegra_clk_uartc] =3D { .dt_id =3D TEGRA114_CLK_UARTC, .present =3D tru=
e },
> -	[tegra_clk_emc] =3D { .dt_id =3D TEGRA114_CLK_EMC, .present =3D true },
>  	[tegra_clk_usb2] =3D { .dt_id =3D TEGRA114_CLK_USB2, .present =3D true =
},
>  	[tegra_clk_usb3] =3D { .dt_id =3D TEGRA114_CLK_USB3, .present =3D true =
},
>  	[tegra_clk_vde_8] =3D { .dt_id =3D TEGRA114_CLK_VDE, .present =3D true =
},
> @@ -1048,14 +1043,7 @@ static __init void tegra114_periph_clk_init(void _=
_iomem *clk_base,
>  					     0, 82, periph_clk_enb_refcnt);
>  	clks[TEGRA114_CLK_DSIB] =3D clk;
> =20
> -	/* emc mux */
> -	clk =3D clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> -			       ARRAY_SIZE(mux_pllmcp_clkm),
> -			       CLK_SET_RATE_NO_REPARENT,
> -			       clk_base + CLK_SOURCE_EMC,
> -			       29, 3, 0, &emc_lock);
> -
> -	clk =3D tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EM=
C,
> +	clk =3D tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
>  				    &emc_lock);
>  	clks[TEGRA114_CLK_MC] =3D clk;
> =20
> @@ -1321,6 +1309,26 @@ static int tegra114_reset_deassert(unsigned long i=
d)
>  	return 0;
>  }
> =20
> +static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args *=
clkspec,
> +						void *data)
> +{
> +	struct clk_hw *hw;
> +	struct clk *clk;
> +
> +	clk =3D of_clk_src_onecell_get(clkspec, data);
> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	hw =3D __clk_get_hw(clk);
> +
> +	if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> +		if (!tegra124_clk_emc_driver_available(hw))
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	return clk;
> +}
> +
>  static void __init tegra114_clock_init(struct device_node *np)
>  {
>  	struct device_node *node;
> @@ -1368,7 +1376,10 @@ static void __init tegra114_clock_init(struct devi=
ce_node *np)
>  	tegra_init_special_resets(1, tegra114_reset_assert,
>  				  tegra114_reset_deassert);
> =20
> -	tegra_add_of_provider(np, of_clk_src_onecell_get);
> +	tegra_add_of_provider(np, tegra114_clk_src_onecell_get);
> +	clks[TEGRA114_CLK_EMC] =3D tegra124_clk_register_emc(clk_base, np,
> +							   &emc_lock);
> +
>  	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> =20
>  	tegra_clk_apply_init_table =3D tegra114_clock_apply_init_table;
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>





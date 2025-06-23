Return-Path: <linux-pm+bounces-29301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924ECAE4083
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C7816D2FA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136B24EA80;
	Mon, 23 Jun 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oAd5Z8KB"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013013.outbound.protection.outlook.com [40.107.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A599247299;
	Mon, 23 Jun 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682011; cv=fail; b=u1TgEJY7v0eVPQg3CjrxDbIBNOmmk33mmPXpjv4VrS8FpXjKAanDcwDi5Gc+02E4M2lljEMbKkuJ7X+jJ9LZBlOOH4+XrIj4YG9C0exaKq8iHbknXvjP4YuW1JDxN18bwT+1P9CNjqgLHEJOA/t7NLkJuZjpCCN6MmCcQBb9UTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682011; c=relaxed/simple;
	bh=83VXph4EHUxyyfRbb9VCBKeQf9fpDRjlCjdJM1mDt/g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BTpzCMR2lqyhJDBSI3UFdsZQ2NdDYbPiELC54/1Um/R/ztugdsYiABvlEppZYhHC6saZyr9meoC8oWb5qo2fYsY1UksthsE/msg09Wyk2nFRjTJRvJ+CD65Se2LDqzIqzV7SIUEbYbMW0ifbq3EkwEYR9pxSn2Qoc9zN0yW7+pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oAd5Z8KB; arc=fail smtp.client-ip=40.107.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTVf7/H7iQ7NoI3TOUbvmMYv6GtZOVmrxOWWQF7IgZKrYAhWVu0KzmLQQU2ZqDJn8kwE9fD2I60E1vHe5FsIZbxk1unT1RCDo/UEl2vNXEiUpuBxu5Bfup33le4NKBJUvr+jju5xCkgl8bAHx01KNLJHsigd1R2Xpn9mwieYJ2XBmBLAWKVquOhZ/waY/DQadOhtcPgusxo+WakAjU7VgnW99Q64jYprLXczllO4b84rYCbLJVO/1sCDvVOze6sR7lNJF9eqN38sYree00/9/pT/5jK4M7e5cRhcdG9O/kiShqonqCTy3L0/qhVGkykSlY+bpcXu0X/81mGm+tNEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X71Qk1zOgwh+64zwLCEZ+3gp6XFQlEgHSqHur7UE9LU=;
 b=osaC7QxsQBk1m0i+OdmQ+nnL0X+8DXVO1HWRVFbux3m2X3OW9+lwPud+HOpFhGANR3oLLS8p/DmmACkMtlHzwq9cADBRZ9rLKhXIP09K1z10KswF2lKpCTvsiHjjWYuUeSetqeEJ8bal2D/FQk2cdG2bCnY69P6yXIC3CVsWL4ZlsInpF+v42HfPmWGHdEJsH/rucHjWmdcMn7hJNZjdLDEP0exFnc6C0oOYvEtwWnFWDVp/C0tuZCtlPZuLjJZcfVS95avPOWNDt1NpprJbmYGos6vrzIOCeDyZWlsodxou7luk7jV6gt1B0tj7HE7s9bf+zlOpWkgJMos1SCp6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X71Qk1zOgwh+64zwLCEZ+3gp6XFQlEgHSqHur7UE9LU=;
 b=oAd5Z8KB1lpgJIXMWw/uKzZFAZCpFhKgsmCVKTu73f2ztXjHYDSvAFOEbHt5wIdShM2jILmCkFWZLXt8Snhdbt1FSDSArXd5GPJaKUvbUv/IPZ1rjJZ4Z8U/hGlV4ol71MICXpHmwwtg+AskBwaVGxITeadnSpeQsQoLQlxOiHABmiifyV2i+UoMuegdT44nSmT1uijh+7rYcyBQfokbQg+0xDssffQCw6BmJnqBli6jIGQ6iOwcyzdxeXlxXnVJ3zKPkI5GZtaHBH+D9w42tWAx+HIALx38J7Inigcj0u46aSsx4WgM/oRPichjI2Lr+xrAQkwF3dY4s81OdEeFqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 12:33:26 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:33:26 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 02/24] thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:33:12 +0800
Message-Id: <20250623123312.472566-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TY0PR06MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd9a029-0a0e-436d-dff8-08ddb2522695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU5reDhiUWZkbTAvd3NRMVlwd01NcWxyREJWbnBiVTlJd2pQdTZXY3IwNkN5?=
 =?utf-8?B?dVhrcnlyMzJwSzh3cUlDM0pHbXJwNXU3cEQzM2NwMkhxWDAvMmxBU0tabXZ5?=
 =?utf-8?B?NFUvTitDdkp6Y0FkdWxXZ1Q1RElMZTYvSlFPa2ZDK3p2SEJ4NTlibm5KVjBh?=
 =?utf-8?B?VVJiRld5VjMzbmIrR3cwRWdYdTcreTlWUm1CS0ZvSkVPd3FHZ01KWjZJWk1J?=
 =?utf-8?B?Njd1N2daY2tuVTJZQXRuektLNUNGVE5JWEsxZmlNemxWUmExZElUUmQyNk9x?=
 =?utf-8?B?N3NCRitOTXgzcmdDT1ZPMHhtMHBoNkRGQzUxTGJma1JDN0JOMUswdHBGTUtx?=
 =?utf-8?B?bnArRmVzRlVhNjlQMDNWZk9IR2NRVUJpa3A5YTkwU1Y5YnhjZ1RGakw0Y3VI?=
 =?utf-8?B?Z2E2TUp1ZzB4UUtuQjBYQmZRTTFzTjgrNTNoMCtRSUJyZWxRaVU2cVdyOEVM?=
 =?utf-8?B?M0ZBV0ZWdjFSQ2hrUTdqcm9xdTkwaG1oQXFFeEZERG9TK3Fub1U4QjF5Vy8y?=
 =?utf-8?B?TmRoSE9kYTNXK0RETEFoakRnYVRGYURVL3NPZnBRSnFJN3ByOGZxdVd3ZWtr?=
 =?utf-8?B?eGo3WE03eGZCWSsweXd4dytqRGN5YkxMMkhWWGF6elVTMXZrYmtwVjJzNFFE?=
 =?utf-8?B?V1RnMDdVOVhHZGRQby96N0NWcHVITEdiWG5oaURRSVgzdnM5cUJQNFRQU040?=
 =?utf-8?B?MklFTU9ROWZjdDRoM1hkVVBVdWVuZnJzcGlsYzEvTGN2NGh1YVA2WW45ZGlM?=
 =?utf-8?B?OXBGQjdURVNPZnoveGcxemt3MFQvTnF4SnQvY0RIbGE2QVRCNDYrNllKSEpJ?=
 =?utf-8?B?UldoRGFCS054VUIzempVU2pLYlc0UlBlRXBvcGxzQWZiNXVsL2Y5ZHU3TDl6?=
 =?utf-8?B?VDA2YTNiL3FjNTQxNXdNTVlZSTBPZTNkcUJpcFRqU2FOcVZlNllIOXV2SW4y?=
 =?utf-8?B?eW1pTmNmTm5aWEhaZSt4c2xOVllIVlVPbnI0VmdXNnU3NVQ1UkJWRi9kNjRr?=
 =?utf-8?B?aFcxb1pLNFZWM1JHeDBwZEh2Q1VtSGFZMEFiOUNJUnBULy8rTnRNK21RcWJw?=
 =?utf-8?B?RWxIR1VJVE9nKzlLQm9kcW5QSnJBQzVMeWhoV0QveGE2UzE5b1MwWmxJRmY1?=
 =?utf-8?B?dHhtajZrd1lhS3E0R1Aycm9GbGJuK0RWSWZKaVFOTEhIK3hLMnBXU1lDZnhO?=
 =?utf-8?B?NWJUbXhVbVRrb05WQzRLMlkyQ2VDTGpoUGJKMzVqUXZkdXg3TzYvUzBhNVFM?=
 =?utf-8?B?a1V0KzBVck1pVHVacmh5TWlWOWFxWnp4d3lub0hhbStheVRCUVJydkJOWDhO?=
 =?utf-8?B?eHNIMUVDb3Vpa0ZlUXVRV0pIdXZxYlZ6VDV4RS94U0RFQ2kzQW00QTJvbmFR?=
 =?utf-8?B?emUyOHY0eFFZNkk0MHZIYUNpeHorYzhpTnFTbTZvZW8zYmtDSTM4SmpoWE9L?=
 =?utf-8?B?ZFZJMDJnR1ZQZWpzS1FhOTR1OGNuZEVPMTIwaG12SFgxdEw4ZDhUaDhoLzBo?=
 =?utf-8?B?bDYzaGJXVkpuOFk4dnRGZ2RxSVFmb3pZcEhRcHFkbm1Mc2FZaTFBaTM3L096?=
 =?utf-8?B?VWQrOHhTWFlTTEJKenpNRUFGM2VKT3Z6Y0llNUE3UnlKbW1jQWZYWTdEM0ty?=
 =?utf-8?B?Z0V0MXhUazY1T01oV0srSlZFc1VXSEMzMFNqajgyNDdqYkRBTUp6YnFEQXNP?=
 =?utf-8?B?UFROMmE0bytpU1FIR29sVGtQZm9Wc1JqVzBpK1l3eC8rMVVkd2JCYmZOczFs?=
 =?utf-8?B?Sjk0OVhYVGRQR2NYMkhXbzRGeEY5S0VlNGFJMUVMRHhSbnFXQ1RxVnBXTEFu?=
 =?utf-8?B?UG9FandIT0lMNWJMVzdVNHpWTnJPWTJnVzlZRWFkZ0RBRjNITldaL0lFbEpR?=
 =?utf-8?B?ZlI5NUNCNGxYU2R4R0lDWGpUU1JBdGNRZDV0K1YwdWxhbi9kcHNSTCs1ellG?=
 =?utf-8?B?a21hVHU0UE02Q1BxVkpGZE1PRXVsaVhIWTNPVEIwSkFmR0xhZ2I2RzM5WmxX?=
 =?utf-8?Q?2SqYMVDM3eBUNjvzXhIFlY5ANJhwUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGlRVUs4QUJMTDNUazZUTmRCY1hPUDZtbG5Na0ZCTGcrS3ZPWmpEWTBZMm9T?=
 =?utf-8?B?N1BoSWE2aE1VUnB6dmVHYklwMFhLZXBaQ1RnUFZRc1FOczJjazljNHVSVyti?=
 =?utf-8?B?bkpYMGYyM0p4ak5JazMveWpwSXltSmFJVlZDMHRvMDdqY2xscTRWT2N6Wm1x?=
 =?utf-8?B?cTJVa3pvTkZhUVJGSW1EQjJxQWFmbkNCQTBJSzVmajJwZHRnT3hrUW1GL0Ns?=
 =?utf-8?B?TlVVaVNvN3VHelRoVHR2Y1piRDlobVNwMmdZdHkzKzM1ekNXV1ZvOGg1SjZ3?=
 =?utf-8?B?R0FpNU42Qk1VOUNFd3A1bWdySnBLUWwrWDEydWp0UTIrRDNHVEZjRzhPS0RT?=
 =?utf-8?B?dFNaWDVIa3ZxK1REVjNmQVJmNDVLMU13Y1lDSmpzeFBnVzc2S04wV1lUa3I5?=
 =?utf-8?B?aGtNU0dVV1BINnhWMnpDaFZucitQcXZGMmhvNE0yeHM4NFlwKzhhZG03NnVR?=
 =?utf-8?B?Y0FYSVgwR0VMNjdPK2MrenhPZkYwRjBFb3RGOEdZZWdXSHZRQTEyWUxQSG5M?=
 =?utf-8?B?bzNTUWZ4T3hFMlU3WE5WeVlLMHhYOFVRaG5sekl0T0JTTnlvbU1xSnQ0WUMw?=
 =?utf-8?B?TGhmYWZrd2RYbE1heDEvSG5qT1NTQThjL1VHZUZCUVNIR0hCdGE5MTl3VzVl?=
 =?utf-8?B?ekJpZWdPK1BVcjZSY2didnNBdVp4SDA5VXBrYTVKV2trbUo4dm1JRXVTUm1C?=
 =?utf-8?B?QWJNNys1ZmF2MUVrcklSczkraG9Bb2RXMnM5ajVVaHl4TUJoQWlRSkxNYmtl?=
 =?utf-8?B?ZkgvZWt4ZWk4eUUzUXlSWUxna1BlQk1wUENCNlV1d2drWE51di83RjNKc012?=
 =?utf-8?B?VjJ2QWpDYk1YelBIUDd1Zy91UWlJUWVmU2pEYTRzQklSY2JTeTJ4RTFXcGhB?=
 =?utf-8?B?djU1MUttR3FtWjFiS0lXT3U5WCtURk9oVU1xYzBCSDJMcm1CY0FuOU9veUdL?=
 =?utf-8?B?WVZMSmNRRGRkNmU0aFY2dTNmS2NhazRiQVMwN0RObVVLclhud2xHVVZxYk05?=
 =?utf-8?B?VGQ4QnNtQXlVbDVOcGZwQjZYZVJKcmw0NVNkWE5kaXM4L0p2MmI0dkxxT21N?=
 =?utf-8?B?WnhGaUcvbm5KNmY0YzZmWnduU1RPbmt4cTJ3MUtEalJLK0pYeUgzcDRYbFRU?=
 =?utf-8?B?TjVPL3JxZVozTkhERHNoelBXOVNYTlYzQi8veXRtUGxvTmZDTklyTUpRMENi?=
 =?utf-8?B?elpybjZ2eFZEbWE2Y1VLTlBXM0dZTmtXSlpTR0FkYzFjUUNlSWszcWZiNnVm?=
 =?utf-8?B?Q2pqRXZqUldYSkc1N3JaRy9HQVNuRHkySGlKeVQzUWNXaTRidVZRNEJYaldp?=
 =?utf-8?B?VWk1bW9Zd3U5S2xMVDNEWlVLNDdCcUI3N1hxeW1mQUZ0Y2pDaEdkLzhTTDFW?=
 =?utf-8?B?ZHdVT1diU2xiUVN0ZCtxTXZubmtuZjFqK0tURGJ3Q2xvajdVSmJKYllWVzFh?=
 =?utf-8?B?V2czdzJ0c3BYNFg4Qk1tK0NickxkbzlYWGtYRmRSQVNyNjViSEJuL3NsU1BK?=
 =?utf-8?B?QzQzTXExVmpTK0hkajRja2MzQjJ1S2h2VE10NkJzWXY1djNNMStUNSt2cHh1?=
 =?utf-8?B?dkpKKzBxeDR0alJlVSsvNERpdjBCQ0tOaDF4Rks3MmZxNWlBaFI1akNQNDFk?=
 =?utf-8?B?b3RkS1gzVlBtR2tiMmJKTThoaEFxS1VzZmMzMU5Nc3B3UkF4Q1kyMnZpNE5w?=
 =?utf-8?B?cFJUbm9xamJkR21nMnh1RC9MN0duajdiclRiOGs4clZKYkZZdTFDWkcrRjNC?=
 =?utf-8?B?cjZ5ODNLODY5ckxYQldwN3c3bVFpMDRHSkpnMmdlMWJJdVVMQTBzcm0ybU9a?=
 =?utf-8?B?alQ3YUdyUmpRQ2phb1I5RW1VY2xBTE1wdDN2cmV6eDFmeGlJbUJiOEVldndl?=
 =?utf-8?B?eDVLY2ZqWHBCeWkwZ1I3MHpRL2Q3QmdUdFByZ1FVVnZ0ZmlGS1ZCY0xHSGpL?=
 =?utf-8?B?NVlGNnpLSkFGdml5aGZMUkRuYVNBNXJ4RFEyNHNjcjd0NjdKb2J5MnVDV016?=
 =?utf-8?B?TjBWQWNsWGRIcm80YVZnN1d4U0xtNDNrcVFJVVhxM0lRcEh5S3pXbTd6WlVO?=
 =?utf-8?B?Wk9xVFoyRXlhSEN1KzM3VTJsaktta3hjM0ZIaml1dXBYaG52Z0EwMUVSWnRO?=
 =?utf-8?Q?Xi+i9IdRydPNGYMA2WnBxBq9Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd9a029-0a0e-436d-dff8-08ddb2522695
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:33:26.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmYKem00TP7Jb0gcGy+aI3U5qGSIWaj6P2Gxrey3EMqtUlG2wP3XyHi13zs9yDEB8IwjHt5YEOVDO0MQ/Vc+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/sun8i_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 22674790629a..43f6a9d9bd76 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -587,9 +587,9 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	 * registered yet, we deffer the registration of the interrupt to
 	 * the end.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL,
-					sun8i_irq_thread,
-					IRQF_ONESHOT, "ths", tmdev);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+					      sun8i_irq_thread,
+					      IRQF_ONESHOT, "ths", tmdev, NULL);
 	if (ret)
 		return ret;
 
-- 
2.39.0



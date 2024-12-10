Return-Path: <linux-pm+bounces-18894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593D59EAA57
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23BA188B6DE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929022E40F;
	Tue, 10 Dec 2024 08:11:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020140.outbound.protection.outlook.com [52.101.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE322CBE5;
	Tue, 10 Dec 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818290; cv=fail; b=RPOkbCGHBSZP38qD8X4mOEkzlN17XpVn8b/at+tT5Frv0yHA/3ivmoEXmOhdeOPP+yplHSegpbbmyWvtb8JYyJH0EWx7lzg1lMeBP5V00thGVkK4+3ZjkoIfM2jjaR4bg1+8bWythDGtyprKbRIBmxk4XQssGbc1vESk5WF7EvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818290; c=relaxed/simple;
	bh=dxzLznjO3OltVFgiselyM+9xdFrpUOBCh3QNtXANbAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p77lYIMiQQ+Iz8W26iBfifaFmbaPVT9K8pLsJ5m/Zgknc/rWM925fKcnYnDJ62mml1CfcIvevtX/LYWASsyKo9e9JzAAL/Z+vMZRQ51dYHIKWW3tTTH01PalnJZRMaj/gt/GAXLpEeq4UQpf0miYRSzaBDo2EXwq9IcbbVFxIik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwUg+sLtLkD8x2mYW2AKLAI/Xfo4EObtyyx0ZevNsG7pYQSczJF1izhalGs0v10AdZ48d4rM400ZgeTz5fZObXBdGunhSFjA+Krm53wQY62DySFhSCG+032JTWVjhP7KRiwuH6txUKdS8vgXij0+L/meFGl0jvs4aV0jaDJhyrBgKvaL9EEnawMQBCgbntt2+cF1C0x2SR68EWoj2qBOMSBDEZIboSQiDHmIIWoqs3KiMwwP81V+XtIdBkCdkMcA2ZDMrPP4+NpK4PPXAfT9Q85ya5mz6VIIi3bhHRw7WGQc6SCzTlMFcSCqdSB4MMsFh4udY9V8HDzOX9aXHyeEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6Oj6+ofxB3rf1YAeCkfdsxOBtjHzlezZyql0SmVWT0=;
 b=jiWUwv4LYbxD5i01r4tMkCNJiRwwb74rMPd3FKkuu3OFfPWrM8dJzwnd19cxvcXQFV8I0BkKCrGKLgsRx3Oj2Qc1F6DhghF6kSF8Q/W3UsPOETXbi4d2yVTcHiQSwsx7lEaalzk63bHxkdCOFV3+fy2UEbI41ZzhsilIjwf9dx294UYfVUIAU/Z+Sbx1QWn/PQF610vY7IQv7/OEhpiesqwi5EpzIiymi5XSbrU+/KV9bHBAnyCDWXYOGYHBctQWD3KhOM2FINDLz81VwZ+pwYdjaT8c2R6ZmnE3/orIWOAmcgt3HoVDzcGrlEmVCtJik8miwMaBeW+vvjpCNN2S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MA0P287MB1195.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 08:11:22 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 08:11:22 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Tue, 10 Dec 2024 13:39:46 +0530
Message-Id: <20241210080954.5067-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210080954.5067-1-bhavin.sharma@siliconsignals.io>
References: <20241210080954.5067-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|MA0P287MB1195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2387af51-d456-4f75-1fce-08dd18f23c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGhHQnREclRrc1dIUTAyVHUwYndjb2tLL3I0WmcyV2lrenhFcm0yemFubHB2?=
 =?utf-8?B?MkJEVmZUZG1IWENlMERneEpHVlJ0aXpVZExkMFhGVHZCZENUTjFXdUFONFg5?=
 =?utf-8?B?UGdGM2NhS2hOZHk3OFZ5ejZrN3ZOLzFvQ1FSa2Z6ajFPNVFxZ21oKzF2LzQ1?=
 =?utf-8?B?VTQ0Mk9YNGpvYk1PeEpibUx2Zm5ZV1FJZEFtVjlNdG5mRi9pdXlZWGZzM2lV?=
 =?utf-8?B?NHNpUW05cWYySS81WFJZUkcyUWJncFhVZW9lMmg1Q28wdFpRRWsrd01PMzEy?=
 =?utf-8?B?QzZWeWhSNXJDWTB6TzlsNkxjNEZSKzMrckFpc2NENWJuRVVzaDEwWmlwOVo4?=
 =?utf-8?B?YnFFMytmenFSU3Zzb2d2VWZBZ1NTTEFmTzNoYTNiaC80MmtwbHJWMlVGcHF0?=
 =?utf-8?B?c0R4cWd5eHNTK3lsY25LWGFpUUJVTnpUY29iS1FHMm9ONnpZTnFMRENGdGE0?=
 =?utf-8?B?dmxkUk9wbUdoYjVOanlYdFVIK3crWGsvaXJEL3l6K3Z3QWxXTnJOMjE0UnJO?=
 =?utf-8?B?enkrNE1UbnA3MXA4TDJlNTRaMFhxTWJBdFFXdGNDWDI0Nkx0WU93dWwzbmxr?=
 =?utf-8?B?QlRmNzN5TVh0ZzJaQ1ZJTFR6Q0E5dmdWSTA4ZkFNbHU0VW9VRjlkL0NFNVBs?=
 =?utf-8?B?bE9vNjVHdThEOHVmeTF5bmF2TkRNbHdyUjVySXM0a2dtY3RHblRVRFkvVG9I?=
 =?utf-8?B?czR2aWo0UENXM25qeVpnNE1RZXJ6TEN4Z05uSFB1TlRWRW95T2lFek01VE1G?=
 =?utf-8?B?NFM1YU1QcDNKdXIrYjlUdjNZM0YzNUp0RkIxNGgzbnVsRWR3bUp1SEZLYml4?=
 =?utf-8?B?Mmw2TVdkRDRVc213Smh0QmJacXpWTThYazB4K3dYVFFCQ0Rkem55SEErWmVs?=
 =?utf-8?B?SXZsbUlybHdLaEZBQkNQV3M0RGcyNGpqRHZydFd1SkVzb1VRd3psN1lMSFFI?=
 =?utf-8?B?S3d2QTFVZW9FT0NpWmYvRUpsN1BTNG0yRlkxb3hzN1c2dFJob0FUNmMxN0ZO?=
 =?utf-8?B?UDZ3RFdoalJ6eG1aZW5VeFZNVzZicUV0QlNzcWZzczh5ZTd5Qy82SFpBYXBD?=
 =?utf-8?B?TVJMQmx6QXlVbnMzajBnQ0ZzcGdGeEpuRG1ZUWtTdUxTbkI2V2NYMVFTVUFZ?=
 =?utf-8?B?aERCK0VkN0Z6WHBYNGhYbm9UbS8zczVoY1doS1FTY3d4UUJLUXFrSDFaRW1s?=
 =?utf-8?B?UWMvWThDYXpabjJUZHVWdlNvaEYyWXIzZEU3ZER2bkJSRVJwWS92MGFqeEpR?=
 =?utf-8?B?aGltNWVBRXc3MUw1bWIzK0Rjb0huVHEvRWJUM0w2VkFFOVJiM1l3ZnVkanRF?=
 =?utf-8?B?N01lR0lFS2hxNFJXZVI1QXVyYkdXNktUa2U3akE3cHpTbzdNTnZXcDcrOGJo?=
 =?utf-8?B?MHNrTWtJSkpiaVh4TVE4UWQvV3pCeHpCQ0tHYllPM3hqeDEyNjNlRjB2VTBi?=
 =?utf-8?B?YVZ3VUtaUDE2V281N0IzOWRPZGllQlBueTg2UG5tbGtLTitHdTdLTCt1czMx?=
 =?utf-8?B?S2xKVDk5RWRYbGZwSDM4Ulo2Y0x0VkZKUGZwb2o1MngzYkFzSCtOSDZ3aGU5?=
 =?utf-8?B?M1dnYmZ1UmlaQXZqRVN5WTQ1Tm9BL2JvQkxvMFdnNzYzM2Noa2syL3ZETnQr?=
 =?utf-8?B?b3J5eWpCTFRkQ2c0dWVCZXNtUDgraWRGaHAybU9ZdFZVUGNrUEczZ0tvQUlr?=
 =?utf-8?B?dE5TWmwvMU5UOS9uam11cEU1QitwZXdCemlBTFNoaTZwR2xPK25ocmgwK1p5?=
 =?utf-8?B?bEtUVG9hQ2hzaG9IbzZvZ0dLRDRZbW84RllrdTc4OTVlSWlYYUVpNXl3clBJ?=
 =?utf-8?B?TkNCUkt2U01ZZVJhV3JRSmtsZkJhVEkvQWV1aWcvY2FUaGUwbWxPOXhmdEpi?=
 =?utf-8?B?MC9HWm05dFREcmJtRVZLRjVKWmlGcUVEWkRNREN4TWorQmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEt1RGJMUFBCTVpmelEvTXYzM2hDT203UERGL3FZQUlhYUZibGoxN1d4VlNR?=
 =?utf-8?B?b1RWYXIxZ2VaTTBwYlZFUWpVeWp6dUxWY3FjL2lmZElVeTNySTZOT2NpNGM2?=
 =?utf-8?B?RENXdkhuRnVJYWw3NDl2Njg1UHp0aDhyYm9kZkFJUVg0WEs0bGtnU2gyTnph?=
 =?utf-8?B?eWw2eFQyN2F4d1JSQ00wc042bkNRWFdOMU92Tlc4MTB0LzAzL1ZpR0JQdE9S?=
 =?utf-8?B?bmhYKzFnS2RnZDlWYVd4cTlWYVFDQmRzWWhpR3ZySS9kMkhKZHJKcWxXUlp0?=
 =?utf-8?B?ekNyM0NqRlpvSk9CdkNPa2VmSXhYLzFOc0dQSVFMUkRYdEE0VHQyVGdYRitX?=
 =?utf-8?B?VkdKeEh4cGd6U3BZV3phSEp0RllNS1NiN0s4eE9oZTRzd0JmZ3k4OVArMy9i?=
 =?utf-8?B?NXNWS3NnekY0QmZMcW9kWWhhaWU0bzUvdXMzWUNZZXJWVWZSOWUxR1Z1Nlpk?=
 =?utf-8?B?NnJGZFAvbC9valF6bDRjR1pvdC8wbTc2Q2Nod0x2U01xZnF3eCsxeEFCbjZU?=
 =?utf-8?B?U3A3WG9Cd1B4VVQwVkI2ajg4Ryt4eUsrRjFpYkREcVRnZ1lEem85TUNHSm4v?=
 =?utf-8?B?RUhBZ2lXajBkWjArR2x4Q2VFNWxBWm41T2NYWDhVNmphSEViVjBxOWZxOXB3?=
 =?utf-8?B?c3VpdytGM3MybXA1UkxGTUgrVm91NkNubHVlMWF3RExoaTBuMldWYVJUTS9m?=
 =?utf-8?B?cGZUOE4xVFR2YkJoQWdyYnRqaUNmV3ZIU0hxVXk1bzJyeE9rUjl3VDl0YWNO?=
 =?utf-8?B?T0tEMUZvSVpSS1pLVWtxNGZNdkpjTTYxM3psY3pNY01waXFjWlZGcU51ayty?=
 =?utf-8?B?RXJ1Wks5SU5aR3U0b1FXVVhpR1JQWFVwSjM3OG9ibDlXSldoeWp2aDVKNGdR?=
 =?utf-8?B?dWFMa1UxTVEwWFFpd0w0VnhsQzlOMUV3bE05WGtCNzlXRGdVdzVPVnM1MUZM?=
 =?utf-8?B?c0tjTzFWYmRZUDJjTkVMdVNLZTNobnY1Nkt3THNBWmFRQUdKS0t0T2JuVUJH?=
 =?utf-8?B?MUU3aXp6c1RIZDd1NDEvaW9sR3Q3U0JuanpONk9GS1Q5ZG41MWlVSmFZTTVE?=
 =?utf-8?B?VkJnQ21sUXorSjlZd1VUb1VqV2RlNldQb2dCZlpxSFRGdXhGbmFwamg5d1Bu?=
 =?utf-8?B?b2s5OVp6b3RLbmw4ZklkMWpmaWxhQU9rZ29XUUlUSFhlRXBReGtRaEx0Wlk1?=
 =?utf-8?B?ZXFRcHNMSVpRL1ZMUmdOSGlnczFDRmhQZWxFa0ZYWkQxeGYrMzk4N0tmMnFr?=
 =?utf-8?B?dnhha2xxbDVyM2V2VU04WkFoYXZKUnp0d1dqQ1lPa2w2NWxLNGZabkVWZW1s?=
 =?utf-8?B?cXNGWjVkaUtwOXNab1pNY3JJUjBqc0ZXdFF4Lzh2T0FhRXJhMkxuNjlSbHZr?=
 =?utf-8?B?Y3JvWlRLeXdBQUoxNjBqOC8vU0ljTDZkelRLRjk4aHpDc004dmRYV05hdmt0?=
 =?utf-8?B?NnhzY1Qxb0NJNHNMYzBGeE5hdHM3eDZacHFsZHkwTHB1SkE0eDlzdmk3ZXVt?=
 =?utf-8?B?Mmc3VmJ5d0lnMXo4UUwxUkdHcXlmK3FQU0xJN2lhT2kzV1NsQXVYVUsydGVP?=
 =?utf-8?B?VHdVUG04b2s5blRUc3VMdmRnWHd5VDIrWGNXTHdaMmt4aDRxTkZuWDd4RHoy?=
 =?utf-8?B?NThkYXFja0ZOVEpuQXorN0M4NVN4aGZTb1dLaFY0b3BZUytGUjFSVWJLUHBQ?=
 =?utf-8?B?dXFNNk9Ib0Y5RUs1WXhrZXpOYmFGOTBVY0psUlRvL1NoUE5TZUNqSVM3M3pU?=
 =?utf-8?B?YXc0YkRHSzdLNDcydTZ5bFF6bjdST3A1T2lpKzFWVlRrbHhsSzg1blFvNkhi?=
 =?utf-8?B?TzFIcHdiVFhHYWlCT2NiSHVwZVFuT1JJSG1HRnVWRWUvTWhVcTIzdEtwTjh5?=
 =?utf-8?B?a1dBOEczaDBVRUlsN2FrQ1BKTnBQN2UreEYxOWoweEh1R2xLT05XZW1QQlNU?=
 =?utf-8?B?WkZnR1g0cGRqY1BtdlRUNTY3SzBjdmsxN1VLMUhUby8rV21qR2xoaTZhajhm?=
 =?utf-8?B?aWlZSS8zbnVpZXdyMHNnenJkblBQblZXQXhXNFdGMmk0SFkzYXJuaWlVOG1w?=
 =?utf-8?B?VkpXMkt5VEZTdGp0eldLcGx3S3FRYWE0U2Y5Z0lXUFFidUQ0Wk9KTTArRWRW?=
 =?utf-8?B?bm0xaE5HK3dqMlRXeW9oVUpzTmdsS0Z5ck9pSGl6RThFalZRb1VTNVp3S0s0?=
 =?utf-8?Q?mLDBQco+h8RxmsYjbUxhDZI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2387af51-d456-4f75-1fce-08dd18f23c14
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:11:22.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+BgFdliYQposZ9FKKX4+u1PDka6F863HvIcTF7Hk3kZIX9FKc/+I+nNFTcmRBztCnyQXc1GAwTNfi5d9fJxfnfCzBR04aVgwyF6UKDc5AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1195

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>            
---

Output of test_power_supply_properties.sh:

TAP version 13
1..33
# Testing device stc3117-battery
ok 1 stc3117-battery.exists
ok 2 stc3117-battery.uevent.NAME
ok 3 stc3117-battery.sysfs.type
ok 4 stc3117-battery.uevent.TYPE
ok 5 stc3117-battery.sysfs.usb_type # SKIP
ok 6 stc3117-battery.sysfs.online # SKIP
# Reported: '1' ()
ok 7 stc3117-battery.sysfs.present
# Reported: 'Discharging'
ok 8 stc3117-battery.sysfs.status
# Reported: '38' % ()
ok 9 stc3117-battery.sysfs.capacity
ok 10 stc3117-battery.sysfs.capacity_level # SKIP
ok 11 stc3117-battery.sysfs.model_name # SKIP
ok 12 stc3117-battery.sysfs.manufacturer # SKIP
ok 13 stc3117-battery.sysfs.serial_number # SKIP
ok 14 stc3117-battery.sysfs.technology # SKIP
ok 15 stc3117-battery.sysfs.cycle_count # SKIP
ok 16 stc3117-battery.sysfs.scope # SKIP
ok 17 stc3117-battery.sysfs.input_current_limit # SKIP
ok 18 stc3117-battery.sysfs.input_voltage_limit # SKIP
# Reported: '3704000' uV (3.704 V)
ok 19 stc3117-battery.sysfs.voltage_now
ok 20 stc3117-battery.sysfs.voltage_min # SKIP
ok 21 stc3117-battery.sysfs.voltage_max # SKIP
# Reported: '3200000' uV (3.2 V)
ok 22 stc3117-battery.sysfs.voltage_min_design
# Reported: '4200000' uV (4.2 V)
ok 23 stc3117-battery.sysfs.voltage_max_design
# Reported: '325000' uA (325 mA)
ok 24 stc3117-battery.sysfs.current_now
ok 25 stc3117-battery.sysfs.current_max # SKIP
ok 26 stc3117-battery.sysfs.charge_now # SKIP
ok 27 stc3117-battery.sysfs.charge_full # SKIP
# Reported: '3000000' uAh (3 Ah)
ok 28 stc3117-battery.sysfs.charge_full_design
ok 29 stc3117-battery.sysfs.power_now # SKIP
ok 30 stc3117-battery.sysfs.energy_now # SKIP
ok 31 stc3117-battery.sysfs.energy_full # SKIP
ok 32 stc3117-battery.sysfs.energy_full_design # SKIP
ok 33 stc3117-battery.sysfs.energy_full_design # SKIP
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:21 error:0

---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 608 ++++++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..bcf15907b25b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22168,6 +22168,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..5c13fbc9751e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+       tristate "STMicroelectronics STC3117 fuel gauge driver"
+       depends on I2C
+       help
+         Say Y here to enable support for fuel gauge with STC3117
+         chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..4abc0cf375f6
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/crc8.h>
+#include <linux/devm-helpers.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define STC3117_ADDR_MODE              0x00
+#define STC3117_ADDR_CTRL              0x01
+#define STC3117_ADDR_SOC_L             0x02
+#define STC3117_ADDR_SOC_H             0x03
+#define STC3117_ADDR_COUNTER_L         0x04
+#define STC3117_ADDR_COUNTER_H         0x05
+#define STC3117_ADDR_CURRENT_L         0x06
+#define STC3117_ADDR_CURRENT_H         0x07
+#define STC3117_ADDR_VOLTAGE_L         0x08
+#define STC3117_ADDR_VOLTAGE_H         0x09
+#define STC3117_ADDR_TEMPERATURE       0x0A
+#define STC3117_ADDR_AVG_CURRENT_L     0x0B
+#define STC3117_ADDR_AVG_CURRENT_H     0x0C
+#define STC3117_ADDR_OCV_L             0x0D
+#define STC3117_ADDR_OCV_H             0x0E
+#define STC3117_ADDR_CC_CNF_L          0x0F
+#define STC3117_ADDR_CC_CNF_H          0x10
+#define STC3117_ADDR_VM_CNF_L          0x11
+#define STC3117_ADDR_VM_CNF_H          0x12
+#define STC3117_ADDR_ALARM_soc         0x13
+#define STC3117_ADDR_ALARM_VOLTAGE     0x14
+#define STC3117_ADDR_ID                0x18
+#define STC3117_ADDR_CC_ADJ_L		0x1B
+#define STC3117_ADDR_CC_ADJ_H		0x1C
+#define STC3117_ADDR_VM_ADJ_L		0x1D
+#define STC3117_ADDR_VM_ADJ_H		0x1E
+#define STC3117_ADDR_RAM		0x20
+#define STC3117_ADDR_OCV_TABLE		0x30
+#define STC3117_ADDR_SOC_TABLE		0x30
+
+/* Bit mask definition */
+#define STC3117_ID			0x16
+#define STC3117_MIXED_MODE		0x00
+#define STC3117_VMODE			BIT(0)
+#define STC3117_GG_RUN			BIT(4)
+#define STC3117_CC_MODE		BIT(5)
+#define STC3117_BATFAIL		BIT(3)
+#define STC3117_PORDET			BIT(4)
+#define STC3117_RAM_SIZE		16
+#define STC3117_OCV_TABLE_SIZE		16
+#define STC3117_RAM_TESTWORD		0x53A9
+#define STC3117_SOFT_RESET             0x11
+#define STC3117_NOMINAL_CAPACITY	2600
+
+#define VOLTAGE_LSB_VALUE		9011
+#define CURRENT_LSB_VALUE		24084
+#define APP_CUTOFF_VOLTAGE		2500
+#define MAX_HRSOC			51200
+#define MAX_SOC			1000
+#define CHG_MIN_CURRENT		200
+#define CHG_END_CURRENT		20
+#define APP_MIN_CURRENT		(-5)
+#define BATTERY_FULL			95
+#define INVALID_TEMPERATURE		250
+#define CRC8_POLYNOMIAL		0x07
+#define CRC8_INIT			0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+};
+
+struct stc3117_battery_info {
+	int voltage_min_mv;
+	int voltage_max_mv;
+	int battery_capacity_mah;
+	int sense_resistor;
+} battery_info;
+
+static int stc3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* current in mA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			     CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp in °C */
+	data->temp = reg_list[10];
+
+	/* Avg current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+				CURRENT_LSB_VALUE / battery_info.sense_resistor);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv in mV */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+			     ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		ret |= regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+					(ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+					(ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int id, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (battery_info.battery_capacity_mah *
+			battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity_mah
+						* 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if (ret)
+			return ret;
+
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+					  STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int id, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+		if (ret)
+			return ret;
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (ret)
+		return ret;
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = 0;
+		data->temp = INVALID_TEMPERATURE;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = 0;
+			data->batt_current = 0;
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data =
+		container_of(work, struct stc3117_data, update_work.work);
+
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+		enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = data->ocv * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = data->avg_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp * 10;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	psy_cfg.drv_data = data;
+
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+					   &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+				       &battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get sense-registor\n");
+	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
+	battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
+	battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialization of stc3117\n");
+
+	ret = devm_delayed_work_autocancel(&client->dev, &data->update_work,
+					   fuel_gauge_update_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{ "stc3117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.34.1



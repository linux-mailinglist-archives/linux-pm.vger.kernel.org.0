Return-Path: <linux-pm+bounces-21615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37084A2E1B3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 01:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F191887C1C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 00:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD404625;
	Mon, 10 Feb 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FVBIQtGx"
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8C182;
	Mon, 10 Feb 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739145749; cv=fail; b=ZBiRmhuH8byKjTNFktJvDlIeKw+hpfijX4+q3OT0merNTw+qlOqvJ+uSB+w7bdoi5MSl2kcAJDJUn5xkxgvXp/8+P6phXnDAKWTvUodRu0RteLpewp2zxCAubA878cjdjL+7M0XincTHoGxzos6gxMQ+8bPvRgFpFVRk2ZbztJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739145749; c=relaxed/simple;
	bh=TZLgShhcRvaYHzJqYR5AUpaEpQ7IT6g6kgUqrT7ygls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fkw3aBYv6aicfFGSUgVr0NG7//si0FeoMQ/3DrsUbeyMRAlAB2NJedvU8jWVBEC+ZpzBU0DGI5CWgZWp5yABzni5x7F65Q9TKu4HlMSFUjhry/rJ5u5BuE+/77DV1tu/PaZ3JKKrdOuUIuuewGbVIO2oYBLY4WAo2pWcwUIgFP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FVBIQtGx; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4NKW0no9WZAu9RKimdHRAqdtE1rEyAqMY4G5fYPiz1QjQybTX++tG9P7wX6w21Y7mL8RVSBZ9hb6UV9U4ubhRGAFpJBstnbE1ohsdX5xMCTcKO7yq3+cs6FSoMDZrHdvudUFS8lVUNAGCT+GWYotW3/ArbwRee6ka4ThSgpvbNPkJGrtqpOCBHkf1ma04K+HiJsbmfpsdEgufmnY17Q43jvvkaHVwC6TDUw1uiLI8Pw38A0ByWkVxAIbs14DQqBlxp6ij6j/rNDMpSEvwD88lDLsKqlLnW41t58eH1HHDzN3+NTrkK0xNpLrYCICVkbLg2pYUW+Qr/GAKlWHTOQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb9Vk9DPaIaHkqGUII+GRmxKSJiIXJ0YSMBzkORiyn8=;
 b=vpqTXODbnClZ8aQqOlOgX4byZlW0xzXvAI3FGGVP+Plxf7Hb9LzUY9JkqoxgYla4eKU504CPUbGLWGppVPw49r+qwvnYhimnva7YUhYy9e0Z8MBtPlYQVA+Qej/DH8aQUFTuoKXR3dHY0h0ZFoOq35Xo4sdS0VrhBkztFVEhnvMiU357HHOHsgPdLwjJ5BXYChi4L5E2g4llKp2cBYeh5kSjLSMt9KRHI4sxczCchzjAs0O9GxEWl5jJTnYe+u38oCEsL+jpfXD58jlYenpVQ7J6WSfYXWcZ+eB+73aVVeg9oBRZ3LzJvwS2YLHpV3vqfEHtXcB+3hM4Zx+2QgUdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb9Vk9DPaIaHkqGUII+GRmxKSJiIXJ0YSMBzkORiyn8=;
 b=FVBIQtGxESk7mi3gt7RubGHjsw7VfD5kJqkgji6fi4jm4kCulzm9Dz6yhJ3ZT/0zUjUbk1X4CzRTgkcYypEm4WKnMDw8fi27F8R8rgYPsDllB4anq42USlDZIphUzCGeab5NVuEJVw93sD0d4Va6CUrQnudJ8FLpfAN3uC3LYO5veXO93tO6FtDjVY8tNKfRMjN5BXzwXd3+pDpsfnl7Qme85xO50uONNU51odbLfDJ/l7Hf8uWdmZCQLHvy55l5bfJsQzVErccj9xOUI/Cool9+vS1ksbbOUvr1i+TDCaT/kqmRenBoBcH/zhhZy/eoWnpRBZJntwsx0CWq44H1Og==
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3a::19)
 by PN3PR01MB7613.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 00:02:19 +0000
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71]) by BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71%7]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 00:02:19 +0000
Message-ID:
 <BMXPR01MB244050BA1841F4416FF0484CFEF22@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 10 Feb 2025 08:02:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, soc@lists.linux.dev,
 Inochi Amaoto <inochiama@outlook.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
 Haylen Chu <heylenay@outlook.com>, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:3a::19)
X-Microsoft-Original-Message-ID:
 <78230a9b-5d4e-444c-a4ee-c9ac4dd4c550@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB2440:EE_|PN3PR01MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0ee1fa-61b6-4b64-02ba-08dd49662f8b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|19110799003|8060799006|15080799006|7092599003|461199028|3412199025|4302099013|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZJc0V4NlpGNkZvUEp5YWd6cWN6RFZnS2U1MTB6bFJxZXFoN0s2cFdwYW5D?=
 =?utf-8?B?dGhtVlJ1K2VwVXl5bHJvakNmcjB2QnR0R3hYWnVwaHNDNTRXM1RqOS9uRmU2?=
 =?utf-8?B?UWQvRmpkNDFtT2c3REFjbDQ3ZTRyMXIwK3Z2T3NzQlRpUys5UDdITlNXZU9E?=
 =?utf-8?B?UVNtd2VONXM5WS9hWUlVaENSYUlieTN4TWl3ekxaZ3h2ZEl1V0k5NEU3TXNk?=
 =?utf-8?B?TUgwMVJzY25KclFTN0V1YXBRcW4wWDZiOTR6QmpjUXArd1JrK2JKRzJrSkha?=
 =?utf-8?B?K3BTTHk0eElvUXB5RVBONXdzOURHZ2d3Qzg0b2QxbG9jdkh6NEFWdUZZZDBj?=
 =?utf-8?B?bWZHV0NRSzNhYm11Q2lzN1BlQ1lubHZMQWJkNVFUTFQydkVQSU0vQ052Ykda?=
 =?utf-8?B?Wm1ldnBnM3Y3clJmcGovclN2UkxQdkhsUHN2VnJpakpXOUFCU0lsekRyOTN0?=
 =?utf-8?B?cFpra2Y2bERpeUpxWHg3cVBwcXB2djdxc242bzFrbVdoMGxjTjI5d1hmMm52?=
 =?utf-8?B?WklhK0M5b2dFZmlHM3ZjK3A0V3NYN1k3OTRWRkdIN2ZwMm9kcjlwQ0pJMW12?=
 =?utf-8?B?STI2cjlIV080OTFlS25UMkE4elozNWh6VWQzN0xuQjNUY0V3aVd5YVlCc0pZ?=
 =?utf-8?B?aWk4b3psK0hLdld3WHBQWWVlSE9nV0E2bmg0VjllWDRsMHR6NnUxRkVRVGtr?=
 =?utf-8?B?YzVUNzl3SWxmcXRmSTdZWmxCbldXN0c1K1pibGRLekpDOGw2YkRTTHFHTFV6?=
 =?utf-8?B?bFAvdVdCZE40NEFZSnNxU2grVzlvbXY1UEhjNGN3N21ldDc4NGl4MmhUdGp2?=
 =?utf-8?B?MUJsU1VMZWo2bDU4YmFSa3dSVzNaeE43Mzk4K0ZHQ0J2ZU9ucXZQM0t5enVw?=
 =?utf-8?B?NE9YSDkzc0NDVE5JSkhpaWt1djU2MWp4US8xcDJ0UDA3QUtMblFVK0VhbUJy?=
 =?utf-8?B?UGt6V05EbFZYRkw0ekUwS3NOUWN0Y3RmNzR2Uklvc2w4bGNtaVM1K25VT1Jv?=
 =?utf-8?B?VHN4bW5Ua29YaHV3YXQ1M3lHbzZvUWlMWFBnZDhnblpSY1N1bHJ5UGFCOGg3?=
 =?utf-8?B?VXNZQnB1dUw1bjRMZXNLeWVXMGhUTG5Xb3ZxV2o4dXBCTVdJNHkwNlFJMll1?=
 =?utf-8?B?c0F3RFVSR01BeGJ4TDZ6c0F1Ryt2TGZ5RGhyV3lyUnBSSDVoYnJDem9KdEZq?=
 =?utf-8?B?djN0U0syTHdlZ3JraS8rZ2c3VHp3Wi81NkJUQTFLL3pqZm5hZ1pnMGhnTEF0?=
 =?utf-8?B?Uk5mR3NJcjRyNUw1ZTFGTDVXWWpnNmFIUzBwVHFsalphNFpEaWN5aEtxbldG?=
 =?utf-8?B?YjdSUVJDemYrMHVyaU9hL1VyQ2w3Tk5VdVRyemQxMlFlcUtRK0pSdmNEb2Iy?=
 =?utf-8?B?enZqWWNOM2NCUFZaRnByVEdMZnFYMHYxQWJiQVN3S1YvdWFsYjR2SUN6NGdC?=
 =?utf-8?B?bTdLRzBuTkJUdXF1cUR4d2ZnSXZCZzJTemVrN1dxRktrSzRpSWVVVzRFRUpI?=
 =?utf-8?B?U0IrcnpqM3l4RG1OSWpmK3FubjFXdG1aQjJ0RnI1QzFaa1RKLzNpVjg4Nkhu?=
 =?utf-8?B?SVNNeXlFYXVzVUt0VVF5bGQ5UVJibEZSRmF4blV6SkFYeHZ1OGliSm12NGls?=
 =?utf-8?Q?eFtsKa2tvEeZLMV1YECSLj5ytRlk6NypXpgn3JtW12ME=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTErYlYydTRVRnI1dEgrVldCZjhRL1FqQmh5RHZFbzYwZTY4aFBTUXBIMkFO?=
 =?utf-8?B?UCtxYkxFYVNCMjFmVVZiMHFTQ09Vb05CSkNTWUwzeE5ackJtcTc0bWt1U3BT?=
 =?utf-8?B?dmJ6UE53dzRqOVQ0eFBicVZ5Qm5aT2YvdXdSTHpISkhWRHJsUTBnaWpDNEcy?=
 =?utf-8?B?NlFwclNaeFBzNEdRZytrNFY2dEtHRzdNTzlhYVdVYnZEelpTdTJveWMvOHgw?=
 =?utf-8?B?SGlGYjdYdGdWWWlFbkY2QURyVzV2UnY4eUtyOVRzM3ZFaDZ0eU5DanBaclBj?=
 =?utf-8?B?S1l2akt2MnNQYlpjTnlGVTRSNnhTeExhdWdrQ3h2cVRmQkZsNFJET0o2UExy?=
 =?utf-8?B?NzdINW94K2EzZlJqbVdIUkU1VGd2SlIyREhReEwyUnVpUTBwSnFxQWltU2tD?=
 =?utf-8?B?SnlDVVIzUmJWZ3BDMExsTVdWTzJCN2hvTzFTcTgrZ0ZqanJ6a2dVeklVbFh0?=
 =?utf-8?B?TXd4cmpjTEEzaCtvaXpKSEdrS3Z3SHBUakhQWko4eDlTclZRcmhTKytDTzln?=
 =?utf-8?B?NXVGUGxTQVlNVTY1NG5JUThhVENaQ0JmL0Z4RE4rVnlmRTJ5cE5wTjFOS3M2?=
 =?utf-8?B?UFJrTzQvK2VkNHI2SDlQelhXYlhoRDNaODNLSEVERWNjdnUzUi8xcTJUTzJU?=
 =?utf-8?B?Q1VxMWtUeUFqaEpjem1XdEYyMkYyMkwxb2dONURmQ3Bjd0RxeGxiSHM1cnRF?=
 =?utf-8?B?TjVkYkVtY0p3SGd1MmZQUmdTUDRWemNNeWp0SU1Ia0NybW1oeTBZRk1ic3Bi?=
 =?utf-8?B?Y2MyZkRoUUFGOFJQT1JqS0tQRjdVOER6M2V6YTdycUF2V25BT3pRR1dkSUZZ?=
 =?utf-8?B?eEE1REZtaWNjMmVMRFdzUVdldHU5Y1JaUmx5cW56UCtOZlVMbGc5YmNodWdp?=
 =?utf-8?B?ZVB4RnBpQlVZR1JObU5Gb3RJWWlVeTJlVWJNMEpJV3drTEVDUi9jL1NHcFVj?=
 =?utf-8?B?ekFzWktVdjBkdVpDejFydUU3d2tSYzBUL3Y2TE9LT2JUK3NSSTAyaHBnUXk0?=
 =?utf-8?B?TVVLZ3ZwVkpDR2xaZlVOMThnQjJtei9OYjU2L0FzYm9ZWmYxRTVKdHVpRjNj?=
 =?utf-8?B?SEVRck1qRFF0ZXlnRUVEV09EblErSXNhOFRtWENNSWZjNnNmM21QVTV6eVMw?=
 =?utf-8?B?Uk1pTERTaTgrYXFtdzlLd2VJVldIUHNpVGxEdzRUS1FlTGVQQjZEUHB6OWN0?=
 =?utf-8?B?bDUwOVN5R1FHeGVVQWc2cFpLanJsQVlzQVN3ZkdrdlY3d3h3L0tnaXZJZnBQ?=
 =?utf-8?B?am1jL0hjMEVLQWVxdjR4VWlXMjBFczdVQ0Y1RXNWZkxsd2E0WUgrK0tibTNa?=
 =?utf-8?B?bmd3Q1hheWpRaTZCOEViZGsrT0Q2SHgxQ1FzWC9xL0pJblcwejNaaEdFN2g2?=
 =?utf-8?B?WFJOeDVyRldUZnZkY0VYWEJUbVdxZWJWQVRjMmF6OEVFWFF3SEFmL25yQ0tI?=
 =?utf-8?B?ckxLaEJ3L2xPYnc4allDQ2Z3b2RINUNaWDRBWk1XR1FvM2Y4aUE1VHNxUnRw?=
 =?utf-8?B?OStDMGpzTC9sd2xrWmhrNDlySk9LeUVYS3NPWHI5Nk1yVi9DK0RTT0lQcjJC?=
 =?utf-8?B?UTJqaHArbVoyYXVSVUJON2xwaHN0YWkxTTM0NithUzFWZm5PMUhVS1lUSElC?=
 =?utf-8?B?amJkakx2UTEvK29iWlFETXIzWHd1ZjlPK0hmU2thcTlQWllhMDh3SjhtOG9k?=
 =?utf-8?B?RThJYW5CK2VEbzJPbU1lZ3V0cW1WNHAvMkFqaVN2bGFNenhreFBqdUZxQ21X?=
 =?utf-8?Q?kfCyGwGwwdyP0A4qdYxld+ff6FkhDhvMR0FCnFl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0ee1fa-61b6-4b64-02ba-08dd49662f8b
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 00:02:19.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7613


On 2025/2/10 6:06, Alexander Sverdlin wrote:
> This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
> arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
> been chosen because the upstream toolchain can be utilized.
>
> Sophgo SG2000 seems to be a continuation of the Cvitek CV18xx series, same
> peripherals with an addition of ARM64 core. Therefore it would be
> beneficial not to copy-paste the peripherals' device-tree, but rather split
> the most suitable riscv DT into ARCH-specific and peripherals parts and
> just include the latter on the arm64 side.
>
> This series adds the device-tree for Milk-V Duo Module 01 EVB, which
> in turn contains Milk-V Duo Module 01 (separate .dtsi) on it, which has
> SG2000 SoC inside (separate .dtsi).
>
> This series has been tested with Sophgo-provided U-Boot binary [2]: it
> boots from SD card, pinctrl, serial, GPIO drivers are functional (same
> as for RiscV-based CV18xx SoCs).
> New reset driver is provided as an alternative to the ATF PSCI handler,
> which Sophgo only provides in binary form.

I just see Inochi posted a patchset about cv18xx reset driver [1]. FYI.

Maybe you and Inochi need to communicate with each other and synchronize 
the related work in this regard.

Link: 
https://lore.kernel.org/linux-riscv/20250209122936.2338821-1-inochiama@gmail.com/ 
[1]

>
> Partial SoC documentation is available [3].
>
> This series lacks the support of:
> - USB
> - Audio
> - Ethernet
> - WiFi
> - Bluetooth
> - eMMC
> - Video
>
> It would probably make sense that the whole series would go into SOC tree,
> even though technically nothing prevents the reboot/reset driver to come
> in PM/reset tree. If everything would come together, `reboot` command would
> work out of the box.
>
> [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
>
> Alexander Sverdlin (10):
>    arm64: Add SOPHGO SOC family Kconfig support
>    riscv: dts: sophgo: cv18xx: Split into CPU core and peripheral parts
>    arm64: dts: sophgo: Add initial SG2000 SoC device tree
>    arm64: dts: sophgo: Add Duo Module 01
>    arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
>    dt-bindings: mfd: syscon: Add Cvitek CV18xx rtcsys core and ctrl
>      compatible
>    dt-bindings: reset: sophgo: Add CV18xx reset controller
>    riscv/arm64: dts: cv18xx: Add sysctl and reset nodes
>    power: reset: cv18xx: New driver
>    arm64: defconfig: Enable rudimentary Sophgo SG2000 support
>
>   .../devicetree/bindings/mfd/syscon.yaml       |   4 +
>   .../bindings/reset/sophgo,cv1800-reset.yaml   |  38 ++
>   MAINTAINERS                                   |   1 +
>   arch/arm64/Kconfig.platforms                  |  12 +
>   arch/arm64/boot/dts/Makefile                  |   1 +
>   arch/arm64/boot/dts/sophgo/Makefile           |   2 +
>   arch/arm64/boot/dts/sophgo/sg2000.dtsi        |  79 +++++
>   .../sophgo/sg2000_milkv_duo_module_01.dtsi    |  84 +++++
>   .../sophgo/sg2000_milkv_duo_module_01_evb.dts |  30 ++
>   arch/arm64/configs/defconfig                  |   3 +
>   arch/riscv/boot/dts/sophgo/cv181x.dtsi        |   2 +-
>   arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 329 ++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 305 +---------------
>   drivers/power/reset/Kconfig                   |  12 +
>   drivers/power/reset/Makefile                  |   1 +
>   drivers/power/reset/cv18xx-reset.c            |  89 +++++
>   16 files changed, 689 insertions(+), 303 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
>   create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
>   create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
>   create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01.dtsi
>   create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dts
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
>   create mode 100644 drivers/power/reset/cv18xx-reset.c
>


Return-Path: <linux-pm+bounces-19512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97C9F78E9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3E51894321
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD7223323;
	Thu, 19 Dec 2024 09:49:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020102.outbound.protection.outlook.com [52.101.225.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00293221DBC;
	Thu, 19 Dec 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601792; cv=fail; b=AaBe+b8C895JoXryKalBRse+Z055SPF1lpSQGDD1i0VMLyB6FwD6QF3TvS1eLwOwvSSCDZy9+GP7H4pMgRFw8gFGwwXGhxtGl0os67tiIaCmaf3836zk2oL2+z93U2bVRpwo9nO4z/YJZi43VQ1fm+3ACAUYtsn8EfmA9tE5RcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601792; c=relaxed/simple;
	bh=HIzgnlJBNBz/6OejXKswZKVi39G8wZhTlwmgipxTt74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTJSEBsDS2IAc2MGOQd28o6MZCkoib388qR4wed5oG1X5FaeIsyDLwd6ilaz4RJpvA6TLzsL4YlV2CqfqUifTRNhdDQ56ZfPWSRQwakmSD8E55YsCeymdTHvZQiN0gRPcFGz6DVT2EKtihV6GRgaMz7UEDwqflMDV0lXC1ZLLGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daOQ62BtWzGCL48AyRjfjJEH3J9x9+yWpSAdymX3qOhzbCSllZc0iqQJQ9+xw/Sn+OfsEi+ZEDYihSuZL4Jalwg6N085MxM6RIRoq2bLIZUrcrTf+WO741cHFgD0uGAMwaL1voN+GWbAJ3zxjGJnB3IqC23K3qSpwF5JSOHJtZPsEd+3pr14WPMx1H3gqKncPHIF1ugXDp52UeBHnwHJgaMAWk0u5ljaINlXT1J8ryZnsmiuLpi0LfyKsvwpMOF+YN07fSyR6XqpV88ivp1v7QEl+dqUPqfclfzNQKIyuIfgy5LlPZrwj34H2X4tGQVfm9L7jZm2PpGLm1e3bXCoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/3eU/AbwhPX/80HUCWGzEyK9px/WMqCcf/UZv8Pht8=;
 b=H0Chf5EGexIoZ2r0c286a5Qg6go3cFLPFKu1gE8h9APegv2oXcZRZrXhO/w97Z43gE4qcIeIa6s2krlkS9lQFaf/yQaotWZ5fWadIPxljEeFIjC92MQIYK8vNpiJzebT8Ms6hvuprjTlojF4QTi4EoCOfKpp9RUe4cuOEsiz2ccEQit7kz5DSPq5lQ4DW4seErSj11A8vZCcmY4D3w4PsiI3FMnbnZYwBVN0ctFT690G+sKGKt//TGcsj8BmLYHc5XQNtGcFJ7oUeDHTdu3QPvkG11JkwDru2DlKTQFJYuXPCeWeGjdlmk5MXmt5dRCaQhrve5M3R2G7Gwor91Q36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN0P287MB1187.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:18d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 19 Dec
 2024 09:49:47 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:49:47 +0000
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
Subject: [PATCH v12 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Thu, 19 Dec 2024 15:19:12 +0530
Message-Id: <20241219094915.19059-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219094915.19059-1-bhavin.sharma@siliconsignals.io>
References: <20241219094915.19059-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::23) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN0P287MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f2528b-d757-41a0-9e19-08dd20127942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3NwMWFwZE1RUm1NMzVZUnByYTZBSmNJWDIvQUE5eGIvVXQrQ2pFUm9wRWdP?=
 =?utf-8?B?djdhMllLdjZDNVFpa3hsQ3ducHlCS1loUnNQcVptTVg0TVg4SWoyZVJBd0p0?=
 =?utf-8?B?a1lmZGd6VklLS2dDbXFKbnlsQ3R3VjhOUFhIQjE5V1FVSHorOEM1UzB3ZXF0?=
 =?utf-8?B?VHdkN01DR0RuNzIvQ2hlSjBvdlk3cmpzWktUQ0FiWThqWUV0TTV1ckxJSFBl?=
 =?utf-8?B?TWE2cG5JSFdhRFUyL012azJvY1MwVHFFUUE4aFd4VHQ0TU10T0hocmV1eVNk?=
 =?utf-8?B?cGJGV3Bmc1JIV2l5QWxVbnB5dnB0NnpBdUtqTzhTby9mbGhQSzdQZGlzSHNj?=
 =?utf-8?B?V2FZUUZvMGR6dHdTb29HcGcxRGxZQzVJQmZ0OG1QU1hOTjUwYllTNkk5TnNj?=
 =?utf-8?B?YXpNdW15dFRvQUdLSXNsVVM1bENSeHpBNE53anVuVitjcENHU0wydDBkbmdL?=
 =?utf-8?B?MFlKUzBJbnlKdWUwTDVJS2I5OGw0NnlvTlljbVZUSUZ1Z0ZFWjZKQXhNQTd5?=
 =?utf-8?B?VUQ2QXFtekR5dmpLMXFlaHRSK1lKZ3BTeDJ2R1dRSEtvelVScUlSczF3Z1Z0?=
 =?utf-8?B?dk1nRENsMjk5aVVSRjFHQldvNTNxUVlSWDhnMU45cFYxc3ZBRzVIcHkvWVUy?=
 =?utf-8?B?VzlxVjFsd3NHMFgwZ1d6N203N0dFeGFqZE1HcnZJaXA0UE5GbXVrVkcvVHY2?=
 =?utf-8?B?MjZYdmVHbGNNNHlSTGQ3RG9RUkdLcG0rTlJPVzduMnA1TVVwTU5xMGQ0a08z?=
 =?utf-8?B?SElrdHNOOEpIb0ZsQTk2eDk0OFI5eHRIRlYyM1pWeDhzSTJ2akd6RUdBTFU3?=
 =?utf-8?B?Tm9KdjV0dTdGa0U0Wnd1b0d0L1E3Z2xXdHZNQ1RKZTJUeVJlYm1qNkd2dEJN?=
 =?utf-8?B?OTRsMVQydlZOVEt4Ukp0RlZOYUFFREdoN2hhZ3NrdEIrTkpSdDcveEZQb0gx?=
 =?utf-8?B?Y0lSRHR0cWFoN05uMlFRdis5YThXWVNnOWpDcm42bnlWOWswaEJVb1NPZW5K?=
 =?utf-8?B?N3ZUVG9tU05GV0xaaEd2NC9VRnlKU0crZUxWckRuUXNsTk1nc1JST0JMWUZy?=
 =?utf-8?B?YnNWbkRPSTRVZ3VmQXVyK3FjVUFTY1ZVYzVZSXB5b01ZZVdaMCtMV3NraERF?=
 =?utf-8?B?RjlMSnZjZU5HbTJPUk9lQ0VTSmNYa3JCeVN2OGROQTFKV3FFVThLd240bERr?=
 =?utf-8?B?SCtNd3BKOUZEV2d2RVlRWFEwQ1dhT1VTVnlCQU5qc1IxczY2cjJrWldNTUdk?=
 =?utf-8?B?NlYxTUlnWmlSYVZwVXc0NWVKOXhZNEdyeVVaUlVaS0dLTWtrNEVPTk91ckM0?=
 =?utf-8?B?R3RaU0NBdGR1RHdFbG1Jb1ZnQkFyTmFBczh2RXVCUVVKL1JrUThZK2tCbGNJ?=
 =?utf-8?B?Z0h1ZVFVS0wvb2wxV0VUQXpNUWthcEIwcWVXbGpmSXNEY1c4dUIvNWgyWHRM?=
 =?utf-8?B?KzU5eWFSekQyd3gzazlVVmlaWmhxYlUyRDNtS01NN3JZdEErc0l2K0lVbnV6?=
 =?utf-8?B?OG0wWUpNQW5UMFFwVWZSNnZwU1lBeWNTc241bThCamJ0eFlOZk9Td29TaTJ2?=
 =?utf-8?B?VXhhbyt6WHFPSmZkTnl1ME5yQ0w2N1l6cDlRNU9Vem9hbVMwa1lJSjl4NU9o?=
 =?utf-8?B?RkxkbkpyUkxLSWEwMm9RWnl5dzN2TjJQVzUvUTN3Nzl6dG1Ec2lIc1ZVMnor?=
 =?utf-8?B?MGtMa1dPOGZMY0dwYXF0dnhkeEVwU2tZcjZjWUc5TjVCYkFRNStaYS9LYVV0?=
 =?utf-8?B?d3l2SXNaUUpCSTJESzZNeDljWWVJZVNYeERWeUNFZjNqS3FCbTdtc1dJVmpV?=
 =?utf-8?B?cVlLQkJPU0trTnlKdDhseWhnRDNDajhqQnJxS3hMN0prUHc2a09rSGN1RVJJ?=
 =?utf-8?B?cEJiZVZUaStyaVQzRHJtMmQ1NUh2M1Q1TEprSm5QN096NTV6dzZRZnBRU3VB?=
 =?utf-8?Q?Oe1ux95UoRtd9eqsEkQijJ/tzUebyUAM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjJYZGtWVnlBWnVGYnFQaWNFZ3lZYWI3T2d4ZTBuUG5ZR2ltdzJVS3lhbjhi?=
 =?utf-8?B?R2VsazlUUVAyVFdzK0JocGJ2ZVJoQ3h0T1hGTTdUNUZhZG9QYVFOeVJkWkpD?=
 =?utf-8?B?MDdSdkJQcmI4Z2N4RUlnaDAzNFEvQnY5TGlNYys1V2NVUFV2V0luTnFzaGVH?=
 =?utf-8?B?SmZ1eGJ4OVZFckwrbE00b2tjVkxPUCs3bk9EQmlrOEVmMm9uWDJxV3ByQS94?=
 =?utf-8?B?ZGg2bGhXbTJ3MENZa0d3MHd1aHVMY2p2b2pxWFl4bFVqOGhaeU9aWFU0ODU3?=
 =?utf-8?B?T1A4TEIydTZCOWNhUHVSM2pXYXhQaXVsK05yWitjZTdPQW4xZGZ6OGliVkw0?=
 =?utf-8?B?UTZxMkRqYmNLRS9WM0toUE9YNnFNdTRaalBXUzJQdUxGK0lMMGcrUmJSOFRQ?=
 =?utf-8?B?N1pOSEZGdlE0Z3UvdjBRdGo4R2hlaStnV25PeGRtaU9UWnk2Z1lzRHJQZ0hi?=
 =?utf-8?B?dG5uVTRGT3B3NitGYUVka3RxbTVrVmg4RHQwa0t0N3dPNGdlVjBhKzNpMThR?=
 =?utf-8?B?Uk9Vb3lpSFluQWxzTnFrQisva2E0bFNqZVRKVGJlb3VYN0xBR1M2RlMvbnVr?=
 =?utf-8?B?ZVpKR0ZRSW9jTVVUNzhiVUF0VXlScHJ5RWVtNUNUcldJU25DcVgwM2tpUEdS?=
 =?utf-8?B?b3VERi93eUNubVo4ZW81RllLTXlCV0tIYUIzRDJMNU9qSWs2ZHErSG5YaGtS?=
 =?utf-8?B?T3FmeGswdWpKZzM5Umg2UFBnNFBTQjdlYnpMTWdDQVhlRHh2dERsWHM1NTcw?=
 =?utf-8?B?d3pVWk5NN1NyUk14d2toTzgxd3AwbXBHZGVaMFpvQ2xCYjhEcjhJQXZxTTVC?=
 =?utf-8?B?SDdwQ0xLcTZGWXZzU0l5WHJDVVV5eGxKWnZSZUhYcFd4NnFTaE9iYXFLZlEw?=
 =?utf-8?B?K1RXNUJGT0F0b2hCdWhsSjNjYVJCWjArOG1FQ3hrc29aQ1dPWDZnNzRvRm1v?=
 =?utf-8?B?UzZVcFIrNDlzc0M4RGtoLzcvc0JPcVpNSWhiZVZiNHFVQU5seTIrRDNWWmdP?=
 =?utf-8?B?a0tvbThmYllobzQ3MHRPeDBDMCtRemJSNC9JcmNTd203RENrRkZyK0g1SlNQ?=
 =?utf-8?B?MTRIUERpK2U5OS9ZM24xTTlySXhFRzB0UC9kc2toS1hpaDVCNFpWc0cxckNr?=
 =?utf-8?B?ODFkamgyRVZTaXdnQmY5ZCtZT2l3QXRXSm1hdzVPc01qV0NXUG5PVnlZYXJR?=
 =?utf-8?B?c29qUWMrZE82UEMvU2JRdjVSN0gwSFMrTXdkMFN2MGoyNTVlTTJjZkFnM0s5?=
 =?utf-8?B?eDk3VzhWc2QwemZNK0l6QTF5K2N3R3gxSklJZzNkL3c4SUVXQk9UMGlEVFBW?=
 =?utf-8?B?cytRNDlYN1NzaFRRR2pwd3p0L2VzR3kxdllYK2F1OFVTenNqVDlzb0NLMmFr?=
 =?utf-8?B?dmg0ckh4eTdLazRXQzNkQ25RUituaVZ6ZHQwaFQxLzVKOG9LZzNya05lN2l2?=
 =?utf-8?B?NExTT1AvejRKcHVHM2hKRGk5VE9yZi9XQXVoSTJmK0d0L2dLWVkzNFpXZGNo?=
 =?utf-8?B?MmFZSHYrdDgvSnEvb2FSOE5VTkN1L2dLRDNUaGpiOHllVUJSKzl6dGpOQStj?=
 =?utf-8?B?VlF6enpydHFjcUlaQVJDNEY0Smhqc0NSeTl6UGZ1L0Y2SjBRckp0ZjRXa0p1?=
 =?utf-8?B?SEZuZ2JiNmtIYUorQzJ2Q3VqSGtnRWI2SmgyRnVWVEM0V1VBN3BvOE52NUhX?=
 =?utf-8?B?MlFDLzE3R05kQTMrMGo5YkE0NWZIR05wMVZNVzlCSTd1S24vZXdFa2sySVFS?=
 =?utf-8?B?Z2pUSFVzNE9tQVlkczdzcUMrSkI2YmNyVXdhaUV2MG10bXBwR1EvNW56bk1i?=
 =?utf-8?B?K01sdkY1aTl0TENHUzZJS0dDZXRDbDdtb2JzN25kT2ErZG5aL1UyQjI4dlpL?=
 =?utf-8?B?NWl2WTNDMERNekU1MlpMMlgrYWpnQmRiUG1TaDhGL1ZDVVhrZHJqNjhDSzJT?=
 =?utf-8?B?RXBNY3VhdUl2SUVoMm9peVJRZTRKOXVmODJ2dlJ1VWQ0Yzk1c04vZzJmNEFQ?=
 =?utf-8?B?Q1J6aUFjRnhXYlQvODYvOThxd0RtenEvejFsYlFCR2ZwTnAwMzl6R2RyZVVz?=
 =?utf-8?B?aTBmL0xVUWZnaWI5dTZIeElFRG05WS9kMTRpWXRPYTBQamd4S2FTM2YvWmhT?=
 =?utf-8?B?SVdHSjk2TGZmaFRnSWJqWWtoeHNNY1Znd0dwS1paZ2hDTVhPS29YZnozODA1?=
 =?utf-8?Q?9g1xCqO2HAjy9CJhy5SHgOY=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f2528b-d757-41a0-9e19-08dd20127942
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:49:47.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hURY6XI6f/uL2VLsolvsetDskhToN+XWv7FAH2rvfYXMH4cr0IT8uvrwmDzQ6IPYCd2J1bHtnhNE6ggMmUzAi1sJSwWbV6RCBYX30Ulgq4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1187

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 607 ++++++++++++++++++++++
 4 files changed, 623 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e29c4e86db1..847690a8d9a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22170,6 +22170,14 @@ T:	git git://linuxtv.org/media.git
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
index 000000000000..203996ebd215
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,607 @@
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
+#define STC3117_ADDR_MODE                      0x00
+#define STC3117_ADDR_CTRL                      0x01
+#define STC3117_ADDR_SOC_L                     0x02
+#define STC3117_ADDR_SOC_H                     0x03
+#define STC3117_ADDR_COUNTER_L                 0x04
+#define STC3117_ADDR_COUNTER_H                 0x05
+#define STC3117_ADDR_CURRENT_L                 0x06
+#define STC3117_ADDR_CURRENT_H                 0x07
+#define STC3117_ADDR_VOLTAGE_L                 0x08
+#define STC3117_ADDR_VOLTAGE_H                 0x09
+#define STC3117_ADDR_TEMPERATURE               0x0A
+#define STC3117_ADDR_AVG_CURRENT_L             0x0B
+#define STC3117_ADDR_AVG_CURRENT_H             0x0C
+#define STC3117_ADDR_OCV_L                     0x0D
+#define STC3117_ADDR_OCV_H                     0x0E
+#define STC3117_ADDR_CC_CNF_L                  0x0F
+#define STC3117_ADDR_CC_CNF_H                  0x10
+#define STC3117_ADDR_VM_CNF_L                  0x11
+#define STC3117_ADDR_VM_CNF_H                  0x12
+#define STC3117_ADDR_ALARM_soc                 0x13
+#define STC3117_ADDR_ALARM_VOLTAGE             0x14
+#define STC3117_ADDR_ID                        0x18
+#define STC3117_ADDR_CC_ADJ_L			0x1B
+#define STC3117_ADDR_CC_ADJ_H			0x1C
+#define STC3117_ADDR_VM_ADJ_L			0x1D
+#define STC3117_ADDR_VM_ADJ_H			0x1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/* Bit mask definition */
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE			BIT(5)
+#define STC3117_BATFAIL			BIT(3)
+#define STC3117_PORDET				BIT(4)
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                     0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define APP_CUTOFF_VOLTAGE			2500
+#define MAX_HRSOC				51200
+#define MAX_SOC				1000
+#define CHG_MIN_CURRENT			200
+#define CHG_END_CURRENT			20
+#define APP_MIN_CURRENT			(-5)
+#define BATTERY_FULL				95
+#define CRC8_POLYNOMIAL			0x07
+#define CRC8_INIT				0x00
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
+	return value * 1000;
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
+	/* current in uA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in uV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp in 1/10 of °C */
+	data->temp = reg_list[10] * 10;
+
+	/* Avg current in uA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv in uV */
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
+						STC3117_ADDR_OCV_H, &ocv_m);
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
+		data->batt_current = -ENODATA;
+		data->temp = -ENODATA;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = -ENODATA;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = -ENODATA;
+			data->batt_current = -ENODATA;
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
+	enum power_supply_property psp, union power_supply_propval *val)
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
+		val->intval = data->voltage;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = data->ocv;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = data->avg_current;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp;
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
+					&stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+					&battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to get shunt-resistor-micro-ohms\n");
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
+				"failed to initialize of stc3117\n");
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
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.34.1



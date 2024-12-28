Return-Path: <linux-pm+bounces-19792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EB9FD89D
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A95160D87
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160581727;
	Sat, 28 Dec 2024 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fEXGWJJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338578F54;
	Sat, 28 Dec 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348553; cv=fail; b=TbH/d4phBFSxQaGbJVWavxoeKRzlLaaDc1rSdVvT8aGK6v9C8wbP+o7lmwCFz4riLEO+nMR33RL40DRTJ+Kk9MxKF0GytWr2s3L70lU5mXse4TL1akH1KkrZ0qQhcRbPUgXVRRg47qWcn+2ctuXiVU4Ad7dVLIBQXmOzz7tIhx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348553; c=relaxed/simple;
	bh=JiSAV7Q4NNZurUbBcswCV+h/Lz5/1lhowxKOZ/KNAmw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FnHOMEVD4smTTu2Ol8haIvw1TLKOreGa2WQ2XHND3UeXizrKvkqQDZOSNqSjBYndGKGkjQIqlUbEkKQbkGtYSakQmYc+Ii2n+iCgrbRZRiA0iXkOea5ThgiwE+VNaA+oPHdPjXfhBnuZiup4mS4MpjfnstcrGRYrJNqCKeQqyCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fEXGWJJn; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olPMx0tE6Ed7jYvTX0V9egv8YIGEugwqDV0iITMiFZezT1oYT7/8Zz9jvFnsKfpsIRpZkyuO5miIklunKno1OLDxzzjzZOh4izeWWdt+VX3j2+MVWjjoGjAoKoHMmatYQKZ2R9ZldqBUEUHpm4Dd//NfqPzxEDcGscrocV12fQ6xNrLUETFM+NorUMIDPRNFPuTSempe/5O83GLSZVr29MZchLGstIjW2TzW4eFF6LrRdrnbZzQw+3lsI5gvS4+NYOfd2Wbqp9mXjV/gvNS9dUX1NyfEThs0BHhTIskq2O4v04Q4HlihmMBSqRng5ERqIKX9vVz8lcRq7Hfoo0sciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvRxcJQkTcUxL+UY0CT1LkbMh/5QCJDI8WvxLfFze6k=;
 b=NdZO4KK6Cnnw4xzoOm5Q6YfK8kZvbawsHzox7CCkum8NdHeT5jCpWpl/7NKdb+jsIivo9XdnDfeUaPW17O4TvNzHkUzVBVGkyKwpr64uMtTlQtmioB14+oS+3TuboxVhzDAAu1kiL/b5z1Xhj0+MnTvQPQjRJ3EUKgTxDfrdYnR8TMl6X6s1CEsMVmGvM2WLX8uq3Gl1W+pGG7bH7FC0Gm0byZhkhLa/NbP8itsVQCuMWsls5vvVdN1nURqvdUpbhCtE8XY6iB9/XHn/MzrDW1yTSrgycb8MkblB7tz6CJ6GsjqI6jjh6XNvYTG/d8mfN4MaR15W2ZUJxYM3qPoZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvRxcJQkTcUxL+UY0CT1LkbMh/5QCJDI8WvxLfFze6k=;
 b=fEXGWJJn5P4XNa0sBDtpmP4Mai2h0uOC9b66ZC+Q1ZeRfeaoDlkDtiSVfIVM8mypCgYZxFYnjrDE3JHAfzevvUtMwxGWia5baxtDcRiQJBGPv1YEb2FQaBDEFrY3uoolISyGPba2FYhDFwGmYRyDq/IsnOptfN/MSsC0hD3MKteJm7whbZJwpWo/1SC2lduAFN6Nzwn0kIdZkqXU9KYRmLpCVnNlfoneMIcwST8iRRcb3jNfNZBaDrgCC1gNikHMcmGPqGUKN+NkArdXPK2UT8rGBZIPPlponZXr7V0Qz8OKvQxvGlh9NuqhylK7Tgvn11bpbcWnIWUp68rd5BK1Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:42 +0800
Subject: [PATCH 06/12] rtc: stm32: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-6-09cfca77cd47@nxp.com>
References: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
In-Reply-To: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1529;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3L5kSry1bFWI+vzXqFXX2mukiWSnq2LH9PLt8NvYjoY=;
 b=B3T68jTJq1CEoyhrigYxE+0meJO14wNaqx5QKL+LOdMajmlDmTiJD1lez46bwXprMXVKEvpGi
 mJWb21WGEHODrDQuLK0flOSEZPL8Qlp3R2EjTV1CpPGtdR9Qqxe+1vD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ef80ce-50f7-4fb6-f7e3-08dd26dd271a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlYWHlRbjA4cDVhbkpBUk5DQkdJVlJJMm9JV0xqNWNxYkorc3R6MUJ2akYw?=
 =?utf-8?B?ZmJ4NlRJUjBrL2dCUTBWRzFXL3l2UXp3dDJPMk92VDBTcXB3eFFpaE1nK1Uy?=
 =?utf-8?B?a1hNL01SdkdtUjZGRkNnNGRDQnVVazUrL2E5UGs2dHhUYjdRVUhPbkkvck9R?=
 =?utf-8?B?ajNPdHJsVENuUWtwSWtrTkcvaTF4L2kyL1VrcWhYVnpYZzJwQW9VdVBYOHZ3?=
 =?utf-8?B?ZjgwM1dDbEV1RTdOSGlvVEtwVFV4d2pGcVIwQmJGeGRNcW0wTTVONlU0M2hF?=
 =?utf-8?B?djR6YTBxQjRRMEwwSXNkdjNORXdLaEVVazBFbkFrb1ExczlFQkxjSkcySXRP?=
 =?utf-8?B?OEZjYVhqL0xUZlpUVHFneGwxVWxLMVUzNDZjWm9LZE1rQnJFalNSUjRDWnVu?=
 =?utf-8?B?ZE1jT1hSeWM4c0tuM1VPN0luNFFqYTJ6UTdwZ3hibGZjWTFSY1BvbEljZFJ3?=
 =?utf-8?B?V3MvMVpGRklsYkFxUmJEdzJzRXNaSk1rMlpZSDNPbFFsVTZNSThDeE5NcnVY?=
 =?utf-8?B?TnZueFoyQlo2L1loU3Vzall0Z0VqVVBBQkFhMHYvVlpmMXlHVXdnTVBMbDly?=
 =?utf-8?B?OFRkd1l6YkZKRTlxL2U5OWdsaFpGMS9BVnlYblpOOTJKc3lhZDFZWG5RLzgz?=
 =?utf-8?B?NDFIaHJGdXEvL2t0RktDbWFaMVM2QURNVWpnK1JQRUQyZk1hNmIxNGxBakd0?=
 =?utf-8?B?N3Jwdjd4Y1FNTzIvTTduQmhFYThjS0w0djBEUGdmTDNhUFg0cDRudmJFTHZ4?=
 =?utf-8?B?eXpqQ05LcktaTkVUS3I5b2lLSldtZXRGNVVqWndzTy9aOXFpU1NMeVdhbWRh?=
 =?utf-8?B?K3RRNGduZDA3UFk1Zy9nQUdLa1BWdy9QRERGMXFpTzQ1MWFUTlZXOUs1azh0?=
 =?utf-8?B?TW5YaGRRL3Q1UVQzNGgrMVI5emptbW9vR0YyMmYrdkJNWGcvcHVqWEloMjVp?=
 =?utf-8?B?RklaRHNGSTRTeFcvMUhHVlh5YkJzaG9OaDZvZU05b3lNOUUyR1ViYmw5WEsv?=
 =?utf-8?B?Q1I0OUEyMk9LZU9VOXV2eFJWWFJOalExdG1RMGxjeVczOGVRQk5aOGYzbVcr?=
 =?utf-8?B?dnY3cS84aHZ6WHZrd3FMZnBYajREenhZSjh4ZWx4Y3l5a2ZNQ1ZmeEsxKzVL?=
 =?utf-8?B?VjlzQ25iRzNmVDBXcW1QWDZISkgvSFRBVEdwcXd3bFdpcWFvNXBqU2NYRmpY?=
 =?utf-8?B?ZjJIeWhBMDhUdDFoTWl4Uk9LM1AxRitBTzh0WTdPNFNqelRyL05JeGdYbE1h?=
 =?utf-8?B?amh0bXJxYVFJZ1VBUkROSVY3UVhacWNIcUdxT3pIY1ZsODR6RWdaWVdKb0hX?=
 =?utf-8?B?b3gzTVZxU1VzQVpUQmc4YWp2RTAwYVJFcjdQRG1Qd3NWUzh0OGFqMnphL2lJ?=
 =?utf-8?B?VDhiRmUwdkJCNC8zZHFkOEJuVXpwTjdldjdFY3NMbnFENVk3MjdmT2FHZ0NG?=
 =?utf-8?B?dEFQblRPcWJ0T203MmF3Z2FhK01hQURMbWlFYXFES0g5L3NVZVB4ZHlZajd6?=
 =?utf-8?B?NW1NeDhkLzI5dlY0MjVYamZzYlMxMWNRQjdSTUpRMTFEbVBhaWRsZmlmWWxG?=
 =?utf-8?B?eWlpQjZrNDNQbmVsMlRzbXNEK29LczZ1Q25NT3Rpb3huNGZGdjB0T09rQTlz?=
 =?utf-8?B?bEd5VkNZaC9yMkFJeDE1YUZ0MURQanhQeEpiUnpFUW5qRUM2NzM3cVBtM2or?=
 =?utf-8?B?OCsxUGUrN2paeUgvaW8xRlBMeG5IRkJVVWhobVN1Vi9HVEY2bTBnL2NkMzhV?=
 =?utf-8?B?WlhyRVExS0p4WmVhR041ekxZWUd4anQ0RE1UakczZERtcVZJZGxpY1RvZkY5?=
 =?utf-8?B?dXJ4MkV6ZUk1bVVmWG1CRlZJL0tUYkFpV3B0amNUV3lTRDhEdW9GQXRVdHlL?=
 =?utf-8?B?TnhxM0NQZzJYL0hTelI3NlptMWJ2TFBpYkZ0RDduVkRldGtDL0lIY09OTDRk?=
 =?utf-8?B?Vmt5QS91dFZZdU1uK2FidUt2VW5aU3NCZUNFc1NyZGwxK29PZnFTRVJlVDJ0?=
 =?utf-8?B?KzNRSXpEeThRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXo1QzJDcEhoMm1ZdjRvalcrd3plT1grbXZDODdVbklBdTFhc0dCNTllWFpq?=
 =?utf-8?B?aEdCcHpLcHBkMEoycXZTMzhhbjB6dHhoM2VKUXdpdE0yeTdoeDZnc0g5VTZh?=
 =?utf-8?B?elJyYmxWZk5qYU12SVpwWllOeE1lcGhxKzMvZUhJMWUzTjRYTG94QWtURUt4?=
 =?utf-8?B?SUJuTUhBc2hQWUZ2SWxQT1RCS1RyeGV0ODh2K0tJOUZhYkw2YWZoQ1ZTWm83?=
 =?utf-8?B?ZFZieXVEUkgzRk9kVWYwMHVDRDBEK25aK0VoNE93c0w2d1dlaVVnSUU1aENi?=
 =?utf-8?B?dUE3RmFJTGVlY1FQalZiUllWd3gvK1ZOT3lpMVVhMzJjbGxaa0hwMWczTFdv?=
 =?utf-8?B?eklmb1BaNkVEQUtzM2V0TmwvWnE5TjZ1cklPRXptL3JYWUtmOXRSV00wZ2tM?=
 =?utf-8?B?Zi9odllNY3pXRUhBNVBHNDhBc013N0NKZzJiR1cxVld0bjdsd2xPandheU9G?=
 =?utf-8?B?T1h2bHY4YzBnS0FZQmdzSkZoMEVkQ3VOTU1tazlxTFJLVTFsaS96V0FBT21R?=
 =?utf-8?B?WUYwRHg2UTlJeWNVK0I3SGpiTUhWRWYrT3huaHJNTnUxeVNVdUwxc0tGNWt2?=
 =?utf-8?B?UDZybWhXTjBDZjlkSzFRYVNmdk5QZkwzT3pRc2tmVzU0TGlUSTFGYTdFbzB1?=
 =?utf-8?B?NDNWMTJXMXpTVzFlQ0J5VlJ3UEVGbEJiY1IzNXBpYkNHa3UwOTdWZG11VUla?=
 =?utf-8?B?Y21tamVrRVdSdU9tNjQ5d2F4ODU1UzBpdGpDWFMvREpSRWJwQTNxWG1iWjdo?=
 =?utf-8?B?YUJxTFJmeDltL3RxN21KeG5zUWNMRWNTb3hVUFl6bUJWL085YVZieVJacGpq?=
 =?utf-8?B?NHJEWENoT3d3ZlZxVGo2M0Z6dnNLK1lYZ2wvOFlaMW5JN0Ird3d0dTVxWVNG?=
 =?utf-8?B?dGJvZ3d0dDREN3MxTWVrNDN0SXNzdUI5NzM4VnYwR0ZIWVRYY3pXbUxjc2tv?=
 =?utf-8?B?WkRoSmNvU2I4WlU5TEo3bVcvSXhSY1V5T21tK0Znck1nVWg4dDgxTFEveVdn?=
 =?utf-8?B?Q3MxeFQwd2RVZmI3QVg0c1hjekxwQ2NneU50cm8zV3RxSldjM1h2alo1KzUz?=
 =?utf-8?B?cXEwTXVORjFwT09XNUtjR3l2aDFwSnNyWkVJQzQrbHNlOXZvNjJmYWN2T2JL?=
 =?utf-8?B?b0xLSGZoK2hSQUlrRURONWNxZWtxOFdINHpwc284QitscjVrWDE5YlkvZlNC?=
 =?utf-8?B?OHplYytSNkZ3ek5DSGxybEprV2hiVkZaM1crOTdDU3BqajlRcWFiOUNrUk5Y?=
 =?utf-8?B?V3Z6V1JNWnZidHdvWmlwSmZJYjFETkZ4VTFZbmpqTGV6Z2M1T0lBTlZCUEpG?=
 =?utf-8?B?Y0dCQTlsUzZ1U3FweTIxeXNrVys5NkJmaXJuMXkrTTBoR2tUSjFlcEtISHJs?=
 =?utf-8?B?YVVPRlVxOGRJWEtIUlYwMHZYS0I5THBCNTgybkhDOXZTU3hRQlNhMlk2a3o0?=
 =?utf-8?B?SjJYcmZQU2FnSGREVkpweks5M2hSNm13S0VQdVMrejZrYm12TjZycFJXdFdw?=
 =?utf-8?B?RHpnSDM5TStGOGZhV21ZTlJWSlNJYlJ6Uzdob2NUUXJ3L2ZOSjJ3N2FxenRs?=
 =?utf-8?B?L0ZpT2ZXV2NLdVdnbEpENWIvV3g2NnRReHJrcFFqSDZkZU5WYjIwM2xzMUho?=
 =?utf-8?B?bnJlN1RmT003eXladjVKR0pxTHRSTlVLeWt0WlJyZzJOR2M2anRUdjhkcU13?=
 =?utf-8?B?RFcvS3djTXR5TXJQK3I1KzJsNXk4QkZSc1FlK0dpY0MrWTJPY3lvU3V3VUwx?=
 =?utf-8?B?T1NVUCtzV0FzTnZMaG1TcTVwbXRhUkFQeUtUdkg1VHI0S0RQVnFwc1QyV21o?=
 =?utf-8?B?RFl2L1JjejNReGVhY25HcmJjb011b2t0c3BVWTV2VWZUdVluWVdRL3RFV3NG?=
 =?utf-8?B?M0w0d2VlRkgrYVJhZkRoYmYwZ3d3S04yT2s2MVp5N0JrdEtPL0JMNy84cmlt?=
 =?utf-8?B?ZnRFck00T3dDUGdITnppSnovVm1GaGlNV2NsZ0dNeGwvR20zbTZUT2hCOGdi?=
 =?utf-8?B?T2JhZmNCM2F5eFFQZGRKQ1BHOGNwYU52Rzk1NUZValFGcXA3N1JYbmVuL1Bo?=
 =?utf-8?B?UVlUVjViLzBVUnA3eUtqTGRRKyszcUtnNG1BUG1BaEVoaU44RGk0TzZ5RWlm?=
 =?utf-8?Q?LJVbdDObGHOnt0pqQzRAsfaXz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ef80ce-50f7-4fb6-f7e3-08dd26dd271a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:44.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EASzHYX0Y9Nate1j5d6Lk4cnEVHCD/u8gP/xBHIzZk1pkFSOr8l8qigS2Jf+nvLIykTkPagclVuGWw56ni4Vcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-stm32.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 9f1a019ec8afa57245c6d40d378ec50fdcd64deb..183017b0d33d10481f94891de24cf2eee95893f5 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1151,11 +1151,11 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = device_init_wakeup(&pdev->dev, true);
+	ret = devm_device_init_wakeup(&pdev->dev);
 	if (ret)
 		goto err;
 
-	ret = dev_pm_set_wake_irq(&pdev->dev, rtc->irq_alarm);
+	ret = devm_pm_set_wake_irq(&pdev->dev, rtc->irq_alarm);
 	if (ret)
 		goto err;
 
@@ -1216,9 +1216,6 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (rtc->data->need_dbp)
 		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
 
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-
 	return ret;
 }
 
@@ -1245,9 +1242,6 @@ static void stm32_rtc_remove(struct platform_device *pdev)
 	/* Enable backup domain write protection if needed */
 	if (rtc->data->need_dbp)
 		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
-
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
 }
 
 static int stm32_rtc_suspend(struct device *dev)

-- 
2.37.1



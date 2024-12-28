Return-Path: <linux-pm+bounces-19789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09E9FD88F
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2497E3A1BEA
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3A67A0D;
	Sat, 28 Dec 2024 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XBLE3//a"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104550285;
	Sat, 28 Dec 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348537; cv=fail; b=sUUurJ+OKJZx6girds2Y7jRSwXqIft+Pzxt61IHEbbvZBjWuy7F7vZ2L/s99Dmlb7Hq3O+znLaDElcbsQD8nEATmjoTVMThOR4cFgYfk7c99lbUNnNC0a3yvpqpJX2HbVn/fsNWuPCKGv3B9Q5bs9TI0nGTvnFcp6bOQAD6x7uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348537; c=relaxed/simple;
	bh=DNmSM/zlaiHe7y+SpoUtP9k7yyKM9LouOCBuhZSkcWM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k8hepYkFhRBYKOdNsdMnel3+Mv5aPedhITq0FW3X+4aM/GpMBjHKYJ525S/EBDtMP9Gf5IltTTlvxRcF8o4XzY3id9RPiw+qYcNDNOTXYeIZjXLqhKrgroqyaKkqyO3gLE9eepfH3OTequEh/07woI0rSWU8ZSRSSxQ4xqvu1us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XBLE3//a; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWEDXFj1zRBZbCj4jTywAYgUog+kXOLJm/GyPFk4BSTFhuJ6sPkUZCGU3ydCnqnB6iTW7n1Z4/9NXpZfwQ3tHnVoaFj4aFhUkRmzyuOySq2eJV9vZCKrxTL36b8qJamFachTUDVUMhD4oNCGnYbpN5WRLwXNH+fTM+JZdpxP9IMpb7IhvS+W2GTn9fOEKZFAvB8GUZ1Y327P7wmHIzviAiQPir2qUPwokDZm40TRvp1Cbi5L1rqjUXJwOfEIeG+/kLKkeMl3laLpRPPxtVQRuZhE3SIVJuDWOsN62KJKHB2K4R/7QyczSoUXVl/UMkLVsUksW2tQP9nF6zvRO/TqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS+DM8g/1DZ++lGRTiLrP/ykpiHku6xeI0up7+EwB9k=;
 b=nMK61q1f3iv8IS8mVpJPXCLtlAMGuij5lngqJRXQktiudXn2LWPhNY6LhhpAfKb9LQmeo5gFoglFha9iQm9p8VnQ8t71mbHsNsh2EjLcQleHnAO2JIjR84eFB4rF6ei04jAHb57tPbjZHciTrBxetf5ioLSfC26O+d6cFt0qiiMuJVYi1HeCLjvtMjwiirnzrzbwXjV5eL0H/sp3N6nlGy/K1vlYuXdF4GgfBiqbaiWUSegs7MysJa1EuErwTMer3dJk24sVOC6TeYWactjcKZLhGpuo2P9CgIEkGhg5dzhD942c9u9rXAnD86EsVuldNQQ/WmvLGgx8WJqI9QJc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS+DM8g/1DZ++lGRTiLrP/ykpiHku6xeI0up7+EwB9k=;
 b=XBLE3//aEAKVbhEC+/BM1AxatOEnWwzsJqOyaIsZkYVospAzKoJsgqlZLWgRXL7KUD5PK/hIpFEOS6PEpveF2Rnyp2ax7gLzjHRNSIxSbY6LPsSJr8Ptm/uSSoIW+PQJ8rrcL2vp9CFLrt9yx0Sq6x+Q0vm/632nvRTeOwpWQOWGts6HjqExsCX7M/DbaCktVYgX+A03ied7ASJlyXGZvAHT3JmeqpT+c4A1mEoUEXmQUEAkDttlKj0VFXmTrlzy80R11Lf66lb44eMhz+QIm9hB3DUket3x0SUxHle97tYthqdDToK+kHU51yWEOkbdshFZ4wMOYmD6cXEXq7IIQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:39 +0800
Subject: [PATCH 03/12] input: keyboard: omap4_keypad: Use
 devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-3-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1365;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IYFb5BcVnaCb3uUN830r92UAprUHpPfeHJSpQKDJq+A=;
 b=ITPynXFen6NGI8Tv+l+31DPkuKOjZW+qKhVpYyrqEi1xXbuJiSLrF2YI2N0Bz1lh8BwJ5w4al
 wmUn6KOWVzGAMLjoeV1RPp2jYZsny3AhGb+XF2EJuPOEk3vDtyGfzq9
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
X-MS-Office365-Filtering-Correlation-Id: 9a463dc9-5b0f-4a17-510f-08dd26dd1dcd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXgxL2l5aWY5OVlxeVVDM2pOemNRcXZzczNQdmlqYmtkZktvbGY4dk1BWUV2?=
 =?utf-8?B?U0hqWkVWT244Mko0Z3MyOTc4elVpa0kvMmdvQVY3Y04ydGdwZHRVWjRFaWhj?=
 =?utf-8?B?eDRiY2VRc3RROGlJVzlXZHd6QU5qcVduaVRHdHlnUG8xcXkxd1BucTlYeHFp?=
 =?utf-8?B?Yk9oaDJwb0hQS0plcGFPbWIyQlduamUyVlpJakk3TG5UeUtlYWlWR1pCRFNw?=
 =?utf-8?B?VTZzNUN3UUdyY2gxVkk2aVo2VmE1RjRNT2phVkMxNDdKZXlLczZCY0NKMGlE?=
 =?utf-8?B?aWE4Uk9zZGRaaFdJRzVWa3BscTFzVzVmOXZjdmJrZFRLQjMvMWx1Q09qa3Ru?=
 =?utf-8?B?aXRyUWV5WkFkaWdOSGpTbmxobUw5MW9aNk1pckprQVpvQmdWSklOV2ZuV2N3?=
 =?utf-8?B?dXRHQXluQml0dnQ1Z25XRWc2VFErcXEzVllHYnYvM2YrUHU0ZVo3c1JuWGhY?=
 =?utf-8?B?eWY1MFBjMFNsOWFHUHk4Q3VUSWdPSEhYdHdCVW1HRWJOWDZjY2xueWw0Y0hO?=
 =?utf-8?B?WmVHaS83MmVnZ0tPWE1VSWJ6NWZSVzl6OENQVzg2d05ub1dCZWUrUmRRYVNR?=
 =?utf-8?B?NHFaRUR6eHFQQ1lwRlZCQWVzN0c0ZUU2SWJ0VDZiT0pEVWg1cXNZTEV0RVZU?=
 =?utf-8?B?aEZhRE95SVIzeUVyaCtyeVh2K20rcSs5OW5rcFZrbHNMUlNtdWUxNCtJZUZu?=
 =?utf-8?B?YmtKeFhLK0NSUWN2aC9Kb1hGMDZPUm5jL1dyMHk0QnZuTE1YeFlFWFM1THRu?=
 =?utf-8?B?Zjd1cEEzSVVPYyt2Y0gwT3FZS0lhb3E1RmMrWjgrUU5kbE1KZzJ3eDE1N0FC?=
 =?utf-8?B?aGpKb004amszOEZoZXdYWU9jRFAzK3JhUkd1allVWi9kcExuV0ZiSmRmcytZ?=
 =?utf-8?B?c2FHRkkwMklBcFlDYXloRnVUOWhOYUloRHlWQ3Nna2hLc2IycjJOYzU0dTla?=
 =?utf-8?B?WTM4TEY5Wi9SOFBHZUQvZXVHSU80RmdoNlJmTFN0UjBHUDk5TDBzcW0zUjZU?=
 =?utf-8?B?eGkwZmtEOFllSHliTTB0amllWEdtWjVkc29pd2xMUUNoZzNkcHNjNTBoSmUw?=
 =?utf-8?B?b0lDTkFpY3VxL3RyaXluNjZhQ0J0MlpuQ1VuWjlMY2RiSUdFWXZCdnA0WW51?=
 =?utf-8?B?RmR2WVlydUlnSlVtYkdsSVh2MTZNSjc2LysxaXV6SjE5M1JJOGtTYjIydVNO?=
 =?utf-8?B?RE1jY3FnRUZiU3RpNlF6MU83cVNvYU8vS0VrOURsQTdMUkFodU5TemRpcEtn?=
 =?utf-8?B?RFFUTTBrTGhqY3dwRDdqcWJaQjd6V0Z0d29nQ0szVFIrcTNMVEV4VEdjRHRw?=
 =?utf-8?B?NjdRcUtYbjlQeEJZYUE4N1B2K0hKMWxWOGVYZHJRTmpLT0pXWVZxeVBqbDBP?=
 =?utf-8?B?ZmFUYVhiMUt6Zyt1bHFPcEZDbmJEKzU3SXEyOHBuSXREL29zV2E5R1RpcDVC?=
 =?utf-8?B?K0szYjBvd0x6VUtJODI2MjhSYWxDZE84Ty9uZFlrRTdTSFVYNytvc3NodkJE?=
 =?utf-8?B?dnRVNjVsZU11azB2cjVtZ3ZBbmduam81d0p1YXJ4RkFydDJBUnNTOXNSbHVH?=
 =?utf-8?B?ZWR6SVNlaDlsZWVJem02TE1zeXF0ejFiZWdUTlZkRkNwa0ZHSzV2N0xPZXp5?=
 =?utf-8?B?MmlaOG0xNjlKZ3lPVllhVlFCSmNIdHhxbUJwb29LeGNFTUk2UjhORjNZbkh1?=
 =?utf-8?B?MWFBUEJCNHZYQW9EeG44QVlLMnJnUE9uN0Q3aFZEaTlKcnAwQjQzMjB6UU5Z?=
 =?utf-8?B?S2lFVGhLUlZad1A1YU4vU0FFN3ZCNzhYVUZZUEJBZEV4UjJKcW41MHN5V1ly?=
 =?utf-8?B?QWMzbk5SSDFMd0Y5ZnFndGFRa3RVN1Z3ZXJzdWw3cFhrWllpM1RoS0hacFdh?=
 =?utf-8?B?QUZIUHNsYWE3RjZHd2FubGZTeFk4aUZFN1VzNDNtRTF5K2ltL3ZFVTF5Mmxt?=
 =?utf-8?Q?M8dXsFsgnSd3o8cXjpMWymVwdZaCaoxz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWUydEhvZ2E0RzVqZm5VWENSbEpKc0laYnc2K2cvakdQMEk5MGRDTk05cGtE?=
 =?utf-8?B?K1RqQlliL3ZwcWFVbEFjejZRVEdPb2VJWGZiL0FhL29JTDdzRzNyVEhDa21u?=
 =?utf-8?B?OU9SaGh5b3d1Qmg5cmZLYkhqVGhvR3NZRVdtZWtWNUZwbVo1RFl4dmNyaDd5?=
 =?utf-8?B?eWplbzdTd1lwR3cvblUzUTViSEVUT1dFaWlZWnEzYXRWeTQ4TFJpRnZiVDdT?=
 =?utf-8?B?bEt6MUEzVmtFaXB5UVp0emExc29HSStrdTdMRkJteUIrbE9rWmFuUDdlWFhV?=
 =?utf-8?B?aEJlaEhsY0t4UjdmaDR0OWtnTlUzNVgycUYrNVBPand4V0NYMHpyZzFFZjRE?=
 =?utf-8?B?ZW5LemlPQXJjUnJwV2YwODBDL2FKYTBsZjZkREJBZ3pqQ3pRczh1Q0Nid0ha?=
 =?utf-8?B?M3hHc2Uyejg3UGdxUVJHbThvbk03WC9aRXBDd2h5WTE2MUhCV2FDaTFuV0lN?=
 =?utf-8?B?WE1hOGdEQU9aVWZjdGNmOU1kcXB3aXVmdHhWZFFGWS91d0pWMFJ0dlVLYVhM?=
 =?utf-8?B?ZDlQb2FMcC84WmJiVGpKYVdJd2QrcGVRbjhiUzMyNVptVFBDcEIzbjMwU0Fz?=
 =?utf-8?B?d0dQSU5BMUhZTEV4SG1yNDZrMjF4STZEcjBsWisvWGFmUnlEdXg4LzFZOFA1?=
 =?utf-8?B?ZFZhUExXN1BpSUhPdXRCRlJXTnJxWFJwMVViRkZtdWY1QmlQdUhteHBVbVBM?=
 =?utf-8?B?Q1NYczMzQ2lOVWM2TjVlNlRTaGlEcGVtemNQMU9LcjlvNUFVd0FPd3JySlVY?=
 =?utf-8?B?bnJRNFd3RzZYM2locXlKRFlleFNGdExwWHRDVWpVMXprVFkvV2FlR05uY0oy?=
 =?utf-8?B?RFVVeEljNWR5WHBtaEw2VHdZN2NlN0pUOTNDa2w2MjRUeEtXMzVPMzFpTkRs?=
 =?utf-8?B?eXZKT3FOV3FaWXdiajJ4VlBPdURmV2tuVkU4bmZGV1JqWXhPMUtTUjd5MU1z?=
 =?utf-8?B?eFFCSmtPTjJLbW8waTNsSHFQeEtMWVo0cGxzblpqa0lESGhkRnRjRXh5NHc4?=
 =?utf-8?B?WFREYjVuanMyMjEzM2VLVm9neTNTcjdtMDNqMnJtRWVhdGkxeTZqQmU1a2oz?=
 =?utf-8?B?N084ZFpCSUdGSTVXZDVlY0VPeFVhbjlFTUkzd1p0SGZ3Y1dGTG1SVk4vSitv?=
 =?utf-8?B?WlFBZWJ0U1ZuV294cVpWWGxybldCNmJLbkhzTVpiUDBPNExDaU1jZ3Y1YStv?=
 =?utf-8?B?cGgvRXE5SEVTWE1Bc1pwd3pvZVZ6NTBJTWtUTy83eWRldWtWbjk4ODRNTWI5?=
 =?utf-8?B?WVkyRldWcUtYY1B0MzNTSjhZZkN4eUYvTG5WRXp0U1NFNks3SU16VWJqditW?=
 =?utf-8?B?dGdnVkV2dWdlb0gxY0VldVNLeDFGNG1sVXJOQXRMR095d25zSWt6NFZHOWRl?=
 =?utf-8?B?MThIcDNYbHZNd2JtNkgxYndXVGhNb3hOeEQvK3ZucWxLWWp1WHl4SmRYK1RF?=
 =?utf-8?B?b0pKL0VQdnBzM0xCV2lEbVcxNHpIbnoxcW1aL1FUZldJY2orZkVDMUIvdVVZ?=
 =?utf-8?B?NEwrVkxsV0d6Tllod3J6TnBicVAzYWdIYU5nd1pXK1IxdTZITXFwWllFeGlw?=
 =?utf-8?B?eTNId2NVQjlHWGxLc1JLSlBvVlBSdnpwY1hyME9DNzlwaWpHMjVzYmxLQnY5?=
 =?utf-8?B?M1B1OUFFNzRQdkFzcW9EblhkUVJ0cURYb1RmK2gwcWhOelhSaWw2cFRSWnFk?=
 =?utf-8?B?enpieFVIc1B1Q1BsVUZtbUwvZGs3S09pWS9sUFNaU1lFOU9paDc1SlVNVTZw?=
 =?utf-8?B?amowNkQxamQ2SjZmV2hoSThWOER0dGorU2lobDhOS0Y2aDBHdGJwOXkvVmNj?=
 =?utf-8?B?MnVmdHBjN3B3aG11Wk5mUE41QzhJVGdKUW52WkpHd3Q1dGoxTloyRmdoRjV1?=
 =?utf-8?B?UDRPL3FWcjlPV2pNcTQ1R2ZzN2xDeEd0Q3JPSWJGbE9WUnZKMUZqNk5VOEZw?=
 =?utf-8?B?ZnVDSEpaWFpSUFRSUllPZERDQVB3S1BhS3FIK2ZWOVR3WUNLTk42UlBRY2tM?=
 =?utf-8?B?d1lEaW1pS3BLZXNNeVZVa2ZxUGhROE96NHdPUjJXMHh3Zjkzd1RBeXkxR09q?=
 =?utf-8?B?MWJWMVluRnNkVmhUWUdISks3eDdSeXBHMDlObmU2aXVRbnZjT1Q1bHVGUGhW?=
 =?utf-8?Q?oLwomqfQPpvVd/kLZQ6XstfZ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a463dc9-5b0f-4a17-510f-08dd26dd1dcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:28.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYtznAeGYIu8MZpOGd3NkS0oHP9D5N8RErVMSD/mWqkv2HpiJzDvALxM8prkBUt+znJIsOotmJXLljeiwbrM3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/keyboard/omap4-keypad.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index bffe89c0717adf9ebe5b33892efa4dc30b158f83..b7bd649d1628a6bf10db4135f73778f62db92647 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -465,18 +465,13 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(dev, true);
-	error = dev_pm_set_wake_irq(dev, keypad_data->irq);
+	error = devm_pm_set_wake_irq(dev, keypad_data->irq);
 	if (error)
 		dev_warn(dev, "failed to set up wakeup irq: %d\n", error);
 
 	return 0;
 }
 
-static void omap4_keypad_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-}
-
 static const struct of_device_id omap_keypad_dt_match[] = {
 	{ .compatible = "ti,omap4-keypad" },
 	{},
@@ -485,7 +480,6 @@ MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
 
 static struct platform_driver omap4_keypad_driver = {
 	.probe		= omap4_keypad_probe,
-	.remove		= omap4_keypad_remove,
 	.driver		= {
 		.name	= "omap4-keypad",
 		.of_match_table = omap_keypad_dt_match,

-- 
2.37.1



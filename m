Return-Path: <linux-pm+bounces-19929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CBA00602
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A474F18845A7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD71D5149;
	Fri,  3 Jan 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cts5C0Oi"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF214D2B7;
	Fri,  3 Jan 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893747; cv=fail; b=u7ucxL+cO+m1aE+e/EwkWkAys2pVITvNn0x+D59Fy8bzffC+Lt61wvRmcHvfxaZq/Y0RzPftoJ8wtHGFnMdriPUvC0wynDhvOK6bWG0ZO+9n6Z405Kh2LDqETpmzmHb7A6AW8II6hnZ6vnENByDlWfxCT5mWczwUF6XvLB2O1sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893747; c=relaxed/simple;
	bh=zQeVfeCxLWPp1ta82McHGDfqjkgW42mBMCjsal6VJxQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i8Ufd/7PA8Q2Jvn3WFExND+VisT0C4Ku5NCNFrhEeoLWxzqbBlhdZhMCowIC/MikQUx19CHoQY9zXQTSDTm321gUujGq/2sPIwXe16MVjFqK1BloEGM56Mv0AG1wAdDtTm31VqJv3u28cm4h8wLW1Q71w3CKufv6DUzXCnh+d3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cts5C0Oi; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8tm0uvqhIf6eroM2HkdsD8BVwwRNYKIWwxjflnKELkq4poS1y+SHTdOD/JbLRK7kdBOQyQbfsNcLPfo1hOZSTtPt5e1mi0rtop5qPSlm06knOFNBiamsQLESAqhzu2CF3UHPzl2YYaC3Q5CLZwL0aYMQTShWL9c+LQM1VqR3y914G0F0/IOvYPhREeGpSEX/evzRg9+B+ArlNJlbMVq0eT7+pvuQEc9jxtNuos2gcb4ih4KlQE2voew2TrAmBpcMYjnVnhJfYdQjAZ8O4J9Q41q5bGl44GQrViGRdduWe56nlu3fXILxclWzgLHRUy6vZMTcOn60+23ojiwCI01Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLJ6/6T287sMFeFzpA8pzl4U0kUK+AHmoE0BEwYo/f4=;
 b=Ja/dB4ugHm6Vcl2ZZFuh1oA4BY9dX6PnHP4jpoR9vZyCMvsIO7JxrqPRgVzI4UlOFhPFF1XPNGla9fiSCRM7FQx4F8xL4Lzh+1qCaXFjRAsKVsuQ3yXFRkHnuSrps6lpJy8JcU8HTe+5wwUDYngFhaNw6iGk3CuMK1pM480D9lGv0EWXNwqT3m1SkKIuve7P39kyDYdntx0EhGZ523+GI3mcUa3PE3SGxjhFkzBLhNla8BC66neUXhvLmfBH6iHx9781FFrQneffCTMmAd3ugdeslrMjd8tt4ASgEtHQwSxE5NQUg/8skI+qBQFozCx9fnMc0icKdQxe7LyBUdWvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLJ6/6T287sMFeFzpA8pzl4U0kUK+AHmoE0BEwYo/f4=;
 b=cts5C0Oi00MJZmoRNM4haR+LCAm5msTkmn2uRXN/MAT6bD6ZTGs/SBu52cdodHHB7vKd7FaMjQ2K9jHz+keG2LH14/Nqe4eA82YhsqEkt+SxAqjt/S4HJRA+V61N9dzyGMgN7Wg7QbX6E1t6khUDIbatBQjOjUejj98LsYWe2WPfED5u46ztmLhk6zL8sWN/R9EhVpO1D9x05ndsgpOqGSra5cosXwk64TbT5jAPP4qpDU4O1Byr2+rZ9DjhkL2oLL70okzc1a53/V43vnCM7bxKBgtxoazTqDslAPi8SCh9bNkv44kIctxuMaDcMqTiqSMb7K9oxW1JF2hy4zA1tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:16 +0800
Subject: [PATCH v2 04/12] input: misc: nxp-bbnsm-pwrkey: Use resource
 managed API to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-4-e3aeff5e9966@nxp.com>
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1523;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=g2vZhAdAlG59tJHA7zmPtBw4oLxwHW1tSbJmlo9rLyg=;
 b=+I6HRtno9tO1xMt9Xr1J/+5hT5bkBUElXdcTiUS7rB914jnH7yIGafGxTvgx5xbyGDYPREEEM
 qgLQ9gN7uKRA7a2DGATSZHotKncPnzAyRgYkI8jhhuEYvA3TZtkEnlB
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d65fc1e-2bc8-41dd-7b0c-08dd2bd287f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lBVFJhemUwbmVSa0R0OFBNeE56aXVmcFhRdERpRzBqdkF5bjFrQ0NGeFA4?=
 =?utf-8?B?cVExZ0tYN2hSRTVQeExYK2NOVmlnZzUrbGZKbk42TFYzVHR6UXp0YVIyT2VI?=
 =?utf-8?B?akZEOWN2SU1qR1JZakZiZXNtMFMzL1pjS2pqeDREUGtkbkhFOUY5dVJYd2tK?=
 =?utf-8?B?ZWhEdExzRW9hRXFPOEt1L1N1ZmVRejgyVXBhK2NwTzBqdmROTmVNbXVZNmo1?=
 =?utf-8?B?ZEhCdGJDbUovTitzWEt0Z25zSTZqcy9yY3FyWi96K1VMYU1TdEtxUk1pc0RD?=
 =?utf-8?B?NEpIcDZpSThvVDNtQXBiWXJCVXduWlhjdVFHdE5ncWs3TzlhUHk2Ykp4NFVL?=
 =?utf-8?B?TXVwcTNuTW9QTEtReEd3cTJ5UjJkalFVNkZobG5xaFNYZ255TDlOR1VTa083?=
 =?utf-8?B?ZWwrWXI5b2xMNXlrMWdTcXFiMWVTdnBnVUR1OE1LKzNkS2dYU09XSEJ3enpD?=
 =?utf-8?B?enJRVU9TdzRzczE2TEZlTDNVRVdjdlVLUEVRUFNpM2xMZHhnWmxsWGRZc0R2?=
 =?utf-8?B?dEZNbDEwK0ZKaTdLZ0c0ZnNINjlZUS9ZRzRHcnNldGYxbWZNenhCZ0tDZ3l3?=
 =?utf-8?B?QjJQZHg4QVdRa04wR3dZSFordGtyVlNiVjZqRkx6ejhWbVMyQXdKMkFTTEc3?=
 =?utf-8?B?WFhaK1RVeXpKUDNhdERpM0czK1MwNnlFWFZpU3dxdXZXT3UwR1UycWllS0Nm?=
 =?utf-8?B?RmFKY2ZNbHBpdU42UHYweXo3NnhIdmMzVG9jaGlIdEppRmdTcGRWKzd4TnZk?=
 =?utf-8?B?RHZ4ZWNXWDA5aGY2UElJRWpSRHgwSEhsZVJ6RWxuWFZMMWs5aGxOOHh0ejJU?=
 =?utf-8?B?SGUwdDZZU21md1RUbTIyS3IvcEdpUW41dENudnNMaGo1VURid3JvTSt3a1lk?=
 =?utf-8?B?U3h6M1V6ektrbm43S1l5Z21KUWRGcEhrWktZUWxQM0xnRVNka2drR0h2RHkw?=
 =?utf-8?B?WWljSmJrZWNOK2N4aFZhSlgyWkR6R29HdWNRNkg5eDA0cTFtNkd3Q2EyUjBa?=
 =?utf-8?B?L2NrV0djcEhhcmNReVRCaVFEMWZDMlA3RStLdjl3ZGtMa3padXhEcmgvSDMy?=
 =?utf-8?B?aEpjQ0FLS2VXVU8rVUZ5eGM4YnlKWnJYcjM3N3NPa2MyaU1tMkY2eHVYQzd5?=
 =?utf-8?B?QWZmK3lENEh4R3R6NXA0Y3FRSWJtb0I0eGVIU1pyMUVzejh5eDAvblY2d3dp?=
 =?utf-8?B?QXR0Nm1qenExczQrUWhGS2lsakNMbEFDSGQzTEkzUzUva3Y3SHBKbEFvV1p1?=
 =?utf-8?B?T0FHY0FFcys1SGZ2dG1VcU9kNzhEeWp4UDNTOGFRaDFSbGdiaWliSnhIeFo5?=
 =?utf-8?B?eHJPYkR1YWo2ZWNXeHJTUjdRRE5wdzV5V1NPNE5MK1ByVS9RVGFmUTNkQkp6?=
 =?utf-8?B?N1gyZW85a2tHN2xhc1VLSmxFZWlLYXRJbklPZU1rSFlRalRQc3JmN01QQUIw?=
 =?utf-8?B?dVdiV2tjb0pENWo0KzNmNE0xZE4xdVdZNlVpYVh6UHFZdVozYzdadk16TzRC?=
 =?utf-8?B?djlob1NxWVljUlc3MDdSaGtxb0dSdW0zYjI1Nlh1Q1I3dFMzU3RuWk9HVENB?=
 =?utf-8?B?emM5RjV2TjNCM1d0NGowYUFXSC96b2VndURiYktISmxyR3ZmZHpYd0FxeCtL?=
 =?utf-8?B?Vm9mY3k4azRyWUJzcERGMTVQSUJaa2hJdjhxTFl0OU1MaWhMQWRPNmVBM1BE?=
 =?utf-8?B?cGdESWpiQjhsdzZjbWZJSEdNRTc0elBoQmcyTUtFMFFEblpLeThIWFlRdzdX?=
 =?utf-8?B?ZTRDNnFab0pwUHdyRENVTWpXNWc4Sm5XWVJlWmRDQTVLa0RVbXBOSVZFN1I2?=
 =?utf-8?B?SGNEd3ZnQXoveFdkQVdIZXc2cGtPaE5qVm5Id3V0Vmd3dnk3b1A4eVdWRXcw?=
 =?utf-8?B?d1hOeGxmRE52ZnFpN2tTYnlRWjNtSm92MkFhbEUvTEkvMXJ4czBRNnQyemxo?=
 =?utf-8?Q?Y0+5unj+C/N8EMblYcOJbTiEFiofZdi3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2FmZ3NKcWN5Q2ZLUUEyMlNKUFZabGZnR21sUzZoOXpsdWJLWHNFUXpHbFdI?=
 =?utf-8?B?VXcwd1BNSUhEeldPN0NESlpXM1pIZXUvSUlBMVRUcm1BY3oyLzNpdkE4clNH?=
 =?utf-8?B?dEhjd2lKWnJhdzlPYkhTTWl3TTlZWGRhWjFVTzVjb3JKRVpmemREOW9DZDZl?=
 =?utf-8?B?SVdMYTltVlFlT2Y3bUg1UGtNWStnbHFDdXNKNnpIRlg5VXA1UGZkZHRvcUxt?=
 =?utf-8?B?TEhnY205WU4zVlpDSVdoQUFVV3I0RGovVWFVT21SK0I4eVhpM3NBcC93UXEr?=
 =?utf-8?B?WVg1L3BtbXpGcWFwdWJ6cHhBUDZuOERlWVFGWHkxbmQ5MTdudEFNSWNscXll?=
 =?utf-8?B?QU1mVmhrOGFsRitycUlJS3N5c3B1OWNzRFMxaG5NeVB3Nmsxb0xSeEQ5Ky8x?=
 =?utf-8?B?K1pIRDJENDBRMVZEem1tUkFXc0VKWFd6WE5Ed2xSMkZPeHp1VUZIOEMwdzB4?=
 =?utf-8?B?ZTNJNHhXOTNPbEZSdU12b2FIaUJZZWVta0hJdlFQNjlOTk0wUENjZGVVMGxS?=
 =?utf-8?B?MjdBQUJsZ2x4WnN1T0doRkZ2VVcwcmJpd0xMOURpMmd5bTE5QjRIV1dkQUZo?=
 =?utf-8?B?Y1ZoVXNvQlY5Zk9OUWl5eUNNZ2hSUExENlBqUlhDRTcvUWVqR1BEZE4vNWZo?=
 =?utf-8?B?RnphVFY0NndySEpUb1cvV2F6U0JWM05DeGs0Q1hGZ250dExFUCtRVXhmZ05I?=
 =?utf-8?B?RnVvblVwdXNER3BWY20relkrQ2E5dzlFM0lDRi9JSnFvczEyU0RQd0dtZkRP?=
 =?utf-8?B?Z3RXcm11alRpdDdaZzJYNFltbkxFQTVxb0FhajFYVXgxNHNJVjE2NkhLRlVW?=
 =?utf-8?B?bmxtQUpNVnM5Vm5aMjErZkNHeEltcHVuS3RyM0szY3J6N2VmT3BPM2U5UXB5?=
 =?utf-8?B?TjZLTXZwS0gyeHV2Njd6UzBXeE05L256R1plc3NkbU5ZOGdXOUI1VDU0cTA2?=
 =?utf-8?B?ZmlDUTN1aHRoSVJYLzFsUnEwZHF5bzJuc0ttNGVwb01KT2dkK09PS2lNcitx?=
 =?utf-8?B?YVpPY3d1ODZCWUZXOVhPQ1ZCNWdPNW5WcVp6eDZlK3FxVmZkSnZrT0QvdW44?=
 =?utf-8?B?ZFNQNllzYUlNYnIxMk13Sjd6ZUxLOGh2dmZLL1BLdGk2ckVqamJ0eENKTndB?=
 =?utf-8?B?c3NEeko5amJ1clVIeFZBNGVFcnJzQXh0S29JT21jTGhDdlFZbHZhY3lLYjRn?=
 =?utf-8?B?dUtWV2czSTREQjRyR2kwSmlLeHdqa1FIWGN0aTBDZFoxTzBLY0MyOVdCY3FQ?=
 =?utf-8?B?MmUxTWhyT0x5QWRyYzAzNWJ0NHR0SHZlSTFuNng4U2RRVTNjVDdxL3dMYi9S?=
 =?utf-8?B?OGNWTnovQWNJY09raUlNVHpsN0F5aVE3bGRRdlpyaXlSU3BtTlV1TnBwc0FX?=
 =?utf-8?B?L1FqMnVvVUpUSXdwN3JralBZaEd3dmx6NUp5a1lGdVVoSlRTYlFzOTg4UmxU?=
 =?utf-8?B?MjRnYTlwZFE3NjJCemd3UEpOUW50cDdHRjhLaExGSFIxK1JtU01WMjRHVUF3?=
 =?utf-8?B?eEd5MFZRVmR3NjNBQ1V5MDBCMURoTXo5NmsyWEIzc2p6SDYzNWtSRGJBd1pT?=
 =?utf-8?B?ajU4QmRWMzk1ZWtLaVZPSjEyNnpneEp2YTNTOVNVdkJEUDhyVHFYaVAzYTJI?=
 =?utf-8?B?bTBzUy9FbUtla3FzZk9PbDF0Tkh6Q3M3dVdLOWFwMUhjakZkb0Y5RFN5WTU3?=
 =?utf-8?B?a2dJZ3IwVGp0ZmZnRWNRV0lPNmczeng2U1RDbGhkWWgwL2s4QS9leUF5YnRX?=
 =?utf-8?B?TmFCR2lYazIvVTRIZnczTGo3eFpHSnY2OXRFa21mQ2o0QjJHbE5Gd3JLc0VX?=
 =?utf-8?B?OUpQUVpEdzVpdGxGWnpYZDZmeTVGVEhNMUpIMjI1bi92M0VmbEtMQ1hjcXl1?=
 =?utf-8?B?QnNGVmpZYUlYTlhwZGFXZG9WM1E3VitjRkZnY0xBL3NwT2hJT0NySVdkNlV0?=
 =?utf-8?B?LzlxbnhTSEprZ1hFamxpSFd4WGIrVzQzekpWMmN6S0tOdzRMVDdHbmRNanhr?=
 =?utf-8?B?Z2NHRlRPMmtmekZhVVVGVHFFVDBKMGhzTEdVdStEemQ3L1pSWFU3SnYyMlZ1?=
 =?utf-8?B?bnh5azhhUVlkWkwvaGxmVzBNbUlaZ2hqdUJ3UXJBYkthY0k3ck95VEk4Y0F3?=
 =?utf-8?Q?Md6gp39qwxyRSOB8Xpp0ER0Is?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d65fc1e-2bc8-41dd-7b0c-08dd2bd287f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:18.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guPTvljsyGYzXe5O5VBVaJ2FUhM0XZRUy80MXfIHCNgH5u1s4/qtkgJW/BSEtHw/7k87VIluKfuvxEiml5HPqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/misc/nxp-bbnsm-pwrkey.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/nxp-bbnsm-pwrkey.c b/drivers/input/misc/nxp-bbnsm-pwrkey.c
index 7ba8d166d68c18b396e616f6f9074ae98c4629b7..5faad2c98af35c52dcacbf25728dbaf2cbb3c625 100644
--- a/drivers/input/misc/nxp-bbnsm-pwrkey.c
+++ b/drivers/input/misc/nxp-bbnsm-pwrkey.c
@@ -179,20 +179,17 @@ static int bbnsm_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-	error = dev_pm_set_wake_irq(&pdev->dev, bbnsm->irq);
+	error = devm_device_init_wakeup(&pdev->dev);
+	if (error)
+		return error;
+
+	error = devm_pm_set_wake_irq(&pdev->dev, bbnsm->irq);
 	if (error)
 		dev_warn(&pdev->dev, "irq wake enable failed.\n");
 
 	return 0;
 }
 
-static void bbnsm_pwrkey_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-}
-
 static int __maybe_unused bbnsm_pwrkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -229,8 +226,6 @@ static struct platform_driver bbnsm_pwrkey_driver = {
 		.of_match_table = bbnsm_pwrkey_ids,
 	},
 	.probe = bbnsm_pwrkey_probe,
-	.remove = bbnsm_pwrkey_remove,
-
 };
 module_platform_driver(bbnsm_pwrkey_driver);
 

-- 
2.37.1



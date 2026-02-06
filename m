Return-Path: <linux-pm+bounces-42232-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EsZGBb+hWnUIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42232-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:43:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8133FF21D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 427B53014436
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B541B37D;
	Fri,  6 Feb 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fs9CxG/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5743C199F;
	Fri,  6 Feb 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388967; cv=fail; b=Y8sL6jPoboftqXTff0iIOZKUq+z6qI8QBEvJQWZNMZpDj8zJTXujIXnHByOXnbIHR5ROi+AWhrFwghemfC+BgzI/CvAgPmysOBBZAt9gwfCGaiy9BU1AjxhMbpvJY/lrkSyAb0cmkBcdcdp7xxh69ZFGqbzaYc8gjy1pfIuyXlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388967; c=relaxed/simple;
	bh=dM+HCta1Gom35/2HFvT1USezDKqYYcQZHYYz3GaHD2E=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=R3pH0tlde4tDChAsfX3ZNdPImqK0Xbqyc9U/VoCy1IFsR60jCNQHrwzgZxdaMlmKLnrX0YNSPP3mJrbusTHaKyq+I1HYPpGOSNDdp2bDM0THyMeuOsFRnP9QClffHoc8szLUGHqqjlPtwOjXEFYwEvP8ZGQPU8bYKQFpjJ8meQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fs9CxG/P; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQk/NjR6DdlV82QkFmCsyTxo1ax6I+D6rVZQcphOpsG0jA7+dl/YKDynKFAPlWDPjJMDI4vUPml/lza83jRCu3akN3OHoapfEi3A3VGbAAbjG/rhZr+ZS8HhQfSJNHiYzt25RsYHD9G/XzwldnevIpwUYqy3hfhqggbpWn3VWZlWUhB8TN8kZrKsztf1BBnmIzJMZZ4J64L3KhXaOBsMSwivBhBsQQmUmAEX3Sx72LOSvNluQCE8S8yJYQJ59ho/gzPtKRS34nR7qA2h68wtIwCGcJ1mh1cleVXY+bbyI2DHwVYtTRfdHB9vhFl68f4UoSYCXaJWmrCUmBlq7FoyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3KF4fMdlEaSLMLUahVb/KsimO3j/RJJ69baKfKlVqM=;
 b=cSYHegHerub4REnuHU7Xc94a0u9sDLwmdK1TbvnIWScfoFEG4G74SWDEdTac7DHBqB9Aehi26GZWLGGOGYWv2GRrPlr0f1PDSpDMb0xCrbedx63oEM67iyERpRHm7lqgZ4CPc/Gm0YW1q9S3rNrCPz2Z5ycSY/SQBY78sBrc5Q9O/V04IJbhoT9kPmYRAmBk8vggqSVmr4e91H/LA5p0a8Mdz79W9uCHb04af4ytK7eJ137z2kg3lCsv1se0U4Unq5yixfc8ZlOc6iJAo8yHPahvGXIR+TkN13IhUNCOXsF+G1IDRop495RIVvyd4zFZon0Vn7yTqHf5hEGjMn9gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3KF4fMdlEaSLMLUahVb/KsimO3j/RJJ69baKfKlVqM=;
 b=Fs9CxG/PgJC717cTxx8qohtTGcL4CzNbV5hOYTlHVmSkHOrhP9jQ4H6TVqZuM8xQGH/3mZhlKa6y9y7BnNTZMMc5TRoejYsWDVSg2WZED1uDH5Xb45+WlHMZw1Yzoyui0IJR/jj2D4W+pfZLwBjgy9unom1HdcudC6Vb2OMqFjTsiSWvzc+j2WlSObERdmidPGXIzTWpYrnqGFEgmCCSRgf5zFxYrT3nIc/gVKjjaPYiQs79LVfnfo510jha/nE7dPprn2JWwTJo/Q0515qwXvNbRkJ5mdODQZWFBzA+drCdnWN3aNnzrzVVSGjzHClsD/9kE3p+Yha8NazIezyYxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:42:43 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b%2]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:42:43 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Fri, 06 Feb 2026 22:44:17 +0800
Subject: [PATCH v4] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260206-imx8mm_gpu_power_domain-v4-1-52fb603da502@nxp.com>
X-B4-Tracking: v=1; b=H4sIAED+hWkC/3XPwQ6CMAyA4VchOzvTdjCHJ9/DGIJj6g5jZOjEE
 N7dQWLUA8e/Sb+mI+tNsKZn+2xkwUTbW9+myDcZ07e6vRpum9SMgCQgCm7doJyrrt2j6vzThKr
 xrrYtL6Qm0gaQamRpuwvmYodFPp5S32x/9+G1HIo4Tz9muWpG5MBF3ijUOylLlId26LbaOzaLk
 X4UgnWFOPKzQbg0gApB/SviV1n/L4qkiF1BEhUUoMuvMk3TG35iQB5IAQAA
X-Change-ID: 20260113-imx8mm_gpu_power_domain-56c22ce012a1
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, stable@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770389068; l=3303;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=dM+HCta1Gom35/2HFvT1USezDKqYYcQZHYYz3GaHD2E=;
 b=eTfA0C6Z6MCIGjE4a7xC9Z7cCcEaP1iF+Vx8qXRNK/QsQJJdj3ys8mhVmadQIfLND3PSw4SNr
 p9juZib6suwAGWreFtfPgFnJyf3OmK4twPmB5LNyKMnnb5L4zjY4liS
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|AM0PR04MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ca5faf-e3fb-40e8-5c46-08de658dfc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0Rla041Y1BydE1JOGswN2cyR3l2RWRLRTFEYnlDczZZTTZjbE1hSlA1TTBQ?=
 =?utf-8?B?LzlicE9vd01Zd3hDTGRwN2dPZW5UOUtrTkdIWUhWMXJ2NFdpdUEwWW0rR09v?=
 =?utf-8?B?WjZORHJ3YnVYZzdsS1hxSTBRTEp6QTQ1RWhWY3NZVXdpNXRkWTRMWWliS2Qx?=
 =?utf-8?B?NG0zb0F4K0ZsVS8vN2xCR3ZwVXhUc21ReityWm5CVkRPSzVxREgyRnR4Z25Y?=
 =?utf-8?B?Ti9Ia0hWU0FraHNVbTJRSUlBY2xENkV5aEM0cEZZcUJ6OVA2YTNRY3MyeXNL?=
 =?utf-8?B?UVdKTFZuRC9BeC9maGt0bmJUT1lKMHc0aEJqWlFlQ3hkZElvZzRDOTVGY0tH?=
 =?utf-8?B?UFNCc3lkMFZ0RWVCdDVRTFRJeTJLUWNyR3dUZSsyY0dpNThheHdCQUxlbTVx?=
 =?utf-8?B?cGdEbk1wdkowSjZMN2JFU2h0UURCeC91TjV1aDZRWGFzeHpMaHl4SEdZbVhP?=
 =?utf-8?B?QXhnRGlUTXY3MndRK2I5QndmN3QvWGFTL2xVeFVvRmNCNXhMNkVicDlZMHBw?=
 =?utf-8?B?QmpGWkpQaEcwUnA5SE1ZOFFab0FsKy9BSXFwMWZmelY0aTZjWEUzZVZkaC9y?=
 =?utf-8?B?Z0JKcXBVdk5VMkdXVFVKQUg2OERlN3ZhdFRGRXhNZ3o3amZhKzVhSjhsQitX?=
 =?utf-8?B?aTBNcTMxUmhWYkl2Z0tmU09OZ3RzMVNncnlxZlZwN0pKdDQxYzJNYmNvZU9v?=
 =?utf-8?B?YmRnWjVhWXBBS3Z5YVhUSkFheGM4OXdNSlozNUVJc3dNRXYzTUc1UW1hOUl2?=
 =?utf-8?B?Y0IyVFl3UTBWbkhzM2trR3RBbVlUbTNjcG5WSW55Uzlsb1NqWlF5RThka21p?=
 =?utf-8?B?S3pYR01xQU9UbzR2VStBem1SYTFuRjZhRXU0Zy84bzdFc1hKcFI4V0VFeFdp?=
 =?utf-8?B?TEF2Zm5QL0F2dmdDWDIwcjVUNVhEV2k1L01mZkQ2d0RwTEZrQnN0NUE3MjJr?=
 =?utf-8?B?c1ZKS3ZvaC8rT0FjeTIxSERIcWlnZ01FTzJkMmV0Q1FPbWNxbjV4WnZNdFB0?=
 =?utf-8?B?Q3YwbUwrVU1tSXdGN3FYWlB5Z3EvTkVJL0ZlOHpQdU9GMURvS240WHJRaVFQ?=
 =?utf-8?B?U2c5cEZrUkxZazcwMkV0aENVTFNLTUsxNlBxbnczcHBlSkF1TXBLOU5LNDB2?=
 =?utf-8?B?aHVNZk5WaGdHWmdXbFZod0lZZUFpZk5lMDJObHNGcGZlQ2sydU1rZ2pWNmU2?=
 =?utf-8?B?RFlqRkxmWlNCTnFWbk02Zi9Ca3RDTnVDOXowazFNV3RJLy9MN1I5b1FjYldo?=
 =?utf-8?B?NHNXU283ODBkcVB5ZDEwaXNwSDFaa2VGWkNDU2VycU40REJ0TEpxUDR4VUFI?=
 =?utf-8?B?RWVzdnFXYjY1aUQyMitHRjBWUVhlaGUxNTJ4SHJyTGhTRnZFcXpQR3NmRjNP?=
 =?utf-8?B?UFdkTGlOdDVvLzBBUDNVbkc4VEhoM2JVVjhuL2NDTEo4MCs2SXFTWXdOdVRR?=
 =?utf-8?B?WmVVckRKekFNKzRGOGdXUFBvUDFNdzg1U1NQckJtb2QvTHBNTEZZQ3A4c3Jv?=
 =?utf-8?B?bXZvczFkVkVkc2ZvWFgxUjVRZE5rOE9veVpVdHpoUjJnVnBDdUYyaHR0MXFP?=
 =?utf-8?B?K0tvaWRUQloxYTZJVFlLelpXTjlHajdlZmNJZEQzaHFyVjFJbnhmQU15MDZV?=
 =?utf-8?B?elBqYVAyTnRUS1c1L0NxRzc0Q1I5SjA5azgyUURKSE1yYU1zcExwbWVNeHhm?=
 =?utf-8?B?a3dCQy9aSUFnWnE1SUtRR25kdDUzd25MQmdRRmRlNHVSQUJVQ1FXZE9pSm9R?=
 =?utf-8?B?c1RNS3Z1R0lhRFF4VXhURW5yRG9GRjZIRG9NSExNK2ZiZTEvNFZUVW9RR3FV?=
 =?utf-8?B?VlVUbmt5WmEzRU9sM2hiZFRvUm5vSURwaHdib0UrQnZpQ09xcC83UWVPZmIx?=
 =?utf-8?B?TEIycTFzdnl3elFSZTRScnB2djRlNE10c2tpZlhpNEtoUEUwQi9rallYajVR?=
 =?utf-8?B?U0JNOXdlVkpVTUtiaTJPdEllZFBSbjVCNGhCcVMvd3ZDUXY1Y0s3NDlCTjJU?=
 =?utf-8?B?NjY2azY4U0tvTTNjVXR6Rm9vT1RVZ0l4eEdVNXVNRzNrY0c1QWROcVNERS9O?=
 =?utf-8?B?WFArWVltWkF1OXJKOVl4ellnZWhxeGdhVThWWG1iTWNMR3RvenFrOGdQRTR5?=
 =?utf-8?B?YkZZUWJiSmlPM00rK3NBOXlsTHpBWU51dFVieVlkTlo4RmNNYjdyejdIMmpJ?=
 =?utf-8?Q?aAnE2zr/VjCCSehQESE4owP9/ZGyofE2oQNlTrBq8/12?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTVhQkM0TEc3aVBsU2V5bWxLMjNwRkppS0xvVkVsOU1PbHNLSXhpcFNKQ0Nw?=
 =?utf-8?B?aWU4WFFoTXBaVVpLMW51NmlyOEZ0RkNjellZbHZ5cjh1WW84RmFYYmhMQmdW?=
 =?utf-8?B?TUN4OUx5c1RuN2VaVUVLM0crZWxkVUU4RzRKb0J6WjZmK1FEWUdIV3prTjlv?=
 =?utf-8?B?eWhZaU85ZUJWMU4xb082a2ZlQ2hITWRBTUtEZnQ5ck9za3lHTFgrUGtsVGpy?=
 =?utf-8?B?L0kvQncvU0MxZlZFN05ibHV5YXBJZzJIeVNwK0g2ZDhITWNwS0VKdFRxRDBL?=
 =?utf-8?B?YWFlRFdJL1prczlrRlV3UmlWbmpPaXpFMzAwRW05NEs5NDNob29GVEhNanVZ?=
 =?utf-8?B?WVJiYTV0eWlCbVZ6S0VKMnB1amVCMlIyd2JwalRKcmhuVzNCMXZocCtKejNG?=
 =?utf-8?B?Q0VYaUpYZDNtMkdSYWhlUEhEUzNtMUdYTHM0NHJ4TTEvY0p6OWJxQ3BxNFFr?=
 =?utf-8?B?MkJlYUN1bWYwdXFVbnBsUjlqUkRhczE3ZkpUQkw2WGh1OWZnRTZCU0RVV25D?=
 =?utf-8?B?Q1RkbXlaekYrVXlZUjB4UWFJYzJ0Tld6VFlKOHhGcGxhOEc4R2xuYm9VUFB3?=
 =?utf-8?B?UUVnbkx5enVkV0FqUytjWWR5SXN4SkJ4MzF4KzAwYVUzVC9DOEo5VHJvTW5l?=
 =?utf-8?B?TGhHMDZmWnIyb3JQQlk5d3FvM2pBTnNrS21sTmpueklLVUFQL3pLQlY4djI1?=
 =?utf-8?B?TkVEVXhja3FJT3Z0WHZQaE81cktud2pZSmFMZkJ2VEhhOHBqSXoxM0xTVlk0?=
 =?utf-8?B?WXdXN1hzTkcvdXAwSWdZcUJoY0N6Y3N6M3FvRzdFNmZNa0ZDVGozV3AwMFl2?=
 =?utf-8?B?RXhQV1ljZmRHUFZPem41UUtxRnZjUTQvTGppcFV2ZVJYNXd4WXl1UkpyYWlU?=
 =?utf-8?B?UjB1QW92eWpQS1YrNmVpTVV0dGpBOG91VFY5RFNGMEVIUWc0SVdza2tmeE9X?=
 =?utf-8?B?d0h1NU5Kb013QUVsU3hTZ3B4R2t6NDdOUVRId3ZVRmZtMW1OTWVPelBxMkZH?=
 =?utf-8?B?M0N2OVhnQWlmbHI5aHBJV3Ayd21YVDJrZXoxN1BOUmJocFoyMDJTSFJ5b2dP?=
 =?utf-8?B?VFpRUEtUQ1Z1VERpc1krVmlhaXhwaDZHenAvQmllRk5JQ1JsQ05wQ1pBVzBa?=
 =?utf-8?B?Wm1TTjA4dVNsK2tJUEJ0R3F2ZWFyR3ExNTFOcmJTRXlxZ0JjRUhDeEd6U2F2?=
 =?utf-8?B?MWkxMlVmMXQrZUR1WEVQYk5zeEVMQ0p1MWJVNlZVMkJrdGZuRTd2eG9YcWNM?=
 =?utf-8?B?NXQyL21QVjljYmowUUlnZjJQdm4rYm9OVmQ2d3R6U0psUnQ2SEN4YzlXeFhJ?=
 =?utf-8?B?eFR4Z3dwdks2cjZnelJVWjQ3SmtvQjVYSUVxd05aL2N6OW5iRmdmQnhVNG1B?=
 =?utf-8?B?UGFJdlRMdDNnYnpzT2huM2l3S0NmejBhNHBVdXUwTDZsZG9VdFZ5a01MREsw?=
 =?utf-8?B?MDdRdFovWDFGVVNmazVHbHpqK2d3alVQMTBTZFNvUXdSRk1wcUtxaEQ0dHpL?=
 =?utf-8?B?ZzlpZkVZUFJnY3lsNENSdEZlTDlMNStlUmxJUlVhWnpZOTJrM0NIbTIwMWQx?=
 =?utf-8?B?Uk1adjBqNHNiNm5oZktkTFAyZnhhNTVmWUtZczRpVm53LzBtdU1tZEVENFhL?=
 =?utf-8?B?WXZ5OGc1UnA3MDhITjRpZ1Z5RnRnMEx3Y0pYbGIwU0o4TmJBZEFySStNR2Fq?=
 =?utf-8?B?akg4VmtlWWowK0swYmpnR2xEQnpVMlVSb0Y2bkNyS1FCU0p5WTl4V1JSSk9P?=
 =?utf-8?B?WG40VDhQQTVzY20zMk5UcU9MQzkrYTFKN3cxcG9FN1RmSFVKZVdWNkwrZlVk?=
 =?utf-8?B?YUpPQ3ZwOTJoY0l3OTNsNCs5OEVDTGUxNkhBbFVsN3Z4WXFEWUY4OEQ4UnRE?=
 =?utf-8?B?Ti9IZEw3QldEdjRzejlZOXNoL2ZoKzI3QlJNbzZ3K3pTdkhGUjlIaTFCbi9n?=
 =?utf-8?B?YmpiTjVwSmNQbG9LMFpWUm1ZR0VGZWpkZVlGM2xiRHZwLzZCekFsOVgrL2cv?=
 =?utf-8?B?TXQwejhKOGRXNFN3cVVmdldLSWIxaXhZUkEzWXFNaEJrVnU1aVo4dm93SE9i?=
 =?utf-8?B?c244SFV5SmVHNXBXV0dmWlBiRnFSaFVjL3J4V3VELzEwRlRIbk40dTZkY1Za?=
 =?utf-8?B?dHNQMnk2ZTNhRXFKcnZZaG5aYVVkSUtvazlCRGpxbUFIeGJUN1BkdUVDT2Q4?=
 =?utf-8?B?RjNZZWhCRXJrWnVMZGxnUllPVUxkVlpjUE4wcWhvU3JMaGNsb2NXeTZONC9Q?=
 =?utf-8?B?aTJWYWdDTUFJenEva1FOZVg5bUloYUxWUk1lRmdSRU9WUmI4R2FYK0p2Y3Ny?=
 =?utf-8?B?allWTTd2ZDRVQlhWZ0tlcDRGZnZoZ2ZoZUpPZmsyVlIvR1BDNVJ3Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ca5faf-e3fb-40e8-5c46-08de658dfc7b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:42:43.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkz5KKc8MF5zl7wDLqgNRbahmczr7NPBx3yzNUV5pxgXGm1jGEwsnQhfMujCt3IPXhwIVGROrDEA0/KI9GxKVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42232-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8133FF21D
X-Rspamd-Action: no action

On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
also triggers a reset of the GPUMIX domain, including its ADB400 port.
However, the ADB400 interface must always be placed into power‑down mode
before being reset.

Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
handle dependency ordering. In some corner cases, the GPUMIX power off
sequence is skipped, leaving the ADB400 port active when GPU2D/3D reset.
This causes the GPUMIX ADB400 port to be reset while still active,
leading to unpredictable bus behavior and GPU hangs.

To avoid this, refine the power‑domain control logic so that the GPUMIX
ADB400 port is explicitly powered down and powered up as part of the GPU
power domain on/off sequence. This ensures proper ordering and prevents
incorrect ADB400 reset.

Fixes: 055467378bf1 ("driver core: Enable fw_devlink=rpm by default")
Cc: stable@vger.kernel.org
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Changes in v4:
- Add the Fixes tag
- Link to v3: https://lore.kernel.org/r/20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com

Changes in v3:
- Fix the Suggested-by tag typo
- Link to v2: https://lore.kernel.org/r/20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com

Changes in v2:
- add prefix to patch subject as suggested by Krzysztof
- refine the patch to move the GPUMIX ADB400 into GPU power domain
- Link to v1: https://lore.kernel.org/r/20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com
---
 drivers/pmdomain/imx/gpcv2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index b7cea89140ee8923f32486eab953c0e1a36bf06d..a829f8da5be70d0392276bd135fb7fc1bbf10496 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -165,13 +165,11 @@
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 
-#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
-#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_GPU_HSK_PWRDNACKN		GENMASK(29, 27)
 #define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
 #define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
-#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
-#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_GPU_HSK_PWRDNREQN		GENMASK(11, 9)
 #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
 #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
@@ -794,8 +792,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
 			.map = IMX8MM_GPUMIX_A53_DOMAIN,
-			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
-			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
 		.keep_clocks = true,

---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260113-imx8mm_gpu_power_domain-56c22ce012a1

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>



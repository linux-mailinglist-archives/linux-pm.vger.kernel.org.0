Return-Path: <linux-pm+bounces-19786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B715B9FD873
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51930163DC2
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD507E574;
	Sat, 28 Dec 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PfgY/mha"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D84635;
	Sat, 28 Dec 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348523; cv=fail; b=MHDa+M9BYGIxh4W/Dl11h3Z5DHtuqP1eYFeMRu82lZVz/qfukahjPWIDK13gNSmFGDy89XOl93fiKEh6rtabTK98ADgTee956rwOXtj6Ptdjbkkn4F/CCBYtgXWwSN6GARhbU0XXlYUe8vIxxsANR6Ro3aQ3oOAZPylS4zuOgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348523; c=relaxed/simple;
	bh=KayTLg0Rpss1Xcxxs3o+LQMJcaWZRMXytsYCOw+QzIs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=NWjUDm3KoLCR9RbW8bcaSlY+pNbReNY/GCPw5i+7d7tp13qlypDSSlut/4uq9Tv3KSd1/YxjiUiifqo0UmnLVw3fgSwHpIqizWH4R7G6IMmTdLnNaRqah2rt+7ZtCOqwKEBaEoavMbQjgOOEgPc04r9/dAdTZK30/IWVR9aayCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PfgY/mha; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHL/oecvV+6GyJIW4WP1MleHLGhSkswB8K4fSV4F3yQH+6t3xRQMFmPfXv0e9A7w2nViRVgIdBQmSM5tYB4MKxqtBheZ2pZilnU9No0MmetMDzYn99Ee1jGMgkfzFV8XP5USuaCobzcRT3UTQ5l3q96Nu9/f92Nqe1BMbe1z62iDxc9nRy7Fz9gA2Ly3Mb87kR3B6aKyF7iCdfIW7fmNrTxOJb0xWKhv1o3Fr+di2nZSgLVyousZJ+7eL0XAgC9LSFqu6KeV+/1rVWZC5+XtjFHZvHycNaEiHdiCL1d5mFt1KuwM980jYYjCkRJC7nzrAxOv0nHVq5M6L+/EuRn1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSrHaMAKu4cD6BEf4GE/0e+NMcSLtzqoORvfYtRP5q8=;
 b=bn5l9Eu48gofdn5KiVO63ldNKxHAu3ZexGpevPehbHDNfz7x3JiKjXF1mMENZ/svyOYGszAeesYNwr3hosMTloe5ipmogN0Tth6g2XLZQqaSGgBYj09eNkg/478odSk79lfj8RQBFr0IA555bBUOc+bkaMqC9k+rhlvOd0QI13MAYo3wtzOl6sDhrgfK/hq81GrOE61v5DQFTFvBn14Zww7AhZoazl8M4CX+qIzvXh/ub0Up/egFVY1ZtipSpkamFPhkOtjDHFsAW+EdTBn6afMBJJtmzx6IQ1QNmybPB/qYNpGNbt9yokyOukqn3R+7WfhfNgy8A9wEMt3EP8BvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSrHaMAKu4cD6BEf4GE/0e+NMcSLtzqoORvfYtRP5q8=;
 b=PfgY/mhaL2j7wIkOQRife2wUidD6N+CtYq39SnPQqRGqcsUef5h03IGTA4I7NuWT+h+1g3cbZrzpmvJy4Up5a+JDbeuW1rw1efErhDeEE9fO9OEfImPnRbWTqqZTircAr+9K2R2p4klUQzZwphbMD3Glo9B745ZgmtdDa6BEIMbqRpwIBI750wec3k9iWUXOkF+NFpxm0DgEAMPPdFluZTNCFXuDlUWwb59/NmOnAlxhVbwCNkoKjBfk0yTGFZ4/SjdXG1kUdZeCSHrWWCbhFaZWykxB6mg4hUsNDLfpC5LTPK1C2A93SChZ4fG8LPbqJVkOCqJsHpxHx8+K4GI6tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/12] pm: Introduce devm_pm_set_wake_irq
Date: Sat, 28 Dec 2024 09:14:36 +0800
Message-Id: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxQb2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyNz3fLE7NT4zKJC3SQzixQzA5OUFEsDIyWg8oKi1LTMCrBR0bG1tQB
 /hX0mWgAAAA==
X-Change-ID: 20241227-wake_irq-b68d604dd902
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=2428;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KayTLg0Rpss1Xcxxs3o+LQMJcaWZRMXytsYCOw+QzIs=;
 b=MXcdJkhhjnB1OROKylILiFNT4gm1U7nz3Z+jLd1SkSuZ+537eZVCNCNQgIIujmKSGkGNrC75w
 iaDZij7p0gEC6AElT+fIQ9++x3sBWotIeTImqXFA8P410WyI+toMNBV
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
X-MS-Office365-Filtering-Correlation-Id: 49689c47-6b4b-420b-7c40-08dd26dd142b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0hCQmhDOExxTkUzWWNWVnJUM3JFRzhZSW0ybFdTem42bzBiZFVrSDlLUDFZ?=
 =?utf-8?B?bnArQkNTUWJUZVgrRDhodE5lRWl2QkxZUk83L1JxRjRuMTVwaEVZWk1pMXRH?=
 =?utf-8?B?RlJJeTVHMlpaMXpFTmtTTHc1MjZEOXluWFhqR09SS2dVUkNMTTZtWWIrelY2?=
 =?utf-8?B?OFFETUsrVjBXUEVOREtGY0pLdDcxdjhDS1hLbG5FczRkVVBkRFBhYXpWc1ln?=
 =?utf-8?B?VFp6R3FSOGFQa3lQaTJvM1Q4MTZXWXV4U0cvekgxTnpOdDhncEtXRnhoS21Z?=
 =?utf-8?B?dXU2Z0ZJNmZIZzJiNjRTWkRnRHp3MjdIdnl1d1ZXaHZGYThaY0JaQWlvTzVZ?=
 =?utf-8?B?SWNvQTZhRkdIRkc2SWkrTzh3SXl4YUlRY1FUcDVnTmRHN0FaR1paSFhCVWVn?=
 =?utf-8?B?TzE2TEdEOG4rZ0pSME1DcllGM1hmOTNkNnlHcTJxam9VVFRUaXFiZHU3Nk1x?=
 =?utf-8?B?cFFUdVZVazIwVWwxQXJUR3BIWHhSUExRM0NNMmg1VUVFTUQ2QWswa1JpN2R0?=
 =?utf-8?B?Y1I2YTg2QU9vNXJmd1Y1UnV5TlF4SVRiOFVReFplbXlEUkxNMXZGWEJhdndh?=
 =?utf-8?B?Y1FNTmRNZWhiOXVXRDcyTGdnRFRqaThPNWF3cFE4KzVURjZXWXdvTnpxQVJu?=
 =?utf-8?B?S1l5N1duRUVzZld4NXVjbW15L3ZiaFZ1UkNpcENWdERheVNib3l3SlBWQldm?=
 =?utf-8?B?bUFqb1JKaEFscXRsaHdKNXU1WkRWdENiWEN0RDhrL2dZNWhkeGJnQjVWdmNi?=
 =?utf-8?B?bUZOUFdTQnB4VENvRmMrZlRpc1o4Y2dRRXk3ZE9SNE1kKzcrQzNvQ2UyTnNV?=
 =?utf-8?B?OHJwSjRZZS9sSWdCVUtTbzJ1UDlMMzdCL2xzcVh2VTZ3Y1NKc204UHk4dTZn?=
 =?utf-8?B?TWpqK0pTcTc0OUQyeHRQZFRoT2o5T0NxMys1RXFNUURodG1XVlhETy94WU1o?=
 =?utf-8?B?SjlyVkdOMFRRRjIxcElpa3BzY1VwOUdic24yazA2bk5vSkErV1NlMFBkZmlo?=
 =?utf-8?B?Vng2TWgzRWpQV296Z240SjVIK2prTk16c1MydEtWWUoyYnBsbERQdHMvN0lQ?=
 =?utf-8?B?Z3BMbndTOGhjMXFINUZDd1FMU2xianV6dlhyRVZpUWN1OGN3N3JXOVJ3V3ha?=
 =?utf-8?B?TzN3TWIyY3BNckhOZFpGRmZBTllmZjE2Qzl6bUhzcHlKMktIemN2MFh0M0RD?=
 =?utf-8?B?ZWpOTFFMN3VKNUxsdStyZS9aUWdZaDBPSGgzaTVudVFWR05uNlhESkpkVlRJ?=
 =?utf-8?B?bUVBZzVkMytMcWpNeWcwUURFV3krY3NPckpaSVJ1QkZDWTh0OFI2MTh4dENS?=
 =?utf-8?B?WHBud0xpU0MzMjVuYVVqWUJVSUdDb3YrMGUxQmxqbzlBZW0zeXkwV1JEUHZr?=
 =?utf-8?B?Sm80eWpIcVhGTnRTWTJPM0FyNjlpSFlVMG5RbDVHZDV2SXlYTElMODhlQ1JU?=
 =?utf-8?B?SW9Nd01GVEdMTTZ1Z3NUdGlneXExdllJRlk4dUVwZDM4Z0RkU2wvQjB0SmdR?=
 =?utf-8?B?dThPOVZYTDhjTGxKbFhMaHB5Z0MySGJDM2dGMXYrVGk1RktKbGJLZmRWaDYy?=
 =?utf-8?B?U1lEWFB2bmlCbUh2Q1FrY3NnOGwvYnZFOEUzMVB3SlFJeHZrdlJQK3d3ekZR?=
 =?utf-8?B?ak9WQlhCUWJGTUQ3ZVRsR3Z0NGF0RWVpRVM4NmJHOVh2aGp1VC90UTNENjBU?=
 =?utf-8?B?cGpxZlBwc1daVm1GTFJVd09iQ3Zwemc5Y0l1SEZFSjE3VDloU1BsM0dQeW0y?=
 =?utf-8?B?NCtISkFqaVA3N3hKb1JnVnpEc2RKaHBlejVKTUFwNmpsa0FrZXgyWFUzcEFa?=
 =?utf-8?B?T3ppNi8xbUJtdDl6dEVBcEFjbGJwWEczUndMdlZxVS9kWFFNc0tOamRzQ2ZG?=
 =?utf-8?B?L2JUdms5V3hGNkgxR0dVUllMVGJkcjV3SnhmUUw3dzc5OTMwZ1Y2R3c5NlFz?=
 =?utf-8?B?RGt2NUpSZjVyU1lNa09janJBcEJCTlhSSktBTGxUaDRrL1JkVUgxdXJzZEMy?=
 =?utf-8?Q?+vjuqmO5X0Zav3BRg8wijQKk5IldMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTNrMS9qTkpFM0JTekJHbEtieWQ2U0pPaFhCdU9TM1VEOTlZTG0xVlUxbjJs?=
 =?utf-8?B?bjEvNVBsWWJpMFhyRGhRTVlLTTY5TEplNWhjTnNoOTdrb3ZDTW5pd2JxYVpG?=
 =?utf-8?B?ajFleHEyczl0TGJCZ2w3STJSRjdlc3FxYWFPQnBZYWY3UndXZzNtdVh6NzZD?=
 =?utf-8?B?UC9BcEFQSm44djJiRDJkZ2syZTlxVnhlcDRyYW5EcmdWNGxOVE9DTTFSSU9E?=
 =?utf-8?B?TVl0SVVzWE1GeEVSdjNDM3gyMUlEUEp6b3hWNEI5cXBXdEI3RGlNbFNibEFu?=
 =?utf-8?B?Nm13amtrbC9qZ250dE51VGdOYXQ2bXMwWGdNWWRzUHMrQy9uNnlLUG9tcWky?=
 =?utf-8?B?bzVVR0dJUXZnRkhiTE9QWjg2TTdneC9CMUluNEVRWnpRZEQ4Mnp1ZjU0UWJQ?=
 =?utf-8?B?a0hwdjBtUm8rcnZIaXpxZjd6NDZjbHNFdDdyMk9MYzhEVCthOTNqQ29GTFpl?=
 =?utf-8?B?ZEVFZHZNclhuZ1djSHVXQmE2MGxjQ014T2UrbDFZZTVwOHJtTk1xV0NmcWM4?=
 =?utf-8?B?OGhhdktQL3dLMEllV2lLbkxDWHI1UWZna0swU2FZREZBU1hTMkE1bWFJYmJQ?=
 =?utf-8?B?OTJCNWpFeW9uQU51NWM3V3dVZXlXVU1naTVjczdqU1ovSmIzRk9FUkkwRjBI?=
 =?utf-8?B?RTE2bEJsQU9JQjVEOS93aDlrSnJrN1BDZ0ViZTNoVEtaNzJnbktHaGN1akVW?=
 =?utf-8?B?WElOOUJCU3R1eTNtUEpBUWw4WmZWNmtJSjdtemROcmhOd3FsT2Vkd0Q2a3V2?=
 =?utf-8?B?elFTNTE2bXZyd1BFRFRwZlowQW90SXVVU1hGOFYzOE1DaURaS25oL2tOQW5M?=
 =?utf-8?B?RXdZRFFwNGlCdDNkbTNhTnVUN2wwTnlFbGU2YnFSUWMvSDh0bDV3SmEzelNn?=
 =?utf-8?B?UU42L0ZTZFFBUGFCU3FQdU15d1kxSVJucGZXdnFiREdKVEJyTUJGRmczUmda?=
 =?utf-8?B?Qk9vRzdTQTJjZngwUDJSdmZTbG1yd1N0NXY3OFBZR3doTnNNWlRBSUpablJp?=
 =?utf-8?B?ajFZTEgxU1pUQ05UY0tmZHFGZEwzbGlrSzhyQnRtN3BWdDlVN2dldVpNeWo3?=
 =?utf-8?B?VTdTUlJ5Sjgzc3d2aUdsV0FINFc0QUlFbnkwNlVqWnJQR1BONXZNZC93WVRn?=
 =?utf-8?B?OVlxMVlNK2JrbVltTzI2Y3JTOXhIVGljNENEK1NxODY5aXZrZ1czais4L1RP?=
 =?utf-8?B?K2dFUkhKTjVHUnlPd3dxMnMzVHo0NGFOTXVnamR6M0ZnNm9Fc1N0VkhOdHV2?=
 =?utf-8?B?WHp4amZOOEZPMmM4ZUpOUEZheWpKMVpEaEkxWWEyQmpWcU1zVG9TUGk0Rlpw?=
 =?utf-8?B?RzVuSUpmUWE0OWJ2eGlma3cvVk9yeXZJZUEwb2YxZC9WRmZlRXZyTlJtM04x?=
 =?utf-8?B?TWM3dGtiUzcycjZZOHJVS29pNFpaSGI4cytXbG5FdTQyZ2JSR0xUVDBJUkE1?=
 =?utf-8?B?UW96Zy95M2tDRkM0U3hmRi9mM2YvdU9qbm96VVJQZlpmL3d0QW1yOUNNMEpH?=
 =?utf-8?B?cFdRR1NtbDRVWWhLb3pMVVdXdVJvYXNOSndqVXhOaHpjSG1iVk0zRlJUdXdP?=
 =?utf-8?B?amE3cmkzbmhTcDFQZnQ4THlUSmlJTXFvN01oWUhSRFp3R3RMT0VQTWV5Nm9T?=
 =?utf-8?B?R3cvM2xERVdCYnVvenhTbVQyVGRlUG1KaCtoMEp4eXlMWm5PMVJuUFF5R2ls?=
 =?utf-8?B?SFY1VGNjditVQWRwY2tGbkJSRmJ2NU81UmlLMFNsSjRhSWx2UjFma0hmVWF1?=
 =?utf-8?B?UTJWWTVzUjE3Skg2T3dEYzRhMjNXR1E2UHZHYXhGeWRHUkh5TXpNTE9kbUxy?=
 =?utf-8?B?QU1vdG42T1l5cXhKNUtJaWc4bEhJNXNQTEVhSEU3LzJZdWpsMXRERFJER2dI?=
 =?utf-8?B?YU5sd0REQ21UQkRFNk1QYmVrK0NqaEtYcytHYms4NmdSdnN3ZUF1UjJsU2VL?=
 =?utf-8?B?Smt6akhCNklsNSsvTmVObml6dURaTHNzQk8zQnV2SmNvS3VyMytHM21mTURq?=
 =?utf-8?B?ZUR3YlpDS29BcnF2bkRoelUraXRxbmdwa0RIV3NOZndHY0xJVHg5UGVxTWR5?=
 =?utf-8?B?dHNOWFlDc3JBVEZSZ3RJWmlxdzcwV25Wb293U05yL3NKNFZocDhuRUhCU1ND?=
 =?utf-8?Q?/254HgjXQAZIUM6e5IqYc8fzs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49689c47-6b4b-420b-7c40-08dd26dd142b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:12.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqF/j5NVvH8yDgg/B7nZKR+p3VvW391XVJqGmOr4eJxRdLbSfW6kZbtBvYIAR1jMQpSUX9LCW7WL7cliIFYpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

This was a retry to address [1][2], to let common code handle
dev_pm_clear_wake_irq. Then no need to call dev_pm_clear_wake_irq
in each driver.remove() hook and error handling path.

In this patchset, I include input and rtc patches to show the usage
to avoid that introducing an API without users. There are still
other places using dev_pm_clear_wake_irq. If this patchset is
good for you, I could start to clean up other drivers such as mmc and
etc.

[1] https://lore.kernel.org/all/20241111092131.1693319-1-peng.fan@oss.nxp.com/
[2] https://lore.kernel.org/all/ZymxvLMkkktRoCXZ@google.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (12):
      PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq
      input: keyboard: ep93xx_keypad: Use devm_pm_set_wake_irq
      input: keyboard: omap4_keypad: Use devm_pm_set_wake_irq
      input: misc: nxp-bbnsm-pwrkey: Use resource managed API to simplify code
      input: touchscreen: ti_am335x_tsc: Use resource managed API to simplify code
      rtc: stm32: Use resource managed API to simplify code
      rtc: nxp-bbnsm: Use resource managed API to simplify code
      rtc: ds1343: Use devm_pm_set_wake_irq
      rtc: pm8xxx: Use devm_pm_set_wake_irq
      rtc: ab8500: Use resource managed API to simplify code
      rtc: mpfs: Use devm_pm_set_wake_irq
      rtc: pl031: Use resource managed API to simplify code

 drivers/base/power/wakeirq.c              | 25 ++++++++++++++++++
 drivers/input/keyboard/ep93xx_keypad.c    |  8 +-----
 drivers/input/keyboard/omap4-keypad.c     |  8 +-----
 drivers/input/misc/nxp-bbnsm-pwrkey.c     | 15 ++++-------
 drivers/input/touchscreen/ti_am335x_tsc.c | 43 ++++++++++---------------------
 drivers/rtc/rtc-ab8500.c                  | 11 ++------
 drivers/rtc/rtc-ds1343.c                  |  8 +-----
 drivers/rtc/rtc-mpfs.c                    |  8 +-----
 drivers/rtc/rtc-nxp-bbnsm.c               | 29 +++++++--------------
 drivers/rtc/rtc-pl031.c                   |  6 ++---
 drivers/rtc/rtc-pm8xxx.c                  | 12 +--------
 drivers/rtc/rtc-stm32.c                   | 10 ++-----
 include/linux/pm_wakeirq.h                |  6 +++++
 13 files changed, 70 insertions(+), 119 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241227-wake_irq-b68d604dd902

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>



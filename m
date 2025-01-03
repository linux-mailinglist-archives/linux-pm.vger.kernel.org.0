Return-Path: <linux-pm+bounces-19930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2CA0060A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8EF7A1D45
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28F1D5AA1;
	Fri,  3 Jan 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UzqqZG2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D891D517B;
	Fri,  3 Jan 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893753; cv=fail; b=PHN0XOAClWZ3bYX6kw/Oupc6DcCqfIiZfppwBEYyhLan7zq0GRwUac3De5f7l1Pbkk3lqIs4Wi3wySnd4inZaSKqHVBfvKn232sCbey9qqlZfeY5u3suZ2RzeMJ57+7Tobhn/beXnSyLg2dyvVfeVuEYZOZy43xsN6/D4GnHm1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893753; c=relaxed/simple;
	bh=yGvaO4CE8KR0YjpwnelDEdIH1YkR2FTo1uOdpptvhd8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N/YLCrXoLCC72PxrBP8p1BZ7//UH3hpMcZ5mUdAFbXX/K4LuIV8RbUAh0DqDk1PECv4GdnkiOVGgJVB4/zgRTEHOWxTuYTSresJRCwpPdmnHUXhlSd5Lvhd9/ziCyWCz2VoEWZBI4XWCkzXVBwy5pifPghgllEPYb3TdGohJFpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UzqqZG2w; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTjwbQU3kUsgvzGcCD3VBqY2J7+BYx7ckbBrgQCKX+8MCj4X1a9RY8hOfmcN6omDNc9dx7rkF6rW2WmFfHM17xCxijcq3wFIgaOP134Jw0iSq6AczjgMveuzdPVKhf/71t19EDZyZ0DkElxwZVKlNy0/6mnk6lqZoX1ZemSBS+awWHDm91jFYlzRTFR2Krru2dWN59MvKP9FCjN9ySWBwoBPhgdE3Ti0sPm/WmQLmDw8aUfbF4IOvUkuXX9/4Ubu9bXQkPfvKZaasHMOkCPlFWsUo7sbj0s3o6dfy3bSAyANcjKbbV65rAIcklpHxH33NeQDb1317If6DAVfMMv85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhC1ngrU87eDqzUYVlj3esO6y93gVDOOhc8DDXGyy0w=;
 b=PI5ZGczYPQLrL1jP2Od5JiZSEG4FLCVBKFOubqTgMlA1agtGr2CVKGLY9KyvNKi52XuxpJgG4QgLzErtuxvUZaAzWJE9twsYiOB5f8e33OPVbCRbvl71DRiZaPJ5uGQ+P53+upzoqL2oKDhZ/j+7PInt11xgVAh15NUprJH1aUzl7L3wWrE+RscKj9NMtWwZyoYUO2kGUNRUS5lyLE2m5ddM+hUBmwy+n5D9ITlnzgcxcw4TBspE0pvck2e/kfd0FXj4bGjK0PwBPXjQPKSwQoP0j4kl8Zf6WCQeFrrNSFuxnT5b2XgA/m2sTdBEeU2f7hrwfiPrpUWefQ1elDz0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhC1ngrU87eDqzUYVlj3esO6y93gVDOOhc8DDXGyy0w=;
 b=UzqqZG2wt7u3GOyLoPgZRvDb0RQGwAtCgwI1vmNZKRVjTpo07sVTFJns9v27st1R4idAwSHngrXtsOL9vq82o2EP5W0/YJHFEhVRib4EJrPLYim81mGqel+8asUavjxbSg48gJC+z/KqbKudGA/JvroHDHLYfXT9njob8Gj/rU5L9Mwnlg+nIfwfUe2EJh/2hwm/tRM3Onpq50VydBl7g6oKGgGgXO+q3Z8E5W34sIh4hTnQ5VODrj4xaRD4DgtMLO4yXmQUJzH1L1gznzVHXd/cxEz76fRbEfDEwGPHMB7QH3txBc3GftkX2byH6R/2ovO+igebHQO4pFZUytQCCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:17 +0800
Subject: [PATCH v2 05/12] input: touchscreen: ti_am335x_tsc: Use resource
 managed API to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-5-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=3411;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1lZmp/EoQtZDgK9cRNpEHi0IbcGjqZ+/tYP3nl5MGB4=;
 b=d+ynM2f+87jzy29uH2AmtGEhWDRO9UQf3P+P0Uubu3afIPgRsDzhnXyS3RMl2g4FSX1MqPgcH
 dHCQMbcmHz7ChbsmlULhgPAwEhZEjpD+rfpLGpCbGI27Ef2eX0u0yKJ
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
X-MS-Office365-Filtering-Correlation-Id: 5e97a831-88b6-49cf-1515-08dd2bd28b28
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXRBVVlIN2FIRVJvODUvTkp2TWFmeDlZQm91UVV1SFBMK3hHcWFEVXg0Zk9z?=
 =?utf-8?B?V0Q0eXNlallvZ1owc1duNEtjMzRyVWQ2MFY5dnRYYXVXWStTam40UXRPdnpj?=
 =?utf-8?B?MHd6QjY1THlEbHBVWHoyUHJzL2kzWEprcmdKVTRqdmY3TEhCSTFBandtUFpm?=
 =?utf-8?B?RzBJRkp0RDM5TU9jV1AxcE4ycEhzb2UyR3AwZzB2c3JkRGZGOWZxYzNzaHYw?=
 =?utf-8?B?NEZIK2poQ3I1cDJsQW00YmFZQlVIdTl6QlZjQmNGOHNtYVRhSjRvZjJGOGEv?=
 =?utf-8?B?SUw1WWNoaEpZcTM0TFBPSlREVjVoakRUS3ZnMzRuQjdsMmRzc2JlenUxZW5K?=
 =?utf-8?B?VndIR1RNejdRMjJvNktFTmRRQk4yWEU5NmxTcmhnb25JY3ZTMk92SmZFcXV3?=
 =?utf-8?B?dHpjSjluZGxBTWoyNW9SL05XU2hkdXZGcWNvV21aSUpEaEUzc3hYSlpDcnBw?=
 =?utf-8?B?RktzWGFZZUkwUXg1dStHV2E0L2lQeWo0RVdib2pUWWhHNEQzd053YTg0QjNY?=
 =?utf-8?B?cUNld2hBYkxoZXpleEQ3OFJKVTA0V2xUdlBrWjdwTVRGYXBFZjJjU21BRkV0?=
 =?utf-8?B?UFpRQjY3YnlpNENrek1BYVNlSldxbVBOSkMwS25WeGpEcGRuc01lRG43Uy93?=
 =?utf-8?B?a1cxMnVCb2FBK1pnbXF1dWdGL29iQnQ4RitYdnV2bmYyNkhRZXlBSHdWaENC?=
 =?utf-8?B?Y054VHJHYm1sbWp0N3hLQ1lZanJFTEhUSlZoZW15U1BDVVdSUGVHbnJETXZO?=
 =?utf-8?B?ekVOamRDZCs5SXRqakQyMTdUN3JMMml5aWhGZEY2dFYvNHZBWTRXY0piU3ZZ?=
 =?utf-8?B?WHNBRVNMWUU4ekxDV2tOdG1zUVhuOHdId2pmNmRtbGZzUjF6NzdQUmpoTG0v?=
 =?utf-8?B?VmptOVFQa1IyZ2lOZzJ1NTlBUVp6WkU3ZHg1MTEwWkUwQUxGaWZFSm1CRkNp?=
 =?utf-8?B?c1V1TkJQdE0xTk5WZWRXak5NcDhHUnJFdDNQZjNmZzFSd0xXTjN4RVI2ejha?=
 =?utf-8?B?cTBQa21uZlprOEgzVnROSElyNDJuVzA1bFJCUGVLdlJidEZCaUJaYWg5QXVw?=
 =?utf-8?B?TG1TMk9yeVNod2tRMXh3T1krb2FCdHprdnRCbzdLaDU1bWdKV1Bla1hRUDhV?=
 =?utf-8?B?dEdqcFFTQUY0Z1N6UnowU1FUY1hZYlhKcXAxelRaRFlNa2pPU1NNbzk1T1Fp?=
 =?utf-8?B?V2xWRmNJOG43VTJqdHNCcjN6SEdYSmtOb25RWE5MQ3FKWXlrNHZ3ZDJCQjdY?=
 =?utf-8?B?eUpVR2dTRS93dm9GZTdSRzRxMTVtdnl3dEhRcStUQW83ZHdySGVNYmc1N2dm?=
 =?utf-8?B?SnRQUHBOQTg0aDMxYk1zVlJJMGJTSDErVmNMZDU1WkpEc1dWTUIxcWdCTW5i?=
 =?utf-8?B?UVB0eFNTckR2RXFRVHE4Z0p2bjVJUmNtTzN6Smg2MUhOWmVtYU5ScnNRbXAw?=
 =?utf-8?B?bDhnQWl4dFcxQUF0YysxbDFXNDIyWUpaT0xhYTBpTFlsMVJjN0k2ZXBxTVlk?=
 =?utf-8?B?elJVL1BNNkU3STFJNWlXcDFwdEVJbmI1b1BjN1p2T3RneSswR2traVpHNWs2?=
 =?utf-8?B?MDZCS1p4SnJZZXEwV21QRE1VUEIvczZ0Q3cwVHNKWnJoeStiTU95NTdXMHhM?=
 =?utf-8?B?emlneXcyeHlKSmhBdnJtZnJLVlhQRTFoUzRnRENRYTNLcXdSeE9QRElyakp5?=
 =?utf-8?B?WXFhMWVPMkZZWUV6MlJteGU1KzM2YlMweDdQU3hFRHpQNkpRZ2I0T254K1Zx?=
 =?utf-8?B?VUhqVXBxYTFxUTdSZWd5Z2pGd0lISDNJOS9aSVNMZ1hDMk94dTJSbXpBdzkx?=
 =?utf-8?B?ZFFmZWgrZ2FqY1dGZFRjWVRGRXorY244ZEM4OTEzNlZGTUhzZXh6VHhhNSt3?=
 =?utf-8?B?d2VPQkU5MWVENHVJZzRGaCtnVXNXYTd3Unc0S0RoZzRKbEV6ekNmV3lVNWNr?=
 =?utf-8?B?MHh5MGZMdVpMMXVsR3RhRkVsQ3lZZU44OWhGU1lUZmIwVFRTU0Q2MHplcnFk?=
 =?utf-8?B?anZPTFM1ZFh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1FnYlJVd2UrUjlpc3prd0pGZ3BzZmZwL3Z2Y3ZNaytCVi9ITWJRMTBXOVVD?=
 =?utf-8?B?WnY2Z084bkYyNzFvSDBjNiswbkNDYWFSZ1RLN3RxSHIweXk1cXBaZkczUzNC?=
 =?utf-8?B?ZmN3RUNpYm53ZmJHT0JFbnYxVDZvVndkbzlaL3pXTWtHYTh4MTVQQ3YycTZn?=
 =?utf-8?B?enlQVjNMQzJuMnkxV3JBMGhGY3cxWkhCUWxqSkhsNWpXWUJyM3BRTVpmSWk5?=
 =?utf-8?B?VkRBM0V4bzNkbDN3d3kwa0ZXUHk2WVgrM2xBZHVvcktCWUFGcmFwc2NtRGY3?=
 =?utf-8?B?WnhQVGV4dXI0MHpYRmhxQzZ4TmdtVUpibGloS0xDbDIyNkNHR1N1OGIydytv?=
 =?utf-8?B?VXVSMUhxMUZQTjdPVUZlOFY5c1R6Qi8rdjVaRDVVaDNFUU05NUI0NFlDOXBP?=
 =?utf-8?B?V2RreUM2UU5wQi9yU1VWWnlOK3M3VTRLNzcwM2REbjRvMHpXOE9SMTVwcWpS?=
 =?utf-8?B?ZVkwZEpYNlZIK3E4MEJFUWdjb0tsa3NyeWQ2NENPQVZ3elZrOEk2QkI5YzRW?=
 =?utf-8?B?bXY4czdQZTRLZk5tdHhVOEcvSW9kWEtWb2FPMnBUMXBVZDBtVTgzYytjWDZh?=
 =?utf-8?B?SldQNEVlYzdLeGhycGxZMkJ3MzQrakR4L2cyK0QxbVNRVDF4TlRZZUd0K0Z2?=
 =?utf-8?B?ZEoycGNWMWFPWW00dVZTdzQ5ZUQ0QnpsRXJLY2FYSm1MZHZvQUY5R2VTcXRT?=
 =?utf-8?B?ZzdZamlud3ZUNEdSTHBvTHZXNDBOeWd4cGFKTXdHdWYwOStiaFM5Mm9vNnQy?=
 =?utf-8?B?UlBYTzBqSWw3c1ovTFE4R0Zqd3FXMjJ3UXJvbFd1d2ZNMktsSkxwL3hSUW5R?=
 =?utf-8?B?SkJ3cHNSYXBjbVYyOGRtODZPdU14WEUraHpZcnZjenhGVnczSU1sY2k2dkZm?=
 =?utf-8?B?QkZUYjJzWVlQc1JFT1Z4bWtUWHkxdi96VWZNWDBDSEkrUmlQakU4eWpIRmdv?=
 =?utf-8?B?UEpyb2J2elVsZlhQTExINkJVVzJ2cFcxYkFFcWlZQk8vNitIaEY5VjNSdVlM?=
 =?utf-8?B?eXQ3VkM3dzZYSWVlMUdSUzZVVW9nWmo1SUxMY1oxUnpHY3J1YTJSVHpMYmVh?=
 =?utf-8?B?RDduRFVCdkwrNmdVeVRpMURBZFRDNnYvdUNoV2JLNEw1bjNhdUNndThLNUVM?=
 =?utf-8?B?Q2lOcWR2TE1ibUJtZllJUHRkd1dIeFZ2Z3VGTzh2VFBta3JWWmRKMTBKR3ZD?=
 =?utf-8?B?Y1FRTVpzb2lxU0hXb2t0dVV4cG05VVYrN3V1V2tuUGdib1N0TXQrdldCZ1Z1?=
 =?utf-8?B?QnFLdkZwdll0UTRhMi83Wk1zc2dvekFVMEw3cS9zRE12bFVwWW0zNU51VDdr?=
 =?utf-8?B?NWs2UHhOMGtZR2hnVWc3VnQwNk5aU1BJTkRTRFpROVA3alZMWmIxMnAzRVA3?=
 =?utf-8?B?eE1RUUVCVnFKVUlib2JhMHl4OUhJRUVhWG9QSFNweGJRNFREUy9IbzJXQ2sy?=
 =?utf-8?B?QURnbVluTFFFckZzRFpXSDhJR2xqdTZ1NC9MVFZCZXhZdk03bGFOWWR2UlVF?=
 =?utf-8?B?S0NSbC83Qi9RUFhEcHZ4cmxkbTZyOXlweHlmcEJvb3ptbTF5TWxLOXh2NUZm?=
 =?utf-8?B?SHBIZ1VIbEtRUmc5eWlza253cmJrN0lsNFJac1RZUmlOU2xocTFxc1E0MW1O?=
 =?utf-8?B?elFxcWp0ZGNTOUVKQmh4WkxHM3ZCS21heTZWejdKak1zbHp5WWlkajZyVkJy?=
 =?utf-8?B?T2k4dENGRGJYRk5BZDFNY1p6TysvanN1ak1tOHowUjZqbW85MUcrUzdidmRu?=
 =?utf-8?B?alpSd1BCakZlY01sOUM3c2ZHZzVUaUg3RmNXY2dEYXNXcisraDJHa2ZGcWtS?=
 =?utf-8?B?VkhweGZjdEoyck9kUVpWaHdhYUtkY1U0VVF6cDNGRm1lTGtEV1BCam9WYjIz?=
 =?utf-8?B?SjE4aWhvZHF0VUFMQklFdkkzaUhuZlV5b0hEdUNXU3hPMTdhcHRndFJhYWd1?=
 =?utf-8?B?MWJ6Q2ZlbVRtRkIvVVBMMUQ2blgzK3oyNjJ2Znl6aWVGY3kvdE5SNTUzNFdB?=
 =?utf-8?B?NzFaZTJGdFRVN3pMdlJEdDM3VU9ZQWIraVEyVVhheDlqZFIwc0tuYnYxanVC?=
 =?utf-8?B?L2pyWC9QRllZR2JtWjJ1bi9oczlCNHVGMUdyN2hjSTNPbjhJZDFTcDVXVkVn?=
 =?utf-8?Q?Fesh6f/bd0vOvy640lF2SRgqu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e97a831-88b6-49cf-1515-08dd2bd28b28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:23.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y76hL7eWCAXZ4d7JTo9bVzePVFX0j2fzFAQMsLIZQ5JQTBOPaaIewcvUe031gS25x5U7dcSyP+9f+TbdD/EjpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

From: Peng Fan <peng.fan@nxp.com>

Use devm_input_allocate_device/devm_kzalloc/devm_request_irq to simplify
code

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 43 ++++++++++---------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 93d659ff90aa94ecbd7000fe05e0eef8ab3546ba..aef38b2e4e464e3b76395de5991a0f41b4f852f4 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -418,12 +418,11 @@ static int titsc_probe(struct platform_device *pdev)
 	int err;
 
 	/* Allocate memory for device */
-	ts_dev = kzalloc(sizeof(*ts_dev), GFP_KERNEL);
-	input_dev = input_allocate_device();
+	ts_dev = devm_kzalloc(&pdev->dev, sizeof(*ts_dev), GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!ts_dev || !input_dev) {
 		dev_err(&pdev->dev, "failed to allocate memory.\n");
-		err = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	tscadc_dev->tsc = ts_dev;
@@ -435,18 +434,21 @@ static int titsc_probe(struct platform_device *pdev)
 	err = titsc_parse_dt(pdev, ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
-		goto err_free_mem;
+		return err;
 	}
 
-	err = request_irq(ts_dev->irq, titsc_irq,
-			  IRQF_SHARED, pdev->dev.driver->name, ts_dev);
+	err = devm_request_irq(&pdev->dev, ts_dev->irq, titsc_irq, IRQF_SHARED,
+			       pdev->dev.driver->name, ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to allocate irq.\n");
-		goto err_free_mem;
+		return err;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-	err = dev_pm_set_wake_irq(&pdev->dev, ts_dev->irq);
+	err = devm_device_init_wakeup(&pdev->dev);
+	if (err)
+		dev_err(&pdev->dev, "device init wakeup failed.\n");
+
+	err = devm_pm_set_wake_irq(&pdev->dev, ts_dev->irq);
 	if (err)
 		dev_err(&pdev->dev, "irq wake enable failed.\n");
 
@@ -456,7 +458,7 @@ static int titsc_probe(struct platform_device *pdev)
 	err = titsc_config_wires(ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "wrong i/p wire configuration\n");
-		goto err_free_irq;
+		return err;
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
@@ -475,19 +477,10 @@ static int titsc_probe(struct platform_device *pdev)
 	/* register to the input system */
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_free_irq;
+		return err;
 
 	platform_set_drvdata(pdev, ts_dev);
 	return 0;
-
-err_free_irq:
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-	free_irq(ts_dev->irq, ts_dev);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(ts_dev);
-	return err;
 }
 
 static void titsc_remove(struct platform_device *pdev)
@@ -495,18 +488,10 @@ static void titsc_remove(struct platform_device *pdev)
 	struct titsc *ts_dev = platform_get_drvdata(pdev);
 	u32 steps;
 
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-	free_irq(ts_dev->irq, ts_dev);
-
 	/* total steps followed by the enable mask */
 	steps = 2 * ts_dev->coordinate_readouts + 2;
 	steps = (1 << steps) - 1;
 	am335x_tsc_se_clr(ts_dev->mfd_tscadc, steps);
-
-	input_unregister_device(ts_dev->input);
-
-	kfree(ts_dev);
 }
 
 static int titsc_suspend(struct device *dev)

-- 
2.37.1



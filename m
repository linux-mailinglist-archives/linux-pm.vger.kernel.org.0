Return-Path: <linux-pm+bounces-19791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41399FD898
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A982E7A2392
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5235038389;
	Sat, 28 Dec 2024 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cA98UbwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983C35956;
	Sat, 28 Dec 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348548; cv=fail; b=Q+B6q0F3sPxuWUGna5yA8UGcz8JILMHePJ17aAj8gma8WuZH1HQixRie58wiGR7jrvx/cbFV/tHArjdHmpCcdUa+sYFvdfoBPO7cqiKFoxsHb5CYqfzYOS6VRoIRRBPpMxXhjdejA73XSvTAq4njo2Q7pzlhq2NvIlGeer8YoeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348548; c=relaxed/simple;
	bh=yGvaO4CE8KR0YjpwnelDEdIH1YkR2FTo1uOdpptvhd8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g6+Ea6s4UiRoH/ehMhV6cubgcXQCh+oL0zOuTGobSiPaedv2zaKw0RenL/9HgbBfwCjz7rRb2BQUAs++7I96VKHVjW90wkQ/bQGu0HUMz8CUbk4oiRwnJmajPkOkqB91Kr8aqrwss8VUbft3BJlOcBBxwIQTGy5rWCWJMLA6LnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cA98UbwE; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/G8BdliSEHx0Q3RhzvHHb4gZDm7nd8U9oyXzHd55Bb4fFKPUAXiMIEYSbuoOtbEdxG0JouEjRZwG3JSzXWYa2OV8J7Gk7+ZQEc5QSYGTDhlk/iMuumAOLuZKALhA0NY7/vvhvFG9E6J3RvOK4CuJX3ub30pcS5j/pJ+/Y64//MDlyaIPcQBdnYWvKbUKXgnYTanlVTNlau9EHKhC7TeeMe22obWcNCu3BzioLHeUiM/sp/w63EIU2byRUTDWY+fJKY/LlUU+wApDaFlHP+nNCJEog4poH3eW2luSbXdaP6qc6Vugkx1/OxtRQRh7JKKZ0RH0vyoKxBye26eqhkfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhC1ngrU87eDqzUYVlj3esO6y93gVDOOhc8DDXGyy0w=;
 b=hk8K3Ny6SJcd0oB5CBOmWwUHHYSFPOGMqZiLcSj4I6HIJ+mcVCcEqb2DNKWFrSxsg7MMPlW61S33HVlo8RrKXGhCO9GwYVzE0A8XaLTvuQ+m8ZqiGaIGQ/yauGtSQnN/DAMwxLNLBBbINirOoVBiTvHRX76wXszoypYB9oXLr8Qoe+IkInF7d++7eIU+FWvjTGqnCZ/PlMwd9/Ictqn30TqOvEahUoVBpz+fE2FRcN6Xiyfb/LbtdEagShvRYexD4Fz290E6bv++FkNSGfaA5yzw6nBOxYf8o2junUS+Zuv1dzaDMA3UGJvOzUekw6rxYmqWFeYH+AM4tNyv9GqWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhC1ngrU87eDqzUYVlj3esO6y93gVDOOhc8DDXGyy0w=;
 b=cA98UbwEXYy8AaaZCydgYBXUee5xD9rfXQc112Cwt1t46qevMbnGdlyXYxRiyqTMQbRks6yg33cY6oRN6OZESXv4Z+UGTxs66IztXA5iJyQcha86e84XoulwQtFDFqX9GKkq/7PtytAXgXZrhq64S9OFDvN/pYkiXy/+UFZxRnn4iYFMtV30o/1nqulxuWT+7Qeh1jm11T5WQEkaAAEbCtpmWu5IoJ2LQ5YtVblKRfhUc2WZVeYf+1uHerV0p6xCz1jqP1kcSNKhMaQfuHAdumfibwaUDVvTFp91/OEDHehZVmG52FqQ2QrVjS3KMz11Yio0UUsa/IYPVgyu5Isx5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:41 +0800
Subject: [PATCH 05/12] input: touchscreen: ti_am335x_tsc: Use resource
 managed API to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-5-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=3411;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1lZmp/EoQtZDgK9cRNpEHi0IbcGjqZ+/tYP3nl5MGB4=;
 b=UXvCXFxS0bdNfnP4i9+l23yI6Hpv7q0/4Axzg63Hm6BI7CWYSX2VuRHQZESo9FnGhA2gXLlZK
 2S8tSKbe6vRDK3wAMDYcuopjwFCx/eXV4VwLcGndSqEbmeNg5AVJ4EE
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
X-MS-Office365-Filtering-Correlation-Id: 441ceda9-a42a-4473-1f83-08dd26dd2404
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWhXcWdxdzZWOUVhdjgxOTB0SFlBaHFKVklxVEw0amhEVE01Nzc4N2V6alh5?=
 =?utf-8?B?R2N6VnFnaFFtbERwTDhtamJTOS9tN0lrYU9LSHJleDVJM3AxbitlWVdlSCtX?=
 =?utf-8?B?V2VnQlE4OWF1RE93U0ZOTms4ZTlzT213RFY4enNrVGZ6NWNDeFRYa1hTNzRG?=
 =?utf-8?B?TkR6M0FGamVyK0tpUUVTTjk5bHRsMVZFMzhvM0pZQWJQTFZGeUdOSGhqcUJa?=
 =?utf-8?B?TWpLeFAweW5kWk1BQm9mbUg4M1hGczNLYms0R2YwNXFscElXZWhRWURudEVZ?=
 =?utf-8?B?eDFjMGw5TTlYVlFJbEh5enVNRWRxRHp0N3d1Y3AzSHJrNG9rN1BHVmNUWlFu?=
 =?utf-8?B?WHM0cjMzems5b3ZHbldLWWFHN09raGhZM1pUVzZnTGtFR200T21WZ0lPL2J5?=
 =?utf-8?B?eHZJUWdvbFNrRWF5eXV2RzlnVkxyWUd6VjJlT0lHNmkraEQ3dmc4UlR2RkVM?=
 =?utf-8?B?em5wTGdZQkFKNm9iMU53MFFEbVkzS1ZEMEJCN2daNkF2WlI2bWd0YmlQdVIx?=
 =?utf-8?B?OEpyTkJNVC9VQ2lhUFlXSU4yWlBjcE1xNDFNSXRjUUY1SGNpd0IzYmFYOUZw?=
 =?utf-8?B?SmM1N2dCMng1QmNDMnpibHZrV2hYc3FuSVhiM3EyU0ErbFAvcjBCcGVEUkxF?=
 =?utf-8?B?WUlsYXRrU3VkNGlKMzJkTEI0UFUyejJQRnFjVi80VlJvOVBzV0dueExjNnR1?=
 =?utf-8?B?bURXbGVFUjNHU2dXYThXWGhqWWM1Q3c0cUdGcWkzN1JkWTBmZUFJVTNrZVVh?=
 =?utf-8?B?c05ZbDhCZDZoaU4zQzVXcVVLSlFNOU9jSjR3eHBoV0JodnpRamZ5UHJRNWJs?=
 =?utf-8?B?a3doMThaZmxHUThPdGxicWFDc1hscW0zT3YrMi9QU29WN2lSMklPS0wwbC9D?=
 =?utf-8?B?MU9EZE1ZUk5nN0N2Mjd6ZkdkdTFseXVtS05ETVcrK1B1NFdXa09YcjZiRWtl?=
 =?utf-8?B?V2VIcGFndy9UYVI0QUQzSklMT2UyOUVXN1lUUjZzaEtvdEcvUWFhSTNERkFS?=
 =?utf-8?B?MlNjbXE0V2ZVc043Zkx6TnExWXpTMEtKR2t6L0t1RHFpY1NGSm5PV1dlRTNR?=
 =?utf-8?B?MFZiaXdNZnMzQ0g5dUJRQ0hIanMxR01jUDVCL2VGZ3VwYTgzRzJxZzZHZEZO?=
 =?utf-8?B?cGRaY0VkTHZiM2JkeUxudXgxN002RTRhdldtcTMwcEhNcHJybFFBOCt1aTNJ?=
 =?utf-8?B?M0NVdk5IVFZxbEkvVE1UV2pHOXpPN3FhMTdybzc4NzFQUGN2MDFYdzlXUlgv?=
 =?utf-8?B?aXpyVzRlU0ErTWpKSGhaeXNXMzlpZjZvN3NCZnhIZ1hudjl3TEp0MnhmWTFT?=
 =?utf-8?B?U20xejRnbVZzaG5hRkIyQVZLYS8xRW5uakM3aGw0RTNCeVZMYStwZCsrSDhu?=
 =?utf-8?B?VFhxYnJBendsaHFOVUQ3L1JMbkRuNHoxRlNvWWJXT2lOQjF5dy9JN1l5eDA2?=
 =?utf-8?B?ZE5TUzBjQStmWTBqR0NVSnBZZHNpMEs3OWpZY3U4TnB2L0RkVDZEbzhJWUJj?=
 =?utf-8?B?VXJoOFNJWEcxM1luQzVCeVlGc3FYSVRKN0hyK1A5bENCVU1CcHRkdkhXbnlN?=
 =?utf-8?B?VlJkQ1dRN0l6SGJMMUJrWGlRaW0zcFk4eDVoeDArOG9nQlFhc0liV3pRVE5u?=
 =?utf-8?B?ZGFNc0VDeEpuUWNCZFNkdm05ZERRWFFlYXE0NnREWEkzUk5aNkgzRWM0RkJX?=
 =?utf-8?B?UDlTZTV3YW81MFRlalFiaGRSdWlNc2ZpZlB2VUQvTW9vOWhqeU42STBrZVpS?=
 =?utf-8?B?WHNVVFg1SmNvZEpqdnU3dk9EUWF2bE4yUWllem1SS0NBZDEzc2VaNmNUUktH?=
 =?utf-8?B?STEzYi9TVGJmMU5lZ2h3c3pzckhoc3BOaTNpcGM4emNXL1pZUXduNlJmTDJJ?=
 =?utf-8?B?WE1YMmRCYXQvUFZkWUxRL2FtM2Q2OFI1bXU5aW42RzdXVkdoTWFkY212T1li?=
 =?utf-8?B?ZGdxUjh4TktCQ2E4TDBTZkNTeDlmZGtTZmhxbE80b3B2d1ljVW4zc1h0ZDdx?=
 =?utf-8?B?WThqNWpzOHZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFJzWktralFHUDYxNWRDcGYrdkMxTkh0Qm5DeVdzSXRMcnhsSk9KU29EdG9n?=
 =?utf-8?B?MHQ0QVpjc0FLSmZhdytSdUIrQm1DMjhSZ0hSN2VtT3NoaUFhVDA1MU9wdUlv?=
 =?utf-8?B?bnczZTM1VDZ4K0hjTHR4UmE3S1lUNXg5YkVTNzNlOFdsMkF2RGRmVXlmajlp?=
 =?utf-8?B?c1JCTjRjWG1mdysvLzNma255TkJDMUh3aWtiSTU2Rjc4WUo5M0h5UHN2Q3ds?=
 =?utf-8?B?RmR3SDgwcTRwbUd6NkJDa1YvaGI1VzRxNzdkM2U5dERhZkZ3YWdTYkU4bnFs?=
 =?utf-8?B?N2FxbWpyS3Z5T1I3MUl5WnpobGc2MlNzVjNkbU1xeUxXOHlXeS96UTVsckNN?=
 =?utf-8?B?ZThaejQvMlZpMzQ3YXMvLy9kOGFsRlhieGZhV3o2bFlDU2pHOG1FQmhTeURi?=
 =?utf-8?B?bk5hekpDRWlQL1lCRlZ3d3RVaFhHUk5JdXNseUdlMUltZndJNzVESkNhQ3A4?=
 =?utf-8?B?Z2ovQ1gweXR5U1BPcjVKcGpVTkpoUkY2RGE1NmszUldVM1ZLc25EdDRyL2pK?=
 =?utf-8?B?cTRxK25aQ3F2SU1zM29RWUkzWlFsNU50Q2RBU3JWVDYxNUphMkNJeVh1cjBh?=
 =?utf-8?B?RWFBMDBub1V6dUhyLzZrYmdqNEZQOXZqU1JQSncrZHVka1FJM0J4SDJ1TUd4?=
 =?utf-8?B?a3MxeGVFM25qMUYvcUd1MC9HbnBwaC91aHB3MjJsRHpZTHpjUzFzTHJQTDQv?=
 =?utf-8?B?YkZvUXdRN0F2aUlad0RUQ3c1c3dHS2dUcS9YL0Y3ODhMZ2RsOEgzdm9nTWFQ?=
 =?utf-8?B?VDA5Vm1VZ1V5WngvWHc0RHlXWjJoNkxmckNENUV0blJqZ1lOb0lFOENVNWJN?=
 =?utf-8?B?aXZZbFgydnRFc0xnL21xVVAvWjN3UWVSVHVLN0d3bGtwa1FVLzZXTHhrUVVs?=
 =?utf-8?B?ZEk2OVBMMll0OVZSQTdpdnI1T2JEOXB6ZzFVSzFLUEkzNk1BOUU0ZUQ4QklM?=
 =?utf-8?B?N2x2R2E5NXJiVDdVSVE3aUhtM21ydjFmQlI2NVlodnQvOUk3aEtmN3h0R1pJ?=
 =?utf-8?B?STFUNmZzV1ZjM0NnZ1RWMVR2Ym5mNlAweFA5bnNlZEZXTW5nK2NUNUxhajlL?=
 =?utf-8?B?eWl0UllwcGV0N0xVZzZacDlycXZzUGozbmpsc1pVTHE4N1lVZzYxbnYvTmNR?=
 =?utf-8?B?c0Z1bEJwcUt5c2VzMlFCWHRiRk1kUlZWWnJVRFY2aEtCYXphYjRKVlVtOTJy?=
 =?utf-8?B?Y2FoaTB4ZzVNZmo3MjhDR20ydG9pZ2Iza3JOcmg1V2o5U0dQYzdLUkYvU05C?=
 =?utf-8?B?OXZCbUJTQURsSUJGeDhVQ1lyWS8wblFCSkxmbitrVTYyWFpIUnhackxvazNt?=
 =?utf-8?B?MzVGNCtSRVJPWnl0MkxmVUNyVFlJUWNpTDVXMjdBQXEzY0lnbXIyeElXTjFX?=
 =?utf-8?B?M2FPNCtKVkdjdi9Ka0d1bE1NVmJmYm1CVE5EOU82YTZTR1RNcXZXRitTZno5?=
 =?utf-8?B?dmQrWEhMY2xGNTE1V2w1VGhSUnd5SFkxUDNhVyt6WUN2U21kVjFLYTRiZlAy?=
 =?utf-8?B?aDJmMnBpdlFSTjdnZS9zSU9KWVA1NXVhWEwyWUlkM2dyeWNhZVFpZXE5L2tu?=
 =?utf-8?B?SGx0MmZHakJmbGEzSFh4TmxDdjI4bnNldUkvQjdXWXFLWWV0V002RklOVVZD?=
 =?utf-8?B?d2VMeEUwY1hMUnhHb1hVbXRDajFFdXQzejhpbzBzTDY3aTRocmhZN1pvdXhl?=
 =?utf-8?B?TFY2RmxYSmRIL3VNdWVzS2NCb1dTYmJ2ME5rTWh6WXVYcVQzNi9qN2QwdzlS?=
 =?utf-8?B?SndldVFVMTd0WW8yMGU4MldpQ2thQXc2Wk45ZFlnZG5iNm93dGFTcG1RSWpp?=
 =?utf-8?B?SjQ0T0xUQWcxMVIyMnN6NDh3ektjeWdVcmtTYzlueGYrdEdneVdNRkhNYjZT?=
 =?utf-8?B?M09aczhCU1RWRUxGeUg3cDFYeitLUzhoeWNSK3lXeWs2cDFZSmI3eFpLOEVG?=
 =?utf-8?B?enJiZ1VnZjc3Yk5oOEpad2RCWjArT1ptOHFQY2N5UDlEcXk0alRpUC9LWEl5?=
 =?utf-8?B?aUxKTldub2dQa0xUWEFMWm55K3Q4cURPSGNVZnAvOCszWmVBSE9UcmZ5MHJk?=
 =?utf-8?B?TDREemMrTjhSUWIzMHEwcEpLQy82THpMdDVZZ1BnREU0c0ZhU3QzRnpNbXYz?=
 =?utf-8?Q?IMMs8AVNBPtcmwXquFGUJw9HN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ceda9-a42a-4473-1f83-08dd26dd2404
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:39.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyPBH4LLq7gK/75BIZcgsVFHklg6gECQ4xtlci2JbjNFipDttoEZuJ9Z+RuUABf1SdXC2y/91QcgaaSnArz1Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

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



Return-Path: <linux-pm+bounces-39454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7387CB82A2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 08:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC5813008BEE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CF30E83F;
	Fri, 12 Dec 2025 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vnrzfzFM"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FF30F52A;
	Fri, 12 Dec 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525910; cv=fail; b=FnbW9KtCQXrGi7jx+aXoGCeDGaG5VlprbvfpGcE9stuTP6cjBYed6MDLAJdxmyERsD8A/4PBOkItTHTouULcI/GaeMwmjmG16J1bp+aaKYU/mKb/KsDmOLzdAuUnZ7YrOAgJNd1yamtyNFaVYzRUJgUG78IvmbEu/f8QrG8MNpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525910; c=relaxed/simple;
	bh=y4C3WZhf5M/opeBVo4/Yg3sdDruw3KYef0ANnYQPaxU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dy8WyWezFxFfdvn6v+xk3X6pGrQKxdPC2DGyWO4xTkl33uR/TzCiqIlhQglN4D0qsyJvMKZz+rGhB+QY2tmSPJuBxQ7Oe02IF+rXk9OOHYumMSgvCarxTaLlXWhfLWk11qxoSOr61xuT9ycNkGh0ovqGDcDgHPDlNe6yLSb7Pcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vnrzfzFM; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZimMlX3gDu4GKmZOvFGh4PMpAwBHdWmy7aPFRZlkdZ2Q+29ghXX9PDdCSoFlOvYyrq/REll2sjwJnOLTKjbeEDKB1FyVeRwBH1IkQWQXxfnwIdYEopUUzf4i+4tjw0/mTT0PJlqzuqTetfSYwVhQrwMBZv6qe73YIrnHE78YNXGZcPrR2E/bzT0O0WqKrxV/ndVDblEapR7gjfh8SJ/IdNKwF+f4iluYWKWovnOn2bpvW+q0dzcEdfZcVeSdsWC2tv3+/qPWWtgxDmf3jSAw+rujVMg3n2t7M1nzgm/KaGOx8Lv0lg3NHwKYSZg56EsjwNfjNjSEXKSJnqLImQbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS/aWVEDCzDd/vTiDtKgR6DVPsHhRGATQmxJMU97kyo=;
 b=wZBV6g4t5hbux9G2sLttzmHvWv0ePnkok6vkP8zzPcQTiWY1sJfOlSMhaAY4KYv+CaiWzWHFykNpZuYIS2D+99IqnGg+wQpZbHk/+r3WR9mPtwGf4IbZ5uj6R/LYxWIMurOz1Z5jLp2Qt1LdM/JEupla82psg3YXRapG4cF8/qyCmhaPM79X2hBqWqC4FUWn1VWjrJREqX+ODELt9xDliXZ54+Zfklzpjpk7pJJcsSqzGy1lIu6DDZJWkd4f2dmvOpjG6IT7xkkrsvYDbtsE8hjv2z8OIZO1v1/LZ0gwufKrdARnjBN2xK3L4nCR9cTIPmUMjEcqqQsB9GoY5ROYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS/aWVEDCzDd/vTiDtKgR6DVPsHhRGATQmxJMU97kyo=;
 b=vnrzfzFMf6EJORwg8rxJgj7IFUC/OaSjFC+Y80/mUm28KuL7G63EqKm7QTCLFuJX8l2R3Y7egi+LjyB+40GP8q+dFam0m20R9ktJSp0EHLBKrjq2INSGlQHe0UMPYH6UOw5jRIWX1gWpZq+VM+VIZ+kbIePRKf9SRn0EdZlRFQoMHGhS1cUFknZJyBk5WpzZm/GHozw6MLzQnm9Gee1F4xOEbuh7lahWEkqAev6WEQ0VpynV9OUoOMaOEWU6lR/fiIvG2FO2bs6wHWEbbhtJ4pngj0OITfitBDbwc+Sft/L23hsQwEGcTZ2FPwhWdOCthb5w9NvwKSUPoAxaRAjBaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10608.eurprd04.prod.outlook.com (2603:10a6:150:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:51:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Fri, 12 Dec 2025
 07:51:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Dec 2025 15:51:15 +0800
Subject: [PATCH 2/3] thermal/drivers/imx91: Drop extra spaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-imx91-thermal-v1-2-c208545b44cb@nxp.com>
References: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
In-Reply-To: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10608:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bb80ee-84fd-4f89-201f-08de39534bf6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0VMRzRzOWFMN2VvVHpTeHhkQlBrZUplR21yb3NncG1hRjZadHJSSFRkMjVz?=
 =?utf-8?B?d1Q5T0RISThNU3hTTVNsMUdPakRsTzh4a0txZlk3ZUhnSjRKQlJYWHJjak5F?=
 =?utf-8?B?TURCOEZiTTBaaWkxUkVmOHVzdHlPb3kvazlkT0xNdUw4QlRoUm02RTZWUDEw?=
 =?utf-8?B?U1E4bFNYRG1oZU1HaEVucEVnN3ZWOEJWVDZrTnZ4L2JFKzRrUWl5M29SazZY?=
 =?utf-8?B?b0t6dUovRmtlZnErT2dNZWNWYXFlOGpKQVAvQm1aUE1aUS9sd1BjSloxUm8v?=
 =?utf-8?B?a0pGMmRQTndZTnRNVWlOejBhRkRIcWtST1BuWi9JOGYrQTd1MFhZU0VCMHRK?=
 =?utf-8?B?OHVTMTRBeDBod2hnWDNKeXptUFFSUmxXcWloL3NjTjRhNXNlZ3BYaXlyODBS?=
 =?utf-8?B?NWUvNEQ5ajFqSm1ZSmZxd0JUYmV3ZmtQU3VtZ0VLRlEyMCt5aS8vUzI5T00z?=
 =?utf-8?B?RFc1QVdvWkZsZzI2M3VuN2ZwYnBzWUJoQ3dzQ1J4RUVKekx0bm5pQStCd0ha?=
 =?utf-8?B?a2pubmxzWEQ4UWswOVdFMnU2VkNJTUFhQi83L0lKdFNmbDIvOWx3cjlyQ1E1?=
 =?utf-8?B?TDlweXJ2c0pFZzEvcXJydk10UjdWVm9yTmp6WDVxUllhRnRqajVrYSt4YTll?=
 =?utf-8?B?SExCU2plNVlwN09WSVFVdjI5NDAwKy9FQ0h3eW5WRW9LZzJGMEh1VnNYYWx4?=
 =?utf-8?B?eXQ1NnJqK0hCMWpINFQxRmsvK1I5cVF5cGp6akxyQ1BLZnBMWTZSbExtRUVh?=
 =?utf-8?B?S3lpVzlhS21nMGQ4aFJqc3JJL1BqVll6QjZzbS9NOHlVVXE3WkdFa1B2ZGx5?=
 =?utf-8?B?RFBNaXNkS0p2Zkk5anRJYThraWNFcmd6ZmE2OGZWWlBGOG1CNGJzSDg4eGNZ?=
 =?utf-8?B?Z2VITnZSTVROQW1VeXBLdHNnQTMwdmR0L0QxTGJhbEoza1NKMmM3RDM1M0tE?=
 =?utf-8?B?MFdFZHFoWnhyUzdVeDlpbzBXNXVrOE51WTNIcUZDUnQraUhhZzh6TnE4Q09z?=
 =?utf-8?B?cVV4dUlMSHRNcVNmR0tWMVZ5RHdTcFJZQnlPUlgvV0lHd2ZzRGtobFYvaEhN?=
 =?utf-8?B?Q3FuZXhhL0NvOWxvNVpKSXY4b1FLTnZ1Y2Z2N3JodW8vSURpbnFyV0Z2Q0xl?=
 =?utf-8?B?bDBxUFhxRU9NVVNUMnFZYU1ITTgrSjM2dzZsb1FSZlNPZmlwZUEvSFM5cHhG?=
 =?utf-8?B?aWpSazIySkhuRWhnWjJhYUpoWVJQZ3gvTTBRTGVoTWhSRytWSStHbEZjVUgw?=
 =?utf-8?B?ZXdMZVkxMDk3ZHRGNFhxM2FrWEFVQWNZTU1kcjBuQjlza1VvUXg4MVlUQXRY?=
 =?utf-8?B?UW9LRTlOR2lQby9jK25jYlJzZG9sajRWOHRnU01DQmhMSG9zQnFKMExTQnd3?=
 =?utf-8?B?ZWFjbTF2ZFNZTjI2K2ViK1U2aUl4eTNna0NrVnROblpHUmFpeE45eG1wdmZ3?=
 =?utf-8?B?VUFMSTI0WTBxWGZHa3JzbXpWMXhmTUxITGIwVVkzalRuaXp6eXhIcVUwMVBV?=
 =?utf-8?B?ak1KWFdNUitoYlk5RlBRR09ZcUI2N3RReGZ6Qm9FYmZsZU5yMUNmalZCWjNt?=
 =?utf-8?B?TlYwd29sK1RNVUhEV2orVDU2SjZyK3RwcFA2RUlhcldRSkhLR2RQa1g2aUw4?=
 =?utf-8?B?QVFGWlhvYmJYdy85QitMTmFTdUdaRCtrVmRmT3NQZHE1Y2RrbGhZWmpTQ0NC?=
 =?utf-8?B?QnZaRXdIVEdmOW80SWpZNUtVdk56RG1RRXB1MURuVW9XMmJDNGFqd3hvM0Jo?=
 =?utf-8?B?U1BqUDQ1aUNIQkJSUURNdGpQbzFTcldMRU9TVDcxTzZ4TTR0MkZiblNSOHJk?=
 =?utf-8?B?UlgrK1JHOVFFRXJ0NFRuUWQvbXJQMVFkcnZkQVIzVkl6M0lraXhxRk9udzY3?=
 =?utf-8?B?aFJOZ0dXVTBXL0JOelFZb0JjOUphN0lmaUhLdi8zclNPQm90ZnJneTgvY3lL?=
 =?utf-8?B?WGI5WkhFSzJ4bnUrNi9xV1ZqUDM2MzJ2UWNGQWM4WEpvMFNsOGlXSnkzUjQr?=
 =?utf-8?B?ZDI4cndOU0laNEc2QXhyMEcwZzQ0cm5uM2JSOVBLME5sOXlOWTEzS1Z0dDFv?=
 =?utf-8?Q?V2oYUH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHl1QkNOdkowMDF3TFZ2NDJIWkkvQ0VsNlVWMXhwOGNhMk5XcCtYSjdrZmVN?=
 =?utf-8?B?UFNSNS9JQk0zb08xUjRCVmo0RHNOeXpPZk13dldYRWg2dWh3ZTRpcll4cEF2?=
 =?utf-8?B?MEViMVhwMDlVZGUza054KzRra0l0QmFnTXBmMHlWVENiRzFwNHZOb3NabnlU?=
 =?utf-8?B?N1VsNWl3U2NVUmVzL1hyVldNazE0K0pCdVNGVVJPME9NT20wVUp3NGJyQnpt?=
 =?utf-8?B?M3pFaXNYUVc4Ym5HYmx0aXBaZkpKQjNMejV4WTJLVnFPZkxyUlV2QVVJditw?=
 =?utf-8?B?Y29VcDEvdEhpM05tN1oybnF6UG9zTElHYnNITEc2R0IyRjV1OFd4ZWpFekZv?=
 =?utf-8?B?MVJpOE1GNWZxeVYrc21NS0duNnBFZjEvQjR2akNLLzVNdGV1V0RFVGxPMjk4?=
 =?utf-8?B?Q1dUd2dybkdDT2tQNGkxb2RwUmNMK01tTUc0T3JzMWszSGM2VUhoWTlqUXR6?=
 =?utf-8?B?MGRxRG95WDYrSXM3Z1dDNHVqdEV6NlNINVhML3IrU3hPemlSUklCWTlIOUVi?=
 =?utf-8?B?MFJvNDI2MjRwcDVWVnVIWW5SOGtCblorUm80cng2Z3N0d3NKTDFRYjc4OFZi?=
 =?utf-8?B?N1ZGek5IYkdSakRkRjNraWNDVFA4Tjc3MG0xdDhKUGhGRkdLYnhwYUZoQTBy?=
 =?utf-8?B?bUFvUGFYREplUWJ3TG53RUhzMXpYWkVTMlhPcjk5YTZhV3hMSE8zQ3N6RUxy?=
 =?utf-8?B?My9CSXhXRUxITXptUVhlSC9BKzF4a3FOT3BoRWJScDdFWnAwMTZDUjdIeWtM?=
 =?utf-8?B?bjcrZ3o2UERiUkpPK0llOW1DanhrZWowUjAva2hUNld1STcyNVZGSVJDZ1Bq?=
 =?utf-8?B?Y2NwSVYwQ0Y5QTdkYmZOT2cxY1Y0MzhYa2piWXI2RGhOSGIxdnh5dWRBaVho?=
 =?utf-8?B?ZWZEdnNUVjNFWVhtSkhSWDdEM3lVU3MyWDBoNE9uSnJsOVZrbjlVR0hFSXBI?=
 =?utf-8?B?VFEzZDI5MXlSN1BWM0ExVWQxR09CL2VsK0lTWmdpZU9PQWFkaE1iSnRvVEo2?=
 =?utf-8?B?RHhaZXdZTUF0dWlvUkx4RXBGZy80ODRLY2JYcCtCQmZMNFVwSllBc25ab08y?=
 =?utf-8?B?R1BVaWpjRjVSYVI0NzBjOWRrUHdrbHRvQnFVVzh5NG5yVDRSb1ZodmtNeTBM?=
 =?utf-8?B?ZXVmVDN2ODE3a3RVR3ZEZzBNN3RBR1ZackdFYmlWditOTklQVXl1UmV0eVVW?=
 =?utf-8?B?bW1wSWJEZW5FWVBBM0dhczN4T3Z4TG90QmRMY1llR2FTbFJUMnNIdENCV2VG?=
 =?utf-8?B?WXBScVRNME51eHNaaS9wNXpvTGdWQXVyR1dnMGpIQXZsSDkxZVRqTnNnOTh3?=
 =?utf-8?B?TXArZGpDVXo5RGVvbUU0SFRDK0pialhBT2gveUFpMS8wdUI5eU5LK3FBbW52?=
 =?utf-8?B?azBTS0RaOG1QVk9FeHpod045NnNpalpTUURHeXdMcVRsL28xWHphTk1yTEJj?=
 =?utf-8?B?empEQk00VUJ0YlF4WkNWekRuendXUFhnbTVkbGtYTmp5d2FPREJjTEJoaFhF?=
 =?utf-8?B?UFF1VkVKTEVkZ05keG5WREl5amxZRjNRNS9YMUZERTlTcTljOCtROGVKNkM5?=
 =?utf-8?B?RkVQb0tPSmMwcGZ2bmlDdUdPQ3cxcXpzUVZUcHhUQ2RLRXN6eTM2MnAycFNF?=
 =?utf-8?B?RWRtanAzcWtHVnB1N3lNNTA2TCtYZG91NFdaWVZ3cVI0OEp1bGxFenNWWThv?=
 =?utf-8?B?VnBEY09MWndHckFrK2pZdlRoWXYvOUhxN0RWWVljM3VqeXVIRnhNNXFyTFM0?=
 =?utf-8?B?U1RHN01hQWY4OFM5bTNrYkFjeDZlNVAzclNxQUlSR1hPZGgxWnZxbStNOTUz?=
 =?utf-8?B?QW45UnRwalFoaGh4Y0V3TlNYQkQveGRmdmtwVnRlUXZlY0dVaVRMTzlzVSto?=
 =?utf-8?B?RitGUE5BZnJSR0xkUFdPNWEzbUFXRDVuTXBsNmVsQkQ4cGJhK0FwZWdvSG9H?=
 =?utf-8?B?dFBPVmIwWkJTTUpWRVhZUjNNRnVENjlsaVdBNGxrL0IybHZzMVdVcHN0NTM3?=
 =?utf-8?B?dHNnWG9GTTUxR01YTnFhQUMwcjBrZTVIc0pkaWtSR0M3dU13Skl0T3BBK1o3?=
 =?utf-8?B?OEhNU3JRU1YwWWdTQ3hFRTZDWmZuNFJ5cGtmNFZpc3ByU0FPSVhOOGxKR2d4?=
 =?utf-8?Q?tunBUHVf25QqbQktDBynWZtn5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb80ee-84fd-4f89-201f-08de39534bf6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:51:45.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZtYLb21fpQotV4DjcUL/N5r8EqVaj3/xG+khRzwaIMweO3lKQ6vZa7wqSXTmslWFOu5tuj6+bLjk1RUgPoQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10608

From: Peng Fan <peng.fan@nxp.com>

Unify the code style, drop extra spaces for the macros.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/imx91_thermal.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 77e8e6a921c6af308b830c36721293c007256ca6..768c5acc384eca1c2203098bd4749628d9ffb8e6 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -22,17 +22,17 @@
 #define REG_TOG					0xc
 
 #define IMX91_TMU_CTRL0				0x0
-#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
-#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
-#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
+#define IMX91_TMU_CTRL0_THR1_IE			BIT(9)
+#define IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
+#define IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
 
 #define IMX91_TMU_THR_MODE_LE			0
 #define IMX91_TMU_THR_MODE_GE			1
 
 #define IMX91_TMU_STAT0				0x10
-#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
-#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
-#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
+#define IMX91_TMU_STAT0_THR1_IF			BIT(9)
+#define IMX91_TMU_STAT0_THR1_STAT		BIT(13)
+#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
 
 #define IMX91_TMU_DATA0				0x20
 
@@ -42,12 +42,12 @@
 #define IMX91_TMU_CTRL1_STOP			BIT(29)
 #define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
 #define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
-#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
-#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
-#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
+#define IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
+#define IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
+#define IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
 
 #define IMX91_TMU_THR_CTRL01			0x30
-#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
+#define IMX91_TMU_THR_CTRL01_THR1_MASK		GENMASK(31, 16)
 
 #define IMX91_TMU_REF_DIV			0x280
 #define IMX91_TMU_DIV_EN			BIT(31)
@@ -67,7 +67,7 @@
 #define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
 
 #define IMX91_TMU_PERIOD_CTRL			0x270
-#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
+#define IMX91_TMU_PERIOD_CTRL_MEAS_MASK		GENMASK(23, 0)
 
 #define IMX91_TMP_FRAC				64
 

-- 
2.37.1



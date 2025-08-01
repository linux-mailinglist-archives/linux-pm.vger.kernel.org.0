Return-Path: <linux-pm+bounces-31718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B73B17BE3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E443B1C22DAE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D8D1F4281;
	Fri,  1 Aug 2025 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nkQ24msf"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF21F4165;
	Fri,  1 Aug 2025 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022899; cv=fail; b=geoVkoZCbewSPMwRcBN1X6/UFfECYKRzeEUjU1r3r8E/NPZudyNF3gkJnyAP60RljG/LjnzNliWj8ERlOY13AqxZ0l+oooXYfwxNqI3JnB5o2HHnvvx6348TpoYqtElq1u6cQIXBA+0Vx11C6hO/ybLVsvAgL9SCFQ5DkS1/cmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022899; c=relaxed/simple;
	bh=8F7IZwXpDH5sLxod/40wvvSn6FqullUWy2O/ZKYg26g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vCyypT71t9l4GG/5YYrgL0e9G2NYf3EUJ13CJe9OPsulrQSb8ndbcOkswQpP8z85249vlvSvn+yZg1T7tb/EU1HhHbXlsdiNM+oZdjKInNvDz8LGUWC5uHJHr3vBAWviCix1+sB/xJpPiou2HueMgRHWoIsjK7x491uJ42f4vp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nkQ24msf; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlItd3XjfvvWuPn2vnkSs/EH+Eqizx18yyaLrJhEo0VFYRTV5bIzj7nsHRDRXjZiOW8qSkotuR7fUCFWsHI1vRBmkAV2ui+NcfiO6TL1O0gNMzCqO3evL8XfiXrsjPB9V409HizRQ6efLWDcqV4Bc2EZQr2hXQklXrl64WSbASxN1mPSCK6y/AFzhhX3SLsMLZt1CDPwoMWHtbP5a+Kc7XlPPqEgU9tzbCDm2s/gU/FTE8kBxqqx0lJWsM1VwTkfUJ83k29umfLpTmFWf7t4ZjveFVao0SNnLBqZzK2cnChHJ4fTheerew55q8mhSiN5SoyfbJW4+u/2yZrG0r1Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWP0YpljYBTFc2kbQJxT21z1anaFg57ICxbBOEkW7gg=;
 b=H034htbu5o0y/3vnH/vxelAuL0+MQ4vVR12h7UBz1FWyVGdlaGFLRkVwtI+AsklozEY5VxnvkRt4XZfeHk46Uk1pT6LwM4uvj8I8ADPxngRgrUZz02pJrgTYVocLtU3ZZpIps9iK1snVkakuKV3x6/dk5Y0jGQgyilEBPjysf5wwAVdSCImVM7ZS8hrSC1woB9GiSyKz6UhTEZr0Fw8nFfk106z5qRdnGA160VuiIlxGkfoz1cLTfFnT6RRnLTFwZ108E9D5uwR4tn71kGT66ft16zcQrSI//MblrlR0rzlIEzarhiyvdcFNFG8mC9bOGSd1TizLq+DSk341x9ArxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWP0YpljYBTFc2kbQJxT21z1anaFg57ICxbBOEkW7gg=;
 b=nkQ24msfE9IEAYlhaPuAesDVoJCQzSWPVXX2asKSnbwUYsokN/l9hTqtllk4awqQgJlmPZ7aj1Wxd3TMbWt0RQFZeD6WaVPAscUNOUn3HkILUQ+zymc6GbLQGGnIjqwid1dW84GxTXGAat2pWXwnIijivFCeYCXGZFWJ5lL/8scwnYqWPgZedbHme26DgTYgVN9y2bMdjfszT7apMrlbgv90jdR5Ag0RojAX2Soc+OgzTMeVzhA/e7DT07dDJY0pBQSqIhuUez9KnoklK5uUAhJp80hByq71Qh37OzlbNsyIx2aXZhC/H3Zh4vVwTjPKhxfpsqnN+1set0PqcJiZlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 04:34:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 04:34:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 01 Aug 2025 12:34:22 +0800
Subject: [PATCH v2 1/3] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pm-v2-1-97c8fb2a433c@nxp.com>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
In-Reply-To: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754022883; l=3205;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=8F7IZwXpDH5sLxod/40wvvSn6FqullUWy2O/ZKYg26g=;
 b=SIKgCDr7oOO0okVWwY+trAEnLXKKauAeW+WOift/z+YUq0kQw6wOOr5sAZaxR2mUcZ1l8SKIX
 fXMm/xMl7CEA7wtvr0zr9E1eniggX2zxZgGGHevCN1OAWYIY7TZ5FF4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: bf367773-1927-4592-c373-08ddd0b4c35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmJweGhIZW14UWxRaUpabGpwM2JSb2tYemxieUV3R2hjUG5PRFp5TmNOZnUz?=
 =?utf-8?B?c2M1S2t4b0lkWGNacHBna3k4b1RkcDRUdGJRU0lxNGJ3TTdLVXBwL0sxa2I5?=
 =?utf-8?B?RjN0YTg1dWZxRHdtai93aXRnVjhLbTU3ek81RGtEYkdWZEM1bHZmZ2d5aFdj?=
 =?utf-8?B?REsvZjVvc1hpWTlabkVIZ1JOb2VLZnc4QkUyY0hTNU1HZEtlR0dhZ1Mrb3B0?=
 =?utf-8?B?OXNtOTNqZUpVdkwxQkRrbHNOdkhlRzU0S1NIT0tDZlJmY09xWHk2WHpnNDly?=
 =?utf-8?B?V1kwZXlldVFmV1M2bElORTdUNW5OUE8zcThud2VqYzY5ckVsOFJrZ0JQc2dT?=
 =?utf-8?B?TjdxdytWdGRMVGwxYVBxbHV6R25HV21PVzBnZURURnQ5czdmbW5ZeTBmWUdr?=
 =?utf-8?B?Nmw3VjVpZVY3MUoyNDNQMnFvNXlZYitESGxOR1NEMm9XaHNOcitCdHNXNHQx?=
 =?utf-8?B?MjdTZWRneU5Nb0VDNFE5Si9zMUVEV25kMFZSYnhnM1pYdlIyY0YwMnNmNTB5?=
 =?utf-8?B?OE00VkRYcDNveExTdjQ4Mmo5Y2tGSE5OQlVNaDhmeU9qVDdudFRTaThvWHZR?=
 =?utf-8?B?eFAySVlDcUxnVEFoQUU2YzVBK0hVUU9xckszUUR4eVJlcFNiZHdRbnFXNEp6?=
 =?utf-8?B?NTE2Z1F4WktGQmZuWXg3K3MwR0diT0xyeXdLb2ZweTJGNk1jNHdadmsxY0Nn?=
 =?utf-8?B?empJNUNWOE9OYTlvM1R4VTR1UXVud1VlQ3BqaWF0cjF1MWxyZUZ5RmZLRGJX?=
 =?utf-8?B?Y2VGcGcrM0ttYUZPT2dhdTFyNklNZm9HK1EzRFMzM2VqK3hKblk2NytTb2Jt?=
 =?utf-8?B?YXFsZVZBRjNraUIrQ0xmWUpUSGhlT3M1YllJaGlKc3FSSkVVajlaWE9HL21S?=
 =?utf-8?B?RUpES0t5aUdNU1FCUkc3bVBMVEZYaXlDdDlqN0trZWlXUlR3TDQ4TXRLL0h6?=
 =?utf-8?B?YjBBK2x5am43U045aE1oS0c5US9zK1VrUnhOSzFiZ1hGdTJaY3h3SVZrRWJC?=
 =?utf-8?B?bStBRUNOYjROc0V3L2FUUWVwTlpjTjQ3d2tFSjZXRnJQNWRsaWx2b296bHdG?=
 =?utf-8?B?T3RXcEVpd1VYRnpSZVdvRlZHZy9CNW1VSWNhdUZaWmdsU3JxcDg1NHlyOHJw?=
 =?utf-8?B?dHUxSTB0aENPSEhuOGo0dXJKazhwTmRFcWIrcGtualNzNVJXcEFTL1Q3Qlgr?=
 =?utf-8?B?Y25Zayt5K3ZiMFRpcUxvWGJiZVl2dUNuWXFsTnlTYUhGaGRDRlc4emU3Zk9Z?=
 =?utf-8?B?OHR2dkd3NFozWlB2MjdMeDBVcjV1MmJYOGJuYVRabWRaVUxXYUdPdGVJYjJi?=
 =?utf-8?B?b2ZFc2gwdUxFOE1Kc3EzWnFHZWl2RkNzYnRaZzIvSEtqMXdjd29FUGpHRVM3?=
 =?utf-8?B?YlhYNGJNRndtbGQ5TjRSV2prTk1GN3dORXl3djh5NTJQNVJuMjdPMjR3Ymo3?=
 =?utf-8?B?VUcxRFY1Vnd0REVqVGxqQmpYUVNTclBWRTJXNTVFYnVFQ1FKTk5OUEdtQXFt?=
 =?utf-8?B?czlaOWxPMU1oaUZJMVpqNW1yZUE5a3RleDlnTFlsTklrcWFtS1RqVlN5QnUv?=
 =?utf-8?B?RGc0aHJ6ak5QUk1qZ04wVFdIZm1DaEVWNDNEdXIrYVZONktkU1Z2MFBYREJ6?=
 =?utf-8?B?d2xXaEZBQ1VUQjZyL1ovaUcyVzFpazR2RmFtanlvalpDcjRWRzJpNXpHRDVk?=
 =?utf-8?B?N2hvSWxidmd6R1VBV0owUjZtdWhYSWlIeEU0eGFQYXF6bGpqcm53YkhSSmJE?=
 =?utf-8?B?dkxlUVk0RTJSNDhjcnRJcU14cDVsWm1NMjB0NHRZNklnL0kzaFdPdjJzNWtO?=
 =?utf-8?B?ckdSM2VWVFJpZnBMbW1takxqMzhmbzVsbUh5aUlxY0pYRTJEMUdha2oxaWFr?=
 =?utf-8?B?MkwzNElrWHRDWnBMZFpFSlQ0TC83M3ZCMVB0R2V1a1VUVnRYTUFGaUQ2ODcx?=
 =?utf-8?B?aTdYbHI5YUdoc3JSZEJQcWJrYmszL0ZZVFFQU2VpbkNGNFZ5aTBxUU8vZ3ho?=
 =?utf-8?Q?HkRjG9SOZu1A2UjkaBt9i5xP/Ly32M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGdkNm5OY1ZLaWhXbkI4dzk4bGVZMW16SlUrMm5JaFZjaTVaVDVOVUhWczJN?=
 =?utf-8?B?K3oyTXB3VzdTV1pvenhjclJDZTNrUXRJRyt6RXhsVlJHS0pNelpyOFZ5cnZP?=
 =?utf-8?B?bTBMLzJVUHJFekpiL29rMzdMemVvWTRUVmZzMFFrUkZBdGE1V0JxSXNjR1Zo?=
 =?utf-8?B?eFN5VjdJcDNxazBYTis0V0VGd1I5WFVwV0R0QnM0MzYxNHNkcTBLOExUSXlC?=
 =?utf-8?B?Y25mUlZZbUNQMng0NkN3bDM2aXdNUytGbUFpVlJ1YWRNcFVPVklmU3JjZGtR?=
 =?utf-8?B?Qk5ZNW5Va0hVdlRQSG10REx3anFNQkN5MHVBallTY0FSSUxaaWd5bVRHN3A0?=
 =?utf-8?B?MzF2akNRWFFtNEVyQWcyQ2ZsSU9mNm8xa0kyR2hwUlZQdFVka3FOUUErd2pY?=
 =?utf-8?B?VDRuSGhua092Tmh1bWJhZEFnNldiVTBHTGZQM3FIZlJJbHFOQi9vaTNlY2F4?=
 =?utf-8?B?aElYWGxwajJPZ2R2NUIxRG1wQUh3dlJVcEtmemdDYTJURlJiS2VvWjdtR1pn?=
 =?utf-8?B?UVczZFNKVzV2RVBZNFh1Z0dPZnozanhhQzl0amNpRHZ2WlZoMFMxNDVEb3o1?=
 =?utf-8?B?M2QzZ2tFSkVLNURHM2tXMlVVWkplWWtDUVlybVNpTmhmZjFiMS9rUHZiRHgx?=
 =?utf-8?B?a25mNDd5TjZUam9lOGtQOUxsU3ZhNDZtS1FLSGJUY000MTZsNW9ta0pZVUxa?=
 =?utf-8?B?SFdBcDVYMk9IcDg2T0JTdE5KZVYrcEZCYzRaRG9QM0ZGN0hyYnBHT2tWSVRi?=
 =?utf-8?B?dms3MmJRYXI0M0xRcVZwVjdGYS8yL1lFdkRVOXE0NTROcUlMUWFyQ1FBMGNv?=
 =?utf-8?B?UWkvRGl2S1VPTGIwUXh2endGSXlyVWRBZ29vNjJXbGxNSTBYb1FSK1hXeHVh?=
 =?utf-8?B?dTRXSjhJVW5XYXZKT3cyRW1sT0FHNC9ydXBhTmREVGp1Mk53L1MyeTZObFJ5?=
 =?utf-8?B?ZEFLSWFBajlRYTJkZ295MkpBZllnWUhlUmNWazd2dzlvZ2ozeEhtTjU5dXpk?=
 =?utf-8?B?WXg3L1RYZjYzOWJrYlNOazJNZ3VhNWRBbWw1OS85VnFIUXIxOFQycEhCa2JB?=
 =?utf-8?B?ak9mbldIa1djQkxDV1dFUjRXYkNTcmJZdUwvN2RzVk5uc3Nlb3J6L0tmOUhv?=
 =?utf-8?B?SEdBVzRhamdkUEhOaUtWYjJtRDRjVXBZcFlCOGNESHkvOWFzaHN1dXgzZUlH?=
 =?utf-8?B?cVNqcktCVUxRY1ZWYW1ucW1TRS82d05JR2NmVjc1ck1mc1NCSDhuZlN2TVI5?=
 =?utf-8?B?QUZBMU1ZZ29reUZHQWc4eGtBdjROU05QN2hXN09tVFkxdHdQVDdndlpCaUZ2?=
 =?utf-8?B?M3hlSnRjNjlpdjNhek5TdDdBWUZpcHRMUWQxS3pPZmM5alZuWURxRHVnaTR5?=
 =?utf-8?B?SEFCYXRVSFQyVXE1alVjVG1JSlE2TndPelVvNEsvUGhlalRqWWVCYUw4eW1q?=
 =?utf-8?B?K215bGpLWVo0ZUJYWmhBdmswQVdWUS9oMkFURjBxMk5leVRlTUpYVFI1QkFs?=
 =?utf-8?B?RDU5a2RIQkxPenJPNk44UWU1cWMyQmpUNFRqMnBPSGFYZ3Y3bVRFUGJSSUth?=
 =?utf-8?B?REV0RW9Tdm5tNEs4ZnF4bWxOcXM0dEhBMiszWUdLUkJveC9IUU45RXppNk9x?=
 =?utf-8?B?TFhTY2lmaEs3UC9WbERKYTFWdWxXdTRUcVkxeU9kNVZ1YlZYMFlpbjNMYjFG?=
 =?utf-8?B?VjhSblN0dncrNkwybWt1cDY1cDFnK1ZZYjhLeTdNWEVjWDhnRklqS2VZeUJH?=
 =?utf-8?B?eWRmSGNuVlV4aTByTWJGWEZaaXQwdnJnWWgwRnlpdDNXdnlyQTBvVjdma1hi?=
 =?utf-8?B?YXZsMklIWStobFJnMVdndVZyZTFsNmdGR2Nid1pzOWxWTUxOUFNvMWNCby9Y?=
 =?utf-8?B?c3N2Z20venpPc2h5MG9kMEUyWFNvY2hKMGdyMVBXZkEvOUFhQ2cyUGNNY0d1?=
 =?utf-8?B?ejU0eXoyVUtaeWdYZlJxUmxIVWFtb0I1OG5YdExPY1poVnZMZkM4Z0hyNFlk?=
 =?utf-8?B?UFhmc0t2Z2pyMzlZd2JjQWxpME1BQVhaTUJQdzlDUkVqdWhxamRPZGdCN0hZ?=
 =?utf-8?B?eDBTUHZmK0F2SHJZOFZFSkQzN0l3RTRPVzdnVVVBUy9NS1RLaksreklvSW9l?=
 =?utf-8?Q?0V+5St/r10X6cN233di8pjxut?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf367773-1927-4592-c373-08ddd0b4c35d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:34:54.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp5hXcUyuCWeNhbTn0elQGf0XuFsWPtpMXW2o4S5yYYBVcLD3bTcxRVwVJHLHMUBSikeJeeBlhtj5TOZ5ao/Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

For some cases, a device could still wakeup the system even if its power
domain is in off state, because the device's wakeup hardware logic is
in an always-on domain.

To support this case, introduce device_set/get_out_band_wakeup() to
allow device drivers to control the behaviour in genpd for a device
that is attached to it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/core.c   |  6 ++++--
 include/linux/pm.h        |  1 +
 include/linux/pm_wakeup.h | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0006ab3d078972cc72a6dd22a2144fb31443e3da..8e37758cea88a9ee051ad9fb13bdd3feb4f8745e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1549,7 +1549,8 @@ static int genpd_finish_suspend(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_get_out_band_wakeup(dev))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1604,7 +1605,8 @@ static int genpd_finish_resume(struct device *dev,
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_get_out_band_wakeup(dev))
 		return resume_noirq(dev);
 
 	genpd_lock(genpd);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574c24ece2f651352d4d23ecaf15f31..5b28a4f2e87e2aa34acc709e146ce729acace344 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -684,6 +684,7 @@ struct dev_pm_info {
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
+	bool			out_band_wakeup:1;
 	bool			strict_midlayer:1;
 #else
 	bool			should_wakeup:1;
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index c838b4a30f876ef5a66972d16f461cfba9ff2814..c461c7edef6f7927d696b7d18b59a6a1147f53a3 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -94,6 +94,16 @@ static inline void device_set_wakeup_path(struct device *dev)
 	dev->power.wakeup_path = true;
 }
 
+static inline void device_set_out_band_wakeup(struct device *dev, bool capable)
+{
+	dev->power.out_band_wakeup = capable;
+}
+
+static inline bool device_get_out_band_wakeup(struct device *dev)
+{
+	return dev->power.out_band_wakeup;
+}
+
 /* drivers/base/power/wakeup.c */
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
 						    const char *name);
@@ -162,6 +172,13 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline void device_set_out_band_wakeup(struct device *dev, bool capable) {}
+
+static inline bool device_get_out_band_wakeup(struct device *dev)
+{
+	return false;
+}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}

-- 
2.37.1



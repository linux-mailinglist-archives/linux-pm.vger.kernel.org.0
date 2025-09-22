Return-Path: <linux-pm+bounces-35131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B8B8EBE2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212703BC1DC
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7C2EDD7C;
	Mon, 22 Sep 2025 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O9ieN6bs"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E02ED855;
	Mon, 22 Sep 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507277; cv=fail; b=lLKxbRL29nenYvTZgLln73qAx6QdRsBs+Jki3kJ/VUT12G8CPdxlHs/u5t4U7N+6y4JFBAXuNxaeSTPcZC/7S+IB3x+bGKrUECzgaBKqnI/eBnuixH65Z379Tje401ibm+vC3LXAfXD/35mIWryG9f1FDfQzqSiUHxIp6IxvUHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507277; c=relaxed/simple;
	bh=Jfuw4ReqQ48yD6GVrAaD54bMaBD2P0dzQUqUpQGNgBU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X4kaxzmaRu/e0zbjZpw+50sOE4vj3Y6Q3ratBvju5l5IT6YlP5tgCO2MLYEtf6ztWFdF9Zaw6Nt3C/xcSQ27wEQOkAvWRlrZu7RYgkdyl5z71pmoAfEHM62Bn5qE6c015zewoccRqTB8fAoNaPbXtaRVSqSUTeIJNTh5ps10WMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O9ieN6bs; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLXLs+eroZDVYS4zc+r8hA8mqcvF2Up15lQP3L8sQGb4MMUGB7mQt8rmYhhoiGOJLcK59b2c7RccKiZMa0lEnIZ90FLp8FjtvHiN/w2AWiJCBVQcTEhJZYVwThCT/OQF5wkhpA2gqm7g0dk0V1dTcpy4OLIHHNGUMrhn+5O7gr6LLo2mZykCXiyRqoJURlVbDHFJhJYvaw7W9ybLwRXqxXEp10GMHn7RAhYQwHsKVnGnP+oarS+sx8Yzp8M5neiq4ykn3Xsb6Vha/JKaiMqjOG3eegX+qQf4JyhNJDvljYjT9hG2B338lmkEjCXBVdIJdqJFD13pub4w/g+OCHDRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chm9mqzbgpbVnPEeOZgoLWO37PtUmrlCKvpvLIYNyKE=;
 b=Rx+RpSq7s3KnsZPotl/zaFkJ903mSepBuYPyUZJPnximdITY6Tx36AzzXMrV14OxahaR32urhuYGNTj6ubt2wci65I1mK4LmhmzT8TD5e4ysZnScTUqVrHMAVwlIPboKDKufVDCNAEVZnAU1tvL7wFrRgN4XofPAVgz1R8InCile3vgZ1gRO5HROlAzUxoiEqEj3l0utz6wFPvNtMH/+2I9N9tip6oDC/gnPDp1/njxTRGcJLLkJ+kH0LMsnZBqyRDUmBoIPel42rqFii0JucPfCzo5P/8RMOqHoGVG7kFJbMJr7VzPfCO4zkB9zRDVdb7gOKwFtRQ63XPcoKvkpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chm9mqzbgpbVnPEeOZgoLWO37PtUmrlCKvpvLIYNyKE=;
 b=O9ieN6bswFG1QWkp6OVfWN3sTjvKCBcEE7PRjlwLfHLhNetCwaQsKVc/ZvhMrWB0aal5WcLBvcN3BQMQkF45YWSiCP3h+YJtNbpyZCdHaYo2RBYW8cl/hRuwxbMaYV9Ybu+tow0ueeZxV9CZIZ2oo6qOR+KjCq+KfF7igAGPSIn/GybpEfLB4udYkeOj9Qir57WZhCI45zATseQZLIR76xS5TussV/yunSCW0CinFn6CaBilSau0DNPfPNRJ7KMGXbYRyPxDuJCJ96tIGtJ2c1yAcMdTaVOfpa1h5gdAllASKC1X0qvHLiHhKdnNuLj7/6QOcUFq+NVXM65P2LjZJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:14:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:14:34 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:14:09 +0800
Subject: [PATCH 1/5] PM: wakeup: Add out-of-band system wakeup support for
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v1-1-7ed2e98065ad@nxp.com>
References: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
In-Reply-To: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507262; l=3180;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Jfuw4ReqQ48yD6GVrAaD54bMaBD2P0dzQUqUpQGNgBU=;
 b=XkeqeMXqcem08nJneaFjlqAp4su+k81j/3DB1R/tWD/Qqgyv+h6KE2UvpnWk1nU9gmbxDfyFT
 Jglag0rAM3MCNMXb7bqypo4irMghFINU+IP5mwoV+qMkCEFypnSGfZb
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fb2e5d-7474-4acb-3865-08ddf97dc62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE50NVlNMlp3WUk0T0RtMjBWbWxHMk5HalBGVTB3QUEwTWlNZ01BQUJDSW1U?=
 =?utf-8?B?UW9hWHNSSlNXSUZYeTYwem1qRVM0dVoxVlZUcnErMU5rTnFZR0pkSEg4UGVI?=
 =?utf-8?B?dnVtdGpXdXNvMk5OM3NKajBpUUI5UjU5SkdLdUJzSzRDNzVEd1ZOTjRoMW1I?=
 =?utf-8?B?dytSaHVid3MyWmhycG9XTCtialBNTW4yYlhVbk4rT3JKN1ZXeHFXUTlpYzM3?=
 =?utf-8?B?S2t1T3pBMHFoYjRHZkFCbGVmUGtKdzZyZ1dpUjBMRjd1MTQzQk1CSzduaE5M?=
 =?utf-8?B?ei9hai83d21DbXN0Yi9Rb2lzaUxZOC9uR1VpSlZGSjR5NldTbUdxZlV3L0JM?=
 =?utf-8?B?MGZPbnlzd0RtMWZYQmlsZ1E3RnIrNlBONUI2MHBmcC9CNTZMWVVUaUxVZEE4?=
 =?utf-8?B?QkE0ay9WczR5djMxUjlaME1GQXRQaTczS2JmQmsza3RJQkh2Y2dkVU1UZzNs?=
 =?utf-8?B?ZFFndDVyaW9ZUCtkK2JxREV4V0d3eVozYTdhUW5OSUEyeUFzdGRIdncwTXhY?=
 =?utf-8?B?ZHpGNCtqZnpGcXU1Y29JaDlFd01xYVJDTWxBOHYyRW5GdTZ2bmpRdytmeDk5?=
 =?utf-8?B?cEt1TVFyU2VJTkhGdDhuTzlwZjdjRTJ6S3ZBVTg1aG5JMmNmS3M2R0hBQ0Nw?=
 =?utf-8?B?SGNQOENPREVjMWNVK2NQME9peHV4dEk2UGJRSGhabUVqR01zRURzWXVxSDMy?=
 =?utf-8?B?a0JRcFdONW9MT1d6L2Z2WEtGK3BDOE5xWGZNMWlnYUlDTmhLVGJqdFlwTVkx?=
 =?utf-8?B?S3ZSc0tZV09EbW5GaXZTRWlkSWpOR1pzdXI4YTlENytDRmJRTUVGRVlNaVBi?=
 =?utf-8?B?QkxidEYwZXpsNlJ5b2dCK0pCeW1NcXh0bk5FNm1rcVVnVUMwWmFoWFRocG1C?=
 =?utf-8?B?QXM5aGZpdm5YSnhjeStwcWd1U0xmYmVwYm9rbzRJT2o3eDBHZ0FrbkJOWkRR?=
 =?utf-8?B?OGVPQ0E1TmZDWDJhdzB5L3hZNTZUdkxBYWVqYXAxa2taSmNCNVNxVlVwdkNk?=
 =?utf-8?B?SFRieCtkenV3TzlwZkllYytFdEJoWXZtN0pNRThNZ29NUGlSK0VHcXJvZEV2?=
 =?utf-8?B?L2lrNUdGY212V2oyVDc3a0ZiYkg4eGlrR0pJME1qdTNtckI4ZUdkT1IvdHB6?=
 =?utf-8?B?WDBTK1lTYm5yMDd0UUFzbis0Sll6UU1qdXZDdUNIenRVazUybWw1N1RuUmxQ?=
 =?utf-8?B?ZGlCUTlvS1Z1eVl2K1pJRU0zbTlNQnh2a01ZM3hQb3ZEMktVbTRrTHBwNllE?=
 =?utf-8?B?VFJuY3BVeHY5VWJRT2ZkamtseEd2QnE5M09KTmt1Y2JxNkhYb2R3RzdNOUkz?=
 =?utf-8?B?TDg3ejBFWWRsbmRsUk8wSG44b3UvNjFPOHBhQTYyby9FT3N1cmdIdVE3b0pD?=
 =?utf-8?B?OFpqazRMMjVVclFibzZKbHlaNWFTYjdFbVhzNE5Rb0p2b2w2VXlTZ2w1QUI1?=
 =?utf-8?B?Qk1zM0VQTTJFZ2VtVlBuSmNQRkVzc1ZFRktSY0VUdDNuUGRNU0hoa29LbjV0?=
 =?utf-8?B?VkdIY1JSSDFwUXUxSTNCMVJ1RmwxZ3cyRFNsMlVsdnJFRVVaWEVQK3BDNXBS?=
 =?utf-8?B?ZFBPeUxwUDdtMVlIbTZFdVlpcE5BNlF3QWJFSW5haU8vcldQdnFjcDVUaklW?=
 =?utf-8?B?N2MyU0FucjVnMlB6ZjBtNjVWTWt2YU1LL0RjS2liYVhTdDFTZXFOaWpyYW1u?=
 =?utf-8?B?Y1pOdjhSTDlMMHM0MUNEcWU5dmFjRmFxV2tVeFJKLzVFbk02c3RZRHFIaCty?=
 =?utf-8?B?a1RCWFEyZmZaZUtrWlBaL08yYVlSc2JRWFhBSUgxYzFvTHpacWhITGc5eFdi?=
 =?utf-8?B?WWZVVkNaV21kSFgweHBKZHJrWVg0ai95SEczSDFENlJrbnpSOC9wMTJQUnJp?=
 =?utf-8?B?cFZQUzMvbEpJUjUzWmR5MGM2bVBEc0RSY05nU29ndUtOcm1IM2t1Y0JuKzZI?=
 =?utf-8?B?a2ZFc3JvcEVESkNaWEYvbXlscGdRSklXWkxORngycXlrUDZNWWh1MTdsWXlw?=
 =?utf-8?Q?FmutD+6oBV9DRERNHBARwSSkqi7gfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0k2THJNdG5XR0dqbTNvM3BzbTdHU2hoTE83UnNHaG9vY2E3ZkwwaDZaZ2U4?=
 =?utf-8?B?ZnpDQzQ3RWY4Wkx1b3o5U1VmQ2lEbFZiNG1HVXNKME9rbkZNT3d0ZXJWVjNy?=
 =?utf-8?B?NGlDM1JFUkZtRXU1K2piK3ZIemswQkcyU1pSZTZXZ1N2b1Z3a0hNRUN3d25I?=
 =?utf-8?B?RjVZR0w0RTY4clIrNkdvMVduUFRDOE1jVlF3RUZSQ1VXaEc0eCtDUitkQUI3?=
 =?utf-8?B?SWNuVWt2NEQzYVRJSHB2K3lyUU5hM2d6WGVkRnErOWVXcjBvS1F2Nmg2elBr?=
 =?utf-8?B?TENrZnllbHRrM0hPQXhpZEwwTkozKzMxZnFQVFJmVTlFclNadHluWitsd2JM?=
 =?utf-8?B?NUl3S1NmWEVPSGtRQmhzRmE4VzJRNnNMSmtPaVM4V1NRUG5mZHJmdTdJaUNW?=
 =?utf-8?B?aG9ZRnJvV3FZVnVEVkhnRy82VHpLYTl3aE9OeVZRNDVrVC8vMTZ4SytzbU1U?=
 =?utf-8?B?bmR2dEs4cVV5Z0lqaEZzeFhEenFlUWV6WU50dnFCVHZPeGowKzUvUEVXZ1B0?=
 =?utf-8?B?anVzS3FUZllGRnQ4MFBVTVVuUEtwL21KWm50Sy90a2tQTlZCc2lRRGdFd2hI?=
 =?utf-8?B?NEZaY0I3bXRPdExnT1ZnUFhaMnlTTStxd0hBUG9iYU55aytjNm9abnVnMlhZ?=
 =?utf-8?B?TlZrcHhFSzJ4b2VDQ29Vb3NTaGZSK0ZkZXc5NGJiaEJZeTMrb2xzMEpDNFll?=
 =?utf-8?B?Skw1aU9wc09mR004eG1Ka1I4WWk1b1N3ajJndndXbmNmRnFtUXhHb3dXRUFF?=
 =?utf-8?B?Uk51V2Jub0h5RmJGSmp0VVgvbDJua1JaV1BXalJWUnpMT0hsWmZyTnkycmc4?=
 =?utf-8?B?YUZPOXpjMnhYWmpySWRYMGVBMW5OYzhxKzlRSWhmZWhnM01IQU9EMVo4UkNZ?=
 =?utf-8?B?RjF0bWFJR1N2dUJPSk96LzVjZE15K2pDNHZ1WGFFMG02SnpWS0R2eHo1NVNq?=
 =?utf-8?B?WG1ucUdjQnF0a3VOYVF0ODZmNzBzM3c2NUpCMkRJc013d3BSOFhSZSttUmZv?=
 =?utf-8?B?cFRiUTQ0Qm83QXVOMi93Q1dqN3JXcmY4RXdmRlZZSDgxZDN4SW0zN25LeG5p?=
 =?utf-8?B?TU50ZFVobkFpeWJEeWhNQ3IycnZZTUl0WVZQSGh1b3RjaGxrZzJkOWJYd2Zs?=
 =?utf-8?B?dHRGVmZFT2tta09KMDN1R2RyRWJMZFVGM0FXMm1EUGZyQ0p4SUZMRmVKWjlt?=
 =?utf-8?B?cnVETDBDY3BMd0cvZWlJVTVaVGRNYU5PbTh4TWI0SFdLaGllcmF5c0ZsVlFO?=
 =?utf-8?B?QmJjeCtDUnhjMXhhQjI2aEhhUTVwQmdUMWY0clByb1ROcU12WHVocnJxaDFJ?=
 =?utf-8?B?dFl1S2tvYlNIWjJ1WnRkUWhuZWsvbWN2MFZJSVVmeEdFTno3VkNnbTR4UVJB?=
 =?utf-8?B?THR6YzZudjlOaXJxRVk0VkJzTC8yaktORDFvT1RsaVZZQjBudzFJUlh0R1ND?=
 =?utf-8?B?MFovTC9EOGNQQko3ZHE5dXUxaWQ0cGIwaUhpVmlLVzUwYXJkQXlpdnZQd1lm?=
 =?utf-8?B?Q2JhTklRbjFMTkh6QXhzNGZUOW9MSkpta1VxbWxWdG1lbmRoRnlMRm9hOGxE?=
 =?utf-8?B?WXp5QUJ6bEwzUlFQckN4MVNJYnQ2QnRBU096NlUwZkFCeVJ3dXN0Zk5scEk0?=
 =?utf-8?B?RnRKNU53VzdBN2VVUC96VmNvcHA4K3FVcDN0Q2Q4RGJpV00yc2JPMnpIaHpV?=
 =?utf-8?B?TXM0d0UrdUREek5qY2NmTHEzMmw4NmRRRnNrOXpQYWJHRzV3YlAraFVKQ3Vh?=
 =?utf-8?B?UjZFZ1Q4UjR6OE5FYmovSS8vYVYydXdubGxOSmFBeDRZSDVFWld0WlBJZ0FC?=
 =?utf-8?B?clQrM2lDU3cycFBwZ2tDZVdzd0Vpd21SdWJXaG0yYzlVcWh2b3NJWHNhTit3?=
 =?utf-8?B?NUJ0VTZRbitkUTAyN2ZNYVFrMmYyVGx5SjU0Rm9uclJzc2g1VEY1SkxTN0pB?=
 =?utf-8?B?WVpRSlBaUWJCVTRwN1Q4MXR1VTArTkQyTERycXdaOHlaa2JaYmJ1YUE3Rkpl?=
 =?utf-8?B?aGxUdG9zWE5GR2tqSTdha1c2dGJiOFV4dER0UWJDdlpKNDRlSnU2Ym1ZNnNW?=
 =?utf-8?B?ZDUrM1M0V2kySjQ5NThJK0pZdXExR0xEelAzMVRFM3BuenFRczJjL20rVGNu?=
 =?utf-8?Q?of2KgVIkfQGCLEUY1kqEwxgvD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fb2e5d-7474-4acb-3865-08ddf97dc62d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:14:34.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nneoj36cxQGf1YsucWB8VU9xZ1jGtKaCrpl5yq05Q1LOgru6v3wNcCUF3MxKIjrrkasa5Y6G360rQupEPfek2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

Some devices can wake up the system from suspend even when their power
domains are turned off. This is possible because their system-wakeup logic
resides in an always-on power domain - indicating that they support
out-of-band system wakeup.

Currently, PM domain core doesn't power off such devices if they are marked
as system wakeup sources. To better represent devices with out-of-band
wakeup capability, this patch introduces a new flag out_band_wakeup in
'struct dev_pm_info'.

Two helper APIs are added:
 - device_set_out_band_wakeup() - to mark a device as having out-of-band
   wakeup capability.
 - device_out_band_wakeup() - to query the flag.

Allow the PM core and drivers to distinguish between regular and
out-of-band wakeup sources, enable more accurate power management decision.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/main.c |  1 +
 include/linux/pm.h        |  1 +
 include/linux/pm_wakeup.h | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index b9a34c3425ecfab038097e2c03645157af2e598c..6b1ca729dc3e34292952c9c309aab3f34a0a664a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -2124,6 +2124,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	device_lock(dev);
 
 	dev->power.wakeup_path = false;
+	dev->power.out_band_wakeup = false;
 
 	if (dev->power.no_pm_callbacks)
 		goto unlock;
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
index c838b4a30f876ef5a66972d16f461cfba9ff2814..41e8f344a20563898e827da62dd240b8cbe657d2 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -94,6 +94,16 @@ static inline void device_set_wakeup_path(struct device *dev)
 	dev->power.wakeup_path = true;
 }
 
+static inline void device_set_out_band_wakeup(struct device *dev)
+{
+	dev->power.out_band_wakeup = true;
+}
+
+static inline bool device_out_band_wakeup(struct device *dev)
+{
+	return dev->power.out_band_wakeup;
+}
+
 /* drivers/base/power/wakeup.c */
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
 						    const char *name);
@@ -162,6 +172,13 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline void device_set_out_band_wakeup(struct device *dev) {}
+
+static inline bool device_out_band_wakeup(struct device *dev)
+{
+	return false;
+}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}

-- 
2.37.1



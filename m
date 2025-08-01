Return-Path: <linux-pm+bounces-31719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C0B17BE7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399071C2686D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EF1F9F7A;
	Fri,  1 Aug 2025 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9CiCncj"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5A1F4E34;
	Fri,  1 Aug 2025 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022905; cv=fail; b=hYl7RloKWMVfH9QB990rJRjItLDvEviO20Y09Oz7dxKNFakcm0lrvdLuLXex2euSKnaQg5Of6g95Mgxl5ZZU5b4sSy0J+mzDeeuhlc5kLGrnVyz52FqwwNVDyufNjrvu1xEf+BK3TNuOUNXarCnVYXt/AiNex8+99rXwFXWHh/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022905; c=relaxed/simple;
	bh=98ErKuVbLiEkWEGOGeE9dPghbgVTVYSB61cTBYhchuA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g672R7lVmv7A6RvC2LkK94fKCGyGlS7XAQMkoajzo/AjxtDLAqy+4xhd9hcdYRbx7CEYBO/N3aw2G8tCL0OnJl+dDpRGIJ7p02roojfuxrLyjpvpD94b3h+bEWrNV7T0A/YyO8OIUJBNMXjveS5kHK1wl5ag3KFMuyZ+YZN7iSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q9CiCncj; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO1o1FBmv63hbx4Abdq8sVlM0rbNOzGytdS06B+UdWPPuvYiUzKxW+gplMhC8cX2+fvJKj4SR3tlMKKbjyC6dGZuLbzW8oxhAckUbSENJU/B66pHQNYGxk7ngEssNz4FwB5jsDxQOyhBCHcq4MQidhNq3qLkWucdja3UuAMoeydnIPd43zfEto5EDNpNgO6QOuaz6qMYPTJVLeHXnXwJB79F3d/gPdbP8DxCHog0PoH0WFFRBv0fBBuAU8PoEZbdBYrjatFXvOIjssXuExuespdbO37ZNz0cxIJImwo0I2QaNbhd+ND8kOBjK4XLody0VkKhEOQDhUYZS1gLCqef3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hoOIaZzOflEu0ETEPYYxF1bPwl0BKl79gbISVqmorM=;
 b=mWNuGkhf9swGanqGlJenNIVEqluR1bDE7kG1tZCkZp/KePR2NUlF4vcCXpteyKhYbH23jTR5m9j+wetKvSA3xsyIl4GEib1s5rAnZ8YPSJXxbp9feeKhq/kMZduo+J7ySV+w6bbm6s97BvOBH7+4F6sY4BhG+zXBlFe8tMkY7f8JYtiijRjtVI1WcpylSABUqzAEnwVO4jpQBFog7Yn+AM6aDCZgA+C5HdUm3DU7QJG91Mqujwb6v8g6igMYGlB15DyMwc/OkwZyyEasiZMaYuy9gBIxE+t2g5ZijFkAlCiaNPGF2/IPpw3WOV9u56uG5UdsoP1b8rHYkU61/PVlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hoOIaZzOflEu0ETEPYYxF1bPwl0BKl79gbISVqmorM=;
 b=Q9CiCncjf5cv+v0raOt6nSJGq3fbCYg69ujRchj+HqndppKtyoA/e/HitOmONxe8HIpJkRH5pxV3bQCmzsP1xzibsWNg1JfkGYbQU3/ubxhKfxuZcFEYOJA/dvFtxozQI2G5SaDW23pKO5NKN/SZ8AWFu9GKud111nppPKmbwmXbyD/usJYshLm1VcNiQ7U7X25Rm08+d9k1S/w5T/oQI83IvF5ic8Iv6VYVtq/VSuKO0jcWaJ2j5zvt22i49CqwCqyxUIkzxu0vClQdUYIzJKuHvj+l0e6uvk4UG1Llv66724xWnEI1HNnRybkH3JucQ1eZLwtLiOGNyN416Q62XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 04:35:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 04:35:00 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 01 Aug 2025 12:34:23 +0800
Subject: [PATCH v2 2/3] usb: chipidea: ci_hdrc_imx: Set out of band wakeup
 for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pm-v2-2-97c8fb2a433c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754022883; l=2458;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=98ErKuVbLiEkWEGOGeE9dPghbgVTVYSB61cTBYhchuA=;
 b=E9C+1/kTXHaTSccy1D86pYsnkrGNdlsNUZE8QCJ9I/0MIPRCmNOTdxcdtFASkC4TS3++v/aAZ
 e3H1sKpjfO2BFTgu+UkEjq52KrVP+3ebFaVhc2Dtnl+YJFiIk8u8+05
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
X-MS-Office365-Filtering-Correlation-Id: bf71f72c-81ea-4f00-29cf-08ddd0b4c69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUhCUWRwZ3BMTDRscnduMEU4UXlUSmtMeE1Nc3JBalhySVZpK0FkWE5KcWNI?=
 =?utf-8?B?bTVYV1FaMVl1eUFGKzVtaG9hWWUrSWVSWjVsaHBPWi9MWFVTRzVBd1Zwcysz?=
 =?utf-8?B?bFo5RW5XczlFTGxCRit5Y0Y5OWZwTlEyVWgzS3ltSkx2cXprZXkxcWh2SVdZ?=
 =?utf-8?B?a0tVRVdOZDdHNmhDZlZVQmo3bS84Vkd4VTdSSFNJV0pWbWN0dVFQZDREc1c4?=
 =?utf-8?B?UldDeHlneDh2S0h2bXIwS0djZ1lwREJGcmwzMUVwYmNGcUMxUk40VTg1c3Z4?=
 =?utf-8?B?aTQ0OThESWszWWlUSjVtbnpvZU90Vko5V1R5dTFSVjN0N2JWNElYNlp1T3Nx?=
 =?utf-8?B?N2d4SjV3S2NCa3dmZURWQS9tS1k3UEYrTFIxbVp3UC90Q3pBS1orOE51WUF4?=
 =?utf-8?B?MDZXd3diaXk5UGRidGtmREdSd0h5OWJlWkVaTlA1U3BYRm5Ba2xHTjJMSXNF?=
 =?utf-8?B?c2ZhQzhRUkUydmxTa2w1RzRWdWpXZWFhRUZuSjhJVjRGb3pPSG5ib1FEamFj?=
 =?utf-8?B?c2I3R1RONEJxTkF1L3RmcmFXbUcxNXpKVUJLN2RZQVdNODl0MU1WN0ZpSjBv?=
 =?utf-8?B?em1VY0hjeGtQRVNha25DK2NIVGc1aTM5OUYwUXFWOFV0SlVkTVNvcFBBUkhQ?=
 =?utf-8?B?d2J5MWhaUTd4b2RKVkc3L1BNY202VlM4eUUrUHFFaVRrbGhkL2szN1ZjWWxJ?=
 =?utf-8?B?YWpKQy9rdDRnaTNVYjBSb3ZRQVJ3UnpwYzhOQ3J3WUd5K1duaXRGQ1Z1dHdX?=
 =?utf-8?B?RkFmSVFZT2dRZzJEN0RsZnRsU1NNVnB1U3pqb3p1OHN4QWJMaExlLzFnb0cw?=
 =?utf-8?B?a0xWNUFRRlByMjJpNTJqQjgwZjdFVkIzdGJzakJwNjNRS2N4NElwUlJ4WDZo?=
 =?utf-8?B?RTRscVF1VE9YL2pIVU94d2FqRTdscHAydWI0OHNXWW9FN1RpQkI1N2IweDVm?=
 =?utf-8?B?ZE83VEhseGYxRjdFbXhsMndMZURjKzd2QWdlekx4dlJWWnpiVnBnaWJqZjhN?=
 =?utf-8?B?ZldnS0ZxdHAvZEdaaUxHek5xd3pCYnNtMW4vSk9EMkh2Mlo1ckFKNk1jbisx?=
 =?utf-8?B?L09obGtOcHNvUVRUUGFnY2hWUzR0UVRzN3lSdFRGa3ZKemc4THp6SDZ4Y1Rm?=
 =?utf-8?B?VW1ubWdjaGxUN3BJZUxQNFNmYkk4TjFMUUNRamJDY3h1cHNrNWxxS1ZIaEdx?=
 =?utf-8?B?ZzVBa0VjZE93K3NSNldqNUgxaU9yTHBQUHVuRzdQd3NHQTVOSFUrdi8rLzUz?=
 =?utf-8?B?N0VvZG1jU1ZYVjNOR21VVDhHdllyUWl0TVloYnNKZ1YyKzgxUEJhUndpOHdL?=
 =?utf-8?B?bzV6Q016ZkU4Q0ZMNXhHMTFiRnN0QUdncW1HT1hXYkNWMDZUcjVKeUUwRUtF?=
 =?utf-8?B?OXd1ekFPN2k5eFUxa0IyYWYrcCttcjlVWlNkWkpJaGo3UklER21GRHhtL0lm?=
 =?utf-8?B?K29BWWNhdmpYRDh3WG4wVmNsZXk0cDdkSGRiSEdIZ2tZUklGTEhmQ0JYcUZH?=
 =?utf-8?B?VTduVlpmQituVWdoNkJOQmpFTmRGN0grWGJwYzhNeWowSFZmMHFLVlh2OHlt?=
 =?utf-8?B?QjJxWitVZGUxWmZNclVIMEljZFR6RWpjSjNpbzMvZm1DbGtqWlA0MStjTTkr?=
 =?utf-8?B?WW5xTmV4MFI0ZmhKSGtNVkE5dkJEc1ZsdWhYVVN6MFBNSkExSURnR3RKWUw1?=
 =?utf-8?B?ZndkTm44Vzdhb0JoaE04amVRVmlKQmhDaFdwMnI0akF0UmZOYnh3cWluYXpN?=
 =?utf-8?B?T3NlaG5PNTRQb01QOXJhK1hmVkVjNzBiYlZXbGpFWEVEbUpMNEhOTHBGc1VF?=
 =?utf-8?B?RW1mc1RSSENRYnJsYkJtakI5ZFFPNTlPRDd3c09LaGdWTUorSnBRTUhONlBR?=
 =?utf-8?B?TTA1UDNRN2cvamVFN0Ftem5jVXduOG4rTjlsTE4wQjNUVmp6d0lrVzcxQUNn?=
 =?utf-8?B?UzcrSHQ3N2ptWDdOZlVUb0tTbHBiZFNGWlVmQWZJNHM5L1AvZzBMaXVkU1dE?=
 =?utf-8?Q?US+AA7zudAjsR5fbNRgb/t46A5ziuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXpTdWxoeDJUZlp5VFc5bldzUkVYbkJ6Qy81ajcraUFKb3NYZndNYjQ3MlI1?=
 =?utf-8?B?UHUxc3lERTltWmJHNkJYVWxlaFdtVWdjellxd0kwTGtlSWdYN0JoaHZRamhW?=
 =?utf-8?B?aTlCMzlpU1hqSHFjdmQ0RnAwaTVjSXVwd2JsK1VwRlp4STNPRHR3aFN2Z2RT?=
 =?utf-8?B?c0pTQnZWRlBFSituanJVSVBLZGFrQkxkMjY5THJWY3pkZUlaaXozZXdjNnlt?=
 =?utf-8?B?c2xwUDFwNlZxRUg1WHJWMjRDTEY0YTU4VE93cUdCWnlhUGdZa1BOaVRHY0tr?=
 =?utf-8?B?aC8raWFFaDNKNGZsVkY5bFB1Qzc1R2J1TnlEK0h1ZW1id0tIalNFK0t6TzJk?=
 =?utf-8?B?Tko0OXJPbFg1R3FXYTM2bDdob09hcTNSdzY1NUl0Rjd3dDVzTmNsNCt1QW1D?=
 =?utf-8?B?ZEtMWG5xSmJ4d1JnU2hsaGlmRXdhNUhWS3VDZ1pyVnc4bFJiYUEvTXlydnE1?=
 =?utf-8?B?R0ErZjJLWkZxc2JBalBscjZZUUlaeEZSeTNnR1Z6Wi81U3p4eVpEM0dZUFVs?=
 =?utf-8?B?ZXRubjRiOHJ3TklXZUV5dStCaFZoTjVRUWlhdjg0WVVBK3NGV0tOMlR5aE1o?=
 =?utf-8?B?SEh3R3Z1ZDI0b0lKSnQweUZjbmNITmpyZ2xFdlg4ektZVXBZWGNVbWt4eW9Q?=
 =?utf-8?B?NHU3L2FrT29TYlpDRk0vTzlWaTlCWDdLMnM0MlViZG8ra2FPc01ZKzFPd1gz?=
 =?utf-8?B?TDhXR3dxTmlwVVBienNpUysvYW9YRDlMTjRmSUVadnpwUERqR1l6dlNjbklr?=
 =?utf-8?B?RG90emtoWGNzVngxZGowMUJNdzkvQndzTUhuVEVCamNJUDFNaHFua1JaNFBR?=
 =?utf-8?B?N2VhTEtWZCtjZ25lamkveFphdlJmZHZJbDJUR29CbkFxYjBUeDI5bjZENnBF?=
 =?utf-8?B?R3Q0VUUzSDZaOGpUOHphckd1L0lKZy9UV2FHWjdQTEdDcWJGYW41aXIrZEd3?=
 =?utf-8?B?bDlEMnMzZ3lQdGFtclkxd21Vb3grT2FDaUlEb0tZNGhyWHZyWnNkR3ZibVVq?=
 =?utf-8?B?T1JUOC9rbmJqVkZvRWdWS1k1b295bXhUbEZlbjFoeGZTNFJHd2ZYTlc0ZDVi?=
 =?utf-8?B?ekE2ckxHczNBLzFYdEZhSmpqTWdDM21mczFqQkR2OVJJOS80eE9TZE9XSHVw?=
 =?utf-8?B?WUxXcWw5b3JiSU1qdmEzNit2dENIQTY4bVFKbW5oNHRoQnVJSVJXWXgyaW9P?=
 =?utf-8?B?Z1RWbFZLTTFoWHdwWnhPN1Vickk2amE2eWpkMWlHYW1uSStva1NXVXF4Nmh0?=
 =?utf-8?B?b2FYUEQ5dVcxdGE3OStWZnlzT2JKVGxseVdCVHdiUVR4cmpLdlZBZlhkUHVC?=
 =?utf-8?B?S1IxT05GaXFNc0lpdzJ5N1UzeFp0YzNWbTBmSC9Rb3NURDRaNFhMSWVWMGhY?=
 =?utf-8?B?aHhQZklYRUtGQWJyZXViV0F2RWhWSmR6RlVkVjI0M3FvdGRpdENYMG1sN1RS?=
 =?utf-8?B?NnN5N2VNVDdacmtUODRJWWxvR0xWTUZ1dXJlT1E4YlpTVGlPNjQvU2haTmlr?=
 =?utf-8?B?MmJNclVEQjF3VkhaTGhkSmlWU0dheWUyNnpjRk9mMVRxWnlsaGx5RXRFWEEz?=
 =?utf-8?B?ZTc4eGQvRWFsNGVlTUpKVDdVMjBLMWdjRUxQSzBqTGNYdVo1d1NrL3pRWU83?=
 =?utf-8?B?L05lb2s1YmVtWU1qZTFGdW5LbjA2d3F3RVEycVUxaCsyM2d4S1N1S253clhz?=
 =?utf-8?B?T3UzaU5HMVg2Rm1aUTlLdHk3TlRQU0dqcXp1MUc0a2h5QmJBR2k0a0d5Qnlr?=
 =?utf-8?B?UjhBaFA0b2xhSFFabUxJV0JJYmM0Tmpsb3l6elpUbWY1V3IyYVlFOWVkalNx?=
 =?utf-8?B?SXpPUHdaNWxiOHFZSkh5am13cHBYb1N1V3YrWno4UFVNU1RaczNWN1JYQ3B0?=
 =?utf-8?B?MzF5Q0swVHJnamVPVTlKdE10ZmEvdGIxR0Vlb0xzc09JVGRVYk1ua0EySnUz?=
 =?utf-8?B?VXpWckI3WHA5ZVJqdTkra3ZaQzJsRzJPekxST29zYWtSdzRpYUo3eDFIZFVL?=
 =?utf-8?B?SFllY25aWFNoLzFtc00wYU5MRVJPS3Rpb2RhMTNsUWpBOUYzRXU4MWN0TUpB?=
 =?utf-8?B?L3FjL1hTcWNxeUtsWFZrTlVuRjRUcjdITjZXUXJBYkh4SytaZG5ZandRQ0Fl?=
 =?utf-8?Q?L3sKKXu2X7szQSuYX6ENFgkgt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf71f72c-81ea-4f00-29cf-08ddd0b4c69d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:35:00.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g16a591uejYQda3WIIJsphK9y7wtbnjrppTUXK8EQV/iDTDfAehRKWNM6eoyKhM18vcq4zBw+nr8YHbX+tNZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
wakeup system even if HSIOMIX power domain is in off state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
 include/linux/usb/chipidea.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index e1ec9b38f5b9ba0568101b51fbf16b99461b6ee2..7a3360d8a0fd065394393de829108a12c27c85b9 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
 		CI_HDRC_HAS_PORTSC_PEC_MISSED,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
+};
+
 static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
 	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
 };
@@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
 	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
+	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
 	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
 	{ /* sentinel */ }
 };
@@ -569,6 +574,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	device_set_wakeup_capable(dev, true);
 
+	if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
+		device_set_out_band_wakeup(dev, true);
+
 	return 0;
 
 disable_device:
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
 #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
 #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
+#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1

-- 
2.37.1



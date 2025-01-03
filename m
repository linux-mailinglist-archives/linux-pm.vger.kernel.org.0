Return-Path: <linux-pm+bounces-19937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F5A0062B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A7165283
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAD1D6DD8;
	Fri,  3 Jan 2025 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vxTtPFsk"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34E1D4339;
	Fri,  3 Jan 2025 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893792; cv=fail; b=lRPLQ+lBWc8H5k6URjWlPGzxgGsNP7PzunQS1tgWVs+3Pmyua+r0ZsqjQ/AQNCw8rYFvEOwTp9FysrM+RjloEdZqSM9ZD1Nxmurp0DB1YEWoYmSrR3o77UzEKvAcDb8NG29f9oWSgW5YDWtOoEEWD0YOID4SLcq6ioP6lE/n1rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893792; c=relaxed/simple;
	bh=AcWk+DTl4vJlEoX1Fz1L2UUCItL1uFcWaPK5Bz+U1lU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OOfFHxLxeq2nEqB1FEH4rFJBg0Ra345pVbbP98BkUIGm6p6h4IA2WeYxr58xNEb7pTbbegfl6r3HGzYCYVuARAsJtwlHwnJP8n37Brn1OY1M72IAw9GPzgMTbTa/mvXyyFYOPdMZpKotiTm+kEasQwkSz+xPA4u9o5zjenD2+AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vxTtPFsk; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQWhPDj1ofOw6tAbwxQfq8y7SsMShquk/MtqtByTVkNA9Vc9pVvpZpP8Z6YJJv4bSZXruHE7oWL5E4dzNaVdYbobLU1yxv4nW/Dfx9K3RepTJcqJMdS0YHcPFfuoXlxm2/c3mE5aC6phLfiYB2yavJR/nYbBRLZ9RdgbviTSooASvh+KW0lGgd6/xq83zxTaR2Bm3eDbNa57Rl4fWlOjXTMphnBVcoy8WeO8w90u4Ouu/n2uEoLtx7Mpp6BS4xNeFZLIGT+1CJ2ihrqTqpnKMHJa6BXGCF+ZEFHCsnGIWAp6QwIi6H7h3No8CkrpgFzYZZxIbzq3Tbx5C4BwfC55EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwjZqLy9UAzAbl6jmLkoboiwEpYZWe0ARcy3BM/gy6g=;
 b=Ls1klEqDwOGqx+74HAzT8Q09y30G/aIXIA51Dkpc7iF09f18N16idakmdNhFM2Z/v6m342eFUMk2ML2f4saShR7xUgaeeujzH6q5M7lpgBFlKbMcFdRpjFgFv2TbD+anH0PZEvCKF9Pa56kSNcsLahu3FgS6n4fDAHP0HYglbC5q1RAr9CaG9zuTjrWmDnynvQzXeUh6s+tVa4fO5ooOyquSNvk3zD0ejj1YkTMKe8kZ9NeaHgmRfmScmsu56haPpBScnTc5ZIbtwTa4IthVBL+f4ZTcqT1olC/ZwKfT5eSxVXifGAZ3AKvNkPtbRmFPHe75pnlfdOKRJ3/ucmC8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwjZqLy9UAzAbl6jmLkoboiwEpYZWe0ARcy3BM/gy6g=;
 b=vxTtPFskRMLEgHTyP/fgpcXoOnZE1EqlrYdZ2rMxNKdrjgULKw6PTiA0yxz3Uw/Bxxfmqg7Q8Q+D+JkkbClTC80gWGg0rdgqcIBvWqzD+Q7+R+/igdZgIU/OyKxyP+/wCOKnFCpoX3VY6brTJX0PM7bQ0bpxZK6tnj0rkNjKQ/kYhoCXxbWB0fqzaKPw8iv62R3HUYewE5VbJQekz/9REa1wkAqJhmccyUcrCSVBpF+C5Dq7NUpZ7ulQgUVrXw8w8+le7flSPCKKtNZmmaNT2hz1t4rM4yyN6rX9RCu+QfbAgPprYFeSk01dpoKE2dT0Dq7DwJIuUSLtu8dXblVBEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:43:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:43:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:24 +0800
Subject: [PATCH v2 12/12] rtc: pl031: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-12-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1457;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=836X+TA/l2wfm7yon8oTf/+NEC4So+0tkKKh8ZKoqD0=;
 b=wPNPC7HHmF7S3u6pMjmQqPHx6RwH3WIKfRhJYkNt9qByWhu1R+qotgzVAjq/sEWPG4hhwi942
 RKN2EzFG34NA0T/RCWXd5Lugy7TNOKAcYWyHlzqRweLvVc2ZyR8wknu
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a94550-10e6-4f5c-c545-08dd2bd2a28c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFzZmsxcEJ4VWZMSVQ2RnlJblJ0QkE1SEdVUlkwc0grNnlNakQ3My9JWW4y?=
 =?utf-8?B?MkUwblA1Y0dyQnBacnlYZ0d1Rm1lY1NMd0lXZ2xETElSSENVS3FtSXpZdkpy?=
 =?utf-8?B?MGJvNVM2UVpmVzNpcExiR3VwSFpWbno3bVN1ZmoxSy9zYnpra2pLRkNhY1Y1?=
 =?utf-8?B?SDhzblpXTFJ0d2Y1Q0U2L2pmTThoT3FrUkFwQ3ZGL3cyaVFTNDd3ak40V1VR?=
 =?utf-8?B?TDNsSFM0MHJpSTdoQ1RONmlObG8zQysvSENlTnhwQlRGSXJRU0F2WkhWdmtW?=
 =?utf-8?B?N1lGdVZQZUJaOXFOS0FkV25obFU3Nm1MeFdLWEovSVdscXlFRW5QcitLcDdC?=
 =?utf-8?B?b3l6YzRmeDBjTDBIdEdSbDdNTWllQmZ4TVlKdjNmaE1ZMmhUalNuYlpqSEdv?=
 =?utf-8?B?b0lXalpyNkZ3NGo2WHAyTmUxdHFaeERtczZUVE5nanNkN3BWZUdqbVNBVytY?=
 =?utf-8?B?QURTSi9DQVEzWU94d0lwV2FIMEhXdWRSRURkckFvUmgwV2hWTkFLck5CU1lJ?=
 =?utf-8?B?ZmRRaVovTWpIREh5dTdCM3RFNXV5b0I4azZxRTJLclR5ZG9VZ0laZVJmU2w2?=
 =?utf-8?B?SGgrbDVDNWw5bEI2dHREVG9vUnhYWC95RFk2aGl3Q0FFejFqZXV5SjQ4QW5t?=
 =?utf-8?B?eWdDM1ZGSDZab25wM25QZjNETTA4NnFuc2piM0h0cFpjangxaE5aQ21oMmVS?=
 =?utf-8?B?ZjVGZSsvbjIxMWhBNlQ3U1JjL0VlZHlpczliaWdQMVA3b3o3b1N4V1BhbUl5?=
 =?utf-8?B?RTF3Z2dxLzFLRTNFQzFCMk4vc3d2Y3RIekxKRDQ3Ymh6cUFneWdBVTFtbVZy?=
 =?utf-8?B?ZjEwMDJ1aVpsSW5yc2Jtbk5PZkRNN01ONW90VlVtTGVWRXhDa0pKeXRZaTFx?=
 =?utf-8?B?NngreDlxdGNtKzRaM3ZNUlZEdkhwNXVtSlhqSXVzcG5yTm91WGlsK0lEMmgy?=
 =?utf-8?B?dVVJdkJTRFFpeWl2ZTRCV2loRTFIeTN0TXRFQ2diWEZxMERkVlZEdU0xTXM1?=
 =?utf-8?B?Q1Znd1hzcFBWdHA1RVVkMzFWT3MwWi9nRU5kMjRmeVkraXdicGsxam40UXB4?=
 =?utf-8?B?QWQ1SFdLa0hSSDJCVWVGR0ROdDliWno0emwvTXkvVTlKTHN1eHZBMFhsNCtD?=
 =?utf-8?B?Rnk5bjljQWZpOHcwNU9abVhCR3BhbDlpb0Q1cUg5dHovZnppRmxVcFlIajZI?=
 =?utf-8?B?Nm1zL0RaMDdITGFDdm8rRy8vaS9zODJCUGdsaDBZb3FLSTRSbEpOQlk2TS9E?=
 =?utf-8?B?M0RLSjBwZC9vSDZ6c3RyME04UEl5Uk5wcFY0aFBIRU85ZkRwdmE3Sm9YeTQw?=
 =?utf-8?B?YUFBcVVjaVBaRXR4NUlqMFdtUUI4S2Nab0lWWUpEVnFyWlZzbERIMGhvZUFB?=
 =?utf-8?B?Nk14WkNybGJEVEozOUIrWnVib1hmdSt2d3RwRGpCWWlOMFVCUHBpV3FGWE1w?=
 =?utf-8?B?L1EvUmJFSjZHWENTbGxjUG1samEyM2ZGQTAzak1jaTArejNCbWx0ZEtGWVRl?=
 =?utf-8?B?YTQ4RkRLTm1zM1ROa0pzcmdIZWkxemo3MG9lRUhWWFYvVWlsb3dnRGpGNGk5?=
 =?utf-8?B?OFpBaC9mSjVta2NPWmlyTjJZMjVHMHBRTHJXc0ZOdkdMdkJBQmlPMVR3bU82?=
 =?utf-8?B?ZFU0VnFVMUFTUW5MS25PZFNXbDZVVE1zVkxsVTVpMW15dTdkR1lVRGVkc2Qv?=
 =?utf-8?B?YlB4WS9TczF3MDdCWG9ER1NlSHUxZUlVbzRPS1dYcFFWT2ozS2JYMWxCdlRG?=
 =?utf-8?B?UjRmd3hkSmdIUHpQRG5KMEFqOHhyNGVVajdpOS9veU5ncUp4UGc2L0haS2xK?=
 =?utf-8?B?TUs1cGJUeUZSc3IxVW5WNFhqMUJ2bmJLY000WDUvUXFTY3NzN016Y0d5ak1t?=
 =?utf-8?B?anJpdE5Dc0h1UG80TlBBOGtTQW92U05HYWNYV2gyMzVxVTY4Y1ZmS3BOY2dn?=
 =?utf-8?B?SDVBQ3BDTGRmY2oydkJQbDA2SjNRQkVmSytVUWFGK01JOUdBYmpTdkV3aGI5?=
 =?utf-8?B?LzFyK1ZiOEFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGkvekZpTVpVdXNUWnZuSFRqeG1JZFdQYWpOcFVTQ2lDWXRjaURSUkhlN2U5?=
 =?utf-8?B?N3JraStOSWhCN0VXVjN5OU43bkljei9TU1d4aDBoT3VKMTBsR0U2aVplc1Az?=
 =?utf-8?B?YzZkbCtkdDRjdVhiWUNFejVXYnk2dzdZVklRTVRhTUxKMXp4Zko0elVsbHhZ?=
 =?utf-8?B?Vk9ycGdHZkUrT1M5Q21IeEc0dXE3N29BZExza2EvZlR0NFlyWXBUNjhkNG9H?=
 =?utf-8?B?WEs4VElDbFN6Wi9BYzlYL2VRVXFEOUYyNHgweFlQTjJjT0d6L1FkUkptUTYx?=
 =?utf-8?B?UC9RS3hqTmVERjRESHBudTI3VjBYTWlKc1hFaXl3Q0NvSE81YXV1RnBYdTBm?=
 =?utf-8?B?ejY5bWpKNE90OFRrTHcxdWVmanp6ZlZHeFlLSWQ5UEh4ckxLUG5JUGNFWHpO?=
 =?utf-8?B?UUdONmU0UitrL3NERzVCSmdJbW1JaUFTbVQvRVlQbVFFQkFmTjVwOStiTmJp?=
 =?utf-8?B?bEMxcGY2em1HTlpsSUtVR3QyZ3dOMjFmZHE3VUdlQmdXN3MwbHUvdXVUa1BM?=
 =?utf-8?B?Snlidk55Mi9WMHpPU3VaUEFYRUdRR3dzTHhxdFFSOER0dHNPK2tvZTFqZ3FB?=
 =?utf-8?B?T1VTNndvbXd0cTZRV3RMSmp0ZWk0cXJ6WlBsWWdvd0FYY3N0R2FEYWIzRW5D?=
 =?utf-8?B?c0dXZlNBNE93dUhEY2JGN3pDK2tvQjE3QW1xSkNFNlo3SnpydTFvYmlaaHFz?=
 =?utf-8?B?V3p3cGZwRmt3QkQrdm1kdnlqWUtXZThab3N0eGhPWEFQdUlHWWUyNDBkeWVZ?=
 =?utf-8?B?dGpqZTFEcWNKN1ZsaEhJdFJqNndNeTZxcDBXd2lFZjBpeTg2ck5mRkRHbVlF?=
 =?utf-8?B?bkcydHNmdDc3bmFlcWFwbmcwc0l2NVpyUmxFdmtQeVBpbVlwQXVLc2hXWnBl?=
 =?utf-8?B?TUxtMlIvRm9GUjZOVHpveFhCVjNLOW5weE0vZjZ0SFJIYlErcnJTWnhHVTFG?=
 =?utf-8?B?OEhFQmtHd1ZVRDBQZUtQQ082U0FjOGhPeEZFbzd5akdFblNBcnZzU3NhTzYw?=
 =?utf-8?B?Nkw4Ri9BMHU4anh3dkZOaUgwRlYxeU1sQWVpR0Zod0t5TTVMcTBJRnI2d3k4?=
 =?utf-8?B?Y2psVFVqdVFXdzBlWmIraHVod0I5WS9QQXEweFFDcE5ObFo2TDZrZXdkcUtY?=
 =?utf-8?B?RWZobEtoQUsvVEhiTWt1d3VMbEdzS2VRQlM2UHEzZFd5NmtIalRNZVIzcGYx?=
 =?utf-8?B?bWNzSHVEdkdJUTJSbWxnZEtTdFFSYUo1b1RPSW9tS0tIc0lEUGtRVWIzUVVI?=
 =?utf-8?B?T3NGNGZGcG4wTnN2YitSb1RmQ0lqcW94OXFmeFVBME5KaUZqN0NQMWlQS0h1?=
 =?utf-8?B?Z0k2TWVsaGIycHREMjB2cEtYeTI4QlVCM1pnc3VIOWhMNkxuT2tXL3dCN1NP?=
 =?utf-8?B?WEpTSVpZcWo1cHBRWjF1L2JSQ0NVNWVqbGpzTWF4SklvQ3k0MXEzVTVZWFYr?=
 =?utf-8?B?UTk4bDJGYldaYy92YXExV0NITjdkczRHbWd0a3N3YURWQzV3Y2RLY2FOZ1hM?=
 =?utf-8?B?UU5aWEFxUlc4YVZUWmxkNTZCQUEvWW4zMHNBL2hFckNhVlFJWU1kS3VnMmZL?=
 =?utf-8?B?ZFFHdkdCL2QxZHV0SW1YNFYvWTQwSUJ5VitzekUwb29NY0tOeklUTmEwNGRs?=
 =?utf-8?B?VWZON215am5aN2N4MGZ5SWszVmFtWXdzbzIxa2NUUU9CL1N3ZzRUSG9yZnNY?=
 =?utf-8?B?ZkZNT1hjWVlBbXdwbERpcnR0S1phQmNOTlE3TjlsSXRIdHVKcHJzMVBhU1ZY?=
 =?utf-8?B?REZJUVFoakxUbmc1QmdLeGFTWHdNK0RrM3BCbmthM2tMSXQydFArdG5RZ2hZ?=
 =?utf-8?B?cFduSVJwenBuakhYWnh1SXlFWFBhcDZOMTd2S3NJczllVHIyQ0dYNnA0ZmMr?=
 =?utf-8?B?aW42b2pnT2V5YzRwd1F6S2F3YmVhTjZ4aWhYWjkwQnFoQnJSL1Zlc2xKbi9n?=
 =?utf-8?B?dkxBbGlITmpTaUEzdmFvcDNXalQ1WlVRUlNsRWJNalFrU3JvNjJzTjlHZWNQ?=
 =?utf-8?B?V01SbGROL0dMOWNOU2hmRU82OU8yeWNNRGhnU0hRVzl5dkE3b1I5Z2VHeGxJ?=
 =?utf-8?B?QnllQVJHd3VGV1BuTHFWNzNGOGNLSytwclNiMGZIRkQrSUU3QWhkeUNKY0xq?=
 =?utf-8?Q?IpLBTuQ/8LPSKkHrCC+Q6wSK3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a94550-10e6-4f5c-c545-08dd2bd2a28c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:43:02.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbRkWz8ZpFt7a5nsJBlpqqRsT9miE424tJjzPiFVpLHNJKjBfmnaampVFv6MfS9OdqFC6I3d4BehT/R/OnDJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-pl031.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index bad6a5d9c6839ca70905e3d46286b9729c1fd435..47bfc5395e5908b7722b98276399120f1ba65af0 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -284,8 +284,6 @@ static void pl031_remove(struct amba_device *adev)
 {
 	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);
 
-	dev_pm_clear_wake_irq(&adev->dev);
-	device_init_wakeup(&adev->dev, false);
 	if (adev->irq[0])
 		free_irq(adev->irq[0], ldata);
 	amba_release_regions(adev);
@@ -350,7 +348,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
-	device_init_wakeup(&adev->dev, true);
+	devm_device_init_wakeup(&adev->dev);
 	ldata->rtc = devm_rtc_allocate_device(&adev->dev);
 	if (IS_ERR(ldata->rtc)) {
 		ret = PTR_ERR(ldata->rtc);
@@ -373,7 +371,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 				  vendor->irqflags, "rtc-pl031", ldata);
 		if (ret)
 			goto out;
-		dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
+		devm_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	}
 	return 0;
 

-- 
2.37.1



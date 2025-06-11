Return-Path: <linux-pm+bounces-28451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DFAD4D86
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE8817AA4C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDF123A566;
	Wed, 11 Jun 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qCWOtKVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012058.outbound.protection.outlook.com [52.101.71.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2164238144;
	Wed, 11 Jun 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628478; cv=fail; b=h+Ok7zEo22XhK5DKA3Gw6f8vc7+uZSNPSrrO7ZXglP5kN0oUjNys8x2Ody0Jnu/xk1/sftlUl0APbeKq3oBMGYM+FyjLZUu1EeFZqH941mznurwPdvmX3FF3Ggfsc1OMJqlYThwG8fqXLbnsgKwkQqDUWBqLfXWiMWQNa/ddSro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628478; c=relaxed/simple;
	bh=ldhQUzKL1K8CWVN+YNscRImer5utthg6GiFfwHcmPaE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iEA9hmrPz+p0DPoanV77q5yltqqLtA/8bUN0lNRgLch48aO+OkSkmhG06JBEdw6ACTf0MUUjf9Cjxcbn84B4Hj2ufZturR5E/yuc5ik2ZX7XJn3SI/OqUyGPJpKxTIH1OUa/8V3h9+leGKNQMGLl1xz1C13PcfoHHdaKuwbiHpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qCWOtKVR; arc=fail smtp.client-ip=52.101.71.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1Z61NYP1DHzm56EpwpqxLi4qAMEEhJ3fOBoSNubTPUq6yD7Dn8kdabj5X8f5VcFWnoUquS1259DevJEmgK/PEDFJN5AQFFP/wcfTiQmmI4H8+wbbK0/gLLL/iLyIwax8FtOTq6Qo2sgZTy5Vq+rrkt7DyxHFhwxoNVmqwb1iTiJtUZNt1LYSWRjV7uABeDqDlX83uXtP72fOlbv91r74HUjr5EwAUvK2B6SwxauK0tHdXVzC7qYmOIMalR3ztLOa8ULdu5AWRO9XMtXsSTKnHbsDYMFtGnf5H0XD49mei6KhsOePJVB34rvqsfcY3C+zAASPMyEqLttrEZDfWJU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOL8wmKpAgw8ZVXa4lFBGUS0w4cwiRMAsMBXTbbruWA=;
 b=NezdRTdJYB73Mv4rr/OyDgT3EQb/oJWOzL9W5fXlNAAYy5Pds5PZhIMOPhUMjXoES3ua+6uaGD3OWn5ALuKaJ/3dGb5imIeG+fwBY0RmnLvw49uG5VequlObG1tVWh80ED80SFvxOpeR96CMGDmWVQ5R6d4HCSM9jdXlWGi/5v4L2/pFSkJXwazX/ekQ6ip/sus8rN09YjB+8q3TamgWSUmJBMyXKJIudFIkNzzu4LiXTZ7cey35+CPHVklusrKiaZ5GTnKjpxFMGTipLKpO/nqViChfwOcMQF94UT232tqpDAumaST2K4u7+3NSGVbqunI9POLS+Ug14j6UnxMEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOL8wmKpAgw8ZVXa4lFBGUS0w4cwiRMAsMBXTbbruWA=;
 b=qCWOtKVRICbdpQqK38B1r98BiF9hPmF45uHYopkYNsbqP5pf3nKkCafBACZm7h+sFzDS6ZcH4bCtbCq+g/ZYrazR6uIfdsHes+m0HN7y8hG2ELgVAETHvW5A6+3+Sc15hSLmH7rG2hW/joKYjtalyBrmlZwu5V8l+z2xfjjhxCJ9IyUZ23RoCgm+s/JMaZs6A8Z9LePA6SGxyCMADzFfNTiPUrR/luUiP4epfYsfmA8LIw2rkIXKjbBsOEzVdndzX378q+pXDGJRV+qAHiPrUDhIKsbypvBWFDwnucn6xrXLGFWoe3KIC6V0prJTCCl5ox618cEKt7D46Sza7WjaCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 07:54:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 07:54:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Jun 2025 15:52:45 +0800
Subject: [PATCH 3/3] cpufreq: scmi-cpufreq: Enable perf limits notification
 only supported
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-scmi-perf-v1-3-df2b548ba77c@nxp.com>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
In-Reply-To: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749628374; l=2509;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=MGDElYttVmCn6iSeKiaCycZJIb/by6vQcfrvx8hUUVM=;
 b=trLWyOJ8m5F65HntAaDiEl8gvM0dtLAPevaxmHn/KSJ9+ib+HkgtJEM6TAMKmSpk8HZVQyDw/
 oM34EWByGMsCdxlNQyDaUwcgJNjLb++MARE2w6dqcgOkuhbJ4pIIz7b
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: e64f8955-1f28-45f8-be06-08dda8bd3492
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWhMY0w4c3dLaERULzAwNkFrcGFPTFdpclR1OTh6bWhpdjQ3dnM4LzBkNDFE?=
 =?utf-8?B?RlhsOTd5RStpNHN3M2IxYkh5NGxCcW5pR0U3QVNQRW1KMUVFNS94dGRXdzdT?=
 =?utf-8?B?SmJ6SStGWWZuNytmUk5sN0NDclg4dkJuMGpJNFFvTlArd1pPc2haRGlPdWUv?=
 =?utf-8?B?YlhrbFI1S1NUVklUenRvbmdhNWI3RnR1S05LdHFSSGJybDRYNEZ6Q08xT1JT?=
 =?utf-8?B?SEJjcWZPK2RaRWZibTUvbmpGaSs2NEVIWTFoQUxjN2gxUWIwY1YrRHhMUU5t?=
 =?utf-8?B?dkVROE0wZ2p2UFRIUTBtejY5eklnZlZQRVNvdnFXU0F3cjRpZmp6L2o5bTYv?=
 =?utf-8?B?bUNwV1hadzZpMU5GclNMQUxMMGpZTzRoa2dtUW12UzBiUFpZbGF6VkNRczBl?=
 =?utf-8?B?MFF4dVo2Y21RZU9iQk1oRXo5ZVI2dUY5YjRsYTEwMjdOQTVLekFDbWQ5Mmsx?=
 =?utf-8?B?V2IyeHkxVGFrelQ0K0tqZ0RIMjBta1AvQjNNVlRuTkN2ZUJhNjZLYlZRbUFF?=
 =?utf-8?B?SVlGWlhPQXNEcm1iZFFXdFJzSUZqWTVONHBiYkhSc3lJWkF5cUxVV2wyT3Nz?=
 =?utf-8?B?SnJVaDBuU2hzdmVjdnJXUklzM2lPbytxSno0amtCQWt0eTBqajB4SjlWMnRU?=
 =?utf-8?B?dWpONk8vNFV0ZGtQSnFsRWJTNGU0aHJEb1JGSi9rMDZxR3ZyK1pyYUZQcmVm?=
 =?utf-8?B?eHBqUzY5bmhiSUsvYStPcWhCN1drOE55UDV5Smw4aDgzcVZ5R1J4THpFNWt1?=
 =?utf-8?B?SnVUbGxNOEg5NHJYZUtiRU94dGRLYVYrQjJIektnMnpMR2xWSnhMN2hFZmVS?=
 =?utf-8?B?dmdDOHNXWTNjaHZ1eWFwS0hDRkxBR0xXbWlsbm9CYk5rckozc0VmVjI3MEdh?=
 =?utf-8?B?azRNYitKZEdPL1RFY3d0a1N5alFwR3FDNk1YU3hka3ozMG90ayt6UVhIU0Rq?=
 =?utf-8?B?TU5mQU9BYjYxMGxiekVYRmVQY0dTS0d6TGhieXpNSEtBcVlDY3NZWkhJTVdz?=
 =?utf-8?B?ajRQc1RpK1BMT25kMStzaksrbHlDVHhEeWFKMTdaZ2JrU0RIc3RzUVpqZzIw?=
 =?utf-8?B?NkZPUGd3RVhkZnVnVUFicUFFTG5wdmJzR0lxcDA0TEhhZS96TS9BMmVTY2Fu?=
 =?utf-8?B?SUU3Z1EvMVczdnpOeVhIRXlObFlhTnYvU2xISUg2WE10cWFUdXlRenY0Snhm?=
 =?utf-8?B?bU5EdW92dWpEUWRjekIvN3ErbFh1YndUd2tJWFVKMVlLTFcxVWZKaG91Z1Zu?=
 =?utf-8?B?bGJXU1BnY2FxYU40cU1GcVoyUHI5Y1JsVlZyVHZoNUpxM2VKU3ZIVGNhYzVy?=
 =?utf-8?B?RVBac3J0TklhZ05XWWdoaCthUXlVc3hza2dwd0hDeUJMUXEvWDVBcGdWTDdD?=
 =?utf-8?B?aGxNTTNJd2JxaDJyanhyektpSExsNEl0TU00NVIzVEdGcTJIcXJSUmJ0RlJH?=
 =?utf-8?B?ekYzeFl2MncxUk40WTdlb1ozWVA4Tk5WbFZJTGdkcXhUSk93WGdLd1l5UVRL?=
 =?utf-8?B?TmpocUppc28rK2lrMGNPQUJFRDc0THIwTnBISmFtOWhxY3VoaHYwMExVR09D?=
 =?utf-8?B?aHNzSEkxcVdxVnlDVHhQeTZESWZpaEFwMWNuZjJKWWZyYzZzZlVoMHlkYW5C?=
 =?utf-8?B?cWI3b0gwdFU2U3JsRm5QdVVOQnVQRkRqZ0tKWHhkQ0daT04rZlpoSHpjY0Jz?=
 =?utf-8?B?emRXRzBYaVkzb1NNV0JwWnYrakdQNVI0WHlhQUdXR0k2akRjOU82aFhUMWlK?=
 =?utf-8?B?S29TN2N5c1VXN1NNVTdOMndTUkdCVS85bjN3M1FmZHhPV2xWU09QZlRuQmdY?=
 =?utf-8?B?YitzRVd3VHZ3WG8vNDlwcUo1Zm52VUVUU1BSQnNxak9FSFllS0w2a3Yvdmtq?=
 =?utf-8?B?c2FnOEFVWUhIMWhJZWMySmMyYmV0ZnBwL0NZemU3bnVWRDZIT3RzMGRIWWZN?=
 =?utf-8?B?Ky9qMFd6UlBNamQ2MHZySlpDVUVNMEtFbzNXaGtVVHF0Skhpa0JMWUgyeEhC?=
 =?utf-8?B?WnB2YkN3R2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFlzTldibG5yb2N6cW02RGRaaEhWTU4yQWRiYWlzMS9XcHBZVUkzK3ZBT2M0?=
 =?utf-8?B?dlY2bVV4ZDRFN2R4NitySytoMnpXSmxiek43M0R5S09QZ1BsL3NNT29nTUdn?=
 =?utf-8?B?RlNtMlUvMTVRazkxbW9YZm9hMFJ0b21qTU5YMk0rMmRKTTFkV3hWbis0U0lC?=
 =?utf-8?B?dkpSbXhlR2kxd08zMEtQTklBV0FYVkhaWW5FMDRMdnpoRjJ0Vk5uTUNDNDBY?=
 =?utf-8?B?d3c2UXRTbVVROVJadEJTVVRld01XL0V0RVUyaUhySjFZWHluSkMwdEpJSy9y?=
 =?utf-8?B?OGNiVm1tSE1od0pYNlVsRXBxL1FoLzZsbUdRbk11S0I5K3NYNEZraTNOMHZx?=
 =?utf-8?B?bVgveThXMGp3clE0OEYwVDlEbGFtOTNGOXFRdkZySTNZR1pWZjVtM1JTcVJI?=
 =?utf-8?B?ZStlSFNGRkM2Z1dCMXo1Ty85akhLb1VnRXllbFphbGFRYmE0ZWFCa2dGejlD?=
 =?utf-8?B?L0VRK0tVUmZkZ2NCamxxY3lmdHRRZ24xRkFqcDVVNnMyQ1hvS2kvMk10bE9B?=
 =?utf-8?B?eXFhRFJjbXV0ekphTURacVJSUnRpeStnUEhkSUV2RzBtSHo4THR5a0xqNHBk?=
 =?utf-8?B?d0M1dm94Q0xpNGhnc09FZmFwS0tDNW9VZ0NVM1ZRYUZWMWM3cGRiVkJHaEp5?=
 =?utf-8?B?NWNSNS9WUzc4cldhTVBSWXZVdmFPb1h6RldXa2pMZ0wyK0NjV1dMS1BncVN6?=
 =?utf-8?B?dWJDM3hwUyt3VnNUeWsxV2QrSndKa0FGUFljSFdCMmpCWDM1RjlSYzFDWGdH?=
 =?utf-8?B?aEx1TXM0ODhsTkN2Nng0cy9Vb3NSVUpUQjlMQjVoR3VZc3lVcFdrU2h5ODBt?=
 =?utf-8?B?NmkvVTJyZm1mRDY3WE1rbEF5NW1QV2hCeXZXcEhkQU9HUGhjTkYyWHZuT2NO?=
 =?utf-8?B?VXBQVk5xcDdLcXA3MFVvRGU2dEswVVNoUWlMNEtOQjBzK2FFSXQ3UEZLTloy?=
 =?utf-8?B?RWdZdm03QWF5T0tWNU44UkdaZ3k0NUE2S3J2Q1FlTXZXWGhRejNKbGZzNVR3?=
 =?utf-8?B?b3BHeVdrSW9jaEt5ejNTTkFvSUtERldOalZUOTZNMUozbVpBOE80QW1LRzJx?=
 =?utf-8?B?WCtlNVBTNnhqQzdBNlk3VjlSeWFZSHdHWWJFQnlUbUxoY1VTaE9oOGVmZDg2?=
 =?utf-8?B?ZlNadkxHSXFrcWJYcngrSnZGNDcvVG56U2kvNEEwY1BIV2E1TG4yZk9HdmhC?=
 =?utf-8?B?WGlKRmZCdFJkb3hDMWJueEl3UjRZZzNWY3ExL1Bqa0NQSzhSelVCOENiM3Rn?=
 =?utf-8?B?c3VseXFkZG5pRkw4N1FZQWQwVzk2OUFRcUhZOTd1QzBxZEN0dEFMRjY4cG5s?=
 =?utf-8?B?TTJYSHR4R1ptR0tiTng0a200VU9PalU5VVRwQUJmellsRjNqbHdpTVJkVDFZ?=
 =?utf-8?B?RDhHNmw1SkFNd08zenM3Wk8xUnh1aXFTc3VlUDlsbVE1M0s0elZZZjlvMHBp?=
 =?utf-8?B?akV1WlVKa3Blc3lvdndSTGoydzlrQUczOW9KelYrcGhUbUZzV2lyampsT3dN?=
 =?utf-8?B?TFBlRUE0UURwek9oLzFlUVBiMzI2a2lsZ3l2U1hnYTQ1YVBOYTY0RTBjeVJU?=
 =?utf-8?B?MExtOWZFd1kzWUpvY05WTWFuRjRCTno3SVJSOEtDT3R5UHg0UnR3bjZKUW5B?=
 =?utf-8?B?aVVSUEZXWXc1VUtDdUo0RWVzOTh1NURmN1hPSWo3bnQwdUhKMGt1ZjdOcTNQ?=
 =?utf-8?B?RzlXeGgwdVBWNXluenpPSnFOMnFJMW85MzEzeVVQcWRKaHJ4NEM4L2p0d0xa?=
 =?utf-8?B?ejZ2VzNYMU9oSlJpVEFCWFQ3SDZkczJUdE9aNVc0RUJyelQ5Vk02NTRNdmlO?=
 =?utf-8?B?K0xQeElhUXMvSGM4UFc4a1h3aG1yOUtpQ3lYWURnN0o1eVI4RHRaMWlicHlY?=
 =?utf-8?B?d25NSk9Rd2k3WnBUNlQ5MGhpdm9aNWhZbDBCeWRqY2wxWjRQZ0tSckYrU05P?=
 =?utf-8?B?Q0lobEVjM0VRTTNWa2JteVBnREYvS1ROUXh3OUE3WU9HdWx3NURKZktvOGhJ?=
 =?utf-8?B?RVZhM1pNMGtNb0FOSGRJTWhwcFA5c215RnZ5ZFdTNTZhdnViZS9SYk1HbXhI?=
 =?utf-8?B?QmZ2elhKcStPMVFrRjJqYXA3cUQ5QytSRGFEaWYxdzhsMDV3bm9mN29GbS9q?=
 =?utf-8?Q?tS2wyL1XgY39t7AgYHQJFo668?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64f8955-1f28-45f8-be06-08dda8bd3492
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:54:34.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr+15EApG50bkAv814xfdG1IBGk2qHcGatP9dfjvoE5Wqbuf70cfOshx/Kt5ayu0dz8HrbluuBNAi0ivKe9Hhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

From: Peng Fan <peng.fan@nxp.com>

PERFORMANCE_NOTIFY_LIMITS is optional, so enable perf limits
notification event only when the platform supports it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ef078426bfd51af6a8a4b803278dfae5d323db48..8999960574a2fc427e934553198584d2aeb14a58 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -29,6 +29,7 @@ struct scmi_data {
 	cpumask_var_t opp_shared_cpus;
 	struct notifier_block limit_notify_nb;
 	struct freq_qos_request	limits_freq_req;
+	bool perf_limit_notify;
 };
 
 static struct scmi_protocol_handle *ph;
@@ -310,15 +311,22 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_table;
 	}
 
-	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
-	ret = sdev->handle->notify_ops->event_notifier_register(sdev->handle, SCMI_PROTOCOL_PERF,
+	priv->perf_limit_notify =
+		perf_ops->notify_supported(ph, SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+					   priv->domain_id);
+
+	if (priv->perf_limit_notify) {
+		priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+		ret = sdev->handle->notify_ops->event_notifier_register(sdev->handle,
+							SCMI_PROTOCOL_PERF,
 							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
 							&priv->domain_id,
 							&priv->limit_notify_nb);
-	if (ret)
-		dev_warn(&sdev->dev,
-			 "failed to register for limits change notifier for domain %d\n",
-			 priv->domain_id);
+		if (ret)
+			dev_warn(&sdev->dev,
+				"failed to register for limits change notifier for domain %d\n",
+				priv->domain_id);
+	}
 
 	return 0;
 
@@ -341,10 +349,13 @@ static void scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_device *sdev = cpufreq_get_driver_data();
 
-	sdev->handle->notify_ops->event_notifier_unregister(sdev->handle, SCMI_PROTOCOL_PERF,
+	if (priv->perf_limit_notify) {
+		sdev->handle->notify_ops->event_notifier_unregister(sdev->handle,
+							    SCMI_PROTOCOL_PERF,
 							    SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
 							    &priv->domain_id,
 							    &priv->limit_notify_nb);
+	}
 	freq_qos_remove_request(&priv->limits_freq_req);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);

-- 
2.37.1



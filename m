Return-Path: <linux-pm+bounces-38195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D24C6C1F8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 01:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DA06361A0E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 00:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B21E1DF0;
	Wed, 19 Nov 2025 00:25:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733F18C31;
	Wed, 19 Nov 2025 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511955; cv=fail; b=RIXcuzPqB0/a8C5ddR09YBdSrfxduM1PieCun5t4WFFUjh36PAgM4LCZcDUL/qfflTd9kgi5kCb6SZ8yqJJWjzHWjo39fhAuCcQ06CALJgeHq/fDcAg87XAnlzeAuOaQmpblObOWXejAbHRDpkRPBrXTijl2wrev+pHNGYzaMbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511955; c=relaxed/simple;
	bh=UO3uIfrut3AOF6Ha6CTsM7LLO6UWn0kF6ZE9IybCt1k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oNHGieO6ytAxeYOyFT3WLe8Whf/YH2IQCPhcw3L+ATA1QW3AYOuKlpfrg/8kfp28iRoJrwFt+B51RitUjPxwID2c7v3FLwZ6BNF9CP/+9iTAJUC3pS/UKmGM1y88aK3V9O4tzdtmombXbCuatlh08rKrReZNrD1wKUbfCy9hqRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq/agAAqKQ5I5kRCTiHreMlS8syzMtzrPVS8juXvg2axLFr1w+0QecAYOLSVrsapZO0p32za7RcC0zWpke5ZI75Mn2B62dJhBRDd6mZ2K4corsSfUG6mKC1/bZZydKfUg3uyoa/88f2RgzrjHygqVZBm0GvkFyMiIljbeaD5ZqXhBzRLqnyKbXGbafgQMyJxcWRWnqwEQACVtMfpHe8tIGPPxt+8IuZ4Ey5Xhn9VcEpbtk9gGsMOenk5epy9FSoRdIffAxS40GgXSA3cXCm2YfsK6DYr5uN8ft5KZ4v3llhqPKVZGD3zfsgvLynXNvZT0ig344HpxA6VzXknh83frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6gqKR7XNHyopeHlpSvqf9/WyNfJuXOYNnjjiNJCZ5s=;
 b=N8M0xACHMlt8kVLXXxSlECewzb3Kt/RTT4winG6zvnO8ABDXO35wshSfSw42ODvNaxsW/ybFQlbQeKBVN7huiOqUMRZ9DubMhKCxo2mnKG0Vn17KNdhMTEz7Rbj5ouabaA8tSKcBFI4sYB3EUU42sQoVb1rbgK2AVRPh7SWt2PSNOQ5uqX17pijmnYch0JN/MNEYNqmxsFqZrs7oBNZfk152jd1STHUuPxq0YAioPNDjs4fsgkARE53jCslzbrV857z0Sxfr5olm6ZWUux/4PWvacLqSkY9dxSt+xIvVIaP+6bG/0A8dTTAJlAvYyRWC2Vbt0N1tuFDOepPHdOje/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6801.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:25:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:25:50 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	gregkh@linuxfoundation.org,
	nathan@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] cpuidle: sysfs: Display idle state enter function name
Date: Tue, 18 Nov 2025 19:25:44 -0500
Message-ID: <20251119002545.666251-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0965.namprd03.prod.outlook.com
 (2603:10b6:408:109::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e301ab-266e-4be8-356a-08de270230dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yeizM9KN5aVAiSXwLam7tf0NuqHVAJkQiNJ54qc42+S5UPy97j9BPGjEi9YJ?=
 =?us-ascii?Q?VTfcrdb4DYzd/8LYz4USHgXym77hGxew2DNNAtxPeuxRcxwQxjlIgRZCIGQk?=
 =?us-ascii?Q?bp1ShZrXlcldtPcGHUHJBibtn6k1kjJ60s03/MIw1gdIwr+db9laQKLMq5Yl?=
 =?us-ascii?Q?tQO2GYj/oo08U8TowWuD5nmNSGE/gurPmiPnMdtc+r7QRQrpTmrJXLNOBdC/?=
 =?us-ascii?Q?WTt3iiGMjVXVMibT8+5TfXDHXzxjQseRGDmAejCsMhceRZKlOpIUkiP/amFe?=
 =?us-ascii?Q?pQR4lZsTFA7M28nSba/aguoKkthsQ5skraiZykAhrj8sl4LQBCG3dOJoR8Nc?=
 =?us-ascii?Q?V2vsCiAB/tjhsX54cb4Rqgbr8rtRUCo1CKiaeqFBitMTAyOygVZW7TdEpuEP?=
 =?us-ascii?Q?0y6NSZliYp+3xdihb38lhIbzez11zqBr9YGwO31kiKI+KNufg7uU64R825T3?=
 =?us-ascii?Q?R4po5SfyWtiO+/3jXAJTOV1zCb6+7PrLNi324YWb02nFFT57A/wOy4B20ATc?=
 =?us-ascii?Q?S+/+7ZQmAn3JkFBXPm3VTbBoLnbbynty2MJO8fQCS/wLr7iEzYByRj7M0I5k?=
 =?us-ascii?Q?nxi0AXxAlDAqjp1Weo8ECVVNFP/4TdbWbCChhZ3rdC+2mMgOPM1fzpU5XBi9?=
 =?us-ascii?Q?ynKL6BYiIAAIEhkxeqmfKPSdh3+9bLd+gnsvdQLYVNvdgB6Vr9GjWxhegog3?=
 =?us-ascii?Q?5ct/TNhdgW1F0gDWDF62DtN1EZkTwTjKNDVXN4QV8owrK8Kv0pJEXLa/odIR?=
 =?us-ascii?Q?P20LGRCrxFd7tXcpu41C9l5SCaFH9xAiZyQu9ScFiZ3XUr5McE7IncAuu7qf?=
 =?us-ascii?Q?gu4sdpEQdoEMSuXiqSa5JCQ+0ZShtv0fTU5ht6fOqjTW/u1GNbfo1lPYxaqA?=
 =?us-ascii?Q?F+/yEG5YW+7Ezan5AzrmcJK/gyfsCnXc7GEf5NOIQEHvn4lmzIYklZkGlGr4?=
 =?us-ascii?Q?FJJYy0/vJ4UGYyGnv1OReuf+itNZur2sjVDeejm9Gd+r1fNRv35uEC4YgPW5?=
 =?us-ascii?Q?Bntk0lWK3PSAcfV+kNEOA1aEPYHYmLG+xz8CnJ3WZJM1ZIPnnyexYLWnbg+g?=
 =?us-ascii?Q?2BQFB5AnfEzgAdp+hPBrvv5ZS/4fWfQu+YFb5uUY8b/2myV4s+lSToWwgoVh?=
 =?us-ascii?Q?Qdt6wa32VnFi1w7ledcMFNW8WjpG6agWUfyJP7Jlk+f8V49hsOvNytX8JbxW?=
 =?us-ascii?Q?HLFBK15qKjB5JTClm5kuubuhYGiyLnslJDiVw/w8sd2sqWEXZFRCtME/4gRc?=
 =?us-ascii?Q?QBbKjR33jPw+qTmE/mz3Ls+rwe6Cpbm7gPK3oAFi4yE/yraAAhd971XegTkU?=
 =?us-ascii?Q?1cIC+TOY3jlTmqrpcLu7Bh1oMWsU8PST6iU6XukeTdu7ic6ljr52VOZFVF8T?=
 =?us-ascii?Q?fLeNpK+RGIgX7/NpDmBvCvs2aW22bHSXb4WN+OMJ5IA+0xOpQ1SnAQr0lFVQ?=
 =?us-ascii?Q?YtbCXzAR/mc6AqIUsSCnUdqmnt7PlBCXDq5H/sZgqOsQBXshftcC9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FfRwQqBG/BnGQoIjZq0J8w99XGwQfK/G4tZRpd07DgYCb+pIMytgiEJI2DkU?=
 =?us-ascii?Q?T3Fn3nSbM5fvQ61wRvijL/ROcY4WnL4X4RJdj2Nwe5kjKY8nLu+P5CnlZdLv?=
 =?us-ascii?Q?luuzMwS+XYrtwWLvduSO1t5nfo4A4BT6mUPtkMLhptvY/N3PPMcRSgFbrhDd?=
 =?us-ascii?Q?vump4XcW93TuhVJ8vyq+q1kEicn5WUb9ZP21SO7XtdeuU0KTNlUZei/VXNcS?=
 =?us-ascii?Q?1UdYHRTnvwUI/u+BJSF+hzT9QQydTimMWo4xmUre3MMVqDcByUG4BNC1+S8l?=
 =?us-ascii?Q?SDZSfGKcpZqJv8pGnS8ahTZ3Xuh4ElzRL3WeGTbclh3/sJd4+kcO6vwgrGoO?=
 =?us-ascii?Q?zCYb+5E66WBfw4G+JTswlfGwYIkTeWsvC+m9vx92z1pqK2x105/7SbRqebqk?=
 =?us-ascii?Q?lfWxb3kb5LYpwsiSy5nhpJBlCoW8DOeg2zNvVPW72FPhCTcWyzT9R5xi9a7g?=
 =?us-ascii?Q?Gut5NPi9Cc+xTLUyTIhklLesm0nvI/eqN5p4VlflvjmOZEFSKGAZoVACRgkx?=
 =?us-ascii?Q?esAq6bdGBl85HPtMulKjnNXnYPxpqkfbFBra3MJ9gW7WT2XejFKJD5FLAnT7?=
 =?us-ascii?Q?IFR8w1m1s/+CJ8cIKbdSiXhtFKWyQle8q+Y1dv8PXYKQRU51YA9ZciX4uumz?=
 =?us-ascii?Q?pvNHv7qopukBWrn9K9GTEveTjqHzDuF7l5rR/xrCtJ/7KudPuO6R95a4MnOp?=
 =?us-ascii?Q?s4jpl4wf3jPF3ompGI/vQhLPAJq3vub/RdxJNUpg7hgbrCJMM191VxApkbSb?=
 =?us-ascii?Q?5V2I+A2sNpdwtTdY2z4DuVhBiP17SIbkKj2vxPiVA+K2Mij83QEIoJZw5HbO?=
 =?us-ascii?Q?kVN9kNvJR4//K82MsVtU0KxhNMdD1+8ZgbvYvyI1ZZbLxgaqHtxrFMlR1jZW?=
 =?us-ascii?Q?2VqcVZ8DAfynRk6Xhnfrjp/WiqBiv0RoKssNA7skQIc/qMxIlRaftBrfloFy?=
 =?us-ascii?Q?5SbNeoGGCOBj6GxTV8tH070B8I1iv/y5k7T+hkB35VI4C5aODeJoL2xdf/Xs?=
 =?us-ascii?Q?tWQdyuZfkoRIFid9R/mrw9TygyhBTFkJDsGhR1/7ZqYulwK310xM4LmVtSth?=
 =?us-ascii?Q?Bp5kjXnYIl/w91YNA3Q//n8LdMbYn5u4rMtO3kmQjyVq6SDkse7//kw2IyKF?=
 =?us-ascii?Q?8rw4mep8r7yQlDIDlHJOOadtDznYvbCxqaBZfPzD04uRIOJfi7MDCuM9KpEH?=
 =?us-ascii?Q?bWQ1lyK7EuzEepV+P9TXWfg+D7Ox/i8wgJA6iLC+CTXu7LgAQ/JTI7bS3zXp?=
 =?us-ascii?Q?MEnArNnCSuNlFQ8SvyrYfx51PFSW/GVLIo8uk6rJ6QB+ZwNuAwGmy5gsOjx9?=
 =?us-ascii?Q?3Mrbe+haqe28+ibArL2uMgYDsBT9hZHGsYPm0Q6P393A6BT3o9cYKDBa3Nk+?=
 =?us-ascii?Q?JNA5wd2WFp9vsOZm3MYOEk3tnDBJvAVVJN1zycPeR6mcfUWv4k0No6M2LQni?=
 =?us-ascii?Q?ptzW7IYx6oUvEUUNCwaQeR03cNF4OO81uofgjHglj2NvKEGbI9LDjQZ7ykdt?=
 =?us-ascii?Q?T4Lng+bFb29hYJ4E7Zh1BsQ9FQCenyqYT5yY9RWYZy1I5Ar2bD0AUeS6GILF?=
 =?us-ascii?Q?SkzMhXlKKPmYvEZOCpgCSMvvAVqiSiiivs1vNzSb?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e301ab-266e-4be8-356a-08de270230dc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:25:50.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeXi+/Io6FTq3sLM8+iqGEHmV+7EFnM+7W8PlywxXeJGWTYtQJlAW3YOKx5sw2A+vyxn1nSWk0+scWVQN39IMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6801

Changes since v1 [1]:

 - Correct commit message

[1]: https://lore.kernel.org/lkml/20251118232208.660255-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  cpuidle: sysfs: Display idle state enter function name

 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
 drivers/cpuidle/sysfs.c                            | 9 +++++++++
 2 files changed, 16 insertions(+)

-- 
2.51.0



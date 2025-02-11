Return-Path: <linux-pm+bounces-21831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55BA30C67
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92606166650
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF11FCFE3;
	Tue, 11 Feb 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pCglBbiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BB524F;
	Tue, 11 Feb 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279022; cv=fail; b=Wi0HduxhciTVaaS0HzSBLmyXN+NnAcqQn2BzfkPWJyhRj+VtYSZsxBJi/wq26BZc9ZJaGdej6mlVqEXQv7LfVLtxlFXVqIdKKeAsqgK5TqOiNffP3a0UoANKlsO19xvvLIxVVnqKbTvJQ6Ztu9DjPJfBhIl2at391vWKGPZD2cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279022; c=relaxed/simple;
	bh=45uIB3ALJWbDC5cIRpGVr084iPLHnI65XmMXK8aNQYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TSJd34L+VeH7CR0FTN/BwBtf4gXH6keZKH2Sa51W4+VTm72cVgwJaAt30JbHT9ZpSFQpyUN+JPLYnACRQXCaylndwpnlLyYj+ZeJN65ZkdG3jPZkOzXgTz5rDejMw/y1nhpJc9PKmO7pawpJ96R7LsNe73WZ9eXGBaNydR8HLp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pCglBbiO; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk3nP4CMG6/atBWyKTxmtkSYNAjA4iaBKNblUUAC2GbR6odn4MSzC6ngFftpgo44eQWrggjzZxDXVrE1JR4eOgno0qE85EROWT4C7YsjCWZvMw1gbX087N3fgRjN5AUe6yWgAatOp7IiXgX5hfpwsMZLFNundWOfZ9W2wU+VVb5V3bKYq4JP3BdxoN7gIAVMZ9eGAuOxzXlwTn8zFd7kDH67nMF/2jJtkPxx1NiJHgk14O8minKLE9aU1USGqBS1ywrdXpreXyn2bsFHqlcog9HB/Df2Oram44MNQ37bu25jzF31yZ9sL5Nb4CKWV9I6Tf5Fh2sl5s8PLwy4kJ+AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2QKyIYLMdTo0bt78qB9R4dsyNS5F4RdEvdxvi9NNkI=;
 b=IvtXpGfy+yp19DxYiLNyJZ6knIbx/2aoPX998XpZ9usjkAGkboJ5w7dSGO96/XRjlR51T2Ui6sLUyL6pZF42qdO1RlE+1+qJlPyLJtrZie8WQIJdXx3FGMiv1mSinPybUPz/Eurojeqd6NdCvs7SVqtoq8gyCQDqIj9V/V+A7Er5E1EXGfdb/gZjzWCFSUFPJwkEYjq3IT57mrIUUefJ1eYSYH9t7s8qHFEnqDyNlYHmmvcp0yf3w1PgHpyAbO31p8Qm85yfrc7AvDr1NfKP1miOb2ZMpG5rwRy1L88HiSoZIrGqnZ3KXSbLExhW1vt9ebLGlYMFmEFQ+yZ3WqMH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2QKyIYLMdTo0bt78qB9R4dsyNS5F4RdEvdxvi9NNkI=;
 b=pCglBbiOIuyxyrl2HcPkwRorxX13aFAU+fBZwdKCmIHQfWpQwhwxUP7GTHXlnE8E4eCMA6N7OOZcmCAFAoOz02G9zWWcx46Ijx6YGAMYqan/4PvDjbaulR4T4FkK2Vnsyna/sIBKuiDkurqAl+Qbbqb45B1ivtTtfjnuI3Pe4E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 13:03:37 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 13:03:37 +0000
Message-ID: <81e8c853-ec5e-4959-b1b9-0680b035720c@amd.com>
Date: Tue, 11 Feb 2025 18:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] cpufreq/amd-pstate: Drop debug statements for
 policy setting
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-12-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-12-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 952c49c6-56e2-4cc8-0913-08dd4a9c7fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azFFQlFPNDBQK1Y1VHJoemhKZ2czbVc2ZVRKZUFhWnVyeWtqZE4zUFRzajZi?=
 =?utf-8?B?WkNZRTlJd0k5MnlzNENHcjVoRkhkVkR1VStiMVgweDJtWFVmTVF1ajJudlNR?=
 =?utf-8?B?NXY3c0d3RmZUZTBJcitXYzdaZjAwM1BlcFdIdm4vd3MxUG1NOVBWTDhOQSt2?=
 =?utf-8?B?cGh5RkZicFFEQW1pVWgwWEVHMjhWQU9hNWpxZDBhOVZLOGF2WnlTUUpzOGhs?=
 =?utf-8?B?bFFZeVRQcnl1UHU1VDJZamV1S0ExazI0cnNFZHdramRRYUlZZWt4SzkzaTRw?=
 =?utf-8?B?b2V1N1BZYUxWSFRncUJ6UkZqdk9PRnNxd3JnS29rOVBrV1FaZmJZbm1zZjgy?=
 =?utf-8?B?VmI2MkRBRXVXdmMwL0ZWUW9YOXVHRVlacFlueDkzclVsS2VtaGJmYlFhbU9R?=
 =?utf-8?B?OWdiNzBxZXpBS0FjS25tc1NQNzcvbGVRZDdDN1o3aERBYlB4SWd0enBURitI?=
 =?utf-8?B?dVB3NDJFL2orY2hEZUNtQUh0RmR6OXFxcTV1OUNtWUkzTjhPZUx4NUZQb1M0?=
 =?utf-8?B?OWtoOUN5M0hZeEZpaE16OFZpZjJFaTFWRjJrOFF3RTNOdGVZdXMzbkVqei9h?=
 =?utf-8?B?a2Y5WFo4cTN5aFNlY0ZGVzQwc0gyakpucVdzckZOOHM1NFp0NGRGN1ZQd0pI?=
 =?utf-8?B?TFhsVldzanVvQkppeThXemZxSjBFeWtlR1ArK09vVjNHVFVZRS9HbUw2UlR0?=
 =?utf-8?B?andZOC9OcFhEcThITkNSMWZRa2NKclVXMVN4T3NPN2xkSjlORE9CY3JiQ3lt?=
 =?utf-8?B?K2k1OG0rSjlQVDlyelZ4Qzc1RGV0Q0pxZkUra1JHRUNkMFFEL3RHWjZaek5x?=
 =?utf-8?B?UnpSL2dVMjB2YVIycE9mK3VZZGVvY0dJVTgrSFc4dmI2RXQ3SzgvNThNWTBC?=
 =?utf-8?B?U1Z6UUp1cEYyRS9Ta25TYWJiamEwckFoVk42VWNCSWFBVi82WDUvR1JGejVu?=
 =?utf-8?B?Y2p2TzQyczU0RUFjVHJ2a2drL2tHMGxpL3ZpUTV1all5NFl2SU9jZVpFckNy?=
 =?utf-8?B?VkZsMzlLWEQ2U0t5YURvd2ZVRjJwQ2xUWnNIMzdsT2NUQm5HWTh4ZFdleXh4?=
 =?utf-8?B?M2dtNlZ1c3FVOUJqUmo1M3FLcXEvckRadjFZMDZMcDlQanV4eHNyZk9seE9S?=
 =?utf-8?B?YXJscEd4UXZnTW5vVU5TenpjNGdBQmJPRkJ6d2Q1VnNVcm1pcWFoTy9EU05J?=
 =?utf-8?B?MXhJZkx5RFdod0tWYjFBUkQ2M1RnOUhLazRVTW9ibWN2Q2kvdS8wR0d1RVdi?=
 =?utf-8?B?KzJpbTVIWkJBK0ZQS3llZVliZmVveXphL3RDUkUvQUszbC9nNlFiQVJHWWRh?=
 =?utf-8?B?TnBsWW5ydmdLYVFHeHU5Wi8wWFdIeGlhYzRKSmtqLzIxVWVqZkdvRjdJUGIr?=
 =?utf-8?B?KzA2YlE0UHVLbS9MWTVjRUptczBYS01QTlJ4WkJHeDFjVW5vU3ZCb0d5eDBW?=
 =?utf-8?B?NEVyTm1LTmd5ZGhlOU82OVFQd054aUd0bEdwcXVFT1lnWFBVdHNGNU4wL3Vz?=
 =?utf-8?B?YlIzemd5SjFBRjlicGxxNXhGazI2R0RIVzlPQmhOcmdOYStjUDFSOWRzZ3U1?=
 =?utf-8?B?SEhERHVTcFNGOWl4LzNpQWVybERNQzFjQjZlTm1TcllGbCs3K1lpaUsvTzRI?=
 =?utf-8?B?dGJuWGw5U21nWHdycThBTzdsRUZZUmNOM0huRGY0S1VDYjFnSy9GQ09CUFlK?=
 =?utf-8?B?dVQxcDJRUlNBamZQcklGVktUS3FQVHprM2Q2d25YTmZsd1lqMDF2L1RobVpo?=
 =?utf-8?B?N2drOGdtK09zVnVCdlRWMkZyUjlsN3hmWm0yRGh4ZTRaMDRHMnRyNXdqdDFN?=
 =?utf-8?B?SkdTSXJQSWh5MVNWelU2VmIzNmJRSnV2NjM3MU5YdEFpZTJTTUpqUnp6OE1y?=
 =?utf-8?Q?hNU1n+OBspwlB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1lOWG4rSXh0a3dqWEpzS2doLzdOM0prNHFrZDBkdW1aQ1VvSkpiNEpvVHJw?=
 =?utf-8?B?ajRkZElzVGFnRG9ORSszblRvNkcvanpaTmtMZ29UV1VNWFVySnJvS0NYZDVI?=
 =?utf-8?B?REVyY3VKeWlOc1lpSzJLYVpTUXp1QXVjdUdaRFhRM0NwM0JEYzlhZUJ5cXZF?=
 =?utf-8?B?VnJBaDl0V2FJMUU5UllyMitLcmozRkNhTm9GVHorRS9jakNrb0t5dlM5UTdv?=
 =?utf-8?B?QjZ1aCtUZS9uTFhoYWlGYmFObXZwZTB3c000RnAyQ2N1ZS9obFdDUlgwTTN3?=
 =?utf-8?B?a2NMM1BKSUJtZHBURXBLODJzZ1pabVlzRWFHa0lzaVRuV3NDbWx0c0ZXdlcr?=
 =?utf-8?B?cklFSUpyelR2YkRqazcxWVZvWDQrZFYwZnZkUjhnbG05WW1xeVlBMlkyYjBK?=
 =?utf-8?B?emxzSmlFL0Z6c0hWQ0lucjg2c0dscnMxejJvYVdjLzl2aWNxL0o2c1NaaDV1?=
 =?utf-8?B?VmdvVllSdTNoYThpdjRKSytaM2V1MzNYQzdHeGpkbTB4UXhpNnRjVEF0aGY3?=
 =?utf-8?B?Z2lNYlZBVXRuWFRRRXJ1UDl2WkJ0K05rUm9VZE9LUUdIY3pPb1J0ZUJxQlFI?=
 =?utf-8?B?d3kwSVo4RFc4MkJTNFVGbnNSMXJoWlNQSmEySTl1czhUMzJZUjlITGd6WjFO?=
 =?utf-8?B?eVFNdWtqdlQxRlV2SGRXOG1TR2x0S2hIaGZXNzcrVno0NU5Ib2xZUzMzWkVN?=
 =?utf-8?B?b2pLckE4MEJ4MkZKWlZOb1ZpZzYzTFJ2MVIrMnV1RnNhS0ttWVNBUFViRkVw?=
 =?utf-8?B?Sm9tVTNvU2k0U0t5UVhaM2Ewd29SN0dJb1hiVkVOR1oweTNqT2dNV1IyeXE1?=
 =?utf-8?B?bnQ5dnJTU0NtOXlNRkpTVVFYMEViMU15d2tEZnQ1RDR5dW9kVjJVVTJHYUZX?=
 =?utf-8?B?azZycE56QjNsQTZicHNIOWNPdmN5NUxqMXRpV0dtV1BNM0o0cHA0L1JYWnd6?=
 =?utf-8?B?NHJNMlYwdlFEc3lFZlR3dkpJU3pVNjdOZkJpQ2JzekQ5dmVIQmhTVzQ5ajU1?=
 =?utf-8?B?TzVYMXBmbHBLVGYrTkluVXJzejZxOEQxMEJyekZyZzh2UlVpNEtzSTRhKzc5?=
 =?utf-8?B?UkRlbUt4RnV5a0YvMmZibDE1a2Z0b0R4elVQQVBVQXFlaUcxbWJCM0lScVlu?=
 =?utf-8?B?Sm0vejZjczk2c3dlcFRNTEZEWm9La2U3TEwydlZRRWtHVEswYTdNU3dFaTJo?=
 =?utf-8?B?U3kvVHFWUy9uRmRsOThOOWRPTVEva1ZLSjdnNnMwUThyMjhXa05OQWNnMEVw?=
 =?utf-8?B?NUNaTEp3Umw1c0VxR0dNd2dhVHdCVjdtY1B2NW5NSmdDazBvZVdJcUMvZTFs?=
 =?utf-8?B?cnIrdDIwbEF1bDM3MkNzVmFrZmtXN3dYdUs0MEE5UnF4Z1RmRkhTQWhrQmhj?=
 =?utf-8?B?bmVMV3lpRHBIenArU0hYUVRuT3BFeUM0R0w2Sk12K3JZZURuRnhsMU04bGRD?=
 =?utf-8?B?eHhzTnJGQnhPOGtOMlNLVTlTUUhkR21HbGZtaWNQRUQ0d2hlQXRnanhNVVdO?=
 =?utf-8?B?cElVRDRETS9uUFlPMGdySEdDbEhLaEpjYktMLytRZWVyMkhNbWZSbXYrU0Iz?=
 =?utf-8?B?dTY4dEFyUC85V0hNcFo0a3d4QTBHUzBobjIwaVZNNSt2ZmVmaExvZC81dkhN?=
 =?utf-8?B?UGN2M2FIa0tzbC9CSFhHODlwd2lMTXJEaW4wZVpNNzJtRW43bUpXWllON0FI?=
 =?utf-8?B?dkZScTJwZkxnM0kzS1VOMGpuMlpKclFUeWU2ckFkRDc0d1A0MTJBeVdrendz?=
 =?utf-8?B?TzVwRlczRHVBVkZZT3dSblQvY3I5ZUl5aGk2RmdXRHVDdzBRbXVhcUNGWkdh?=
 =?utf-8?B?SVpqUWhzcisybldMN0UwNVkvTlN3NnJqdXNOYWRvVWtmMUVPVXRRWitNU3h1?=
 =?utf-8?B?ZEU5VDZuZjczQlNCVi82V0ZQVFZFQzFNQi9iaEY1ZDdycVppek12L1l5T1Ev?=
 =?utf-8?B?TlE3RGdDbjM4K1lIeHVQa3p0cytNbWlFVDZGcUMvSk03NHNzMDE2RXptSG14?=
 =?utf-8?B?R01GVXl1WktTY0F2dGRPemovUGEvT3pFVjlGNGExaVlJSy9hWW12bVNXWEoy?=
 =?utf-8?B?V1YybTV1alhrSG4vZjVvdjV1cDlsUmJhOVFCU0lTVnB2ZDYzdzNaVmQ3QU5i?=
 =?utf-8?Q?p0c9CeXKuLiirlW+WdGzZo0E2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952c49c6-56e2-4cc8-0913-08dd4a9c7fbb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:03:37.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt+hKKNOckcT0vMpglLpBTPqziGkfMlblACMKcrI+zfKTnagq3vDQ2aN67tgG37Ewjwi7RdyPaHBVGFxldkSxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> There are trace events that exist now for all amd-pstate modes that
> will output information right before programming to the hardware.
> 
> This makes the existing debug statements unnecessary remaining
> overhead.  Drop them.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 754f2d606b371..689de385d06da 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -673,7 +673,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  	}
>  
>  	cpufreq_verify_within_cpu_limits(policy_data);
> -	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
>  
>  	return 0;
>  }
> @@ -1652,9 +1651,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	if (!policy->cpuinfo.max_freq)
>  		return -ENODEV;
>  
> -	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> -				policy->cpuinfo.max_freq, policy->max);
> -
>  	cpudata->policy = policy->policy;
>  
>  	ret = amd_pstate_epp_update_limit(policy);



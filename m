Return-Path: <linux-pm+bounces-21923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC767A31DC5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 06:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9B07A2658
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 05:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EE1917E3;
	Wed, 12 Feb 2025 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbVNASqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C15271837;
	Wed, 12 Feb 2025 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337324; cv=fail; b=fNUDjLalmuF87dSQUCRkuEkrwD99SZIFDWAg5Skh7NwkBwk3dsPNi9/g2H84c2mtREZkuEqi+HATLPkkipkIANnoBA6sNj4vFI5y3fRpaMKuKnVcfiyYRgKIsrPqS9DVjepeiz2kFL/4MGx/HM71F5mrDgk8xUXOkozjp/glJ+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337324; c=relaxed/simple;
	bh=rcA1i2sSSVOLtWKWrT9QyX1DCmdEkCEzRl8A65jVXB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UsxwErk7dDMgpF9GVstZfAtMUNGRha/ODx6Ozbwsp90J7s0jm265TLdCuZS6W5e8Ccd8VPuKIrIyw/GQySwFRsA6gjKiNXlc/6nuFYR1j3sEWJyXdyPEvB8Mva+W8kavMcPlXj1CoE0+UvdudaoSuMwfhpacorkVtginiU7tVUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbVNASqO; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyPTFE4uvqp38GnigYNPdvGsgGSe1emfoR5QrOiVHLgAa77xkDqbgRf4Bo7yMa+dboF5Bi7UjuKqLHrfDYQ8e8KqFUe5vu2LlgJh+V4rvHOozao1m8hh5G6y/2d0E576LKws5Xd3uY0FmzxoHyUTocKI3Qcjn9Bow2fKV3LzaT9Tt8l8B2Fn2m35VPirXZU+lfybfq9+KIhleViNmTucUOMmQesao2vE9RzFet38ocKvLXtyaWAkH7MJU+Qe6qM452zjsCf5VdR2QLtgdC9h4JFCIoZ5/SsFwznr9M5gUqYh96p0JLhH+oT92GpZYfjMWDSqa8XBtPahBcI99P8XSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2WJ3ramNTNQRQ2jBUsBH+8Ib3SsmCN3t5M30LpujdQ=;
 b=cQyoiMFM+Rbq506Xz8sojD0kCCaP/Cn63exkPXejPlsSdExM+AA8KWbc8C3B/8okA4uyWsKhbv+kJqpaKwSDD9aoNlblce0yN7LdY1LE8mmKtuzSRAKeFOrK//etaP+ACSe9u7rqgXtttV3jYfjvHC7GT0WowQAGp6oqzD5zoM5bX1UTt/cBgAhgY9huaMzvIw0W4a1HHPeCNJzK/oi6/D6UaK9LXeMIVfF30PBfmGJ1IisRoa26a1UyYGpypz7uCClpjCn6b+2PU4tPWmirUqBN3R86oQ/ffPZBa7HWic0dk11VRHWVIQ7Mfs2Sxtupj3pSK5Md+5idORSD/1FzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2WJ3ramNTNQRQ2jBUsBH+8Ib3SsmCN3t5M30LpujdQ=;
 b=pbVNASqO+9bDPNJf7VPh3uz2a6BvDooEV0X9TOyV1S7sahvRt5XEb93XJH/BlWvaPP3DFwuIzyIlBbq1lv6Kq1meslwPynZTj5cvpvIFVbiRWAYddgty8810fYlD5INjCajb2B6qq8IEmNqSxEz/W14J1vlOLUdNntDVWc9ZLN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 05:15:18 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 05:15:18 +0000
Message-ID: <82f27cde-4725-4f4e-b4ae-c23885b31d14@amd.com>
Date: Wed, 12 Feb 2025 10:45:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] cpufreq/amd-pstate: Overhaul locking
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-5-superm1@kernel.org>
 <adccc912-bf93-4320-8011-21c0220c839a@amd.com>
 <bfcafbaf-c407-412b-a5e4-d152e2a565d7@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <bfcafbaf-c407-412b-a5e4-d152e2a565d7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 799e4e1a-4f2d-43e7-8406-08dd4b243da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnhZNm5YVGxTNkJmaXdZNU9RSVprVmVFNzVDYXhBZ0oyZTU1Q1VGVHVOUDVE?=
 =?utf-8?B?NEtiMHhVNEh3akZMdEFlWmY0UmovdkVnNzVIczBhK1lHVXBCazZVSXB4aGtR?=
 =?utf-8?B?WVQzRWVXTkg5RGZKeVpUTEN3R0o2WURYQko3Vm1UY3dKN0RsL05BaitEY2FD?=
 =?utf-8?B?bmNyZVpwSG1zN3dSbm40SVB3QUJxZGZMZGRhUWp1dGdjU3hrVktVYzRURlhF?=
 =?utf-8?B?NERHZys3MndiK1V2ZnBQNlhhTENzeGpVNUJpMHU5L1lwVnNmZ3NzQVVTaDB4?=
 =?utf-8?B?aS9UWlJNS3Jic1JWbmNuNzN1MHI5Q1drZktsNDR2b2wxQWE5dkhsQmVnZ0tq?=
 =?utf-8?B?c3NCM0NXYm5KOE5RNC9DOWpVRUNQYnZkVTRGRFFpT2NwbVZqWWhNUXNER1JE?=
 =?utf-8?B?c3BBTWM2SnJrQUpqUmtVbGdjVGJNZWlNdXZDY2RoT0F5eGcyNkpHcFFxeWlF?=
 =?utf-8?B?K3RzOUV2blkrNjkvdFVraUpHL3UxZ3RpdU9OUWUvSlBFNVJzWTNmdEhnS0xo?=
 =?utf-8?B?c1FwWEpTQ2YzK1ZJc0lQSmMyRTlTZk55cXZyMTFIUnNXRy91YUFvVlFnendY?=
 =?utf-8?B?RkpkbGVweEgyamFZNDhvanFscTdQOUxvVWlIZlZZQ0xkMWdGcU9LLzgvcnYr?=
 =?utf-8?B?aGZnUHQwTkhONklCcGo0djR3d1laM2plYlg2Nit3MkpwYWJraW15Z1M5RkxO?=
 =?utf-8?B?Q2lGK0NueWlzOVc5VnVPWW52TlNoZnlrR096UzJuaGlEWmJReEFGallCMHNN?=
 =?utf-8?B?eTRMZWFIMEZiMTNKZVRaWFhKY0VYRVphWkNLL3lMeXBSYnFNcEJwQWQxeHkr?=
 =?utf-8?B?U1FkNk9Ucm9zaE54SkdCM2dPMmE4QnZwd29ZdDdQaWxxTCtTMFAwaTFsOExu?=
 =?utf-8?B?VEZPWTZsUHhaYXFodTUvaDlLNjRUaFUra2Y1K0FYaGtyZXRMSVYwcTZVeHlJ?=
 =?utf-8?B?Y0ZrWDdodmlqa2pxc0N2OVRIVERYVjZBWlVtNUR0R3Q5VUZMRENmQnhqaEFt?=
 =?utf-8?B?czBNcnJrdjlXakN4K0U3VFozRFpqRE55dDVaeWhlalQ4TUJSdmc0NkwrdklK?=
 =?utf-8?B?NUJUY1duMHFoN1Y1Nm0yc1lxRnVRRmVzZ2l2M3d2VVV4cXdmc1lBK1RzalE1?=
 =?utf-8?B?cW15dFVYMnl0dE9ia1huUGd3cnA1TjhMcFNjZkhqSW9CQXNtSy9QNVQzaVQw?=
 =?utf-8?B?YkZVekNNa3JrcTUyZEdvcE9YUy85RmVXRThxU0p6QTN0cjJoMVB0NDdEdld1?=
 =?utf-8?B?RUZxbjltVjBpTGl4Z2VWalpSSWY4S3ZWWFNkcSthSWtMWG5LaWJtR3hOdm1F?=
 =?utf-8?B?d253T1BVUkVPSjN3YTYzR2tBeDVzTy94bEQzQzRVbzUralk4OVlhYXBhVG16?=
 =?utf-8?B?V3JtcHhFcDhWcnUvWnNvSUF0bXpFVkFPTW00RW1YQ3d3WEVrSlQ0SVV3ZFRq?=
 =?utf-8?B?b1IzUE8wUE5jdXltRk5aU2RjdG1OOWQ5UUhQaHAzMkNLYzFYeTd3a0p1MjJv?=
 =?utf-8?B?TU9xcHlDTU95NHc2Um1welN1cDl0WTVlSHFZM0htaE5FZGE0SS9OblJCWksr?=
 =?utf-8?B?UUwzZ2YzU1RsT3czRUVJQ09YaEhQZzI3MWVLQkVlRjVJampaVy9HU1VUWU1u?=
 =?utf-8?B?bjd1QnMvUnFqb2haSDB5cTN0ZHZ5S3hkeGw0TUdidnlCaVV0ZjBMU0NkL2Jh?=
 =?utf-8?B?b1l6bUcwYUxSeXBUcUdhbmpJdmhXT0ppQk1jQyswb1VIVTVBekFnaWNERVFw?=
 =?utf-8?B?c2JGRDc4a0cyLzU1Z2FVWkpHeVViTmNhWDczakFad0xMYWg3Q0xwRXVXSlFB?=
 =?utf-8?B?bk5DenRvM1drRkI1WGNTMENpNUFmd0JzMUpEWW9jbmVwcTVCTSs3bUc3RVpG?=
 =?utf-8?Q?asTwUpQv7CLjp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBrZkdtdkFSSFRtaVU3NGRVQW54UU1NY3JtdzBJRVJpZ0ZZWFZvNHlZU1Ry?=
 =?utf-8?B?R3JtMXJ1TVVQa0VJRkFxWFlMVm1GRU14Wmx2K1YxSVh3Y1YvZVdxa21qWmph?=
 =?utf-8?B?eC9TTmxFa1FHLzF1ajcwWlp4WCtOTFVWU1JibjdNblErRWEwRG1lenFrMERo?=
 =?utf-8?B?TFJMeGRsSG5raWc5SWFYc1oxdjdybm03ZDJoaUFEbXNVYkFDc3RxdlM3OUpW?=
 =?utf-8?B?YjFYcWpQNFJIek1FVkRGTzdtSjRiNmpiZm5pTThid2t3QTNocm9nZVNnUTZo?=
 =?utf-8?B?N0ZOUjV0WE1lV0lPOEZob0lQZjY3NDhLNWJQbDNDYnFITVZ5c0p5bGhEeE1i?=
 =?utf-8?B?R2JHaFV3WjhLS09sSWk2Y3dlQ0p6bXZBNW5BZ3VId0k1VVJUNHV2ajB0WHN2?=
 =?utf-8?B?aWJQbmRDUC82bjZQWmdRSGtnNmQ1dXB5Wnc5Qm5mNnJFSi9YakpPMlJFNTcw?=
 =?utf-8?B?dy9BbndaY1pSam5wUFR4TXp6NVVFcWxsZ1pFeGlmYjhsUG5QYU5XQ2tPUStB?=
 =?utf-8?B?RVBZL2U2Nm5HY3J0OFc0MkVlZzNEMisrUWxoS0pwKzBMbFdYTHZPS1pxT0Rr?=
 =?utf-8?B?TnFiN0dydVdhTFBxemlRZHhha2drUW5JeVhTc0s0dml1dUdaM05mWDNPUmV2?=
 =?utf-8?B?aktPbU95VjB5NC9tZGRNN2dtc0JpRmV6ZmdCWFkrVlZRLytPWnpxTlpnRzNI?=
 =?utf-8?B?UFpONEo1RUsvSHJNaDdEYWZkSGhaZXU5TEtrSG1YbmU3YXhvTTdwMXlXVC9w?=
 =?utf-8?B?Q0lqeTNTWThRRlMyRmxrWVNsNlNBd0xpckhON0tMQVV1eHhSVldwbzdwNVVp?=
 =?utf-8?B?MVBYQjM4NTZ2SlJzME5aRjVGZmMxclFXZC83Z1A3RDBqMkRneHVwUVI3eFQ0?=
 =?utf-8?B?SVdBemlHMUFIcGw0RFVPZXFNVzUzYVF5dWZ1bFFxWU96MGdlemtqbk5lSDJZ?=
 =?utf-8?B?R0JobnBZUzdCekYxYmVqY3RiRFA5c1FxQ3Zzb29KaEt5eUp5WWpvVzI0Nmlo?=
 =?utf-8?B?OWxzcnppMlpRMUE5WkNBb1hOVkxqTVlNYWwyclJHUEdMZkt5T1dTemRmQ3Mw?=
 =?utf-8?B?VkJJU0hVeFlHMWdzdE5XOWd3VWR3cks0cTI5R2RPNWhvaExpKzVSQTQ4Ymhk?=
 =?utf-8?B?TTNwN3BmdEw1S2tPTmRyaHJHL0V0UnFRS2g2d2NGeW5kVkZvai9ROFZ5YUZV?=
 =?utf-8?B?SWlMVFVDcVQ3R2I2UjVQYWhmNWVYbURtNUYrMDBzVzN3WjZzc1E5cVJWZm5O?=
 =?utf-8?B?TG9RZ1IreDRSODVxVjJNYU4xSCsxTml2NStTNzhIdEY1c20zendXTVNDUkl5?=
 =?utf-8?B?MWgwRUZVaUFZN2lpMTQ2UkVLbVd3ekNETDNqOFYyb1hJb3dpWDk3NEduZTJO?=
 =?utf-8?B?RFVKSEZiVFFKSE4zVmNHazBXZzE1RG43dmtNMkNBUVZSbEt2ZDA2VmU0QmZs?=
 =?utf-8?B?NkpiL1dFQ0trRFZiTGlKR3hreXg3UEJLM2x4VU1oMk9ZQjJDTFByNXZ1Mis2?=
 =?utf-8?B?RW82czNGTUx5TUkvSmg5N2JVRG9ReE9MVWdnU1hoRERLN20xcEZBZXZUSkFy?=
 =?utf-8?B?YVB2K21DanFQR1hDeFZ2NWRFcFRJaG42aUE0L2lWdUl4VFpkdTI0MTR2WFNl?=
 =?utf-8?B?NWY3ZzVYSTRKZFI0bVN0bUtKYWJmSlZrRW9Wbk44RDVONCt3eVBzU3FiN1p6?=
 =?utf-8?B?eXI3MEgwWWlSWmtsbWRpNjE3NzgyaWo4OHh1S2tvYUN2OVQzNkQ1WnBSdXFL?=
 =?utf-8?B?cktrRU40d251aHlyeW16bEU4VzNzRDQrRDd4YTVPOHkvZmdpUjBzQUI1eVRZ?=
 =?utf-8?B?SSt1a3RxbVpsZ2hqNUh6Z3NMaTNsaWQvSmtFTFVMZVl4RGxDVC9YRGxaejVL?=
 =?utf-8?B?Z1pTNGhFZVVWN2hzb3F4Z1JXZWUrUGp4b25OTXNuUHdMdVVyT09PQW5JbXhS?=
 =?utf-8?B?Ri9ndXdBMWNRY0J4NzdOVUlsOUo3MkFpZ1RUckZ3RDg4RGFPY3ljaUZjazBT?=
 =?utf-8?B?aFF0dmxLSXNiTmdFK3psWmhIK0NLeTl2M3BCZmw4cm1aNlB1ZWdyTCtrOFVS?=
 =?utf-8?B?Zm5aaWt2RXJNVzR3VFVzL1F5ck8zSTE0UGMxUnpkTHlMREZlbjFydk1INUtD?=
 =?utf-8?Q?y6ocZmyMhAMJLefxV6sP8lts2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799e4e1a-4f2d-43e7-8406-08dd4b243da3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:15:18.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPtgmIl3r6A+FKSNNHbFpX9jSGpYFchu2kOj9gh4uYkZILDN/Zfh1XvsTtFUmcwWpA1IzDyPMUngh7zPC7KJQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On 2/12/2025 3:24 AM, Mario Limonciello wrote:
> On 2/10/2025 23:02, Dhananjay Ugwekar wrote:
>> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> amd_pstate_cpu_boost_update() and refresh_frequency_limits() both
>>> update the policy state and have nothing to do with the amd-pstate
>>> driver itself.
>>>
>>> A global "limits" lock doesn't make sense because each CPU can have
>>> policies changed independently.  Instead introduce locks into to the
>>> cpudata structure and lock each CPU independently.
>>>
>>> The remaining "global" driver lock is used to ensure that only one
>>> entity can change driver modes at a given time.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++----------
>>>   drivers/cpufreq/amd-pstate.h |  2 ++
>>>   2 files changed, 19 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 77bc6418731ee..dd230ed3b9579 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>>>       return -EINVAL;
>>>   }
>>>   -static DEFINE_MUTEX(amd_pstate_limits_lock);
>>>   static DEFINE_MUTEX(amd_pstate_driver_lock);
>>>     static u8 msr_get_epp(struct amd_cpudata *cpudata)
>>> @@ -283,6 +282,8 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>>>       u64 value, prev;
>>>       int ret;
>>>   +    lockdep_assert_held(&cpudata->lock);
>>
>> After making the perf_cached variable writes atomic, do we still need a cpudata->lock ?
> 
> My concern was specifically that userspace could interact with multiple sysfs files that influence the atomic perf variable (and the HW) at the same time.  So you would not have a deterministic behavior if they raced.  But if you take the mutex on all the paths that this could happen it will be a FIFO.

I guess, the lock still wont guarantee the ordering right? It will just ensure that one thread executes 
that code path for a specific CPU at a time. And do we even care about the ordering ? I'm having a hard 
time thinking of a scenario where we'll need the lock. Can you or Gautham think of any such scenario? 

> 
>>
>> Regards,
>> Dhananjay
>>
>>> +
>>>       value = prev = READ_ONCE(cpudata->cppc_req_cached);
>>>       value &= ~AMD_CPPC_EPP_PERF_MASK;
>>>       value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>>> @@ -315,6 +316,8 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
>>>       int ret;
>>>       struct cppc_perf_ctrls perf_ctrls;
>>>   +    lockdep_assert_held(&cpudata->lock);
>>> +
>>>       if (epp == cpudata->epp_cached)
>>>           return 0;
>>>   @@ -335,6 +338,8 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>       u8 epp;
>>>   +    guard(mutex)(&cpudata->lock);
>>> +
>>>       if (!pref_index)
>>>           epp = cpudata->epp_default;
>>>       else
>>> @@ -750,7 +755,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>>>           pr_err("Boost mode is not supported by this processor or SBIOS\n");
>>>           return -EOPNOTSUPP;
>>>       }
>>> -    guard(mutex)(&amd_pstate_driver_lock);
>>>         ret = amd_pstate_cpu_boost_update(policy, state);
>>>       refresh_frequency_limits(policy);
>>> @@ -973,6 +977,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>>         cpudata->cpu = policy->cpu;
>>>   +    mutex_init(&cpudata->lock);
>>> +    guard(mutex)(&cpudata->lock);
>>> +
>>>       ret = amd_pstate_init_perf(cpudata);
>>>       if (ret)
>>>           goto free_cpudata1;
>>> @@ -1179,8 +1186,6 @@ static ssize_t store_energy_performance_preference(
>>>       if (ret < 0)
>>>           return -EINVAL;
>>>   -    guard(mutex)(&amd_pstate_limits_lock);
>>> -
>>>       ret = amd_pstate_set_energy_pref_index(policy, ret);
>>>         return ret ? ret : count;
>>> @@ -1353,8 +1358,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
>>>       if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
>>>           return -EINVAL;
>>>   -    if (mode_state_machine[cppc_state][mode_idx])
>>> +    if (mode_state_machine[cppc_state][mode_idx]) {
>>> +        guard(mutex)(&amd_pstate_driver_lock);
>>>           return mode_state_machine[cppc_state][mode_idx](mode_idx);
>>> +    }
>>>         return 0;
>>>   }
>>> @@ -1375,7 +1382,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>>>       char *p = memchr(buf, '\n', count);
>>>       int ret;
>>>   -    guard(mutex)(&amd_pstate_driver_lock);
>>>       ret = amd_pstate_update_status(buf, p ? p - buf : count);
>>>         return ret < 0 ? ret : count;
>>> @@ -1472,6 +1478,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>         cpudata->cpu = policy->cpu;
>>>   +    mutex_init(&cpudata->lock);
>>> +    guard(mutex)(&cpudata->lock);
>>> +
>>>       ret = amd_pstate_init_perf(cpudata);
>>>       if (ret)
>>>           goto free_cpudata1;
>>> @@ -1558,6 +1567,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>       union perf_cached perf;
>>>       u8 epp;
>>>   +    guard(mutex)(&cpudata->lock);
>>> +
>>>       amd_pstate_update_min_max_limit(policy);
>>>         if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> @@ -1646,8 +1657,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>>>       if (cpudata->suspended)
>>>           return 0;
>>>   -    guard(mutex)(&amd_pstate_limits_lock);
>>> -
>>>       if (trace_amd_pstate_epp_perf_enabled()) {
>>>           trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>>>                         AMD_CPPC_EPP_BALANCE_POWERSAVE,
>>> @@ -1684,8 +1693,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>         if (cpudata->suspended) {
>>> -        guard(mutex)(&amd_pstate_limits_lock);
>>> -
>>>           /* enable amd pstate from suspend state*/
>>>           amd_pstate_epp_reenable(policy);
>>>   diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>> index a140704b97430..6d776c3e5712a 100644
>>> --- a/drivers/cpufreq/amd-pstate.h
>>> +++ b/drivers/cpufreq/amd-pstate.h
>>> @@ -96,6 +96,8 @@ struct amd_cpudata {
>>>       bool    boost_supported;
>>>       bool    hw_prefcore;
>>>   +    struct mutex    lock;
>>> +
>>>       /* EPP feature related attributes*/
>>>       u8    epp_cached;
>>>       u32    policy;
>>
> 



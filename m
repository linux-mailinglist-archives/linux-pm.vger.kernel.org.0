Return-Path: <linux-pm+bounces-15517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D299998F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 03:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA5C1F23BBB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A176FB0;
	Fri, 11 Oct 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQrxnHSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990D26AC1
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610608; cv=fail; b=WvCaMECu2LAcW6EiWzvG/wu8tjomywo75DYlrb1gWcgL91mO5dVEDG4ViOwpPK1vKZ8pnLB8eXMFWG3fpwbX7gcuzrehHBde6xK3Mp+83aaCop7BX7u3fbJWcNEH4JtcEEp5otk/9aTXNHvYRGJaxoWRdHI/847wzuaKgBFJg6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610608; c=relaxed/simple;
	bh=XikoeTyP7t+SxMXzvW722f6ZtqRNGgLMujlor0to5/8=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=mFfDI9klxgcZoSMquLjjRzfbJxiYeKWlnjAbpswWPhqNkF4sCt22pxJvmt1gpTGl9NzcRREa4bJYC0l3PbApDwqrGeKNJbhQBu//78ghyfscAak8sfG6gVDg0KUuBS6NhkUCjRNbu7nGOFvYpprVrWXTXIUEy9XGygorCpnKN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQrxnHSt; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUOocIl6dp5UrcRKPyZbc3bJryBFVGvLKVBuUCYgtYraSRNkv1F2UTrfWzCRQ0me6AibJwkGSAZWJeZG2+BooB/mL+VmNUvCKBHPnQYj5Tez5TJ0DFZHwsfpO/snLqm/gHmdY/6lnfmlhL8p59sFRYpVNAbIN+iUdAs4XXgouEOQCwQZnHbsMrxfQJtv/WmkuAgI/SJQOmPHSa3K3Oj8e3C8hKzcGgDujykqxtXjGMjrDDOG7TAU9ybr9SefPKOWDqM9uHmHgZwKl5op9ZeWXu0bxAC6Ti6uVdyFcg4lOgmFk6HgwZD7DuSMLV9YNjRp/Tc/Cz0iR1R+4wl3FFBDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxcubRqkumvQsGrnCVyVqTa0/d6DvJsozPWamEXjJTg=;
 b=yV43ulWRI2wiH479FjSXZe5BBeZHm7/LO1WOj2cQ9VpgRPrsyCsALWyFuFPCS+E6FgbkQME8S2Sn1W57VL2hdBMbQ0JK1oM2q5ifFWdZL65/uuR5SXnJT53MmpQ3e74VEwlF6E1YkZOZBwllXUuvkNwUs7KKDQdSjMI1iMR8BCIbu1LDUFcUttImW1mpaM2NE5QspjKBwibwZv4XWZ4wDU+3LyGqCVV6VOfljVTONo31CkJKSLDucPCC/58dH6OBlw0LOXEJ/mlo+OcoAFwz6ruxI4euQguY5FS7jpuUjcgetusyZt42LfcNHO9A+0E1h8zp87giB+2Xorc4MKZolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxcubRqkumvQsGrnCVyVqTa0/d6DvJsozPWamEXjJTg=;
 b=AQrxnHStWDOoM66Re7FOihQoREleaoJXc15zFZj8oBDNOvHfMgjYh1K6JeUtFdS6NZBHBZpP1yjGVfMck56+Obt10SwAbNiO7AeS+znLudm+lEuOsA2LA2GrpHMGvRNzZi4ktfE+UkM3Vw/oQUSUsSnF4DUFx6HFH4DSFlpZ7Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 01:36:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 01:36:43 +0000
Message-ID: <ec4ff18a-ae7e-4a29-9961-8b53dc8a3acf@amd.com>
Date: Thu, 10 Oct 2024 20:36:42 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: amd-pstate fixes for v6.12-rc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: c4876bf1-6f38-4af9-d160-08dce995297a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHFzNnJPV08valNzRERWekc0NVorL0djQ3BzVmtqUVRSdExCc3NEZjlOaE5I?=
 =?utf-8?B?TGdTYVVIaElOY09BVWxDSmRaYThUOStnRGU5MkRFSlB5ZDc4b1BEeDRHTDZW?=
 =?utf-8?B?UUQybHhGaHJIRW4yaGxmWjFtckNRSHI2aWNJRmF3WUt3MGd0ZEVMYXlEMUE4?=
 =?utf-8?B?Mk9GeGJ0Ris3eWV3cUFGc05CK2ZmbXFCVTJOdlJrZlNKc1NtQkgyK2wzdExu?=
 =?utf-8?B?VlJXVGFSQU51aTd0RENVWnZLWW5mSzVaRy9tS3ZtUWFQQzQ5SU43V1V0Z0hU?=
 =?utf-8?B?c3lxSng4SStBaGhxcVBkWERab0VELzBxOEZWOUdqYlM2bzdORDZVUWtrcmo4?=
 =?utf-8?B?UU1MRVh0ZGhkdTE1ZEhTOUJaajZFYU9nQ2puM0dnZE8vMURFZEJFWEYyZWtT?=
 =?utf-8?B?NUpWVlBpRUhtSTBob3JJQTN5RWlrNmNNMTZQOHZSbHg2UnNOQ3NMdGE2Zit0?=
 =?utf-8?B?RWZvdXFJZHRxcUZ3VHQ0eWtCRWpVQnVSMzRJRDloZWJUMlowVDUrR1EwZXZM?=
 =?utf-8?B?bHVhSXZnSENLcVJkZFFPZU1YRlRldzRuNmNiclVvWnNHb241aUxRRDBkd2lX?=
 =?utf-8?B?WE1yUi9tb2FxN2lNL3o0OHhpTXZuaFpGaW1CYnZuVTVDaVZobXlXdkNVcVhw?=
 =?utf-8?B?MnY3TTh0clM2QUIxeXNxSWJaandHK3MzWjU0RXVXRkszRzBKcGtRa00rTGxQ?=
 =?utf-8?B?TzlaWHFlcWZpN0JWbW05dGhKQmhEK0J1ekYvU1d3SzJXUVI5OVNCaVFZR1dJ?=
 =?utf-8?B?UEJ5RjBUam41dFYwamcvYkd1SDVJTFRvL0tRdHJwelY3K0hWNTJROERuQXhN?=
 =?utf-8?B?SnVGbmxtenZKRmtVWndTaXplV0Y0QnlNZ2pSQnZ5K1c2WDE2S0tEVUFlc2VI?=
 =?utf-8?B?dzVOdmRUY0ZaZjNOcjMxUjhYZ0hZT0RrcHEreks5eFk1WjVWWUhYNkl2clRC?=
 =?utf-8?B?RkJMZDZHU0NBSE5pM09XaDlvZU42RXdRRy9CWnNDOWFidlducGRmamYvTUdC?=
 =?utf-8?B?YlVaSS9XY2dLQnlmVG1LQ3BqSms2RmFmdit1a05TYmdKSDVBcW1ZdXBMNWRi?=
 =?utf-8?B?MGdDZ3lnalJUQnhuSkx2bWt3L3hvaDRKR0QxbzcvOWZvQlJUR1dnQ1J5SjNP?=
 =?utf-8?B?aHRnTjhpL3pBbnAvM0hVb2tGdWFwSkx2N2ZHb2hhN1RaUEExM0lWYy92TjJl?=
 =?utf-8?B?bGdQSjBRdHhsbWRKL3ZRMklGWTlJNzU0WmhncVdaRWp6SHpWYzRCS3k2bkds?=
 =?utf-8?B?elRqNGhGMmlqZ1RkQ05KL0V3eU9Sc1R0U2oxdWpUcVJjMjAvWlVteEZxN011?=
 =?utf-8?B?VXpZclp0K3dMb3J2bG5ZWURRVVo0S3RvY1hjbVBHQW9HOXk4aC9MMGxjQzRG?=
 =?utf-8?B?MTRHaG92aVQ4RGFGbEFGQkF2TUowUTJkR29HOTR1VkVUVWJRR0l2Z2orL3Ur?=
 =?utf-8?B?SEZWTjhwQ040VkZEU1owWFpwY2VSNHhrN1p4KzNjSUlPQjcrYzlxaG5HMEdl?=
 =?utf-8?B?MnlLaElLbkg3YWZoQWc3UDhpbVJxcXgyVzJLQkJXeXE4di9CVFp3RkRTL28r?=
 =?utf-8?B?R3ptTWV0V0xDRTNSRzhmTDlZU0pTUVp5V0NWblFTNjVQenI4NlpRVzNIbDdT?=
 =?utf-8?Q?TQpVglBsq/77vwHzzTogwsYy65/v5khQTHloNiIh9utA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFJWdWdMZURsVWtvWlM4c0hOM0N6emM0elYwNlU2cnE3OG1RMGtQOGhMdXQv?=
 =?utf-8?B?UVVhYnUwQy8yd0xmc1Eyc1h3bFl0U3cwYkF2eVc4SG9Fd01lRnF4WERrRzZw?=
 =?utf-8?B?WDJzWGlYcmw1dzNRNUlYOUZIU1FyRVRMVC9TSCtnZy94SHdpZzlIMCtvMEVw?=
 =?utf-8?B?K2tlblBKWkdESTZiNW1BWlhjMDZuVzlRV091VCs1Ymlja2h1bEE1RXIrVkRh?=
 =?utf-8?B?NWgxb2ZCZkdHeW45ei9YMloydGJTQm5uNTJYV0FuVHIxK0hscHVlMVJwUmtk?=
 =?utf-8?B?TWZ3TzdzMit0cEQ5T3ZxODhhVk9SMkhYeFRQM0pVSGNpeXp3OE9rQnQ5ZU1T?=
 =?utf-8?B?VFpVKzh6MWkxNlY5QVliU09JRGR4VndOb1BENUlNcEI0ZXVaVjFUMXR0c3Rh?=
 =?utf-8?B?bjhRU1hBRU55a2pNajI5NEMveHMyOWJ0ZjFEeWIyNkVKYk0wV1BzOWlnVVov?=
 =?utf-8?B?WktjdWRqaHFnWjRzejk0RjJQOEE0ajFEMVVSZXdmTll0MEJ4bDVKbTFWUUFk?=
 =?utf-8?B?OFN4R0xEaGxuclVWYmRxYWdMd0VhcGhkY3dNSmRNSjJKeXVNV3JadmI3c1Jr?=
 =?utf-8?B?NnJnVk1CNktsLzhGcktCWjliQUMreEpPOFdrMEJDUTYzNkRjbWxwK1loTGox?=
 =?utf-8?B?UDZ0N2h5elczNGVyMm9uaXFtOGZ6a3VXNnpKWE5oREFxb1Z4MVRmREc5VE5E?=
 =?utf-8?B?azZ5SnNsN3IxNkI5SUYrQzhlWGdLYjNEdFpibzRzWDRyV3J5VnZEcVVPZ3NS?=
 =?utf-8?B?Nld6TW40ZVN5cFdxc3JibFk3UjBvS1hVNmVQL0dmMHh1M0J3cjN4TU5NTWVP?=
 =?utf-8?B?aGNHczkwdlE5RzlpanhRQ3cwZERqQ09IRE9jMnJtdUtLN0JRUDdMZHVKdTZp?=
 =?utf-8?B?TnBJK3NMOG52QncxYmhPTnIvZ3hLUWIvMGFURnRhUUhMMUIvMHJLdFJKYkhn?=
 =?utf-8?B?dXRteWZzNXFESmFFQkxaQnIvWmRsUkJyMUgvb1NBYkZiRVZpTmhxK1ZWNkp5?=
 =?utf-8?B?MXg1TEhtNmdZdGxBS05EZmZEZjU3cExRZXd3WEJXNE14d2k5YVpiNVJscVhx?=
 =?utf-8?B?V29OQ0FsYXpEMUU2Q25adUhRcStLYlBSbkQyRUdPNk1abFlrRHpXVUVBbHVi?=
 =?utf-8?B?Rk5FR1J6WFNpallLQWNqZkJaS1hWYmVCTUJqT3dLR2RJQmZDRXExd3R2RnJk?=
 =?utf-8?B?VnNXM2FaTjNpYWlMOXdQUmZCeWdlSlgrVDQya0VLaFVQV1Zyc2FBU2s3blJO?=
 =?utf-8?B?M0Vla1FWZ2dpaFdSZEU0VXNtS3kyZW5UNnlheGZqUEdrdU96ZkdBcFhSdUk5?=
 =?utf-8?B?VkF3ZGdTdlBzKzQ0dW9Ea2w5OWxvVERDRFd0NTR4OEN0VXF2RVVwejc3TTA5?=
 =?utf-8?B?cHdWVHZDRGdURGpaK3lUYkhONkRNbDdBNkNCR20wWEUwZ2ZNelJTWkhlRTR4?=
 =?utf-8?B?WEFFcmJXUWZkR1h2ZnprN1BhZFVmVFY1V1cwZGdtbmJrUENpUGNtU1UwZURK?=
 =?utf-8?B?a1pKUlZuLzU2T1NITG1oR3RxNkpLMi9vZk05WkROeit4ZTZXNEk0cEtGNnFt?=
 =?utf-8?B?TkpHUEJSUGFCNnhQOUFIQUFvaXdDUEh6eHBpSDBPODlyOUk0dTFiV1RsK3F5?=
 =?utf-8?B?WHh3L0N1SXNZNnptUThCQ0R2TUN5NmRYVStYWXd3UFMxdG1mT0d3UVQ3Nmlo?=
 =?utf-8?B?T3h4eDlRbHltdWVWOStZT3BFSEFCTmZ6K3FxRmJwbDdIc1h0VXlkVUU4Qms4?=
 =?utf-8?B?cUlGdFdlUjVweWxxWnIxWXNoWTBmblRYOWdpYzdSK0ZHcm9MU2d2cXkrejN6?=
 =?utf-8?B?a2s0dGNLSHZPV1VKWURuNmtYcXNKZ3lzT2M4U1lpRnhwSktPeHY0M2loaTE4?=
 =?utf-8?B?Qk4ySi9PTEh5b2VIOGdVNVNwbXNhaHhUcjFSOWEyK0N0MHJ6enU2eEIxUi9L?=
 =?utf-8?B?NFhqcEIrL3prVlBvMThPbXhQNHNFcXdQczgwMVRjRnQ0MVh1TVU3eU5SUHIx?=
 =?utf-8?B?Z1htVmpPVkZ0VHQrQ0g4U2ROQnNkRW1BbnZVRFhIQzZ4eTN6MStsM1BkYy8x?=
 =?utf-8?B?aXlWWGMvQUdWSE1yTURGeC96MVJXaHdESHUrNkFpY09zVFZ0bDdiTVlzRDlQ?=
 =?utf-8?Q?C3OFix+kRrvwCyPdxsAUuCugb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4876bf1-6f38-4af9-d160-08dce995297a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 01:36:43.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDsdERXVw4NdKYqrM3vOHlwDZsRwsQZcCXnSwi6rbRhX3+BNEO4uGIg6sRNCTxlsjsKAv2xgwX6U1MybCeYkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

Hello,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.12-2024-10-10
  
  
  
                                     for you to fetch changes up to 
c10e50a469b5ec91eabf653526a22bdce03a9bca:

   cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory 
systems (2024-10-07 11:32:05 -0500)

----------------------------------------------------------------
Fix an issue with changing amd-pstate modes at runtime on shared memory 
systems
  
  
  
  
----------------------------------------------------------------
Dhananjay Ugwekar (1):
       cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory 
systems

  drivers/cpufreq/amd-pstate.c | 10 ++++++++++
  1 file changed, 10 insertions(+)


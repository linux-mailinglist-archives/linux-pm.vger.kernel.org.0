Return-Path: <linux-pm+bounces-6940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF098AF4A5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7561C22874
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE013CFA4;
	Tue, 23 Apr 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vid6G5Hy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F174CB55
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891177; cv=fail; b=VPF0iHenoB+2x41Iq9gYg7CN7HXRIcU5mE0HzQC5+ZIt3jc5VYkywyv5F2IyB6xsWiPYUICLpDU0Ahe7r9Z8wOjWEJkJBNIITUAkRnq4XidR7LfbjBa+Ou03SXXshIwirsQnPSetQ/0q8sCW54yJxlb/pLB5Beh/NAKe7uqFsaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891177; c=relaxed/simple;
	bh=uPfjTM1lXGdJepxleXsB6q+DNb9FKiYFSaAHxuEUB6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fAeZ2BTtJT2fnJFIFAWDcHTGoRKeJqrvEEQo/F5Yv9h6+yVA+PVbTFV7zRoukFTGo8mJN9MdfhWycw9GR/1PPcWcSTx4jGqGPAm51fqXKMAIfe74gGFNNahrYI1X0c2fiUuVHSC/Xkl2OpJUOz84yzqkllaJA7/NZQR7aVYcBG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vid6G5Hy; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge+uX7LdVY1MbNwSK2fz+uFZPtPbJWYJqiqnX1Fzls4enGc+syaxwnYDMaK+9tf80JaE2hz3trEKECtzolruy9ufsdpF+wlf4KWPgFDgR1nWghCMWZ45WJGvrrFLJXwaClGCqbb0ePGbyl1GMCyTMxLUVG0TG/rREOB3wHR8AchZ0JbROEidrxk6o62E9u/7TC/RwuhBoD9wk+u6S3xa/6WhlSqOfo2x2nEAwikAwb31gYY1QGIIi+c6vqprFPwkxfqyfeukCmw3cpv8V+f0dks2QhmtFiQD9wASYvNnxGVgQYRIxP5eQjWXBLA2zDSKvT2cE/HL1cQ1JuAN/0x25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HhCoLl9N9qKVdeG/c2XZz1XJ0j9BoUvn+t6k0lugRk=;
 b=WC1qJ68H9ZP6vmeuZoZw/kgiHZh/iNSMTcQxpR1h3gupUqgTzbooCBIVpiPqTMBjCgZqGHsPViTHVhFEtYpHqA8S0BsJNWipGALHEIWYzQ7icdkk1GAfton9hDT3aX7OXKn3uFS67cHDET6hiMOR537fYE5i+bEwLqG5FwdQ2wBIFJ3PJFVhikhM84Hwecrrmv4ro9Dx4758S4H3jhwwqVA3/GfL3Qlk1lURwqypk3KXiCIgjO5EWcPNpJknJv+bSOGQ2BK71kvnkBTtjoXX7cSsFWFkhMLtt5PWeVOV7cBqWo+o3O/iOOwaOjY8tDRWoNz4s0D07KZlheFoBvaZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HhCoLl9N9qKVdeG/c2XZz1XJ0j9BoUvn+t6k0lugRk=;
 b=Vid6G5Hy+ZJIjDzln87kqkbvIR9AsTJnqwSNy6u25AgV3BpZuM/m+qmZ9gViRq/aOg4F0RHYfDPhvhxAjigVRckTfpMRjB2wNRIi8vdQJN9tJrO5LnrPClC4BxavdMOoTrKcPs9MW61Wqg4u7k/BZKu7qJTLZlb/a1NfucT6yKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 16:52:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:52:52 +0000
Message-ID: <2f07ea21-c89b-49dc-a7b6-8c4e207d1af7@amd.com>
Date: Tue, 23 Apr 2024 11:52:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: sleep: Optimize the pm_debug_messages_should_print()
 function
To: xiongxin <xiongxin@kylinos.cn>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <20240423081723.412237-1-xiongxin@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240423081723.412237-1-xiongxin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:805:f2::47) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9b0db6-6784-4de9-078e-08dc63b5d11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVhTRjJabjRKY3hWMWhrRDdsdFhlOUtRQzFHVE9xRjlxZW45S3l6amQyS0Rv?=
 =?utf-8?B?ZitUbVA4azg5S2tQL2pIVllORERNcWRrV0xoRVdLREJWdGsvNlowT2NjUHVj?=
 =?utf-8?B?cnNwK3dRS29WSmZpd3pzczNlSUpKV285Y01pOWpCcUFlSXh3b0JnSmdGOWwy?=
 =?utf-8?B?U0F4VWRzUlE2emx4SzFqKzVqRjdTcEs4USt4b21VUk9zOCtsOGxFZ0ZyZnlY?=
 =?utf-8?B?UjQydlozUTZEQ3pPcVVpeDNaUjd0RnNwYmY2SERQL2Erb2N1VUludWt0TE4y?=
 =?utf-8?B?MzZraUF3dXBqSHYvb0FpYW84RG5pdm0ySnJKSlduaGNsK1BYNFZqemE5OW9P?=
 =?utf-8?B?WXJ3OW82aVhiNmJOTG1KNHYwOEVURTZyZ0h4dHhlNHpUWFhzMi9vaUtUOVRa?=
 =?utf-8?B?amdvNVd0UE0ydVNYYkwwSndUM0RWQWx5Vk9BQkZRQVBZd2E4bjR3Y25aaVRB?=
 =?utf-8?B?WXF4UXUySjhGd21kRzJVWU5IMCtOVm0vZ1FDc3BjSXJ6VFJXUkJQK1pESytt?=
 =?utf-8?B?RkdDZW1JM0Z5TUNuUm82Umk1NFBaeHVwVFBpNG1MUkR1d3A2RVZGRDFvdTVz?=
 =?utf-8?B?TytUR1ZwUTMrUXhvbU4wNnhPQy9ZaGhsbGpEcEVRWDE2V2NNVGg1TGdHVDBp?=
 =?utf-8?B?cjcra3FvVEFKVVZ3cjZHdjQ1ZkEvMzhyQlp5YVhlMHRJTDJwOGhjaVYrcEcw?=
 =?utf-8?B?b29LNnczSWd2L3JaYUdMaE5kdFNzaE93bUVCckhxWXhDLy91QXFsMDFBTDJR?=
 =?utf-8?B?MjVGVld3WGRMSURqWmdCR2lNR0RTc2w2SUF6eVFITXNTZDZXcHNJSktrZlJN?=
 =?utf-8?B?UWl4MmFGaWlmUWQzS0VHQkRpUndpa0dRSDBRS3VWVlB0V0hGM09DWnkyMUI2?=
 =?utf-8?B?WmtDcjlZdUwybTd3WDB6QU8xUE5UMks2QWorZlZxRFAxa1lBZCtITzgxM2Z1?=
 =?utf-8?B?Q2g1ZUJlS0t6cittRDFiTHhVTy83dkxTWEJlTTI3eldScEI5SDZSa3dBalZX?=
 =?utf-8?B?WGVPdGRlUUg0WVZ2V3FTbElRMzAyNFA1a2FnRlpCMzZacithdC9MMSt2WnFw?=
 =?utf-8?B?VVl3bk84SUl4L1hKU0hRSWJuZklRcTZRaUNsMVk4UFNxNUVPdXdScXBkZlQ1?=
 =?utf-8?B?UzhYNUR4bkFFeUNrR0NXMkc3QXgwUlVTY0RsV2lXU283clQwbnRFa0wvMjkr?=
 =?utf-8?B?OXJRRnQ4TFRsR1NWVjBGNzRCQ05oUUxvSURkT0xvZXZuRHdZaGtleXFiR1lv?=
 =?utf-8?B?YkR3T2Vvc0QraWgvalFhVllNdGQ1czdtdDgwS1BsWm01a1htYldLdXQvRHRM?=
 =?utf-8?B?R1VPdDRQM0grT29VR2xXNjQ5c0FyZkgxQkNIOWovLzBnQ2ZWb0tPYWlqZUZy?=
 =?utf-8?B?MUk5enZMK21oSENVTjIvSTNVSW9EaTh1clphL0ZTZU80Q092bkhMTEVraUxO?=
 =?utf-8?B?K3F0WFJBaFo0a3hFODc3WURQZnBPVVdYWEZlWVQyMGlMZk1vd2M3UktISjMx?=
 =?utf-8?B?ME15cUp2b1crYnZZZmsvMUtFWmtZUFdoLzd4N1NoRFN1SnUzaS8wTGIxbWNZ?=
 =?utf-8?B?WjMydWxnY1kwTGJucWtlYWc4emR2eE1tbExwS3hWSFJzOUtNTzhIUnNJZ0tV?=
 =?utf-8?B?dXFDcTh3WXV6TkRHcjFkVWM1KzdOV3pza2xNZXBaeXVuOHRHbThVS1U5dG96?=
 =?utf-8?B?MUZzZ2hTQzE2RFpkRjJDV1Y1a25UeHVNa3Z4TmFaN3ZPcGQ0U1dHVEdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2IwTU1sRkI2YXpsZnNCQUQ0T01RRkRVM1o0SEJCS0ZDZXk0MUFJTWdvUWFB?=
 =?utf-8?B?VXlVRGdzTy9IcnhYc3hSbGNET3dlRGtEVTMrL2YxK2oxRGNqYkF2WFI2QlpH?=
 =?utf-8?B?RXZLZUlRR2dVeUc4Z2prMUZ3UUR2WVh4MnlrSVgrYkFHbUoySFd5aU4vTi9G?=
 =?utf-8?B?Z3RNQTNBOFhSNGhhTHRlMVVjNDZDRjhOeURsdzN4bXg0K1kwNWg4TmVUTElQ?=
 =?utf-8?B?UzBCYU5Pa2lqbnA1b0pJc3ZYb2QvVmJsV25YdFFZaG9rUi90SVZTV25yT3pR?=
 =?utf-8?B?TkF4S0tXTzgybHN2cVR3V0Q1OGZYNlRZdVNqbmttVjQxZGNvWUh0cWtOYVN3?=
 =?utf-8?B?Q2I0cjRET2ZzZDVYZ1ZoQm5pVjh2RGZwUkpTY0g3WnBxUmNrVDZQNnNEVVZD?=
 =?utf-8?B?b2tLb2dGRjJFUWxGbmoyb05sUUUyc29jSGVrQ2tvSHdiN2pHZjBvRVhRdHpO?=
 =?utf-8?B?alh0Y1JQOW4vT0JTVVBvV0orOEh0R0IyaElkYlU5TGwrRG03MkVVRlBmajJD?=
 =?utf-8?B?dmpaUVlzVVcyVlhrOFBjb2dTT0paZTI4dTZ6UWo3WjBEUG1wN0VVV0Z3a0Va?=
 =?utf-8?B?dHA5S0djV0pEcm93YWVIb3RkZndBaERjNHp3Z1c4c1MyMG1SVWNQRzgrakN3?=
 =?utf-8?B?NG9VcnRVUUIvL2U5T2s2R0VtU3UvM0hBUEtjUDJYV25icGp3L3VGTHp2ZXBR?=
 =?utf-8?B?NW92MDVBMHhPS2EyankxRm5uRmFTR1duQzFCSmtTVFUzSmpRcldoQ05MY0pU?=
 =?utf-8?B?Wjh4WnRHckNpNHZ3Vit0TllMUDMxY1p4UEpkeG9vRGlGSG1BYWNZc2xBYUhp?=
 =?utf-8?B?Qy9SMGE4UEdORzQ3Y0xQVHR0RXk3dlN6aytvbi9iOEp2djFqckJ2VG9ZUXRj?=
 =?utf-8?B?aVh6bXZ4Y2swZUxxKy9hWGlhKzVZamliMXBBWFNSMUw2NzlFNkF5V21PeUxL?=
 =?utf-8?B?SDk2aGdPSUxZa3BPVk5SMUJCQmErWXkvaXF1OFdrOVlzcW10V05SUkRtQlYw?=
 =?utf-8?B?Rm9iUC9lL2FwME14RDFaWlczR2xRZ3VsczVQQ0R6RHFuNTFFMmlEV05nRjF1?=
 =?utf-8?B?a1ArNUVoWVNNOXh6a0E3OEQvd09kcGxMdXNnQk0vWGxhRC95MXJpaitYMnpE?=
 =?utf-8?B?aGthNmg3SitBUTZpdVlUQWN0RFNCdUFsbHFENlJNdHVxQlljTkcwK1hGYjBO?=
 =?utf-8?B?L01GME9kZytGektUOE42R09RWFdnbkttQ0tXam43N3Q4dU1hYWRScFFZbUg5?=
 =?utf-8?B?Y0oyViswSGZqOGpTbHRWZlRnWUgzV3BDS1VpaG9ncURSZVowYlBJQVNQdlQ0?=
 =?utf-8?B?aEZ0dXFzK1ZXdVdWaFdWMjgxTWZHZmpLU1hjbkZxWDN2TCtOWkxHejgwTXhm?=
 =?utf-8?B?eTNYaEd3dzBDRWEvaC85c3c0d3ZFcmthZCtheElPQ3AwcFE1MkNmTVgzOWcw?=
 =?utf-8?B?Z0hKNEsvR2dhbEVjU2l5YWFwVXJqVm9SQnNDZDZaUi9PcXNURjBHZ24xVDBS?=
 =?utf-8?B?RkF6Y0lsdU1RU2JOd1dvQjZZTFJhRWd2VllPTkJEcldUNGlkUXc0OG8xaGJV?=
 =?utf-8?B?NHJBbXdvK3FhRFkzZlJHVTdBVGRhc3VOaEZHYmt1cjJuUzRDMzBYWlFzc1g5?=
 =?utf-8?B?RDFtTldHRWhIdGVPQzR3cW9rdC9DcnFmcVdPSm9nMWxCalBrRm8wR2ZNcmlu?=
 =?utf-8?B?QnQ4TzloY3VZMGlTVmo3elo5Y0ZSc0hvaFJ3RzkyWEQ2L3VQUm02cVZqYUVR?=
 =?utf-8?B?S2FiUGFzNGR0ZEczZE5HU1ZIeDNiWHpEMTRBbDc3a2FpMUQ1elJxVWdqQjV3?=
 =?utf-8?B?QzREN0xWZWNNb09ZZkdicENjeUtpTTVLM0gyZDVtQnV5RGNwWnZ1aWVUNHJ3?=
 =?utf-8?B?RjFLemIxUENTRVIzdDI0RkhHWjBTWmlWS2NWZHNMRkNDaXNGd0tzSUNJT2ty?=
 =?utf-8?B?cm1VREYvZ3Ewa3pxS0s4ZlN2ZlBCTkxnelFEMUdzRmcrWXlXT1BsWEI4VkFu?=
 =?utf-8?B?L3d6Y3NWcW5sb3FSQ0hLeHpDMWdPWWswUm0xVmdZRVhqTXZ4NGIwcmRoaWFL?=
 =?utf-8?B?VTB5dXg5RGJwcE4ySzgvMTQrZEJCWG5zbnlPcGZZNU45Nng3S0l5UlZBWVVF?=
 =?utf-8?Q?hE8RCjk9kuX2r6mdt/Ru2w8ZO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9b0db6-6784-4de9-078e-08dc63b5d11b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:52:52.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWe0dvWQ9vc4KlDMZxXDgj0Xd6cRsym8SxbzVykLdRQNT5s5fIEpjLwrrzZ5mny2f/87HaPd9tDs+8KMVI4ORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

On 4/23/2024 03:17, xiongxin wrote:
> commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
> messages at suspend/resume"), pm_debug_messages_should_print() is
> implemented to determine the output of pm_pr_dbg(), using
> pm_suspend_target_state to identify the suspend process. However, this
> limits the output range of pm_pr_dbg().
> 
> In the suspend process, pm_pr_dbg() is called before setting
> pm_suspend_target_state. As a result, this part of the log cannot be
> output.
> 
> pm_pr_dbg() also outputs debug logs for hibernate, but
> pm_suspend_target_state is not set, resulting in hibernate debug logs
> can only be output through dynamic debug, which is very inconvenient.
> 
> Currently, remove pm_suspend_target_state from
> pm_debug_messages_should_print() to ensure that sleep and hibernate main
> logic can output debug normally.
> 
> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume").
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> ---
> v2:
> 	* Resolve the compilation error and re-submit with the fix
> 	  patch.
> v1:
> 	* Revert the commit cdb8c100d8a4 ("include/linux/suspend.h: Only
> 	  show pm_pr_dbg messages at suspend/resume").
> ---
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index a9e0693aaf69..24693599c0bc 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -613,7 +613,7 @@ bool pm_debug_messages_on __read_mostly;
>   
>   bool pm_debug_messages_should_print(void)
>   {
> -	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
> +	return pm_debug_messages_on;
>   }
>   EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>   

Did you miss the proposal for fixing this for hibernate by adding the 
extra variable to monitor?


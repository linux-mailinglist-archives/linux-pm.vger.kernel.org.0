Return-Path: <linux-pm+bounces-9506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBC90DC55
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A883E1C219B9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C62161900;
	Tue, 18 Jun 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uG3DlaWi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A715747F;
	Tue, 18 Jun 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738717; cv=fail; b=A03aHq3oG+0HXwR9486XKzA25vIsfcQRvW9dBoFvAu12fMQGUaBxACpoUdFZL7e0L6x/OCcOtJn6t8f2cX+OZumNrbNXB6K7/DYABO/OjnV5DGJUMA7/ciZDFBjqo7I8stqlQEeWNut48t1PQnSU218+tRl1rwA5s3IAl4r7wJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738717; c=relaxed/simple;
	bh=FFhvBxCts1aBl9kvnhTxtWiZyHTmpcWE4qdNrnVq2P0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jv2J2kZnds29N0ASqgC4ox595D4zC1HXEE+HY5foZe+mT+dJVtthKOUhYkAyCndjlOg5HmkeRZZ/rWbZUK77AMAy0WHxoz8uGhS8IkecgoCEH3x7FauWO7L8vpG/J52wgqpz17JyVZ+Po2qsbNBwzE+g+amFZhVIg2kUlIVFHts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uG3DlaWi; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTY+PEkR7sY7oEsaTtONOH6oo8mmTxmxRWVrijYOwd4o9ctpzo0uyFNM323/zmq+2cKWuksJl1lmfkOMsJV6myl0iB6kwqxS6/uPYOI0eE8PzD2EMkOlc3YQ+y5ZQgrzOpNVwpihDHCjmXZSGLnabz7qrmHTENN/GMLFIWCfyxElFkB9fb8FrGyazrrDoPFw7PfHZWgJHWryXR/TPRCh1Hr+9SnFkZx31c0SFCD2snq5bmFvWBDSam7dj0PR/8/tzE8ngZPIbOuTdehwWTwomH6at9+RoIQu+L8kvnWLF8DaSpV5KIF3w+xJR5yfM0GUeG8xQepnBbiL2ZNmP4p+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JljtkeomtGh5HbXKZQ9UG8/40Aewmccs9EbgJpec4Bg=;
 b=AdOH8re60kymjwC7mF4B8O60kha/L/9N9zAAGCxZiDEbhU32EIYOTv028A0EiSfQVSwEEUyOSwmtw5uxA0FDdvPebv64tGsUHXeL3PnJ09w8SPCJENMwPKU4dOYvF+u3Jj59lF1vbCZvn9Od2nx6tqA5mExqX6jxwFedFpT7vWG0JP1WXapl27AJtvQ8p2zgDSEI+RISoi2TNYtWyyPyidCO9fZnQgLPBcBWaUBvsy+ltQdtt66bktSva2g3uyL8oFx6lfha7hQ2avJtW+RnU5oFTSpQHZP+dxln6AclcUu5yZdceNkSZFlSsWihh8g802i1dD3ufEYKVlOC32Mclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JljtkeomtGh5HbXKZQ9UG8/40Aewmccs9EbgJpec4Bg=;
 b=uG3DlaWiI65JP34vmrtg5jfnEc7ttC9ao9zUUAigV9LiOhgcyMn4kBHFb4DwzuQLx4m6N01TX55R9ErKVjaI5wF0zp5qnGH79gbL2MqXASb0ZJ5eA68EqYSiN2RRpYBukK4l+3xz4xkDdpO1cboNcHKJGF6CIr/VQ+0kp/3b7sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 19:25:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:25:11 +0000
Message-ID: <8d219c30-feee-483d-ac80-bf7e7426f948@amd.com>
Date: Tue, 18 Jun 2024 14:25:08 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 04/11] cpufreq: amd-pstate: add debug message while
 CPPC is supported and disabled by SBIOS
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718606975.git.perry.yuan@amd.com>
 <2f5dc55e0537b089e1f4d31914c0b5c5c12792ac.1718606975.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <2f5dc55e0537b089e1f4d31914c0b5c5c12792ac.1718606975.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4aed50-597f-4896-ff3f-08dc8fcc5f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmZoR3RYUGltOGZ0TitwMThLbVloSCt5ZUxVbGNtc2lxYmlUQ2JSaEt2Zitk?=
 =?utf-8?B?bG5MSnpDZUNFWjJqWGVNZDQvdElqeHhvWnRNR3prSDVNc3hHbXRMbjJ6K1pK?=
 =?utf-8?B?OW1ibm5qVzZxd3p6WnVublViMDNWVHhDM2s0Vkl4MlM5bURvWlNoVW5objR3?=
 =?utf-8?B?OW5WdWpCeHVWVnVqRmI3eGtPV1JaSUZqeXlrK0pkTFBpbUo2SDVKTFl1aXBY?=
 =?utf-8?B?UDVkMkwyVjY4S0xLWTdRSldIQ1BEb1RwZURjZGIrVUhLMDBQNXZrY3NmWjVU?=
 =?utf-8?B?TDJBS0kzZUhqTkh3amE5K2NPM05Qd1F0clU1TWsyeDNYS0xzWmlTK3R1Rkx4?=
 =?utf-8?B?NnVRUzJQVzU5ZWlkSHJiS1hGUU5BWFZEZXBwYXRMMlh6WEpoYktiVXk2LzNx?=
 =?utf-8?B?ZzZtWnFtQlNRNlZpa2FKNVVpcUtkL2piZmtRSS9nMVJ5YUVuRy90UDBCRHg5?=
 =?utf-8?B?Nkh1Zmlpb0dGMGUzTWV6WWh0UU9BbE9jWmNhaisrUWN1eTV6SU1mdENkTW5U?=
 =?utf-8?B?Mk9vcWgyZXhHOExJU3h4c0l2aFVXUW5uYVo5cHFKRFlzZDRBVDhpK2Vvb3pv?=
 =?utf-8?B?UjFhTE5RV0tTay9kWHp0UFBYMGxkU2t4NzMvMTNLMnFEYTZFOWZGRm13MWcr?=
 =?utf-8?B?bUlkaVkvRGxQVDhhUS9Vb3lwd2NLNjNrQnE0ZmcxM1hxdndtRy84ZVFRR0tI?=
 =?utf-8?B?cHVIRUdMSm93MkR2T0hoUnU0MGVXMFpNNkw3bUpmWm45K0NJNmRJcGtKM0JZ?=
 =?utf-8?B?eG1aVlNYV2RVMVhHNGZtaSt1emp0ZEg3UkF5U1d3M0RzazdWZTlMSXd6SVcr?=
 =?utf-8?B?LzE2cnN5YXNwT1UyZHVmcnVuZ0tKakh0c2YwTUNKYXdQeVpiRy83NnhTMDc0?=
 =?utf-8?B?bnlyU0I1WVdGdEpwZ3ZORE5vQlVFT0VzMnpZU2pzb1N3YVNjSWQxVDEwQkhu?=
 =?utf-8?B?SEQ4aWFHMkFrR0pPSEkxRDZCSUpzajlydDdnQzdDLzRManNKemtML1hSUzlP?=
 =?utf-8?B?Q05CRlQyS0ZVS3hRUTVTdmdpRHZzSkVTUFhjbE9XVHFNcStHdjE0TTRrZ1E3?=
 =?utf-8?B?NGZZRWZJTi8vdFZlTmE3dUZmclhDUW1waUVpT2hPV2lPeGJ4amwwc29Na3U0?=
 =?utf-8?B?VDVzVXJpNmhXTjhMcUtDTnJvcHo1V0ZlcmJ3Vi9NWkcyalJHZFVmUUd6R0E3?=
 =?utf-8?B?Q0VGWHdObWpBWjNiQW1OcFJ0U0dhbWQzeE5YNlB3bmhjcW5iYW9XNmJud2JC?=
 =?utf-8?B?WERLMkpyZ2p3S0I3emZyS1lsdjhOWFRBNks0dzdrK3N0N1E5b2M0U3gwU2VC?=
 =?utf-8?B?N0ZlMzR0Q0JFYXl5dVprNXpkZWEyOU1OaG92MEUyamMyNHFMUTNBU0laUk00?=
 =?utf-8?B?dVdqZStQUlFpMjQvZFBqa2VSY3VEaVhKUjBBeldWS0FBOGxZOXdWQTZUZXFl?=
 =?utf-8?B?UDRXU084S1p2V2M5Ylc3MzRFcGxQUTVTQjB4emJxUU5sVFd3cVEvT25qS3Ba?=
 =?utf-8?B?eE1JekxMUUhwZUZrL3ZkL2RmM3ZVVEt1L1d3NHFMYTQzelNhWU1ySnBraFpx?=
 =?utf-8?B?TUVtV2oyNnlPckZjMDlqTWhpQnpoVXdzTE81d0pKbi95NmhqZVMyNHZtRmd2?=
 =?utf-8?B?aGp6MzZpRGUvUDlKWHZGM0lRZDl4Y2h6MG9Yb2pVRTJMbnI5WFdJYUhYNmdO?=
 =?utf-8?Q?96G17QcHIwMQUQ33bLWk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnZQMkFpN1ZuNDlIYVhvS3k2OWN4b2dEYjNwL3dSZWc4SCtSL2NjYTY5ZDkx?=
 =?utf-8?B?S3pnRE5ML1FPTzVTeFM1OVpGNUx4b0pycGJVTFg0c3BwUUl0aVJ0dkRJSzl5?=
 =?utf-8?B?cEsrQWtDYkJ6U2l3SzlPWVpsUnlyRE10NmlLMU42dmkyUldxMkNwTXNnL1Mr?=
 =?utf-8?B?RDN2dlBqOVpoN1J0TkcyKzcvdkdNZndTTU9FcG4rZ0NyRHBQUG9wdWx6V1JS?=
 =?utf-8?B?a0hlRG1YUXZ2RWZENHRGeWt2R2E0b0pGZU54Z1ZKWXgvclAvSTFWcW1lUkwr?=
 =?utf-8?B?M0J3TEZDUlloRmZoczVYb3NERklWVzBZbmkrQjJoRGZVTDFnREo3V2dGVEEw?=
 =?utf-8?B?Ym0vQk5iai9rWnRiMklRdklRc00yQ3RUZGw3TEJteks4b1BIMnB6SjVtZW1K?=
 =?utf-8?B?RGZleEo4WmhTM2ozQ0FKTEtmVHpRaGI1UEV5U1VBdG5nOFplTnArNklVdnNv?=
 =?utf-8?B?ckl6T1ZCTTNpd293T1YxUkhoZ2prY0J0SlNaMTMzR2FNUUpMTWZOY2Y4MVVU?=
 =?utf-8?B?ZDdaTXZsSkVrRlg4SGpBOTZDUWVwU2pFOWhZSWluZ1F3N1o4ckR2bmNzbC9G?=
 =?utf-8?B?d3F6TWJHQVpmNENyY0xGNTFPbi8xNTM2cW02MC96Q1lQam1VaHkrdFlQd2pp?=
 =?utf-8?B?MFJVM080NFk4cnEyR1E5Wng1UFBpYjMzenRFSy96SzJSQUZ0VlRhMTZjNXFm?=
 =?utf-8?B?ZlRNZEtJaTRTOW40dHJqMWhoMXdLUTZSOVA1WithdlJLTkp6K2hvMjRDVkEy?=
 =?utf-8?B?d3RRaFQ5aktQZEFDYzgySzI1eThKNjRYTGRlU3ZHT3RHVnhrRkMwVHMyZDQ2?=
 =?utf-8?B?RkEzTHhaVGlId3RlVUpXTnlKRTRMeG55dVdWZmJ3NWtCNUFQQ0JTUmt6SVZW?=
 =?utf-8?B?UERRbXZERHRqT0pITTg2eXNSYmFvWTA2eVZCM1F3MTZCRTIwZDJvWnR5eVFZ?=
 =?utf-8?B?VXVWSzN4SUtCVER0NllyQVN2eTFnRWVMWjJBYWhYanBIU3dPaDRSYS9BUDI3?=
 =?utf-8?B?Mm5mSkxGc2t0U3d1N1VKZ2NkbUw3RGtiVmViaTJZWlkrNUcreldSaVJrYnVB?=
 =?utf-8?B?WWRBUjgvQmF4azlWMldqcHVTWlBiTFNKWllBTzZlUXRsdW90dWhycGJIMm1a?=
 =?utf-8?B?TmRqVEtuazBiSkZLRU15RmRiKzRiVm1LcHkxOUlEV2xjM0x2Z0dDMFA3NGlw?=
 =?utf-8?B?MlZ1a2lPWFhKZkc2TjFnSGRoUUhzY1V6WHQzeER6WUphTm04NmJ6bVBoUCtx?=
 =?utf-8?B?NjA2ZGsrM0hGSjNscEJDY2F3UWVzMkdLZEVxdytQY09zeHovZEFxYTZaSVRG?=
 =?utf-8?B?SWNSallrMmNIL2ljR2lvMnYwOW9WcVgyOGtjdUR2V3c3VkkyTmhMTHhnbWNW?=
 =?utf-8?B?NUpXTzVvRUxvLy9SaUJjeDJ4QVo5czRTcUJXSms1Lys0V1NsUmFnempITmp2?=
 =?utf-8?B?ZDNkeWNIejNlaUE3UkgxQU9qNm1SWXZSSWlmR0Y0Tm5Sa096S3AyU2J5Y0VO?=
 =?utf-8?B?THVLNXdzR0lLbjNRYzFybFlrNkhxS2tqTWZHNUVJYllZUlFucmpJdWVqSGJi?=
 =?utf-8?B?ZGZtVXhYaHVXcHh1RnlTUmQyY296OXR2RXliMFQyTnI1M3gwVCtuZVptNktH?=
 =?utf-8?B?Z2JjM09JSVVBV1NBZkpLay92MnNmdXlnWThUN3owa0dtYjdiS25ZK3NPTHA2?=
 =?utf-8?B?MzZGejBneVpyb1VuTGpTcGdSR1RkRmtSbDZQWTBpZWF2R3U0am0zeTdwck5F?=
 =?utf-8?B?SWx0ZndsL1BWYWs4cHJJUTFSR3p5UW1wUmNkaUowVXNUbW9sQzVsQi9TdXNI?=
 =?utf-8?B?ME9DQmtZN0ZINUptTElkRTQvSWlnbmJJd0NMVHJ3ZmRiUnZOMG5sOHIyZXBo?=
 =?utf-8?B?YnVmQVBHcmowL05MdEp4V0FuaG9wQnUwSVh2QnVZV1pYK0prbmRMOXFNREph?=
 =?utf-8?B?dmM0U1NBNjlheTh6dlRyTVJLNmFiZnZVbW1rUWcxSDB0dGhRUHdVd2JsUWZz?=
 =?utf-8?B?aUpIdlMyNmQvbTZsYWdwOTlZNk9ub1JRZDMyOXJHaXdwMFUwaUx0SFRPb0NE?=
 =?utf-8?B?all1S29DdWpYWHg0S1VacW91LzZBaDViczVhVzE2SFQ4bnhHT01zWTNvajBG?=
 =?utf-8?Q?gC5NBWYqYrcuEvZS/9P/2wZHo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4aed50-597f-4896-ff3f-08dc8fcc5f3f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:25:11.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ri4GyThwPN+tSjE/SptM6/nTrrbYci574xBRzZEEI6PMvLwXtcK4wIfHQg/kPaLJ9UvJlT+FdpiSSzdMr06HXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

On 6/17/2024 01:59, Perry Yuan wrote:
> If CPPC feature is supported by the CPU however the CPUID flag bit is not
> set by SBIOS, the `amd_pstate` will be failed to load while system
> booting.
> So adding one more debug message to inform user to check the SBIOS setting,
> The change also can help maintainers to debug why amd_pstate driver failed
> to be loaded at system booting if the processor support CPPC.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 76419762c04f..9aa220a0e3fe 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1749,11 +1749,37 @@ static int __init amd_pstate_set_driver(int mode_idx)
>    */
>   static bool amd_cppc_supported(void)
>   {
> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +	bool warn = false;
> +
>   	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
>   		pr_debug_once("CPPC feature is not supported by the processor\n");
>   		return false;
>   	}
>   
> +	/*
> +	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
> +	 * the AMD Pstate driver may not function correctly.
> +	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
> +	 * Note: below checking code will not abort the driver registeration process because of
> +	 * the code is added for debugging purposes.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> +			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
> +				warn = true;
> +		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
> +					(c->x86_model > 0x40 && c->x86_model < 0xaf))
> +				warn = true;
> +		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
> +			warn = true;
> +		}
> +	}
> +
> +	if (warn)
> +		pr_warn_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
> +					"Please enable it if your BIOS has the CPPC option.\n");
>   	return true;
>   }
>   



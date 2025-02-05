Return-Path: <linux-pm+bounces-21423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0193A29822
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA82B3A838A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9C2066D8;
	Wed,  5 Feb 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mPfdB93/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16B202C47;
	Wed,  5 Feb 2025 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777888; cv=fail; b=lvvbNLcJPnJMxSeIfsNggjimFq1tKX9gGba6XIdYlLvI8NbLulKt9ZwFoF9B3lpR5fVL3IpT20eOsdOrYavIptuSF8rsyzM+IZc0p5ag/xsoa8M0rcS38DhyCs4HJZBkhtyh9hdrcwRDauZpmHSjnX5PUvdc0OEyQ+ANwct6Z3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777888; c=relaxed/simple;
	bh=/dM4xrBbL7+JTOyNrVN8e8E2hjEvBdHxANBIhM2acvw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kiEgwH6qRt33jmo7j4Q4Y5zpLDpRDUhwCo49DRrOgmAq7A0mmMRIDZ0KY3AaSDNpO9M/x5Sh6Z7S5y+xV81EUU6cnVbsim2r/QsLLWXcRbLtlkFlvQPIwZ7Y+GEJtxe4joeby+MY30XIB7+r7zvTiqgx0DyEDhVUXwA2LSzic/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mPfdB93/; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6KMkJm5xZsy66iU/+2/9o8ChJK34bjnBtH15Ae1H53aPkklby/78AyIdTDB/kufK3zlGCBnvnWlsu2RXoaB1fe0j2ZKw//zBbBX8wNe8kROxmUioy+qqZQYjPGSz/L6Rkbv9DjHnRttQ8W9NsGaTni3ip5PducSt1aqnT0fxxcvAExHbYtCn/L63ooD+R1T2LmhAgR21+PVi1QMR/6YqKcLxOl7kwdlRhJI3FyJfd4uXEiMKw7EN0TPS7Z2P2qgZDqAka9clXD+v7+NcjrCywHNm9aYE7uUkm7DCuH860kjNUBYBOe/H2v3yKwW7WPK/C/n1WVOtbvp00+e2553EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue87ocQG/fyMG5osIziGqD0uhcKJxohczJib11rxezA=;
 b=pvj9xfAyfYcGfENm07H0tPNt9XUu3/QJCPR4HoQVN8Sr5Or2FoeGhk2n3x0McMKx2e0sT2YfzA/TbJBLpCYQ6EJNJjNmR8VEQWKeJnYIwJgoWLVOqr7vo5P4ihqmb31DX+PRalC3Almm6bpica7P04abXzuyjUOF6lZkCZHXgj5W/7QhHDvaf85E6ef8iRkBVFlEv6gKfGJgUeB4uyQK8PaOJwRRTe9YqYyhEhEYyGr8eH4gGJUEPInxTs4tbUw4sNf5sWcn842Xv3XKgdiPr/KrUZ4E1Lsy+18RN3/RTQvCmwuJgFJohEzaN7SKE5YRV49nyt8fDcROpeUDfANSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue87ocQG/fyMG5osIziGqD0uhcKJxohczJib11rxezA=;
 b=mPfdB93/64TVBL9+sqC5POCpyc2l2SAg+O6T2q0+l+kcL8599JDjux5IbaYG+Od76ecgyUivFOU8ELxycIunWYjdkkbkBUJy6P8i4AYRQD1W8NkNgR+iF75UzigRw4Y326Msoe1a69ztf8Lniehmdli99wLeX9W1EPAFWOnMSJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:24 +0000
Message-ID: <b8b7ae5b-34fe-4379-8cfa-5a2c26976928@amd.com>
Date: Wed, 5 Feb 2025 11:50:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] cpufreq/amd-pstate: Remove the unncecessary
 driver_lock in amd_pstate_update_limits
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-13-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-13-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cbf77e-50dd-43ce-520c-08dd460db4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFh4c1NFTGJBMHdIRTRzTVFDb05ONjJMWEJWU2pKVHRKVXY4dXp0cWRvRzNF?=
 =?utf-8?B?TUVzOTUvTlN1WGR0dHg0Y096czlWVnpiRytOckllZUtNU09waFVDd3NlOVl4?=
 =?utf-8?B?ZDRxRmlDdFJGQ2o4VzJhQmJVUitXeWhlNGRDV3VReTZpdXFlZ0tNSXFPaFpj?=
 =?utf-8?B?aUpHU0IwODZxa2FiTmIvYmh1MlpuNTVuUnM5c3hsakI5bTk4WVAxekdhYzRC?=
 =?utf-8?B?YmJuSjU2WjBpYmxIYUtNZGY1VmhOdENtaFhZOWM3OUtwRittWWRXNENzVmxp?=
 =?utf-8?B?dE9udTZSVmw1d2hmUmo4V0pvNnJySUdSbXBhZzN4ZkxZRURNUjl6K29OelZW?=
 =?utf-8?B?Yng3WjQ1TDlpRnVrNXFUbGVoZGxLYjZSa3o0U2tSa1lqWk9BNEdDUzJmQTdD?=
 =?utf-8?B?RVFqUzlJZnlyZzZSSDYvdTJ3WmxzWWZCNk1UWHZjbk8wV0U3SmlsZlN6eStK?=
 =?utf-8?B?bU4wM250elJtQWhxbE1scmdIUU0zSXNFaGRobkhkT2VMWTgrOXI2ZUdPaXlh?=
 =?utf-8?B?b2N2T1B6d1pTSDQzZVpUazJyMUtibGtxODdKUVhrZGFSbHJqeVAzcVAyZlg3?=
 =?utf-8?B?WDZBcjhHT0FiSkV1dU9KSC8yaWdNbnNiclVTbzBMK0lxSVNqbk1UWGtMUWNj?=
 =?utf-8?B?Zjlnb2lZQTRtdENpOEVYSEZmRU1Va09QWDJaTEJGNWR2bHU0ZDBNUXk4QTRw?=
 =?utf-8?B?ZUNmUnpGMy93cTJUZFZtWGhRS2h3dVVCM2ZTakZHMm5PZnhINUtjOWFIZGpJ?=
 =?utf-8?B?cmlJUVZwbmpLemo3VEV1UGhVZzdkVWFHcFlVQVV6MjJySVc0Sk5SMlozUWdP?=
 =?utf-8?B?NHdadkNQYXBoWll6ZmtPVjdodmh5d2xqZmo0OCtQV3lzQlNhQ0VUWlgrbmNG?=
 =?utf-8?B?bkswaStYb3ExT0o0WGlqTXpMc3laSHpTc2VwbUg2ajNhNkxKaTZmVm9LS29K?=
 =?utf-8?B?U0xZOG05eFpueDVseDhWeGtmWnBLaVp0ektoMk5vV2ovMGwyNFJSNnZTS2F0?=
 =?utf-8?B?aFowa1RFVlBXM2FyV3JUVGF5T1JUYTk4QU96K01xaHFLQ3VGRjFqUjZScmxu?=
 =?utf-8?B?THZXbXdBNGlIWWQ4a3F6c0kwdmZmWXFpVm9vWk42aWJRNGk1YklnY3lMSzFD?=
 =?utf-8?B?ZDR6U3YvWmFDWUFSem1HTmJKZkhuSUx3SnpUSnMwUk9KMjhVeWdZVU5HemZu?=
 =?utf-8?B?TSt0MnoyWjFPWXg3YUlHUThNYzlBekdMb1pyd0o4QzVKY0RndEthb0xweUJF?=
 =?utf-8?B?Y2pQV0l6SWd3akNNcy92N0x2RjVXd3ZER2xxMUl6UWtJTHFadFovZkJlaWhH?=
 =?utf-8?B?S2NONzRjQ3hlTDRONDVFVjVnNzB4c2FkZkNvNTVEMDZYVWt0MytNTGhxQ2Rs?=
 =?utf-8?B?bGtYbFRSVTBUbkROMkI1Rmd5N0llRDc0eVJBS1dmMmF2aGQ5TmRXemlXN2hv?=
 =?utf-8?B?S1BqTG5QM2tVWks2NlF6cTBMVkQ5RTI4TzFOYWhEWUNhUFlsUC9jN0ppTDdi?=
 =?utf-8?B?VldrMHJhbHdseGpDUktCVjdUR056NVBCUGd2bEhzajlpZ25TZWl5dG5seWgr?=
 =?utf-8?B?Y3pyYWlFT0FiQmhRczBZOTErWDdWZllHMHlDdk91b00zRUJuNDJnZkI2U0M2?=
 =?utf-8?B?T2EvdStyRVJFN1F4cGViZ1ZYUG1yQUxlVE54SFdSazEyc09lTEp2dzVMa3Z6?=
 =?utf-8?B?RW91Mnl0dXprRGJCcFhYcmUyMTdBYzNEOVR4a1djUFI1THAwVkp4VXpUbkJ6?=
 =?utf-8?B?dk9HUGpOWEtzV0F1VC9GTFNKN1RYY3h4Z2ZHUm9mSzdBY3d1QmZ5cWtVRUtl?=
 =?utf-8?B?QkFrbWxHZ2NsWm1zcENNbnhINEVPSFdrUXkxQ3V5M0RlblRDVWR1aWZNOEVq?=
 =?utf-8?Q?yIIHGcWULi5nj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJUSHZSaVBRcFpwYkpCem1ER0QxLzRVczYxRDlqY1ZKQnBhRWYzcDA0dndj?=
 =?utf-8?B?WkRYZ2piQkI1M3NFeHB1UExLczl2UEFoYXhJQ3dubUovcnF5NkVXTlFkRUsy?=
 =?utf-8?B?ejFGN1FZOG02dHVTUEhDVGpZc3dlMTBuUXRzN1RyczI3ZFFQMWNQdjVjbEMr?=
 =?utf-8?B?NlhDVG0rVm5YMWFxWWVJOTV0SXVCVzBhS2dKOWtpZEh5WHRLRzdsOHdmbThG?=
 =?utf-8?B?OGpkUUVuc3YzQXlVRU94M1BYRFovY3grT0owcDZiQVJKTWtOTXVTdmlaeS9a?=
 =?utf-8?B?QzREWkFiNm9NamVMcWtFQytLc3BHREU2cGh3Um54ZVhNQlFPcG92YWx4eVBw?=
 =?utf-8?B?elpLVWhjbXZsMG9EMXo3ZDg4YmZ2TWYwN25UdjVuNkJrK2tBYnhVS0FWRjlp?=
 =?utf-8?B?NkFNbDBSdGlkSVYrZ1VpODlCWUs1azFYWm9oYXhVWTN6eE5jVncyVm9DblVa?=
 =?utf-8?B?VXhObmszNWp0SEdMT1RtS2dDMEdpNm0zdGg0RUlvamhaYkNzT1pOQ3JGcTc3?=
 =?utf-8?B?djBJZlJpcFRyck9qWVFVYVhZWStGd05POHJ2NlNudXFqQUxzWHZ5dDNLQjdl?=
 =?utf-8?B?bGJUVkQyQ0praTN1Szg4MTJYeW1FRVMzNkdYRENYNkFhWm5nTkc1TXFQd21t?=
 =?utf-8?B?cGJJU0d5eWMycTJCbWNTSDlKRkFzWURuKzlZLzNRNmVWaFhWaVk3K0YzUXFT?=
 =?utf-8?B?ZzltRm91MnNMakJib0g3WWhaeE5wSU55TEl3dlpOeXBSUmZvcTcwa0lMYWlm?=
 =?utf-8?B?b0ZKc1V5T2tZckhIUWlEbmkrYzNNaXZhSi9DbU5XNXZ0THZkRWU5NkJjd0pw?=
 =?utf-8?B?dmFpWUVHMytsWEZsMFhsUW5pMU9rdkl3RTRCc0xldDB3UXlJdjZ0L2pNakk3?=
 =?utf-8?B?VGp2UEhYaWZzUW9Cd08zdFpGdUdsY0pmTGxCWXUwZ04wc2FIWG9QTFQxZks3?=
 =?utf-8?B?cGVmOU9xam1XaG9ER2tVNTlsdTdlMzNSaTl3dnFTMmVsT1BUYWs2NGQ4VmI3?=
 =?utf-8?B?elVFdGhUay8yTDVxRi96SFVMRDNiYTl4UXFGbGN3NWRVU2RCMG1xcTQ3NW1F?=
 =?utf-8?B?SUxRY1IxS05aQklITUtpemxJcU5aZmVweDlySE5kN2lnN2Z6RzdsRWxRQUJv?=
 =?utf-8?B?UkU4a0FvVXk3SnN3TTVOZCtHUzhIL2ZVakY4WHR1VU9OeUJ2SFV1QUhjRUs4?=
 =?utf-8?B?ZC9oUnVXS0M4ZmFHYzhzZlJMMmF1K3Bhcm91SzVGSkFicXk0U3NTclB6Z1J4?=
 =?utf-8?B?MnVmcEt5RlpRTndGazBPVTgzT09sejd2aTc4c3grOHhFUDNlcHBkVVFNZ0l4?=
 =?utf-8?B?bW1OcXMvZStvQmlSTzdPTXh5cEIyN3p6cFRjV09iSm9vSllkL2NzaS9hVEVj?=
 =?utf-8?B?SFpkem9sSkVkK2RPYXppbGlUWmp0SWdYZU1uRnd4L292QVFhc3RpaThCdGxG?=
 =?utf-8?B?blNrYUhWYVZxYnlNaHNncFRGSHBISkpGdnNjTUd0cGNwcDVXRmQwNHJFYkJG?=
 =?utf-8?B?S2RwaUFnTzdSMEdibUFlaTBYYjc5bkQ4bUFoRDBGZ29wQjBIYlBhR2c1bTN6?=
 =?utf-8?B?elRJY0Npd05QbFRrdnM5RUtOemJSMEtGaFdNYWM1ZDJlQmNrUkFkVEg1ZzNZ?=
 =?utf-8?B?ZTMwMis1MFlwaXFXQ0NTM2NUVXErMUl3Y1JhMGRFTjhlRThRRnR5M093YXU4?=
 =?utf-8?B?Y21neVJDVGdKQzliZVZVN2tONUNPaGNZUGw3WjZiY0xVbGJuWVRiMWdQZWNO?=
 =?utf-8?B?aEhyeWFES3c1QnE1TGtZYk1lMitSSjJSb1RhQ3JPMTdBWUlDSWZFUVdjNWY3?=
 =?utf-8?B?eDUwcExocExpNFd6NEQ1WnVoRG9FbzdFSFJOYk9qVW9YZURxMytkSmlRUjhl?=
 =?utf-8?B?b1ZZNjlVVlRINnk0VW5EZnJpbFNxa1piYmdScG8vNk9mRGNLblJxK2Y0L1FM?=
 =?utf-8?B?eXlSTEtNaTYwRFA4QVk3aTdncVM5TUorU0dGalpqWE9aMmVuRDBkSE9CY3A2?=
 =?utf-8?B?TFJtOU53cUkyRzMvc1g3Z1FQWXh0QVMyRjVPc2VQR1F1aDhDTXpkY0QvT3RQ?=
 =?utf-8?B?RUd3Vmx1NG5CeFZIQ3cycEllVjB1Rm1wMmV2L1BnVldaVFdTaG5kUlNOc0JN?=
 =?utf-8?Q?vJnz74eIEr42X08Pspf7xrb+R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cbf77e-50dd-43ce-520c-08dd460db4f2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:24.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7vj6/ovDxKqZyIEYL+7Tb96mVhX2wyQg06a/DB4nTnimAXnd0Fg1j03NSF8ySr+fKdXr3lbwxy001wGpNk2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> There is no need to take a driver wide lock while updating the
> highest_perf value in the percpu cpudata struct. Hence remove it.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ee7e3f0a4c0a..08ae48076812 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -832,8 +832,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   	if (!policy)
>   		return;
>   
> -	guard(mutex)(&amd_pstate_driver_lock);
> -
>   	if (amd_get_highest_perf(cpu, &cur_high))
>   		return;
>   



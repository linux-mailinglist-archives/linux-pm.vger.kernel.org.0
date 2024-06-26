Return-Path: <linux-pm+bounces-10080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC591997B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 22:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6818B2325A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550E190664;
	Wed, 26 Jun 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mc7hgPSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324088F47
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435233; cv=fail; b=btslVg0S+1kxuo+pKhT7n2NYZ/Q99IoIeJrGwegagSkWqg4XiIE5FF7unOX9MQQcVoaaC6ZmaNuq4N4UftFdxr3H+b6C90/Fx6GmfCmCekL3lmTOup0B0+kSEpfgmCSVKCi/yWLQ1LyErTxjmMvNbOoyNIHh7NDSNm1Mmjn/VI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435233; c=relaxed/simple;
	bh=tsVlIu2X67uKjoCWx2Z/p2Y3qLyEYDG1wpo6YDPZdAY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=NCRyhrgxT7EkwIXeWy15NTDUzCMvqa+yuiT4ndGqzdb92J3RpPeYVDMYD5lgr5vm4Pab4lGeXUwhZQnaLW+4EJAe0WAw8esJUBAc6LdWMxyCtrtG5iiQeP7HpFL1cl1AHQOsTY2n1M+bmtN4GDBxDYefU7C3UgM0RIrqU0JYIQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mc7hgPSf; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUStNEhWeR5oMXnEeR+0For8c2domTXJuJU433tw7+/NjJ9bK2OrEH2jElovmAjxYet/2YfX3xAikmiZV26C7bR3H8f6izUfcuaHW3yt0KfT6t7yt4kROKj9o2+ruPwGrF5Ljc5GS8N/BfSyZyLqrrf7+aVu80HXWFjH4cuWjGbrDxWkH1cqeGeWEtP6wnFSYKRzIHXdyMIp3kISvGbZXHX9uIloFSATx9adoKdnwmi+dMft9FhIP+4o7a21b5pfEvbOtoB+OwibfdBTtTA1P4SsQ4jwxBmYiwn7X6RdBQdzbANBiZvcyA8/W6dRtqE1QmYHfd/JzTY2uW3SqTFNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1JJsGT22Y9hSGMxjQZHV6kpTMuOzkGP8eKSDkvdWhk=;
 b=FkaQcARkvDIViT1cPvR1UvGPdLJZeN0lTnK5NYvldwGea8mvzstPSu+TQERvV9Wr0U6JfvXmxZEnvOfwEWeCNbc64ks32SDJOn5LJaXNL/juWMAKJSyUUWrfCKxhGT1rxEVkQyQCoYiCXjLFoKKdWDBXTcSiCW/Hjpn9QkAcOtcJBWi605oOMUFg/K1bZByW8/dy6hAsdNhoT/W2rxHwj2FEypywN2m97yT5rxebbDWoe+tZ94pizjqZTiM4hlcwj2yQhbQuFlFXb2PwiPvWOixgKB5io780P03QGHkeXesW3tLTdhCw8JEeBQ21euxUrQwOzFyqgPOG2o36SjCdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1JJsGT22Y9hSGMxjQZHV6kpTMuOzkGP8eKSDkvdWhk=;
 b=mc7hgPSfjSEaiQ8MDJ/IvmNGjzt5daeMBcRLf5fTLgY/9X2GbsS0G29qUIHklFiL24qFCK//z/EIzSoMd9gJFCuAXTyvSvOojcFOrLajXnw3uxoYpnvtJt3iLARMx+BN/G8vXjumbhhSqyZ5jvZgINqCWis7e7UV0KtEhpubjjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:53:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:53:41 +0000
Message-ID: <56258f5f-c529-4f91-b0a6-09f233174e1f@amd.com>
Date: Wed, 26 Jun 2024 15:53:39 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: 3rd amd-pstate pull request for 6.11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0179.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a494f9-86d6-47e0-f319-08dc96220fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmRoMVhlTnBPZ2Y0T25RTUhHcGZvYVNXM2w5ZlZ6dkZaMWFKazVpbFpMaWM2?=
 =?utf-8?B?VklMY1BjV0dlQ1k1NWlPd0ZmREVYajBmY1BDS1l0a1FWYmwrQkpDdHd6YUN5?=
 =?utf-8?B?VjdmMkhaVU1WSGJHL2x5akF6ckNQdEhMZWp2S3pKTW93emFmM3ZIYzdxaFhW?=
 =?utf-8?B?QklqNmtnUTFYSmh3V0pyYjlSU3ZOckIwcFo1Y0o2T0FycC84OC9xbVVyVm96?=
 =?utf-8?B?d2h4TGxRSTNBOUN3eVBRQ0hhbVpSdmRORzF6WFJnWG9EYjh6dlFycnV5MzVn?=
 =?utf-8?B?TDdRUE5rRlhqeEJqSEsvdHoycWI0Ykk5QTl5WXpFUHk0YWpMbmQ2R0hneFdl?=
 =?utf-8?B?QlQ5MFoxMjJhTkM0MHNUL0xVazc2UUJ4Uk9yUDVUVUpsZU5RZlIybDJIMTFm?=
 =?utf-8?B?cVEyRUNiVlpHTmt5N29QWlpTYUlpdHdySkJNL3RnUk4yc1U5Rk9HdlJGTlgy?=
 =?utf-8?B?OTAvaWtKUUpIMHhUK3l1cjRDYnMxK25oVThXcGgxV2I3d0VLV2ttUjBzb2Ju?=
 =?utf-8?B?T1RUNlhUcHVPZFlwSkoxZ01BS2ptOXQ0QytsNnNwSGtUajNxMlN2QS85Mmtj?=
 =?utf-8?B?bTA1b1hZcmN5QXdJczZXOFRjd043a0lWb1E0bDlKU1F4aDRueGdTcFdaOHpz?=
 =?utf-8?B?VGluOVVoMTh0Z2F4bDgwSVNESWFsSUJMclRmT3ptcjdwenozMDFYUUZEOGFF?=
 =?utf-8?B?a00vL0luZEVzSGJ3VFlPbGlJd3pweFcrTC9Hc1NUNWZBc3QxcSs1cHhxcTBW?=
 =?utf-8?B?V1NsY0hYYys0QVJiQkl6Y1FnRGN1b0JYYmlob1FUOWdTWmcvaDZDV2gvclJ5?=
 =?utf-8?B?SUlXUlRpa3dtRFBodEliZi94Rm5VUUI2RXl4SDBpYVc2cXdzK1BQejlPZmY3?=
 =?utf-8?B?RkxEZzZzcWhlUUR2VFhoL0ZIT0dSV1d0TEo5Wit5c0VLcWNyUm4wdkFaTVBV?=
 =?utf-8?B?SkFOeHRET2JUbzJtcVhlMTlwbjY4RkQvMWV2bU1wRkIrWjVFRE94VkYxYUY5?=
 =?utf-8?B?bStEUVQwTkFJYTFqTWUzS3htQWNIYkZxc204TUkxa1pRVXFkQThwZVNmU0Va?=
 =?utf-8?B?ZVZSQWx0Vjl2REZ2TDUxc29YTVFXYUxnU3VMNlBHZFdVYVAyYWpZYUp3amFN?=
 =?utf-8?B?em1UZXJXd3VBZnJZS0t4RTJEV1hmTjJxVXVzK1ArWk9lcXdPY3c3L1d1a2JV?=
 =?utf-8?B?Rm9vOThjSU9pZ2dudzdTSnpWTFUrSFVjTmJvd1Foc1Z2cUsydVByanpkUEps?=
 =?utf-8?B?Z0RubCtVbktwZnl4SHl1QlpDZUVIeTFhcUwrWmZISUxkdkdnRWt6Vk1ML1pZ?=
 =?utf-8?B?cHEwakZtcXUvQXZBbFBPQndFV0pKWnRpSVlPVWx2RFhMaUR0YVdMdnVEQ0d6?=
 =?utf-8?B?eXNIeUdJdEZ2UXVRUDdIV3kvMlIrbVhkUzU5UWFQMHpRZjNrRjNVWTdRek52?=
 =?utf-8?B?ZERHbVBNWFFCQWRkNXlHZTl5NUFTSDVBd3IvdzVFeE13bG5Ta1dNWVZSaVlv?=
 =?utf-8?B?M0h1SGRWQmNlMVRzVG1PWmROU1FwZENjWStkM2dCTmFqeEdTckxIUzA4dktq?=
 =?utf-8?B?VWtlTzEwZmZRZmRXSjJ4R29PNlh0NFZ6UWhJamNhK2VPUzFXRzBKY09XeGF0?=
 =?utf-8?B?MXNBZlBNN1F4SXpaRmNUblJyRjVkOVgxeGYzMm5RYTR5eExvc0xPVFJiOUtP?=
 =?utf-8?B?RGxpYm1uNm9xaThlZ3RFcThXeFMyK2tBcE0xemUrdUlyeUcwcHJ0S0p4NnIw?=
 =?utf-8?Q?8wUAIhYfE37M//dLPbebdjbUbMvRWShG29O+Mke?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJ2S3QzTkV0U0U3WGF1Q2xxcDhoYUJnL2d4VUxLS01idDNGTFEvWGJKTjd4?=
 =?utf-8?B?QWJ5dWZPSmZhaitzZzdoMVdMb0hIbjZkK0liaFNJNG5IVXYwUFdtVDJRTHNS?=
 =?utf-8?B?TzNIWkY4ZVgzN3VNYkEvUG9RUDB1aFRXMVcrUEMzVXBzdldSQnhGUVFOcTNr?=
 =?utf-8?B?aGRQbTN0azJUU1lXL0FhU25tbjFNZW5XaG9BWjVnSzVpZE1SQ1lKYUxuVVQv?=
 =?utf-8?B?VENMYzdYcTRURU96Ym15b2g4WERwekJSZGxQSzI4K1R0VkJTYTd5UnRhcUph?=
 =?utf-8?B?VWpmbGltSVgwL1hqbkxQVWFrZFZqeVB2UU85ODdTaDNYSnc1RUFkdXFPYlY2?=
 =?utf-8?B?Mks5cE1ZM2xXZlByWHY5ajNmTEVqLzI5Tll4bDdjRXZSd1phcjF2RXo1Zzlt?=
 =?utf-8?B?aWFMUDA0Skorb0M3VmoyeVlxd2hmdEhvdmtlMzJzVmpYMFJnMzFHdEhpaU9Y?=
 =?utf-8?B?SG5pQjEvNTRJeDlCSjc1dEdhRm5YYWF6MUZhNzhYdkgxeFo3OTh3TkpBL3dB?=
 =?utf-8?B?RW1ubHp2TzQrSVZxbEt6SDRKQ3dvaXAzYUR3YTFVTG9RWEZZam91RjFEQk5Z?=
 =?utf-8?B?ZHhLa2c5eGsrbmpjZDJ2b0I2d1B5UHVDTm9wR3Zua0FWaGRRZEFSQldreWRT?=
 =?utf-8?B?UGhlb2NyUStuSlZSZXVEMHNCbnFxSmJhTDY5d0EzTzJHcmNla1F4QVpJbVJD?=
 =?utf-8?B?ZVJuOFIyb3FjMS9ob1NtMWR4cko2RUo0cFp6YUNSQXdoYmI2ckpzUnN4VU9q?=
 =?utf-8?B?WnFtV2ZHbEoySlM5TTFiaHA0WXlXUFZSajEySXJIa0svSWpSNDlzYmUzdHI5?=
 =?utf-8?B?VXVoak1mMTFMTGE0ZjVpK1dKS1hrZksrOHhRTjNFcVZlZlhzMm0xTFJ3OVNR?=
 =?utf-8?B?NDJYM3ZURWp5MUtDcjlka3p1L1JKR0UwQVNkOGRtMjdaaW12RmQwRDNUSXNU?=
 =?utf-8?B?ejJ4WFdoWksrTkd5Vzh4dzZjekYwaDhTOTVsclNXZk1QSGlsL2dOVWhTUGkr?=
 =?utf-8?B?L0dLdGh2eEtLVko2aXorQ1R6RTlhc2FtellZU3UxMWxHdndEVkxHVmFwN0hT?=
 =?utf-8?B?VldzcEhyMWloRFZUZUUxdU5IWjFnMnZGRGU2dUwrOVV1REJLc3hGaDl4MTBD?=
 =?utf-8?B?eStqTktSRktJTUJsdE9PZi9uQXBBQytFU0FQdllJZEFjR05yUXdRKzJra3dp?=
 =?utf-8?B?SUQ3cmlnNTk5MGlBNVgvOWkwV01nVG85NHM1VTV0US9MOFlNWHRzajN2WmIv?=
 =?utf-8?B?NGRKRktjMm92RGZPeVBnRmJyQmpIemIyZXRQeDFqUnh3NC9ueFBxdjhaam5G?=
 =?utf-8?B?RDN2dS91WmpFV2FhVENobFlUbmVWRGpuT2VnYTRwL1NLZHZxUVRsbkZ5QkVT?=
 =?utf-8?B?WjIyd2hWbDFWell2c1FXY0ZaclY1YUlEVnBsZjBaKy9HaTk1VDZPSXhvbmRu?=
 =?utf-8?B?YXV2RHNGcUkyZGdjUy9kK0RGTVZHVW01YkNaVEpLYmxjNmZWSzJKQlBMNTZi?=
 =?utf-8?B?dlU4TnRNSHN2Tmo5NVREWDM4eUlnNDQwYU1EU3FoRWk3cTZWcGpOZTdadGpI?=
 =?utf-8?B?ZW4vTVNRVzJkZDFRRk9iWWNNU2laa3VYYzhPMDBjdVF3bDkva1dFOXhvR0dI?=
 =?utf-8?B?RjJqajBMZEVJVk5yYVpXSjZMNkIvWlU3MXVZSk10aWtwc0VTTDZDb2Q5Rjky?=
 =?utf-8?B?K0xkOWEyYWtJaVowaVJ1eVFBYUJjQTFKU0k5TGJLb3hhb0x3cW8wLzVpR2li?=
 =?utf-8?B?L0xxV0JZZ1RYQ016SUYzZ0dZR3Z6aSszSnczRVRsR2IrbS9MYndHL1A5NW9m?=
 =?utf-8?B?Z2ovZFhhNzlQenh2eDI1V3ptR3ZYQVdQZlF6cUhESnZHdmc2cm5FdVMzV1pO?=
 =?utf-8?B?WWhFNDFIbURLWXl3MGhpcFBaL3lWZHBReVVCd2diTVRFRFFYNTM0dFVFcmVq?=
 =?utf-8?B?YXpzaHBLNHZ5RDNRNVNsazdNYmhQWlNNSldHYVNQWjUxMHlFSUU3N1BWWm80?=
 =?utf-8?B?cHZ4djBVbWJ5QXFYaGpLc2lTcFRFaG1sb3RZK0pIUk1VVEVGVC9uWFE2T21B?=
 =?utf-8?B?ZkpkYmxVOGx1REJFMU1BbzB1Z1NLVVBKY0RDb29JQ3JJRWxCb2ExSWN1NElF?=
 =?utf-8?Q?m+L2yjALSSBkdXOwviaFnG3Iz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a494f9-86d6-47e0-f319-08dc96220fa8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:53:41.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5jJOzypNMZixo+cLPivwZl+CdiNQ05kg5J/rGkD3H//nZHn11716JdgDQW+C/n28Y1IYlW2FPiKTGJ20uj3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418

The following changes since commit 2240d3e60bb3e7a00422596412d012aeb54c1573:

   cpufreq: simplify boolean parsing with kstrtobool in store function 
(2024-06-24 16:16:16 -0500)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.11-2024-06-26

for you to fetch changes up to 6d588891a90c5a946aaac11a93d06edd89ed9054:

   Documentation: cpufreq: amd-pstate: update doc for Per CPU boost 
control method (2024-06-26 15:48:21 -0500)

----------------------------------------------------------------
Add support for amd-pstate core performance boost support which
allows controlling which CPU cores can operate above nominal
frequencies for short periods of time.

----------------------------------------------------------------
Perry Yuan (4):
       cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
       cpufreq: amd-pstate: initialize core precision boost state
       cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB 
is off
       Documentation: cpufreq: amd-pstate: update doc for Per CPU boost 
control method

  Documentation/admin-guide/pm/amd-pstate.rst |  16 ++++++++++++
  arch/x86/include/asm/msr-index.h            |   2 ++
  drivers/cpufreq/acpi-cpufreq.c              |   2 --
  drivers/cpufreq/amd-pstate.c                | 122 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
  drivers/cpufreq/amd-pstate.h                |   1 +
  5 files changed, 119 insertions(+), 24 deletions(-)


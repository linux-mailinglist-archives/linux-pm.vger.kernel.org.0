Return-Path: <linux-pm+bounces-16579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025379B3248
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C21F21FE8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6481DB54B;
	Mon, 28 Oct 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZMvm7ISO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA71DB52A
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123797; cv=fail; b=SbRCJ6E/7cz+mZCXCngXjRNEOO8tofc4x9HMFxsgAg30JiS+j1a8fIzceTxWT4JXo4NQjuuSnTHrtPPFrIIYiMOPLlBV8BzAbdxIJErdMi1FfEkTCRR9SRMaFf6tfW/is/U5Z8A7kEZHnmhuQIFoZF17P3jiVLeF6Vmi1Qe6O+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123797; c=relaxed/simple;
	bh=7zQzwdCBgZ1z9FxfqIi159ODOVVSueeETA8xL/0ZT3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YlG3JCm405vc7+F0/CNiKXDniW0N7raHrutb6ZWMbkuCnAyLwUlICrN1NxH2mH9mmtmWCCWWtYi4iB9QcrrC+e98jYanbqiCEe/DI65gQOdudS6FUgGHjcV0FLzix6oLIXa659M0sSmxf0Kznq6v7N+JpKwAoJhsHen2EYNOfnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZMvm7ISO; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdSFfxFNd6t7t6SHCfXma9KSeqnn54azBbeOcGpThAQp1EXOolib2y4x0EhT0LXfChblXxzXSD2zQYlbt/TY0qo3zdBeP8jUFtGq4X2/IMhniCtwmK76uh0C4etj/L0OAV7sNWHsdccIdqvFAJCxiOWrpycn6VgEtG+/8yI5eJDrUNDvcstSV2tCXY46bSMeS8cUAwZ2mqrD9MfGyUKQIXK0PC54vOijcWEMV62hFV30PAkk4dGnu7P3qp4VHtog3cHyQZJQV9hpNILvDHxHEnCP6S51u0Zy4/0ihw7ceAv2wTY9ZUm81RMDl9ZmmtygCwZ6y4E7GIL1pq4O8rcSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1X5eqGShfPggsFZ8mJ3/3lpONqvZ+wqijqrdCTlBqU=;
 b=TK/4sHOtJkdi8HFM8h7yoiv+nVTcXqLEvYsz2PEotmtSK2XYPhGX6Ozs6e1F6lIOBNqs6Y3lBqkBN0ZqinPA0xEbPPsScxN8yySvxHQNuqriY56JPKDDkoQA/nM1cJ7X0rvQBn/6ltvNnznYMCpVPj0mS9NbpzNTtAiiRDEL3GO2EA5HnxoiwbZUsX8lN8DI79MjqHemcCGEoHJJi69US7/cwd8UjFoWw0Qt7tRQ0Mm9Qg2UeNOyBnP/NjUZ56wgXIzUntwGzAKM4WX3tvnIvGTaYVbFnO3wNnoIKeb6S0cwQJPavv2FmyBp1LV8PNPvuGx0N0OFx+XJxZbiEXQweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1X5eqGShfPggsFZ8mJ3/3lpONqvZ+wqijqrdCTlBqU=;
 b=ZMvm7ISOK1MJhnbBbRJxxyst2Pb88HVFjQqMIpiSchnaCYAW1kZ1isbqUUcEwpUP6bjfT4AYzvuyE6dlUUwtDhelhUrOX/6Vy/u8qt5Ugv/oOgLCxs1jZUuWtLuQ9xa6Trt1leKUa9WJUUHqY2dB33yYYMB25T/wdlB5UTvBfiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 13:56:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 13:56:32 +0000
Message-ID: <796cf4f2-6397-4012-8130-0c7c7f136486@amd.com>
Date: Mon, 28 Oct 2024 08:56:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amd-pstate 6.13 content (10/22/24)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
References: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com>
 <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
 <CAJZ5v0hjPVL=vJ=YGNoAKwEej=v27oPg_wvZUQ5KXU+=zD6Q9g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hjPVL=vJ=YGNoAKwEej=v27oPg_wvZUQ5KXU+=zD6Q9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: e4971fbf-2280-43ae-7e76-08dcf7585439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVdSQXNtTVVnSDk0UEN2cytmN0I5S01sWnBYVEt3RWF3RzBBVC9xT25CQzRk?=
 =?utf-8?B?ejhmKzNXVyswT2o5RlhpT2ZNektGYmJhZjFsM2NPaS9uTFpGbXVacjRNNmVn?=
 =?utf-8?B?U0JPSWNnUFNvb3Z4ZjhTb3IvTFJnUXR0UFFRNDFadXBzdHpCeGlPc2xVdURW?=
 =?utf-8?B?MnR4VDY4Qmsxb256QS9LbCttL29OakNJUG81eUtheUZQUVNsV2h2VCtNQzhj?=
 =?utf-8?B?aW1mRVE0SXF4L0VBWlZnb0RobDNjTGVNb0QvbUdIRi9QWnBGWWRsQTNLenFy?=
 =?utf-8?B?Rk44V2N4b3F5UVNCbGsxNVZQdmd0NVBXUTdYZE5NZHpKZkc1Rk9DWnJxMzc3?=
 =?utf-8?B?ek5HeFJYaG9DS2NBZGVaaHpUMkJNKzNpcDdmNDJycjhnYWpQTjBDT0g4L2xN?=
 =?utf-8?B?YWpwY2JWY0RmZi9nQm8wUjcwUmZZQXNHM2doRUpUdFFJQnhvWENkRVhYbWdW?=
 =?utf-8?B?WVZSWkFXOEJUdllFSXZrYVpKWjdYR2hlTW1uc09Fak41YzhGOTVvRXBHSGNN?=
 =?utf-8?B?d0F5RG1Zb2NVbVdDdXNCd2tmc1BjMDZGdDZKankrUHE5RmhidXZaOWlCZktn?=
 =?utf-8?B?NlE5R3lkN2ovb2creHRjc2xDZ3M4RTl0OC83MExIQmw0TVBsVldZU1NORUhZ?=
 =?utf-8?B?NXJjck1QbGozRVJqK2VTQi9Ga3lRVTZ5UURMZ3lUL0FmMDVCMVBWNWlhTVFC?=
 =?utf-8?B?R2oySU0xUG02K0Y1SGpjQkhseE15V1g5bHFXNW1VYWd2LzZzaGtvdFh5MjFt?=
 =?utf-8?B?WElvcXhUdmpYWkludTJyRXYwV2x4R3BRMlFubGNyRWlVZXNxSTVPcTJLM0RX?=
 =?utf-8?B?VWVQS0xpbTdXOWVEYWlXaEROWmVQM29KWm5aTGdCbHIvNHZDa1RkQmlaS3RP?=
 =?utf-8?B?YlkvR3BySm92WkRxbFRvN2JianYwQUM1QmUvYjJVZy9HaXBmbmE3TW5JNEI2?=
 =?utf-8?B?MGZWNi9PWGNhaWZ1c1pidTRZRzArZGQ2cUNkbzRrRk53TEN3cUZHVEptZlQ4?=
 =?utf-8?B?Ly9Uck45ZEhGbUdmWXpzamFITm90bkl0THFKelFyMmtybjFmN1ZQdC91eHdF?=
 =?utf-8?B?czVRK0FzSFdJcmo0cENMYkJSSEs1ZURmZ21kdnlUaFlmMEhFZmlIeTRRWkRX?=
 =?utf-8?B?TktPSW1ucXNFUjY5My9wKzIyeUxLeWNOMHhHeVFGUE5OTDRkcENzaVZYTjd5?=
 =?utf-8?B?eGcxTGoyYXkvUFk5cnRoc21aV29SeUFPdmIwRjV5bVIxaXQvTWljY1RsUFI2?=
 =?utf-8?B?OUFQY2QzM1JRT1NvOXFnTjlEK0dRRGNWZ1hzOTJheThMMGllN01VZVpMN21D?=
 =?utf-8?B?OTcyVWlQU3RDNEZNcXpwMksvbWNyZjFsLyt3a3NXTGNOWGxNSEJLNFVVSm42?=
 =?utf-8?B?d0NCdEkrTGRZUTRsUmo4ODJkQ00ydUpqR0hINlV0ZnNPaWtKQVcxQ3NDbWlE?=
 =?utf-8?B?WnpuZjJrMWZEMk9tSFg1b3FHeGFHOHZ5aTZwK1JLVjZnRmpCQkpCbk9ReXlN?=
 =?utf-8?B?WmtlWG1pRVkyQlRiK3FGbGhpb0FSUWw5NFZVaWpOQlgvUmlISTJyeTh2YmZF?=
 =?utf-8?B?djJYRDNuWlNYYW55KzhLNWpnZXQxZE5oaEI3SThnNHRVNmtpS3M2TlQvaC84?=
 =?utf-8?B?QUNmdjVzMDRCZVZ4blFBNUsrTTdTQ09Xa05mSncrT2VwcHZ2VjNNcUtqaWhl?=
 =?utf-8?Q?gZQJ25cMaJhBLmb9yDgO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajdRU1FiNlRqQ3RNR2s5eUhINkdrVmZBRm52ZWZlTjRsWHk0Z3N6SGhyWWJu?=
 =?utf-8?B?T0NTSGZuTytGYitnWWp5QmhOeTAwMVVtN3pycHBObW9Kd25IMEtESENiUlR6?=
 =?utf-8?B?bmNrK2MzRjhjL3FRMVdzR1o4S3lsdVRLTFJGVmM4VUg5VXl4NU5ObmtBeUox?=
 =?utf-8?B?blpVSEJlbDdGTDk1WVFUZkt0OU5NVm1oMlR4R05lRjJDZnowYWZXL09hdVg1?=
 =?utf-8?B?c0k3dkF5Y2c1Y092Ukc0OUpEeS9uSlVYVHd3YkFhcTltQ09OTDVzQzdzc3BN?=
 =?utf-8?B?UVo4cGkzb0JoN0hzVXExWlFuODBGYStPL09jbU5SM1gyMDBVaVhuOEtUU3RE?=
 =?utf-8?B?dGRNaXQ5YVcyeUdkQUhoMUJwVDA2ZXlncDRoa0s0TElpZW1EajA1QVNqOXA5?=
 =?utf-8?B?MmRQRkk0d1ZIdjl6UkQrMzRteVB3OUdZZUErbit4MDhmS1FCamZsbUdZdlJz?=
 =?utf-8?B?bllHQXk1VndCb3FVR25YaWlKVmU0cUpMUkZGSmtpa3hFVTdZTGo4L2tZUzJW?=
 =?utf-8?B?NjZWTG5wSjBhbFpKQ0ZOQVhXL0RpZ08xcC9wemxSQnZKQkdnOWdjTlRaQTBK?=
 =?utf-8?B?QkRQcVdDem1VM3JXQiszaXQ1bERQa0Fva3F6VUgzQ2tuWUtXaU1jWWdleUtX?=
 =?utf-8?B?ajY0WTdOMkpxWkRVdWNaU2dpODR1NkRNVHJjOXl2cC9VbzVPRGFCczNXQVpD?=
 =?utf-8?B?YWxHbk1aNUdHbUs4b2hZa21yMzRMeEt5RmhzUzlZazRIeCs2WWsxVi8rOWJD?=
 =?utf-8?B?Q25Zb1NSV3lrMmN1RW9VUVdKSmRWRm4rTGljUTFzbW5rT0FyTUZHMFRZYXJE?=
 =?utf-8?B?MENRaXB0M1h0T29zOUs5QTBNcFhFY2g5N1Y1T1dreUE4aFUrUGdpOTBLQkI1?=
 =?utf-8?B?RExMZ1VLOEg2T0E5OGpuRS9vRG9IcEFuSVlDNmxBYnBReTUrajB2cjZiSlA5?=
 =?utf-8?B?YTNMVzJGODZ1ZlJXd1hyaUxuTXpFZUZqV1IyOHpNL1N3RTlkOHZqNndwTC81?=
 =?utf-8?B?Y1J4bEhqZ2p2dzRZcjBJTCtyMWNQRytBZXNQVlUzMWZ1RUFGMWYyOUhhSUpj?=
 =?utf-8?B?YUp6bHdLb1RXREZ2MHBHTk1XV211dnJac04vOUxtWVpXU2pnWENVVXBTNzMv?=
 =?utf-8?B?ODU0SmJkVnZoMElOVGJFWVdmUk5XQjk0eWxWQ1JWeFBzNFBpTE1RV3RBaXdJ?=
 =?utf-8?B?VWUvc0V0UXh1bndYaXVEM0luTVV5bzRod1dMVk9YZkxNOWlXNzFyR3dlREJy?=
 =?utf-8?B?ZVFhczVvN0RmaDNFNHo2Nk5zWW5zTVEzU3JDUWJRd1g0WVhjc05nek5XSDl5?=
 =?utf-8?B?bzU5eGFpT0thYkF3Q1E3eUQxbmp2R1JZUDFHWlJXZFhaRDFtYWpWNER2enFW?=
 =?utf-8?B?ajk5Q2VGSFZ2OUpTTzVsSDRETEQ0WE8xV2dhSWhsM3VQbmFRUHcrcWpKVXM4?=
 =?utf-8?B?QlRPT1NJNllHVU5KRzNlems2VzdKWUVjaGQxamZPYWhTNk1BeXYxMER2Smpi?=
 =?utf-8?B?Yk1lUjJuOElVMTFLWnovbEpKUWZ5VzF5K0hkeXgwVEQvc3dwVVZ0b3hqeStj?=
 =?utf-8?B?NkY5UnBCbEdJcW9Cb3hXS29sQXFhWTMrMGJDWmpsa3ArcWY1dzg4V0IrYUl3?=
 =?utf-8?B?Q0UrcUFzREgzQ1lJME9YZjhSS0NIbGZNZW50aTcrcU9yejYrbHhJaXN2NGh2?=
 =?utf-8?B?RHJpVU5LalBJVnVpMzdEdlhSaVI3ejVCQzRMeEhCeDc1WnI3VFkyaG9FNnhz?=
 =?utf-8?B?TGJxcHhsUHhZbGE0OHYyU0NLWW9aK0RaV0JFTlR6ZzQ5MW93M0Q0M1BqK0ZK?=
 =?utf-8?B?U1VsTm9FeEUzVUVKOUZiSDVkOEE3THJYSlBwSGQwamRLUWtoMW5KTE5LUUVX?=
 =?utf-8?B?aEdzMjdqRFh0YUZVVlE3aUk3WnNwTXdaZUNMNE5udGZWV3JkQktreFBIb2tz?=
 =?utf-8?B?SWJyeTlDRmZldTlmc0dyVUhuUnRWaUZnUVdhVWZYbzcvKzRJR2U0MzZKOVRU?=
 =?utf-8?B?MmlnZDZRSy92TVVPQyttN0MrWVNyS0dVYm5Wd0NFT214RXpTVkxGS0lzb3p5?=
 =?utf-8?B?Y2JDbVFEbUF6OWVBbjM5cVY5RWJzdXFDT3BJRFdTWkRNODhHNWVMaWlYNUti?=
 =?utf-8?Q?KV9VHz5qXf2sr4/rCrMMpPUBs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4971fbf-2280-43ae-7e76-08dcf7585439
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:56:32.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0E21Ng9p4Cnw8siN+cmoZak8C0O6FhY8tEv/w0l34ywE6tpOkANvFhQIG6S4Cozxj3JYMwhhX5u9N+GkhYOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

On 10/28/2024 06:22, Rafael J. Wysocki wrote:
> On Wed, Oct 23, 2024 at 3:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi,
>>
>> On Tue, Oct 22, 2024 at 10:54 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> Hello,
>>>
>>> The following changes since commit 7f31183fa1d5c043864b4bd5632930f40d3c7002:
>>>
>>>     Merge branch 'acpi-battery' into linux-next (2024-10-22 22:00:30 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>
>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>>> tags/amd-pstate-v6.13-2024-10-22
>>>
>>> for you to fetch changes up to 7027b415ff1a4184b99055f11455d5c7041aa3ee:
>>>
>>>     cpufreq/amd-pstate-ut: Add fix for min freq unit test (2024-10-22
>>> 15:21:42 -0500)
>>>
>>> ----------------------------------------------------------------
>>> Update the amd-pstate driver to set the initial scaling frequency policy
>>> lower bound to be lowest non-linear frequency. This will have a slight
>>> power consumption impact but should lead to increased efficiency.
>>>
>>> Also amd-pstate is enabled by default on servers starting with newer
>>> AMD Epyc processors.
>>>
>>> Add various code cleanups to rename functions and remove redundant calls.
>>>
>>> ----------------------------------------------------------------
>>> Dhananjay Ugwekar (7):
>>>         cpufreq/amd-pstate: Rename MSR and shared memory specific functions
>>>         cpufreq/amd-pstate: Remove the redundant verify() function
>>>         cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
>>>         cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
>>>         cpufreq/amd-pstate: Call amd_pstate_set_driver() in
>>> amd_pstate_register_driver()
>>>         cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
>>>         cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call
>>>
>>> Gautham R. Shenoy (1):
>>>         amd-pstate: Set min_perf to nominal_perf for active mode
>>> performance gov
>>>
>>> Mario Limonciello (5):
>>>         cpufreq/amd-pstate: Fix non kerneldoc comment
>>>         cpufreq/amd-pstate: Don't update CPPC request in
>>> amd_pstate_cpu_boost_update()
>>>         cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP
>>> limits
>>>         cpufreq/amd-pstate: Drop needless EPP initialization
>>>         cpufreq/amd-pstate-ut: Add fix for min freq unit test
>>>
>>> Swapnil Sapkal (1):
>>>         amd-pstate: Switch to amd-pstate by default on some Server platforms
>>
>> Pulled, thanks!
> 
> And unpulled, because this branch contains my temporary linux-next merges.
> 
> Please.  If you want my branch to base your material on, let me know
> and I'll create one for you.  Otherwise, please base your material
> that you are going to push to me on an -rc from Linus.
> 
> Thanks!

I had asked if I could base on your linux-next before sending it.

Yes; in this case can you please make a base branch instead and I'll 
send out a new one then based on that.


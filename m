Return-Path: <linux-pm+bounces-27185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4AAB7E0D
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD94C14B0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AD27E7E1;
	Thu, 15 May 2025 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mBY+3Iet"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E531A08AB;
	Thu, 15 May 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290824; cv=fail; b=kdEH9OpXSEyakshamBtNhZFBFakNscm61Adp7CF1MhV8IMWdIE9+E5x06b2tvZQkA3KnuioWxICbb5GWTDnJz1r3Cmud+4b9CjkZO9T3i8+KfW2+JoaeSjbsEW0zKOxtbElHqgj8vFDZHuoUuCz0eGtD7zZ0e3DDTNJGWOiosCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290824; c=relaxed/simple;
	bh=NDSEgveadyBpxwAeZDbpoujAY+Uyrs72D3c6kn+GWrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evtgrUyNnFVgJ+GvO0WwAw8acbh8kHplRWk2Csts5SyPouYHLsbeaTtuIv1hhdSQyO9gq/E9UqlzNoJIJNQhr/eZR3S1ACFFWwOcgvVVGTNmx4fdFa8sgc3Y2KRAN023/BAuR9vqmLtqRLtJ3LBhhZLRMyVwlJxOoLMIb3AujeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mBY+3Iet; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTPMoLUMyEMyrGLs/ZsUjXzj/yLho2txvKFhyoFH0tS3y5mjj//Q4P+lFr2NarETJb84/FNnP4hTVIlWf0XqnSKWUNScgwZNkPS50v7w9BJQu7wt69mPFse1h4yR7ifJle4UuLvE+71xxgb0JrszwUizdOxNBqheaJvxI1Z3bkEBQmag42ByKXmc2GXsgMnP+Mz/wEufJ5DRQKplxcLu2pAXWC0OgQNcTLQZs5sRHhFgSAY9QNrraq5tAbRMeZUlAebg2oB7fPvJdAF8yNLxhOWtMYtRL+LytzhCX5gfl/+iRhc3FO9mEzVxPKtSOIHxl98h6SymB3mhPGA7GZmPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2o6Px9vA8dMFb0uQc89SbLm8i269oSXIwiQrNAwxtA=;
 b=TEmtY+zrYyzyQWoy7hMrI2QNuQaxOk6DUSiDWPXm0i+++Xy8Zw+vjycy4BkW4EpSSO6+Es8qdbqCJRaEZ6CP1PU2F+1MRK/DSTthwYELclfct5yurFIQ46IDbE8By++sHr7wI19MUm+ktmKfrUGhkRrWQ/MdUcwOjgtc3u8v4vULzf54cwpzjpUyxzEKK3ztC7UFn34BlIh5nzqvvXRfG34HztQBibwT7MwOeC6fmyq9KehqUMBOcFQjwPUVYGteL0YJqaHO12wEMutvJKSgjAQC5DgZ/0huUGIQtIK4KyT2oQESf4EA2cZeC5mJJl/hI2xIeY2/C7Yf9iCK5iGOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2o6Px9vA8dMFb0uQc89SbLm8i269oSXIwiQrNAwxtA=;
 b=mBY+3Iet/l2oCtFeLD02f3er95tDDSf/BNXjwFLPefGHmzan9LjZvAzxafxmaY5M/AjnkLGpem9zxFSjzsJk3gGXjZfGTlWFRzk5nXWgff8tAl9N0sxSaI3mcnmBc7MjOBN+7OwipMMFzg0vS+vIKJOAWTPIpaWedPJSWeVR6DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 06:33:38 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:33:38 +0000
Message-ID: <51fbdbcd-a895-43b0-bb59-aa3361d77cad@amd.com>
Date: Thu, 15 May 2025 12:03:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 4/4] x86/apic: Fix W=1 build kernel-doc warning
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 yuntao.wang@linux.dev, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterx@redhat.com, sandipan.das@amd.com, ak@linux.intel.com,
 rostedt@goodmis.org
References: <20250514062637.3287779-1-shivankg@amd.com>
 <20250514062637.3287779-4-shivankg@amd.com> <aCRMpba5mp5YvmY3@gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aCRMpba5mp5YvmY3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4c) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c45450-60d5-408b-8919-08dd937a6cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxsQjBCOWNDbG04OHZ5VUZ3MFczSWxpb2Q1YnFXc0ZuWk16TFlWODk0aWJR?=
 =?utf-8?B?NnNPRnRQeGphZE1zbHFUdGtSN1g0eTJRdUpoaml5M0plSTZTKzd5RUtXSmtP?=
 =?utf-8?B?d3VXdFhMdEczK3FKQ2kyUDM3c2xURW1wWmxhRXcxei9ucms1bi8yd0dvYi9I?=
 =?utf-8?B?ZllTZFprV2sydUtHVnk3N0Z5NjNna2I0TGFDaEZVK0pSVzZHOVAvdTZoVWtq?=
 =?utf-8?B?Y2xVa25HTlBSWktvNGhEZzNLb0VIRHZzTmpGaVpaVjhSRElvTEQ4cFA4ZHFQ?=
 =?utf-8?B?VmV2YzhIU1dKRGljWFcxblozSGxFZFgyVjFaQk8yQ05ualNkTnJmcjNwNnZE?=
 =?utf-8?B?RlhmTkd4NFdFdWpab1pYQ0lmcUFSMlltOGU0TWNjMmxCdEhhdEdUeEdVSW5h?=
 =?utf-8?B?VmRaNjkxNGhLbEx6clBHY3pSVllzSGVMalNpYWdDT0tpOEN6dndwQU5GVWZz?=
 =?utf-8?B?Mk1wTHNHbjFrNFZ0YkFoMWVibkpabmFUbVdMT2ZuVENuMkxkMVFRWXVYRVMy?=
 =?utf-8?B?L2tmcXZuR0lHdkwzVXJQUGFIMlNqcDdaSXArbE9yOG1uY0RLYXhrQ2hIWjNv?=
 =?utf-8?B?ZndRbzZkdnJYakkwYTZkNFFtcEdubVZGSG1keUpFOEVkWkJrQjJwc29yNWZO?=
 =?utf-8?B?NWtMalNhRk5yeitXcXgrNzV1Y1JJRk82Y3RCOFJLUURmYVFvZzRneUNJUzBo?=
 =?utf-8?B?NDY3R0hKblpRYzVBcDVJc05FWnNTemkzT0hUMjJBVmJFbkpNSytEdjJTeFVl?=
 =?utf-8?B?YlhkemRQcStmcDJ3UTE3Q3RWYnNQRmlsTitCclZFcUgrbG5mS0NrcDZrMWJi?=
 =?utf-8?B?ckRWeWdGTGRxOU9LeEljd1F6QVBLbUdudlVwRFdNZVZEL0pUaHhmR2RYc3VG?=
 =?utf-8?B?ZmdzdVZwemFwRUoxa0tRYVJDUVJ6MnpEcHJsVlp3VjBqMForbFJ0YkIvWkxQ?=
 =?utf-8?B?Z2dGKytpc0lvOC84N3Q1OGpqK3NZMHBrNFZDWGxublUzRHpUTWlmajE0THZj?=
 =?utf-8?B?UWZlY2xGVlpHelRiZUJNY0VQYWJCV01KTlZGYng5SFE1VmI0eURrUGUxcU1V?=
 =?utf-8?B?OTQrL1NRaDBlSkE2emswU0FrMU5RQWZLdkkveVp0c29hZ1JWc0E4ZFliamtL?=
 =?utf-8?B?WkgwY0s4Ukhjb1A1WEtuRTV1ZUJTN0EwMXYyOXZBR3BIUk1IQ1BJYkZIc0dT?=
 =?utf-8?B?SVhVbFJxWXREcElieGNkdHA5V01xZ0dFVlcxNVFVVi9ZNWNCbE1KZ1lJMDEx?=
 =?utf-8?B?OXZyczI5S3U3R3lucFpQd2hCeTI2dXpOQ3BsQjhocXRKZW9BVGhzNXhwZGwv?=
 =?utf-8?B?NnVjSEYxMHNqQzlENStKMUxFSWQzMWpvMmV0VThmbmNZNnRuU0NjVTB3UDdl?=
 =?utf-8?B?Rm9qTENoaEowOWNlQ0FqTndzVExXdEEvWFNrN3hnV0dMc1lKb25lSmVQVHQ0?=
 =?utf-8?B?VEtuVkRDYW5OMGtxVFI3Y01FZVlmc1ZxSXFhekc1d0JVM1VMcEMwdVRkai9n?=
 =?utf-8?B?UVFLS3JHcTJGVW52Y3paTDQ2Y0Z6K0pEbit6OG5zL0dPY1M0YXFESzNrR05l?=
 =?utf-8?B?UFYxZTdkS3gzTUl5YWNxdW1LdHRWUEVMWWhNbVJXS2UxRHBxbXA2VmZac3p4?=
 =?utf-8?B?Qm80WGVYNGtEYUJQd2VwMG95WVBJOEVBamZUK0FLbS9lbGFUTGVWQitxUEg2?=
 =?utf-8?B?OWZFVXVZUWp3ZzZvY0QzYmdyMmI0OHByQUZIWkRCS0RDeklEbTVLRjhKYU9C?=
 =?utf-8?B?S2tXUWZibjluUVhWSTZ3SnlacFBESnpTSkF3ODhEc2R1dnc5bXRldktuZ0Zy?=
 =?utf-8?B?WDRBY3NvUjVuUGRlZGFiSXZMbTVRT0NkcmtGM3hhVFJLRHdFRHVTZXRJK3o0?=
 =?utf-8?B?L3J3aHBucHcwcTdyTFp3REk0cWdpZmg1cFloaVkzWDlITGN1Z0VkZ2poRS9D?=
 =?utf-8?Q?TY5MIMOHt20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDdaRWJtZXRSR1FqMllSaXNORnRSMU5aSlhqYU9ENkVqZHFiejhHL1djZnU4?=
 =?utf-8?B?TlY1eFFlTjdOTzN0Ylp1WWhvbllKZVZhMzFuZjZNc2xVUUFuM0lydDFCWUph?=
 =?utf-8?B?Z05wM2gxRjJRanhkN2xrdzdJbWxSWitpOEVSdGdtTG91TFNkTU5uSnJmV0dr?=
 =?utf-8?B?RnpxbExaaWJaUmV3am01b2Y0L256R0c4K0VRQWJzY2Q2SGhiUDQ4WlFlQ3l2?=
 =?utf-8?B?OExFeDRTZG54dU5lM2tVM3p3OWJvWElJUzhndjJ2QkdIU1FnakZYMDJ6NXlN?=
 =?utf-8?B?OHI3dE1GM2NTRDVzV0hsdjdmN0dFSFRrdXA2d0JwOERDblNkbTdpYjJRZWEv?=
 =?utf-8?B?NHFJQldTVnVvaVVkWmRHL1pkTjNuaGRua2VRUEE3YWRaWVZWRzZsa3lJRHhn?=
 =?utf-8?B?Vm9Ta2dFQjh1NC9qdTBXdUs0SWdvUlk3RDZEVWpqQWFGelBHSDJKa2Vlc2tt?=
 =?utf-8?B?Qngrdk1IM01oVUhrMnpTYnU2MGJJSndOWDNncXBkRmdDbHdRbUdXREgxL0RS?=
 =?utf-8?B?Ty9VSmNEN1Y3blRHUEo3bjJQQnBjQlVDN3dGZjZEclBwbWFTRlBZRDVLT1dK?=
 =?utf-8?B?cXJYVkVzSE1WRmxPVEpHcVZBeWZpOWNHWHYrc3JPWjRkYVRRcW5ONW1mQnpZ?=
 =?utf-8?B?QlpxNkdQMElqSlkzN2NsV2prWFVGdys2Z2czUmxISmhlVkVVdnRweVlycHR4?=
 =?utf-8?B?VTVBNk1KdnZYMUx3WDJ6V2hOM1R2MEliSklacW5iUzNsOGVEd29ZcmxwUnNQ?=
 =?utf-8?B?YVMrYTNrV2pmZnVvRWlCaVFyQWNZS3AxZzUyRVdnaExTR0N4RkpXaGNOMGhO?=
 =?utf-8?B?TERhOHZPeUN1L1JVNFlyclo5dHNobGpydS9nTEpORVpoWmgrRitobStkNEpp?=
 =?utf-8?B?dHNpd2ZjOWN3Q1dvQUV0L3VRRG4vZWZteE9rK2NFS2dKbVpVcWhUYWtEYnN2?=
 =?utf-8?B?c3VpaVRHN0tydjJ5aUNteHlnekVyZDUya2NOL3FrV1NLMHJCWnZkSjJaTUdG?=
 =?utf-8?B?alNLVnl5aDd5MFJoYVJKRnpGdmdyQ0M0ODBYVEJNVDR0bklQWmUyYXI2bWVN?=
 =?utf-8?B?RGNLUVZOM0ZYOWVEUUQxM2lSem4rU2tXUUk5dktrQTNOYmxhSTNvemFtdzV4?=
 =?utf-8?B?WU1JWXQ5b2l4RjNDVzZUbWJDaTBscGZEN3dTNnZJQk53OWRCbXpOOVVLaDJa?=
 =?utf-8?B?N1RkUmQ4WGlzWitpVDBLWDR2VmhuSzNzV3JzZU9LZFpWVVp5Vm5jMXpaS0l0?=
 =?utf-8?B?b29YVTZpYXpNN3RKRGVmYW1rdGlhY2xKbWIzdFpJaEZ5dVBjVGZCR1VxQnpz?=
 =?utf-8?B?UUFBTk8zV3VNWDdnSlFOWkJIQmN0K1lSNU1sdGJWTGI3dTFPOWdvUEltL3By?=
 =?utf-8?B?OXY2SjVjZGIyaVgzWXN0U2lLVEltSGd4ZGs0a2o0WnJIUUltY2xBbFRwczlU?=
 =?utf-8?B?L3o4NkhURjFLa2k5dS8yOVdJQjBsTjZCU2FVKzNKV2VOMzBveFFXNU9lWk80?=
 =?utf-8?B?eVRITG50OUdmYXIyekoxOFhIcGl6cStxYmlQcVpETjIxamV4eEI0TXVMeW1V?=
 =?utf-8?B?ekcvemtGRGxFaERCVDNOUzIwRVRsL2lRbXc0RTF4MmVDZmxCVGdKSFdZTzkv?=
 =?utf-8?B?R1F6bzlxVEJKVy9VQUR5T2R1T1QrUTVRN1BkMDVPQzAySXNpNGt3clZzRkh2?=
 =?utf-8?B?eVNaRXZkVThJZk9tUloycmN1THZrUDAybUZJck5lT0NHdkVpdXVHMyticHRC?=
 =?utf-8?B?RUc2N29sSTdlL1NrNmpnTnhqaXBuU1JnN2lVaVhjZE01YlpWcGhUeWxqeHBT?=
 =?utf-8?B?R25WTnlKZGg5eXdxbng2MXlvVndvejJpQmZqc1lYYlVUNUdZaXVqb3lqZDRJ?=
 =?utf-8?B?b2pUVHZsN0xwYWhFSFhGNnM3cTFrWGdTbHhEV0prMlM4ZE1BUDAxbmdKdkRt?=
 =?utf-8?B?WFo1cFg1ZllBRG51dW9PNENEZm1BUVpBeW5NOEYzNWU2cTQyNmp1VzRCV0lN?=
 =?utf-8?B?ZDJKWFpCdVdNRHhiNDd0RUREdXp2RFZQZkhQMTdlaDRDazFiMEIzUi9JMzht?=
 =?utf-8?B?NU1yQUQwT2cwQnpwb1plWFVkTE4xZTdaVXh1RWIzeVlqbktqeUI2UDFkYmVL?=
 =?utf-8?Q?Yoou+59QKnkOmeBQPM2utmRc1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c45450-60d5-408b-8919-08dd937a6cb0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:33:38.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2lhb7+DrwjjPzFX3SQs3n0JIl4n6nK491ROxPD2lxgwaU3UrwHM00ZuJ/SxElep6ROY/+uKOrg8ZO4Zrm6oNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474



On 5/14/2025 1:26 PM, Ingo Molnar wrote:
> 
> * Shivank Garg <shivankg@amd.com> wrote:
> 
>> Building the kernel with W=1 generates the following warning:
>>
>> arch/x86/kernel/apic/apic.c:2140: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
>> arch/x86/kernel/apic/apic.c:2140: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
>>
>> Fix the description format to fix the warning.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  arch/x86/kernel/apic/apic.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index 62584a347931..f888a28d400f 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -2128,9 +2128,10 @@ static noinline void handle_spurious_interrupt(u8 vector)
>>  }
>>  
>>  /**
>> - * spurious_interrupt - Catch all for interrupts raised on unused vectors
>> - * @regs:	Pointer to pt_regs on stack
>> - * @vector:	The vector number
>> + * DEFINE_IDTENTRY_IRQ - Handler for spurious interrupts
>> + * @spurious_interrupt: Catch all for interrupts raised on unused vectors
>> + * regs:	Pointer to pt_regs on stack
>> + * vector:	The vector number
> 
> This is incorrect and is based on a misunderstanding of what the code 
> does:
> 
> DEFINE_IDTENTRY_IRQ(spurious_interrupt)
> {
>         handle_spurious_interrupt(vector);
> }

The kernel-doc tool doesn't handle macros properly.
Can I change it to a normal comment instead?
or if a kernel-doc comment is required how should I make it correct?

Thanks,
Shivank



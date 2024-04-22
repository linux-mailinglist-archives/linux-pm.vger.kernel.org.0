Return-Path: <linux-pm+bounces-6819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436AB8AD14F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2187285259
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF0153578;
	Mon, 22 Apr 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0luayOKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3C1514D6
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801265; cv=fail; b=EPJTGxv2MkILQgjSaeSQxHbYSKbCZBQrILXfB73ROsEI8P5rwMpUbC/WG7fVCr2A2QWgafACVWFkylUb+PFEMMjboYsu8ODuxb6Ie/paqHF9dImQmc6JJFcRMDYHob8wrhv4AW16c/dBx9Wxx7DvHT0ZruG4ehbRk2/xfzAQbYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801265; c=relaxed/simple;
	bh=nfc0j6prDPzQDUIDv4OxFi2p6ZbbEWoggqby283W4o8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/mh261Jm/+4hUq7ce1YOhOePHz2Q37tMjmMoaiHM4c611YX+xSJL/mnPjIvtOuALslccybIxNVGa/fLpS/rJCfYZKX1Q+nUe4JbHfQIwKYGUPU/D1+xq/AKTC4Gcn4urDUoNW6W4lXpCQ/Hju0eBo65B7CFmMTTQnsWMtsEWgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0luayOKZ; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZPAvIPDA3kpogdD4BW5XQXnogGH3K9sPle5H3pVvaAJzki48W5RKADAIE7gzpRef7ohn4PQXKolMPqrUhMDsqh/+J/mkV1XFbQaLJjl0QzFoM6VUw6Q0e5/oRCe2p7bk3K/eMtMBTxgIYS7BGyCArL5GV/NwumuNsN9a3F4I6kH/b7CQal1wJBx/cwgGIEgJoSwbY3crn781JuRViSWFWOnIYN/dwhE+CH0vVAQqEmrkRujz7kDbkyFcx+2i60c069Pn1b1YQWIKyoFpIheNVX/a/BWww3ua5oqyJtBbvf2aAXhwe0i1KaYtRHoVaUbQ/T2er5oVldc34brx1QxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xsnW4dpVR/Wqt0/ZbctoG9piyiHqgcBHyG77c1SHPU=;
 b=eRwioWBhUqQpzbDjrR7955M0XlvZWoB1gEMcGPn3wDwyV1clzNfpkFiYgyw1WGpDQAzmWJOHPxWzKh9EsTBdZQS4+nBdii5CfDGuQ9/IN6SP+3F1v0dpUvqbnchyCVJRPq3NIyIrV6RLCz53uAEUIEeVXbDhP/bD1hMWV4gqyy6JtCrCr1AxqraEIvQysOCztOex+aE0xClUK/Nxcepj39x+d3lAJoKLkj2TwbL176XquyAgZ4jpH5B39AQF1w/qMXz58yGAv/tnRLPufnWigXYZfb2SKV9rDa8pGnvPm/a5UjsL46k+e65elnWmZYgAZix7QkgSv76xSlhoK2xHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xsnW4dpVR/Wqt0/ZbctoG9piyiHqgcBHyG77c1SHPU=;
 b=0luayOKZdqUXo334npAnw5Tru1bg+q/Rl7qF9IItZ0ApU8DWl8Udr/9BuPPSnCVgAxy3buQiE+AmbBrw/UtSwpcQeHFwgvHnmKu4QyKG0UxdSQkZyhZelrg4gBzTaCHc37G1QHTotZvB1uG4IlMajgkYphN/gvtrUXGWMDJBOKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:54:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:54:20 +0000
Message-ID: <cf3a8d4c-846e-4d7c-ba6e-b774dff420d8@amd.com>
Date: Mon, 22 Apr 2024 10:54:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: xiongxin <xiongxin@kylinos.cn>, len.brown@intel.com, pavel@ucw.cz,
 linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
 <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
 <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
 <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com>
 <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9aae88-15a8-409a-67d9-08dc62e47935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3h1OEplSndycjVJd2k0dVpGeTVKZ3YzVytVK21Zd1crR2hUMkQybW52STJ5?=
 =?utf-8?B?MGNvVXF5aHdtT0VibGpFZnozOUJxWW5DYW9OcDFMMUl4ZHBWMFJkdUdURG5a?=
 =?utf-8?B?blBRQWRibjYvTzk4MEIrZGRnUHFTRDZaazBxTXRmM1kzZVFKU2xXcjd3Sy9m?=
 =?utf-8?B?VXJoZTZMd21iVUQrSXlGM2U5Qmxkai9vZEM0c2tNR3IyQi9tOFNvVWEySERB?=
 =?utf-8?B?TU0zOWloUWszVGRMQ1FLODByY0hhZVU2UUd6VG82bVd3aE5rbTIyNktKNEda?=
 =?utf-8?B?OHlxejZoRFBGVXdYVUxyQkFYQ2JSTWdEeXh5dDZBSDdrdEgrSHVheXFwZUVv?=
 =?utf-8?B?Q2w2YlBPbUlNaG5yOW42WkZGQ2FoTlY3SDJaV2IrWHFXRDVkVVZoUitQd0lT?=
 =?utf-8?B?NGZXb3BOUndsZTNDcE8ybTVEOWpHTGlMVnhEZjliQ1ROWXdQcWJVWmE0Ykky?=
 =?utf-8?B?Sm4ycHR6YmlxSmxodUZDQmU1aW5MWFR6VGtXZWdPTnp6K3c5R29hY2J3TmQr?=
 =?utf-8?B?Y3Y0UVpvckdWeDN4QTEzOGV5ZlQzdER2cEtTa2FibE1ZY0dad3NlRlc3S1pR?=
 =?utf-8?B?R1VHK2xHb3dDazB4YUc3aTNjRVNuc01oNmg5SUNRM0hqVnJ1ZiszWFpMVXMy?=
 =?utf-8?B?QUw3ZzU5MWhuRjVtZEJReWVNWlRTYmVVYWdMUGdHMHJHK0xaZ1NnREFvd0oz?=
 =?utf-8?B?eUJoN3lSdnBzdzNzMTVWRFpGTlhBclpXVlQzQUVmSmdMZE1kYUlMWlY0eXQ4?=
 =?utf-8?B?VUdTMjdKNzJUZUtNRENuNjRNYkx0ZVMyVzJUSXZCMVh2dG9ReWpQUWwxVXpG?=
 =?utf-8?B?MVNBSTRFeThSL0VZVGRWRFA5R3l2Uk1iTmlGVnN5MWFOMXJ1SHZyeWM1MXd0?=
 =?utf-8?B?WkFiSWhkMUhncDhWY1pKSHFvcEI5VUMxdDQ3QjV5SlFYSEEwU0RiUWtDVVRJ?=
 =?utf-8?B?eVU4c1BaRU1aZG14MHFoa2dPdURFTVlxSmk1ZVg0SVF1OHFkbjBKSDBtekl5?=
 =?utf-8?B?cEU5VTRibHhxMjhNNnVMOFdOL0doT092aTVXQ20zQ0dqWllCaFZxR0pCZ1NJ?=
 =?utf-8?B?VWYzYVdsTEhhelA1cVFDQWVVRnVBTG1VaHg1LzR5TEF0c0Q5T3QwMHhjNHRC?=
 =?utf-8?B?Rlk5RnZFb2NPaDZ2N25GbG14cERiSFJqMFFseWFqMnNyZm5SeHJSd1BORnQr?=
 =?utf-8?B?ZytHcnNDb1ZDNlpQWVpCeUhJMlZxNlV6ZTl4WUdEWFVqOTUrdm9ZM1NWUVZ4?=
 =?utf-8?B?OXRqOTV3UWhnazE5ejY4Mytvck5jOXhwZlRjZmZYODlWTWIxMFkzR3dsRHBV?=
 =?utf-8?B?QjRRdHNFSDRDUjZPQXFKS3lZZGhYV013STJVTVV6S0VocE9UeVlmOThLZXRz?=
 =?utf-8?B?ZWhJTk04K1hJZjdsVlZLSDMxaDhkaWVIQjVQajk1djB0akxiTS8ybGhaNjJq?=
 =?utf-8?B?bkp3elA3U1QyVVRWV1dxUU9lQkRzVGtKajRFaW83ajd2L3NLeGgvRW9YM3dn?=
 =?utf-8?B?Y3A2a3QyNTVBck1KWFNSMWhmTU1YWnI1VFhDbU8ydmtwVVFibHpyK3R6bTBi?=
 =?utf-8?B?S3ZyNU55ekFxR25JQjNkRnR1anRMSDB6dFhHQ0RlZzhRcmxGYm9WZGxvNjJM?=
 =?utf-8?B?dmxjQWRxR3pjZGJQKzlNVDJDRm1rNG5STVk1U0JuWXVPdEpDTnFHbmJweU9u?=
 =?utf-8?B?YjRNblFaT0Zab093S2pwTzZWWTBBbW9UN0FmMFg3QlkxSmh2TWxsSnBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVRnWDhqTm4wc0ErZnpDNXNqY1hROVQzd3FOc0VDRTJQcTdQbGd5bVNLZ2JG?=
 =?utf-8?B?YkhlaGRGMk80L21pMTlOd2ZkMUhxcjFwUlpUSWlyYzFxWjJQZTllblYyTUVG?=
 =?utf-8?B?WVNGdlozOG9JWk1TWjM2cmtqNWNQdDN4NUYvWXFQVnNRTk1QekRQcis2QXI2?=
 =?utf-8?B?WWRERVo2cUVkRzdIL0VvbTkvK0pLR3NTb1JNUGREVENYdkZtSjNzQjlKVWRW?=
 =?utf-8?B?NVlmZUVXMlQ1R2NqTG9JZlByL29FLzNjd0R1RXZMNDJiNGpHeitrN3V4THVs?=
 =?utf-8?B?U09GakJaME9rWTdFOTgrdFRWNHg1a2dDalhHVjljcnVlZDZxSjlXYVRaUGdX?=
 =?utf-8?B?TWlvUUdHdnl5b2VueFAzdk1xLzMvQ2IzWkE3NHBhS3pqbHYxT1ZHUHJLV3A3?=
 =?utf-8?B?VFJjcmtjTEorLzBGdWp6YkNiVTdOZjl1cmhqY1RSVzArekpQcTJrenpNY0JE?=
 =?utf-8?B?UmM1MnZSSUMyb2hCcTJ6eGZBaG9FTndlSFYrWTRvdTRwaWNKMFJrVVF1cStp?=
 =?utf-8?B?N3pvVStCQmxaMTR3WFRkN2JqMWZ3TGdOOEpDZkxtTFJReEdNVmtqTVZCei8v?=
 =?utf-8?B?SGJSOWZ2a0RraWlnWGJzYktPb1ZBTXU2eWNIUzNpd0pNclRESzYzQURiUmZi?=
 =?utf-8?B?aWNUekdib1JWc1RYeUo2aDVaWWNSU2VCVFdZZUk5K1dsWlo2a1crT3k5c0p5?=
 =?utf-8?B?U2VuZ1VQZmxWU0dVN0p2SjNqc01weVhDb0RqMmpmTm9tb0M1YWxGOEJldjZT?=
 =?utf-8?B?L2lacVlyNVNadmFBV3BEd1k2RStqM2JvemsxUWVDSTBaZk9VTlRwVHZDMHJP?=
 =?utf-8?B?a0FMTFJ4eEM4U2xpaFVQYVFpR3M0YUpQTVVnUEI0K3RQMWN3MlJ6bFR6Y0pI?=
 =?utf-8?B?ZVozTkZURExEU2ZDWEx4NXRJYlhYUkhkY1ZaS3VXdi9kR29wQVRjWmQ0aHVi?=
 =?utf-8?B?QmpEZFMzZkJXOVNLQ2hidG5sNzFJVU1OWGVKZ1dUb285bk9RaXZEQ2hTTWRS?=
 =?utf-8?B?b1JlYjNLUjRWUkRFMVdCYnc5cnYva3FxemphNTJKTXVFZkVxSm5lMWVGdWNu?=
 =?utf-8?B?a3dTRWZPMVp4VTdhMUhWWm53VXducDFCREp5UDNrM1ZMNGRXVVJERFRBYkxU?=
 =?utf-8?B?RVVIWEsxU05nWU94REVVV1RHRXlta0dpY3dmcDJod1FFcGFITHRJM3NzeDhO?=
 =?utf-8?B?OHNuQU53UnBFMzIzZmYwV0x2Vk83RFZMempGaDNBQ3JBM2R5cHp5cys0RzVj?=
 =?utf-8?B?NVJDcjVEOVhjVjJOZWhVOVBqTDlIUTVJRlRBcFBVb200SGRsSGxkdWhFMkVr?=
 =?utf-8?B?VzZFdXBEclpTcnFoaTFpVmRCandFK1hUM3pqV2NYbFFRckhUQ2R0MWtkMjdv?=
 =?utf-8?B?VmEzNFkrcnRqTzV3QkUrS25OOHYzOE1yRjJ6ZXdTRlpPcXdiRWNBdW9EWUtv?=
 =?utf-8?B?ZGVBV1JVeFE0NVAyamFoSG1FR3lNRWt2czNnUzFONEFicHROQTVBWk1SRjJh?=
 =?utf-8?B?b0dRWUtLSGdsdU9INnlxYUdWcjVlTzI0cGRxNVZReG5qS3NKQmJTTjlqRFY4?=
 =?utf-8?B?ZDErdGxwYy9UWCtQaXJTTmxmS3dvVlhZQ1phVGkyTHlyQWhRTm9qMlV0THM0?=
 =?utf-8?B?MHZMcGxkamVDRkllSnZjalpXQkE0N2ROWW9IVmFXRkc2SEJOU1c0MVZXV2ZM?=
 =?utf-8?B?SU5RSjlhcDE4QStmbDdhaDVobWJiK3oxRno3MUVhbVZLd2Z5ZVdDWXFKeEs3?=
 =?utf-8?B?ZE53OWltcG9Kd3pRdkZVaFFzaTNYdDRxcnNYUjlkb0EzSFllTjJCQWRHaldw?=
 =?utf-8?B?T3pvUzcvcE01akFoaGwzaEJjcGVKdEpZVU90bC9XQmpYbytoanUzMlRyMzd5?=
 =?utf-8?B?VllFaVdJZHN4MktjanY2eDlnZjVkdlZaa2V5bGtkQTFXV3lVWENUdlFOS21V?=
 =?utf-8?B?QWhDRnFYVlNuRkwxTE9oZEtxeE5LdFd1VGRoVVJrVVhtcmxhRlBUVStJNWRZ?=
 =?utf-8?B?V2t1NVRiZThvRnlPcWtSeGNIYVp2RGF3NmFKVnFabmFmenFlUHV0SHlWVFZY?=
 =?utf-8?B?S3B0Wm9IbkR2UVVlemc3OXpNcEZtZUhuRU14SzRpN2JlMXNIREpsTnR2VzFV?=
 =?utf-8?Q?zqo9dJ4MulenImqtoD7jQJyxq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9aae88-15a8-409a-67d9-08dc62e47935
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:54:20.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85NPjirgtFcPZQwsjlFOueNt4zIq9NXXrAUTUxshPLfyccHWleSRUx6Fi3gqQb4cQSYLwsNSVBP4aWpxft3MQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363

On 4/22/2024 10:43, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 5:25 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 4/22/2024 10:18, Rafael J. Wysocki wrote:
>>> On Mon, Apr 22, 2024 at 5:02 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
>>>>> On Mon, Apr 22, 2024 at 4:33 PM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>
>>>>>> On 4/22/2024 04:36, xiongxin wrote:
>>>>>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
>>>>>>>
>>>>>>> In the suspend process, pm_pr_dbg() is called before setting
>>>>>>> pm_suspend_target_state. As a result, this part of the log cannot be
>>>>>>> output.
>>>>>>>
>>>>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>>>>>> pm_suspend_target_state is not set, resulting in hibernate debug logs
>>>>>>> can only be output through dynamic debug, which is very inconvenient.
>>>>>>
>>>>>> As an alternative, how about exporting and renaming the variable
>>>>>> in_suspend in kernel/power/hibernate.c and considering that to tell if
>>>>>> the hibernate process is going on?
>>>>>>
>>>>>> Then it should work just the same as it does at suspend.
>>>>>
>>>>> Well, this is not the only part that stopped working AFAICS.  I'll
>>>>> queue up the revert.
>>>>
>>>> I just tested the revert to see what happens to other drivers but it's
>>>> going to have more collateral damage.
>>>>
>>>> ERROR: modpost: "pm_debug_messages_on"
>>>> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!
>>>
>>> What about removing the "pm_suspend_target_state != PM_SUSPEND_ON"
>>> part from pm_debug_messages_should_print()?
>>>
>>> This should be as good as the revert from the POV of restoring the
>>> previous functionality.
>>
>> That would probably help this reported issue but it's going to be REALLY
>> noisy for the pinctrl-amd driver for anyone that sets
>> /sys/power/pm_debug_messages.
>>
>> There is a message in that driver that is emitted whenever a GPIO is
>> active and pm_debug_messages is set.
>>
>> It's a really useful message for tracking down which GPIO woke the
>> system up as the IRQ that is active is the GPIO controller master IRQ
>> not an IRQ for the GPIO.
>>
>> But if that change is made anyone who sets /sys/power/pm_debug_messages
>> is going to see their kernel ring buffer flooded with every since
>> interrupt associated with an I2C touchpad attention pin (for example).
>>
>> So if the desire really is to back all this out, I think we need to also
>> back out other users of pm_pr_dbg() too.
> 
> OK, so it needs to check hibernate_atomic in addition to
> pm_suspend_target_state.

Yeah, that sounds great to me.

Tangentially related to the discussion; how would you feel about a 
/sys/power/pm_wakeup_gpio?  Or /sys/power/pm_wakeup_gpios?

If we did the plural and used a comma separated list we could probably 
axe the message I mentioned above from pinctrl-amd all together.

Thanks,


Return-Path: <linux-pm+bounces-16556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837BD9B24B0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 06:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A18281922
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D518CBE7;
	Mon, 28 Oct 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OI5TBY9+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B326156960;
	Mon, 28 Oct 2024 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094777; cv=fail; b=oBBfqwj+3jeuwabgmQkHYF7uEY8ZmtQa/MUKH7yhTAN8vblsb68aEdoVhqvqb1HcolQ4CMnze/P0gCKbLAPm2dxhgNubhR9zkBTu5eU/X6uNZMZRKamFgylspDv26hmv7YEJTT9cj/kmLGiVk1zmSVOlnGTD7zTMt3IXsIRLP2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094777; c=relaxed/simple;
	bh=dce+NuVWHzNoGX0j9KMKUo2Y4zu/27A3AsurxadoyLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vd2GFXjasZEY2mDMIXq9JOa05o8WQN3WnOpqrC33v4YYLHXdESC+m6/tf2qNP9w9kredlQUGQLZvhIrcLHX8w1ou+jyc2mY9AkedYZei4xdN2cE4WzN85J9ANWaJBvLK3j2OdeHd7bTKzZSxYAeKAkhF4H/uGcWyxrPZayZ3Fxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OI5TBY9+; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ioy3+kWRPWOW2ZU227vat5JLDUBKSKJQXaOL2hEClu/dclzy5zXPhtYv5FCfc9umbJ4lE+G1WgKS1NAC4zZB8wtSpmZuDUfd/jpIpZfVe7NVNBh8ixX6A5uTjK98ZUpilz/pPwFGmCGpm9j9tGrlVsIEUyYhT6DtDOzBz9ntYB6Z/jLEyfneyfzhsmB3wgwfWP15HPeeBssgXoSGPEEz8Yx5501ORBPIUCQRvmUKlw0oYtb6GsmIqm22aFKeI0bhRMQZ6eHtrrZ3cuu29lkxshtMzgI9PXh5Tb5q1Rzw8d1J1DLp7Eg15c3L0i2bO5UaYKi5JzdtrTD6I4SZPcXlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se2Acy3wt1+7/AaktCxp5iguZQwWnS+8h2TM42AOS7I=;
 b=sFQlJ1bWwHXF4KnpuU1ZVR1822q4vzmxdk4nxu9lsihwO2BYNf1FCBM7yS1ueTNtgVtx64qd9xgeB1/u0GkfF7uAZHxq+w1BxvRK99reomC+YQdCbstuYEuF7QHN6nhE0guAONKWPgAJnN/3uUXzVC61xYWeFkCk/ZpKLs37Ee5BBshiaSjQFxdxd3ipt6R7A7X4lxjq68TVhsUJrwd9WNrwQctJbrXz9d7SGBvd014HIsol97mCaTBBQuKykDoCnLguwcx8cGDm/9QlcX56OJhgZRber8mFo/LE+OE09xr4RSbkXHQgG9QCWh2oR+wn+h3EdeJhZruLaNauBxQUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se2Acy3wt1+7/AaktCxp5iguZQwWnS+8h2TM42AOS7I=;
 b=OI5TBY9+mABJy1G4YeeDiP18N6ao9ScY0XvbsvkKqcnlYSrFFpls+IpHAt+qwZHgNFBlpewjBhocux6d+na5RhL1SBzolYj8jZZbKhkzjh9CYtR4LiNgyxxIkqNp64OZyhTVeDAQr+RDzKUsN2ZKjGsHXSweNO0IC1k2YCHVNxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 05:52:48 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 05:52:47 +0000
Message-ID: <c7cac2dd-8fc8-498f-b3c5-bd95900e881e@amd.com>
Date: Mon, 28 Oct 2024 11:22:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20241028020251.8085-1-mario.limonciello@amd.com>
 <20241028020251.8085-6-mario.limonciello@amd.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241028020251.8085-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B1.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::d) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5bceac-4f46-4687-0cf6-08dcf714bfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhWN1JRYU15azRwVDRwdDlzTzRybVladllpR2xWVWcrRGVZWVlCMzQybDJ0?=
 =?utf-8?B?NUx0NzcwdnZZcUt3ZklZTDNNazVsVU1TQ3NoYjlCZ3phMmN2YndpSVNJQXpj?=
 =?utf-8?B?UGgrNnlmUHpKWHFLbzlwTHByMk9nZUtuNk8wU29NYXYzOGUxQXpFRzdHdkl5?=
 =?utf-8?B?R0NrU2NDUFd3eDBXU2tQRHNkSkRwdnhmSmlQc0ROSzFGQkNmZmVTMnVSMlNj?=
 =?utf-8?B?dGV1VHM2dEU3OVJVVzF2ZU5EN1B6aHhlR2RYdUlsQnpMRnBwZ0xSbzBGVHg3?=
 =?utf-8?B?cnBVTmIxamlwTUpCVEc2RVdrWGFsd0QwZmtyUlhIODlrUWRZNjVXNWR3MjUy?=
 =?utf-8?B?MUF1QXlXQXoyWkxFdVlXMTNYNGM2Ky9ZUlppa2VzSGRIWkVsOW9tVkU1dktY?=
 =?utf-8?B?WlRrVnRSZjlLZDEzUVNDNWhLY28xZzdYYi9BRU1aaHRHSm9UdWtxWjlxaEd3?=
 =?utf-8?B?M2xaeWkyS3FJbFJ4akZLQUpYZHoxdUhWbWM5U052NVVxR2g0T0lDek0zZGx5?=
 =?utf-8?B?dVFYcGVKcXpwT2NXam1GZEZybnZ5YTZ1bnNJbzJvM0ZhbjZvdnFES1dTMHFa?=
 =?utf-8?B?Q1FjRXpLSmkxQ05iNFhTbEh0RHZub0dFdHVveWdFOUxJODMrVEE5YzF2cHRY?=
 =?utf-8?B?K21rd2pXOFltUHFPSUNzMGF3S3pFa3FaVnQ4K1JqT3JMaXZaRUNpUDNHNjNt?=
 =?utf-8?B?QWdHRTNZTDJsMXJXSVRTK2dIWExmWXhNRFZ2MnQyRFAwQmhqSzVoVnVWQnNl?=
 =?utf-8?B?WkVaKzd6S0dyOVdXdGZDVXJRZHNKRVVxcXhkdzFxTjhCajVBUXc3blhrNEVZ?=
 =?utf-8?B?YnFZNEJXV2dPdmNrdUtia1VHRkNvemx1K01yZGViS2YwQ0RhbWNOcmZMVXg4?=
 =?utf-8?B?SzFhWkhxQVZlTDFieC9NTDBxYklBa1Y4b1EzVUlhMVpycmRjQUtmd1RDSW5K?=
 =?utf-8?B?dmpyVlJ1aEY3REtkeS9lbjRaSEF3SVM4WmFDdk9wTHVaQWNTb0xoTE4yU3pG?=
 =?utf-8?B?eUZrQ0JXWm4wRk84NXJUUHJhTmNyZlpzYUVtZkhDdDQyM2lmMXYxbVdGdWlv?=
 =?utf-8?B?aEk3T1hOaWhPZ0RwUy9LWm1EVlRjM2xDSkdVWTVrS1VWeWFjU2ZDVHd0aFlI?=
 =?utf-8?B?ZnlIdkZGU3hadXpUOUF6emhPV2xlTi8rS1B1TEk3azcybUFWcGJPdXZxbjA5?=
 =?utf-8?B?SEwyL2ZMQ2dKVy9WWHp1c0tUTUtWYVpKUy9Wa1ZsR2w1N1VTR1pvaE5sbjVZ?=
 =?utf-8?B?NlV1eFZIR3ZIVStWZDJvOU1iOTVvZ3kyemgrU2FXQW40LzRjZXBnSnlhSnl1?=
 =?utf-8?B?bnVXZTFVckk2SkZ1cUpLMVpZeXI5eG9Vc3JyeEszckM3dTUyMS9YUmlRdDVT?=
 =?utf-8?B?L3kxVlpwa3FuZ2J2M1BjMDhQcUhlQUxFd2c1TkhTU0lPMnZORVpJZCtpUUlw?=
 =?utf-8?B?dVByT0VWMXRQOS9UY1FQWWFMN3BjS29uZk0ya3JoN2xFa0ZvNmJPYXBZOFJC?=
 =?utf-8?B?Sk9oblI2WUpqTU91RFlhNkRxaUtYdkxZcGcxNnJJdGRSM2lpK1Nwd0pjRkdN?=
 =?utf-8?B?ZmdkbDkwa2lMb0NsVUdvRWRjYVR3Ny82Q2QzM0lOR1h3b2lYcEVQZzh6dkFG?=
 =?utf-8?B?V1gycDBpZUpwaDBxRWl1R2RvS0hyN2dKdDQ0Vk1kc3g5OGVTRStCTjMwRUg1?=
 =?utf-8?B?MDdBY3pNclpIN3NqNjJaME5DdHl2YVJDeHRCenB2djlHV3Y4QVFIL2lWdjM1?=
 =?utf-8?Q?yCrM9Ke95ZxihnyUx740a8LqhnMiX+G4d4Vqgfr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QklIUmtyQmpYeGdjWWEzOU5YUDJiSFNqTmNUUE5TZ2R4SUczRzZrMkh1N29r?=
 =?utf-8?B?RFdacVlBTkxvaGs2UlNTck5wRGJnR0NZUXhhYkxKV2NPa1RBZTBhUmtxNlZh?=
 =?utf-8?B?ZkVTbE0zdUxWQ2JMSnQ1S1VzdTlGTUh3R1R3Szc1cFJwU3VPT0pRejRpMjQy?=
 =?utf-8?B?UnZVUGJoYzNqTHUrMEJnRHR2VmptZkJjSTRWekxNbUNDMFNwMEwyUE45UG53?=
 =?utf-8?B?NEV4NjhaSjlCRW9vNlg0Uis3NTBrL1VmL2tLSTROdHg0Sm9yeWF6QjFzdzFR?=
 =?utf-8?B?RjVSaE5tRGVJaDVlOHZUNUlzbXpWTGJ2R0thT29SaS84T0VpRDd5UEVuVSt2?=
 =?utf-8?B?Z0R0OXBXL3BpU01zWlBoN2tRdkFaa2Z2ZHFoUUdSVUJDQmEyTms5ODRjSmdk?=
 =?utf-8?B?Y0NxY0VvYTZnaUlJRjM0SXkyV0FMazVTRjd2SkFtZTJ0MVJuYzVKZktKSXhj?=
 =?utf-8?B?VXljVUt2RkkvUXk1NXpYSlpsWCt1b0lvM0h5aHhvTXA4VFdteUlDRzREYVhu?=
 =?utf-8?B?K284Z1lJN2VWcUZFUmxIUUcyNVR6YkdCWFp5dENmTDgvMDU0Zmd1ZUxyQ2Fo?=
 =?utf-8?B?VDUxbEk2Z2RtcU0rM1NHcndIZ0k0SWNCTldnMHNpM1ZLT1BTOW5kbU82QktV?=
 =?utf-8?B?VlI0K1pnWDFIQkJURWJ2ZVJQUCthbjhsNXcrZmt5M05PS3ZKbE1MRnpycllK?=
 =?utf-8?B?RHZmUGk1NGRSWEhhRHhGbC9hNFRLYWdRR2JHYngxNzVYMlpmVVdIbzc1SVBo?=
 =?utf-8?B?cFJyN2lUWXl1YjArME5hZ3RRU0JNdWt0YVRBL0duOWhGWXBvbTlZQlBnUWo3?=
 =?utf-8?B?N1NnZjJlNE1CbDVRNVFubUNPeEJDMUFGdUd5bjJDcUhidmFoeXc1eDA2YnZG?=
 =?utf-8?B?cW1mdkhjMjZCZjZ1N20vUE53ZzZ4MVp3ekRxOTljd3ZQVlhKeDVqZGw0dlFm?=
 =?utf-8?B?dUUxRFVud2F6RHNtYjZtd0UyQXlsVnZZYjhPZGF3aWFTQjN3STJPOGk4bFJa?=
 =?utf-8?B?N25JMEhGYlRoditrUFhYUjdtSGNvbW1tOEF1VEFZTEpEUGhKZENrTGRuOUNJ?=
 =?utf-8?B?QjZXcmdFMk1OTVU0dThwemJiQklFdjlMaFcyNUlWOVpvQUpMNFZxYWprY2s4?=
 =?utf-8?B?S2VDeThZeFJzYzhBWjdxWE9hZUFucU00dXRMREVVN1NSS1BaWFJrM0g2UnVs?=
 =?utf-8?B?MHVsV0tEVmV2Zk5kYUhuK1BvWlNtMlVLR0xyWTlEK2RDL3pJNm85NFp1U1hv?=
 =?utf-8?B?bk1pdjIybTU4TXN3Q2NWOXVLY2NjZ21yUFJHUkZMMjdOdzJiR3pqdXpnSkt6?=
 =?utf-8?B?N0ZWcC9pZ2N2UkZrbWJGLzByZG1ZWllwOUpZcnNzeEJPbEdRVmFoTjFCU3hv?=
 =?utf-8?B?WlN6dEMvWVNpV0VLUlFQSkJveEczUlB1MUQzSWs0aFJ6WUkrNmgvTVJ0eEVY?=
 =?utf-8?B?d3BKOVVXbGFsL3Nzd3loZHVHaGVja0RUcUY5NklGcDNuV09CWjRuL01tMTZB?=
 =?utf-8?B?OFBxOEhBRUlBSGV0bXhISXhFYzJzMFRWSDN2WDNzQSt0bVZ6U3BKUmY0aDhW?=
 =?utf-8?B?MEJPb3dob1E3aFN4YUcwOGU5ZWU5NkVIcWdHanh3a1YxemlRd3ZBb0F2NU5s?=
 =?utf-8?B?TjRnalYwY3djSnBCV2xaWlE3UXB4bDQ1UG9qb2syVkVUVXZuQlJpM2M1eStP?=
 =?utf-8?B?T1krc29RR1U1WlJPdzN3WittMkJranBVbXI2UTJPMm5GeWtyRkVLWFRwbDhP?=
 =?utf-8?B?d3JQMlRWMWJlNHNqT2VoSkkvMUlRSXhBUEYxRm9RM2k0dFRGcXBlOFUyb2tt?=
 =?utf-8?B?cHZvVWpzVmNCK1dpYzFoTDNRMEFrVXZuUmNMcFovZy9uZzJ2b3pJalY3eVdR?=
 =?utf-8?B?M0pIRWJmVVNIV1lRajVoR05rVU9ERXVpVkJJWHJWdWRBL1E0TTdnMnNzOVRM?=
 =?utf-8?B?NFI3cFlqM1NuTHV3dk9rMFAxUW1VdW16Qll5cEk5NUsvb0kybzYxeHNiay93?=
 =?utf-8?B?V0dxU2dVR3IrcEE0Z0J2djNzWVE2MEtHRG5rYnZJSWY2d08xMnlNR2NKTi9N?=
 =?utf-8?B?NEZCVjc5dTJpajRmM3d0YW0vRGJHbnJ4bUFHbGpORi9TU05YS1pkZk1LZ2p0?=
 =?utf-8?Q?U72bUd7I36uBoOhjLJh5MuAAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5bceac-4f46-4687-0cf6-08dcf714bfbd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 05:52:47.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDJ/bf+BznQ43y55CrwzRRBbYI+kBFIAGHPWshl0crZc3ivWDImvQ4P+bjp8LTyCKRc971N7kcFU6/Etse3Z4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537



On 10/28/2024 07:32, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> There are two CPU core types defined: `Classic Core` and `Dense Core`.
> "Classic" cores are the standard performance cores, while "Dense" cores
> are optimized for area and efficiency.
> 
> Heterogeneous compute refers to CPU implementations that are comprised
> of more than one architectural class, each with two capabilities. This
> means each CPU reports two separate capabilities: "perf" and "eff".
> 
> Each capability lists all core ranking numbers between 0 and 255, where
> a higher number represents a higher capability.
> 
> Heterogeneous systems can also extend to more than two architectural
> classes.
> 
> The purpose of the scheduling feedback mechanism is to provide information
> to the operating system scheduler in real time, allowing the scheduler to
> direct threads to the optimal core during task scheduling.
> 
> All core ranking data are provided by the BIOS via a shared memory ranking

/s/BIOS/PMFW. (as you have mentioned it as PMFW in the entire series)

> table, which the driver reads and uses to update core capabilities to the
> scheduler. When the hardware updates the table, it generates a platform
> interrupt to notify the OS to read the new ranking table.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/Kconfig      |   1 +
>  drivers/platform/x86/amd/Makefile     |   1 +
>  drivers/platform/x86/amd/hfi/Kconfig  |  20 +++
>  drivers/platform/x86/amd/hfi/Makefile |   7 ++
>  drivers/platform/x86/amd/hfi/hfi.c    | 168 ++++++++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>  create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>  create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index f88682d36447c..c3f69dbe3037d 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -5,6 +5,7 @@
>  
>  source "drivers/platform/x86/amd/pmf/Kconfig"
>  source "drivers/platform/x86/amd/pmc/Kconfig"
> +source "drivers/platform/x86/amd/hfi/Kconfig"
>  
>  config AMD_HSMP
>  	tristate "AMD HSMP Driver"
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index dcec0a46f8af1..2676fc81fee54 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
>  obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>  obj-$(CONFIG_AMD_PMF)		+= pmf/
>  obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> +obj-$(CONFIG_AMD_HFI)		+= hfi/
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 0000000000000..08051cd4f74db
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +config AMD_HFI
> +	bool "AMD Hetero Core Hardware Feedback Driver"
> +	depends on ACPI
> +	depends on CPU_SUP_AMD
> +	help
> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
> +	 selected, hardware provides runtime thread classification guidance to the operating system
> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
> +	 These capabilities may vary due to the inherent differences in the core types and can
> +	 also change as a result of variations in the operating conditions of the system such
> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
> +	 resource allocation, leveraging the diverse set of cores available.
> +
> +
> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
> new file mode 100644
> index 0000000000000..672c6ac106e95
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
> +amd_hfi-objs := hfi.o
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> new file mode 100644
> index 0000000000000..a92fe74b415e3
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Hardware Feedback Interface Driver
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Authors: Perry Yuan <Perry.Yuan@amd.com>
> + *          Mario Limonciello <mario.limonciello@amd.com>
> + */
> +
> +#define pr_fmt(fmt)  "amd-hfi: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>

required?

> +#include <linux/smp.h>
> +
> +#define AMD_HFI_DRIVER		"amd_hfi"
> +#define AMD_HETERO_CPUID_27	0x80000027
> +static struct platform_device *device;
> +
> +struct amd_hfi_data {
> +	const char	*name;
> +	struct device	*dev;
> +	struct mutex	lock;
> +};
> +
> +struct amd_hfi_classes {
> +	u32	perf;
> +	u32	eff;
> +};
> +
> +/**
> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> + * @cpu:		cpu index
> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
> + * @class_index:	workload class ID index
> + * @nr_class:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class
> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
> +	cpumask_var_t	cpus;
> +	s16		class_index;
> +	u8		nr_class;
> +	struct amd_hfi_classes	*amd_hfi_classes;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
> +
> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> +{
> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> +	struct device *dev = &pdev->dev;
> +	int idx;
> +	int nr_class_id;
> +
> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
> +	if (nr_class_id < 0 || nr_class_id > 255) {
> +		dev_err(dev, "failed to get number of supported classes: %d\n",
> +			nr_class_id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_present_cpu(idx) {
> +		struct amd_hfi_classes *classes;
> +
> +		classes = devm_kzalloc(dev,
> +				       nr_class_id * sizeof(struct amd_hfi_classes),
> +				       GFP_KERNEL);
> +		if (!classes)
> +			return -ENOMEM;
> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
> +		hfi_cpuinfo->amd_hfi_classes = classes;
> +		hfi_cpuinfo->nr_class = nr_class_id;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_hfi_remove(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&dev->lock);
> +}
> +
> +static const struct acpi_device_id amd_hfi_platform_match[] = {
> +	{ "AMDI0104", 0},

Space after "{" not required.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
> +
> +static int amd_hfi_probe(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *amd_hfi_data;
> +	int ret;
> +
> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
> +		return -ENODEV;
> +
> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
> +	if (!amd_hfi_data)
> +		return -ENOMEM;
> +
> +	amd_hfi_data->dev = &pdev->dev;
> +	mutex_init(&amd_hfi_data->lock);

devm_mutex_init()?

using managed APIs can help remove entire amd_hfi_remove() function?

> +	platform_set_drvdata(pdev, amd_hfi_data);
> +
> +	ret = amd_hfi_alloc_class_data(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver amd_hfi_driver = {
> +	.driver = {
> +		.name = AMD_HFI_DRIVER,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
> +	},
> +	.probe = amd_hfi_probe,
> +	.remove = amd_hfi_remove,
> +};
> +
> +static int __init amd_hfi_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled ||
> +	    !boot_cpu_has(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
> +	    !boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS))
> +		return -ENODEV;
> +
> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
> +	if (IS_ERR(device)) {
> +		pr_err("unable to register HFI platform device\n");
> +		return PTR_ERR(device);
> +	}
> +
> +	ret = platform_driver_register(&amd_hfi_driver);
> +	if (ret)
> +		pr_err("failed to register HFI driver\n");
> +
> +	return ret;
> +}
> +
> +static __exit void amd_hfi_exit(void)
> +{
> +	platform_device_unregister(device);
> +	platform_driver_unregister(&amd_hfi_driver);
> +}
> +module_init(amd_hfi_init);
> +module_exit(amd_hfi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");


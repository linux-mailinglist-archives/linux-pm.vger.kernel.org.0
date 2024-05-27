Return-Path: <linux-pm+bounces-8180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401208D0534
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B421E283B5A
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA716D4FD;
	Mon, 27 May 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5CAYIKa1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00815F406;
	Mon, 27 May 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820829; cv=fail; b=RyD6ZqIg+QJdyzJKYrqmePVP7INgFLheh86zQH005sjU+KMe0ft2sR3ilwuLq7bnWsF5Y3+q6KOnFxV6UpLhjpCVHxMEoKCwOg6cBhDV8ex2qEPrZzp9ysGFCrTnq5igKIcFNMQfosArFjcyWapyjyaAYmLMOfQI1VRkzLpRWNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820829; c=relaxed/simple;
	bh=5L5kerQKFoOWqlcQq1dnhEKBxuzp1GH0mdLmJx9CUW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0QZqr7cvaDgEclldlsXLNR9jCU+eQXPy09Eln/AkinMB/m1mjQuEmXt8XdspJZDCeBB1ShlstJfXh4GvKgx6nBN7/KYmwr5KKdKE0QWFWiHrHA+9agxzTWqBq20s4qxxqjtF9XKeTcwKr9wZfVk5FBx1WjRf+Z2+Mg4jWfn+e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5CAYIKa1; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOBmaBQm8fXHfdtSuzmAx/3hcxX5fpONMjIViX82OTBSRevsTLbZkDUfkXtmtW4vbDs2gsvwOab30MY9Z0pMmJtDD/PCufrMOrrBth/nqHE+++7Y+sP/+ryFMvSNhBg0VV005cTi6iykwgevIsZecQHz6W5Gf0v+slDef/m1elvSgRb4Bbb+NGq2vjiQMz+CRdOkXG5hsij3O0EB0K3qT63CE2xPj5QF/JdlWoe0V8VlGy08q243a0W2oyVcLrrVPdiQoAXG0VcYPOsXUjQJvjmFfzlz5KAQCLKldK7FvnNGnREJwnbCvDT5FJ9TlpZ5bwYzg+/hGoHy/o+dw/AWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnIJyvC2DwhVW4zxTcQzjlDkZ8To++1icC3TQ0mVDzY=;
 b=dXZgFtVSfdXpkZPHFLuWkVY5FcqTZ5xig5tI89dheSimtenLXPos5qfi3QRlas2kRdOBceBQJb9Syt2XR9SkGRZDG95VeBd852CCAJ3vCOQjgJSDWec5QenQsn+Gaiw8XRbhTt9vo3wwz0Qx0jbfjQFH2EBtdf5XuVNCYdREXpG9Zj/VuHxlJ7EKY0fm8qllj/jXv9GWVCxfiKaL0x1O2U1IATYurLqE9cUZrWoV9jQ69vftSXZRh+3RmzJYLvh1WKmmO4sMluHLJU/MiYNdXoisJMmMnv+XHH8kDyDPkVhUmBf5Z9vrGJ30rnAbhLXfxjDWmdOFuBRZVTY696+Xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnIJyvC2DwhVW4zxTcQzjlDkZ8To++1icC3TQ0mVDzY=;
 b=5CAYIKa1E/JmOte2b3BSu9+jlP+Th5xBf21YA48mgwautEtvI6jkTcc5zfIOP44MtK4u0XWPk/B5iCeGxCXx5ths6IOb6Gv+r+IoekE+s4eMiRfOokXEfkgXLyWYkZwTXIZVOXlpEMNnimz4n/wvWOmpdVXJDvDWnlXF0Kvl4GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 14:40:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:40:24 +0000
Message-ID: <929aec0d-690b-4277-90b0-d0b4adb437d3@amd.com>
Date: Mon, 27 May 2024 09:40:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: Fix the inconsistency in max
 frequency units
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, rafael@kernel.org,
 ray.huang@amd.com, viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: ananth.narayan@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Perry.Yuan@amd.com
References: <20240527051128.110091-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240527051128.110091-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b28770d-290d-4d9a-f656-08dc7e5af174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW9RS1Vxb29ReGFiKy9RbEhGZWdaUnFUMEdOZnB4Tkp2MU1Ock51b3FuMXVL?=
 =?utf-8?B?WEhaU01KUm5JTXcvdTd4bHUzTVR1dHFqcjhrUnJCampLMmFtNGVjWmFzNVFF?=
 =?utf-8?B?cGs1ZTkvdW9sQ29zb1VtVzQ0TEdRUnV0S3dSazBHbGV4ZnJENU9pWk1OWjFj?=
 =?utf-8?B?MWxkOWFsa1VXSUpCVk5QaTZFM0NjWnMzczlIang3UHZGZUpFTDdXc0h3L0Jy?=
 =?utf-8?B?bHN4QW91UHA1Qkpac1hFUGhwODVMZFQ1Y0RpWnBGV2haWkJtNnE2TUhPSFVJ?=
 =?utf-8?B?bzJwNFdBVmh1QWFsOThtMS9jczgyd2JFVS9zUUJxS1htdVdjT0hUK0lyZEd3?=
 =?utf-8?B?TVF4cnZtOHYzVjhXSU1xdG1aYkVYU1pVYkIrSUNRQlFuR2EvU3JtQytXOHRj?=
 =?utf-8?B?YS9obnFYcDhkdXJDSmQ1VXVCUExxbjVKZ1dKOGtKWHJWV2JjQXVaSjZ4T3RZ?=
 =?utf-8?B?N3h4c25MZUx1K0xBcllLRnRPaGVhQUhrNUVWUVNQM202eHNBdDY3SVZhclZu?=
 =?utf-8?B?bUtPdGZiWDhPdFVKUzUyOHNkcVh4SGtveFZhekJnMGJYSndaK1dRdE0vN05V?=
 =?utf-8?B?cmVqUmZvSzZESzVIS1VNS0hONklERTAzcTJIYm51ZUNweGJzbXBOT25OY2VB?=
 =?utf-8?B?ajlXK09pd1BTWGMzTTNDdjkxVmVXWHdhQ2N3bHNId3dPRGZqcnd4NUg1RU9L?=
 =?utf-8?B?M1RtN3pJV09vdnl5RWl5ZmxYOGgvZndmcGJWM3hTOGowa0w3cnFIV2laYkxI?=
 =?utf-8?B?ei9MUC9acnp3U1BORFVzVlFXQStOOXMwbkMzMUttSEd1OWRPODBiQjhoWTZm?=
 =?utf-8?B?Wkg3Ylo5MTRLcnZvTGNkRG5BR3BMWlRqYVhCalFuNjl2QVhjSnJvRjl1dm5I?=
 =?utf-8?B?WU1nYk12eEFTUHZwWG9mbGo5ZGppSExYRmp4cnlhb3V4VnU2dDZjQS9ScjhR?=
 =?utf-8?B?TDZVdVptb2N4amdSUFBSZ09PYnl3N3NqYktIV1ZDaXB3WnMwU08yVUw1anZy?=
 =?utf-8?B?cjNSNXc4Rk9CajZyRi9EajlHVXBtS09xdDJhcDNBU3NxZGsyWXRhb3JmdjNZ?=
 =?utf-8?B?UkR1YlBHZk95TEN1UDR1ZCtpNHlNZERUMGNJTzI5RWM3T0ZvODBtdDZ3SENS?=
 =?utf-8?B?TUxmVjRaMXFmM1orTnYwQ1h5Uzh2RTBRaTZQMmZZM0ViNS9GTm9HeFBkd2tL?=
 =?utf-8?B?eXVjWGNCcm9WWU52MXc1aDNZWUlRdi9Qdjc3QnhEbmJpSFBOcmFTemFRczR6?=
 =?utf-8?B?YkVYM3BUL0FVdVRXN0h2czZQclI0YVNNNEl3aTZGSnVPTHJtU2dPL2ZZbWZC?=
 =?utf-8?B?MGR1TThRdjdmT2NmdVpHd1ZwOGdyQkpJc0gyb2FOOGsvcUN2aWVjWmJZbG5s?=
 =?utf-8?B?UXArQmJXQXVZM0Y1NkVVT1diRWo1d2N4WGhHN2E0d3ZFcEw2MzlRbnI0T2hT?=
 =?utf-8?B?amFhd3lLVGwvbUp5R2M3SGJPRGZhWTY4WXk4MkprVGRnRTB4VHUxdnJWdnB2?=
 =?utf-8?B?RGRlOUVSUnRzWGl4VXBkRmE4VkFOd0ErcVB5RnFNV2NqQkRiRFZuZ0taRVNx?=
 =?utf-8?B?TjBQUTRNaVFpeEFQY0lSc1hTZnhVNExwZ0pRdjRxbjgrZUwvbStPS2lRZzlq?=
 =?utf-8?B?RjdyTTFoMmp6YWUzYnk5WVVmSVcwMlFFdjlMK2tXV0Q4TlhTb0l6WTZiaFQz?=
 =?utf-8?B?VTlhVVViV0gxQUVDbUNOb1Fqc3loTnVqKzVZcmUyL29tdXZTSnZLRzR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3hDWUMxN1JQb0dETmNqbUw1TVhWdEhyWno0WHpUOUIxNDBsRG1nZmRqTHNZ?=
 =?utf-8?B?ZGdsa29abEtDUElkd3FuSEw3a21PMUlNS01UMXlQckVxNld5aU02Vlp0RGRJ?=
 =?utf-8?B?TksxVDJHUHlqYkQ3UGsvWWJwTVJTbWFYOEhwQ3ZYak81YUlNSHl3emVGWDVw?=
 =?utf-8?B?UHFxOTlXdUNqNW5yQVV5a2hpQ0ZKb0tLQUpzaXNuRXBXRkRQUjNzL1ViekRN?=
 =?utf-8?B?T0lROUl5ak10dE9KbkZRMGRQYXY3ZFlvaUlXVE80OHZUUXNCa3FJbUl6RkVs?=
 =?utf-8?B?Qy9BSTY5WWVZWWlWUjIvUmQ4MVR6QUpIMjVCdlVOaFlwRzZ0L2V3dmlZR1ND?=
 =?utf-8?B?Vmh3bjZnSmVUSzNPODJoeXlZdzJBTzRHdXNCUmhueDVQUjAwMHlxaUh0eDF4?=
 =?utf-8?B?OUpWNTcxYnl1ZkQycE5ZamRKamtTVnFaRkVqZ0kvTXdIU1A2UHFoMmw2QkZC?=
 =?utf-8?B?NVJnVXNNU3QrTnVGUEtjSHRQVEVMTGFsT2tPZnFiNHFYZ044K3RjQ2hSbVpI?=
 =?utf-8?B?UkJLdzQydGUyZlhBTXplai8wSTd3ZEpIbmFaU0RQbkpKZzJOYnZScVlRZkIw?=
 =?utf-8?B?aDF2ZXRwK2EveGV1empnaFdrRFRwWG44em9BWlhiZ1lRVVR6NSt3bFJXR3Jm?=
 =?utf-8?B?UVZmeTNIa1Jza3hjVlNBV2czVUl4Mm9DWDI1b2RUUGdWWTQzd2hZYXdmZ3Ja?=
 =?utf-8?B?MFRVUndKTWxYMlFjeThKdUE3NDh3dUFidlR5ckRHbnV6bUVuekN0dGF3QTlJ?=
 =?utf-8?B?R1hHT2NQb1JMOGdhb0lsTXJ5MUtORnJxdGxSVlFMZGZ6WVhERVJNV2pZQVB0?=
 =?utf-8?B?RDBFdktyclVqbDB0cWFlWjN1Rm1Tc2x3UXlDU3RMQUI2dlNhRU52QWtZNVZK?=
 =?utf-8?B?ODROa2dKRmpjdi82ZXVOUjdEYlAxeFBVU1M4NVJTOFREaTJ1YU5MVElPcm9O?=
 =?utf-8?B?WVVmQVVJdVA1ckxvYW9zOFZPT1huQmdVRXR2RWoyVlRmYW9wM0hqT1hteTNY?=
 =?utf-8?B?Rm5tVTZ3SUhtdWZVWHUwa0RCM3E5QUdzU1RPRWdiZElqb3pBalhPY3l0dEZQ?=
 =?utf-8?B?K3BTWmIxYW9YZ1dBNWN1ek85WldUOVVFbVdmMFU4dThQQmlyeDJBYS9BYkM4?=
 =?utf-8?B?RytwR3pwaXBaQUxtM0thbWFBcEJFVTRUYUg0REwvd0xwTDdzdnBaQ2lUSCt1?=
 =?utf-8?B?N2lDRmVCU3YyVmZmaDh1aXNUaGsza3RpYWNhQzN2c3R3RnRWbU1oN09hUU1J?=
 =?utf-8?B?Z3ZtYWhqNkJNRWR1aC9VdVZBbjRNcWozaDlkcXB6THpVUkh1aGNGRFUyeGFa?=
 =?utf-8?B?OTRTamtEa0o5b1hqQk5kWU1HWCt4TXl6czV6R3dmK1hySDJsNG9QUXJENFlN?=
 =?utf-8?B?TUxJQk9wS1Y1RlVDNC9UYnI0Y3htQWM2MTZWSU83VERsdi9OMVlPOXNETFVq?=
 =?utf-8?B?L05VODUveVhLdCtvSm1zeUY4Rlc1NDQrU0g0a3M1UmZOUno5K0E4c1p6MW9j?=
 =?utf-8?B?WWhxNGJNSDUxMi9QcjN3SlZKdUxRQ1JwTlQzOWIzYU1Tbk5uMGlORmdCQ0xX?=
 =?utf-8?B?RHZWRWtldEFFZFp2RXNmOTBVcVRydmVuOStSKzFyL0hENmRIUEg2NlVoZWNm?=
 =?utf-8?B?d1ZNL3hRcnhEeHg3UjFmOXpqcm0zWTJicGhCSHNkNi9sNTVDc0V1UEM0VTl4?=
 =?utf-8?B?SWFSUUJPQzRqZGVwQ3o5Ky92RVQxcHg2UXVIM2Q2M0FpTTZHTytrNVpJejdC?=
 =?utf-8?B?M2ZPU1IrT1k0Uy9WTEJYQWdJY3hoUXhpTWVhV01JWjEwQkJEWjc3d1JtYlFU?=
 =?utf-8?B?MmgxTmJORGxMNUpzcGQ2T29uWkk0NTZnd3krWitid1R6QjVjQjUydEluNUVu?=
 =?utf-8?B?VHdmNGF0VzU0QitId2NLM3NXSjF1OGhSZExRN0JST3FOUVk0RUVTS2dUUHZs?=
 =?utf-8?B?UTJiby9sMnJTbVZ4UW1VMHFMM2lJTzcxdkN3L0Z6QVBtYTE0RDUvd2ZtYVNY?=
 =?utf-8?B?LzNmVkxEczNSR2wvZDU0aDRtRVJpRmVEcDV5Y1BwT21XQ3JMaGRraTVqQXc1?=
 =?utf-8?B?T1NwL080R0svWStXeWRjWSs5ejY2WG9zUk9jYitTUHc3TmFNa3NXQmx0NGRZ?=
 =?utf-8?Q?O6KrMcn41iXoan7poLc+oEdkg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b28770d-290d-4d9a-f656-08dc7e5af174
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 14:40:24.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWfjOFEjbszk58CycjOzcqAsrMGokgFCKaWpx6TApw+Og4L+Y5r7INeU/Zy61acNjOqGCvIkab2HEyo45uFyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

On 5/27/2024 00:11, Dhananjay Ugwekar wrote:
> The nominal frequency in cpudata is maintained in MHz whereas all other
> frequencies are in KHz. This means we have to convert nominal frequency
> value to KHz before we do any interaction with other frequency values.
> 
> In amd_pstate_set_boost(), this conversion from MHz to KHz is missed,
> fix that.
> 
> Tested on a AMD Zen4 EPYC server
> 
> Before:
> $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
> 2151
> $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
> 400000
> $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
> 2151
> 409422
> 
> After:
> $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
> 2151000
> $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
> 400000
> $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
> 2151000
> 1799527
> 

Cc: stable@vger.kernel.org

> Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1b7e82a0ad2e..cde3b91b4422 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -669,7 +669,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   	if (state)
>   		policy->cpuinfo.max_freq = cpudata->max_freq;
>   	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> +		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
>   
>   	policy->max = policy->cpuinfo.max_freq;
>   



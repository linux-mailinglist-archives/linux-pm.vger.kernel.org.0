Return-Path: <linux-pm+bounces-15519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786BE9999BE
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 03:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9161F247BA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 01:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA77EAF1;
	Fri, 11 Oct 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLmIPVYY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25741184
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611071; cv=fail; b=Y21NBnqtFgmadIAx1AYlvFixQCncqut0oVGDE75yAzCs3iTMUYoNZzVGIe7VwdCgjsXBFeqzk6SW2wutp7F786eJirGJpsGWH7nUgTQb0T7CYBLkyus8DvhP94y8NpUA5hO90VR5Q4fiPa1iQBP3CoL+Sc9z1rYvAq6dIyGnBBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611071; c=relaxed/simple;
	bh=ZfMDHFiRDGWt9NfReyzshC06HUcARAm+Yz3aj8laFPg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=mzGAqdWfPH/EKayGrGf92eQf+/f+eQBbyOQqFvcqNB9vKkZz/7wJ7a3qwvqPilE8wQN06bE0ZYXHHSP7azwNRzQsWmHNL0qGRZyaoy6T8i3OA4OMXVH1a3p1akNYqQGmb4Qp6vQ2IGtNgEoRtcpJY+MvG778V7+gJ3L0qzHd/YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KLmIPVYY; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojZSkssz0VIFoDMd3EkMQNOErI0SC0Igin7n20WZjbLVEW4jkPe8+8ac/ThYC3d2i5MCXK8zAlEy7fd8WydVD3u9kzNPIUeRbv0RR/wmBw5MOf5VgAI+fQ8UwSwiNa7ee5m81BsHRngnZheoH5ZdlVP5r7LR9jqEicxPIa3DwvskNCjDwWPtGogqKrMMZUjiK4yUmO+VydcOOBwIr7RRLZaSnWjs7GKgD01GDUHPrElg9daWiGWORKSwhlri8GApFYZfM44DUvw1HqBUn5xoFRVSzKu6+r+6mo4VgHlqS2oMeZLcM62Kb/dX/wHdHZPSUyXiRzhgcCrfxFuGRY2u8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVeO5bfAFx0Kqpgj8/QG3ENZkUWkm/2/E5djsWTMZHo=;
 b=Ny5+oGGcuslJTUHSzPiA2QP5XxdHibmqF1WXKG+KX3+k0EruhyyzPKrD49jNiA3pLRfEQbHiJAkE42l2mJ0nMmThhySXoxPx0yxS3d5fHeDNYq7umCgvQd87wM/LgkG3IPeV3Rh9An2wLCW7YwebgAf5ox4wrVozm+qHrybnlDDhSenvMsGf9sxpoKklTGZVhWgtYpQ2kRCnlNyvBUo6T2zxN+O4aonc1d5J5djxcqH92es4oeKNrnsHB8kcl1v4478ZIBb6k0DqzUqv3dC/hOopclZIh3PxS3o4+W9yWDnAolVXBSo01lpWDSyMr9+tM7XffDv0jV99DW8J/Ye/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVeO5bfAFx0Kqpgj8/QG3ENZkUWkm/2/E5djsWTMZHo=;
 b=KLmIPVYYCK23F4nEMcsfkYIphLmCS1QMFy5s35DTmxH3FUEYYaI+MjLAQW2jmbutgLS3H1/Wmb3kh3WkldAvfmBQimpeDGLG+54vxk1XzAfstuw8qN4Jh/4iWpmG8Fiie6XXvn6qgGCIm1vw5iXzfCV1S9Dl3YzS47U17gsaFT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 11 Oct
 2024 01:44:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 01:44:27 +0000
Message-ID: <03f55e79-c1b3-4f2b-af96-6b64b170866f@amd.com>
Date: Thu, 10 Oct 2024 20:44:26 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: new amd-pstate content for v6.13-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:806:120::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 362a4880-e6fb-46c0-4788-08dce9963e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmtHcUU0K2V2L0kzWkwxN1kxTXBjU21waU4yV0xNTVNpeUE1OUw4YS92N3hX?=
 =?utf-8?B?RGQ0Q2JqSjdKUUY3RHoyN25tR0RORkdaUUNkcG82SlRPQlZMMlYzMkE5OWR4?=
 =?utf-8?B?NGxRZ2JoWVJRSkVSVStyZ2o2TFppMUNJRW85Ty9WWHBURkx3WEwzRmg5ZUw0?=
 =?utf-8?B?THB1ZTFlSitCU0ZSTk54YXdzR2sxR0F6cEd3Ty9mSlJCZlE2a0JmQ1lrcGpu?=
 =?utf-8?B?VWN4c3RYQk9rQVJkbWtPME1iT2JJMlZFRmVGaUN4dGNCM3lzYm45d3oxUHBS?=
 =?utf-8?B?amt2Y2tudDBmZnRPanN3RG9tSWQ1b0VjYnZBRTNzNTV3OUxRV1h6Y0JmMTZO?=
 =?utf-8?B?bWdZNldKRHZVaDh4bmhRUFAxUDMwSk9URTNWQlA0d2ZEYTdtempnaHRrSlUw?=
 =?utf-8?B?VUdnRXJJR2doZXdLbGNMbmpqS2htYitFbUY4M293MC9mbEVTVGhxa0Fhbysw?=
 =?utf-8?B?VmNhNkcvSGhVd0Q3UEFyUW16dlQxMmNuZDZ0c1VwTHA3bmpHRmRCVmlqL3pL?=
 =?utf-8?B?Q1hML0RuV1I5Tm8wY3VEd1JNL1JITGU3aXQ0N1cxeTczS1VzZ0U3N0ZZc2RU?=
 =?utf-8?B?R1YrSU9pQmlMSHZuZnFCRXEvRGFDUGZaNnMzVTVrcXFiNTd4TTZLcnk1VzdZ?=
 =?utf-8?B?Q3FhTTZqL1lPMnptU1YzbE1ONHoySU9LZnptdEYwMDZrSkYyMTBzbExuNEhZ?=
 =?utf-8?B?MDFsTlNrdFhoalF4WDNuUWJTMGhSQ0xUUFZlcFZES2h0eXhIQTAxRHNMTGZ0?=
 =?utf-8?B?WlJyclJZMjk2cGdzdEtBYjdidFRKVzIrTlY0RU5KRTlyRVptajhRS0VxMU9N?=
 =?utf-8?B?d1dBaktGTE5WVmNoRGFzOWxRVWk2WjNqVkRaVUhLem5vT1FHN2V0aWFBOGtQ?=
 =?utf-8?B?S01hZmlVR245aU8reUxockJZSEw5TVN6TElXeVpIQW1SWHBsQjI3MEx2S2xj?=
 =?utf-8?B?MDZCMkpJaytHSTZjcjRuT0FEbUVmbkdZZEtlNlFoQytQdGVqQ2QvWFBnYXNF?=
 =?utf-8?B?Sjd5R0lVQWhaaUlpd2NkY3dHYldZSERnN3l2dXJzR0lMVGhxb2JXa0ptdldD?=
 =?utf-8?B?bythM3JiV21RQzVUMUE3bW1aUXU0Z0l2M3NvTjlvbzBFQXVXenlUMkNJdDBD?=
 =?utf-8?B?SER3aVJkdC8yTzhJSUU0ZUxJRGUyYWJ1TlhSN29JTXNycFdVdTZvUW5weEFZ?=
 =?utf-8?B?TEVGTVcwcURFMTYwdEVqbnJsUFZ5RlZLVHl6ekh2K2Y2enk4VGFhS21jNFlk?=
 =?utf-8?B?Tmh1R3QwWVN4emVMQVVDOUtCSzFDQ0dLak8rM3ZPNWo4L2RZWXBvc0xWMWZh?=
 =?utf-8?B?cW8vZWVKT09QK200T2I2NWsxMDBsWnNqQnNHeXlYb09xNDZaZ0MydmRVRFpH?=
 =?utf-8?B?ZFFVdUVjRmRYZm1MUGhWVXQ5WmtkREJzUW5TVXBGZjhreUpBY3NDMGlhT2FS?=
 =?utf-8?B?WFkwVlRTZEdvSFM5SzIwVUZmWFN0bHBpWXRmbDJRU3Ztanp5SElRZmkrNlNE?=
 =?utf-8?B?WTRmMkZURXBtaGZJUFFSM2VybnN0UU4yQkpGNEErK2pUN3ZZOUt4VklYb1NS?=
 =?utf-8?B?OHFlSHdONTNSVnFwWEpOeC81QTQ0YncwVXdpR0NQRTdVdEFpK1FHWmQyNWNq?=
 =?utf-8?Q?5uZgKdbUCb81wcdlyC3CDT+LA3mWEUjOP9ZKW7DQPc9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnlTblVvQU1pT21POGZXcks4WTlpSFRNRUxPbStPOWNCb0pJNVdGOWVLc0Q3?=
 =?utf-8?B?VmFGUWlMOXdSazlNSlJaUXdJai9DQVdPeWhhcjNMWlBtVjZsOVNydTVjQm9k?=
 =?utf-8?B?WkZVMGRzczJMR2dab3J2VWlQTm84RlFObmRmakxSODdHYXdXWk5WNVVDaytj?=
 =?utf-8?B?eE8wVkg3S3hLTUNBM2l4T1ZsWVdCL01wSnNuV1k3eGx4L0NtcU9CaE5Wb2RB?=
 =?utf-8?B?TDZzU1NHZWVuTU9DMjZKb2NneGt4aWM3YWFEUG1LbHJzS2JPRktia1dsY09z?=
 =?utf-8?B?SlpkR3pQUDZ6WmZCUzQyTHdQLzMwK1EzS096ZGpOK200TXFid0h6dHVaejNk?=
 =?utf-8?B?TDJHeHEwZWRBTjhWam52WmF1SWFWTlRsZE1XcnZuNWJyYjFQZnB3VzVCd1Zm?=
 =?utf-8?B?cDBVTUpwY2lxVTNTVWoxaUNoYWd0cCtkRCtxN0R6NDg0aitSNlBJbjNlNi8x?=
 =?utf-8?B?eTBSWjhaSkpJQktNMkRCVjF1akNadnRDWkJxa2hPVGkrZFlPZUFOdnpMd1BE?=
 =?utf-8?B?bGNua3lMcWtSVXdIK0g0aSs5TlJ6OC9GZjZ0RHEzZWE1RGxTWjA4SUFweXAw?=
 =?utf-8?B?SnhlQXBMUXE3c1AySHZLSlRnbWtJeUNzeUhiREpLUkdWZGtuYmRNbEY2M2ty?=
 =?utf-8?B?MFhqS0Z4TktXZHVNckZ0QytkdlNKSGhnVjFndmE1L0xjWGV5Mk9FZmV5Z3lz?=
 =?utf-8?B?eit1MEdKVHdUOUY0aTd1UWt6a05qZkh0N1FqME9VZC9kU2dGZER0bVM3KzZM?=
 =?utf-8?B?eUkwSFhjT0p1a01OdlUwSFZJNzBqUnAyVEQ4bnVWMHpkRy9sTWNQOGdQR1VU?=
 =?utf-8?B?KytYdFRnTUFaZ0dxZlBvZUdJWWxMbTRoZlB5VU9YUkhmTHczL3Q0SjNYNHdr?=
 =?utf-8?B?dGN1MmlkNWIrczBPa1JVUFVLcjROelloRWxNaXRNRFQxZ0dVMDBQU2xLMEJY?=
 =?utf-8?B?QkcyVGJLNCtvMnJDdXdKTWxkUlRUQnJsOTFrMS9XeTNGbFFkRlRwZ3l3YzBW?=
 =?utf-8?B?akwyT0t0OGZpUkFwS09JWHZzSVVKMVBYcmhaaWhmbWtDdjZYMGpoUTdwSjA5?=
 =?utf-8?B?NU9xQmNpWkhjNnBiRmdQeXdKTEx1di9zcXVIZ1kvQmxhZnhtcXFkaXEvdmor?=
 =?utf-8?B?bGVFMGh6Vk1EYWJRdXRqaDhZUXpNdU9xOEVoVGlMMVZiaURVb20yTFV5dGtZ?=
 =?utf-8?B?QnN6dC9Bc2xOK1pDRUZxNW9sL1o1N0hLTlJyZUpIdVhVcGZyODlTR3ZtRk92?=
 =?utf-8?B?U2ZPSEJPenM0TFU1VENrZmZISHU1SlBycEo5NUtkNGpPK0wxdXR4STByQlEr?=
 =?utf-8?B?d2pKakFhYUJqZGlnMFJjcXpLa21TUGtNYTFqZXluNzFBVU5SQU9ZR1AwL3pt?=
 =?utf-8?B?WThia3l0R290T1YvZnFOK0MrbG01SlZ6bHQ4N0FMcFV2MFVpVW80YUxjcC81?=
 =?utf-8?B?c05FUEJtbHpsK08wcWNOTVVsQkczY1RKb1dYeXEwUzdHS0lBcWhtU0lPcGZj?=
 =?utf-8?B?aDV6ZFJkbmZCTHQ5dFdvR1JYTHBLZFRjZjVHTDcyczNDeFRCRjA5NGE1Rkc3?=
 =?utf-8?B?T2pIZmF1K045RllRdUkyUVlxd2ltaW5RNFZLcHBCZ3Zadi93NHdEVkhZQTJK?=
 =?utf-8?B?d29uZC9kR29LTHZCY0JzSkxwZ2NrTFFIMU1qS3pwdFdodlNUOVk0bXhrNW96?=
 =?utf-8?B?d2N1emFQUFhEWmVDMFZuSTlSK205N1NDM09JQThrQ1VWVnJ0ODhyeUdsb0Ex?=
 =?utf-8?B?TGJkL2dqTzg0NkdKdzVvSW1NV0pUYkx6N2U0UXhTbERRSFBHSkwzdlIvNjdp?=
 =?utf-8?B?WnNDaldDeFZEOUR6MlZQSnV2SlFLTkZYYWtTR3pVUlltcHc1akRreVU5ZFZU?=
 =?utf-8?B?TzNhcTRRM2hnWTZSTUVCY1hCVXZaMFpHYUNCZDZLU0tUTC93WlhWRkhIaXpM?=
 =?utf-8?B?d084aDFvRkpnN1RHTkd4djNvUW9sYjFndWZRNEEzcGR6YklEeE9UK1Vqampm?=
 =?utf-8?B?TzZOc0V5VjN6M2c3NXBxbkFLZkkyMU1hd3NwRVhZRmF0UUx3S2VzUnFaYjhx?=
 =?utf-8?B?YWtUU2JrclByZWVrWFZRZ2kzcndIN2NabmU5YTFIMnNPU3JqeHp0RWEvekdI?=
 =?utf-8?Q?otqDFJSA89ID94FrgruKVeQTS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362a4880-e6fb-46c0-4788-08dce9963e40
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 01:44:27.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6fFa29XYmPxpPs06oeS3h7upRlN3VlGKVnHtKWr3qhEDMaNJtp8kcpzoCU9sni57ULnZX+DUlZ6EsO55Xt6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

Hello,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.13-2024-10-10
  
  
  
                                     for you to fetch changes up to 
57533bc760ae012eefdac53fb8e1eaf3fe4291ec:

   cpufreq/amd-pstate: Fix non kerneldoc comment (2024-10-07 11:32:40 -0500)

----------------------------------------------------------------
- Fix the determination of the boost numerator used by the amd-pstate driver
on AMD heterogeneous designs.
- Rename functions in amd-pstate to more intuitive names
  
  
  
  
----------------------------------------------------------------
Dhananjay Ugwekar (2):
       cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory 
systems
       cpufreq/amd-pstate: Rename MSR and shared memory specific functions

Mario Limonciello (2):
       CPPC: Use heterogeneous core topology for identifying boost numerator
       cpufreq/amd-pstate: Fix non kerneldoc comment

Perry Yuan (1):
       x86/cpufeatures: Add feature bits for AMD heterogeneous processor

  arch/x86/include/asm/cpufeatures.h |  1 +
  arch/x86/include/asm/processor.h   | 13 +++++++++++++
  arch/x86/kernel/acpi/cppc.c        | 30 ++++++++++++++++++++++++++++++
  arch/x86/kernel/cpu/amd.c          | 29 +++++++++++++++++++++++++++++
  arch/x86/kernel/cpu/scattered.c    |  1 +
  drivers/cpufreq/amd-pstate.c       | 36 
+++++++++++++++++++++++-------------
  6 files changed, 97 insertions(+), 13 deletions(-)


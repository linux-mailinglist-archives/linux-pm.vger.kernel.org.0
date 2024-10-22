Return-Path: <linux-pm+bounces-16261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C19AB809
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EE5B23035
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C71CCEE3;
	Tue, 22 Oct 2024 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yTzjU/kH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79451CCECB
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630478; cv=fail; b=k6TXca3jYaapmC+G4OAAz7laVrPDnRh13oqVpWw1RDHG7H1cSXEtPwU0JQF2Vfsz49auHNhq0SguXuNSqmwKgQok83flzwQGaP5EFsc2n5EqmTTEu/KeD0gGg2DVysGJjlLbWjZ75pyVxW+eNWG9atogH5gYXS+2cTKuBtp707w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630478; c=relaxed/simple;
	bh=Fjyu7fY9zB6++jvckYDFefYpog/RcqBrUyeCZLVrbuc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=NIUrgMl7VCWfJuketkAiCIZCsyf/+sOafbaS3Ic+3SX9eIwrdjw/9JM7AD5nU7u/O1y4gQgWkVwagyzFvX7r3e67mI+dXvZPIKszjlF8UGc4lLiWcKuMluQKQqD7WhEo9C6CNqwN9fwYpbV6n0Wg0unjMf5CjV3i4kLM4+LSWsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yTzjU/kH; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFQoSBr1FGjMTL1vMD/2DPkVt6aknjyzakuTumzvb5SbFg1IHFg/8DLluQIf4tJfLdMeWovEKcqDtoGaa46GZ1Z5cczM1jlgzK2hX4gx2EXpnHqK5w/ebxQwXkMOhTRgPt5UabPlPOLpOE3ne+AYZk706g9K6vxumm+rTMuNcrAKf8cSOBKJMKepf2a0kpsH98NUBqNQ/E1RKiChUhxmtdajPVxshk7o7aUhGlJ0gdnlSsGYWdQ4OTas3ZYRmlarhs1R3I33MSlzRVd9/Z5p4AL4tXSQVQfka26/hP/OyJbVMJHRxuu129cPRNdiMBuR5R2JJz7eIsGaXBbPDCpB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5PjAcQ9JbbyexCUBBgDJxJ1jZh2WvioHh/uD8UHPHc=;
 b=hrf9hsmTiqP/bI3fkZtTKdGUsUJ+0Cad1KHp51Bs47oerYLwQ1XrzKEloKmVJi2XtBszIcTDLZPkuig/IeMt9TP3CGYwevl3OhHpECmwanO1eXqmspjpjvJKAZKTgJlQG539OQ3ps5HN2UVvMd3aTCECF4SRHNYEDvyJlViqEYhRz2aC9/m1clxGIiedJzbxh5qhr5CQemU6lWY/2XgdOZSn2EbLUGjiMwBji0LV7Lvt8+N0bXdBAwhzYnxv3QPqXNMSGmJcyNL4XoBOYp+kHFvj2aA7qmo7YeWZiqFxhYBVkJNTskCa8dkYEuEpgMskDvr4bd2cL7oQ0vIahqTKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5PjAcQ9JbbyexCUBBgDJxJ1jZh2WvioHh/uD8UHPHc=;
 b=yTzjU/kHTOfMO0nvnNkP5EAaeA6HEUEwEfRnWw9dmU6znFpKUdz7FqKxv6dPwz8cee6YCY2WwCMKem9fMEML+4MbRIkCqmrgOWFQC5PQg+BJIQkE4/JwBt1vceJSiBqswmCcvZt4CzyIXR92MwAU4kOMk8LiY31jJzhZOpKfzNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:54:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 20:54:34 +0000
Message-ID: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com>
Date: Tue, 22 Oct 2024 15:54:32 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: amd-pstate 6.13 content (10/22/24)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:806:122::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f727adb-c37a-4595-1d41-08dcf2dbbb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWUvSGI1WmtnM25jVFJXS1RJMU9NdFRzU1AyMSszbkEyc3RCeStwTGNCc2NY?=
 =?utf-8?B?UkUxbjlQSDU1NnBscUV4NWttV3FWelNSbDdkWFB0N2R4UmdzdENvdmFtSTNw?=
 =?utf-8?B?VmQ2STlGamJNQ3ZUbHFQY2RMMmxGb0FUaXRHMDF2eGNDZzlCaWcwRzdZcTdw?=
 =?utf-8?B?NUhnL0hVNlFqMTZtdnlKRkNiMDNRY0h3VTVIN2xkdUJnMmdRRGF4cDFleGQ5?=
 =?utf-8?B?SlhkbmNNZFRhd2xUc1lYWmliRUt3dlhaS3JkbkVHclNTRGYwc3BPcEdLQlBz?=
 =?utf-8?B?VEZ5cHI0azM0b2ZNblVLaXdnWVFwZFNiN1g2ems3QnpOTFZqUDczd1RwdWs4?=
 =?utf-8?B?MGhzRFQ1em92OWYvbTdJSjZObUF2MndJZTA0U09NYzZISjB2NzZqWEMrRHY0?=
 =?utf-8?B?eDZFcnR1K0hnbUVYc2lFSHl5Qmt6S2EyS1V3cWJtdlRSMjQ4bFJDOFRqMk12?=
 =?utf-8?B?MWhSTzdNbXRHVEFyMjVWcTBkWnJlenFxM2VZK2Rma3BKVllkcWhvMlZqTW5W?=
 =?utf-8?B?cnBCeGZLZk1WS3hPVWNEa3dZaCtOUGVRdXR6TUVWUUNHN0VQS29WMFB4M0Za?=
 =?utf-8?B?WlVYaDJxVE1McnVQb1M0SDV3NHVUeWI2b2RDTTZpcFdrZWhyeTRkNXNmTDFR?=
 =?utf-8?B?WjRQUXlBRVZ3Ny93OTUvNU5WOU1DZGpFNzY3OTBWcU1ITHpNcVdHS09xdHh6?=
 =?utf-8?B?aHNrQ0NicUN5bk5laTQ1QWVSS1VlVytUbERqcG5VYWZiRGovcTBZQ3ZuU1lT?=
 =?utf-8?B?QXB1MW5YTkRGMW9rZ2toV0VObFJmRTluWk5SRjFpLzIxYXp3ZjNuR0tudDBy?=
 =?utf-8?B?WE4rK1g1TTUxQmh0TVlxM3VERDExcWU4WWNUVm5NNTBwL3REVGhYVlc0Mk9E?=
 =?utf-8?B?czVJOVd6UnRkMFVVV2F6eTI4TGpWYlFPQmpvc1RYL3gzVkFOZS9KV2dxczVX?=
 =?utf-8?B?U2dqbjlCbmQwMG12cUpITERMSVoweTlOTEhvT0xvSWFxdUZXUGw2SkN6ZEdz?=
 =?utf-8?B?TjNXekx6MUpReFI5QWxKWGgyeHY0MnBLekNrSVZmSU54aWdid2ZjdEFOWjRJ?=
 =?utf-8?B?T05EV1hLTzhDRDB0My9GdjduYlRYMUMyL3BmQy9TVlMvcExtWlNKUHg5OTdo?=
 =?utf-8?B?OXBSZkRUNGZPcVdrYXdMZTNCRmNXaDJQOHE0YUZXSWoxYVkrUGFnTW5kYWd5?=
 =?utf-8?B?c1hjL3dLbjdQNzhmM2VvUVFoaTUySzN2Qzkvdjl1WDkxS0xGZWxrSmpxOGhN?=
 =?utf-8?B?cVplVEZFUytpSThUWk1aVEw2UmNSUUpDcnJlaXpJb3JGTHp4bk9hNW1UUG1S?=
 =?utf-8?B?bzhIS085aDlsbDNObkJXaW9seGRlV2FVcGxBcnI2elJjWnNUTHBoaXdGbUs5?=
 =?utf-8?B?aVZUVWtwWFduZnFPQ3hsVmdidWY1TzhacDlPaVVTbm0ya0JVamRtbHNoY2hx?=
 =?utf-8?B?b2JsM1JObnB3T1plOWxZYkpuUjRMQ1BZSGV1YWhEOTFQeTdkOW1ZM2ZKdGFS?=
 =?utf-8?B?VGZ2TE9RUlVCQkF1QmxFdEVOQysrS055c3MzUXNDQnNvdVE5YmRNYk1QSnVr?=
 =?utf-8?B?dFloOVRRVFJVcDQzUTZob3dVWjVnb0ZTb1JaZjNSWWNNZzdPbWw5bFJoSHYw?=
 =?utf-8?B?cThBVHl6c014U2h2S2VBR3NTM3dFVDBOS0dUU2h4NnY4VC9rYjdrWStzZGta?=
 =?utf-8?Q?mlptgB1xODo61LaxzYnP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmpZSHJ4Ni8zMkNZZkNEblpYRTY2TkVvRmg0VitLNGEzRHppM0ZZcXhEMC9Z?=
 =?utf-8?B?b0swSThtYStDS3RYQVhRZWJhaThwWjMxVjROeEdsNVBKR2ZCNytDQk9ZUDhx?=
 =?utf-8?B?ZXFlcmZUZ04wK1BqZ0pTbDBuNTVNNjlnREhUR3NnZkZuVnRweXdwbXlWTlNq?=
 =?utf-8?B?YnlDUjhjeTJxZnhPQ01kWGtGVWZWUFpzUFcvZHdWYWtIWEV5YWRKYXFhT2Z3?=
 =?utf-8?B?T1p4Tk5ldVVvODFla0lSeVF4aWE3cWZGbHZEa2NuWFY3OGFndVZHZTNPYXFt?=
 =?utf-8?B?c0sydDZlK1J1R1l3NmUxTVNuTlJYa1V3aVRzc2doT2d6dCtIdTR6M04yMFNX?=
 =?utf-8?B?WjhIaVFBa3d1TTVsaDNWRm02T0xjSEw0WHRWaXZEbGVnNEJlR2REZmpZbXhG?=
 =?utf-8?B?Q3JRVnhCOGJCdGlXTUhCMmdhRkFRN3JFNlNxbFkycWFQazVNTjhadDNlMGRW?=
 =?utf-8?B?aE5BSDdHbzR3RzZUeUs1SGYzV2tnZkxLckk1SkhaS0hSdy9IVi9DcGNTOUp0?=
 =?utf-8?B?MW54dzR0U3F6UGZYalNZZ0VtNEEyd1dpK3hxSUFJSlZ1VFdoWGl3T3czQ1hy?=
 =?utf-8?B?MmdzMDJ1L2NCd01zNW1lMGNFeUFTSDRTSXptdFRGK1BlUUdwMzNYd2xtSlV2?=
 =?utf-8?B?QWx4YklxM0p3bll1R0c1Wmt1bVZZK3c3cmI2a0Nad0tjaW5VRW1HcmYva2Rh?=
 =?utf-8?B?VlNDNk9hYXhBQzljNi9VVGt3NStsNS9EQ1g3WGl1RHFqN3lkdi82UFdNN3VL?=
 =?utf-8?B?d1A0MXkxZ0JrN0JlSGxSbkdSQVVzYkRWaTJZcDVlSVlkL3FEZWptNkNWTjJC?=
 =?utf-8?B?YTlvTGRVZGdTTW9LLzk0U3hSMEkxc1lLeEZLSWNRZFVJYjFKRGx3TzZYRHVo?=
 =?utf-8?B?T2VZNkhVTzRXYmNlV1RKU2pVTGo5c0k0cUJLOVhYR3ZWdkJMRk9lbExiY3VB?=
 =?utf-8?B?bXdzTldybVNEQ2ZsNll4eFk4RWpSMFNnMFRSQWJiSHBjQ0RYWm9mcGFxNmEw?=
 =?utf-8?B?bmtka0d5MnNlSjFFUlQ0R1dLK01vTFFxWnF4Q3FvN0VvSHZxWnJ4WU9WSHZh?=
 =?utf-8?B?bWtvWm5WTC92bjVGVllCbTU0RUsrTjBoV3I3aG9iU2NZUDVSN1dzcTBieGk5?=
 =?utf-8?B?UmJNVExxQkNoVDEvRTNrR3cyMGNxdDhUSmVvekE3TjY0aUFRbnFSenNOL0p5?=
 =?utf-8?B?TjBtRkM2N3N0eDBTSXVMT2JsOHBzMVRWeHh5RXp2N3NHdUhLMXI5MkhIcVlo?=
 =?utf-8?B?cTRFOHFBd1JqclhTOEJxS3BXWjlreEwvM1p2Y3VJcVlKcmZLWXZ3cmprbW9z?=
 =?utf-8?B?SVkwK2swaGNpRzJJNmJXTmhKSHFQVlVWWVY4dUpLMWxJeDJ0N0xsUzQ2Yjl5?=
 =?utf-8?B?RFVmVXNMYVY1WnBiM3ZteUcrZFJuL3c2NFAxTDRqRmdXQWtybzhYeGd5ZDJT?=
 =?utf-8?B?eUdXOS9oNVVGdkdpd2tzTFptRlpKSEpZZW9SVXVpTTNsNVNvbGlZTkhmUHFZ?=
 =?utf-8?B?d3MvL3Eyd2Q3NjZPZjI2ejdjelZnbmtkV1V6U2twN25COHgzN2NJK3FOSWpn?=
 =?utf-8?B?NkhKTiswS0JtNVlyUEJodTgrUUYyOFZ4cWU2WC9XMU1oNXFHMUN0bUhOU0xq?=
 =?utf-8?B?SjJVZ2YrTmRJS1dxSVJJODFJRDlBczhmSUZmQmJzeklNUjJoYkhOVVFycWRw?=
 =?utf-8?B?OHFUV0F0MkQwdk5QbDBoMGFueFl2SEV5eUFOVnRyb01iK1h0amcvdC9QM3lx?=
 =?utf-8?B?Uld4TURUSFJEVE9vdERYNGFUcnRXSjlpUVl3ZWhFSWpDdUlEc0QyRk1Ub0kv?=
 =?utf-8?B?NzdiYVJWZFZKSzVzMHF5Wkh4MG4rNzlkK0prM2FRRlBPZzBsTnhKb0hESDdw?=
 =?utf-8?B?dkMzanhxR1kxWEJoNGRzTnMrNzVpWVNIaGNMdE1JU0NKMGQ1aEZlblo5VzNN?=
 =?utf-8?B?ZmRoRDNNcC80RlVqQ1ZLY0ZwSkt5cWFXU2pyRHdSckJxSngrOFlGWjhwVzFI?=
 =?utf-8?B?ZXFoN3QrMWlUdkJhbW9hS01pVk5ZRTdjMnBLMFlwU1MvOGZGUEJvamFlK0ht?=
 =?utf-8?B?V001RTFwUW5hYzk3bXNSbmRJNWxtTytGdk9KbkRWTjRxVVIxRmg4Y1lyL0Nl?=
 =?utf-8?Q?ZPnbDDyXJSgJIsl+TEdifwIFI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f727adb-c37a-4595-1d41-08dcf2dbbb8f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:54:34.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irsXmgphFjQLT4MmtOfD+8bWDm7+WK4BRQr/npSErMHXrAs1LouumyRjawj6LUGjYDDfzbh0X6YT8ysklx2sYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Hello,

The following changes since commit 7f31183fa1d5c043864b4bd5632930f40d3c7002:

   Merge branch 'acpi-battery' into linux-next (2024-10-22 22:00:30 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.13-2024-10-22

for you to fetch changes up to 7027b415ff1a4184b99055f11455d5c7041aa3ee:

   cpufreq/amd-pstate-ut: Add fix for min freq unit test (2024-10-22 
15:21:42 -0500)

----------------------------------------------------------------
Update the amd-pstate driver to set the initial scaling frequency policy
lower bound to be lowest non-linear frequency. This will have a slight
power consumption impact but should lead to increased efficiency.

Also amd-pstate is enabled by default on servers starting with newer
AMD Epyc processors.

Add various code cleanups to rename functions and remove redundant calls.

----------------------------------------------------------------
Dhananjay Ugwekar (7):
       cpufreq/amd-pstate: Rename MSR and shared memory specific functions
       cpufreq/amd-pstate: Remove the redundant verify() function
       cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
       cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
       cpufreq/amd-pstate: Call amd_pstate_set_driver() in 
amd_pstate_register_driver()
       cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
       cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call

Gautham R. Shenoy (1):
       amd-pstate: Set min_perf to nominal_perf for active mode 
performance gov

Mario Limonciello (5):
       cpufreq/amd-pstate: Fix non kerneldoc comment
       cpufreq/amd-pstate: Don't update CPPC request in 
amd_pstate_cpu_boost_update()
       cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP 
limits
       cpufreq/amd-pstate: Drop needless EPP initialization
       cpufreq/amd-pstate-ut: Add fix for min freq unit test

Swapnil Sapkal (1):
       amd-pstate: Switch to amd-pstate by default on some Server platforms


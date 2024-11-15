Return-Path: <linux-pm+bounces-17589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D349CD5D4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 04:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE04C1F220BD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 03:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2714F9D9;
	Fri, 15 Nov 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpPFhdOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F953FBB3;
	Fri, 15 Nov 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640939; cv=fail; b=V7CKZHVJIgA4A5JjM6bkKA1ttyqeBwG2fJkbAmLMld+4vJt3h/fr/wz1w1s/l0w7DcG70KUpIzGaoXaB0JkPbW1egW2nLI7gfmZj7v8ixdGgi+e/eoiA+VC31T6oJEe3DaHgCOhdp/diGcPmm9w3kJ0a0LRMreFcfI2y9kEFgew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640939; c=relaxed/simple;
	bh=SkqvXgGZPHx/up9ZCZsTz8ijSiQmIa+9+usf0b5ghIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueSno9IMjjGVzerHzxv63suLA4p72SDlMBhGZn0JWGizc9Jya0Xkb3bntleNe70wicqpu4e9gfNdtUna0i6LUe7i9aHddtgFI+CAKexZd+5GwbxaPfm+JPkXtQAKLEtBvvHQAxhqpkMdmt6S8WMCAV/R0XaqYWsGXViwF999vnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpPFhdOO; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuI4wikyCrePIxne63PsyBP42wJSUKX9M0b3/3QK22vOzPs/OHtVesSJsvJQPz/X453Ut46SfLOIC/xn49b27V7o2kSiapV3zLxrQf+IT8Ycji06eRNAErI8o4zIhfjPk1RKXUK02lduodDapMepcODz0HFaJkIye57H36lMg3TRjneSfKbGGvRa34KHDX9i1kB2C3UtDXoPLASoqLMIrigSbi1GieU46z5MMW0fVxM4KhqB4qaD0o75rdWYY/yASpCZUC7EB75vFbz7ymb1bAyCbylN0VNdxlMOADx8PrUdX8QXSMpU1qA+c06Lzp6f4pNzz1GOmNgQrWbnZjrdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVR6E3LieSWFfw/Au3+j29WtNRtQBV5ilAlURaceewk=;
 b=tPyAWxhHyGmvxEOl4CiF1XOOM+A4IXJ2jRfySSgt0URrqNVh08gcVoU13CbF/JUcTrWiP77XxGdkn0tZfvI+w3Je54oibpOkFFWCBpjH6Ocuyfb49gpkLzWEJVRUI0srPNDWRspp6b74sPa3s7Pn0y3eC+YpM0Kbzsn9Bi6c9vX+eywH4cm7dnE0obKLfzG+1naRKYjXanSuOV47uDKSPFOdPTGb9pcMHQQ/d1GrZeqTA/F4zLar7n+Rii+krTkVAilh700eiQPxdoAXrnZXmFHYE8TPHR9h+Ro9OgqbBRs3vJYZF47RBM/VVXKbYy/CBmgQ2DeRM66RnzkmWn6+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVR6E3LieSWFfw/Au3+j29WtNRtQBV5ilAlURaceewk=;
 b=rpPFhdOO6kWhjB2TSNE4wYCQqvXMsf4K+rk8S2CvoAxod8XjI6/FE9Cj6uc3Kxc92FhYaN+xwBzbtB3ynXyvE7n54dBNNvhaLbtGWlMEnkdq4ufTEcuVtsEPhc4DgVpHOZITZ9KjYAIUcORN3pfGVacqLqcT0ypo73LSZbDItjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:22:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:22:12 +0000
Message-ID: <9dab5129-d3cb-494e-9da3-cb48c2023666@amd.com>
Date: Thu, 14 Nov 2024 21:22:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: processor_idle: Use acpi_idle_play_dead() for
 all C-states
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <2373563.ElGaqSPkdT@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2373563.ElGaqSPkdT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 063fd49c-1313-4f05-8208-08dd0524b275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejljU1VqaUFzWmdtMkNqUWZkaFp6bHo4cFliRkFkallpM3hSZFd1S0tQTGQ0?=
 =?utf-8?B?VDluYmQ4OUtUenVFRUpuYXZjZHBUdWR1SVlQUTQ2eTN4MnJrck9rc3VzNjl3?=
 =?utf-8?B?N0dZd2R2dld4Q3pveC9EMHFLdWV5bHBVRWhzRnhwMGxRcEhwWjdVUXRNZGxZ?=
 =?utf-8?B?a3F4c0N2S2NCUE1XaU0vV0NEUlZQQ1ZWSmE4U2Q3aUpnMExiVGk4aWtHNTh5?=
 =?utf-8?B?UEhZZkMyWkRCK2VGNkU2RW9xalk0cXlPMFIzM01aYlZZaXNySGhDVTBIZWV5?=
 =?utf-8?B?U0pCWTh3aThYNk1OVmdSb3ZOWHRzOUEybXlBR09jSGE4WjVpeFdnTnNoenZ5?=
 =?utf-8?B?aGNqTzI0ODVrOVJGV3lyUjgvMWZ6Nkg5SzV2emlEQzNvM3l0bGR4ZDk0TjFy?=
 =?utf-8?B?NU5KMkljVExJeTA3aFBQcXdtOTE3cWo1R2lyb3ZmbVRreFNSVW1tMC91TXBL?=
 =?utf-8?B?UzNwOFVKUDlhRnlDcmp4WnRkVXN3cHJzelBQMVJmMS8yWXJkS1d6ZlV1cXd6?=
 =?utf-8?B?Zy9ORElDVGFmNklnYjlYZ09SZEZIb1cvcXp0MTh3ZnRPQnRUTkU2a2xSMzYy?=
 =?utf-8?B?VGRVS015aS9BcHZEMXY5eFhnbG8rMDh4NDFyUUxpNHdSS3hmOWRjSW13bVIx?=
 =?utf-8?B?Y2M5eTZXQXQ3S0ZjckVxdm1FNFU4emxoT2s4TmNoOGVwRzhpRnZPZ0RQMVJm?=
 =?utf-8?B?Szk4UkJCTzFvZHdtd21BRlVMWmpLY0xCa01USHlXdG9rdmdSbnNNMzdSQzE2?=
 =?utf-8?B?Szh6dk9tbXJKQlMrQ3FWdVBqK3dYZ0JCNFlMTE9tSHpzd29oNFA5RlZFMmEw?=
 =?utf-8?B?QzVIK0pJV0tGUHRtbnNROWFUVUMvbUxDVkhuaUVUUWEyZERFK0RPY2E0Q2Jj?=
 =?utf-8?B?NHRLNUVYbFAxL0o0Qkw2TU4xUm16MWpRSnFxM2RKVG5GYlZ0TTM3elJKeWxB?=
 =?utf-8?B?azJ3MXY2YUQyc29CMGZaSllIZ1ducWRGbW5KVnE0MlJpYUpienBHWW80WU5p?=
 =?utf-8?B?Z3RLYnhnSUlRVHN2dS9HZlFLVDV6eWpGSTgyanhMYXZleGtLaXFVUkZpcXZK?=
 =?utf-8?B?Zi9VMlg1NjhKQkpHM1ppK1IvbWIwdytCbjU3aHhHSE9BOGxhb0dWd0ZTNnM4?=
 =?utf-8?B?MUJ3emNZeU43emtqUGtHQTdBVWJFRXF0aXlxM3FFcENKSlA4L2RPbzFFb1Nr?=
 =?utf-8?B?YlNGRThBb1NFUHZYSmwwcjdDY0FLY0ZJYlhzYTRuQzFNbFRhekNMa0piQTdZ?=
 =?utf-8?B?SW41dis3bmk5eHJqT3pvT3dicCtBang2R2hoZWtsMytXMFhNNUZQTkRpbXZH?=
 =?utf-8?B?TzNEWnE4K3RQOHhsK2ZKZllKMS9jdE1xMWJUOUFaYk9uL1JtNlNsUE93ZFps?=
 =?utf-8?B?UFBad2laMURDVEM4ZGMzT0NZSFRhcER0SlRkNmRiazZDd0NXVmlzUnlXNld4?=
 =?utf-8?B?aWxWcmRLcmNkdk9pcDE3V1htUFRnczJyMFY4UVBoLzNCdGtyRUtLcVFGSVgz?=
 =?utf-8?B?RldIWm52OW9mU09qVTVldHhmbzVOV0pkOStaYkFGejZHdzBIaFJGRmlHaVVm?=
 =?utf-8?B?UDNLZ2dJc0MxeTRqN29iZExjYkxBSWFLR3NIK0RvS29BVmptbFV6Z3k5eXdw?=
 =?utf-8?B?WW44Sm9hUVlIVWlVaCtXTCtDWlR3UzBhWG0xRjAvdHZKMzBlK2k1eXBGemFK?=
 =?utf-8?Q?T0TVYY/rXvw9KwmV7IpS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1hrTjZTSkpqSWN1WnhvbFpXTzhSOUlSYThqQ2hkY0w2WE5CdnROTjdObGZw?=
 =?utf-8?B?cEZhcElnRDJLQlN6Q2ZEM2psWUZtWHppOXU1SXdjbFl2b29Ea2tubHpVbzBo?=
 =?utf-8?B?UFVRMkxmakc0YWZCUmpLdEJiWE9NWmszL2JieEd4N01YRHRaWXN5RmdRN1Mr?=
 =?utf-8?B?WjRsUG01aXlQV3RQNjdra1o2QTU0UzRBTmE4QTNrY3doejZSVGJNUzV4cnBi?=
 =?utf-8?B?b2EzUGRuM0xUaGlTczZlR3ArcUFyT2RYdUxqbVNnMUprSzU5eEVJdG9RV2FK?=
 =?utf-8?B?TlRzZS9UM2JtaVJHNkhyd3B1dkVYMUFBNUlwWDZCNVJsOEhXbzFSejRER1VB?=
 =?utf-8?B?blc0bzMwM2c5d0FpTHlKblZSZ3VHcWJJZDk0MUtucnhMUzBRTmhPT3p1ZmdI?=
 =?utf-8?B?S2VnMjMyTkhHQkxORzk1QUJmV3V3QUk0Z3A3L08rOTJlQVp3eTFnSzlhWXRa?=
 =?utf-8?B?NmNSRXhNSktya3VVUzAyY09NeXZRODhwWFByWXA4UUVzMjJDNm93ZVJuU2Yw?=
 =?utf-8?B?UTBDQmFOaFBXR0p2L1JOZ2FkcHFxZDlsdTFDeGlTamxudExvSzJKQlkrQzBI?=
 =?utf-8?B?N1h2T2kzMmZORGVFU21pS1A4UXZIVXgzaHZld084U2tMa1cxcUs0VVQxRXoy?=
 =?utf-8?B?MEx2UTNmZFFNS3V0NXFFSzVwT1hwenlHdlFBN2lkei91cXVMTVFKWXB6Q2hv?=
 =?utf-8?B?UVY3WXBtbTVPWk1sZG0zcXBlSDVocDNBOVN6My9lbGlOK1RsVnl6R1dYUTBR?=
 =?utf-8?B?ZzBNc3oxZHJvdEdDMXcxTzFXdUxHSkVBZFJQQVBvejZlcjZ1NitVWkdOVUdI?=
 =?utf-8?B?RkQvYlRyakpuMktOa0tDbktwcWFvb2psQk1VaC9pNytDRWNSMnAwYThZQ2tT?=
 =?utf-8?B?UitvMVdTSWNyUjRGcnlQblJwSGhZTFFLT0hxNnhmNHBnaS92RTBYNUppVFlK?=
 =?utf-8?B?eEFkWjBrU0FGYy82cCtRSjRTdVlmL1FpZ1ZqTklBOXBaYW9VWTJFR3hXOEo3?=
 =?utf-8?B?b1hyU1VUV0dhcDVzbVRWc2tXdTRSeENwcVVtemhvSVFJWlFtWDZVOFpyYVZ6?=
 =?utf-8?B?TDZncUdKa1NFQ2NOLy9Fd08zbEorYmI4Q0RwNmNPckloa2xtMVpqTGtRVHcr?=
 =?utf-8?B?MVVmd3NyZTNMenJwcU5GSFV0MHprWDNxYmkweTNwTGd1OS8xc2QrNjBaQ2pY?=
 =?utf-8?B?OHFnekpIOVlLQ0ljbS9kWVlKQUJ2UXZRYkZualUvNmRoV3ROTzFlS3R3SXlR?=
 =?utf-8?B?VUttTEJKbW5ML01nc25OQ3VaR1RySC9zRHIyblpsVXpBaXlESmdibFdkUTBh?=
 =?utf-8?B?SW9tWmlNbWk4UDBSVUZDS3RmRGlxSkZyMzVqWGpRNEozZStnUDVXNDJFUnRU?=
 =?utf-8?B?dWFVa1YrMm5XYWpqSDZyNEpTY2IzZWNZZklNaS96SnloZ0dwLzJuazlVRjcv?=
 =?utf-8?B?WkJEWml5QjRRQ2JvUGpQQkxONDJjZFFpdENmL1puLzhoa2owa3NWRXdXV2pZ?=
 =?utf-8?B?ZU1CME5EdGhoTjhQTTdERGI2TDF3QkE1alhvVGc3YUtxQ1JrajlHTmF0UmY1?=
 =?utf-8?B?RkVVb0g1NTFvSW9aeTNBc2VFRHFNam1HVzdLUEhLa3dRQkh2c1V2a2RPN083?=
 =?utf-8?B?L2oxSmpObEp5Qmg0Y2d2Ty9NTitTQXpiNk5CRXlIendyY1VSajZWeHJHcUR1?=
 =?utf-8?B?ZDUwenYwYnlwMFI0ZzFrUHFRcytqV01JeGdXVnpkMFJnLzRhSmlXMTlxUzVv?=
 =?utf-8?B?dTNYbUhGNkNBMXM0a2FUQ3NtTlZGT0w5Z3ZqWDFLV2VKVnZSbjl2aXN5UTQ1?=
 =?utf-8?B?NnBKT0dvNkkwTys1MC85Vkxxa1UyOFNKOHRxd04raC9KTXY0aUpvb0ZBallP?=
 =?utf-8?B?UXltZEZHWXduRjlaNDFVVnlrbG94QUZIOWYzcVJlazZyN3JzZmRBZ0M2Y2Js?=
 =?utf-8?B?UUs5bEdOT3lJZGFnNmRyWUlRSXFFQnBhQ1FFRDJVaEY2aXByWlF6VjEydk9p?=
 =?utf-8?B?SnY2dFZ3bjBTelFCdlNxRnVkSmZqRm1oVGJmRVE1cURtb0psYTlneHAyYTZ3?=
 =?utf-8?B?TnVRdHJWRjYrYWc2NGpGa1BtVmxtMVNDc1lSRTdJRkpsSGdvSlJOVzYrUzdD?=
 =?utf-8?Q?XmfFspZ1bAQTrM2TU5eDm98DJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063fd49c-1313-4f05-8208-08dd0524b275
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:22:12.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMv1CUhmeggB6cgcj1AEVJyLoOdb0rvhmZ+86GAXHf8DmGZC9h5iYCoTdJez3Mam8ZGB2Q18dWmFFv7unmZwjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

On 11/14/2024 11:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that acpi_processor_setup_cstates() can set state->enter_dead to acpi_idle_play_dead() for all C-states unconditionally and remove the
> confusing C-state type check done before setting it.
> 
> No intentional functional impact.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7

> ---
>   drivers/acpi/processor_idle.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_idle.c
> +++ linux-pm/drivers/acpi/processor_idle.c
> @@ -803,12 +803,12 @@ static int acpi_processor_setup_cstates(
>   		state->enter = acpi_idle_enter;
>   
>   		state->flags = 0;
> -		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2 ||
> -		    cx->type == ACPI_STATE_C3) {
> -			state->enter_dead = acpi_idle_play_dead;
> -			if (cx->type != ACPI_STATE_C3)
> -				drv->safe_state_index = count;
> -		}
> +
> +		state->enter_dead = acpi_idle_play_dead;
> +
> +		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
> +			drv->safe_state_index = count;
> +
>   		/*
>   		 * Halt-induced C1 is not good for ->enter_s2idle, because it
>   		 * re-enables interrupts on exit.  Moreover, C1 is generally not
> 
> 
> 



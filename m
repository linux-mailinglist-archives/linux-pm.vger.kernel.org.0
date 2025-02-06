Return-Path: <linux-pm+bounces-21500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA06A2B253
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 20:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D35116AB45
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEB1A0BF8;
	Thu,  6 Feb 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eyPfiY4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D11990C1
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870332; cv=fail; b=h+dqJ9+ILoCb8vOxm9u8F0ivZvncd40dXX7lO5HDrQt1b8DSl6LvUajsHMVT1bbFKP+VMGNE1FXE9aOFOzAQaIpmwr8UZxH6ZDAEEeaet8zM0YNzMQcK3X6d+3qElIG+r2s+HryfihTGLP0yztKHYMvB6QxuxVUG8rVwps2czIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870332; c=relaxed/simple;
	bh=37snP8VSV4KuIx2DVuzEAHmbHmUaFE3gsct/VEV04QU=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=M24hMN9V01hn45qeWaKSzQ4MF70KwOa7zvlHq0UfD5+QJPapIv9C4HF2kFJ+xAniXgqcF4Rd8RNCpEvQsLqzenw/TLFiFtUsPWPK/tmId0oZUHVqZC4qzUdLwnIu6XtFuSfYIM06IpsqzIjNMYD82UzLeMTSEMc3m82uuM86SHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eyPfiY4a; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDh0h0cnnOUGQPttq6xFF8aH4rNPVE1/Fod9n8nit3RtzwjW9w8EEMlDvxXi18LjtT1l3t7eLZy6t0tEyiH/lxOhkCpasVTqNOSXUyxLGtK7M8c9D50N5vwNVBz5G+V/Id361xQczRNgzYwMEZK3AXICfssT9hqUuqAUlL/o1lTZPJY3tEI6kNqen5/DFVVVyz3XBIujn+d8YAVQIfyvGiCwqR6fV2JocEROHpCCFZnhZNT+rOV1TAYkGvObGNlPjON7Ueow/7OTclR0nfBrraMEIcncZUoD4gxnxZUVQqwtfgw1vqSiFcegDU3f89otR7fDgJnCEtwy3KfZ+oa4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vk9kiXq1yYcLTktUGBiT4HWgWy+AnnzA4v9MQKPr/k=;
 b=fsRlk4PKtu8ElNC2KOKnGiB9DLmi9CDiPh6mRyT5Lj3Px0fOlBd+8bmYmT7wuoNN5PCCfn8tdTTT0N/l6JeMf/1c0bsRtsYM5t8ztf9jkGJPy5tMk47IaX/wJiqSHmOO1Gk83GE2xzU1zIuSw9vMJLG/sScJe4UZANI57P0SEY3z2HG5k+cYdloeJTKMj97W/c/Dmg5ii07IOmX8LaaaAhkxnMgtPcltSCdzz1R/tpsQF0tMUHgIp0UDkZmkGX8rc+sirCE97/Vg8gF6/phJM3lR42IHvqM+2SaP5dA37qjGtW7OfZ4P8WHE6/ysgC3BLvnmjD17PagzQCP3DBfNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vk9kiXq1yYcLTktUGBiT4HWgWy+AnnzA4v9MQKPr/k=;
 b=eyPfiY4aUxQCZwvSyy51zlWdpJn+jUS9NyKkPz6lFWjYQ08hcdkbGPtXIE7GKq5y2z/IICVxUV0Z87E/zlZ5yOqUc/Z8Gr7lB9bDUc+k4eECYJa1IaLGBkN/8xChl66twDTDWkyu1+7V6VCFm2WONF0QEtiz752dZ1F82UlJlTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 19:32:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 19:32:09 +0000
Message-ID: <e656ef9c-3e77-4a40-912f-cee96632bbb7@amd.com>
Date: Thu, 6 Feb 2025 13:32:07 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [GIT PULL] amd-pstate fixes for v6.14-rc (2/6/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:806:f3::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: b21689ce-e840-454e-f1a0-08dd46e4f26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZC9VWm4wcy9tdCtpZ2MzUTNtZkpuL3NtcjhDVDh2SXE2VE5oNjd4UjBJbkd4?=
 =?utf-8?B?cDgwTUZXd3dpa3h3b2pDNnZDdDZsanEzU3lQRGxRdUtoa05JYzdpV2NpNWE5?=
 =?utf-8?B?U0pPWHFETk1CR3c1N2tnMkZwK1hDeHhhcXRDRm9tT2s0RmNtYUl3NTQvTnR1?=
 =?utf-8?B?OVJocGJUMlFBc2JGZzNVaEpBcGVLTUM4NGdJTlBNREJzVXBhUnU0cHQxYjJQ?=
 =?utf-8?B?YVlTS0ZDZ3FPQXFKaDZFZWYvc1RMMjhzcUx0blg1Q05VM3dsTmYrMktTWlF5?=
 =?utf-8?B?eHp5QWhiMnNka2FZbklQK3Q0NC80WkNGNld3U1V1K3ZCdnFsUkFTQTZnQmlB?=
 =?utf-8?B?UUkxeG9yK0NHeW1UN042UzBPWWJBZkE5WDdvNjJXOENDZjFxbS83L095eEZD?=
 =?utf-8?B?dFg1cGlJOUlhOENPajUxcjJCQ2k3c0xtU1JBNnpKMW1oNnhxRnFFZTVKcjg3?=
 =?utf-8?B?QzhkWnZvNEVlZU90bTdlbWl2RUJkd0dxelBaWmwxVk16anVzbi9uK3Z1OFZW?=
 =?utf-8?B?TWNodjZxMnAvbGFrYnVXSzgveXYzWDd1cHR0UWF3Nk5vT1JUZXBSajJ4ZjJ2?=
 =?utf-8?B?ekV5aUxkUEt3T3diMUlsNDFidWJOMDZjd0hZTW1qTlZWTTNrdmFRQlJzbStK?=
 =?utf-8?B?aE5EbUhzVldhWWx6dlZjeUZZTk9ka3AwSXFBYkxid1h1ZGszNHdUSlhXclls?=
 =?utf-8?B?MGd5OHVvMHd0MURVV0RscEFpTjYwY0dXNkl3N0N6bnJWSnMrUDROVmJKeGpx?=
 =?utf-8?B?N0ZyMlBKRjdtYkRONnE5S1dKRjdXaXZtUUVVR1BNQjE4d1J1a1F1K3B2Z2kz?=
 =?utf-8?B?VjR2NFlXZDgwa3RYVkxBZVlaSmJveEtldUZ0bHVGZDIrejErY1JySGpFMmdM?=
 =?utf-8?B?NGQ4cUFjd0F6MGphWTkwbzNWT1RDNFFGYjJvN2QrVWNwT1VJenJzOFpjTjdz?=
 =?utf-8?B?WUVveEtjd1RKN2FSbXUxVlhtUGVhS1dWa3VqK3p6Y2dBVURsQVhETFV5cnI1?=
 =?utf-8?B?RFdoRitXSlpmOUlTbE8xdDBHaHdnVlRNam1nOWswTE1ueHpxZzdIZndOV21l?=
 =?utf-8?B?aU9HbmJ6SWY3dWFRdEpzTlJvdXBWM1ZaV080Qldtb21MeVRQSks5OFdNak5Z?=
 =?utf-8?B?blpwbnd0L0pjNElDRDkxT1FrWWx0YWlaUlBsNXBVdmZiM0M0cVJVbWxWejFV?=
 =?utf-8?B?R0JSMStRZW90eC9OSit6aktjY1ZhbDQyaWRQOEJvdXAwYW01dGtWZUF1cXIx?=
 =?utf-8?B?eHJic3ZVcGdDeGVmVWV3c056ajA4STE2ZUo4SEJ1YmJBbkpzd2dFTDBHajRS?=
 =?utf-8?B?YzFRTzZ2TUNGcmpXTUNFZTZxekZsNjdtWEpvc0FlbmhxR3hRdE9EeHRXVURl?=
 =?utf-8?B?YnptQVZBQXlMVnNpSG94T1BtV015MnJReUwvcDZRUTVXZWwwOWsxVEUxaXNz?=
 =?utf-8?B?YldmeVNHWW9YbWh6NlZqWjJoQlZvOUc5bzl2NUNzZmdSNDE4eFVtSFlvZ3NV?=
 =?utf-8?B?eGdIb1dYTk9GVWtCUTRIbmVoM2p0c0ljbTk2RGdXN0NPK0JFUWxyS3llMXAx?=
 =?utf-8?B?bXVod1g1ZmZWdTZLeGx6VXJoVUFkb1dxUEVBWVJZekpmOFJqSytEaUN6RGF4?=
 =?utf-8?B?azBDYVlWM2hsSXNEclVGb2VEL2NlU3FVYlkveXp6cFB2Z3NuNmFmNDJrd3NT?=
 =?utf-8?B?NUwrYlZ5cDJVVjY3VU9ZbXMvb0N3MzBTRkVhMzU4dzJ6RUZlM09ncHhySE5l?=
 =?utf-8?B?RlJmUE1hTVFBU1RkdHNmZlBmTzBnSEZFN0EzRFBFTUhJL2NVNndabGNhS1Nz?=
 =?utf-8?B?S1RRck9wUXFMVExmRlhtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNoQnArQ1g0NG9ZNVZNTGRPWFhiQVlxM3NwQ3d6MytOTnNzaitienRLZW5I?=
 =?utf-8?B?cHFoNTZ1TkdQTnhybmdFUENMUUJsdGordVdzbjhNU1djaEdlWG02WUpocFJk?=
 =?utf-8?B?NFdrcEVIMTdrK05HVCs1ZGRFbHplVDg5Ump5RXJEWEZkTjYrdm5oMkYrZUdY?=
 =?utf-8?B?K2FZVTQyVk15OGRoVlBhcHU5Tm1zUnRlUHFHTWlVd3hqeitNYWcrampaYTdF?=
 =?utf-8?B?UWs5U2NzUlp2L2RvSHJZM281VjkzZDVCMS9sYTN6cXpUZWVFUWhoeDFqQlZT?=
 =?utf-8?B?b3BHZVZkMFZpUHBaM0huQWJHSHRCMHFZNkRMQzNrdXdjNTlyOVo4TzBFRWVS?=
 =?utf-8?B?RmxXcnFRMEcxc0pwYkdwZnU4N21ZQWhOUnl1QkMvcDNJaUhnb29Lbm1kV1pN?=
 =?utf-8?B?azRLeE1MWWp2aU9LdkVpVXBOTzdjR1Mrc1A3a243T3c4bmRLRlRhVy82dldU?=
 =?utf-8?B?UnZJdUdNcVc3bko0TzlJN29rN25NZWdKT1dLZVY3RlBMVEliWHdSUTZtcm54?=
 =?utf-8?B?K082QzloVUdDM3pydFZiY1htblZmMzJ2RjZJY1l1R09kSFNyU3JhTlNlRHlm?=
 =?utf-8?B?WEVOTFBWSlgvWVBmb3RhOWhpRW41WHNCWTMyTlpjNXR5bVMrdnRweDZFemdI?=
 =?utf-8?B?eHcyOUgzMjVhczVLcDc3WEl5YTNReU1tOHh0blcvQVNuSDJEK2JodHZvM0Zu?=
 =?utf-8?B?R2xxOUVuQWx6MyszU29wRk0vTzRmN29WU2hSNjh3WFRrVlRrc0ZOK2ExN3Va?=
 =?utf-8?B?YllzSlpvUi9OdlFINTR1OXNWR2ZNdlRjRFRsNlZDZ1h1MnloVU53R2pXT054?=
 =?utf-8?B?MjJUUGpTd1J6RGE4MDVXVXptYTdJbFdJTWZCcVFYYklhTS9aNnQvUFNWRVkw?=
 =?utf-8?B?MVNHa3phMm9ST1BHQWpYZU9rZ2xJN3h2Z0JCOVhodUExbCtlN0tLN0xucE54?=
 =?utf-8?B?dkpmeDJtOVJVTGZraHBBUFNKWkpsV0dBb0ZITlk4WVc3SFdKVms3SUg5UXQ1?=
 =?utf-8?B?WXg5aWhLenpkL2RMNWEvWGRUb3hOWklUZ2FyRXVvenBKV1dsaFVtbXoySW9w?=
 =?utf-8?B?eGhzLzJUV2dYTGEvQ1IzbTN5cVRvOW1IcFFsK1dkblB1NUJDeHN1a2hMd0xB?=
 =?utf-8?B?N3YycFIyTWRraE9FOUhRTWU2N2tRNzY0NG12Y3ovcDhXcG83NUVmak5LSWcv?=
 =?utf-8?B?YWdTRGV6cFVlS1NMYzdzUEVKYlFteFhjeXVsS0gzRVlXNXhyNExjQzlManZV?=
 =?utf-8?B?T0RLaDk0dkxlWG5JVTQrOVZIRGlNaHllSGo5YXVqczFhdklxY1dTOEsvK09L?=
 =?utf-8?B?TXhuUEdGQUt0Ykk5QUlrOWtSb1lkYkJzUm5sWXlNYmlzUi94SU9UNEN6V1Zu?=
 =?utf-8?B?T254eDFQbDVQQlZkd3M5aDR5c3VpTms4TmcrQzU5eW50YzhvQVFoT1lZZ1pq?=
 =?utf-8?B?T0lyc2RPeVA0dHp4Nk1zaGhsZ3B4dmljWnQ3OXpSL2poQy93YVR0cnhENDMr?=
 =?utf-8?B?ZFp1Zy9VZG9RQzNkY3prMFFoSW5kVHUzby9wYXdSVXZmOGNwZ3MwVFZHQXc0?=
 =?utf-8?B?Z0N3amxMMTI1My8vR1hZODBGUTZNQlVYRHBOcUp1S1FVelNIQ0RLTjRzNzM1?=
 =?utf-8?B?dGppbkVqN1JqRlVZWk0rQUcrd2VGWHErVHUxWFpUWmZubWVVWGZUS1hERmR6?=
 =?utf-8?B?VGJVYjF2YlljSlpFRUhaRm8xNDZoclNTTUZtMGoxWVdhakc3Q2wyZUd3bVhI?=
 =?utf-8?B?K0pUcy9YZUFOOUpvZUhzcFhUbzBLV1d1M2N2aGVFU3VTanI0WFR3eTZmbkNR?=
 =?utf-8?B?bmU0M1VCdzFweWJVUUpTMFl0aHdRZ1JqYWFScDkwU1l1WTd6cFBaeUh6YmdM?=
 =?utf-8?B?SGxJdTVVbmJ2YktWbGUycXlCUUNwTS85Uzk4eXBvdS9lL3dZekhlVjZFYkJO?=
 =?utf-8?B?eGo5bWRFVmpKK2IzQTRsdXhHaEtFYnFOUDhmbCtTcE9qQjRiM0lMWjdvcitL?=
 =?utf-8?B?dmowWk1XYjdzMzZSTWhQSXNuV0NLNitRcG5ibXU1TGVEUFFmRGNGdFEreW4w?=
 =?utf-8?B?RWIxQlM1cVMrM2pMR3RsTlV0djFjWXJDT2hCbEFrVmRpbGphUktoRUhSYjlw?=
 =?utf-8?Q?fOCDFGhnOCVOdyboV7XfaQjap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21689ce-e840-454e-f1a0-08dd46e4f26f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:32:09.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/mbPFgmMEetzDhEZXD/EkIUpkZfqzLBQkj3I7h/uwl2s6Jq3zw6d77kr5sywv4zmTW8R+z7O6rw30p/cHEU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

Hello,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.14-2025-02-06

for you to fetch changes up to 3ace20038e19f23fe73259513f1f08d4bf1a3c83:

   cpufreq/amd-pstate: Fix cpufreq_policy ref counting (2025-02-06 
13:19:36 -0600)

----------------------------------------------------------------
amd-pstate fixes 2/6/25

* Fix some error cleanup paths with mutex use and boost
* Fix a ref counting issue
* Fix a schedutil issue

----------------------------------------------------------------
Dhananjay Ugwekar (3):
       cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_limits
       cpufreq/amd-pstate: Fix max_perf updation with schedutil
       cpufreq/amd-pstate: Fix cpufreq_policy ref counting

Lifeng Zheng (1):
       cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail

  drivers/cpufreq/amd-pstate.c | 20 ++++++++++----------
  1 file changed, 10 insertions(+), 10 deletions(-)


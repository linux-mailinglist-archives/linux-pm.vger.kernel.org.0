Return-Path: <linux-pm+bounces-14032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05329755FC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEAE28C3A8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A81AAE07;
	Wed, 11 Sep 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AAjAEuoL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DE2C190
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066137; cv=fail; b=EWvx06mSuxoPGSDF/81N30hRCwI6WRkGrFQcy0fTV1vgDunAzwR8zQAquOpJrNRed+FAp6Z5izcUlrWqdrYqTQgczaG8sKJjQZbKOxLMZukBqngoAit89am1F8bA6Erw4FjEp3R8HC/jw0jxA4p/LE4rsFfxMgmnmTR+XzvdPEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066137; c=relaxed/simple;
	bh=7iKRqwvviOP2GPB28di5eX0+MitWP57mwb2dhMie8ec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIHx5PcImRSqUYpy3J5qc4pQUOBduLpTc7QS1r1/gsrPwDv+Bdf1Nq9tyreQonOAkAWg5jRTiefOpXa4zjCKUaYOGGzstSpYoDCa+E5RubIOwpw2BbsmLqJ9WfnRZlRlUleU8nLIu+AMpNleOfn2MUy2NzmGG93aSlx3EsC826k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AAjAEuoL; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMQne0VsSzoG9EKH1tLyvoWeIueq+jqj0cZhtr4N87fuvqqc72INfs1286nDdtifFIGdfLUpYF+Rsy0xUnP7F3hUme61Ck+EIxlabCjyPp1LokMZlBHb9E/0sabZ79p8O7D6o3+gxbLikNecMYJ7oP1uBF1YDHj8eVq338tf3z7UtwAOOUINp1LMUFf4kJa8GcnezzuCQSYpaufrDT7aSVOmTGwOgVewD1Dc+Jw02raF9bhrwcfu4cFddfqab2HGlh2rWN/+BEZ0Um3vAb9VOpXUKiyTQSqqHRessxmwHRQhGM2LPYb8T7Y7UB7E+ad244k5xfeE1UUU09GRpVWfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWoXCg3gVjoiv+Zwac4Ze8ioQOe+b6KOpNPKTODBfXU=;
 b=WfIuzFuQgz4/6O/4DFLrm75DqYa/W8mw8+Bl8q/qpyR5GrDFEJqT6j3yB7WnEuLyx170oJwCe+J0xcVF1uXDtlzFoSTZNYHQqc5m5FGdRszbbKdarGA5aQ33b5/QS2tNm5KThuqG7LjAcEvu1HngIAqI2AhzMnF3+eGJb0Ds1ekr3SzA2BNW7mKdv2ptOJj9iStv6NiPgz/llcPKlL0d3Cgz3H2yc8bSzaFOL8M8nJf2Osvoyi/KOiMfyThbl+cZtAc9bFptErLs01XUalG5yOgaEU/ayhsoZOUZ6GTOhDDM5+corrSVKY2NpHYCREBmoOrRD0W/F4XMjFbmkXMylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWoXCg3gVjoiv+Zwac4Ze8ioQOe+b6KOpNPKTODBfXU=;
 b=AAjAEuoLUnoUXWzfvRoPtKjSP2KGJLqFS5gcS9PpmQfuRIMkQl85Nac4e+PlOJO4vHQzvF53L+cm8qaagnbPfcMlRZkv13ACMFsL5F3pDOd6jKNHUtcJh2/nc15G2Feg7h8v5MjefNtFEOiLINVgnFWRKeOTXpJhsvj7r4HyILo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 14:48:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 14:48:46 +0000
Message-ID: <749561d6-51b1-4136-8baf-c7a10fdffd5d@amd.com>
Date: Wed, 11 Sep 2024 09:48:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Second round of amd-pstate 6.12 content
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
References: <da6db097-d4a7-425f-8e61-084a2fe15770@amd.com>
 <CAJZ5v0gzUbiaT5_74NSPv9bbBO4GfCoEfx-M0JHHMqYkn5N+8w@mail.gmail.com>
 <CAJZ5v0jG57Oq_rdoGzXABdxHGvQ9yqeG1f-850LmtmFy+3MFKg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jG57Oq_rdoGzXABdxHGvQ9yqeG1f-850LmtmFy+3MFKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cf16b7-1885-49f9-3f76-08dcd270d6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QngxTDhuNzJpeit3L1Bpam1nRC9ZZ0dWQm4rdmlPSVdnTlExSmNWakI3M1ZD?=
 =?utf-8?B?VHpBOG5SZVg2eTdRbWZiZDQyYXFyeHMvMC9CY2tQeG01NWdrUkVmWWpPek9E?=
 =?utf-8?B?Z01YcGdYTDZZNGhsMGt1WTRSYnBJWGNLbzBjTE8rc1hFRTkvdXBycXVIY2Q0?=
 =?utf-8?B?NTBmU2NsOGZHVVE0VksvaW5kQTBUbkVxK0V6Q0VCZjMrSXI2eWpaNENLMjZn?=
 =?utf-8?B?T0htSU9GRkFiUEs4bWJXdXAwT054eUhoSnNpTjltMnhYRGJuWFZqVkZkdVpM?=
 =?utf-8?B?bzQ0S0lxSG5uR1dSeUtBNUlibllQMWFGazZzTkFkV0tUMC84QWV2YzB3bTRF?=
 =?utf-8?B?NFNkamlXYTRJTXBBM0pPVzNlZVpPN1F1Z25oUnFWakhGRFRIa0t1c21obVFK?=
 =?utf-8?B?L29KNDMxc2s1cXNteWYxTHdBRjY3bVJnblpSdGlKTFpjZzhFeTY2eVErT0Nl?=
 =?utf-8?B?ci9uYUpod2dsdTBwTlgvaHpTcDhPZlJxQkw5ZS8zOUJ2RGpubDgzdGx6bUNY?=
 =?utf-8?B?Yzd3SXI3NitvZ2pvSllmUndjVzlmQkZXbnd3b3Fib290Vk50WjJuQU9VR01L?=
 =?utf-8?B?VXduSnN6dldOeUw4WlhhNnJBT0RiR1U0S0xDdCtiaFVpMnpZYUdkZjF0SFV5?=
 =?utf-8?B?dmJWL0hvWjJJMVJ1WW1CUXJwWG1wcVpkRUJLa2I0SVdpRGNMU05pYUhsWWp3?=
 =?utf-8?B?cDFOYjBSZEwwS1UzQko2aVg2NDBSZGJaajhrUWx2NlcrZkFrakh3V2ZuODRJ?=
 =?utf-8?B?bDFRVjJjVTBvNWxOSW1wTmZ3S1RrVEJ5dXBTNjRINjl3SVBMMS9LSHRGU0Nx?=
 =?utf-8?B?RUFvSE9ZK1JWeTFDdjhaQlFyYVNOeXoyeFE5STd1SENHdVc4amdRK0NEZDNy?=
 =?utf-8?B?YlBUTUVXZzhuR2M1R3BiK0ZXb1pMMGRKRVVaSXhha2YwOE1tL1E0U1E3Nlg4?=
 =?utf-8?B?MVdJamZ5WTFNQ2Z5M0h3L1g3Sno2Vy80dkY2bURKYU42VDlJeHBWQlVva0cv?=
 =?utf-8?B?QjNQdklvYU1Da2pvVXJ4Y0lyQ2JEVWY2Si84ZnVKa0NrcWVFR3o1QlMyNk5m?=
 =?utf-8?B?Zm1zZEttT1VyVmNKN1FwbG1xODJkRlVId0dyT1ZRQUR2Ulk1N1pIUFRTK3hz?=
 =?utf-8?B?YUM5Q0F3cWd6RmxkbTNkVkVlNzlYQ0NWTnlBbWlOTzJGZnp4WWZYTFIxYjQ2?=
 =?utf-8?B?Mk9SK3ZyODRvU256UXpJcE1rK3VVWlFzY1I2V1E4WlkrSDlidnZoZHdnTXVB?=
 =?utf-8?B?cFBjMVBZS0t3NkNmdzNBaG9aYkFHNjE1K0RpMFJkdGdyWndIcDhmelFhM0ZJ?=
 =?utf-8?B?dndiRjRkV0dLQnk1a2o0N2k3WFNyMHJ4MlZyeXAyNGJPNXVBUkZJVVVZZXFp?=
 =?utf-8?B?enh4VFRBOFlpV3JOT0xIYkFuS2FPTEd5STFIZTh4cVVEb0xxbC93cW5aVEhm?=
 =?utf-8?B?bjhySUNvZGZabFlRcmk0KzV3cHFZNVdqeFg1UFhCVG1HNU1BdjZrY0Vybk9M?=
 =?utf-8?B?aksyMTYyVDhOQ1QwVlRFZHZneFhnRDRTUm85cHpsQWlSWmd5djNKTXBDWC9o?=
 =?utf-8?B?SUl3OFVENks2M1lxMHpBM1VWNjhpeW9RL2NRaFkvczl5YkE3SWZqTVNxbnQ3?=
 =?utf-8?B?M3lkT0MyZmxCbHdIeEZpZktzaXAvR0NmWXZQNWdzcEVpZnRHcVpDWWRiUVJV?=
 =?utf-8?B?L1JoU0R4bHJaRjBjNS9hVlA2TDlzdlRjaGl5ZWFSdEswMXdtK1phcTVUWlVE?=
 =?utf-8?B?d1BUMnRjZ3l0MVpsSmNFTTI1cHp6Y3dvbDROTjdra2diQkR1V2tvMXllUWk3?=
 =?utf-8?Q?iBnJ8SvtczwI6lMJ7ZF0szLkksZFCNpYZpo5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlVUTEI5Vk03M253RFBVRzlyQ2tVOU81aUpTUTd2a3F1c2hLVEMvK29GWU5N?=
 =?utf-8?B?SGkwanNFUitoZDRBcWxPRlVSVzNsTUpkbEF3VTNCYWdUZmZyalJ6Z1JpMXNJ?=
 =?utf-8?B?L3ZyMmo0eDJZTXZoeUx5a3R1a1RBcXdsdHVGNnMyNGU0WUpnL2lrOG1kNkx4?=
 =?utf-8?B?aFVGeHV6UllIaUo2OWhIWVh6UGtBSzJIZ2NxNkdDQ3RseStVR2JGRnc5MExz?=
 =?utf-8?B?TncvTW1QSVFaZjBBTDdka3V0K21VeitxL1ZGM2hCM3VFUU5hQkZNNFlZTTFK?=
 =?utf-8?B?QXFpV2NFdW4zVlZaVHJBSlQ3M3FDNHd0cm5uN3dKUmFVTk95dWs0MFhNbkwy?=
 =?utf-8?B?Zzhwb2NxekdKK3JtQ3RWTUp2NXRFQ1pkT292Z0VqOUNrSU5ucmhSOVJJRFNE?=
 =?utf-8?B?aVdQSXFqaVh0YzROcE9iZjVnbDJqdWdoMVRPTVRFMThFNHhaWklDK1hsbkVu?=
 =?utf-8?B?eDJySW5hM0F0UW9zRVRZUHJDTituV2ZjaENFYkw5L0crRXZ3Ykdrck5MUjQr?=
 =?utf-8?B?bzdNL1JkWmd5ZmcvYjBxSG9qeWNFSWVZbm9vWG1RUmk0T29rc3hkbVowcUlj?=
 =?utf-8?B?b3duRFY0VzBVOE51cm83dXE3VGtXLzY4d2gvV3BSYVVnMUF5ak9vc3NPbmRv?=
 =?utf-8?B?R3FBK1hrdEpvcFUvRHcvN3p2Q1BCT3dPcG04QVVXdjNUWExtZ2trMEg5M2di?=
 =?utf-8?B?SDVSY3c5a01TZ2hFK3ovemJuU2RBaWJrd2JJVGRqRjAxeDk4c2hiQVo1bnpR?=
 =?utf-8?B?dkhkeU1UVVdYMHVhYlJ1YmJMZ3hkWjJhRDJHT29lKzQ5MEszUXBOQUpDRkwv?=
 =?utf-8?B?SW0vSVkxRUt0YXh6OEpSKzVTSEZZemFaMFJkaTBHdXZNOE13MmhpNnMyTktl?=
 =?utf-8?B?d1lvcDJtNjVnTFJuSjZCaC9hRTFoYjBvUXUzWjNBcUlYWVZmV2VLQWgvYkNi?=
 =?utf-8?B?U0s5QlIvYlFrZUZCY3V1Y3RwcHp2amdZQnNWb0p5SnVvQXNDWEh2QkpyRnRx?=
 =?utf-8?B?OFFRUkRheGFKRS83ekg3NVdHT2FTWW01SWVmT3o2QWFBbXU3ZVVKRWRydDk1?=
 =?utf-8?B?UmNhV2FVWElpSkFRank0aTJJQlhHVVhZc1R4MVF3YVAvejZ4NWFybjN3SEJs?=
 =?utf-8?B?OE9CNnRRVmxBNHdISTExVUJJbHJ4WDR1YWx1Z1U1b1E3TGxOMmxnRlk2eXND?=
 =?utf-8?B?L2JIVUN2TnJRdFFoMW0vaEo0N3FNbm9uKzYycFpxUmtKQzlkQkcwR1V0ek5m?=
 =?utf-8?B?SDNHdVVoL0FiMUcxekNMU0VaNlJVTnp1MlVNNWNaVjdzT2F1M0J3NElqQXBn?=
 =?utf-8?B?RnpBTkhpMFk5dnpSZXpZRlZ0U0FyMFFhN0QzTS9QdkJrZFNaUS90TnJ1RDlF?=
 =?utf-8?B?VEZaUGFpVFFVOHd0VkVuWDcvZmNwWjhxeHhKdEFJU0YxSUZqM3RMV2gwQ1FZ?=
 =?utf-8?B?bEN6NGY0N0IvdjlLM3dVVDhJYWJiRW4vaWZobGRDejV5SHhudXJBWWF0U05h?=
 =?utf-8?B?V2g5T1JIcHorTzk1Q2wxbGpCR1ltdFlIb28wMk1COTh4WXdoWkpJNWxVbzAz?=
 =?utf-8?B?emlUUFpTdTlSMVFlRHZlaFNCSG1pS1ptMTdKTG04Mm5BWTVrazFQWGhjcUNP?=
 =?utf-8?B?aXN6bGtuQ2cyWTdEZ1JSR05odW9CR3hla3EvWldpbjdPYTR6N3pwWVIrT0Vq?=
 =?utf-8?B?QzMzR0gwcUlDU2lqZGRtcHJKOUJhTUljZDdnMk5SNW9RK3BBWGJIakNrMlJJ?=
 =?utf-8?B?QTMxeHd1cWVEcGJsWVNkcFc4UGovOGwvZnhIbXdmQjk4cDNtRUhpUWd4cEQ1?=
 =?utf-8?B?MlNIVmVDaHdiclNhWVhSd1FkSUJKM1NZMDJTZ1RaNUJySlpFSWN3QnlQOTBz?=
 =?utf-8?B?cU5NdEVadDhXeUpIUU9SaUt1SFJkdHd1RHFkOEdoT0kzaDgwd1ovVFJuVTFD?=
 =?utf-8?B?S1NpT25YTGJnZHZWb3dGRXJoVjhzRmora3YzVWY2ZUlXYUdOM1BjNExhWi9X?=
 =?utf-8?B?Q0VDcUtXL3J2R0I0S1lEU2FXUkF2WC9vckFsdFoyTnQyWkJGbW5DMmxidnN5?=
 =?utf-8?B?dDh2Zlg0YS90bytZR3lLeHhVM1hSQjdKOHlNa1Vjc0RicEF6Wm01UkJIYTFD?=
 =?utf-8?Q?zwvJrQ262BQ3webpNXjbU57a7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf16b7-1885-49f9-3f76-08dcd270d6e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 14:48:46.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8Cmdbj6lAlNjgXqsj+yb6xAAfopZmXS55TNM+ujCTLfzzHDcZNJQPKJ8R8933XkCCTqN715p6rIBcY0dTpd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

On 9/11/2024 09:43, Rafael J. Wysocki wrote:
> On Mon, Sep 9, 2024 at 6:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi Mario,
>>
>> On Mon, Sep 9, 2024 at 5:52 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> Hi,
>>>
>>> The following changes since commit 8cc214312cf8a0c3702edd1aa52e507262adccb9:
>>>
>>>     Merge branch 'pm-opp' into linux-next (2024-09-06 20:53:58 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>
>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>>> tags/amd-pstate-v6.12-2024-09-09
>>>
>>> for you to fetch changes up to e121c01c0422fc56033d0dfa1bf3f0366115d2d5:
>>>
>>>     cpufreq/amd-pstate-ut: Add test case for mode switches (2024-09-09
>>> 10:26:26 -0500)
>>>
>>> ----------------------------------------------------------------
>>> second round of amd-pstate changes for 6.12:
>>>
>>> * Move the calculation of the AMD boost numerator outside of
>>>     amd-pstate, correcting acpi-cpufreq on systems with preferred cores
>>> * Harden preferred core detection to avoid potential false positives
>>> * Add extra unit test coverage for mode state machine
>>>
>>> ----------------------------------------------------------------
>>> Mario Limonciello (13):
>>>         x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
>>>         ACPI: CPPC: Adjust return code for inline functions in
>>> !CONFIG_ACPI_CPPC_LIB
>>>         x86/amd: Rename amd_get_highest_perf() to
>>> amd_get_boost_ratio_numerator()
>>>         ACPI: CPPC: Drop check for non zero perf ratio
>>>         ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
>>>         x86/amd: Move amd_get_highest_perf() out of amd-pstate
>>>         x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
>>>         cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
>>> amd_get_boost_ratio_numerator()
>>>         cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
>>>         cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
>>>         amd-pstate: Add missing documentation for
>>> `amd_pstate_prefcore_ranking`
>>>         cpufreq/amd-pstate: Export symbols for changing modes
>>>         cpufreq/amd-pstate-ut: Add test case for mode switches
>>>
>>>    Documentation/admin-guide/pm/amd-pstate.rst |  15 ++++++++++++++-
>>>    arch/x86/include/asm/processor.h            |   3 ---
>>>    arch/x86/kernel/acpi/cppc.c                 | 172
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>>    arch/x86/kernel/cpu/amd.c                   |  16 ----------------
>>>    drivers/cpufreq/acpi-cpufreq.c              |  12 +++++++++---
>>>    drivers/cpufreq/amd-pstate-ut.c             |  41
>>> ++++++++++++++++++++++++++++++++++++++++-
>>>    drivers/cpufreq/amd-pstate.c                | 151
>>> +++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------------
>>>    drivers/cpufreq/amd-pstate.h                |  14 ++++++++++++++
>>>    include/acpi/cppc_acpi.h                    |  41
>>> ++++++++++++++++++++++++++++-------------
>>>    9 files changed, 305 insertions(+), 160 deletions(-)
>>
>> Pulled and added to the linux-next branch in linux-pm.git, thanks!
> 
> And unpulled because it was based on the linux-next branch of the day.
> 
> Basically, please don't do this.
> 
> Please base your pull requests on top of mainline commits and if there
> are dependencies out-of-the-mainline dependencies you need to pull in,
> please ask for immutable branches to pull from.
> 
> Thanks!

Ah.  That's what I did originally, but there was a conflict specifically 
because this got applied through another tree and I ran into problems 
when I tried to do a test merge before sending out the PR.

commit 5493f9714e4c ("cpufreq: amd-pstate: add check for 
cpufreq_cpu_get's return value")

So I figured it was better to rebase.  In this case can you please make 
me an immutable branch and I'll redo the PR from that?

Thanks!



Return-Path: <linux-pm+bounces-29667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5DAAEB967
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8F3A5EF4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7615689A;
	Fri, 27 Jun 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MnU1GBQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E35144304;
	Fri, 27 Jun 2025 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032898; cv=fail; b=sjBO0PnqPI3MGIpKjI9AzjwW4x+PvDDPiaNO2wGu+aviSeXnAmUgPemGi8YOo5S3s1FLvRT0pbYYo6C0682rZsgrn/q1vNhhZzib3m8kUSZwdHg8BbfS9oaUFoBwub5v4jr5LHi72MCobrcCrViW3hjUrIBnNoOZgdpCDiuuq6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032898; c=relaxed/simple;
	bh=DyU1iwXauFivmCW5p1NHwDWqGAU0bWLaj0A+JT0s6eM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBB7qyNUdQs5kK04iKREtAgWOsrTho/6og2/bl2AEwSSXGqAqYS7JaeCnXz0BEzxc8tMLT0UthxNFA4He9emIdNFEGiH0GbjWCYQ4USeWTe6o/45UtuuM666psFx/mhPlKIYJtkmdkoBS7HNiK31tRF8g8ehhSsPr6ZVDcNv0l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MnU1GBQa; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVGPGUCo1YJe5lZKBN8Bq+bJpAtYdSvJ1XsRySdGcU9y3YixKKVXA36bvxCHRhDWWOE8DiEyxvur/reIz6KFew/XTppBFhTwirFtpECtzNWQ9aI8xen8iAGvV2yyOldXeJZ116+8iwSoR86gD1GDSpFeBLUrGh62wAwNTlhr3WChprZvlXsIS2R4a9HnE2vGu9mOFZH6y3vrYt3Ztk3noQS/UhacjXPP1jUvTdgaJ6lmZKilmLvrZUzgxdQmAfn73Z0DvRrLX1BmzUDn2HL7UPuwtdfOuRFy0wWTP65uq36OEI1YroHHlU7ycQbf16EXtY+GDoOnIS9l7EtEzqNQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw+HqC2ysNE6o+6ZJKIyCHJ1SqDdrFCYXEf91Js3HWg=;
 b=qHNgrKXcUiKf/vk5pifrnYsBSWktE5Ojv9yBQSFyIMHzz05ihPKZ2oPIf7aFKpi9H6iata1cCGLwCNFH4dusR3TigeNHJBvxGS3+b7RhCCrACbAeAprqpB2xeGtpq7cfkiU7ErteCE0iZV/6lDMwMFEUiAW9W/9pt5LflfXSy5jT+RIvWmphvYQ0kDUUfa+XrOpa+sgduGCRPmC6ASMwFMeN1s2WMAF8e9+C8T4I68OqLdQ7xXw9d/bZM/yFLBRr70F0Z0Q0Ou3BNYw2IUHv8TPDzE9p/GN5kFH0dU+lrRc/OQ5jyXnxA0PKZFQmV9IcyVFO4CBZbEw6rlELtFTBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw+HqC2ysNE6o+6ZJKIyCHJ1SqDdrFCYXEf91Js3HWg=;
 b=MnU1GBQa4PcV8DLPhjeX6Axri5V0aCx+5e/eNdBxXZ4lElNVo6hIa7Unm05gDNBgVaJXhBHgFgLPw04CorQyuHgDXO7PMTjLYKKbPYSbV4I3OO9iw2m9AA0MK7G3xd1T6MLxVRy2Nl6RSG16njlq5Q8M+pe8AZxvgfU7M8rzH6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Fri, 27 Jun
 2025 14:01:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 14:01:33 +0000
Message-ID: <0412561d-6ed3-4823-b510-8600fd4fd1fa@amd.com>
Date: Fri, 27 Jun 2025 09:01:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Saravana Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <5011988.GXAFRqVoOG@rjwysocki.net>
 <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
 <5a6d0684-3340-43ed-b520-933654515943@amd.com>
 <CAJZ5v0iJ65xxuHtJrWp1sC76FUzPHNpXB+xtHB=e4qTRSgAC4w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iJ65xxuHtJrWp1sC76FUzPHNpXB+xtHB=e4qTRSgAC4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:806:d0::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b36f4c5-2fe1-4187-260f-08ddb5831f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDJRc0hYQWRra3hjaytaZjNlc1JpaEltOXNmYzczazkwclZtRUEvWnBkaldv?=
 =?utf-8?B?djN3OGExT0M4NXhOVFdSN1BNdHJEczcveVRKTUswbitxcXBWSlFXQXF4WVNW?=
 =?utf-8?B?K3FuYk9zZ3d1c0Q1TUkvUjFxM09QRVRQQlBGRFRRN2RPc3IrWU5Pd0liRFU0?=
 =?utf-8?B?K3VYK0h1V01HUFdRQkZHTytYUHNIM3o0SldWSlFvdDRKUVF5V1NuV3Q0Uk5S?=
 =?utf-8?B?ZEdDRkIvSHFiTngraVpFS1hYQXExUndDWXpaNmtLL1dkcnd0UVJiMCtyN3Ni?=
 =?utf-8?B?WHhGdi90YlV1dU1GNkxPM1A4SjJoSVpFQkJWSll2bkc3SlpLcER5eUlwanBP?=
 =?utf-8?B?UGhRV2hnTzRSSkZjVW53NmxkUUNud0RhcHh2dXMydVVTNUloSnZwcXl6K25p?=
 =?utf-8?B?Wmk2aENkY21vcXg4NkFQajF3Ymk3NnQvcTFoOXlWaDNCVlZJZDBRSjR3amoz?=
 =?utf-8?B?YnZSRlVtQmpGa0R3RUpCNW9lQ2JsMEdjQlpvRnNjMWF5MlQzcFBURlkzbHVu?=
 =?utf-8?B?YTZaTDh4WmEvaUN4ZXN4S3V6dE43eXA0clFSWEYwSWZ2c1NkVHlFRTFCU0pr?=
 =?utf-8?B?cXdLdmYwblNldkJtZkhYQ1dHazZGR253anRNRk93K2tobjIreFZES3A5WnBT?=
 =?utf-8?B?QUFTU2I0clhjZncxL3R6MzJPWGQxOUNEdGlEbkZVeVkySFhpTzZWSzU5RUhu?=
 =?utf-8?B?R3FleHBrK1QydHJzQVd0S2lxY0ovMlA2L0UxVXhCN2NGUkV2eDg0UW4zZXR6?=
 =?utf-8?B?bnFxcTN4SzV4YU5La05uVTNwUDBGUElUOHF3bEFLSnJGTk9YbE94RThrKzdI?=
 =?utf-8?B?dG83eTJKUU1KeUZ1M1pxbE50UzAwaE1zNmdCeTJEZXMxOFlpWWhTMEVkTENJ?=
 =?utf-8?B?TlJINXBLcUxQM3pvMTVlcVUwYVdxaUYvQUo1RmJxTnI2K0VJcXBaa1BKRjZm?=
 =?utf-8?B?clhwMGdDLzlmRW1HeVFCUVJVdElleDV3QzR1ZnhWQjdiR0k5SEQwTHMrYU1J?=
 =?utf-8?B?QUFEM2JUWjd3WTlhaXVSR0RnWmpnc1g5MFVnSmJ2N281S0haNUluUGZDWGtO?=
 =?utf-8?B?dHpsKzFIK2Rab2tWV0xpWWhDRjlMWHJyNndDUVNZMWxnazMzaytHSDRzZkt0?=
 =?utf-8?B?UEtrN0JKbTdVMSs4a05jNklJSUJJWkNTUUpLcjYzbHdROUxZY2w4UHR6czJ3?=
 =?utf-8?B?MFRSbzc2a1JGSHRnaFA3a2drMUF2L2VZdm53TktxS0Q3THV2c1V0U0RNcm4r?=
 =?utf-8?B?KzdIc0pRMUJkUHJxR2FqSTFIdXdJOUlydmtUeHQ2c3M4UjhWaVVPNkVSNno2?=
 =?utf-8?B?MmpZNlJmU0RBc202TlFITHV1V1pKdjVuWWpJaVlWK2hOQk84OTRDRXQ1T1JK?=
 =?utf-8?B?bUhScnFPdHdobk8xbE84dU5IaExUOHFrM2NBNGNqamtSZTUvM25MQmlXTWJz?=
 =?utf-8?B?Mk5GMHh1MXRtWE1PT05NRGtqY1VjYkloOE0yeFZqSjlyWDFzS2kxRVVvS1FE?=
 =?utf-8?B?bG9rckd4UXJONlBDQUhJVE5XcVFqRVZtSmJ3amJJdmRPVndubHJoVmN2Qmpi?=
 =?utf-8?B?b05uWkRNMzNUMG9FUGQvQjZLVjdDQlRjcHlFUVQ4Q1dDWk9QWnhHb1F4T2Nn?=
 =?utf-8?B?aHBnVllxd2xMeVloWGhibG8rZ1hla3hvMHNPcmFONEdqdkd1MHdiejVTL2hw?=
 =?utf-8?B?K0NDdEhrWHlDR3lPV040S05PUVk4VWF5R05mKy9KN255cTJQNG96RmJtRUVV?=
 =?utf-8?B?VkE3Y1M4clRlWGNUOWtmN1FtTXNaTHFITDltTFB5ek5ZSnBwTVVhQ1gyQ1RS?=
 =?utf-8?B?NU9PRkxMMTAzY055WDdGenZ1QTM0NEEySUFvZXhIb3dwS082SVBjc1lNelBw?=
 =?utf-8?B?MUYyb0Rvdm1sekZtdC80YnFmbUxvMXIzS2Q5OFp5UmpNd095TmFBVkhjMllh?=
 =?utf-8?Q?/12hVEg6lio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzZObmgwZXJoMGh4NkFSd2FZTkRGU0JtNnphR0wyUFp3TVZHcVpLcmlEOXB5?=
 =?utf-8?B?SVBqU0o0emlsUnJzeDQ4L3JXUm1JVVRLVU1LYndzQ1lhYUVGMlpKNVZucFhr?=
 =?utf-8?B?ZmtuUHE3Z2RyaWJ3QXhUMmRYc253eFFrcjdveXJmK0FmUGJhSlkyc1NHWEFK?=
 =?utf-8?B?NEFrRUYvRkhtdnZkVFdhRkdOSUZrVXRQaGppYlFLRUlrMnpDVDFRSEV5Skhk?=
 =?utf-8?B?dWZIYnhaYTlqbmlZclV0bzZDZW5sUG94SXdtT0NQeHI2WmJoNVl4enpSZHh4?=
 =?utf-8?B?c3JMRjVReGtramNkNDgvbllvNWRTR09oYVVqRS9ZQ0dQaHZSa2VuMDhRQXJ2?=
 =?utf-8?B?NU5Yck8xRVhRNitXa015VE40M2V6S3pEdkxCSmNqYlpOUWFrcDJrNERPSkZv?=
 =?utf-8?B?NGcrNno1VmJDS09JeFNrekszaVl3VkZOQ1Y2ZHhia2pGUkR3UHlIUmgyd09H?=
 =?utf-8?B?OVA5OEMyN3lBNTFQWTdOdjRTbTA1OHBTNm96K1BIeU1Ed2J5SXVHdXJpNWFB?=
 =?utf-8?B?NWZjbDZEVXZKdWJtNk95Tlk0Tml0UUZCV05ibVcreUhTVEtjNzhWamJWRmJu?=
 =?utf-8?B?M3h6MHJxSWZPV0Q1cEoyUGVOSlRUOWtQRUo4U0lDUHBkRnFob0dvVXJwS1BH?=
 =?utf-8?B?WXNobWRzaFI2VWM1R01HSVlIZGdQbC84R0NuTHdoa2VKQS91czkzdHVUL3Bk?=
 =?utf-8?B?YkprU2cweEp0NEJraHBMR3J3TGpkMjVGK0dhUXZES01va0l3WGNycUtMWmE5?=
 =?utf-8?B?QVhWRkZxOXJvYURTd2o0dDlkR3JranhyUzZwZDhCMEx5ZXRvTUI0MmtJZHJ3?=
 =?utf-8?B?QzNURlE4a2Z2Y0gvVE5pOWphbEdYZEpPNTJNSEhrQ0orSFZCN01wTlVYNjNT?=
 =?utf-8?B?elg4SGhxR1ByS1k4N2JHQnB2WkdmRUdETEdaSVlkL3hEalc5aVRYTHBmZEdU?=
 =?utf-8?B?RUFVdUhEUUpqUi9Lb1NIR0FKblI3OVZ4elhDUDh3eEtvTlVSaldETGJPOWFI?=
 =?utf-8?B?K3QzNCs2V1JvUEFaNDNZUWkzWkZlTHM3UGMvMlJsTGZpZkVtOFdNeFkyb0Fp?=
 =?utf-8?B?LzhtTjFmTEcrNVdSeno0Um5IWE4zeHVLRXV3TXZwcUtVV3RkNjdRYXUwVmVw?=
 =?utf-8?B?bG50RUdWVU0rYUdYUmxWV3laR3NvSzYzK3hLYXhNTnlVZzBQL2g4bmJtUXNT?=
 =?utf-8?B?YW40T2JDZjRUSVU2T3M3bGN4Q3hwbFFXU2V6S2Qyc1RyNDY1SlF4NTVlYzhS?=
 =?utf-8?B?RHFJVVlqd2N0Q1pxSUMvS1cyUzY5dzlKbE5uaGk5RlJEZGJacFNuRFJtcTc2?=
 =?utf-8?B?enA4MVJKTEJzN0dNaGRLVFJaNXhrZy9BK1VhUXNPNXhqOTdrRWd6OW10WGdD?=
 =?utf-8?B?M1FWbFdRQ1l2bkYwZVhFYm5RV1l5MlJDOFk3VTFiVmxGOW1heEJzQ3lpVWdY?=
 =?utf-8?B?UWxkNkwzdm1nM1UwekZJWlZWTzVaZ2lPWmhvRTRLRTZTT3JIOFlpZUJueVJo?=
 =?utf-8?B?L2dxenE3WGFEVlBPVjdpUGxCK0k2UVhaYm12Y05TZ1pnb0wxZ0Q5T3ZaRFY3?=
 =?utf-8?B?NWN2ZXZMc1FuRTJPcy9hUlFxVldXNGRFaU42VjZiZWJpUVdQOTJMcDQvMXRP?=
 =?utf-8?B?YWxJVE1tZlN2bWVGSUI0cHJMRm9IWmEydVJOUHpjeFNHeVRqdVdRTmtORXh3?=
 =?utf-8?B?aGpLa3Zmcm5uK2h4L2RGRmM1MFFCclFQaXIvYTNwTklDb3Q2OWVvcG5BMC9Y?=
 =?utf-8?B?aDVNNUQ4MHJPOFc5Ry9va0lTdUZTZllqNStWUTRhcmNrSEVWWW5NeTRpNkNL?=
 =?utf-8?B?ZHp0YThXeDVjYmFKRFZxeXBNN0hBQU5NRWRFOEVsbGlZUGhtaHhBM1pGLzdr?=
 =?utf-8?B?bmdvVlF5K29QUm9YRDdIYXFFT1RCc2pkWUFIRngxNmlWRFFmOWpDQWwrcjlZ?=
 =?utf-8?B?Q3hIVnlSM2pPa1pBZjRpaE5FVlc5cnhyZzVBUXFXbldaaUFvbWdKam9CcjhU?=
 =?utf-8?B?RlRmcnN2cUNVMjlVRmxGdWxkR3h2SW5Sd3h5cm5mS0NscWhxUldTYUJ1aHQ4?=
 =?utf-8?B?WHdwdk1QSUgzMXlCOHp3ODhSM1RabmhsYms0YUsxcTIrYkpMSWZpQzNISkcz?=
 =?utf-8?Q?9dVMDT/dVk5b8XPpkL+9+rI+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b36f4c5-2fe1-4187-260f-08ddb5831f7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:01:33.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlPghsA9FGMV3K2xJp+icxLjL0ZZKSpMDIRTw0Eee9+U7ZP7RDK5Wx/0HV/73wgNGugsdEoIHCcRraAZ8xw0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

On 6/27/2025 5:40 AM, Rafael J. Wysocki wrote:
> On Fri, Jun 27, 2025 at 12:28 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 6/26/2025 4:46 AM, Ulf Hansson wrote:
>>> On Mon, 23 Jun 2025 at 14:55, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> Hi Everyone,
>>>>
>>>> These two patches complement the recently made PM core changes related to
>>>> the async suspend and resume of devices.  They should apply on top of
>>>> 6.16-rc3.
>>>>
>>>> They were sent along with the other changes mentioned above:
>>>>
>>>> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
>>>> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
>>>>
>>>> (and this is v4 because they have been rebased in the meantime), but they don't
>>>> make any difference on my test-bed x86 systems, so I'd appreciate a confirmation
>>>> that they are actually needed on ARM (or another architecture using DT).
>>>>
>>>> Thanks!
>>>
>>> Hi Rafael,
>>>
>>> I haven't yet got the time to test these, but the code looks good to
>>> me, so feel free to add for the series:
>>>
>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> Kind regards
>>> Uffe
>>
>> I passed this series to some internal guys to test on a wide variety of
>> AMD x86 hardware.  The initial testing looks good.
>> Will keep you apprised if anything pops up.
> 
> Thanks!
> 
> It would also help if you could check whether or not there is any
> measurable performance (that is, system suspend and resume time)
> difference between "before" and "after".

Sure thing.

Just to make sure we have an aligned measurement methodology:

I asked them to do this both with and without the patches.

* set /sys/power/pm_debug_messages before running and then capture all 
the timing prints.
* add up all suspend events and get a total
* add up all resume events and get a total
* repeat 5 times
* calculate averages for the 5 runs


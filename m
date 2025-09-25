Return-Path: <linux-pm+bounces-35331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C267B9E67B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EAB425887
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9672EB84C;
	Thu, 25 Sep 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HbWAk1IO"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603292EA464;
	Thu, 25 Sep 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792852; cv=fail; b=fUrmt4+g8i4BxbEUKPNZuKKasD5NYhKVbl44JwMTFOxsVwvZxNR+1g87jVbb9vHyZkTybCxBsrOVGF7fjfURSQisd3ps+RZQx0p3UIL1IUkKQ/11WqdH0dk8WWmPaVKr0lH31lsx71NvTcNxn0mExgNj3Z/Y2cSoEM8N9rBzgL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792852; c=relaxed/simple;
	bh=kZVmz+C8spi9C6D199x+G1wqjf4dfJUPRaIFvNta07M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sheaW5nnFD5xYXkfDo7XbGVmo6hNqhj61nmlM5Bh1XP/ns2GBeQGKmFH6IWLGy55EiQa3Q+uIrmzOgzp5lKxWwEk4mOvza3QoEqfwEjp8cHSmglzVjOa8TDI1p8DoRjoCOzBc1ukJf/Nl6j6RNJmuSz2Bt6Z5CymDSYOISYmc2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HbWAk1IO; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaiKRokq64KXdiy2UY3HAgE7BjhHdfDT4/MbAztWawzAHraCWNQ8xuA231f1s+0iFPXMd7x6P3As5ryHIVK0J13XLu9a7RCIpnOwPP5DKBL9g9sSnRp1EXQfYHUqUAAVCnCHuw7b+y/0TJCTiaDDa9Ae5R3n84OZDXtbqxDUuYYZt2BMJbBodNNbJ3aH4e9xrjA6a0C9HTDbkOueQjHD/1ZJ4lC1+WiuuWlWAgIAsxw0myoz9REl19Ns68cOc7PeNEY9LTy+drlMn4RulZRAodbxCf5UweW2/+XfsV8wRT8t7f+ZExJl3AGC0g//56DdxGYwgHfkaqXAfPe7/OBgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCcr1vAnwo0Zmm5bfE4pYnJ2ToVGNcRv2Yh6fh4N4iI=;
 b=aJ4Sl5vNjFRV4qE+rczI9b6Jt3EjcoOIfmASGcYfSpqHvEchM6xgfikZ371gKgZLbtbrbRcJyAnRoQlKq/oNkvKsIRDjbnR5Vw4LKi7Bbmuxw3nFrEadRZx42tqh7KQAC/xd0y84gfskEQ0JgjT4660HmK1yJj+G30uuNLfFGUDQcK5LEeTFQVZjqOrT4o53Mjo4+n9GPcNLxUm2TxgTFeB0/8LSwR6hEcUjpfrfT07NeqLyeNoj3FvOUawe89TSCzpncB/q61hURCV8qoTV0IQ9anqYoVU3C7s5Rmua4rDa0auz2p+CffpF1ULfdVWmbq7CKBzwUfx8W9S54mfZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCcr1vAnwo0Zmm5bfE4pYnJ2ToVGNcRv2Yh6fh4N4iI=;
 b=HbWAk1IO+GqpAmH5Gr1H3tOVl8qRCqt9g0AKR6KiRMH2w0CJTN3EHy2Kgz1A2xZCCVdxUNh8kfA1b7Kr0lq5QK49sgizjh4wXVNuu+Q735iQeS4gNQKGidKB4L8rO4fWyaasr39pxVNlI6+FzdGafiscYW69zBWQu+N8qYa6rwlS1qZD7k/mTIszhl8/hpcEqiSSAgvSsC1rfTaTSZl+SaDRaj3QmtdJ21W/JoExEfinKVPVVVXaoMKpk4sucHgwf61L+3Pl+fnOgbTg2MA8DApFRGopGObHCaWKliTMBgtshCb9P4/2tvXAsybnw43kho394XXh159l0UyRSBglHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:34:07 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:34:07 +0000
Message-ID: <9d084f85-1368-4974-bbf8-588140422040@nvidia.com>
Date: Thu, 25 Sep 2025 10:34:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org>
 <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
 <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
 <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com>
 <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
 <CAPDyKFoPOejFT+=OBoLTBXj5GYuHFwwnY9qGROTynrtHT=mCAw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFoPOejFT+=OBoLTBXj5GYuHFwwnY9qGROTynrtHT=mCAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0257.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a11d19-0ce7-4952-8b51-08ddfc16acb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnhoMVpDU2lHK3E2TnpPVEpUZlNaMzdDV3RnY3Z1M21UZFZXdVNoWiszeENw?=
 =?utf-8?B?bVI0YzR3dkdXWS95L1lvb1FMMXMxSlJWYUpUMWREMzFpVUNqZGw3TmhPUnY2?=
 =?utf-8?B?ZmVCYmF4WTRqOVNJN0RTbkNSaVBaQmpLcDRKOW9DY3RDYTVMS1V2NzVybTZC?=
 =?utf-8?B?SEowaEhGanN5eEtCbVVYR3kveEJNZDIvWmRQYkdGL2ZYSytPblpBV3lZQno0?=
 =?utf-8?B?T0VhZHJmR0RYcjBhKzlZVlQwc0huNWF6c2ZSS3RQamRQYWhqR1pKVnNkWDk1?=
 =?utf-8?B?aUFUQTdXRGVmY0RFZk9SYXBiNVJHRHRncTJiK1dZWmxDQzNIb3pyUHdHZDRj?=
 =?utf-8?B?aGx4Qm5SRUdHbDNOUlFOcS9MOXE3Nm9GakJjTzJ5TEVNVW42Z2tUTmhhYWk3?=
 =?utf-8?B?RjdCR2ZUVlloZ2pYK2RDL04yNU1qNUczVmxrSExTanBySnFLditzU3pCL2pv?=
 =?utf-8?B?YWxqVzBuZVoybTRhWnpMQkhGdElYZENjRXVCdHRDZUtPblMrcEV2T2NSUHlG?=
 =?utf-8?B?R3BvWFUxM1NiYkN3WXNJUjQwSFA4amdPVEg1VE5EZTFBZzZId250aDl0UXBX?=
 =?utf-8?B?L3Rmak8xSjNWa0Q3SGxoV1E3S3ZZUXM2SWFOZ0VFWnlqWnB4V2ZRaS9iQTdq?=
 =?utf-8?B?TmtZeEZDYml3SVhVV0o5NVVubEFTblpXektIL0NEbkZyOENSQzJIWjRKalNB?=
 =?utf-8?B?NGZNSFlYWi9rWUY1UlNoY2toTjhKWXJjRzhNbTkzRTExcDlVZTR1S3lZejkz?=
 =?utf-8?B?WlEyWE9MRzdqYUhvRmV3anlkTzU5dG4rTTlOZklrY052QjJUSkxmQkxONWNM?=
 =?utf-8?B?UjloYVoyY1JzTkhkOGcybkZ2QWpuVFFKSmJFc2NIY3lJa0swRmlBTFR5STF4?=
 =?utf-8?B?TmRVbGpaeThvRmd6UmtLcnpGc0RENW5xZ1E3MDhRR2h2bkZ4eGN5bzZFYks0?=
 =?utf-8?B?K2xjV3pXbmJWWDlJN3Fyeng3ekxrN0Q1VS9veFlNYXduUWhpSXh2cVAxNjVt?=
 =?utf-8?B?eUJFdmVmdHFabG1GWktVNG1JR0FsMkZLMFdWaU45b3FKU2tyS2V5YnNtZ0ly?=
 =?utf-8?B?V0llQjQ3TXdqT0JoMklndFZYSHZIQ0JmSCtFUkoweDlhUS9Fdndjak5IZnBP?=
 =?utf-8?B?VFJ6OWpiVFBaR0FtUExGR095MCtwTk5HYXBBTzlxL3Z0SlFHNEs5ZkNkZ1Vq?=
 =?utf-8?B?WnZDZy96RXpnWkN4M21KdG9wQ2krbmNsMDFGWm5maStKTnJVY3FQSWxBZldu?=
 =?utf-8?B?TExkR0FhU2tNbkY1ZUVLMFpBVjZyditaTm1ORUlQYmRzaE54RzdqUk8vR0Nr?=
 =?utf-8?B?ZFVYb1A3VDdLWHRSMGFBQjhvbC8zdm1WY0NXSUhLQjQ1MG1tTWhqK3o0djRN?=
 =?utf-8?B?Sjg2RUxVR3NrYlhRSXM5bzd3MTN4ajZwdWgzL3k4MXlFdEhOQTU2WFhLY3hi?=
 =?utf-8?B?cVlGckFaVUp2dktwZWpqYUJYM1Jtc280VGVvS0NRWmttbDFZazd6S3JWK3Fv?=
 =?utf-8?B?SFRWMDEwajAzNnUwb1IwZ0Z3TzE1NkVQSDIvQjViaWZJeXBNVlRsNThTRE03?=
 =?utf-8?B?MkRGaytld1BJbnNhU01OU3JUdTg5WDQxTi9rNEtzREpTSEh5eks5NitOZlZy?=
 =?utf-8?B?QWFzS3JmOVNOdEM0UmNLbDREazNETnJWOGQvMnllUkdPaitQT3RvUGQ0WFV6?=
 =?utf-8?B?ZnBmOXlKTUlSbkR4anI0ZW5HUkNNNmNXOU1vQVlRaGY4RlE5L1BUbk9ocFE5?=
 =?utf-8?B?dUd0WmtWWTZORHFaTTZjdjVxK1ptY2xzaEZVOFFNMy9UelJTOEE0RGZxa0cv?=
 =?utf-8?B?dDg5anZXRWRHUE5hemNlNDBYdmRrSTJLdm1aNjRLQnZ5NGkxUVdzcUlGbFkw?=
 =?utf-8?B?QW44OFdxd1hMVldWSkFoUkI0OXhqVFVwWEQ1cGwzSHZUNElEcDBtaGJQRE1J?=
 =?utf-8?Q?Q5qkLmADX5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhKaGNGYjh3bzhhdlk0L1RLVlBWWm1PMXN3ZmV5Q0l3alVrRVNTcmgwZENT?=
 =?utf-8?B?cTB2U0E1K2x5d2FRZU11WGtVUXlPSTdRYnVkMGh4YWZ0SVUxQmhQTTV3RHlB?=
 =?utf-8?B?c2VyTlpGaUNiYVdmNjVUL3B5OFJsRStrTkhHNVliZDh0TjVwY0RDZkhaMGln?=
 =?utf-8?B?MDRnOUdMUWVVVmFUeHJ2YzhRdmNsYWlkeFF3cjM1YU1KYmIvSWNYR3lhamNv?=
 =?utf-8?B?c0VnUXl0c3FoaUw0Rkkwck4veERyaTdlM2hkbzNwTnRKaUQ0N1ZKNlV6MGM5?=
 =?utf-8?B?U2UrMEZ2WjBjdUFtK1VNU0hJdDlnM1UzNkRKR1hacDFtUEVQM2dlNzRwc0w3?=
 =?utf-8?B?Zk5JMi9ST3FYSVArbUdoZ3hRSGRzRWRySnlJemlJWm1RcjFmSHBWR0FpejNN?=
 =?utf-8?B?S0o2MXRVUktweXZQT1pLdmxmdkQwMmg0cCtpRm9qVU5kWFI2SFNzL2FoM29C?=
 =?utf-8?B?aUdRRDVEeHBvUHVMeWkrRUxreXUvK0xDSGtocnlEWnlSRmladFROMmFmSlBV?=
 =?utf-8?B?LzhTRTNySHBCeDJJWmFGZm5ETHluM09OTkdGNytZQnhSTnhqM09IRUtwOG5Q?=
 =?utf-8?B?RklJK1JYZUJ3NFYrc1k3MURnb2JSUDdQL0NHckloUEZFNlkxbFVXWWlUR29Y?=
 =?utf-8?B?L0pwZnBqNHpmNTdNY1p5anhoYlZNcWFiNzVHZkZOUHpQdDh4cC9sR3ZqeEZO?=
 =?utf-8?B?cE9veTR3aDU4MnFqQlhDVktUSHhWUWpDZ29ueGRwejBUZU5zRnBDTnQxamxa?=
 =?utf-8?B?djNVdGNDaDRsSGJ4REVxYUZnemdITjQ0LzgyUUZ6VjQrNWU2M2owa1huREQr?=
 =?utf-8?B?dlNqZHZNeCt6ZjFaUDRtM3VnOUQ4cENtRFZJTWZJNzUxRHBBRmJCOXd1VC9m?=
 =?utf-8?B?MCtHMmlDeDdlVGpMdHBBeW5qWktJU2c4aTFOQ1hlTVdPVmt3QmtTdkZNUXpw?=
 =?utf-8?B?ajhCL2xCSGJGMmV5RC9VT1VYNzFlbXZzRHR4QWNrMXFSalptQWdZMlh4K00r?=
 =?utf-8?B?RHh3YnR2VzZITFV5R3IrVnU1K3JkMjVzL0xzV0UzQ29HSEJZSWJDQmR0S05v?=
 =?utf-8?B?VEtZUGRXSGZhVEljTnZOcWpQbXZwMy9pOXhTSE5MQ3ZvNzE0Si9TQ2tUMmZP?=
 =?utf-8?B?eDNtQVh2UXpkRmRwd2hBMTdPdEVUbGVnMEVXR3FnY25kNGx3YXFVRDkxaFph?=
 =?utf-8?B?RlFYM1MxdjRHV1MxY1dFUjNpRzl3d0tQdlNZL2FCSDNSNmRELzV4emIyTjEr?=
 =?utf-8?B?UVE2UHpESldRYzlvcTNYaVN4cnlrdHhyRld2dmszQUZRSExVNit0b2RKckdC?=
 =?utf-8?B?cFNYTmhyWnFaNEpUZGx2dHcwOTlKOGk4a0kzNHB4YktuNVNPTThNemdkQU9n?=
 =?utf-8?B?OU4vVmRvdFZnVG9XcklQRUJkMk9SYmc1N1cvWFlNTGpDN3FRMFE3WlYzcWxO?=
 =?utf-8?B?L1EyRVdvdzlCaCtVTDR0RTFzVHppMVZaQTMzalE2YmRMNkg1WVNsWWhSSzlh?=
 =?utf-8?B?RGxsMm13enR3TVpWU01PcFB0OHhIRm1GMkI1NWoxWmNSRERQYUo4OUxOKzRT?=
 =?utf-8?B?R0lFREdYaTA0QUNrUkY3ZXV6ZXdQVzA1dXk2WFR3Z1hLNTlYcFd3M3J0ZndF?=
 =?utf-8?B?dUJpNEVOOFN6WGo1YzNta0FDMkhlVThZZDNXRkxjZTZsNEwzM3RZSk5KUlZM?=
 =?utf-8?B?TzdvU3FKSktORDdrTnNFNmhGUGxHcE1TeEZsRHNENjJMY0c4WUdYSFQ2Z1o4?=
 =?utf-8?B?TkhSK1JLTGFpNUU1VUh4YVNwSUJDT2hVNjhwcXMvdGRuRzBTU21QczllczBF?=
 =?utf-8?B?c3pObUlTM1ZLV3o2SEw2NjQ4ZWNPWFJYNDBpZ2NPYjUvdjhYVkxGYWNBVzVM?=
 =?utf-8?B?eE52ZVZMbzB4S1piVUxDOUFRbUpsM0NLc3VvamhmaldtMTBINHR4Y1E3Lzh3?=
 =?utf-8?B?USsxN0VTRGR5U0s1OU5BZFU1VlFzUElObGtzcmkxREg2YXYwNUd4TE5vaGhL?=
 =?utf-8?B?a1Y4cVU4MUt5OWo2Vk9EamhCNDZ4UWd6SVh2U0FhZTF5ZXFFYStyd3JlQVhC?=
 =?utf-8?B?dmR3dWhHSkVEbVZ0Z0xBc01MOTcrSC9hdU1aN0tZWDV5eGZ4VlI4R01IeXl5?=
 =?utf-8?Q?/clxn2jESBlYxl8V6LtJim8LM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a11d19-0ce7-4952-8b51-08ddfc16acb6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:34:07.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Yj9jsA7Awg+TWQ2Io5mnLNp+0WQSNqP26BBp8Sivj1r16FhHa75bWvdJDPnlRLki7oocXjYiV9WRUh5YtL8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570


On 24/09/2025 16:53, Ulf Hansson wrote:
> On Wed, 24 Sept 2025 at 13:41, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Hi Ulf,
>>
>> On 03/09/2025 13:33, Jon Hunter wrote:
>>
>> ...
>>
>>>>> Following this change I am seeing the following warning on our Tegra194
>>>>> devices ...
>>>>>
>>>>>     WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
>>>>> 17000000.gpu
>>>>>     WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.cec
>>>>>     WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
>>>>> 15380000.nvjpg
>>>>>     WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
>>>>> 154c0000.nvenc
>>>>>     WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
>>>>> 15a80000.nvenc
>>>>>
>>>>> Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
>>>>> and so should Tegra be using of_genpd_sync_state() by default?
>>>>
>>>> This is a different power-domain provider (bpmp) in
>>>> drivers/firmware/tegra/bpmp.c and
>>>> drivers/pmdomain/tegra/powergate-bpmp.c.
>>>>
>>>> For the bpmp we don't need GENPD_FLAG_NO_SYNC_STATE, as the
>>>> power-domain provider is described along with the
>>>> "nvidia,tegra186-bpmp" compatible string. In the other case
>>>> (drivers/soc/tegra/pmc.c) the "core-domain" and "powergates" are
>>>> described through child-nodes, while ->sync_state() is managed by the
>>>> parent-device-node.
>>>>
>>>> In the bpmp case there is no ->sync_state() callback assigned, which
>>>> means genpd decides to assign a default one.
>>>>
>>>> The reason for the warnings above is because we are still waiting for
>>>> those devices to be probed, hence the ->sync_state() callback is still
>>>> waiting to be invoked. Enforcing ->sync_state() callback to be invoked
>>>> can be done via user-space if that is needed.
>>>>
>>>> Did that make sense?
>>>
>>> Sorry for the delay, I was on vacation. Yes makes sense and drivers for
>>> some of the above drivers are not yet upstreamed to mainline and so this
>>> would be expected for now.
>>
>>
>> I have been doing more testing and do see a lot of "tegra-bpmp bpmp:
>> sync_state() pending due to" on our platforms for basically are driver
>> that is built as a module. It seems a bit noisy given that these do
>> eventually probe OK. I am wondering if this should be more of a
>> dev_info() or dev_dbg() print?
> 
> Yes, I agree. We have had similar reports for other platforms too.
> 
> I intend to send a patch for this in the next day or so.

OK great! Please CC me and I will be happy to test.

Cheers
Jon

-- 
nvpublic



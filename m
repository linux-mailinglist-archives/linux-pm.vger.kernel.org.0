Return-Path: <linux-pm+bounces-26663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918DAAA99E7
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA61890B1B
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827426AABE;
	Mon,  5 May 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x79/ZWce"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04395265CD8;
	Mon,  5 May 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464409; cv=fail; b=ZG+UwCiavoqIVTiKIvlP1R+kQ75LxFK/V3vmcngDFJwbYmN8Sg+OaTBungC5rPPwgFYxLg7dIxcagxf+zAkMEMYdE8keKce8R0ML449gF18eJBMBLUgZkvQ3thG4knNf/xb/2MRn2ZxlFpbXpGYiN/NWUOBAV9+24C5B9uZLSlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464409; c=relaxed/simple;
	bh=R8le/maXXANjSKVUsdmAAtPutpAlcz0XWB6oM/XXbCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U2dl9gIZmdOycwLKv+wEd7r8S6NJSyuc5lhh0zXTqXT6jsQUF97TBDwYFGX0suYI9Xm7lITLSTbVFXpl/mOwdB/9nDu9fqHme9fhmG7Dxst0aBJR84F1moaP4DzsM2hJmpgAonjdiUCzRcJSGBKksqSeiCI0pt7ORIsRfXMU86g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x79/ZWce; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6L1mW/jgC/UY3m+BTrPDq+ILSXKMyBnubGxgNiH4qaWtvCC2mAJQO9oKXUoH280zsFk/n5Nk46FJ74TBVWlD0zDwgoRCTQiPAjlTk3izhB7lfRzU3NA5Gfd2DDNb2UkLFuzhn9hBrvflDrnJPGoBRw/xi8ys+7ChK5MOWmL99r0veBmyp0EIJMFiKjHY4NZMi6empGNsffCzXJ9Heh+Hcv4HgeDTq53JdJ1eNVDcElLPc2udGdSb6ksQqT0XeQ07kcYgyTTp2m5iVpnLxuQWUSL2TtSHv4cA2OhbfSOB6g49Z7Jtp1atRMezrwBxASKtF8qiZ3uf/SSgqv/0WGtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7nBbteEuAp6QXKZpzoU2U3UISrFSrKNpv+hrXnTBeE=;
 b=hLhjKYpyulQTafP9vt9YJIjIZiMdA5LMe2hisTkUeEEQy+EJE0J7clrjFkXOTaAbrW9EDkcj9tNusZtSouAs4IxfE5l1mOXugIsGQqtF7huJTYiukdsfxyWguSvxy10ltIud/3W9gO3puCAi9o1jAup9zMtvit9zMnFnT6zsr76ERcSgehoQHAwkmzRcyfXpwj5zLtF7XRauxXx8woK1SWHsbq/pA/cQGU8QAouooSO4yY/fnmOTbo+jahVvjMwifZY6sQ4g9ZlpqOfeXVGkZ7cN2O/yemsnRMPiEJe3VONSy5h5eW8b59gabZRRZ/Bl+8hMmyMLSYpcq1BXOX9Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nBbteEuAp6QXKZpzoU2U3UISrFSrKNpv+hrXnTBeE=;
 b=x79/ZWceRBzwUks0lZJZNStKzeYQy6BbZQ7BR3fiJTTN11cWpcGV9lx9cmI79FEXnQ0To+BW8rPvLR45gChprYKg/+5uCwNdXaZfZW1Mu/1Wq9FkVdf1w3KJmfwecoSrZ6DuNLosIuksASQCuctc9Nswvl9ip0ClyKd4NA1tJbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 17:00:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 17:00:05 +0000
Message-ID: <05544c19-d4fe-4561-bd8a-cc6624353a99@amd.com>
Date: Mon, 5 May 2025 12:00:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd-pstate-ut: Reset amd-pstate driver mode after running
 selftests
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: ray.huang@amd.com, dhananjay.ugwekar@amd.com, perry.yuan@amd.com,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, gautham.shenoy@amd.com
References: <20250430064206.7402-1-swapnil.sapkal@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250430064206.7402-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:805:de::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: d76b6b8f-1601-4aa3-53ba-08dd8bf6484b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVRUeVNyYWYvSHo1T0M0V2d5NFYvMU1tYnA5YjNuek5hZ3R6alo0V0tKMnNV?=
 =?utf-8?B?NERKYWlIMjl1amt2LzBrOHN4Ym1uMTFwTm84OXBQcnEzUFNqRXpHcEdWYmlu?=
 =?utf-8?B?MDNrcldXN0swMEVRdEt4Yk1wWGdlREJUcVk5NHlPOGxlRGgyL3dHeWNaQXZh?=
 =?utf-8?B?NWJScFlmM0ZhejQ3Um1aalNNRk9XZ0Rsdk1LVXdraHM1N2lQNUdBWGh3QnBw?=
 =?utf-8?B?QVI3d2tmZHFNcUxoZlpwT25rYk9uUkVKN0JKS0E3ZzRNL1dnT1R1a0VBU09O?=
 =?utf-8?B?dnRGYUExcTV1RzQ4a1Byc2hCa2pXL3VQT1paSENjUWM0UDJma0R2YlU5b0Ir?=
 =?utf-8?B?enJodDNzMktQazIwREtPNjYxclBVaDZFVW13WGt5RjhhRzdsTDlmR0FqYlVk?=
 =?utf-8?B?T2hFbk9oVUFsQ2Jsd1BYMlk1cjMxUVNXQ2F4UkJpQklkalhzdWdxSGkxUXhB?=
 =?utf-8?B?OFAvM0gvNElLMzhHQTNmandhczJjQy9NK2lId1BjSUlQcExsYjdNNEhTVDJB?=
 =?utf-8?B?RXR1eFBhelRlenlNOC84eDkrRFVKZmVQVndvMkRZUlFmSCtRRDE1Szhyd1pw?=
 =?utf-8?B?dnVuZXRjYm1KWXoySEJNeTFCT0JxRlcxT0lzeWkxVFJ6aE5PRTM0Vkh3bmdM?=
 =?utf-8?B?MXBZQ2w5RDR1K2hrRjNuWWc4a2g5cFRCQjh0b0ppdm9ydmZ0cnZqZzI0Sk1G?=
 =?utf-8?B?ajQ5b1UyRk10dUcrR1JWOGsyaTZnallLeDF3OXBkRk9QMVRKa2VlajNONk9B?=
 =?utf-8?B?T3F3SHNpRzR2OXdNbldxUFFLY0wyVkdqVjFRK1hBMjhycEMwOXlEVzN4akhR?=
 =?utf-8?B?TGtMc1gxWVlhcERiRFJvTXFUbUlFbDFIOGpzZFdLZ2ljalJBdk94S1NIV28v?=
 =?utf-8?B?QzhRMnJ5ZVRBL2dDVlBUMmo5VktIeVNPM3YyRTE0WkJwbTVETm1haHF2elBp?=
 =?utf-8?B?VFRtei9oM3d3dy9XY2VabXJyT20zVHpkVWdNZEt0Ry94Mi9uaTVjYXV4eGVa?=
 =?utf-8?B?eis3TWhVbEZDeHJOb1JMYy90R2Y5YkxQeW1WRzc2ZWkvMWk1Qzc4dHZ0WG9P?=
 =?utf-8?B?bGZVZDNGc0pER3hGRUNtZ0pTS0dBaGZDZ0hUckI0MWw5WURKQ3Vudk93UmRx?=
 =?utf-8?B?VFhvSWYzaXMrUDRWTGxGZHRFS3hFdmJqekFKblZLa1ozNlJwT1RxZEE5WlEw?=
 =?utf-8?B?M2VOOEZmeDlvV1VSWWpDT00vSlVvaU9KamVqbWFMbjJEYzN2WkFEZElpSm91?=
 =?utf-8?B?NXU2TWZSZnBOT3VjTUVVY2xmYzRtT2JtQmxkLzZrTVBNRTRBR0VWdldmTlBM?=
 =?utf-8?B?VDhIZkFIZTdQRTNydjc5TlhFMUlic01NazBrZ0g5YXV4RmcvVE9FZk9meDVO?=
 =?utf-8?B?TkhscXQvaFJjV2svQm9lMWRSVzFncTI1aUlFaUZNdVcvbG5qbTZCdStIL2Vw?=
 =?utf-8?B?RkJZTlFhcnNFaEpTMng5czdkT3BrUi8vQ1JXMTliTU90a3RZRGt4WDZ6N2ps?=
 =?utf-8?B?cm9MSU50M3hmUjBlcm9aNi9xZTRBNXNRTHp4bHpEU3V6RUMwQmJZWlZ4Sjg1?=
 =?utf-8?B?UDhiN3Q2a2k1ejcrZUlNdk9XUzJiKzY1RTBhN0l6elBVNEgrZnNLOWdtZGlQ?=
 =?utf-8?B?UEhNWHY2WGZ6anpXaTQ1RTdFOG0wMDFBTFNQVDlCajBXNVRIU2RyV0IrME1y?=
 =?utf-8?B?MEpVWWxUMjM4bzRUSVhmYm9KVkpIUlowa3NoYVRzMG1McFRXSDI1ZlNMdjR5?=
 =?utf-8?B?eTdBLzI3S0ozMFIyN3AvMUg0MXhObFd3Y2hNcC9nVHp0ajluakVnVFMrNlZy?=
 =?utf-8?B?WGtMMjk5MG1XV3FtQ3l2K3haNmtlUUozOXcxN3Z3dFNSTFNFV2xkZWJwa1hx?=
 =?utf-8?B?RFdnbGtNTCs5cTFaYWh3UTZ1T3A2YXVmbkJZUnlKOU9odnVYem14T3E2VFlW?=
 =?utf-8?Q?bRNW6IyO4ZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUUwU0NoOUpBMDE0bUlOMWo2T0NlVmo5RVQrWGZjWFo5TFBReDB4WFd2U29p?=
 =?utf-8?B?WUk0T2hPSXYxVGV1cnRuVlRmdmJaRFRmVE50dmxLLzRJdkdUcjg4SmxzVk8w?=
 =?utf-8?B?TlQrMUl3NFJSaEVBZGNDSENrZVpVY21uSjBzNmJnL0VrRjZrYmc1ZDRYTWNC?=
 =?utf-8?B?cUE5cHZsTzE2ZEtBcVQyYVVwTXdJc0dWVUhBdklxRDE3aGJhRlVFaDgyMENL?=
 =?utf-8?B?RHJ2c3RsOTZFRUx5a1Z6TGdyOXd5akM3WnJNSWhVRjl5VTRYZmhYc1Z3Tk9r?=
 =?utf-8?B?NGw2QWg1anJmZUgrS20wRGZ1NllFMkFjNVlYVTNOYW9Ub0pvbEpuOTNNRG5u?=
 =?utf-8?B?NUk1eG9panF5OGN2ZGpDUnhBdFhQUVJla0pSWlhSR2wweWZJRTZqNjZRTUQx?=
 =?utf-8?B?N1NDekYrbTFCdFJVUFlvNVExL3BHZFd3d2xjOUpxMzUwZ09yRTNzM0RPR2lw?=
 =?utf-8?B?NWduY0M3anZINzBhdVYrS3hKcTlpelRnbENaQUFFck1FZHpiSk9kT1gwekNs?=
 =?utf-8?B?SWFjOGNNcndLcFdQZHg0amRkVVB6SVdqYks2NjVxVzBzc2VvSFZ0bUtpWnlx?=
 =?utf-8?B?SFpJeldiQkQ4aTdCY1R5QU1wc2ZDREwvaTFmOFNvclloN29OdWNOTkRpNzZ4?=
 =?utf-8?B?NnpDcVFZd3RkQ0dMNnVwLytRZFhUaUJ2QUQzblFlSk80S1QzdGFrOEZaVUFH?=
 =?utf-8?B?WGJETHRmTkdUOXRmUEU3OHlUV2NocnRPdjZNZW1laG5HT290YTdpZ012OUVz?=
 =?utf-8?B?ci9PcWE0a1NSdkdiYkcwVm11S0JqZTNLb2tjWFgvdnVGa0lNWVBOT01zaExJ?=
 =?utf-8?B?Y3BRbXMzcnFGeDlyMWN5dEJFVjNhME5BK2FhQjY4MGdXTnRTbk9BYjN1NUg3?=
 =?utf-8?B?Z0J5VzVvQVN3ZER2aUFka2FaU0RRcnNHbnhYakY5OERLeDRSOHEyQWxiWThD?=
 =?utf-8?B?cW5JM0JmMjBLVHBHYXYzMlh0d0VoczZ6b1NMcmFocUFnVVpVZ1NzVHY5cm1P?=
 =?utf-8?B?TU9OUzNQVWR0dUhxOVdIcStiUHkvb2JaRThCYUFaVXRzMjM2bGxyMUV6Z1ph?=
 =?utf-8?B?RWh5NXhEd3dScjhLUzRrTzgvdytBRXhzK2phbXNxVlZzS2x6UVpialB6Zno0?=
 =?utf-8?B?d2RkTzhJdG9Rb0dROWhXcTJxejFKT2wxUmVxRmlseStlcm1XcGc5ZW12QkRE?=
 =?utf-8?B?TWtzWlc3MEdYLzdWWTI1bEdSMHZoY0dsU0hqejlqYkFxakVLblI5Y1FIMUIx?=
 =?utf-8?B?RUhPdDZ5M0JHaVVTTVJybFFwU08vQ0Yxd2VNUmljTHZ5TitMNDFwNUZiaFJz?=
 =?utf-8?B?bFNMRmF5MFRlbzRnaFdCdER4TGlxVVlIVTM1QWF1c0h0blNZdzJlUmlEZnMy?=
 =?utf-8?B?eHJ2bnFtWm00WUxMNjlyaWN1UGQ0R3N0eFAzOXdGbXNkTXpVeXVMVW44MFA0?=
 =?utf-8?B?cTc1S04rZnc0S2NLZ1hGNGRYUEh3ZWsraGRHU0RYVUlyUk43RjNXL1FYb3BI?=
 =?utf-8?B?Y1ZsWS9mRzNNM3FHeUg4QWRITEFpSlR0VFF1YjlCZU1uckd3eWV4c2pSeVV6?=
 =?utf-8?B?V2l2VFI5VHZ3ODc4QkNRcDIyN3hvVzFkcXcvVW5pSEN0b3kyWmczeEVlSXQ3?=
 =?utf-8?B?MElBQW5jaEFnNHRPOWZadTJIOS9MdkRZaHJlMHVORGh6Z1BUUVUvQnlGTWJs?=
 =?utf-8?B?SCtiY0FEdWpENnBzVFFVTUdjUWk2UTZTcm0vL2hkdVBpSzlDREkvREVLSGZX?=
 =?utf-8?B?SXRrLyt0cmJRVEVGNDZyWjVCbHFxaHkraThsTjlLYzRGMURYK3NJQll2Tlhj?=
 =?utf-8?B?UUl6RE4wQktyNjZzMXNhU2JZZlo1c1NZbnhVSjZmZzRocFYyVW1SOUtnREpK?=
 =?utf-8?B?QWJDY2dYaW8wbWZjdTZ0VDdReVY5TGRmdkh3b3M3WmRVZGw1SEdrWE1ubk9o?=
 =?utf-8?B?dTEyRnhnZ1ZtcGJsaUdraTdzQkFlY0FMZVdzR2orUU4rRHptelg3d1BzbHRq?=
 =?utf-8?B?eUFlWm9mUDN3Z2ltVE51TDA5L1hLemVWa2lKZ1lCM0lpWFFJZVhQRVo4bVBY?=
 =?utf-8?B?TkltNlNJcURRQmg0dkRQeDhGUGNjd25mWEU0TUMzTEwzNHBOSnZsUlNzSGQ0?=
 =?utf-8?Q?o7ay7h8YmnoWIlxITNvF2mSJh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76b6b8f-1601-4aa3-53ba-08dd8bf6484b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:00:05.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zyKsexqk8GONYp68+KtJeNfNgD3KHgrhY+pvthqv+YO1G3v6fEgeMR4Xjd4ysu9dGP7e3jWAse/lG31V24IFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

On 4/30/2025 1:42 AM, Swapnil Sapkal wrote:
> In amd-pstate-ut, one of the basic test is to switch between all
> possible mode combinations. After running this test the mode of the
> amd-pstate driver is active mode. Store and reset the mode to its original
> state.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate-ut.c | 19 ++++++++++++-------
>   drivers/cpufreq/amd-pstate.c    |  6 ++++++
>   drivers/cpufreq/amd-pstate.h    |  1 +
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index e671bc7d1550..30835d0e4994 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -242,6 +242,8 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>   static int amd_pstate_ut_check_driver(u32 index)
>   {
>   	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
> +	enum amd_pstate_mode orig_mode = amd_pstate_get_status();
> +	int ret;
>   
>   	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
>   		int ret = amd_pstate_set_mode(mode1);
> @@ -251,16 +253,19 @@ static int amd_pstate_ut_check_driver(u32 index)
>   			if (mode1 == mode2)
>   				continue;
>   			ret = amd_pstate_set_mode(mode2);
> -			if (ret) {
> -				pr_err("%s: failed to update status for %s->%s\n", __func__,
> -					amd_pstate_get_mode_string(mode1),
> -					amd_pstate_get_mode_string(mode2));
> -				return ret;
> -			}
> +			if (ret)
> +				goto out;
>   		}
>   	}
>   
> -	return 0;
> +out:
> +	if (ret)
> +		pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
> +			amd_pstate_get_mode_string(mode1),
> +			amd_pstate_get_mode_string(mode2), ret);
> +
> +	amd_pstate_set_mode(orig_mode);
> +	return ret;
>   }
>   
>   static int __init amd_pstate_ut_init(void)
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b961f3a3b580..af08049fe96f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1305,6 +1305,12 @@ static ssize_t amd_pstate_show_status(char *buf)
>   	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
>   }
>   
> +int amd_pstate_get_status(void)
> +{
> +	return cppc_state;
> +}
> +EXPORT_SYMBOL_GPL(amd_pstate_get_status);
> +
>   int amd_pstate_update_status(const char *buf, size_t size)
>   {
>   	int mode_idx;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index fbe1c08d3f06..512d5d97806e 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -119,6 +119,7 @@ enum amd_pstate_mode {
>   	AMD_PSTATE_MAX,
>   };
>   const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
> +int amd_pstate_get_status(void);
>   int amd_pstate_update_status(const char *buf, size_t size);
>   
>   #endif /* _LINUX_AMD_PSTATE_H */



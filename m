Return-Path: <linux-pm+bounces-15787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D39A0F5F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD391F238C2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6F20F5DD;
	Wed, 16 Oct 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b2a+nhkR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876720F5B1;
	Wed, 16 Oct 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094983; cv=fail; b=n+LjmRGGf2eT4eCG3/Wq6IXomFhQZdkXSOcvdx4HI5nNT7Sw8x4qVnEFcDWo55Iz5sk6VvwLagP/JfkjBMiafvOTXb0yMLY6Xy2otlxj8LaRckHOwbK7KeXcfT1HYLZFQmTF4BX7JhPsu8i8y5ed8ZrpH3KGrw0+D4IGRhEFeDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094983; c=relaxed/simple;
	bh=A8A+SJbbfbFRYCaMwMTBf2/xLzJeJANoFcE+WAvvESo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXs3LVzZvyEBbkvOrf9xUCy/ruCUDhtPlQC+vKLPd9Ux/mwVGlZbYpz4BQxWCNzBIwDAuNm2XX2qXwQojynf+bANUnt7vtAGN9Xa1jPs8NuYm0qzZzkr+luTGxG7VKIG7QeCdO7hAu2sIBXE9iPMY10DSOszx0W41E++2/+UAmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b2a+nhkR; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwIURhIHBtKr9Y0vc23NMW9Gw9e0zQeG4FkMbSq4cqqNfz/d/qYQKubi7lWa3ulLNqhht7JwWNFp3b48jyV6cB46IbSBv29XMXyD6NQizinV8IurX6nuWevRHhiLFHHfQo8K05b0GRARM7uoUA17YEPsTkiCqtZFmG0yZxrqO2lq/chwHbIAr2kzoXxx/vStPf4PcCo4NEWG6rSacpoQqWH4wVM+/HRNo4BjHZRrCVRRWkLgDsBHqRDhtMhfpnZEvoY/uOzRq6r3F5wxbSJ9Yiugyv1EBXfvQkGcn/JdtlDy+vPGhs4LyxWCPO+7aEbCgnRldA+QFA27dYEWFRVvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuLPiA5/iY8hmINCjV2Xt4suJmJB9chWFgjkuncU+CU=;
 b=CvkifZqGIp+dh4UH2iupbr2hrKAjhuqjVVocmy9Q9pJV0jGNXjX14RUqANx3y8ZjpqjeDUQ41fv3TqeI4gWWFH+QO+Y9wbHBngMLhX0e1udUYHNC32qespAbA4qkD+uOrDI0gi9JXEz7hzX9uqsTog9p5dJ3DJXFChEIqeNtiKcfSZAiKWsJ6i0M+PQFs8cyeNvT8adMpw/6Uoso5lQHM//n6AAmwLDoEruZUwtgFbKD10ioWO8FFQNJbqAbVcUpeiFBPigOVArVHg47uVqE3Zl1vbuO3HW2bKVOnqtD3/a8gNmNjFCAJCgXlzypwroBfpXAuh7j3wF8z1XdLZ4IXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuLPiA5/iY8hmINCjV2Xt4suJmJB9chWFgjkuncU+CU=;
 b=b2a+nhkREuIt15LY1WofVyYwN+9kDAbpgCVEVY8C/qmZFboD+OW8f/XyGtemNGnMFhE9jbq7A8kXEqYjjIMlsxhEQBdzCEc7YZo/ISBN7f9SKxXQmJCDnD+byOUa8uA17yN54mvnuK1X7IyTO7t6knJgyvyBAwjeNGc+csR7E08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 16:09:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:09:37 +0000
Message-ID: <6b67a84b-eeb6-4b53-b3c7-2a0925c6bea0@amd.com>
Date: Wed, 16 Oct 2024 11:09:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] platform/x86: hfi: Add debugfs support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-15-mario.limonciello@amd.com>
 <7b3a2e3b-9c37-09a3-238a-9cc90726c929@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7b3a2e3b-9c37-09a3-238a-9cc90726c929@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:806:f3::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: c543c558-04a9-4dbd-57a8-08dcedfceedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enpyY1RDT2hOOTQ4cVJHTXBvRGt3eUVsdHU4bS9YS2lNZ0pnR1VIckY5Q0lI?=
 =?utf-8?B?a3lBQWlRT2xWRUtCRWtZaVZjaHN1MmFpK2Y3eEZMQlA3eExadW9NaitIT09u?=
 =?utf-8?B?R2JleGltSWw2YWdkK2ZKQjN6eFBlWTZVZFl6V3U2c3JwcHVOZlc0WCs0cEJj?=
 =?utf-8?B?VlJhejNsWnBVNC9OdWN0ZDNzcE4xOEp6WHZXaVBwdlVWU243cWhwWUhlMys3?=
 =?utf-8?B?MWlOdm9MUVUvMEVRT01ydkt1VmU1Um5KMjhLYUF5SStCaERIWkJRS0RuaEUx?=
 =?utf-8?B?dmRqYmlkQ0VuUE9qTE9ISUJWQ1R6dTEwSFV4SktJa2tBMzZxM1lyd2xWa255?=
 =?utf-8?B?Q2tMRDBkWE5UY1V1WUVTZ2RVcVZiRTZtRjNEZXVhMU42c2pwdjd6VjM0MzdU?=
 =?utf-8?B?OVhYUitiQW5mSGRqOXhDcWQvVU9XQUJFbS8vci9XZUl0ZkJJN2EwRFZLZTF5?=
 =?utf-8?B?bFRPSzJWNkVlbzdvNjJDNGpVMkdUMFZwdEc0RmFoTjlkRzRxVHNpYkFWQldm?=
 =?utf-8?B?cXdua1BuL2tWWnNZSW9ObzhSa3A4S1FxS0Z4T1lHcHlFcjRLK3Y2STZIamZa?=
 =?utf-8?B?Z1RMRlFrL0JVRjQycUFXOGVqRUR3OUFRbTZTS21EUXNtOVVZVGlvc2tCcjZr?=
 =?utf-8?B?NmlCZFZmN080RVJxV1kxWXJjS3V3am56NGphc2llY2FmL3FtekduV1BmTFhn?=
 =?utf-8?B?K0EvYVU4OFplaklOdkR0WUhhMDMrWDBZUDhDWTVWdnFPZVpCblI0a25vNmJG?=
 =?utf-8?B?N1lvemwvak9IQ2F4SERNa3BOWjFJMno4WmxvZXlVUVZrMEhscUp3Q3paTjJu?=
 =?utf-8?B?OTNsemsrUWtaTDk3MWcxa0xIVGpBUDRVQWRXbTdkWHFkbkVXSHhwL2NBMXFn?=
 =?utf-8?B?aktXaGY1d1luTnNJWUFRVUpBMDkrREM2TnVsZXovRE1QanN4Q1VOY00yb0F6?=
 =?utf-8?B?WU9TSHhFbzhxaXByOXR1aGNVQXdmSUF6OThrMjc2VHJuMmw0TTNVNW13bTd1?=
 =?utf-8?B?TnN3VWZ4WmtEdGlwUUtnWTJDM0NXajRTZUlocnVRZ0tYU3hPUGJvc24rd3ZJ?=
 =?utf-8?B?MlQ5dmREc0hReSs0WWszcDBNamlKbXJtYXM4VG1XSFlvTHVIc3lUUmdNWXNX?=
 =?utf-8?B?MWhaeDNJeVZkSXg5aEZyWXg2ZzRzaTA4SHNrTFJ0Z3FmeE1rdmJ6OTJtU0RJ?=
 =?utf-8?B?ZkplOVpTRjk0L0ZZNHM4b0M2aXRVZG01eGJGK1pWZzRQQzc5WCtrNHI2UFk3?=
 =?utf-8?B?VVpBcUg5QnN2OHh1NStweVdpZm56Z05zVUhqeitmQlo2dkVUaGpzV0RnK0l0?=
 =?utf-8?B?cTgwRUt3SFBqaWc3VjFXbC81S05ZaUlTRWFDekRaZTRuSTlId3FiNGZYQXpE?=
 =?utf-8?B?VUQ1bnh5SVJWaThIL2RKSjJnUHQxYjFoZUszU2xxZlVLZjBYQzd1ZTVWTjJs?=
 =?utf-8?B?VHFaQnhVMCttelNVa2JXdWRPRFAzamdqUWpBVW5EblN2MnJOdVBpY3dvaEls?=
 =?utf-8?B?Rm96RDM1eVBZQWtQK0RVdFRjNTArQ2ZLOXZEVEVhQTUzMXJ0TFF0QnovVkdR?=
 =?utf-8?B?NE9QRnhNTUczVnc2Q1ZuMU92bDcxVDVzTjB3WkdEQlpNV3c2ZXdYTlVmYjI0?=
 =?utf-8?B?MWx3QXZlV2RnamhvVXJveHV2Ym01aHZmbmNpTEI4cWkzQ09LQTNldy9aWVEy?=
 =?utf-8?B?dEpHUFdLOWVCb1BJSk1GWW9idy9kVHMwOStCenZhZHE3NHpGanFBV2lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW5aVWRsSUp1cyt5RzZlNkZ5SWFzT2kzYjU5YVhzTGxUbWtmcDhzTkhhYWxG?=
 =?utf-8?B?cTVhck93dDU5V2tqUWZyeFdTTjdGZUZnWUN2Nk1uQmhCeHZlU1NKcjJUYWhX?=
 =?utf-8?B?TzZaUDFkVDNOeXJxMlhHQ2VZSGhGTTRCVDFBQkJvVHVvUFZqQWdaN0lpWU5V?=
 =?utf-8?B?YXRRZ1BBM0VTYmlIVkdyQk1hSis0Z2ROZm1IaGVSY1FYaDBXR0U1VmxSdzJt?=
 =?utf-8?B?MytHalBOT1pWNGpJd253eGdkYjJXRmQ2SHczc20yT0JWMmRqR1cwQmo2RmxB?=
 =?utf-8?B?MUJrVkdJSTR2UVk1QWpEQWp6UkdiNTd1bG9uaUVobWNrR1lSc2prRlBGem1y?=
 =?utf-8?B?a0Q2U2daUnlrNDBOcUgybGM5dE9tU1VmaEh2RjJPblZZdmg5SnZwY2dzNmVj?=
 =?utf-8?B?T3pVb05aWjRFME9DMGNER084ZXkrek96T2d6dWJqR3F6dkFIeTJsOXRMb01E?=
 =?utf-8?B?bThjQ096OTE3TVJQVWhMWk94TlpPbUlYNGZTdlFlbVNEenh0MDhYcU5NYVpK?=
 =?utf-8?B?NkhER0RMNlQ1bXpFOWZwdEpxcDJyeWVCVC9adEYwNkZrZzJpbDhTc08rMEFI?=
 =?utf-8?B?VWFZV0p1elhLRnFldFJRQ2pCQy9TcUlGQ1ZkYVdDamh3ZzFLSUN0UGpidnNu?=
 =?utf-8?B?WDJINVVMN3RDYUozZlZNcGNreXovNTdNYlpEdVE4OHVNVlJiTTNGK09YNDBM?=
 =?utf-8?B?c3Q5dElVaVJ0c0Y0NC9sYUlnUWlOZHpacHo1d0NkUTVqWENLRi9WaU95VEhm?=
 =?utf-8?B?U25IRzY2UTBBNDU0Snh0TVdZS2tjZTBjOVdMbE9ObVhpbnM3cFhDQ0xxNUhm?=
 =?utf-8?B?cGFaTFU5S2xQYnJkUlVjVE11Z3kyR0lETnloTW5zSGg1OFJyYzZrT0liam9D?=
 =?utf-8?B?MDh5amRDdXNCaytqSVlsK2JwSmsxRFo5WGNRSjBpRFpaTXkvM295TVVFUUxR?=
 =?utf-8?B?U0tyTW5HcmhDTnNJZ0d2VnBLMnVVbklST1kreVUyQ2VuUHM1VENkdUlTd05t?=
 =?utf-8?B?ZEJ1azFEcUNpQjJBRWRpUDhuRUhYVzFGZklhNjZkU1JGTFdKUmZTM09YQ2RK?=
 =?utf-8?B?S2NJTlg1Sm5VazNIdUl5Tk1aR3FKa1VSVUJMZGtOQjNOaG5OM2JSdmtFdzJt?=
 =?utf-8?B?ZmJrZ2orbVMxWVl4RGdaVlNTTWhNemt2NVN2bGpWR2ExbkdiQ1ljcFRQb3Bq?=
 =?utf-8?B?OXkwWitPUUdFSXRaREVMWVFSaUgzT1JSQlMvTk40TzJmR3VIQndaVnVNOE1Y?=
 =?utf-8?B?dHpwSmRLR3htaUlJQnljMFBqNlZsamtoVkx0amd5RXVmSGNwd0RZMTJ2WjZS?=
 =?utf-8?B?UFh6V1dPOEQ3bGdtVDFMSEtrQlBzRkk2eit1NEFmU0QrQVpoN1hlS29zdHBL?=
 =?utf-8?B?MEhmY0FrQi9VM242WUkxSlZQK1lqOVZYUXhoWk5jZnF1aEU2emR1UFkrQWFE?=
 =?utf-8?B?UUIyd2FpVmF4cXpuL2lIQ0xWd2hndmJLUG5kRUt4eEJBQnNya2tlWE9WZVpE?=
 =?utf-8?B?WEp5ZEQzRVJxZ3dvVUozbDBMelBuTTJhNEo2RVpBV0FrR3FBV3p0a2ZxdGRG?=
 =?utf-8?B?TWJDZ0pNamxVMWk1MlFHWjhTQmQrOERvRE00bzlDU0FweVFkdWxwTXkvOTdi?=
 =?utf-8?B?dk5KdXplaGtIU0tubkNYdzRXTVBJa2tWNGtMc3dJWWtUbGlsc09nMnZXamdz?=
 =?utf-8?B?MkprMlNObmwreTR4UWZsVlB0MlJLVFZDcUFPZ2o5azF0SkVnR1lkSnFzVWZt?=
 =?utf-8?B?dUk5anlzbDZSeGVuYlZSMzFSZDZYUm9ZYVVKZWNKcXhvOXEzbWRXT3d0b09r?=
 =?utf-8?B?ekJiSHVEcXE5WDRrU0pYa2REcmlrODMrbTVUNFMyWUhmSTBGUVRQL09iQWY3?=
 =?utf-8?B?dnJIdm94b1dOSnFLS09yZDVjUkZYOGxJK1hrQkR4UWRrM1k2c1FqRkRqM1h5?=
 =?utf-8?B?bWZSNUdmR2hLMmRtSnd2a1l3bk1wclN6akJxVFJUYW9qZEl3Rlp2V2RwVUNz?=
 =?utf-8?B?M2FJSkZ2d211VWc0dEhYeFNSL3MrTi8zdjM4QjhIQlY0Zm1yZGRhdzgrM0lt?=
 =?utf-8?B?czFpdzhITHdmYVVJYXJ2ZnBaVFhoMlF5VkxSRTljbVJmcDdzVUJDdXE2QThv?=
 =?utf-8?Q?AD9FMaHi1GkZ0JDZ85iSaDySi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c543c558-04a9-4dbd-57a8-08dcedfceedd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:09:37.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPL3vPmI0krti5TV8GUM4Mxmt17a9tTXC7pnzubP4aKSgpmztwjsteU96m0e+0SZxN4emCZ5WoeEy0756xBs9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

On 10/16/2024 07:38, Ilpo Järvinen wrote:
> On Tue, 15 Oct 2024, Mario Limonciello wrote:
> 
>> Add a dump of the class and capabilities table to debugfs to assist
>> with debugging scheduler issues.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>    * New patch
>> ---
>>   drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
>> index 6c90b50f0a40..6df80f6ac73c 100644
>> --- a/drivers/platform/x86/amd/hfi/hfi.c
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpumask.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/gfp.h>
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>> @@ -79,6 +80,8 @@ struct amd_hfi_data {
>>   	void __iomem		*pcc_comm_addr;
>>   	struct acpi_subtable_header	*pcct_entry;
>>   	struct amd_shmem_info	*shmem;
>> +
>> +	struct dentry *dbgfs_dir;
>>   };
>>   
>>   /**
>> @@ -243,6 +246,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
>>   {
>>   	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
>>   
>> +	debugfs_remove_recursive(dev->dbgfs_dir);
>> +
>>   	mutex_destroy(&dev->lock);
>>   }
>>   
>> @@ -400,6 +405,28 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>>   	return ret;
>>   }
>>   
>> +static int class_capabilities_show(struct seq_file *s, void *unused)
>> +{
>> +	int cpu, idx;
>> +
>> +	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
>> +	for_each_present_cpu(cpu) {
>> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
>> +
>> +		seq_printf(s, "%d\t", cpu);
>> +		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
>> +			seq_printf(s, "%s%d\t%d\t%d\n",
>> +				   idx == 0 ? "" : "\t",
> 
> Is this conditional printing really required? Why cannot you just print \t
> always here and remove it from the cpu print line?
> 

Thanks for the suggestion, will include in v4.


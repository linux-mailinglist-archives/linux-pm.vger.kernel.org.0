Return-Path: <linux-pm+bounces-19454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26689F6E11
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC881884152
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB05157E88;
	Wed, 18 Dec 2024 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4V2WzrKJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E209461;
	Wed, 18 Dec 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549616; cv=fail; b=nLQb1UogCi0t4n0sFZRPoDj+25HEbRZILCMRfZeJJ3zUxRlTqFNbDtQO1X9Vm7H19rOJV0FurKYsTOyiWIupY6BFnW41MeRvsyeHPF8N57j/caX79czdTRXfP0pa7AfE+37r/nQLd/xULtwgB7YDamr0mKgMcIGZF2y9pBVxwt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549616; c=relaxed/simple;
	bh=YNMEaYqhkEcXNetmgi4WWOa0vWRgV9q1kbY9upOhFUg=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9mI8muvlVzzO71UHlMJwv9YhYPf4zmaKxoSc8BEyzaMOwXf1xLQx6Ono516zFxm86Diwy17tibj0L5qDhv7e5UawctXJXQBXsHFv05/J4anseJDkeQRQO7RmzaYecI8GF+GjbNHlkkxeJVlVYJKk5QTCa/pkpAjF3WiPNhJNJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4V2WzrKJ; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgx8DawycaLcngDaKdIj11iXClhBx70drONg0C1JcZfSL48cquXwrW/QpurSiMC6IaOwp1lXUMkYOO6jmm1jETmVSHaZ42db/OdFWpQEuJG8i9KOZbgtmCLZwBNKEuOLU8L6ZHUE/bTsZkx5yWHJAqnzT04Vov/CM3GM99QVM5L6xR4p0HxJVGKPzGfJw0nlim2ORqQjO7sxwu7C+Y7o+OGUNwRqkcnFiosrLD/tEZUk+fzIkSWbtsRU9m+jtjdq8ARCGosYo87ajHYzMe+8/UanSBjr+dCkaKIM12TXlknm8vWbN9aJjwrDUTAU5SkNSkkOOlR15XksUYKGtd2VUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDo3HMwRz5uUlqRpXrruSfZMvVtf6+b213Tc1MqF7jU=;
 b=Utk2OKe1sEcwOPzlA0IEVL2cq2W8bwAeAlYu2N/goox3+WMSv9njhxHsnKgDVVE7CyNksqU+dFiwL5pg2uBH5i3dxO5It2kStMuUnziL0MdNipVx+mkqivhJK8hLXkg8sXiMLJVNvT4QMDB1eYZ8pMoq9PHPWs82zOeRnpmB5HgaqD+/07XRm0SW7USW1E3hQn4WNbLh/oQP5CZfF/nQL4kG/mgXHwXNXPO323pd9nOVDv+dAi1djFU0Nl6TSbweTm9+ZD/DI6SaHRNK3RFFVOlTeJ48pBY/+Db+B9RO35aD+r4y3ZVdWBW5TAMc8yqxPtC3xFp6KgOPhhGilMLF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDo3HMwRz5uUlqRpXrruSfZMvVtf6+b213Tc1MqF7jU=;
 b=4V2WzrKJUuLSHoh2aUHTG7ljASESxdg6gldGpj+GIer1zKY6IGcmTRaP9RYBFrhlvjK+OODhyxCQST2pJzPrTVZYWg0SoH09WVXrcsqcaOLH91CPV6QuV63D776dlI0dKh+A1Ky09bOJ+5VmKJ/wfa/kuNVCK3q/olIq9uBYOmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 19:20:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 19:20:12 +0000
Message-ID: <b1210cbf-22c8-48f1-ad50-d81395abc8f3@amd.com>
Date: Wed, 18 Dec 2024 13:20:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Refactor max frequency calculation
To: Naresh Solanki <naresh.solanki@9elements.com>
References: <20241218190030.1228868-1-naresh.solanki@9elements.com>
Content-Language: en-US
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241218190030.1228868-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:806:125::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 580cee7a-db8a-4a9f-da61-08dd1f98fe5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VncxeFVjNysrUFhlL2lhajlMS2dydnV2bUd5TFpKdUd0dHY4N3NTRXM1OHRr?=
 =?utf-8?B?RjA1dVA4bFB3SmZ6eFlob3QzRlR6NHJ2b3ZiaWdsYXJkL2p6bXV4ZnExTXlH?=
 =?utf-8?B?M3FBSTF4MTJIbEE1RXFWUHhXRHdITi9DUzYydVRWYmVlSmZCSmdkWU1pQVdn?=
 =?utf-8?B?S2U2YmNhWXc1RXBSNHhSY21JbU84eThTNktDcnQ0NEc5Q1dWSUpTZXJYdlFD?=
 =?utf-8?B?amRGN0xHdnY0U3lxcWdFSHZjOFA2SVJYQmVXMXR1REdzaERtNFRLeWVMWGFn?=
 =?utf-8?B?aFU0Mk5WR0RZUE40VDJ5Wm85eHprOW45Q1dQYzZnNEtjbzE1NzA2SlJ6Q1Bp?=
 =?utf-8?B?aXVLUmd1dGVpek9JM0E3MDZ4eXg4d29yYnVXQkcwV0pzbENEb0NHNTIvWHlC?=
 =?utf-8?B?TDBCdEJjYTNiNUl0N1ozanBFM0ljcjhnZFhqbGtpUTNHWnBnK0hwdEc4VXhy?=
 =?utf-8?B?R1dNM2FTQXltYlFuZXRsVjh6YlZ6aXZ2VUI4eTQ2QlZzS2ozZ2lFbXdFOTRu?=
 =?utf-8?B?OU5wUDkvYkdKdVNIL3dhdStmY3poK013VUZLNlJwaDJMd1l2a2NHZnRqTElJ?=
 =?utf-8?B?dXo1MkdnR3pFVHE3SXJaai8vcUN3QjNkbDI2K2pkeEErMGNUcVh1MHVZSTZk?=
 =?utf-8?B?dFVua1VRMmZqeVkrK3VPNGJPUHVsL0k1WW1GVG1NUktINlZYZHI2a3N1bEJa?=
 =?utf-8?B?L1VqYi9UUGoxMGVJYk55Q1kybmg1eDVrdS9kdkJnLzQ4VlMwRlJhQkxKaGhU?=
 =?utf-8?B?czZhMDVYUHhTYVkyejBzQk10NHdqVVl4T0JSK2w5bGRkT3g4eFpqeEM0dDFF?=
 =?utf-8?B?U04yUVkxcUVuVlRXZW1xUitmam04WjBESFlzbHNpSDc2eHk3dFVKM1UyM2tt?=
 =?utf-8?B?STA4RG84Q01EenhodUtWclVHdmpiQUtDQ05BTlRaVFhFMVV3b0tQck1LMGJp?=
 =?utf-8?B?WExoWjI2bTgxZWRyNUVlQmJEMmJRWTc0UlgzR1FlMDdHWnpuc3k2VkpST2Zt?=
 =?utf-8?B?UU9hbHZ3U1BwcVhveTk4R1U4cEg0YTJsbUZ3MWI1d0Vacy9FdXdoaVNNNzZy?=
 =?utf-8?B?R0pSNnoxTWphU1MvcUJoZXJidDB4S3JmUlBzZ05jQzdteUhpaEJFMGQ3MEQ4?=
 =?utf-8?B?VVJIc0QvTjA3WUtwelR4T2tOQ0pyTHJrWUhxYVorVGRwMHV6VFNIdkpCbzA3?=
 =?utf-8?B?cG5lNTNLOStQVXltdWRuYjEzNVYvQ2sva0RGVUlsOHE4T242b2FybEpPQ3hT?=
 =?utf-8?B?Uk5Samx2azZ2YjJpci84UFdlU1VPUnJXMkNIZ3pMV3lPbHUvR05Mb1pPMlps?=
 =?utf-8?B?eVhpSVAybWs5ZXpXOHFyUElvNmJyeUgrdVduazZPYkRBSmpnYzdLdlJIc1hK?=
 =?utf-8?B?WHQ3ekxTeUN5NUN2eE5FNGpJL0t4WndCc1JqK28zU3NhYms5TDVtMkhublV4?=
 =?utf-8?B?N0NEVjdRN0xqd2RUREM4SHVTM0lTUVZRd05DOVcyWUZQd0lWODNwTDNlV05p?=
 =?utf-8?B?ZTlXSk5EekpudDVBOCt1OUdhOUY2T3JCcDR0bDI4OXRGblJJOUw5Vnh5Y1dR?=
 =?utf-8?B?VnI3OU1qMG0xM2FHNmU1SXZUQzEwK1JybXBnS05hc01maG1VSkc2TUdxUThB?=
 =?utf-8?B?RXY1UHJ1VGQ2QnRhYnZmNmJlSkZaU1J6SFg3dVBaR1VUQzV0a1hEakh3S2xy?=
 =?utf-8?B?MzErYnFsSStOWUJSbHAyM0F2bkliRWV3UExKUS96YjNyTnpoc2RuM0l3S254?=
 =?utf-8?B?UGczaUVINUhhZXYwNG8zWlBwVjZEOGRmRDNIalY4QjhzSE9ETFVuNGRRK0dw?=
 =?utf-8?B?Z1c0Sy9WeWFTVG1PZy9Jdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFoyaUVIN0g5bjVmQzZSTFRobGdURE5PekFZcVRjZkptUWluSUp2QVN3d0sz?=
 =?utf-8?B?QVhMRFhSNXkwSGExWTRmN3hsVDBPZVVwTFA3Y2hJcHYraFN2OTduZFc4RXQ0?=
 =?utf-8?B?RWM5dm9QRDQ5MEtoNnRHMmNVb04yNE00ZlJLY05GdncyRy9sTzhobzROV0tH?=
 =?utf-8?B?bHZSOE5nTUFCcTkxUm1jdmc4WjdKLzkxWkszeE9ob1RuTjRVUUJGYVVoQ1NS?=
 =?utf-8?B?a3FTcVE2NVhTLzJscTZTY3YyakJvUUxlb0d1NXdXUkJEdWl1V1YvNkpZYmNy?=
 =?utf-8?B?QWh2TlNDbEoyUVVLRHQ4azR2dkVMNmthaFQ5cVlGakk4NWs4ckF5U2J5S0RJ?=
 =?utf-8?B?YlQ2QXo0ZWRVUEZjdGR4MjNIWVR2REtaZCs4ZXdmMjd5TDdtbUIraGRFaHB2?=
 =?utf-8?B?UVhrUE9GdEdSZGxwV2RYbnRsQVhQNkpYNnVlMFRDdGhnazh4RlhEa29oWEZ3?=
 =?utf-8?B?bzR2MDJ0Q3RDY0RHdklHZFM1UW40czJEbTVtNlA3Nm1oNGxwdGNmTWpON2gr?=
 =?utf-8?B?alJ0VHVCTEJPSVZvbGJPZmdDbkljSU1rV2NOdGRKakxQWFF5dlJGUFNVUk44?=
 =?utf-8?B?YkcyN2FGOGw1dDNmdk5UdTlMbHRPU3lxSHptVmdCS3o3K1hVd0xuSkE4VkJG?=
 =?utf-8?B?eTZkazRoNGJwWHlhNTMxemhKQWhycG81MUJkZFkrb2ZrMGVzQ0pUZkpDV2pN?=
 =?utf-8?B?RWpEMUFGYUJoT29vRThNWDRzaGVSSnFOUDlaK2wxT1R4WnkvN2RDbytrdkNG?=
 =?utf-8?B?R3MvVGlyZmJYRkdDQUZyTURRQkF2eHduNkg1Y2FBQ0R3aGlGNDRBekpxNUJh?=
 =?utf-8?B?NTBoYUhBRVRxZUljN1E2M1dKd0NXWlo0YkVEaWwwNnhvRjkybWVzOFY3cEgv?=
 =?utf-8?B?RkVPa0Q0VHF3Y0RjQzhCQ0VHK3d1c3plNXVZTDkzTWErM0JycmlHYlIzZi9F?=
 =?utf-8?B?SURvU0xOTk9ERnZSVzFabDlmSng2ZVR6MGxMN0tYeXEyUyt4WFhzTndaSnFt?=
 =?utf-8?B?N3R2R21pcVJCTUQwaEp3WjFRem5YMlplVEc5SmxZVUdGV3UrSmhPYW91QUhX?=
 =?utf-8?B?NEZVSThmWmFNbGxDaitlN1N3MDFyV2svSThQczJkdUdsREFnZ3VPdnM0dFl6?=
 =?utf-8?B?NmhFNWs0WnJ0cjVZeGlTc3c2K2Z1MGVPcW45TnFZaGo5OEhGd3ZmUVJ5OVB6?=
 =?utf-8?B?UHhIL0diaWpBR3VacmFXRHRUQWlOR1FRMmRzd3gybUNoSnFpdm9ySUdLQURC?=
 =?utf-8?B?SjNMYXRMeWQ0eW8wMGorRjUrU01zSnZtbHVOUVVDMXpWZFlwdm12ai9sS3lv?=
 =?utf-8?B?TTl2aWMwRS9OWjNTZTRTYmsyYTVGdUJ6RWtOanV4aWNmeUhVVlNDc01HUWN6?=
 =?utf-8?B?NHlyUmxQeUJNYmZJYjVKUDNPMUNoTGJzcGdmVUVSdDBBQ3dTaFBIWnk1dnpS?=
 =?utf-8?B?eXR4RlRsN2s3UEV3cDVJNFlVK1ZzK0dvVWFhUTg2Q1NPQUZBd0pvZmd6RzhN?=
 =?utf-8?B?dWtqeGdXWk40Nll1cmJ1OVZPdmpyUUdENm5LaDdlSlJRUTBYakZJRXFBM1RE?=
 =?utf-8?B?QWw0U1RvVXpySFJZSVprUTNCNi9GYXFpSHNMTytsTGJ5OWN3ZXA1eHBxck8v?=
 =?utf-8?B?SFM1Y2xvR01RWFlKNkxFQzhJOXRwZllGaUhWUGpoNEk4N0JHeGJCUnZaMngw?=
 =?utf-8?B?V1dhWnd2NGFIY3NDdk0wVEgvcjNwUktrbi9VWkR2ZUk3aEhudkIzTG9vTzVF?=
 =?utf-8?B?REVRbXhMYnRWQlZWenZuWm9kRy9kd0phSVJDRFJwOFJIWEpTdnRXT3lhRCt3?=
 =?utf-8?B?eW9SeldjZ0hNMUh0OExlY2pDcFJjTE4wemgxc3dXZUJnK05FblEvWGhYRUYw?=
 =?utf-8?B?NUZMSnJ3b1FOUDlrK2lFbkc1OHJYNHhBWXAvVW5PczV1dE5sZVlJdGVHQXVQ?=
 =?utf-8?B?bHJMSEYwRWd1TXNsa1ZoeTg3VzIzMzZMSzdYNVNSODlZSC9vZWlGeWVZb29E?=
 =?utf-8?B?QW9maHU0TTFKWlBjSmZXWXhWekltdXdjaDVYd2NndkZXWlI5MjBzMklqTWlw?=
 =?utf-8?B?K05GRDUycUxRWTRYZ1g0a080UTNFR1Z1RVpUeDBad1kxaHJCK3pJV1VVWTNh?=
 =?utf-8?Q?mJfCBx13g3kIp7Qc9Uq+FYZ5Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580cee7a-db8a-4a9f-da61-08dd1f98fe5d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 19:20:12.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xflyl8x6DMp+DWTTawpwV4pNp1ghTQYPu/hIwUXn1RfAov/WSSi7ULQq63LGG8tHRBOZ77gvEd2hqiLLhpWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

On 12/18/2024 13:00, Naresh Solanki wrote:
> Refactor to calculate max-freq more accurately.

Can you add some more detail about what you're finding?
What was it before, what is it now, why is it more accurate?

> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7630bab2516..78a2cbd14952 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -892,7 +892,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	u64 numerator;
>   	u32 nominal_perf, nominal_freq;
>   	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> -	u32 boost_ratio, lowest_nonlinear_ratio;
> +	u32 lowest_nonlinear_ratio;
>   	struct cppc_perf_caps cppc_perf;
>   
>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -914,8 +914,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
>   	if (ret)
>   		return ret;
> -	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
> +	max_freq = div_u64(numerator * nominal_freq * 1000, nominal_perf);

This doesn't apply currently, because of some changes in the 
superm1.git/linux-next branch; specifically:

https://git.kernel.org/superm1/c/68cb0e77b6439

I haven't sent this out to linux-pm yet so it could be in linux-next, 
but will be doing that soon.  So can you please rebase on that branch if 
this change still makes sense?

>   
>   	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>   	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,



Return-Path: <linux-pm+bounces-7591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B18BE654
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4851C21D85
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64F15EFDE;
	Tue,  7 May 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JMhh8EF4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308564A;
	Tue,  7 May 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093147; cv=fail; b=d89BlnAtL+4ViN7+Aa9s3pubH9G6ZBe6FF6zhVqpIl0q3gNG03qEiuUDvfHzf9SEhuvalsDnC2DmqlLL5Ne1NbFDGmWgZqV8InJfM7KGYMuLSs6OZcheFBM8fyRguc5A5ZeAndNyqw4J3bYOPn9YBIkE9+PMHIZDZsNF5zngQVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093147; c=relaxed/simple;
	bh=jzRqOLY5IWjh9dvGseTN48KM+8XhGZQt9g8ZbK9+Hec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ABCOzeiJzJaWV0GlZ2wZI6fOze69HmCZduFiHhyxZKLnU99qi1d5ELRgHiWOul3PtYR7WLkM1zb5IZi9d8YDbofdmx/p1UwPqLI3qvKlvMpLOGH12QPqQg/PyRRYeSlcAVr1xYnuznMqWCkRxLH2lmzTkx6CGPJqNia7GTfXKN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JMhh8EF4; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5d15cd4iKfjBejKXZsLS5UKT+40s3QNPsda1vqyy/U3vdVEV8IM5Vj93Qav92NGUITcW+ButcU3VkkW9zJ/B7Ghpj5QbXaIYPPDhDtkAwApGE+5ByclzZhXRsbrOMLZ4OldQkMHwXTXdC9OuH2vEZdwdeGD7iOc/TrxoEm9JL1oNZg2CPXy+i9LNqzfGy873E9jCPo7eDFj6Y/JppcMcWiK1c4WJpDktmLAa5RIXs+ABt6pYSGjadQR0RVsEwJElWIHpB7Y7LQI31JcJeUEse/QmOofert61S/G/RBF4hQw+zNmKqRZe+QMBiUrvXrYWLZp3/vJY3pTmf/7RTtGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuSjbaRI48AEfdlmqqi7mpOm3yp7bbYU8XoXQWFyFPA=;
 b=X1E+n6IbDT/UGNLaRKwdTdHKDTtm9ULfuQIpGQyGgFUxOnaljuRewbU7v6+1qvCC6r7O84FFQ6Iwz0JMNgMauSXQ44x/ob4EqQXsYD/xI/EZD/0gkw0B3earsuwhyP3BdwO4IRLjeAW5CvZDieCF+HwBh+P/xCKMWxf3MRbE1u66WuyW/pkpIf38BdW/SsKNKUx8Jd5fUv+NaMxZoGQJwRINX7MnIcuUNJH5dT2kjXWNJ87aCjo60VuLvPHcHNTxkpjDkOqzw41VSpUZ6G/U6oa50r6EhZcKOoIxYQ/3b1ifHopu8ZEw6vsWR3UCcwIB6zXto2vYT7asEl+jN7nDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuSjbaRI48AEfdlmqqi7mpOm3yp7bbYU8XoXQWFyFPA=;
 b=JMhh8EF4PqUfgxpWIHrf7oj3y3Q88+kcg+O5aPClZBd9CAbVHx7i0FLRKe/75+c+DDOMVXwb1ntGMHe4ccU0DzAwN0iPOV75AuOoshSn86AoD5u8bd6DHDKHvDE8e5T0uDka9WbBm1xjgJ5dxtHSL1rKYHTZ6ZDQ3mYmIn8yDs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 14:45:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:45:42 +0000
Message-ID: <208d227f-dfed-45d9-ab26-848fc12e22a1@amd.com>
Date: Tue, 7 May 2024 09:45:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] cpufreq: amd-pstate: show CPPC debug message if
 CPPC is not supported
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715065568.git.perry.yuan@amd.com>
 <4b4a1a6b30a2dc6c95e550c62b230bc3788af415.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4b4a1a6b30a2dc6c95e550c62b230bc3788af415.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:8:2f::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5b1e73-02f7-44cb-ed2d-08dc6ea45ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm84YTdLRWplMXRuMW1HMDk1dCtrcXVKbVNvUS9nSlBIVWtWbmtsM1ZtZXBv?=
 =?utf-8?B?U2htMTBxdEczdzF5clU2aVU2ZXJaQ2UrbVU5QW9GaS9LTTFQUHFqRDFoZDI0?=
 =?utf-8?B?SUZpODV0aStKdjN5WjJiS3pFZDEzd0dqcVdpTHMvTXJWR0tkeHNNODFKTS9w?=
 =?utf-8?B?cGV4OTA4U3U5QU82Nlo3K3dBRkdzMmIyRy84UStYMmJrRUg2bGpjOGd5NjJj?=
 =?utf-8?B?NlJaTmd2UmE1ZE01TXhYSWhCbHFlNWVnVFdzdW8rWlRjemo2SENYUENzVGJ6?=
 =?utf-8?B?ZXd1ZVdsWmx5eGtiRllwZ1pxdXo5SXZxNVJVWEx0UUhYcDUvZ1pMNFBQcXA1?=
 =?utf-8?B?NWYwRWw4eFlSUWl4TkpjMDV2ZnRrZHBGcFpiQkNmelJRb1NOekNmTkhLMGhW?=
 =?utf-8?B?dDJOTjlkRU5TV1lQcmIza0NGUFFzOU1oRlB3VnNQbURFTlExOXN3SStIZEZo?=
 =?utf-8?B?QlJKVTEzQjZ0c0kwNXhYYkRueS9CVHZ5YXV5NXNXend4VVJzWFZnb3oxVmdN?=
 =?utf-8?B?UGNwL2JSQTFUTytoYW9lVVVjNmNFcXVVdFowTjJjMEJGS29SQ1hiZTJwVG53?=
 =?utf-8?B?SHd0UzhGbE9KL2xXbFBPYlZFV0RRcTZKN2lxTFRGaGlCOFdkUmM4ZzZXbUlu?=
 =?utf-8?B?TjdpWW9CRy8yMlcrU1pPaXpxZURYdG8zOTlubFRaMzVLbFBoK0c2ZHVINmRE?=
 =?utf-8?B?WUkrR214MXgxanNOUFF0djVlOHJrYUd2YTJSb2t3eDlqL0hUMldnRjg0LzM2?=
 =?utf-8?B?NGRWeWRwZFRIVFhSamRDVmNtWEc1cUtsaFM2Y0NHeVBDTDVCZGxJNnFhSTR4?=
 =?utf-8?B?VVN0c00xNlE0NWlVMHluajdJQmVCTnkydTJFUDNMUWF3amVKTStucGN3M0Yx?=
 =?utf-8?B?T0dRVXNNeU1OcWIxeGxucXloYU1JOXYyVCtHenJpOFNXNDBWL2dqTThWVjI2?=
 =?utf-8?B?RS92cU4wc0ZQamNXSEdYYlpDTllrNmlyM2ZvK2N4dmM4QzVEZ3ZaVTkvQkVB?=
 =?utf-8?B?QmZqcTRCVUQxdWZDbng5YlhoanlZN0dhZVRoSlZhMi81eW4vc0VkNG90d1pl?=
 =?utf-8?B?N3ZzamE1THRyMWs4ZlpNYU8yMko5SEdKWmhlREdFaWYvc0dyR0owL0k1SFNJ?=
 =?utf-8?B?NzB0eGt1b2YzTGlzb0JjNTRmN0ZRWnlSV1IxT1BtRi8vREZDM3d5RVBOQlFi?=
 =?utf-8?B?ZVZVTnpzNDNrQjBlMk5wUHd2eUs3ZXpwS09sWTJsYitIZ2xuYlV2N0R3NEVv?=
 =?utf-8?B?emhaYXF3b24rSjRYeHB1UWZUMmpBNDlDSm5nUVdtOUJWVDZhRU05SWdQWlBo?=
 =?utf-8?B?VjZaVy81SEJsR1BZc1hYWEdFYnFhNTVhdkJ1K0lGNW5oOTJMMEhtdW1hckdI?=
 =?utf-8?B?VnpzMU1xWi83bTA3d0JhMlF5WnRKVGFUWVF5aGxTTUU0a1ZDWENCc3dFZkpF?=
 =?utf-8?B?emZvRGoxTGl6QytIOXZubEU4ZHlKTlRIZ0hlM2RnNUVXZUtxaENzeFM4cDRu?=
 =?utf-8?B?WEZMVHJYZzEzL1Y5bGczVjl1eXVjWHoycXRVaUVOOEt6dXJWT1JjTlVNNFpW?=
 =?utf-8?B?K21pVmh0S01GWmRkMFcvMmtRYVhtZ3hHam9KVlZEb3g1OE5mc0JlUWk2WG9p?=
 =?utf-8?Q?xzpzXSA7mYOurjxg24SdhDsPoOUvDxHYPwFTdR8PF3D4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW92RlloSEtCYWZDT1JjWldnMjVTamRmWUhiUnpNdHByTGJIZysyckEzUVpY?=
 =?utf-8?B?T3VveWVJTE8rUVlXMHBXcTM0RWVYWGhQaWN5ZW93UUN0cXFRUnFLTW1nL2o3?=
 =?utf-8?B?enkyTzlROVJMM3V0ZU04aUR6bWVkUlhBOHh0Y0JUY0R6SEYzcWJnSEFkYytR?=
 =?utf-8?B?cWdPdDBxVWN0K3FWaXpmUzlrekE2YklJbVczNE5BRUhieUVpT0hmVHZDQ2Fy?=
 =?utf-8?B?RWphVXNNWFJKYnhCS0hyVkFwTHYzem5va1YrTk9vcUN6M0Qxc1BHdm1FNk9D?=
 =?utf-8?B?b0UyYjdzWG1kbWh1eDlscEhza0djTVdIa21meEpxTldzemJzVGI0OFZLa2Mx?=
 =?utf-8?B?cnpJV2tmL1dwRE1ZUk8vZTRKQTREaTJrVnhWUjBpSkt3YkpmckVIS0FYa1cy?=
 =?utf-8?B?eEtndFZ5d1NSQWxpa09sZnpTNS8rb3N1WnUxd0RBMURkTlRwMllQUUlYbUhF?=
 =?utf-8?B?REVmOUs4cmFkVVBVcFRIV0FvazZmckRNVUROT3l6eURqQnBZU1FDdUsvQ1NT?=
 =?utf-8?B?QXZjaTJKcmx1RTBTQXRyYUxKNnY5M1NXcHhCT0FMNnA0L3VIOUU1RW5oMVA0?=
 =?utf-8?B?eGhvQ3hTMk4yZXYzQ2VGdm9EbThHOS8zRnpNS0IyTENaRzVQd3lEOG5zQ1FL?=
 =?utf-8?B?SEYxOTZ5MFRvY2RhdkZOTXZ5VUZ2aVhhWXk5Z3B0WmgrNWNDK2ZOc3F5Q2VE?=
 =?utf-8?B?a0lOK0ZicVN1d0RWcXZTRSt5K1JhYXc1dUljMnBGSlQ2NWVrQjAwNmxpZHJn?=
 =?utf-8?B?ZlhDdHFvZ0xFVGhOc2I4MTlHUTlrM3Z1SWUvQ096V3dkcDVyUERJajZNMTBZ?=
 =?utf-8?B?NFcwZUJrYXlPbVI1NHhCRk9oY2RVNlFlMWhSamlQYUtnMy9nN2Y3RUJhTmN4?=
 =?utf-8?B?NWVoR0NjQUhpTWYvYUJoSFFhNUVqL3hZZ1ZlN0hTcEVwNmsrU3pIcEowQkMw?=
 =?utf-8?B?amo1Z0N6bnNsZTRjVTBpMlJtVDZRenlrbXBFYXJndDh5S3pkblNtb3RZOTND?=
 =?utf-8?B?Z1R5bGRpYmgwbXN5WXJha29DQlZHNE91SW9EazlnZVdSUDFTNS91TzdReFBR?=
 =?utf-8?B?TlhaUS8rbXRyN2p0UXpXUjFFdzJkaVVja3hjVVp5Yy9lck45WElQNThkaWhS?=
 =?utf-8?B?Mm1QaFFtc3h6QkJqcDNBNlFxRnJlOXlPZGhEVTlDNHNNVzF6dXNsMDRFd2VU?=
 =?utf-8?B?ajdCT01JdFR0QnNOR01yNjdYNS9Cd084cGlVdTF4NUxNRWRxK3NBMkhNa1dr?=
 =?utf-8?B?c2JhSHB5YnQ0OHI3ekpEM2VIYkdZeXhMMlVSVnpacndMNWxiSkdnUWtOckxh?=
 =?utf-8?B?RDA2aTJJdjhBZS9MUzlIRS8yTnV2U3EvVTBhZWFPQ2RSbTQyREF4bUIxVjZK?=
 =?utf-8?B?UEtsMGdUQk5NMjdwN1AwZk9mZTdtOVhhaG5uRFk0RDV6R2lLdUxGMlBWQ2RL?=
 =?utf-8?B?UnkzYS9FSHo4ak5JWjdZWlI4WU5oc0cvMDBBQ2JFR3lFaVlMZWJOR1ptVXlR?=
 =?utf-8?B?NHQ0SHV0TklhQlZjcU1NcDJQcHdlSkFLZTJaN2FMb0RmNlZJR2VQVHI1dHlw?=
 =?utf-8?B?QnR3ek5VK0NOU2dwSWV3ckN0ZGw5Y2J1WEdXbElkN0o2eGhVN1RCUHByM0lP?=
 =?utf-8?B?TDlPRFFNbWxxc2tsQ1ovZWVqbFlaWSs4MzNBdk4zTUEyRitmTFhQajNuUWhI?=
 =?utf-8?B?Yi9rVVNTWERwM0xDa2hsSDhDeDdOL0dxcGMwckxuMlZhZzBiWlo2ZHFLdWFO?=
 =?utf-8?B?eVZ3OU54VVhEdGVYSmdGZkhLZy8xNXZmY1VqcXZ2V0VrUTBmcVlURDZ2bU1y?=
 =?utf-8?B?eGRpUytRWlNiVUhjMGE1WjZkSG5nR3RxZjBiOXMwbVFxSkNOMi9rUXRwc3F1?=
 =?utf-8?B?Q3FvdzVHdzlyN0dINHZaSFdZai9pSHI1VFhCRUZ5QklyZUxpWVFEVFlyUnZX?=
 =?utf-8?B?cmNSQ3FKWFhTckNtMjk4ajdzWXZPTGh5d09kYTU2S0lacWNia005Tk1pWnhD?=
 =?utf-8?B?Y3A4ZWxQbmNLaWhZTi9tT1NCU3JyS2x3WWtXR3c2SjdOQkpERjZFdzZiSnBC?=
 =?utf-8?B?N1QrT0Z2a2JERnlPYkZtaDlmMGJ2MitNUG1vZXFCTTVlcmhZMThzYW1ra1VN?=
 =?utf-8?Q?FbgVBOhd6WfFnTVayKvaIqsZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5b1e73-02f7-44cb-ed2d-08dc6ea45ee9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:45:42.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEDSOZFaWBwZ/OJGJMqLoMtVoQr6fsxIlne2rtYXHj9fj/XhC3A6DXT/FQXU4HAG5SvSoG0VxAlQYTLXjg7UNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

On 5/7/2024 02:15, Perry Yuan wrote:
> Add CPU ID checking in case the driver attempt to load on systems where
> CPPC functionality is unavailable. And the warning message will not
> be showed if CPPC is not supported.

shown

> 
> It will also print debug message if the CPU has no CPPC support that
> helps to debug the driver loading failure issue.
> 

You should add a "Reported-by:" here for Paul too.

> Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index be7f2d3c86b6..cb766c061c86 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1687,6 +1687,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
>   	return -EINVAL;
>   }
>   
> +/**
> + * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
> + * show the debug message that helps to check if the CPU has CPPC support for loading issue.
> + */
> +static bool amd_cppc_supported(void)
> +{
> +	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
> +		pr_debug_once("CPPC feature is not supported by the processor\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int __init amd_pstate_init(void)
>   {
>   	struct device *dev_root;
> @@ -1695,6 +1709,11 @@ static int __init amd_pstate_init(void)
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>   		return -ENODEV;
>   
> +	/* show debug message only if CPPC is not supported */
> +	if (!amd_cppc_supported())
> +		return -EOPNOTSUPP;
> +
> +	/* show warning message when BIOS broken or ACPI disabled */
>   	if (!acpi_cpc_valid()) {
>   		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
>   		return -ENODEV;



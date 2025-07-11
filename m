Return-Path: <linux-pm+bounces-30711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D04CB02621
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEB2543693
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68E1E1A3F;
	Fri, 11 Jul 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hsKk3aCG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010E7494;
	Fri, 11 Jul 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268181; cv=fail; b=GWmbsTMRylyKrOPF41lQu8nhDfV5LD6qvpN0C9ycPzapj/s+0ZXFyN4qg4aWsoOzgTHIkZ+BYewMOSsXI2hsJi0F+miPN9FjsBRoj8sDdjuGaeGy+SCu10wqt2PHqoYNo0k8CRXBcbEz8YFuHXY9EPssqyEJAMnWUvh0hELM8/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268181; c=relaxed/simple;
	bh=mEMJ0kh/KpEbjdO96ZvUi5phX/2k7yDga+NDRcQ7VyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4Xb6fcQpA9v+JF401TUquxhc60Xe9LF8HlBgfHSQXkL8TKS4j6SsI7u7UEaFE/AkwFjRcbR30bNY8OZdUXo6qImXpGHJk/2lyBHurVfw/D7y2sMPqvJ4X51pb5KhX97kmjjVWgUjfmbxAHSxy18Bwd1dZi5iv5zhdvKhDwhQCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hsKk3aCG; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yotOwyvaiTpB8sbJOsWHEwr0J/oDly4R8AlDSnhzQ2YC+KOJlFD3V9a8p4/BWouEOWyxVTEjVqAseITFIH73FcE5F+V+L6AA/IZI7AzKpiVL9QmDfhWNU0+x1v3V+vBDHd1QgA4P6WLKVLSssG39PtAQGK+ih7HIPZ0olUr9xTnbcCkcIkRz9lorA+LfzjU4kQwyfSnScG7K3PViaxXJmvlfBnuxOnkFI+E8Bw58zeBgcdc2qZnyLueUlojMQjKnxWYfjKFqRh/AyjdlavEqg7GlDOYTEXWB1eqowjAhk5efccGkvSTOVzxPwyim28paexLvgZYcBDU73cKD7S8CaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I2hfgEgJqcKnJoBDU3kcIBYhVAXIxRe6zoJ4EjehIM=;
 b=ljmM17LyWyMYn2vNAq6jvjIj0K2RiBT1Me3A7vRvVngW/k+j3BUbOJU2oSyQDtv8NOb93MgCPL3MR5gnU4YDL4KAc654hMHsWxmY1Gx4aQU2xYWhHFfaDJicrMNt1Pbd4Rvxk1VLEF0s3zFv9vDLe4HbRLZi7gsS3ZtzKcBT6cmtPppKMrEMxPGhBwxwy0RRTvWxnNA37IG6Swo4U/Vi0n1+yTyzJnG5pKUwT8UYsi7uJUy2P0aCdfl6NkSYj8eAxtpeGv2wPCV/jFeY/xyh2LrR5w1H1QWKGpJop+WHzSv2YqxKC6igpDpmguRj/vPRMGar50bRibPhpiBzIzlcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I2hfgEgJqcKnJoBDU3kcIBYhVAXIxRe6zoJ4EjehIM=;
 b=hsKk3aCGqQhjfsNiuS2XhzqOBFdkQgBJUaMaRnkM4f4Tj5m+wQ5sRewgrYyaM73ls2BLnbpM3sNFNu712iyY46E1Vf0dtGQHsf5PmcSR9CsynKWcTNu03zZxgQojrb5pc4uJ/UG4firSka7wEx8g5ZFoIkc9PdgU6VPnDTZxF7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 21:09:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 21:09:35 +0000
Message-ID: <6324f224-0c63-402f-8bf9-66386c73909c@amd.com>
Date: Fri, 11 Jul 2025 16:09:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: suspend: Drop a misplaced pm_restore_gfp_mask()
 call
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <2810409.mvXUDI8C0e@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2810409.mvXUDI8C0e@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:408:80::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: e46998a0-b6ad-4792-78ad-08ddc0bf3d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDI2S09zdCtacWZ5djhaYmFoanR2bmpvTVRoTHd5ZkExaFN6bEg4K3VWMTNu?=
 =?utf-8?B?NTR6QVIydUdaZEprZDFEbEV3SDl3WkRHQXc2Skg3NkJrSnYvK1R5LytjZjRE?=
 =?utf-8?B?ZDB2a2lWaEJMd3lxT0tYZzRveVdoSnVQRlY4ZFFkT1BKcWZ2dWw2NXdrdngy?=
 =?utf-8?B?RXVLNDMzWkoxaURYUmpKei9wbk0wNTFQd0c2K2VmZkthbTFiZVJhVHlQdjBm?=
 =?utf-8?B?S0tvVTlhUitRaFp4d252VGhtR0FMNWd2QWlZdlNSQXd3MWhzNXVmVUhFRGRi?=
 =?utf-8?B?OTZYNGczODVZSkRXTHB5TFd3c1RHZS9qTjFqR2E0d0VFRTdtT1ZWNVRXRTNR?=
 =?utf-8?B?NTFvMk9BUURDTGNXWk95SUJzMEU4am5nUHdJcnN4REtidDhXekZpb1pUVmRC?=
 =?utf-8?B?TjQ1QXNRcnc0Tlh4RnVYVUVkVGpPaTcyVUlkU2RpY09LaGNzZ0c3d3dBMUxB?=
 =?utf-8?B?RHJjbnk3RmloQ0RKZ3E2NzFNTm9iS2xmUnVUTGtFdy92MjloS0luZWVMaFc2?=
 =?utf-8?B?Q0JXeXUvYVRSeGg5dkJJSFJBTzhkeUpSdDQ0czZacHhOY3hjaVUzZThUU0dy?=
 =?utf-8?B?aXkxdXViTmNGWnMreG9QTUdIbEVUVjVJa2dyVzF4UnZsWlA3aU9KL01rWmdK?=
 =?utf-8?B?VnVqVTcxcHdCSnYvbWJPVTlrbkVNQ2JkcjYrUjRWcTVTTE1BWEN6WW4vVmZs?=
 =?utf-8?B?MFdSYTNFSXdjZmFpTzNqVVFJV0xFc2lDd1J5THE3TzFiQVJDalg1UE9pbENr?=
 =?utf-8?B?YnhVRUpoZnJaUTcxVHBFSEYwK0xFWUZCN282cFlweEF1eG1JL2tHNWo0b1p1?=
 =?utf-8?B?NFljdVNyRzJRZWlHL0cxcmR0dFhDMTJpdUhqZEZuZzcwUzY2SFhiUGNLWWxT?=
 =?utf-8?B?d3c2clZTWlU0RDBlMlVJeEpja3J2cXB5Qk9BZHlpSzc5S3RyV1hWb1JjdVhK?=
 =?utf-8?B?MTV3S1lWdDVVSkg0Y3NHOHRpNlBBNUVnZ2xzeXdoUHJrUExpQWNPQ0phc3Zi?=
 =?utf-8?B?ZXJscHlxdzk5VUFHMmhvNmJLc0gyVTJTQjNIWlhEUWVGUFVNMm1DUkdNaElr?=
 =?utf-8?B?RmJiN2ZYNGszTklPSHhRWlNEcFBheXFWZm9iUXFyZGVaaEV1Wm9OSXk1M3Z0?=
 =?utf-8?B?cGpLWUxJS2Q0QmpyazBuOTlWSTRJa3l6MW1ERFZEVVQzYzZnMm5LellnMWVa?=
 =?utf-8?B?L25hTmk3UzZZaktjNVk4WVlKOUpTZ3ZRMkF4bjRWWWJ5dE0xRDJzR3ZBekFO?=
 =?utf-8?B?clQzcGdJY09RbmRmTWd4V2RtNllsVGlhYmJwZ2kzZGJrMnhVRlRPTHZhb091?=
 =?utf-8?B?RlZPZjVOUTNJd0psTzA0TEhaUVlZYlN0KzNDUXNEaVRRZE1zUVhDZnFla3dE?=
 =?utf-8?B?UzlXNENqc2NyQ2o2SjR5aEJNTzFUSTRSRVM2OHFldzdTT2tCbDlnMUFGR2tx?=
 =?utf-8?B?cHQvWDM4aWpHaWZ6OVVidXg4QkdaZDA5bnorQ0FJQUp5MUlhUmlmd3UxQ1dn?=
 =?utf-8?B?Y2xKU3U2RnVzVGZpZG1pak9jN0NhRFE2OWoxeVRSemIxakdXcXVaVExnV1cx?=
 =?utf-8?B?dHdlcHhwcnd3OW4xQXpCelRhdThvRlNPWlZENkdUWGRlVUxVUkFJOGhtNlJh?=
 =?utf-8?B?V0VLZmRIc0pmcnFRd3dhMEJiaE9EWUROV1EyRlppeU1yNUVpVElSMXMxZlBC?=
 =?utf-8?B?dFZmMVRtd05DUEdwRHBUb1N2cnR2ZHlWdXFRb0F6Z05vNUJmTVRFanhpYmZM?=
 =?utf-8?B?a3RPcDBoK3o0SUhGOU5EM3hOMlUxdkNrUGtkN1FnSjBOWXBhMXMvWWtJTWRn?=
 =?utf-8?B?QnV1ZEpNTCtYbUdEekxIRDAyVHppQTVaZy85VVhxRTlJVm92dXNNekdNeGt4?=
 =?utf-8?B?VkU3OG04alBJRWEzTmo4UFM0WWdJbmZ5NFIrTGhvcFBxUUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjRnVVJGTGFQaXhHVTFVT3R0SHFSRjcxN3o4OUw3VW9PaGo4cUdiZThuWVp4?=
 =?utf-8?B?VDVLTW1sdzVxbGdEZkd4eHM0RFF1WEtvdS8ydVVuOXlFMnF5eC90YXR6eU1O?=
 =?utf-8?B?NUp6aDFzdjBQajZsNkZhc2hDc294Tjlva3VFVTNVWGl3WmhMTWtFTndBL0FG?=
 =?utf-8?B?Sm5aa3AxUUtQL0gyZ2RQRk0rMkIrbDRCU0dHbVZ4Y2ltZlpzK1V6Nk15bHZX?=
 =?utf-8?B?cG0zeTc1UXpudXVBaGlpcWxrWVljTytvU25ZelUrckxlcGVqNXRDcitWRnJo?=
 =?utf-8?B?cVpiS3Rndng5NkE3SkdOOXZzZUptWmRmNzBQUE5BWFE3K29vc2RkWlBudC96?=
 =?utf-8?B?bTFyL2J3N2Yrai91eENVUDJMWFRzdXVHUXRvSUl4ejZBbnFlMXh1QnhjMExh?=
 =?utf-8?B?RHhzS2dFeDgrbWtJM2NwZUJ0ckhuVUtLVk9IL0JPTlFRbTM2WnBZVmpwampw?=
 =?utf-8?B?eUFNRU55eTBvQlBJR29zUXNac05TankwZXhrUVRvc25HblRGcjc4cU1Hb2dq?=
 =?utf-8?B?UjdWNWlCaXhzQkNrTHVqSUVKeVArenZDU3NkSWhjVmJYdHNFWUw5M3RvUkJJ?=
 =?utf-8?B?VzV2bGx6YlBFS2Mvd0Q1a2ZLTEd3eUdWMFYvQUJoS3pGZGpOZnZzclMwRzFR?=
 =?utf-8?B?NXdPRGdSS1E1bVY5U2FkNXRVeW5nZmtaK0VaNjQ5T0N5azNYTFg3U2xoUE1D?=
 =?utf-8?B?K1JLYStwcEJ3NnNyaTFWWFJUK0VROWplZzhBcm5sclp3VjNRMlVFVStoOWhq?=
 =?utf-8?B?VWlwQVlLOXhHWjgzQmxzRFNWTVYzUC8zcERFUGppelRMbER2K1d6QjVlemh0?=
 =?utf-8?B?ZkVFSkEzU1ZTUEE2TW5wS3lJeEl4THJESU5jckpoN1o4K0JnQjgyQnUzdHZh?=
 =?utf-8?B?MGRXcDZtdFVSNFNSQW5VcVIyZmxzNmN2Z1hVcmtqYUFkbVhzbExqUDNNZ0Zs?=
 =?utf-8?B?SEJtWXB4S2hJWUxoT2d0bFRtQnozWlN2NHN6bU12YmY1d2t4Z0x2TUYrQ0Ni?=
 =?utf-8?B?NWxGR1o0ZVRzcDJ4b2pjU0gxNVlPeUdGc3VGK3lXa09jaW0xL2RpSkxvb1hS?=
 =?utf-8?B?Tm0ydnU0NWRjdkdyTXhOZngyMEpLZ3ExRm12ZGM5WDd2bEs4NnZXT0QrYWFF?=
 =?utf-8?B?NUhiZDBMdGg0aEdhYitRTWFqK1RzZUtKVWRlK1A0YzlCeVQ2bW5uWlNpd2pl?=
 =?utf-8?B?Y254a25GNGtieFJJWkxFMmtkdUtyK3ZXL2orSDBCWXllN0IzTkxML2dmYXVk?=
 =?utf-8?B?cVQ2WHM2ZUZjbWxLTEZ4OWN4QlBxR1hmTzRxSVpKMHlRUmFJY0drL2ZPQ0hZ?=
 =?utf-8?B?MU5vOFR6NW5kcHQwa09SVHZwQVdlTG9CU2JMZ3RXL25qb3lKUVJmd2o2RHdP?=
 =?utf-8?B?R0J0TmRuak5URzF4Znl1b2ZFdkQ5UlRmSU9XclZXL0RPbVl4b1dXK052OE5w?=
 =?utf-8?B?bEFxdzJsZWl4cHpxSVNCMElEampySjVwcDVJa293K0Q2UGFOOW1BTDkvWGpy?=
 =?utf-8?B?YU5NVFRuR25NSjY0TXFnWFJsRkFSZG1ITDAvYWRDc0pmM3Mwa2JHNyszalVu?=
 =?utf-8?B?T3JpbktyWUlwdmFKZ29KbEk1ck5JdEp4Qm1qK2NncmNDVHZQRkNaSDB6ZExp?=
 =?utf-8?B?a3hFa3VuYUgxWkFYMkxEdUIza2N2K3MyM04zYVFJbW1xZFNsMTNqbFNJRUQw?=
 =?utf-8?B?amxTNjVjS2VMN2t0Mnh2VFVDdnkrT01STzF4OVdKQ0RPWFBraUxucWljOTJO?=
 =?utf-8?B?a3lKUGt0aFZNSUJOVUFaei9xbm9sY2IyVHlTWVpVcUhzNWg1WGVqVVpsK2dU?=
 =?utf-8?B?Z3hGK0dDOVpGTGV2Q0pOY3VqSUZHVWpTQXZKZVVYZlJCZEkwWWNBVFp6WFQ4?=
 =?utf-8?B?S1ZSenNJSHkzaTNzNkQwb1Y4NTgxKzRPOWIrTW9FV2svbnFUSDlkaHV6dTd2?=
 =?utf-8?B?V3dndTdPNUwxYVBQemorTkxUK2tmaVNzdUg3VG5rbnpEYW1UUktoM2JFM1F5?=
 =?utf-8?B?NHFHenhYV3Uza2J2Sm5RWGNvcEtXQ1F3S0J1UWdjbTI4TlhGK0FiSklaL0F1?=
 =?utf-8?B?ZXJxRGFMcEltYVNxdWxzZ2c0endhU0Q1UHoxMnhaZjlrVVNzOCtSN2Z1bWhi?=
 =?utf-8?Q?uYl2z9wcl6iWgzUWSF+OOye/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46998a0-b6ad-4792-78ad-08ddc0bf3d4d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:09:35.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/TDYHtBQzVgsLIC+aTQ0XheWSip2lQVLEn06xXtmYpT5vrwAUdb9w1XeKza5MEP9wScbMglpGvAEm9qK46EEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

On 7/10/2025 3:43 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The pm_restore_gfp_mask() call added by commit 12ffc3b1513e ("PM:
> Restrict swap use to later in the suspend sequence") to
> suspend_devices_and_enter() is done too early because it takes
> place before calling dpm_resume() in dpm_resume_end() and some
> swap-backing devices may not be ready at that point.  Moreover, it
> is not even necessary because dpm_resume_end() called subsequently
> in the same code path invokes that function again.
> 
> Drop the misplaced pm_restore_gfp_mask() call from
> suspend_devices_and_enter() to address this issue.
> 
> Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   kernel/power/suspend.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -540,7 +540,6 @@
>   	return error;
>   
>    Recover_platform:
> -	pm_restore_gfp_mask();
>   	platform_recover(state);
>   	goto Resume_devices;
>   }
> 
> 
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>


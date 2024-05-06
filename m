Return-Path: <linux-pm+bounces-7535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579798BCEB9
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438B9B2025F
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A46745D9;
	Mon,  6 May 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2HfSu3eO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595D15A5;
	Mon,  6 May 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001065; cv=fail; b=Q2xE047qhmfuP0DkjNk9xKdgHwga/Z+x5VGhRZyAWEOZ+majL6fM+8mzXGpHvqGSWaFirbVxXVzANybu9lwL/ZhRftfi5PH+AogFmRpm97Ax+aMHqpaZWLmJDQK3DL4UL9Hc/GaEtQaRRmXLp8OsqCf5qWdJlDmzUacDvw9++ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001065; c=relaxed/simple;
	bh=I2WZx05G43wpMpGhtNvK45mTlTVdRySVeR3zh3m9Evc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lTcgV+MoUbuoMDQJXn9fA8MExFRzpKQCyDkI3ZGd/nQ5aKFchcxsTNu91i4g+fla/NxJq98jIQ7D/IhKg3FwGqN8jU6rRYg9Dk34LYntJHQdqh3YosVBwuok0QR/uRBrFjqXn2fsbrYswlieDOjIVl5IKTsLZtxCnF4pAjT/7k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2HfSu3eO; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrNG5xAFmJaM+FNETJRtIDDhijNkpxcRfjlps1QlE4UCYtKRlNPYxbN5gskZLdgTl0QHSiHX/jRbzet8JWrTLTE9t9urIDBaXUPJtgNxsDeA/2B8CHV4IZajPQSKvES5yr5ZdSYuHk2dwtaJ1/Ugffs8ZbyX2ZvgcWA8c7Y2/Ew3KPofBXwOaWyy8yQTskdkLQz2JQxncmI6VxRhYD/mJ3jsf6foZTf4rbtuKW8y9ljqsTFf/qYSZeXtHUM+UUX665J7KaJSjWdLP616NUM96t5N79HNf70NZUu9HVn/rOdwyiDtXVEr0WfKPYyh1lgk5DQXtSQQO8f2AN731VlVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS7/e5ZXiGxR9u7yL12xU0hnIRnwCAC4NSddNp0uWQk=;
 b=kvppR1bToCuiOkxJ+byKUF5dWcZIvPif35DsXitHp5EyNyTzZ55kG4970+iagGVPAqasVqTPpkSpPDSXvQcgaFu/4ddtZz24l61aXfUif6Oh+wQjESxOZoDznz1clCu9s3rvH1lWtCGwmX34LCP4mHdWGBBF4iCTdOJ6uF40W2Ki4TGE/wG0veF6ywNc/ElNewH39amudVsn9Nr6mreen8ewGxX45+mCM9/3v5DwrjHz+0hk/HIIV3jQ0Z8aDAtNA4QsuBASHEzQ7qKAntXTtBEOPZDLjaAfsqefhMe9zisWilHw1y8yEQ70jeeVOLw9m/n9UrROXzox+YV+Bvw0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS7/e5ZXiGxR9u7yL12xU0hnIRnwCAC4NSddNp0uWQk=;
 b=2HfSu3eOxCQe9hXG34OUOqkDqOnLbuFCjiukach0g1EDQfgVKnUTK277tJKLLy9Omp0tCPlzP4Dw83JsDnQIJsccMh/RxBNMqc8Pc+sxISwirWK/U9nanKcMp5PTdhJ3AUm5+3EnY5zr9IoEeXY+fGaKm+qjz/rqWMWq4hSeJiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 13:11:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:11:00 +0000
Message-ID: <84c58078-93a4-406a-8abb-9054854e54a0@amd.com>
Date: Mon, 6 May 2024 08:10:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_framework_laptop: introduce
 driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 "Dustin L. Howett" <dustin@howett.net>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
 <20240505-cros_ec-framework-v1-1-402662d6276b@weissschuh.net>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240505-cros_ec-framework-v1-1-402662d6276b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0018.namprd05.prod.outlook.com
 (2603:10b6:803:40::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a950818-c05b-4b43-894e-08dc6dcdf99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWZoTFdWVENhUGVLSk1sMEZkQlFacldWZWZmNzI5RUtRek90NXRKQUExUDd3?=
 =?utf-8?B?aFQ1VzVLS0FMOFNJVlExYUxoM1haMmpkMTZSbVB2SEUyc3EyWXJ4eW1UUXRS?=
 =?utf-8?B?cXhkWnZLcUhwUDJ5bUltcjZTWnhhL0hvMzJrNlJjNGhiNUxvMXY2cUE3RFRS?=
 =?utf-8?B?ZEFVMVRIQnFDUStMbnpRQ2pCWmdoMHc0aUFmRkNOc3R1R1BRRm5PSVlmVHVJ?=
 =?utf-8?B?SHkrb0tMRmcrSUxYVldqV2xZNmduNXk4MlJGMkkzN2JmNlpRdm5KTzl2eCtL?=
 =?utf-8?B?MzNQUmJmdWxpNFFiZkZ5QTZDdkt1blNjTGZOZ0NFblkvbnQ5NENNeUwrV0xv?=
 =?utf-8?B?N3hvQ0duK3N5a0RuQW55cFVZWW8zVElpRHhxNHhuV0d6MDdUQTVtRitQeVhJ?=
 =?utf-8?B?ZnFCeklCNjdaMVpTUzc3S05aWURnVUY4bVBnby8yS3pzZlRLdVM2RXhNRDNr?=
 =?utf-8?B?K0lXZ01sZXVCSmpWK0Z2dWZhWFdTS1gzYkp4MDl4QjdsZW5Wc1BtOUNnM0Fj?=
 =?utf-8?B?UHlERytTM1NteDdYVHYzeTJvM1pYMTArcUoweklNb0pncVJ6bnJBUlgwNmVT?=
 =?utf-8?B?WnRSV1A4dlp1Q0o1S0hZZzV5d2hybDJ4WjJENTFDc3RqdHpTUkZYcWxXSnVz?=
 =?utf-8?B?YXUyVERha1ZsUEJIM2xtWmYxekRmeU0zRkdGSkE5c2lScWpLcDg0Yjkwc1FB?=
 =?utf-8?B?TUxhZzh4ZmlFcDBzNC9DekVFby9FejN6L2N0MUJZbG1LaTdPMFBpU0hRSU9T?=
 =?utf-8?B?alJHdFk3V2E1ODJVdkRSMnc4VmlRL29XRmtNM0tvUG9HbWRPRjB1SHcrTi9P?=
 =?utf-8?B?dUVBUFdOWlYzM0NuRUxaZXhQTnJSVkhKdEs3UTh3WWtwa0NEeVVuaXVGVzdF?=
 =?utf-8?B?eDJqZ1ZwMEhnY1BpSzhCT1E1MTlXaHI2Z3N3bGhDM3hqR0VCZlVEbGRGS2dY?=
 =?utf-8?B?c1lCSVNuNGQ5RkxjZTVkWTUvN3MyZUZ3TVZhVGN0bkxzZTRCOVQzek1jWGs2?=
 =?utf-8?B?TEVIYlo0b1JCSVFrTmdNSlBycERDZFF3ZDlxeDl4UTFOS3VMYjA0akwzbEcy?=
 =?utf-8?B?V2U4RnlrbWhVQWltbkxuU2NSZlZKNGk3Wk9pQ1BzRlZuT3F0ZVNzN2lJSHJV?=
 =?utf-8?B?bUFybjh0NzFuS2Y1cWY0ZWhJYWxSbE1uTUFsb2RYUTk0eXpUYzEvWjlWaGsr?=
 =?utf-8?B?L0pkVWdrdllkc0dsc3NsMjg1V2ErVldNTUwwN0s1WVozNngzY3BkeWFOK3ly?=
 =?utf-8?B?WlJNbmM1bFJkM2c1NUpFOVIwZ0dHVUQ1RlVCQjJtcFAxZ25Ub0Z3NTQrd0t5?=
 =?utf-8?B?TGpuaXFNRUxmWS9UTWhxRzc3Tm8xOS9lQXVnT0NtcWFobWhjaTV6LzF6cm1t?=
 =?utf-8?B?ZEtuWDdQa0dSeXNpNkhsZnQ0Q3NlOVVrUVY0ZjE0eThUaE16TDgwSWNzTWRl?=
 =?utf-8?B?SG54bWo2ZFRpQ0xRaGs1R1VmOHJFY3k1N01NUmxaNnRyVnorOUQ3L2k1bSth?=
 =?utf-8?B?RC9QbDVIOTJ4dTZTejI5MWdRbG9lMzU0N000K0N6Nm9iY0wvaTJVZkRtdGxj?=
 =?utf-8?B?OUVMRk5FTTBjMzZVcVVVNGZiOVZXTkdNMExkYlNYNnFmMzFjWjlVKzhqVTdC?=
 =?utf-8?B?NUlqM0JKZ0orNzM5L3BRTkE1NW5mUmRJQTlqVmpmbHpSM3BZL2NObGs0MklP?=
 =?utf-8?B?U0hTYVh5ZGhxSExvVHFoTE9JdHZJUGxMZmtaREh5R1hsN3FxRWpSZExBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVNvVEt6dEMzYjJrSHg3ZG1QRXVEd29UaFI2VVZkTU5ZUDV1dm00WUpBVGor?=
 =?utf-8?B?V20wOXZ4V3NNNzVGaGduNDVLaGsrWHR5R2ZaTEtxQ1E3c2hwbDU3ME9QYjFL?=
 =?utf-8?B?YkZ0ajU4L0pETCtrVnJKZkk1QkE2NktpaVBCQUpXdmRYZWw2Z1RPa2tRM0JH?=
 =?utf-8?B?MnlVSmVJZWxad0ZlMkZ4RElxQklDUHl2YTMyNFVsRk02bG1FRUltTXRVY2JD?=
 =?utf-8?B?Q0FwWkN2c3ViY2FCTWpDN3VQaVliSnlNVm0yK0xjU2xGZU0zQm5XUlpMS2RR?=
 =?utf-8?B?aTJOM1ZGTEkzZFJqT3RENkNKZVZtY1RDd1VnbUltZzVYelFRdXV2Rk9sM2sx?=
 =?utf-8?B?cVpHYmZNNnlHT2xDaUVCa1dSUStsL0hjMnd1cUNwUUNBMTZxMU5PaTdWTnJ0?=
 =?utf-8?B?aGhhWkJ6Z3hBUVhCQ1YwVmFIOHBMQXhadklNU1dDM09PRnhTN0Y3VDBXSVk4?=
 =?utf-8?B?SE9vaUhQUFlPM1FHMGxDejhhRmIyaHYyaWlXQnVRa3pPM084WjZCUjRMM0dU?=
 =?utf-8?B?U3V5ZXowMFc3S2JuVFJ4Z2Z6THZmZW5WZXpuaVlZUlhRUXQ5R1pzUkczb3Aw?=
 =?utf-8?B?YmcvS0kvbGlXdTFXOXZubkxpczg1cGMybDkrSlRtVTFLN002VFNkRDhNb2Jy?=
 =?utf-8?B?YWlESEpvMGtoUlVyMEZtdTlnWVJWMmNucVJySERtRVo1K0FMWUwzc2U5K1FH?=
 =?utf-8?B?b0lHczhnc1ErNUdGS2lqbGUvSXo2cWE0cHJtbjEzeWJFdjNiNHJsbThkcmZ3?=
 =?utf-8?B?WW9xL0xidG9NNGUrRDE3TDNJNGRPbFBuUG9tMTlzTHFuTjZTMHowMW5zd2hD?=
 =?utf-8?B?dnU5UjN2MTM2bG42TENHMXBKLzhNOHRPaHU2N1R2NHI5NTFGMnQ4QmtYay9K?=
 =?utf-8?B?alpUU3ZjUytLeTFoQytYSDJQTnZaVnZaL2orNi96UFZEaDB5SmZSalRidjRR?=
 =?utf-8?B?RFdSY2QzUHpvdGxnWHJWd1ZIZnQybHEyN08zVmRKSXhEYU1BRlh5Q1lYYk1D?=
 =?utf-8?B?UkppOCtwTExlbUU3NDkyOStOOW9EYS9vT296YmN6RDBNdXZlenlLREFBemhX?=
 =?utf-8?B?a2lucTdYaldYK0JCRk9JNkRJNU11T3hqc2JYY3phcHAvNzVUaGxDN1dWU0hO?=
 =?utf-8?B?Y0tGbHZPY043aDUwK0hrYTFZak5vT0RWMXlTbXNRNms5RlRDSHF1VmNodTdl?=
 =?utf-8?B?U1ZqcmlLeHhYS3VFUkNCRlVwQ0dFUXpTNVhhaUVXTDM4a2lUalBQc3ljaGRF?=
 =?utf-8?B?bXBWdkZtdW01TkJjWkFJM2ZyWTQvL3dvMmlzUU81bzUzVHM5dXJHTVRQVFo0?=
 =?utf-8?B?RER2ZFVIblhLM1JCOTNrc1lsbndNclBJRjVpU3lrWDZXdTE2bCtvbjdNZE5z?=
 =?utf-8?B?dGRKWkgrL2E4NXZyY2JjcEE2eFBkaGZvRnBObU5HSlNJbVVhck44OSs1Y3Z4?=
 =?utf-8?B?MFhoNWdhNkN1eG1qK2FWT1Jla3FISzMrUEFkaGkya1p5bzZFNWNWVWYxWEY2?=
 =?utf-8?B?YllOaW85bUFwS2d5OFVXNmQxL2NaTVF1clJGMHhYMktYQ3ZNbFlEeHNpWUtP?=
 =?utf-8?B?V2RQSUVROXlWSkFHYlFmTnlDVFFTbkJRYmU4WUR4VTZrRzR0OGMzQ0RhMTg1?=
 =?utf-8?B?dnFTNmhiMmRoNDRFL1FCZ3laZ2NPSjZ4am9Ma1Z4cUtKNk5nRzkvb0IvOUhQ?=
 =?utf-8?B?cFNGMFR4eEJJSFRYRTBJQ2FqaGRIT0ZTcTR0NzFURjN6R2JQUkVrdmo5OUlH?=
 =?utf-8?B?dFZFR1djMnhxc29SdGZRM1d5TVY3VWkrbHdqT3ZiZEozSnErbnRmdmdtc0xY?=
 =?utf-8?B?SGtvRTdIYlFuNWJKcDZiTWltclFiOHlqQWtPTXJwWFNWU0t2NlVSNnlaUFRu?=
 =?utf-8?B?Q0YyRkllWVJldmZtdnNMSklIU0FGMW94Y1lKa0ZhUklrdXU4eHlMdUdTdDhs?=
 =?utf-8?B?OXYwTlRJTG5MVXZNSUxsenRzcDNrRkhFelRMNVhkZDF5UG9GSzBQRU1CV3N2?=
 =?utf-8?B?VytaS0QzQjNWcWY2MjFFVmVuaWJwdVlFM2RUOEM4OXoxZ1lqSXgzMHpqdXhn?=
 =?utf-8?B?Y2ZWNUNHVS9RWmw2QkdsWmsvbFlVSnNTS0lEOU51Z3pHQ3NrYlJscDMwaVpE?=
 =?utf-8?Q?g0fNKeFKk/AelA5aoeUQpHMeZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a950818-c05b-4b43-894e-08dc6dcdf99d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:11:00.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CpCdjcunnMgg8p+rZV7Hs9S5lC8iETWtXdcZtCGmx29+tbWqHx0Mxk/1S0Ic1G4t/pUVoPtySgqtq24s+mV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609



On 5/5/2024 3:56 PM, Thomas Weißschuh wrote:
> Framework Laptops are using embedded controller firmware based on the
> ChromeOS EC project.
> In addition to the standard upstream commands, some vendor-specific
> ones are implemented.
> 
> Add a driver for those custom EC commands.
> 
> At first, provide an empty driver that only takes care of scaffolding and
> device binding.
> Further patches will add functionality to the driver.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   MAINTAINERS                                        |  5 ++
>   drivers/mfd/cros_ec_dev.c                          | 13 ++++++
>   drivers/platform/chrome/Kconfig                    | 11 +++++
>   drivers/platform/chrome/Makefile                   |  1 +
>   drivers/platform/chrome/cros_ec_framework_laptop.c | 53 ++++++++++++++++++++++
>   5 files changed, 83 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c23fda1aa1f0..60699c289757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4988,6 +4988,11 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>   F:	sound/soc/codecs/cros_ec_codec.*
>   
> +CHROMEOS EC FRAMEWORK LAPTOP EXTENSIONS
> +M:	Thomas Weißschuh <linux@weissschuh.net>
> +S:	Maintained
> +F:	drivers/platform/chrome/cros_ec_framework_laptop.c
> +
>   CHROMEOS EC SUBDRIVERS
>   M:	Benson Leung <bleung@chromium.org>
>   R:	Guenter Roeck <groeck@chromium.org>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index a52d59cc2b1e..0a36e77e5039 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -145,6 +145,10 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
>   	{ .name = "cros-ec-vbc", }
>   };
>   
> +static const struct mfd_cell cros_ec_framework_cells[] = {
> +	{ .name = "cros-ec-framework", }
> +};
> +
>   static void cros_ec_class_release(struct device *dev)
>   {
>   	kfree(to_cros_ec_dev(dev));
> @@ -299,6 +303,15 @@ static int ec_device_probe(struct platform_device *pdev)
>   				 retval);
>   	}
>   
> +	 /* The EC on Framework laptops implements some nonstandard features */

I don't think there is a spec really for cros_ec is there?  I think it 
will depend upon what features you're talking about if this is the right 
way to go.

The reason I say this is that maybe some of the same kinds of features 
will make sense for chromebooks that use cros_ec in the future and thus 
they should be "generic" cros_ec mfd cells to probe for in some way.

> +	if (dmi_match(DMI_SYS_VENDOR, "Framework")) {
> +		retval = mfd_add_hotplug_devices(ec->dev, cros_ec_framework_cells,
> +						 ARRAY_SIZE(cros_ec_framework_cells));
> +		if (retval)
> +			dev_warn(ec->dev, "failed to add framework laptop devices: %d\n",
> +				 retval);
> +	}
> +
>   	return 0;
>   
>   failed:
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 073616b5b5a0..ff69ee226606 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -239,6 +239,17 @@ config CROS_EC_TYPEC
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called cros-ec-typec.
>   
> +config CROS_EC_FRAMEWORK_LAPTOP
> +	tristate "ChromeOS EC Framework Laptop extensions"
> +	depends on MFD_CROS_EC_DEV
> +	default MFD_CROS_EC_DEV
> +	help
> +	  If you say Y here, you get support for using Framework Laptop-specific extensions
> +	  of the Chrome OS EC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called cros_ec_framework_laptop.
> +
>   config CROS_HPS_I2C
>   	tristate "ChromeOS HPS device"
>   	depends on HID && I2C && PM
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 2dcc6ccc2302..ce6aac620086 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)	+= chromeos_privacy_screen.o
>   obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
>   obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
>   obj-$(CONFIG_CROS_EC)			+= cros_ec.o
> +obj-$(CONFIG_CROS_EC_FRAMEWORK_LAPTOP)	+= cros_ec_framework_laptop.o
>   obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
>   obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
>   obj-$(CONFIG_CROS_TYPEC_SWITCH)		+= cros_typec_switch.o
> diff --git a/drivers/platform/chrome/cros_ec_framework_laptop.c b/drivers/platform/chrome/cros_ec_framework_laptop.c
> new file mode 100644
> index 000000000000..8a8bf039fa9c
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_framework_laptop.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  ChromesOS EC driver for Framework laptop
> + *
> + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
> + */
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME	"cros-ec-framework"
> +
> +struct cros_fwk_priv {
> +	struct cros_ec_device *cros_ec;
> +};
> +
> +static int cros_fwk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct cros_fwk_priv *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->cros_ec = cros_ec;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id cros_fwk_id[] = {
> +	{ DRV_NAME, 0 },
> +	{ }
> +};
> +
> +static struct platform_driver cros_fwk_driver = {
> +	.driver.name	= DRV_NAME,
> +	.probe		= cros_fwk_probe,
> +	.id_table	= cros_fwk_id,
> +};
> +
> +module_platform_driver(cros_fwk_driver);
> +
> +MODULE_DEVICE_TABLE(platform, cros_fwk_id);
> +MODULE_DESCRIPTION("ChromeOS EC Framework Laptop extensions");
> +MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net");
> +MODULE_LICENSE("GPL");
> 


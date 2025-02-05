Return-Path: <linux-pm+bounces-21422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1669FA29808
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C5A161B9E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA89200B9F;
	Wed,  5 Feb 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d2PFhfq4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2441FF7D3;
	Wed,  5 Feb 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777886; cv=fail; b=OoyrhbmIRBhu7kSYPSxBEnkbIeZPUERwIEdyFy+g7yPSekswnDDN7MModKsSiVgFGaPjk9pXXyT+0HYcmw6tcrQbJ65Fqoz04465rnJ3hUz8e0LGk/BUZOoa9HaSx/qPFisL92xsWIRkO/PF5jjDPlt5A5+rhqnX2t/aH4K4X3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777886; c=relaxed/simple;
	bh=CLDevzoxHC5tzj/qcwJd/zSG3CfaLu3+QytOO2P//PI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gr2lqnU6BFjFEnfmQRfB2ibWr3ckRSsMSEM6bZSq9EgahO/vsXcxLGdDRgF2QzknaONtOYmpuLJe0E/tkAaK+JMk0Hz9mrd5mjp9t/RBW1dB1owCs2bLzvskZ1xdkvj7bu18OGYmSgBYmY+xiU0UUkxxWMyxw2zmx2XIOgfz+WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d2PFhfq4; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEGM6LUKZVrBF861o3s2Yy3+9GHrU59b0DhvJQX6hR5/bNirOYmTkPrEMoBv1JBvPSJtTaDHiJCk3AIinBFcNpynIuJEyyW98wwMV/V/e/Coi6lzhuFzfej+XGNNRY8MTpp1wl2DkoqjN2Ej3SAqwEOdncoH8H7qKiVjd724OeT/V0CZ0NK84SzRXPrnKxx5pNdvf+BjfirehMLavShYE4GPgqU6VrW7Iuin746FP6MYnQhN/O4EM2I0heUGmDppbzFIUJFPTIJL0W2xGEHN+uJ5lAFxEIxWzO5cr78iVOdlyTcImrlINVSY/Vbyd9P7uHyyy9GjCh2AX1Nv4GgjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4CsBlNb3rYHXdiBscCwmwcKtZO5QdkxZbcztLROGks=;
 b=jDoFscmNs95GucIOZcCwnXT0U2nWuzYbm1Sw3Ze5Q42baxgWvt6XKkEg6MOoX2ZAWhksjFb6T4BahnLFrAbE6aXr1xAF2HnKpTORzlq/0C2Yb7/pTHeR0MqPmQL0/noYxP7uywPJnZF2N7t7SSioo7lQ0yb03+kRlgbthc+zebAuDnnv2m+v4tY6CwfVD9+ntiu9TIXt8APHrbZnhbaXEwZKHycoljHkhFVjViHMHHWOlMzH+dFUGKbdgG8nJBtLAsnAP48Lv31XF9g12hAbAdm8Wmv4Q4QbWLpLgavH5j7EuHIYthuWISTWEUgA54GpswDjbaJ2SNtN2ziumEO2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4CsBlNb3rYHXdiBscCwmwcKtZO5QdkxZbcztLROGks=;
 b=d2PFhfq43qvr8NErc+GbdlB9iF0DAQne3rkjP4sLyWkPVr2k4CF9tZugo0l7GxbcuZh0orf9oRxt79uUiIf7Ei40fX3moYwmNvyLPTdoHA6DRKARJvSo+8uUal7AKMrfOYTN5L4LoxhD0DyFhaTXYLh6HLs/2Usnke35XmGM7FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 17:51:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:22 +0000
Message-ID: <c2a31d45-4780-4cbd-a219-53d99449c4ea@amd.com>
Date: Wed, 5 Feb 2025 11:48:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] cpufreq/amd-pstate: Add missing NULL ptr check in
 amd_pstate_update
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, rafael@kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-11-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-11-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: b6db024b-7da2-43aa-4cb5-08dd460db3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXBvK2pNMXhPeHBRam9pOGVoTUR2QTYxeXg2VzVHM1RpazJEdnp6djFDZndy?=
 =?utf-8?B?N1MwUnZhVXk1aE5TUzdHMjN3OWg4Y0R6cHhobVVWS2g0cEZFMS9kRngweXd4?=
 =?utf-8?B?WG0xM2tPeTU3QnMrdlNZZjlDMmhTbFpFVDMwNk8zeXdFdUVnVE96QTRxNTNM?=
 =?utf-8?B?VFpBbE90RkhNQ2FLZTBVeXZHQ1ZWWlYzK0dnQzVHQmJlMmluV1lBaWkxWUQ1?=
 =?utf-8?B?RnhGblBsMC9qaGhRem4vUkNrMFRDbFNISjlhQzNZVzlWUkZMZnZFSnpKN1JH?=
 =?utf-8?B?WVY2Y3pJOWN2QUJ3QmRKNkNGamFtMmxpY1E3b2NaSXVVeW5hWmt0V0FnZkhX?=
 =?utf-8?B?ekdLWXhWSHV1WUlxNHZxNnhzT3NISk02TDdEUXlobU9yeTY3aDQzc0liM3RK?=
 =?utf-8?B?RmI3elJsbU8zdmxEY3B2bitvQkVhVFdyek05NU5ISzR3VE1PbER1ZUxyc0pm?=
 =?utf-8?B?UzJpZU54VHZCSjdveGNBTitzbVN0N2YxQ0dZcG9KcmNYc3lLUDB6aWw2aFFk?=
 =?utf-8?B?NFZ2amFGYTI4MndhOCttN1M1QnNpVi9rT2JiVFVRQjN6M01uRlZxWS8xNkFC?=
 =?utf-8?B?M25vTlZXVXBobXlUU1QxQVJPQzgwSmpudk1GZjNEcVoyMTA5TDhWY2V3b3RZ?=
 =?utf-8?B?bzFqUExxdVAzc2Jzc1pxbEhWNTZZNlM0QUllMlBiY1k1VW9KSjV2a3E3R0RU?=
 =?utf-8?B?RzB5VUx3SG82ell5UU1HeWJSRnBFRE95ajhmS2JJb0djeE12VHNPa1V0cS9s?=
 =?utf-8?B?UkF6Q2M3aU1JRVhJV3FzV1NxcHV5eUFZWjJFY0kzS1d1UE5MSFpsemV0K3VF?=
 =?utf-8?B?MVBMcW9iSStlR1FoMUJtQ2VnWlJzYXRQSXQyRkg4ZzkyQUJUdHkxbzZ2MVJJ?=
 =?utf-8?B?SFYxM0dEbzdqOTJpZGh1dnJWckFFdnJ6djY4Z2hac2Q2dFk2NDcvREFxbkZp?=
 =?utf-8?B?SDROM0cxdFE0QVNpSUVsbVR6ODBLUzN4UEw4WkFZOFJpSHVSUm5CVkZOUzhY?=
 =?utf-8?B?OUkrZ2MzcEw4S0xpbkcvNEFWMVNUM3hpSy8wVWlqMUJhS3FkTm1MUFBKZXE4?=
 =?utf-8?B?ZzNDbzc2U1lydVNHbTNDdGNMb280b1NtSEdwbW5MT2V1eVVpcmJQK0VTc0ZJ?=
 =?utf-8?B?SXh6YVpQcnVxY1VnL1RLNmw2WUh4d29jM040MFEzRmN3QURnWlVrZDFNdnBJ?=
 =?utf-8?B?bklVN2lVTTcwZEwzTHRMWHhOdnRGTWRSWVNuOWd1a1pnczhBUUluamU0c20z?=
 =?utf-8?B?RXFRM1JObU1FQkEvYVBiTTJBN28wZDN0cjYxZWpYWDRueWNqVG1hRllJSnM4?=
 =?utf-8?B?dXlkRnBuKzJrRS9tMEorS3NUTGZuZ2h3bFcrYTdkUTJFU25HUE9EU2gyUmhq?=
 =?utf-8?B?QmpCcU5EYS9adVZ5akZmTW9HYU9XcWl2NVQ3d0lYQTN5dnM1eFNaUi8zNWNi?=
 =?utf-8?B?bW5EYllUWlAvbElGRDY5VE94TzBjMHVjZXVsTnRCR0RhYllqSHpYRXBpRnlF?=
 =?utf-8?B?Ukt0cUc4SFJxdVM3WG52bXd5a1Y5M05jbXJ4Zk96ZHdveVBZZHNzbmFZWXhX?=
 =?utf-8?B?TGxMdnlzQmdieFRWT0hKams0Ny9RbW5UUDN6SlFJNWloSHUwRWs1NUN3c0ZT?=
 =?utf-8?B?QmNmZVowcVhISi90TWhJMmcrUHBob0ZxeVE0Z1FuNHMzdzFqb2l3VWk5VWw3?=
 =?utf-8?B?WTQrdmpEc1FPNTJ4WW1GR2lWREEvSVc3azdMZ3FJRVh1RG5FS3VBaWs0OGdN?=
 =?utf-8?B?MmpLL29LS3p3MzdSZG1CZmtBcERhb2xlRFBHUGpRRE5iUmp0dVVlQjhidExr?=
 =?utf-8?B?dW1CbnIvNGc0ZDFIY0h3K2N3YU4rcnh3ak16OEVqcnhqZjFuZmo2eWdnVzV6?=
 =?utf-8?Q?V/QsVBrQOAFs2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhDRFc2V3RJK3pqaDhGRWM4d3NtZXU2cVg1dE1FbUx4dXhmK0NISU95U0I3?=
 =?utf-8?B?M25ndzVaVERJSXpBM29HUjZEWVJzdDg1OXJ0dGlDVWozdlZOUmZWZ1hOMWpM?=
 =?utf-8?B?WG5pTDBDREJSRUNVWUlLazF0M0YySFN3RWxsb0FNVFptWWFGMXFZK241N01h?=
 =?utf-8?B?RUlZcU9WVVlreTRGdmhxcVh5eHhlU3Byb1RYMVlQQXpOSkhRS3dTREhQSDZ1?=
 =?utf-8?B?OUdkQ3M1QmtaUWozaDZhT292WXN5RXdBL1NiQlJYcDZsNXY5OXgrbWNmcXls?=
 =?utf-8?B?UDM1ZncrVThydU1NNmR1c1VWYklhellkWjBCMnVJRGpyNjZTV2FGVzJWbDhq?=
 =?utf-8?B?ekhsQXlTNUJPQm9PVElraXY3Qm93WlY0cUUvUjRDRldMeHFFZWw0TGdDSXpZ?=
 =?utf-8?B?L0FWclhlcGo0azhjNGlrUnMyK040ekRGWWM0WkwvUG1iblpnMmg0amxDOGZD?=
 =?utf-8?B?SDhtMVcybmM1eHhKdmdJZ2xkVGFTSGhoNlphcHBtMS83NkIyL3YyUXZ2ZHlD?=
 =?utf-8?B?YU9BNS92ZGZnYjkwUWhLdzFXNzA5RktRUEExWlFxVUhQTG15aHVjMlZxaWwr?=
 =?utf-8?B?b2dwdHRRVTNCQ1ZTMnpQZDlGNXpJeVAzM05NeC9jWjhYTlRiemJmUXZuOHVu?=
 =?utf-8?B?QWVSbDl1d09iMjZyOEMrbEk3alZ4ZVNEVHBHTllJbDRnSnVtMDZpejBhSkFv?=
 =?utf-8?B?ZG80WE5vbVZRaEpzQ1kweWlJNFhScERxS2hPbmJjSHZBclVRQXZOcVI4cDR6?=
 =?utf-8?B?V084SEN2c1J5RjlNKzdaNFU4OWZEOFFzVWZaRXovc21qbnpCdTI3bzB1NGt1?=
 =?utf-8?B?TDljak1vN1JsM3J6REJ2cFBQbnVwS1FGN1dyUCtJUXV5dnF4OTgwTzMxZmcv?=
 =?utf-8?B?bkRKTkQ0Tjh6VWJhakFEMVE1aWVkRFozc0J4TGxRQWNpMmJGWDN4Z0p1MVpW?=
 =?utf-8?B?Znd4ZVlTSHJ3azBRUEhXQkwxVGVBT0EzcmhDcVEyR2pFMzdGOHNwaU5QS0cv?=
 =?utf-8?B?YUZ0cjRpVXE4c3UycnRNaTZBTHUzSTZHM3ViV0FFWC9QMEFIR3oxbWk2NjUr?=
 =?utf-8?B?RTNQck5FTTZZSGNkNHBodWtHbDFrYjlwWXhOaE56ci9zNHY1M1Y3MFdjME9D?=
 =?utf-8?B?MERxMlJkRzI1UzhiL3h3b3hWZlI3QkJyT2tIdklUaFV0WGR5NU11TDZuN3Fn?=
 =?utf-8?B?VTZDVkNheGdmdFhKS2pZc1ViVzd1OUlyZGluem9rejJrUWx4ZnFnNnpNd0tk?=
 =?utf-8?B?TEhPQTVMVjUzTUtKVlhaOU01eVB1U3MxK0NSUlpXc2lXTmZRMFdOL1pvQ0Yv?=
 =?utf-8?B?OXhsTXFSa2tieU9OUS9pT3lMekp5a2ZCRUNlek5ncjhuenlxK1lkck0rdUgv?=
 =?utf-8?B?Y0VLdFhDV201OTdoMFl1WTY1NjhZcmRSSnJ1US9XckRtOXgvbjl5SXBLZFRH?=
 =?utf-8?B?Um03OHJzSVN6eGZ4ZXpDRjRseUtvamF3UFluUzV2ZFhDbndrdGM4R3JiT3dX?=
 =?utf-8?B?YTVZbUZ0U2JVNklvUFJWTE40WlJnNWFKeFljcnV0WXZHdUlvRk55WDJwNC9E?=
 =?utf-8?B?VXBxN2VlN0g3UUNEenJnVXRRUEZYZnJHWG0rekFoTzJJNmw5MiswSkNxZ0xM?=
 =?utf-8?B?YzFrUjduWVl2OXNJVTREdldEOXZRV3RNZmNKbnptVFhpd25oSTV2dHhvaU9w?=
 =?utf-8?B?Q3NzVlZxZXJWL1diL1VxT2hVb21tRWloMGNkRTFRNFQ0RVoxdjJhWUJyYlhx?=
 =?utf-8?B?bnJZZ0FteEtOVHhOcFFTejcrL1A0ZmIyQzA3REMrRlc3R1QwT3U4ajMvbmtl?=
 =?utf-8?B?bmpOZ2ZrcktkL0lycGNNZWZyK3NKVHRaK0pNL3J5TUhBRXJZSURFWm9ydEE4?=
 =?utf-8?B?c3BPcS94bE41ZmRPM1BISzB5N29oUWRyYkU3a0dudFlabTVDVEVhSG1POFhS?=
 =?utf-8?B?SDFkUTFkZ1pJVHUrMjVJZWtGWkVPNE1uRFdxQk5qTU5VMi9PVlFWb3RYUkIw?=
 =?utf-8?B?WS9ud1JFQ0JtMW5FTVllR2FXZG9iblhjeVFRRGRkUUxHUXp2bWUxNE1Mdy9R?=
 =?utf-8?B?LzZqbkdMamNNMVg3YmtXZUJ5VDVBMndsMFlVWHpBVEtUNFpodXJYU1BRYm5W?=
 =?utf-8?Q?TDIRtgJZU1zfqGAFq6KWxcDoo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6db024b-7da2-43aa-4cb5-08dd460db3c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:22.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8RQZr/Ke8KkNsqfOVTOFUMu7jf0wJpPO2oAO/V/eyACCrUDVBt3DjaTY3CEPv776ZMkb7IaS4g5Kv2LQp3pBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> Check if policy is NULL before dereferencing it in amd_pstate_update.
> 
> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---

Thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this fix for 6.14-rc.

>   drivers/cpufreq/amd-pstate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9c939be59042..6a604f0797d9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -551,6 +551,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
>   	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   
> +	if (!policy)
> +		return;
> +
>   	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>   
>   	policy->cur = perf_to_freq(cpudata, des_perf);



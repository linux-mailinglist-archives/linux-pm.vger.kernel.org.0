Return-Path: <linux-pm+bounces-25056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025C0A832E7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB5618988B5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB92211285;
	Wed,  9 Apr 2025 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LoCXbBI/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37401E5018;
	Wed,  9 Apr 2025 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232295; cv=fail; b=U5AZD5czC1yRXickO6bHgReqmghEzv0ll2cbQLcBi/T8CDM4mNHtoOWQ7FND0N6TeubBoXpv3nD5IMGn+gFgfOAEJmerTjsP7cHvMrCGG4KYTJY/JEGcEc+sCPiTWsetScSsrputw7UyQ0J714MUxPgp5Bsv6cisQNrBxkRr7fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232295; c=relaxed/simple;
	bh=ErTGCOeCsURQFaQ1K4sTLVp9Oucu4A4H+30Cd/eCFF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AiUKkjUt5nprKrrCdTvfJdTzT6ZPuLyjEiipGEO5RzhqbwpTF/pQhsueigeM/dBCSKeFD2KLlwWq48ayOXFD8mGC5t9OrFEjL7raiFloSeP3vGRB+KCBqZbr2oUpZXCBt8hFPhX7ozLHFeB2Dk9wfqa517LNqDuch0TowPRCO1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LoCXbBI/; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHTouL1VnHovr1wP5GgaqQX+MTeYyyDFJB+c5nVLgDt3NO4G52lsX7bjnDIHLtRDht87bZSsuBYMXdYHzF3/ncGuWwimGLv71jfPGdg/zOATbniFCD1rxJmPklaUxc4HcfT6gF9XieivTHGlRJuy8nN+Q8/ENqfFYjXxwoAsJpNwY4lTlAqp5GNh60LN5lpkzNFjR/1OvA6WL9ut1Svey0rd5Fa3+u6Wlead4JavO+AjO/5aNSSTkVjAVTWKp5y3Z4jlVzWuHFN2LS1KSHyGh6+RaSR1DQbguRS+HR7Jd63inO4jjamc7tv7lHpCTFLt7ukA6nCfWjkZhaI4BrgkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Uz77EW42lZsfusO+/W5gj+EOyG1lmw0EcYbhDNHZDM=;
 b=uU7b1kmEdevfqM6CrVHa6CF4nTjfwJI8ZR7zq5wfSSFLQ60WgB5teLAQ45HRvlsDIz1G3ScPOtqddMEbBhL1Jxg1njtNg7upi4xqcZv3uy/7FG4Pj3i2t+fS7QMs/Naxf5l66mUQSK0GfUzejSzTgg8OQDVsZ4bFmPcb4rLO8RayDDvAyamDqD1cldj/RV8hFP32XGUVA200FiFU2AsICGsFJ7dGJNiel19hO2ern3DXlyeDXtvHNdfT1tUKC7ZDlvU4Km3dDcBEVPCQzcpA1OIxkSELNVzzrGQoP22n1feo4JyDlm3UNDb1bFBwiAcKZecRpFTJzvc/Vyir3+iV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Uz77EW42lZsfusO+/W5gj+EOyG1lmw0EcYbhDNHZDM=;
 b=LoCXbBI/AcldRLQkenLTymuVyzL/+JQR2HpD0wh85g+rCweSf36yaa0b0LjkJTj/7Hf5AFI4ejpNRDb84R0uELN6yK2FR2d1n701MVyeg4/brZeaSlTHtEO82W+XDNouO1rlcM/ePK0lJmMtF1mCgtxCrFuS84o/7Mg/BHysyZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 20:58:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 20:58:08 +0000
Message-ID: <483e9fc0-28bb-4531-88bb-738cd9ce9eb3@amd.com>
Date: Wed, 9 Apr 2025 15:58:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Enable ITMT support after
 initializing core rankings
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Meng Li <li.meng@amd.com>
References: <20250409030004.23008-1-kprateek.nayak@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250409030004.23008-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:806:126::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 953196d7-acde-4d0c-abb8-08dd77a93b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlE1d0Q1QzRpVjZEUEczNStpQm4ybXlDSmhJZDhpbUROV2xYcndqVXcyK0lX?=
 =?utf-8?B?RFhDSHBBMVM0KzllTmd4b3pDWkdUOXEzbElPK21ob25SemxQeXhoeG1kSTZp?=
 =?utf-8?B?ZFo2OHRaUDYycjFPejNneUk3dWZUdFdNZEJiSWdWVWEyNjZoMTJpclprU2FG?=
 =?utf-8?B?SzlGYTJ3c2gvZkp5VWNXS3hZcHBkNERuVHBuVjZYSEJUUWtKZjVIdXdoOVFs?=
 =?utf-8?B?Mjc4dzdUUEFpSXpPVDRkTm9IaWYvQ3pIcTFmSlhGZVJtcFozQjJhZUpiYjhk?=
 =?utf-8?B?VXNtM1hiQTV6Nndrd0MrSTBwLzNDaXNHSVZPVGRBOGduRExEUnRGYzRodnFk?=
 =?utf-8?B?Zy9aKzRERjVwcE5Oc2tDV2hCTElyOERudEJtT3U1dnllM1pZajMxTjczOGlx?=
 =?utf-8?B?dWdpanJIaXhTQzJJdlJSV0NLQWpNRjBLcGFwNlQyQTQ1M09WMmNBNS9CRnVB?=
 =?utf-8?B?RWR4T2VsdGVKK3B4OVlmZVd5cEtKcTA2enFSbWdVZ054V1B6akVMYS9IcDlF?=
 =?utf-8?B?RDg4WUlKek5SRGVDaFJNdnI3eXg2NU41em0ybGVUZ3dtd3RHTHdta0NRSXFD?=
 =?utf-8?B?am1Qamk5RzBLRnlPZk1mbWNLbmxFY05KRUw3WU9GK1k3UHYva1kra2phTHFC?=
 =?utf-8?B?SWp5cERuWHZhWXZLMCtZeDJjdjA4V2E5TFJ1MUlIMnl3cHVwK3FwZjJ4N3Q0?=
 =?utf-8?B?ZnMwZ01Vd25UMDdXZFlmUWN2SnRLOThQLzE4RDk4Y3FxTTVUM0Iwa0Fla3V3?=
 =?utf-8?B?Q2VrOFBKWUJIbjh1SEFSQ3BCeFJvdWIyTy9ESkRYZE5ReUV0THZMaExiNGYv?=
 =?utf-8?B?M1Z4TS9kYklWM2crSWRIV2pBTDF2N2o3bXVxSURxN1RlbStFbStPbW0ybk5K?=
 =?utf-8?B?QjJLa2FMR0M3Umc2QWFLZ09pN0s3WDBxQVhUSjVadE5hRUZyV214a0hRZWxr?=
 =?utf-8?B?YmZvVGR6M09Kdm1UOERMMXEwSzY2ZWFkWFdwSHNXQ3MrcmVNQU9oQmVBbGhN?=
 =?utf-8?B?VWx6YWNqNktoTWxGS2dWSHU2cE55ZUtielM1UWl4a2FTRFNreXpyczgzVUdK?=
 =?utf-8?B?QlNTKzVhYjJtc2hTUlpudy9RbkxIZGJ4OHliRHF1K21vVFhCRHBYUkxUS1pj?=
 =?utf-8?B?d1Z1T0t3amdGUUFJRXlPanJqdW94SllYTUVubTBPWUo4Szlxb1RlQm5WRisz?=
 =?utf-8?B?Ym4xYUF4dGM1UzJSUWx5RHBKbXl5TTJLVDF1YWN3QXNjcjE5ODhUTWJMZXNq?=
 =?utf-8?B?MHpMZVQ0MWVNOTBvZHJWR2RMVWMvUjRwOGVJZE5aSnA4UnNUU1BHc210OEho?=
 =?utf-8?B?QlBkT2hqdVM4MHNSckIrT09iZXR2NEJVeHlRRk9UamxDQ0xYTXhSWHhwVnFh?=
 =?utf-8?B?MmVYU25rdmxaV1FCNWNta0FianlWL2FGdE9KRUk0dTFac2VrNXBieDcyVmcz?=
 =?utf-8?B?anBER1ZlRGpRQk9XQXZEWDU3b21KQVVKYWRRQU1nS21DcFlQVFY5SGZWaTAz?=
 =?utf-8?B?SlRXMDFjNWpZT0tzUm40WGV1NHN2RVhEQ0JFaktlekp4VlNaQW5mRk1DWG12?=
 =?utf-8?B?R1hWQWF4NjdiSGxFNldXSGhNVVcvUTh1R2JrZFlUWnVLWm0xbzJjenhhWkhV?=
 =?utf-8?B?QkxKMHptZnhOUm14Wkg3WEthc21sb1NxTXo3NEdLdWVzbDYvVkVzWVFCc1R3?=
 =?utf-8?B?MmxrYlFDb1JGdUF0c1N2R05BeWNwSFRxOVc4L283K3JwL0FMQWxISExtdElJ?=
 =?utf-8?B?dVJHVU40alpRc1c2Y3V2UjNlZGJDTFA2a0N3OVNVNTJHUStlY0xTTlpFN25P?=
 =?utf-8?B?czFmQTZyODZtTkVUMC9heXdKS1JWY3p1Rzh0dUdxcXFxaG5IQ1NxRmp5QzBt?=
 =?utf-8?B?aWFObGJVc2JvVXZiNkRtbVd1anJ0UG1UQncvaW1YUXhFMkJxMUFJYkdBc2xT?=
 =?utf-8?Q?QavnQCqhcfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTRVSTIyY3JtTjEycVNmcitIRzJZdVdvMU5FQ1F5ZHl3cUlBSWdKYmhGT0Q1?=
 =?utf-8?B?WVUwbGo5bGFMQkNrTUhYZHBkdjNZRW53d1diUDRtVDR4ZHhSTUNjS2lXc3Vh?=
 =?utf-8?B?ZHVVcU5uRnFOVFFpU29rOGlvb1VVYm11cUY1VmhGTnVNS1BtbVJ2WXVkd3U3?=
 =?utf-8?B?eG9kMWJvOGZKdURsWDFIMW5ISWxOR0lJcXhWNnZsZnk5MFJiMlFURU8xREp2?=
 =?utf-8?B?R1lLaklJUHBHemtMMG5wei9TSjVoL0I3TENNZDNJOUs4UXZFWmc1QS9VOFhF?=
 =?utf-8?B?M2hJSGo3akJuOWdRVS9RemN6RDgyaHNWVlRtMmxyeHZpRjN0b3R5UmIzeUR4?=
 =?utf-8?B?UEFlVjJ0bFoveDlWbDhQUjBjc01kc1RVQy9yM3kzUkh6bng3dENnS2dtTVBa?=
 =?utf-8?B?VUJ5WWJ1SHJrQ3R4NjZoU0VmQXhuT3pNN01JN1NSUys0djBzOHMyTk1IOW11?=
 =?utf-8?B?VDdaYnVzaXdhVElqV3kweHpiNm5PV2NZSlVnZmtkcit3aDQvaDN1RXc5Rmd0?=
 =?utf-8?B?QW1WWWpxaEpGd3BpSE1TUHo0MXlIdVphSXQrSnJ0L3JVNlR6K0FGdEhvMmlw?=
 =?utf-8?B?akc1dFJmTlcxdEhMTzNwaDBqeEN6eFhPZFVUMzd0aXVKQmFuYVA1Z3NybWFm?=
 =?utf-8?B?S1Rwc3NnazVlWWZLb1A4Z1lub2ZXblVGVityWU1ZREYrVSt3WXQyOUN5aWVm?=
 =?utf-8?B?ZHVSK3czdUtiY3FNUFBBVDQvWVV1WkJ0T3B0ZFlyVE9NdDZ5QTNQbTJoa1F5?=
 =?utf-8?B?V1hhSE5xSDRxMVJPVXpHZi8xMTM1dWhyL2NvMVVDSFZpMmp4c2o5VzZQRHQ2?=
 =?utf-8?B?OENCZjlmMlJzSzhYcXRLdTZhb1pvN1RqTWVyK1UrLzV3QXZpRTJCbzl3dlo1?=
 =?utf-8?B?bEJrcUZDMTlnczFTanpjVFB4am1ubGNFWS9vNFc5N050RUxaTUJWeGw0SGpG?=
 =?utf-8?B?V21rYUk5SUJxZFF4Njcwb0JxQkQ3Y2tTSjBCV0h6c3ROR2lYL2RDSGpHOXZP?=
 =?utf-8?B?dWNoRnJMTGZUdDRVazdKVW91TWRzLzgzS2x4VTFyQTM4SEtuOTc2dHNWRTdm?=
 =?utf-8?B?T01DQ24zdTNtc09BMitlVlExVnBwWmRWdnFXNkc2dWNrUVR5UWFKUHJPWEhP?=
 =?utf-8?B?M2Z5OEtJNmM1SXhuMDRqMlA4bE5wR0RvNGpqWlVKOTNUR2JnZXdYbG5XNity?=
 =?utf-8?B?czViQnhYV2c0YmxQck40aTUwaTVSejMwV09FQm05ZUJXVUtNaG15b3lKbkla?=
 =?utf-8?B?K2R3NzFKNDhTQnhxNDN3WFpuRDYxWktUa2hGUHB4MUhGS3hrYWtiL04rTGRT?=
 =?utf-8?B?YmRvUlkrSzh4ZExWV0orRUxxeHRHZ0s4VWc4MDZLMEJJZThPV1d1OHhCTDFr?=
 =?utf-8?B?MVpyRE5mc0VsakZUcGVydFVuZGE4TDRmS2xZdDJuWlY3K2hKazVLSXY1d1lU?=
 =?utf-8?B?RldnR1BueWtnbzV6RkNkWUxyeVRIY2JqSmxVTnROemFPYnpmSEc1b29EWGYr?=
 =?utf-8?B?anRWakZrejFPS0NKVGlaL0w4b0lpV09GRUdQbnNhZ0gxT29KdERZU1hNZVJx?=
 =?utf-8?B?SFNlVUcvNnc1K3V3VVVFck1tWVRSOFQxVUJDQ3JoZ0J4cHZRN0hGaTNxZTZ2?=
 =?utf-8?B?WjU4MFI2U2luUG5SZkppeVBhZmFON0xZV2hzTjdmRm5oK0VhV0hNRFdySTBm?=
 =?utf-8?B?WCs1Y09DdmUvTlo4aU4zTEtWcDBGYS9mSUZsUkRlb3BHZno1WWlxaFIzQ1c1?=
 =?utf-8?B?NURMZFhvSXI2UjBWcktuRzdEV3Rpcnp3dkQyT2diT0tsbVZGSWpSL2M1NUpk?=
 =?utf-8?B?NkZub1U0Ryt2K3ptN3d3MytVQUVIRzM2REhBK05ub2w5ekQvcm9OeUJJN0pY?=
 =?utf-8?B?Vjl3L2Y0dmg1ZS85SVIxOENSaXhKTFovbXBVM1ZwaDJzbzFlSlluVzVWcGtQ?=
 =?utf-8?B?RjNCN3FPdXR5UjBSZklUUlJxbERqQVpUVzRmV2tJQ1Y0VnREdUMvVG5QNVFS?=
 =?utf-8?B?RmdSNWRpblFzMHFoU2ZJbjVOYksxa0NmZjNIUnNwTGQxcDZjaC9XZ211R1gw?=
 =?utf-8?B?YXVaRlZpc0JPME5JdmVFQmwyNnVpa0pnaW5WVTByaDRtUU1nKzVWZjlXcjV2?=
 =?utf-8?Q?W1fpSb7gKJH8HgwIgdY3yIbU2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953196d7-acde-4d0c-abb8-08dd77a93b52
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 20:58:08.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/yH9H1IC2oyLAo4b9+zVREQqac6IB/hCecEMVQk8LenPJvxQWNOF2jbmwwHjEViExNVAcPjeyRQva4K9QiCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072

On 4/8/2025 10:00 PM, K Prateek Nayak wrote:
> When working on dynamic asym priority support, it was observed that
> "asym_prefer_cpu" on AMD systems supporting Preferred Core ranking
> was always the first CPU in the sched group after boot even though it
> was not the CPU with the highest asym priority.
> 
> "asym_prefer_cpu" is cached when the sched domain hierarchy is
> constructed. On AMD systems that support Preferred Core rankings, sched
> domains are rebuilt when ITMT support is enabled for the first time from
> amd_pstate*_cpu_init().
> 
> Since amd_pstate*_cpu_init() is called to initialize the cpudata for
> each CPU, the ITMT support is enabled after the first CPU initializes
> its asym priority but this is too early since other CPUs have not yet
> initialized their asym priorities and the sched domain is rebuilt when
> the ITMT support is toggled on for the first time.
> 
> Initialize the asym priorities first in amd_pstate*_cpu_init() and then
> enable ITMT support only after amd_pstate_register_driver() is finished
> to ensure all CPUs have correctly initialized their asym priorities
> before sched domain hierarchy is rebuilt and "asym_prefer_cpu" is
> cached.
> 
> Remove the delayed work mechanism now that ITMT support is only toggled
> from the driver init path which is outside the cpuhp critical section.
> 
> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c54c031939c8..ee638589f5f9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -794,19 +794,9 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>   	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>   }
>   
> -/*
> - * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
> - * due to locking, so queue the work for later.
> - */
> -static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> -{
> -	sched_set_itmt_support();
> -}
> -static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
> -
>   #define CPPC_MAX_PERF	U8_MAX
>   
> -static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
> +static void amd_pstate_init_asym_prio(struct amd_cpudata *cpudata)

I think the previous function name was fine.

1) It still does set cpudata->hw_prefcore afterall and
2) We still have an amd_detect_prefcore() that is used to determine 
whether amd_pstate_prefcore is set.

>   {
>   	/* user disabled or not detected */
>   	if (!amd_pstate_prefcore)
> @@ -814,14 +804,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   
>   	cpudata->hw_prefcore = true;
>   
> -	/*
> -	 * The priorities can be set regardless of whether or not
> -	 * sched_set_itmt_support(true) has been called and it is valid to
> -	 * update them at any time after it has been called.
> -	 */
> +	/* The priorities must be initialized before ITMT support can be toggled on. */
>   	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
> -
> -	schedule_work(&sched_prefcore_work);
>   }
>   
>   static void amd_pstate_update_limits(unsigned int cpu)
> @@ -974,7 +958,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto free_cpudata1;
>   
> -	amd_pstate_init_prefcore(cpudata);
> +	amd_pstate_init_asym_prio(cpudata);
>   
>   	ret = amd_pstate_init_freq(cpudata);
>   	if (ret)
> @@ -1450,7 +1434,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto free_cpudata1;
>   
> -	amd_pstate_init_prefcore(cpudata);
> +	amd_pstate_init_asym_prio(cpudata);
>   
>   	ret = amd_pstate_init_freq(cpudata);
>   	if (ret)
> @@ -1780,6 +1764,10 @@ static int __init amd_pstate_init(void)
>   		}
>   	}
>   
> +	/* Enable ITMT support once all CPUs have initialized their asym priorities. */
> +	if (amd_pstate_prefcore)
> +		sched_set_itmt_support();
> +

Hmm, by moving it after the first registration that has the side effect 
that if you changed driver modes from active to passive (for example) 
ITMT priorities stay identical and aren't updated.
I guess that makes sense since the rankings /shouldn't/ change.

I feel this should be OK, thanks.

>   	return ret;
>   
>   global_attr_free:
> 
> base-commit: 56a49e19e1aea1374e9ba58cfd40260587bb7355



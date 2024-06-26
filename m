Return-Path: <linux-pm+bounces-9984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF69176AC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CD11C210CB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBB45C07;
	Wed, 26 Jun 2024 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ToKR8ylI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37D14AB2
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371669; cv=fail; b=OPXYvg33N+ISy2fGH4onxkDUd3dzJqDKtEyfc7IaFVcadHavVjy3Rjfo508Y/zkt1BYvwCC1kD2ArbrjQdP72PnCXv3goHfE7TtqMD3SZRyZHGGd+MgNk509pNqVbbkmMmeCkrSIwKqXDkdhH013i02AV+OBltTeRrAqB8uobT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371669; c=relaxed/simple;
	bh=4esqxAsIolOV7w69JdHSUsuZu3nP1aw/ziXC64WYh4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7O2I9iaWFFMCjxFyOKJWuxrHEPC7SwUok5YSWRBGpwnl3fjOuc22ZooR39pCb7HbcP1pbt3FUjkXIu8mJRvT7iY1+I6k6ydRXuvllkia5lYMT37Yq7Dc6zJJhMFx1GTmwI2iH90iQxMayQH0NP4hBuDwPPPXKM76Yd45FfmBzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ToKR8ylI; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adYIeZo6cor8moLnRlcDdW3+HV/fUVasTTpzYPY2HXWV5/uGtC+caVM0Gc/xUAxUFrSMPvt/vw9qe6qyv8bmu4/9n6x7dbgMimPZ7xhCi3hfSrkwmSZF04vVVP7AOkURxtyRZCGslrY527m4f4AVTbcT5i2/Czcpv5znsGDtZeBBPWOenI6WNO0HaCwCoJTcnkapK9KFC4i3tYM8dru9IFQN4x/KUQg2VflJzcfGXvX5/4Eid6i7rN5wwptW+zYOCv473xwqCsC9M91XWQHmkfjU7TtVLVmg+rZdTFERpqEh0Xk9p4qvA+PIEZ1I8tLrTlzPGevfXmzjSJJlrFaCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cBla4TtrpOt3YtO0LVKrki4K1oNBcSGn06JFSeJamM=;
 b=Acmck8ug+7CgL+tz6EDRZdjsenvxZ8Nya2e03XvhNVfjvl8ENtwbtYdUkumySpXEv7mPLFFUrMQvMuqNG9wMIs4YQADpg7nPcPb2k3CN+ggOj5UdXSqk1MbnAxgJl/q4Egz1l79o1yl/keHIBeeQ3LPDVWWxFYXsoDW6/ZZP0/y1uJ/TnzeME8Df/KhDCWzt4z6zsxhDfG+DtjeU4elbrlE/pDU+dq7Fb0we1bd3Jg1W10Mh9vm8p0NvDtiRvjrcbjzYe2B50eKZNf0U0h5Hys4Uk7lpIOpXE3Kf1C58YWXH5yl0l5miU0agiKukQ5GLl00VHifTpF4TFqdlWAJOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cBla4TtrpOt3YtO0LVKrki4K1oNBcSGn06JFSeJamM=;
 b=ToKR8ylIvKIjzAYfWdCLFWq9exwtX1tlRymIBgkulym5e5YzZLyQ0mCfCZT3K3JSOuUMIVk6qavp7xOmtn9rz6F2XJ9bDcwZNt9kbPr3NE+XEQWeqmtTfHMKfSDBRJdHsj1QAZkqs14gg98NdrIfVd8ywLQdmidTmc2uoUL6xvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 03:14:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:14:25 +0000
Message-ID: <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
Date: Tue, 25 Jun 2024 22:14:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
 Linux PM <linux-pm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 307168fd-16ac-4770-f402-08dc958e14ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGJIMDR0a2w0VDRLOTlNNEVFMFBPYTlyd3BPTUhVMXk4TVpETFE5Z1ZsYUY0?=
 =?utf-8?B?NWxraE1GWkFWeWhHUzU5dlNOZlZsRi90cDlDOFVtZHBKY1lVYzA5QjMwdng1?=
 =?utf-8?B?NHV2TkZ0M293aDJxWEhRSmVrdngxQXB2dHF4UExvbktsdDdQbkF2cTJiWjdp?=
 =?utf-8?B?K1dIVjhEUmpJSlg2QUpQeHF0YVN2YjIxM3VRTWRDRTlVK2dacVRpaURuQzd2?=
 =?utf-8?B?djdKamswSW1RS1pUbjl4TlJnOE9ESWpIRkZyUjJwbkRCTHN0SkM4dHRJNURk?=
 =?utf-8?B?Wm9tT3F1Z3pzR0xoMnpNd0ZUbkl0QmpkeldLcXFDTGdyVVE3OEY5Qk1wMURV?=
 =?utf-8?B?WlBMK3lkQW5mWHlPUXpiRitMRmhUNGYyRGNiZlZJWGF5OFBtRHp6SmxmZkQ2?=
 =?utf-8?B?ODJGWlBHbG5qUThreExHVG94MXRHdWhqYWZEZmJnMVAycDQ1WjRDd0phUGpN?=
 =?utf-8?B?cXZUbHMrYndNRDRyZEJXWHdEVURrVzkrVDgrUGMzZXAxOU13M0xyRVJ6aWlj?=
 =?utf-8?B?eFpEbVo2MExJbW00c3pCYldUZ0FmZjJmcHpRbXI5WjN4SEhRZFowYXkzZXhR?=
 =?utf-8?B?cTBoS1RhNEF4R1kvcUVaZUJkSElPY1ZxQ21vcStxTjZ5TUxNTytvWXRNU1Bx?=
 =?utf-8?B?U1B3WE9hcllKVkEwL01seVRCWmJETzVmSGV3VGF1ZVlJdExIaElIbWp1UGlt?=
 =?utf-8?B?TXdwMk5YQ3FSeFR4UkpGNGluczRXUnhKNjlOcVUxTFdnYWhEOG84eTVCRkg2?=
 =?utf-8?B?S2NsZ2Q5aVJrb3pmRDZqQTdWRnE4RVhKb1JyRHZ3Q0VaM0x2NWZscVhmZVEy?=
 =?utf-8?B?VnRobitXLzY1QlowdnlTOEszeExXczJiejI3UmUzOU1jdVVjamR6Um1PTGp6?=
 =?utf-8?B?c1lFMDN3a1R0cGJDdkFRZjVIcEZtWnFBMCtDZlpEc3ZRY0pjWHZDOG56TXdT?=
 =?utf-8?B?Y29oQjBSbXZKbUpuR0pIa1M0MHZDcVVFaElhVmE5ME4zdnRWVTIrb1Nmdjdp?=
 =?utf-8?B?OEdkOFA3QU43WlNrUzlyVHZhYXYvVHVEWUlZbFRyZElOWDJ6bFBmcGNvREdl?=
 =?utf-8?B?ZnZGSWZzTGpGTzVmQXE5dHZYRXFtVWladzB1Zi84QWJkSXNIOGExNk10K2tY?=
 =?utf-8?B?b3c2WEZWS29CdTBLWmwxK3hGTFVYTzVTblQ2YnFIQVBDTTNPYkkxUE1VaFNG?=
 =?utf-8?B?L0lKRVdYcEJNV2FaNzBDdHlFeTFwaEdCNGRzSVBFMEU1ak9sY245L2djVG9w?=
 =?utf-8?B?ei9EY3dGb2pDR0RSdVRTdzV0cWI3OERlaXBrelhBdGk2WlhKbDJuQjVENGwz?=
 =?utf-8?B?a3orNXRKbms5Qy9QN2tidFprVFZuKzloeG1NQTRMdU5OWGVRUmFJNFh0aDFj?=
 =?utf-8?B?cnZ5NGp2S1dIbXhxWExqcGpQU2RWcW5iemc0MEIrc0lLZmh0VUFTdjBYQXlN?=
 =?utf-8?B?VE9Pb1pSY0hZcy9nWkZaSE5yS04wVC9mODA2VHFYMDVIRnJyUnhmOSsvSlJV?=
 =?utf-8?B?OExJa0tXekVSOXJzQzdhR2t6b2NNTzd3TjlLMVpPc0hwYjVhSEt6R3lhbHp1?=
 =?utf-8?B?dzdQaDg0VU9CdVAyc3RjQjJEaHNwcnRzV3hVZXYvd1pQanNhcjRDU1FpYnp4?=
 =?utf-8?B?aEsxM25aNVRUcWRFbmxTNnNJNVRHZmVRaFhTMlE1eVBtbmVRbEZOTkY3Zzd0?=
 =?utf-8?B?NlZXMWV3N1E1bjh6ZmhRMVhpZmZUL2psV1hUUUtXT2JaSS9NZnpHUkRGN0hG?=
 =?utf-8?B?QXlpRC9QVndBU1NmdGg3M1ZzUjBXeTBwYmRkaVd4SjA5djBhNzNlR0llNzFH?=
 =?utf-8?B?aElpb0ViWG9iQWpKNWVYQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFR2N255M3J2SWN1cFIxeVdYNlFSK1FEZmgwbmplUjdheDJDYmhRdTRTYnF3?=
 =?utf-8?B?YTF2NmN0dW5Qd0JWQ1lCeUpybGZWenlVRUkrSDhmbkN6Um8xTDFHc1B3ZEg4?=
 =?utf-8?B?c0hpUlJzNlplOWNwOWFyYVJyY0JFT0ZSb2lGNzhiQ3RsY3YyODZzN2ZBd2Rp?=
 =?utf-8?B?ekhaRFdkejZjYTc0OHV6YzJyenpWNFNEVkFKMFE4TGZWRmdmenZxbVhQclMz?=
 =?utf-8?B?WkZwVmNXRGVTNDhKeWF2OFNPQ3lMNmhyYjNVQ3BJM1Vlbm5YMzgwUWxVZnFs?=
 =?utf-8?B?WVhSemEyR09ncjNQZlBDdHYwRStjMFUwVTI1SXRVaTA5Ty8yNGRSVGt0WmZk?=
 =?utf-8?B?UGczOTJYUVJMbUxjT2dYWkl3b2R5Q052Z0JVaHFTcXRpaFZXbDc5VDI2YzU2?=
 =?utf-8?B?OFRRQlZQMVlPOHVCdzh1TjBDd3ZaMlZzV1BDWERoc25DNE1uQ2lEZThjdStk?=
 =?utf-8?B?KzlwMi9wM3hqOU9CMDJqSDZ6ajJocURiRXNCTkFiQ2ZGSW5qUTJlc3F5ZHJ3?=
 =?utf-8?B?TjdNUUJzWGxzSlRKN0ZOdFlnYUNEMFZPRnZDWDRrbmlGbDYwUmZCd1lnNFJB?=
 =?utf-8?B?MHFsNk9hc2FBR3dZdXNoUlgzUW4zOWhWYXV0V0pLTDJ0QStvODI4c3E1WVQ5?=
 =?utf-8?B?R2s4M1ZOMWpVOU5TN0xHYlZBYVlyR2tMVmZ5VXR6WFdnYlJaQkp6eWV4QnVS?=
 =?utf-8?B?dFQ5aDJhcGZhRTN3QW9lZXA2cWlQRzJzSTZDcmd3b3dYU21yYU80cGxhUlVv?=
 =?utf-8?B?QllnM2pSNThkUVNFTXhxNVpEcllhT3ZncFBnRWpXejJtd0pJNjZkL0dUSC9B?=
 =?utf-8?B?TUsrdnlGQlhObVNncDFMN2JmZHZhdFBPd1lLc29SdHRiWFM0WnJxbU1xVHM3?=
 =?utf-8?B?NkxsQlB5YVpRQmhXa1B5WGVMUlQybDd6TFIrY3BwOGhZUnNpVzVqNlEzK2Z1?=
 =?utf-8?B?ZjVERzRKZzE1LzhoQ0ZSRmdoZ2wvMGt5QUlSK0R0WWo0R2hFUUlhK29MQWxw?=
 =?utf-8?B?ZHN5NEx5Ykt6d0lpWTllSU5JOFBsS0xBL0RBT01KaDlrekUwU1RwTXpFOUFn?=
 =?utf-8?B?VGt0WnpMRkVEVkJIK3NpS1RGMlpEZXcxN0JVbDJ2RURNdGIwR2REWmFrbDRu?=
 =?utf-8?B?WFBUc01tTVNJbXBLaENDLzV4cjRyc0RwMGcrQ3NTdStXMzYyVTBVNWkyUU1p?=
 =?utf-8?B?RTRtZWkzQzAwMUswNXpaK2prSy84Nm53ZzhSQkpBdUI0amwzMGZjRE80YTB5?=
 =?utf-8?B?ckhuQm1ZVjh6NnBGam1KMFpja29WRkZpU0dzT2NrNWNydHl1L0U2KzFBZXhJ?=
 =?utf-8?B?TllhMDMxNmw2ZmRuNkVjZkdBWG02cUJlKzFWYzVhQ0R2K0FYV3dJUTQzNkpm?=
 =?utf-8?B?SlpYMGROU0JxYitJVEFVUnpsbU9nMGFjdjNqanpaZlUvZXZjSGxWSWxtV0M0?=
 =?utf-8?B?TVBCemxHM3VnZHVaSnFXZzhUR2xWVU1YUmkvMUdscWZKSVhtK21NdmYzb2h4?=
 =?utf-8?B?SHd6SjhxS1NPOXFkUEx4dG5jLzRxTGVGVEExR0dhck5qbllqVU9VVmI3ZDMr?=
 =?utf-8?B?Z2VFZDVtUk14SFI3T243eUZJRGFOK05uaTJEYUNZclJoVFVGaVZlK2M4SmFW?=
 =?utf-8?B?SWdMNUJCNm9XcEsxVmZwR0RzaHYzU3dGa2U1bUUxdElDTUZ6ZExnV1ZlYWw5?=
 =?utf-8?B?TDkxN0FFTTFmR1ZhRXZ2bzJ2NENURFVsUGxoWm9HRXMwL1l3VmY4dlhrRFpR?=
 =?utf-8?B?d0FVUHcxTHk3cDI4cXJERFk5Sm1zMVluNDcwZFY1UFdGR0RocDRjU0k2REt5?=
 =?utf-8?B?b2I2enc3Z0JjZUpxQ2ZUYTUxajBYa1NBblV0SXZmM0gyQmt0cERrWlhzNTR4?=
 =?utf-8?B?MmxRTUxCaVU1VHlydFBOdFNFcklSUno5RGtGM25RQVliSmtUY1ZwelBmbldk?=
 =?utf-8?B?cVJXL21paVErL2xXZ2dRZ2pPYU5RNXBKUWk4OWpEVmVuUHhUR3F5NlVRS0lh?=
 =?utf-8?B?NEJHL0N3blYybVVJd3UvNUJlak5NdUp6Ni80d05tL3gxVzFTdGhwTkdBaytH?=
 =?utf-8?B?a3d4cEVCUi8yY0tuVExtODFUdHlFNUU1R2JjSTM0ZE84MXRlakxIVUpDQWFq?=
 =?utf-8?Q?twVP4Kdo+ugKAmn396wowWlFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307168fd-16ac-4770-f402-08dc958e14ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:14:25.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slHtF1sgbZd/rSyNZTJuiwptb8UgXHmA24V523VYhRdoP5MtSpn4hFqVmCqrf3L6EVK+7mRdcyP1g0Ozx0UQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

On 6/25/2024 22:11, Viresh Kumar wrote:
> On 25-06-24, 07:31, Mario Limonciello wrote:
>> The core issue is that there are drivers that have boost functionality but
>> don't have a frequency table.  As pointed out by Gautham there are also
>> drivers that have a frequency table but don't advertise boost pstates
>> (CPUFREQ_BOOST_FREQ isn't set on any frequency).
>>
>> So what happens is the driver may have choosen a policy to have boost
>> enabled but when cpufreq_online() is called it gets "marked" disabled from
>> this check introduced in f37a4d6b4a2c even though it's previously enabled.
> 
> And who was setting policy->boost_enabled to true before that ? Also
> how will your patch fix the problem ? I don't see any other code
> setting it too, unless request comes from sysfs, which would work even
> now I think.
> 

The earlier patches in this series do that with amd-pstate.  Gautham had 
suggested a change to acpi-cpufreq for the same too.

However I tested Gautham's suggestion (which is in this thread) and I 
think it's the better way to do it than what I did in this v14 patch.


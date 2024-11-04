Return-Path: <linux-pm+bounces-16998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68029BBD5D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB04282617
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8C1C4A2F;
	Mon,  4 Nov 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hb9sr08Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511931CF8B
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745458; cv=fail; b=B8vDwzxSiPABbFPxc4DG3+vszGcPCTlEil3sonxWhE95IInUs1yqze/+hBWIirYF4OlWTtscLCxbscKmR9fpmq1G15DIfI2P6+r2u7RR1YRXkI5FUcvQJZVwmN8NCSZUpAgid33NzsUtSVCiRwNxn/RMUUYMYfaWIrry0OyUBFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745458; c=relaxed/simple;
	bh=cRwLgjb0J5GX6mo/Fbq3qcs/b9FiqIe+X4I8OluQqHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pspDUW+4g92k+oEbJQn86RLi6WoNG50hB02Dct8Sb6InPSKfIzJ20PL91DCa5J8T5+46s+zxyEicVDHVQt4V56PCT5NgI7jvERzGAY4A+76+hkuSD1y0TCMep2QtEfkzgu7db7PWfnig1hx1eBJ5JhYOnYliv6o68mrBoD+4smA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hb9sr08Y; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpUj+ZSMBt6LMcgynKocF8N6JnMitlddzmV6pkQdDxY1Y5ZLBcvSoe2dLBRCKQ5idqOwlOPMCLaxxakk01keCAI788+bULMXQnav/2ycvgkHe2LyCrsEr226FbJW3aBIIJ2e1nPiD4a1gP3dvq66UnJ22wzURGuEVX7oOqzKDBsSyQNX0OiRTB9i1yM5N8l+jExnu381D8uIKX0T1djlwtgG9g+RhSkPCqGwNeGKnkfOQKt/Eomk7VNBLAm63iCkRWLWzo3wb8YzQHtvCwGnkb/GLolXUWfimj/8Ossdj92opARiqWP/J3b/zYXnUK5gPAEfuduKETge0DjCBVZPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGciJT/CzuiYLz8RI26a5WdFMWyIITMNzlUmSXbFjbg=;
 b=GgKOGZCBeGgDiVro/nOABMQKycmFwPF1T/ifRSYEiolf8KwpYwr96fFC7iJ2WTZFwyQa0D+dhcg53Mduzc5tBpTe2N7WDSB6n8k8OkN2DMCQUclH2NmUkuzw/BjOLcCSgwZOOqZ5qjmEU9JMv79c9z4j92PJna4lh/tgFIHPxT/1EM5q5PJSvOpujLMNXTQReUunleFIg5M1csT9qaLKXgbLxzK7hEhom52jSanDbdnGYYGbAtiHXb28SztYi4cnbWSeqNcXaSbGgCkv1Ey9+1swtrYwhkF9zgC51YMV72WXUPV6gRxPrfJ9CTvAd8SIajIOqwCWJypV/evTGeTQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGciJT/CzuiYLz8RI26a5WdFMWyIITMNzlUmSXbFjbg=;
 b=Hb9sr08Yk2VF9d18hK5pFMHSXmq0mEmiKgw09005Rk5xKSgHMXxwoF3J4I3g74cQrrCmACBmECT8rebS5HTeWmNilOw/wJMvBdoLlbItWT6SUrjXoHoI2bimfhU6IrM7WfXMrontphsExml6dvESA6GqjiT1NhAwZuxYPHyMRh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 18:37:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 18:37:32 +0000
Message-ID: <3816d092-2799-4056-9815-421a614c9228@amd.com>
Date: Mon, 4 Nov 2024 12:37:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 24
 warnings (v6.12-rc6-98-g57d5fb99dade)
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "kernelci.org bot" <bot@kernelci.org>
Cc: linux-pm@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
References: <67290cbd.630a0220.3b06d1.05d1@mx.google.com>
 <CAJZ5v0j0+2iWE1Xu7egnymi8Njuav+miMOdeKkxHF5TPvYm+Wg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0j0+2iWE1Xu7egnymi8Njuav+miMOdeKkxHF5TPvYm+Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6e014d-f017-4ccb-f903-08dcfcffbe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1hiRG9kdVlnejh2T3p0eVo2U1FSN0h4QWNlWmNkWDJnaS8vTVFybFRFdFNJ?=
 =?utf-8?B?azYyTWJHMHArM3NyWGJGa3BwNmI0OEhnZTJWSTlXOXRrVUt2eGRIc1RRYVlC?=
 =?utf-8?B?UWVkdFk5T0djU0FMMlpjUWZKNmtZWHJZQ0dRdmo0bmIwNWxMYk5PMmdPRWVB?=
 =?utf-8?B?WGhPeXhoWU9JbW5pM2sxMmttcnhWbTZFbm5PaWQrWmptclM4bXRkcUZOc2d5?=
 =?utf-8?B?N2Q4eDVUd1Ftc0Q4SGRLbkR2cFVhaEhsNjJIdDNYQ1BvQVRNd2piclJEUnpU?=
 =?utf-8?B?aTVaSllFQTlkV3B5U1BnckFUdHhLTFU4VU9SckVXNjRIVlR5OE0xY1BkTWpj?=
 =?utf-8?B?ZlNXSlpvT2FuMjlyNmFUODNaTzBTY2hYYnBkVlFncEhlZmhGaHd4SUl2QVB1?=
 =?utf-8?B?YWhLeFNDTVh0THE3NUd6UldQa28zR3Ruc2ZZRkdURUIraEZWSm1RQlFyOGhD?=
 =?utf-8?B?RFZHNjdicHZWWXJCMUd4VDRsaTRYZmpwT0d6d2o0SnhHdE1yMkJpVHZwbnNi?=
 =?utf-8?B?YkNhcFRqdmJYc0E2WXd5dU5JRU9sVWJVYkxlWVVFYkx2NVRHVlFaeXc4d2xj?=
 =?utf-8?B?emRwdmNBQ2FHYll0cG9KV0ZBcTY4UC9YQkxPeVc3VlNRUEYvQ0lXbUlwc0Q4?=
 =?utf-8?B?WkQ3RHJRYjNHbE1UUzhyQ0NjNzFXV2xPYjZaSEpLWmtmalJLQVRwQ2JwQStT?=
 =?utf-8?B?djNqVWRUOUEwNjNVcWVqcDJqT0xlb0xzRjFxNm1hVDRRMlUyOG1SNWlZUjF0?=
 =?utf-8?B?Q21TSndaUDFEaUUveHg5S25xYitmQ1YrOUl1UEZoQ3pGNXR0aThOTEF1RmJO?=
 =?utf-8?B?YnZYOHIrd2hzQ2MzQ011Ty9TbVFVdUg1U2pNQ3NnNmsxNlU5WXRZN1E2cEZY?=
 =?utf-8?B?WEE2NEpBeTNteFozL1liV0NqeGI0eUE5TGRtVlByMERVTDVLbHJRaHN2VXI1?=
 =?utf-8?B?cXpCVGNTMXNQSExJVWZiek90cE1xOWUra3VkM1VycmdDY3pJcURaWkRMeDB3?=
 =?utf-8?B?aDJTVnZ2ZkdTZkpEK0oxUFRyZ3BqN0pZajNXb0thNUg3dGo0SVhrOS9WSjJW?=
 =?utf-8?B?b0pCMjd1SWdkTkIwYWs3QllWbG9yM2JJMDJudmNNc0N6VnNkYWtpLzFiTko3?=
 =?utf-8?B?L0FNT0p2dTZzNExXWEs3ZnVKV0xEOUpMb2NDZUwyb3Zxd0UwNjVHZmY0MDBa?=
 =?utf-8?B?SkM5Z2FoQU5QNnhkNDM4OU5hL2d3M1JkZGtvR0oveVE3WmJENnR2c1BPZXdG?=
 =?utf-8?B?eTRiS3ZVZmNBTnFSNUpwRE0yNmk3NE1JR2tLRk9iUS9Ra2FleWVtWEs2bVcw?=
 =?utf-8?B?QkNlQ2Z4TjE3VUY0dmsxVGcyQTNZSWNrSkxBVkJOMWR6b3lFOEQ4TitlZmlY?=
 =?utf-8?B?R0QzVysrRkYxUWNQVjc3OWNqdU82MWFVMEcwSGxLNUNpVlgraHlUYmliS2RR?=
 =?utf-8?B?cE1wZU5pY28vUHB5WUFCYkhUbEU0K1JlQ2tDVlVWVFRQelh3OUdhMk9hbGNI?=
 =?utf-8?B?TkpSZUxNbk8rNENVZ0JxNS8zWDFJWkFGQXlEbTM1Ni9iVGNMRUo3bTJIK0My?=
 =?utf-8?B?RTMwVUJrNFlEU1Bvd2I4NE1VRjQyYlAzdDlXSTVCOVFIejJNdWVrK2ZNcXd6?=
 =?utf-8?B?eXNMTEg5Sk5pdDVxZEk5WSszWTREdkhkWWNVYjQ2eFAxQ1Q2elFBdU9YeWM4?=
 =?utf-8?Q?U3NChQHyaziAhlHa5gzU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNxQVVhcGhBdTNtZ0NGUzJzb3lMVXpNbzVZWVgrSUFmNEg1cW1RelNqVjN4?=
 =?utf-8?B?TGxrbXVSOURDRTRudUt5elB1UG1yTWlqdDhEUTl5dnpMRVkyVmxrRzhMMmh0?=
 =?utf-8?B?M2NlMzBEZVZXd2NTYXZMWlZrVGJiUUh5M2VIa01hV08yOFVhWmRleFB0WHMw?=
 =?utf-8?B?RHExMDVJM2hzdHlQUEVHS0hMVjRtYk4yZ3RJeStBMEdKR0ljNThBYnVPRUll?=
 =?utf-8?B?UkltZUp1b1VIcDdLMERncE0rUWJLRkdzaGRrTGMzSUVlaWl3b1NucTBaRHBw?=
 =?utf-8?B?R1hYUDZYVDFwZGpRU05reG5mRlpzdFQyUVREenVoZzFqaXNSSjIvQTc2SUsx?=
 =?utf-8?B?UFBoVDY2dkswbVV3RCtyY3Z0aUlHejE3Rm91TkhnWTMyWU5YRDN6WHdCNlRL?=
 =?utf-8?B?eU1lNXI3dk8yZ2lka1ErNVY5TkpTby9EUjlyNFBDMDd1R0Ntdkd6cEs1TENK?=
 =?utf-8?B?M2lKdDh6ejFkcXBsWWNwcFJHMkNSckhBY2RSeDh6aFB3QUsybVFzanNkRjZH?=
 =?utf-8?B?RFRWVktNb1M2SkYzTWVoaHZ1dHc5dGhhSzI5QVQ0cUk3MmNmSi81bFcxRExz?=
 =?utf-8?B?TS9QaG53RlNNdVJBaDl5alRnTzR4eVR3bzdmYW92dkd3dThzb3ZYV3lOOGNk?=
 =?utf-8?B?Y3VGU3B1Y3NvUlhNOGd1TzhIdnpvSE5tV0wyQVdWL3lFbDB6c1dSc3hxQ1N2?=
 =?utf-8?B?TFRvTkhJNlFaTTBSUlpVZFhwSmt2RjNUeTZNbFBEK1Z4dnJoY2hkUVV2SSs1?=
 =?utf-8?B?VUhqR1kwNFppVHcybHpsSDlOSllhdmEvSDhDTFRrc0F6WExPOVEyTEVhcmZK?=
 =?utf-8?B?SVpIMlZmejcyMjcvQm1QVW9pUUFJdjU2Ujd0U0lVa0JuaW5QRVZRMmxaa3hT?=
 =?utf-8?B?ZWFObmtWNUpraWI4Rm80WHAyUlJXSG8zMDZEd2JKVUN5a0dNSWkrQnBHQ3Ay?=
 =?utf-8?B?NnJBbStOUTBLUEp4SVp2RGJOTXRUbnIzMjVBWC9KMXBoaG9WcXJJL05HMTNv?=
 =?utf-8?B?OEdadEhVNHJqdTRJV3d2VnduT0VyS25tRDRYWmRwcXo3RE5IYUcxZDJ3Qndv?=
 =?utf-8?B?TVo0MXM4N25HS0lDdzVyS2NZQWZCMUora0ZzSHBxQmNja1NENHpXSnordkRL?=
 =?utf-8?B?aVRYMDkyUVZyb1ZWTWFFVlYzZlBaS1VzZmFqQTNmNW95dzhXakgvWExPTm0z?=
 =?utf-8?B?R1JDSTd2Ukt5TzNXY2tKY1NJVkhrbThiZDN6dzhmRng2MlNjQ1NFeGtFd1kx?=
 =?utf-8?B?NlNyQ1pka1VqcVo0V205b1lwdCtwMVJTakJhM0hOblR5cUtUM1lnTmlhYUI1?=
 =?utf-8?B?Zmh3V2Qvc1crcEpyWnJZcVVqQnhmWWVsTkkxY1pEbUFKbjlFRFJDZEZsdGV3?=
 =?utf-8?B?OCtMc3pPYktMbDFCaGVGSFZScHdWdENucVVHbTNOcnhJeFJLenpzOU4vRG8v?=
 =?utf-8?B?NkdsRDF5ZXNhNjc5WWlFM1ZhKzlxZXByVmx5WG92RFNLZU9QMTlsc3VhRnhI?=
 =?utf-8?B?NURacFdXNUs5RDFCalltcFhFOGxHYVJsTWxjcXY5cVBycXhoR3B1cVlSSTln?=
 =?utf-8?B?cjl0dVM2S1hoWkhXc3lrekVGcFdQM2p1MUttQVV5UFhqOVZSZG5xcndLUG9q?=
 =?utf-8?B?ZFh3aWgxRUdJSVFwVENwRkd3cndvVVdKWW9GSW82eGNBbGZJeGtVR2xSZUNL?=
 =?utf-8?B?M1R0a2RyRXpLOWdvV1NCcGJwYzNmbE1WeDlnSURCcG9NY0l5VEVEbTdkalM4?=
 =?utf-8?B?NHRaL0FRWnZXWEtraUprY1REMkF6S1MrT0JyK0gyVGhVQU5EQ1ZMMEpsU2J1?=
 =?utf-8?B?MjZocG1MemRuUnlDZ1Y2ODM3ZXR4WFdGMVdlZkEwWUN4RUh6NExGZWo5ZDd1?=
 =?utf-8?B?bXliOVl6OVVwUWY5VHRWR0dReklpMGQzRVRkeFVyL3l5QkFyQXFLT3VhaEtP?=
 =?utf-8?B?VGJJME53VU1kTlZsNjYyMkJJWndQSEdhTXVYVkUwM1NqbkhTdUFFR0lTSXFs?=
 =?utf-8?B?azNrNS8vdjUyWFF2OHJoeGlkUmRpTGI4Q0FrK3VxYmJ3bTZ6SjB0d2JPRHF5?=
 =?utf-8?B?YjJjSVppai93N29sdFhvZE00VGtrRE1ZUDd1V01qZUdKMlE2NllxQVBHVnFN?=
 =?utf-8?Q?r6l6ECUXp/ucDa4yORjjA0/UB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6e014d-f017-4ccb-f903-08dcfcffbe9d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 18:37:32.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY0LaYaNmsj4rXIf2N5mDzfdyn60jiaA4YMFfZy4cH9+DSm4LH2Eh99B2Il5n0fIdvckeASaJ6IG4aKjA1EFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

On 11/4/2024 12:35, Rafael J. Wysocki wrote:
> On Mon, Nov 4, 2024 at 7:04 PM kernelci.org bot <bot@kernelci.org> wrote:
>>
>> pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 24 warnings (v6.12-rc6-98-g57d5fb99dade)
>>
>> Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.12-rc6-98-g57d5fb99dade/
>>
>> Tree: pm
>> Branch: testing
>> Git Describe: v6.12-rc6-98-g57d5fb99dade
>> Git Commit: 57d5fb99dadef3680372de9e1d3972dffb1ec800
>> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>> Built: 8 unique architectures
>>
>> Build Failure Detected:
>>
>> riscv:
>>      defconfig: (gcc-12) FAIL
>>
>> Errors and Warnings Detected:
>>
>> arc:
>>      haps_hs_smp_defconfig (gcc-12): 2 warnings
>>
>> arm64:
>>
>> arm:
>>
>> i386:
>>
>> mips:
>>      32r2el_defconfig (gcc-12): 3 warnings
>>
>> riscv:
>>      defconfig (gcc-12): 1 error, 1 warning
>>
>> sparc:
>>      sparc64_defconfig (gcc-12): 18 warnings
>>
>> x86_64:
>>
>> Errors summary:
>>
>>      1    drivers/acpi/processor_driver.c:273:9: error: implicit declaration of function ‘arch_init_invariance_cppc’ [-Werror=implicit-function-declaration]
> 
> Mario, I think that this is for you to take care of.
> 
> I'll drop the CPPC invariance init from linux-next now and please
> submit a v3 with this fixed (and the comment we've discussed
> elsewhere).

Ack.  Will take care of it, thanks.

> 
>> Warnings summary:
>>
>>      2    kernel/fork.c:3077:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
>>      2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
>>      2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>      2    3077 | #warning clone3() entry point is missing, please fix
>>      1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: missing .note.GNU-stack section implies executable stack
>>      1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
>>      1    cc1: some warnings being treated as errors
>>      1    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous prototype for ‘__vdso_gettimeofday_stick’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previous prototype for ‘__vdso_clock_gettime_stick’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype for ‘__vdso_gettimeofday_stick’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype for ‘__vdso_clock_gettime_stick’ [-Wmissing-prototypes]
>>      1    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
>>      1    arch/mips/boot/dts/img/boston.dts:136.23-177.6: Warning (interrupt_provider): /pci@14000000/pci2_root@0,0/eg20t_bridge@1,0,0: '#interrupt-cells' found, but node is not an interrupt provider
>>      1    arch/mips/boot/dts/img/boston.dts:128.17-178.5: Warning (interrupt_provider): /pci@14000000/pci2_root@0,0: '#interrupt-cells' found, but node is not an interrupt provider
>>      1    arch/mips/boot/dts/img/boston.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
>>      1    arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt_provider): /fpga/pct: '#interrupt-cells' found, but node is not an interrupt provider
>>      1    arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
>>
>> ================================================================================
>>
>> Detailed per-defconfig build reports:
>>
>> --------------------------------------------------------------------------------
>> 32r2el_defconfig (mips, gcc-12) — PASS, 0 errors, 3 warnings, 0 section mismatches
>>
>> Warnings:
>>      arch/mips/boot/dts/img/boston.dts:128.17-178.5: Warning (interrupt_provider): /pci@14000000/pci2_root@0,0: '#interrupt-cells' found, but node is not an interrupt provider
>>      arch/mips/boot/dts/img/boston.dts:136.23-177.6: Warning (interrupt_provider): /pci@14000000/pci2_root@0,0/eg20t_bridge@1,0,0: '#interrupt-cells' found, but node is not an interrupt provider
>>      arch/mips/boot/dts/img/boston.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
>>
>> --------------------------------------------------------------------------------
>> defconfig (riscv, gcc-12) — FAIL, 1 error, 1 warning, 0 section mismatches
>>
>> Errors:
>>      drivers/acpi/processor_driver.c:273:9: error: implicit declaration of function ‘arch_init_invariance_cppc’ [-Werror=implicit-function-declaration]
>>
>> Warnings:
>>      cc1: some warnings being treated as errors
>>
>> --------------------------------------------------------------------------------
>> defconfig (arm64, gcc-12) — PASS, 0 errors, 0 warnings, 0 section mismatches
>>
>> --------------------------------------------------------------------------------
>> haps_hs_smp_defconfig (arc, gcc-12) — PASS, 0 errors, 2 warnings, 0 section mismatches
>>
>> Warnings:
>>      arch/arc/boot/dts/haps_hs_idu.dts:68.16-72.5: Warning (interrupt_provider): /fpga/pct: '#interrupt-cells' found, but node is not an interrupt provider
>>      arch/arc/boot/dts/haps_hs_idu.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
>>
>> --------------------------------------------------------------------------------
>> i386_defconfig (i386, gcc-12) — PASS, 0 errors, 0 warnings, 0 section mismatches
>>
>> --------------------------------------------------------------------------------
>> multi_v7_defconfig (arm, gcc-12) — PASS, 0 errors, 0 warnings, 0 section mismatches
>>
>> --------------------------------------------------------------------------------
>> sparc64_defconfig (sparc, gcc-12) — PASS, 0 errors, 18 warnings, 0 section mismatches
>>
>> Warnings:
>>      <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>      arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype for ‘__vdso_clock_gettime_stick’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype for ‘__vdso_gettimeofday_stick’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previous prototype for ‘__vdso_clock_gettime_stick’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
>>      arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous prototype for ‘__vdso_gettimeofday_stick’ [-Wmissing-prototypes]
>>      sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
>>      sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: missing .note.GNU-stack section implies executable stack
>>      kernel/fork.c:3077:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
>>      3077 | #warning clone3() entry point is missing, please fix
>>      kernel/fork.c:3077:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
>>      3077 | #warning clone3() entry point is missing, please fix
>>      WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
>>      <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>      WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
>>
>> --------------------------------------------------------------------------------
>> x86_64_defconfig (x86_64, gcc-12) — PASS, 0 errors, 0 warnings, 0 section mismatches
>>
>> ---
>> For more info write to <info@kernelci.org>



Return-Path: <linux-pm+bounces-9505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8490DC53
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6EB20A83
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14013161339;
	Tue, 18 Jun 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TB6e2S5U"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4B15747F;
	Tue, 18 Jun 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738705; cv=fail; b=HT+sbbY1oLiVrKJER4/VWYAk4+AfMczUf4OYRGxtz8Eua5pbHT5xXMBp2kf5vIn0h851j03RXSEDTZh+sqzsJjPD7dFQ66IjHzkCd1NiYndgivh9X0WmZlqYPNvnVY4bvhFIxgQ5rgBVikaLUzG5CpcrSjMDkNN7ZLJO9y24jFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738705; c=relaxed/simple;
	bh=3WUsFbhEhTf31+IslAy8mfuThJzNFv2lZrJTf2w16sM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZXSTSrNUES376lCJzqpMwBWLlybCsmD7RTNE8offuXtMqn/hQn702TcnhtaS0YzlIRSEQdYNLemf6iMtXWR5ODvJcilCOUr2ii6g7hLrYHFunHPQXhZzH1DeeFlD4PQUidL0AB/UmERyAg9MVS5DGBxelaF+UXNK0suCNHt9RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TB6e2S5U; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngcP24yUYxYgn21jmY5y/QeTDVrfTajvgs7MN2+muJo23eOEJC2SFEMCtBRjSTsEF87ti5kYlRQQq+iNmXn8IizFLTOKiVqXbjO2ucyUSrWHU/z52PvOUdsB0pGvO08m6r0O2TrjoaPMDmJI+iEle1NcGPGxJAArUQVOXenNCl4dMRVYAu1DFpZRSPennTjLco9FmIf25sOGlKWT1yLhPA0bwHaAo6qzdpSIU3th6/zIXhNEPQOc1tdpVIxxQYmqivFdmBg9fyIT5lAJU7B9xL4+FYWF+pXRC0yAiSUaq2jd71ApI+gH21/GLz2XluKUKBpJlaHe/AgJt4ZB9WfF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tViHSLbXS5bc5OBr6VDFyqg/P3V2NXgL9CXywFnp9sA=;
 b=RxJVp1oqFPHJYt5gblFpsRKx7IAtuaa4WV5ldxDSY+WUvOfxds2A4SVA4p5WNIcUh9r051Mahfhp4rBTW59KqXd3/d9YilwoCUb0gfyHAA+zdvXgfdHYdwwpnmoR/M0U+SUZ7LQ8sn8E3mC4Avmu0sGX93s2uhy+6HFTSZsMHW4c47HbAI29zHFjLVbg3dx9JWNIMOuIrVO7HimiVswX3WU7QqT+5xIJ1gHioPcJnraMJxPlf9qaURM00QVZAipjXnz0BDS9Gznka1B492yJKYjApBHb/44WScU/DQCTj3WCAFWGCpVzicoeV2Kzm2g3j1djVYpl9tUrEYLwEVmF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tViHSLbXS5bc5OBr6VDFyqg/P3V2NXgL9CXywFnp9sA=;
 b=TB6e2S5U3CT2LuME5zZGQ18Z7jQdSJ9cLBitmzkltWNGwX71p9E1bNSjpCVc3qkjC7mqXDZZui7AvN6xekOp68DhxIMU/p9/+3rHNFwy3R9QLWmnryHgRe1kPPRa20YM7Prd/oPCwxb0ke1OaZio68RpXThCDHc89Fe6kVWkLzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 19:25:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:25:01 +0000
Message-ID: <f92a3e84-e401-4287-b618-252011fa175e@amd.com>
Date: Tue, 18 Jun 2024 14:24:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] Documentation: PM: amd-pstate: add debugging
 section for driver loading failure
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718606975.git.perry.yuan@amd.com>
 <ce88d442ba6398853ac63351107e0028ef659660.1718606975.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ce88d442ba6398853ac63351107e0028ef659660.1718606975.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: ce26b3d9-59ad-4ee2-8e51-08dc8fcc58fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFk1ZitScFVyMmx6b2VQN2p0Ym9UMkhvQXNpUTVXUkg5Tlg4OFluSWhOZnIw?=
 =?utf-8?B?azhFNmx3RlR3UnBDMHA4SXBJc0tRd0IyQkhaM0VNYkxTTFdRa1NFUjJWMVNF?=
 =?utf-8?B?WVp0alFRbUd4THhYNGg2TUp3TGEvbkx5cUJTdlhQcysvc0FZWW9IUU5YVjkz?=
 =?utf-8?B?UjJWdDgxck95em54ZDEzOUFIcUR5YzE5bmlpTTVRS0xHVWFXMW13MVNSTVZw?=
 =?utf-8?B?WXZQTlY0MjN6Yjd2NUhpYXJQelNmRklybkNZVTAvZXUvR29qMGl2TUM0cWpq?=
 =?utf-8?B?MkdvSDIrN2ZUSG1IdWFaOHJSU3JBejFoaGt2Tkl0UmRQM2ZpOHVkQUR3Mm82?=
 =?utf-8?B?VG1qV0VOWUJtQ3RXc3VncTErL1AwWkFURjRmd1FOL1Yvdm5RYjQzUTdDYitp?=
 =?utf-8?B?RzVWTUpuMjdWeEVUMDBSdm9iY1JSRjByWnlTd1p1R3NJSlc5MkZ2MzJUSkxQ?=
 =?utf-8?B?ckVVSk5ZbGIwQXRMTzJVS0VHRVA2ZCt2ckpTVGgzeUtjM2RVbjdqZ0djUjhy?=
 =?utf-8?B?ZUc2M3RHWGw4Z1J6L2hqLzRWeVZEN3ZaUnpzRFJkK1Y2Z2RFcSsrQWRieWhV?=
 =?utf-8?B?SUROTXVxRFBmMU82RDRIa2wwSGdKVnhKYVo1MFdlY3o2WjNWZi9iTDAvZTBO?=
 =?utf-8?B?eEZURE5UaGYvZEJRc1NTNXlkWmR1TWVEUXZFS1QxSXJ5aHphWEduVmZWLzR0?=
 =?utf-8?B?WU0yNGd4VHc0bUZlRkoxQTlidE1ZZUI0aW5USjA0Rm8vVVRqd2pHMlJDeSt2?=
 =?utf-8?B?NXJwZHRUY2FDL3h2LzVkZnRxeit1aVpOMWFFdFlKdXRzeStqQ2JQMG8wcFNY?=
 =?utf-8?B?UzZibXVpYndiYkVWT05KbFpGOWNuVTZjQWlnRm56VFplSjBVbHN2Rjk1OExE?=
 =?utf-8?B?Nm9MUU9qQkVZYWh0d0trakYvdjdXWnZYR3VCaVZERTVYcDVBd09tcmVzOFlj?=
 =?utf-8?B?ZnpOMkgzOUt5MDZkVXBUVFp3WGFvOXJOY1pEYll1VDlpRGRMWTAvcUlvaGZX?=
 =?utf-8?B?M1FDSFNwSWNvVVNIOVNUenBOTituYk1jNzVReUpTM1dYeWc3WFU1Wk5YYWFW?=
 =?utf-8?B?ZnA1Mjh3OU02M004bFRHaE80dXp1cHNPdlpvQUxRc0FIcWZMTFNtOVJ0L0x3?=
 =?utf-8?B?eWt3Z001QnErQTFCWVQyNEh6dlVzZUdhTjJZRzlET2Y3VEExYWxRS3prSFRX?=
 =?utf-8?B?cmIzci8rVzRNeUlEMVoxNE1ZNkxGRWVOWXd3R1JIb1lPdE9HcDBoTFZ2alpo?=
 =?utf-8?B?QzhXMi9ubmNKWkhwekxrUVFHMHZPcloxZU9xMis2ajlCZXA3cnp6ZGxlcmkw?=
 =?utf-8?B?S0hER1RpSk9qYVFPUGcwQngwUkV4N1EvRC9GSTZNbGNFeG1GaEVFVTIyNWcr?=
 =?utf-8?B?SitvR0lEN1J1T0ZTTVZrTGNoTi9FRG5paTRTVXppelZXamRvam9YQStpTDFC?=
 =?utf-8?B?Q2dBMHA2QWd0T1pGSWZRMWl3c0JvcGVMTkxoTVRVUWtlVHdzVG00ajRzbDg0?=
 =?utf-8?B?SGlrVjhPaTNiSUcxUmRZa1QrRkR3T0M2aTBvbUdzSzRLbFlDMHF0TFJwbFdw?=
 =?utf-8?B?cmRxQkU4dmpPWXFYd3FaUWdhYitwVXIzVjREOGJYTUFsc2JMRThodU5lNlRN?=
 =?utf-8?B?cGZ6cy9TUEloRktIelI1ZUdnaHE0WjlJMWpldGE2R2hNQUs3Y0IvQ1VYWTZ4?=
 =?utf-8?B?UTUzdGxSQUlDOCs1ZTA1M0gvcjFHNDZ3TG9Bb0tLd0gxZ2praFY1MStNVEZL?=
 =?utf-8?Q?OlBWRAu4vEQI3pb/Winvvu6MRTHWIovzRdi0Y8+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dit0VyttUjhKNnlNdlNXYTlUbnE0M3FRSU9FUURDaUR2TlBRSUtobzlDQVJZ?=
 =?utf-8?B?endvaGpaU09uenFERHhNSkwrVEtzTmxadE5mRnk1cFVibHQvOFdENXZyWUNM?=
 =?utf-8?B?SkZyY1RtS1ZuNm94K3BjWHJMeEM2OFd0WGtjTUZ5MzdBUEY2R1FrNGxjTmU3?=
 =?utf-8?B?VStWYXFqSlFNbUl4QzR3bWRpT0RwV0xDeE96KzdnQmtCNk44eFcvSUpiYWlP?=
 =?utf-8?B?aGR1ZEZUUzVFdWROd2I2SW40akFoZHBVUHhKNXpDcDF5UCtXalpKallPbXVN?=
 =?utf-8?B?ak9QUDdZSGNrLy9Za3d3bXlGWUlHR3hiZ0x3cm80NUIrd2I3USt0UW1DMEJ2?=
 =?utf-8?B?WmhMemR0eVBtbVcrNXBjZ05KRW1rOXRENkYydkowbk1PYzV0elJ5RFAzNkZG?=
 =?utf-8?B?N0ZnQWlGZXVyOG0zd1BIakZnSEJOc0FkTWd1dTRHTVQwd1FiOXpCS015amcw?=
 =?utf-8?B?VU14cCs2c2U1ZnNuV2c3V0NKa2tKNWhnL3JXMlRWZElvaW9EcVVINXRhdjRO?=
 =?utf-8?B?S2ViU25XSVFoaW80dVFkUGdZVllqSjZxZjdSVXJYK2pvdkg1VmpTQzV6VnJx?=
 =?utf-8?B?OTVXdFBwVitBZ2hNR3BWYThlRmJIenkyUFBkVDBLelU5Y1NnQ0Y5THJQQllH?=
 =?utf-8?B?OHp3NlJGS2hRanBuU3JPdlhxajJKMGwxK3BBMTRLb2ZLdmZtQmFUQkdvY1VB?=
 =?utf-8?B?eEF3OW8rT1lXUnhsMGhUZ0kzeWNpYWdiUkN4dTNuN20vdHdJTHNqZk9iWVcw?=
 =?utf-8?B?ODZwaDhPUGFWS3o5MW5qblA2NkcwR0hPTWh5NmFHdW0zM2ZPVWxtaGJzODBn?=
 =?utf-8?B?NllsYVI4N1dlYXZVVDJlSDYxOEhULzNscDVyRWZqQlRKOTlEYjE2TS9XWWpZ?=
 =?utf-8?B?bkVCQ0dOemZvTHBQcy9vM1JURkErOUdsbHFkSVJkTWNlSTdnbjJtMlFsK29E?=
 =?utf-8?B?ZlBRUDZGbDF4ZlQ5ak1PM2pzdlhYQklybTF0d2FCMVpaSXdLUXJiNnZVZXJN?=
 =?utf-8?B?RlZ3SGxWdnIzT01rTUlXNVFZS3A4djluNERmaG5mMEs3YkpNelZ0NkY5SlFu?=
 =?utf-8?B?VkR4akNmSldtdXEvYW96K0JhSlBzMmpHWHBqeWNjeUlkNUl6MnVuTVVWd0R1?=
 =?utf-8?B?Mk0vbnpIb2VkSU1QbWRqbzY5VXlCNmp2VGpKNXdHdllwL1luZWthbkJ0RWNu?=
 =?utf-8?B?ZE5YaEVVUDMwemJ0M2ZKcTFmNHRNMGltR0VyRVByeCtPZG9Xa1NSZUV5NE1Q?=
 =?utf-8?B?QWdTR1doNllTNkxXL3pyUmI2Z01ybklxRlBaNWlQaG9kMFRLbmlEZmtuK05r?=
 =?utf-8?B?SkhOZy9TVnZjeXVteU9HMWtnRTBkb0lKdzdRbU51UmZsVUxKT0FncjF3K3pv?=
 =?utf-8?B?Y2pVSkxCL0dtSndtclJlZWNGVSsyNk5IRjVKTHBTdFJQTXY2SVdjTGE0b1NH?=
 =?utf-8?B?STUrWWYwVGE5c1k5SitpK1p6Ukh1eGIwdC9KTEVFYVk4SkZHSXJsZGpmWjcz?=
 =?utf-8?B?SGpibSsrTGM2Nmp4bXRURVUremRXOGN0czBVZ1lvbkRnQlFFdkNXSHlBMjZQ?=
 =?utf-8?B?ZEFjZm92SXFhcmxuVzZHdnB5MmxDK3lUUUtXTkJmY2xpVlNRU09kR1R0bzdU?=
 =?utf-8?B?Ry9RVHFCRk4wUGVkYTlqblJjZ0VhbEpLM2RSNUorMkdVTjg5U0dNZE9COUY5?=
 =?utf-8?B?d1dsZ0tyWmxBQ0JUNU1mOXdrY2JDM0Y3SGRuak96bDEzNXNrY2ZWdTByVG10?=
 =?utf-8?B?Y2k3bDRieWxTdWVqT25RS01yNDBSUml5YUI0RUFGNVBLQzl3UXZhVTFOb2FK?=
 =?utf-8?B?bUh1ci8weTF5cDVjWk85Vzd1MWdOVmZSTEdwT0s5ckU3RExjd3RrOFBxdVI3?=
 =?utf-8?B?T3ZSelgzRnFza05lckIwQTB0SWhkb29OeWsrQkh5UnVIbk5WQUZla1dQK3R5?=
 =?utf-8?B?d2tMaThmZ1ROK3NtZE9YL29wRG9CZTV0d2VFMVRWZ01NQlpFYnQwejloZktI?=
 =?utf-8?B?b3VpaXQ0R0t3d2Vud3RSVjBIaWFBbCs1dHcwb3B3QWhwZE84RllFMk9uVElh?=
 =?utf-8?B?TlJ6Y1JXOVlQUFNOQ1NoTkJtL3duWDNuTnNCYklrckVMNHVsWE9ybXNiU3do?=
 =?utf-8?Q?46RjJtLtzudoKcmsyqmiHJgTW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce26b3d9-59ad-4ee2-8e51-08dc8fcc58fd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:25:01.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+5Ce+LKQ7E0ucN1loLcjvwrVIii+JwNzGVXPEfkGGmEl2Mb3WV43GhOKZoWZX/1wRb0etnf3lYqeAHAIhUBXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255

On 6/17/2024 01:59, Perry Yuan wrote:
> To address issues with the loading of the amd-pstate driver on certain platforms,
> It needs to enable dynamic debugging to capture debug messages during the driver
> loading process. By adding "amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  debug
> amd_pstate=active" and loglevel to the kernel command line, then driver debug
> logging is enabled.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1e0d101b020a..ceeb073c9ada 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -472,6 +472,20 @@ operations for the new ``amd-pstate`` module with this tool. ::
>   Diagnostics and Tuning
>   =======================
>   
> +Debugging AMD P-State Driver Loading Issues
> +------------------------------------------
> +
> +If the amd-pstate driver fails to load, additional debug information
> +may be necessary.
> +To capture debug messages for issue analysis, users can add below parameter,
> +"amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p debug"

What keys off "debug"?  I would expect that dynamic debugging for the 
first two is sufficient.

That being said; isn't everything important shown as a warning now with 
this series?

Is this patch still needed?

> +to the kernel command line. This will enable dynamic debugging and allow better
> +analysis and troubleshooting of the driver loading process.
> +
> +Please note that adding this parameter will only enable debug logging during the
> +driver loading phase and may affect system behavior. Use this option with caution
> +and only for debugging purposes.
> +
>   Trace Events
>   --------------
>   



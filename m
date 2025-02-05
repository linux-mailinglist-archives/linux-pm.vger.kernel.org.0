Return-Path: <linux-pm+bounces-21413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B8A297FC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EB816219B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41B1FC0ED;
	Wed,  5 Feb 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sMz1Psf3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B091F8908;
	Wed,  5 Feb 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777860; cv=fail; b=BXdFJrWnJ0idj94JLXoNQ6TJEIwqrzoXHfzMCRLLJOgqSZPoLHthUcLpHIYNlgQW60M6JqTvFTmzKm37tP6HRv3uAw4JjYXX3XNd9Ztmfv/lW8BEth40k6buTQ67n16LrhoCo4eP/GkmduBH8L4wbvYncXRD5ewKpEw5T4FKS9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777860; c=relaxed/simple;
	bh=DyivZHYNiWrwQzblyhJ+THCCZ+nEAMlbcniOmiPGS9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2TfOZXSTQcrJQr0Hu34NO3/vN9F9QprkexJF8NdGmekGGOa8ZEb0YVYQELhIkMjypvGSGhTHpSweZontrxkHMIvEUi0P3JDSPRn4F/x1WouKlTmFc5sO8PxF1fLyhMHjKYAdKexi7yUnhQ23rT0K1fVruP+QNHL8TWu/V4Lrec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sMz1Psf3; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLOJX7Tqe3F943ruo4kVKyfhUCfIyTcaN92XfTQCNe4R/fRwHsagb2KQkSAucEJ4aDnnO651OvLfOKbO/IG9NoVFY1+DOsM9trVfLSUV40qKatjJugrseUXm3nhOCRwc8AOTdbuz1Izx1Weybnqy9wUpyC0lCTNM/AlKPWpBjKMnE4MfRjMTk6lEDpRL+cpQfAO+7BlXF4WBGe+444jhBpQLXEiuMt/y6+RUazFt4vAz+Ydr2E0UWKcwtnSR3xmvto6pHHKraTSFwHLqf41SAtGQPJFweUd9eM3uFoVxon75/u4BWc35DMnoMqQRnt2FamTS8Z9gETwgFGa4O8J8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g3/Nc6EBSORZVgi1aiEjP9vsWtRL94FHBd0iZRnCBA=;
 b=Qk/Pz8xXVBL/o5qKQNItvzpbRnoOvpDZ4gZedtDchDC/EEn6sWfVkQNFS78ympGANRgRUZ3fgsvoBP+p5rdH1g/xdgj408cGGpXIbwwh7z9m5b87dVPqYi7vlavhZKJi6x5hujFIPtOiyJ7KquurtnBfMDAEhI0gY7ZQPnoouSbWSTW1rUGaWMVI31twZkXuRpyckLFRWTo+txEOShBiIy8rkfcOfV6N9jYVGLowNJqBegL/wXzfvNIAsYwRpZEulPvDzgW72wMgO+BF4au2ws72eQ40MpLwfO/oQhRsNJpslCg8KZM96wCclm9V3ebqcqtyVcJ++hEE+asqeLVCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g3/Nc6EBSORZVgi1aiEjP9vsWtRL94FHBd0iZRnCBA=;
 b=sMz1Psf3vNnn1POTsGDnXPx3aRJvo7cd6utHY5QR8PakhAsdIDEpssBgz+gX1N2D9AdkxVEqALIefHa1Noag1LOw1iWSahkSPVjCyaBHYaNQ3QVGgmm2fhsRVhC2xin7Urhs2PvwGRGDg1A+IySqk1m4Uj/WtWnWhPTac34yCao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:50:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:50:55 +0000
Message-ID: <08e884ce-ffa5-449d-958d-c18b8a35e353@amd.com>
Date: Wed, 5 Feb 2025 11:40:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cpufreq/amd-pstate: Remove the goto label in
 amd_pstate_update_limits
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 gautham.shenoy@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-2-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-2-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: d1024f3c-3ea6-4e08-2b0f-08dd460da3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0dTSjROSm9KM3VLYk1GbWhrdkxTc2xXQ1AzcW5HQnJBTjJ2SnV0ZzdYTFFU?=
 =?utf-8?B?OUJhMW9majlMZHdmcUw4TTlCU0Fra1F0cnRwL2RMRVZXOVdnK29ObEt5dEpR?=
 =?utf-8?B?bkloRnVrUmNUM3dLVU9NdGFWc3lHeXV0MTd6UWFybEw0MktZQVMrU3IxcXFl?=
 =?utf-8?B?c3BwK1dsK0lKS1lBV3dhaUlveXBGeHU0SFE2WE5HeHlrcnRrMXdjQkgwWVlm?=
 =?utf-8?B?OHVRWm5pUWJ4K1BjajBlbkZaUktWTGwrdFRXZEVYZk9mbWphalFtRTdCUCtj?=
 =?utf-8?B?MnlvbGVvVXZFM1EvVDFVRjFaRHFwSkM5Nm1PMlRUT0hBQjVVd25KcmcwWHZY?=
 =?utf-8?B?SG90LzVBbWc5R2huME9RS3F4YXg2MXBXTDI2QWN1bk45M0hLU0YyZGxPaTY3?=
 =?utf-8?B?S2JDdkszWXF4UlFJZUoxeEl3SERVeUIvMHhTMElmdnhpeHMrM1BBclJTV21F?=
 =?utf-8?B?N2FhYm13M0hkTzFKd2lVMmZPejVPVElVOHhQTmJUVkJBd2RPcXVZY0gyT24v?=
 =?utf-8?B?SUZydmNDb2lNRU1wMU15eDRHVTB5WUZtSzEvV3ArckF2VkRvMFJYTVJIcjZB?=
 =?utf-8?B?L3dGTmpkYVJDVUwzVkc4NjNVVmhzMkl3YldicnVaVjNMM2ZScmQrN25ibmRR?=
 =?utf-8?B?U1M2cHduUTN1Y3lhUjJoRlN4a3k2bDVyU1NDUmRnbVZqeTViRXYwYi9xKzlR?=
 =?utf-8?B?ZzJncnF2eFVlbmY5QWJHa0FWQUNMcU94d3J6dTluUkhrdG1hSFRqYzdyOUln?=
 =?utf-8?B?bHlhUlFTNjF6MmJablNoN1F2VGZCaGdDYU54K2ZacnFMMlp4b0d1ZWxhR1hB?=
 =?utf-8?B?YjVXNVBISllrUEkxTHhuMlJGMkNnekpYNmpCeXN3ZjY5OFhHYWdoVlVTdzBC?=
 =?utf-8?B?cjZTZVFVYUR4cGF6WHFmRWlsZEROMW1QQm9VWEV4Zm5KNlRvak40ZktpMUxE?=
 =?utf-8?B?cXArY1VEc0ZvdmJkVzN1NExZTDJYYm90ZjJRRkxpT24xK0F2dTBaWjd2UHJP?=
 =?utf-8?B?VUZ4cTg3SUJVcVhDdnhuRk9FS1dIVTBETndGU2R1ZUFEcmZUck5yVlpueStZ?=
 =?utf-8?B?TVRPblMyVWdpSFRRYlJ6QVBjV0pMU2k1UWtPNTduTUpCeE4zR0V3WDRZQlI4?=
 =?utf-8?B?VHZBUnNkTXpvTjRaN2dsZHNLV2xXcThIUXB4aDhZR0tNR0VNTm5hSExnakhw?=
 =?utf-8?B?UlhXbDZtaGtuU0U2ZUd0NittckRQY1doVVBMQU5FWDl5UnIvQVl2bXY0Yy95?=
 =?utf-8?B?QlJ1SlR0U1lsQ1JDUGdJZm1tQ0lxWmlQRmNkbmVTQ1pyZEdLM2FhY0h2VFNy?=
 =?utf-8?B?OENybXFMajgyeVhsY3cwbWp5REZkY1pVSDBMNjNja3dMOXR5U0dRLy92RFpj?=
 =?utf-8?B?LzFVVExISDMrcDNRZmxiZTRCY2VzdFRSeGZQcXJjbURVMDQ5L1MrSUpXMmgv?=
 =?utf-8?B?cWRtbFdMQktaaTJDQlpuMDNJT05EMVpUMHZESlgza2pTTTFpUERQcm5rcXZS?=
 =?utf-8?B?WFJpT3MxM2kveGFGMXFRVEIvbFdzb0NyUUczSlIrTnJ1djd6SWU5M24zZEhH?=
 =?utf-8?B?ZkxLTHdKd3JLeXdPNWcvclJZU2JEVTFRMm91TzVTaHN6d2FwWnRIOXhnRy9x?=
 =?utf-8?B?akhxalA1WG5JeTdNT2dXZ0tuR2ZidHBtR05rUEtHUW9CSDZCanBDSmQwTlhh?=
 =?utf-8?B?QXVGcGtVRmRKOFAweUVXMUtVeE05MkhZQW9RSVhYdlBqYnNZRmtTRW9YQlcv?=
 =?utf-8?B?dFZETUhreVBLRlpNMUsvMkVlZlZPWklLcGFhMGswSEk0czY4WXlxTXQxdGJn?=
 =?utf-8?B?S3pDa2NHMzY1bCthRFE1THJuRUZWMHhVN0RDMXdESGNYVjdnemVTVjJhUnl3?=
 =?utf-8?Q?jSykxjpjVu0kn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmQ2Y204M1Z0aXlzRS8veS9YTzF1WVhucjBzcUZlYkF6SkNyeEhWNFFKT1ph?=
 =?utf-8?B?L1VtV0ZsSkpGcXoxcUwvWkMvRjMxWk9PZnhWY3Q0UWlnZkFqN3EvM00zR013?=
 =?utf-8?B?dXlaeFFaakpDS1F0WThpMjZlaGVlOWkxZ0xJME5WR1duM0JKSFY4TkIvNXFR?=
 =?utf-8?B?OXUyaWgyOHRGM1VuQytYQUptalNBRERZcktlNTg2RWYzRlhyejBuVkZ3UHU2?=
 =?utf-8?B?cHUwOHlmK01CRXJtR0VOdjF6RzVxTUlUNjJtVS9EMW5yUEVMRjkrVGF6Mms2?=
 =?utf-8?B?a0ZpMmJEYzlPQ3gwcDJLTGxmbVFlaDFrTkVrVkJwZzFBSzJJR1ZSU3R1ajcy?=
 =?utf-8?B?WE43SkdkenBvNmQ0cTh3N1UvRzVXUU0rY3NSWkRmbE5kajJQcVFsbmVJcXVn?=
 =?utf-8?B?WWhRT2p1TVdqTUVwUWFLRCszQ3ZEdmk2Q0xhSUdBRUJ3REcwMzcrdk5yT1B2?=
 =?utf-8?B?UXd1UDlJZ1R3dzVmTmx1TkRETldCZFV3T3BxeTY1RXRGZFVOOVprK2lsUlZx?=
 =?utf-8?B?dGtjaHB1c3dtYXBJT3Mra3BMbFdkZHF3SDIyNmE1bGZZYllLQWdkUWJUa2ov?=
 =?utf-8?B?b1pGSzMrZE1NVDFmQnNrTFVBV0ZWVkdtdlJwVmJvNnpJd0lSSnVRRVU5Q213?=
 =?utf-8?B?aEZ0WXZaVU5xVUlQREdoZkxUOW1PVDFsL3JOd00rMHZNL2FCOUFCWWRQSW5K?=
 =?utf-8?B?bzg1K0NiSFp4WFdSOER1bEhQSWYyK09KQzdqTldwa0JWWDFXbG9KVDJNclZl?=
 =?utf-8?B?VWVvZVl0QUZoV25LbDh0Vi9mdTk4REJaQ0huOTMyMk94TUJsbmw4T25ZMis5?=
 =?utf-8?B?MUhKNzc3UGNtcTd3QTFuRThhUG1PbGE2aUh4Ymh2OHJoNXYrSHhkNjRYeVVq?=
 =?utf-8?B?TEFGd0tVcnM0RHRER0dLTnkwaXNnTkViUXlqUjhJQjlYRSt0NTkrUy9SK2kv?=
 =?utf-8?B?ZVpiWVA1a2ZzZUlFK3A1dFduVFFuc2lnSm9weURaL3RseEp1N1V5YnNocmlU?=
 =?utf-8?B?SmowNEU2WTg2Wm1TRmtYSjc4WTFzZ3kxakhnblpGWEpjc0o4Tzdab3V3R3Jh?=
 =?utf-8?B?YTg4ZlRTcWJLdjRLNWptSVdXbUZtZnZsczhBODFmUFVVKzVyeEZhekJxT2Ra?=
 =?utf-8?B?L3FnWllaU21yWUJoa1ZIRGl4MmNRNS9KWGI5aHRucEN6TU1ZYmt6SHAraVQ3?=
 =?utf-8?B?dW5BM3E5NVRLMXcyQTRCb2dJbThKUWhqcWMraVZrZm43cDJwRCtFZWVQSnpv?=
 =?utf-8?B?Zk54b0tCSkliSXJnOFdBVWdORUMzZVRwS3piSG8xR3kwZ0xiL0tqek9aMXMx?=
 =?utf-8?B?TTRmRlc0WVY5bmljY0FOT2QxZksyZGFKSmMrRGhNcUNpb053VWtBS0hTZXFU?=
 =?utf-8?B?aWVVTmV4VTUwTnNnN3h2R3ZtMS84WW1GSDlLenVEN1VjR1Q0U0ZBNll6bE11?=
 =?utf-8?B?U0ZFckxXY2FMalpLZm5XUklwaWVPSllzem15M2I0d21XeUFIZHA4RHBFSm1u?=
 =?utf-8?B?cnlubS9qaXJ6R1lpSGNlYXZ4NXZ3K1AzL1czMzlKOGRrQ3oyUHduamVPUmNN?=
 =?utf-8?B?ci9kci9NdCtBeGZNNDFkNEpOTGN6TXdTKytjRDF4eUJnM3lxRmhCZnY1RklO?=
 =?utf-8?B?UXZaaDZRUDFsQlphVFpIYXgydElvbENqUnpmVHVFUTBTUGhZdi9lN29lejFR?=
 =?utf-8?B?TWlkWmRlTU1oS0diTEkvaXVlcDZYQ1dXdnNCQmYyMTFuRnBLaHdsQjVET1FU?=
 =?utf-8?B?dkxCMVk5bnljYUYxTVlmbXM4ckpvdTYzbWllV2RmV3hSNmxiZG1TdGtoSEFu?=
 =?utf-8?B?WTNESUxYWGRYWCtoVE1QNXRnTGJzdVNWQjdSQ2hQODlNdk5wOXRFVzBFYVhh?=
 =?utf-8?B?VDRnemdITHFPOWpqWjVXVVcrS09Scmg1aDVuT2VRRUpMMGlmcmFXeVV5OHJP?=
 =?utf-8?B?b3gxOTJIeEhlYkk1TGVhdGNaSk1hRjljSGNwOGh4MVY4TDJLUkkzQTlBY2lj?=
 =?utf-8?B?RkVCeDVzU2c5ZitVWk5mdWtpOEdqOS8xdnJIcUlPeVQ3TFhMTDlpWlY3dzJs?=
 =?utf-8?B?Ym1CelBORTgrSHpWOTE2UVpjdVpvSUowS0djVzRKcWwzK2ZhYzk4bmovS1Jl?=
 =?utf-8?Q?hERz1ugCMoZTPorCw6qON334u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1024f3c-3ea6-4e08-2b0f-08dd460da3c8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:50:55.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxj5mSOltQwfjk19mHGeqSs71ev0BbePxwo/lWRw9vclVGZRK4lX8s2eXc6pwZ2NtIgG4a34kbh7N24//kyFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> Scope based guard/cleanup macros should not be used together with goto
> labels. Hence, remove the goto label.
> 
> Fixes: 6c093d5a5b73 ("cpufreq/amd-pstate: convert mutex use to guard()")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this fix for 6.14-rc.

> ---
>   drivers/cpufreq/amd-pstate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7120f035c0be..b163c1699821 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -838,8 +838,10 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   	guard(mutex)(&amd_pstate_driver_lock);
>   
>   	ret = amd_get_highest_perf(cpu, &cur_high);
> -	if (ret)
> -		goto free_cpufreq_put;
> +	if (ret) {
> +		cpufreq_cpu_put(policy);
> +		return;
> +	}
>   
>   	prev_high = READ_ONCE(cpudata->prefcore_ranking);
>   	highest_perf_changed = (prev_high != cur_high);
> @@ -849,8 +851,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   		if (cur_high < CPPC_MAX_PERF)
>   			sched_set_itmt_core_prio((int)cur_high, cpu);
>   	}
> -
> -free_cpufreq_put:
>   	cpufreq_cpu_put(policy);
>   
>   	if (!highest_perf_changed)



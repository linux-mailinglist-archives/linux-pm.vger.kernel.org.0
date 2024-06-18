Return-Path: <linux-pm+bounces-9508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1F90DC59
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627C11C219C5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576E161906;
	Tue, 18 Jun 2024 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YAcl1mDd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1916191E;
	Tue, 18 Jun 2024 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738731; cv=fail; b=OhcHUVQP01CPp6Fe5QNrsBYvhInOOBHNnfCqZE5+Cvr0IT6RHjavU6vHQ3C/9kmEMFfuwcIdRcxpveVsnW5AUqsSR/NBHvhC0/1XIGRuaIzpr+x/rjkPifD0MLiCsASq89PjUT+LM5uWuS0av47qzKVGvmoVoN8Vq66+3AXx2fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738731; c=relaxed/simple;
	bh=n/lKeuKxOz958gpLE78jTM03KeQw9iTo5+B9wvhGi4w=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYZ+7QbBgJB1jUJNvfLK+Yo4TszkIMsF9UJQYdl4G4KWbptpW1xHijVp/uOHlhQ2jSJ3sF4UyQQ8QOwwTJ+bGfAqmaPlcqm+j6R42iwk55AdGzRWiXUKSCOTZb4FFPlfgrQly5DFsLll5RT4dd4FSGQU+YxH3wFtw9Hy+dZOFCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YAcl1mDd; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFzvkVyY24hBYW1DNZKZjkOrVF3UknZBuQx20i8Wr2+nMO88R15Y2xY+TLqJJ4QDGQuJ7xc6T0P4uuHnH+v0PNcMSmHXj7qhyRgKYlTiYi+ztmXKYga1mmGTXLgXdnt4VuMtZ9/9t6My5xbPRycIrfSuPYHHjOuTYyl2LpzEglI7+zcM4HvrAqxMc8QJ30gT8WQiLwmj01oQReYS/PwC3fa6vTH7BbFShhoYg8xptsgO6s/+bGxAbcptHnjKDkgvWsWaUT0WR9zFriy9Ixdzq+qKyFB6EYYIlcZSMAgjx0LbxRJqKtFf9tIlOQUjnVFQTT78qmheFPXi2lCiQfqxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuE0HMixAYobTE9bOcR2PylYN1k6Sx+iIrVkFYPyFoU=;
 b=a2e89q7WZEYHO4o+8DqWFKMthtawgwp0IwDyDRxtxp7cVRGb/iTc59vrTP0O8Q4OP4X8ivsNcRUrvnqkmp2fVf+rFLhU+qCwn/cV4GBJSmUlkok0nTVM8TtIYGanktGzaK3Qyxy+x0m7wHJYD2PthDoQhgJpIi4FyoLmGBxdplqzPLHcAygy1q0sz0XCQRFa7RAO5fVqWLYdiCFqVb8mmd0iI5QGVWlmm/gxuYr0EyKJaLkw16OqDs81FbjzjKg+2D1i1smrJpiNAoNECoxamn8CSGv6UaxoCvxxNaTc6CLDgKpDyCBPq7Xs1BBkOep/VQ45Wy10zU6m/L/ji+5Lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuE0HMixAYobTE9bOcR2PylYN1k6Sx+iIrVkFYPyFoU=;
 b=YAcl1mDd7Dyw05t8CceSBzpvlyJTmKbHM0vZ8kp7c3crKEScd3S+OEuoEjGFebHhrVKb2+Crqudrs2WMy8syPs9YRJAJ03qB/sLGLpx1LO8lnJokL3BeOiDGVJ5QCUTJJXN0mlIlVFpmCenJ3CN0fT93yfQGc1B4+xciOdZCJ20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 19:25:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:25:28 +0000
Message-ID: <09f985e8-5e53-47ed-84a8-baaee52dd483@amd.com>
Date: Tue, 18 Jun 2024 14:25:25 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 10/11] cpufreq: amd-pstate: auto-load pstate driver by
 default
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718606975.git.perry.yuan@amd.com>
 <0a4699e224e1931c09d6ede2620d585382b7d168.1718606975.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <0a4699e224e1931c09d6ede2620d585382b7d168.1718606975.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:806:d2::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eac34f-3316-4166-7960-08dc8fcc6910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YS9HTEFPRzBnTzg4N1ZDU2o4THNpMGxNMEtzNEZQYXFPWktieFRGakc4K3BH?=
 =?utf-8?B?OFFSZjBvUHM5azdxWjE4enh5TWNLMHB6UWFxZCtudmozWWlpT2FjZ1pNQVAv?=
 =?utf-8?B?M2V2U2R0NG1RWGxhc2FHcUQrRElPN2Rjb3pLOThYNlJjbTUwdjVaTGNlZ0hp?=
 =?utf-8?B?RGt4VU1Ed1ErMzBXWlluV0FHclJscmo0T0pPMWF2NUNJU1QvS3NWQnUwbHho?=
 =?utf-8?B?V3llclBXZWtwRU9BeTlITjV4aFpaNnVCYmFqcmlGZGdyUFEvK1YvZ3hqVUpG?=
 =?utf-8?B?L3hCZXhBKzg2KzJWZG9US1AwMUJnTnZBVThTR3UwbXhuZ3BBb29DUmlEU0Ux?=
 =?utf-8?B?ZkhSZFNmS1IrdzhvMDYyZkwwVHY3NTN0dzNmM2xvN2w4TkpRYU1ueC8vWC9D?=
 =?utf-8?B?TndPMklLc281WkFQY3ErQjg0QUNpZmxQemVUajUwMTNDWFpyUEtzSXpPREh4?=
 =?utf-8?B?WlpHTVZ2ZTdUWHFqSjlESUlDM3Vrd09HZnV6OFNGdnc2VEtCcDBndmNIRVJu?=
 =?utf-8?B?c0FIdGplLzBiT2JueTVIOFExd1A3d0Q1U3AvR2dKYjI1OFhOMExnemJ5U0pE?=
 =?utf-8?B?UDU5L04yWGhQbC8zMHI1dHRQRGp6YlJtelJIeTd5c2NHTjh3TXA0RXp0NUZC?=
 =?utf-8?B?QzhFdGhjL1I2cFdDMmhSUnpTT1FzcmRVdGZibUtRMnJVU09CREREdHltYzFw?=
 =?utf-8?B?OGVSQWdWUlhYSnhudWJ4WllVOCtqYzIwNU1MMXNTMlIzWjBrcExVNCs4TUlE?=
 =?utf-8?B?c1dYdGxIaGR2TE5JaklDbmI5OWtqd1F5cUNoMy9RRFlBRWhva3NTVzBVWko1?=
 =?utf-8?B?YlR4WTVWdnVlNVg3ZHFkZHlBK0N3OUtVcXBMMUY2V2RzOFRMY3JDYU1Xc2pp?=
 =?utf-8?B?K2Y2MjNUd0ZxazJjeURZcEV5YkJZQks3UnplQkl0VmFrOFg3OEwzcFJUZzNt?=
 =?utf-8?B?RE1XMVoyM0dpNmZpd1E2K2tlTGhkUHB2OXYrdnBqc1VNR0VnMWRTWXdsNXpY?=
 =?utf-8?B?TlFhUUp4RDBUMXBvcElYSjFhWlZTYmlEeDBGL2VpMDI4enZnTFRHU2RRd3kv?=
 =?utf-8?B?WmNQM3Q3SUsrWndsYmtCWW9Ba09MeWhMYTJBVytFcFdIdUY1MEV0cEw4NEZS?=
 =?utf-8?B?Q2t4N2RRdHo1SGNBc2N5QmFKWUFXZzduaTY0ZmhTZklscG1FZU16UGR2cktq?=
 =?utf-8?B?K3BVR1M2NnNxMUozTzRKaDdVRjU4eDV2WWhiekk5cnkyckpwZGFoaHhLQWFZ?=
 =?utf-8?B?c3Q3Qk5QdDBzNUdKblJwN3g4Wk5oZ1BiQUZHZWhvdkdMNG5QTjdyaklEbzJP?=
 =?utf-8?B?Z2pOa2k3bkxOdnVKRHNzaFQ0SnFnZWVvZnJOa3JvNUZGeXVYdU1uYmoxVFVO?=
 =?utf-8?B?TjhWTzB5bTRLYUIxL2xXTTcyZFErQzd3TXBnUEk0U3RSNnVQaExKSnRIZ3l5?=
 =?utf-8?B?cWxMdW9oeVlydEZmWWN1U3Z5ZlhvNmF1Q1J5aFZQdkFranB0Q3JqKytDQUNJ?=
 =?utf-8?B?cXZCdnlkOTlJelRTb3VwQWNGbXRydlp0WHBvVFgxMGxIQTNzREFlUndUYUVy?=
 =?utf-8?B?RHpuOFJZd3VBWDc1d3NZZDk3eVE4MjRabE84ZytsN3ZQVkdYQ05WV3dyZklB?=
 =?utf-8?B?MG04RVlMc1NOL0RoTHVGU09hcGdTc29GSDB2eHRQTHhyWHpRSWtYMkZNeXA4?=
 =?utf-8?Q?/7fe6jhgQ0/RQ/o7A6zJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXRyOSsrZzN0ckRHUWJXKyt3a09rYkx1NW5HVzJjNzF6Tkxmems2OVRJUmZ0?=
 =?utf-8?B?WDI1d2dSTmZYUWhiV3VENXoxcFRNOU5qS1RRRFhDdzdQUlgxY013dkVwVExo?=
 =?utf-8?B?UHBNL3BEbmE3dTcwT1p5dU9NUGNsUmV0QlZlUmZKMjZmNjh0UTMwQ0N4VWpC?=
 =?utf-8?B?RUZpY3pGMXg2NEVQZUJnRDc3NTZ5K1RURE1QNUNBOHNad0RkTy9icXBHZVly?=
 =?utf-8?B?ZTlSbGFsYlpsM1NTdUk2cG1QRjJQbDloNnhpT210dU41WC8ya211Ym5oNHd3?=
 =?utf-8?B?U2F3MVU0WUdXWm0yeDJhR0RyRWhkV21ib3pUaVUxenFlUkZiZnRiU0ZIb2RE?=
 =?utf-8?B?aGJDSmliRTlCWUkvOVdsRjIxdWZ1MytNSkxKK1dIQ3RzNm9WVFllUDBtbnFC?=
 =?utf-8?B?ZUcvZ1RqTWhtOUI3ZERzOWFqdFl2Z2lYYXRQRWdsOUwyelVqZjBzQ3VXM29X?=
 =?utf-8?B?N2hMcmdvWUV3cUxkU3lMTjBUWlB1cmRBSjdHRVZQUWtacHU5cjl3YURFSk1q?=
 =?utf-8?B?YXI1MkdOeE9NL0NtSEpTd0VGY1I3QUhLTXM5bUE0RXArSkxjdFN2eTZ2dnVO?=
 =?utf-8?B?YW43ajRRWGtsZkJHQTdlVmJocTJaVnBrbG1YcEtrTUlJNUpSVE1Jemc5Tjd4?=
 =?utf-8?B?YUVBaFEyQnRjWmFNcVVNckFocWpmbE51UWY5Y0dWM0paVm01VEVjdldPdy85?=
 =?utf-8?B?eUV1a2l4K1Rxd0x4eThGb3NBOTRKcDNJKzR0RFhzeTBxYmp0Qjk3dVdoSzA3?=
 =?utf-8?B?Wk8xZnNRTUdvZUNZTnZPaEhEYktObzdRR0VJY0ZUZFlWQ3A4RGpxVENiTzR4?=
 =?utf-8?B?am5IVTNKSjB4NWpkYnczb0wzbDdHSHEyN1o3aDdUS3BXZUJ2RGNKNEVFL0V2?=
 =?utf-8?B?dEIxTHdkYkZXeDVVWjZNZjZINGM1TFkvWitYUTY4Ty9Pc2xWNUQyUHYvRzVS?=
 =?utf-8?B?N1B0b09sSGZLaFh0ckpYdVVxZTYwSnJaQy9GN3JGaUNzcjJCendnZFNDdHVy?=
 =?utf-8?B?d2RwRkJNRHozdG51V3dhd1J2SFlzcWxveTBLWUpFOXdkeG5OcHFxRVoyZUF3?=
 =?utf-8?B?UDlZbmZOaGZCd2J4Sm9WeUZzU0YyUEN5cXgycEpsWkxlVzRJQ2JlYlJCK005?=
 =?utf-8?B?MmdWSCtESlQ0WW1tNWQ3dnhEaDFGWllobzA1T21vWHFxeUdKQU1ITkRISmhG?=
 =?utf-8?B?enJWc040cE9BYU0waW1sQ3ljU0RKaHhYZzF6ZVdUay9Ha083L1l1UUg0YTVm?=
 =?utf-8?B?OWxsUDRmWGttZ2JkU2ZIOUMxM2I3ODV2RVBTdmJaeThmcHhtWU5NRmkvOEhy?=
 =?utf-8?B?YjM5a3BqR1hhUkdmK1VmNlRzYWRhRkJyTnNCc3A3QVdVYTVRR1JwOU9mblVN?=
 =?utf-8?B?V1QycFBHRVorbnVuU25QVHpGNE5MbjBLUjMvOTBkb3dnWW5Hb2FtVUNqTjE5?=
 =?utf-8?B?ZmhnWWpybEs0S0NveXM1bUU4NFF3RGRPN1hDcllPNEZYdllINXg3OFMyR0xQ?=
 =?utf-8?B?Ri9Eb2Y3L0ZITUMvT2xaQ0xDZzNQK3lObVJ5YkMrbDBrOHdqL2cxVGdaRUxh?=
 =?utf-8?B?aGN6UVQ4R21LSHJyRGNuR1plQ21Td3kxUlFIMUFpdE1INFFUWkZrZE5hZzFq?=
 =?utf-8?B?eFFWRW9RQWdaRndFYnlvTjdQcEtWK1YyY2VGMFVKc2ErcFptT2orZ1RZZG1m?=
 =?utf-8?B?bDBQRE5zZGpKNlY1Rm5NckRRK0VncGVoVGhKeTJuazJkcUtzREFuRGJYR3lx?=
 =?utf-8?B?czRVWW4ySFZvVkxLYnpCSmJreHUzL0lVUkRoSStUbUpESlJuR01iUmRNbEJN?=
 =?utf-8?B?ZXY1aEx1MFBoU1FEcWVQbWcvTlFTMmpqd05YR0VKalVycldMRFd6UU53MCt2?=
 =?utf-8?B?alNGZnVRaGU4RXpFTUs0NzN6V1FtMWRJdXdIdElmdnE2QVQza1FCUTAyblhm?=
 =?utf-8?B?SlpjeDNyVkFVNnV5UW1oa1FXczRlUGtyQm54ZHNMR3A3YzFndk1FRW1zYzBN?=
 =?utf-8?B?ZlVwM0JzNjRQT21jNGs5aUVQMWV4MVFMZys5UHJzcm5sUVNEb0h4bFJJeUMv?=
 =?utf-8?B?M1hlZzVhMmRCa0VJa2FEeUtPQXNpNVoraTBrN1R4Q0p3ZWhJMGc3bjIvSnMr?=
 =?utf-8?Q?/A8lbIx7oWcz+xAZuVukCvda1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eac34f-3316-4166-7960-08dc8fcc6910
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:25:27.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBgFGZ27X2aTU3RUaEIbpk18JUCnUsjlNEoc65d1SiCsdDIiqDmakPK3v9ejMBZuABa/r3jCjaUjM97dyjuwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

On 6/17/2024 01:59, Perry Yuan wrote:
> If the `amd-pstate` driver is not loaded automatically by default,
> it is because the kernel command line parameter has not been added.
> To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
> function to enable the desired mode (passive/active/guided) before registering
> the driver instance.
> 
> This ensures that the driver is loaded correctly without relying on the kernel
> command line parameter.
> 
> When there is no parameter added to command line, Kernel config will
> provide the default mode to load.
> 
> Meanwhle, user can add driver mode in command line which will override

Meanwhile

> the kernel config default option.

I think you'll probably want to swap the order of patch 10 and patch 11.

> 
> Reported-by: Andrei Amuraritei <andamu@posteo.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cf68343219d1..b48fd60cbc6d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1857,8 +1857,13 @@ static int __init amd_pstate_init(void)
>   	/* check if this machine need CPPC quirks */
>   	dmi_check_system(amd_pstate_quirks_table);
>   
> -	switch (cppc_state) {
> -	case AMD_PSTATE_UNDEFINED:
> +	/*
> +	* determine the driver mode from the command line or kernel config.
> +	* If no command line input is provided, cppc_state will be AMD_PSTATE_UNDEFINED.
> +	* command line options will override the kernel config settings.
> +	*/
> +
> +	if (cppc_state == AMD_PSTATE_UNDEFINED) {
>   		/* Disable on the following configs by default:
>   		 * 1. Undefined platforms
>   		 * 2. Server platforms
> @@ -1870,15 +1875,20 @@ static int __init amd_pstate_init(void)
>   			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   			return -ENODEV;
>   		}
> -		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> -		if (ret)
> -			return ret;
> -		break;
> +		/* get driver mode from kernel config option [1:4] */
> +		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> +	}
> +
> +	switch (cppc_state) {
>   	case AMD_PSTATE_DISABLE:
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   		return -ENODEV;
>   	case AMD_PSTATE_PASSIVE:
>   	case AMD_PSTATE_ACTIVE:
>   	case AMD_PSTATE_GUIDED:
> +		ret = amd_pstate_set_driver(cppc_state);
> +		if (ret)
> +			return ret;
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -1899,7 +1909,7 @@ static int __init amd_pstate_init(void)
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> -		pr_err("failed to enable with return %d\n", ret);
> +		pr_err("failed to enable driver mode(%d)\n", cppc_state);
>   		return ret;
>   	}
>   



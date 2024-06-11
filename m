Return-Path: <linux-pm+bounces-8970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D01B9044B6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90309B245E5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8D143746;
	Tue, 11 Jun 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RY5zqXNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB62628D;
	Tue, 11 Jun 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134168; cv=fail; b=lSetSLJbi7fpSS39YrPiokOEK21nM3lWxqRGwdwMWTQwRGE1wyG8lSnydOii/VgUh3mjIP/BPzDRy6vUPfdFn1U/uSNfGXWD1lzeA+S2eued7WwANFzeDkQ/EHEWYhMwISLnVOTa3eWbWW1OB8YKsBvcodplQxIDAl1ZGOJU51c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134168; c=relaxed/simple;
	bh=UANXVU2IyBKFeNjjZcZQiiytgINm+iU45fNdHBNsHqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MYG71xHH5kPR60wVjXIO/osfR5Fj538BnnnYynSJgiQvkO0vBMXzEqmubgo01IG3LfKidHZyqppyL0VWOnDM0TLYcFltTshYSgMEqTsu60/cwfMu9jMacSCC3n0KzZjsDtz8k+5Dq46Y2boWlF/46QQmP4E3gl593lIQlJMpH8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RY5zqXNk; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0MOW/c5Q7UzKceVHrCx938clsEtm/vl0XIe1/4jiC5Lx1AuasXfhheUIHe29pBD3HapLr2HJgCooVl6Hcs3u9fM0PVU3LHxjldS/f+Gjs5vY8Pz3zI/+0zNaU54Qtz5hXZ8hNP+dGKACcRJIJ5mMd32C0d6SVPUbWzBB/xnugV90SWfgXxwnhlWzi+E4WQQfrzzQ+nDb79hxt0ZWRVla61b1EeD2B7ABwFzzKjPdHAqncEJpb7sfB+Q6EwAcxyK2/xHrs2s9Cv0NP4FYnUifW3VVxBBY/4ZoZOXdDWNFTFmF+JjcMWpNaq0irWvfTE4RQ5Rs6NR8h2EpYnJvwSQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCpTT9gHwXvSk0B5eDFow+/qvTM5trNJsQPF673o+Ws=;
 b=kG83cUv+7Ox/QM7/IZL21H996Xjm/riyfKcmdiH4rq9OS8X/qis8CWbB1bQYP/GTj1MsWS2CJcLQx9mRZ718oebqMxR0wUPf6lNnpkSvH+Y7aGo3XbmTyByijj3YT4wRi45KcPXfrkoWmouKs6DpTLyWSOYUgEBH83vj+MQg+i5LQfIRotKanemvYZDYBDSQUbgLYJbRdo1HVLmN0y+QBgkVM+h2ZUpKv0DX6VLhLbRRmLdGkNE4LPX2zt4obxpqWxK96ThRFiPA0YsmQzGQIRhe1l4nOQG0Z1TglapAEUXOa4k4UQgxPNmGiQgMyxcyjEv5A4Hl23Jk0prUVxB9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCpTT9gHwXvSk0B5eDFow+/qvTM5trNJsQPF673o+Ws=;
 b=RY5zqXNk5w3+cvXm59GitZ6tMzHF0vaBqWOinFRMbepyImUKU8GOq/Tej1H4g6+/7XEQdSd50Hsmw6tblOfj/lKL2lBazl543pgn0BRD/fQKucel9dDS/ZJY1P1KEm+qgZxLHJtBegaegnbFi+A/rr0nL6Hbae3qZ2ipV5wLqnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 19:29:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:29:22 +0000
Message-ID: <a6d6ccdb-93f3-40be-b02d-390cb70656ad@amd.com>
Date: Tue, 11 Jun 2024 14:29:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <97b65a2294154dd469377a7a76ee738de7bf7aef.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <97b65a2294154dd469377a7a76ee738de7bf7aef.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:5:40::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e19335-0d5a-46f5-d816-08dc8a4ccc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUUwMnp6T3kwWU9sWUZqT3poRmIwbWRGQ3h3V09IRG5ZT2xPWksxMGx3M1ph?=
 =?utf-8?B?UnJuWWZjeHVHN2tyT2dMb0l6QVV2UU95N2h5TjZ0aGt0Y2VaUGhSOWlETjhL?=
 =?utf-8?B?S1VrU3ArVDU5ek15RjlzbE1keGxhc0pBVStPTGFObVZNbitaNno1SmY2YlN4?=
 =?utf-8?B?Z3dPaWtsYW4zNzZpUGVUZFpicWRlU2ppOEZaM29wUk5teFFrYmFLaW9Fa20x?=
 =?utf-8?B?S3U0Mk90cUV6Yjh0bUxZSHYzSUdDb21mS0tyL1hHMFpXNm9ma2JLRi8rLzRs?=
 =?utf-8?B?TXFsVU9xaVl2Wld0d0pJNHVMemdIb0NRSFNWMEg1aWRtbS92WG5PMTFsNlMw?=
 =?utf-8?B?dFNISDdSazdwSXN3UXNRdllraVcxRUhpN0FXcDA3czQ2WXFpemw3YUxGSThq?=
 =?utf-8?B?MU1aNGV5b3JtczRPN3dpcVUxNVFROU9hMnR4WmRlb2UwVHk3NlBnaGhBcEpW?=
 =?utf-8?B?dnpiSTVMb3FhaUVXYmo3bTFGUXhEUmVsUmlxby94SzljN0ErYzVIeWFiT085?=
 =?utf-8?B?UDVsMnJtQnpZS1JHM0NrOHpGZlk3aEZyQ3kzb1pWdjBtcXl5TkJpSXREQ21R?=
 =?utf-8?B?b1d2d3AxYzFKMWlzdGZvZGRXV1NQZmRFSVJ5UnlKMGtrL09MN1djNU5mL3B4?=
 =?utf-8?B?VEdHbkNGaklUYk9EME9xY3ErQUhSTDQrbnlWTjdiYzMzQis1dkhrZkUvcHJa?=
 =?utf-8?B?bGxaRWEvZkJ4eWRNeHR2KzZuaFR0dFBoU2g0U1BxZU4vbEpKT3loWE1pRHgv?=
 =?utf-8?B?YjhsbXErZW5nUGtUM1RSbnNDNjRjRWI0Y0tvVUVYSFlhV1JENXBBenZkM29K?=
 =?utf-8?B?Q1VZcW03Vk40OHVOM3VhNnhzVkRvbTVaODBQRzhaR0xHY3dNaG5xTys3eFA4?=
 =?utf-8?B?QkdXWm1VNmpJeXBkbVBBOTNiTkVxbzh0cDR6c015UmtaMFo5ZEJzWmVsOUEx?=
 =?utf-8?B?UGZ6TlpQQVJCaDV3RDU5M3N4eFlaSjBsRVBvSnZ1eVZ6M1VzQXJXMFRYQ1JI?=
 =?utf-8?B?M1A3NDlBa214bDRHc0Q4WWhHazI0T0JGWC9vUGRPMXNraFZSMXN5TjRJOVl0?=
 =?utf-8?B?eWUxY2kvVTZFUmdJUXBPNFNablJ3bkJhRXZjRGZYL0U5V29zMkhkZ3hsVS8w?=
 =?utf-8?B?Wjl4eFFuYTErWWVuMWk3WmdRTkdRcVNhQmQ1eDRCdEFrYVVFbHc3SkRuOEMw?=
 =?utf-8?B?U2VReHJwNVFDN09HUy8wSERaeW1nSXJFbDBDN3BtTHQ2NVozcXh0WlZCQURq?=
 =?utf-8?B?eUNyN25heUhtSzd2ZWRPNTlvanRhY29PMmlxZDMrTzdWbWpUWUVxNG9ydWpE?=
 =?utf-8?B?cG5nNjdvOGIxbTV2cyszcERpM3dUOStKN3BDb2ZtYmhIaU5oRU4reE5MNllU?=
 =?utf-8?B?TTdCOWN5WThXU3BUY2xNT2t0dHZhemdQOW1aR3Z3c2RWNVhvUEN4Szl4c094?=
 =?utf-8?B?U2tRbGlzVWlWWE5VVnFhTDQ4dEt3QzNHcm90T21Ta2djbFRWRzkrdXo5aGJE?=
 =?utf-8?B?cFdUSmhvaUYxcG1JdzZhNjJyWlZNZjdhNUZmMFY4MlY3M3A0MVFMZjZUelJE?=
 =?utf-8?B?U0pHaXBSTU4rUnIxWjhFSUxaYXdjSTNtaTlyUnVIQzhHM1dsNHJ6S1NCMDgw?=
 =?utf-8?B?TElDb1J5TEtZbXFBZkQwbW5jaVZEWjFDUEU5Ky9tRjR6eFFMSm5sOVZyU2V3?=
 =?utf-8?B?SUpHV2ZlRnNuTUFZNGJ4UkJqWWhCRHpoKzFPeUo0d3hhNTIrdEdLVnJzdmM1?=
 =?utf-8?Q?CLm5VL55u7hjpn2Mu34zw4ScSSAX8bhHgSBiAHT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXdqdXlOdlFpeU80OURZUzNWRFBSRkpFaEpyZkhFai84VTVIcHV4OFRzRXBG?=
 =?utf-8?B?ZFRqbUxIS2Rxam9pcEhoYXJiVXhvSG9vb29LUEhWM0tEZEZTRnRqcDhheDFp?=
 =?utf-8?B?dmJMQVc2Qnk1RjBDcUVrajlIS2wvcXEwOHpPN3hZaEdMN2s0ZEZrSk9VVmF6?=
 =?utf-8?B?cUNUcERxYmFTWFMvODRMcVB2TXhReU4ycnk1Uzl4TUVDcitRaFgwYVFBNnh2?=
 =?utf-8?B?SFJXTk1aRUs5Zy81cW5OVnR6RHBXS0lDT0pCZnlQZjRMZkRJVGY1cXNtQUpo?=
 =?utf-8?B?Ny85N1dHa2pKRVdjTDZ6OVBTMWd1N2x6TDA4N21BZDM4dFhOYTJNOUJOWGhK?=
 =?utf-8?B?eVd6ekFQbVkrRWE2NUJmc1ZMbmZpU1dlZ00xeVJGNXdseVdsVTJFOHA3UkpO?=
 =?utf-8?B?TFFvVjV6aGRvNDhHRUhPYmxQMDJGODJVM2pXQjlIUkd6TkVnSjVsQWl2bW1Z?=
 =?utf-8?B?NEtDdndtR1Z2L0MvKzN6ckt6d1VkTmpsYkhjRElnVjMwSFZrQzNEL2JXSDFh?=
 =?utf-8?B?dklUWHRRVk90RHVndkhkY3dQaDdFRkZRTnE0RGZaUTNlSjlaQzlMNEdhYVNh?=
 =?utf-8?B?MlZmZUtCK2lqTVIvOHN6OGdKVTY1RU94OS92TzNKbzZpRGMzMjBFcU9qZUo3?=
 =?utf-8?B?cmZTWmpvdWFKTFJOVDQybHNRVG9hNFJ6aDg5Y0t0TUROai94V1BlZDVpUFVn?=
 =?utf-8?B?bjM2dFBabW9xYlR5NnE0aWp5YUhjWTJWbFNQaHFhMGdNRTRtWXhxL2lZdVF1?=
 =?utf-8?B?SllZWmQ0dTJXL1ZmS2RyNUc4MnhQaWR2N1FoN2tJM0U5aVg1Y0I4bnFDLzJG?=
 =?utf-8?B?WFlIa2lPZWkvNDNkRGwwcVc0dC9MNTdjZmRVc3V2WXViKzh3SzVxMVNMYk9q?=
 =?utf-8?B?TmVKSXg5OE5uWjA5S0VyKzZkMkRCUFJtbHZQUUVCN1NzT2M1ZVNKd1JPQ0Zn?=
 =?utf-8?B?NVhKaEc3N2FVVmZwYnorS2xFdGJSNmhYd3Q4cHQyRFJkT05RUkhQdmljYzll?=
 =?utf-8?B?VW8vYm13bVhKMzhBV0VaNWJWZDFKbHBRcExLWXA4Nm5UVTE0a1VqR2xGdStS?=
 =?utf-8?B?QUdmYmk1Tlp1eWw5b3d6aStlbGR0MVdNUy9XZWZWWERnbWE2Wm0yZ2VpTVBx?=
 =?utf-8?B?MjVQSVJaR1M3ZTd5M2ExTDlyRFk3RHBzSUpWZlA4V0dqclZWK2RtMHVGUTk2?=
 =?utf-8?B?NzQ0b3pPSGtWdVVBUDFlcFlCQ2lMSm9FVmpZdzRIc29YaDVsREhKcE5kRkVI?=
 =?utf-8?B?M3FkMlExTnEwOWU0aHNtQ29pZWNjeXlnR2lqN1pXeHJ6TGN3N1dhQnVsNlJJ?=
 =?utf-8?B?Tkdyb0lCbXV5VVhFcmduaEJaSjJRbFhMY1lVWWNyMWd6UGE4MkRua3IrZTNw?=
 =?utf-8?B?RGhZQmx6SXFJOGpscDVhQWpyUThUSVU4Y2NYRkZIVlErL3BKSDNIRXlrWXVC?=
 =?utf-8?B?bGNaTGNReHVYUXg4OW15YkxRQjlKR1VaUkxWWE9rWXJVVjRrT0pac1Q1SHJk?=
 =?utf-8?B?Q0JGbC9ra0hDV0tCYzNXSmR6OVVXVzZSYVd3WFR6QW5tdmcvNXdIZTNOT2xn?=
 =?utf-8?B?Mm4wTUtpVjMzOE16WlhYSU5qRFlYSVczN3VZNWNaZDRLWjE3NElnQjlBVUNT?=
 =?utf-8?B?S1cyemJtQktzS3lXTHpNMG9Sc3NTVVk0QnVoY3U3Q2cwMDdCSmZxTXdnbERo?=
 =?utf-8?B?c1NXaHEvR0FNQkdud2lrY2RBUEQ3ZVVoQ3B0OHRHV3JYWWduU1Bqbi9vOU05?=
 =?utf-8?B?bTFNRzA4b0c3UENMTjFId1JQU1FLL09YT1JqT3lyTmFFd0M1Zmg5SjF4c3A4?=
 =?utf-8?B?bTdZbVlFQytWUElUU0d4N080Q2N5QmdTL0w2ZUx1RGZwbmF0M1FzcmJOdGU2?=
 =?utf-8?B?ZFNPUzlkYml4L05RZXNkdThYbXEvYmxZUDYxb1lQak5RRGRpWk1IZzRmYkNz?=
 =?utf-8?B?V3BQRk1icXp2RktNWWFhZ2VqTUo4T25IRVNrOUc5bjdDMlNpU0lhTEZPVFpt?=
 =?utf-8?B?SEhFbHRwdnFrTkw4MUZOb1FqVVRVSFpCZkJiUW5OaTRTdTl6MzRoeXNtUTdK?=
 =?utf-8?B?dWo3dUdmWDFsUit6QmNmMWFyZ09HQnRzc2VlSG0vSkkzT0ZFWUp5VUVNblVx?=
 =?utf-8?Q?+t/hPRyqx8ewTDzvrOgx9BaNU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e19335-0d5a-46f5-d816-08dc8a4ccc07
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:29:22.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U9WT6/A1fEIAA//cYQKc6vMuRa+Lu0Zgh493tmFq5GpawhwGQYXkUsUCxZrgL0G2HQu1qIQoaegvDDxg27p7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277

On 6/11/2024 03:52, Perry Yuan wrote:
> Introduces an optimization to the AMD-Pstate driver by implementing
> a heterogeneous core topology for the initialization of the highest
> performance value while driver loading.
> There are two type cores designed including performance core and
> Efficiency Core.

I would say:

The two core types supported are "performance" and "efficiency".

> Each core type has different highest performance and frequency values
> configured by the platform.  The `amd_pstate` driver needs to identify
> the type of core to correctly set an appropriate highest perf value.
> 
> X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
> processor support heterogeneous core type by reading CPUID leaf
> Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
> driver will check EBX 30:28 bits to get the core type.
> 
> PDF p274
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

As Boris suggested in the other patch, this URL won't be stable if the 
CRM system changes again.

I'd use his suggestion of the title, document number and page instead.

> Signed-off-by: Perry Yuan <perry.yuan@amd.com>


I checked and it fails to apply at this patch at the moment to:

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=bleeding-edge

error: patch failed: arch/x86/include/asm/cpufeatures.h:470
error: arch/x86/include/asm/cpufeatures.h: patch does not apply
Patch failed at 0008 x86/cpufeatures: Add feature bits for AMD 
heterogeneous processor

Is it dependent upon refs in x86-tip?

> ---
>   arch/x86/include/asm/processor.h |  2 +
>   arch/x86/kernel/cpu/amd.c        | 19 +++++++++
>   drivers/cpufreq/amd-pstate.c     | 67 ++++++++++++++++++++++++--------
>   3 files changed, 72 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cb4f6c513c48..223aa58e2d5c 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -694,10 +694,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>   extern u32 amd_get_highest_perf(void);
>   extern void amd_clear_divider(void);
>   extern void amd_check_microcode(void);
> +extern int amd_get_this_core_type(void);
>   #else
>   static inline u32 amd_get_highest_perf(void)		{ return 0; }
>   static inline void amd_clear_divider(void)		{ }
>   static inline void amd_check_microcode(void)		{ }
> +static inline int amd_get_this_core_type(void)		{ return -1; }
>   #endif
>   
>   extern unsigned long arch_align_stack(unsigned long sp);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 44df3f11e731..62a4ef21ef79 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1231,3 +1231,22 @@ void noinstr amd_clear_divider(void)
>   		     :: "a" (0), "d" (0), "r" (1));
>   }
>   EXPORT_SYMBOL_GPL(amd_clear_divider);
> +
> +#define X86_CPU_TYPE_ID_SHIFT	28
> +
> +/**
> + * amd_get_this_core_type - Get the type of this heterogeneous CPU
> + *
> + * Returns the CPU type [31:28] (i.e., performance or efficient) of
> + * a CPU in the processor.
> + * If the processor has no core type support, returns -1.

Is there any reason to use -1 specifically?  It seems like it should be
CPU_CORE_TYPE_NO_HETERO_SUP.

> + */
> +
> +int amd_get_this_core_type(void)

Shouldn't the return be "enum amd_core_type"?

> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return -1;

return CPU_CORE_TYPE_NO_HETERO_SUP;

> +
> +	return cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_this_core_type);
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cb59de71b6ee..fa486dfaa7e8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -51,8 +51,9 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> -#define CPPC_HIGHEST_PERF_DEFAULT	166
> +#define CPPC_HIGHEST_PERF_EFFICIENT		132
> +#define CPPC_HIGHEST_PERF_PERFORMANCE		196

Why did you bump this to two tabs?  It can stay at one tab no?

> +#define CPPC_HIGHEST_PERF_DEFAULT		166
>   
>   #define AMD_CPPC_EPP_PERFORMANCE		0x00
>   #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> @@ -85,6 +86,14 @@ struct quirk_entry {
>   	u32 lowest_freq;
>   };
>   
> +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
> +enum amd_core_type {
> +	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
> +	CPU_CORE_TYPE_PERFORMANCE = 0,
> +	CPU_CORE_TYPE_EFFICIENCY = 1,
> +	CPU_CORE_TYPE_UNDEFINED = 2,
> +};
> +
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
>    * with community together.
> @@ -359,9 +368,27 @@ static inline int amd_pstate_enable(bool enable)
>   	return static_call(amd_pstate_enable)(enable);
>   }
>   
> +static void get_this_core_type(void *data)
> +{
> +	int *cpu_type = data;
> +
> +	*cpu_type = amd_get_this_core_type();
> +}
> +
> +static int amd_pstate_get_cpu_type(int cpu)

Shouldn't the return be "enum amd_core_type"?

> +{
> +	int cpu_type = 0;

I think it's confusing to initialize this to CPU_CORE_TYPE_PERFORMANCE.
It should be either not initialized or initialized to 
CPU_CORE_TYPE_NO_HETERO_SUP.

> +
> +	smp_call_function_single(cpu, get_this_core_type, &cpu_type, 1);
> +
> +	return cpu_type;
> +}
> +
>   static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>   {
>   	struct cpuinfo_x86 *c = &cpu_data(0);
> +	u32 highest_perf;
> +	int core_type;
>   
>   	/*
>   	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> @@ -371,7 +398,26 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>   	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
>   		return CPPC_HIGHEST_PERF_PERFORMANCE;
>   
> -	return CPPC_HIGHEST_PERF_DEFAULT;
> +	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
> +	pr_debug("core_type %d found\n", core_type);
> +
> +	switch (core_type) {
> +	case CPU_CORE_TYPE_NO_HETERO_SUP:
> +		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		break;
> +	case CPU_CORE_TYPE_PERFORMANCE:
> +		highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;
> +		break;
> +	case CPU_CORE_TYPE_EFFICIENCY:
> +		highest_perf = CPPC_HIGHEST_PERF_EFFICIENT;
> +		break;
> +	default:
> +		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		WARN_ONCE(true, "WARNING: Undefined core type found");
> +		break;
> +	}
> +
> +    return highest_perf;
>   }
>   
>   static int pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -384,15 +430,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	/* For platforms that do not support the preferred core feature, the
> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> -	 * the default max perf.
> -	 */
> -	if (cpudata->hw_prefcore)
> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
> -	else
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +	highest_perf = amd_pstate_highest_perf_set(cpudata);
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>   	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> @@ -413,10 +451,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	if (cpudata->hw_prefcore)
> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
> -	else
> -		highest_perf = cppc_perf.highest_perf;
> +	highest_perf = amd_pstate_highest_perf_set(cpudata);
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>   	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);



Return-Path: <linux-pm+bounces-43240-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPUyBjssoGmLfwQAu9opvQ
	(envelope-from <linux-pm+bounces-43240-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 12:19:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1D1A4F8B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 12:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07662304A063
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 11:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDC363C51;
	Thu, 26 Feb 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JxrpU8Bm"
X-Original-To: linux-pm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5A36402D;
	Thu, 26 Feb 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104670; cv=fail; b=DKPWT4cLWFZb0KO9aR0DJllXvQP4OM/Km4GCY/r8AWo0CYIfMVMzTNaS01qfO9ScCcyyzrjvCixrv1nACPIlsodmiZbdMARTuphBAfSnETspnzr5LOKrECQbNrmkXfbRtGAKJ3aqGOwEsGT9C0QMCI3IUk3c6dYdAzRvfRENJ9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104670; c=relaxed/simple;
	bh=BnKPs4psPwXlQ2/f8peKYxSVzJzmDxN1nBKY1Dh7TJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKlw+5SdDXvc86ZNTUHdh6qnMjAoft+N4UtD6F9KwsC07tNqN233XsIx/9AsTftG31H+eQHlAjJjOmKB04CWQFZnSyrkEHLJ+HvvnZcobNlH+gpNbnFYOWcO+nqHkZGgicW9i2qZZ54Hf8r95aH6n5foiLGfFvcEUO8UG/zO4TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JxrpU8Bm; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9NW2wd+bPVa9P2+EIkRm//gSDhmWeYaNHsPLCKf8nv7MiNiPsJbczajIkRAEeS9ISDS3zBolBKEzAQK5cPZL3CwNuPxkOwy1y+pcsIWQ2U+MWdTrKBLPzBQzwBQLHqtKSiLlSgwehwsa33drvl58hGoXyjjfbXjtu1B7rmoDIIuM8eqSoT4xMTIfiEoiyP6fia1Q2cMA641rlp1Jb1ikzFF2aKv11bVpaWkzgkukxDcEenVZMP8XJtCbu9oZS8XdvdXVBxrN/6fIHbvHJIiO5umahbN9KD4G6yF4q+NljRKtmZU7/B+h0SdvLKsUmYrFfcwAE62VJ3nitRMLIfjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btxr9o98t7DQxHYcx6DS5zP8h9rKlh5QB8sgAJtJJsk=;
 b=V/GMi8VqOvonwP107zNEdimfPZKSucOqwATKd+MEAxauW02rJ09gVnuM54UFr4WaZ6NHdeusKEHV6X806n6hXTcLaMSa6Z/1j8QiJ78C+AssDyhYX3C75K7wr95m/Vr2vh4k7NMWx+CSx1s+ZbQLRiLhC9VKycWKKoJbfgl6eW4n60RAw1UKr+rTw6sw1f5O4f3YsBU20i8AyHIx0gJUWrKF/AmHzAvt80H6fbPjiusS53+OlsX0jHqdh70uNm2kUHITsKYiWOosimc7ep9kccLfunShUyub8CCRAJ6pKVlJ2W4eijXT8i9jy1EFKX8SMVHrin/oVqIUbxWffjjXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btxr9o98t7DQxHYcx6DS5zP8h9rKlh5QB8sgAJtJJsk=;
 b=JxrpU8BmQ9H5A9a+5la38AvHV+SkBZ/Lu6HL2ZM94jMjbatHE6hV9BfoB5QFPScpipHumJRgpAsWeerkhSBacmyM3KqYHFf9Uc7mvde4XwRz2Iah1XlsFfSYEjzJzAkhA1wu+fDGr2GUj/xHtqpuLpnQkCP4Y7ZzVflNh8BVxiEo9ceqDznVyCMH4Mt+yyiDbtq9Jn1VdQG1VmjY+Rca4SAKimL+ifPEw0UcHoMVeZco4sCpYCMcTkynSsNKujuJUOcylaIpRe3NHrrArccYw1vQeBaosWQsiCtf7scg65Ai3c8ky76vUuSPT9GninX2i2A0ANY34mzJPqEP8i0ilw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 11:17:44 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%6]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 11:17:44 +0000
Message-ID: <f52750d7-cb23-4a10-bc87-67232524dd28@nvidia.com>
Date: Thu, 26 Feb 2026 16:47:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: topology: Fix false warning in
 counters_read_on_cpu() for same-CPU reads
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, catalin.marinas@arm.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, viresh.kumar@linaro.org,
 rafael@kernel.org, beata.michalska@arm.com, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260224092714.1242141-1-sumitg@nvidia.com>
 <86ecma9gb5.wl-maz@kernel.org>
 <bdd6a7bc-0b7d-405d-99a7-a11eebaf627a@nvidia.com>
 <aZ90u4HrDh1N7ylK@willie-the-truck>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aZ90u4HrDh1N7ylK@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: b125da84-f91c-491d-b470-08de7528a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	ZNcPJYl+JwwivDNj4MYyBgJje+aLiW4rUTEv2qd5jNRRjW3d33ppPOv5HVKX0/Ed3KJZ8FTVdg7x91B/DexwaXWnhtFC076ke1APQBHpZJZHe5bayJVNS+jdTOMQSuXCIVn0S0EEeSil2JPzIxxco62R6cNDyWROGXQ3nOyQ9mMpcakGJ/P4HQqZ7peJ9s9mInbjsmOwPoTaBb/BZys+Z/mBzXwTdjgosVIOa0GUUzypEnWhd8EgmWWfbT/glOKQNMTrC40kzFG4xuxA1XvCj4n/e572pM+ivT7Aq2+t6ehOL+JHhlJTBptBGwi8VoAThNH1Ad7Ya5ub6xPWKmksyQuHR8wG6Evt0YydCfxSKCcOiGYnK9s0Eb2tBWkoNhXfq3Zmi0ZBwurjLpCuwBTOI8S9hGjHZSWb0tekqjHmyDLZc3tf3zwd0r74tTmEJ8FhGY1QiN9VXWJwfqxOk+ylPIegaolLFVZioL16MHapMaV2ydOn3eMTMJWFg13sSoXnet5hkwqz9Z5yeYP7JlQalvpBtvl34RPRTl+94NPB3RS12PNKdSqx0iQzHPp5TpP/aUR1KlM9cUBu/ucTLTkX+kk7VvrdVaHQ0LyyPKO/BLYv30FdtONH+QjY/326zkiKiV8pUq0sA7PhB6ZlnVvTHqwPMpICDJMa2VsMwgO2YC6jrqOrd/LFnL+FtGKZCYTZh2xuWuCt4FwXRaMTBksXSVCkzQ6LyJ2d8PuO8AKBZfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk9mL1lCVmJkN0JkZFRoVy83UEx3WXdYMW1vNUpkV0dZanFxdnEzdjRzWC83?=
 =?utf-8?B?M2taQ0tiZ0VPSjUySnJmanpyZldqb3J6UW9LdnMrTWZveWxmakVWRGlhZGtG?=
 =?utf-8?B?cXhGaEh6V0VuV21yWDViVTR0b0Y1em8wVmova3VpbXBSMkZ2aE9NVytGb2FL?=
 =?utf-8?B?ZWsyWlpyWC9DY2JTVkVadE5WNlFwei8vdWlVRUFxeWszZnlZam1IZS9pNVdQ?=
 =?utf-8?B?c3l3SnBER0dlNEdFMU5EbkRjVVdzUzdIR1FVM09ZNzErbU5TOERwWm1MZHNX?=
 =?utf-8?B?YjFjdmdrVVBxMmZML2lyN28rMHlpZWlzT2hJYklwNWxUNm1ZRnVxMEd0TXpp?=
 =?utf-8?B?SU9NWGZVS2E3UzQySmlWek5FNnltbDVVemZtcEE3enhHeVhEWHNBd3ZZUzJM?=
 =?utf-8?B?T3hXREVleEpNZGlQc3dqb25NZVR2Q29ZQTlmRHZnQldPTnRFdHJIZlFlSVZj?=
 =?utf-8?B?MEduaGZjcCtlYjZOYlJpSHNkVkVLZXBObW5BdkZwRmpWVloyYTRPaXNXVzBa?=
 =?utf-8?B?VC9xWFhNNzBRK2R5Ymt2ZnE2Z1NyUXdsUEFkdFJjN1dUQVhpK0FPd0h4WGMy?=
 =?utf-8?B?Qys2NzZZVDFSL1hkQ0hkNUdvM0pvYjQrd3lvWlY1eWFLcm5tRTJUS05jVmV1?=
 =?utf-8?B?d0JwdjlkTjVrQlVqWUhrSHBmRlppVXFXT1RrNlU1UXZjandDRjBsNUR1emdt?=
 =?utf-8?B?ejlYU0xzU2RCQWk1aENxRGdTYWJhVmYxditRSjJCUC8rZ1RqQjNUcG1kLzFV?=
 =?utf-8?B?dUhnSzBINkVyRHFUN0thdkVNMGxhd0NFbVp5VUUyMURwazZrenI4QkZ0WXVz?=
 =?utf-8?B?RFM3SHUzeFgzaHpidEdoS09Sa0dMZzdpT1hPdFpVV3BFQWlYWHppbEdkRjZi?=
 =?utf-8?B?dWhRVEZPZk9pSWJrSUxGTGU5dWVqemFqakx6dkpJTWdZcXFROFloSzlQeUhR?=
 =?utf-8?B?cXpHUUprSFRPZGVTTFo0ZFJrbUxYQVNrUndIaW9OT0tRc3NXaDluak9pQUJM?=
 =?utf-8?B?NEhoeE0yTVkvdWFxMGdNeGpxRnhOdWo0TnVqSWNMT0pXeU04elJNeWFLdEc0?=
 =?utf-8?B?cEY3SGtYMWVObEY4VS9IWGdJNk9vQit1U3JCUEdjK3VQVWRqUjFWR0pMMksr?=
 =?utf-8?B?N05nc2Y2RFkxcExTcDc5bXBEektZeFJaTmtrall6Z1ZvWk1QR1JPTlMzSGs4?=
 =?utf-8?B?UE9vZDFUdzVkRTFKUW9iYjhRb29mZHN5R1lGZGNycm1PV2dTbS9RcjY4eXJS?=
 =?utf-8?B?NkhBd2l1eGxOY3VDKzNVL2xPcGZYQ0V2MW9rNWhKWUdLTUFCQ2ttd3Vyc3I3?=
 =?utf-8?B?RmJyM0VnVnE4a0k3aERQM3RPSDdCSmljYzR0cjZ3Z05ROHE1Q1RVc1BwYmp0?=
 =?utf-8?B?VE5tdTQrbVJHRzZrLzBMdjlRcG9WZEJTdVFlbzBoMHVpRGFrck96NE40UUZq?=
 =?utf-8?B?TEU5alFRVmJZQXdydjN4N3pVMzIrdDZvOTV5YUxHb1dmKzJtV2s5bGhJZitx?=
 =?utf-8?B?ZFV5Wkh5ckRNWHR0RGZienFlL21maU03Mytob3dsbm45dUZTajhhQTRaRUxv?=
 =?utf-8?B?MnlnS1lDb3lnL2RBSUt3bThrZEN3TExlSExYTzlYZ2xSOWZpYTFSV04zalRE?=
 =?utf-8?B?ckNmdENCc1A2SDQxN0NZUk5qaXBadGduZHhuWkltNEdEQWo1NGVmQmZjZXJa?=
 =?utf-8?B?dDVsRTN4U2dsWWh6Q2ZXYlZjNDlqemU0dFRKOHhFVW5iSks3UW0xSUc0Qkpy?=
 =?utf-8?B?eFB5U21WOEhOMmUzZVBnZnZTMGpjMUM3cG1ib3VTU2t4aEoyeXJUM0lWODRw?=
 =?utf-8?B?UGdYOEsyendtbXpzS0NUSEEvTW5Cc3dCc05EYkM4QTR4RlU1bVdhK29ETnU5?=
 =?utf-8?B?NFIxdTlzQS83aUdHZyt2djNYb29wZFpwNitZazc1N0E2Z3dYanBhUHIrZUg4?=
 =?utf-8?B?VnI4Y3kyclcwS3ljWVpmOEpjRTR4QnBzMHNIcEEwcjhHUThIR09IS3NLNGdi?=
 =?utf-8?B?bFI3Zm9SVTE3QVAwcXJPTm5DTTdnTmd5T2tLQWM4UU9XL0dhYXJuVnlUT05x?=
 =?utf-8?B?QXd5dTFMcnU1c056Y1hwR2hZL1V4WFVDQTl3aFp3T0xKT2l3b0ZkdmtrRXY2?=
 =?utf-8?B?WGpmaUFFN0tXc3ZrL1IwaGtGQWJpcE9UcktzWjRWMUFSdnptUER1QU56c0dO?=
 =?utf-8?B?QVpCM0NOV1Nld0hJNU1uaSt3SGtwQ0RPTkdyQWZGVXFJTmxpZXUvTVE5Ui9I?=
 =?utf-8?B?YTJQODU2NlNBUjVXVDVKend5Z1RqQ2JiUE1HdzJzaFFLNmRIem96MWZ2QmVm?=
 =?utf-8?B?aUp4NFNYcTZQT0E0VnNYOGtPODljMHE0KzRXdzFpdzJGcVBKL203dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b125da84-f91c-491d-b470-08de7528a96b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:17:43.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7NFL8kERkrtdzlC0tJ8oRZ4ygmlp9ZhljmR8sCR0v+gQ2msUNtkTFs1hJBrEylqqwNoWweGctzuhwwqmarT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43240-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 35A1D1A4F8B
X-Rspamd-Action: no action

Hi Will,


On 26/02/26 03:46, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Feb 25, 2026 at 05:08:03PM +0530, Sumit Gupta wrote:
>> On 24/02/26 23:25, Marc Zyngier wrote:
>>> But I'm more concerned by the overall pattern of doing these things in
>>> random contexts. Going back to the original patch (997c021abc6e) that
>>> states:
>>>
>>> "However, this deferred update mechanism is unnecessary and introduces extra
>>>    overhead for non-PCC register spaces (e.g. System Memory or FFH), where
>>>    accessing the regs won't sleep and can be safely performed from the tick
>>>    context."
>>>
>>> Clearly, the AMU registers cannot be arbitrarily accessed without
>>> blocking when accessed from one CPU to another, so either this
>>> function is never called in a cross-cpu context (and the warning
>>> should be removed), or the premises of this change are wrong.
>>>
>>> Which one is it?
>> The function is also called in cross-CPU contexts, but only from
>> process context (get_rate, sysfs show) with IRQs enabled and
>> calling smp_call_function_single() is safe. In the tick path,
>> cppc_scale_freq_tick() uses per_cpu(cppc_freq_inv, smp_processor_id()).
>> So we always read the current CPU's counters and no cross-CPU access.
>>
>> The premise of 997c021abc6e applies to same-CPU accesses only:
>> Reading the local CPU's AMU regs does not sleep and is safe from
>> tick context.
>> The irqs_disabled() WARN is still needed to guard against unsafe
>> cross-CPU calls. This also returns '-EPERM' unlike the WARN inside
>> smp_call_function_single(). So we fail instead of risking deadlock.
> Hmm, so why isn't this structured such as:
>
>          if (irqs_disabled()) {
>                  /* XXX: Explain the tick case */
>                  if (WARN_ON_ONCE(cpu != smp_processor_id()))
>                          return -EPERM;
>                  func(val);
>          } else {
>                  smp_call_function_single(cpu, func, val, 1);
>          }
>
>          return 0;
>
> That way, the irqs-enabled case remains the same and doesn't need to
> mess with preemption.
>
> Will

I will do the change in v3 as suggested.


Thankyou
Sumit Gupta




Return-Path: <linux-pm+bounces-23668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECAA5784D
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 05:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FFD188E6C0
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 04:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171CA2E822;
	Sat,  8 Mar 2025 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fa1zSCOC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82431537DA;
	Sat,  8 Mar 2025 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741408232; cv=fail; b=V08QhjlXjISAXn3NEHkT0JuL6v4yliJhYS0O9zLQ5YOkiAUYN61EZmx/AWFtIrAQOaYMmuHeKkSkAd7mmcnsWr5ppqM88Twt140A36HWzG3o7Hlz7vZPZlubE0IiYUdua7CcO+FGrOpgEN7OkLD8dTWwmvm6UOz9PMVusdUXYoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741408232; c=relaxed/simple;
	bh=hXiNI1DQNXfIP1LbafEXOfHQJohbRpVWxsLTzYMHFjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYhUKIntV66huAk+QIL6gaAkkHPFfKj/a3Hn+Ma9A9bxoC4+tUiDGJTuiORwp7cqh2SWvmDVRPncN67dqL/sgWgqtN6ORv0T1bvCh+cDD+4YRrTyy8txGJwgSAzi2ksNbfqtazrAaNW2Dd6Ux5/6FdbW6KwYoygbmvKA3e747L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fa1zSCOC; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4wNfZFFMryXrr3ThHrznIFIaabLopsdlYG/AfbB+bdsqeKHrdaaFUUyM2puByvACrt1qqAL5xaTgpUhyBg++dRyFn7Wc3Y/ch7VHgTcQBT1WxTjQ58bRzKE1iJs5bYvCjSmFJUX17xaJvNz9pfLEYCkvl2wBsc02l/FmG9wBMvrt3wc68xcnY6idDED0fVdkDpytp/rTbv9oV27RfV6PmYhHhUz47qVNj9DcBt3++QlLDz7bayWcH38VgvFP+6ay6+qbpAt8ciwfFwrt7vsWWCjKgN7h2w+qkOSKalxk0r0uY4w4LfHttoM6t+HkktqbZj42ulBOZlThDd2MlJeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxYJmgzputB0iyH1rpgLTBXtG02lVPd6dYLuu4PRIwU=;
 b=gGppKXKxWP5q6szdEClYZZ7I59OkOzyY7FXH1eZknqQZekYuLbcrplPBEOTiZeAJ/5rHg1DuajkXDG0s9qQA+cyVV14U+P90gNG3RRayCbv9+umbWFrGZdlcFTdP422SkZB9gBj4/a3BxvxA3UqE05BTmXgBHuWHXa5oI+uVoEDl++9AimhPBq2nMNVpKlz9ZvyWv665De/U2EXCkz/+0MndfXMzigXDeUfVcMDhGDMQI1Qf/PEYng0Qehg3Tuo9vqc+DazabS1HLQtpnRg2Tg7dZEBvbkg+7uXwzBznlvo0d/erHves7dTaD5L8ZMGM5V3ZMGBBmbg/9HsrrciUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxYJmgzputB0iyH1rpgLTBXtG02lVPd6dYLuu4PRIwU=;
 b=fa1zSCOCxtTsBY8uKc3TFlexYEQzKHQoP6QU/ZcTXAs3qOMAt/u+xdJJP45SZQOrK90P43hCfWVGuwpuIceqfqCJMpy0dU+PgG4+EjV1ZOsF6bFUTrWj0mFaRxYc3BH8ouhr0RL+S8kfXba+0Q26Ix0bym46S9mcDuASz0/CJoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Sat, 8 Mar
 2025 04:30:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8511.017; Sat, 8 Mar 2025
 04:30:26 +0000
Message-ID: <f3849033-e883-4296-abb7-eb04e8c2a03c@amd.com>
Date: Fri, 7 Mar 2025 22:30:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-4-superm1@kernel.org>
 <Z8sdREywSKVb4xx7@BLRRASHENOY1.amd.com>
 <969ca809-c630-46e3-9bc2-6cf340bc66e3@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <969ca809-c630-46e3-9bc2-6cf340bc66e3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0129.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: f1134561-3cb7-4a19-48ad-08dd5df9f356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEpObTltSUtPQlZNZWZCZ2d1QjZDS1Fvd1JzMXZSS0dZTWY2ckpvZXM2WTd4?=
 =?utf-8?B?cy9WSUtDSWNMT1NpS1QwMGduanZaUit0Y1hDNUNYZTVTcURTN3ZZR29hVlZZ?=
 =?utf-8?B?V0ZBb3NnbWxSRFQ3QitJdHRDREszSnpzeVBQMWEzNC92V3ZVcTBXeWFPZVAx?=
 =?utf-8?B?RVlrU2RsWHk3YTRiVVZBRkJ1Y3JUM0NoMHR6b3JPeVM2akR2emN1SVZXTHJu?=
 =?utf-8?B?K3NQNDJhSVl4Y0ZpckVKZTY1aU9GRWtuTW9XTDZMRk42ODdCZUxweFB6Qkp0?=
 =?utf-8?B?YVRvMWxDek5CendyVlZid2pGWXhyV3JTVlRLM2d0ZUdtY1BwZmN1Znl6SktV?=
 =?utf-8?B?aUJiMUpHQ3FXVi9wMDdkOUl0UTlKelF2TEo5Y1BKaHNWQ0lMWkRxUVl0UFdW?=
 =?utf-8?B?UU03VVRLc0Z3dGo0SDZYNjVJRFBodFduMlZEY3Y4dVJweGZzZStzT0FJV1FX?=
 =?utf-8?B?U3NUdDc4UzV4OERQZk1DY1ZKckpwaXNnUmc5aWVScXdNbzcxYko5U2xNaTdp?=
 =?utf-8?B?MFFSZU5Kd3NoeXF3V3cxMFZ0cG1WQ2RnNnQrSERLaXRsNDdiSHJuRzkxUkU5?=
 =?utf-8?B?N05iLzU2c241MFFsUEFpLzFLZjZFYlNaM0tYOFlrU1BQVFVSY1dzUkQ0dklH?=
 =?utf-8?B?VUFUQ2VzamN0MWZ5N3Z2NlFHOTRwUmQrcWlRYTJSL0pSUjdJaE81OTRqVW0v?=
 =?utf-8?B?bEFPTjA4ZUxJaTMrZXJmSTlaN1g0VWZMSkZDZm9oamdVeE03dW9MQUdVM2hi?=
 =?utf-8?B?RUhOTjg3TzVhYlZXd29EVHFQK1lPQ2lXSXBUNUw3eXZnUkRxMWNUOHV4SUVt?=
 =?utf-8?B?cUN2YmRpWElUTjh6WitBWWJQRUVpak0wRGg2aHNZSmo3YXFaU0FxWTErZ3Yx?=
 =?utf-8?B?S0x5eWxIaGwzNjY0UUZWZi8zZ2JDYXVjbVRWTVgvQlh1ZXlSZVRSVjdHRkhw?=
 =?utf-8?B?YTYwUXJ0Vi9ERXdEUU5nUFZWVFNEWTd1eU1JOXhJWE1PYUZhY3I0WnFTNVlm?=
 =?utf-8?B?VWNDSEtDc1R2clBCT0lsRC91L1djaWpwQ1dkTURuMEErS3dvdnExS1lBL2Jt?=
 =?utf-8?B?bWptTjBiQ29FSkNxci93ejZrd2NBcVVpWUVocGg0TmQ1YmZrdXBZbnNDY1BC?=
 =?utf-8?B?ZWF2TnErak1Da3ExZnVRYlh3QWNjcjZkQWlKRFV5S0NMbTM0amtOeVAweWNB?=
 =?utf-8?B?TDVaTFFNTUJGQ2lDTDJyMmhSS3VhNi9DbTNFdGJUTlhVUTVwOVkvdXJ0UHFl?=
 =?utf-8?B?NmYwb1M5SFJWU2hEc3BLMFBpWVVSbEhiVHJ5cnczZTVPcEZDVU9QNlk3dEp1?=
 =?utf-8?B?UU5lU2YrV3g2SmltdEJ3R3ViR1VVOHNhN0VPMTd2MDVleEJabEt2cDhQTDRz?=
 =?utf-8?B?WUNxUm04WWd0aWFrTXVIMjNiQjNPcDZUMEUxNEFURVhxQjZNa2x0SkJDUG9J?=
 =?utf-8?B?UitEOUtzdDNYQ3NLNzcyNnlmanBwZnBSSkNxdXhETDNYNm5WTlhzZFBTMC9H?=
 =?utf-8?B?Y1B0cFRuTTlhU1AwODZGR2srRThyaHlNR1Y1TVg3TjBVZ3dsZ2dOU1lTYytE?=
 =?utf-8?B?YUtWd2NlbWgzVUVwRFJ1T29aTGNGaWdsUTFSazBFb3h5WE9YVWt4U1h2Wm5t?=
 =?utf-8?B?UTBmRW13YTYzM28yT210dE9zS1F4T2hwc2w2R1A4Lzc5RG1DMjh4TEJCZkF0?=
 =?utf-8?B?ZXU1OUNxKzkvaVNRSWQzZ253Q1pjRWlrdXlxWXF3dElKZTBUd29BbkkzQ09T?=
 =?utf-8?B?OUZNUHpUNk1LK2JDa0xnK1pRdmJhVUVIOUthdU5iWEJLQTEzSzhSL2N1ZE1v?=
 =?utf-8?B?OTR2aHExRGNFbjdPUnRkaW1vNUlLVmMybWFxVUp0RlVkOU5mSDVvMDRGNjVG?=
 =?utf-8?Q?Kt4cDge+zwRI6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVhV3FTbllTeGlUZWIzOElhUzVudnJJTnhRNnU5Y1Z3dDNrZ0FFWjVFbkR4?=
 =?utf-8?B?ZFp3YWY2bVlnYkxOc1RRVi82bjV6d25CdXZKNEtHSVNpelBQUHl5UXZwbjBP?=
 =?utf-8?B?dlluS1lYa2VqT01VZ2JJNHFLbWtJMSs2ZnJTOHQ3T0I1d3dJS1NFdkcvd0dQ?=
 =?utf-8?B?MWZmWjMzdUtDUVNwNjFVbW40amVHUGg4UDNQVW9BL3JydDRiUFpLNG51MHZI?=
 =?utf-8?B?QmszZDZhdHVWOURHVVU5QkdYTGlBOU5uWHJRN0t2TEFYTUx5RGtQR0Ftdmdn?=
 =?utf-8?B?d1lPWm5tNENOR2FYNlpzUE1WTm9jTUIweVpVaWxBazd4bXVWbE1lU2UyODdW?=
 =?utf-8?B?eEdnYkk2QjlOZTNUbFNQL2QvUm9yam9UN1hvdkZLQ051REtrM3hCWENzWjFa?=
 =?utf-8?B?Ykhtd01NYzBmUThDZVp0U0ttWjhycE9KQ2pqMFNieUNLNFFtRUxiTlJ0b0Y3?=
 =?utf-8?B?UG9OaDdIeWpTT29lQ3J0V2RxcjlVZVdwVERXOXEyQmZZVVZySEtWcmtEVFJo?=
 =?utf-8?B?TEU4QVhWd3doQWZwVGxoRXBiYVNmMVNYM25kRFlrU3VFangzMWlKSXQxa1hl?=
 =?utf-8?B?RWQ5R1ZXbytrVW9Xa2wrTjZ6dnZsWm9LNXFFMUlyK3ljTmtraFlkc0tKclRt?=
 =?utf-8?B?Y1luZUJ0SmtyWEZacFkxZTRRbWQ5eW9jYUdGbWZIOUMyN3lTenpjcHVFRk8x?=
 =?utf-8?B?SHdGL2duLzFqUi9zalRISDVtdk0vSnVPUlNUckV6SjYvY01lM1dSQjQvbFc1?=
 =?utf-8?B?ajhrOEx4eS8wSE8yRVNoN0d0Rkk3RDF6UTdRMHNvam5Yd0hWUHcvNmlJdTlp?=
 =?utf-8?B?VVlLTndhQzI0OGFRTXM0T2xZa1VKa2xvTXhQNGg0VTZISUVlTGlGcW1pSWp5?=
 =?utf-8?B?Sm91a1BQcWlqdXNaMS84RWJnc1N1Q2Y2ajlpTTdsbHIydG9TMlBsSWhQTXF5?=
 =?utf-8?B?U25Mb0xtTGVsMGVMSHlLWUNjWDdKRHZpSjljQlV1MWNld0hSelZlMUVLUm83?=
 =?utf-8?B?d2NweCtlTkVUMFZPdm12ZWt2TnZicmJMdW1jZE9od1dvcnB3ZG1nZXB4MFdy?=
 =?utf-8?B?SThEYzV3d0Y2WEMwRldOeFUvKzF3UzNSUCs4MUY5elRubzRvZjNUL3NaSk1t?=
 =?utf-8?B?WmV3cFlaSWFRYkVCNjBxdWw4dDBWQ2FuT2pCVmprTjJTVWltQmV6dU44MjY3?=
 =?utf-8?B?cW0waVI4aklldko5SThmdHh0bUxLTUhXbkt2Mk4yQUVSdE5JcERkREtkOWYx?=
 =?utf-8?B?MlVEM2F1bEMzUFZMb2Q1S2NzZmMxSHJxSnhSTXh5M29yb1J3QzU0Y0NDVU91?=
 =?utf-8?B?RWtqckhDUExoekRodHIwMmY5QVk3K3RueWZmZDZ1d3hvR0ZYVVpUNzd3YllG?=
 =?utf-8?B?eEE3aFY1cHFVMjgxMEg1ZW5YWWFaWjJsbGhkWTJGc2JKTXUyTmRNTEV1M0xk?=
 =?utf-8?B?eEV4Q2NiZGNSVXBVbkU3N2pRbEVGYkRqK1M2WURiSFJoUVVKT3EzZU9seGRC?=
 =?utf-8?B?ZnpiTjFzcWRGYlo4M0Vpb2hXWE43Q0N2TTkrN2pyUTJURWhKSHFiMnRUTHNV?=
 =?utf-8?B?VG14My9qSjlXeEpPYnQ1dTJFYlkza2NKUWltTmwySWpoWmQyNUFJek96aWVQ?=
 =?utf-8?B?QTRKTDBZakd4cGFreVVWOEVMUFpiQ1dSR1hNaVNKTFg4bHN5S0JmTkVicFRF?=
 =?utf-8?B?aHlMV3ZsVHg0bmhQa0hwQmQ4TGM0STh5TU1pRkR3TEV0QVhVa09NZzgvU3pa?=
 =?utf-8?B?WEdpVFIyVExKcHl5Y1ZSVEc3REpnK3VONC9BRlp1Q1hyWkFJTDc3V0VnT0JK?=
 =?utf-8?B?MnduK1ZKaE5TYktKSEJEUG9xQXZMY3BpV0tPVVJpNi9sRE53dnUzY011b2R6?=
 =?utf-8?B?eTB3R2w0OE0rZ3NDTWlDTXNBWTFrUGRQSW5EYVQ4Z3BZWlB3bFNiNFNGVXZW?=
 =?utf-8?B?cEtBakpTUW1wTmZVZDNFakI1cnppN2h5b0RkOHY3ZGtFSFY3RjVhL2xxMDVh?=
 =?utf-8?B?eDU2U0xXUnJmeVVHaWdOUi9WL3J5Qks0d1NtMXRPdTNHMmZhSXdjajRHa2Rm?=
 =?utf-8?B?U2FFaTRrSUNZellSOWtONWhVdnlMQVdNcUdaNGlZSmRYQlJManREUTNyUHVl?=
 =?utf-8?Q?NlieFyRcIS/lHCJrNW1g0VItm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1134561-3cb7-4a19-48ad-08dd5df9f356
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 04:30:26.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf1XcaH8MAeXnVDDp6eorB/EB6l3yxnOReMWTej6sIhapEbAb6+IbAZQRUBjYxNGyeQRH+5IJkiZvrqaAtGuGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

On 3/7/2025 10:55, Mario Limonciello wrote:
> On 3/7/2025 10:22, Gautham R. Shenoy wrote:
>> On Tue, Mar 04, 2025 at 09:23:25AM -0600, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> The platform profile core allows multiple drivers and devices to
>>> register platform profile support.
>>>
>>> When the legacy platform profile interface is used all drivers will
>>> adjust the platform profile as well.
>>>
>>> Add support for registering every CPU with the platform profile handler
>>> when dynamic EPP is enabled.
>>>
>>> The end result will be that changing the platform profile will modify
>>> EPP accordingly.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>>>   drivers/cpufreq/Kconfig.x86                 |   1 +
>>>   drivers/cpufreq/amd-pstate.c                | 142 +++++++++++++++++---
>>>   drivers/cpufreq/amd-pstate.h                |  10 ++
>>>   4 files changed, 140 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/ 
>>> Documentation/admin-guide/pm/amd-pstate.rst
>>> index 8424e7119dd7e..36950fb6568c0 100644
>>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>>> @@ -321,7 +321,9 @@ Whether this behavior is enabled by default with 
>>> the kernel config option
>>>   at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/ 
>>> policyX/dynamic_epp``.
>>>   When set to enabled, the driver will select a different energy 
>>> performance
>>> -profile when the machine is running on battery or AC power.
>>> +profile when the machine is running on battery or AC power. The 
>>> driver will
>>> +also register with the platform profile handler to receive 
>>> notifications of
>>> +user desired power state and react to those.
>>>   When set to disabled, the driver will not change the energy 
>>> performance profile
>>>   based on the power source and will not react to user desired power 
>>> state.
>>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
>>> index c5ef92634ddf4..905eab998b836 100644
>>> --- a/drivers/cpufreq/Kconfig.x86
>>> +++ b/drivers/cpufreq/Kconfig.x86
>>> @@ -40,6 +40,7 @@ config X86_AMD_PSTATE
>>>       select ACPI_PROCESSOR
>>>       select ACPI_CPPC_LIB if X86_64
>>>       select CPU_FREQ_GOV_SCHEDUTIL if SMP
>>> +    select ACPI_PLATFORM_PROFILE
>>>       help
>>>         This driver adds a CPUFreq driver which utilizes a fine grain
>>>         processor performance frequency control range instead of legacy
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 9911808fe0bcf..28c02edf6e40b 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -105,6 +105,7 @@ static struct quirk_entry *quirks;
>>>    *    2        balance_performance
>>>    *    3        balance_power
>>>    *    4        power
>>> + *    5        custom (for raw EPP values)
>>>    */
>>>   enum energy_perf_value_index {
>>>       EPP_INDEX_DEFAULT = 0,
>>> @@ -112,6 +113,7 @@ enum energy_perf_value_index {
>>>       EPP_INDEX_BALANCE_PERFORMANCE,
>>>       EPP_INDEX_BALANCE_POWERSAVE,
>>>       EPP_INDEX_POWERSAVE,
>>> +    EPP_INDEX_CUSTOM,
>>>   };
>>>   static const char * const energy_perf_strings[] = {
>>> @@ -120,6 +122,7 @@ static const char * const energy_perf_strings[] = {
>>>       [EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>>>       [EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>>>       [EPP_INDEX_POWERSAVE] = "power",
>>> +    [EPP_INDEX_CUSTOM] = "custom",
>>>       NULL
>>>   };
>>> @@ -1073,6 +1076,10 @@ static int 
>>> amd_pstate_power_supply_notifier(struct notifier_block *nb,
>>>       if (event != PSY_EVENT_PROP_CHANGED)
>>>           return NOTIFY_OK;
>>> +    /* dynamic actions are only applied while platform profile is in 
>>> balanced */
>>> +    if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
>>> +        return 0;
>>> +
>>>       epp = amd_pstate_get_balanced_epp(policy);
>>>       ret = amd_pstate_set_epp(policy, epp);
>>> @@ -1081,14 +1088,84 @@ static int 
>>> amd_pstate_power_supply_notifier(struct notifier_block *nb,
>>>       return NOTIFY_OK;
>>>   }
>>> -static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>>> +
>>> +static int amd_pstate_profile_probe(void *drvdata, unsigned long 
>>> *choices)
>>> +{
>>> +    set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +    set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +    set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int amd_pstate_profile_get(struct device *dev,
>>> +                  enum platform_profile_option *profile)
>>> +{
>>> +    struct amd_cpudata *cpudata = dev_get_drvdata(dev);
>>> +
>>> +    *profile = cpudata->current_profile;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int amd_pstate_profile_set(struct device *dev,
>>> +                  enum platform_profile_option profile)
>>> +{
>>> +    struct amd_cpudata *cpudata = dev_get_drvdata(dev);
>>> +    struct cpufreq_policy *policy __free(put_cpufreq_policy) = 
>>> cpufreq_cpu_get(cpudata->cpu);
>>> +    int ret;
>>> +
>>> +    switch (profile) {
>>> +    case PLATFORM_PROFILE_LOW_POWER:
>>> +        if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
>>> +            cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
>>
>> So prior to the patch, cpudata->policy is supposed to mirror
>> policy->policy.  With this patch, this assumption is no longer
>> true. So it is possible for the user to again override the choice of
>> EPP set via platform profile by changing the cpufreq governor ?
>>
>> Is this the expected behaviour?
>>
>> The bigger concern is, if the governor was previously "performance"
>> and then the platform profile requested "low power", "cat
>> /sys/devices/system/cpu/cpuX/cpufreq/scaling_governor" would still
>> show "performance", which is inconsistent with the behaviour.
>>
>>
> 
> This ties back to the previous patches for dynamic EPP.  My expectation 
> was that when dynamic EPP is enabled that users can't manually set the 
> EPP anymore (it will return -EBUSY) and likewise turning on dynamic EPP
> should keep the governor as powersave.
> 
> I'll double check all those are properly enforced; but that's at least 
> the intent.

FWIW - I double checked and confirmed that this is working as intended.
* I couldn't change from powersave to performance when dynamic_epp was 
enabled (-EBUSY)
* I couldn't change energy_performance_preference when dynamic_epp was 
enabled (-EBUSY)

> 
> IMO this "should" all work because turning on Dynamic EPP sysfs file 
> forces the driver to go through a state transition that it will tear 
> everything down and back up.  The policy will come back up in 
> "powersave" even if it was previously in "performance" when the dynamic 
> EPP sysfs file was turned on.
> 
> Longer term; I also envision the scheduler influencing EPP values when 
> dynamic_epp is turned on.  The "platform profile" would be an "input" to 
> that decision making process (maybe giving a weighting?), not the only 
> lever.
> 
> I haven't given any serious look at how to do this with the scheduler, I 
> wanted to lay the foundation first being dynamic EPP and raw EPP.
> 
> So even if dynamic_epp isn't interesting "right now" for server because 
> the focus is around behavior for AC/DC, don't write it off just yet.



Return-Path: <linux-pm+bounces-11292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC993938B3B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7533F1F2182C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C98161B43;
	Mon, 22 Jul 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="iMpycTI6"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2082.outbound.protection.outlook.com [40.107.215.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A770182BD;
	Mon, 22 Jul 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636827; cv=fail; b=rCsNJCT0IpQlrHUdshchrYyvkPJnx830UFfbil7eob94TMlwoKS3k6Ptvn/VKvn3wGsvSaTNfJVYJ+uudd5O36OzClDAGqLJ4Krai04hIqFkrxZLOQc40dAmzD9wyErMmIlyAki5S08Xl4Q9tubclXVx6IlSfQClZ+gkYoqk4Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636827; c=relaxed/simple;
	bh=+8hqQTUdnW0+VeQyRtRiloraMd8X1icguoQw+tzhpKg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDbkRPQUkbDnROzlh8p2BtvYGpRfxlj/kzI01llyFIuSpMwne5G0p/PX7qRjXX2XRjfgeX9+I+VfkshTogJr1hb0lXibAgDNKS5VPxgw2J9HWCFJRxx1v2RrrYqMsCGn4YSRSC7TY91q64VU6MNP4R4tAo1xdm7/b4AjIw0fFvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=iMpycTI6; arc=fail smtp.client-ip=40.107.215.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRhabF3b10Ml+N7DlF/DBL52phI7wq5e+R5T3wGRhr1Ru/MD9jA8Ei459qVBSrGSjZhYt+K2TgLKpOvMPUzfLHM9KYkPTM1MpHzgnYpLa24zVGywIobRXRQarf/O5rVKxFL6kexaER8gKkqRp1CgHPnc/EHjbhNUf05BjKuDmOUOG6b1L+m6WcBXMLTyACuLOutbEubDO60f+KAFr+tnoqk0onCsVU0hfEhnuI4i11pdbJMHc2RdjYQigY4h5f6Z81gyLcDGKElE9tgm4u5XR7+sGnok5+sHEgOUaRZ4REP/VdYCgHEnvMN+XhXaSMrWOXZe6BsuCc/QWk98mciJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfnrcfN968K5NEVDFg5gs7r/zJYbOxpFFZN/rkKpkP4=;
 b=IzcV+RVoaORIytn/Sg2KxBowh7woEfax2hkhIhoIPshS7UI13wnYrjfNLKwb8x/GBqhzHOQ9QNZhJLT8KxbvPj+ifD51Vmiqj8s3aE8AIB3UTwrMB5TYkrtwCxlpCE3zXh3Nd4xXZYrgIijqumOYKy3m/Pg006Lwl5fQhQQUefZZa7ktJzouARbVMR8Ng4R6ZJIFMNhFyBtpIft/4tZKlKi9jemjwtAcr7Ybj5/OWnzRADaiwUcY/l3JLCg40/j6bBdeEV9UQBT2zO85Xg/G0Gf2Y7gmT7NqdZ0+60zhNlPRlpyrqpPcKshw8LeTWIWGN40D1nxEDchkamvMsHZZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfnrcfN968K5NEVDFg5gs7r/zJYbOxpFFZN/rkKpkP4=;
 b=iMpycTI6yyaBUFF23DlH/UfmafriK/K5CK5ZTd8Th00+hXG4xOmFjzspi3lcP9Aaoo5NiXr22+kIIihn3A9mhx02HKVT7DxYwqxUvQ7aYiWehaXfgD+OAeXjV/HyC855NARRTpoxgLsva/dyJRh8GzfLRpBjmipCttAqHpGuKDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by SEYPR02MB7460.apcprd02.prod.outlook.com (2603:1096:101:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 08:27:01 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 08:27:01 +0000
Message-ID: <6c643297-fe13-42c9-820c-2f95db5a63b9@oppo.com>
Date: Mon, 22 Jul 2024 16:26:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: queue policy->update work to rt thread to reduce
 its schedule latency
From: Gaowei Pu <pugaowei@oppo.com>
To: Tim Chen <tim.c.chen@linux.intel.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240717063321.629-1-pugaowei@oppo.com>
 <b07c39fab5ac0e32e7768ed3e8a799c8eb68802a.camel@linux.intel.com>
 <06ce2143-cc74-41e5-b39f-15053133b232@oppo.com>
In-Reply-To: <06ce2143-cc74-41e5-b39f-15053133b232@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|SEYPR02MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd1f046-f188-4ab8-6bcf-08dcaa280f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEljUTFRVXNGRjFCcGZIQi91YURxaFNITWRuTmFLL3lvRTFGWnBwZmx5YXdZ?=
 =?utf-8?B?Szl4aG51bUlYTWo3TnI3dFcxY1JrT1FQSE1GT1hUbENrN2Y4ZG50T3RwOCth?=
 =?utf-8?B?NCtZS2oyVzk2VUhkMDEvYnNYRzBvRENzbVcrQ3lnbUZncFA5UENRYVp5alhR?=
 =?utf-8?B?Q3FINTZzcGxERG1YYVM1cGZYZ0F3SHZRQjNRU1VkR2tTMFdLamtGeC9OZUJM?=
 =?utf-8?B?b2p5bUFGWElJMlFsKzU1OVZ2Mkh4TzVrV0JDNDljOVJxT1JmTnpyaHZYQitR?=
 =?utf-8?B?dzZlalAzT2FXVjhmcWI2a0RQalk3b2NSL3hEMmpCZHZBRkd0QVhjQlB4WG5K?=
 =?utf-8?B?UkljdWxGNU9zL3h2WlFHcVhoRSs0U1MxRmF0NXppclhIZFU5dEpyZ2dFZFNz?=
 =?utf-8?B?VVZtRXl0NXgwNEQzWEphQVhwZWhUMVgwc3lyU3NUK0hwN1VSWWt0c0gyQTR3?=
 =?utf-8?B?T3ZZL24xVlRFRmIzMHgvQ2Y0WFNza2s2eVFZOWFhMkp6dC9mOWhuQlVUelFr?=
 =?utf-8?B?N2h2R08yRnRwVjRmZk9ZNmpMV3VYRnpacjVHdXFMZnU3UWo4ZnZYYU1mTEp4?=
 =?utf-8?B?QVhocGZwckdIeGtuU01jVlRwSVdvUWJTdi80QWttbGJBUE1ORXlSaDdLOG5F?=
 =?utf-8?B?US9sZkNIVzMzY1pmSHBBTkp3N05SUFVEVVVaQzFkQUNrUGI3aHM1RmlrRVE2?=
 =?utf-8?B?eWZ5N3hKamlSOVdZNXdVZTJFT1pjMldUdE5YRW5rWUJCTzlhMmJTYXFhYkk3?=
 =?utf-8?B?R2ZSUmpNcFlxYVUwRXl5NmJEUW1rSXdoUVBSdTd6UzZjWGNtdlN6K0dRQ000?=
 =?utf-8?B?UTNjNVZOTUZiZlRwYW1RZm5xQklGTVJRN29tQS96enBtVHVMV1lmcEpSS0dp?=
 =?utf-8?B?czcwRjBnOGMzQW9VR1FtMVBCcU5FV3RIN0JiOWZITTdKTmpuQUZqQk5DbTB5?=
 =?utf-8?B?WFdzVmhIQkpucm1nNnIwVXlBeUF6azNUTEtZWVVUMkxJemxxc1RNV2phV0lw?=
 =?utf-8?B?c2VVYXlMWTdzaGdPcGVoY3lLWE9hQmorVUYwSTh5NTAyakkwaXhXZk9xL2Fp?=
 =?utf-8?B?Z0FncVNqS0pWZzd1bHVDRElwRkx3M2V5ajFocFFVd2NXRVUzc2RudkhwdVJV?=
 =?utf-8?B?U3ZrTHBjNEJ0TWhEdVFYWjF4bzBEd1BlSjdEallmSVlJcU9xdE5QMmcvNDFL?=
 =?utf-8?B?S2hscmQ1d01XVFBzVlJheDlqZmRpYzNuVk9mNGtVbS9meFFLTXBIckNuUlow?=
 =?utf-8?B?V1YwVUo2cGFlaXJIS3pEMTVPUlkxKzNFYnlTVGxXSElFTWhMT2twbGU3bERq?=
 =?utf-8?B?Q2krdHMyRDVPaWNia1pPTkpRUUkya0Nrd24zazhkaHAySjAvU1l2T1A3QkJI?=
 =?utf-8?B?SGtyNnA2NlBmNkJ5QXpreXpjZzMwb215anRKRm5YbkFHWTI2S3N4QWNsalBZ?=
 =?utf-8?B?cTFNUDFydFlJaFFDSUl1RTVQS0FHdk0wR1N6TG52MHBBWXBzZnArcXA3bmJw?=
 =?utf-8?B?ekFRUGNTZ3FTbXc1aVQxaTU0d08yck5QNnladXpYVDdsMUhxWS9ZZ2hKaEg0?=
 =?utf-8?B?NFlrclR4UXRQMStHeTNSbW1HNzBQc2V3c2dreWJITXlTRGpjYjNjQ2E3MzBG?=
 =?utf-8?B?N25FK0JJdDlMOHVLMVhnQ2lpRHdOMEFwYlFlQTRMeGRXYy8rakd1cmY0M3J6?=
 =?utf-8?B?Vk1XUW1WQk9CYVdxdy96VE1oRkNyRmJORWVuT205dVNFTVQ4eUNRVGJXRll2?=
 =?utf-8?B?aXovcUw5T0NDZFV3Vm9JVG1tZXlLZzJYb3A2aUI1RWZsZWFRVlYydXZJOTkw?=
 =?utf-8?B?ckVoaHFjRlRBMWxBVXlmUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3pBSEdUUG1KS3ZRYkllN2lsaUJndmY1OFFjY0dtSkdMMG9yRzRoYS9JaC92?=
 =?utf-8?B?VDBwSlZySGFXNlNaT3M0THZULzNlRElvQ01JUUlNYy8xTm9YYlNPVnVESEYx?=
 =?utf-8?B?QzE3ekgyZDN6ZjJHWVNrcG1DZUpSWS83TWhGaU1wTnVKd25sZmxlQ2VtTWdS?=
 =?utf-8?B?eXllbGY5elZZMlVFL3I5YXhzL2VCU2N3Wmt0NWw1T2NlRERlL3Z6WXdjVmx2?=
 =?utf-8?B?QVlYYmhpenRKU0FTbXErcTFsS3pHNlZqUW56R3Y3K3JiM3lHRWtGRURaR1o0?=
 =?utf-8?B?czBBclY2Q042KzY5Z21rWEhFZlR5SWJNZ2kzUXdSZ1VCZmtjYmFpYm5sTG1z?=
 =?utf-8?B?Q0MrVzR0SXR6UDkyd0E0RjdWLzhFOURBZWw3eUJXWC9zQjB3RnZRMXh1eFBV?=
 =?utf-8?B?ZmZxRXh5QTNhYitrczhSK3JnaENJamxNOTJveGdhdmhPQTcycG43eUhIak1n?=
 =?utf-8?B?UGRZejU0Zmhudm5pYUVLNkZmVmVhYjNQcFR6RTQ0Z2dnUmhXcEtSY3ZpM1BJ?=
 =?utf-8?B?RTRCODlkODFGOW5nS0JGWDRRenUzREQxdkdOcnZhSkpVaG8vNTljTDRBQWFX?=
 =?utf-8?B?UlUxQ0x6ckZpb3h1aVBDdGhCZVV3QTJuQ3h0d0Y0allnaW1ycjIzdk1NRUlm?=
 =?utf-8?B?aXpzTXZoMFRRRjR3TDcwU2hrUGhuZ1g3aGsxTmlzdlh3RVAxNzlhbVlsQ2Nt?=
 =?utf-8?B?NmR2WmlNZHUwMzRXSk0zUjM5M0hhYUxaS296cnhTQTl4eXprMGFmTGVZb25G?=
 =?utf-8?B?ZzA4ZTNsM2poRVpvREQ3SFRPYlRaV0haYjBMaUFSZ1JNK0ZXM2xDZkRzOUgv?=
 =?utf-8?B?aG9UVUNmRnBwd0Y4bC96QUQ2Q3JQMmJuaEVTMEJiS1pwOTFHbGtVMGI3NTRQ?=
 =?utf-8?B?RlFoNXhpakpIY2lleUpBUHR0M0RJRzRrMmlLeVdiTnZwekdiSGNlY2tMVXVD?=
 =?utf-8?B?a2svVUk5d2p2djhRQmc3eTMwVVRJQnljZStpaDJ0SGQ1TzJMUXNySmlVS2Rr?=
 =?utf-8?B?RGkyUmxrZWUxeGw2UVdtc0VDUjd5RGpjVHF4ejJvcGxkRHpxK1B2UURPQ2cx?=
 =?utf-8?B?WmM5dVVPTXp5eGk3VlVLTnZrWkJ2U1pHaVN6eklFbGNicmo2VjkwTzVBb1lC?=
 =?utf-8?B?YXplT0pIdWd2L3FUM2plZHRBT1ltUWtFdXAwV1RIRkg2VUE4ZWpIWUJKZ2R3?=
 =?utf-8?B?WlZNYXJYakY3aEoxS3VlQUFpSE1DcDdYRzZuRUVMZWtha3k1ZXo5VzEwUXFX?=
 =?utf-8?B?Q1lubVZkT3NpQWI4YnRRN245eXFHMG90Ujd6L21QL3BYOHdkdy9lVEV3K3pv?=
 =?utf-8?B?WFR1VnVhOTVDbHdKR2FHeGkxT3RCK1QyUHlST2pnM0lyRG93MzM5MHdmVUhY?=
 =?utf-8?B?bHYyZWI3cHNydGUvaTV0SDMvQUJzWWRuZmhURUNTN0hNMHZqRXR2MUw0MW10?=
 =?utf-8?B?bnFIYUdka3lmTzhuL3FlZ1UxTG02UEx0R2RidDBHMTc1cUFsNkVOcGUwM2g3?=
 =?utf-8?B?cTc0MU13WWVNV2lpdFlqNmk1UkxPMVgrMmFUaDAyak9uYzRtVmhvbDBwNTRt?=
 =?utf-8?B?TVR1SE9EcDVqb1JMeUNPRGJkME9NVDJzRmRPcnF0elZrRmlrenI4Nnd5S0F4?=
 =?utf-8?B?aWtyd2ErNEZsS0xleDlFRFV0enBmTEszZ3lacFN6aG9XT3FpZlBkZVMxRy9m?=
 =?utf-8?B?ZnVSMUQvRHlxMnE5WXpUVmE2S0xSeEhKNnJKbHJyd2RaMTNSbDBURmdJTW5k?=
 =?utf-8?B?VFI5OExBU0ZrZDBuZWpkcFA3THhuQThjOG9ZMXhoeU1BOG54Uy9RdktFVkt3?=
 =?utf-8?B?MXVYTS9makNyTmdRZWVjUGFzY2EyUFZFemV2aDEyanBWU0szeVNKeER4Z29N?=
 =?utf-8?B?ZzJaRUZKOEVwY3JaMzU3azFDdndZTkdQR29iZ0txRnc0YWNsR0pCb1RqVFRt?=
 =?utf-8?B?ZStFZ0FmdlhYMXQ4bG01N2lSb1d6SnRWVDJkWnJUaE0va1oxMGlESjJVZGxp?=
 =?utf-8?B?ZWlMNmtKdjcvalBHRFZGaUFhOVp0U2lDRWhLT3kxSzN5QWtWbHE4M2xKYWlQ?=
 =?utf-8?B?VU9HTjZTRnNhUW00RENpKzNGTVUzdEFTelRRcGVIbTFwcDY3SFZmcGh5dzRJ?=
 =?utf-8?Q?aHdf/7YHB1Ownp/P/uz4H8xw9?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1f046-f188-4ab8-6bcf-08dcaa280f09
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:27:01.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5IAt6yAL3N37spBu3c/p+4qRd8qOg0ZIydDZq/SLhG4LIm+cEeKo+FKhzXkF6MW/vzpPj1+YZicoZxU0E140w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7460



On 2024/7/22 10:30, Gaowei Pu wrote:
> Hi Tim,
> 
> On 2024/7/19 6:03, Tim Chen wrote:
>> On Wed, 2024-07-17 at 14:33 +0800, Gaowei Pu wrote:
>>> Currently we encountered a problem that the cpufreq boost latency
>>> is about 10 milliseconds or worse when we boost through cpufreq QOS request
>>> under high workload scenarios, while the boost latency mainly consumed by
>>> schedule latency of policy->update work.
>>
>> What is the tail latency now after your change?

sorry missed this.
the tail latency now is about within 50 microseconds after my change.

>>
>>>
>>> We should ensure the low schedule latency of cpu frequency limits work
>>> to meet performance and power demands. so queue the policy->update work
>>> to rt thread to reduce its schedule latency.
>>
>> If my understanding is correct, kthread has a default nice
>> value of 0 and is not a rt thread. 
>>
>> I think the gain you see is
>> your patch created a dedicated kthread work queue on CPU 0.
>> The work from policy change no longer have to compete time with other
>> requests coming from schedule_work(). 
> It's not just other requests coming from schedule_work(), also some normal
> cfs tasks running on the same cpu.
> 
> In order to not competing time with the above threads, i change the thread
> policy to rt and prio set to 98 to reduce the schedule latency.
>>
>> If the policy change really needs to get ahead
>> of other tasks, I think you need a dedicated
>> workqueue with alloc_workqueue() using WQ_HIGHPRI flag.

> I think the cpufreq boost or limit action should be trigger in time to meet
> performance and power demands. An dedicated workqueue with highpri will be
> better but maybe not good enough because cfs pick or preempt policy is not
> purely based on thread nice value. So i think the final solution is rt thread
> and the policy change work deserves it :)
> thanks.
>>
>> Tim
>>
>>>
>>> Signed-off-by: Gaowei Pu <pugaowei@oppo.com>
>>> ---
>>>  drivers/cpufreq/cpufreq.c | 24 ++++++++++++++++++------
>>>  include/linux/cpufreq.h   |  4 +++-
>>>  2 files changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index a45aac17c20f..e6e42a3ba9ab 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1193,7 +1193,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
>>>  }
>>>  EXPORT_SYMBOL(refresh_frequency_limits);
>>>  
>>> -static void handle_update(struct work_struct *work)
>>> +static void handle_update(struct kthread_work *work)
>>>  {
>>>  	struct cpufreq_policy *policy =
>>>  		container_of(work, struct cpufreq_policy, update);
>>> @@ -1209,7 +1209,7 @@ static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
>>>  {
>>>  	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
>>>  
>>> -	schedule_work(&policy->update);
>>> +	kthread_queue_work(policy->worker, &policy->update);
>>>  	return 0;
>>>  }
>>>  
>>> @@ -1218,7 +1218,7 @@ static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
>>>  {
>>>  	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
>>>  
>>> -	schedule_work(&policy->update);
>>> +	kthread_queue_work(policy->worker, &policy->update);
>>>  	return 0;
>>>  }
>>>  
>>> @@ -1301,15 +1301,25 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>>>  		goto err_min_qos_notifier;
>>>  	}
>>>  
>>> +	policy->worker = kthread_create_worker_on_cpu(cpu, 0, "policy_worker%d", cpu);
>>> +	if (IS_ERR(policy->worker)) {
>>> +		dev_err(dev, "Failed to create policy_worker%d\n", cpu);
>>> +		goto err_max_qos_notifier;
>>> +	}
>>> +
>>> +	sched_set_fifo_low(policy->worker->task);
>>>  	INIT_LIST_HEAD(&policy->policy_list);
>>>  	init_rwsem(&policy->rwsem);
>>>  	spin_lock_init(&policy->transition_lock);
>>>  	init_waitqueue_head(&policy->transition_wait);
>>> -	INIT_WORK(&policy->update, handle_update);
>>> +	kthread_init_work(&policy->update, handle_update);
>>>  
>>>  	policy->cpu = cpu;
>>>  	return policy;
>>>  
>>> +err_max_qos_notifier:
>>> +	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
>>> +				 &policy->nb_max);
>>>  err_min_qos_notifier:
>>>  	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
>>>  				 &policy->nb_min);
>>> @@ -1353,7 +1363,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>>  				 &policy->nb_min);
>>>  
>>>  	/* Cancel any pending policy->update work before freeing the policy. */
>>> -	cancel_work_sync(&policy->update);
>>> +	kthread_cancel_work_sync(&policy->update);
>>> +	if (policy->worker)
>>> +		kthread_destroy_worker(policy->worker);
>>>  
>>>  	if (policy->max_freq_req) {
>>>  		/*
>>> @@ -1802,7 +1814,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>>  
>>>  		cpufreq_out_of_sync(policy, new_freq);
>>>  		if (update)
>>> -			schedule_work(&policy->update);
>>> +			kthread_queue_work(policy->worker, &policy->update);
>>>  	}
>>>  
>>>  	return new_freq;
>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>>> index 20f7e98ee8af..73029daddfc5 100644
>>> --- a/include/linux/cpufreq.h
>>> +++ b/include/linux/cpufreq.h
>>> @@ -20,6 +20,7 @@
>>>  #include <linux/spinlock.h>
>>>  #include <linux/sysfs.h>
>>>  #include <linux/minmax.h>
>>> +#include <linux/kthread.h>
>>>  
>>>  /*********************************************************************
>>>   *                        CPUFREQ INTERFACE                          *
>>> @@ -77,8 +78,9 @@ struct cpufreq_policy {
>>>  	void			*governor_data;
>>>  	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
>>>  
>>> -	struct work_struct	update; /* if update_policy() needs to be
>>> +	struct kthread_work	update; /* if update_policy() needs to be
>>>  					 * called, but you're in IRQ context */
>>> +	struct kthread_worker *worker;
>>>  
>>>  	struct freq_constraints	constraints;
>>>  	struct freq_qos_request	*min_freq_req;
>>
> 


Return-Path: <linux-pm+bounces-43653-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M/uAS8hqWkL2gAAu9opvQ
	(envelope-from <linux-pm+bounces-43653-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:22:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B7420B7E1
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11F0C300D0ED
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65D629D266;
	Thu,  5 Mar 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kDzvEzjJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545D1917CD;
	Thu,  5 Mar 2026 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691753; cv=fail; b=R58UAF6xQjy4OMJKVR4aY0lF3NMJPsD4SZK85x+CZECXKinsn015TBA29mVaf6nln1Ug5y9/R2nC0pDLYTauoXOQJfVSP1E2+urJTWOBFdPle4ZEMn/OJLcqWYYSqQ6BBnLkeVa5U0coF/OGkgUH69NN6ck+GhkB+SwB+CSt5uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691753; c=relaxed/simple;
	bh=9tsgJg10+tp7dxjNTbu7jtTyXnIuqWQAg7tU+IAS9eA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dp7ZKGpYi8usbyqv+bxBMk4bYc7Pv8LUZa1cloutl9aCwsBZ4dA97noWX1iqqzmvGReGmYsY43BbmazS4+oQvV3853USIKJzQ/iica2hIX1c9t8U47v+U8DRRii9b665sBHfeYEPhBhy0qYBVfRiFcD8GL/ezYWag3INpes5Mwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kDzvEzjJ; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6VhZ/JOACyFFcGq4LzWxoBCFzsT9rBx3E+X10NO2qdba6KKfuVLJf69q1/3cvTOXL4/a1NuKl2sFKfRAWp9BPQJzzzTZKqBgvpTNZlpU5VpNKWaRxH5n8kxj5QCv9ATyEOA3vI+ZV7aItDaaJ1yhsGGo1rPRz+NQlBqppi/fvIcYjXPjpV8owyka7lIfmdoTRmV2W+TFPV9OtnX3o77HUYTiPdxLVFxZub9CavNccIHCIuh7cWMZPYDYVvYux/TxcQZbqvIOih6FE8+VjBH5wS63Oe3MaRmxBA3K0/y556BVKbzUjjEtMh93pJjiDAkmRucR6Z0K2uHl9WhJkv4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=203ULLuUhVaaUmCwxNEypYu/vvGX8ZDV1KBgEs1sGns=;
 b=M0kJuyc0RHdtQks+9QCxnfAKoVb5NCaBAA8q7aXtBGCrlfT81HKwlbrq1MG8GvqOMYYG3XNeG5UQC86eWqixtk8gKa5/RLICZs6kqa6TTolX8YLBI//nzjg6WK3WlgQiVSSlxm/RghUfDAOyozaFH0nHQ9eLpT8oTpVlaHONaICvdoDtgSKherktWz9wBEzNTjhHtt7wemSHyT+b0lRufo8U4A3tjnAQLZpevto5QbEVs1SICxOlB4HrRsXr3Vtk5iazY/ZyIfTTWQPAIQu/WAcdav6vSqmeZYCbdsRg6VFTKd6XWEJNsf9ubbI/YNLHxrG2hHAjcHCPN7DjhkLQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=203ULLuUhVaaUmCwxNEypYu/vvGX8ZDV1KBgEs1sGns=;
 b=kDzvEzjJxjzgIivgOK7cw98mQVkB5Zm5DELCr35qvtaDrgxzLt1/oVMFjHqhPY+yQ9hw+Hpsl7oUF62dxPjZzSSiY/I1sLWdLpLtBW6SxdGjuU/wltRLp76w+sPzCIt9vQNSj2+KoOLop5+vaMrGe/4qUyAvwF9ElMkcjy2qob4F1ZzYzg5V2qrhfnmdeM5MVh51B7rSt02RsAxEf4ZN6dYOfXOMVPNqnjVa85KaNVEsvhirPb29Py3sb2uqTcBu+OYYxDRZYREuOPDH+alqF3AgJOleceDpI8hu4y2kVFaw4YDfotJXBp5HLzKNYCQL3W+ZWjZh4CgioGtUeOusaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 06:22:26 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 06:22:26 +0000
Message-ID: <25bfc2ab-e73c-4191-9888-7e107f4e65db@oss.nxp.com>
Date: Thu, 5 Mar 2026 14:22:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] boot failure on imx8mp due to e0203ddf9af7
To: Marco Felsch <m.felsch@pengutronix.de>,
 Franz Schnyder <fra.schnyder@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, ulf.hansson@linaro.org,
 benjamin.gaignard@collabora.com, kernel@pengutronix.de,
 sebastian.fricke@collabora.com, linux-pm@vger.kernel.org,
 festevam@gmail.com, s.hauer@pengutronix.de, Frank.li@nxp.com,
 peng.fan@nxp.com, nicolas@ndufresne.ca, regressions@lists.linux.dev,
 eagle.zhou@nxp.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, mchehab@kernel.org, shawnguo@kernel.org,
 linux-kernel@vger.kernel.org, l.stach@pengutronix.de
References: <n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp>
 <fcsge66ba6toath5g3t2yw6vxqqldn7utxq3ekrfecfuwgzjrg@ftbzb6xvarcr>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <fcsge66ba6toath5g3t2yw6vxqqldn7utxq3ekrfecfuwgzjrg@ftbzb6xvarcr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8d8efc-29b8-404b-d0ac-08de7a7f919e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	1DhfSp9DTg92X5qL85wHbaUUMkHtiktXieDW4g3VY5XDpCOL4r99lzAdO3dDyfheOCFh27NKtTaVLu9aLrPa5D6aY8c+V6JNRMlwkMJ54AoO5NeKF7acDF0mllbst+wqoTYB5oaaXotGWCUOeTtxG5Fsb2i1fIcPFXHKZtRlQioyrjE1wrPSuhw6UiUeivvLfH5VwxVBle1Y7LUVOdZHcIwMOn3zfb69hE9xk1C70Jy+TY61ZbDfFhuK21Gz0RorJFHtu2x/wdeBBBVUL63uQiAsr0PnjeNNyY7Qje1U5kbugUAQ4tpo0a7sIXoaMi3qBD/d0WMy2BonuNqF9XclLXGTD2TvfK47qMonA6pqzx8SYUptC9pp8YHnNRpwwT7LUMTj0CfVrMxG8TWmtpl2t6T0V3Zp7PvVyzNrmtMvmqNTwAvGXASg+JgUyYAYz6UHsFLyuP86AIkRBor7d9Xe6wxvozzTB1xVBDhgKFnP1odR2IQFXJ8emxf73YRxy+8p0ey8Mg/8oW1YmNtgmzFpYNVaEzFmi6aA4b2SDy8vMsPg0fVRQnBRwtioNMmfdW5dnyoS3TUnvPhG/eDX+jCXSX4MJmSW40Nng6u3DvlJHkfSHJKWDSkGCHCLIJyxg4oYS/RN/yq3S95AZalxILxX5yTcfkgOQKUU10UurFQmc5oNhCRm1kbazB9vTkjW7/2tAhszRv2n1P7K1IJdEBxhYhtN/doXgzukYplKo8kRetc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXBaNmM1WisyemJmMGU0NFdQSDgvY3ZQa1o2WVFqSnM3STJiK3ArdnM2N3Ni?=
 =?utf-8?B?VlhPT1BzeDl4UXRXZWFuejdqNEtXc1lHUjlaeVNzeHUwMGhsSU83eVg1NCtF?=
 =?utf-8?B?UWNRdmJubjNwcEcyeUVIMzA1TWVuVE1IM1RLRUFzblBjS2hvS29ibGM0NGE2?=
 =?utf-8?B?bVJ3Zy9DaXZETTl6OVh5aEFTTi9WQS9uRmR6LzJYZkpzc1hJczR5WThITkJ1?=
 =?utf-8?B?cDcvMlRVQnUvcGtVQm9nakRMMW0rZnhVRG5BcXdXTzFRR2VjL2VEa2xEZjZT?=
 =?utf-8?B?dXVnZzZnQnN0QkNiMkpqQmIxUS9aY01vN1N4YnhEVWo3cHhGWFF4cyt0dVUy?=
 =?utf-8?B?bVErNlBObWdaenB3ZEM1eHFISGRWWENuZVE5REw0eCtYV1pWenl2ZklzRDRY?=
 =?utf-8?B?dHlOeXQrc2NiZUtwN2l2c0dKVTIxell0d2MrM09vT0NSNEdNb01ML2RWNmFi?=
 =?utf-8?B?clg2R0J6MURnRWRGTGRjVkRLY3BHTXpWdzVHQ3JSSWdVbEFLL01HTmhuMjRl?=
 =?utf-8?B?L0pPTXV6ckRmdkVwbzlyUHQwTy9Qa1lYTHRyMkRZYzViVnRSU0dmdXNlYTk5?=
 =?utf-8?B?U3BnRXRZbk5tN3dRY2dRVlVOMDNXNS8yd3dQclN0UUZIU3ZOUWFuYTU4RHd0?=
 =?utf-8?B?UmdYSitHd1BWOURoeVlGZzBIYlRiM0Z5VlZjNzB2Ty9jTW5UZi9xakJRN0xS?=
 =?utf-8?B?R1lVaHIxOUtwYTdjZldNdmtTTGp6Ykx3QnpYdEppbWx5emJaWTNYR2pvTXVh?=
 =?utf-8?B?U3phVUY2aXA2TnpjR1NDNTkrVklYTnFNaEthVXJFdWRQTk01MVlIRVppQkp6?=
 =?utf-8?B?V29Tc0s4ZFpCaDhJY3dIMlgyWHNzUE9BQkp1OEVlQlRjTTNxbThiT3dWZCsr?=
 =?utf-8?B?a0djRkwxejdqN3MyWHpWSHFvUUJxVVRQT3ZZeU1ZV2JsKzBJclVqNE9kRVI3?=
 =?utf-8?B?dnFkNlhIWkJLeG5xTFpiMmpHYXIvMGZvcll3R0REcnRNNzJlb0JXVEw2ckI1?=
 =?utf-8?B?d2Z3cE1YdVlEeW1aR29FNTJyNSthNUlXS0wvV0Yrc1Z4d2xleGpkL3FzckYr?=
 =?utf-8?B?SlhQU1hiMm1pbjRsZXJRbmtGQlUwNFFYTzQ5dVdmL2M5RmNTVzBvdkFpekIv?=
 =?utf-8?B?S0Q4azR2cmxreDBmNmdmTjI3VC85bXpnUzI5dWRBVkRyNmxJU3hUWkQ1YTdF?=
 =?utf-8?B?M1d4Tks2NzQraC9waEtYeDAyOVF0ekh3elN1M3k0MlB3dUNNTnZiUW8xWHZl?=
 =?utf-8?B?UGVrS0xYaXIzdEcrR2ZpYW1JNTlrSEphd0Q1S3JVejUzRW14aEI1b1gyUWZw?=
 =?utf-8?B?YmFUMWM1NW1MYmJ6ZlcyVW51MTVwOFRUdUZtaXNYdDBpNXplL25ScGxBOXhK?=
 =?utf-8?B?MjNIaUJlbEMxeVBHTHpZZTBFdm9IbmxxM1BsRGNZZTVPMlRZMW9RaUVVRUp3?=
 =?utf-8?B?alhlUS9wVlRRSEw0aEY1eFhEQWJmY2w3aHZCbFIzYlpRK2tTWk4yc1dteWVH?=
 =?utf-8?B?NjM2b1VsSXVEYUpyQ24yNVpJYzlod0QyQWRJczVhb0VVYmxFU3FhbXJBZ2FQ?=
 =?utf-8?B?WWZyZlQrRGJYTzNyakM2R3hiZm5YUnlSMGhLZGpjeUFVdm5TZU9BMnA4RW5a?=
 =?utf-8?B?RFdZM0dobExVNlh2REdNZXNVaktQMCtub1prMG9jZlVpRHZYVDBKVWcyN2Vy?=
 =?utf-8?B?OU1XVmhVYlMzdXVlYlNNbVpzSlBmQ0dwZFd1SXpncjN0dFJJc0p1d3pvSE1I?=
 =?utf-8?B?Z2ZxUnNhYjh6MnliQVV6UXUxbit1Z0NQbzhSQVZTKzY3eUJlVmRzd2ltUmcr?=
 =?utf-8?B?eThPQXZNeXp3bGdHamxvQy9SRVEwaktGWEVOalo0dTc2QmRSQlhDS3hES255?=
 =?utf-8?B?NFI1TmNNUHNXN1lCRkJGdzRsNE5mcnh5dXkvWjUvOWFWSzR6NXY0dm0rTUM1?=
 =?utf-8?B?SEUrbFVOVE4rZXpRMWlCdXVHN1J4ckxBNjRSaDE5S245Ym52b3dTSXRaMWJQ?=
 =?utf-8?B?Z2xVTk1oaEdKdENiSFN3VzBzeHdaTU5wNlZMQm9kRjFTOEtBY0FnbWU2NkRt?=
 =?utf-8?B?bnYzSm01T3dsSEg5Mit0dDV1UzBnYTRuN2JDa1R1VlNnbU1HbVM4dmZ3WGts?=
 =?utf-8?B?YkRHT2t2S081Uk5lcXUweUdsa3FmdDdqYVIrTER0YUMvSDV5YTVzTDMrbXVW?=
 =?utf-8?B?K3ZERVRPdWhydk11Q2tkZGxoeFFicGI2WmRkVEJIZzRQdndjZEgvQmpSdkox?=
 =?utf-8?B?dUozYkxtVmlJYVFRQnp3RERKem1lV0U1OG4xZGJQajg2dFc4WFNDTzlBWTVl?=
 =?utf-8?B?a1h2Y2U5RGdNcVFFNE5CVXZXbEEwbWhCMVVuRmtBZ3pjU0p6OXkyQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8d8efc-29b8-404b-d0ac-08de7a7f919e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 06:22:26.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qurOODck3pwa+7CwsIXt7wCZGCZHJXe94yZEYBLkAhyNlptbavd9+aCuEsNE4o4dhYzCYykNL95CJ3JPWRha1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
X-Rspamd-Queue-Id: 02B7420B7E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43653-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,linaro.org,collabora.com,pengutronix.de,gmail.com,nxp.com,ndufresne.ca,xs4all.nl,kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

On 3/5/2026 6:43 AM, Marco Felsch wrote:
> Hi Franz,
> 
> On 26-03-04, Franz Schnyder wrote:
>> Hello,
>>
>> Our iMX8MP SoMs (Verdin and Toradex SMARC) fail to boot after
>> commit e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC").
>> On rare occasions, it's still able to boot.
>> It fails after having registered g1 VPU, probably when it tries to
>> register g2 VPU.
>>
>> Ming: Any ideas on how to proceed here?
>>
>> Success::
>> [    9.040517] hantro-vpu 38300000.video-codec: registered nxp,imx8mm-vpu-g1-dec as /dev/video0
>> [    9.052133] hantro-vpu 38310000.video-codec: registered nxp,imx8mq-vpu-g2-dec as /dev/video1
>>
>>
>> Failure with decoded stacktrace::
>>
>> [    9.004477] hantro-vpu 38300000.video-codec: registered nxp,imx8mm-vpu-g1-dec as /dev/video0
>> [    9.027097] Unable to handle kernel paging request at virtual address ffffd9c18eb05000
> 
> This is quite a nasty bug you triggered here! I think the issue is that
> the newly added imx8mq_vpu_shared_resources[] is of type __initconst
> where as it should be __initconst_or_module. You can test this
> assumption if you switch from a module [M] build for the hantro_vpu
> driver to a builtin [x] build.

I will correct __initconst to __initconst_or_module.
Thank you for pointing out the issue.

Regards,
Ming

> 
> Regards,
>    Marco
> 
> 
>> [    9.027132] Mem abort info:
>> [    9.027139]   ESR = 0x0000000096000007
>> [    9.027147]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    9.027156]   SET = 0, FnV = 0
>> [    9.027164]   EA = 0, S1PTW = 0
>> [    9.027171]   FSC = 0x07: level 3 translation fault
>> [    9.027180] Data abort info:
>> [    9.027187]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
>> [    9.027196]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [    9.027205]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [    9.027215] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000004924f000
>> [    9.027226] [ffffd9c18eb05000] pgd=0000000000000000, p4d=10000000496dd003, pud=1000000102e42403, pmd=100000010c33d403, pte=0000000000000000
>> [    9.027258] Internal error: Oops: 0000000096000007 [#1]  SMP
>> [    9.101669] Modules linked in: snd_soc_fsl_sai crypto_engine rng_core imx_pcm_dma authenc snd_soc_fsl_aud2htx snd_soc_fsl_utils imx8mp_interconnect libdes i
>> mx8mp_hdmi_pai evdev imx8mp_hdmi_tx aes_ce_blk dw_hdmi ghash_ce drm_display_helper snd_soc_simple_card hantro_vpu phy_fsl_imx8mq_usb libaes phy_fsl_samsung_hdm
>> i snd_soc_simple_card_utils cec phy_fsl_imx8m_pcie v4l2_vp9 imx8mp_hdmi_pvi typec fsl_imx8_ddr_perf snd_soc_imx_hdmi gf128mul samsung_dsim v4l2_h264 etnaviv ti
>> _ads1015 industrialio_triggered_buffer snd_soc_nau8822 ina2xx lm75 gpu_sched i3c lontium_lt8912b kfifo_buf governor_userspace imx_sdma flexcan imx_aipstz dwc3_
>> imx8mp imx_bus can_dev spi_nxp_fspi caam spi_imx error pwm_imx27 imx8mm_thermal nvmem_snvs_lpgpr snvs_pwrkey usb_conn_gpio gpio_keys display_connector roles lo
>> op fuse ipv6 libsha1 autofs4
>> [    9.173690] CPU: 3 UID: 0 PID: 45 Comm: kworker/u16:2 Not tainted 6.19.0+ #47 PREEMPT
>> [    9.181623] Hardware name: Toradex Verdin iMX8M Plus on Verdin Development Board (DT)
>> [    9.189462] Workqueue: events_unbound deferred_probe_work_func
>> [    9.195314] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    9.202284] pc : of_find_matching_node_and_match (drivers/of/base.c:1129 drivers/of/base.c:1120 drivers/of/base.c:1187)
>> [    9.207869] lr : of_find_matching_node_and_match (drivers/of/base.c:1185)
>> [    9.213452] sp : ffff8000805dbad0
>> [    9.216771] x29: ffff8000805dbad0 x28: 0000000000000000 x27: 0000000000000000
>> [    9.223927] x26: 0000000000000000 x25: 0000000000000000 x24: ffffd9c2060d48e0
>> [    9.231078] x23: 0000000000000000 x22: ffffd9c18eb05000 x21: ffff0000ff79d7f8
>> [    9.238231] x20: 0000000000000000 x19: ffffd9c18eb05000 x18: 00000000ffffffff
>> [    9.245385] x17: ffff263ef9a67000 x16: ffffd9c2055d3d54 x15: ffff8000805db870
>> [    9.252536] x14: 0000000000000000 x13: 006365646f632d6f x12: 0000000000000001
>> [    9.259689] x11: 0000000000000003 x10: 0000000000000020 x9 : 0000000000000000
>> [    9.266842] x8 : 0000000000000020 x7 : 00000000ffffffff x6 : ffff0000c4a9d8c8
>> [    9.273995] x5 : 0000000000000014 x4 : 0000000000000000 x3 : 0000000000000001
>> [    9.281145] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>> [    9.288301] Call trace:
>> [    9.290753]  of_find_matching_node_and_match (drivers/of/base.c:1129 drivers/of/base.c:1120 drivers/of/base.c:1187) (P)
>> [    9.296336] hantro_probe (./include/linux/of.h:983 drivers/media/platform/verisilicon/hantro_drv.c:1047 drivers/media/platform/verisilicon/hantro_drv.c:1225) hantro_vpu
>> [    9.301144]  platform_probe (drivers/base/platform.c:1449)
>> [    9.304815]  really_probe (drivers/base/dd.c:583 drivers/base/dd.c:661)
>> [    9.308399]  __driver_probe_device (drivers/base/dd.c:803)
>> [    9.312765]  driver_probe_device (drivers/base/dd.c:833)
>> [    9.316956]  __device_attach_driver (drivers/base/dd.c:962)
>> [    9.321415]  bus_for_each_drv (drivers/base/bus.c:500)
>> [    9.325262]  __device_attach (drivers/base/dd.c:1035)
>> [    9.329109]  device_initial_probe (drivers/base/dd.c:1088)
>> [    9.333303]  bus_probe_device (drivers/base/bus.c:576)
>> [    9.337152]  deferred_probe_work_func (drivers/base/dd.c:125 (discriminator 14))
>> [    9.341697]  process_one_work (kernel/workqueue.c:3268)
>> [    9.345719]  worker_thread (kernel/workqueue.c:3334 kernel/workqueue.c:3421)
>> [    9.349477]  kthread (kernel/kthread.c:467)
>> [    9.352716]  ret_from_fork (arch/arm64/kernel/entry.S:861)
>> [    9.356303] Code: 6b14001f 9a93d35a 1a80d294 91032273 (39400264)
>> All code
>> ========
>>     0:   6b14001f        cmp     w0, w20
>>     4:   9a93d35a        csel    x26, x26, x19, le
>>     8:   1a80d294        csel    w20, w20, w0, le
>>     c:   91032273        add     x19, x19, #0xc8
>>    10:*  39400264        ldrb    w4, [x19]               <-- trapping instruction
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:   39400264        ldrb    w4, [x19]
>> [    9.362413] ---[ end trace 0000000000000000 ]---
>> [    9.367037] note: kworker/u16:2[45] exited with irqs disabled
>> [    9.367134] note: kworker/u16:2[45] exited with preempt_count 1
>>
>>
>> Thanks,
>> Franz
>>
>>
>>
> 



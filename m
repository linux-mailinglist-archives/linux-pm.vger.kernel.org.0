Return-Path: <linux-pm+bounces-41936-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePm4B5m3gWkrJAMAu9opvQ
	(envelope-from <linux-pm+bounces-41936-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 09:53:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57444D66D2
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 09:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFEAA30214E3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B0392C58;
	Tue,  3 Feb 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WaeaBuxS"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DC27A123;
	Tue,  3 Feb 2026 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108822; cv=fail; b=Xt5s/Tu+OBOrke+pdTCYjkO90h4RWmMFRmX+HHkwAC/+6GBPuicKaDkYCIisCZIJFcvqRFv+yZX3rCSeWbgaoR+wI5/cuEGDyjV7Aith4Pna2DoLFXlNhzSuEoNwaT/XBZOoTB6jJv1IjuQVlipsl0beoV78tpY6UNU7qLNpEBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108822; c=relaxed/simple;
	bh=8IFW2FXh2XhJW4j5rhpoCa5wutdjgQegIYvO6eaz06k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CiEDNOC4lLTlqJLiB7jl5Cic7EibGVHVlLRzKRGf72SKAxqeCuPaNJlvFlf+w5Gxd0KBQFKj8TQmg/hnsxAJaHZm5AnX30PQ2OCZbRfUYBLl03v+hdbWK+z5Z+V6JYpn4qtYLAZbVR4+MIpnf506URqTS9uNzy26l07O/ndhyhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WaeaBuxS; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL0txR6TaIvf+/4HdtO/isNuUhDD8MRVRL8D3jzj0I/ZdjiYvvAa8zjQP5HppPQGKio055mylXuFbpjAluVA6jvSIztu5cH6tLFeifz8633wk8zcHddLJG+XPz2kJ5R+0tQ0469bw3GdFFtvV/XuHv+TuARvnzO5YZAE666sepcKeyVJQeuyYI/cNE9zWh0s00u11hKqBqUNeRHeQhF+normSxoIb/ERPreaPIbDt8dtWhyETM045dSGzhLa1oBfTZnrI866bTakpRnzeT1B+UtQHitksj1LWqJV+9sP+z/VuCwAXtv5KqreCk/NV4iT0fqrqQA/hAtteoFvciS+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P90DiersDAm/2vdKnMckUEU9pwkbKY7ci9KDgP/J5Q=;
 b=gqqUKpZ5NeXgKUa1VdktwaHufkMYNHIQIBdn3iVHhariPoLImk3U/KOGWBkssrqM5bR5EHKPmch3bhUret+RY+JFv/717uAJDJveUxEASYdsK3PvGQWg3Z/K71v2uiR/K4KVVkFUnZq+ZC8ImjZ8qsFwWBI9vHj5gHubnZ+kd0NXJ808iu0gd+4n0qZ/nEJPCnmMpAU3O3jkLeaNJPlcJZg251Lr9qXlPMKrd3a3ph3/zvZsjt88kpUZyCf/HDREyHUM6EYScfrz1pVss4GWrf0fWBoKCSgKupO9UmpbA5el79ERG15VWUYO+i2QoZpFNcfhFssE7l3V37UOgQSOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P90DiersDAm/2vdKnMckUEU9pwkbKY7ci9KDgP/J5Q=;
 b=WaeaBuxSznF00CjEtZAhTrXnxXmwKDAywp7iR3qv1yc1AZJbVhZBQWpvKRJgPaiEGS1bxSBkTg22gUoa9Hih6UBe0f0vtFGjGYEbt1TpGDPlkJ+jOFcAyNFkqhlHwN9TB7z3vvgjvhprP1Oek0/YHfbGFTWRTfe32wZr4iH0WN5dBbLxpXvarrMZkJRVdRSyvdGzlNjYq3OSCmaustrqGY2AZ23skXlxcrzwzOHEbfo5026qePmmu0N5z9YT9OQT0Is/tW3MxrR8yBdRLAE9w8cV5wn1NKCopVU+9G+bJSY+pWXWzOqpigVzoVR8qmDU60GU2A6Xdw3lNz4utSF8EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DUZPR04MB9984.eurprd04.prod.outlook.com (2603:10a6:10:4dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 08:53:35 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 08:53:35 +0000
Message-ID: <cd07dc6e-1f19-4a59-8ee5-81a36d51bf1c@oss.nxp.com>
Date: Tue, 3 Feb 2026 16:53:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org,
 imx@lists.linux.dev, ulf.hansson@linaro.org, Frank.li@nxp.com,
 peng.fan@nxp.com, festevam@gmail.com, robh@kernel.org,
 benjamin.gaignard@collabora.com, sebastian.fricke@collabora.com,
 linux-imx@nxp.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 eagle.zhou@nxp.com, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, krzk+dt@kernel.org, shawnguo@kernel.org,
 l.stach@pengutronix.de
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
 <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
 <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
 <20260203083110.woan3gmc3qdh7nmm@pengutronix.de>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <20260203083110.woan3gmc3qdh7nmm@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DUZPR04MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e062bb0-b47b-45b2-710c-08de6301b742
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWRrdDJCWlEwMDk1WUVZR1hkcjhEZnF0UithSnRrYjNtQU1iYThENVVIZ1h4?=
 =?utf-8?B?S29jWHFnSUJFQ1AzcDNOTUkrQVE1M3pvWkJQdVFXdERyNHY2eHQyUWtudUlE?=
 =?utf-8?B?OE4zQUJYRlY0Y0xyN1JQQkpWS1NWN2RQc1ltWjNwVlRqS1UxMnNLRTExZWRU?=
 =?utf-8?B?OFpMWnZLeFVPOVVJVmhKMC92UWRFQTRsMGo5SFNJTHV3QnhBL0hlY0RGVHVW?=
 =?utf-8?B?VHZ1d1pSVCtiYkFTdTBJcFFESHJPbzZOTEp1ZlhKZHlKRitieU83OFFkR1N6?=
 =?utf-8?B?VWNSeVA1bVFIbEd0ZVBlcEpaME53Y1FiWWEybTAwL3o4MFVuQjl6S2RpbFAv?=
 =?utf-8?B?am1XNEtkcitnU2VvRmNjaTRFV2ZPRmd1dkIyR2JIUHM0TkgwaG1acVpLTkZP?=
 =?utf-8?B?SEpQTlNqdDFpVU0zSTVteXh6ZFFKNjJQNG1UYmtaRFF2ME80Y0JCaWVUYTd3?=
 =?utf-8?B?SlZzY1UxUzk5VU5MaFU5MjlYbkNJUkVycjJ6R0NNNlYzSkxjbUxpVkZvTlBI?=
 =?utf-8?B?NjlBWHNEaERYTms2Wm82eFpiRFJJc0ErZ0dxQWk3Rlk4by9NZ2lvUisyMG1L?=
 =?utf-8?B?dEV6bDJBVU1ySWVyZ3d4S0I0RE1uQ0I3ZXMrK3hWYm1JM0FxdWdmZHZnUXhZ?=
 =?utf-8?B?SU83R0t5NDFLNTJvSTRYSFRmZzgrbXgvOGk1Q3k1d3VlTDBqRUVUZzZoNVhV?=
 =?utf-8?B?WGlKK21mRFdkZWF3T1haZWpaYnN2UjBkV2xjTlg3aHVGaEtqNnFVSjMzbVFX?=
 =?utf-8?B?L1BZNTVYSzIzdlJjTExYR2NTK2lhV3gxdTQ1NHFtT1gvazJVcko5WUF2dXJ0?=
 =?utf-8?B?ZVFtQVZFN0lTamJTRzFYSHo1NkNmREhDNkJHdGNaL1hzMmJITUZBOE9YVzNO?=
 =?utf-8?B?RGwvTGE3R0d0cjJqRlZRSzBDa1NUR09JZ201ai85eVc3bVNHUW1uSE1TbUlM?=
 =?utf-8?B?SkhSQm8vdUxPMlFma1pRRythWlJKSEVyREhHdzlBQWhGaEZTcDlNMTR4MW44?=
 =?utf-8?B?bG1yOUVvbDlNVnFBbkUxbnJqOG1TNkFESWZJYzVZOE9QQktkZ2t1QWMwNmc2?=
 =?utf-8?B?K0FVMGVkeU1mMm9kbmJNOFIvczUxZ3FrWUNGZWhwejM5Q3RFdmh6S3BkeXFo?=
 =?utf-8?B?UUx5L0tKSTkyU2x2Wk5VbHR5OWhnWGVzN2tjazhKa1k0NURWYXFUUmFrZ1R1?=
 =?utf-8?B?SFFIMC9WWGF0Y0NxNm1QQ1NYeWtueTl1a0puN1VmN0Q3MnhNTU9SekZQWlM2?=
 =?utf-8?B?UkVtOFRVQ093UHY1ejVPNkNKa29UNkwrUFRlQmtZT1JadWFYS2EwYVhjUzkz?=
 =?utf-8?B?ajJMdlRieU51SDhEeUpLK1FyQWExeUs3MWpMME9HS1NZU2FMb3VaVzVZQlpU?=
 =?utf-8?B?V3ViR25pTm12SGxCbDdabTVaeEVudEhUT1JiRUhvT2FkaHNYMXVRMnRsREVY?=
 =?utf-8?B?TFpNZHRzWHdsVk5oZGRLcXU2eDNkdlZjdVVsNFZkTzlpTDZYMnhXS0pqSk9Y?=
 =?utf-8?B?NklVN2tKcGlTTjZYMXFRKzJGWjlKWE8xR2haUGhWMzc2anZodVI3N3BqUkcz?=
 =?utf-8?B?SFBYWWwxcnV5ekZnZ0tjcU91VUVsYmV6MEtNYXUrYUtudWN3Mitmbk1ZOXdX?=
 =?utf-8?B?Qjl5TTBaZDlOVnhsWklTQy8vbm1CQzQxanRqZXpqVERJVTBCWUVSWEZrVExL?=
 =?utf-8?B?NXZHZEJZU1cvZnkvbjkraDVCbTJnVERkbE9ZRkh6VE4xWDZBdVRZZW91SzJ3?=
 =?utf-8?B?b2VGeUNZZUJHL0FELzNULzFFZi8xK2xwNnJKQkw1YzYzL3R6VjRBNE1xdGFQ?=
 =?utf-8?B?N3gzeUVJVnhIbjhHb1pOLzlFVWMwak53UjNWdTZvclB4WU1ka2VnRmlQQldK?=
 =?utf-8?B?dG1ueTFTRityTEV1bWRrTGt1S2c5MFZhRGo1SVRyYThSdXJBRzV6QXRUa1ZF?=
 =?utf-8?B?NW5mYlFMVGRkSVJUWUtYRHpLbVJ1VlprZm9sc3ZqY010WGx5ZXpGMHlRSFB3?=
 =?utf-8?B?WHBRTjFDZFJCZ1dFMmllbjByaEl3SFZBTW1NT0t6bVdFUnZBaVl1SmJITXNU?=
 =?utf-8?Q?5dPN+N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzIrVWJERkZrakw1Wm5LS1ZxMUdxaHpSYUtwM0tFZkV6ZkxPRlRjb2VNNzNC?=
 =?utf-8?B?bCswWk96LzFlYyttRGNyUUJ2K1VhZFFqTUxaam8wVXRaY0ZRYjFNZ0hFdXpU?=
 =?utf-8?B?L0VhYThxMi9NbFlQT2JGUTVyUngvTUtLaGFQZVgydUlQbUYvdWZUeGJoUjA4?=
 =?utf-8?B?QksvRW5QMGM5NHgyZG5PNzBsbVpmOFBYQjRrQjBtVzlEVUFPeVRhTTZsVnFV?=
 =?utf-8?B?MXZiYzBrTHFhVHFxSFU3UGxocnpyWDRDM0M3REFja3JvdGJWdGdiMGpucFpS?=
 =?utf-8?B?dlg0bHkwcjRhRjRkNnZpMnRPTHpQbEVtb016S1NLdlZLOUlHcjBkS3FDQmUz?=
 =?utf-8?B?bWg5Nk1GaEtVS25mdy8yWDF5dW82Y0RDRDhqbUppQjMyajY2emJIak1zbGpB?=
 =?utf-8?B?SG5MdmRhU3FMV2RYQ3F5ZUx5RlpjdHZMd2xlOHFvNmtBcU9UR2t2cFNLL3pS?=
 =?utf-8?B?anY2WERXL1NQT2d5eWJ3TUE5UzF1UFpUU1FaNVR1dW9QWnBZME9oRnNFVWxX?=
 =?utf-8?B?ZEpybFFRMysrYmtSM245MjNTS3V0YWV6d25BSXhlS2tJY0VHaCtFS0d4ZmQx?=
 =?utf-8?B?ajAvR2xpYTA1b1g3U0ZJN1RpTTlMSG92K2xZM3MzZXdIT2lDQkJVeGFib0tx?=
 =?utf-8?B?dURHYTdOUXRtRU5rOFV2Q1lIVEVQTmZCSkNHUjhqQ1djR2hodTd1cWc5WEpi?=
 =?utf-8?B?UStkaFdiR2lFaFIwNGhkbFZPWVNhZS9KVkNTci9HRlpISkFmM0dJU1VGT25s?=
 =?utf-8?B?dVkrOFh3MmJPUlpzZjRlUzAyLzhmMDVnSW1HQTJ3blBVU0oydER3bWF5OVE5?=
 =?utf-8?B?L2V4NVNDS3prK3VPejlvMnJHMW1qVlladDVad0swdmJkMzZDL3JqdmNIZmho?=
 =?utf-8?B?c3gzTmVlYlI1WmswUG1rdzlZMjVEM2k5VnFpWmxzcGZJczgzbW1FWEdMRFo5?=
 =?utf-8?B?NmVpUHU1ZndvbXZiMXVaNS9YVE9kdXRheVdtWE5leSs2Sy82akRveVFvci8x?=
 =?utf-8?B?b2ZhVkJBaWprc1pycDE2Y0tKYWpueE1Ja0tQbGM5TjhwdDExeFlVTldwRUFE?=
 =?utf-8?B?L3ZOVUVQYkVrZ0VzZ0twdkVBQWtsVUFVY2V3QmJDVmt4cGV4VG4yNUJvbjlY?=
 =?utf-8?B?YW5sRVJXS3RXZjI5SkZhY0dRWG1sMUZhUHB0RVRBZ21FUTZTckE3VXJ6Y3c2?=
 =?utf-8?B?WndDVDRKdzJ5K2p1OS9YbzNtTElRdmdNaXFPdE42bCtuK09pZFNOcG5kV3M2?=
 =?utf-8?B?VjMrSWdXcWNWU2JKc3BqVURCRjF3VklkYmxRa1lzalpmTVkwZ3VCK05MRGFJ?=
 =?utf-8?B?ZmVwZExLa0ZOS3ZQbHRZRnlveEthMXVWWTlHV29OZlZpUC9DeXJHWm1qQkov?=
 =?utf-8?B?aGRWSkY3aUw4Uk9kWWJta0FiSjgyK2tmT0lrNFl3NVQvYnFqbitKR3Y4eEtV?=
 =?utf-8?B?eVlIZis3Sjd3c0pyWVhkRVBTSGo0RjRNajhVR0c3Y04vOUlKbm1YbU5TVktM?=
 =?utf-8?B?S1l3ek1GLys2dEZ2UUNUMGxJSjlKbVF1bzl2bDBsRmhxSzF4S080RSt1Z3lt?=
 =?utf-8?B?eUJmMHRJNnFvSm94THZ3ZlJKL2pPWTBEWm1zZVhwTmN5aHdOT0szOE41bGx0?=
 =?utf-8?B?UnhPQ0haRGVMR1BldHh3NUxWT01RZmNaRDY5Y0dFWm1ySUswMktpMUpXQ2s5?=
 =?utf-8?B?anlJVXhDZm1McWt5cmV3WWZnWDBGQXdJZk40R1JEWkZadXpTRnRiZ2hjMFhB?=
 =?utf-8?B?c0NycHVZY3RTMTZWV1RXUnNWMnRaWW5zNXFBelkrVHlUYVEzdFZCOXRZb2VT?=
 =?utf-8?B?YnhqOS84MS8vSVAwVHVpY2hjTUQ3eDhpU3R0V2pyS3NHWXBwWGdTb3E3NmRz?=
 =?utf-8?B?RmNTT3k0ZlNwOTFXTnFIQXdrYXBldHBhLzlyTDdjZE9lN3Z5STBKWkJKVEV5?=
 =?utf-8?B?QUozdTRudVljK3hlMGFoSldtK3UwdlY5eWpSYzZWMDNUUVkvUkxjTi8ybzY0?=
 =?utf-8?B?b3lidEx4TEdRMVZUNWhKMitQVkhiUGI4dmk5Ny9SZy94TWFKQlo2bmZoRm9M?=
 =?utf-8?B?Q2hqckRFblVtSi8vTmZyOE1UZzI5ZE1TeHZ1bkU0S0ZnYWFkVEo1NmZFbjhh?=
 =?utf-8?B?WUN1VStCcHZ0c2ticklkeEY5eXZCWUZ2L1RiYk9ORGlMaDN1OW4yenJJVnBk?=
 =?utf-8?B?RVBNOUMySmhFeXJuUTdjZlpjd2VOaUhZK0VJSEhHVXFvU21MeERJcy9BSTly?=
 =?utf-8?B?Yk42MVdXbjQ2Y2dYVjBjRFJ4U3FaYmxMYThxMlp6bzNCdC9FVVBJTEkzaE1J?=
 =?utf-8?B?YnJpdm56RjhuZ0JJN3NJclN0d0pXL09VRlloOFBmeTNvcmU0TjEvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e062bb0-b47b-45b2-710c-08de6301b742
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:53:35.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFjhO65GS+N1RcDQV+60HtWsZGwUYz5hUk10onW8ccUgqoayQeQaVL3Itpx6vAPAvVGAMTK4puLG4UwtE58yVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41936-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[ndufresne.ca,vger.kernel.org,lists.linux.dev,linaro.org,nxp.com,gmail.com,kernel.org,collabora.com,pengutronix.de,lists.infradead.org,xs4all.nl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,NXP1.onmicrosoft.com:dkim,pengutronix.de:url,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 57444D66D2
X-Rspamd-Action: no action

Hi Marco,

On 2/3/2026 4:31 PM, Marco Felsch wrote:
> [You don't often get email from m.felsch@pengutronix.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> sorry for jumping in.
> 
> On 26-02-03, Ming Qian(OSS) wrote:
>> Hi Nicolas,
>>
>> On 2/3/2026 3:12 AM, Nicolas Dufresne wrote:
>>> Hi,
>>>
>>> Le lundi 02 février 2026 à 13:44 -0500, Nicolas Dufresne a écrit :
>>>>> This doesn't sound like just a VPU issue; it's related to the display or
>>>>> DDR.
>>>>> If not displayed, do the fluster test cases yield different results at
>>>>> 600MHz and 300MHz?
>>>>
>>>> Didn't you run these tests before sending ? I can try again, but in my
>>>> internal
>>>> notes, I wrote:
>>>>
>>>>     > Tested that, and everything becomes unstable
>>>>
>>>> That was before I figure-out the IRQ handler didn't handle exception bits that
>>>> didn't stop the decoder (or dry IRQ, which strangely is common from the G2).
>>>
>>> Ran some fluster tests now. With this patch the results is not consistent
>>> anymore. Then I ran it with weston being started, and in the middle of the test
>>> the display turned black. Matches my past observation. We did reproduce this on
>>> BSP kernel too. When the display goes black, the recent hantro drivers reports:
>>>
>>> [  827.581586] hantro-vpu 38310000.video-codec: frame decode timed out.
>>> [  827.720201] hantro-vpu 38310000.video-codec: not all macroblocks were
>>> decoded.
>>>
>>>
>>> I have local patches to reduce the cascade of errors, so it likely survived
>>> longer then last time. I will send these patches soon. The "not all macroblocks
>>> were decoded." is triggered by a bit in the status register that is not
>>> documented in NXP TRM. I found that bit in some VC8000D documentation (the
>>> sucessor of G2). I concluded it was the same meaning after looking at the failed
>>> buffer visually, it is indeed missing couple of macroblocks near th end. Each
>>> time we see this error, the DCSS gives up and turn either black, or sometimes
>>> other color. The second case has been tracked to a DCSS Scaler underrun, the
>>> first we don't know.
>>>
>>> Fluster command ran (two threads, never completes):
>>>
>>> ./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j2 -t90
>>>
>>> Nicolas
>>
>> My test results for fluster differ from yours.
>> On my end, the results for JCT-VC-HEVC_V1 are consistent at both 300MHz and
>> 600MHz.
>> And results remained unchanged after multiple tests.
>>
>> I'm not sure what caused the differences between us.
> 
> Once it comes to system stability, you need to ensure that your
> bootstack is aligned e.g. same TF-A version and sometimes same
> bootloader since there might be workarounds/erratum applied by the boot
> firmware.
> 
> Regards,
>    Marco
> 

Thanks for the reminder, and I agree.
I think we need to align our board environment first.

Regards,
Ming

>>
>> Below are my test results:
>>
>> 600Mhz, 0.9v
>>        cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>         SW1C                             0    1      0 unknown   900mV     0mA
>> 825mV  1100mV
>>        cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>        600000000
>>
>>        ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
>> 90
>>        ****************************************************************************************************
>>        Running test suite JCT-VC-HEVC_V1 with decoder
>> GStreamer-H.265-V4L2SL-Gst1.0
>>        Using 2 parallel job(s)
>>        ****************************************************************************************************
>>
>>        Ran 139/147 tests successfully               in 505.434 secs
>>        Ran 139/147 tests successfully               in 505.350 secs
>>        Ran 139/147 tests successfully               in 507.540 secs
>>
>> 600Mhz, 1.0v
>>        cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>         SW1C                             0    1      0 unknown  1000mV     0mA
>> 825mV  1100mV
>>        cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>        600000000
>>
>>        ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
>> 90
>>        Ran 139/147 tests successfully               in 506.901 secs
>>
>> 300Mhz, 0.9v
>>        cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>         SW1C                             0    1      0 unknown   900mV     0mA
>> 825mV  1100mV
>>        cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>        300000000
>>
>>        ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
>> 90
>>        Ran 139/147 tests successfully               in 506.063 secs
>>
>> Downstream v4l2 driver
>>        cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>         SW1C                             0    2      0 unknown  1000mV     0mA
>> 825mV  1100mV
>>        cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>        600000000
>>
>>        ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2-Gst1.0 -j2 -t
>> 90
>>        Ran 136/147 tests successfully               in 460.435 secs
>>
>> Regards,
>> Ming
>>
>>
> 
> --
> #gernperDu
> #CallMeByMyFirstName
> 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |



Return-Path: <linux-pm+bounces-41733-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIpIDnbKe2kQIgIAu9opvQ
	(envelope-from <linux-pm+bounces-41733-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:00:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A32B46AB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32537300DDD3
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA293596E5;
	Thu, 29 Jan 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LweqHFLC"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B286327213;
	Thu, 29 Jan 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720435; cv=fail; b=B0Z12OUie9xp/Sr4e1CVsmFLu5arn8GUnaWcjdadVp8wHRXzaBIDlGhs+L0Pj+bmUaWjKIKdmyPeap2h5OrzB99VBO9uktwpsyAd5Pj9X4jrrsq0dP8YPcr8C1mnoTVTnFYtYriJJmuck6T8FDvkD+xwSIbovz5hTkxRt8ZB9m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720435; c=relaxed/simple;
	bh=clduyMmBt7xD6QaxeVNxN19khAaYtWhw5faUYwxVDM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dlCYF7fZwbP6NE6uKnieYIzN15EE65+DGoj1Y6fLNmhInVlPZ7DpRVmEIo28QL9fAfirU1r1GAXpqvRwR/4MN/+MHMRdvafw6CWa2+MMbTskSnW6VidtVtfWsIMCit97Fbn3D5wU+ntRt3St/zweR8Yu5BqSjhYOhTCC/zwCczo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LweqHFLC; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2fWgE4EWp8p6G8r77U2M7dJP9oe/+VFCfWgYNV2YM2jPBDqlkGRp8otOLhQ8zU3UZD0kFwD1fWrEfpenr4XPPOamGqChJQfVJtJfDdhemyL/OiCITrV+n8rImnKjsAAko/UeYzgKYS1vRCokQr5wC7iQ7ljzOmh6wOPN2v0PRk+oPzN/5AZdRQ7KXPada2jpFONsoFMWCMpl/5JalcF9bOg+HQEh4+eWm1sZDjk1nvC7ylgEnK4kDaaUKn24vpBLmYBayH4kS7Blbv6t/LySJoDEXQWN+CjpPwRwSBlA7fw9I58ZBVoVEHbSS0b3ByVg+IEfnrJsSnVVE39wKm5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+Asj2vcwp3CsBfFn2k0hXk3PxIqQP0ePZHgBoavl5Q=;
 b=dnrIrNMolQPpqCWru6YVKBC7zF2wuUXgkiP4sz9rtokeLcxgZMGWteT7htQz4LV1IpCUAt21s8fSWXIXuEUHFXDpvUvLouhgl6cxJAId6nI/PvjTTBGFrIUAj2tBKwPCx12ORvWUFGjHr/e6w1P9ZDkJunoqN0pxSxS/1L0NEHfylDBTDbHKSua58yGfYsxGVW4Xrj2G6CJ4puCsDAMb/wA5QTLfmdaYmOnqneqI5pYQBm0LjPy+RW8IQISPoRd1Fw4oqmmn7hajGFABQqpB6EP52Q9d9hqhuTSLT9TU3yTdaPtTm/a3uImaPfKjb3pQNAznnRvHHM3c/k3DpNzVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Asj2vcwp3CsBfFn2k0hXk3PxIqQP0ePZHgBoavl5Q=;
 b=LweqHFLC6uOKrG5PDha7t9X7YSReAi8NaWVgpmiY219/aqlnJfusuDyZUbrPrQ5qWkx87LVlaupzIy8iWtvBfNUiGaPvuKKNHwX+S6FFxItIv6g+hL5vB8fNTvezDtmY0Cq3FbWcQxLouuOePKgxOgRx38wf0p1cfkuksVT2t/Pfe5IDOihEJRXQd+Rl96o60EI7xwksSQsnjNOP/aNiPpkRJReJIJZkRr9PiQFZtmsH8zxJRv3+7EnHRvu0ejLBRTzG//Mcv3E5ZkErk4SlzQNw/0SuEsnfpehHC0GNPVm52hZrDPCcGhKXI+h/1q5rOs9M8C+5ianXAqrH0efURg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9984.eurprd04.prod.outlook.com (2603:10a6:10:4dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 21:00:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 21:00:28 +0000
Date: Thu, 29 Jan 2026 16:00:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Message-ID: <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c593dcc-6cba-4fba-a27e-08de5f796de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtDc3FHQkRROEhHV21HanNUMEtwbGVDNHMwa1N6UTVvd1hGb2JkWDhFRUpr?=
 =?utf-8?B?ajlRU2JsVmV4YU1SV2ZIMXFVTXd3L1N1UjN0Wmx6Wi9RQTBpNnk5MG0vVnYy?=
 =?utf-8?B?a2N6eGlDWFZQWHpjd1dWRUIrY3ZNSXJuQ0JYeTNnV3lnY1h6Z0U2Uk1Sb2xZ?=
 =?utf-8?B?WWtHWTVQLzhvdW9MWnV5ZkJyS1F1aklhem5UTk5ucWovNTdkd0Vzd1lhMjlN?=
 =?utf-8?B?OVFKa09sMVR0NmZlbCtJWDJXTWdiY3dnajV4Rk9zTkNUdXBLSE84WU4wYjFq?=
 =?utf-8?B?cDhWQXdFT09zbDlQcE91K0QwYkRlTGFuUzBrTkxBRS9wRTRXWmI1MWtUajV6?=
 =?utf-8?B?VE9kRlVOWURqRmhmMGtucFVkdm1mZFVEUWpGT0ovTk5NSnZsYmF5SHI5MGMv?=
 =?utf-8?B?S3NOZWorbk5GbGZaWHlyMUp0T1FhZVluclZEb1lpMjRiMDNEU0lrZkozY2hm?=
 =?utf-8?B?QzE0eW1yQmJuSTdySExYUnFYWktVTHhheWR1QVQ2ZkxQNjNvL3ZSZGpOUE5C?=
 =?utf-8?B?Rm13Z2doTnptbHIxUWc2eEVCNkhQeGU5Q0ZlclR3UktiRFZzRHZqU1NFT0h0?=
 =?utf-8?B?aUZkcWFmZVJiTndHb25qS0xiZ0RvQ3VLWnQrejdpbnFINUw5cTZpUjZBb1Q5?=
 =?utf-8?B?QTFRSnIxUjlDdUtEYkdPam5DcXBpbWE2Qml0ZDRRdWxnd2gvdUhUQ0ExR0NO?=
 =?utf-8?B?VzR2azVIQUN6QXpYbjBNYnRwZkw5R2RqMk5SaXFRSFljUytPb09GYXNXazI0?=
 =?utf-8?B?aFY4cWtieXAwV2RIajBXcEtRZWJWeDBXTlBZbGVPRzEySmxkdTJYc0dKQmwv?=
 =?utf-8?B?cHFlb3JlU3AySWJleWxEWDNHcEY1WUpFUkQyeUUrOFhoU3RHTzA5K1lncHBH?=
 =?utf-8?B?dlI4bVBLU3hsdVRONmdwVFNyTE0yNDROTWxHWHR2cUQzQTFzSmJqUStGbmhz?=
 =?utf-8?B?czVNSkc0ZkU0eFNsTXNpa1NvVkJ5YnUyb2ppTHJSUUorSVdxRnJmcFN2cS9E?=
 =?utf-8?B?STBOZW94dWtlOUZTaHZCVFg3cytZOXZCSTlGTExzZTZwYXMvUm9zZVdDbU1s?=
 =?utf-8?B?ZUFJUjRVa0hzL1FwNnNWYzRQN0VIS1FFdys5MWl6R2Y4NDl5eEE1QnhsVi9z?=
 =?utf-8?B?UmFBMXg2Q0VUSHZhaUFqZkRvZlR5MjdaSzU1Y29DVEtiWE0vVHdmSzlQdnFj?=
 =?utf-8?B?aE5pWUR2b3ZoN3NrTmxJTyt0VE9jZ2lsaS9uVFl3dHRUem9oSlI0WUdyM3Y0?=
 =?utf-8?B?YXBJNzZEb3E4cHdONUJoS2FpeG5rNDdzbytLeEtsMXRsQzMzSHBsN2kwT1Np?=
 =?utf-8?B?NVc5V1BrYUgzZUZkVVBHQlhzV1loakNXeE0yWnh6OFNyelQ3a2tnWGFrdHNs?=
 =?utf-8?B?dFJpalFXL3M4cTY5SVB6L3Rmbm9na0RTNEVoMTBXSUxFUlB5UnBXcnVLdlE2?=
 =?utf-8?B?K3BVZ2dFMU1CL3hPQzBQL0FZY0Q5ZlZMME1rZmVjVUFXcGhmR0xXRG5UWTFi?=
 =?utf-8?B?Rmo0VmJrclRaL2RpMlQ0Ky9pRDcxTUZybUdIZHpmZU5rZEFCUGt5YWRjSEZv?=
 =?utf-8?B?cEllbTFldnloRkZVWmg2R3kweHBFcXRMd2I4cXU1ZFVRRjJ6VzcwS0dZZ1p2?=
 =?utf-8?B?R21OZENCbmpQTXFlSDJpM1U3OXB4ekt4Ri9LVXNId21ZZHc4Zm8zUkVWUzYr?=
 =?utf-8?B?T3pnVzJSM1VWNDlleVJDY08zbDM4bHVETUpqbnNTRW1FOXBmUjRwMW42Q25Z?=
 =?utf-8?B?a0hYODNSdlVvczBsbTl4R3A0TGJSY08waTI1VVd2WkRYbzFTcHVWNGFwYS9I?=
 =?utf-8?B?K3ZMcGFZUUN1Z3FkL3VGTzNJdjg3TWw1aUFLL3lkRmVkZzQ3T3VsRnY3cm5v?=
 =?utf-8?B?aCs5VjI4NkxpekxIcW1GTFlCWnVZNVFjMEJmSHVPRU1Ma3RsaS8rR3N0M2xM?=
 =?utf-8?B?MnFmN3lLb2J4Q29GZkpFQXBZZU9RY2tpcGdIdVpmRmJyVlRzYk90V3cyL1NL?=
 =?utf-8?B?KzRkbFdWa1VmL2IyajZWRittdmVqMkxXSjRCKzR3c3VyVnliMXBiNzNQcUUr?=
 =?utf-8?B?Z2RyQ0J5Zld3dHBJMDl4Nk5NQ2NYd016Vk5xeG96d3JwOVd3WVU4eUt2NmVx?=
 =?utf-8?B?NWhIbDJMelVXQ2lvWXhkeHI0M2IwK0pBY3d5cFlPYUVPa0piSWsxbWpFN1dx?=
 =?utf-8?Q?BXuRnSZrMYl+yn1TLW/3Bds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBVV21lNW9ITTMyL095MlNlNUFmL2ZFV1V3ZmhNMlJoaEQvWkNDVFhLRTNl?=
 =?utf-8?B?M09lT0tvMDRkRHMwMW1qNDF5MXE4TXJsQU1UNmQ3WUw5SHlFYTlJRjJmakF4?=
 =?utf-8?B?OEFUcGQzekpqN0I4d1BSdkRrS0pXYW1hRHM5SjJyS1JzS3A5b1pCYU0zclR5?=
 =?utf-8?B?alZndUx1TENEcGRHN1N3UDdpaWZGY3BoSDNDL1dJVC9RTU9ycXd1TVNyeXpQ?=
 =?utf-8?B?OXRldWprSjlpV1B0amc5TnptNFE0T250amlSNDcxTzhLc1FnRjAzaGdkeWpJ?=
 =?utf-8?B?RWdocWVOekllYkh0MkY4NmZVN2RJWjJsbXFlM3ZzSzVhYXh2QnhCL25PTGZ4?=
 =?utf-8?B?YU9SU2REMVFTK09WWE8vTkdlZUdoOFc5STBmTlU0ZStncHNLaWxtM3V0TzRj?=
 =?utf-8?B?K2YzUlpYRTBya21vTkF1cFhnVXZoR1ZrK2l0WWtjZHRJWWN2a3EyMUFNQlpD?=
 =?utf-8?B?QUkwcStzanBXYVlvTW92OXlGSjRnaFN2RXVZdVcxNktTL25adjQyWG12MUhs?=
 =?utf-8?B?cStnTCtsSjJtOVVQTzN3TlJzTW9vMlUyZDJTSWVIQ1cxYS9mYUpLTWE2Q2lh?=
 =?utf-8?B?SlhqL25WUnVicVpVWGFhVWhiUUx4YWdxVXBSVDRHM291YVkreHdVY1BoZG5B?=
 =?utf-8?B?STBscklBQ0Vmbk05Y1V3NnVDVDdyL3BNRjJGWGlUai9zQzVUV2V5SWZISVZY?=
 =?utf-8?B?NXMycHIrRUVyc3dHTnZkakQ0bFFvTXl1L3hlUWdqMHVkN2tEOW9SdWFvaVNF?=
 =?utf-8?B?MjJJQXNRby8zOVBWZjJYL3BqWGZxN3lLS2d5cHRjako0dXhjSlAvcFhWTVBU?=
 =?utf-8?B?MXlpVm4yRVdkNkViVDNPTHpLYTlUbnVaMkszT1hoVlZMeFY0amlkVlR5bEwx?=
 =?utf-8?B?eUJWVTJJTlRVTjRwRWtScFR6T2dCeGszQUVhRGVSVVIvQnE1TlNrYnpLNnZq?=
 =?utf-8?B?MEdjMjlWdm52YW1sWWNFeFY4MkxiRXpkVFhvUXBMMlAza0NlMHJsVHpmOFlM?=
 =?utf-8?B?TXdDZmZlVkhDOXVsb3BGR2NmN3BTMFpxcEdEMzA4ZzRKRWJ5SnNQSkFNTElm?=
 =?utf-8?B?eUZiUVA2eW1OdXFKRjU5UCtnN2tCbVlwM1A4bWhnMmtZOW1oamEweTdPYUpO?=
 =?utf-8?B?K29KNUxySVQxNDFSZHJTb2hyMnFlWlJUSXdUck1sSEwxMUJmTnd2STZrdDND?=
 =?utf-8?B?UDJlcFlhdEtwSzFRUGw5UGdJR015RjBUV0JoRURhV2h4TVF4bnlyU0FqazlO?=
 =?utf-8?B?a3l5TE52WlFRem1iV0drLzFLWndLR2djcUtneGN1UElPVDRtQkJZeTI0VGht?=
 =?utf-8?B?TWQ5RzV3RHE4RUs1UHIxQmJnNWRZZWlGMmdBSVBJOEFIT0p1dGdtMUxjK1M3?=
 =?utf-8?B?L096bFAycmU1VFB1RERDRitLS3RiUWIwQ2ZPT0RQc3J0TWNENzBzeStGMEY4?=
 =?utf-8?B?V3J6NDNrbllHVnllT0N0TGZnQzZsbGlwYlFjZVZjVEgvVmt3L2xnYXFsajZF?=
 =?utf-8?B?Z1NiZzBOeWgySmYxUWZEd1FDRVpFME13b3VUZHovNHp1aS9UVitTNU1UR0Ir?=
 =?utf-8?B?ZGNvV0ovTi90L1BIOXZPdXFmcW5TeXFmSkxlaU1DOUtZbzQ0dVBEOWFESnZo?=
 =?utf-8?B?Z0VyMUNQN00yVUpyVTVFZGFQUFlUSk1IN01LU0ErMkNNZTlFRm9vdVNjTlRN?=
 =?utf-8?B?Ty9vT0E4RFdCZUxYMmI2TS9vcEkraVRoaDZxZmo2UVFuKzhiVUxUS1MvRGVN?=
 =?utf-8?B?U2huNStmZ3FhOEpGcjh0QmV3L1pUbmFlclhvYkRSbGYxWFVqSUtGUUg4NGpy?=
 =?utf-8?B?dVFTSnlkR0QxNzJEUjk5dzg2YjZSYjV3MUE0b2ltQVNNdzNSNU5DMUNRZEwv?=
 =?utf-8?B?SEg0V2dlazA5amZLc1Z4TnJaNHFyUXF0T1E5V1RTNCtMS2tMZ1pzQVF0d3RG?=
 =?utf-8?B?cnJ1bHpiNCs0OGNpQi9ycFdDRjR5Nk9ML0RSMDRkL0xVN0JaS3REWERpR3VX?=
 =?utf-8?B?d3EvZzJ1WGVJNW9nYzY4TGF4RERMOWRoUzZvVjRTREJMSEV1TExCK1M5SVhT?=
 =?utf-8?B?bG42YS9ZcmtrSmJ2Sjc5OGR2YkRVeUl3YWNYeDBUbytXTzBwZ2VLSWRTbEdG?=
 =?utf-8?B?dzJYNm8zTDA3d21tL2RwaVlrdzF3NmlwZGQvREpZblBuaThoZysxZFQ1a0Vw?=
 =?utf-8?B?TGRadjN2THdESEt5ZUNsTVMxb29FN2pqeDdiMlFxOER6cndtQkZoSDJWREF2?=
 =?utf-8?B?cXZJVzhHWlR2NUduYWIyM3p0T0w4UmpTMG9wdFFDR0t6WXUyU0hWNld0OXly?=
 =?utf-8?Q?FHRJFhkeL5Erbl616Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c593dcc-6cba-4fba-a27e-08de5f796de0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 21:00:27.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akbtzn/zf6PA63PTdrTzftEF6ZO2sWYQ+lctayQfG+YT5AgiCC+/J8PyAo7xl1/jfuOUnNacRm1qlMjWvgGlhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41733-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 80A32B46AB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:28:14PM +0200, Adrian Hunter wrote:
> On 29/01/2026 22:00, Frank Li wrote:
> > On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
> >> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> >> where a single parent device hosts multiple I3C controller instances.  In
> >> such designs, the parent - not the individual child instances - may need to
> >> coordinate runtime PM so that all controllers enter low-power states
> >> together, and all runtime suspend callbacks are invoked in a controlled
> >> and synchronized manner.
> >>
> >> For example, if the parent enables IBI-wakeup when transitioning into a
> >> low-power state,
> >
> > Does your hardware support recieve IBI when runtime suspend?
>
> When runtime suspended (in D3), the hardware first triggers a Power Management
> Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
> The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
> the clock is started and the IBI is received.

It align my assumption, why need complex solution.

SDA->PME->IRQ should handle by hardware, so irq handle queue IBI to working
queue.

IBI work will try do transfer, which will call runtime resume(), then
transfer data.

What's issue?

Frank

>
> >
> > Frank
> >
> >> every bus instance must remain able to receive IBIs up
> >> until that point.  This requires deferring the individual controllers’
> >> runtime suspend callbacks (which disable bus activity) until the parent
> >> decides it is safe for all instances to suspend together.
> >>
> >> To support this usage model:
> >>
> >>   * Export the controller's runtime PM suspend/resume callbacks so that
> >>     the parent can invoke them directly.
> >>
> >>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
> >>     parent device as the controller’s runtime PM device (rpm_dev).  When
> >>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
> >>     instance’s system-suspend callbacks from using
> >>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
> >>     PM is managed entirely by the parent.
> >>
> >>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
> >>     by parent-managed PM implementations.
> >>
> >> The new quirk allows platforms with multi-bus parent-managed PM
> >> infrastructure to correctly coordinate runtime PM across all I3C HCI
> >> instances.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
> >>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
> >>  2 files changed, 22 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> >> index ec4dbe64c35e..cb974b0f9e17 100644
> >> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> >> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> >> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
> >>  	return 0;
> >>  }
> >>
> >> -static int i3c_hci_runtime_suspend(struct device *dev)
> >> +int i3c_hci_runtime_suspend(struct device *dev)
> >>  {
> >>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>  	int ret;
> >> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
> >>
> >>  	return 0;
> >>  }
> >> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
> >>
> >> -static int i3c_hci_runtime_resume(struct device *dev)
> >> +int i3c_hci_runtime_resume(struct device *dev)
> >>  {
> >>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>  	int ret;
> >> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
> >>
> >>  	return 0;
> >>  }
> >> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
> >>
> >>  static int i3c_hci_suspend(struct device *dev)
> >>  {
> >> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
> >>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>  	int ret;
> >>
> >> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >> -		return 0;
> >> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
> >> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >> +			return 0;
> >>
> >> -	ret = pm_runtime_force_resume(dev);
> >> -	if (ret)
> >> -		return ret;
> >> +		ret = pm_runtime_force_resume(dev);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >>
> >>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
> >>  	if (ret)
> >> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
> >>  	return i3c_hci_resume_common(dev, true);
> >>  }
> >>
> >> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >> -
> >>  static void i3c_hci_rpm_enable(struct device *dev)
> >>  {
> >>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
> >>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
> >>  		hci->master.rpm_ibi_allowed = true;
> >>
> >> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
> >> +		hci->master.rpm_dev = pdev->dev.parent;
> >> +		hci->master.rpm_allowed = true;
> >> +	}
> >> +
> >>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
> >>  }
> >>
> >> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >> index 819328a85b84..d0e7ad58ac15 100644
> >> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> >> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
> >>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
> >>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
> >>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
> >> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
> >>
> >>  /* global functions */
> >>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> >> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
> >>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
> >>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
> >>
> >> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >> +
> >> +int i3c_hci_runtime_suspend(struct device *dev);
> >> +int i3c_hci_runtime_resume(struct device *dev);
> >> +
> >>  #endif
> >> --
> >> 2.51.0
> >>
>


Return-Path: <linux-pm+bounces-22654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BAA3F78F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD81662D4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051A20F083;
	Fri, 21 Feb 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Tyg34uuU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2101.outbound.protection.outlook.com [40.92.41.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9720E019;
	Fri, 21 Feb 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148913; cv=fail; b=OOs/UEuvC7QIkzOETHbK1An46CjP2a19dADw/I2L4l8ADOlYxlEr2XO/eZy8VmkkrdQ33gwe9M8RJYqn1f6pnGv1I4xEBcvfbh1veOCVrfKSHX93rdRN+0T+373oGRvVxBIE9tnRqw79xSjh+sCVpzaBrea+5YKnEAjUWuW3aEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148913; c=relaxed/simple;
	bh=EWwZn18a0W6gceff9fGC2k1TW01FKl/RBcPefwPz8fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ApW+acutRPxdrmkAhvtpqt/swSMfEODXIM/ocJfdcHaY5nkoPPbQOFzwd6kupOL2wTC1EqNcXRCRD86E7KyBoLeO/2nVhB6ZoQlhGg7L2jTPPbduyTsjefj3tKS/M3M5EB14mGtFiB1u314QHgbIe/HWUDu2mEGDnCCMjOgcaDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Tyg34uuU; arc=fail smtp.client-ip=40.92.41.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkVYFzQYEjQU1AaY+6rZjlIjO6WhgUe6/FdY/ltFEvImlAIq6OowJoX3AyIoGVx5V7MZz7qpdSQ344SzqkJ57tdYno59ClArRzUrAWRzNGNC6XXdsKEaQxwORHyzcZb6lzA5EK9o7B9ScYmzOekUr7xW6uugsIjma2bGyGGOnxajQ3YHKrDji4ycZ74mpn/whJ9Y+tbt1hnCUjOGrmP/9i49KlQgPMh2ia4qErZCP+vMyDF66GTxXpyCTheenTb2dRTy34PSYXKbtsj7nFbAxRLjW3y5TSLlZGmuARWQiwoDVo6f0dfE2eVikUitaAawRJKRwJgNDsJgoQjBsp0w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWwZn18a0W6gceff9fGC2k1TW01FKl/RBcPefwPz8fI=;
 b=IKCaePr2ry4XQe5kv8C9bjBKPRRPwRmYKb+thYQ3AjoDxeuhzQXq9kYY/XAVPIsXmp8GhjuAThK1TOAaC9lV4kFYgqlP/w7eNukgwDBA642GmGLwSVOlrnPlbiYURUg49zoAp/mb2QAKFLdcAnJN3ys2BeEJpAk3giJBqctqL1msKV3vvUmPJ97NegwJBUp0Zn9HtdGXSjz5cEX6tUD3k/mhXD1Xn+JcfTYGgJ2dmMmIVLw5e/MkRGA8NrBwjHyOefCuJGGE9kB0raGtawd0/dZiJgr0AerSQc4GkD/Vdews/sRLt8HcGKl+qZE+lvAPU6FC8C+ps4iYVOKThO8jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWwZn18a0W6gceff9fGC2k1TW01FKl/RBcPefwPz8fI=;
 b=Tyg34uuUuK6veku6DgHbJqg4dYJZrlSt4oNc9z2QAbSRXSVUg/4N7ABjtb5MDupC4CWulTxoY+RGprhmi1XHtZxFGLlXYeNt3GEnbHe5NV/51zTTGibW423vI153ZeoPfOXCSrsBDuDzOjlcoOi6wjUPXE0e7ciROFuvc4igCmX0vfwnWEXpy3Fg6NWDynzf9HhaRzxJV2LqSVSNuwvcrQwY+v3ghJpnRA+Nrwv5JnZTfR7N7MPASvuhvYdH32NcqZ4SK49Prc6k4hmvvVmfsu6oFYh3JRrKBzRGI+hMBoB8P5m1aLfmLAyTsf/0OP6eYxvHwbQPgxMyvAbyaGji4A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SJ0PR19MB5368.namprd19.prod.outlook.com (2603:10b6:a03:3d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 14:41:49 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:41:48 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: dmitry.baryshkov@linaro.org
Cc: amitk@kernel.org,
	devicetree@vger.kernel.org,
	george.moussalem@outlook.com,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_srichara@quicinc.com,
	robh@kernel.org,
	thara.gopinath@gmail.com
Subject: Re: [PATCH v4 4/5] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Fri, 21 Feb 2025 18:41:44 +0400
Message-ID:
 <DS7PR19MB88835F4120912ED00626709B9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <hmhagxzvumlmzvnbw533ebzilbvknexarsnxjfwi4djq3eabkc@efferfxbxkt3>
References: <hmhagxzvumlmzvnbw533ebzilbvknexarsnxjfwi4djq3eabkc@efferfxbxkt3>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0034.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::21) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221144144.10839-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SJ0PR19MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 87506194-0a4c-4c37-bd7e-08dd5285df0b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|8060799006|7092599003|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5TUBEgwx0DjTzmrqM39g1W1i9PmwuEY6cCv8zPH6Qj2LSlyzIIWJP7PukoR?=
 =?us-ascii?Q?ESAQGh/iX3YL96c75JTgLZ62QSpU/AoQOt8CU41G22ObqJonDUfb7u7PgT79?=
 =?us-ascii?Q?19f4CWYV9xCW7u0JoMn3ZbxUIaKGMCoeGsE72pUA9siICQ1RvkNZFEzIyKuo?=
 =?us-ascii?Q?YJzBcRmvf46pOk4HlFFmA0YexqORO5QyRYK7734JBIqtj0zuN0zq+HKfi3qS?=
 =?us-ascii?Q?P0l28gAqx0sKhIRYnzkuh4wZNHKnsq3CpTKBHgb1/lYEin8zaCakSFK3FCga?=
 =?us-ascii?Q?3jV6NRQo/PaMsLGexqlmyYqVennv8582W3/2JauYgSE13KXFi7pK43P8SGmo?=
 =?us-ascii?Q?YVfg0NdCxf5tRb5/VYZJbF/IQ++TtlyXsk+6+fBgF7IygP1nAH5p+vBtoQNx?=
 =?us-ascii?Q?qJHR8BDMvMd/vkGguWagW/lY+ILeX5yZap/lYDZb08GV0Jss1B1xvBHb9ylg?=
 =?us-ascii?Q?QN/0JtfAWhqWSKpieZp29wy3QAReo8seDoF/vz5iyBzK7k4aIU/JQe8D7XDe?=
 =?us-ascii?Q?uN37vwr6dlLoQbKuMINM//W7jlURNGapnUKtmen+dcZvKIz9VwGGB0YEUGfP?=
 =?us-ascii?Q?UoNmriqCDj9h3zHM0ihABi9T3SKQ11MMd1VdIAttk/x+i9nAXp9EIMy+8Gy4?=
 =?us-ascii?Q?ze/n0IeB9GfMggPc3WVnnS4Yqxq0cVCUWmw9rg926V2vc2dqKvrQoZ6ieV3N?=
 =?us-ascii?Q?2XrXpII4Qr0twaV3t7ZI3OsmxdyQJu7Cq0jlg1vTGaq9EL34YLhoYdpBwDya?=
 =?us-ascii?Q?XEQQw2i1VW/337sFkPQt4zjGElJwYAAWadmesg8+qijqMupUsR6NzoVUe2IL?=
 =?us-ascii?Q?O1H3g8NxezQhJhmS9549cj2BzP5EyJC+Q+qCyYPpn4WV1bQsrbk0SXlVMBAS?=
 =?us-ascii?Q?AX1bzJ5K2ArJGDHeAX8dRIoUnyOotoDUdMoeOjGA6mPTaraAa91PAMxr3WMf?=
 =?us-ascii?Q?kbPHpGYBRIhxED33ExP/ZUH7nAxyAyXQB3b9B12NMHNt4bj3Eyiez88Bw9CQ?=
 =?us-ascii?Q?24T9XGMWHiuFUn91tzjt3PAc1noYbebuC1MnIa/3w0tZDbvhIkLc7o8ZPuv1?=
 =?us-ascii?Q?EkDq1yLlxrxjhBopdlKNJaoQ0IFpHDeW4jCEwk9//Nrs8o5kKqg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+YXRR2AZCvjMZwzeV++LYiohcsdba+gd9/1cDuFMYI1wp03kPQHuUcc1Vmp?=
 =?us-ascii?Q?4wmyCsrhNtfcJ5SfDDLnvqPfEyERr3dzIu3xmZ0WYIEuH95KwSz0FV8ll+Yo?=
 =?us-ascii?Q?kkLaoxioZIL3A6edeWWowY3yoJIuuWN2YIjF4rKYaFMIuRWYsRTKSAvXiYtY?=
 =?us-ascii?Q?OyqldnChBqJKjDugLGaEbUVg2CpHTesvWu5RyiPfQ5l/y4G8tloAWnu2hyVG?=
 =?us-ascii?Q?3j6Cj1u8NbAv8UcVxFp91gOABbcRC3lxhW2x1fxpi+b9ypVHmS2dr4C2J//O?=
 =?us-ascii?Q?I33faPfAIV1PTJczOzwupNfL1ET8zMN32X5MHYjUanhrH1JRoXBQv2Zymy4O?=
 =?us-ascii?Q?e1JoCyX/wdMDIE0tYCSJ71gqrDJ89eFEIKQJ9M1dSy4MEE7m7m8ahBEYyNg7?=
 =?us-ascii?Q?Fb31g53fr8db+ile9qVP3eI4wkVRgKxkPBjsyIr3JiMRsEUAbY2qNLFkwYkA?=
 =?us-ascii?Q?st44c6/ARhcLAbkdDBSVSH6y86zgGxuOzd6EUysIpPGZrCLLSp7dQWZw3h70?=
 =?us-ascii?Q?imPRUfXO2/LegnfW1xkdF6NSIJ0SGA139JPzGFapcEc8iYmhlpslMpLR5OQi?=
 =?us-ascii?Q?QeI214MyB9zru8KHGLRx1FPjxuMC7NjHfl1vLZJdxuhJGSDgKKG5ksoHuNzk?=
 =?us-ascii?Q?uwW4AoNPLBmoVCGTN39LiL//6Or3vIcr09NPW+yxPRkt97zFJpOL0szhs84Z?=
 =?us-ascii?Q?PJ7Ut24FGE5HROCcBT4jV/CV7dVhRO7bL8+EcPM7dndqbM5FL0LOIHMNZ0P2?=
 =?us-ascii?Q?krJ5+yK8zg3ziIrO5gNa44DS4xPG8swUKE+mZar8XwMoUpD7/X2q3sRof7B6?=
 =?us-ascii?Q?LbVPeBZqWNh0nMaKhKZ9NNz+d/e+fZaW4b5ezwEI23y2rUiiKoBZ5zcgV5oq?=
 =?us-ascii?Q?mwrx4LhfeSHaQDIUr1wUnYc5h0s8Q7WWT1HnVfGTTrwZuVpCjr6aqULc2Ajn?=
 =?us-ascii?Q?Ac+fqovagP9Wsmv4Fu46xY547YzLvEb2q4P8AUOpljy1Rr23tC/f6v/Adik6?=
 =?us-ascii?Q?+NZ6kK049bQoIFdfkSp5U39X1sv12uEEPnOpV81AckVhIl/zGTYGXiBVrflD?=
 =?us-ascii?Q?RTW2QixaNc2KtWWrlWapO0PZILJ7OTuG2hpyuwTPlR98hwxsVyL7wsfVqTBA?=
 =?us-ascii?Q?c85gDptH3r/ip4VigPnipAHPbw8pU5OevqcUFlYTJSeIKwM7/BPqmo9hQTKE?=
 =?us-ascii?Q?KUKbZ14s0BowCggaLgn6uF2MI03ozT6SeDJOz/hj+qLoEsqcAYjx2yAMTFgR?=
 =?us-ascii?Q?AC9YW+JwstsoWXaBR2gt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87506194-0a4c-4c37-bd7e-08dd5285df0b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:41:48.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5368

I've just checked the downstream dts and driver, it contains 5 sensors,
but only 4 are used. So I propose we leave the number of sensors to 5 and
adjust the commit message. Thoughts?

Best regards,
George


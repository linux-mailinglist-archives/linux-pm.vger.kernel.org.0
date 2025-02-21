Return-Path: <linux-pm+bounces-22616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3523A3F171
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00DC16C56E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B62204C29;
	Fri, 21 Feb 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rtwii+yj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2106.outbound.protection.outlook.com [40.92.18.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6E204C0F;
	Fri, 21 Feb 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132511; cv=fail; b=EHjPCFRnlSckige28TsIWcmRS1QMkmWLU25ivq232M4+YnHmEab/Qsf2A47MCdpmiewf7JEIj1mGjaX1TYIwYyKbZBeAAHS3d9lxhQQLE6V4Dt/do//SkEEwsn27FVIlJUW6w6uJv4X0Sl8BVPYDu3l093tJnbQ4egSsrEkGBgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132511; c=relaxed/simple;
	bh=BeUhUh9uCPxV/P6rPkRwAik973a7bSac7R6Drbpttvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekfZ1opCMXpngMKv3p2Sa9nfaGiHYoBaxWxZ5a6lINUYbrWmlBpGqwPI+dZMjqAKC/acF4sJmp2thMe4r7j2PcT7TBIpTtD0gp2G5lO9WlceceK7MCUWXccN93Yg1hdqdC8Xue9PDQ5SUnFohH9QWG5OJ/90aEGmiz5ydPg/G1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rtwii+yj; arc=fail smtp.client-ip=40.92.18.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9krUqcBa3miiA3aVC21qOlrarts1xT4g4g/8LfS7ELOkscwm0i79sEM9TMW85ScSPG0QIOVu6EPud0Gkzj6+eyw02UUx7LaiBxCnA2Ea+Jf9j9X3oUUlIZspLulzaRGu+++45jBLFAQdWxX6NQ8MVAFnwk2yly2fjqvOVRA7wwv8jhXqSPhQNnUVdcA/ITWOVvbgW8GmvX37M/NT9Qxe6k2aWNPhR9aLhU8L26sMashBYj6fYFLeNvNX5B64o1fK1E7nOGcQrAeWgTn0Eg1XPiDJLVXGXUDI7gCCTV9QLdW1QFAGFn8awY6znlyT8fc8guzue7uuly7aUkqVW+9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeUhUh9uCPxV/P6rPkRwAik973a7bSac7R6Drbpttvw=;
 b=EZSzhyjO8DoeDTK9dbj53qzMoLe0G9n3BYaJVftA+VBiMqTLcBR2bpjTKc6fwUKG0v4c9TIJ6e1CfxfoZCD1Y8hoC4etiCer8KXWCWOBfV74jGSGvUHI6AfIXLxYGJyKMF+thiSW5oEFWty83gfHvcMs7U+/tnUcdYuQSz8L9FH73qhW2PnR8gVasNBhtvlQZOTWpK94xXenH22NIakkp8GTBOxABRPcsByz6uHO++q7LQCrUHm9AEWIgLca5euj062lZnQvrmsGM5n9XRR4sjEVd/oARjXBMSDq5PnB2B8OZDRq4fnuRvph/8lDOu048dia6PZnurRlSOhTFm7jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeUhUh9uCPxV/P6rPkRwAik973a7bSac7R6Drbpttvw=;
 b=rtwii+yjwdW67B1cbYjzrX7Jxe+hdYjn4q3EK7/cIbShKBrtKKx6OH7qQUFdq7rxo7hahQXS5HhXNQ+LZH85SNjisjbGa876/mJ/jEqbjTQHOHZLLI+FP43QfjOYvQVyhtdQeEOIX/ut20e/656XWijP2XvrxsStWJ7bLpsd8pwuWE9tSZ58SK3zd4vzsfOVcZOWGjbOyNwG2yH/N3QVa9SEv73N2+RgZgLU1Z4LtmvRnYzEbs70021de9/XLk5tqfDdXs/yyyMpbQzexPWjCs6qNOHCu0DbcLVEkAcvPutAQo0vf8eXl0H0LUfJQYn4jiycomrL8qTa2EfAgkkeWw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DS7PR19MB6278.namprd19.prod.outlook.com (2603:10b6:8:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 10:08:21 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 10:08:21 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: krzk@kernel.org
Cc: amitk@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	george.moussalem@outlook.com,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_srichara@quicinc.com,
	robh@kernel.org,
	thara.gopinath@gmail.com
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Fri, 21 Feb 2025 14:08:16 +0400
Message-ID:
 <DS7PR19MB8883297DCD342BFA68E4186B9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <4420c389-e53e-4f10-b2f7-7a5429d282ce@kernel.org>
References: <4420c389-e53e-4f10-b2f7-7a5429d282ce@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0038.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::15) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221100816.16721-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DS7PR19MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8e6d52-5c85-4408-abeb-08dd525fab44
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|461199028|7092599003|15080799006|440099028|3412199025|4302099013|10035399004|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4ULMQAHqxe5uSa1GdGiPg/mieJHUGSgCYpe9Pp1L0uHxBO6r02KprGIvz6Q?=
 =?us-ascii?Q?UZCBnFuKoUcKPEmXPmsCqdtI0dX5Wnm6+u2up7GTqYS5/HBQtOtZM1fVt4LK?=
 =?us-ascii?Q?reI5eQOmV0SpY8X0/rTyaQwHAwbDcFOGessZkoNdW7jfbEqp0BISrjDeH/Wb?=
 =?us-ascii?Q?QxYKp3lfV6R/cZNvu8KRoYHNSXmqCsjRAcEY/vx8YGNHWfXEmXZhmlqECtC0?=
 =?us-ascii?Q?F99d25wYm8oN530IzvpVRp3bodZMEmuP3BGJI3M2dAWe7d9zmv1yG2FSYPjO?=
 =?us-ascii?Q?OAJsacdbE5AKJrSk1YfLGm8tG/ht+gWLw0UoJl/5vz8lsuQJg/xTWda7BFgL?=
 =?us-ascii?Q?tZCyRP8J+ymfdGUESNpf3KJHhd3qVWJIaQ1sIaSgcpIB+Sj3M6bsMFfbKDnB?=
 =?us-ascii?Q?xoeKYp5mpJ5i77K33Aw27KI6KtrvWQXWKhauDCwFohaGluzuGP94nJG40S5z?=
 =?us-ascii?Q?sN2KJpLstluOaPIVaEPiYQUP6SIrfyaBDTu9re6zM3T8HJ3N32Nf1rWbgi8c?=
 =?us-ascii?Q?IDxGMuCo3gj8t7aEzCcUY7gWJd1GdM8iCNFOkXCa+pYZMAn2YuyRZlXI8/3X?=
 =?us-ascii?Q?doEZziDpBTJmvzjmCUnVnH7X8TBWdHL8nBmS6aiOfs0iuNakHVDIFPFbWDK6?=
 =?us-ascii?Q?eqPBX0myB3YAUNILNyA+22hICZxl29DgMaDqKBbGNuOON+XFR6WrGvIx5vT3?=
 =?us-ascii?Q?ExqNR4/JbcFX81zdUMlUsLvEgr0Nyqen3P75ZRm3Ini3Ba4XjAdJElvIH9Vg?=
 =?us-ascii?Q?eV6HYNpX4m9W5/whmPc8kkFFVnaDF5hTGnXOpNPv1EX688/1V2+z3eHrB6Ib?=
 =?us-ascii?Q?cCwyBFKDujm1lrBRZUdCpdqVvUhozXuZhaQ5xTqL42T1/ROaq4ywxZyY+elt?=
 =?us-ascii?Q?K5ZLawCKXr069RzeN/HoxjEzZB/RugBY3D2OPwRQqqGkEtGwMd2Llfo2dyr3?=
 =?us-ascii?Q?t8TfiDoC7xfl7UmSeFD4rACjufbTl/xfCea/TaQEhHse2NQYJPJWWFhBRbjd?=
 =?us-ascii?Q?9U8PcqJCDo0dIFNhDXKEKG7rlvpmFu+v2hIKHsjBvUDRGBCBCLRiA1lkJoyz?=
 =?us-ascii?Q?7bt5XlALYWV8Xo0RQs8pFiwUnqwul4AaeCFz/1+6emFNPIBuo1KzqKAZ4Fpq?=
 =?us-ascii?Q?RWE8SEolzYHCfPGpM9w28sEU7EaVJMq3WQsPP7WjWqHwwuU89pDazvvqfW9v?=
 =?us-ascii?Q?IrSlU4X1bvzLDw9U6sunkWj1GmNcw5/XsqmnZ4vnYuIgDuOX51X3WQakDDMc?=
 =?us-ascii?Q?14CWSqKm6gF3Zi+QehAd/hNO606QNHwwnch7IHm/xA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3EGUA3D97ZI5r089VhN5rf1j/YQ2VRWTBiOzCN2YSfQfyr9b0WdaiIGOx1JF?=
 =?us-ascii?Q?oq8BLo/E71Pw2lei56qlrPZNRM7qqtJyq1sJ1HDhXhFi/LWsYqQIdIpXeonn?=
 =?us-ascii?Q?aQ2QlcLvpjDtLKVc+YrC98GLM5WLQ5OnKHXv+wG7b60PXSdXAa1WGv0lkIQI?=
 =?us-ascii?Q?iwv7gEyZ6EW77bp4DF9qOVz/ckZYm06HXJQxFc3x0XK+quL1xadq0nX6esrw?=
 =?us-ascii?Q?pQ2WZ3/fJsHUYM2I1oaNj2tvkr9y0dTBdotebKiP7HcBxU+TTYUCxdD8hgR0?=
 =?us-ascii?Q?mtfcshM1UYGN65k3JVA2ms/sbRjLZLSNxQzDnkmtpEJ9PxPIuJ2y0r+2BLsn?=
 =?us-ascii?Q?ZuTy76lyW8y4aS7AjmZOzfFJABKX1+zkOsV3EY1L63dXdhDhYGVlASmNarH9?=
 =?us-ascii?Q?NOXe1pdmJRg1J6DL6X2728Ye6k3iPPpu6zBetcZBEoGwLTuMfTh7yhmCpfPV?=
 =?us-ascii?Q?rnPiMl2DNg6fjPzPz7sfNxQrDop3iWf5bZqf+2v9r1rWU1l6VIKp6OumwRhZ?=
 =?us-ascii?Q?kmdxFiHo16ijHW8x2DpzNKPWgfCRkViiAQJ3VNrtMGykD1jwxh7ZY7MBMTt1?=
 =?us-ascii?Q?DYv+71jwb+LlbPHBvXALHzQPBO5wp2/Z/1foN1V0Mxp7Xb5wuk08n0mj/rfJ?=
 =?us-ascii?Q?81Cn9pfzZo1rMawKjFQefsDS8DjzMzKcZquXehurNQnGrkalA+5cVBwg0z3p?=
 =?us-ascii?Q?C6yX8iEwmV6dIytYYXfRLeX3AtKULIK2wJlNi2dTcPzs7Ilc3n1R6cAfGVjG?=
 =?us-ascii?Q?6OqZdrZXJQ49w7X8x7lVPKuyWFlcoI1Zcca5Q81wyFOxxfXnsXeWF+oK1cfM?=
 =?us-ascii?Q?2cENbFeOJfCbkkzXwfHgG5Cr+4Gs/mRjsMkHsk7v710Blg824keG73EqViwC?=
 =?us-ascii?Q?wI+tLSO7kJlJKmoohfEGrxqGpgdjuch2aHgJA948hNR5/Ph7kYpO0piK0Ll+?=
 =?us-ascii?Q?V5nfzZ46ABGWLnm7iiSZY/0IaET4cibfIejHFJhBkF34PZ9DTynxYsByfl30?=
 =?us-ascii?Q?y0vx2d6JzGsMApLBsDCiW+1k8wVUFcMa0p9hicrZKUZf12MHuhdk9zzfdU56?=
 =?us-ascii?Q?c9yrlF4Q1NHOH1PDdTR+hzJN7MiWVcp2Pju4VeYk3kgO+/hVy/Vrudoc9onn?=
 =?us-ascii?Q?1YPjjJeIvl+XpNvtJYooqlSLupgnTjZfaeo6gRdpO5uIFJ/jMwX5PjkeL6L1?=
 =?us-ascii?Q?pWZHpoe4c+ssHQJUwrgUUhBs1IbNp8vjEZk38SmC4NZ+wSbX0F0+Q2VKevZm?=
 =?us-ascii?Q?RolZlvP6G40TT1mIKb3J?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8e6d52-5c85-4408-abeb-08dd525fab44
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:08:21.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6278

I can't speak on behalf of Qualcomm as to whether they've abandoned this chip.
However, there are plenty of routers/APs that use this chip and support for it and some IPQ5018 based devices has recently been added to OpenWrt.
Hence, I'm picking up where Qualcomm has left off and would like to send as much as possible upstream for mainline support.

I've included a cover letter here: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/


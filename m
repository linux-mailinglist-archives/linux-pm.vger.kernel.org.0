Return-Path: <linux-pm+bounces-22652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C8A3F6E8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6C3BB45A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6420E339;
	Fri, 21 Feb 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ex7YmK4/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2058.outbound.protection.outlook.com [40.92.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA89433DE;
	Fri, 21 Feb 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147200; cv=fail; b=KvuYRXhQ3UZHBc5bQIhMMW7bpvLPzJpNh42QOse9aHd6kbpPaYQsQ3qLmxM7CE5Wf5htb93nPm9bTvq7ocZFLnBFgyYryqcIBkeVcTyGtse/7LxEvB3oZNQUH09gHTx1DAewEGb9FgluF6LTcNzmMP1Czc0KOIPRKWJ0W+xMUaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147200; c=relaxed/simple;
	bh=hhJc1VEzn2FXcR0EiwWQtVlnCIZzMbCPadUS06Q/X7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=doIz+Wto8vtqlyg/Icl+SYRT7U8f/ZJe/hWhR2ALUERXJgAmm8TfWwP8Bfhx5tjqz6n+pRGnqjdE3+0SFQW3bYGToLn7Go3wxldpRd0Xur3EjLiXqNSY727eoPg1ZA0Sq+AFIudydFrvp5GZ2CmWLRL+mOCBNtG+620yH2O215k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ex7YmK4/; arc=fail smtp.client-ip=40.92.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmz/lYSlu3tb589I87RoCHgxYt6KvA1judyvL1yRoejYqK8ICt+HdZYrh3ilRfyvwJ1w2MiVK9k07608zbloIJMrzmpJTEJgYoHteSjmRjxblwZQhwgElUgs9c8vWQ7We/JjhomnGFCQ8ZvYazb+PXylkCbYvKLDLkSK4NSotUTkJGlfGt4oQc6ZbE7nuSmcPvDxb5JFctCnWgQZx5EPWj2K8i7Ja1Sr4Qgc8V5rPsCSXha+5yBSe2zKLHux98UTiLmK/bGw9W5TIzs9TKrwskP8U845ZzzOtQLYv190UqH5fFgit1x6crd7UJCbsyeTNsElnzzzmWchTTTFp3tTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhJc1VEzn2FXcR0EiwWQtVlnCIZzMbCPadUS06Q/X7Q=;
 b=u9cghipuOyAqoZrAIwljhg6asgteVuQqdqk2Eal2bcF9/PB/8hjf2Sw3XMjUOk4JMoNuBJTHhvdOuzDv5x6YFoKipLWXVaMrhGbH3Ik4wEYg0u9jb7CdJf/Oxak2dlOa6vKGAAgBRUH+mOSHOCcox6mBLNOSwXEL3cMNCci+dpr/wNScPNqSfeUfDOQFbcN6GS/AB+WL60Vpn3IINx+omKwUVRBRcA3ncRJlU7pvQZ8G2saJu5uJJnWbi9V37RoRmIZpe7aysp+9/jDlmEdakqwO8pjnfQDSvkbchJU1+KI/Mhr4Lt3lBcxBLnm2ItU/xeiBTLzkJroO/dVudIpGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhJc1VEzn2FXcR0EiwWQtVlnCIZzMbCPadUS06Q/X7Q=;
 b=ex7YmK4/VsOv8vg5+lT0iknTuRoMddjB+OfujGeZSjqYRs4KS2+Rp9VRyDxUVYynIal/U5/rWs9HwdrN39lHGsxML8LwIcM4GvPaFTHYQzq4fFduzX83rpWVob1UvHt7ZcDn9LUkKEuwao1HlgJTa+4TMaoU+Eb97jqtzKUwPNtHVD3TV8h94/TDtYpj4gVB7r9mhPgdUFBkOJEt8HliTpgUn7Eo6Mejjhncvuw9ZRaVbmQPbeXDsSZEbk/2FvZf+fKVU3/2RuDpq+Ljjhfr4Z+c4wG+GtYNR0hUnzHR+bIUQs169e0mUMN3Hh+0gNYS52bkoZV6OXkPHqKvBhUcyA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA1PR19MB4880.namprd19.prod.outlook.com (2603:10b6:806:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 14:13:17 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:13:17 +0000
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
Date: Fri, 21 Feb 2025 18:13:12 +0400
Message-ID:
 <DS7PR19MB888370DA2FE2AE936C47C13E9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <zesif5ehsoho3725k4xjqhb3tizj6fj6ufocdlzd3facj5hrrt@r4t5hthvyp2p>
References: <zesif5ehsoho3725k4xjqhb3tizj6fj6ufocdlzd3facj5hrrt@r4t5hthvyp2p>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0014.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::19) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221141312.5022-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA1PR19MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: ef12ec26-fed6-4566-3b78-08dd5281e303
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|5072599009|8060799006|15080799006|461199028|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1n4LIlse0pGHyjDiIjPRvp0Xe35KCCccb8H2fSiN1Y9hfTnAap9suUWxUGbV?=
 =?us-ascii?Q?uuqMEwUQMgRfx6yemoA4r6wcmELsSGQmGC7+gzfYdfxDfbypiRVZ+PeplTv/?=
 =?us-ascii?Q?eWt5QdwDsHCm/cm0gKFEsnGNQ+xay8pIYiubl3TclU3hqQFH+phW8I8LMcAN?=
 =?us-ascii?Q?z/dKsdbRK/WStQm+kRwQC5GnU5p6PWR1IAD0H8bdEPZXKppbTrwtFPRfyU5P?=
 =?us-ascii?Q?dH64+OREbmJxn9mFdd3Tuuw5IsAzrqoFZP4dJ9O2vmomn/dUUWTjBRMB4Tgj?=
 =?us-ascii?Q?CVejHPjQgXfxepaQT/o5lTUT01gkKaXOTXKRUPTqMkJT/6tPEAppEpICsQC1?=
 =?us-ascii?Q?VVmR1C3FdBImT6VGf9YOrtj05h+tyfPVMUz2it1uFo/vKnJb/nAZ6RT48AwC?=
 =?us-ascii?Q?/+tJXpck1BttPwDjQwR5e+7hSmDYhWROmWmpcxEN9wKD5xiwxF1K3reqlf13?=
 =?us-ascii?Q?ESfdeYmS5NaHHqHGDCJAez0FIxn5s1r5uRBoKvp4iHdYYVSazo5knQUk9z4j?=
 =?us-ascii?Q?aGadfK2SY5uCzjPYfjLVZqCruEsfOZQMVhBWUL/ke06+/7PWLtcvcc5ysHcM?=
 =?us-ascii?Q?YPFtkD7EJu7hiLdsvs6/jZ8e8kmJKPaLOUrWQ5Q8/d5wlY9yOkzzajoYQx50?=
 =?us-ascii?Q?q7jdLu/5mJXTzDovh8hEOIK2f+UTfRzMipUMKLloLGEv9f9hFJ8zvQ41tYtt?=
 =?us-ascii?Q?njnfWjZZVUPDIE1b+o7yAQLigT02Nsy1dYVyqSwMUKqYzsPdQbkIva3V7Moq?=
 =?us-ascii?Q?sAyVi5x6JkTjacTJtr4A6+EPwfFRELUAmPR7lUTl/z+oxTJQ+sGG5nR7aIKu?=
 =?us-ascii?Q?ATQ/KaNVDJKlv2qvVT7KaqbRP4XxYrqMP/WlCL+XIy2sPlsbiNoGZJvmsOB8?=
 =?us-ascii?Q?X9gGHz/g/7HBhc7x6i52RcOIMV8EcimLntwNIswxyKf2iTvUWlfbaCt1uafK?=
 =?us-ascii?Q?YlP4yUPVWocfGoPOvMWDwRWvkiO6fFnm37vPAPXUAYx95Y6QWoA2euIsVN5Q?=
 =?us-ascii?Q?BZlMtc+kDR6zxIPaoxIq17Z3S/DBvwz7gZn9wXH4el9ZnHmXfq3C6YU9ospD?=
 =?us-ascii?Q?9LPqpUw3xGXfxrZ8jjc5rpiU4zdkE7p2GgGDQBNtf9J4hCtwYEQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zsTg/IAD/S0fKpm9YkZCdNJIjweiRCz9iuCj0HFlHwjKonpBtvhxrMHRodx2?=
 =?us-ascii?Q?/f+U46TkfSSUfkr7wdt5m0yTcV66WH82tG8/x/4bNGgGixmMEycRBaf2uIHt?=
 =?us-ascii?Q?rEX/bIXnObH30D1CZ0feEd9VtmqJ2wJMuDG69/YOmVTSmigIrqM6rHoukpqT?=
 =?us-ascii?Q?4a6qE91qlxqj3o6tEII7Zy3G5aVE2gmTbx16Rn087lJnYTVTmokK6CEgmJSY?=
 =?us-ascii?Q?sRPWLwMr0demqNOCTgSawn2uYx/v45cK48G9/qj/dEg6jj2wMHah6tBPTPzL?=
 =?us-ascii?Q?/rd7/SP894OfUE0MSRB0WOZkNZZeg+Kg/M2QUYxNrLnpfcgBr22iBYZdk4bt?=
 =?us-ascii?Q?/nOpIwgq1R+EPLPMlCBq8QrTeg18z2/4xtbhlPh9DFkva6G5GI9gKw/p8wdY?=
 =?us-ascii?Q?s1/kDJkxjvrznu5VD85qyzoX65K/j/PvGcJKdyPJkERfZUCy2snCWqdhtOIe?=
 =?us-ascii?Q?aGCOqNYB8eagvdzjoi/QPX9lqWyliuBVM8eB1bGdVLf7hlZJcoFg7EQ1EKWM?=
 =?us-ascii?Q?Esz1JgUYcdblYiuBlRdbUvqkQOChIN2zmcbCDk3KUDokSUgl2JuKVJt6/obe?=
 =?us-ascii?Q?Dpdzw2NBNxZvoG+ySSQgR1tF2PkFded3o4hZRv7ZCwv/HcuNhkX+fX08jeWL?=
 =?us-ascii?Q?vCcyKV7tLLlCCbxgHHJW6PVTm4POdabhEq3es9FX/X8cbGhU9gyJhRlvCpyp?=
 =?us-ascii?Q?pCYxUy+ITjAolzyDhNIRhh3pXwICFcjBkWPWJPwjWZs+gK2AIN2CXjy8ZoCk?=
 =?us-ascii?Q?MDOPdRAJgTzlaJx/Nt0D3MFuE6COB8cNRA3zfHZWO1XLCLamTymr1sNgbad9?=
 =?us-ascii?Q?gvsSEz6O8kXnr9MKLAovrN5u/UxcW0IlwJd4ufmkHN1eGoY+WmLBztepOtS4?=
 =?us-ascii?Q?NMgGnePwHfiNLFaHLuUEq4+rrm7JjXaN8Ts5AVYYQ/Hw4y9G6yuBQ0qk+i5Y?=
 =?us-ascii?Q?Y8f6BvzJ4DyaToY1sL0YWWKDCEKyh6someOXZcXFRuVHUtahpF0whwWszfrS?=
 =?us-ascii?Q?t+fSYaxw8ppxJuWttu/lwWrHZzKkrlUBPXwXqgf1I7Fo3GDK9aH2CZR+wXht?=
 =?us-ascii?Q?F5wilWbbGFOJbnMcwgZYKrO9XjrrHYI6QoktJwsp7EKeUes8aNgzffU+8keO?=
 =?us-ascii?Q?mAse9OHUAN3WAkZ+hcdrCS9TlkFV6mI75xjfDhrqPbX3duSMei0SbWRDPg1Y?=
 =?us-ascii?Q?stjRp+1GVKsRZpkeMRFL9AWCdpzJ0r5zMzkYhlngMU256+i2DvGgphELlF6q?=
 =?us-ascii?Q?tRqtj+13OiHoBfC2nxDD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef12ec26-fed6-4566-3b78-08dd5281e303
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:13:17.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4880

Good catch, thanks! Will fix and send a v5 after a quick test.
Also found that the addresses in the tsens and qfprom nodes in patch 5 need
padding.


Return-Path: <linux-pm+bounces-42263-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JWKA8+3iGkrvAQAu9opvQ
	(envelope-from <linux-pm+bounces-42263-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 17:20:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A42109685
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C855C3008D17
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517334B192;
	Sun,  8 Feb 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Bggu0+tY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00E34A791;
	Sun,  8 Feb 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567620; cv=fail; b=bg0+AdD12JFSHDvxl8MPoy0zsjvTR+jpv7oCeOy7VbVwbbN8VxByZRiWbth724kHLzpxO4GpBmCZjbnspcq7okxLa1+3kN3IiTmuMeuTahA4/QU6vQGw7c0uhERGkrVdBDsgeZ3sUjdOjVPF3rbdi447M4zjjQbwLMyklLYFq+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567620; c=relaxed/simple;
	bh=RECKIM8HWwlUBTZNyUEMKDnuXH1ygLaOhI+DeD6xX30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APZRDv8gNQ1HWmudlQjPPycn/qGI7M6J7loNRWbOhlcC6bV7HJVZ+vzUOuugV0KXCXLQ9GTm+X2qoLwyqJVBju9FS9N+al8oXb6vre7zl57AymzYPFU6cU5TBWiFUC2we/1abLtOP7jMIB5ikmdTAaogPm0OaZ0VxsrF4DkWUb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Bggu0+tY; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618Fwowo2017592;
	Sun, 8 Feb 2026 07:59:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=5qR+rHxkGxvk1giXVh9AK27qD8Tl05ddUfSE3svv5mY=; b=
	Bggu0+tYh5ieMvfuEqRjICdc1retpw2NZYqPj+T6kh0luVSMEFduuUvATqNdH9On
	nBuc844qQh2yM2ODXB7BpN3EcoS2RucD0DvHBKSy/Le4xhqWXSRhuCkDPKw0ustC
	zfVL8Kf4KikIldEzvSLtSP1zGKlAdoE57sTNTqMkZyvdq6eA7Ye44w05Y81O5K4m
	PrhRZGPUyJpF5k62ydXUhgzU0+Axu0uD6D1QW9NuHePH2AIdRxJ8DV92iDzRw6Yr
	S3Vqm2LFSY9Rqf4jxPcI9tEpZSwfYb+t15eZwshaNp5KWMb5MHcwLuwv+Q8BawVK
	nA6qjPoMP/efjGJSiSNkTA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj0r6s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Feb 2026 07:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohxyG30dHo9+LgPSd+xQ9a3fAn2x3Yo+lmz+iKc5rjQGBFb+GSdjLGjtNRYdyltTUbtqVGjDQj/KHwhgKjwZpP1II/H36P3WLRwW6xGt44ZfQaLBHpr37tMQNXp6+RrKwN3w7eFXP5x9ZCBsxXHqS6eOz2dkRR1Tgtdw3GyI+L4PSDt+H6agLslOXiq3mXVliipSnbgohljtWGff69AZ/+/YsWVpAx8BDkCAUO4oS1qfocB1vyxWuv0kFpOMTrdLfzGyi/DFR9HPTyto1q9ks+e7qR9BDd+HIosEwjC94MKkEYFKgUkJCaiGsb5IBX2eC7/TwwWkgGlVHHzBnhxGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qR+rHxkGxvk1giXVh9AK27qD8Tl05ddUfSE3svv5mY=;
 b=XgrJaVQKX9abRRfQSwDwmVfqy+btRqjpyIWeSop7Q4rQlMXVYcwIpBAT0mTmgMpJgauwYOpFVOboRtTzrUZN6cTzn0dsRHQRaMoX1jSS1mSWkxN9aH7rfIs0D8nF8STxkj385HwzJbYfRqlf/LyPHc4pV0tIptMqoDGwFKJNBM6iUGXmsarkVSNELN5y8PIZzf68qth8XctD+cd1dTPjFUej2ibgcJJK9wtgnl1gDSSUqNLVJI82jtgltFzqqRZdy4bOvJX4ABJ5fc5pv5vH13Hr54metztcmO1CM01/tpRFPzct2TXNRaC+ORcGvyKkZNBRTzbCO8q8doD3Wa3TOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:59:42 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:59:42 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Ionut Nechita <sunlightlinux@gmail.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
Date: Sun,  8 Feb 2026 17:59:00 +0200
Message-ID: <20260208155902.437740-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2244365.irdbgypaU6@rafael.j.wysocki>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <2244365.irdbgypaU6@rafael.j.wysocki>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0496.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::26) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|PH7PR11MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 871fd475-0361-427a-68e1-08de672b124b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TabTirZvB0kcE6tfb+NEVNe8H6BnuUFZUPT/1jiXnRwvO8oyl6FdgrWxOMHF?=
 =?us-ascii?Q?ux52eBI4oeZrFs0GxvmLr7oZ0JeFAqi6doRoBZ2ZnGDkBGWOl7jecch52Svg?=
 =?us-ascii?Q?UWtzLUyOCVGvkLSIsQ2I32d1lAkuIFtX9HMmyZPB9Ux6dvOwIHmQERty4g4D?=
 =?us-ascii?Q?s1GdLaaObolKRoPaMWmKhqNEEHV03zUn1/AWvv2KyHttnjLt2k9qHn6FOKWc?=
 =?us-ascii?Q?SMJwocz2etz8KVmEb7auovf281UyxgHXW8Fi7xpG7xlA7WNe0i0tPk3LJ+V+?=
 =?us-ascii?Q?XyNrjfVg9g/tL0DdgmVOVLhNUJjl1mWpWlobBG6CCo0QznmGn4FKyKVf8HxX?=
 =?us-ascii?Q?nMuF/z34jWp+3YJzosSoclBVKs4DmxoWwzPWFC6pTweSC68edHWc6zr2/8/U?=
 =?us-ascii?Q?Pjmi2oJo7U27b+/w86S8t3WwFgEehKau9X7ofz9KXTq16EysoeodTLXZqjEV?=
 =?us-ascii?Q?XIdstBeWiodVORG8+YvtXT1ZtQOasvI757X0jrU4bZOJVXhZi7K2hUAOU/JB?=
 =?us-ascii?Q?R3thk6b8JY4nBTgqD4SNzvPCvHJCJRY9YNXBB+9+c2UMcMK/Bt0HrX1A7ZVw?=
 =?us-ascii?Q?mPgkfQZBDogRGDleiDWsLTY6AwGCC53Fsesl7gk5+j5XrSmsmXzFN+dQ9Z5c?=
 =?us-ascii?Q?yMDfYjEXBEcTm1VeUBML4VpPLH5mXgQiF1Oegha1/xgmXv5X8oSsI//KHPa3?=
 =?us-ascii?Q?gIbp0+ybLhlFRto3RI05FwGxBwDZ1uohsEwzYpfuR8Fm0yIZh0Wtb44K3NLX?=
 =?us-ascii?Q?YuO1qWrnSxpLawRtEgw35PRqeAST6PmEjidHUVtLNW1cs1P4ly6WFyxqrnIR?=
 =?us-ascii?Q?thZGoibajbDq27Bum458CQ0o4BItqQgTvxFjMbxxX+R53NxHDdQuEckMmxrL?=
 =?us-ascii?Q?MfPs3J3ZXZ2np17Y6fx/48tgGc+0T+JNre40gv8HBXncAjb/4hnFLj2kZk/L?=
 =?us-ascii?Q?JzTPteAcMmH8t+5k3kZFwS08CpGx4mhICpvUJv5F6LieHKEO/R8d/DG2Hw8M?=
 =?us-ascii?Q?tOYd8MyACUDLv2psY87ewpfhSdg1ke4EThdt9Od85ZzUfTdeocxhpLchCvpV?=
 =?us-ascii?Q?UJLjTUn4F6wms8pNPPd+ISwDp6Yi+ISOHaYecAeOIK3wQt3u8jwNkja9aBnZ?=
 =?us-ascii?Q?KJurmGsjg2/x/eRhttUwB0h9juGquVpCRR97uEFepScgPeHfU5X/Gv4x2aLl?=
 =?us-ascii?Q?jphsZlnR18B6EQXqWrpuTWuvAfXG7ERL+mNvgKZq5YTi7tmKr3XVaFKKpS+9?=
 =?us-ascii?Q?R7g2pOEC7tT0cxRhfZaow0/hm6A32woY/wh087P4HmVzfItmCzzR6LsMm13z?=
 =?us-ascii?Q?9LRW1PGa1vmU4sT+UnQehEpaR4UMGBZz00x/hoORnvkEMz6xTXmndEqidjwv?=
 =?us-ascii?Q?eNu4GzERLfUiabX+gC0mzNsqiasSak7DnOKuv2TLUuRLBfrHaE4zAybSoOho?=
 =?us-ascii?Q?U+WcurszeFSRJsq208Wr18V35/Pfc44gJ/C8tXmxA7gBs+1QZOvNgeQcfrMg?=
 =?us-ascii?Q?WKuyB+eRwElwyJFemZMwZbWY8qt1c9GsN7E/tVO3Rz/Q8+hfEOmUmG6p2niw?=
 =?us-ascii?Q?KTgDUW2al3JjON8OCtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vn5YLFYIrV8DhdJSXZsq69IaseSoRB7ZCmcuqB6zn2tmRu7IXmWDNrNEugkm?=
 =?us-ascii?Q?n8x3fLdOcx8eEYQCb6gdtJ4r3L+Vof5dh7FZGGQ+eopiLA9SFiXcFDNj41L8?=
 =?us-ascii?Q?t7X2Ftd0zP4moGIwQXllpa0uGzj9XPsUsz68x6QWFJA/KtzI+yxHfkkQnz1Q?=
 =?us-ascii?Q?pUR/D0c6sYYut0i2/dRs1/boI63mh/FDZpbkuzRWnZi9BJm11+EuUJ1Z7+UL?=
 =?us-ascii?Q?NWiNLCGRGqiHftu6KnWLm81wReIhQyONqAEA7Np2zIV7ZUjzch+ntXgSz0iR?=
 =?us-ascii?Q?bALlOxEsVXX8luvXsAuqjMVTOAObQVJzbgklvENrsGFZL+s7sMlJeNNsF8yW?=
 =?us-ascii?Q?5Y4mxLjTW+Mf4WFI2CagDhH/DiMyC8nI6HTTJ91k51bmtgR1x88MBF4Qmq2o?=
 =?us-ascii?Q?8dXuAR5tSgStt2gHTYEvrMG9BZQYT3cNw3h4AvZoNP1enR8lAyIf5+tuuG4o?=
 =?us-ascii?Q?SER187bzpR0mFtGwT6GO/wldfspJ/cOmLHhjEgGSpjG/c5FW+C+r5HwF+T2x?=
 =?us-ascii?Q?gjAyAuCwm2PVGB/0pLrA/v2ZYqHmPvbJQTWeOvh9/BQuR/+bY6FMQyllfeJv?=
 =?us-ascii?Q?8P8LG6iB/RRp5AyGEneEd98fpU+wnuAkDbaqiLA2WQyqU/85nfMbHvL550YB?=
 =?us-ascii?Q?PRfWlqAIb6wdxa9zlgSBBl88tZJhNag63Fz16Xoip6iRARvwnCOjesScoDco?=
 =?us-ascii?Q?5o++KA0kQO96UEATWFavg4uBiLvZzTXeee8CURzG/Jkhv4+yJZFOO9EnHtcG?=
 =?us-ascii?Q?OTOo7UqUo3fUpS6kE4901hWPVixNneN17ek/CHOTyTdO1TJaYLbn2O6+J95T?=
 =?us-ascii?Q?BEU6SqP24al3ryYK0WLch1X+kwJqBZ8oj25BbQbiqs+Bc31O63nDGrZevZfZ?=
 =?us-ascii?Q?iY6+K10QPxhw5A8oIPyfN/FMYoP4ASmV9IUyJ2CyQfN6qzA8ZPMhymOZ9/vt?=
 =?us-ascii?Q?pxtiIfY0ag66JkJEJbv6OAwn0N5QYEe6d6a+qAbG+cssHy5qZz5WSVWU7HGM?=
 =?us-ascii?Q?l1kzN5qWdc1D0dCPIEOXolxXR9UfAlK//iLUV2e1iqqu3lJxlKMkXD33gTDU?=
 =?us-ascii?Q?j745X3yTl766rXcaUetfyL5bSE5X8ESUzdq+GpiN2q2th8P4erlNDFLU09lb?=
 =?us-ascii?Q?Fg56q7c3ywBOj9YGh7U6DeuU+2cFhdChGXqX08JsyK/1IbEAOhmFkNW+DZAX?=
 =?us-ascii?Q?mvkFktL9y7H79n3siHM8qbsYFYG971pklHibGH+cZLf5g8gPReD6xWHoxJNu?=
 =?us-ascii?Q?xXSiICYJuTDcuFl6WqdL5jc0z6sewc2M6cZNM+uPpKFUQtfrZjxl61sZO/BP?=
 =?us-ascii?Q?W8CbH7pWN3vnQn8YE9AkY6hW+4D76V2do/K6hSEp6PRsOTQgsJwfPaFT7WKu?=
 =?us-ascii?Q?rNeok/2c51sGpkYybfXNo4VH5EAfhNxcg3wi7Lb3p54ffc7WDw+ELsK5xywd?=
 =?us-ascii?Q?0QZ9kcaFeJstnAWbjzuX5v3QyOQmOPHGodL1YfgyeLjIgAsTWqC6TABE/xWm?=
 =?us-ascii?Q?79ElYVZkNBf++Hx9U9O2sR1WIFa8l6ndlvVB8nGiWHOB8Ff4OsVWrWGurpIp?=
 =?us-ascii?Q?MmTtqrZfz63aRkzzPE614UtiCC2HoDcIONLDrfrWIDV5513W6FfVhfsZLyQk?=
 =?us-ascii?Q?LVGNtVCqv9fgZJidG6TCsqNXvxivRAXC+6YwWfztJ1zTjEIcfUKMVqkUywYD?=
 =?us-ascii?Q?lw8/gbOZO3GSUWyCbUQBBnhfUK8NbYOLJRxnXkFQfCQhsUECxQS/Vs7pfbhJ?=
 =?us-ascii?Q?QW6Kbsljv9IBorjlmy9ehu/Q2DSVi2MF/IVLKyp3S3dUQIzP7o4M1SZa2NbI?=
X-MS-Exchange-AntiSpam-MessageData-1: nWy7SNOd7n/w3SqAESzkwgUIfz8d8Id/GIo=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871fd475-0361-427a-68e1-08de672b124b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:59:42.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWJRVhaMzU2wTCVr1EXCiCa7dUtC4YJgSWfmcJkJ+CSGFNYJ8Amy9by7gECHjeOJCCn86xhU0sFLO+EXRErbnXOQ/Tw0ogNPmhnCLunoXjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-Proofpoint-ORIG-GUID: nmBCgELKRz4wank52EMp_Iqq_4eL3ruY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDEzOCBTYWx0ZWRfX2GQYHSGWHExy
 +puwjldy8EwLpTnvr1axumFeOwYZenaj1lhMEP6Ld1NigdYG24kIuzg7ETjMVyzyKBx/gmEOX7D
 egq7iVqH31VgArrQ5Ah0hH5o2eFnlLRiJO9FbdIplZ8z2L6pPTHp4QzuFMreZ+WmdvHl3FC64Ob
 /mOzY/5OSJHc5W/IbVkxOhg3qg0dtNDLD9TvfZpLmjQgYWrzkO3oQoVlMhry4+bUL5s3LNbmojT
 qP4pjzyaWwv/GU2WUXcrSZaYC8Z1NKZO6kBzeScOk5vRykWVE1b2NWSZdsfdajvsJ/YFeuzb7/T
 PgWiKJu1t8Vf4toE1ITHNMTqObwXZQts46Ta3i9S3p7il3kTqHAfZV9CFp58b3vMswg/zg8w0xo
 TKfQ5/KU6SyzQjbCT9atjD6jcJxYTu+4yb4S03kSkmn0EmqwrKhpxP+AcSfYQOGE7filWiC1JCL
 43ekPVSv+vEAw8+IPHw==
X-Proofpoint-GUID: nmBCgELKRz4wank52EMp_Iqq_4eL3ruY
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=6988b2f3 cx=c_pps
 a=Ess5LnjAiV6zB+80YbJDlg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=nVvI1opj7HawLhm45-IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602080138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[windriver.com,vger.kernel.org,kernel.org,infradead.org,arm.com,linaro.org,yahoo.com,gmail.com];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-42263-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91A42109685
X-Rspamd-Action: no action

Hi Rafael,

I have a question regarding this patch: is it planned for upstream
integration, or is there a newer/improved version in the works?

I'm asking because I've been working on a related optimization in the
same code path. My patch [1] takes a different approach to the same
problem area -- instead of skipping the override entirely for nohz_full
CPUs, it changes:

    predicted_ns = data->next_timer_ns;

to:

    predicted_ns = min(predicted_ns, data->next_timer_ns);

The idea is to prevent selecting excessively deep C-states when the
prediction is short but the next timer is distant, which on platforms
like Sapphire Rapids with high exit latencies (150us+) can cause
significant latency spikes.

I notice that our patches touch the same block but address slightly
different aspects:

- Your patch: prevents the override from firing on nohz_full CPUs
  where tick_stopped is always true, avoiding systematically
  discarding the prediction.
- My patch: when the override does fire, uses min() instead of
  unconditional replacement to preserve information from the
  prediction.

These two fixes could potentially be complementary. However, my patch
is still under investigation due to limited hardware availability for
collecting more data across different platforms.

I'd appreciate your thoughts on whether these approaches could be
combined, or if your patch already addresses the use cases I'm seeing.

Thanks,
Ionut

[1] https://lore.kernel.org/linux-pm/20260122080937.22347-4-sunlightlinux@gmail.com/


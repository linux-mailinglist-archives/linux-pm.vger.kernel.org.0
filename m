Return-Path: <linux-pm+bounces-42310-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCfdAltHiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42310-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:32:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73110B1AC
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 625973006138
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1192C0260;
	Mon,  9 Feb 2026 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CNZ8/fbD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R0iIRAms"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CD29D27D;
	Mon,  9 Feb 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604371; cv=fail; b=NQ4xYnxn7Kbn8rqL1UPf7/aEEDqJMPfEpSzFhsllq1cyy5YIYZtWJbHxCdMF/NS2RyO2Vo744z3XlE7hjOub3VpdoN6rJR3hDr4dJVp8ZIbry6iUkURfzwscV6UrTZRLLJMZSLqxD6pwM8+uRURlyIWTkeyTtAPp6i+ys9xxgN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604371; c=relaxed/simple;
	bh=w1Xp24ihUakBiP2D7+zmRCBaZqn4MXNZz+Brx3MfHLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNWeW57VkGEWUbWlbqknuInhdWz0SocxfrQ7n6pBEbA5kWHMrkK+bjz79YLibqD05pGiakmxUALNbPT4ULEeW8/nGRnWE6wKerAxy2W6Eo60cBaZAy34rAsjDop5jGs8r/gPw2ocwOxRoIIw7JHR+9XRn42YhNhF+SWKAvm1FAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CNZ8/fbD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R0iIRAms; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190sOl04047619;
	Mon, 9 Feb 2026 02:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X1D3aXo1ycH6dLL88sj9v7a4leMkhOiNZMF0hY/gAdM=; b=
	CNZ8/fbDh11QfByj9Ohbw/8Ob1o6p69AHyCz34ednT/mqXbugNroPITt5iv8iw5u
	J6/ab32cdbhVNehMavpuU15Hv9Qn42UVqfu4BdiOY2rQe3AaaINstEvhQpCWsNSj
	XGVQaNhfmQPjKkrwH55lIKOFBhE154aI2pF1KmPGp12kZSpBy5pmRhcHI9uIvM+8
	9x+xzEmrlrLWHte2DQobeJjx5H6zbgJNA6hHM0rJ39IbiChzpBK2obElVnwccyXw
	BoOXC+wpQbiUrDqLiJF00rKiUBMVMst3XqxO2HArUo3qhMBaqPCTF2FT3P79HpOe
	3xDA4LoGcXWq/LhLWwWX2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjys9cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618MEgXG021033;
	Mon, 9 Feb 2026 02:32:00 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c625g7ass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUbOjPzIBVliu24eIgeUYsmTpG+AELQpf20NFheQbnUrMgzx7k2mTkN4ndVW0mRdgn7S279JAOqoeyLM4QrmIGRB6cagJVcbgBWZcHU3MLPW04rErKC/L9SzvhB+z/ntN9yIe4erDXkKk8PyqwBfkSNl0l/rOHsEBBeKe3BSD+qrMIvvfRXySVtmXpLxylEH9mDGTVBTp24FyOIAPJWT8sIPEa+vDUnPDbmDNurn4ML6Na3vnnGArsI9v5u33eF/eqERfNAtwJKtsfuyujvyT7oS6v4A0w2ede+QQyLOkAjvySu7uaPAW0KX/aY1W9S0IrVoOPbtu2nmz6oxKdvdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1D3aXo1ycH6dLL88sj9v7a4leMkhOiNZMF0hY/gAdM=;
 b=B9H1DoNnVpmBrXtzTFRCdBZypWEdE/EtWFmOScU3Q1QqvTVuxk9n82Ex4fIWVvfY4IXNzT7NauhYIr5sFDURW3PONNmS7P4A40pOIC5Ve1dVIcLtUsSmX4PvUa2EAItLCUegMn3+AqanYIwBn6wvfxzx7PWa/31+O6aVXxUeIutT/hgX7cXxeYMssVVXxWSVL54PP2EfIN5zPDu2Btxw5alaPtibsz5L9kSZvpYu5gqYbiCTwfPvbClnXXfXwQLTZrhkNr7OVidnY6+xD/efjYQC1Z2GRQIULQ+613dFsuWPjwRP3jubAeWo0+dkAy5imuHfsvQCeo0TlMQC1BaxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1D3aXo1ycH6dLL88sj9v7a4leMkhOiNZMF0hY/gAdM=;
 b=R0iIRAmsh6KZGJrOc/XyQFppX40aK8WYWtKASXyq9ipLgRHheXPv1KN5z/HfjwGMxi1Jyni6ryHsSS/Y21nAwD5h/hZeY4Bj4LUwnXVvgeTktQijgELBzsQFbYiub08GjJiIG+qU5q1ZouYbV17TzOd353u+rxgAiC/O5vr/mOw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB997601.namprd10.prod.outlook.com (2603:10b6:8:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:31:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:31:58 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v9 02/12] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Sun,  8 Feb 2026 18:31:43 -0800
Message-Id: <20260209023153.2661784-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB997601:EE_
X-MS-Office365-Filtering-Correlation-Id: e96f3fb7-ba14-4c4d-eebe-08de678365e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KiBRvO/rq0loPbtoaw1GMwu9gPbZ/TQKesuCL0JjshnlQtHvtOsleDQPMrr1?=
 =?us-ascii?Q?FpBy23PL8ee6UE65WKH7FJbvmu7PuhjTVMJVXDdQYu2WJUsERsA0hYLN+rQl?=
 =?us-ascii?Q?seaiSHMz2RlIg+AskLJT6NUZdhvnU6J0pJU0zxhyzP6hU/lbDQ1xrq8W5iXt?=
 =?us-ascii?Q?7CnTmw8wiZ19pR8VIaCMcZos9+647GYP7dpnglCIsXD65gBMj6UF7FJeJ1ni?=
 =?us-ascii?Q?TDjTUo3V0O4lcloBHWeenQRW3qzJcdjoZNbPpGGsjXXAQBLG82cVyDS8smgh?=
 =?us-ascii?Q?uGT4GmWZwiftYmxjyigyBKB+N9RxbbtXsRp8O/69YjWssPSi8UXlZT/gKmWZ?=
 =?us-ascii?Q?e+schsZH8GGNtPV8hQsDr6IWy+mFYC8gFaVPPM6khSfoTYjBligxb8wVTChH?=
 =?us-ascii?Q?Njc4cXOGZF/1d8Rt+xRDTH2gIp5N1+3qhOYyQf09jNHxfZGLFm0v4+QZNQOR?=
 =?us-ascii?Q?l0cjfXvoqpzhUu+j7O45ROS8GlEX/0MPViu+TW/pPfWpB5/k6R/JP0yPDCAj?=
 =?us-ascii?Q?6HvkcLpSXih7BcwNDiIJaloZSYj7g8GmXjHQq5vzC63sSvEDxuhAs1cFk3T0?=
 =?us-ascii?Q?6WcdPQk1ElQAS6Dfm2lCIucQ2SBOn2nu8zWnMZgoTaUxFT/QK8E3DhGWB9Gy?=
 =?us-ascii?Q?B5qoEDFDUzqwR7u5ww+IdMm1TxICNiCm8VaGOUS1OU2UbMzZWTPoASaB7Bht?=
 =?us-ascii?Q?XyuWnCnBbvZRadP/bvzIzpX088CnYKcnaLssUOKV4HqcbtKulnetZFaGSPSP?=
 =?us-ascii?Q?4Nd5Kb5PDEXUQF3fRdWaGJGFbu5fyqWQN6kQHvY3ScIbY+Z1dDTUiD17Ay3R?=
 =?us-ascii?Q?bsg2sEVG56ggqG+Ya1OWCWh8eNj9+4blRd12zNNtp/7oO+1y7hD4SXQb6BcA?=
 =?us-ascii?Q?fCz6O8sFfK8e+PtRCOue6TNXmL1ZILKlSJF49My78jVIjHLN7GPTRnWHmFK9?=
 =?us-ascii?Q?vLkoYUxqQTeR9gKegxVxVODmPLTwBUxsF8p/B4ghwdQva6at4QtBNM0HCTFb?=
 =?us-ascii?Q?Cl4J+YDyHbCIh7hOX2DfWhboGjm86LiwFAR1UTqy6MPKQTlsNspoS+XRFQKj?=
 =?us-ascii?Q?B2BO8mgMLwZIiJX6hf57hZ+hZ4BnWsoIaCrgjb0csr5o6KvsSVIbwkSSO17N?=
 =?us-ascii?Q?yjDmRF2kZ29IVFYGVKo9UHsLT7mbFge9ftWFq7mKXQu4nyhzWyQQm5cBU7G2?=
 =?us-ascii?Q?JHLP1bzkxYAmgvkaxjsFZY4ajB3uo/QLmO3MTwwjIgfum8ax+Z/bzZ8CXYAL?=
 =?us-ascii?Q?z9mJxWaI1L4BUFwUjxuT+6kUz+Wgi8PK8PL4DiHp3bB2wElgvvaiPykyX4tU?=
 =?us-ascii?Q?xTwbLh1xz+w0MLHDZFha9U6bM4leU2hsLYhOgy0XfJCf0pL5lj+HWO7/Fubm?=
 =?us-ascii?Q?qL+KB5wsNvJbo9qt0NjL4ehQdV40RKXIxSyBxKGu9fuTrVKAHXiEDXGqFq0V?=
 =?us-ascii?Q?msVDQ8jDjBt7xbjNSsbtT7BwQzw0CLY5OMzQ75+u2XjPn9ueDQAyUy9wZ37C?=
 =?us-ascii?Q?zSDacit66pmXUc18iL0TUrN/lo6vtUkqw7EYFrsQx/y7NMkoq6nDiA5EPZ7Y?=
 =?us-ascii?Q?hF5KgsAFZIW0LlloJRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JO2OREnS6DChZIskLwceFArLOjtqUCuHf+ltwt1zSaj4SVKqbhXK+/NmDIXb?=
 =?us-ascii?Q?MXalCTrKUeJfBW8HZURGplrE0XsbMqHownkMUTkAvzqv895Ly0G0RNogFkqF?=
 =?us-ascii?Q?XDfxxHZ7ByLTRWGbKEv86BDvDLRgknaIXrH4uwFD5c1UQ00tvQ9tAoNxP/yq?=
 =?us-ascii?Q?vcKVoPp5Yh6Rxnj3wa6CjSK4Ztq0nPQaWs6xUFLSxz3vq9Jn8onJ8jKeo3p4?=
 =?us-ascii?Q?IXSEGzKeRwPfo9ilBnHxAHxvs2AWy72CLW8keJLfFfKoqlEscNZBk2Sod+at?=
 =?us-ascii?Q?9CNyH2Q93an2YNLDeDu9ctwy/D3+LPyNyRW1PiQ2vSUVAlmuuc9sgE6Z4MhO?=
 =?us-ascii?Q?zegPZwXHvz5zGI7aJrZzmKrZWLvtnib4M4KyHFBPGeRF/ZBI8OTBiiJrDyoN?=
 =?us-ascii?Q?YWduK24vk2pYNCMzR+0S6C0Z2rQKfFwGIbIdZI2GhPZC01VBsMCHKWsLl4OI?=
 =?us-ascii?Q?PNWAM1BH+gZ+ExgWCGbydeQv7PtJ2u3atjkaXzh1gekcUcGeHlIOms85kQFl?=
 =?us-ascii?Q?JkMRU529l/jrI6vtf4k/Wslm5ZPWeFKhDmsEyvPwUfq3r2R/4Q7Z9IqzfiSx?=
 =?us-ascii?Q?e6cJBa/b8P3/SQcSKOX3oR7WKLFXeh8bo3jimbeQw8ULPmuknrJ0HZhpae8+?=
 =?us-ascii?Q?WQ7UwmasDvUFajIS7oPJ7Ha9ZPIkj1IO7XMjL/oNxfFF+4XaHt9WSSJQ5EHF?=
 =?us-ascii?Q?5zW6eYBU1k2OsYHaaCHM2DmtQFz92L/m5iGlc2vHUDpfZJZcUN4RqhVv48BJ?=
 =?us-ascii?Q?55/zID/w6pCJPsPtBelFSzNi9zkjq/DPirXqQ2e4EPuC7EKD9NGAfNZm6z8T?=
 =?us-ascii?Q?79/yZduJW+oQzNlZ7k+i7cEPZldHs6e+loC0LoBkQGanVWZ11TLCO0qCqqdd?=
 =?us-ascii?Q?bRllqotmEhZrzehy3QhUR3XSbn+opY8pS4iKD2101GLGw0ZZuWUAt/1EkGPp?=
 =?us-ascii?Q?rhF9bB/VF6pjcBPeFf2B0eUujRcky5zU9rSx0zDwDTd+/wqlNEo/c0b/xZuP?=
 =?us-ascii?Q?blw/hhLL7aOe5iU4fKyHFYxmZBUwnwBBV2HKeNLzZxynKSVCkpupAp/jlX8n?=
 =?us-ascii?Q?YehxoWvCST4iyWkEDuKFyhc/+RaUxQycRJrSQOWsr2C2orwMjToyMtQFBtsy?=
 =?us-ascii?Q?fd4YpA/X9jH5Ho5sENq+mtjBbL+SsXK7zX7f5T7SzYHK+2kZJZfTOCwgvK6x?=
 =?us-ascii?Q?8s9j2F6EiY8CVtJS8JKhh6lInmPuJQrWlT0pFH3/RH6ZF7pp6PMgEW0+vgxR?=
 =?us-ascii?Q?NJKa0rP86D3bMoW9BpyDJCxSQv1KCpVKebpvxu8fQbXGNH2s0he8qBDkhrUD?=
 =?us-ascii?Q?pkh+UJt15fTm77SnsEVoW/Bxi5N7us8H5lc4lK6EVrOHI929nr6j+YIOXGGQ?=
 =?us-ascii?Q?0IZq9i9/fONIQAA/Zi4kP2zbNfzflZe3+tYNdkwzdDQ4OkS/z4hj8fEyVQr3?=
 =?us-ascii?Q?dYYS+LHYpN2qZ6bkwtRgaipjDjsrr4yjti/VluGUZUOQmNZGIsayi6fSDq90?=
 =?us-ascii?Q?4wCgjYlnrpF5EFJV5J0IsnFCkqkcOSNQFPoZ/IFsc9xlYgGFjEAWDqvQVVRq?=
 =?us-ascii?Q?2Dr/iNmROnPYSNzeIzzwjn2QpJTFqPh5zGvMSbiWWzAGSWB9Ld9jgiVNBhuZ?=
 =?us-ascii?Q?yUcixNjpsRIEMJJWJ1zbOl7umgKXgxI6v3gc9TIIo+AZyTexfJfREHolX5zC?=
 =?us-ascii?Q?sZge5lQp+YD2y/zG64xInR6jgRzdHhhPb5mp/CDduue+ZMrmyLqYxg+x3HcU?=
 =?us-ascii?Q?mcbhDWWIvDvNZNFsHWgl7yQlYew9qac=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OffzDAbmO9p2NWjbZgYhnuzG/zJ5WoikDEl7AlLZb150xGdE+tsDhV7dLnhFjPmHDrG8NATN0Km/PQEedblxWBqNXYvs3Oe4AI5tlz0C+VKTb1/CR829Y9dZ3UrvjKJ1Do7FKc8whsmTszpmLqasFwYmVpcJyb7f53N3xXrMChRs4xvlMSbheOs8zTlrrh8brfx0WyWnBvAq1iK3ztbQv+0PGi3A9g3hMXJTaHXyCy9QBsQq8TU0DyKWMV2BD28Rhi/NYzGjRW73vJpYqzVu+2yUvDa9Yxz93dRBcpNLIoQmj24XRJnQeqTg7mLYyYxyO8FaIzmNfr3gKQj4GxL6hFNbPIgOKPkEk/dkq1oAk8lUVRwjOALWPIEVj2265b2223fxnK6RC87eYkpq4ut0wbikfW43NZ8gTuAeptCO4NWzISPEya+d8K5wXVCEvkhbP4tCv05X5tk24YJ3YrKbXBgTwFzP78VD+OK1+ikEfAwD0vvJ1Mq1QypwDdBoFvGNvrSNTySYDjBsdsm6tsA5D/ryTjM/Ouc7eJdMYbmkQP96qjj8RfJszNqwLOm27Asy/G0rMP0Mhq6gMd7U1Y/pjWDgi8/3UTFTALGqv+YcsYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96f3fb7-ba14-4c4d-eebe-08de678365e4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:31:58.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYd8YxSErhplh5ZwLzAt4fnQtvbidWez36KDZD8FNJpdUuCoDNOBdPwpxO4xDkx9jUd4HhNocMnDd7X90I/vhgKMURowH/6Hz8wbZloXaYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX+XPeBClSuSNH
 d0sSUn/x5viGopZSdFY/I6oRSa7M2AqRw+NGBjK5bUkDMj8VpJx04qVSjnv0aG5OeTsYeDQS3Oi
 iFgnKdFcRTdqZJdSx3EH0vZOiCLuJZvmZKY3XeOaUV9loELuqZYQzv9cQh/F611/3AEifbTVDeG
 6SiQWjDs7nET5SborjMHhXdBDwv1NAfIX/jJLov7WF2QgwUPTDzEjijhA9+8mZe5jLBsSREg76C
 folSIucN88iUDQPDBqoCJDry9TXDxs60hpOdT8PzjJVL77M9e4dLo1MBZ8yfHANVUQjo1xra4GQ
 8sYD7trSFsbKx9sMcbacGqQ0EC0E8mQMdvOtQNCpvvv5DlWBgS4mnIOWsYHDiYXTJMCGHvQG94c
 2Bhjk6H7Wyb8U9846j8AUUi67uMMc3d/sjMFT66rpm0hpFM6HxaIX/Y3WrLy4a51Lmopx1VOS1K
 2nihP0CDZrfIQ7iICaA==
X-Proofpoint-GUID: CDMihF7nqoL7h9WA8788E-c9gv19Yh67
X-Proofpoint-ORIG-GUID: CDMihF7nqoL7h9WA8788E-c9gv19Yh67
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=69894721 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=yKa5MwykXiZg5cSm1iIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42310-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,infradead.org:email];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9D73110B1AC
X-Rspamd-Action: no action

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in
WFE periodically and don't block forever if there are no stores
to ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by upto the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
each iteration of smp_cond_load_relaxed_timeout().

And finally define ARCH_HAS_CPU_RELAX to indicate that we have
an optimized implementation of cpu_poll_relax().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Note:
   This commit additionally defines ARCH_HAS_CPU_RELAX.

   Will: I've retained your acked-by. Please let me know if you
   don't agree with this change.

---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7..239fdca8e2cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,6 +22,7 @@ config ARM64
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CC_PLATFORM
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	select ARCH_HAS_CPU_RELAX
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..6190e178db51 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,26 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for the ptr value to change.
+ *
+ * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
+ * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
+ * time-check in each iteration.
+ */
+#define SMP_TIMEOUT_POLL_COUNT	1
+
+#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLER__ */
-- 
2.31.1



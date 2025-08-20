Return-Path: <linux-pm+bounces-32730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF54B2E406
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3993D3A8F83
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7323717F;
	Wed, 20 Aug 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NtiTBGv1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NtiTBGv1"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3B1FE471;
	Wed, 20 Aug 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711201; cv=fail; b=rYLBe6aP+ZTLK5FiF58v5ivAHX9w59ZaGUqYvo8+UNDBJhbNqxiIZ0yFUu4D0uOaEJmHPmJ5abyTXDFng8XSFcD9n8qElXz8bqaJCUFMSYzFbIaUalHAtiQR/vRMWcF4j6u4Nvpj4BwZWArNQixPaQpkbZ+gUykKMqFdwtAS180=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711201; c=relaxed/simple;
	bh=eRC+jXf2T0kzDn4LFD+YnM8DEsBL5qmi3d1pPfyWaJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tYSDjJ+/V0CectdhBZuKgwtAHho2cQReAbDY+UOe8rJ56JZ3hpvQ2zrNHfGWC1mPaYr95h/kPsdm+BkndOAuxA/JjhNTfh7DTAPZ7Rm3kPMcN/R4Ldv0O/onKL+nK+wsgS06k6JEfglx1X0A/wIbkw9i0l2JS9E/4gc9hQvl+Yw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NtiTBGv1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NtiTBGv1; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qdk4x/wt5I33f0RoIyWvM38LKziMSU8rGGRUpKHBlcAhWzbiIz5lgAtTY4qpNXEuEaPaO8K/QnTPlvYI6HeCXhlVoTjVXDiFb/4b0zUPqA7SzuiykuhKmELBessFHzVd2LmbjjmtFxhvlL0PkNhaVBvZpZgqEB4NGIHzowbLQ911kKHCSjBVWIrQ/EZgKadaJtLhoTjN8WmFxREGwJ/SEsVAfsbcvHeybXxu1TKu5foWLlbfOENx7fHeXcAQWUMReH6nb+DKE+PQH/Bj64Q1UmvZB6aTfQthVJtP8SV16SN07NCf7cf4R34UaeSkcz8NvTpSSWLxIwfJUcCwQlrHGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D6t9SCatIFaYUb9M2vJUFZ2vLmuOx0xdEc7SsbfOW0=;
 b=nRvvsQ2u63yMHbRign2eDayJz2fAgt4jaq+0ipNRwojrybM/YJm5t4pc8PuozQpQa/z5dzxEnic+uRmYGZDBGCwclrnpabKTAwYY65YMeMoyrD/1a7A79c4gHi640F0/xQw81Cr8AQtT00sg1bIAyTD2oSe9QmTY3GvYDdWAghQxH2WO7pvq/NUUyq5Uq5NBL73V+jXD7uLnjqe4IkZS6H+jQBYIlgv2ITaMscivRiszfg2ukltL0ZxBmxl79X+4mswRUTTK3kyKg4BmHTGOEMRpJ31u6jLdmcxk7I1ZpTu1x8yaoedr/3wZCvDjJ+DELz2qSeG6qcUi7TqqDgSTew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D6t9SCatIFaYUb9M2vJUFZ2vLmuOx0xdEc7SsbfOW0=;
 b=NtiTBGv1LGAIN4Kqxb47r7S0BZUSz2MIs3Fi0x9xINeXska5TSnv1PN6r6rx3vodzzNm4A5YWO+3e+AMlJULdfZBAl3CSYgO2HmJLs95BNWRtKutMVqs8VYjJVyFEbIZOrVRKsDEyHYxj5YqkFLX99PnIb+6I3kniEIpfCN4Cx0=
Received: from AS9PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:20b:467::24)
 by PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:33:10 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:467:cafe::a3) by AS9PR06CA0138.outlook.office365.com
 (2603:10a6:20b:467::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Wed,
 20 Aug 2025 17:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 17:33:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3GGcRwqA3aMUJouug529caOIQWRuJcL3L/9UfMVp+yNWGMCng+OdTK7n1obhzFpXmSTU1q0xg4XYOccWRBY2fyplQ2paXTiLyvRSNEvZt5gWoGPXfGrOv+nzJZIGyvaYfQb7SRKp432e0Xji/FNYEdHHxfO6pi7sdbr1/ARt3R/ziuvEt/2ou+pPMUutKspeWgmbD7dSn0uVUu2enA4kzg4wxcGKdw7Q49pZUBAWApUoNV5OCeqN0zUiis9OdLgEZdLfUE2cqCKzmdH0Xcz9dpuop7t3m1kGwXQdpigiEbrbSFNKE99ADZU4Azz3rCudiZy7OGRcjoCMjou+20a9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D6t9SCatIFaYUb9M2vJUFZ2vLmuOx0xdEc7SsbfOW0=;
 b=LBm+QoFWF7JpLvoxQ3rdZhj4ODYA1CZHt22vDUX1iLw9vB6vLMLnKWVIui/9Z+i18Rov/A1og3hL0xyKoPwE+C6Hwr++UL5oKO41l87DshM3Rt7T3pUWL1p8nQ4ChvxWslz8KDjc9IE+7iaBaB2jT+WC+UJ6wJOD+infyE5eE4NCyaNsEcmiuHb9X71n27Pf4TSUFoVkRPrbil9aax2xWgnSAAFljFwPi9DvqTAnefp3qraY6/hJuA25un6b2gyZlKbdpGtZ920jFMjxZulFGHu56WoUhHHSSgvTdGhYGVCRWz0bojLlBKGyfzJYaZQzp5vLmawds301WMS9yA7m1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D6t9SCatIFaYUb9M2vJUFZ2vLmuOx0xdEc7SsbfOW0=;
 b=NtiTBGv1LGAIN4Kqxb47r7S0BZUSz2MIs3Fi0x9xINeXska5TSnv1PN6r6rx3vodzzNm4A5YWO+3e+AMlJULdfZBAl3CSYgO2HmJLs95BNWRtKutMVqs8VYjJVyFEbIZOrVRKsDEyHYxj5YqkFLX99PnIb+6I3kniEIpfCN4Cx0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB7407.eurprd08.prod.outlook.com
 (2603:10a6:20b:4e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 17:32:37 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:32:37 +0000
Date: Wed, 20 Aug 2025 18:32:34 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Message-ID: <aKYGsqCTRXwnb6Gw@e129823.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-5-yeoreum.yun@arm.com>
 <aKXlnZ8HXHBZMj4T@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXlnZ8HXHBZMj4T@e133380.arm.com>
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB7407:EE_|AM2PEPF0001C70A:EE_|PR3PR08MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8a0c6c-c0e0-40ac-c768-08dde00fa1fa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?dEBa6xRwww5P1uX9Y8zfSw0dS88tMIFCKhefmwxL0TMH8ct+M7WVav+pLcrV?=
 =?us-ascii?Q?pZoAsXpuZMxQDHFdkcImPLeoDfCmtlfsgUGIZ/mlP61Z/BNIpPAqN19DdKXU?=
 =?us-ascii?Q?k/l8ed851uBaAT+oq/vGCQdmFOqY4fxfAen2cO9C32kogapiU6pIQe4b+pDv?=
 =?us-ascii?Q?DT67rOeZ9NMwy1sQIJD570MV9bkeevAFYycw//t/b/oTweWmpL9hfk9RQgYV?=
 =?us-ascii?Q?QSmYmyMWetzC3ut+gEz0CvIBD/BSwlnPVfjner0ne7IUX4eEM/sq97yDlQ8G?=
 =?us-ascii?Q?fV1oeRqnnnQPRDXMSERI62iTucs8AXOqdGTPrv2AtOWDxIDuexQvSUn00zwa?=
 =?us-ascii?Q?sgm6jU9SpJ8lH6WnhXUPPIAmKWprerBZxD4K2c/aUov5DhTfZ4WjsUhMrHPQ?=
 =?us-ascii?Q?6Wtgqp8SS8/JD0uwJHBxIXnMF51HaQPI/RT0Tv9TQqEhw0QBtJnRU9Jq5j7k?=
 =?us-ascii?Q?+bRIPaBBPovwnJ/yI/4dqGkGbJM+qRaiQmPkuErrMHBTm3XFM6A/CTGEdP1h?=
 =?us-ascii?Q?HIDls2+wNLC3uHQuQOURdBOHYfeMCEv7xSJToNpEVvEFrB/i0YmzFCP0ugQM?=
 =?us-ascii?Q?bO79OyAJ8ILA0Po8OKPo75u80NGEWe/FN6+sSttST13ZJVDDBh0af0Th3uFW?=
 =?us-ascii?Q?cOE6QDTNsOe8dZGmDH6HzLLmxniTrqqLM3Ht3l3uo5s42SUf/50KPzE1nj1j?=
 =?us-ascii?Q?nhABbd20c8Q1ESVHbnfHBGK223cgqqH5Ay375uonu3v0Qq+eyGRM4QTeux3n?=
 =?us-ascii?Q?/myRPGoSv5rxSkNo9UpSIIsc2qfIdKzl2GDjbVo3KJ8wrvBqCDhm0p/Qn7LL?=
 =?us-ascii?Q?APwQXXZTW3e93BF0P+Y9HfOhvAzqiDtkuEwSwb97xAs7aBj9a8dlJylMonjY?=
 =?us-ascii?Q?bYDh0shdyo+x6lD9D5gYZJtEC+sQXAhF+5aU2QgS2Px9KKO6bK2SVoowBbLU?=
 =?us-ascii?Q?bFweD6ETr09H8BSPh/tHPdSetsrxiH5xQ93f7BoJ7+6znMPYpMlaQzMSrL5H?=
 =?us-ascii?Q?ZBK0AFKwlKjKDH/ESj/DeGTFNBEBjry1wM+ih2RgBZaGvMrKwZdyrF7YTyAE?=
 =?us-ascii?Q?zKSdfk+1Q+L8pf/tG5+gpIj23ky8wRWsLcFmRAcvPSFF5q/pO0qVE3xBUb42?=
 =?us-ascii?Q?ifE57uLUiK8V9VNVRtEgCWE0L/e7qBcGoIwla/vhmg5+f3/NDVEgBtH7i9mr?=
 =?us-ascii?Q?8NOTl1jVPMXuBgCUWzv5URyLzrLe7zoSmoah9A6+eLqnQXIr5mkHcWD+88h0?=
 =?us-ascii?Q?mhmrlX2n8BZ8FiDd02fIjwKpctUwdcnR+b6OucpKg0qv8vVl5AQB7bq9j0ep?=
 =?us-ascii?Q?Y5pZnNeDzFkkj9/+YSCjBHsL+szVuD46KirtxLpenRL5iLDENALdDKt4P86n?=
 =?us-ascii?Q?KNeEVjfXsLdBmWRhGL9Xp+5RQbJrWKaQLmIdhvgu5MdnSjrFDw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7407
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2951c50e-4b3f-4d81-922b-08dde00f8dfb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700013|82310400026|35042699022|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHbA6HYMEobA1xxUxdSuT9G/hgZ8G/kaGW9oRjFgjBOgeLDlUqUZtKBcVMn5?=
 =?us-ascii?Q?zzsEO/QT3KaXgcoBRYfVU/m8DZp1BhAp4ul58/Ga2A0GCxWrZCe+TXkWxXzr?=
 =?us-ascii?Q?JIzYDAyx8fxYewf8tlGRNSdPy/xSIy3OD5AZoakT0wnz4fBz0s7zX5VDtWLz?=
 =?us-ascii?Q?9IkQPPGZ7Irv6WEKP0SXe0xVwlX+wu64Wy6gD1+f1woeQ1aEK1+BJmhQxnUD?=
 =?us-ascii?Q?ZMactk/zV3O25VZCsI1XguqDqEr1KxpeIx5z7wtzLxI9nC2I4X5gz7OYH9Nr?=
 =?us-ascii?Q?qm2Nqbyfdy2HGtZ0mYR8zP/hmtscboKhsnuyD6pjKDoMa1mXbLhPOlVm20Iv?=
 =?us-ascii?Q?mV/eZOfInGKkn8h+Jic8ynaRahshgi+ZwYz8nWb7eIGbLTouPFUZn5GRMMmG?=
 =?us-ascii?Q?XWdqryLDppRcprhQ40XrQDVAz2jYjXYt9DG3NVpvTsrZaCXcTs+NsRGwCNFW?=
 =?us-ascii?Q?wnl1wVtlxagV9tpG1MdlQN9Xq/eGZLq1ag45ngUZgjJruEVapsR+1+EghHC1?=
 =?us-ascii?Q?mrItnWDS4qM/sZTbmkZkGZN78JsA21Y7drpW96PDeD/EvKiuZvYt6EbSzldh?=
 =?us-ascii?Q?cvFw/n7KQIeRe570BQ5X4o9QqL5w7I/FVWeEk9eQxaav1bhsISTiiADgsbVV?=
 =?us-ascii?Q?IrkZrn9VtnLSX6xrTwgIRNAl6NPVFTxRuPJhW2CrkL7jmqN54AkxrkkfoYlP?=
 =?us-ascii?Q?E0BPqA+fb16WFI31grKsupsBKnDkKlE4K3tQQxZcD/80edO5keoA2qM0MS13?=
 =?us-ascii?Q?04FhnQ6d27RleNiT9fI9+QyXvfZjuFxe5TZ2X722YMTjv3hlu0mZcgNMMOAd?=
 =?us-ascii?Q?EYZfrCaMywcWCtChKjZHPqohWif8pzElCcK2hVphDF7VARh0oAA0vDUjYmD+?=
 =?us-ascii?Q?0g03YSWNFEEn2dGhC6wKCGazrJTQ8Cp/Z7qNRvlYKJ08NkuVxpsqWaPSZOxy?=
 =?us-ascii?Q?XgTIOevtMZdsuWTZLb7hZhj46RAQehUYG39QnnPihAs/AmiEjVt/jb4eWL03?=
 =?us-ascii?Q?KV0Rj1bSuKTd+cWUHNJFvaOtMfQkFQp7sXgXYArVj6b3JGT2LDgRigpFU5WX?=
 =?us-ascii?Q?Rlwl4aX7SGjtX/gmK91oYleI/epArCuvTLsYSZgIMib5mWGdjv0mtdE2GU6X?=
 =?us-ascii?Q?h3Z/UTq5Z9juGelyI9zWMpkv1VLPWcMmd96awdLHiqhjVksqQ0EZbswvQ0ZK?=
 =?us-ascii?Q?HyGVUmJ4sv1/V4kbjpYfwuE402FDzrJwZ9rgSC0xFzke0dhogmi6XdgjH0mo?=
 =?us-ascii?Q?sqzh3ahWPZEu5A+oq2NBL0Z9K6yVfhvqaFu626BwZqZG0QbnNjUf8eq0Mzfa?=
 =?us-ascii?Q?cmEHfzLKfo0wvKt91CONgVE/jESiV3HkwqajvfmqeMGVyir71P3MiABL+hoF?=
 =?us-ascii?Q?vk1u9ZA1dz7hRms8pjzb6eotQCPT3iMSgwTJb7H8RIhoOKtox8o2oGxY+w96?=
 =?us-ascii?Q?WX5f5flHd8+RLUQlp6P8hGconi5W0JsUbcRXAdMEYQdKl11rfOYMUA2hBucl?=
 =?us-ascii?Q?x8A2Ut7LESbFsYn5/dcevmnqW5U5V3ahDwDM?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700013)(82310400026)(35042699022)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:33:10.2179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8a0c6c-c0e0-40ac-c768-08dde00fa1fa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5852

Hi Dave,

> On Wed, Aug 13, 2025 at 01:01:17PM +0100, Yeoreum Yun wrote:
> > SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4
> > and serveral architectural feature are controled by bits in
> > these registers.
> >
> > Before, launching new kernel via kexec, initialise SCTLR2_EL1 explicitly.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/kernel/cpu-reset.S | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> > index c87445dde674..123564af345b 100644
> > --- a/arch/arm64/kernel/cpu-reset.S
> > +++ b/arch/arm64/kernel/cpu-reset.S
> > @@ -37,6 +37,12 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
> >  	 * regime if HCR_EL2.E2H == 1
> >  	 */
> >  	msr	sctlr_el1, x12
> > +
> > +alternative_if ARM64_HAS_SCTLR2
> > +	mov_q	x12, INIT_SCTLR2_EL1
> > +	msr_s	SYS_SCTLR2_EL1, x12
> > +alternative_else_nop_endif
> > +
>
> It would be better to do this based on the ID regs.
>
> Although the previous kernel _shouldn't_ have used SCTLR2 if the
> capability ARM64_HAS_SCTLR2 did not get enabled, it would be better to
> enforce a clean state here for the new kernel.
>
> If so, maybe one of the macros that you already defined can be used
> here?  (But it's also fine to open-code it.)

But cpu_soft_restart() can be called before capability is enabled?
I think this function is called after "capability" setup,
Was it good to use alternative than check the ID register?

>
> >  	isb
> >
> >  	cbz	x0, 1f				// el2_switch?
>
> [...]
>
> In the case where the el2_switch argument in non-zero, don't we also
> need to do something to reinitialise SCTLR2_EL2 after switching back
> to EL2, in the HVC_SOFT_RESTART handler?
>
> Maybe I missed something.

No. I'm missing to init in NVHE's HVC_SOFT_RESTART handler to clear SCTLR2_EL2.

Thanks!

>
> Cheers
> ---Dave

--
Sincerely,
Yeoreum Yun


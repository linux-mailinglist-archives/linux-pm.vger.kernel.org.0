Return-Path: <linux-pm+bounces-34872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9FFB80023
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152343A363A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972382D73A8;
	Wed, 17 Sep 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ogH7c/4/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ogH7c/4/"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B62D4B5A;
	Wed, 17 Sep 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119380; cv=fail; b=oWygfYRNuYX26qeDdY93qg86trlpiXprZs7zJgwW+Db+Kw636AtKZC3TSq0Wf7z41m7BTRYPGQoDs/9Q5ub5DSghuAQh3eihOF+9PftTCB0wPOl5VUIjcXPM+fDkSvocqUU6NTCpTe7UIjETlRRMB96iqFmzpq4mvljzTlUbpn0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119380; c=relaxed/simple;
	bh=syj5F+uQO0tW+MjiXvwEhmpjRYmm6UYq8QvIUGL/1ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Img/+45nHkAJa9j1Ks72caFi2YRcO8uuKahxRxAOZ2fNO/BqBuqAa+TYDz0ksXXbK+4mNL+W+J0KMsFNwjPgvVYy5g/5UYCQB7SSU6GoRBlP+bypIjk1ffguXzJ1A7dA/dolJbw3wDQQU7HvsoZxJhf1heQN1aibG8uxAfvBcYo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ogH7c/4/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ogH7c/4/; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zUaMBGUrqCMGKuuqOmLq6G5g+acPRCQ0bZF6PJKpaJhGMbU8f4vchJmU0W3h+SDrUPHoCY8Kh2BBxkyp9I/kHo1RuWaMls5HpsrxYZqqCtYsP3tgsyDNAj9sJpWRTFN6SkFpJ1aSQh7NVJvXjoBMZcxt7OYSwaX57YnVKNOwA9jhXe+7VUd9lrWqhowtySmeTzXMH42/0RKgfW+rlZPgNFS0qCbdSaBYk9+g9mAbKYrDRNzmBhJXuUkGg79lk9degKvSucKLMrxIwLNGFm6B6TZNiOlMi1mR0BA9bruOHMK+QJC8x6qzQDas1asHtrs0BjNYFdnUdqDBVHJz/uxnHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1sH/NQLa+O1qhCKsXfDV0tUyIR6/Ydvry/+xnvEZoM=;
 b=GEJ9RZPWBPI5ycDqd+VIFOlm5qfjluE2Vc1spIGY7rIho+Tu+SRjuzYsET7HToJiP3STgvQU+FoQijNreYProZwqrXpYGPOpSTSmah0ms31+zu7f4+nC3Y+NIGm0sMKzux4ga4tx0neRNXfDBeH5kjv3F0IYJOGWNUoTlcshuJFxLXRsovSVlMxCkfvqi01GCz8yPYh9gyGKAjzcB+GVVdtO1nZzOF2TF17JFxMuExkyysdvupYrKRZxUy2mXi6xupkFtdc8wYaBhNkSNayCeSa+JytcqhhQRoIkQPdRHj8Mly3juw6UmKF1MRSdc5FGZuLOy/v0mIO8Arg8btHH2A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1sH/NQLa+O1qhCKsXfDV0tUyIR6/Ydvry/+xnvEZoM=;
 b=ogH7c/4/UIU2PZ2kwnu/y0+OsvJAngNKYB5FGEBGrsVepgWnbn0AlLdB1oDrjmYgWRu4NWmBLOz1cLj4+FeSHFwpt9LPTmvMzOTHkTFggFQCsAXGPdT/EKd8ZddFNfuSmYe3x80xHcUX8x8W+j0mmGAVIKZJFk6TSHCauYwg3MU=
Received: from AM0PR04CA0108.eurprd04.prod.outlook.com (2603:10a6:208:be::49)
 by DU0PR08MB9874.eurprd08.prod.outlook.com (2603:10a6:10:422::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 14:29:31 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:208:be:cafe::d4) by AM0PR04CA0108.outlook.office365.com
 (2603:10a6:208:be::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 14:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 14:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2JH/8RjCthN2OvU2HhMWhePGLv29LNX29Hfl8qXB8WVAG+nWLk8nkzhiMynC5J0ha0rp0h0jf6F2kLMir94DzwKibuwCg69C5yU/D8b7mNMvYS53gnzurBZZEKNCXTyeubQ8LnU9MpUw+VsV8XmnDcqS86BiHSaUZnsgW2/OHd72OidaDeezF/veczVwp3xOHfKKyH0sWM0U7zFjtF4rl+Zxz67ULDA+/S0/1QeWvGcp9Ih78HeSqu3vU+/RC0muu8KpAunf+bNsRJQqyG6gp9bC7E85BFPy4lfaT6qNWJ9xSRfYW3xJUgqWYtJ8BNBTRjAOfpK68N3pSuaHY2I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1sH/NQLa+O1qhCKsXfDV0tUyIR6/Ydvry/+xnvEZoM=;
 b=n+nGGAhpTPg40btPtkUixRtf1VmkwQXXnUKHAO6mpfEgotmz2ndHi2qH5KOq6sYxxaF5CtwMkjaC8kyNW41kk5xe+w6mn1S4U2zZdoyWgVavgPE2Hy3LBcxmcZriumVQUm/GAN66Ohb2hqge8hHgBw2RSOqRf6Itp2r7xmN+kIl8H7ipXaOlND+zCi+KU5TscIU+b/iV66Mq1hofGSvXE1ObVdbWmzJJ92f64zHWErmwNDW7kovDXVxTAInToX6SeFqiepU34wwoQw+dVKQ4ilyllib4RhI8tW0p6/fk8DRe315QHAM9EOimhoSykcAe8PwzxnhKhlE7pHbHijzh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1sH/NQLa+O1qhCKsXfDV0tUyIR6/Ydvry/+xnvEZoM=;
 b=ogH7c/4/UIU2PZ2kwnu/y0+OsvJAngNKYB5FGEBGrsVepgWnbn0AlLdB1oDrjmYgWRu4NWmBLOz1cLj4+FeSHFwpt9LPTmvMzOTHkTFggFQCsAXGPdT/EKd8ZddFNfuSmYe3x80xHcUX8x8W+j0mmGAVIKZJFk6TSHCauYwg3MU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAXPR08MB6735.eurprd08.prod.outlook.com
 (2603:10a6:102:138::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 14:28:59 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:28:58 +0000
Date: Wed, 17 Sep 2025 15:28:55 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 2/5] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aMrFp/2TY2BYQ76W@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
 <aLW4A3rTcJvA0c+j@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLW4A3rTcJvA0c+j@e133380.arm.com>
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAXPR08MB6735:EE_|AMS1EPF0000004C:EE_|DU0PR08MB9874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aecd232-aa8e-470d-c39d-08ddf5f69d8f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jwjnEyMckAhyhJxSoZ8+Rv+riOV8AJgu3Psu1FU7D629be/bExOpoBxBVRnB?=
 =?us-ascii?Q?hFlcOVRuwb2KyvQ7wSobXVu555FbLHWl7I42iQmUz0OLXZragfXxxTGvMWfe?=
 =?us-ascii?Q?CCppBWjZ0XdFSlhuLKaipFotApR9MrQcQ/+z/AfxBXLU26zx0rrYnv8ZskrF?=
 =?us-ascii?Q?oFcq5CkpGc4XQ3VF7rmkQjZ24Oz45PbX/ycGSygDcrLQlr7a7ugzl1CGjGgG?=
 =?us-ascii?Q?S8BzUGIQmU+vadMB7AE+n5aGqWoyaU42ccy2tWl1+pH4CbpTamkhMLnPMKzj?=
 =?us-ascii?Q?HO6RBVbyuXzksXp6VblmZnhGbeoltVSg2p6/VS3EoFgM8O4HuC6C5wFp3bjr?=
 =?us-ascii?Q?P12acpSK/2uVn8G1n4yu5bsaY++PPfKMO0A/unNQV9cIJyotudYF2DtXA/Yo?=
 =?us-ascii?Q?w2eENiyeKNy0E2DPFeuf0nc/qs1CKBo7Ca/Ti390h/btRRPh+DfwTAYCXdX7?=
 =?us-ascii?Q?oz6UyoVej2IpZEWS//KNZVMp+Hv9rFzb/MaUvMjjjep4tx4/enqhvuo/pFgx?=
 =?us-ascii?Q?0/w5UFB5FJxyGp2qQyzea8Bj2whLzR4lwBfc0ToHxpIKumuFNtYIvaK9MHfE?=
 =?us-ascii?Q?ytltUuk/JWshTUAG/hWRMgdpNcynLwEvsZRU9P+07V2U8kstdW19443kwgKE?=
 =?us-ascii?Q?QEJC027HEptPwun8E3Pjzeb04eNw7L7u9BQBJpCK5G/z74C6ymvZUA2JFYbS?=
 =?us-ascii?Q?cyKcVfeNsbIJQUIUUpuLOFf25GS7DSafYKzHBoNcy7UHIlGKkjEEDjDs6i+f?=
 =?us-ascii?Q?MVbCePoavFavgVlcgqQmZ5LI5uQ1U3bKZ8cHjQZKhEF45SXRqIbeS81ob9Kc?=
 =?us-ascii?Q?jL+2tnIPOqgdmF+2ZZY/4nkJmzCs7+5tOcLGXaIExPOBF3X01YpdN9IpwYPF?=
 =?us-ascii?Q?23mxjLgLAFyWJ7rKhr+trX6u7zIQPrws7GTr7WFCWikceVqME4u982Fml3+L?=
 =?us-ascii?Q?/UvyYIMvGBdyNtZ3R2FsDzdLQPxSX8EV+pqIh+WTBJjA7X2Rr3tUXd7JlW0Q?=
 =?us-ascii?Q?/i0a9q3ChRmWDhTuuubS8SqIAfFS4OKnddrvRzhZiJfXaDbbgCeRvPpC9WvU?=
 =?us-ascii?Q?AuHJa2dojbplmFe8zlrl8L2UtQber77faNi2YrbGC01642WIPajcl87smFCK?=
 =?us-ascii?Q?EVaK9VaMAumIs1UhZIVhfsOzJG/AnmOzZH1YilQ1j0ursiQH3hZv3FCuiTMR?=
 =?us-ascii?Q?VA0fzz2Qo9lJGFznsaHPzqwWqpXMZaCUkHHH1kJdMdSiHnRQwQFDvUGYYLVR?=
 =?us-ascii?Q?QUvGYcC3T1Dh74svvVU3ta7EPC18JlZNLp0uedYjdxrSLEFyVHrVYnYaNzeW?=
 =?us-ascii?Q?hmkWOGniyozroFBWGL1hasVJjlp8gRS/7CP/2ssqHQmf6bnLTTBJBxYY0St4?=
 =?us-ascii?Q?UyWm7ByWcQkkfjtSfcK5eBRbRZWZyL8j4/EEfQJAJfuukrOUI3KoGL4GsLxH?=
 =?us-ascii?Q?CdfgC9wBTyk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6735
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	31abadf5-aa59-4231-db77-08ddf5f689f7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymBFU9XnXESjV5j1F8BoIveZ207z0n7matTY7JueN39TU2Mu+4cKZ2n3AnUV?=
 =?us-ascii?Q?gdFuFVO+M+PSmU+SPRyaxSr49Plskjnl6s2XMGk5mFQVh42M8SINIv7j4fsY?=
 =?us-ascii?Q?fzKF95w+C11YqowFT96pOBQiBK1L9CV9xwTFK/eyGswjpL2dLtmxH2li7jpT?=
 =?us-ascii?Q?pjOXf210wOsNuGeRHwgi/i308Z8+6fCRY+IbDjJO4C+W+QfbE0sNBW0ThDmO?=
 =?us-ascii?Q?8wp6pFkOm1qEBdL1G0yZNgMLEyPfNYpYhERr0GDgkMTCoHgi00b1vB5aM9VT?=
 =?us-ascii?Q?v60rS+dskzbVZld4qVdiYXtNiQh2Gcpl5TzjnhsdYi8MmKRJofknCB0XrNfo?=
 =?us-ascii?Q?Px1UB6RcF7EkgT2Bx4y53lOkjvnau8blmsLACzgZ/t0hTXHyjPtHqOZ200PE?=
 =?us-ascii?Q?dnfrzG5c9qamPSYM27BqWU37irWJYtYb4gDVAXS4sKrImSkK7tzHyqTnKKsI?=
 =?us-ascii?Q?3jaeLigWq/d153Zip/6MBkXLb6rSJh3LRycstPsN3EAYeOq8EdQJq2sMSWCd?=
 =?us-ascii?Q?8Pjo3I6TDwNLFPV+vdidru+sAnic7XJhuVnlKXYIwS+rMEuImnE5DWdl5f5b?=
 =?us-ascii?Q?D/GTc5ElLcACeHQ8969Hq4wQOr6GNPSPslT9+7w1r67CeNXiWzhoD+bDhTy7?=
 =?us-ascii?Q?gzpX52+JJfgbEa3ShgUeXNRmqVd1nhIAR2AeRxImeQfq+TQqKd72LSdSK0Px?=
 =?us-ascii?Q?eATXKdvwi20L6lnby3MiQfXDsjdihRrjJkVYVhbDe7tJ9qwlyXSUXezJ4Gxe?=
 =?us-ascii?Q?wJkha3n/prHXuAHgyXFZgLjSt6XnGvSIVRboYVTgfMpVpMMfdvCwhSefCzZ6?=
 =?us-ascii?Q?J6BOnPYqpk4ViEZh7P2MID1HXnIh8v/2zHwQv5gMrvKriSh8JPgsHyRgQJew?=
 =?us-ascii?Q?tPiGADhI6tN28JBhD1MXK/dXVOW8wz1qjP6KA2BF7vtcA9OaKOmmmVUDi73F?=
 =?us-ascii?Q?LAbD3ThmHJGTL9AjFy1Ag5nZB4woQ+Z+8X/fBQKpC1HFpA/cwAkEldGW8eQi?=
 =?us-ascii?Q?cA0Dfm7Z0Owubt8rjziOV7D/OSXkzqULt94jfeyO99G9bV1wRJFxgLDjLUKF?=
 =?us-ascii?Q?pMmNRZjEkqe6NKzkR3fjGghocdd6jcw8Zdc1UBz7cJB1Ddxe2YwvDovnFl9b?=
 =?us-ascii?Q?CfErIfQ6fQLnCaLNFf9p6VM4kS9lcXV5cCWQD40mmcrmHH3o04rzAq0mUhK9?=
 =?us-ascii?Q?83a+1d88eMw8Pf3JFSiMHRbV6BYzlq0nEqwI7XZSceBPtoUmUtRROK9PWrnp?=
 =?us-ascii?Q?HwtZc/X8hHjTtGaxxi3uLnkSRyQyx/LEQx6xxnpn5cq7t9m75JWS4eXcEv42?=
 =?us-ascii?Q?p6GO/j8koSoXL0NWzEMmCv84vm1ctrE68TeFiyhBXkpF0d/6w66E+YTjby4k?=
 =?us-ascii?Q?Cno3vw/92Mf4JaJdYB2gxR7h4b/7wzxR6S/z3nDptAAh+1z0TM0iLhDlwfP0?=
 =?us-ascii?Q?QMWStHCVhrXjJpIth7p9m8eIyjiUF2AYgyroATMwxQIBRHYb/8Y1KJQoKysU?=
 =?us-ascii?Q?KLI9v03rNEhLJ/DHhFk8kMPTPjPIKYM2d49r?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:29:30.9715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aecd232-aa8e-470d-c39d-08ddf5f69d8f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9874

Hi Dave,

[...]

> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 23be85d93348..c25c2aed5125 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -738,6 +738,21 @@ alternative_endif
> >  	set_sctlr sctlr_el2, \reg
> >  .endm
> >
> > +/* Set SCTLR2_ELx to the @reg value. */
> > +.macro set_sctlr2_elx, el, reg, tmp
> > +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	\tmp, .Lskip_sctlr2_\@
> > +	.if	\el == 2
> > +	msr_s	SYS_SCTLR2_EL2, \reg
> > +	.elseif	\el == 12
> > +	msr_s	SYS_SCTLR2_EL12, \reg
> > +	.else
> > +	msr_s	SYS_SCTLR2_EL1, \reg
> > +	.endif
> > +.Lskip_sctlr2_\@:
> > +.endm
> > +
>
> You were right that just doing
>
> 	msr_s	SYS_SCTLR_\el, \reg
>
> here doesn't work.  It looks like we rely on the C preprocessor to
> expand the SYS_FOO_REG names to numeric sysreg encodings.  By the time
> the assembler macros are expanded, it is too late to construct sysreg
> names -- the C preprocessor only runs once, before the assembler.
>
> So, your code here looks reasonable.
>
> But, it will still silently do the wrong thing if \el is empty or
> garbage, so it is probably worth adding an error check:
>
> 	.else
> 	.error "Bad EL \"\el\" in set_sctlr2_elx"
> 	.endif
>
>
> Also, looking at all this again, the "1", "2" and "12" suffixes are not
> really numbers: SYS_REG_EL02 would definitely not be the same thing as
> SYS_REG_EL2 (although there is no _EL02 version of this particular
> register).
>
> So, can you use .ifc to do a string comparison instead?
>
> If might be a good idea to migrate other macros that use an "el"
> argument to do something similar -- although that probably doesn't
> belong in this series.
>
> The assembler seems to have no ".elseifc" directive, so you'll need
> separate nested .ifc blocks:
>
> 	.ifc	\el,2
> 	msr_s	SYS_SCTLR2_EL2, \reg
> 	.else
> 	.ifc	\el,12
> 	msr_s	SYS_SCTLR2_EL12, \reg
> 	.else
> 	.ifc	\el,1
> 	msr_s	SYS_SCTLR2_EL1, \reg
> 	.else
> 	.error	"Bad EL \"\el\" in set_sctlr2_elx"
> 	.endif
> 	.endif
> 	.endif
>
> (Note, I've not tested this approach.  If you can think of a better
> way, please feel free to suggest.)
>

Sorry for late reply. but when I find some usage like above.
I couldn't find any usage for this except this macro.
In case of entry, since it just only chekc for "el0" case
I think it doesn't need to apply this for them.

So, let me apply this for set_sctlr2_elx only right now.
when some new register requires this kind of pattern,
let's apply at that time more generally.


Thanks.

--
Sincerely,
Yeoreum Yun


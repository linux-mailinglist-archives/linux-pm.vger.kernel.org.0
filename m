Return-Path: <linux-pm+bounces-41164-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL8UBpcdcGlRVwAAu9opvQ
	(envelope-from <linux-pm+bounces-41164-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:28:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2744E7EC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 555E56427EB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DC425CEF;
	Tue, 20 Jan 2026 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rNo/Uwcp"
X-Original-To: linux-pm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F8425CD3;
	Tue, 20 Jan 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909699; cv=fail; b=g7kHZRVo8Xo7I6zSrriKl0U8SFFdW7MEs/aJ1zYQlPHANZ10CSL0cJSUspGFvhgPIGWe8wmVZeFjkYt2pddQWcLAm5P+HvRzG4Qr3fO5B4oI+osbriET4CY8NtQ0UhUVTgRKTzgyobyvdh8qfy0LAYTnCr43GWNlZC6US+WWYhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909699; c=relaxed/simple;
	bh=z2M0We1QuRJn2unXQpzgE2daNzDDB1ZrTBJBdjpT/So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QURPHmow6p1K6gcZyZyhe6WCqjGpLWtECF1IYBPtPKYolLp85R1efJNpPZi6K8SPcYjwF4IfsJyIsI6zfigtT1ORGnmB6yxiXLQTn+6A2sbopenB3Cb7GwuaMvgYHpqAMvZnc6kHzLmi+GQQKx6F6Phmr9UvF216yhp1cvlZsbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rNo/Uwcp; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWomezVft5Gx1Z8NeibfLWfaCfxQbVYN2VhC77RpCOl4IXK5m0jA6JEntDoEXYDYa5kcvFyCwbiuCPBxR04poOzgF3a6vcenhnnloBgQOW4IopiS7P7AXPvR/oENjNvGn/Qzgpc5GyZCwgY8UEK4DeAQeQaMhRpRh2kfIdPFBrp11vdvwtz7V44MuuZpzvW0RzmlmYfhI2BETmSx+HeacR2jvFiNrdh+jMcAYeYuhcZKluohQuaSuiXehTAtu19+ahtQkSEqOgUHXU4Jvrum8+yrzIdvsh7KRjke65bpjLg54A0U0hRdV96exaR71Ko9sLu9m/tXM/RrSoNOwwP8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eikradmCaZ9as0Q3XUD8DEaV9yfIz+7j7Pz5Sf6CNY=;
 b=Seyqr8ueSAPFu9Y6nEBT9GoIBjob5C0CZjivXi3eQS0sIQhupwMhbr0Zig72aVqlSaQTPyKRhU1wujI4cC67qSgQsqMNI/q5Wb9C57TzcI5ana1TrS0t3122ZaUFXz1aTsiL926wGfJv1wc42A3m3ZrdtRPbImlsSvLFGwnOPNsNZ+2mk3p/czLTWi8fwP5672dE0ErIwI/e4j5cZ4zdZ36YEX1Ga9hA2snnxTBfjNYqd6kn+TCh+WRSXtQFwm6Ssb7ATaj7vojjvblkZys86bFoKLpmCJaiP7IQsSI2czSNi2J+w8tXhU/RLDEo5QbbQrIBnW/JP4Jl8AInLmfw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eikradmCaZ9as0Q3XUD8DEaV9yfIz+7j7Pz5Sf6CNY=;
 b=rNo/Uwcp8cQg1Oc6NZE7WogQ8zmvDwGPqduyEvA+sarbPJKJjf3IvCibE0VkRZosx3OZWCp57MlLIrD4ElTczThryXCniiEaZEJWMvuggEtsedZ9al6xeGziDO56m0+XtlkDrOonqZi6KPFp48AYJSQx6q0Kl84QmZ/WCFFxVf0=
Received: from SN7PR04CA0096.namprd04.prod.outlook.com (2603:10b6:806:122::11)
 by SJ5PPF1849371D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:48:16 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::da) by SN7PR04CA0096.outlook.office365.com
 (2603:10b6:806:122::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.10 via Frontend Transport; Tue,
 20 Jan 2026 11:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:48:14 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:13 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:48:13 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 05:48:13 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KBls161151397;
	Tue, 20 Jan 2026 05:48:09 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 20 Jan 2026 17:17:32 +0530
Subject: [PATCH v3 3/3] arm64: dts: ti: k3-am62l: support cpufreq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260120-am62l-cpufreq-v3-3-8c69b80168a3@ti.com>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
In-Reply-To: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>,
	Bryan Brattlof <bb@ti.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768909675; l=3167;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=z2M0We1QuRJn2unXQpzgE2daNzDDB1ZrTBJBdjpT/So=;
 b=qt4NnZ5AbfOpppOdh+isQ2z4FEByrb31gN6j0DTaCQc6p/x4hgucmQggGmsJ1A7JJWxMGcUj3
 Xy21w/Q7MoBDSCn4hf2kVLxqhdR8kOh2eS/RFfeMT3hfi+rxaVqR93J
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac59d84-e75e-4631-2f9f-08de5819cb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1RnOUZlYVY5THVXSmdXNUxLb3NMWHhjWDZ4eVlMdHpKRkFkOWRBZ0taU2lu?=
 =?utf-8?B?OW9DQlhYMXR0eUdPM05WeTgxMWx4YTI0dHE5Rk1XZi8veGhmZG0vSjZlbE9w?=
 =?utf-8?B?SDV3bHVMT1Brcmd1RnljcEpaYTNkcjlUK1dubFBsVFYremQ2MllqdWhsV3ZG?=
 =?utf-8?B?OUVjZ0RNNnhNY2hGMVpZNHBBcTFpU3V1NEh5S1IxV3F1RXlLUWF1dmxtKzhT?=
 =?utf-8?B?VGI1eUdFTXZHMlJzb1ozRWdhRCtQdUhLUkxDQ3pJclZKTk5xWVhjc3BmTkYw?=
 =?utf-8?B?L3pIeGlTVDRBR00xcnFhY09wdjZDRS9Jdi8yakhhTTlhNlUyK1BkOGlybnhi?=
 =?utf-8?B?ZGw0V2tKeGtxMXJiTWJ2SUJGci9BSkpibklaMVNieDhkeE9waGNVMkdqcDh5?=
 =?utf-8?B?YmVaM0xXS0dSYXk4VHJiUmdnYVdTeVVjVlBJM3pzUDd0ZFQ5am1RaGgvMVlL?=
 =?utf-8?B?L3J6TWhmQXJNY2JqNncrVVc3TGFFcUdkZ1BIdzNqZVpwNmorcjVSZkFpbzFh?=
 =?utf-8?B?bFA1OGhHNW9zeVEza1NHTFdyWmNsVUFZTXhrOFpSNDNKQlRIWWYyRDQ1WUlQ?=
 =?utf-8?B?OUFHeGZlZ1NzZ1dJR2hCSlhRNUo1bEZqSndtd2JRS0w4WjN1bld5MHdIVWkx?=
 =?utf-8?B?TmJvTjI2czdqWXltK1g3VGllQVMxT2ZySTFQc3VOL3pKUVc5Y2wreXpQc2hx?=
 =?utf-8?B?MzYxRTZJdk5VbGIwb0RWVFFqQzNJcnFJdWdUTDVwcWpIODUxc0xvRlZWc0FK?=
 =?utf-8?B?dkxzNVZTWThnZ0ZwcjFRbGwvTGwzTm05R1N1NDNjOUluWXYxYjlOblRBY0pR?=
 =?utf-8?B?VVB1dmwwUlVPWXhBcHVhcDd5TEcwckovdXlIczNHTi83b2RlSW9uNHJUL2RN?=
 =?utf-8?B?L2piTVpFUnM0cEQxbk5tN242aUViSWF6VXpQR21VVGhsOEVDbHNtZVV6V3d3?=
 =?utf-8?B?bktQbmM1TzUrV2lyZk56WFBTa2phUC91MTRhZUI0b1VMajZqSEpDamo2S1JJ?=
 =?utf-8?B?Rm04eHgyazV0Q2lRcjF2TlJ6VjBDOEpDVmpPZ0VtVitta1JuYXZJY3VxQm5h?=
 =?utf-8?B?eFRnUGpEU0R6TGE0OFhLYlZTQy9KL2lRQ0RUUUQyYk95ejBPazFCNDhSWDhU?=
 =?utf-8?B?WmZwNGhveGFvenhlU3MvNk1lejFqdnpoVTNmbmxvZngvRXRraVFDTGlnWElV?=
 =?utf-8?B?ck1oOUZQWDlEdVZ0VGxuSDNhd2NoSm5CZzREbmZzdEhKYlhxNWVaMzRVZGdM?=
 =?utf-8?B?Rk1CTStycXYrdDN3ZGYrN1kxMnpJRXVWSGRTVXJLS3pQSXBhelYwUnFMdFEr?=
 =?utf-8?B?QVdMUmM0YU9rSGkzMzVSS0pPSWh2NjVkZkkzamh0dGxSdUNRd3FrYmV0bkdj?=
 =?utf-8?B?aHVrWG5BTjdOd3VleS9RalJ0L1FQR3lOUEw0ZCtCQlpEQkRTVTFCcGZHRDIr?=
 =?utf-8?B?WTBPelNONjlOMTlUdE8ydVlYbytDREM2WGlRaUFqc3FkMFU2ak8vRFlOZXMw?=
 =?utf-8?B?Vko0dVNWakNiUWI0bTh6SlU2SGs3UXBQSGxFQ2hJUERWakxPQTNlRUlBYlRY?=
 =?utf-8?B?TUNrNVhwdGZMWjhNZXBtTmJBOXlmQit2ZThLWVVoZWYxczdTdW1HV3MvZ0tj?=
 =?utf-8?B?dDBJek14aFE2YSt1Q2d4QjJTL1VodnY3My9qaEhSc2FhOGFZY2pBYmhLSWk2?=
 =?utf-8?B?N3Q4MlMxMFFJWUU5aThwK25ZUEVCMTZmZmo5dlh5bDNKTlhqM21DSGpUa1V6?=
 =?utf-8?B?eDQwbmErNkVJSTVhZEU2Mlh0M1NPNGJLWkpXWTZ0V3p3VU53aURJeGI2bnBw?=
 =?utf-8?B?WWcxbUhuZWxoNlBnRGJsZTVOVnNLalhYNHo5RzFINk5iMzdubEg2R24zYUlV?=
 =?utf-8?B?VTBsdncvRTFuOFE2S0VTQ1owemd5SWw4WGI1NlQvTVZEK0VPOUtVeWFqaW5y?=
 =?utf-8?B?M2h0V1Q0d2laNmdVN0E4T0pUaHA5Ti9FUndvemN1SGN0M2lUMDlzZkJQRCs0?=
 =?utf-8?B?dmEyNTBpL1ZYaHp2cG5nOHRJRDcxZVM0QjVwTFBDa1VDVjA2SGNIVmFESnNJ?=
 =?utf-8?B?eTlxbUNhZFc2NUtIL0UzYXJ6aFdWd3o1VG1oTzRiUzlRTloxUnFWS2lMYjdh?=
 =?utf-8?B?eTlYRmNHR3hGM2JRVjBhTjlIdUtYam01eDk5eFM5dnFCWXhsZ1ZBeGVvQ014?=
 =?utf-8?B?RmJrRzZEZ20xcTByQiszNHloVDVaQTV1YnMxZlJqS2YvTlcxTmFXZkkvMVdm?=
 =?utf-8?B?YklPYmR1dDBHMDhUVEQ5Yyt0WDVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:48:14.4670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac59d84-e75e-4631-2f9f-08de5819cb8a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41164-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,0.0.0.18:email,ti.com:email,ti.com:dkim,ti.com:mid,0.0.7.208:email,0.0.0.1:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.14:email,0.0.0.0:email];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5D2744E7EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable CPUFreq support for AM62L SoC by adding the relevant OPP efuse table
syscon to k3-am62l-wakeup.dtsi for speed grade detection.

Add the operating-points-v2 table with CPU frequency steps from 200MHz to
1.25GHz to k3-am62l3.dtsi

Configure CPU clocks to reference the SCMI clock controller for frequency
scaling

This enables proper CPU frequency scaling capabilities for the AM62L SoC
using the ARM SCMI protocol to interact with the power management firmware.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
index 61bfcdcfc66ea8d802a36ed43cd01fbbf3decc70..a42ccd0d2fcc4d204cae81508f839c44ce83f558 100644
--- a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
@@ -127,6 +127,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@2000 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x2000 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
index da220b85151227c63f59b2b8ec48ae2ebb37e7bf..f7146421918f7037c6a192cc4765e8814a508afc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
@@ -39,6 +39,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&scmi_clk 356>;
 		};
 
 		cpu1: cpu@1 {
@@ -53,6 +55,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&scmi_clk 356>;
 		};
 	};
 
@@ -64,4 +68,47 @@ l2_0: l2-cache0 {
 		cache-line-size = <64>;
 		cache-sets = <256>;
 	};
+
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&opp_efuse_table>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0006>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0003>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
+		};
+	};
 };

-- 
2.34.1



Return-Path: <linux-pm+bounces-33580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69C1B3EDBA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 20:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AC47A6A70
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD1320A2A;
	Mon,  1 Sep 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O596bAKW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O596bAKW"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF743064B2;
	Mon,  1 Sep 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750728; cv=fail; b=HS5QcUU8qk7L97uMOA0/HbGbO5pyoP3DyeohFqyLL5gkzNpmE/qKrKUqOsT6KO7H+cdsAoJN1zAG5MLBufrPEwMYxDCU9CZ/0rTHPuzCIqt39UbN2G40rCqayLvfHan44CTbfzSI4i0Uz0OBBC+NydMQPVXRxQ5Ba5zmNDgAmS4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750728; c=relaxed/simple;
	bh=1tgxdEMoRj4EbLiKMy9Il3hIbO4Ec4COxzAh1VBeal4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ua+nvKA3qxQ7NLXhWaSP42/2Z9iZAuVJs/63cQJtJr4/rUPjVdyBTW4CI8dKZGojx+D1FldF8tnluonU7Lipgm4RN0Ff4ZA4zNJCW24MnDzrizfx1WaobtQTJdm6aEwQk4EKlBTpSMiCcVGMND/zwQ7FzpR8tmjvhdKPJGzh8vE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O596bAKW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O596bAKW; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CDGWfs6aMqb4znQvtLzYHn/jczTBy42RbuQc29zH1kLEl25CDDylvHgirwyWFyxC3xkCLA1sN1f5aeQujQyWjer2/MCO5DKVs1e7PxIszW6bd6SrBD2TSsbCZxgn/u17tlwh3GgXobpWzXvYfBheuPWAnSPvz4dq9sHIftOT5Z//GM3YMDSD3jQoR3U6gjYLQ677CtgPPVZKXvp1RHxMcb+cyIdykc4AjXFebxRd5Q3pIx7AAM3WSc4i3qoLRnXRWzo6eax06WuRc5y+c8RY0dZXbtULX/jcgnWGMzvFHWsK5waBDiLZlscdyhTm1YIBn7S2ZKHZsnmJbsESlJJ5PQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tgxdEMoRj4EbLiKMy9Il3hIbO4Ec4COxzAh1VBeal4=;
 b=SCnJS+FYYfDsEIySztj9Rme12msv3HxuG79x1F5jDcAz/O4fieqCseC/vhr2eDx0RhFPmgCg0rT/bnpkDV418N7WHej3qGN4SRww0j7ZviFP+Bs/ZfK/cawVQZFcJo0ZaFJ55H2LYqJj/7X2/P3ipND+UFFyRobutio3HVPA2mjxqUicGO+/BC/jgALl2LT0065znBs5gicgq+VnpPY7ItpMXSLOm6caxsjYYkVwvPOi+oE6gOkYW/9HcaR2OlKCZvOtXdnQFy+eT5kc3Rf9/RMdHXDI1qmj7UnLhOkyqsg0rwXxLB5wxFzqsvl67R9eGak1g9p2vDmZyGFJrs5SQg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tgxdEMoRj4EbLiKMy9Il3hIbO4Ec4COxzAh1VBeal4=;
 b=O596bAKWCI9a/vLg/8Gj/5jtgWzFPp0HULPfAgm+p45BKzl0wedNvkE+r32Yjn/n5iYvmtlXc/GDmDSUoHAp8B4Ig86sDj2FsCIS3Xdtz0SEZ16VmOntgMrmt0x03ZAyrhiSq6No1bUc20HhfNqCmdJAlRpG6m9MIuhs3b7qM/A=
Received: from DUZPR01CA0247.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::17) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 18:18:38 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::f4) by DUZPR01CA0247.outlook.office365.com
 (2603:10a6:10:4b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 18:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14 via
 Frontend Transport; Mon, 1 Sep 2025 18:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSzGqfU6jJYIA5hEDE8MKeJXRkHOE1nevkzmAN55xGNU/r334S6/HrRiike7mMkrGMPPj2jLo5qxFix0cyeUCe2J0GTiqv7W3cM+PdRtStS0ouiBfT/i1iwEpoe4C00OLHLAHo6QHhPgFCcb1MyybtJytmoD67jP0gfCnXbNNiGvAmYuvf22ONWKe5ey/f4vE5xkntL1UlYEhibpn5nUxA1j97e/ltoLkjjeSDiETmAkjAdUqgjGYGMhaQw3sYofuSZC5ARLTFo2+zDu0gDgcaDDtOOEOoEx95JiLbMuJiVu/evJIGGVXVrkSreIyl/h+CZTLTxpIceAGRMUIz0U8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tgxdEMoRj4EbLiKMy9Il3hIbO4Ec4COxzAh1VBeal4=;
 b=kHnodS/8FERrJAVxEk8+MBX287ni4TOEZo3ay5S1wU6clg0n97UZ6YEKPyoxuHxL3o+KOid3aGa6hTB7uw8qYLfLSPG/0dvsNDLABaa332f0uQkbVReFQBJ1iEEYubW01W4DIfDUCfrEMdBwRRB7c93Y7FoIFZUrwHuoTE72NewagnSpmiG+E02SDI6GHKunI9OhOEojMCitf3DuMc0n79kUXBhOocHg1DIVSRx7nC/BvcAMvbWxkvDDS0/5PJCeqfebOMAEbYA0zOfwaS74YyMg3LOk8YQfjaKEHlrPA9uTFGXcy2zYWfHiEUnsJMeOnmI2a7CV3NYIcXYm50+gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tgxdEMoRj4EbLiKMy9Il3hIbO4Ec4COxzAh1VBeal4=;
 b=O596bAKWCI9a/vLg/8Gj/5jtgWzFPp0HULPfAgm+p45BKzl0wedNvkE+r32Yjn/n5iYvmtlXc/GDmDSUoHAp8B4Ig86sDj2FsCIS3Xdtz0SEZ16VmOntgMrmt0x03ZAyrhiSq6No1bUc20HhfNqCmdJAlRpG6m9MIuhs3b7qM/A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB7613.eurprd08.prod.outlook.com
 (2603:10a6:10:311::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 18:18:03 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 18:18:03 +0000
Date: Mon, 1 Sep 2025 19:17:56 +0100
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
Subject: Re: [PATCH v4 0/5] initialize SCTRL2_ELx
Message-ID: <aLXjVNCbT6YeWlSS@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <aLW5OIgv8/bvvY9E@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLW5OIgv8/bvvY9E@e133380.arm.com>
X-ClientProxiedBy: LO4P123CA0350.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB7613:EE_|DU2PEPF0001E9C2:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1cd55a-9e5d-4e67-5115-08dde983f86d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?RVfx3qvAzVqDlm+yjWZpwh53702klPxU0jQzBX5cpADO1doFy5Co26qbltgC?=
 =?us-ascii?Q?9tvlPhdlL1r4+c+RwqKVTL4xRSeaQ2EAOhtqahwKXr/XczDzrEzli2P9I+Av?=
 =?us-ascii?Q?6Ewb73RCxaRKy6uUDiR4XwXIDtnRu9RFAuD1WRLglL80uDQADxcgQFvrQ1O5?=
 =?us-ascii?Q?v/JW+UOOZ81XSO0pLJPcYMBntrsspBOh9BE8w8+ZAwdEEGuemzrAGhzWXGej?=
 =?us-ascii?Q?MNm9KWLbV0ybrKBzPb0S1XdAd4lTi4LGjQVby50IRcUKhMtLGzanNlOcXNPc?=
 =?us-ascii?Q?7wPRX5bP6hy16+N+tFOhwDjQ/lV5DIK9gzey6MFvINl6dwoCfL9jA4bsDqI6?=
 =?us-ascii?Q?FY2DsefKkA40oOqY99N5NZZMXv/VWSN/BDtc0m0n1HahXXpSEP/srhKuQa++?=
 =?us-ascii?Q?J+QrEsDcwarX7+tvW7+yiRqkBEy9rVqL/hVzN1uKxM57nmNMW1yY+6OQiPvU?=
 =?us-ascii?Q?lH8+0QVIHqGNfwILIBzV3xVBqZHSMXQ4ftHIpkL/dMY74NHh3SsN/E8u+BhZ?=
 =?us-ascii?Q?yzd8YMrh3uN0MtfEXt16dbHOKHIH7zPGJeOGsZMHB9H46/1O9QzD5c+fM6Xp?=
 =?us-ascii?Q?X3203PHvb+8Sk+4bFckru0mu2kckiXaBH0x856Gl1Ki13QdYciGdzD5iYWfA?=
 =?us-ascii?Q?5PsCtXW0yjV8VJ0ttdhETeia2z1jRehAE5w6Q55DbRDC/gPTUNFnfiiZBMP5?=
 =?us-ascii?Q?j6R2859iwvXKt+D+BDNDnmIg2L8s8RqILI4LSzAYRDQTOqpf/orGjmCvkOzm?=
 =?us-ascii?Q?hw28Ri4Y14pVGgEK+vp7IQ7j+EvUveDY9/8to+P7Rs6qmUlXKPTmGaeYQgk1?=
 =?us-ascii?Q?KuJjlHQ4X3H7eblE3KfNq7DzUKN9D6Jdbud1IXLInjaotMz3GhVi0s9cqm93?=
 =?us-ascii?Q?zammxVFaYV9jqxk659LTrzNl8rvSSat3rzDDx6IkC8XTu0b1AbHtXwtw5aSL?=
 =?us-ascii?Q?fUtersx6yuD4hiD5DbmZQJtrBPbtdhhMYH1u1o6WINlGUv5LuulrLfhXWnQ5?=
 =?us-ascii?Q?XnUG2UJ2UvGOdtMwJ/A+HwZnRptg/MmblBlfeLQZVNKWuKm+ny7a+jU3JJL9?=
 =?us-ascii?Q?yCKMyuojxllGRBHUDAcdSIHNOo91Ozi4fta9vQjNDoF/tE+MSQBZEn2NDFWs?=
 =?us-ascii?Q?HaVUKjs5yAlhWDtqPk8Hbb3e2y3nAXt4SxEidARfRRNyNQLQALagcXnkEox3?=
 =?us-ascii?Q?b//+xN3S3veUeN88UQ/jQDTKowYBbCq2/gNdhTwjB9ex9sZ2LxKGq+096uW6?=
 =?us-ascii?Q?EMDlCCk8JXlX0CJw4chmQNrdtnSkY5PRA0ALckUaDeoVCC6sh9EbmA9UO2ds?=
 =?us-ascii?Q?nQUahrp032kyhc/sN4lwtNy5swAX55UhiIoCosvRxL6dxazxvLUndeLv3raR?=
 =?us-ascii?Q?WYlgFmYsMtQ0w8sJ0lycG9FsCzNgQQQe0VNriWUjQnCiXQWbdHZfh+S6NmfQ?=
 =?us-ascii?Q?YSxzXe0HQfQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7613
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b0edbf0d-284d-493f-ef5c-08dde983e3ce
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iAE5SrVj8lNxx4xI0xRblDzJ9RG2C2EOJUIJ6LxH7sPcBT/xiG1FG3viajhk?=
 =?us-ascii?Q?ewEvHZX4nW0GoJlXk2YnyitE3GTn5v2GP3LIwaAlL6PHBXmjMmRHbzxRiV/v?=
 =?us-ascii?Q?undZH+2cubos2Ml3NP53CPG0uFmooavwUc8QWmmKH9Y5KvPu0yRLZNE3LGO3?=
 =?us-ascii?Q?XOyQbP94791Wl0a89gxVyTzgnMjR8/1p/ejuakXfaCrwRDzu+pEbde8/xlia?=
 =?us-ascii?Q?xHGRbVQNVqf95yWzareLe0Xjb0lyLB3QFDcPLJvsi9jFJ9S4y1WEnC853+uq?=
 =?us-ascii?Q?5jsfvPC/q3qEAmBqkmTWVwe88BMPU9PkLndAZhs8BEICSzcuIfZj/QfKqz50?=
 =?us-ascii?Q?PIsxt519SH8LTwCm1B1wYF2/BzJVr/GxIK8xTq1wlc4UDk5DMX6OBVDHngXx?=
 =?us-ascii?Q?JDWmQ1NKuis53chjJPHpMTpPVcDHlPPy2Iyt/Fvpsv+oHXDlWRpZpez+vsAI?=
 =?us-ascii?Q?lJXICFZCEZIgPLZVQcd12SrbyUr38gD8sQgw9KSxhEMXIedczwGsnTgo/BHC?=
 =?us-ascii?Q?0mpE5qDIBYe0rRP2p/aFkHgDT47Itumpvso7HgH5CCuQ5KvnKF579UDrTF6u?=
 =?us-ascii?Q?B7LEsgYngkON3Tsa/+JGJ3pjzMTGbvxWnJuaUbrQM5YqnMSH6EZ0WPJbCJ7o?=
 =?us-ascii?Q?eiGVNvV3Nzyv3mh7qCbDlCX6lldNjBNr4rc797rPy4hAZduNjfjE3Y54NNzU?=
 =?us-ascii?Q?lxUq/aodCXhEpPDEARpKro3kW/dwYDWMBdMemfkZZrxIHGCd8FXsl3OL91od?=
 =?us-ascii?Q?LjlpTWwBpfL5L2p5cGiwl30PTDSd5+Q5sc/bYQgJ6LFbHOMAymTa72G5zQc3?=
 =?us-ascii?Q?59IT0ZKsgIVGCN14KzZXXJUpLydSCGoyrNaQk2of3Dqr4HDxvSekeWMNmQ8u?=
 =?us-ascii?Q?qQ377u6XRcpD1L3ynHhAKQ+j/QI1n7I+qw2xPk+uYXzGcWdTeo9DzLqmnPXe?=
 =?us-ascii?Q?0ks92dgo6HL2YwBqWZBoRKC/jQApKxWXIJqOraZ+Jhx0XjrOnjLOxfwN6yev?=
 =?us-ascii?Q?VMAcXZmilLeER9c6KxeK37xVtQN9eknKNo5lu9Xm5TdwrXczyv7IRCEE5jbU?=
 =?us-ascii?Q?ddQkx241DOdebHTNe6XAjp1DllK0LQtUE7+r079Qz5yuPgNDxj4jAfRIrAqg?=
 =?us-ascii?Q?s10v0ZUzawK68BOD4jlAsRT/R1yyIRAxtX0dizNGNSOHNMBUyVHxmQUT3Z9C?=
 =?us-ascii?Q?Uyew4PfcZyIDl7IJwvx05WFOKLjStlVj8J9FHNBFoUQ9uS9I3qn92AwkMXCy?=
 =?us-ascii?Q?iLVDiQ8OTAPX391H7RDz28kxW2cW6gDuhRlXjzivi4ZQfcSx0cMikGxKzh2s?=
 =?us-ascii?Q?EoK0DFQFpYkd8B9zyJKihxIA2KyrkfSPjH14+tFL9wFZ31JReVEqu56oUKx7?=
 =?us-ascii?Q?NucUOwWUi9csCcOj/SCVl0u+pZIhQ2nnQARpMKClkDee0JnS+zCROyzkL0ru?=
 =?us-ascii?Q?5ssNEfPsoJAGcXYh5p8FkAtkYFLBiSO4YzIme4/KSHS+IJZ0uUdwsQM01hmH?=
 =?us-ascii?Q?eFPHgiC1+QUfFkMN4AakF05BQdxocgIKBwYO?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:18:37.3397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1cd55a-9e5d-4e67-5115-08dde983f86d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662

Hi Dave,

> On Thu, Aug 21, 2025 at 06:24:03PM +0100, Yeoreum Yun wrote:
> > This series introduces initial support for the SCTLR2_ELx registers in Linux.
> > The feature is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4.
> >
> > Currently, Linux has no strict need to modify SCTLR2_ELx--
> > at least assuming that firmware initializes
> > these registers to reasonable defaults.
> >
> > However, several upcoming architectural features will require configuring
> > control bits in these registers.
> > Notable examples include FEAT_PAuth_LR and FEAT_CPA2.
>
> This looks OK to me now, except for one or two minor issues (see
> replies to the patches).
>
> I think we will need a way of testing all the code paths before this
> should be merged, though.
>
> Have you tested all the code paths, or are there some things that have
> not been tested?

I've tested for pKVM, nested and nhve and crash path
(I do my best what can I do for modified path).

>
>
> Since this code is not useful by itself, it may make sense to delay
> merging it until we have patches for a feature that depends on SCTLR2.

Whatever I pass this detiermination for maintainer.

>
> Cheers
> ---Dave

--
Sincerely,
Yeoreum Yun


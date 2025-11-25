Return-Path: <linux-pm+bounces-38524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB19C83631
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 06:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67EF834BDD1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 05:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE673280A5A;
	Tue, 25 Nov 2025 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gIotnAlx"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA42727FC;
	Tue, 25 Nov 2025 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048457; cv=fail; b=V1uEhgUUKLKY2n5W0t/TF6rQI3aG54s16tC3WWvaq7dZdx1ok11bmJRuLQmaDegYRr+DIrv1CSDHJJpF+KMP67hETCbcDT1fF+X49mDRlNY1HsDd1kUg1rdqXD3ntzqPIrcQO8i26HCMGR8dy0naUFhmcp8n1oOhxD46qL+6jyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048457; c=relaxed/simple;
	bh=k1KHV3qDvSWTXtGGR78NGLbNH+h4g8cmSFLWdvSfY+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibxoq/p52mE8tCGMI3v49ObR+T6f3hlkx/JCk/V/5cBtCrI5iLNyduCDkS/89+W5IlafinFKeVZ9oi2yZGWlKmuaPViT+2tgGc5jbR5NzgLrM+YWx+qDis3CScrmEbhWu4NTTJ7dEU7XjRhb0ihhjZL6F2Wm6l/UhY/Ww6Doveg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gIotnAlx; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMWLy/Ry8DMDqNXc4td1ON9Ewo3JZGD0whH53plbgpVFqN5znEvAytfd1EJP0L2eGh8GXHTeTCELyqC45uPBVGQ7TfHJZxV1n+m9n468cDTqvZ9FIy0PUpYj9o+NzLmRupEVLTWSjCBgRFpzkxogDLuY7d47q3SIaQ9gHenuQsdSHN/FN8GMtuJVsu8j5EsFRop0ExtM0YxQufl2TrrE6ZYuo4qsSrO/brPNbS5v4u6kJNLWvyp4dIdn2+AiCW72FXDN4wGD3iaTWdKsa11j2U7jfq/qfJGUS8kLKGAyvxgj/EqGbx9K3WgzgaGlEYSjVAp/Z+JSF/Qalyu4uORxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9POQacBth59HF47rL+GdIMXkyOKLXJ+qm3cUs3dv2V4=;
 b=DCFJoXNdONYFyfxNWa59uXmEYX9tAQk9dHeiT4yVJYAHSsf/ys2tIMbj/tySb90Ku1aIGOO8mp5+DnIl7pE/smcAQIiH/t3QAGM5aRzCN2YpRHXOH/FOZvXudxOv2LBEu2bDoCaGZNXRdXMVKP9GhaH+11P+vNnoZZtDgg7PhSQ5y5k9dmLTAsCl84nVKE/5SBeF6l8sZ4VQWUnJjLvpJe2pdboqvHreQFe3wtkjnSpwR53OOIW3towHAufjTQQrhHWX/bKjocPwLAoo4YRG2kz+jVgSdQpkG+uPko0y8LtPfwyBPzelHusZjGB6V3RtjOSaTvoMWWdLB8lCW6gE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9POQacBth59HF47rL+GdIMXkyOKLXJ+qm3cUs3dv2V4=;
 b=gIotnAlxRKfOT6xnqSUbKSappKeh/DARTS3BXbQUbFdl1wG8/MJ56YzqESHCBVcnhRz1NR7yowp6jIfbkUZgs6L0bVRx6J2B0hNMF78SntYdab2MDYUus6fWMn0ogLKSq04UPdoJeakys65PL4Q910d70VUQiM+mYxjBX5d81is=
Received: from SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8)
 by CH3PR10MB7702.namprd10.prod.outlook.com (2603:10b6:610:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:27:30 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::b1) by SA9PR10CA0003.outlook.office365.com
 (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 05:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 05:27:29 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:27:28 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:27:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 23:27:28 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AP5RRkJ3149795;
	Mon, 24 Nov 2025 23:27:27 -0600
Date: Tue, 25 Nov 2025 10:57:26 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, "Prasad
 Sodagudi" <psodagud@quicinc.com>, Deepti Jaggi <quic_djaggi@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] pmdomain: Respect the CPU system wakeup QoS limit
 for s2idle
Message-ID: <20251125052726.26blhgd5rb3swowk@lcpd911>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
 <20251121100315.316300-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121100315.316300-3-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH3PR10MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c9dbf7-8cd8-44c8-ad45-08de2be35407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZ7UUJlMXL/KoS3V2BYGw7KtZJ8y1ruxkz+dAaDokuwS3cmotfyHVsbW20Jw?=
 =?us-ascii?Q?+NlTiDQfkOJ1fnWFhI3i+8iQGGNwwQuNNTsk4AcZqp0IfUkMPkvJ08WwXvuG?=
 =?us-ascii?Q?RUwlzX12fU/wNSlHXOgB7WQCrS2h0fnOVIhhrxwjcxR2qbojMP1ScWvyRU7T?=
 =?us-ascii?Q?k8HeyYPnCeJuEEJIncHd35ccy6RyfqzTZ7vmSqh8UC7+4X8/OdPhQOfEbXcA?=
 =?us-ascii?Q?oz1Q42Y+6oijMe/Um39IlNcI4qyOal7FMpnqslLVlCpMdOsr+Gqk6ZydSI5K?=
 =?us-ascii?Q?gbc8KtA3sv2P2nlM/l/QNxqTYannonP1qGRQ1XaUDc7YBcPB12rrMLCZjoe7?=
 =?us-ascii?Q?6bKVXdOepUl6LrahfLp/eLka2QtDq31wXHsdsrdVexEbmLUZD3uBnRh9YRYq?=
 =?us-ascii?Q?Feu2qmGCv6fs5/9nsl9jLV2lhLTE19OXSVHhJzxRaqaJLupDYzx1EcFWZYam?=
 =?us-ascii?Q?cKQFP+Q6EmMt7Pl7HUv/f8AW8EH4YMCV4jnUQmQEWQrRyjjsDaesujScYNM4?=
 =?us-ascii?Q?sEpOFDOwXnTUvXdqWBaOgWZ84+WcgxeuIH/X5GQzoElKFrNSbzYNmdfKOBW0?=
 =?us-ascii?Q?ZmWVWNS3KH7Xr/WqfTTcElekojRK+lpI+E7mjsXsNeXwRAjOCe8rNOJWq01X?=
 =?us-ascii?Q?r7lTMhgMsmrx+QI2dazPE94687pYpLJTfYXZbdKy1eQ0H/ChXqu5bgB4vMpW?=
 =?us-ascii?Q?gVIPxNfmSfTPtjHerB4YOfg7Ebm0WoRpzqWBHMGOJ5p1kOOxKklD23NpDPWT?=
 =?us-ascii?Q?PVMFokgcVnu0zNq3a1ERTWzhqMZ88UWdeoUAA9JL2+gX+FO5K/BZ7cA91TJB?=
 =?us-ascii?Q?V2iDa2yIN/sWSIFbIYs7vY8ngMSfR6JcFHSMqWNy42WkSNAiyLHEtOMCcdBP?=
 =?us-ascii?Q?wzVOku0NoU2QELsPbJI4yIN14zh+SvUCUJ+lhzlUmb7m65Idd6iREGL3mcEm?=
 =?us-ascii?Q?gzZ44EMZhnlV2WgKz59WTioyKIIaigbqpbSMf2Y7JnmqFFpRESCZxMqMDJiK?=
 =?us-ascii?Q?elDEaMTc4+nNr1Aw9Uwgjux9TLl5ozMpxD4ozsYyXKfSJocV6Hrto9z6wKId?=
 =?us-ascii?Q?aOBX321T+fcu5DNLN2mtbH2v5jqQbuke/x3iyj4UlkATlpGeCT+rvMUvhvaU?=
 =?us-ascii?Q?M6VhFAdbcjqhOHVt+PtN0kUUr83jSlEq9saFIudZujAJARDC+TAj3Q+i+Qc7?=
 =?us-ascii?Q?RQgd9Z3hd+co4IY7jacQemkzGyV/WwvPILgHHqmbiMDPP4fWexAo4rPiGqHO?=
 =?us-ascii?Q?r6ab7kEUrpjEKLoWNptCrOYR9Nlz0dRkLS/XCLdProbuWmsdlK9fdsqNOPQi?=
 =?us-ascii?Q?vwFgvGJxPMRS2ZjjcnPO8Fn0riigNWmn6vjrUdBWHm3pojNL6POK+LMYOyoo?=
 =?us-ascii?Q?f7EzBoF1N/hyiG0dDu8NG+QR59UmVd4hPqa1PFjaLv7hXaaqoOJWmsZK24up?=
 =?us-ascii?Q?dHh+OsAkXuYCLaXib9SeEeCeBDjzL2pjn2BvKKPW2svbssNnC8Zuxb6hHta6?=
 =?us-ascii?Q?QrQc32aSlSck0GudXYAI4whTow8kPBpKsJzvVQWROwmqBJnoX5YZcyX2aJRZ?=
 =?us-ascii?Q?+ZYMVU9ty9AgIOJpD9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:27:29.9869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c9dbf7-8cd8-44c8-ad45-08de2be35407
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7702

On Nov 21, 2025 at 11:03:08 +0100, Ulf Hansson wrote:
> A CPU system wakeup QoS limit may have been requested by user space. To
> avoid breaking this constraint when entering a low power state during
> s2idle through genpd, let's extend the corresponding genpd governor for
> CPUs. More precisely, during s2idle let the genpd governor select a
> suitable domain idle state, by taking into account the QoS limit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


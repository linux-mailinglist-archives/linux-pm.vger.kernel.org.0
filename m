Return-Path: <linux-pm+bounces-40985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A8D2F3E1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 11:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3B52301B808
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABD31355D;
	Fri, 16 Jan 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S2ZUqB1M"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D723BCF3;
	Fri, 16 Jan 2026 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557984; cv=fail; b=b29dJMooHtUdiNhZE/oZk7ElpUnQYzZS6gMfuaXMcjeRAQdXO6TkKfFhzN8I4XvXDG+ALsWe4qHYTsL5P7IVifypdcoXX4EHc48K8UuCSE+dAOQB1BO1AT94iAEcNl4BSLQjl4K5Ht2pZoojiXzO7lyyBtSehxHvwq5bJvc16QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557984; c=relaxed/simple;
	bh=Ib+lzCoLRvghAmLYa59qlJ2c0K+ANrxfRXmtqgvQTas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj9/oQgBOOe1vhjZJy2YlzNhTTSIY1U5zW/jXByPs3cvhyqrSnrAwn0dp8nHIt79vrTdlBVbDSelyq1vMfeHBeZUyp7w7Bjgh4pPfYA6QHUM61D/E5OmaYQ1kXPY3EOzrPzQyqJDF+fz+u3DLN48HZ648qW98Bhz14tHRpbNFfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S2ZUqB1M; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mknMf7DqzsWCl9L6WkJ5J3RZiXgD0u0MkLax2UMluCXPEYVhXPxuw/3fWeg4HA4+EPUjachuktPnGvrnKC8hVFaHWXYNhW1LFXGca9VtqRkdpr/a17Jfgex8AMFVHloZJdSRUoebVpqJYuA2Qdx4X7ncIhTh0teBizz2f1fQq5Hv7oB4spGgUJ4vuQTQLWZ4KTiJr6TvE0J1Ze6B9s8B9Sikj6XMK2fHgYDtGvErwz1ofGSxojvk/xNoUa7SEwDn/9SK0EvWershb4fhJKtvZOPlUN/uKT0Tz52+IPqb04iWoCEHAP7HvLBIwb5eN3JE2bPHlE6cybai2zYm2xnxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPjXmy1xHBrNjdyBSRWzNyBvjUZ6ThBNFLMbBPnLLqc=;
 b=B8Eu6kgm9EBygXAKSswf3pZWaS34ZZoGhW0ucuAM36b0f4JsRuhzArKP8SL+pHJWEPaCuEZRrVoFZMslkNVa1Gm2CnqzrHkVhc5pgAK60LhsWlAQY2JHR3NdH9oHTSL9RaswrsK3CJiK2vAfuiIGhGpw0R8Ob+92g2xrVy+KH+RK0wIuIr3YIEq4G1OWcPSw9+OZgP333zBcPaXkJ6nLrg3fyimxqSa1ry0cnDfvpHCF0Yk8EcpNpV3D2GHOmumM+a7aogaoyQf4CeBE+DxkpK4uUTRmx2zdtGVXBM1cveV4CWB4j1zX9fLYcCVvV8yRirtyFlvtbCq73XVMSYzI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPjXmy1xHBrNjdyBSRWzNyBvjUZ6ThBNFLMbBPnLLqc=;
 b=S2ZUqB1MsRRRd14AlXAqcM6ClqlCva2bVi55+LjUZP1tjNmZSc2f5fjn3DCF6CAGu47K/bdywG/AD6730nKvjDl+e7cJeaWnfVJ54l+fGqMxe8vM4f7+mZ1AX9g6RmtbpGoyYGR8k1zlRhxvZFE5FyxopF1KRl8ucFF02RDA+V8=
Received: from BY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:a03:1a0::20)
 by PH0PR10MB4709.namprd10.prod.outlook.com (2603:10b6:510:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 10:06:21 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::54) by BY5PR16CA0007.outlook.office365.com
 (2603:10b6:a03:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 10:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:06:20 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:06:18 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:06:17 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:06:17 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GA6FUm2975025;
	Fri, 16 Jan 2026 04:06:16 -0600
Date: Fri, 16 Jan 2026 15:36:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Kendall Willis <k-willis@ti.com>, Sebin Francis
	<sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: dt-platdev: Add ti,am62l3 to blocklist
Message-ID: <20260116100614.k2loytoywr4vqihu@lcpd911>
References: <20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com>
 <20260116-am62l-cpufreq-v1-1-63d062317ae9@ti.com>
 <d479060c-6b47-456c-abb6-9c5139bbd36d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d479060c-6b47-456c-abb6-9c5139bbd36d@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH0PR10MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: edae4070-841a-4363-7ff1-08de54e6e56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RfDxqTUaOj4skOioqmM4I5RApG7Bh1Zx7+wWbRiaA3pNTHWDG17AKdoiL20?=
 =?us-ascii?Q?Y1Cf8V9LhFj4V9eGuKL7PoameDnMdonUJDbpnPbZxLfvR2WoKE078DK+qMlb?=
 =?us-ascii?Q?/+hUMi/PEYZd+k+nB4+FD3Dft6FpvOUPKJqSuUUrNqar3dQ+oI7izIl5nNkC?=
 =?us-ascii?Q?l/HpF87Bx7M2m+FkyufHNwqZxyEvpc4pLtlhWhRp23rkQncNSS7DJrm8Xgb3?=
 =?us-ascii?Q?W30fO+5ULjR5tvjNj5S4d8GE1Khf4GKCKObHEpiRNF/C7jDeZoY71BcTcCHW?=
 =?us-ascii?Q?cONYRrLfokaqeUIsKKVcbgSwx1tpGVAZO/hfyefmS1Op7UilmHB3jxdBhVih?=
 =?us-ascii?Q?6ktipWYwCdWFjCzc5zs53A5dDlSIot2BVpo3Gmbl6yLj447QzD1zzNg6dsjd?=
 =?us-ascii?Q?DY6P8zUkelhBsMGv9xc9vCZlSG9OCvRujCdubIynd97LTvN23jPy0U1pdMft?=
 =?us-ascii?Q?63Y6xcX3a96KZO23V8Uq62qL2H1ICq3Ypf1UyQFe7xvIC9czkN9B7kgaiajb?=
 =?us-ascii?Q?waFceJims7XKunl7LbPBjqDuVR3Qah9dEXkB4M6tH3yEU1SfJzaEERDF1w8Q?=
 =?us-ascii?Q?NLdfN2VCS8FZKyoD2Gc+SGuccbCirHbSmE9YgREw61dcbm3ej+ENZP7u9s3X?=
 =?us-ascii?Q?OPEQhAAKdnHT/MuvcelwBTrRkpPkj5nFxxqS+6D/ZL2l5rTuM+/yKNPuGCyd?=
 =?us-ascii?Q?uasGh1gHzN9B09tXiHy3bUs1c30lQ7d+aGxuYZ9rrdSLMlWl5gelaHyLE3Z2?=
 =?us-ascii?Q?tjrZXbFaXFPxiqNc9RDMIBVGscEZdIA7oAFFk+gB+/9ndbT+SFHqKQrLxBwN?=
 =?us-ascii?Q?F1G8cTXXG27/NPU5sdQXctZyG/ew/Xed4PS+Z7UVmty+Qan4WxZDB8mERIAj?=
 =?us-ascii?Q?WEdIy8v+4Rjz13SsWtwu3I4T8zELwo2YeRj1nEjnzjF0iMKVC11SY9Bq1frL?=
 =?us-ascii?Q?S4WXJti8e12JkhvoUdzJ+7ZANjuwdfmhXRKc7TbxGcD4/J4GK+d9g7ClPKeS?=
 =?us-ascii?Q?T+BbVFLwkVaZbvmwAmKl+H+2qPH0QpAhVBa59mZMTTx1nHziBaDWuZAImIko?=
 =?us-ascii?Q?Mc78qUhFR3VSvBPzUwtuhVMeW3JcRITPuH5jrkI5bfuNLXSqt9UDkQdEUuD2?=
 =?us-ascii?Q?I4SlLGjZSrKP3SmX/mTk/ClJtYRCvUYQ/wSqe9C7mV/0pWpvPobNNHwPRFpz?=
 =?us-ascii?Q?laDzMRqQTdiLfcZmlivl0C66rYJqPwlfj23hKm5e23Uhh3JRKHMJCUCOJ6cd?=
 =?us-ascii?Q?7edCP3WtbDFC2tf5iOIUVEnNTvr32BGzvAPIxpIzppplsTElMy5WrCbTw/iy?=
 =?us-ascii?Q?ZicPuz1METP7qEZ5HEAsQQLuSZKHgzM3M8eLbUyCESf6PbXQL/8V+tkudXyk?=
 =?us-ascii?Q?Ia1Qf1eifXf7/Sxw87uPQb5f7n1ffoP+C5Afy86p/u/jDsLAO4flFBm5QNxb?=
 =?us-ascii?Q?wOOI/5PKW2Y+mqieiDlBsr5A8YHUXNE6uAXD1QVcTu4mTKBNg81wUhrjtZqz?=
 =?us-ascii?Q?FRUOV+2PPZMJDb7TKVG1OeWz271NlgE3Lpwi8wRYKQmMFM4L2b9LyQLrFUV1?=
 =?us-ascii?Q?QGzLoSIFvSrM6ZMeB7jE0l5NsJy8HcymyZJN13lLlq1yaCvxefXeLUlpeKua?=
 =?us-ascii?Q?AR94szCN12te+HnnVDwH9zEXMKWIG1lgKuZne/GzZincW9aKHgwrR2gIv6lI?=
 =?us-ascii?Q?n3eQOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:06:20.0181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edae4070-841a-4363-7ff1-08de54e6e56d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4709

On Jan 16, 2026 at 10:16:08 +0100, Krzysztof Kozlowski wrote:
> On 16/01/2026 10:01, Dhruva Gole wrote:
> > Add AM62L3 SoC to the dt-platdev blocklist to ensure proper handling
> > of CPUFreq functionality. The AM62L3 will use its native TI CPUFreq
> > driver implementation instead of the generic dt-platdev driver.
> > 
> > This follows the same pattern as other TI SoCs like AM62A7, AM62D2,
> > and AM62P5 which have been previously added to this blocklist.
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 1708179b2610bca6035d10f0f4766eee6f73912e..29122bac2e22f6e7a8e8294cc01923c8a13d53c1 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -194,6 +194,7 @@ static const struct of_device_id blocklist[] __initconst = {
> >  	{ .compatible = "ti,am62a7", },
> >  	{ .compatible = "ti,am62d2", },
> >  	{ .compatible = "ti,am62p5", },
> > +	{ .compatible = "ti,am62l3", },
> 
> p > l

Fair point, I thought more from a "latest SOC" point of view but the
standard here is alphabetical, will re-spin.

> 
> 
> Best regards,
> Krzysztof

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


Return-Path: <linux-pm+bounces-38523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5DC835D4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 05:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C98E3ADC8E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419D27D77D;
	Tue, 25 Nov 2025 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OvzJrdwU"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931361F8BD6;
	Tue, 25 Nov 2025 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046589; cv=fail; b=rjiTIkztw3YS1U4PFpiN/Ssrx7zRS8PgE2DvzZTDotrdvrc4uzKthLKPHFwhcesZ2pMbQm1H6yhO5WS94WzV8o5H2voqo1+qc3hvD8w6k++bK1Wyk37lqdJbEHvtt2IinN5biU0k4BuNr7XB3kPVjY8cW8ee9+Q+l/G/Iu3SWsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046589; c=relaxed/simple;
	bh=SHpja7qrgrV3BbyzRDKdJpN8g7oXVy1RozrgfMEYYMg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkT6BKDn1iHvGwc+mCuZpTm/yH4g9fO9iVW1lfmfsxnmNwwWpVoU6i0aCEMHH+jJGgdP5i+Vuef96nvaoOKF5ovet7ftYMRi2wK9v81OsH96l3PJDb4eYwYuEdE5wLc+iBQ7bGqcHN5wg8UPL9+Mqwwd5WllM2L68fU6w50fi6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OvzJrdwU; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyhCUJxh3Ncg548LVARxpp9AfZR6SSo1neemh9Je9qu1W7pvKU1fMdI6N9ngRgH/QfooJ+DRvJPGx+/rD6VFiOBmH941sICDdsrtY1QR+h9Wbbs8QSWX5QaFHLGsmWNM1A+XA+4lagjbmv7DqtrrOXl+WvP/qdD4rGQpZFuF9RX8BZI/C+gm7D3P3egHNADDzZzq/dxggdJwNGjxawc2zHF+p7KpHI0a8IzWPZWVlvNzhQcQ6haMf5UfwzKdOBmLNEJ8r+8hkyZzTubGqn8wf567drjIsfJ5JUxNBJsqaEiloqeYmWH07ddEtZv8kVDPM3QRd7ztNnzigsD+DFZjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36GB82WAbKHaqh+/VnUv/5FSkTwkXmI21zDHZYfZlAo=;
 b=Twko5pnAZk89cLwbH2Crz7Ua7Ajp4UsXzsLNR6eXj2hGm+an2QDrjwd6gPRhLvmtni1VHlogNdBV1d6JJBz6ZF4qulmnvCDXiHyWOgdesiV+h+8eugzxFecJxTAlYyqZmIOMn+07boP61gMKcVdEDiA/cedwTKgEthD8Jxqwf7HbPeUZrX4J/8TXlTNE/Hu643TcFtHG9+zqYoFqBHXqcm2KB6oQpcMDjecATG7boOxNAMbihtaKZqQrjmAZNPX2sM+vpUtO4H6sssw5G6Q1rE2cRF6LnQem/TS7ZgOCfxSVTqMP/K2wqdg4nzDAqdKc9C7WLRI1zOfD61RgM9uqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36GB82WAbKHaqh+/VnUv/5FSkTwkXmI21zDHZYfZlAo=;
 b=OvzJrdwUuUhtkIYEXUzOkaO47afOe5OvAKE7sxkqmy7OyzG4mi1jFyj5NOZ25vA4B+iQ1id7+C6KPaVYuNByMhDyTu9dZsTS5FaLacwyxaf3bMeDDsXV/k+QoC7o5o2muHRzdyJpmzJg9cXLGE3e9dIBHcm65ZRrMYC0Sczokwg=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by IA0PR10MB6841.namprd10.prod.outlook.com (2603:10b6:208:437::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 04:56:23 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::9a) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 04:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 04:56:21 +0000
Received: from DFLE114.ent.ti.com (10.64.6.35) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 24 Nov
 2025 22:56:20 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 24
 Nov 2025 22:56:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 22:56:20 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AP4uJQ23107134;
	Mon, 24 Nov 2025 22:56:19 -0600
Date: Tue, 25 Nov 2025 10:26:18 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, "Prasad
 Sodagudi" <psodagud@quicinc.com>, Deepti Jaggi <quic_djaggi@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] PM: QoS: Introduce a CPU system wakeup QoS limit
Message-ID: <20251125045618.texoubmzmiz7cz6c@lcpd911>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
 <20251121100315.316300-2-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121100315.316300-2-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA0PR10MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: b27f2e16-a7ab-4d43-240f-08de2bdefa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mgCeCVYOIDgOIdFU1QDhavjTynDiPyaTKZmu3FH80xHc1sJSo8oa1qY0h2P?=
 =?us-ascii?Q?Eqt0A/8g/VzlqmUfrE3kyHhAgS9UyX6y6YRixTgnJHQ9hrxB9rJBObHb/30e?=
 =?us-ascii?Q?sX7Dz0hcF09ohC62wvIp+L+EeIgkvkxagr4Yxh6UPfeYYeGHO/gEPkir60Yb?=
 =?us-ascii?Q?zInQ9ZqFeiZsuiqKOI5YkGm7Q86CdaioJjM+wVhiNQnI+msSp3qPPtuNn3+1?=
 =?us-ascii?Q?icOox0oSXKl2Gh8jiJq9heiaZljI1u8Se+qKFpa9BpdRQL06w33BFdlDbbNL?=
 =?us-ascii?Q?g9OzOfaEvBXijRkh047EPqWF5eb/wmGBzfl5j5dP8NhUVhSFsuelNI9+20sa?=
 =?us-ascii?Q?UCukczarGKyT5/HkRHND1V8ztfZSNypdWK14eblVwTC9g1f/rc9+gL6oB5Xv?=
 =?us-ascii?Q?wLBAxbIuj0Oc/cXpxpc8Ao9iS0XsaorrL6uhQmmiJDj5hMUtAYt+xv81BhEl?=
 =?us-ascii?Q?chg1EncmunlCbJCqba1AG9EmFcGeQN5afkvCaMyQz65r7GudrAg3qmbXrq/9?=
 =?us-ascii?Q?HQqFxzWEDhjjL+nLEesLI0tq9keqIky4jQ/mQOULfmXyI03TTbxcVk4jtfJn?=
 =?us-ascii?Q?gltJtVQOCvjKjlfe/STleXdioMFW+w8kCIAzaHhSuhOYus8MC8O7AglSNoIp?=
 =?us-ascii?Q?OD7nVVY6ncOe9XmJX8vNvES0ZZuToX4dTsDpwXaNdgOqerZhXKS1dlFLADyc?=
 =?us-ascii?Q?3bMUJotWaZ6e2weE/R+ii8le+0Otavx3gLtO4JybWEZrV83jQmZWDdwS8B+S?=
 =?us-ascii?Q?xFswjapGY5g77Tuwo2ZWleid4hIenqmP5SobnmYH/SLyr+KxEQLiVhQbqyHL?=
 =?us-ascii?Q?777k9qe7POd1pkFoyl1bvDVdlXFcgSDLuup6kBwD3kzJ+BqhFq5t+Zzkk6RK?=
 =?us-ascii?Q?umT86CiF/lH8Z/4WZXGY8DjAh4rtZ/ALVQk2uWdsmAtwbOFWokS4WuYyaKQu?=
 =?us-ascii?Q?WM9WW2BOsRiZijxlj/WWIO0ZuV52AoA0rSN3lrhZVkfIxo0cF095sbLuQWxs?=
 =?us-ascii?Q?TBbkQnyuLU11rkTAuKQlkc0H1UwLtpInfmW6gECl0lLmjLGr2LDM/cvGgerp?=
 =?us-ascii?Q?N93nVgkyRD+PXYgMRab8bpJT1Gy5CMo3nuVSLo3fsbC30c9/GpST0qd0HppF?=
 =?us-ascii?Q?XGViZsm9IkxAiDF/ZERXnYs4KYNqx+7tTy9VGyffhKzsX4UGkDeRlqaKQ+1f?=
 =?us-ascii?Q?GcIxeulQsv/DPUu63hG3epzESvDnobN8lVxE1+a5rl2bHv2ygQW1XHJhsV/G?=
 =?us-ascii?Q?vycMAPoZwrJHuDvKYJezhVnY6jMBbYwM8DQczDB6T1aJ1dX/8fsVbaWyOjGf?=
 =?us-ascii?Q?Eu6hW/OOyaj+MQpiUT0KC5kvtgFYq43VY3HR8sERlt+KLEmVExwT+QfYHkGn?=
 =?us-ascii?Q?9KB/H0EKypDjOtuCaVISAC3qszpVKrSHihTTWbOyeCwrQuDd8niBJr4kVyyu?=
 =?us-ascii?Q?/IDMK2kFIhXAK7n2UhA/j4YEFf0oaQMeG6uqDmyHGid0Qd4PNC4fPBkeSots?=
 =?us-ascii?Q?Sj5EHzOLoSROixi37wrR8SPfFaTvboxlQDQ/cyiido8jLQB/nqz84tfGkw9y?=
 =?us-ascii?Q?kRBV4MRRgyYqnoy5MXc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:56:21.4676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27f2e16-a7ab-4d43-240f-08de2bdefa4e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6841

On Nov 21, 2025 at 11:03:07 +0100, Ulf Hansson wrote:
> Some platforms supports multiple low power states for CPUs that can be used
> when entering system-wide suspend. Currently we are always selecting the
> deepest possible state for the CPUs, which can break the system wakeup
> latency constraint that may be required for a use case.
> 
> Let's take the first step towards addressing this problem, by introducing
> an interface for user space, that allows us to specify the CPU system
> wakeup QoS limit. Subsequent changes will start taking into account the new
> QoS limit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- Add Kconfig for the new interface (Rafael).
> 	- Updated commit message.
> 
> Changes in v2:
> 	- Renamings to reflect the QoS are limited to CPUs.
> 	- Move code inside "CONFIG_CPU_IDLE".
> ---
>  include/linux/pm_qos.h |   9 ++++
>  kernel/power/Kconfig   |   4 ++
>  kernel/power/qos.c     | 106 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 4a69d4af3ff8..6cea4455f867 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -162,6 +162,15 @@ static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
>  static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
>  #endif
>  
> +#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
> +s32 cpu_wakeup_latency_qos_limit(void);
> +#else
> +static inline s32 cpu_wakeup_latency_qos_limit(void)
> +{
> +	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}
> +#endif
> +
>  #ifdef CONFIG_PM
>  enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
>  enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 54a623680019..839e2dbb889e 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -202,6 +202,10 @@ config PM_WAKELOCKS_GC
>  	depends on PM_WAKELOCKS
>  	default y
>  
> +config PM_QOS_CPU_SYSTEM_WAKEUP
> +	bool "User space interface for CPU system wakeup QoS"
> +	depends on CPU_IDLE
> +

I see that checkpatch complains here with a warning:
please write a help paragraph that fully describes the config symbol with at least 4 lines

I somewhat agree too, since it's a new and pretty important feature that
we're putting behind this config best to add some help around it.

With that,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  config PM
>  	bool "Device power management core functionality"
>  	help
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 4244b069442e..f7d8064e9adc 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -415,6 +415,105 @@ static struct miscdevice cpu_latency_qos_miscdev = {
>  	.fops = &cpu_latency_qos_fops,
>  };
>  
> +#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
> +/* The CPU system wakeup latency QoS. */
> +static struct pm_qos_constraints cpu_wakeup_latency_constraints = {
> +	.list = PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
> +	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +	.type = PM_QOS_MIN,
> +};
> +
> +/**
> + * cpu_wakeup_latency_qos_limit - Current CPU system wakeup latency QoS limit.
> + *
> + * Returns the current CPU system wakeup latency QoS limit that may have been
> + * requested by user space.
> + */
> +s32 cpu_wakeup_latency_qos_limit(void)
> +{
> +	return pm_qos_read_value(&cpu_wakeup_latency_constraints);
> +}
> +
> +static int cpu_wakeup_latency_qos_open(struct inode *inode, struct file *filp)
> +{
> +	struct pm_qos_request *req;
> +
> +	req = kzalloc(sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->qos = &cpu_wakeup_latency_constraints;
> +	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
> +			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> +	filp->private_data = req;
> +
> +	return 0;
> +}
> +
> +static int cpu_wakeup_latency_qos_release(struct inode *inode,
> +					  struct file *filp)
> +{
> +	struct pm_qos_request *req = filp->private_data;
> +
> +	filp->private_data = NULL;
> +	pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
> +			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> +	kfree(req);
> +
> +	return 0;
> +}
> +
> +static ssize_t cpu_wakeup_latency_qos_read(struct file *filp, char __user *buf,
> +					   size_t count, loff_t *f_pos)
> +{
> +	s32 value = pm_qos_read_value(&cpu_wakeup_latency_constraints);
> +
> +	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
> +}
> +
> +static ssize_t cpu_wakeup_latency_qos_write(struct file *filp,
> +					    const char __user *buf,
> +					    size_t count, loff_t *f_pos)
> +{
> +	struct pm_qos_request *req = filp->private_data;
> +	s32 value;
> +
> +	if (count == sizeof(s32)) {
> +		if (copy_from_user(&value, buf, sizeof(s32)))
> +			return -EFAULT;
> +	} else {
> +		int ret;
> +
> +		ret = kstrtos32_from_user(buf, count, 16, &value);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (value < 0)
> +		return -EINVAL;
> +
> +	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, value);
> +
> +	return count;
> +}
> +
> +static const struct file_operations cpu_wakeup_latency_qos_fops = {
> +	.open = cpu_wakeup_latency_qos_open,
> +	.release = cpu_wakeup_latency_qos_release,
> +	.read = cpu_wakeup_latency_qos_read,
> +	.write = cpu_wakeup_latency_qos_write,
> +	.llseek = noop_llseek,
> +};
> +
> +static struct miscdevice cpu_wakeup_latency_qos_miscdev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "cpu_wakeup_latency",
> +	.fops = &cpu_wakeup_latency_qos_fops,
> +};
> +#endif /* CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP */
> +
>  static int __init cpu_latency_qos_init(void)
>  {
>  	int ret;
> @@ -424,6 +523,13 @@ static int __init cpu_latency_qos_init(void)
>  		pr_err("%s: %s setup failed\n", __func__,
>  		       cpu_latency_qos_miscdev.name);
>  
> +#ifdef CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP
> +	ret = misc_register(&cpu_wakeup_latency_qos_miscdev);
> +	if (ret < 0)
> +		pr_err("%s: %s setup failed\n", __func__,
> +		       cpu_wakeup_latency_qos_miscdev.name);
> +#endif
> +


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


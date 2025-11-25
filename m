Return-Path: <linux-pm+bounces-38527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC0C8367C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 06:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAAE3AF1D1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AA2206A7;
	Tue, 25 Nov 2025 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cIh1LmVD"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4320FA81;
	Tue, 25 Nov 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764049291; cv=fail; b=YqzfEBjZryfIN4Ii+L+oypp4nW1GCI9fj4sAc91rgOdENuSt6GqIbJMq0DtqruCtUh6ZcYXILiYZASyEuOHZdVk06mxnxdqv8wEorZaquVOoQgBEAV4kyjvzWTdpqJkvbyHkpBR+wXPQ0W9ikHFKhN+4Fk/HVu/jC8yft262bLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764049291; c=relaxed/simple;
	bh=62O3kJfWSmKu+6A5kSOKLP676dKRN7iPfjeQngemL3s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXA7w/IP8WFPvWzQ6jHfqHcS52GWeqANR3OwodjlqH/JMxONPU8m2lJbDfDGA8FI8sdFaQpnm34ym3GZHMPqn5Qic4oATgV/FambfoyaG4hrw25pzNX8xDqEFph9BiGdf9/QAkJN0c3aGQd+nhkV1bGQkUCn0OZmbvXCi4IY9C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cIh1LmVD; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEOXAVTA0MAVmZFWOJswHzRoQ8mftMmiEYa4KaM8gFvL1KWOvSdJdJhejAmBmTymOF+HFy1QTkqc15oxbJknvsfW6CcCFPeTg7WrLPiTZfiRvHCIM3+oLdii7yLlyMKn9GRa3gecehRWdtFq8UkLnwVNjc9XLTX/Oel+47SS5MYokWQD/xHMTAUf8XUq+E7OEG4iQn0nfs5FtAqfJuHyGmGAsFzQ+BJL1BnJi9Zlajg2FSHzpF9akxEbn4P8LXMVpaVILtIcyVU50VfZ0G97JOe+7xPFlpwTu94hUY/wyhfk0lfhbQr2w2gtof+7/u8B7DXcYtoa90sPR4xWG3c4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0gxmIpCm5JwnwnngWJUI9dH4h/SZfo8tJqH/3tANt8=;
 b=MPPIPzjYWAzNwHGr0HzCDwJX6UifHDDeQ/Dq5A9dQCkW0vI4o47afivQGcWuwJ8D+NzEG4pIgmhSi29dmY01vfdc52Tc60naLBar+8jUnqntrGyWbVOKkFLXsnV1X4JsMUzCu2Eqyti84pY8oia6IU/fmSC27ILQm4WFfxbf7bOohNcrXk3e5Gn3xyWUr7Rd4E1sk1ZhrMvWoPzMk0Y+DJZieP+fNEHl7HI4TR5Qxa7FantVFcp20nb/7OgXj9GO66PaDzDQzfqoty0Rds/VrgkLMxzOhQIWuoqTa7cvnRpgh4GcXaUSoddAtyx78tn3ZKQWfUNDtvcMlwS7XHwArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0gxmIpCm5JwnwnngWJUI9dH4h/SZfo8tJqH/3tANt8=;
 b=cIh1LmVD9vNsXj5PS3xXvtOhBKDREwg6y4pACjeNBT+TbKtsrb4gBR3pRZ6zOpakUGmAfbYKrd3YzOrycXAXL225I3OSP21Z2RqZCSgz/LZeDQot1xwKAMJFCliZ/kixIkRKwlHAWxqBCT++jJGnAWTDeL/OnUSTHDt9/aTmV+4=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 25 Nov
 2025 05:41:25 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::50) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 05:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 05:41:25 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:41:17 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:41:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 23:41:16 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AP5fFOQ3168325;
	Mon, 24 Nov 2025 23:41:16 -0600
Date: Tue, 25 Nov 2025 11:11:15 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, "Prasad
 Sodagudi" <psodagud@quicinc.com>, Deepti Jaggi <quic_djaggi@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] cpuidle: Respect the CPU system wakeup QoS limit
 for cpuidle
Message-ID: <20251125054115.7y26ize7h5kqhe5l@lcpd911>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
 <20251121100315.316300-6-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121100315.316300-6-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|PH8PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 37801e86-ed06-4d87-8f4a-08de2be54610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XJjFvBhk7zgMGEVviUcbIPC0SrFv3/ig1skhpwidp5zOQb6ms65DoERU5h7M?=
 =?us-ascii?Q?983QPGlI85UUcC58W3D+F3RKPY7sei2fkDOYoDIbEYSjspFdrkvDBx404oTT?=
 =?us-ascii?Q?HQQqMZL4DOHAyiMyQHqGn9TF5VMuvkiZdXe7vP1Tsgq1t+GU1KMKB17i4bld?=
 =?us-ascii?Q?k3U3sX7jRqv5cHTah0riQcYSxotMUJTje9/HIHgupZjn92/KzhCsMtdLalt8?=
 =?us-ascii?Q?ybFVo7pTgRbZiX1w7iFi+DBynujC80BtT4rQi+M7INC8E7kuJu+vy6mT095u?=
 =?us-ascii?Q?U3GzjroLMFqda50/zPwM4m3LgUh1PHQEn4JHwdWiQBk0z7ZaG96E+FRclXmD?=
 =?us-ascii?Q?g/ziVlQLwnPv8DN5UCH5RCSN16JZ13gfVRJyI1n6boLk7jWUFZbNgA2tr4WY?=
 =?us-ascii?Q?J+pF6HJhsjJXJykaszg//yiH1rlU3ylOwycNcnP7UQJlYnPeh1PcX5Q9ElL0?=
 =?us-ascii?Q?Li5UGu6frT8Jp9LB5uvBd/BQVE8AkzMy7nPh7oq9m1LfedYGqZ+m18L9bc+B?=
 =?us-ascii?Q?QFv6kUn1QcnD/sDq19nToSlC1hqz8dZZtFyozyXe+rznK70j0XJ2pGgXwtPa?=
 =?us-ascii?Q?8jSqlgGtF92hYrkTNtHlcdU8BPuhog53VebcR6xa7Sy4A4dFRuXBz8VJbSJA?=
 =?us-ascii?Q?HUz01GB2EQZUfUu8UiIiFeEcBwofDlwpVRr9+bwwhXXHSHFYTLfEa6aACd57?=
 =?us-ascii?Q?jBDQ3XdLGcx91I6II4YyM5T3QMwefERV/V6gD5eR+b7djExbOuA8Ag/ElM8z?=
 =?us-ascii?Q?VR0jN0q0yuu8vTw//K7zJmeMIMj7AEtkezvRFQ7cUhA6ZyY4YKj9QIWPYA/j?=
 =?us-ascii?Q?3DN/Y1ehYuEMyPHjjlZNaiQojt6+ghHqYmQURyEwqJoGzP/cokVdQnqudSBz?=
 =?us-ascii?Q?vLCEhPQ3Lv7SqslNoZG/CITl9ZCGBP7YN0zZ/VjgEUG7On30jOYEql+L4l3Q?=
 =?us-ascii?Q?h9O3hbPU9Y9lmaxF/mCH/GlLobSgYb62q6HR11lSFBoHi7ZPPUiGKFxSt54L?=
 =?us-ascii?Q?7Q+9kgxl19PA7B9ijJAgqEMWqecpa4n6ZMXT9/qfo2GGGryq7BdZvm8OEB0t?=
 =?us-ascii?Q?FyazaV8YRFSsx8tYm+mfd9FZXCoLVc3nhKbe4qFKrF5Lwc0xjxNalFiP+L9q?=
 =?us-ascii?Q?/XLsN0LxRpYTw4XWocwGRpcWGdhv9Web29D+tNFsrP641Mn6GnzVL5pl8UhQ?=
 =?us-ascii?Q?+rOXbdzZu19CkEOKRq8We9IkcTAZ92R+XXMCKDNKiZ1IZA6+jx2TS5HIdpUr?=
 =?us-ascii?Q?B7mjvAIB87r/2ih78Wp8qWepWTKWRNNWsoK0nNjl382XAh9OyT8+BXGf7553?=
 =?us-ascii?Q?GFRC/3Zh0H2jf2PlJQjzz2Deya10hLrNKXYUVngjYNZYOiPuc9sJ2AP3wztB?=
 =?us-ascii?Q?QciUQ0h4YLD0iEG7LHmjb1HwtayHH93j9iuCeMbSFT6o0i1TYfg84JkEp5sA?=
 =?us-ascii?Q?uXvGyUGS2EljYcB4pQC2oFB7cLzkmoTko/+vY7pCDjT+GympG5g2UvQF4vGF?=
 =?us-ascii?Q?8CdIVeVTcJRP9g08FAYZ5bSbrbrdBDswnokfO13s0luLjcUP5YdJjciEtZQN?=
 =?us-ascii?Q?FrU1tGXanx5XvBQmj4k=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:41:25.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37801e86-ed06-4d87-8f4a-08de2be54610
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525

On Nov 21, 2025 at 11:03:11 +0100, Ulf Hansson wrote:
> The CPU system wakeup QoS limit must be respected for the regular cpuidle
> state selection. Therefore, let's extend the common governor helper
> cpuidle_governor_latency_req(), to take the constraint into account.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Changes in v3:
> 	- New patch.
> 
> ---
>  drivers/cpuidle/governor.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index 0d0f9751ff8f..5d0e7f78c6c5 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -111,6 +111,10 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>  	struct device *device = get_cpu_device(cpu);
>  	int device_req = dev_pm_qos_raw_resume_latency(device);
>  	int global_req = cpu_latency_qos_limit();
> +	int global_wake_req = cpu_wakeup_latency_qos_limit();
> +
> +	if (global_req > global_wake_req)
> +		global_req = global_wake_req;
>  
>  	if (device_req > global_req)
>  		device_req = global_req;
> -- 
> 2.43.0
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


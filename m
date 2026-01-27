Return-Path: <linux-pm+bounces-41537-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJufF2bEeGmltAEAu9opvQ
	(envelope-from <linux-pm+bounces-41537-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:57:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9E953B9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B89533014C5F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327835A95F;
	Tue, 27 Jan 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uw0hmLTj"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02355354AF7;
	Tue, 27 Jan 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522223; cv=fail; b=HxmU5Mx8ZdYiMZgqN0a0beodF/pQGmdy6gS2UHnKKkLegqbmVizRcf/B9/3k+vBNXcGnMZk+xU5HAzdAv/ka3KleJb4p+HoOz1g0DF6tZgOy61QOGYDb/warl/HEacljAQ3/podTqhnYTboxYVbQ3IEjaeWMu3Zenw3WsKT24oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522223; c=relaxed/simple;
	bh=Qkzsao7ihIbpw/EgOY9mmsWF+gkG5Au2G9dX7tmGKIs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls6SdlfyN7wTJDeJVxlxdFOWkTGL9y9MuV866Xlc33lJyOL2AJyLfZO4IwhecL9AaYrcWk7yNobERph5/EF5n16PWaOoXNNPAPPx1pUbQGtVc5F8vVQFjb1/GhI/eZpdy2Y0IYhYnYlg+klDRfl2Bh1wnC22XR93eFtDROGgoZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Uw0hmLTj; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3okMVdK+gZTDFqTU0kzFGh5vsmPWlvWfg0jmCFHj+BUdFFBNQ8uxF57sBwXukJn41VoiKMir+LEkKap/8PNZalQ24sL7W0pDnSpTVStHGzdvQDxFrPF/oXrujqnBA9Cr/u1qOVl1F1S2dBDUKQqG0Rer81hCOQQrvy4olUI1/OSq5BGvfC/lHFe1KwvrBgsvdMbD81VgpSeHkhmFw3AFjxURDD2SiIyMmN539AeoQGBwVI64zqKcr8UwwWZNfkOtTbaG4R9Cav5axTpW1dnI6pbMG1PPV9ucntb3vc/ObvjgckvRyWPSMtu2W1YTLQoCLBivQs6+hy4bKOFQFSM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGi4zuBCR99YTFcaaij6GMhicjZy4PQwZg2IB9CApsU=;
 b=yrlgAbWwDUXwdttD8OFEFfz8kTuGm885H1oIbfsrEuu+f4sdd5e4UDJWyJCkYXXTmAnez5lt4T2yg8Ei2G6EFFaC2lb9lLhg+gLRDZK3So64LlVazbKXdzpeT1ApD+Vn67cEbltfGOSlt1tgxryHgAe1N9k3l7cQERErB+L9wxKCVsklVU6HEm4rTTvUKtF+0JVbhbu2T3r6kQYnurtNO0Zhm3h8lskt3DuAd2QVMffbKBRu7L5EOH37ujzEg6yKjiy2k2SzEicVWY3tShXRPPaZkVPQwSRdrqhYu5NQqrfzpV8/fojr3O4XBotq5J4+uZgvWfxazL+5ox6GGsLskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGi4zuBCR99YTFcaaij6GMhicjZy4PQwZg2IB9CApsU=;
 b=Uw0hmLTj2/1ecAtADctHIZ3x+3t9ogkL6wMQIk5j3sSm0RU8KeyQiKS+4s9VsFivC5gVsurWdOnBL5EX+52iB8LD+4Z+sZigbg9XS4cTnIQLARzjgNAhUwsZZEvk8bfdOojzRRmDvVvSOb5orybXKoW8JCfKndYvp67Qf/iWF9k=
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by CH0PR10MB4827.namprd10.prod.outlook.com (2603:10b6:610:df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 13:56:58 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::54) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 13:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 13:56:57 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 07:56:48 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 07:56:48 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 07:56:48 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60RDulSj256745;
	Tue, 27 Jan 2026 07:56:47 -0600
Date: Tue, 27 Jan 2026 19:26:46 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] pmdomain: core: Show latency/residency for domain
 idle states in debugfs
Message-ID: <20260127135646.7o6bq7ptfh3gak2x@lcpd911>
References: <20260119143121.161583-1-ulf.hansson@linaro.org>
 <20260119143121.161583-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260119143121.161583-3-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH0PR10MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3ad883-0f25-416f-437e-08de5dabefdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nu459BjAYLJLFMUbnSBrNmZSd730qZ6nlJwxaOB9/Dxp6flMKBxrgdaSsE8X?=
 =?us-ascii?Q?g1+PVS1D8dO+iHF8F+xtgyTfhk+Mis+AHBipV90wg/w9W97EVeOs5s3XJ0WS?=
 =?us-ascii?Q?xr+F5054aKixiKk1dKUyV7LIiPhnzg37wKhNbFAt8FwURcI87EBHmDonW9lG?=
 =?us-ascii?Q?mvQpgzgoJoGCBsVRghP2wEhG3JIu8e/KeNguh3u9jFIuJDuIMdf1SfbKlncS?=
 =?us-ascii?Q?usgkQ+gyKqZtcDELxbLSGj9QqJ3ue5cRWEhcnUpS2H556R8NvH17oxCLVzOB?=
 =?us-ascii?Q?SXbj6kqhYGUvucMqWYUiIKuRjUN9z3JRdaGjjcikfeuGqr8CLR5EIsM0R4so?=
 =?us-ascii?Q?/NVZhArdGSeGRyOk7Vw5SolIyM3DG6lqVMJzJdZRXtLpGZcGlwvNR11Pgpvu?=
 =?us-ascii?Q?na/H1Ppgzwm/hAvE48TnrWuQHsIQ0QKAycRZ6IzIirtNHjJgZw1VUYgI7ZLQ?=
 =?us-ascii?Q?i3EjiT1snI93ebVjWTS3aE1XloQdlqWy/fqheJCxZEvWMLBMwqpZoarfOIbs?=
 =?us-ascii?Q?M3L11Nu3OMQoAqLOYg5mXjGBTqOclsSKZEeYOShmM2u9vxP2IAP1yriUC0G5?=
 =?us-ascii?Q?adIgbXAbnQgWMPYv5uZ5jvctVTijkYjxkM3Xpv2yzDhp7WkjSow9UQWkzTg4?=
 =?us-ascii?Q?MVHGzvptxrl3V1YJqK4OnYh3pO2v+iAyPz1nq28PZnBbhLqEESyrFkHFRlmE?=
 =?us-ascii?Q?YGQV8Ad/HpbBKZnIgvwPY9zEZIwFENq+0AzwGRdW8yMYFuqExBgsN75fRBNl?=
 =?us-ascii?Q?p41C5W1FOq3oGdVeiaJVpD107MvOUGgISwT/33eh9G/L+xE/W+5vAH1iIa7K?=
 =?us-ascii?Q?ZYVOSeZk6drEd+ojVrt666VgfxlgnvFMBeZ5r9ndgfuyLcO/fgvRv8Dvz+UO?=
 =?us-ascii?Q?LTD6W4dUfsQn9IIsyEXQSS+tUDkcYNKfifrvMsAM1t6eU7EJdQkW7jSefq+6?=
 =?us-ascii?Q?FxHXTN/DZfJGpwb1rvR0NSBiYdawQE/0+XZxCEmNW+nAJok626pYf16gXRXC?=
 =?us-ascii?Q?WqP1D0Mcj1pwyScdx5GXl3krpVd8ascDcrWDkrmgsQbUswT2PuDOg4kwvjE9?=
 =?us-ascii?Q?Ehy8wkyIYQucn+owbNGQDjEAKNhSN9AF+99bOaPqA/nGSkcs1oGwY847v/3d?=
 =?us-ascii?Q?Y9mC07tZPHsvmm9bLv3bOk9naZjSYYgnjmunqrsYiA13vv9CrejSjIJe6ki7?=
 =?us-ascii?Q?HAESdGstksOl+qxq58NrUpIiQ3RFrxHI3wK3J2J6rcbnNrkxXVDh/QqGu0Zq?=
 =?us-ascii?Q?AMI+irSMQHATcew0GSpHGW6k4IbhWSDBtCf8AE2EJ/19eV1WBtIB3V5Ekq3G?=
 =?us-ascii?Q?dz9zz7qx6ErntZhm5E0cqdzeYY40ruWwv6ZaUx+1SLT7BCMSNVvmmWmnoElQ?=
 =?us-ascii?Q?vj6lUMyjxVZ1nk4yqGNsBF19RA+2FIVufV7AoO3qkJe/6hbZ/uVy27oY28Dv?=
 =?us-ascii?Q?+InZQnhy8oPJWLCQAazeHpLgL9XACGH1ihdpAd+OdqPXk5PNLT+YrzrEwVIM?=
 =?us-ascii?Q?6hTfarTIoAFGnuK3LXMCqdVIuZSBSIH17GSmftOLL6Qd7zWLYfX1jRdgImRX?=
 =?us-ascii?Q?wqHxO0zn+zMKQInBZQPUkgEscHgiWsT9yHL76W3YB+iTTa0qb+qvTCpsDKlk?=
 =?us-ascii?Q?XYC3k5GpAcnG3WRXXLDZ6pbaImF9GmzLVaKgrX0d8JJCmBaktDlodAhy5DFi?=
 =?us-ascii?Q?F6s9Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 13:56:57.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3ad883-0f25-416f-437e-08de5dabefdc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4827
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41537-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C1F9E953B9
X-Rspamd-Action: no action

On Jan 19, 2026 at 15:31:14 +0100, Ulf Hansson wrote:
> Similar to how cpuidle provides the values for latency and residency for
> CPU's idle states through sysfs, let's make the corresponding data for PM
> domain's idle states available for user space, via genpd's debugfs support.
> 
> Suggested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 919dff2081d6..bf512ff0857d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3809,15 +3809,24 @@ static int idle_states_desc_show(struct seq_file *s, void *data)
>  	if (ret)
>  		return -ERESTARTSYS;
>  
> -	seq_puts(s, "State  Name\n");
> +	seq_puts(s, "State  Latency(us)  Residency(us)  Name\n");
>  
>  	for (i = 0; i < genpd->state_count; i++) {
>  		struct genpd_power_state *state = &genpd->states[i];
> +		u64 latency, residency;
>  		char state_name[7];
>  
> +		latency = state->power_off_latency_ns +
> +			state->power_on_latency_ns;
> +		do_div(latency, NSEC_PER_USEC);
> +
> +		residency = state->residency_ns;
> +		do_div(residency, NSEC_PER_USEC);
> +
>  		snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
> -		seq_printf(s, "%-6s %s\n",
> -			   state_name, state->name ?: "N/A");
> +		seq_printf(s, "%-6s %-12llu %-14llu %s\n",
> +			   state_name, latency, residency,
> +			   state->name ?: "N/A");

Much needed indeed, thanks!!

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


Return-Path: <linux-pm+bounces-11519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD593ED24
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 08:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E07281EBA
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4182C60;
	Mon, 29 Jul 2024 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MPoxj+E0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FB82899;
	Mon, 29 Jul 2024 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233196; cv=fail; b=KsqywV360ifCQVBHkdbbuGD6MAw0WJ2Q6t+0rm8Kd9xrCPEfoC6jyzYUcMAvlGdTgNMipx4g95lQkwNZXJH/uu2nnDG1gNyK4bufMBNss6H/aEPQ8WS7YvEirPHz+yHNciXq7Ki4w5zIyCk8HBFAfML6/j04xkN2tRd4rchUulY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233196; c=relaxed/simple;
	bh=SbJZxQ4Y3cJERHUYEfo0QPsuHYZvgF59AKg3pCA1f5A=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rp7TGb97Mhmiij6TeZWDND+vGxMtP4yTUjUNOBSQoxw27O+9h/RFanxm3lx2EbVqE8OzHd1GzFp4odLsP4pAv7wWpNtiimBTQchsIN1XA2ugDOeHZuOvjw5zNWYbsT3bzOCSdOCLcDyDDZjJuerTe6cJlx8TfJEIN0IuTFj0AxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MPoxj+E0; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goCuIqCF6ZEhOfldzvtZx7Aja0znLIy3LlibMUFEyozdHvLiZdtpeHvYpIbCFBihbzw7nkTb5DfN6zzfp1/lZ8KMBNRl8YnrKAN1CYZ2uFw8ioZ+K0S/D4dFA+9DSp8NtxJMlCRhx4B+EmkcCDInihng2SNu28IlTUjSEUfvz3wCpzsJFdpqGoSmjrNAeyWdLHEkm7omVecH5l0ST4ZOfR8D5+ofQnbRO8G2P/TIcTtI/KdoTyuZ2AvbKLn5YMQpgE4Jc3yVbmzlpGDUQw6lDzrdSJlEnXYtjDae4E0hBvY+40JvvEQHgc8WrgX3mm3jfT3zzJ4uycdVmEByU3Xutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN5mCyWrnAyAq29W7/DG9gGxVvym80ArkZsjDTrzS9M=;
 b=SX1y+nYxAd1voWEUFNrtcZW+/gm/J4SqCa0se+V3qBA1tEOChDaKu99kyeAiJuKVTEBoZle3lf1LLCD3HjkbSyf9gWlEZJqvONXbpCk5aiH6sQOymxzGuAnWlAsEl980CoaJ+X56NgqUHFddOV2e0b2GyBgvKgdMFU0zsbdDp41OL8SSC7pSAhH8kJjpPjAfCykZBmbswI4lqERfIRoQVhOXUdji5v9Y4T7WvCjfpFABAJphvAsAUmFzXNjqqKVXDilRNZ11HjjMsG7hi/KJ592e8fhgofsJlWfem8g4JD5MgTBFjnvW8eWr/t+/pSHUrLeBkY8ZKLu8LcbkqW1Dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN5mCyWrnAyAq29W7/DG9gGxVvym80ArkZsjDTrzS9M=;
 b=MPoxj+E0ljRdSiQ6F+riVFhcOcOw9508XrLQJrchSx0eL4ww9M3AtE+G33xbxS7LFVhAmt+eomu4SwvXhi5E3p0mNXXInYxAk5tsHr1/XjI7P1cutGEERVpwritx5klesd5IYwaSC7EICMvzuKp7nStvbJ0rMlowaTMH2CFHY0o=
Received: from SA9PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:21::24)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:06:32 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::1f) by SA9PR13CA0019.outlook.office365.com
 (2603:10b6:806:21::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.14 via Frontend
 Transport; Mon, 29 Jul 2024 06:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 29 Jul 2024 06:06:32 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 01:06:29 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH] powercap/intel_rapl: Add support for AMD family 1Ah
In-Reply-To: <20240719101234.50827-1-Dhananjay.Ugwekar@amd.com>
References: <20240719101234.50827-1-Dhananjay.Ugwekar@amd.com>
Date: Mon, 29 Jul 2024 11:36:15 +0530
Message-ID: <877cd4vijs.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7ba0e0-ddb7-4297-e670-08dcaf94980f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WT2IVRFvp8+lndARIXIiaaW7df3/xnMqgx9xnS/tjtQrlExiIy9UAjYv3tt6?=
 =?us-ascii?Q?q9oVddbc4HA/1U30HE7ngCEAD1S8F4vy/8whZaLDs238cJqG2Zkw84sGIskN?=
 =?us-ascii?Q?3kW3gha53musf0olLhDisSqLIblPB7HT3c+NYqhP6TuLo6wPZv3gky0VGADg?=
 =?us-ascii?Q?waezYCMO0Cq6XcOsuV+ihKTaDjh4TqJ+BF8tk9v/HASLLNdruBX03Cz/W0QN?=
 =?us-ascii?Q?FuPy2Vy+JqOGOF8wXl/zWpfS5i5lwHVk1gzii6/RCO8Qwc89tTqmVDckmm48?=
 =?us-ascii?Q?Bu2qkARvyePz4HERZpB0ziwlR3xFce9EQN1Jzt8rmkTstTF6w0hwEMP9m/Po?=
 =?us-ascii?Q?E9dyhkaCUVIz7npe9ubi3Q9LtDDW+pspbbRApN7iAJ4TvClIYkGcApbP6BVW?=
 =?us-ascii?Q?AiyrojusY2BS3VJBTKj/rZVdMXqy4ueLRtcg2I+NVDnT4ifn5AF7evmiKyyJ?=
 =?us-ascii?Q?okI621zl6kymQKeAU1zmYM9J9dCUDez4EogD7wX84Zztum1fmbWiGjlB3jqC?=
 =?us-ascii?Q?Msk5B3wZPb8wBTsoSXfxZCMOAxtrljYON6OjEJDfk2dB49ZnwXEwetH0quv6?=
 =?us-ascii?Q?xZJYm5kCVbZWHAVPJSoDgUl5XxhuiFEwIS+22Wta6v8pXbxXaCOoAie86WZT?=
 =?us-ascii?Q?3YR39Qk/jBqH9jdy5Lr08MLDy9Y5mA9tG8zajQ8AKjaFEvRQh2xTMG6mX9+i?=
 =?us-ascii?Q?sd2VVvELSDqFGWjqYHbNkRL5iELxCWsIehJWgcmx+lFlmBiUO1mv3ikePkO2?=
 =?us-ascii?Q?PSqyhsbBHNnCpIeV5PLbdE4SXiQSefSm3uv05ddKW0+MWHYA1v665keAwcH8?=
 =?us-ascii?Q?13kNDZVQVPGmwHCIDZzIpgJ1xOK25D+3tqWUl6Zd1IreptzNL/6vieQJD448?=
 =?us-ascii?Q?sJdVBeEgA05Qm/2FamFIBDSdKSPGqiJ/baKh9pOyD9XxteyyK6GzWADQle7z?=
 =?us-ascii?Q?Ucec6m2s56W2JKkrxPIxt405a81EO0evvdfdlKlVmxnuCp/LZIVKnSWzj4Nl?=
 =?us-ascii?Q?B1Ie8fMlb3xkbldeALPz5Wegh9L1kauqFmR5Ynhsnu7rIiKJhCvU+fsfIfk/?=
 =?us-ascii?Q?hndk6lE1NcTnlgRXQ3UG/QibBeIPurci1GPGtx0Lnqu/36/9xSiEgpKM7l+L?=
 =?us-ascii?Q?qYrGojpYXkdT/OiKimRL8d9WTaU8tawkVWjhNqOVJ9xIOT9IWhRtVQxJH3Mk?=
 =?us-ascii?Q?+sIjgxSEYQXVzFNojXZdnshjdxjd3/ta+3L/7DreuD3RWnOw66HQ7OG++yTA?=
 =?us-ascii?Q?IpsunTYBwekFQysTdrc0lmuainUtv5k3zXHZujUcbDU+T0X0m0yQTChaKuYd?=
 =?us-ascii?Q?iJdNNhEcs0QWhoKjEjP63+ACaPTYXpxgrnqFXQBDqen1hXhEw81EyYe2sJlS?=
 =?us-ascii?Q?ygo/z3Fl5BluVhMpuFH1n+T4Ng4cdzjMWp+k1Ry5jsDHuEcdq+2kF8L6ZJXa?=
 =?us-ascii?Q?4tHq7l8mxhRQtmCZmcIrWtmj1W3jMtdF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 06:06:32.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7ba0e0-ddb7-4297-e670-08dcaf94980f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> writes:

> AMD Family 1Ah's RAPL MSRs are identical to Family 19h's,
> extend Family 19h's support to Family 1Ah.
>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 2f24ca764408..1622f1d6aed0 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1285,6 +1285,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>  
>  	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
>  	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
> +	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
>  	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
>  	{}
>  };
> -- 
> 2.34.1


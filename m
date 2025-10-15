Return-Path: <linux-pm+bounces-36174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD4BDD970
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37AA544688
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2630505A;
	Wed, 15 Oct 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XMhE3SZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6842F5B;
	Wed, 15 Oct 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518941; cv=fail; b=faz7Xi3vRPvwg/MA22NZ0VsuNR+g0e17UIT9gOeltBY9Lrbzus1FPNEbJ7UD3SH2eMezodzFjaXES8nphx9OUrcS75BJCjP4gRGjlC/+5cIAxy38CajniaxjNMNj1tLNo/HXXAwp1JF7aVTKWqICrbcx01f+DWdyTVtPjd/uowc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518941; c=relaxed/simple;
	bh=rK/PnvhN27tx5v9dcl0sg1GDjtW8yGVk3v+/zcW2L0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SFdVFZQBdQ9DTRycB8IKie5zh+Jdabdvm4hgHP4ox2Ay+bVL5NY0GVuvdB0FbsxvprqBPr4pnF9JakvSrNjwKGpvHF1rybun9nYIXag87WNgW8qDOxFAOJ5sP7zIxjkEJ/5JUINKSEDbhr2+v2QZVrvFZfOVFXY3y86H3KrnE8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XMhE3SZf; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN/l2mSwh7ypqHwnP6xnBxFsuWnmJSn/wHxAdhk8C/iS44x/x1kQOM14UF++TvmHs2+QFrO8AxjhzV0lTAjIVhbbfVcjf/ZfYcAI9HH2VuEXS7RQtxCwJdzgvapLh3ivhaOnhu1s/wBE85cpMGYesRKxD8rdJTO7/uZFmuvUomfQrENPa8tkKMhzCT1ZYlm1d7Itru/5rMQwQAbNgg2FAjY4x+ZneQl95K1LwcreQvfgcAX8P870crGhhspX7RlG2Za8FKI4SmAGFoWIOblhM6GPYFpqPaAObBU0OL4E5aAbJdmo310adsOtI1F2ib9OTKIwNVHAEPZiMdDbszyAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbTY1S7NL/q24K0Dw2VLqMDT7eiHJfqiFlmOPDcv9zs=;
 b=n7WvFBDPCxsg7hY5Z3PzgSDtr1JzmGnHKtleoKYHxwoUeCrr18VMtVBwWgIoBOBffOTPzbZDngpp9zsKjtplqZ5GleqG6dJX7QDPGYTS3blbgTzYkqakqtkXlN3AMfViJG6dn4g4jtrtzCams27DAS8wguPir/+x32gaVg9yrNProMO5u7yTLhID1Tm1VN2g4JYyUDTJBdrXe49+e4ZwqEC6tIu4Ohl3I6Xl2+orWH5wr+J5Wix4v3UdghG4NR/QfwASZZjnFYWbfMDobxgNfFIGAKf6eJweZMzgIaWOJG4TQa+7o7MelJ9AyuDaBkwkWA0ZaRm5nYVpivBGyyM2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbTY1S7NL/q24K0Dw2VLqMDT7eiHJfqiFlmOPDcv9zs=;
 b=XMhE3SZfma+sOwDi6IZYgEUzWqkhPZkXjaILgEjS+vybpMlOP5RQ59pSp7yz9vycHjnWEzDwGqXKaJfDsdQKkzzR2c5ebCy1XGzq5d9B8yEPrvCzGaDBNaeFiwrqeFH291oXvaXMXRIqRazjveIjpSWA042NkpAgglxd0t8ZOqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Wed, 15 Oct 2025 09:02:14 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:02:14 +0000
Date: Wed, 15 Oct 2025 14:32:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] cpufreq/amd-pstate: Adjust return values in
 amd_pstate_update_status()
Message-ID: <aO9jDMvkxsSzl3xf@BLRRASHENOY1.amd.com>
References: <20251009161756.2728199-1-superm1@kernel.org>
 <20251009161756.2728199-5-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161756.2728199-5-superm1@kernel.org>
X-ClientProxiedBy: MA5PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be2de56-61a3-4fdd-9428-08de0bc98861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fzOJ+7VjbffSA3HrMM4qBsMsqMKhUmwB2oIP2j0dEojufbMI9hLWjN/V6W7y?=
 =?us-ascii?Q?xZ8zLrrKvIe97M+/sTkwXuGsKvsFGiq+KIre6zyul0sB57HDDXBDk48d7ZYU?=
 =?us-ascii?Q?qzy3yIEIv3ZPXH+mEPkEtRj5St9pu/bXc62vuBHTor+iTsEfRAc6I4OQUH1r?=
 =?us-ascii?Q?VrIIuX7u0exlioLRUNQI/hZVyEn+IXW09nTgXiDUStklwzquy4cHHXd1MPtF?=
 =?us-ascii?Q?+k5Z4kvBm2gtA7JKKTknsa1Acb/E71DV0cXtf6GuhzHYVbNQfS8Axcd6mF9f?=
 =?us-ascii?Q?SpGus1txJOGCFR+0YeAW0F9KZujeMuqXZCsjn32PEI5tPc4hYrmYHBWRQGBo?=
 =?us-ascii?Q?9reMmV5004OvPmyK9oZ9uFGnOp1Iuf8EQpntYA0kgUC2YYQJt7Ivsrfca/14?=
 =?us-ascii?Q?ntHETqIRmHOHPblbS4Jh/ZxoIMxAyvMWusVHyysrXWfmXFkKwh/gqRZ2hC2j?=
 =?us-ascii?Q?8dvE3llYUDQDW03QGzt0VExAWuFBf/bH5Ox/P+0o382lXNZqqvcexk/QMPTX?=
 =?us-ascii?Q?EM8kjnMmjbO7iOtiao6y5239Suc0is85P+tHMHrjdnrG16lThvtZ9pfKjsGJ?=
 =?us-ascii?Q?CFkSVrCMEll7vRSdRCGijRb3Vzd+wR+Q//4wj7wb8mELO+soihDQwB8HWaBM?=
 =?us-ascii?Q?jgRw6P5YJMJQ2iqeqeqdUX1cfvopAR000EIuZDamZIrv/LWaG1MAwHkXoalS?=
 =?us-ascii?Q?6+Rs/6PXjPXM0GuGA2BSqapk/j7WhjrJb7CIf4hT1VICYXY2MTsgtwzqI56C?=
 =?us-ascii?Q?P4vXWXQTBPG5am3dt5oE+2I+3bV3HLuscpR+QcjBYrQslxBUOsOngx0hcmBz?=
 =?us-ascii?Q?dwjrIL85oev7beRb/F/S2u7z9lxXrFj1T2qx27tonLeLXPF9WCXZDYgMzMyx?=
 =?us-ascii?Q?fDGuzE3UJAUtSb6kkYJEs499j5KypWdT2s9AQwi1+eo9iJ3kL2wtUTWZY7pr?=
 =?us-ascii?Q?UlOMMbEqGdkqCmIZdZNdoVfK8zO8ajm6HUTe5M+aRSLwyuv4e0llrMXcvWZ3?=
 =?us-ascii?Q?vjfkiJbHQ8XDqXPaIvOX0ArtWroOv1QgqdArAvamI3WpmAfwCoBkcVs58Cg3?=
 =?us-ascii?Q?yQ3cI3saf5fwANffBCEiUj1dpBexaVNjBJnDwW6tnlSVNDvrj/46CQ1xvWuY?=
 =?us-ascii?Q?wk5RjLxjiMykN0mn6QcRjB3PVQlXO+vYyVZCKbCGEqCeEnBL+e8rsoLGCP8p?=
 =?us-ascii?Q?ow2RpJqoG3TuimIxR9110mhRVGwOajSlo7acwbdFMibEcb4kRCD7VrXjY4sS?=
 =?us-ascii?Q?rwWenAfj+YKkjSB/2Kc5Qlhg7AM4d/97gTTm0EauWXLlNbbfFVP+k02OeiAu?=
 =?us-ascii?Q?x2sTpNE4q/LREYae+xKLsqX0aK6606XtPulcluyxLztRlTvD4jnGvlJHuROs?=
 =?us-ascii?Q?sTxOthGbpeESeAb8yms+Yiqvvu2jtv2Us+XQB+o1pv7iMCLh2sG6lXRqvaYA?=
 =?us-ascii?Q?hGFEJ3gi6i08hjDi1fhB7Vbu688ItF/n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjiH7U6+a/AUGQ8BuGd+wAu1F2l3yuLADGsHYfDxHJ8CcBl8FGeBQA5Zqcr1?=
 =?us-ascii?Q?8rKyBrzMfYSdIhSdgTNX1WrqUWrbezgF4EvpgPKQ7fK34ZZyxyCQQYm86LAZ?=
 =?us-ascii?Q?G646yIcOj5GcTbh8Hhf9Slw3xUYSndgr1OKlBLQkw1M21h99idXfZI7Va+J0?=
 =?us-ascii?Q?+YGQpm6JfWLnOosr5bVrFat/Zto/q/nzoIcMmZ+AtheSubv+z2acx4qsIXDm?=
 =?us-ascii?Q?XoIsQnDRKTxjRTUjMxXrRbhMZsOTY9Lnqmt74uA+euozRFaU2tckd/wR7/qi?=
 =?us-ascii?Q?0Za4hOIrRIE4rolX+A8Th1qIj2r5HECQEuw/5VYBojsAII7B/E59M1WfGtI4?=
 =?us-ascii?Q?Gj85WGMy9Kx6AX5ICKCcxc1mf0W/X5NE2AQxzyK3+Zjjt+AqX5ewPetIs84R?=
 =?us-ascii?Q?pK94E4Ph2mUwW/p9y82swvh+gUpXw0dKorM1DD3xVYwIPjBIFICxm4m712es?=
 =?us-ascii?Q?hm5TItCyPuqsZh892oDtseWDwxHIRiKNMGMZ4kg23kk49G2jB8quua86NLqf?=
 =?us-ascii?Q?OUsC/cHvrfm8rVpl1lwAisfro7ITMqyDDdi712ko02a4sYl1RcdMc2jW1YeE?=
 =?us-ascii?Q?0/p1YISuUt7Pqae0zLNfKEXH/fhs7ijKEQIjHP83T9FZoo8QWJzPmhfmtbp5?=
 =?us-ascii?Q?ieI62WGd6PcWJxEf2Kt39ExgAkGIz2xYoXvzW5hS604zNVVbh7GNBKXHTwUD?=
 =?us-ascii?Q?3NjxbNtLiz9YFo2uHMFvNqZ5uoPnD7KW3o/2tjCQSnGyLbOllVbwURmS/xpV?=
 =?us-ascii?Q?f/dBxvjj73HPstZKaHvdtJcVBeKehCaTjhTbg7ibM+/fSSkoPVNsM4gh4Hgw?=
 =?us-ascii?Q?uvrl/BM5Yv930Nrn6CUuFtqCAHItIw2WWeAjGpoIbovxfLouka34U5sx24b3?=
 =?us-ascii?Q?/nimwNpzfsxXSbASmkdPVHcol+pkNbnT+nx8VCwKIEjVgYl/rkPngtMoiobc?=
 =?us-ascii?Q?Shb0bsw2iQqFC1uyM1AcwLFC2I2u4OfZ/7yH285hgcq95l+lSfEjhZ3uG45q?=
 =?us-ascii?Q?GDhreUImS269DdKQYVpsT567t1RULBT2UN2f3hit53xweOFwOocTLcFr5kHy?=
 =?us-ascii?Q?8oQvgxtEA8dUbZz0g6rl3/kaJyG/vCbjzrOe5P5I/nBDglgEZ/AtWfBH+Xie?=
 =?us-ascii?Q?ObTxyh8RALX5glpzMKzsBGuwkKzA6r0xYB/twD5bzSiAO65MMmr6jwk9M8PD?=
 =?us-ascii?Q?3+0T6FilXjbxpdPx1pOQz+zrB4zyih/gALo4f/ArV1Ygr+fJAb1N4TrmT6a6?=
 =?us-ascii?Q?IWYmFVCM8xLHVFz1fiwcTkPHk+YVlWXHsZIZ8ARNrxcg9V729yheVGPhtUqV?=
 =?us-ascii?Q?/zcT3v7xWVvU/BXsLjEJNscoe69U1j+BHRJZm85+wdd5D3HhTw88HdBP7xwu?=
 =?us-ascii?Q?JmmKe3LCPKDlTAjf1p9PQl2OyIBfV9Pp4vak+VrSqEwiA+mAL4+tFEMEgi/M?=
 =?us-ascii?Q?MtoHF6QC99HvvTc8zu8gOvxTYvokFq3r9+kOzNuaSrDjGj8+3fa6jrbR069U?=
 =?us-ascii?Q?/Epxudycevx5z8unoGNHlXyQhbKTaJ6ZehRLd47M0Qco2Br4JmqtUuwCJbXm?=
 =?us-ascii?Q?BUYe+EfyUfnpCQzAJi2abN1fwAOo/AXrS8viBbvd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be2de56-61a3-4fdd-9428-08de0bc98861
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:02:14.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDF2cmk+OAvu0A1w1y9UpFIAod8Q9ZY+DjoR1LJj+sJsIKNXH9nPBMTN4snby8DZaMzKfmPcn4rUNWUDwGP+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446

Hello Mario,

On Thu, Oct 09, 2025 at 11:17:54AM -0500, Mario Limonciello (AMD) wrote:
> get_mode_idx_from_str() already checks the upper boundary for a string
> sent.  Drop the extra check in amd_pstate_update_status() and pass
> the return code if there is a failure.

Looks good to me. This patch doesn't introduce any behavioural change
since in the absence of a match, get_mode_idx_from_str() returns
-EINVAL, which is what was being returned by
amd_pstate_update_status() previously when @buf contains an invalid
string.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5feb9f5e3a491..2d2ef53d12447 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1346,9 +1346,8 @@ int amd_pstate_update_status(const char *buf, size_t size)
>  		return -EINVAL;
>  
>  	mode_idx = get_mode_idx_from_str(buf, size);
> -
> -	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
> -		return -EINVAL;
> +	if (mode_idx < 0)
> +		return mode_idx;
>  
>  	if (mode_state_machine[cppc_state][mode_idx]) {
>  		guard(mutex)(&amd_pstate_driver_lock);
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.


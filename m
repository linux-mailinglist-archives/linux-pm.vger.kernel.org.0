Return-Path: <linux-pm+bounces-18708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4269E75A9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FB282497
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC23211499;
	Fri,  6 Dec 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZHvSZgc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4420DD62;
	Fri,  6 Dec 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501692; cv=fail; b=pNFh1OTIzaB5w86teSXTrHt5Ke5mfT0f1LCleGS/trUlmrnwpwfEaXVDgB3L2SJorYC2iVBa0jcLzcHYqR8tbBMrHH+BytOd7EzhhiiqRvqOhYELt3HUCfiI3/Qtkyv3JH6p8VZtVMi6+tSEnzbU7RGh0n7i4ZABkCdoW5SxdZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501692; c=relaxed/simple;
	bh=nWN69oeN1Cx4ZkiLI1G6DY9KEx80VUZA+z6MI8H8rxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TlZo3DGDdbQinsyCh9QpsDmWbEAcjqlNmsQUy+Z8y4PlTmi/0z7eJzYaTe/JOPQayeYw1XvBonDCl6o7alIzdWWJR4XgrBsYZwhN/ZcLfAN7kRbi1ucsGYGXKkJvTkGKsMYMU8pIFy0bC3hz1ycu3P2bMI+qjkeeKyK4DwKcuBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZHvSZgc; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkca6h2+uCxqwytj/akR6hXw2vlOJVc3JA6IXABUlD296dIy6FLz6800DAnFvjoZ5D3oDfrAsZ7/0vhunnGTokolWDx4aEJiZLtWyco/6KbPYulOSzjUITcaMduKHY+eGbFDfAEDwVD3h+BhY+ccYXnlmAND77tFch9/w9gmZYOyCr0ojnVq5KUekSaMKWicmMrwUo/3twd+iIRi+QDm9Vyx8UaA1ybKfZbcB7+5dFDNVmC0RUnjk/7/k7VG0cUZMe7e1hZ/TK8b1vL7cmDHzEdRrfXxj6QEjx9cjF32UrhY2UbhtIlb2X/cnHgg2W1zTDgZo2jpN7s1gb+6NzJDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54ZPkgqIhnCVs4+u31Q4z0OU4yI6Muidt7LAnlQPKFM=;
 b=CDRS8xcHtztBDl3WUjYv2UQ1es9cnrxQuXyW9lAozNjlesRnyBzDIvdWXoX0+H9N9Bwy83sFGf5cp00JqM2aRYRgTI0FfvxBLiEHMMN8RCnEyv7UDODyeHE4Nkho0eJzboEIHX3PFFfAlcYL3SyOxT65DcM7KyRK7F4UbeEM1Ye6LZk7t5ZAYQcc8Y4Hmu3U5pZnWKzSsXRtUp+C+V8jxVQA1cfILzW6LyWMp8/swK9i2vOLfIbjNE13Plv/B6PF3K/FpHu2/93LHOr4zqWg8imZXKKbqbRF4jvpjpAq5DbFxm+cdsxSO+EBEoCJqEJn4Gw0wpwaMtDoEAug6QJScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54ZPkgqIhnCVs4+u31Q4z0OU4yI6Muidt7LAnlQPKFM=;
 b=0ZHvSZgcPV/SsLN2oZGZaf7uJdja86zrwijp3n4LGJgxzojxLP8B7abw5wCA0mRvf/3l16VxtjzXQ+89+OBt7s4OEZw+mpcx+5ubq/FFvdcyW2izSefeBZhq0cWFlFzbYeuh1g7xm8Gpd/dklLQ6q9oXTgtnzsrH5d6WU/RDVNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:14:46 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 16:14:46 +0000
Date: Fri, 6 Dec 2024 21:44:38 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 11/15] cpufreq/amd-pstate: Cache EPP value and use that
 everywhere
Message-ID: <Z1Mi7hclcaSaRRjO@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-12-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b83d4ed-58fa-4db3-fda3-08dd161119bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMhFxeLeCGUWxfoIymQdZzWvY/cirJvY1W1FFFtx7zitphFpkSueKFWwvX/c?=
 =?us-ascii?Q?6CirqLPiUET/FrW+HMu4tpcKQjMpHqng9+XaB5B5KX24UNJtbpQ5exs73E7Z?=
 =?us-ascii?Q?kkaJ62+7xko52pwkBoiekuc5hgBBBusDTUILc7ZrKlgEvBgP9pu6e9chfe8W?=
 =?us-ascii?Q?VVoOL7ctfNDScwgb2QDr4QwsG0ToKF2ZQ5Wh+63Nftu8g+pBAXUWr83JQxp5?=
 =?us-ascii?Q?TjSy9z5H4b9n8UW6TnYChiSK8jc9IZalDTpJPdcFNIj3h2At+zFzTugQlwAg?=
 =?us-ascii?Q?wkYQgrk8gjAMav1sARDDGjloghFBRWait3UidKIXufDmS037MOYF9YPFYSbY?=
 =?us-ascii?Q?LOaH0vQuRn7ShhI5ezSyE3QSatMjYXOtY+D79QmaxXzSJF6cJXZzmnv3+Bi0?=
 =?us-ascii?Q?UYp6ULkNMqfxIairFMNBQ3TDTSbrkKoryt5cTurtJ84xs34W0th8PBNWHfWl?=
 =?us-ascii?Q?p9uROqDVrUINEh9THAXSozrxkn5KkPniwCsDwJvUoXWcTihaefwTqndD6L70?=
 =?us-ascii?Q?98s/CBIddA20k8mqQapp9OYEMZYsG5HUhth3jo6dk/Epjmr7fv1pPY+2vgIf?=
 =?us-ascii?Q?G9IwpeRG1nSMNiKvCtUMNGvqiNTpQ2dHQSVFqqVyWBnLULvvA4uo6h3JqNWI?=
 =?us-ascii?Q?mFkSBlvUt39Hex+WMGMIq1fGE+w/wR57Qkgm148osDS/BihpNmWh/VEnRFop?=
 =?us-ascii?Q?bF2khQsTiwbTC1By6/NW04iLZ/Bp2nCq3QCbPaZ0SdUYFFG3/A6fUtjN5rQB?=
 =?us-ascii?Q?SNamqfCs6OYoiCS7lmE/ZeSkqwy42Fha59GNpRVGScEScLza3+L1VazjZ8jl?=
 =?us-ascii?Q?yEjzguD08Q4E1bra9bSZbVqqIkpOJ34YbwpYuMPqhot0JbTjQjK/gdSSg9QQ?=
 =?us-ascii?Q?v5uoNQts1FQODYwblvB0PXA33u26mLfJcCvQLNwAsiEiwRaYFjzTpOvrqTBP?=
 =?us-ascii?Q?v/GnqHH6ZVxvqS+Rq+HPTNQriSUFPIb6MNp79wAGZPj8wuZZW0vL7YuwEm13?=
 =?us-ascii?Q?ag19rycHScbMQTJJBxzmxovhEqaSD3ymASGEmyAgn7XLg3Bo1vF4BkLQiQJ8?=
 =?us-ascii?Q?yaM5Ne6FdF42g7fLjVFnt4/zPiUFXvGJyXVBQlXeSolpHZmtkUHnUyb0cCcz?=
 =?us-ascii?Q?PoFacH0huxcZ1Du+KhDAMYndkwpAiBihezdr+9L9Gipi0Gu50NgehCtYUhrH?=
 =?us-ascii?Q?LWEuQUsP0lH7pdhLP4G3N40Ysx2ARDJqf4anS5yWKFExAfZQ6a1Dk9m6S0BJ?=
 =?us-ascii?Q?bQwt99ajrovqDR0jzQSvgrCP27Xsy7e5WQmFqPj3ACkHen2EHWOeEZa6qEeb?=
 =?us-ascii?Q?d3yaflFzNp38UAnZlV1Ud5aw0G7ptN7TMENp68oqRC4JUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RG07ox6yTyU/goaUXzThCofHpGdTNZPNPvkRQ5kC4SMxOgn5w0qFkqbsnhQo?=
 =?us-ascii?Q?7UIrC/AccSjGX1PyaJmHO73hhC/l/8o3oRqpXAYq0M0YjKRH4keJGd50dHLL?=
 =?us-ascii?Q?Iksq7LUoqeHrDayGHhBMCSS9nN5ibQCgx+YM8pLbVPgeWB07K1/bfnz39hyY?=
 =?us-ascii?Q?o6zPIvOYA/buPL29405VvTCbNcVvohZV8liRv+0R1mN1ZgGHhUfwvvWONmSW?=
 =?us-ascii?Q?lLy20u+My0wxEvZWvV9AK6u5t8b6chykJ8yzGVN1rDTx3mqC+l2J/veno5Sp?=
 =?us-ascii?Q?pUY/n798yKnA8CuwfwlPybG5yr6lga//3tJ/XqdzB3aqNu/MBrMnIW/NYFNm?=
 =?us-ascii?Q?7TGWizJzrIPP4vrHqfQA5FlLdao1D+uwNnHDOXmNt+wdb8v2l3x5LbkDmDUq?=
 =?us-ascii?Q?D/M4OQFx2AyDUOHygEA7QdaST5ae6Tnxd5pgT2lXkw6CTJQdKK+hslEi6oiK?=
 =?us-ascii?Q?vQlmio3haZmlQYDUunc06mMvBSl4u/Iq3QefzIThDn1i82ToTZHRifA8AroI?=
 =?us-ascii?Q?sR8neWMOCLEy52y9eMaqbvIfNa7Vf99o/ti0JCzRkuK4zdxXjDLhtYksg1yF?=
 =?us-ascii?Q?br2VsuuYm6gb8BWIX2KW815sW/AoVGEtKCaQ1cIHowvozqlAnaquroeKc5n/?=
 =?us-ascii?Q?36gUnWbrY/k4nK6DcCrRiOeSHuYwCikFpNqWg35H28VdAljimHlUfu+QzBXy?=
 =?us-ascii?Q?xEtoAo78tYv44xuVZbfv7oYYoVdV6uJTyvS7lHG9vgASqD5lfHwkIUEIyfjl?=
 =?us-ascii?Q?uKdNRVMADt+VvAo8WHgcXigLzt2cu2PXr2G8BwzrYvch9YcXiPFmR7YC3dvS?=
 =?us-ascii?Q?K4XbSy6pcQcF/3IHsnos69Vfv26jQhhPkE2gNfqkQOZAkHW9VmF89MsRGrmt?=
 =?us-ascii?Q?Y5lv2o5fiqU3qg2zXqeWX5bdrQ3FYkpIdxw74bhbctG8cZAMvif+mUb4IAzI?=
 =?us-ascii?Q?+dB4ptrQ5ObRo/nubAeu/QNJ/IVddv9A8rK2y2eLve4GDC4iUjzUIhrwekrG?=
 =?us-ascii?Q?kQ780UOR3rEp38uzX2DnVXwa0BfhzONOCcbzBTykjhCT1eFKlIlvU/pcYzEO?=
 =?us-ascii?Q?HMjmQuBLmmy8va9gj5chfde2OE9Wc3K5nM1qjpedvi3ESQ7/lMCeLo9cGzZF?=
 =?us-ascii?Q?3Zk3fRfzb4ae4RWfEoCY2kH+fP+ZH0TfpQkLuZqjVBAbUYecvUi7R/FY43Tw?=
 =?us-ascii?Q?MMe8WwifSBRFRE9VnF0KT+fD5qjqJVdMYJQNmeUpvt/RUfiuP5JdK9MKmOVA?=
 =?us-ascii?Q?H147/BwPHFEmuvRKoHGMAf73BMuDOdlSow7vpKRxx8icl8I4nT6Jb2L3w+ZT?=
 =?us-ascii?Q?r6mGV1XOtmptykb7liNfCuVmVixxjdZgGD3BUCvJ3x+a+SwFZ+lLGqIpLnsu?=
 =?us-ascii?Q?9FZSHR/lp+50X+BBE4W6tm84D60yCrJHWxrqiW5FVgb+c7gPG47fgRYrZaW9?=
 =?us-ascii?Q?rPT+rzw4rMeqJN9Ue/BDVjMQY/+Jks3u3uhIwfcc4wksEyNhjpw0RcEKMQ9P?=
 =?us-ascii?Q?IZPtsQLsb2tg09q9tjwesYxRj+hXi/TbRxjxMBt3CAWtq2YxR/vmmQHxm4wa?=
 =?us-ascii?Q?7yicj6tIsRG/VPFTXqb0PyXBnaFYZ+u/s+Wj0ux7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b83d4ed-58fa-4db3-fda3-08dd161119bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:14:46.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/XrfohNr/66TxAqF/hd6hMOm96A1MUa1dE/Fq6OYgIhndLOavAFgrYbOwJSpbAoTo6P/vkQ0TKy7GlAV63apA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

Hello Mario,

On Thu, Dec 05, 2024 at 04:28:43PM -0600, Mario Limonciello wrote:
> Cache the value in cpudata->epp_cached, and use that for all callers.
> As all callers use cached value merge amd_pstate_get_energy_pref_index()
> into show_energy_performance_preference().
> 
> Check if the EPP value is changed before writing it to MSR or
> shared memory region.

The patch looks ok to me. Just one comment below:

[..snip..]

> @@ -1610,6 +1591,8 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  
>  	cpudata->policy = policy->policy;
>  
> +	guard(mutex)(&amd_pstate_limits_lock);
> +

Shouldn't this hunk be a different patch. The changelog doesn't say
anything about making amd_pstate_epp_update_limit() call while holding
the amd_pstate_limits_lock.


>  	ret = amd_pstate_epp_update_limit(policy);
>  	if (ret)
>  		return ret;
> -- 
> 2.43.0
>

For the rest of the patch

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.


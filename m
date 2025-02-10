Return-Path: <linux-pm+bounces-21675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EE2A2EAC5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D7A161A35
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891811C701D;
	Mon, 10 Feb 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nv/18rMK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091116D9C2;
	Mon, 10 Feb 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185940; cv=fail; b=fpOD+gvbPoJlxHms7b1aYhefys1SpNOC7YG0ZWAbPdCRC8jc0+nXVwvBKzGKyYjX3AvhIxNdtDLi6SEbPXLVZQ9lo2MrOOB+ddv9O1pTyhENFcQKQ9+MBZEyNjBsP6wfdBfknBiJhCzNiGhJJPNZa1ZG3H2y6EZSEiJyIv2BrXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185940; c=relaxed/simple;
	bh=w21gVhvg/nRzuRUnJTG6SQ29qTngHIslseCLDUIqsKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W9vIFx6k0qGoS4AWAlevxQA/xgTKywly0eSxHIn4rqqMLShCWPAOpF9xlNzmxTJYEu0O6+0KV8Aaj7O2qzgbRIeiP4Pd7KaRuZZisY/s0IKQ2sjWvtxCVdMKKlW6b31sJJfabsASqIIYrX4X5VoIgMcQu4lvaJHGmA9nikh0rSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nv/18rMK; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X32vjAIJwclxiULPpyHnCoL9xjM3XuVZhPX4ENwvyYIKliyJhKlEonfhVQeiU3cRgKxa6mTyY2CzAruR7bop26scxwbBCCn2RXfUYEier54irW4+4KCbEO/vDn7nNsh9FanutvA29Vkh5RzTPqtsaoOqokY8L7zH6lND2Jx/3fCrU6rmAUQ6DtQN/fYGFF+rHINsx7fDST18Cu92mGsIJrUfc+zzGNEUTjIWconC+6uJpketmZhTT/TQAuBNteiU302LXTVaXFO138jsk96zoeI7HG8diCFIzwFBFCR8AeGBI/jgONNxlGxWFuJ8bBOaYn9Olhc1j6Bet/EQRgfFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsZtPeEVavHdtoh+KqnkwX4MlhRqIywnxq6cZ6h+zeM=;
 b=urxK6NOe5YYg3Wst3U2l33EiHdVvaVDPS1jN+UTabWvKSy6hmObZuBu5F9fcN8FVkGxVt8bTEBfBTEcVTjUaxz0jawApndNzHbeNOc8Wq8lY0fgkPqizgwfWxt2GrGTiGse9JUKbvLFYMIVy7eLrS8r0PgcHvtCT9Rot8oneyZFwLiytV/nuz7Nk6uOH5FAG2FD+iF1y0MFvQgXz0F3RnlrqR3FzM1KISdyxnOb+V8fK0g7BEcu9VJR0qFMTHEhP7ifacA1rzVMBt3aNsHZhO09Yi+cLbyObdTNsYKbTYH/KH/mN1MtDXPxOydAAyMszFn9xvRUuTm9WHSdHdksPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsZtPeEVavHdtoh+KqnkwX4MlhRqIywnxq6cZ6h+zeM=;
 b=nv/18rMKvDiRqfD4GsKRviLbf0z7rgFkowZdza/JjyFPZ/vM3q2/htBHtZYrfiycaJgqK570ohuU74pVV1b7LkHPFlGvoMhWUnRCrvjAwyn59dFJ7MFgxXWe/hH0+7tqtq+OYYbO+YTVQCbSkyEFLOL0xosG9SxWgxy7UO/og60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 11:12:16 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:12:15 +0000
Date: Mon, 10 Feb 2025 16:42:07 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 12/12] cpufreq/amd-pstate: Remove the unncecessary
 driver_lock in amd_pstate_update_limits
Message-ID: <Z6nfB9tbb6uwv2xY@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-13-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-13-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bc090d-5e0e-4c81-0fc8-08dd49c3c62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5SCcH7ZRIzDK6lG8RdOxwXkbmJmZOVClziQuHthoGThBKxjeEpgoXSl+g5l?=
 =?us-ascii?Q?A/MLKxB+Lo4SiwpxyNSSpKZgf04/N+75RZwtN9f7E04GOcgzH29D+Rkdc8OW?=
 =?us-ascii?Q?JoLi6vVMcC5LqMUF3d217Pb16lYpc/FwGg7nTSzSriLsr/xs5LpXgGrjI+6u?=
 =?us-ascii?Q?xq5NmK9POJAH99uE/OfJpy3ivFJ27OLV8F6OhNB2+tjlq3ihpNBYidHNJP6k?=
 =?us-ascii?Q?8RpwACCBIDKbW5NA1hq6kDDiOZFIKDyflhv96GX2yWoPjJAnURT+ViEXMl9g?=
 =?us-ascii?Q?lA2SlAdYkgT4a/jO+PvUCAkrm4wtYg7W+DLc8zee3+mRCulB3O8URMnwNRxh?=
 =?us-ascii?Q?R7IWSXqcY3NkQcMjqHFprWhmuWidx7l/j47DNjHW7q16GwjojFuLdfRNsqsh?=
 =?us-ascii?Q?FCl6WY4r74mKaDTXiRq3BimIKB6WYQDjyoapTu43kfRkb5l/HprCVZVnfSct?=
 =?us-ascii?Q?eZzHZWYkiZHgkNqCynqZAUeFwvEY4IGtfo+MDgpQfDTEazRTvfw2d147Au33?=
 =?us-ascii?Q?EdfkvKFuFSyeo+gDlCpQpKCYsu4qvBUyWkw5cOUCjqh59CAroYtnLAEHRx2o?=
 =?us-ascii?Q?wxtutpFG35fMcT10j5uXSMjOR9a1X+cRBSk+EdBrF4/wAYSOXQKIy82ltFlJ?=
 =?us-ascii?Q?E2oT1khwioQ21ggRlYyVQ4CIDtu28rBoesRB61S7fZPOZvlUxkXGw4PWPw3k?=
 =?us-ascii?Q?TWQty8/23JEf4F2fH7zWsU/EWe7tM1UUx3YFDHKJr1v8NEfO9+vXVfkQHP1D?=
 =?us-ascii?Q?v6a9fakSKDOngQFBMOD9M0SLVa6Sndk1y0GKll7P+LL2zFRXepWyuVAJAgsp?=
 =?us-ascii?Q?FOvTPL1sZM7GI+iqA55/HmJS8N6e+jbA5faoN916MD5efGq+dI7qFYYNHGae?=
 =?us-ascii?Q?1yxEkSokaYYQ5DQur2VqehFQX2lc/QbSGUe9/f2czZSL1CxrMGzdCKVWxe85?=
 =?us-ascii?Q?WPX+/ONI2YzPmzIvsUiHGxQHd4ilhxpEBCAbCTgOy6bkrpkzmfqLDdKSKHiq?=
 =?us-ascii?Q?cUkt7iOhqBHuYtHs9rvk1EFiPmyXxQ6GqpYgqQR/HjBX8QeOHWJXESjeGh5f?=
 =?us-ascii?Q?nQMW9OLLzO3lChUc83kRtSmQ1JfdOmNknttiBuRVKglhDrKvQAItBHXLErny?=
 =?us-ascii?Q?TxMQ4KuRY+z1ucyHic76odXGtSeOC5j05QysF6fmwqtlj2B42VGO/mlPs3X7?=
 =?us-ascii?Q?qKFhBpSxB9cguftAqlkZbTX5LwXFYWzTkbIpV4vB/l0l6F8btCxsm+VZONKE?=
 =?us-ascii?Q?PpiF8dG+fkyEYV/tbFZGslg7ebhBYH6jUVmXG+8pDsaPdlYEWDOFX0yeJuoO?=
 =?us-ascii?Q?KQLVQajsY/3yDFhGTHSo1tH+6WGTtyyUq5hofZa6NKUBsQet8YEiWMBSrAC6?=
 =?us-ascii?Q?/skCMBLPeWkUnggPkQfOhugncyxw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QtZgTu4MttvEOZUUsE7E07gefAYTP8mwV2rlmMpcTkWF2gLfS3sMnZ8np9kP?=
 =?us-ascii?Q?v7/AKjfpEeH51/U9psd+5Keu09fOi2TykD8iVB3OE/4zLpwcXDr8PT7m+3u1?=
 =?us-ascii?Q?t8eFIoswZvuGMdcxiImXPnyZYh3J3ly2/QbCZbxfmr7OvUGmFYt7WKDOYJbZ?=
 =?us-ascii?Q?nX/OgLmi7czNh5JXKtQ6bWE8wTgVLVWEWzeqlFR1fnnJe+2q6HnjX/OravLW?=
 =?us-ascii?Q?zM7SXFxFmnVVXq3u3XLFJdAtTgacd0yYY1R0FbuDzmSviv8USl/3RcGvApSG?=
 =?us-ascii?Q?r7Q9FcYON7PoKP1bpaggq4dQKx6A4JqQ9zEW06o0A4XAADdGxRBPHkhZnXsE?=
 =?us-ascii?Q?t0t8FEq81jXRQIBd9nvbzM3tvZena68IOnp0evi3ld4XcRMptLmDQRFX7y8D?=
 =?us-ascii?Q?CDM3C6iJkpZ/zAkq/5jpRhh89EpWA3qw4Hw1JZafZobEVY5X65KYkZJenAuh?=
 =?us-ascii?Q?Y6Nk2aAEbwf9T9nF+F2lLwo/OtaQTWrpF8Njq2lkce8tgTReak+K2FcM6App?=
 =?us-ascii?Q?pRKZEEdGB8p+WhE6LpHBteAX9/WDGNhjkdZpL7rRxbcU3ng2WrFzZXw29rsa?=
 =?us-ascii?Q?RSTGDUSpShYm7PjA7PXOfgVSMPBz//mWfpIInEFXBiK73XmsE8X23/1G0nmD?=
 =?us-ascii?Q?9dSB4GsVENngTTRGNwCf+8tsjp8yj9udrbnL6SL4bTiQ7amiat9390thUYCK?=
 =?us-ascii?Q?6Y5t+wDZJWxD29c2u37iQisnvjhba3ZqELDkpi3KMKi3FVlgAMwHk4T4Si+D?=
 =?us-ascii?Q?88NS2skud8GNStPi42dAnJcvMk5EpUSfSTHNu87lT0d+6raePn+vWj4m3ycg?=
 =?us-ascii?Q?wSflBsSHaeS2GNdhxduLonGrKqlAVKin8udMuRm4o1lsj3bzq+mt+iXeAmOj?=
 =?us-ascii?Q?jEA2xmlYCb8miuQjTpbHxhJmzg5jpMSoZBIbnWRj4fkwT2ecRrsPVhDiA2gH?=
 =?us-ascii?Q?/9z/Y152MQemVMWZqU0l3UsBIfPF8L3bRqxDE685JBZ3m3YHND1p8+1C0UZF?=
 =?us-ascii?Q?3EGLoQuWmoeG7xaPr79tmqvY9r65my5xr9eG+RGv0/ewNFh9yDPInEAzU+3z?=
 =?us-ascii?Q?zLqlAYNZgx96sc22wrgSUygT8pOUZcKwhlHKUkTdqOaSlQSB3OCS9+pk9JyP?=
 =?us-ascii?Q?PBJ2j1DARKqf27TZs1IGprcIFZt2aef0vynI6M4YsTg9p8UcbwDKbZQrX4NZ?=
 =?us-ascii?Q?oejKNg/2AFQqx6i/F18SK+gXmSmCM4+wpnI5bRAtH1FT3YY6iEZqDccKg959?=
 =?us-ascii?Q?zlG0cho2dRsP5Ew9xSs00swLxVrbQhqvuz+oKyW8tS+9w9qwxB5vTzY4AP+x?=
 =?us-ascii?Q?iqBMNYgKnT+tEwc18Txjim+b9ct+NgFfRrfdHB3inPMF+kv+Z2f+29iWkWic?=
 =?us-ascii?Q?jjnWC/rcFCRauQk4UktkewSJEfL402GeeBh1ln9e7WGzQlrndh4Y7bnv17xa?=
 =?us-ascii?Q?w5G7OI3WobQYvhlJ6tMvXEOziBjSp3kZhRW+bF/cPUTumQw36bJWXtm59Apt?=
 =?us-ascii?Q?Sp30Ax7KQbiPr57l7hMKaSXm3kr8GtX52JjlUGzeaaqlKdT+O5MTd62kA68c?=
 =?us-ascii?Q?KBOFJUY4+1ROXfrlQIXr2E9wpz53Y9AEA9pBKaed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bc090d-5e0e-4c81-0fc8-08dd49c3c62a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:12:14.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeOmyXS9ZQl/NWR7fltTgOvX8ho+yXtpAHmC8ty0n2SH+ifMTPzBpqVqMmkDN0idTSPwa8kSB907HWTsaj7Y3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

On Wed, Feb 05, 2025 at 11:25:23AM +0000, Dhananjay Ugwekar wrote:
> There is no need to take a driver wide lock while updating the
> highest_perf value in the percpu cpudata struct. Hence remove it.

Yup!

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ee7e3f0a4c0a..08ae48076812 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -832,8 +832,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	if (!policy)
>  		return;
>  
> -	guard(mutex)(&amd_pstate_driver_lock);
> -
>  	if (amd_get_highest_perf(cpu, &cur_high))
>  		return;
>  
> -- 
> 2.34.1
> 


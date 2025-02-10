Return-Path: <linux-pm+bounces-21661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F831A2E81B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A18B1889B51
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A31BEF85;
	Mon, 10 Feb 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G/+Xg4JB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334132B2DA;
	Mon, 10 Feb 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180780; cv=fail; b=BJNelLnKHAh9d7zCvVxXKgX4MrcjsbeAWsvYNeeKNxa4PJiLwds0/NoQA95mJuImQO73SJSGFUGSH7TeJBH+gkjftVOLBJI5kYJYHBiteMtvWAhRkK7vG5HovAX6zxLGoo3HDU9pC0qO5bxt/Yp8UtUPYSZh1Bv+CoSLWzpTs24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180780; c=relaxed/simple;
	bh=+0t0ENLDNETsFicvszXycbnw5WQeN8Nf4J/cU0XAbTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ixDWwQYUBdXcBUqGnx9I54e26LOe7zZvzhYzyaCVOGkWXrrowP678jFvkgu+GAX3a9iiWhfJ03tLQ7iYfyBAqHUScxb275JHciyDykI2NWTryQ1KYiNPw8NFjCP/QmyAfekwD6ZBaLqggV4mKRYOCj8TX7KdNK73OLz2zslJkOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G/+Xg4JB; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsKp/nY9GRPzF/OMpkV7E9LaM54iMoHPW6FvkbTH+RcAkv9lQc1Dd60slRd71VCIbkfNUrGK/goHuu1yN12B+qfV8+ze5nK0aH7DIe6B76dNYoY3Uk0fw8oVrRhtxumBiwrJuoNL4BPrOOceNlg2jqRYxeSNMzu6qqB8gowjtmcJgU//Pee/bNQ0H4sM3TihGz80wQb4tCu889AhOEW1xPcF2wdu0/rkKBte36N+cqovGMpcbpS92ZDYfiYzVz3/zzYDHDJRiqlDxrCz/1ahVS0X8oGnNVV1fBlJ+RC8pgDPWI6vRJ42P5mUhty46z3FdcgAZe5mdPSz1vt7c2ozng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qMQyjogxUTvore1yL5up4FoFjLtfeQyH1UEdV+3Vr8=;
 b=VKlWFllmj7MrGL7aFh9NQQ+kQRJLrdjixuamq1MHfY4rPYy76GYVotjXITLfAXdV4zHZOPhKCKMSVHYWHGyzS76ILay2cQ7sYO7N/8xD7S3jk04w6djU3xEaTPE+PjmoTTZjYHuWaopF8Agfz8fmkf6xBpX+qvbFF/ZbV3DNrHxDu29rFEIJ445Ed+GSwBLvzueTRfICNHB7R1U3nFv5N9Z/Rce/ZLt3MqmDPbm5ncW16AiM2nHcSLa8gDNBITW1BrOa/MByLnYgBBHdZ0KO2jRBN1BsRR3NiUjVd4DZwf/0oPPt7Lh/Ojm3hQWkxX/ujopil8DWMANHqcskUMU2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qMQyjogxUTvore1yL5up4FoFjLtfeQyH1UEdV+3Vr8=;
 b=G/+Xg4JBV57PLtffg5v6Pna+c+bsIGzNx1JFU9s9tVGphind3K784E1rSQBUVweeNuu64CBbmWrxh4H3XiCnli1o4NanUv8HwAxubG2WeXhgELimUm5qpFQdgZJE1UFMOXEFxCIjmtZY1SiSh3pYrRUtfvBtotNTAU/PjSjj3OU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:46:17 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:46:17 +0000
Date: Mon, 10 Feb 2025 15:16:08 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/12] cpufreq/amd-pstate: Remove the redundant des_perf
 clamping in adjust_perf
Message-ID: <Z6nK4FvvIwM9VePQ@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-5-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-5-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb772a1-4835-4893-b2ae-08dd49b7c3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cO0Gzei0BEMznXKkZTwqIP3in8apJAx8zIxyb1HnO8CVPBVrzw+7DK0ce22x?=
 =?us-ascii?Q?QwTbhwOvIwsaYZH9DRAwwbG4LSSDtQzx+a0pvrJURmGZrdsKBYqo0RjjAjiw?=
 =?us-ascii?Q?eQctb0QrnVI1nmeDus8NZlRzcOFhLulZf80Y2RsnhhLTYdQd3pjpOKPzAGKr?=
 =?us-ascii?Q?uSZ5rpN/O+m3EHpXqdYsyLn7Pi6rjSWtF8DE44r5P5yC8i9b4RjinCI/yBR2?=
 =?us-ascii?Q?grgV6iaTVbA37ESb/dYJHAeeR2FEVDT3xb8Ch/E2H5ozreTx4W1EMFF/hKFb?=
 =?us-ascii?Q?xVLBGDV3LZMyuytWYuwjyM8fDEcybTEosJ80pcLbYXqEWnu0ru4SVaHxzj3i?=
 =?us-ascii?Q?MMovlEgyOtp10heWi+z4gJGJXWn5NQcv4skEKXsEbHAYQUFMfm63Xpsyaomf?=
 =?us-ascii?Q?yXkLooDwEdGjkDEEGkU10bGQUS2fsmxN3cix8KyNoEH7Q4WqPXIdUHQYmHFL?=
 =?us-ascii?Q?ZCxjFbRICd3s6h9VYm2KApjLs79wQCycjRQdlxRrlUek0O+S1PPfTyJaEBLJ?=
 =?us-ascii?Q?FExHnmXRtTomO9O4wgzkFuvyvFjQ5W8txRI2hHgdzjk788QXC76WmQ9Ach73?=
 =?us-ascii?Q?E3Y1asrB6EvUvIA7HN3/zaNMBid+b3PWzgi6OGNs/4pT9tdfTCKZ4mMBO+2X?=
 =?us-ascii?Q?/OdpDWqSb4N3vQgLfUoY51gc+GuCupAMlraf+VNngx4TqQr7hLS9XKQQKWQ0?=
 =?us-ascii?Q?zBrAjdqROZsiMqGqfTu98NoCAFCLlm/s20zIaXdjrR1HSodmV8YBWBz3pBgO?=
 =?us-ascii?Q?OBQm2DHZXi4gxA7zIPXccuX8dc9k21CAMIJF9CAtRXaMl39WLruVazdMEjPt?=
 =?us-ascii?Q?Xbwke11Y5vjskiwiJfYTxNbY5TskCYbl85yStv8tcZUPYJeRx/xvrkTQgzpB?=
 =?us-ascii?Q?HvQrDYFrQlaMvGNoIaWR8NQFHR5gh+MlqXqnskuZJERCr2NefDL3s5ETwC01?=
 =?us-ascii?Q?/kiME7uIZni17TOyvTVRc3Mg2fpuP71+Xv9LeSSVHo1yfr4E6u4UrlS06syD?=
 =?us-ascii?Q?aYF36DJoaNkzRg7MdYUKQez8pTD7U/9NlXcEMTtH9daWZ0Hk2df8XC83r0Xd?=
 =?us-ascii?Q?TmOLdoumtD1EfG9sdTZqYwdcqO1tAbwCO2chBxYEtfOQ2JFDOiVb9PE+sLFR?=
 =?us-ascii?Q?+KqYtoQeTjs3mNVxqGjjUyEgtWgj4/oZS4Lnn2LR/KOy6uQW1Y07GISmM4rd?=
 =?us-ascii?Q?O8UzNchOjb2D1budUwWSEDUmc+72q3s9bbmnmIngWnpXprpjy5uA+ZZj27BE?=
 =?us-ascii?Q?aXFwQSRJK3ruYNb4HJlanCuOBomp59DHqKpQg0BsPOQKwjFdutGn6ngTiStF?=
 =?us-ascii?Q?x+t269DVsU3Bthc5POepEFGXTKpSDsFnfisR6qhDIDY/uvBpJ/fbVgp/OwCw?=
 =?us-ascii?Q?htnri5kfOYX4YtTKrPS8j9yaFEci?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wcyo6I0YelnS5rTSyFx8pmu/Pls6s1iE1KSNjgMDEm9EwosYg7wio+0DsZzq?=
 =?us-ascii?Q?glFuB7xteUDOosWisJpf48L6yfYCKfcy/tZgTX5KwkJig2kX4YF3U9H+Djne?=
 =?us-ascii?Q?KvCuYkLSR56S8HEZD2hBnbHopmWNR5elTuq5jsbIyfmwSRyQrnRD+TPQ1rra?=
 =?us-ascii?Q?/OWcUd/ojgeMI9lBkKg86kS5XOaYHMuemAK3cKx4v2fG4YCZ+wo3rQPbW7Sl?=
 =?us-ascii?Q?GlwCkTFKJ63Hli67SLKKCff0cJ7SXhOu95AgVxtH5cuXR+QFE9TKwuWNxRP2?=
 =?us-ascii?Q?6BcOYopUhqq4NlLWhB5AbA0ps2/yMgeeozdEcgIwqRYw4ymSB3aO+yPWUWn9?=
 =?us-ascii?Q?mx9jl8sOAWiwh381N87Eo1V9Im+qjCjX4iG2lNaEI1ISSHGop1vCqEjmo3/N?=
 =?us-ascii?Q?kWbMVC0E6upzk7CGln5u2YbVnBr8uAU8cfZj/IFAjR3HArRS/GshBuDFKdID?=
 =?us-ascii?Q?SyKjgeikwYbnXiASWC9LDTQeU3z/2hBA7OqsqnVVGBpdQlw2gEKQzTKJXcU6?=
 =?us-ascii?Q?Civj7SZClK3JHKsofFnIQlUpzgHPSrueC52Y9GrukTjNzRK9pLk2KuNoVskA?=
 =?us-ascii?Q?SlaXCIhAQYROBLLu9csOpgXTy0Fu/G87UfRxY5JwWja1t7JxnfK8kcZvvRrb?=
 =?us-ascii?Q?ZkYp9uQJ6ImCpGd+e7OxXJHeqyCKf8Cq3H3GjSzfdinR0IjcPXuXJh4dQ3sn?=
 =?us-ascii?Q?Rj5ghKvr9qrQiagEwKtncL5PbFP84yH8OqWxhiuTNASgYslzWKCG/JmOLxQC?=
 =?us-ascii?Q?SH0OuIM/CbN+VxNE4ZTTL6+K+szkqc04LeaAMDUVzIxmGfUTFI3mYIDGNf+X?=
 =?us-ascii?Q?YKpFDPZKtOPhT2dMacQ1m99dO7/oYronF9ZPe35XzUqSkoax7vgrpo58wJOa?=
 =?us-ascii?Q?qJs+qewCjJd1xAfda7pdoS2ytHkORCRsAQKR3ZlK/bPkJ36FAmdYfBFpJn6s?=
 =?us-ascii?Q?zWLULUM6HJvBepWqxzexJC70ZclzHQDAeMQjxPOnf5lsRmvxLtZDhf/Wqgyg?=
 =?us-ascii?Q?hngcOherJD1WSlrGgxHsEPDWujsTDev2AfK8nhCbogsUYtxkGRYY4L0x5GWH?=
 =?us-ascii?Q?IhXVuaw9aU4qZJEtddp3DvUiIa5i/crieBBuMncvqQYMZbDE8B+9sx1XGBKj?=
 =?us-ascii?Q?RE/5c47ZZs4+QCNRRDwEOZkBaqVAivQkCSW81r9xPNC8qUgy1XQbStoJnhyI?=
 =?us-ascii?Q?qS3rmryG6Y9FdRo0ezJovl7m7XeoWV2UP3ZhXMg6XVereisGyBjL34gTfgFS?=
 =?us-ascii?Q?k2fTZ3mywbS+9yPyECCCtePxIs45/999IqPx8J101RY3cH/qlcpn98iorxg2?=
 =?us-ascii?Q?Z1LzflfGN8bv3ncsUlMpUGo2JF8oyJ135CZtRjj1f24fztoeihOU9rq/EJC0?=
 =?us-ascii?Q?VmxE+7kq1hfxfmOF+cIH8mT04OECqH+PPZvJfRuudyWXjITBn18yybkuHilH?=
 =?us-ascii?Q?33kBOW6juaSUq43ACyu8TtvkvyoDXrQ8jULeRs1FPpztYE/95fCkc1TRifbm?=
 =?us-ascii?Q?98EZ93NN9jdgt5EpMj8kOCbkJ9YmMeOL1rD/qtX/w59izUytMyBDKn5DXUPN?=
 =?us-ascii?Q?j2dC1f7VIjjnefBNBjfmWGvjJfWzTwgWNuneVPel?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb772a1-4835-4893-b2ae-08dd49b7c3bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:46:17.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pog2p40+XrRzNd+DCPQPI+5qgn/LnPvkeFM12iihh4TxPPSCbUyO1DsXAWX7MqbZ/F96lmIySgb/De6MNvyk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

On Wed, Feb 05, 2025 at 11:25:15AM +0000, Dhananjay Ugwekar wrote:
> des_perf is later on clamped between min_perf and max_perf in
> amd_pstate_update. So, remove the redundant clamping from
> amd_pstate_adjust_perf.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Nice catch.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> ---
>  drivers/cpufreq/amd-pstate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a23fb78a442b..2926f292be7b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -703,8 +703,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> -	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> -
>  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
>  			policy->governor->flags);
>  	cpufreq_cpu_put(policy);
> -- 
> 2.34.1
> 


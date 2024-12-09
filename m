Return-Path: <linux-pm+bounces-18798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A599E8EAA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A822820BE
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417C3215F61;
	Mon,  9 Dec 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="edmF7nXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E81215F44;
	Mon,  9 Dec 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736348; cv=fail; b=AFJBei1fFUIe629uHBs7NWVE1WTHUFPzj8gcVO1FloWTG0b9iXymti20ztxPLPq8Bul/DpW29t1hqhV5X9SHd7ajMZIpPp3kht+6WrRc53jww7xb5qZ04Ju//I2cgePMfoa4k9V/TtWDy9jOwNTIAmFcxMqTTGGHrSBf1If6oxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736348; c=relaxed/simple;
	bh=VzUQwtIAjRMkSTo9XatJAw+M35cb3Ii8dW7+dmGmOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P/4uv/czz3qe1JiJDiBDRbJMz99Ijw96zT38Dc1IXGIxDfQ5PfuRODeWuvu5gRtUDP74L9Egg6NA7izBZSX+ElEiBIPWJ9oHh4O/xmElMLzEv2OqYYji5CA9m6Omw3I65V9AjTaf9rfPlr8ScPWOfpqFX1fXDshFET36/Mv2IFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=edmF7nXJ; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxUNaL0/pbrT0mW8/2DReUlWQzpHbbDdLZ8ZXutCGOmxa9PPTSRWmQbSVB+fssLQe6P02Ub1K+TdKiQYDLLe3kPY6KKkM38TYbUcmlebdkNbAL10FaRWo49hjkXnbjfT8Dq8v6299H2tCuCPi1/D1+icEkMWQ44ij+uCkGUcdzkK0VuxqAF8It7hy9tg/bnrAbmodLS0iUMndoy8j3UYdU2uDgo1V71wAPmZMv/j4ykAHogHjAEnc1opX+PON5286R830TRnCAjTROP5K4vY4CBohGzkMatxma+awPZ4WkCzpPp/mj4qmqDU4pQsBfFe848OInjNboBJA22iQm/1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4Rb01I5gWqj8m6ww3BcoRjL5SnurLpAdOYwnBIIu5I=;
 b=KmEAzeJhFGwr7xmTpT/AgxPhlExi5sItNiqBOq3NVWeBL6/xwx8Gx1hNGJYNre+aCwMWKuP1wRX1xRqKxUnYggel+u5gSRIlBkRwPe/TzropmkY5rMc98Mjy7iSkXVFaK4L43NUH/+TbK8ytUiRKQ5uh0P7LZg7gSMrxgyho+/Lwaf71WuHM/i76uQcvanUYgWo3MOGWYmOQIBTeGZnyjgL0NGITOB/6msMxxexWtgRU1oKcbUxNd4SdSQtZ09+LwMCYe1tYfSwUzcg81Sr177vHFBeknGpaiYKXi5/y/kbwusaHkdC3+tPRdySgdI2mDIM4svgXCHd3GXNlo2CuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Rb01I5gWqj8m6ww3BcoRjL5SnurLpAdOYwnBIIu5I=;
 b=edmF7nXJQXcI8rMNK3Na7oFYmiIRfVX3FP6fWP4LwXvgec68YFqsD8x2PzcbZ17JA9pYKiusVU5w8qjV67B5sfGE/kIZRxMsg2poPYg0KLWcX6tZGnfpG+qIL/eBdet4fRaQmNohakSCf7/dFsWvv1YAFfmkT1EUxpsIvZZSuBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 9 Dec 2024 09:25:42 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 09:25:41 +0000
Date: Mon, 9 Dec 2024 14:55:31 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v2 14/16] cpufreq/amd-pstate: Drop ret variable from
 amd_pstate_set_energy_pref_index()
Message-ID: <Z1a3iwdpVP1QnCGY@BLRRASHENOY1.amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-15-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208063031.3113-15-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::34) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e61a31-16b2-4e9a-81bf-08dd1833736c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRVf7lsFAxar3Lux7AA8hkoWduDZVzrsRlQ5tKO8iVFj54BhSoy7EMM5sBeT?=
 =?us-ascii?Q?aO2I01zIIWOyJv54atyjac71DWjsS0bjbGfJjHpZ1HUlQZVpF5y5NSeId4eY?=
 =?us-ascii?Q?UkDez5NTk4L4TYdB5qnpkSwjg6wRgiNFDO0awn+9TLQTAss+yCzJ9W6/p/65?=
 =?us-ascii?Q?QygOS1B721QdmIw1Wb9nD9KAjdHY9LrymwYv9LuK7C/gKmW6J+f2G385rQ6X?=
 =?us-ascii?Q?wO+bw09Oe3YkMr9zWCSW9rnY4lbvANWkTzi8T18XLrHSGmXXIRH4Bqxo1qKO?=
 =?us-ascii?Q?7lBUo+mzCEGrAXtra+Z8um/nyVbs6IcR1Q6d5M6zW2PcdBt1pMMB8QU59CzD?=
 =?us-ascii?Q?pqkojWP2fACr5yqAZXXz9I+97p9rMsQ59h5OD55rYUxCQHvz+inBftUf47D+?=
 =?us-ascii?Q?FprJVvf/DzORFDikL6L/5DLbuVmH9kuV3Vg1c0yEX+UwA1QU+v7J1GLoOpZ4?=
 =?us-ascii?Q?DW6wiDEWBc9EVFQyKlYYgm8948+9ifGoa9k6oR8HMwmAIq6iwOXTv3LcGLDZ?=
 =?us-ascii?Q?JLsZLs1QkQZF1LIiHqMQOP1EwvqDFJ60n4xfu1kZ7BR4y3b7jMwsDmeawje9?=
 =?us-ascii?Q?6fpsoNuBh5ctQt7QR9WuNrx7tlOUv5O1dKI5YkaQF+xSb9QtmeQiiHSS5q0C?=
 =?us-ascii?Q?naGu+pgN2xF6UYAX7wVTARxquyCgYqd5O55TtUtnAS3tc5Mt2OwV0u4uErzY?=
 =?us-ascii?Q?XQegRVWVv2YQvEr4Il8LC0G53D1qvs8fuYcLcC3O7fU+9nu3X0Ac7ellrdfW?=
 =?us-ascii?Q?UXieZoijm7UExfT5KuR1HbRLcxTeq7XgsJbewubV7X3wAziumuzgImxvm8z+?=
 =?us-ascii?Q?6jounSbFzJnOK6H/ZQt3/Sw60epRf6oF+qF2XSn1NBLVIOWTtb9JJ7xtu57z?=
 =?us-ascii?Q?OD2TSQBft8SiCzx0iQUfWU/gcLDwEhNmOFjOraYCqnbnWItsrKWmlOWr5sNv?=
 =?us-ascii?Q?6gETSyBtJ3h0+XTQg+MiezxS1XetshJU9hDBr5w7LBfj7aIT0JJpNe1VM7JS?=
 =?us-ascii?Q?bSsKQJjBVyjD3wZS85+6PsAa37U28cnCRQEVNq4wyee+eUNUqBd4dUuNxLkF?=
 =?us-ascii?Q?x5SuBt8En8YFGNtRacIWlApeA8qXZKbURLKNC+nvpAMe7iI9mOntDMSRaX2g?=
 =?us-ascii?Q?ZPAxDaSTMX/DTH9ZWnq2UnByVo4foURSCBi2JkNjkqBn2FtcjO3kSPcGtp8M?=
 =?us-ascii?Q?BIcm9/6NftPQOR6UA4Q2qLFSk8nnWzAHLtBHPc48dTs+sgyczm5ABZQ5sTfg?=
 =?us-ascii?Q?8OMp+0ExSkwFGTZq8ZqRkRittDF+jl81LCmY+vCKX7aI92IsFsGwP4bhOnUC?=
 =?us-ascii?Q?AaggMfLEaXyxVhGLdrh67oJ7pcwoBFJRTdQu5Tc0c6EBfE2vtX72DlrRJA5Y?=
 =?us-ascii?Q?A7J8Fiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeixpL1P3LZfdnBgIJh4nlPNiYXGqEzPQUD9gpWzss6nyaNlja7dwXL/fsd+?=
 =?us-ascii?Q?SZ82LfU29ojEht8qdDRKJFKNcOfiCzUME5KsmzD/C6ajbZY2sQKaJmLJChUt?=
 =?us-ascii?Q?d/sugW9K/rtd7CEvUqSjifkixMx3PmILgdU/sqrD7idJlL12EQZgb8e92/co?=
 =?us-ascii?Q?hjoa31JztK9xOx0g+PzEAbzyfJ+NZeLh100fV6A+hb+1RARweAFcXAS9Dz+k?=
 =?us-ascii?Q?JjNNJnEKs5trP+HypGomrt9X05R7pwv1cTMfFCaSaRyw9isFkIdYPqxHV0NS?=
 =?us-ascii?Q?Ba7m3pHzoYmlFwFU/g5MsN31J2BKUzZ+gQzX608S3CM11WVH2Hea9zBvlTD4?=
 =?us-ascii?Q?mKXSo2cKpNeBPLKdR2glqGMEeYOBtutSXcV6NdB2Uzfv7II2/uaJ9xIDQCSP?=
 =?us-ascii?Q?41G1J/kdqTwrPHjkf/1FgEsIj94o9k6Lj2m9YbtbriFnQY+E2J2OidahX5ZH?=
 =?us-ascii?Q?TjyVVKqW96mekdO9xBzQKT7mFhZpPREcDQ21J/LwMv1a6a8SzohWF/o7cNw+?=
 =?us-ascii?Q?irHRw1w5LIPYEBrmU+qwTwfOhNcpa5dVJ8UNYipPab8UMa7soVTPPPjjao+S?=
 =?us-ascii?Q?tBBDtZrLgf0lLlpSDZieZRvtuFy+hl6br6nZAtfNTm67Xs6SREo1NN9Yrlo8?=
 =?us-ascii?Q?fZ25Wkws5NIQox6jnl+KSf7CNJ4/yyIY3zgQ2aQQliS6j6gOoLs7s4jmH8to?=
 =?us-ascii?Q?aKRMQ6wNePLyWjQfT6w0Uiue0xHjim5oCouP92C8eOze1KQLevzGwCiDIu9m?=
 =?us-ascii?Q?tpez+gNS5DhA4wLXMF5+ovofIJlfMEFWRy5AoOZq7YXFtQAtB8mixHAKOVy2?=
 =?us-ascii?Q?8wmYk3VqCGGhkYs7GyU1vIthu4/E79qmaji/yCzJAuK84heri4Gy+iVfCuTr?=
 =?us-ascii?Q?fGK3sLHimpSgKVA0qwH1h7FYYIET7evWhSI0+AkVBVcTx25PJORf2W+Ud6Ot?=
 =?us-ascii?Q?M2grKWB2QcsaqYy5gpFHxtFKDbFjOAk0gk2OHZ4TlTvG/LD0X0gemqUH1qC+?=
 =?us-ascii?Q?g3hZTSUClnnIE3uxGtQbuFXHlsAQ20/voSkrxWxFWyjjxpyGUTtvmAF1iQEW?=
 =?us-ascii?Q?fsCpgzGDssVPzUMr7ub5SCefIj6YMBXh4rZV/UJcVYR8dEDpTlQOG0glJV0V?=
 =?us-ascii?Q?8R8pmEac5C0IwRTzvVqaqPbe5ZyoN4EmEBA3M+MOdQRxqnxm/TZV7i/0zkPY?=
 =?us-ascii?Q?Jp4VvUQ/rn+cBXCMezbj9aDgMcj69Ph680Q9JJ3TqP5oNJC8sk6xZb00Nsfa?=
 =?us-ascii?Q?zp+M0O/tzL04BF2teXzjKNy6CCz62hqSsbBOj8k9fEvwMJpKffrdIWGpSE29?=
 =?us-ascii?Q?l6ZFWZVOBKLUFVUgypoo67fMzI3B40TSMMhsZKuHkwSGiH0TCckvHSrFO/P2?=
 =?us-ascii?Q?A82SNhD+FMOtebs3muz04rUgxnNyaV+dkUiaKqnAOK2U3heyAxCyp0pFXHWw?=
 =?us-ascii?Q?Ua6neSBTOCcEv0DARDRj3BaVh2VyV4PUK9AG4NBtUNpn90ihlyCDHeApnHa+?=
 =?us-ascii?Q?Q0U3QoL18Fj/MQxx5Z1fw0RbwOBELJSx5dxX7Gl+s8oNRsfn87RVK0B5CKjf?=
 =?us-ascii?Q?sTNLJInqmHt5Di5SsYrknZXrh2VielNse5wQhpBY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e61a31-16b2-4e9a-81bf-08dd1833736c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:25:41.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgovcJDkGmOcnyFE8nhc80hM11Parh2xTmhBO93PSd6luBLFtodFxY4gzLb3AiW5q8wYjkGcsIflP9Xv2sctKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

On Sun, Dec 08, 2024 at 12:30:29AM -0600, Mario Limonciello wrote:
> The ret variable is not necessary.
> 
> Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>


Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
> ---
>  drivers/cpufreq/amd-pstate.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2178931fbf87b..5869bcd287e87 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -318,13 +318,11 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  		int pref_index)
>  {
> -	int epp = -EINVAL;
> -	int ret;
> +	int epp;
>  
>  	if (!pref_index)
>  		epp = cpudata->epp_default;
> -
> -	if (epp == -EINVAL)
> +	else
>  		epp = epp_values[pref_index];
>  
>  	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> @@ -340,9 +338,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  					  cpudata->boost_state);
>  	}
>  
> -	ret = amd_pstate_set_epp(cpudata, epp);
> -
> -	return ret;
> +	return amd_pstate_set_epp(cpudata, epp);
>  }
>  
>  static inline int msr_cppc_enable(bool enable)
> -- 
> 2.43.0
> 


Return-Path: <linux-pm+bounces-21664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBAEA2E83B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FF2188A724
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33611C5D77;
	Mon, 10 Feb 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jBBDK+PV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291181C5D56;
	Mon, 10 Feb 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181113; cv=fail; b=QT4//dfeyNSYRcfJes6D+3ZDX1uw7XfF8JoMDXmUeDCYlydDBtNubZSKI4sr2VDKV3lEQ0sHKYzr/+4JZsU0P2rpjImnyT33VQM8IFD269ojDuW7960ZGFofvTPHzA8odXhSichFJlLgiBuwaUMOu/KQHUlN6IyhsuwaIFeHiCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181113; c=relaxed/simple;
	bh=K3lmgVxQ5NWwPnfLkBq8QjG9cXIXrbHgGZrQOar78iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMEcvJI7XgV3JxaUEQsk+R3/sbcpI0xnh9QzCXEDQarEOMteQPakTnKqces/8Ft2LIAPejQVyBw+k14sZer9yGNf94k+AQgiX4lLaZZHCNR9TZf7iA9cN/xS65nroFT3p82MXG7blP3P8Q0/qexRcP27emMzHUKDEcYZ5ZcsNXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jBBDK+PV; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0Q7PqDGQv/RSufCOeQrAybENfkI7CTLH7Jz70MrD7hS/xWjwn7hx56sGKYyd2M0oI3rapnvsfnT1mammKvzRrYqHep3D7y2ueWWogjGW7nJufUqUXYWU6J2Fh9xH+aVgToiXDIAHkYbjGMJsDLRtRK4fP1lurVM3/DrlFWrgXrkhBR2BO+FLakMg0mwYCZMTHlA1D28CvvvEXl1LZUC8YRtgq+mpPAOU+eL9552a/5GKjzi+2K9NyvkJ6/QGNiRSqO1XG40QhChk6A04x4VgeLeO6HxuEdzbYhL78oIoJAR1UaMXP3SqrCjIWoRg7Ga3oVReAKWXN0bGMGDe7y+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GNTAs15g+fEKVTHWgLAoTDmU6ef0DjW8lIHpvx4h7k=;
 b=rajz47ycCg+3juNeM2MnrKNOwrKGwFiR1FwahGEHvHzcdC5byXsLvvUHm1ba5a1lmJKG8+msNgsfmtxa5E/TddvhCEbRVrVyvtOEMHN2EGw7k2zEMqlC2dTWaPL1J9HgaCRBZAHsyx4mE29k4GsG6+eh49NmnNRLe4gAgwGEVo/U4OzcOQE9fTm/6VkwkbZ5UdLsarx6RcZY4OWiNB/cdkxmIyjx1j+R1HeJbge9MUxrx3/2h/pLUlqVNbQmpWADBKiw4cFeyq+yLGIP+BXoVqZJmIgbqecxltI7yUrjfep+vm9CuS0V89Csnc2lvmkU1dcJWkmsTKbkyuqXJED6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GNTAs15g+fEKVTHWgLAoTDmU6ef0DjW8lIHpvx4h7k=;
 b=jBBDK+PVn7YG6PEL08N6luPcb3/Hs1AGY6BM7U68ikLGXE7UD0lvD4xwVcPNOy/2Ll0+yk1AC9buvqrjfRRWhIPmjhx5udt6kzNVAO51RbtsJEEz1n4DwK7aSfYok434HjIwx1G/b4sEnF37HgjWGEaDyGBYvpYI0AIfe9YCBko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 09:51:50 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:51:49 +0000
Date: Mon, 10 Feb 2025 15:21:40 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/12] cpufreq/amd-pstate: Modularize perf<->freq
 conversion
Message-ID: <Z6nMLKNBkVgYlnNb@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-8-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-8-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9e828f-2d37-46b6-530b-08dd49b889e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tfBZylm3eG6pioPV3D2uoeNPx1XSQ2M+hNRKeDIvsuMEsKRR/2z0PxX3QrRR?=
 =?us-ascii?Q?Dnwnk7/6Dqt+Pyu8nMnT4W9OPyZQrhTxxoPcZrt7DSWLCOzJoX8iPHMYIOtp?=
 =?us-ascii?Q?0q6SyIVfZ2PvVRU4gMTCNSnfqpsv0izhSqgjjU8Wi2tPgqzlZdyirOraWTRC?=
 =?us-ascii?Q?Un6tmIteQLfNXeKd51JMXXdh11Mh6VYigeZiwegV6Dm5wr3OUDaCUwD5fMvT?=
 =?us-ascii?Q?Ic/wKx5mSisk/dumElbS4RFT56/BI8YEpoXH5V+s8R0A9p5fMGdobXZJlGuB?=
 =?us-ascii?Q?xPzx1TgZ8ymej1DaEEspD5QMGQHZ78Gtak1jA8LntMbFMewPH9/UuWJa6+p9?=
 =?us-ascii?Q?KMcRfahllUQxeItsSuxRh2WLTiCjKwn9A+QXu6QC8TAYf0jLOlDOTZgQnHSV?=
 =?us-ascii?Q?7hoRhTyZNJwj7s4JPfv3SXOXWFxwZj4ISmYboDY0X3NRTcnh6wL1p4xlSuCk?=
 =?us-ascii?Q?RCEKH2925EYrTyPdzGBtz8bgf0YG4I6+v+8uiXeANLK1B2KHKp86T6kzoPAY?=
 =?us-ascii?Q?3fasnKmbSsIoaNUKyh1cfd8YCGH4MbgPw0uU+3Uw/L9IodQ7HGNTfMZT1McS?=
 =?us-ascii?Q?VsgCRn7bx8ivHL1hXcmZlIsfEsG3fOMw9J5uRBMH7sF+JPG2TrSpRlHX4y0f?=
 =?us-ascii?Q?K7naCYt61VsuRGjGJxwRk/RGJJUYpuPWDMZptGgXPGa3WuMhAgmHu1lLcdhC?=
 =?us-ascii?Q?9UdSze+TWojhskyzydKAdF6odNATCGQHpAsaQYYzI5ml9UkwfjbdTQ75XRbB?=
 =?us-ascii?Q?bGFrEOFwUmh5ubs5cSQgClzougdmL2HQvWrgTARkHNin1na+TmJ4215mNUVd?=
 =?us-ascii?Q?WWrbbP8l1Ie/9RCctQ3rR9dew2KqW/K7oYSvMJ8/LMe5omiiIEXegtKwSJDs?=
 =?us-ascii?Q?DAagyQOhFRRaY+ZtEhd/UO2tz8ySOQlotiG2EavB+2cQhTvzVYiWNIW533N1?=
 =?us-ascii?Q?7TkZ6Jnsep+zJmEEb+cXsPkoPtctkz0w75XNKVzJOyl34xZFw0QmQRFJjgHM?=
 =?us-ascii?Q?LFlGLEtnl3upcXBnITqtt8hZx0RlURLlHLukEit3ESZQIM6EqKLcOfp9imTU?=
 =?us-ascii?Q?ESTM03bsfkUxEjizFcjXI5toJpvAl0Yjyt8jfTQEqRm396KG6imP1JjeTC5G?=
 =?us-ascii?Q?ImiRKgxhQlyaMqjqG8UKYxdXUkgyPHQemG1cijKw4vmwG80xjKSaHzaJ+ORO?=
 =?us-ascii?Q?L7czMRm0uSvS6tCQ5lJ7KDZ+5DN5cvT8XInJOJQmiwzWx9bkUz9idZOx5GkS?=
 =?us-ascii?Q?xisYQ5yvv+M7URFwH6p7fCoJ1HfLBiB4xZWQA6WYqB8GH0Xd/GP6+5WbfYWx?=
 =?us-ascii?Q?s2agKg7SxCTMaEk+atasj0XwuQDL5tHq8w0g7EP14TPar3tFtT6Fhwd0k/YE?=
 =?us-ascii?Q?w7/hPrqR3b40Iuv3S4c5DMJoRLX8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RFF3yw7EjR5ciAJWsx7+Uf4ZEEdBDVE9nxeptHy3cnyIvQI7/ZxKJtJIzRe9?=
 =?us-ascii?Q?PtvVjlDjGalGFUDLTaFO8ZMnc3sDCty86j9Ey+cAxRHAjSjyHUuMGuiyjWEk?=
 =?us-ascii?Q?z+CJc1QqUlrQCBT5QR/0PFhk72vbfj/l8C1UFuctiC0LZT0EBZmrMDe5RMz7?=
 =?us-ascii?Q?pMNixmOQzuFcoCzIcxLmVZtKPACNKilg2xy/QqsPtaKQKK07zoPLhBjJ4Kfb?=
 =?us-ascii?Q?wz3HSfRP6R4SyNr0dIEYCIXEiEo24X18/G74oQxdbgRlOR5j3mrViq/oc5rJ?=
 =?us-ascii?Q?ybjC6xgTwY3TS1Eofwpim2PV0X6SEIT5e7jJIENBmw9MiT5sh6RGvQEAr/e7?=
 =?us-ascii?Q?s141syVXZ2mqBu0ZIC9esf4aTzRT+ks1U0LQ1nkU3tq4QSTQZRJDvHBX6gzu?=
 =?us-ascii?Q?2Euywc9Z4T3H+fzGvEutzgFhbDzAWqboc6lw9vjmlSQXpn+MiqIBr6WPIdMy?=
 =?us-ascii?Q?/mZXRkxMDah56ny0R/z7vAOhMLHNxAB3fbg0fZE+DPOM/JWKFpgWxWYreXLX?=
 =?us-ascii?Q?vC7HaFRcG9Dpuus0oL1cy3fgVEYRr32evV8xqjILTLJcACceOKDzGIFEbErq?=
 =?us-ascii?Q?HUH3LljsoYEFFShV3zL3qOwzuk/Qgt8Z+/AGIBvRroMiUflouCI01ftfvjwc?=
 =?us-ascii?Q?YBOxt/81/3BD1W+bMPf4QJNwvhNa1O3IOqP6Aiz4TebhByoZi3wDwTjj5W1Z?=
 =?us-ascii?Q?zsDk+o8sGuIuVVQj8nkkIzgda4Gmt2AHhMqTP8hLwO8oH3NUtsJrSojs0jOG?=
 =?us-ascii?Q?63sNwMg7BDpnHrBUSLOPJ8zq5k6e9sm5Z5jMZTdNw2Bd4zdQ8LmtrLRazyBB?=
 =?us-ascii?Q?E8ufgfN5Kc6w36rpNHyVgqGfd/+2XpdCoo1bK9yrQcmVt8fqW/Xj83tk9ooH?=
 =?us-ascii?Q?Vzv2wJqPwu0RZSZ81o9qvqCeNwz2FtfYUz4qgdp+CKC3j3XtIblXXgYRRi4O?=
 =?us-ascii?Q?ahSdnGVCOhyE9jdWGMxb4+yqv2HwX/LS8T707uxF/y785hjlCk+VP02bOfIZ?=
 =?us-ascii?Q?QJv1MjfdQyWS9tBADAumlUflk4avukEY9u5DMUwhE7/QmMkvKIxxNSpNGZf7?=
 =?us-ascii?Q?ka237cmFWkecbYaHV3YrnoA0cRul8YN5Uhvbp1locqIX81HGtVJ0Hc663W0K?=
 =?us-ascii?Q?J70bVKV6tOExUYIl6HYqkcP3egig+22MoM4ayRy+DZq8zQiN5lvCrSSKcawU?=
 =?us-ascii?Q?UBpsx4zJ5yPCADfQAOVZupclMZcrsU8uQ14HZP26CjxiYTDf+U8P1iAM2u5s?=
 =?us-ascii?Q?CpNtTT+Ox6BEDOYnVJP3eSHRkqwRnjPNVYTWZdHa4d8PU5Vmydmib6D6VXMd?=
 =?us-ascii?Q?UPmHf5d32O43H+JYkN+UBbfg2FlBxhBoU+Pdexj+UN0PYsrUgqd+Q9eotQkT?=
 =?us-ascii?Q?NgpfxRmThZeQf7RE3bC8Mz2xHMZxUBuWOOj2bGTrUB0zB5EcJ2PSRhZn2nae?=
 =?us-ascii?Q?NSzpNltWDq5peI+Tyc8V4S2bbxtJy6/qz3HosKELjl12b2WqMBPEOxhgAA7l?=
 =?us-ascii?Q?Hd2pCLlWjRZ9udzqBeohvGGk6y0vrtO+R2IsH50+00PP5TTl68kdFpNsADW8?=
 =?us-ascii?Q?whnGabUo90om2EWZ4xcppVg2PE6/9ACAbLn0sV38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9e828f-2d37-46b6-530b-08dd49b889e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:51:49.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iet6+5UXCuJlNcXiNpEZusCEeMLI4pSfY2dyWze6f73ZdPGrhTTJm1ced0LQVwU7Y4RhH6yR9RNDT49fnDXG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

Hello Dhananjay,

On Wed, Feb 05, 2025 at 11:25:18AM +0000, Dhananjay Ugwekar wrote:
> Delegate the perf<->frequency conversion to helper functions to reduce
> code duplication, and improve readability.


This is better than using the max_freq/max_perf as the baseline since
these values can change when boost is enabled/disabled.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 57 +++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index dd4f23fa2587..346fac646eba 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -142,6 +142,20 @@ static struct quirk_entry quirk_amd_7k62 = {
>  	.lowest_freq = 550,
>  };
>  
> +static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
> +{
> +	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
> +					cpudata->nominal_freq);
> +
> +	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
> +}
> +
> +static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
> +{
> +	return DIV_ROUND_UP_ULL((u64)cpudata->nominal_freq * perf_val,
> +				cpudata->nominal_perf);
> +}
> +
>  static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>  {
>  	/**
> @@ -534,14 +548,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>  {
> -	unsigned long max_freq;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
>  	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
>  	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>  
> -	max_freq = READ_ONCE(cpudata->max_limit_freq);
> -	policy->cur = div_u64(des_perf * max_freq, max_perf);
> +	policy->cur = perf_to_freq(cpudata, des_perf);
>  
>  	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
>  		min_perf = des_perf;
> @@ -591,14 +603,11 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  
>  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u8 max_limit_perf, min_limit_perf, max_perf;
> -	u32 max_freq;
> +	u8 max_limit_perf, min_limit_perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
> -	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
> +	max_limit_perf = freq_to_perf(cpudata, policy->max);
> +	min_limit_perf = freq_to_perf(cpudata, policy->min);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
> @@ -616,21 +625,15 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  {
>  	struct cpufreq_freqs freqs;
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 des_perf, cap_perf;
> -
> -	if (!cpudata->max_freq)
> -		return -ENODEV;
> +	u8 des_perf;
>  
>  	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>  		amd_pstate_update_min_max_limit(policy);
>  
> -	cap_perf = READ_ONCE(cpudata->highest_perf);
> -
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;
>  
> -	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
> -				     cpudata->max_freq);
> +	des_perf = freq_to_perf(cpudata, target_freq);
>  
>  	WARN_ON(fast_switch && !policy->fast_switch_enabled);
>  	/*
> @@ -904,7 +907,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
>  	u32 min_freq, max_freq;
> -	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
>  	u32 nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
>  
> @@ -922,16 +924,17 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	else
>  		nominal_freq = cppc_perf.nominal_freq;
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
> +	min_freq *= 1000;
> +	nominal_freq *= 1000;
> +
> +	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> +	WRITE_ONCE(cpudata->min_freq, min_freq);
> +
> +	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
> +	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>  
> -	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> -	lowest_nonlinear_freq = div_u64((u64)nominal_freq * lowest_nonlinear_perf, nominal_perf);
> -	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
> -	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);
> -	WRITE_ONCE(cpudata->max_freq, max_freq * 1000);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> +	WRITE_ONCE(cpudata->max_freq, max_freq);
>  
>  	/**
>  	 * Below values need to be initialized correctly, otherwise driver will fail to load
> -- 
> 2.34.1
> 


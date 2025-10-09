Return-Path: <linux-pm+bounces-35833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94373BC7603
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 06:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63467189D53A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126F72594BE;
	Thu,  9 Oct 2025 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xsJev7NQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2323D28B;
	Thu,  9 Oct 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984367; cv=fail; b=g7vQhcYG8KIPX4XM0as6G7qVPKb5i8NU9PnytkmdC4FWaW58VJ2ZTpr5yE4bD0A2h0jHmZK3Be3395memg37LRaJ7uEH0LGN++1J35ZP+473nEU+9MG76h3oE9wvz6wTw3VYll149GUiGvbOL1W5xeOvHKT2rS+yqcQWP3LOwqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984367; c=relaxed/simple;
	bh=O1+vRd5tY08Mg24Rc2pAdb0Z4BFkjEaPD56kjI9p1lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSjxS5L+cbQf4E9c7V8mDc9F4eCig1cAXReZsPvWjG57C1UrzjxxRke/SgCuye9e7POP5L+QFlLZ2uiDKTMomE+IQ5nZcG9KL/7+razoPpOJuwXLW05yzlSlxnnwvMW/Ibyl9u8Pn6UaJDxXENAEGwjv6Elea2/AVbExnSYfEmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xsJev7NQ; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i05jfVIl00TFtAlGWLShlwxuJHKnSoAV97Qxopgjxr3xAgyJS7uiS4hZFEzyBEZ4+KKatSiMQn5lciiySYnmDKQRYIgX7Y4wM4aTwSnd6pXYMBXalgliSrDMOKvqgOOGHV8Y32AIbwlRn7TtQE9bTvsAPli49jbFqTCtFc0fw4x7F9cSPPwbjJg6ISnYooJNzADREeewnvB801WNQ/+0Iwsw4E5GqkUfqJUMfLlvd3qXEVHy1UUFXKm5700JJPhr8LYt5N79Zqe8xipnTJn3/lZOezIWMdWGIYUhvKc8vtN3cQGdLyCe3AshIK5oPZXdWMcDgkNw9utHRdf3kh9AGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSk+tAWM7khQdXxr7QXrZXUZSqxL5K01VNFMNGSw9jQ=;
 b=zAj1Xiyi7fPk7lSkS5DYHnq3DEMzZlpgQM08ZLhuo6ZIfLYPffaomQUOqwwyUhmIIujseaS4VL8ybyzVQRrmHh+KF/wKfG8PNJRMBNPG+PsEa5Y9Vtg7mTUrYDFToocCjBi0W95jVr3n8RZO8CMTKsIuOjlKCuCFfob9+3t/xftfoTAWq2s8sj/2+aUoOq9rBKtzd1y0F82CfdRSHEewUmsZvo9YaHKb0/a23tjcGjE+ra1+5gQMKRLzMKUrjlSzYisZeHPKz7yhFGHQoHJoSUXhT2aRb8u6ocPSKIQ5NQ1SlbNCH24e+qKFqHuYFutNNmwG50adEmwSnHjWeU/kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSk+tAWM7khQdXxr7QXrZXUZSqxL5K01VNFMNGSw9jQ=;
 b=xsJev7NQh1ZuRLqtZOipmgGMG7k1nziRW0o9FvEw8colKduwXuD59OOMqFpuHP6FBTuhEPwMcP1uHaRgk0rgV8oYBHIqlubTyGh3yRqu1GPeGMuyoaCc9z29qUqD5L0/Hp+i8RIFmVX+Kvm/Yzy+jEWmMbA4yg+G/TGX//CKF7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 04:32:42 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 04:32:42 +0000
Date: Thu, 9 Oct 2025 10:02:31 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Use sysfs_match_string() for epp
Message-ID: <aOc633L+euMrows5@BLRRASHENOY1.amd.com>
References: <20250924175016.709957-1-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924175016.709957-1-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be8b54e-c8e3-447d-6160-08de06ece28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtUuLXwgCtIT+IQW8SMP3PGvY5hDSD0OMrHXTrnKeMUQwWoAloKIO7x4Jm7Q?=
 =?us-ascii?Q?VIq0idghT6HU29QQUMBCSY2iEvqwOAAhEkGF002peWAipjt2ST2ZlCucV9c6?=
 =?us-ascii?Q?WAeo9UKl/HvvKEFxsnp7FdAMlm+qJUycbfeyvEViH7zFWYv8GpcVxxGS5mJZ?=
 =?us-ascii?Q?GlUtZ3PNVw8KdIiqCP8PGDvqShshAZvIt7E5J2Z9/G6U3skt89ow0kntksA/?=
 =?us-ascii?Q?kX4IbX6CqYLuTG+6KaLA2SEwJLtUVmcKiJEC7Jzs2SXVzDTsg5Cot12frx/n?=
 =?us-ascii?Q?oMfRWZi1PV41jtjjskuXey5RhL4Hjo9DjjjURLjwuYSgykGpnu/dzo2HzkYy?=
 =?us-ascii?Q?r/QN6ii+ukfb7ibLenqOa1X3WlENqlFqO5WlFN3wRJuTFAFsQDhicvZ/ra8w?=
 =?us-ascii?Q?difee0GURvm4CNfvDS9OGgz1s+jyj2aCav90eHQlJdmPMFzNxyF7yuc1rRTr?=
 =?us-ascii?Q?WZP+bv/fZcjRqQD2VSyw+v8oshopBVYchQDQv9iPi3OKCB6MiE47DKqE3HVr?=
 =?us-ascii?Q?tqcN978x4SHrCFGI3NjfEtNaBe8XHOBFJhNa+FFhw1nMVbOhA0Hopxb5n/4W?=
 =?us-ascii?Q?2JQ0HvrcVKTQDGTPW1DWpisKZV6COLt7hLQM6hguDO2nSQtXvocF48u7MzHF?=
 =?us-ascii?Q?0uc9PkRj8BAQBb2OoC1+ic5FbLn2ql+ud4GWseifGXW+QARL5hCbXmSKmT3Y?=
 =?us-ascii?Q?x35brgtQ2mG/VL4vUAxj1vxOgy6FPLgMFt7Z2XGm2u5m8CWvF/krNDREFaet?=
 =?us-ascii?Q?84l0o7sL8TzdPGUd9AEPlMylLCli+6uy9ihSbBZEvtqHfLPc+w+NKsdprg6U?=
 =?us-ascii?Q?77c+PHgx6NdKh9u399Ky23tywMVcNAww6jQA6FnAutAMXW4iC0blQyZjCuKc?=
 =?us-ascii?Q?Schv/nF97QKue1IlJv/xuIZruKLDPxSa9IXySaL0w3llPxIgvl75Iv9Y4Spd?=
 =?us-ascii?Q?YzVvzRrzlR83VmfeWLWOmeBPfVN4sm0zPku5MDtlljbFx+l0HS//5/qKKfEq?=
 =?us-ascii?Q?VVDRUOf28IlnlMYpAwF9K44+AZ5BHrz0nPlsLoEvelFys4ecW1H4eXl2eW70?=
 =?us-ascii?Q?94I6p6r0FX0hWDEmLxb6Q0J2Wl+zfGOdF/4IeTekHM7EzvNOdcwfjBFbQ+lX?=
 =?us-ascii?Q?GTwapeLv2bnYW00RRhVeuvbo0jJCU9u13YVM0ixyk9Jn2QojcyR0zdVd/tUr?=
 =?us-ascii?Q?5t2sVQC4hMIix8Lq1ldp/YWP6G9h8sStEdyaKAxac3FfGRVnTMFWxO87i5zJ?=
 =?us-ascii?Q?bZTwrtTMYp7dlYTV5K6Zhje2lzdnaBA5q8jOK1NILD2tLh1hMAjCFgB0o0aI?=
 =?us-ascii?Q?yXmuj8JLzNMPUGGjhwG8cAGppp+hLL8+mQe0IOvuoY1Ct4H1Gl7KAdt12++X?=
 =?us-ascii?Q?Y7FB9S3mWLX8K4+g9xUeA9lO8NZ6BcIp0/7FOV2mxR3JeYT9DM7wkpVSQBzM?=
 =?us-ascii?Q?jhQSikISD9EufaEq1EjDl8fb+zEqLjxR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Ojd1zVaRWVrmroQBJccXa422WINuQKwUJ+U1GbVk+lkpmnjPvosF5enEGnu?=
 =?us-ascii?Q?QI+1om2W3M03AbkF8GFPxRYeiWRPsltMeSKTgbMJXRtLc/clUaOHq3iH+fB6?=
 =?us-ascii?Q?ijt8GCFzIsgVUhC6NCwLb8pDVEp4yxMOEB7gmFKxx4X2npWbrrr5U/sb40Bj?=
 =?us-ascii?Q?g4UZdieBdderv4K9qtvh3gF1/s/UEKyhP3UeUvAJUj5tbFncXVhEmNV3DTW7?=
 =?us-ascii?Q?SiSAS/US07bx4DcMlJ5kcQQuKazCD47vebw1b1o/6g6Gy7hCk9Ysv+Gbc9ky?=
 =?us-ascii?Q?7mS2xLprAJ6NR/zSKLgENNyhVYOhs9AEX8vYFu920NcBXlHgLygJg8bXqGc+?=
 =?us-ascii?Q?m1sFFFdMU9QgX7GvynvYzrAEKgAtC15vp3LEI+B9TrPwLQg8weOrZulSzWiq?=
 =?us-ascii?Q?U0tg0VLFBsDElINlZwJW6IoEyu3Y69BWyjSvBmd2fnjQbCQ92RgteF6/lHl+?=
 =?us-ascii?Q?uK4wn+Nblz3tMHAixlu/EWKj3QTUWJIPcFKGs75BCAxs/xWvIYeRLHu3/0IV?=
 =?us-ascii?Q?DJkFL2ofaQ3l64A2nGj/Zv6A0pegp4dSVkw2XGPtUaqKVqMcYuRhmbVB6IEI?=
 =?us-ascii?Q?c4fvJwUug+U2tRgEyIS1fDmxEOJnWJhA5yasMEwD1CtseHJVM90O2gV5nkE3?=
 =?us-ascii?Q?NX+qJRA4H55EP/pHtsCSiYRYrF3b/1zW1QXiQxmz7P5rMTiT+73pu44+wikv?=
 =?us-ascii?Q?/DKnvr4DhvdFNhCNG98jpXHBsAmi8wuBVvNs2A1rUAxrERDS/E7B0FYGbRc7?=
 =?us-ascii?Q?4gDXI5hfbRvc1HhlwXxR2Lj7qN3ceeYUybTmbFeAdZV6au1b9fov2Ml/ujAV?=
 =?us-ascii?Q?5RMD9f/qoi6VJ69KAv+p9XJxwO46CPFlDhZs8b1fgiMAZWV76d7m9tAMOBJd?=
 =?us-ascii?Q?EwOPQhZ+VQcw7u3LdQNJPaV5MgK6B/r52k5nhTbphtuQCY7e/os6BIejEZmS?=
 =?us-ascii?Q?yS86NvFWjUOerYwhPydha8bnm/k+leNicesCjIWJFqB6zX1GEh98hQytKKj+?=
 =?us-ascii?Q?MyRLH261Pz0t8HQFcqPV4JI1DT0OBqQnd+dIlvynnmF/E+zml219LZ4INCvE?=
 =?us-ascii?Q?BRQoJR+fP0tP+p3RKf6Ejdir8N23GIH8/RIx3O2VDn8T0YvUK9v3yTq7xu4J?=
 =?us-ascii?Q?DEAK16behMo0AG2QsV/pfxt227olGnwjEky+6ZMa/BTueXeuhVG3lVqyZShm?=
 =?us-ascii?Q?7Ziy5bWdAtr9AnCXm9HYnIZkzlAoTdNMhkYCLuGggqbSxLFoZZnqvMg+v3tQ?=
 =?us-ascii?Q?ahhZIL6B75c1p+In80+qWkNtl4vMNLnO8C2HATK1dOe6sfDzs23uydju7xxy?=
 =?us-ascii?Q?Aake/fwvHC5RQ9H0By37/bVq5ujzNxzss/kbFaHQMtuW+mfjzN/fScdggY2V?=
 =?us-ascii?Q?FvNZ1ISUuAaGYwESySYrihJIKoIV3XOYNw5QS2ZGObGZK7oaRMllQ/RVTb9H?=
 =?us-ascii?Q?3dNOPNyAR2ituSDPrTDTPS98sD4t1QnroopFTMtzYP5uFjMA0ZdqV4n/8dWf?=
 =?us-ascii?Q?a4lOGCbg0a14xRwtnrwTPwXB4iSDQ/fmdFMFV2aYezy+Z5IyAFExvjCmh8Cy?=
 =?us-ascii?Q?mH4U9/Et2w7GE3hBAYTSEnzRwJvXmFoS7w6z2nwX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be8b54e-c8e3-447d-6160-08de06ece28c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 04:32:42.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LT5X/nSeDUYGkzWZQdjtoLwDQQUn9BF2KJuEasN63yCdy9+AUk8WRiQjWY6dc6L5+BEsoMkGW3DyhrixJmSYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

Hello Mario,

On Wed, Sep 24, 2025 at 12:50:16PM -0500, Mario Limonciello (AMD) wrote:
> Rather than scanning the buffer and manually matching the string
> use the sysfs macros.

This is a nice optimization.

While at it, would it be possible to get rid of the "NULL" entry from
the energy_perf_strings array ?

Something like the following in addition to the change in your patch?

--------------x8---------------------------x8----------------------------
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 34835681be92..bd022dd21a4a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -117,8 +117,7 @@ static const char * const energy_perf_strings[] = {
        [EPP_INDEX_PERFORMANCE] = "performance",
        [EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
        [EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
-       [EPP_INDEX_POWERSAVE] = "power",
-       NULL
+       [EPP_INDEX_POWERSAVE] = "power"
 };
 
 static unsigned int epp_values[] = {
@@ -1180,7 +1179,7 @@ static ssize_t show_energy_performance_available_preferences(
                return sysfs_emit_at(buf, offset, "%s\n",
                                energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
-       while (energy_perf_strings[i] != NULL)
+       for (i = 0; i < ARRAY_SIZE(energy_perf_strings); i++)
                offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
 
        offset += sysfs_emit_at(buf, offset, "\n");
--------------x8---------------------------x8----------------------------

> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ba2adea03db1..b8af6cad9e2c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1157,15 +1157,10 @@ static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	char str_preference[21];
>  	ssize_t ret;
>  	u8 epp;
>  
> -	ret = sscanf(buf, "%20s", str_preference);
> -	if (ret != 1)
> -		return -EINVAL;
> -
> -	ret = match_string(energy_perf_strings, -1, str_preference);
> +	ret = sysfs_match_string(energy_perf_strings, buf);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -- 
> 2.51.0
> 

-- 
Thanks and Regards
gautham.


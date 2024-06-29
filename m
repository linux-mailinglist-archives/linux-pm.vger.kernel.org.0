Return-Path: <linux-pm+bounces-10230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5C91CABF
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 05:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016E5B2231A
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA8F1CD23;
	Sat, 29 Jun 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ee+6M+zq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EB1859;
	Sat, 29 Jun 2024 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630114; cv=none; b=ds7dgGY6W+jktHUDYYx3FLAX/VhBr99L4hxKvIYqy4j1xOy6ACnyDtTTUv2F1n03EG+SycqcpmkhU2nzeT//QMTJ+8Zcv+X4nst0T6/+zyo0/Kcc4gq8LDwK7T+i5uaySFDnhtOrdwF2RVauVWOcLD+3tk+i02J1zy8agYeGgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630114; c=relaxed/simple;
	bh=3IQeLnklReFRlCopick9SeNMiQklOjr/8DJVzRCzPTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZYZWjpsPIpBVgLMi2vZybg4OlWpfDwTITuRNTIT+sNisPZ/1zEX8WFyxpBj73+/goPm1uRQ3JOE6TnY968fSbQsp3SS+H6dZkUl4BWyejjlJ6qHno0UHUI+fdGyyloLB/vx2LWFoSJgDM7Xvqfh2uB59EPyQWARrQ8jaAhJD8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ee+6M+zq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T29Yvf020510;
	Sat, 29 Jun 2024 03:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QWl/x/pOp/DbI8aAEPuPXrupu+Fmk104wx/R4KbeJs=; b=Ee+6M+zqyrAH8tu1
	qK9PAj9mkAbVSLZnPprVhNOOaH4DRcqR26Oux6dbfnpQxhK53qG31w5w+plLMuD5
	wZdb0w7Mpurt5Aj9fdn4eJ0jlruEhXZmYy/unu2XMxrOSm7jKWF7+VLJVKuwLlKq
	VlxwRXiMb0nOeWUX6LUT20Y5OGrl4kl7WeJjF6CPxCyQ5buUn7yeXzsQFvRHx0bU
	Dep5ui4QD96F9L67cz0FEff7o1q7gK5KViL7KnD8uKtm4MAK+RQmePb6kWDQ17Zv
	/li8bqO6aoa2Mi96ja6/g5yxgaFcWY8KACyCZ8A5SbCUUWKGK1Aq7+ba7iE38B/y
	clJl4w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rg1x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:01:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T31Uob030745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:01:30 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 20:01:29 -0700
Message-ID: <bec5aa30-3c53-4be7-95be-243ff998edfe@quicinc.com>
Date: Fri, 28 Jun 2024 20:01:28 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas
 Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>
References: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c6PMjhct0JQbmnNNYPTlvrKUlRveqLGT
X-Proofpoint-GUID: c6PMjhct0JQbmnNNYPTlvrKUlRveqLGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290022

On 6/14/2024 11:08 PM, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes three additional files which, although they did not
> produce a warning with the powerpc allmodconfig configuration, may
> cause this warning with specific options enabled in the kernel
> configuration.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> ---
>  drivers/cpufreq/maple-cpufreq.c   | 1 +
>  drivers/cpufreq/pasemi-cpufreq.c  | 1 +
>  drivers/cpufreq/pmac64-cpufreq.c  | 1 +
>  drivers/cpufreq/powernv-cpufreq.c | 1 +
>  drivers/cpufreq/ppc_cbe_cpufreq.c | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
> index f9306410a07f..19ca7f874d28 100644
> --- a/drivers/cpufreq/maple-cpufreq.c
> +++ b/drivers/cpufreq/maple-cpufreq.c
> @@ -238,4 +238,5 @@ static int __init maple_cpufreq_init(void)
>  module_init(maple_cpufreq_init);
>  
>  
> +MODULE_DESCRIPTION("cpufreq driver for Maple 970FX Evaluation Board");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 039a66bbe1be..92a99f09884a 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -271,5 +271,6 @@ static void __exit pas_cpufreq_exit(void)
>  module_init(pas_cpufreq_init);
>  module_exit(pas_cpufreq_exit);
>  
> +MODULE_DESCRIPTION("cpufreq driver for PA Semi PWRficient");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>, Olof Johansson <olof@lixom.net>");
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index 2cd2b06849a2..9d3fe36075f8 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -671,4 +671,5 @@ static int __init g5_cpufreq_init(void)
>  module_init(g5_cpufreq_init);
>  
>  
> +MODULE_DESCRIPTION("cpufreq driver for SMU & 970FX based G5 Macs");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index fddbd1ea1635..e923f717e1d7 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1162,5 +1162,6 @@ static void __exit powernv_cpufreq_exit(void)
>  }
>  module_exit(powernv_cpufreq_exit);
>  
> +MODULE_DESCRIPTION("cpufreq driver for the IBM POWER processors");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>");
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
> index 88afc49941b7..72f568d14f30 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
> @@ -169,5 +169,6 @@ static void __exit cbe_cpufreq_exit(void)
>  module_init(cbe_cpufreq_init);
>  module_exit(cbe_cpufreq_exit);
>  
> +MODULE_DESCRIPTION("cpufreq driver for Cell BE processors");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240614-md-powerpc-drivers-cpufreq-6d345e48164e

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff


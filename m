Return-Path: <linux-pm+bounces-9996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D47917737
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6598E1F23CF1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818141369A8;
	Wed, 26 Jun 2024 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XkHXDxvj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACB28E8;
	Wed, 26 Jun 2024 04:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375694; cv=none; b=VEXeXHab6z/V/NonHkb4JruTFMIN2mNANdQyAhVLE1t0cDkXIT8B5PxL8ACvDxZF0nU03UvbLTDePNx4jFcVOR+XoygjLhdNJNsBCLKBQYu4RmXH+C5TJTN8YkSHWU8oiXFpWCpoGLqBJXBPV6CwrSHOrRhuWKsjoYAEgMAMjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375694; c=relaxed/simple;
	bh=QrGzaWGF/Pxgx7QLBK4bQHhV3RoAHEsagB6y31SWHXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qvYQ87ND7Yomx9968T6uRWuGYOT9ik+Ej2NNsb68oRztNPweR6xMoou7UCaIuBYr7yzrG+25ZdyViAQPZy8Uo0Aon3Gfzp4f4lwkA0Xv0ppvNWp4Ud3UeFkmcZ8279TAJd5SU2o9QYSbzJF6n962jHQBLY/T1y5scXn4DKuecMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XkHXDxvj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIQCXv018135;
	Wed, 26 Jun 2024 04:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPevAHX0eiKoSN3NfsCn/+HoljXZKFpW+pVLwVO2LGU=; b=XkHXDxvjELRpohOy
	vZHb8k9a481yfsmC0o+faWMBSS8x9ZGl6/j9z4UzAMAIyGo4z3PG+dy+A1GyPcEG
	I4r6mqMrdqO14Wea/lwhQ00FJshuwsJVfOgbcu+f/cji7vlA1zZul1MW3NdjtAhC
	XVxngHavFeobOHkzfliNU22GOgwdlmkd3xPoGot2KT052ktqQEri5b+Jj6oxBhQY
	PHFPMq+24S5910fKZA+ZQcpdZBnBQ7AC0FmXzw4AQgkgGlICf6tFUblrwJ8t6KOG
	uOXZTDCjFs1NA+jIRdXOVUsrVB1UdtclDOGQP12DCIbC30CGEibcavmUb6vjbGO4
	+CqYiA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6r5hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:21:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q4LRqJ030757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:21:27 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 21:21:26 -0700
Message-ID: <f09b56c7-ad2f-472a-896e-466261b39ce7@quicinc.com>
Date: Tue, 25 Jun 2024 21:21:25 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM/devfreq: governor: add missing MODULE_DESCRIPTION()
 macros
Content-Language: en-US
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park
	<kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240605-md-drivers-devfreq-v1-1-d01ae91b907e@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240605-md-drivers-devfreq-v1-1-d01ae91b907e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SDdyq6rabC7vapdYTZ0wJnK04xcfAQiO
X-Proofpoint-ORIG-GUID: SDdyq6rabC7vapdYTZ0wJnK04xcfAQiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260032

On 6/5/2024 11:18 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
> 
> Add all missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/devfreq/governor_performance.c    | 1 +
>  drivers/devfreq/governor_powersave.c      | 1 +
>  drivers/devfreq/governor_simpleondemand.c | 1 +
>  drivers/devfreq/governor_userspace.c      | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 5dbc1e56ec08..2e4e981446fa 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -58,4 +58,5 @@ static void __exit devfreq_performance_exit(void)
>  	return;
>  }
>  module_exit(devfreq_performance_exit);
> +MODULE_DESCRIPTION("DEVFREQ Performance governor");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
> index 4746af2435b0..f059e8814804 100644
> --- a/drivers/devfreq/governor_powersave.c
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -58,4 +58,5 @@ static void __exit devfreq_powersave_exit(void)
>  	return;
>  }
>  module_exit(devfreq_powersave_exit);
> +MODULE_DESCRIPTION("DEVFREQ Powersave governor");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index d57b82a2b570..c23435736367 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -140,4 +140,5 @@ static void __exit devfreq_simple_ondemand_exit(void)
>  	return;
>  }
>  module_exit(devfreq_simple_ondemand_exit);
> +MODULE_DESCRIPTION("DEVFREQ Simple On-demand governor");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index d69672ccacc4..d1aa6806b683 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -153,4 +153,5 @@ static void __exit devfreq_userspace_exit(void)
>  	return;
>  }
>  module_exit(devfreq_userspace_exit);
> +MODULE_DESCRIPTION("DEVFREQ Userspace governor");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240605-md-drivers-devfreq-42b19b2594a1
> 

Following up to see if anything else is needed from me.
Hoping to see this in linux-next :)

/jeff


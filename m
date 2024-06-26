Return-Path: <linux-pm+bounces-10061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E4918780
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E356BB21D51
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA718EFF6;
	Wed, 26 Jun 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VstM7qu7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D631891D0;
	Wed, 26 Jun 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419576; cv=none; b=A0bNjPBdDO6kWNeDq2GZjto2Xj4LpCKoDBvDHvPGPUgOt5bh01vnP1ZnpzFC6jY0RKujkvdChuv0f4Yzd/31HfY8DK8vvzuuBNRNbjfdyCZrz8C9/JutroxfWhz/gKHVrKd+oGfzTr2coiqy88Yv3fnVOfSDsJKUCzqWGK3p6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419576; c=relaxed/simple;
	bh=SGSmlVBbcrq5HeSfkYspEX+pjOH4u9u3a54XcrvwW0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EQjSrB3vIyxzD/WeB14HRY9kqcTaEVFFQmRjWqYg+wOtxU7qB/psyTEasDPlRydKoiANdX//KCiFf0R72yWo7XbF2PkjFapsnnYrb8SA2mW+oNfBDpaGjsW1OHRWy7qRG6XugDWwGiXNg2mjeslxlWiuWC/3YU7hQ/Ju6D86/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VstM7qu7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfL7X010627;
	Wed, 26 Jun 2024 16:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u6Yf94icj8216qJpsPH2jCZKDl3FR08PPCwQzZbsYKA=; b=VstM7qu7qLUN1ylC
	3BlbRDoSaNSmWYUwKYsv55Kt6AgA5RbQz2ddQS0v6vA+7UISFeG0cFC8bOxp4F+A
	sJLwx8/ilxRa0vX7Rc48rXkwe6QtxNJwnOVP8VCkSHezez3gstuhz0J6FjeQiQNv
	l5Ic/Y9Rk+frx6pE3koZa5WSStkA1dNCG+tzxBBxOnwqU/UW7woJ6R5PR6UJ5i9n
	dtjn4FHBIX7GYCQulXTa4P2yhYnxvqySFEDlj3RWSKJrs3D2TvDmNGV5sRJPel4m
	hyBQYvJpRe4n0L3cZKrD9CS4raxXTf3kaOJSFQBxNYXt0LqdSCpyhcEtE1fOPs40
	fOpIKg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdq9v2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:32:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QGWcxO015174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:32:38 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:32:35 -0700
Message-ID: <4f39d7ee-6059-4035-d4e3-a38ea22dea34@quicinc.com>
Date: Wed, 26 Jun 2024 22:02:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] cpufreq: Allow drivers to advertise boost enabled
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Dhruva Gole <d-gole@ti.com>, Yipeng Zou
	<zouyipeng@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
 <20240626041135.1559-2-mario.limonciello@amd.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240626041135.1559-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jxYJT153mplh50OOTB7KunV3S-IPmfne
X-Proofpoint-GUID: jxYJT153mplh50OOTB7KunV3S-IPmfne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260121



On 6/26/24 09:41, Mario Limonciello wrote:
> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
> 
> This is because policy_has_boost_freq() assumes that there is a frequency
> table set up by the driver and that the boost frequencies are advertised
> in that table. This assumption doesn't work for acpi-cpufreq or
> amd-pstate. Only use this check to enable boost if it's not already
> enabled instead of also disabling it if alreayd enabled.
> 
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v14->v15:
>   * Use Viresh's suggestion

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/cpufreq/cpufreq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..270ea04fb616 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>   		}
>   
>   		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> +			policy->boost_enabled = true;
>   
>   		/*
>   		 * The initialization has succeeded and the policy is online.


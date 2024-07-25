Return-Path: <linux-pm+bounces-11394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA393BFF6
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB83E1C21A29
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72910198851;
	Thu, 25 Jul 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i6QCIw8K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36E187866;
	Thu, 25 Jul 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903585; cv=none; b=MCjAY5AV8xPBwtJ3dp8eREF/M9TQ7ZsL9jmTHOMr52y2OtMg3idejINNrmYaETcBSK7mISwyjt6mx7Po63abXvJqpZXP2VfF/rzC4XCBIvbB6wX6S/zR6xnXIJlTci4/CIXhPlUHHrRejqlb2ceCCMjYYZEce2oDQBOzSASRFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903585; c=relaxed/simple;
	bh=q2R6qmejY7wV1ZJErertHQrkFkbltq5MaLaLlTFbgaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bwMaD4wqEGFJwQSvOZVzd40aEZf/PbYwZsJjlVpGSrPVFK2j/BlFJSUfwBH+O4xyDtMkXzBSg+/4s3RoqrFjIJtBcPq7fBy8fNHr3GgsHxGWVLAVQ52xeH5izBMFPEznT041+/I2RsmfBDzQIy2sH6mYmYl3mfABmIhD8MVVfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i6QCIw8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P0WoOL004323;
	Thu, 25 Jul 2024 10:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+NJkvVtrWzA8I3lBftm4GOVxGmthl5QFf23tJV31+GE=; b=i6QCIw8K44lbkhEU
	g2pM0tqBDRj4Ig/8B3Z3r5XTCqoO+5My8qJaqfOk42Vc6xPmg+WiFe2zDpau3BHE
	aHX2HmwrWAflN4C0Sl1Pcc+dcfU8HrBXN1LdYyfwl3s7Jm6TcXWeKJd6P33L/sSw
	pnF+iUzHWsyQ6KyQw2gYthQuZJwNEtZTDertR4wNdEFV5s39t4l8w20YcWGI4FsM
	K7oobPJQDp2NsCHtsBJvSAU9oTGL89liY7ubLznA3x8GjBqH3yC3g81pVLDqWaaL
	/bw6BxYccFj3RgTRj4/jRwv/JKJHnwDaOUvD7kimHNYWQgIVt4qhZhRzOXRh2StR
	17Ih3g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5auvw2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 10:32:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PAWqEO022665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 10:32:53 GMT
Received: from [10.218.28.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 03:32:48 -0700
Message-ID: <a577f1d1-ceba-4d46-b874-38aa40cc8354@quicinc.com>
Date: Thu, 25 Jul 2024 16:02:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on
 PREEMPT_RT
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <linux-pm@vger.kernel.org>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Nikunj Kela
	<nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Maulik Shah
	<quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-rt-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
From: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lu8PEDbsZsbZ0qNEfjGSyLX9uJyP-aMW
X-Proofpoint-GUID: lu8PEDbsZsbZ0qNEfjGSyLX9uJyP-aMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_10,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1011 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=821
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250071



On 5/27/2024 7:55 PM, Ulf Hansson wrote:
> Updates in v2:
> 	- Rebased and fixed a small issue in genpd, see patch3.
> 	- Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
> 	- Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)
> 
> The hierarchical PM domain topology and the corresponding domain-idle-states
> are currently disabled on a PREEMPT_RT based configuration. The main reason is
> because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> genpd and runtime PM can't be use in the atomic idle-path when
> selecting/entering an idle-state.
> 
> For s2idle/s2ram this is an unnecessary limitation that this series intends to
> address. Note that, the support for cpuhotplug is left to future improvements.
> More information about this are available in the commit messages.
> 
> I have tested this on a Dragonboard 410c.
This series is tested on qcm6490 with PREEMPT_RT enabled. For the series,

Tested-by: Raghavendra Kakarla <quic_rkakarla@quicinc.com>  # qcm6490 
with PREEMPT_RT enabled

Tested APSS suspend and then SoC power collapse through s2idle and s2ram 
paths.
APSS and soc power collapse stats are incremented.
/sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
/sys/kernel/debug/qcom_stats/cxsd

Without this series, they are not incremented.

Thanks,
Raghavendra K.
> 
> Kind regards
> Ulf Hansson
> 
> 
> Ulf Hansson (7):
>    pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
>    pmdomain: core: Don't hold the genpd-lock when calling
>      dev_pm_domain_set()
>    pmdomain: core: Use dev_name() instead of kobject_get_path() in
>      debugfs
>    cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
>    cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
>    cpuidle: psci: Enable the hierarchical topology for s2ram on
>      PREEMPT_RT
>    cpuidle: psci: Enable the hierarchical topology for s2idle on
>      PREEMPT_RT
> 
>   drivers/cpuidle/cpuidle-psci-domain.c | 10 ++--
>   drivers/cpuidle/cpuidle-psci.c        | 26 ++++++----
>   drivers/pmdomain/core.c               | 75 +++++++++++++++++++--------
>   include/linux/pm_domain.h             |  5 +-
>   4 files changed, 80 insertions(+), 36 deletions(-)
> 


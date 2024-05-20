Return-Path: <linux-pm+bounces-7978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A98C98C5
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 07:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395061C20D94
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 05:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433F12B95;
	Mon, 20 May 2024 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y+/MqJxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161A101C4;
	Mon, 20 May 2024 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716182833; cv=none; b=ebHX7x8yDnAawJqFMW6VZe3rqdCOOk8gkObsticoxltDlCGvD5JXuGjVwwaf3RWJAX4Wq88DCNsZmP+Ms6XJqDFsd2NVVF4WaYBfZl6CzBLBgGGZpKrZOGykq9liu6Xb5+BYE6q8cCI98uawKYScXrqN1kLn2FpZpum96OaDjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716182833; c=relaxed/simple;
	bh=1lWSxjwxZlL0QP+OxPM8V/1Lvo2RKHgRDHaXZxT2E+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PzQ0auB+cI0g2Rn9nqXglmSeFJUXCEIrdqgnJxx0UI8UYj1c3+f+DR0DIZmy9FSpnYSUnirXK8VKa/5HSNjjDk56CLuvYwSoW1vA/h5oZQir3/QZy7P1L2/AwZiR3lTlJYTb3NUiea/rCI1kJmUcGVDBLIRKxsE7Y5Q9qs0xRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y+/MqJxE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K090sK016423;
	Mon, 20 May 2024 05:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hR9DHjIH4dE8NvkMW092O+FryLwkqwjNd9Kd6N/RMu0=; b=Y+
	/MqJxED6/shIf4t1kLmnEFFqfLokgFH2dwTjGChGxLshtyfVo/W2SkvPxQrWcUr9
	m7P64xWmszd3foQY27IxcrSNWvPV6eRZ4o7nSDd+3asCS/wdwpwA1xe/38WEXamh
	/KVRJPw9VAFzWLlwf+7IRMlH32NbWVtCLT6MZ25be1rymDwK9V1lBGEu9/qZ6r3F
	WF6ccU70qHT9ZBatGioggm4zZ17haULs0uRZoUGkAYs6K8RU4fvyVwwfaLQe4ZoF
	8fHtheWXAiMViDX+JPQMYmUXQaLBZL8dPbCQHVKNBBv+3cFk7Ke4QVNefbCt8n/6
	BEomRPgpsd4i8z5bDp6w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gaj6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 05:26:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K5QmCS020051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 05:26:48 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 19 May
 2024 22:26:44 -0700
Message-ID: <24063964-fa44-4093-bbfe-950eeb7d01b3@quicinc.com>
Date: Mon, 20 May 2024 10:55:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: scmi: Avoid overflow of target_freq in fast
 switch
To: Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Cristian Marussi" <cristian.marussi@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vivek Aknurwar <quic_viveka@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>
References: <20240517070157.19553-1-quic_jkona@quicinc.com>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <20240517070157.19553-1-quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RQWv6nMLlKEF9BUAr-vik55wejgKR5Bg
X-Proofpoint-ORIG-GUID: RQWv6nMLlKEF9BUAr-vik55wejgKR5Bg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_02,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=975
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200043



On 5/17/2024 12:31 PM, Jagadeesh Kona wrote:
> Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
> can lead to overflow if the multiplied result is greater than
> UINT_MAX, since type of target_freq is unsigned int. Avoid this
> overflow by assigning target_freq to u64 variable for converting
> it to HZ.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>   drivers/cpufreq/scmi-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 3b4f6bfb2f4c..42be87aebe6f 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -63,9 +63,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   					     unsigned int target_freq)
>   {
>   	struct scmi_data *priv = policy->driver_data;
> +	u64 freq = target_freq;
>   

To keep type of freq consistent with the rate parameter of scmi 
.freq_set() callback which is unsigned long, will move the above freq 
variable from u64 to unsigned long and post the v2 series.

Thanks,
Jagadeesh

> -	if (!perf_ops->freq_set(ph, priv->domain_id,
> -				target_freq * 1000, true))
> +	if (!perf_ops->freq_set(ph, priv->domain_id, freq * 1000, true))
>   		return target_freq;
>   
>   	return 0;


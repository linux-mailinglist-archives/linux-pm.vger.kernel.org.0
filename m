Return-Path: <linux-pm+bounces-16957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D99BB6B6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB481C22FEB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE62AE90;
	Mon,  4 Nov 2024 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QeFRtVxW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8F487BF;
	Mon,  4 Nov 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728305; cv=none; b=rBpx/PsLQCWpAoxLUW+pkOJV4ZYs/EuMfv/nT4RkX+Derv8MmkkhCbr1lSMHe3gUbkKnN3rQMlpWyPWD3VoY4YrbYiilUdNfLFssS0t70w69gbcx8TSTebKdpZjjNg6GnjPwj4T8DSjNDU4XPmXcqd2+qBHJjG69UuBFemKZv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728305; c=relaxed/simple;
	bh=/quXELEhoBPOJKcJckFERwjPKghl9G9GL5qzUYqocss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lDfc9r5VYsHWwoCxVUeUXe2RIjc+WPyn8ass9OAD6AjlVnY29EsIAr/QBdzzPY/NdZg7o2wbEqM5eGuHgUrCGJbfx/BX5ePlqfhpaI009KQ0csBBh/e1HYcNbfhRXdfp0bspa/PTUVpIG3fp+VdsisayLiIlwp5JJqsxaSq2sW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QeFRtVxW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bj2Xf004768;
	Mon, 4 Nov 2024 13:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9MrI4+M+kKHAd3Sup0mRHUENnMs265A92SHE5aq5rS4=; b=QeFRtVxWbA5wlaYD
	Mi5icSlVBSOTUTsvC4YJneW1skCW7Uu5SZDqCPHrpwBnrd3dwL7puGo2UNp7IygD
	kDmKSx/3jqgvi+pcfaUN6uTkhA2yy4V0Gf/jAgiingblje8qhXgXRDq409ALKWrl
	zvBBDC3W2iBBgkokSumcythPDOyiLoMJxJZlX5MfTjvfO63lvwzpz08QfgtCSPjl
	d3c/ZcMGfPTelCcGBZd8MjVizsUGEOgrTqqA2WPcwLouuimlyzYUmcTYXyYX3t93
	ssV8bPpuK3mPwGX0Rq9S9zAn3jLCMqshSVXafVXZwcd/7smzI9ksjusXAUo+v8ln
	Jm5JbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd284ejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 13:51:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4DpUI4025073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 13:51:30 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 05:51:22 -0800
Message-ID: <e173058b-57e7-7fd0-dab7-7398bf9d66ec@quicinc.com>
Date: Mon, 4 Nov 2024 19:20:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as
 firmware bugs
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        Johan
 Hovold <johan+linaro@kernel.org>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <20241030125512.2884761-4-quic_sibis@quicinc.com>
 <ZyThAFbOHKaBIgLg@hovoldconsulting.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZyThAFbOHKaBIgLg@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N9dkp-hFPldnpkGgKZ0fDSY64p2Ut9pZ
X-Proofpoint-GUID: N9dkp-hFPldnpkGgKZ0fDSY64p2Ut9pZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040121



On 11/1/24 19:39, Johan Hovold wrote:
> On Wed, Oct 30, 2024 at 06:25:09PM +0530, Sibi Sankar wrote:
>> Duplicate opps reported by buggy SCP firmware currently show up
>> as warnings even though the only functional impact is that the
>> level/index remain inaccessible. Make it less scary for the end
>> user by using dev_info instead, along with FW_BUG tag.
>>
>> Suggested-by: Johan Hovold <johan+linaro@kernel.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/perf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index 32f9a9acd3e9..c7e5a34b254b 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -387,7 +387,7 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
>>   
>>   	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
>>   	if (ret) {
>> -		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
>> +		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
>>   			 opp->perf, dom->info.name, ret);
> 
> I was hoping you could make the error message a bit more informative as
> well, for example, by saying that a duplicate opp level was ignored:
> 
> 	arm-scmi arm-scmi.0.auto: [Firmware Bug]: Ignoring duplicate OPP 3417600 for NCC

I did think about doing something similar but xa_insert can fail
with both -EXIST (duplicate) and -ENOMEM, so the we can't really
use term duplicate when insert fails. I can add the perf level
though to the message though.

-Sibi

> 
> or similar (e.g. as the current message looks like an error, with errno
> and all, that indeed warrants warning level).
> 
> Perhaps with such a message you could even keep the warning level to
> make it stand out more (if that's desirable) without the risk of scaring
> users.
> 
> Johan


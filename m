Return-Path: <linux-pm+bounces-9883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202AD914590
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A235A1F21B14
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D712AAE2;
	Mon, 24 Jun 2024 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m11yaG0n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60110127E0F;
	Mon, 24 Jun 2024 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219542; cv=none; b=b7npSDLEervaInblWRgVcAj1DkrNEiWf5UYhnJD0O/vJooUN6i0vA3TGxcvvF2NRHAc4xSpxRWsdnxTJqrBWcDCBwdptdrQOfdx7bYd2P2rRt8/VFIYIb3Jxs7lf7Ii2Q5hNRPzbGhcLgBm3WHgC41buC07lQJQ6eHm0ozArntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219542; c=relaxed/simple;
	bh=ZhfCAPfqgNYy4IYD6ThGSxHwosZDfswjwRJxbI1mGxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mD93EdrJ8l+igbB7RIW5oXwc5OcrxIZq5m2Jy0XdsQdpnnsKfmy6Vl+iBO8yUPkX4pE3FH+ry5Z8ouad+LAd8YfwalwxwC7yFsKqku9uQ9OWasK3ftPExqleyQSiEdL0K6qWlSn+K7obGkPYI70uo+TH26bFKj152CW6df1Ygqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m11yaG0n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8ZNbe032231;
	Mon, 24 Jun 2024 08:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tGJtOpqBIGwTpmqQINRRFGfIw6RK45oXzRRb9w2IWoI=; b=m11yaG0nDIuS5Krw
	Bayzb5INXKll0yrr2GsQX3lY2jzaMm1n90OSi8vp8NRGwU6fVLV9BNEUzuYwS1ti
	KejjfTlEiSX3B/O79Bft69+WyLaCc05yiQXjfAJeQT33BK3fJNCiR0bIXD2tDxJX
	QDE/BJJ64ZqYtz3sUoeyPBrM45Qn+aN2rf1vydpyerZF+HxsjzIP5o5KIdzWrtOg
	wWImQF5QiXDCOWJQumNSSRf3v6UkkJerIalIdphIOKgbFspH8qfc4gNe68i79z2A
	vTcL5URMSmCarWm+laQ2SHiRqXHcYBKwdMXc/A4e9datDnP8XEruo6E16baeTLhY
	Ec1FGg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv31xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:58:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O8wuKr006141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:58:56 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 01:58:51 -0700
Message-ID: <2f238fe4-aa67-b311-7c76-a67359587268@quicinc.com>
Date: Mon, 24 Jun 2024 14:28:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/3] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-3-quic_sibis@quicinc.com>
 <d4f3rlk3jgqegxvto2b6vyemspommtsbs3ixqgan2rmknet3je@ohonicqa2iqy>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <d4f3rlk3jgqegxvto2b6vyemspommtsbs3ixqgan2rmknet3je@ohonicqa2iqy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eqOtmyj0__tdEnBSUJFI07Tw83tklCfV
X-Proofpoint-ORIG-GUID: eqOtmyj0__tdEnBSUJFI07Tw83tklCfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240071



On 6/19/24 00:25, Dmitry Baryshkov wrote:
> On Tue, Jun 18, 2024 at 09:13:05PM GMT, Sibi Sankar wrote:
>> The multiple BWMONv4 instances available on the X1E80100 SoC use the
>> same interrupt number. Mark them are shared to allow for re-use across
>> instances. Handle the ensuing race introduced by relying on bwmon_disable
>> to disable the interrupt and coupled with explicit request/free irqs.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v2:
>> * Use explicit request/free irq and add comments regarding the race
>>    introduced when adding the IRQF_SHARED flag. [Krzysztof/Dmitry]
>>
>>   drivers/soc/qcom/icc-bwmon.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>> index fb323b3364db..4a4e28b41509 100644
>> --- a/drivers/soc/qcom/icc-bwmon.c
>> +++ b/drivers/soc/qcom/icc-bwmon.c
>> @@ -781,9 +781,10 @@ static int bwmon_probe(struct platform_device *pdev)
>>   	bwmon->dev = dev;
>>   
>>   	bwmon_disable(bwmon);
>> -	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
>> -					bwmon_intr_thread,
>> -					IRQF_ONESHOT, dev_name(dev), bwmon);
>> +
>> +	/* SoCs with multiple cpu-bwmon instances can end up using a shared interrupt line */
> 
> ... using devm_ here might result in the IRQ handler being executed
> after bwmon_disable in bwmon_remove()

Ack

> 
>> +	ret = request_threaded_irq(bwmon->irq, bwmon_intr, bwmon_intr_thread,
>> +				   IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), bwmon);
>>   	if (ret)
>>   		return dev_err_probe(dev, ret, "failed to request IRQ\n");
>>   
>> @@ -798,6 +799,13 @@ static void bwmon_remove(struct platform_device *pdev)
>>   	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
>>   
>>   	bwmon_disable(bwmon);
>> +
>> +	/*
>> +	 * Handle the race introduced, when dealing with multiple bwmon instances
>> +	 * using a shared interrupt line, by relying on bwmon_disable to disable
>> +	 * the interrupt and followed by an explicit free.
>> +	 */
> 
> This sounds more like a part of the commit message. The comment before
> request_threaded_irq() should be enough.

Ack

-Sibi

> 
>> +	free_irq(bwmon->irq, bwmon);
>>   }
>>   
>>   static const struct icc_bwmon_data msm8998_bwmon_data = {
>> -- 
>> 2.34.1
>>
> 


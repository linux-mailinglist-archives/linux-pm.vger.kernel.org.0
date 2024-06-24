Return-Path: <linux-pm+bounces-9881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4E914580
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10B61F212CE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54A129A7B;
	Mon, 24 Jun 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNbpvw3q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F27FBA4;
	Mon, 24 Jun 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219427; cv=none; b=ZNQqZAc4tdKYDqAMceJAatp6N9V1EyQfjosOf9oTWU4rxGmLgl9AQdODCL8rlnrf8xWG+V7D30c45+hs8niFn2XRBSfyj191ZpdBCRoiNGVDXEDg+OmvoD+FQO9uP3FyRGepjYC1rWlPqChdYAL7SOzVvvsuYpTmg+dXc+98LtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219427; c=relaxed/simple;
	bh=UCw6cbBAt2RESnbbjnDzyzljalZmFBvcXqndqXVYdak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kURa4ddTWzjZax+WEcZMASr3sh9VrwOrNXnRfkMG0nsRc/YOILUw4ISTH2gWO8YaNHEzY8K2GvQOXwaNPz8ZAusIQdMEryOYrbfUF+3coCTcvR7cqK65exOaEqT6s44nO1vG+uVK2bBtzRY3XRSJtJ3HQhb8E8l+QZurXHWs2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNbpvw3q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8Ycdd018129;
	Mon, 24 Jun 2024 08:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2ApJLtM8F0b/DVXCbP+rOWZFCQMcxrOdYkrWU0hg9M=; b=GNbpvw3qe3DT8lVu
	QfXXx8n/wGqCpblnWcGb7Eti3kbMBjENJw1ABNcIxhALI7BEP4yZEm90KMpK/y98
	9ej3LPSXncHzspIusrQkARJVv7YdLnDpL5hIFbbK/OK5vEduEHmE3RJXYo+33HPP
	2WP/xA5muLGwvUuNlCF96M9HjnzXOgMN1iealAwPK9Hu1n2ZwmTx4+6wx6TKwGEa
	4Uo/txPvMVrqFXISRE4VArHNgu5n5UMWggMG7El02aOpNRU8KfIjcwMGt++16HQx
	jfEbdxtzJgAPbAqR9Qlw74YP3VhkU8GnytPM8sAfSTI/3cMMZho0ZdQc4FcdGTJ1
	zhBwpw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6k44d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:57:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O8ux7g021092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:56:59 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 01:56:54 -0700
Message-ID: <75ed1065-d123-9193-7017-cce12889130b@quicinc.com>
Date: Mon, 24 Jun 2024 14:26:52 +0530
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
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-3-quic_sibis@quicinc.com>
 <vjes4lm3um44f6oguvrq3gozemquzmmmicj47ieczwfuqkmaqp@aby3dj6ttdig>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <vjes4lm3um44f6oguvrq3gozemquzmmmicj47ieczwfuqkmaqp@aby3dj6ttdig>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h1imEcxYojwwOV3vYfxhu0HRJbo0mvUS
X-Proofpoint-ORIG-GUID: h1imEcxYojwwOV3vYfxhu0HRJbo0mvUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240071



On 6/21/24 11:15, Bjorn Andersson wrote:
> On Tue, Jun 18, 2024 at 09:13:05PM GMT, Sibi Sankar wrote:
>> The multiple BWMONv4 instances available on the X1E80100 SoC use the
>> same interrupt number. Mark them are shared to allow for re-use across
>> instances. Handle the ensuing race introduced by relying on bwmon_disable
> 
> In an effort to educate the reader, could you please describe what the
> race condition is here.
> 
> It would also make sense to break this ("Handle...") into a separate
> paragraph.

Ack, will make the changes in the next re-spin.

-Sibi

> 
> Regards,
> Bjorn
> 
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
>> +	free_irq(bwmon->irq, bwmon);
>>   }
>>   
>>   static const struct icc_bwmon_data msm8998_bwmon_data = {
>> -- 
>> 2.34.1
>>


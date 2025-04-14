Return-Path: <linux-pm+bounces-25391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55AA88A92
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F939189A1A5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450528B4E3;
	Mon, 14 Apr 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OZV6rAjo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6C288CB6;
	Mon, 14 Apr 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653612; cv=none; b=RIX+11W6vn4FnNVc9HRXbIMfM/M+Vuz1HefaYRAXVyFi72FgGdEWFjIBftwRo1obL51gDgrzRrWXx0ITBOYXeaZeu8eH7vKuf9QGRQfPgtT/VgMwIoiiDp8wLHTdVwVhGqtigcOZddqqaWa7inK5rZaVmEC5cq7UXMOOxloRVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653612; c=relaxed/simple;
	bh=+CoYcsP98tUeuncLLLFjvVY9A37RssOyoYXVp+8fEpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nX0xRBvC19w9Y2dGRXnn/3hl5KNWoQbl1qXvMj+FpbGs0HbAEN0o7hzZej8wPiXSQhBMsiJp00uMLAnlT1+gAbs3ExKV1vwOqozN1jvTaCcnX3JP/7m4ZvNn2TcQc5esoKlLQGDCQ2a1DqgcplZ88ofOUUmEftknS5HV5c5A1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OZV6rAjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E9AF9T017437;
	Mon, 14 Apr 2025 18:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+m3M7q4RcMjSlbZqaN3PtP+0QBeAAlsXq7JC4+LsdA0=; b=OZV6rAjo/XCBN5sF
	Uvc+kqFXH3xiJRyXKau+5wYOVdtNLTr88zklQZpJk1ZIRl5/zInqS5BTNa/y5wZ9
	iqtybdYnW6oCCoB9fgHyYHQQTLNte8EF9DU5UgFHcpsDu3seqvih0z5SLl5HnD9N
	K8yAa7RL0uIYDz1P5tlKucGVYarNxPtSxePmxrRAWvNb7DSs4xiPTLs5BeZfkWE/
	tdqkeQ49YkFJ8aiN9Trh7u/B8c4iMxVFu/n8UzQAt5KuOuJOZ6LhX20F+Q+Q+8cz
	XLstUJKHrukk/oN7ynn3KLCnGFe0SFFp3zzbFiLfWCGPscD771uF4kRRTz6hcrtn
	KIcs3g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6de10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 18:00:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53EI05Nb018506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 18:00:05 GMT
Received: from [10.216.13.250] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Apr
 2025 10:59:57 -0700
Message-ID: <1e69b6f5-efe7-4b81-8bea-b463b1eacfd4@quicinc.com>
Date: Mon, 14 Apr 2025 23:29:53 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p
 Qualcomm platforms
To: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
 <20250410174010.31588-5-quic_ptalari@quicinc.com>
 <abbfc13d-d6f5-485f-a73d-6a89e15f0ff6@kernel.org>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <abbfc13d-d6f5-485f-a73d-6a89e15f0ff6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mcRZeR5fc5ZqeuH0u5O6SW9r8zsyvGff
X-Proofpoint-GUID: mcRZeR5fc5ZqeuH0u5O6SW9r8zsyvGff
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67fd4d26 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=BTMtgF0SbkP0gLXr6YcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140130


On 4/14/2025 1:26 PM, Jiri Slaby wrote:
> On 10. 04. 25, 19:40, Praveen Talari wrote:
>> On the sa8255p platform, resources such as clocks,interconnects
>> and TLMM (GPIO) configurations are managed by firmware.
>>
>> Introduce a platform data function callback to distinguish whether
>> resource control is performed by firmware or directly by the driver
>> in linux.
>>
>> The refactor ensures clear differentiation of resource
>> management mechanisms, improving maintainability and flexibility
>> in handling platform-specific configurations.
>>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c | 78 +++++++++++++++++++++------------
>>   1 file changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c 
>> b/drivers/soc/qcom/qcom-geni-se.c
>> index 4cb959106efa..5e2add1e04d3 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -105,6 +105,8 @@ struct geni_wrapper {
>>   struct geni_se_desc {
>>       unsigned int num_clks;
>>       const char * const *clks;
>> +    int (*geni_se_rsc_init)(struct geni_wrapper *wrapper,
>> +                const struct geni_se_desc *desc);
>>   };
>>     static const char * const icc_path_names[] = {"qup-core", 
>> "qup-config",
>> @@ -891,10 +893,44 @@ int geni_icc_disable(struct geni_se *se)
>>   }
>>   EXPORT_SYMBOL_GPL(geni_icc_disable);
>>   +static int geni_se_resource_init(struct geni_wrapper *wrapper,
>> +                 const struct geni_se_desc *desc)
>> +{
>> +    struct device *dev = wrapper->dev;
>> +    int ret;
>> +    int i;
>> +
>> +    wrapper->num_clks = min_t(unsigned int, desc->num_clks, MAX_CLKS);
>
> I thought min_t is no longer needed in these cases?

it is needed since there are two types of QUPs - the normal QUP which 
uses 2 clocks,

and HUB QUP which uses only 1 clock.

>
>> +
>> +    for (i = 0; i < wrapper->num_clks; ++i)
>
> FWIW i should be unsigned too.
>
> thanks,


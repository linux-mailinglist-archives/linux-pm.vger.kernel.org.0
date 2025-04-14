Return-Path: <linux-pm+bounces-25390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EC7A88A5C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 19:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9387F7AAC59
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB128B508;
	Mon, 14 Apr 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WX+P93mK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A61A08AB;
	Mon, 14 Apr 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652982; cv=none; b=nW9f4FKE2fMhY1/4zTt2MmFRX6M646FDI1LI9g6h74Zjl2qP9fzAzAgkmcqtdVpxgVyS2AX/Eyvn2a+S4C0r/fggSmkB9Ijp6BAicv5zXF+dUYDhfRdic/eVlhnbghRPIR1mbx8IENB9BSZ9si52qIvebkntbfwFxeIIH+BHxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652982; c=relaxed/simple;
	bh=ulqrosDqiUlPlEkamQ1xyIFEuty/JmTNovXKiA2L3IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DVa99rxHYQQhsd+j+KZfn19bVakVs61hA8Jtk38khH6zpvtk1P1pg661gE9BASAh1C9bZJe/jNnQt1bW1QFBkqwZi/WT/uIrCeoTw5eDs9wzmijvpeWK2IxvwvBXnz9937VXcM4u7OB/rpiqSX/fNQ5kpzfZakFKetoamNVLjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WX+P93mK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99qtg011395;
	Mon, 14 Apr 2025 17:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3yPyywTlsnu2wroIHMQvuyXG7piAsNEAqqurWw7fZ5g=; b=WX+P93mKx4PK3NOj
	xh6vf6nHiXCBBWURnrOTWK0PFFCFi4dcv/bVkOXZem4aHPSif9elmQmHb8N4J0f3
	PpqeVeeBu8RuRTL2pLeAT6VG47PWtk+neOiRYRblfAxE+hiZ3dRMYdG4BK6blZea
	9hF+qYzygsFV4WwWbg3f/XlLFQ6Ye4wsdly/FdcEYjCffbIFoPnALi335BNxyn6S
	peYjhh4APdN2RVDdlBhdcwK+zITRgUiByUAQlFoABQy4WGYumyb/Vbpi09smeXGp
	o5kdDY6XFpzlzn2/rWUaG67zUxqlcJNf6RCfLaUub5kPiaLqbCCJbJSRknJBFKde
	L8nkAw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wdbvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 17:49:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53EHnLCv028213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 17:49:21 GMT
Received: from [10.216.13.250] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Apr
 2025 10:49:13 -0700
Message-ID: <de05fd91-b8d2-4799-a57b-ccc6e9fbafd9@quicinc.com>
Date: Mon, 14 Apr 2025 23:19:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] serial: qcom-geni: Enable Serial on SA8255p
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
 <20250410174010.31588-10-quic_ptalari@quicinc.com>
 <4183462f-7e4c-4da2-8f6b-0dadf26e1b2a@kernel.org>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <4183462f-7e4c-4da2-8f6b-0dadf26e1b2a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fd4aa2 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=ju1iAOFsNRn_4Ngbc6QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Jaq6r0Om7_7zFUCmQPg-SgGrNwa1g1rG
X-Proofpoint-GUID: Jaq6r0Om7_7zFUCmQPg-SgGrNwa1g1rG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140129

HI

On 4/14/2025 1:39 PM, Jiri Slaby wrote:
> On 10. 04. 25, 19:40, Praveen Talari wrote:
>> The Qualcomm automotive SA8255p SoC relies on firmware to configure
>> platform resources, including clocks, interconnects and TLMM.
>> The driver requests resources operations over SCMI using power
>> and performance protocols.
>>
>> The SCMI power protocol enables or disables resources like clocks,
>> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
>> such as resume/suspend, to control power states(on/off).
>>
>> The SCMI performance protocol manages UART baud rates, with each baud
>> rate represented by a performance level. The driver uses the
>> dev_pm_opp_set_level() API to request the desired baud rate by
>> specifying the performance level.
>>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 150 +++++++++++++++++++++++---
>>   1 file changed, 136 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c 
>> b/drivers/tty/serial/qcom_geni_serial.c
>> index 9649297d4a9e..40b71d4b7590 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
> ...
>> @@ -1624,8 +1669,27 @@ static int geni_serial_resources_on(struct 
>> uart_port *uport)
>>       return ret;
>>   }
>>   -static int geni_serial_resource_init(struct qcom_geni_serial_port 
>> *port)
>> +static int geni_serial_resource_state(struct uart_port *uport, bool 
>> power_on)
>> +{
>> +    return power_on ? geni_serial_resources_on(uport) : 
>> geni_serial_resources_off(uport);
>> +}
>> +
>> +static int geni_serial_pwr_init(struct uart_port *uport)
>>   {
>> +    struct qcom_geni_serial_port *port = to_dev_port(uport);
>> +    int ret;
>> +
>> +    ret = dev_pm_domain_attach_list(port->se.dev,
>> +                    &port->dev_data->pd_data, &port->pd_list);
>> +    if (ret <= 0)
>> +        return -EINVAL;
>
> Any reason to reroute every (sane) error code into EINVAL?

i opted for EINVAL instead of EBUSY because i don't want the probe to be 
re-executed if the firmware does not support SE.
Let me know if you have any suggestions.

Thanks,

Praveen Talari



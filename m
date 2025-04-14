Return-Path: <linux-pm+bounces-25358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E994A87B1F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BF818936C4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEBB25A32D;
	Mon, 14 Apr 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LWVOKgjx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDC482EB;
	Mon, 14 Apr 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620955; cv=none; b=VskQ4TUCtObHaPKzVs80f4OJA16Z81puJBOrlQ1CFqP+HYAftLawFQG7H+74hYVglRoMeSc/vz0OFkncye1JH0bFU/Sb8UyILQsyOGS12Josgo6obN1+uVLjJOlF4LPzYfRImNu12jN6zWtuFwGkpOL5vnxTwEieEMNocv0sRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620955; c=relaxed/simple;
	bh=Mp570jmlWEeM0GxqOL/8YDaxX/5A3uK3xNw57Lx3N9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CTUoTbfxztFATk/QM6lKBeQIXmNb8bU21mWCE0NSwP6muixyZFM+77Bu/vOH3ZRvU8fiGt/HT1AqZmzUcPYRSFyFYhL1mOKEik6gwjAv2TAqvbO/YmYS9qVLXFkLTCMRTnwSWH0ZAhdxwiovnxWPEL9fJ+r428iqrrEyQJNS5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LWVOKgjx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DLf2CF024141;
	Mon, 14 Apr 2025 08:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	026VEws+o5At9yvPs07UXmfkca/2pcUW8F11Bo9sjlA=; b=LWVOKgjxbXqxescI
	Ea9Og+G81eotUumg6yHmdbP4ADOntgtlki4w4FXD2zjnmNqAROzgm+687LQECdKx
	yHwWPRQylblahVCdqerf2aq7iE/YotxbcRZMO4GKP5Vn4CIGuYzv9VtcE4vpg1ME
	Y4MVz3KmJHMWKKegcAyZ8BvsSsXNNeRorbY4CWT3Q3nNkeqTEeghfGchc9BRFHCT
	Ra6f/IqggzqEpQqiMa87RiTr9fiypSUaedThDZOj7O5l6YqT/hU9w3Sx8S/2gdka
	/WMi9aFYMYgZo8bAT9rexMryQ8Nut/k1mKTYFn7T+S93Z3kn8JHQI4EbpCtUEvy9
	AJQ8sg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjbx9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:55:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53E8tZxZ017583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:55:35 GMT
Received: from [10.218.11.38] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Apr
 2025 01:55:29 -0700
Message-ID: <b84f765d-4dfc-4182-8d82-365b3e04f973@quicinc.com>
Date: Mon, 14 Apr 2025 14:25:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] serial: qcom-geni: move resource control logic to
 separate functions
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
 <20250410174010.31588-7-quic_ptalari@quicinc.com>
 <df025c47-8de8-4f95-a8fa-8d5d5dce5d5f@kernel.org>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <df025c47-8de8-4f95-a8fa-8d5d5dce5d5f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y0GaeJLzjIGWNyUbKjJt5ivLRf-LwLru
X-Proofpoint-ORIG-GUID: Y0GaeJLzjIGWNyUbKjJt5ivLRf-LwLru
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fccd94 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=fsFalsCVRGTP_wyuaD0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140064

Hi

On 4/14/2025 1:29 PM, Jiri Slaby wrote:
> On 10. 04. 25, 19:40, Praveen Talari wrote:
>> Supports use in PM system/runtime frameworks, helping to
>> distinguish new resource control mechanisms and facilitate
>> future modifications within the new API.
>>
>> The code that handles the actual enable or disable of resources
>> like clock and ICC paths to a separate function
>> (geni_serial_resources_on() and geni_serial_resources_off()) which
>> enhances code readability.
>>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 53 +++++++++++++++++++++------
>>   1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c 
>> b/drivers/tty/serial/qcom_geni_serial.c
>> index 889ce8961e0a..e341f5090ecc 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1572,6 +1572,42 @@ static struct uart_driver 
>> qcom_geni_uart_driver = {
>>       .nr =  GENI_UART_PORTS,
>>   };
>>   +static int geni_serial_resources_off(struct uart_port *uport)
>> +{
>> +    struct qcom_geni_serial_port *port = to_dev_port(uport);
>> +    int ret;
>> +
>> +    dev_pm_opp_set_rate(uport->dev, 0);
>> +    ret = geni_se_resources_off(&port->se);
>> +    if (ret)
>> +        return ret;
>> +
>> +    geni_icc_disable(&port->se);
>> +
>> +    return ret;
>
> This is a bit confusing (needs context). return 0 directly.
here "ret" is also pointing to 0. Why can't we use "ret" directly 
instead of 0.
>
>> +}
>> +
>> +static int geni_serial_resources_on(struct uart_port *uport)
>> +{
>> +    struct qcom_geni_serial_port *port = to_dev_port(uport);
>> +    int ret;
>> +
>> +    ret = geni_icc_enable(&port->se);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = geni_se_resources_on(&port->se);
>> +    if (ret) {
>> +        geni_icc_disable(&port->se);
>> +        return ret;
>> +    }
>> +
>> +    if (port->clk_rate)
>> +        dev_pm_opp_set_rate(uport->dev, port->clk_rate);
>> +
>> +    return ret;
>
> Same here.
>
> thanks,


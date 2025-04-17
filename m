Return-Path: <linux-pm+bounces-25598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE1A91432
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 08:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0E7AD350
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A52066D4;
	Thu, 17 Apr 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="alHWxbM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439C2040B0;
	Thu, 17 Apr 2025 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871960; cv=none; b=UhWfeSy+To87vVaGAdwKSWGZOLncZvdyLa99AXX+jsfsnHS/CU6gWprBopi+anorYzHJxbzZTNhntMKPO7Ep36CQrRwohKYWpl0ThW1pPlQNNVzGuA2WUYvC5B6ypDb1RCXsf2V2UmiQ3L7oCwecSrqMARYVlXfWsm5eTon+Pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871960; c=relaxed/simple;
	bh=WKyAGawzprVwrTkfFvckDEJqm6+VK+OPjXyaZOlYxxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D99TAZqWLlcv5x1Ica87/JpfsIqVFjFNSLgOj2KOwWuGc/c6tSGb98w8f9RuWa6Q1vZUrR5ebYUbI7hFc2jkWsLowddpSoOtyJhtg7ip87aD9YirPg2M0JuyjxfpKeAgB4viL9LgbbZGO8T9JsJVmzCmWBu6jsnx42A9GbQHG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=alHWxbM0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5laLo031368;
	Thu, 17 Apr 2025 06:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lPuo4akm7drMI1PBgwsJ69tuzpSeETP77j5Q17EJVJM=; b=alHWxbM0RFNNlBWi
	SSVByXzfNYXhvcwnJXwnX/e9GzAp58JEuXzV6AnWrnNEWRJXgPuhe9juwa/VCYLs
	hmENAUyUUAob/jK2Z8j2uVd4gGs34zGDwtxgGPn2hStl46P16zRrhFMv0EfADbl4
	lf/YhjHpL5uS73w4IgK8YfzeIPng/kIFta4dGPbtpSwdAlOT3sbB55aIq9ZhMKj8
	umBeX2qxooDtwNeugOk4Jus0niF6Oa8YMLqNGq7zGGR99/h45z2Je+P76IGtc6J1
	+dKBfnFsfeuOxQ+vOUwZpt7StmKUzg3/Xh+2RXfYI5/Nwr7Pe7S7tIEWCeP01RvG
	zek0DA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69wwsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 06:39:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53H6dCF8020507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 06:39:12 GMT
Received: from [10.216.50.229] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Apr
 2025 23:39:07 -0700
Message-ID: <b592a51d-41f3-4a2b-a9f3-0f45c9bef967@quicinc.com>
Date: Thu, 17 Apr 2025 12:09:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs8300: Add cpufreq scaling node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20250313-qcs8300-cpufreq-scaling-v1-0-d4cd3bd9c018@quicinc.com>
 <20250313-qcs8300-cpufreq-scaling-v1-2-d4cd3bd9c018@quicinc.com>
 <ce00f7e3-86a1-4fdd-9274-c1a9896c0f12@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <ce00f7e3-86a1-4fdd-9274-c1a9896c0f12@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xSGqB3RW_Cg5UkcZbFxVwPCWDuayVC8M
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6800a211 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=_WaFmQAp6mqnBGjcp68A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xSGqB3RW_Cg5UkcZbFxVwPCWDuayVC8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=820 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170050



On 4/14/2025 4:36 PM, Konrad Dybcio wrote:
> On 3/13/25 7:03 AM, Imran Shaik wrote:
>> Add cpufreq-hw node to support cpufreq scaling on QCS8300.
>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
> 
> [...]
> 
>> +		cpufreq_hw: cpufreq@18591000 {
>> +			compatible = "qcom,qcs8300-cpufreq-epss", "qcom,cpufreq-epss";
>> +			reg = <0x0 0x18591000 0x0 0x1000>,
>> +			      <0x0 0x18594000 0x0 0x1000>,
>> +			      <0x0 0x18593000 0x0 0x1000>;
>> +			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
> 
> Please turn these into vertical lists> +
>> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
> 
> Since these labels don't match the hardware anyway, please sort them by address
> 

Sure, I will take care of the above comments and post another series.

Thanks,
Imran
> Konrad
> 
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>> +			clock-names = "xo", "alternate";
>> +
>> +			#freq-domain-cells = <1>;
>> +		};
>> +
>>  		remoteproc_gpdsp: remoteproc@20c00000 {
>>  			compatible = "qcom,qcs8300-gpdsp-pas", "qcom,sa8775p-gpdsp0-pas";
>>  			reg = <0x0 0x20c00000 0x0 0x10000>;
>>



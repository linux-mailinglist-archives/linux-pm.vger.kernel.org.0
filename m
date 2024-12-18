Return-Path: <linux-pm+bounces-19422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3CD9F64B8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 12:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B331895E00
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5F19D891;
	Wed, 18 Dec 2024 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pHzE7pOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B419D087;
	Wed, 18 Dec 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520701; cv=none; b=crPxq5eawAr77yjjtMezm8sgoB55LF7KC1uOjZXQUbNodl19FVGiQsAqi/ZWDLg4X4YAf2Mz1PWcxncgro8yt3Az1E1SB5qaeW/f0ALgyalVd540GNxg0TxqR5/8YaDzhGAyrd0jps6hdATHu1XSndLmqfyw5p5GWrc6W1JMQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520701; c=relaxed/simple;
	bh=fzylP+UlZpDZiDs2SvsiqDCcLMktHtqx8TW6QDoRUfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oL8H4o0o2eA2X2TpziXcCHMzLnC4XCZajei+lTmLaGyS+Dt1TtxoD1XQrSH6YMlxJNDjHP7ey5+i0zDLDt4Tb45wqSyx8rcCV9fV1O96azLIbIDzTkp9WHnKMngfPiMtjSm1NNa5PGzp+FRBoGWm1KXkDnzDPzK1fqOQm9qGUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pHzE7pOO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8VaLR014465;
	Wed, 18 Dec 2024 11:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0TUcUSFHC1vl4Ueog59MR53oLOoiM2X9GrjcLqTQzR0=; b=pHzE7pOOj78KUbaw
	sBrUwORCsiTn+j2SvjpRVO//e2d5hchkNWZz+Stfk+zy5uCS2lb8RUwcesaJYium
	JuiZoXBMVfsi8U0L2L4TUtb7wUANjBuULfcceurnBUnp/ewQFWf54W4+vpCrit7S
	kWUoUgw5OknAybmoCKzbtG8ZaBX7P6pNHEp7nY7ThB6J1cbDvjz2JQ09IeZecoJq
	BWN0hXHR3WNTSFONYeGXldavWADMKbstA5sdBSkO3UQSpg9ieg2EEuq7lWuVKWYL
	/8yUqdL6AtWAcojOd6ucyluTq9OaLJcfmUMNsJPj2/Yt8A/S3AuqocKmOW0TOLjW
	Z0fmbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kty6re5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:18:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIBI82Y005979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:18:08 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Dec
 2024 03:17:58 -0800
Message-ID: <b0fb1528-d542-4436-9761-cb5b5bb84df3@quicinc.com>
Date: Wed, 18 Dec 2024 16:47:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] arm64: dts: qcom: ipq5424: Add tsens node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        <srinivas.kandagatla@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
 <20241125050728.3699241-7-quic_mmanikan@quicinc.com>
 <f3fd235d-7306-44bb-8b7f-7eeb63f34481@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <f3fd235d-7306-44bb-8b7f-7eeb63f34481@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j3Ued5pBJPye8wU0WVAYJgzgp_WRcmbs
X-Proofpoint-GUID: j3Ued5pBJPye8wU0WVAYJgzgp_WRcmbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=733 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180091



On 12/13/2024 6:30 PM, Konrad Dybcio wrote:
> On 25.11.2024 6:07 AM, Manikanta Mylavarapu wrote:
>> IPQ5424 has tsens v2.3.3 peripheral. This patch adds the tsens
>> node with nvmem cells for calibration data.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
> 
> [...]
> 
>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,ipq5424-tsens";
>> +			reg = <0 0x004a9000 0 0x1000>,
>> +			      <0 0x004a8000 0 0x1000>;
>> +			nvmem-cells = <&tsens_mode>,
>> +				      <&tsens_base0>,
>> +				      <&tsens_base1>,
>> +				      <&tsens_sens9_off>,
>> +				      <&tsens_sens10_off>,
>> +				      <&tsens_sens11_off>,
>> +				      <&tsens_sens12_off>,
>> +				      <&tsens_sens13_off>,
>> +				      <&tsens_sens14_off>,
>> +				      <&tsens_sens15_off>;
>> +			nvmem-cell-names = "mode",
>> +					   "base0",
>> +					   "base1",
>> +					   "tsens_sens9_off",
>> +					   "tsens_sens10_off",
>> +					   "tsens_sens11_off",
>> +					   "tsens_sens12_off",
>> +					   "tsens_sens13_off",
>> +					   "tsens_sens14_off",
>> +					   "tsens_sens15_off";
>> +			interrupts = <GIC_SPI 105 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "combined";
>> +			#qcom,sensors = <7>;
>> +			#thermal-sensor-cells = <1>;
>> +		};
> 
> Please move interrupts properties above nvmem
> 

Sure, i will update in the next version.

Thanks & Regards,
Manikanta.

> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad



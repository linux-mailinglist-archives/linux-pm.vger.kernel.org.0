Return-Path: <linux-pm+bounces-19421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B69F648E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798241892AC3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A819E97B;
	Wed, 18 Dec 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iuN25KoO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF919D07B;
	Wed, 18 Dec 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520537; cv=none; b=Yn0Gw25Mk9N73+XUGb6PF8R0GzY6FjxPu8lxVqOBBt61GP0m4MTD6iB8860cHL1mCrTy5Y707EcjtSUs8u8/URRDS7NYdcF9tmPeDKebMHz8PbFIae+Sljsrw7qujrHWZxKjMfstUvxTxMjpkLJBGW1e/EhipKlpbNTD4WxS8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520537; c=relaxed/simple;
	bh=inctAiqk9Y9aXPwPxEb2n0GmKc7SIVdc2U5HmGGED98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U4XT4rvtwXXsQTu6g1wQ/nnhuVaTpWfnrj/PbJD1Ub2itoxU4/1AOsWN8HSaXMzWDYmVQ5QS5vgIjFlZmXPgkIUbBKWcJVWZFfUXIWnouiE6VnZrcK5GhvabpPXoUimOHWKjimJIMNDDeJ0rKSkVh2NUGTJL8ifX8qandmTL5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iuN25KoO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI6VXL8024603;
	Wed, 18 Dec 2024 11:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DtDXbLrwZmGApG6b1RUBCdgE7duW8uEJPL4iYKXLNDw=; b=iuN25KoODTIomfsb
	KCdQxdelnecN+Wyje3tTTztKQvFg1Ps6NofDm2SGWm6HTQ297W7kE7am4eh25a27
	/Mc9NL12f7DpMNxgXJsI7wAUDTWYCo87df2lRE8KD0qD/vuAST+yixBCA2HX1A+6
	Fky4cO3ABP85EXPOw3zWgQsG8+EvQ+q0khcJZStxtVAfcF9ar9L0HwqRh7e6tLI1
	lrLD3M2f1KwUChDJdmKgUJd+djalZtLnKRKW3LJV8s6Tf9gilTAQMNnkvaEucmko
	6nI1ve/rKlrrB7QkdjGLASk33VfxpyxAyULpODji/W4DHA12gvGLmGSBpyvupB4r
	Y8Rsjg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ks6ygpgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:15:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIBFQ4M019687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:15:26 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Dec
 2024 03:15:21 -0800
Message-ID: <f6527df3-feb9-4d3b-93d7-84f4f255d23c@quicinc.com>
Date: Wed, 18 Dec 2024 16:45:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] arm64: dts: qcom: ipq5332: Add tsens node
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
 <20241125050728.3699241-5-quic_mmanikan@quicinc.com>
 <556ff23c-8b2c-4ea3-99dc-84196e3f0651@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <556ff23c-8b2c-4ea3-99dc-84196e3f0651@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 60ueWvLQ1Wb5YcztH2AhwK-lExXkdW36
X-Proofpoint-GUID: 60ueWvLQ1Wb5YcztH2AhwK-lExXkdW36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=897 mlxscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180090



On 12/13/2024 6:29 PM, Konrad Dybcio wrote:
> On 25.11.2024 6:07 AM, Manikanta Mylavarapu wrote:
>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>
>> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsens
>> node with nvmem cells for calibration data.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
> 
> [...]
> 
>>  
>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,ipq5332-tsens";
>> +			reg = <0x004a9000 0x1000>,
>> +			      <0x004a8000 0x1000>;
>> +			nvmem-cells = <&tsens_mode>,
>> +				      <&tsens_base0>,
>> +				      <&tsens_base1>,
>> +				      <&tsens_sens11_off>,
>> +				      <&tsens_sens12_off>,
>> +				      <&tsens_sens13_off>,
>> +				      <&tsens_sens14_off>,
>> +				      <&tsens_sens15_off>;
>> +			nvmem-cell-names = "mode",
>> +					   "base0",
>> +					   "base1",
>> +					   "tsens_sens11_off",
>> +					   "tsens_sens12_off",
>> +					   "tsens_sens13_off",
>> +					   "tsens_sens14_off",
>> +					   "tsens_sens15_off";
>> +			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "combined";
> 
> Please move interrupts properties above nvmem
> 

Sure, i will move in next version.

Thanks & Regards,
Manikanta.

> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad



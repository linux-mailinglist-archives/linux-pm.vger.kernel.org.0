Return-Path: <linux-pm+bounces-23456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C3A4F1DF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 00:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9E188D000
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 23:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C72780F3;
	Tue,  4 Mar 2025 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IVVExXtr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F366277021;
	Tue,  4 Mar 2025 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132699; cv=none; b=Vs5DqumiemkVyQkjZw0IqrKwW73lp+vQSnmGmkr1rfv5db0vcc3LPM5R/Zj3oDNEz+Mf8NgxYtrvPeE73CcjGQbKtV72uLjKzL+lw/Fpe/rtgftS26kdnQj97UR+fES21KJLvPivc5Xnb6H7wO7aDND1K8sJZxrIuwcN49M5K+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132699; c=relaxed/simple;
	bh=NElNSuBMxgzeC8rTu/edZDnWeRf0KAL4VeHwtLzomRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fXRoJRaSKBzDZEmwi5zpEBkOdpWk8z1Br25NP//DTQ8ZDM/N21Wqe6E8zhIh29Sjhvh/uS09u24Em7cXkHVI4A06JQg/YO8RnxtpfdCRC0ld2EaA/j8wOhV4rqwBtG5W3LIq8S3wu1XSq8V97Qp8QNdnyIK9u9nPljMj6JdIiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IVVExXtr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NAHVM031827;
	Tue, 4 Mar 2025 23:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	So9hw38GyjjRtkgUGbm08Srs6SjHk0risyVY6nRFrG4=; b=IVVExXtr/tBBAmvp
	lDTvpGBXXCTjDvDuhOxRyDypyoSboJzQs28hh6elrPToK8xuiB0c3+bo3ddRD6VB
	PLkRcD6t0klmjT8+OB2DmDuOggMnervrp2KLlXaHYcYZUoHkojbi5LcIo5Vydjpa
	ptCTtFvfxtaUg0VC54vPjNYnP9HRrsSil9AH/h7X4iw4p9n1ELtD0l82ndX3Ne6a
	2hYgyCXDHSdC9qSw8fZS44Vt7q/FMosM15Y6wBkPdbnOBb7UM9tFgGVbvMORp74T
	muM2eal7Upkcu/zHJcrcinn2zmtcuotZk0Rg0Acdhyf2gPzo6iUz/fevdaJsA8Jz
	eUQa5A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t3hv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 23:58:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524NwBB7016230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 23:58:11 GMT
Received: from [10.71.108.112] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Mar 2025
 15:58:11 -0800
Message-ID: <454b1755-241d-4b68-b62f-4150e78d393a@quicinc.com>
Date: Tue, 4 Mar 2025 15:58:10 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Add BWMONs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Stephan Gerhold
	<stephan.gerhold@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Satya
 Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com>
 <20250113-sm8750_bwmon_master-v1-2-f082da3a3308@quicinc.com>
 <Z4k8T31cw_CxHFLC@linaro.org>
 <a02922b6-7b48-4305-8cf3-8019cbe9a069@oss.qualcomm.com>
Content-Language: en-US
From: Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <a02922b6-7b48-4305-8cf3-8019cbe9a069@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KXX36bico5VNvAaKhC7ESsAttKumilkB
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c79394 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=tmWJlMiWa1-9U-Hj8hsA:9 a=QEXdDO2ut3YA:10
 a=flcwpJxnCEoFzraN3UnM:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KXX36bico5VNvAaKhC7ESsAttKumilkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040191



On 2/7/2025 5:48 PM, Konrad Dybcio wrote:
> On 16.01.2025 6:05 PM, Stephan Gerhold wrote:
>> On Mon, Jan 13, 2025 at 01:08:18PM -0800, Melody Olvera wrote:
>>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>>
>>> Add the CPU BWMONs for SM8750 SoCs.
>>>
>>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 74 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..09fe3149da1926b74a98280fe209ae7f423db864 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>> @@ -2802,6 +2802,80 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
>>>   			};
>>>   		};
>>>   
>>> +		/* cluster0 */
>>> +		pmu@240b3400 {
>>> +			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
>>> +			reg = <0x0 0x240b3400 0x0 0x600>;
>>> +
>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>> The start of the interconnect path is QCOM_ICC_TAG_ACTIVE_ONLY, but the
>> destination is QCOM_ICC_TAG_ALWAYS? This is strange. Interconnect used
>> by the CPU should be QCOM_ICC_TAG_ACTIVE_ONLY.
> I'm not sure if this is a question, but I second, both should be ACTIVE_ONLY

Apologies for not getting back to this for a while, but I spoke w some 
folks and y'all are right. Will correct.

Thanks,
Melody


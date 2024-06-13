Return-Path: <linux-pm+bounces-9092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A169078B0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50530283A82
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9E1149C6F;
	Thu, 13 Jun 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5WwR13l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782471494AB;
	Thu, 13 Jun 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297440; cv=none; b=sRlLFij94Hm0UphuA4Mxdo1SaI3lhVrqOReV+GZL0eifJVpi7j02OJSzOBJd1DDeHkYxtVuaJb9q2x+7mpJcxDYP2YPy1IPsVwwSAJQBBS6hTCVJ0D3XVpAveTnnZgx+KHf2QHmr4+uyBrDP3jYYOwptIkU5cxv2t7iuqMgVqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297440; c=relaxed/simple;
	bh=OWtiegNLK1Tcqw0BVyyMHArsxQwjKbd6/uACxviGS+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kT40InA/83pPkpdxgZb3S14ttB8okDnX/iPodBfJ9vJKctgTvBe3BlUMnOV6fXLCEm/NnXmgbdHvWKlmwXUQm6d3ioEScrX3kBSDLEUMgSYYf2LluhpwcIr/gnS0vz3i8tE26paRG1+NlRW6Fi1STNb70safj/fZsiCa3KOiB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5WwR13l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D95r6o017200;
	Thu, 13 Jun 2024 16:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9DnqzopY74lghgpM22DtSryF8GbwjQyuBW6cMza16Y=; b=g5WwR13laAOquxj2
	8Fs8UnmLwQ3sLWApOXSFAYPDkPosirTQrFBOGPLR0tET4/UZEqKZKTp4zjSIORbW
	gjVHa3DJ4P0mUjTggr25yM2+JepUaG8Yod3NdjyGgTridxUnOwznJSwVe5WyI7SD
	8FsZq82K0augKHdlYXyz32PR8pJzl+zFYp6GspnC/U5GWq/yNlFyaxxJDud4G8ee
	0KyrAVVX3WProyZAkDlnYAo9w+GC2S86oRl/7/rL8rISWnMrjLhw4Fy4/8nT2N/7
	LgbJc7SUJWb9MU/++aCz+3y7PgF0GsHZv8lNBD0I5ErVEcM7nxwpZF43qxv8xQoo
	/TTZWw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqe93keaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:50:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DGoMrZ022261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:50:22 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 09:50:10 -0700
Message-ID: <9d7623fb-be0f-4adf-e9e0-17ac2f7ebaba@quicinc.com>
Date: Thu, 13 Jun 2024 22:20:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: x1e80100: Add fastrpc nodes
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-5-quic_sibis@quicinc.com>
 <wnvet65zg3s6lqnnn5xd4zzx4jwdclbfh3ywy4ut3cal2wmoto@3z3burliivyo>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <wnvet65zg3s6lqnnn5xd4zzx4jwdclbfh3ywy4ut3cal2wmoto@3z3burliivyo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ysEjr7Gpb6cLantCW7rL3RLsNiC2SstU
X-Proofpoint-ORIG-GUID: ysEjr7Gpb6cLantCW7rL3RLsNiC2SstU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=794
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130121



On 6/6/24 08:15, Bjorn Andersson wrote:
> On Tue, Jun 04, 2024 at 06:41:57AM GMT, Sibi Sankar wrote:
>> Add fastrpc nodes for ADSP and CDSP on X1E80100 SoC.
>>
> 
> This looks pretty unrelated to bwmon, could it not have been sent alone?

lol, I figured that the rest of the series was in decent shape to
land. Let me resend this one out standalone.

-Sibi

> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 156 +++++++++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index d86c4d3be126..4edabe0ff592 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -5567,6 +5567,55 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>>   				label = "lpass";
>>   				qcom,remote-pid = <2>;
>>   
>> +				fastrpc {
>> +					compatible = "qcom,fastrpc";
>> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
>> +					label = "adsp";
>> +					qcom,non-secure-domain;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					compute-cb@3 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <3>;
>> +						iommus = <&apps_smmu 0x1003 0x80>,
>> +							 <&apps_smmu 0x1063 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@4 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <4>;
>> +						iommus = <&apps_smmu 0x1004 0x80>,
>> +							 <&apps_smmu 0x1064 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@5 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <5>;
>> +						iommus = <&apps_smmu 0x1005 0x80>,
>> +							 <&apps_smmu 0x1065 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@6 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <6>;
>> +						iommus = <&apps_smmu 0x1006 0x80>,
>> +							 <&apps_smmu 0x1066 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@7 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <7>;
>> +						iommus = <&apps_smmu 0x1007 0x80>,
>> +							 <&apps_smmu 0x1067 0x0>;
>> +						dma-coherent;
>> +					};
>> +				};
>> +
>>   				gpr {
>>   					compatible = "qcom,gpr";
>>   					qcom,glink-channels = "adsp_apps";
>> @@ -5656,6 +5705,113 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>>   
>>   				label = "cdsp";
>>   				qcom,remote-pid = <5>;
>> +
>> +				fastrpc {
>> +					compatible = "qcom,fastrpc";
>> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
>> +					label = "cdsp";
>> +					qcom,non-secure-domain;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					compute-cb@1 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <1>;
>> +						iommus = <&apps_smmu 0x0c01 0x20>,
>> +							 <&apps_smmu 0x0c21 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@2 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <2>;
>> +						iommus = <&apps_smmu 0x0c02 0x20>,
>> +							 <&apps_smmu 0x0c22 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@3 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <3>;
>> +						iommus = <&apps_smmu 0x0c03 0x20>,
>> +							 <&apps_smmu 0x0c23 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@4 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <4>;
>> +						iommus = <&apps_smmu 0x0c04 0x20>,
>> +							 <&apps_smmu 0x0c24 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@5 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <5>;
>> +						iommus = <&apps_smmu 0x0c05 0x20>,
>> +							 <&apps_smmu 0x0c25 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@6 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <6>;
>> +						iommus = <&apps_smmu 0x0c06 0x20>,
>> +							 <&apps_smmu 0x0c26 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@7 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <7>;
>> +						iommus = <&apps_smmu 0x0c07 0x20>,
>> +							 <&apps_smmu 0x0c27 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@8 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <8>;
>> +						iommus = <&apps_smmu 0x0c08 0x20>,
>> +							 <&apps_smmu 0x0c28 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					/* note: compute-cb@9 is secure */
>> +
>> +					compute-cb@10 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <10>;
>> +						iommus = <&apps_smmu 0x0c0c 0x20>,
>> +							 <&apps_smmu 0x0c2c 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@11 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <11>;
>> +						iommus = <&apps_smmu 0x0c0d 0x20>,
>> +							 <&apps_smmu 0x0c2d 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@12 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <12>;
>> +						iommus = <&apps_smmu 0x0c0e 0x20>,
>> +							 <&apps_smmu 0x0c2e 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@13 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <13>;
>> +						iommus = <&apps_smmu 0x0c0f 0x20>,
>> +							 <&apps_smmu 0x0c2f 0x20>;
>> +						dma-coherent;
>> +					};
>> +				};
>>   			};
>>   		};
>>   	};
>> -- 
>> 2.34.1
>>
> 


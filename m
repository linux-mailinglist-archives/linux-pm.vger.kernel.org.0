Return-Path: <linux-pm+bounces-9093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC09078C1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BB71F23783
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A879149C4E;
	Thu, 13 Jun 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mWqAEkvd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8104149C4D;
	Thu, 13 Jun 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297531; cv=none; b=XEHAmIw7sVyvHqHqe25/kdvfCcTbwLhSUNkHh0TZzWfLMGi4wQ0FN0SuC5XpdCBZzD8h0MbDG/7JaKZgekt/sBeuAiMv9VlcVMHYZU+mpDFAdSl2ufB9V9LMC29fIwoB6QCTQ/tMO3ItPhg2me978T5X8kIjp4f2eFPChYfVXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297531; c=relaxed/simple;
	bh=3szXYqumfIH8sAhIjGmW4LtFVp0L+ts8Zdxj0HtKBmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SirAHP0nyvMWN9CUCb5L6VO2xWSrqQk5Qyt5Sx26P5a15puBCJURsxrzNSmonCuk2bE1fjkQOEcK4Yg57fPzha/vjogOA4xoXgH5kN23MTU6CyagD+rpRbOcyA93ebcL7cb70IN+V/S73OuEf4Soy9h63u+hS/4mSRkKQR6paTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mWqAEkvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D8pqPV017289;
	Thu, 13 Jun 2024 16:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kxEJzwYk7wS8Rif0r0yLXavFu9aRsVgwexXYqoAERWc=; b=mWqAEkvdTH8iSvx8
	d3gwsWXJ7VGWZtbbD1K/O/wFEbBzaHGQqJJTcPa+/ZzwS8x9lrEMi57e/dd0kDFM
	0GWK9q9vVdr8wTOkA49XPZy2RZvtxiRqVDjmzIKqSAVsFCrzgpbtRf0TuI/xnLxb
	QNHi6kxfb6hZJmNvqjIzACQNgf2i2YHQYybB1gdpNCvTfQeFb0+Pcgd7JmPS4kdt
	NK3DcB6fu8rie6jN7OOJFDr3z/mi33lrejduiGy5+ddFyavzaMJ9TpfrSO3z52u1
	emHV06vksxEtEASS0oL512Qq2lhv9J2SLvFer73dB2oPeqyvYZUMOGXiUKGoBuMT
	wldvtQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yptuy6ake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:52:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DGq5jR024869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:52:05 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 09:52:00 -0700
Message-ID: <f2d81804-f4a3-d813-cbb0-5c4ada6a3fda@quicinc.com>
Date: Thu, 13 Jun 2024 22:21:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add BWMONs
Content-Language: en-US
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-4-quic_sibis@quicinc.com>
 <b9ee77da-bd51-4d32-8f35-d38fe8b77f44@quicinc.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <b9ee77da-bd51-4d32-8f35-d38fe8b77f44@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -PCezlkoOj47IvxEGs_i8VcTY2wMql0n
X-Proofpoint-ORIG-GUID: -PCezlkoOj47IvxEGs_i8VcTY2wMql0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130121



On 6/6/24 14:39, Shivnandan Kumar wrote:
> 
> 
> On 6/4/2024 6:41 AM, Sibi Sankar wrote:
>> Add the CPU and LLCC BWMONs on X1E80100 SoCs.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Hey Shiv,
Thanks for taking time to review the series :)

>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 169 +++++++++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi 
>> b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 1929c34ae70a..d86c4d3be126 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -5329,6 +5329,175 @@ cpu_scp_lpri1: scp-sram-section@200 {
>>               };
>>           };
>> +        pmu@24091000 {
>> +            compatible = "qcom,x1e80100-llcc-bwmon", 
>> "qcom,sc7280-llcc-bwmon";
>> +            reg = <0 0x24091000 0 0x1000>;
>> +
>> +            interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +            interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt 
>> SLAVE_EBI1 3>;
>> +
>> +            operating-points-v2 = <&llcc_bwmon_opp_table>;
>> +
>> +            llcc_bwmon_opp_table: opp-table {
>> +                compatible = "operating-points-v2";
>> +
>> +                opp-0 {
> 
> Nitpick,In one table, we start from ‘opp-0,’ while in the other table, 
> it begins with ‘opp-1,it is better to make it consistent across table.
> 

Will fix it in the next re-spin.

-Sibi

>> +                    opp-peak-kBps = <800000>;
>>               reg = <0 0x25000000 0 0x200000>,
...
[snip]
...
> 
> 
> Thanks,
> Shivnandan


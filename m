Return-Path: <linux-pm+bounces-13653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD596CE3D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 06:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF20B1C223DA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FA4155392;
	Thu,  5 Sep 2024 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z9zWq9BC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1211494DB;
	Thu,  5 Sep 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725512225; cv=none; b=CFVuhTdFWb8F4Guqyr59vOn41hF/MuNkx38wIoyg6fx3W5CIDgCV5jxyMp810m9XxZMbURXw0VLu/DW6fI6aWlZxXcY+Qd6edKfn7KHXorStwkSUfoaf3vlZ5G2oWt24/sKdhFcfuijzTcTMF047dgbI26gbpLxqnaOgO532/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725512225; c=relaxed/simple;
	bh=jfqZ4v57X1c9BWCxzq3aePc2Qe5N7iUbzE7Oyhqe4qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ca4kOjPFpt3RqxgHLU4uv44ZgIRPZCoJrJTLhBZsgRveTomoAHuahwwAhS4A37Dry6QYaXSEDl0hFKRb4ZBH23YQqBM0sFm6UdmwrtxA5IeBP870XJonfBORGo1SKtv9HiEziPpMy/0T+l0JZfAoiv8ZD0Ctz+fb+dFNxLqtjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z9zWq9BC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4852EqE1015388;
	Thu, 5 Sep 2024 04:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mOI+1G/E3cTVM/8GPl8IKCuvmh9k+a4Z5APBAsAGRrk=; b=Z9zWq9BC9+bKwiEQ
	f5YfXTEtCRKFCdyYq6lrAL2NBo0Nk2vb2+gCm2moiKTolLnFJRB37yH00umOPlyR
	FeGNpkfzhk7V8WC/PiFN09nSrS0qvOz9FhQj1BDzsfAVT9pUU5bALLv1x+K0+qvA
	hRVTtS0IzTsaVHtlg5x5orUuphEyUsdZP/rp9H7igErJtYki3LYkLCrDvaVFnZpd
	92ct+kvTwt/io2FDS3Koe7/XwrmREeq8HVcRcEF9peYLsOXtDqlrL4WibJUW2KNt
	BiB9qMhLWSOixoscDZJP2jH12N1kGR6C4glKSWrVVVCqYA9JJ+s6dMr6EX777wlD
	ScOyxg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dt69exqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:56:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4854utwO007152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 04:56:55 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 21:56:51 -0700
Message-ID: <0c7790b8-fcfc-43cc-a2af-5096522b1dec@quicinc.com>
Date: Thu, 5 Sep 2024 12:56:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] arm64: dts: qcom: add initial support for QCS8300
 DTSI
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Zhenhua
 Huang" <quic_zhenhuah@quicinc.com>,
        Xin Liu <quic_liuxin@quicinc.com>,
        "Kyle
 Deng" <quic_chunkaid@quicinc.com>,
        Tingguo Cheng <quic_tingguoc@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-18-d0ea9afdc007@quicinc.com>
 <be8b573c-db4e-4eec-a9a6-3cd83d04156d@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <be8b573c-db4e-4eec-a9a6-3cd83d04156d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4xHw51o4RZeAhvOIFvs4YUVISUWlqqPZ
X-Proofpoint-ORIG-GUID: 4xHw51o4RZeAhvOIFvs4YUVISUWlqqPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050034



On 9/4/2024 5:41 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 10:33, Jingyi Wang wrote:
>> Add initial DTSI for QCS8300 SoC.
>>
>> This revision brings support for:
>> - CPUs with cpu idle
>> - interrupt-controller with PDC wakeup support
>> - gcc
>> - TLMM
>> - interconnect
>> - qup with uart
>> - smmu
>> - pmic
>> - ufs
>> - ipcc
>> - sram
>> - remoteprocs including ADSP,CDSP and GPDSP
>>
>> [Zhenhua: added the smmu node]
>> Co-developed-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> [Xin: added ufs/adsp/gpdsp nodes]
>> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
>> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
>> [Kyle: added the aoss_qmp node]
>> Co-developed-by: Kyle Deng <quic_chunkaid@quicinc.com>
>> Signed-off-by: Kyle Deng <quic_chunkaid@quicinc.com>
>> [Tingguo: added the pmic nodes]
>> Co-developed-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
>> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
>> [Raviteja: added interconnect nodes]
>> Co-developed-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 1282 +++++++++++++++++++++++++++++++++
>>  1 file changed, 1282 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>> new file mode 100644
>> index 000000000000..244fa8bf97d9
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>> @@ -0,0 +1,1282 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/clock/qcom,qcs8300-gcc.h>
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/interconnect/qcom,icc.h>
>> +#include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	clocks {
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32000>;
> 
> Are you sure that sleep clock is physically part of the SoC?
> 
Have checked that and will move it to board.dts
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
> 
> ...
> 
>> +
>> +	soc: soc@0 {
>> +		compatible = "simple-bus";
>> +
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0 0 0 0 0x10 0>;
> 
> ranges follow compatible, so it is the second property.
> 
> 
Well noted, thanks for review.
> 
> Best regards,
> Krzysztof
> 
Thanks,
Jingyi



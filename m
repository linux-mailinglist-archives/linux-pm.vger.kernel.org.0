Return-Path: <linux-pm+bounces-17317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B79C3D9E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 12:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789C71F23B59
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F0176FA2;
	Mon, 11 Nov 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U3NbSHt4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C50139578;
	Mon, 11 Nov 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325391; cv=none; b=GeHE2fCjXoeMrBtqHhAk3LhN9MF/5mUZnhh62GBT6hYXwIZZj0NPh9nFx/GSN0jMRURSyqT88JqpD5QaaJAsflCoxxr33bMdSi8CPZ81VxUsPZ1VgDbu3I9BzdPLv0WCdI1ru7xZmRDJsXjG2DN5F29kisSrv/Eex1vmh8hPs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325391; c=relaxed/simple;
	bh=ljvC2kSt0UzwNCZYGIqJcQ4jT1G4WFSNjK9yLyBmSJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hzN909lN1YtG6gimRIjmdhtKwNE9mAm5kFd6l/deRMXqgMljFgjPbPCPrH8jEHKt/gT77z4xaMeYtWYBzACjjW2GMH4pMwcNWRWDdWcgKcqztPYQz88/hSDC5LSOi7TXbhibJ6xG0a/mGPFuDpBEQsBll04OyZOBCuj+2A7xViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U3NbSHt4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AALxLRH028205;
	Mon, 11 Nov 2024 11:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+DDIk7Lk2w68YCbx4DDXFvWC08q9N97okqJUTGNc3vw=; b=U3NbSHt4nNJ0ouAx
	wS0WlO4KVGYpr+5qLmsQefsXCkb7zSGAgG8gnnFJRW1DTgJbeomR/LRSJheq+/Nx
	fZySLs1kuINKKbWh9ljZG7/6RVRbpPt+ubinzHa4thg8JohPakl9HzgKGY6RkLgS
	ByrP1tApZxzZOiRcOm1PNcymBmBCDKnmzW7nxHIITMtphfQWbw5hBscoBn5P+swb
	J0WYnSNYwxs8YZuHg/GRcWVtvm9Rvdj62xkoLcq9MyqGdBBaCXUduHQROWAo8Sxa
	7V/SPijlqPdvGzrmDiSQnki9fDP2LaszaKTXE5OlSJyuKKsQ1eZ0e16I62X5Z8a9
	kf+vlQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0wjuxht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 11:43:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABBh1xp001617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 11:43:01 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 11 Nov
 2024 03:42:54 -0800
Message-ID: <379add10-7b4d-49f2-9bdf-6374f4dd5f16@quicinc.com>
Date: Mon, 11 Nov 2024 17:12:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] arm64: dts: qcom: ipq5332: Add tsens node
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
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-5-quic_mmanikan@quicinc.com>
 <69000e68-c1ef-4cdd-8fc0-2a04a6d38e02@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <69000e68-c1ef-4cdd-8fc0-2a04a6d38e02@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BrQUo0y8It_xsicTngNOoixZQ_tDUR1F
X-Proofpoint-ORIG-GUID: BrQUo0y8It_xsicTngNOoixZQ_tDUR1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110098



On 11/7/2024 8:20 PM, Konrad Dybcio wrote:
> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>
>> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
>> node with nvmem cells for calibration data.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V6:
>> 	- No change
>>
>>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index d3c3e215a15c..94dca05fdc2a 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -177,6 +177,46 @@ cpu_speed_bin: cpu-speed-bin@1d {
>>  				reg = <0x1d 0x2>;
>>  				bits = <7 2>;
>>  			};
>> +
>> +			s11: s11@3a5 {
> 
> You're adding 's11' etc. to the global label namespace. Please make
> the names more specific, like tsens_sens11_off
> 
> [...]
> 

Okay, sure. I will update.

>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,ipq5332-tsens";
>> +			reg = <0x4a9000 0x1000>,
>> +			      <0x4a8000 0x1000>;
> 
> Please pad the address part to 8 hex digits with leading zeroes.
> 

Leading zeros are already padded in V7 series.

Thanks & Regards,
Manikanta.


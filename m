Return-Path: <linux-pm+bounces-29915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF06AEF7E0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF69A3AAFF6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5D272E59;
	Tue,  1 Jul 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fp906hrx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A026C3A3;
	Tue,  1 Jul 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371733; cv=none; b=bFgVpX8BSm7lcXSgGJPlsaJlrhdxtnJNd4EayaXjIrS4LMemuxjVgouenvUTGvAjTA7LfYrwxoUXr6oF4bd2MwsvmN0DF3PlQFuXGeOM/Lb391Pcxew9z5B//ioloyNenZpPZhDCMl7MweMOssub7F4o/O69v0aDdHf+0kUcLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371733; c=relaxed/simple;
	bh=QhHQRHt4VQ81RUqeccFLG6YC8L9K3fNKHrFbwwLvNUo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=PB++V39Tz+SoXb1UHO+DtymuwK1Yh6F7a6Qtr5ZQkYsVfykc/7K6mOe4W9AxMZRZu7UwXgznV+TRkZe5VDa6qj1RS4kYRdbSFViRvuO3/089HElPjT+FjID2907hnu09nDK5rZNDJTp4+k6zqnjjHahCwGc5xgnZeOWVEF69IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fp906hrx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619oRdd008527;
	Tue, 1 Jul 2025 12:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	58l8T/OOo3ZCMXUklFmgtyHY1VmXpl5dXrfeRDP8j7I=; b=Fp906hrxou7mwLeS
	mFd4s6IwIsLo45JjzWTZM2mHs3IrhkyZvrhcfosqPMFcRYneTDE7rjj0Ccr8qJJq
	n3vfg/67iUgT5Uo1/ZeIYUm3OghrsIdOCZB9nDr/+zCt/VTYswacwbD741OWR7R+
	xNDd3adJdO+jc8Nl4VhB1WzAfbgasHeEKFGz3XzkqV6Ho5ZXBsKiyJOnFocLgtES
	bffCXegvlXBByKyym5l48OmgU2G6V9XzYjNgpCrW4To5WEQRLS5b/dnvHoG4BzBH
	fTiD+jVdHtCmoibI/nee5oHMm1LC/sJzzlF7Ft2cKd4TjlL/aXuv+Se1tL9RfCJ3
	eoryRA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kkfmwgdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 12:08:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561C8aNx012429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 12:08:36 GMT
Received: from [10.235.9.75] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Jul
 2025 05:08:29 -0700
Message-ID: <db1d07f4-f87d-403a-9ab3-bf8e5b9465b3@quicinc.com>
Date: Tue, 1 Jul 2025 20:08:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luo Jie <quic_luoj@quicinc.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov
	<djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao
	<quic_anusha@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-7-8d392f65102a@quicinc.com>
 <cd6f018d-5653-47d8-abd2-a13f780eb38f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cd6f018d-5653-47d8-abd2-a13f780eb38f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 53KUHXRXMg_U-w1wGFJp9ve0aqlWp6mS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3NSBTYWx0ZWRfXydNpWbOOQGf1
 Wv+siRXa/2cbh3Z8Eot4kcDX+2h6b7kX/JioCBVsghq5jUWr9KcDnW5swNqBn7tC/bCiizQf5ca
 vQAtClfnilZtupqGfVaV10qNUocag9nSM+OqIrsY+BnxqFZhMoxb2RK3ijlo4Af5WvOsNAlkNyk
 gx2Yqd++S5ol6Gk7G5vV0lt55rJJL6BBkVUQeGG6IselcbCmRlT2Y1VLZawJb78I1N+74wkBEEn
 EcbGm+PxV+fzTwHfyL54oq3owHMNU09Pnr7uYJTKm+NzA5nVSkpT/d+9Qkycd1j2GKkKIPgxVUB
 goqX4dVBlCVkYg4viZedXrBnozlZazfIbDBtrvtaUWbhlRU1R8tDm53kms2igQ8m2pz+vdUjLlx
 RlTAuD61CHme3I6B9dxnjgYmhOuW6Mmc2VEn12Z3kZ4quTdjED7pqLDovWrEL1M0uHNBwLl9
X-Authority-Analysis: v=2.4 cv=L9sdQ/T8 c=1 sm=1 tr=0 ts=6863cfc6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=8K8LTxnoByzQzqUqCa4A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 53KUHXRXMg_U-w1wGFJp9ve0aqlWp6mS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010075



On 6/28/2025 12:27 AM, Konrad Dybcio wrote:
> On 6/27/25 2:09 PM, Luo Jie wrote:
>> NSS clock controller provides the clocks and resets to the networking
>> hardware blocks on the IPQ5424, such as PPE (Packet Process Engine) and
>> UNIPHY (PCS) blocks.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5424.dtsi | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> index 2eea8a078595..eb4aa778269c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> @@ -730,6 +730,36 @@ frame@f42d000 {
>>   			};
>>   		};
>>   
>> +		clock-controller@39b00000 {
>> +			compatible = "qcom,ipq5424-nsscc";
>> +			reg = <0 0x39b00000 0 0x800>;
> 
> size = 0x100_000
> 
> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

I initially thought that a block size of 0x800 would be sufficient, as
it covers the maximum address range needed for the clock configurations.
However, the NSS clock controller block actually occupies an address
range of 0x80000. I will update this to 0x80000 in the next version.
Thank you for your feedback.



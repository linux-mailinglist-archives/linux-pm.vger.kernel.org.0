Return-Path: <linux-pm+bounces-23344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F5A4D326
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 06:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D8218933A5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F71F3D52;
	Tue,  4 Mar 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XWTy7dxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7F3D561;
	Tue,  4 Mar 2025 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067612; cv=none; b=YEEtoSBuiUpuvs6PB6FwguMHhUMtTrNW7G1gpSp4TfP1E0G2Z4YHAEIa0y9Q7cvumBq2tU1aVhNZ4E/O6NbZfCGJz3yCuodqfU/EcvzTDQab9iHPnIRDZ6xETvplC4HEAmLcrBLQ82THNTQ1dfbABYBNdnM8hQwhB9+8oWcfo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067612; c=relaxed/simple;
	bh=bQR5ObqMTP1GwQDLeSy5/aqOwHMuH+cQMoCYo7xZ2jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G13n9yFvGlxxBHrgepn+YVdUcHcwe6UhDPvR9GBh3emD0fIkTESvfyUcXM/WFZzzQyWjaL8aspbVVIRHJ0BGjgqM4yhQyRUzSIkQplv52qqSEnEhZTppV2c81oWjqA3y9TFjLenmIwxnbOHVHSYlmL43iz1mKpc0OK7dtk0TX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XWTy7dxe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NX9q8021675;
	Tue, 4 Mar 2025 05:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	97sqRophQCOYVvNdbg1Cr94sp2Vpw2syWk+rVmsMi5o=; b=XWTy7dxeB/Iz/D/1
	3K/ZHb0wVIhUos/cPxrYe0D0Yj3DF3oQFtluq7tH8lQpVt9woBKNmTC3+9r8vwgb
	FVMXbpHvYsH1oO09EcR9P+4ludqIb5Yu/nYOLePfr7QAWpJxCLyxeXOVvcVq6Yhf
	QaV19Pl0QhqEXt6cysapX+EzDwefMDZELadfpxF4unKeQCOmUExRJ/ySrX+9K+gq
	qH6GUGo63fuWuIR85JycIJTgPv4MQfNAAInyP2RZ6rxBXj/j6QrzVOLXS3K2lSZM
	th4he/9D6oF6cSGVuOVyZ8R//KPejQBYmQY9qldq0nib8EZtf4aRQZOi1FtIe8su
	n/0k7Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t0s5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 05:53:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5245rDem012976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 05:53:13 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 21:53:07 -0800
Message-ID: <114b60a4-ab67-4424-afc2-4a400d31de90@quicinc.com>
Date: Tue, 4 Mar 2025 11:23:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 2/7] interconnect: core: Add dynamic id allocation
 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-3-quic_rlaggysh@quicinc.com>
 <bv73i444oh4oakgqet7brkdpmusvpf4x5nbi7kgfvykts43roj@jnc5ps2sazeb>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <bv73i444oh4oakgqet7brkdpmusvpf4x5nbi7kgfvykts43roj@jnc5ps2sazeb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=I/ufRMgg c=1 sm=1 tr=0 ts=67c6954a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=TBUwsZYf_s3QzbKEj0UA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iVD32XXkljEB1SVlanefxgnLMSF0GHFe
X-Proofpoint-ORIG-GUID: iVD32XXkljEB1SVlanefxgnLMSF0GHFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040048



On 2/27/2025 9:38 PM, Dmitry Baryshkov wrote:
> On Thu, Feb 27, 2025 at 03:52:08PM +0000, Raviteja Laggyshetty wrote:
>> The current interconnect framework relies on static IDs for node
>> creation and registration, which limits topologies with multiple
>> instances of the same interconnect provider. To address this, update
>> the interconnect framework APIs icc_node_create() and icc_link_create()
>> APIs to dynamically allocate IDs for interconnect nodes during creation.
>> This change removes the dependency on static IDs, allowing multiple
>> instances of the same hardware, such as EPSS L3.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/core.c  | 13 ++++++++++++-
>>  include/linux/interconnect.h |  3 +++
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
> 
> 
> 
>> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
>> index 97ac253df62c..8b0f892aaed2 100644
>> --- a/include/linux/interconnect.h
>> +++ b/include/linux/interconnect.h
>> @@ -20,6 +20,9 @@
>>  #define Mbps_to_icc(x)	((x) * 1000 / 8)
>>  #define Gbps_to_icc(x)	((x) * 1000 * 1000 / 8)
>>  
>> +/* macro to indicate dynamic id allocation */
>> +#define ALLOC_DYN_ID	-1
> 
> Nit: ICC_ALLOC_DYN_ID
> 
> With that fixed,
> 
Will fix it in next revision.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>> +
>>  struct icc_path;
>>  struct device;
>>  
>> -- 
>> 2.43.0
>>
> 



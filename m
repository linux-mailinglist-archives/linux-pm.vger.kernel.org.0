Return-Path: <linux-pm+bounces-17957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729EB9D5F59
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 13:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01735B27F21
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2431DE3DE;
	Fri, 22 Nov 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EDg23djJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9B1D63FD;
	Fri, 22 Nov 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280195; cv=none; b=owUVA+aOWankjU0f2mjYq4AXTvyit9vPbjJ/DZIp11FVmx9HB09GI6rM0cQPwvlupZ0GpmcB/S/zqFePeFdrYV/3N2+aqyx0qgksM+HDsf8ctcoYayVhy+LldfgnXFzG3r8j35qjZGx/8wXeOgr4uPy4oani596JPHgPHp0SOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280195; c=relaxed/simple;
	bh=rua4jiqu0IXf9iFuTCjMCkzcn31grdTsKU6a7WreqUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IL5q0mWrjSkf57Kn1tAwf9mpsHe/c+lt6LJWZWv7DoyJ6MiPyar8cDsOg3eMOZ8CYqREBRhYRW1WiftgE7/vyfdMe9MNl9G9d2uBDTuxT78HhQ9yWPphs5xnQN4geekn/yzoy+g1fFMZp+aIOuoUwuzg4kPCXfs38IQ8A9bH+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EDg23djJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM2MwfL027721;
	Fri, 22 Nov 2024 12:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vXnc2qST7gKlRus5KPOROdbSEJlz/1mxs2Lg9hr3bgs=; b=EDg23djJjAn79SOR
	uCDZKvXoDjqucsVLb2J4S85UY/u4mpeaORPjldnMP+hsttTTw9nsrjokvUX+ADFh
	YqVTtT02IB5FPExHnryKIo4sYtaUTXqyQCiqtNW8SLHvDyIFZ+ohay/lWzQmBYRn
	SAtRvxgQAkKHHz4lOBgLxZ2Fd+bnVwTg0zZaIq/B4UP+ta49kbPoFJPzIASEJJJc
	V5F+QMnNs5cgpni1MFD6D17x+r21oocDa4n378GaYRlh6dCkW+CFavkldVYVO7nM
	4o4BKMr9WV1wA2i6QPovRFS8N1zAsyeRMiqVKa+NARrkOWsM35y/I/3d8zbdEcDF
	V1zL5A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432h4dser1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 12:56:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMCuJcD025911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 12:56:19 GMT
Received: from [10.50.50.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 22 Nov
 2024 04:56:12 -0800
Message-ID: <ad7a09e2-83b2-4885-a41a-94de381271cb@quicinc.com>
Date: Fri, 22 Nov 2024 18:26:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
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
References: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
 <20241115103957.1157495-4-quic_mmanikan@quicinc.com>
 <bf27f92a-5fc6-4b09-8653-4ac3ef438d4f@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <bf27f92a-5fc6-4b09-8653-4ac3ef438d4f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yzFTLFBq9zzQqw_Bejls4yhkxCfFze4r
X-Proofpoint-GUID: yzFTLFBq9zzQqw_Bejls4yhkxCfFze4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220110



On 11/22/2024 6:05 PM, Konrad Dybcio wrote:
> On 15.11.2024 11:39 AM, Manikanta Mylavarapu wrote:
>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>
>> SoCs without RPM need to enable sensors and calibrate them from the kernel.
>> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
>> Therefore, add a new calibration function for V2, as the tsens.c calib
>> function only supports V1. Also add new feature_config, ops and data for
>> IPQ5332, IPQ5424.
>>
>> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
>> is used to enable the relevant sensors.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
> 
> [...]
> 
>> +{
>> +	u32 shift = V2_SHIFT_DEFAULT;
>> +	u32 slope = V2_SLOPE_DEFAULT, czero = V2_CZERO_DEFAULT, val;
> 
> Please don't mix initialized and uninitialized variables in the same line,
> I think it would be the cleanest if you initialized the ones you want on
> separate lines and then declared val separately as well (and preferably
> in reverse-Christmas-tree order)
> 
> [...]
> 

Sure. I will update in next series.

>> +	}
>> +
>> +	val =	FIELD_PREP(CONVERSION_SHIFT_MASK, shift) |
> 
> tab->space after '='
> 
> [...]
> 

Sure. I will update in next series.

>> +	/* Select temperature format, unit is deci-Celsius */
>> +	regmap_field_write(priv->rf[CODE_OR_TEMP], RSEULT_FORMAT_TEMP);
> 
> "result"?
> 

Sure. I will update in next series.

Thanks & Regards,
Manikanta.


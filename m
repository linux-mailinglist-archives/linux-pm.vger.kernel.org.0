Return-Path: <linux-pm+bounces-9882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2575914585
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 10:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7102823B9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF57FBA4;
	Mon, 24 Jun 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Huho0qcN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC07346C;
	Mon, 24 Jun 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219494; cv=none; b=POM/vPD3NhG/ciM3f2OmVxh5APZldWlbFinRCjXxYUNrfLwgNxzgCMhXrjPoyeTb06guL9qvDjE6ae9cHhsl0tuKodsB862XI06/1rA7rJ465+Y55pnTBqzG/AmlPZS5uSa84nXSeMjg/Crihgb1LkgX0mdjA+7ahsfV++aDvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219494; c=relaxed/simple;
	bh=vw1sbCZKCt+TMNaPLFL5tI1ZWn9o+utrheEXb++Pxsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ss+2P3ZbYRV7ABVIRCjwP3qljn62qPyM4FWPy9+vVKPX9uB/3OHSPSiDsAwWYTtO6Btx1QNXtHHfqD7T6DOxzfS+MpkuCMujMHIJXZua2eClLqWGwOkiu+QpQnE3MgNNWWq2DiiGezF7DswFHKuuKgV09oLgFOSmfWTxtIqwyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Huho0qcN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8YvQd007992;
	Mon, 24 Jun 2024 08:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hq14cDADvG3VYB6Cn7q/47rRX7EruQhyG4e91Z0c+hg=; b=Huho0qcN7RbNDaBT
	VmlAOo+oqX6v5UT0VEJ9RGywVCO23bL30aGqx6VDfszI05Atb5TiL44qD3eMf/Qh
	fVYWvAQb4a2uuLQw+Gbc8ynrys3/wmk6MMRnFR4UxlaDFdPtIyR3rTGKDZerrkaT
	ioR5pvWKjYIfQhDKOttDJg0gr1Xx5cRUl/iB2mzXA+RW0NI6GjabNdTvE9vAwCxe
	KoBFeeePFkGum5gIY21k2WHqQUT04tBphehdO405y5zoRuNM+pXVnMJ3O/PUSCKw
	gZQ15pu/RAkKG6SuZvsmkmt8o4KL7mWWsPoVsKm1Xmr3EqxrdJT4+txlF0Z++JVO
	1jU6wQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnjru87n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:58:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O8w9c2005053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:58:09 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 01:58:04 -0700
Message-ID: <3685a5cb-b849-b63b-b83c-239deb5118ed@quicinc.com>
Date: Mon, 24 Jun 2024 14:28:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 X1E80100 BWMON instances
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-2-quic_sibis@quicinc.com>
 <d09aa84c-dc75-48c6-b91e-c0dbe3d2e06f@linaro.org>
 <eda0d218-aba0-4ade-8a9f-51b4591a32d2@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <eda0d218-aba0-4ade-8a9f-51b4591a32d2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mkY74eYCJW5kDla5gZqndK5XYTP4i0Tk
X-Proofpoint-ORIG-GUID: mkY74eYCJW5kDla5gZqndK5XYTP4i0Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=820
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240071



On 6/21/24 12:14, Krzysztof Kozlowski wrote:
> On 18/06/2024 18:02, Konrad Dybcio wrote:
>>
>>
>> On 6/18/24 17:43, Sibi Sankar wrote:
>>> Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
>>> instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
>>> path. Also make the opp-table optional for the X1E cpu-bwmon instances,
>>> since they use the same opp-table between them.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>
>> I think we can just drop the opp-table child node from required altogether,
>> bindings shouldn't care about where the OPP table (which is referenced in
>> the operating-points-v2 property) comes from
> 
> I agree.

Thanks, will break ^^ into a separate patch for the
next re-spin.

-Sibi
> 
> Best regards,
> Krzysztof
> 


Return-Path: <linux-pm+bounces-11771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E594366D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD56284661
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FBB1BC40;
	Wed, 31 Jul 2024 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hxlh8JvA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6B1401B;
	Wed, 31 Jul 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454251; cv=none; b=J/+KwxpSrTn91SoooAGVWVnxku2zyRe71wmUAIYugxsut7FK6CJ7WXe0v9qZVdiHZS6jY31oyLM8GD86CQ7rppQHXyvWsKpzHjoQfnvxI1bgEsDKOpLOwVszOR9hqX+5mhB3qwABEP6roUY3sOb4Fv5tKdN8mKVfAFjEthkRfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454251; c=relaxed/simple;
	bh=GPYN5sqsxPnq0hW7/Ij1+DV2cMzwBTyrzmFJEnEDzwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HczuvJqfteMdSCg9PzQYJkdMbqEH+g6ZjU17FvcUBaJpV4QFXIUOmA4nIxVlUKZu7DNz3c5gi/aKj7rnLFVI9MRwFHslnPvWIECvlvnr5NTq+L7EAr/iLUj9NpjsNalJBgeOeexUuDQJ+f5rwnkGjfGrVbxUX8zQc+VudeI8ofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hxlh8JvA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VAs7MD028541;
	Wed, 31 Jul 2024 19:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LfCKq3gklYZVwS6+Tsh821iQMYSWhV0Me3bvPbcFRQw=; b=hxlh8JvA7j6Myv2B
	KcIltub0O/PaK6NP3UjBqk1GfSa+xyDSQGyy3OiAj5N/2sPdPSVJjE11hZdqVc5O
	DIzmr5yb+Qwf3rdeIj6EHBeEAvgLyiKJhNqlznPachlf5OhqqzNj3XRCnIBfbx8G
	r4FbgT92Toaa5IdWv8ND6VgyAgJlrbeQRkl0OMOUXQYh+TRE+hhvR7dYTcDwjeQ0
	UOK6VN3JkonC++ifTRGbD/DPQLeVtM9JizQAdBkRoP+S5WQyzXw6qLtZIIpBAnip
	90JUoekH6pXwPkvstXD0niyQUXsUtudF5YPqWPHNOgt0rMe4KRdXYPnupWaUz7iq
	dR8Jsg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q232vn64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 19:30:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VJUi3E006165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 19:30:44 GMT
Received: from [10.110.68.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 12:30:40 -0700
Message-ID: <d8807827-5ad4-e442-a072-d564a55623fb@quicinc.com>
Date: Wed, 31 Jul 2024 12:30:40 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Document
 SA8775p bwmon compatibles
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
 <20240730-add_sa8775p_bwmon-v1-1-f4f878da29ae@quicinc.com>
 <1e78eeb9-3280-45ea-9d21-92efd939efe7@linaro.org>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1e78eeb9-3280-45ea-9d21-92efd939efe7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1hgravicoxA2AwiZVYOgpv3WgV7HpY7a
X-Proofpoint-ORIG-GUID: 1hgravicoxA2AwiZVYOgpv3WgV7HpY7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310137

On 7/31/2024 2:23 AM, Krzysztof Kozlowski wrote:
> On 30/07/2024 09:16, Tengfei Fan wrote:
>> Document the compatibles used to describe the bwmons present on the
>> SA8775p platform.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> I admit I don't know what to do with all these sa8775p patches. I am
> afraid now you say these are valid but in half a year this will change.
> If I give Ack, I feel like I am agreeing to such approach, which I do not.

Are you referring to sa8775p moving to scmi later in the year? sa8755p will not move to scmi
as per the latest discussions. We will have another SOC SKU to start adding
the SCMI. 


-- 
---Trilok Soni



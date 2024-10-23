Return-Path: <linux-pm+bounces-16316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936E9AD3A4
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE11F236F5
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1E61D0797;
	Wed, 23 Oct 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YQnPOdG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10701CBE9A;
	Wed, 23 Oct 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707108; cv=none; b=X4EBUlYL5zdczxV58k8stMdTBU3lN2XirWxDO69rZ4GVZudoHD4lLz6Xq18aFz/OzYRk5oqjqimXs3P5PN3GvVP6h+9j+euLnRzKVn9MwbIcq1jniEDrS5Pv3D1kqlVVzIzSBuGf4zwT+DfT3QnPBcl0CF45WuANBsawJPmqiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707108; c=relaxed/simple;
	bh=lEyxpR8YIKH9jaPfmVdP7LydGJzsOF9o7Wr66VpBAHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e4PnsJr5Vi96gOLsNdDAbPNM9V041FZJbRZj9/y23+iu8f7TLHZTp5fnCnaHuOleZrMpfPmyHX73OQgi6vNA0Lqd/hOCcLM2ZayX3Ug9d15DTlnMfsmE0F+eoHiKNNfKF3XyvagHAa1vlAg7gY7ueROKN4JqZCy4Mtar/KjvL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YQnPOdG0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9cAk0023403;
	Wed, 23 Oct 2024 18:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nX+3YPAG/+ZoEJ5/n00BQBs8grVcYnUDogB8O6j/a8o=; b=YQnPOdG04ed5PFb0
	e4bHxWw3Mth3ZQ3Ptcsuz4iDEbpoVyfNvpjBbw/01KFn+0YYhZDqJNs2UnfONdTf
	ENuKcYv+MV8gVZK+yBkU7dtgNSk+RUylyzCgFJhBiZ8318J4uStR1itHbLj18e7K
	F9/se/jsIx7gnQSPVpx7W+31JyysHHlulgAYqw9+fAQHpY27Izum5YJaxa2eRfn3
	LtxGC468T5XC2rVrU4twod0bW5p8FYRf2I1KOHtk2cjTowlQ2YKNoquUZXLLCJ29
	ioGjgpKAifHyO9bkdppPDWVyoa4XkEU2FnM9yzdhb6V7juGRG+cl3sppFH8tEITG
	kjSa8A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3uk6nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:11:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NIBbcA007794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:11:37 GMT
Received: from [10.71.108.63] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 11:11:37 -0700
Message-ID: <d0291dbf-f786-4d8e-bd38-4ad0b48d9df5@quicinc.com>
Date: Wed, 23 Oct 2024 11:11:36 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: power: Add additional RPMh levels
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>, Luca Weiss
	<luca@lucaweiss.eu>,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20241021230333.2632368-1-quic_molvera@quicinc.com>
 <20241021230333.2632368-3-quic_molvera@quicinc.com>
 <wuq23gxg7xlec4epoztgaycvrezufjthj77iwu7xangf4t22f2@hmj7f7v3kvuv>
Content-Language: en-US
From: Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <wuq23gxg7xlec4epoztgaycvrezufjthj77iwu7xangf4t22f2@hmj7f7v3kvuv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _rFV9wiyoCi5q_WoJOBJuHm-eHbSen5J
X-Proofpoint-ORIG-GUID: _rFV9wiyoCi5q_WoJOBJuHm-eHbSen5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=880
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230115



On 10/21/2024 11:13 PM, Krzysztof Kozlowski wrote:
> On Mon, Oct 21, 2024 at 04:03:32PM -0700, Melody Olvera wrote:
>> From: Jishnu Prakash <quic_jprakash@quicinc.com>
>>
>> Add RPMH_REGULATOR_LEVEL_LOW_SVS_D3 and RPMH_REGULATOR_LEVEL_TURBO_L4,
>> used by SM8750.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> This is not an independent patch, but part of SM8750 binding. Squash it.
>

Ack.

>> ---
>>   include/dt-bindings/power/qcom-rpmpd.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
>> index 608087fb9a3d..df599bf46220 100644
>> --- a/include/dt-bindings/power/qcom-rpmpd.h
> Best regards,
> Krzysztof
>



Return-Path: <linux-pm+bounces-19887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028E9FF807
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54183160CB0
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423351AC8B9;
	Thu,  2 Jan 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mju+9lfl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827F18FC8F;
	Thu,  2 Jan 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813754; cv=none; b=AbX2WJ1mBWiuYL4sBOujVuxHXVdw0zMKARmDbqMYBBSv2dtZuyzg4iOSWahTNJxcufUX2XGatfymKxFSEOcGEAR74RwrOlDjVcxGPoP3oVZshP1U02uiWf9YxKk908ke/qr6uqxADQ+g9My+ANNCaxFmojT/XJj9KjUIixZlmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813754; c=relaxed/simple;
	bh=rV+GbHwNxDjBU9RFByTLjmhrzv4cFey4s9t6DSF5520=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p7r4Osfg63xqO3vFuGh129Sax+xuyPaE7CuxnERQA8V7gI4TkgiLmmtsEKrnesD19q8ADVxdD+ZAI0jaotgpv0C7k/gALLWNh+xOKgh16JMGSvQZ+pm4cuf99Ic8GyipvzOpzBm15w52Q6vXZSPtOdr3S72Da3nRjklmBosapKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mju+9lfl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5024D4Ge031425;
	Thu, 2 Jan 2025 10:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g4APIvTeZywppftz7Aj+X4HSlzNOXiTdcpFnY81F0w0=; b=Mju+9lflaDc7iX4v
	67Ri0u/4r/BxPDWi6f1fH7YcKgsI5AKbQjYZImzoaCAS2T0dAOwf/WKvk5H6Jpt5
	DVSyWI9gO8fA+DJAdryUEXhHdJyttsOJKZl1Pm9gXso5LnFEJWXUDBnpsyOXDK2V
	SLvX0LICAzcKjJXKfZVBo/DTtDeL3EeoFEmkWEfp1XL5eXcj9pOe6z60IkeBVgZU
	EFDY7R0sb/Yi/h/mVvOSnmrxXxRQGSWuejzyXwA+60JokYWaHxqdhM2IJfeWqjkd
	Vc564uwyEkBip+PVtl/clHnsiLSDYVSI2g5ohamKVpBQPtYxzDr9+5ZBsbH9VvJM
	mjTgBA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43wkjt8p2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 10:29:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 502ASxH7015792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jan 2025 10:28:59 GMT
Received: from [10.216.23.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 Jan 2025
 02:28:52 -0800
Message-ID: <c16aeecd-8321-4df2-9db5-e9d5117200da@quicinc.com>
Date: Thu, 2 Jan 2025 15:58:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
To: Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        <devicetree@vger.kernel.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Simona Vetter <simona@ffwll.ch>, Sean Paul
	<sean@poorly.run>,
        <freedreno@lists.freedesktop.org>,
        Bjorn Andersson
	<andersson@kernel.org>, <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, "Stephen
 Boyd" <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "David Airlie" <airlied@gmail.com>
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-4-3ba73660e9ca@quicinc.com>
 <173559754709.2660868.7488137827927170444.robh@kernel.org>
 <a0fc7b6c-e68d-42a7-aff4-a11c88495f67@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <a0fc7b6c-e68d-42a7-aff4-a11c88495f67@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hX9BJLSvBDufzPZs1YUPaperp425gr50
X-Proofpoint-ORIG-GUID: hX9BJLSvBDufzPZs1YUPaperp425gr50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501020090

On 12/31/2024 3:09 PM, Konrad Dybcio wrote:
> On 30.12.2024 11:25 PM, Rob Herring (Arm) wrote:
>>
>> On Tue, 31 Dec 2024 02:41:05 +0530, Akhil P Oommen wrote:
>>> Add a new schema which extends opp-v2 to support a new vendor specific
>>> property required for Adreno GPUs found in Qualcomm's SoCs. The new
>>> property called "qcom,opp-acd-level" carries a u32 value recommended
>>> for each opp needs to be shared to GMU during runtime.
>>>
>>> Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.
>>>
>>> Cc: Rob Clark <robdclark@gmail.com>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
>>>  MAINTAINERS                                        |  1 +
>>>  2 files changed, 98 insertions(+)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml: ignoring, error parsing file
>> Traceback (most recent call last):
>>   File "/usr/bin/yamllint", line 33, in <module>
>>     sys.exit(load_entry_point('yamllint==1.29.0', 'console_scripts', 'yamllint')())
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 228, in run
>>     prob_level = show_problems(problems, file, args_format=args.format,
> 
> You need to shift the closing '}':
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> index b7874f43aaf6..46fbffaf0a61 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> @@ -93,5 +93,4 @@ examples:
>              opp-peak-kBps = <2136719>;
>              /* Intentionally left out qcom,opp-acd-level property here */
>          };
> -
> -};
> +    };
> 

Thanks. Will update.

-Akhil

> 
> Konrad



Return-Path: <linux-pm+bounces-14876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57898843D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58041B214FA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43C18BC26;
	Fri, 27 Sep 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oxn3Nb3k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BA1779BD;
	Fri, 27 Sep 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439943; cv=none; b=mrMIHUzYTw03NHfYVsAGqbeDCUslCT52J9neaPxxbNSqLgAqYdewjXrczxtS/v+pSREd075rUY5GcnfqJ0MJvkMoc8dnWpNc7VPzNEpkDlle19ASVxqVhmHRSeqY45mtbJtQtz+VoV9pgju/j0tO2bRzajv9BZuDUv3bh1bN+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439943; c=relaxed/simple;
	bh=U9TWvLV4SZiogvM28Bg89ipiAtD7eYtvuup/pgPR4wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TckIOfUuLHWE25DoSio0FESiBujGaeWTd2ehk6vYG0hSrHyEsEL4A2z8LPkNgbe9MfWC2ehjXLMUHr+SAa9N6UWIImROrDhTiaI1utFpawmfOiOCnvmBtNfcdmuLp15HX1A+3DHKJoaTwqVTQdXmVZQjRg8Vci3sQNbPi2AmnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oxn3Nb3k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6kBuo003275;
	Fri, 27 Sep 2024 12:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtCCTFQDBjjjsQDJEgXfFZwnFD5KhlZEr1Kh2yvnXIY=; b=Oxn3Nb3kkDFngdiS
	jSqJVsSkVcfyXAL1idQwUQxDaVJygkdKh7GCAni7in+I5HxVucvNM+OC4lsYSgu5
	2nicgVcB55oFhsXavlGAASoeHoedv6uG5m6x+ANRnhL8Ywmib95xk5tr7D5mQuKL
	71OmQN2hblxrnoGvv42I+24RksZZIxx+df2quRFtHh6LB1RBpCYDeD5NAB66mz5f
	696gAVAuUMaadQbkQh2cVKb69Q1Z/+yLOk+653j7pI3kiAG/he7SX8c+Bdd1yGfz
	BKNLXjK6qADPDciZIF7K772wTSueTg/M1LcPErEP70V7D2bvd1XpDvT2eo0FA1ls
	U0wiLg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snqyu0sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:25:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RCPaVC009427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:25:36 GMT
Received: from [10.231.207.28] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 27 Sep
 2024 05:25:30 -0700
Message-ID: <5bae0888-7e48-4f88-93e0-db46074dea40@quicinc.com>
Date: Fri, 27 Sep 2024 20:25:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document qcs8300 RPMh
 power domains
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com>
 <20240920-add_qcs8300_powerdomains_driver_support-v1-1-96a2a08841da@quicinc.com>
 <1e4aeeba-0d98-472d-aa58-8eff6a27a1e1@kernel.org>
Content-Language: en-US
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
In-Reply-To: <1e4aeeba-0d98-472d-aa58-8eff6a27a1e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AvX46QHqT_Kv4id8bczL3p9z1H9oPRjD
X-Proofpoint-ORIG-GUID: AvX46QHqT_Kv4id8bczL3p9z1H9oPRjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270089



On 9/20/2024 9:12 PM, Krzysztof Kozlowski wrote:
> On 20/09/2024 05:39, Tingguo Cheng wrote:
>> Add compatible string for the RPMh power domains on qcs8300 platform.
>>
>> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
As comments in 
"https://lore.kernel.org/all/30458916-90f4-4126-b5b4-a52f580c4fa7@kernel.org/", 
I created a new patchset by combining the two patchsets into one to 
resolve the conflicts.

20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com
|
|<--Patchset 
1:https://lore.kernel.org/r/20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com
|<--Patchset 2:Current patchset.

> Best regards,
> Krzysztof
> 

-- 
Thank you & BRs
Tingguo



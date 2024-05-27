Return-Path: <linux-pm+bounces-8130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44428CF873
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 06:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764C21F21830
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 04:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767557464;
	Mon, 27 May 2024 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CjRSnw3K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA68FBEF;
	Mon, 27 May 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784673; cv=none; b=QbW+gyrZrHYFCMCmVIV/7WB2Q652TCZhe9ZvM08p6lQHv175pehM/PY4yCxxDyhH0yCgGmUWy1LEdfXmcTZCuCtQAtN3h4QD6yrRTmoddAiz9+x4qJ5uTgtCa9BQerfxss4j38IO2NYSwH0IM2I/44o1f5IjBzBuxD6hlaq1CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784673; c=relaxed/simple;
	bh=EHD2w19epTrPQq3vs3G/tNDyHmNlskVxhDpFLuv7B+o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=TNxYV+y0exRQhSuAFOS3NYkYHCXay+v7VmXbpwRmOQoti2DcQk4Esg2shoWZpOKwuW3J8cCChFK2R+xl0Ve0QDDF8QIVcb1wAfAeQvZYauTQihC1zJlRqnIDo3yieU2MkLo5YvAfM4VE+TXDC7OZ+emkIukuZYTlWcJiYTSS4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CjRSnw3K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QNo1KU028483;
	Mon, 27 May 2024 04:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jo+UMF3sWeB2kB1ai6K+FjyeSvcvmLSN/FfrBDQ51OM=; b=CjRSnw3KfKd6ZE8N
	bC5f2O4581r6KLBwma4Oyh546tsct2ggUUbKudah79zYNney4j6BtvfngXanvaIY
	le4Wm9GxEJ8gILJrTrTMC9ZAVfzzAmShLS4vUXnUWtC3jISrFlYonJp91+Zu2cPK
	fvn7mE3qL8BGvkZByRaPJgV+ApsH41fvpx4L11367OBoSPv53k6s07rCLbJuhKE2
	n9SA/7FAK8xSxBHh/azfnyiURD5XG5k+Yi6R4dXr8pS2xt6BnfT5Ypuc8UZcnCQ+
	hPiyD8LYJ0jOVu3JSf+hUADoOaPH7B6cYNNMzXaOWi2pG0l6QZt82jrPnqYwWahy
	OJhXiQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k2kku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 04:37:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44R4beFM010202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 04:37:40 GMT
Received: from [10.152.207.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 26 May
 2024 21:37:35 -0700
Message-ID: <aeb32037-4e06-4b6a-8b4d-7b8ef0a0ad16@quicinc.com>
Date: Mon, 27 May 2024 10:07:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for the IPQ5321 SoC
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
References: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
 <12e5708a-ea6e-4798-a487-f2465c848278@quicinc.com>
Content-Language: en-US
In-Reply-To: <12e5708a-ea6e-4798-a487-f2465c848278@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gmELGD-OxZ65chYRS6wUeLh0mE56IFwI
X-Proofpoint-GUID: gmELGD-OxZ65chYRS6wUeLh0mE56IFwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270035



On 4/6/2024 8:18 PM, Kathiravan Thirumoorthy wrote:
> 
> 
> On 3/25/2024 9:19 PM, Kathiravan Thirumoorthy wrote:
>> IPQ5321 SoC belong to IPQ5332 family. Add the SoC ID and the cpufreq
>> support. Maximum cpufreq for IPQ5321 is 1.1GHZ, which is determined
>> based on the eFuse.
>>
>> Viresh is okay to merge the cpufreq change via qcom tree[1] and provided
>> his Ack.
>>
>> [1]
>> https://lore.kernel.org/linux-arm-msm/20240306053200.6iwrviltwt3pnfnt@vireshk-i7/
> 
> 
> Gentle Reminder...


Bjorn,

Can this series picked up for v6.11?

I applied this series on top of qcom/for-next and it's applying cleanly. 
Do let me know if I have to send V3 in any case.

Thanks,
Kathiravan.


> 
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
>> Changes in v2:
>>     - rebase on next-20240325
>>     - pick up the tags
>>     - Link to v1:
>>       
>> https://lore.kernel.org/linux-arm-msm/20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com/
>>
>> ---
>> Kathiravan Thirumoorthy (3):
>>        dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
>>        soc: qcom: socinfo: Add SoC ID for IPQ5321
>>        cpufreq: qcom-nvmem: add support for IPQ5321
>>
>>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>>   drivers/soc/qcom/socinfo.c           | 1 +
>>   include/dt-bindings/arm/qcom,ids.h   | 1 +
>>   3 files changed, 3 insertions(+)
>> ---
>> base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
>> change-id: 20240228-ipq5321-sku-support-bd07056d5e01
>>
>> Best regards,


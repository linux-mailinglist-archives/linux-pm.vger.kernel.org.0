Return-Path: <linux-pm+bounces-17610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB759CDCC9
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1427D282E56
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D319D07C;
	Fri, 15 Nov 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GJ1eX9Da"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70714A088;
	Fri, 15 Nov 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667152; cv=none; b=Mch2x2zYfSHRB8CNwZRorGOK8TEcUWdXfiCkGmkfnHpdMAS3Az1Tf8tiW9JxBWv+cRpBoXkbcpvGLDt+UeJ0bkn0x1X7m++YfYz5qIhlfmRiX2MZG7QPToihGq0pJ3NrbHMGDyTUdd9nqtWMkPlnugHoLq0jJvQRIRaI6Z5eF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667152; c=relaxed/simple;
	bh=3HM/RaDSon8LA8N7zpH4WJ9nFNUKx6dsdgQ7GDtnl6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a+egixr83GvofGjrxyGoeG6nYf5gwj+kNSVsWrf0NEHsSWwDQGM1W7SDuzL2vCRQ4z40X8LKhs+HI2vifUh5bJ+MudFk0naKKrY4XrA0pbQUkwxKHb9PpDGt1agc5kStE9eMAvrs6w3lOy5tgSFr+4Hlwqq03TrG0O7JVtodR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GJ1eX9Da; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8ZuwY019841;
	Fri, 15 Nov 2024 10:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uEBQz/rxpsUSb24M9rVZsdf+zdWS4znILDaiAox6hRk=; b=GJ1eX9Da3v4FM8DB
	3YEqdUnAH5gRsMfeovEkX+LoED3P4iZFPQt8suDEit/bLcE0mPk1kuW10u2Fyfu1
	2UDVkpr5zBtWzlXfSFFN1nsO5iXMPfWVfAWT5FWCSUu+Am6zIFnoBi9TXQx65dWJ
	yyLYirrQA9yH2tvsVYa+/4Yyo0hp8CP6BaLbFjdyK8vZjHOh/u13i07AqNZyx6vi
	N7p0WWLBqckxCmtiWL5NR3dH257msfCU3avZIRDhFGgvDECvYcfk9wTwaG7B03LT
	4wAKGH0JOqLkm6nwdb9s67B/VS0Gc2bbUG8A9e+qGH/BAAOr7g1GPjluCnl0uzqu
	Eu4lbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v4kr3qcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:39:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAd1nK009405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:39:01 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 02:38:55 -0800
Message-ID: <a6ac986c-4e26-41d4-9781-80373ea8972d@quicinc.com>
Date: Fri, 15 Nov 2024 16:08:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Add TSENS support for IPQ5332, IPQ5424
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
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
 <720286f3-8d92-45e0-822b-c4c5c40e7337@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <720286f3-8d92-45e0-822b-c4c5c40e7337@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R4wHfw9SsmMnWeU8Auuixcffp6BTSHKr
X-Proofpoint-GUID: R4wHfw9SsmMnWeU8Auuixcffp6BTSHKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=536
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150090



On 11/9/2024 3:48 PM, Konrad Dybcio wrote:
> On 7.11.2024 3:05 PM, Manikanta Mylavarapu wrote:
>> IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
>> upper/lower and critical. IPQ5332 does not have RPM and
>> kernel has to take care of TSENS enablement and calibration.
>>
>> IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
>> (no RPM) hence add IPQ5424 support in this series itself.
>>
>> This patch series adds the temperature sensor enablement,
>> calibration support for IPQ5332 and IPQ5424.
>>
>> Depends On:
>> https://lore.kernel.org/linux-arm-msm/20241028060506.246606-1-quic_srichara@quicinc.com/
>>
>> Changes in V7:
>> 	- Fixed all review comments from Dmitry Baryshkov, Konrad Dybico
>> 	- Detailed change logs are added to the respective patches
> 
> Please see the responses I made on that thread
> 
> Konrad
> 

Hi Konrad,

I have addressed all of your comments.

Thanks & Regards,
Manikanta.


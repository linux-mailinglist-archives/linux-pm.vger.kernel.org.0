Return-Path: <linux-pm+bounces-16464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB29B051C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F54B24811
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D114F114;
	Fri, 25 Oct 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TGi/SKeF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229D14884C;
	Fri, 25 Oct 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865287; cv=none; b=iod9s8CoO6YUpTa0uhMRaPTsZmDJ4BOV+tV9a8UhFKns3c+4IG3P5l3XH8Eq8aKfCfbtNyfoPoXcTfBKFadYkuIap4BjkmH91fwraZKh8yzh0lQOjTp5zNEImgMT9xIy76TLNn3P0VlbkFfAl4BsiFz6M18ThKgFX5QXu1psKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865287; c=relaxed/simple;
	bh=5WisrcgviY6o4UVcxq/ftKm7E3q6azuqEKTgUfYSJuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZwQXMxJVelEn6SLeNmkbrkk2Q8/19fK4si6Z5+/W06UvNwar+ys5GFbHgjVgEd9EoPWk+WSOkJVXoxIiVB/TgaEN4Ao6+kmvMrZhwXPK5ueApVKmJIHw1aquMVFAyNirWqcydyX5hRinTDOZ4g3558A19OHC2xIMlL9Q1OUL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TGi/SKeF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBurNX004988;
	Fri, 25 Oct 2024 14:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tkk5ZSyPcxaL6A+xV84EKq63bfDmIqcaz//n9nMPm4g=; b=TGi/SKeFZ/tRqUWC
	sbvuu9+F62fz+eqBX9CdNPLB36SBJdB36Nd3tdwwwM13g5FhI1E03zuCJc5PB31o
	7J/xjbLcn6r/jWkyvqwi4Y19KQWRxWyHdY6fxK/hO+LnP9/jYW/wWFAC9zlVUOQY
	fYZXYZxovaeAzR3xRHI7OkW04JWGrJRyGh2ujRCcURn4OV7MMaciIIe2S1BzirHN
	/H44LWEcgyKWez5hG9tZ/rGFAnGezpiReGfe61F5nnmySgKL5XAhEijLqLYx6RHB
	yqCdr6H1EUZdreO608qatMDsQ/gku2rQmCefiET/ngdVGSw1yN5yW9sESgL+0ymk
	oixFwQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em689ant-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 14:07:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PE7qL6003944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 14:07:52 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 07:07:47 -0700
Message-ID: <99fe6e85-aed7-fb30-e0c4-9812667cd0e4@quicinc.com>
Date: Fri, 25 Oct 2024 19:37:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 1/4] firmware: arm_scmi: Ensure that the message-id
 supports fastchannel
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        Johan
 Hovold <johan+linaro@kernel.org>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
 <20241023102148.1698910-2-quic_sibis@quicinc.com>
 <ZxufoL3NjYs8Lyq0@hovoldconsulting.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZxufoL3NjYs8Lyq0@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1J-w4zd-_qt8A4RcmPqmaCa1AcdjxHEZ
X-Proofpoint-GUID: 1J-w4zd-_qt8A4RcmPqmaCa1AcdjxHEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250109



On 10/25/24 19:09, Johan Hovold wrote:
> On Wed, Oct 23, 2024 at 03:51:45PM +0530, Sibi Sankar wrote:
>> Currently the perf and powercap protocol relies on the protocol domain
>> attributes, which just ensures that one fastchannel per domain, before
>> instantiating fastchannels for all possible message-ids. Fix this by
>> ensuring that each message-id supports fastchannel before initialization.
> 
> Again, perhaps you could include the error message I reported here so
> that anyone searching for that error will find this fix more easily?

Ack

>   
>> Reported-by: Johan Hovold <johan+linaro@kernel.org>
>> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
>> Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
> 
> And, also again, should you add a CC-stable tag here to get this
> backported?

Ack

-Sibi

> 
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>
>> v3:
>> * Pick up R-b, T-b from the list.
>> * Move scmi_protocol_msg_check to the top [Sudeep]
> 
> Johan


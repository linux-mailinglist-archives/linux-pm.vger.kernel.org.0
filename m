Return-Path: <linux-pm+bounces-10756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F36929FDE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B491C2157E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967278274;
	Mon,  8 Jul 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hnqaMp++"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACC7407A;
	Mon,  8 Jul 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433243; cv=none; b=WaCuqNho8za+z+fr0X11t9OBuFp16Ohh9h3GZfdYf0KGlY/PNtWATQYFeCHHnZDOCUdSH/zSweIdWuwogxcndEMINO4RjYUlJ5cfWKECQbnA/jd3P89FQrkiJZoe+Dilom3b37ESyRvMJlBUBAVM9cXJBXsJLg6HDhuenFdhCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433243; c=relaxed/simple;
	bh=LOJm3p4Nr/SY5w5HRVFRJTRX8LEqR9Rfkrg53sGrSdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=em9kkl3AMtelmTILa0gUTzMd6caDPkAnFPrOwJ/RpF2DkQ2OkLo35Aco+GRTrrdOeUJlXhm2oWleRtt+hhH3XpYNM54E3h+dQ5XfPYFQauM4ejyGxrJDURfleH+2wm2HTf14e7+uXTjmtAwScpzjF9b7hJle/10VjioXEkgZ5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hnqaMp++; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467MblOT008824;
	Mon, 8 Jul 2024 10:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ipVfybvVES0g4wxPIJHge/FLa6oHUAtzMjbTnicGPPs=; b=hnqaMp++J/uf1YAz
	w24xUNWAmizU4c5Qr4+OSVTk+tojxezxRP6Mhc9xxTLSpTqjdUJTT0cwYzw1jX8r
	CCxCgbehfPcRR6GdcVBM2jqHePMQghOmDZrUj83ySWbvZAGWrwVssyYP6mTiYFKu
	wdEp7MnGF2PYco+myMZzWJXooazvFtj9KQUe4bml5okE4ReGWroxUbJcGxEJXJmU
	LGRVq4txeK6IYuiy3El2ekwNVuMVLwbEOVsqHonXRaaKQZGDkNNGQF+weFD6icKt
	dB2Fq6HACuR6eHB0DH2vzrAo1tCa7ODTYk47UEZbaBWEoVLy+7DKhDnPwwPbPGa+
	oeq4sA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hb58r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 10:07:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468A7BNa030623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 10:07:11 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 03:07:07 -0700
Message-ID: <48ac18f3-b831-91ab-4993-d82749052d8d@quicinc.com>
Date: Mon, 8 Jul 2024 15:37:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <ulf.hansson@linaro.org>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <johan@kernel.org>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus> <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
 <Zofvc31pPU23mjnp@bogus>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <Zofvc31pPU23mjnp@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V3ih71OpWE9WX07-nPCHl1BdKLvUNd1e
X-Proofpoint-GUID: V3ih71OpWE9WX07-nPCHl1BdKLvUNd1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_05,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=985 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080079



On 7/5/24 18:34, Sudeep Holla wrote:
> On Fri, Jul 05, 2024 at 09:16:29AM +0530, Sibi Sankar wrote:
>>
>> On 7/4/24 16:02, Sudeep Holla wrote:
>>>
>>> If there are 2 perf domains for a device or group of devices, there must
>>> be something unique about each of these domains. Why can't the firmware
>>> specify the uniqueness or the difference via the name?
>>>
>>> The example above seems firmware is being just lazy to update it. Also
>>> for the user/developer/debugger, the unique name might be more useful
>>> than just this number.
>>>
>>> So please use the name(we must now have extended name if 16bytes are less)
>>> to provide unique names. Please stop working around such silly firmware
>>> bugs like this, it just makes using debugfs for anything useful harder.
>>
>> This is just meant to address firmware that are already out in the wild.
>> That being said I don't necessarily agree with the patch either since
>> it's penalizing firmware that actually uses a proper name by appending
>> something inherently less useful to it. Since, the using of an unique
>> domain name isn't required by the spec, the need for it goes under the radar
>> for vendors. Mandating it might be the right thing to do since
>> the kernel seems inherently expect that.
>>
> 
> Well I would love if spec authors can agree and mandate this. But this is
> one of those things I can't argue as I don't necessarily agree with the
> argument. There are 2 distinct/unique domains but firmware authors ran out
> of unique names for them or just can't be bothered to care about it.
> 
> They can't run out of characters as well in above examples, firmware can
> add some useless domain ID in the name if they can't be bothered or creative.
> 
> So I must admit I can't be bothered as well with that honestly.

Okay, I guess the conclusion is that if the firmware vendors
don't care enough to provide unique names, they get to live
without those debugfs nodes.

Do we really want to register/expose scmi perf power-domains used by
the CPU nodes? Given that scmi-cpufreq doesn't consume these power
domains and can be voted upon by another consumer, wouldn't this cause
a disconnect?

-Sibi

> --
> Regards,
> Sudeep


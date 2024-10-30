Return-Path: <linux-pm+bounces-16725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F09B6364
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F905B212E0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355A1E885B;
	Wed, 30 Oct 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HYbVbyAc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5D4D8A7;
	Wed, 30 Oct 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292757; cv=none; b=PSEGXYsBzZuBA0bY1+K5XWF/B9wRZbxvyC4h5/Er4j6w74jmItRIfq/0wtdVY9in3WUIL3VTPXA4/oB/6P2nqeWXwyLX6YXns9EQI73wsour+jfvKJqEjKs/3MJD8AmhTuBxHxWnni/BAOEZgp7uhznQEFjd1VwbmnToourK6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292757; c=relaxed/simple;
	bh=HkTtFEmRjRrNgjKwK8sYfvOwh/wBJWkklEMNCRDk+r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MqYXEZgtbus3RifJ4XTs+Xo2LJxXHwAk1x7pO9Y+xwipsOM9ion72UUepo+A/NsSBF9dsT1U627MV804z+GsgB+Z7HqA0B//ZplhjAjsFn6G55K4z8tgel5WFahmaFut6BsbSGQ+ye4WI6gdScDaWxJWXhBv2TjREP4jBtAgwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HYbVbyAc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UAiOVV008871;
	Wed, 30 Oct 2024 12:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gF+3gfp5dbT+G1Ph7dID7VDXTSrRr3ClgxYxPHb04fY=; b=HYbVbyAch/WMPDr2
	iQGaTkS1tpHhiKQRsP6zgv9yruuy78iK9OODcoUqykcmNnclCmDkBLOfDLciWhsE
	+pGL7qsX60lR/CW84A6voo3Q6ZVShNFO+aZC25aVNy3eT3h7al5K2/lLLVC1Zg2v
	lgtylT0dhFq6XshnBKcJLG5o7AkfhCLlT2W2xym5hlr79P51kKtzw7yVbpjKmfCP
	NFMfOKkRo0uCDA7ByZUboqZ21HJQ+QpLIa3vzVpSi7bma4sVGj0jVY1B0faBMYun
	JPipyGkLjER+61ZUQF0oJ5hqAt91fV5sm8jNrMHqcwMGeXvBGTsViAnBb3qVr9JR
	D8xHuQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42jxa8bud0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:52:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCqO1s023019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:52:24 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 05:52:18 -0700
Message-ID: <a1c14b44-c11a-9855-45a1-9a30fe40c01f@quicinc.com>
Date: Wed, 30 Oct 2024 18:22:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 3/4] pmdomain: core: Fix debugfs node creation failure
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
 <20241023102148.1698910-4-quic_sibis@quicinc.com>
 <ZxuixxBzQZUdIW1c@hovoldconsulting.com>
 <72a0b7b5-4209-f969-0726-e411b5a74e01@quicinc.com>
 <ZxunIcSZDoO3ph64@hovoldconsulting.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZxunIcSZDoO3ph64@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gmUKxpxBdrgdJWBnvcj7Leuq-A80ZKjX
X-Proofpoint-ORIG-GUID: gmUKxpxBdrgdJWBnvcj7Leuq-A80ZKjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=959 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300101



On 10/25/24 19:41, Johan Hovold wrote:
> On Fri, Oct 25, 2024 at 07:36:16PM +0530, Sibi Sankar wrote:
>> On 10/25/24 19:23, Johan Hovold wrote:
> 
>>> Also seems to do the trick:
>>>
>>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>>>
>>> But perhaps you could consider starting enumerating the duplicate
>>> domains from 2 (or 1) instead of 0?:
>>>
>>> NCC_1                           on                              0
>>> NCC_0                           on                              0
>>> NCC                             on                              0
>>
>> We are just trying to make sure node names are unique and
>> can't ensure the pd-name correctness since ida starts its
>> number generation from 0 and I didn't want to shape the
>> fix just to cater to our specific case. The firmware fix
>> will be in charge of ensuring pd-name correctness.
> 
> Ah, it's a global number space? I didn't really look at the
> implementation...

Thanks for testing out the patch. Yes it was a global number
space but we are changing the implementation again in the next
re-spin. Please try that out instead.

-Sibi

> 
> Johan


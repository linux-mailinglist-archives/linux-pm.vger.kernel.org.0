Return-Path: <linux-pm+bounces-16463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43739B050F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D790C1C224E7
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F36145FE5;
	Fri, 25 Oct 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cHyVY4Y+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3271745F2;
	Fri, 25 Oct 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865200; cv=none; b=o8E1htZubZSAumBkFeckgV5aiXxP/bmgpzZGpJYUvvLjuCYulB9hyVlTIlGTLI4/V9/WOSw53gfT7RLJDZf0gzRGx24T3j4eSTITwX1OWqNYlPij7wwhtYRzN3/3ES58rUYwSPR9F2QzMQ9b1Gc5s7h8XC8PS6F0eJickJwJClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865200; c=relaxed/simple;
	bh=cKKDyIrt/dTt0wDdrBO4uVeZ0gwCFendhBdq9JKk1n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k3oxAqHuzvblPBi11bIqApKKm+OIcY6XZp3c/vFy2xEhT9QeZwT6JFRoRMnhZNXAEJLWzsTKfWTGf3eGWQi6hliWQFqGI8gX08MvixcffErPo7pRwELJEOIz6uosA/teqmHfN84ufT3eK3Ts+TZaw2xuBoyLUM3VgF0+JOQZ6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cHyVY4Y+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P62N8m011840;
	Fri, 25 Oct 2024 14:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c8Zb7tpksoD7fMvqbTloS+8Cuu9LoyXtYTMubuP1Hpc=; b=cHyVY4Y+LpwOph0K
	x0rE8GwEuo/82S5c9vhu99LQC2ynyaBZGuhFZJmrz+fHSArvw6sFa2by40NhwJtL
	6D3G5mYe1cqnuZZfGOp7z3+o0WCZWLcXfOUEDzC+jkQKWE2P7lxBO3HJ7eB7p2V2
	piiyuBXuSWV+JGIU6wVFeFdbzaXBPWhfmgwzYhcZS5QOd2XTH7P7zEdPGo3q3uoT
	QbAypr0gIJYlY2NS/HKxTqFFvS9v9dA2R2leWRXB8C3pe5glg4xzInZ1upbSfaGw
	FHlaoM+Qd0J3oCPaxVEECy1GNEt83cqITAoczCuWw2xQgoOGqvw7x0goBbvz0R4r
	k+pxDQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g5q81be3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 14:06:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PE6OIX012362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 14:06:24 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 07:06:20 -0700
Message-ID: <72a0b7b5-4209-f969-0726-e411b5a74e01@quicinc.com>
Date: Fri, 25 Oct 2024 19:36:16 +0530
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
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZxuixxBzQZUdIW1c@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ehmzMwQX5Q7m_GJ1jVenFpukylRey0u9
X-Proofpoint-GUID: ehmzMwQX5Q7m_GJ1jVenFpukylRey0u9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250109



On 10/25/24 19:23, Johan Hovold wrote:
> On Wed, Oct 23, 2024 at 03:51:47PM +0530, Sibi Sankar wrote:
>> The domain attributes returned by the perf protocol can end up
>> reporting identical names across domains, resulting in debugfs
>> node creation failure. Fix this failure by ensuring that pm domains
>> get a unique name using ida in pm_genpd_init.
>>
>> Logs: [X1E reports 'NCC' for all its scmi perf domains]
>> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>>
>> Reported-by: Johan Hovold <johan+linaro@kernel.org>
>> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
>> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v3:
>> * Update device names only when a name collision occurs [Dmitry/Ulf]
>> * Drop Johan's T-b from "fix debugfs node creation failure"
> 
> Also seems to do the trick:
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> But perhaps you could consider starting enumerating the duplicate
> domains from 2 (or 1) instead of 0?:
> 
> NCC_1                           on                              0
> NCC_0                           on                              0
> NCC                             on                              0

We are just trying to make sure node names are unique and
can't ensure the pd-name correctness since ida starts its
number generation from 0 and I didn't want to shape the
fix just to cater to our specific case. The firmware fix
will be in charge of ensuring pd-name correctness.

-Sibi

> 
> Johan


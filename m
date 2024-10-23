Return-Path: <linux-pm+bounces-16280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8A9AC098
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 09:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8238284C7B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39E154C04;
	Wed, 23 Oct 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HonOUKVH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FB15443C;
	Wed, 23 Oct 2024 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669630; cv=none; b=feB2CY6IqV2tSI4YbAn4A9HHY71NVsD9Xttv+3b46glU9cUTVdYGMCw5WS+ZgCBm57AS7C98IcoCItHM7dwodAh/sq8Lj/Dx+XV9Eno7XuF/0sqsn6CcMM2WpTYyvo/7JgmWoUMELYIxH3yrALa+sGLsIrLiAkQ/LuMKzXYVTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669630; c=relaxed/simple;
	bh=WxrpTfo0Ro5O/W4tKdv9AC9eL3/cEUxiZpLNJuhbvxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VaxbYPai244wKxjLn5f4w9L+iNKjq0nKMgOJLpPsV1voqrZ4hHPLlQWT3mVWuNtAzx5tLyNRbiD6kvcelNf7VjV+vgiGRsf1IRa7l4QejJxIt5JuKOWVrWREr2xRTa9EcqIzrMzpJMd+GQRqT9nnp0pxpMTvCWpBcHQSQejJBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HonOUKVH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLaO2i028304;
	Wed, 23 Oct 2024 07:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Reaotx7xKtV+T2RZPrLWeCnG+P8PEHmuEC+TJ6peMeI=; b=HonOUKVHf1ueTGUj
	wc5lsgYBlorSzVqO09XmgIclsjS6ImcLzTjqYH9OecDn0LVkBjsq6G7U0upJkAlB
	J+2630ktTy7lVBe9d9UHeUpm55ez9cnOOj8R03cYlzEnyqSw1HU8M2KsTkbh2CUT
	KUeg4yeayVvx4m0S7cLEVlyED1eArY590gTFti46nV6pgj9c0VFmGRw3+Q3Q5S6c
	0J/tq8CymcU77Jsj9ymYbQC4KnslqyDw8289TrbfJSmKc5ImYBH8nS4muA25cRpo
	fbm6kZuswRpgXkNvFwkPf9YZZPBXUBygeXimXbGQdw4mx+K3m6Fn6AzTbEWIgV8X
	5Kvgsg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41s9k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 07:46:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N7ksa6015287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 07:46:54 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 00:46:50 -0700
Message-ID: <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
Date: Wed, 23 Oct 2024 13:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3esxjgNMWNCmetCmF1sPlsELCZAde0PN
X-Proofpoint-ORIG-GUID: 3esxjgNMWNCmetCmF1sPlsELCZAde0PN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=862 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230047



On 10/10/24 20:32, Johan Hovold wrote:
> On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
>> The series addresses the kernel warnings reported by Johan at [1] and are
>> are required to X1E cpufreq device tree changes [2] to land.
>>
>> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
>> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
>>
>> The following warnings remain unadressed:
>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> 
> Are there any plans for how to address these?

Hey Johan,
Sorry missed replying to this. The error implies that duplicate
opps are reported by the SCP firmware and appear once during probe.
This particular error can be fixed only by a firmware update and you
should be able to test it out soon on the CRD first.

"FWIW the warnings that we are addressing in this series will also get
fixed by a firmware update but they still have to land for devices
already out in the wild."


> 
> Johan


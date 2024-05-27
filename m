Return-Path: <linux-pm+bounces-8143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E38CFD9C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 11:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A525A1C212BF
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39B13A896;
	Mon, 27 May 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LCraXoxt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76F1755A;
	Mon, 27 May 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803898; cv=none; b=OE11LjZnyhdhrlCXV7GbIFChBFuJV3EuH2hnEqWnHdMXcH3DK1uu2W1Ie14/0VeZzcGNwiJ+khSQhsD8tvZ8sOfz4E+q8fB4EG1MBTYWJgeAdqg2f3XKRc5Z3EAh6ihlS8Tp7WaDNKG7r7WtKTASQw0PUNHSBM554Se1JoL+h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803898; c=relaxed/simple;
	bh=EEHOfazOlZEk0htFPYfDkVAUWOazSJfekRoJ2e9+LNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DxbpHT4645hGJJcKDMzTh+hm4WVERTSOmg3tk8cMIv9oeD9GuUdsQs42Rcg3FsKsLUJqTaG20PDEc8QzEPQwy586EJtBWI+5oySAqkaUmXwvipx0t8EjUKA8Uvr8eh9iePZJ9AGxKxEZvb1aHHGKRpmv9GRA7DRqhWfedinqHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LCraXoxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R5EvvH024798;
	Mon, 27 May 2024 09:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ORfPCbHFHYEykdV59xrWma5Fj9/sZHnhE+3H4LARdug=; b=LCraXoxtOshRiEMz
	VaRVgWKHP+WE9PQ12ses8TgsgE2bgS6TqjKU50KBeuUk6MgGevcMi65sosGHQqvD
	F8jpxWW233SifCCwgH8AOpm28cNbaEn+F1bKzEiaZloflOi9YOfC9yfOM5+zK9v4
	gaUKlJGUughzLh0b87T+QijwNNR8Jky77t/7wMQypKLV6axPPMx9d62qzm9HH8eh
	4PMlbfVRLkPfjQOO/ZX7RsSeN2TtolvO9Hs9wwgTNq/Dum/To6KvTIaNzptbquQI
	DJDmUesAsbfMqc9Yr6lx07FmFvgjTxwr+524FJ0B7tzPVagnMSIahVCmRrPxJWN+
	tavtKg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h369r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 09:58:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44R9w3bB030341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 09:58:03 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 02:57:59 -0700
Message-ID: <e3a7c295-28e8-465c-824f-6f14c5977726@quicinc.com>
Date: Mon, 27 May 2024 15:26:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cpufreq: scmi: Avoid overflow of target_freq in fast
 switch
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vivek Aknurwar <quic_viveka@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>
References: <20240520063732.11220-1-quic_jkona@quicinc.com>
 <20240520084744.sb2rk7l2pjf4whyd@vireshk-i7>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <20240520084744.sb2rk7l2pjf4whyd@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q3RuYZYVRENmGCxC65_aA3ClNSet-oU4
X-Proofpoint-ORIG-GUID: q3RuYZYVRENmGCxC65_aA3ClNSet-oU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270081



On 5/20/2024 2:17 PM, Viresh Kumar wrote:
> On 20-05-24, 12:07, Jagadeesh Kona wrote:
>> Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
>> can lead to overflow if the multiplied result is greater than
>> UINT_MAX, since type of target_freq is unsigned int. Avoid this
>> overflow by assigning target_freq to unsigned long variable for
>> converting it to HZ.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes in V2:
>>    - Updated freq variable from u64 to unsigned long to keep it
>>      consistent with the rate parameter in scmi .freq_set() callback
>>    - Link to v1: https://lore.kernel.org/all/20240517070157.19553-1-quic_jkona@quicinc.com/
>> ---
>>   drivers/cpufreq/scmi-cpufreq.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Applied. Thanks.
> 

Thanks Viresh for the offline update on applying this patch to cpufreq 
arm tree. Please help share the git tree details of the same, since we 
need them to pick this change in Google ACK and downstream tree.

Thanks,
Jagadeesh


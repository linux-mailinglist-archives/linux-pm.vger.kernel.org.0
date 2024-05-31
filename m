Return-Path: <linux-pm+bounces-8440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42C8D58F6
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 05:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CB3283D9B
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104143C099;
	Fri, 31 May 2024 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HoWH5/gV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26A10A16;
	Fri, 31 May 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125671; cv=none; b=nxpqAO6MJxKdgglivum4GU3hMecQubErLvZDAKhsIOO1qxPVPY3NqarprevL6QLID+XfND9te4bkzhOR+5MVCbdOmWtcaCNMgystABTb4zrxVs+BS84h0UdhRkvDJZsmHHGIivcMLqlAj51OQCPNXM403V7b/mEOV14PtO/i2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125671; c=relaxed/simple;
	bh=CFk8uapLZ1wRnl8DYYyvWD0srnZFH4IWZ5AUjRAsHv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rybMuStnRO138MF2IsM5oA6DDTa02Nb/xoBOkfklNZHrY+dsaU8r/HpBxDQnj2B50PYhBrG5L4l8zciphBSjBsO8QGbeLCMSWn+cN97ylPY/ziF1IgtiA74vhp1hai2WniVQbtWN+IVr2pNmfbCFsBsdJF6LcqYdgcz4lIH7DjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HoWH5/gV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGrQPS002132;
	Fri, 31 May 2024 03:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Od/dumQFimMpgUyGczAz5M0UXheQzXzMsjnjt6vkaU0=; b=HoWH5/gVB3dImSl/
	9R1HG9bmlQGlBYt23p0nhWJqolP7yhGMszcSx4HpTWa92MQ2sxUFf1XO8xuQb5LJ
	TKoVY+0SbdmMALIaKW+xGILXGtVi8vGl1EVOEUkUPlYVP4FbMD3hUJQF4h987R/H
	xMh8H99Rzb19rjywIw9IlcP512fiK0B4MmansZvwBgrEcce5G6E5bA2mP+qRs6I3
	p72aLUPodm0V1a+aiHOgmV4tVNFH8oPyRI1E30C3q/95jRra9KOwIl1NZbR4x5HJ
	gTwbzZIJSN3LWubwI4tkHv0Gcnf3WESqW2gVr+7zuQOMyH/8PA4nAT4oCeZGDw8I
	p92I9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qnpdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:20:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V3KmHX027462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:20:48 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 20:20:44 -0700
Message-ID: <7d904044-05da-4671-b8de-e752b952b006@quicinc.com>
Date: Fri, 31 May 2024 08:50:30 +0530
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
 <e3a7c295-28e8-465c-824f-6f14c5977726@quicinc.com>
 <20240528040345.ghw6qkha3cka2pe5@vireshk-i7>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <20240528040345.ghw6qkha3cka2pe5@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eFwq2PS58IacrB4C_Bz05nML3rlCZ-Xb
X-Proofpoint-ORIG-GUID: eFwq2PS58IacrB4C_Bz05nML3rlCZ-Xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310024



On 5/28/2024 9:33 AM, Viresh Kumar wrote:
> On 27-05-24, 15:26, Jagadeesh Kona wrote:
>>
>>
>> On 5/20/2024 2:17 PM, Viresh Kumar wrote:
>>> On 20-05-24, 12:07, Jagadeesh Kona wrote:
>>>> Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
>>>> can lead to overflow if the multiplied result is greater than
>>>> UINT_MAX, since type of target_freq is unsigned int. Avoid this
>>>> overflow by assigning target_freq to unsigned long variable for
>>>> converting it to HZ.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>>> Changes in V2:
>>>>     - Updated freq variable from u64 to unsigned long to keep it
>>>>       consistent with the rate parameter in scmi .freq_set() callback
>>>>     - Link to v1: https://lore.kernel.org/all/20240517070157.19553-1-quic_jkona@quicinc.com/
>>>> ---
>>>>    drivers/cpufreq/scmi-cpufreq.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> Applied. Thanks.
>>>
>>
>> Thanks Viresh for the offline update on applying this patch to cpufreq arm
>> tree. Please help share the git tree details of the same, since we need them
>> to pick this change in Google ACK and downstream tree.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> 
> I have pushed it out now, it will be there in linux-next soon. My
> branch is not fixed, I may end up rebasing it. Ideally, you shouldn't
> backport anything to android unless it end ups in Linus's tree, only
> then the sha id will be fixed and guaranteed not to change.
> 

Thanks Viresh!


Return-Path: <linux-pm+bounces-25622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E79A91A49
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392EA3B4D0D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120923814A;
	Thu, 17 Apr 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VqMi5Ok/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B323771C;
	Thu, 17 Apr 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888442; cv=none; b=oCVoICTS09wgDMcIBr4zbWJvmKleKQG117P2qZhEFvhitiDEENJqDyswSYIwcx7wrr4l3r15rZ1wtT6cV2hJZl0UugfcyKXr3/bFSqOm7wT4gMyeeyYhya//GNfkG7YjDwmR9YgpXJ/eO4r7bVOUGL+n+8iuoOj61R8wr7WG1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888442; c=relaxed/simple;
	bh=2sJ2U0EvpEhTQVG9/JgELJW+WflngxUZnimdDk85700=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QsC8O5c8Fr2f7MsclZBRgY751TkdJuhCKi5xqVWn0jZgQAB1bMMFNwYVmA+6wQ1UJIJV6uUl8FfcnzujiX+6g3GpzUSkoPNJOfDROfokR/KMl1lyNCxSjCL9eMbqyV2RxS5oPJRr+vyGCezxQfPvyiAmH3E2QTEaeBXVcHdiQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VqMi5Ok/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5lEqd030241;
	Thu, 17 Apr 2025 11:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4CpzHXoA1ZnrBpdmd8zZ2QRcSHCIdVQ90m1DIUHy2X4=; b=VqMi5Ok/Agu7ts7n
	T4oum788hbwqSEvQMEopOaiKjn7hPqIiWRKD+mphPjZF9VJQo8xcdWDEazTfU+H5
	QCr3RJmF91QPGudhOKZ1S7FS9p8etSqbTRQITAMDMj6I2BgNU4OH9dn1PywLWKNk
	3obexkgN6xdZuIp2c9xCcs26YWxuzIBE5SeoLEJMWaCGi8hYJJIa3RzJZohEc5ei
	TPngcH+gDqD0MO+YiCffe1jnlnAYIjjIbaw9wnwnkBWeLEOIrWgLkCpJB+9KaAgL
	dZdnr0l+Dm4phAvkUCzEYOlhJvNef4AEUpd1XKv1GM6MHxOwKPE9UFgFt9yQfWTf
	xDS7hg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69xp9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:13:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HBDuNQ030878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:13:56 GMT
Received: from [10.133.33.163] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 04:13:54 -0700
Message-ID: <bda36907-d7eb-4969-909b-697eebe14941@quicinc.com>
Date: Thu, 17 Apr 2025 19:13:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: Replace mutex with rt_mutex
To: Mike Tipton <quic_mdtipton@quicinc.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_okukatla@quicinc.com>
References: <20220906191423.30109-1-quic_mdtipton@quicinc.com>
 <3c8965c0-3bc0-252e-381d-bd057fd02af5@kernel.org>
 <20220907145916.GA2368@hu-mdtipton-lv.qualcomm.com>
From: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Content-Language: en-US
In-Reply-To: <20220907145916.GA2368@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: efo0vXhXRsiy9Ndu_quh5Sd20YQJZUEE
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6800e275 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=l4kxOWY4hJXouw1xGfoA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: efo0vXhXRsiy9Ndu_quh5Sd20YQJZUEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170084

On 9/7/2022 10:59 PM, Mike Tipton wrote:
> On Wed, Sep 07, 2022 at 10:35:26AM +0300, Georgi Djakov wrote:
>> Hi Mike,
>>
>> Thanks for the patch!
>>
>> On 6.09.22 22:14, Mike Tipton wrote:
>>> Replace mutex with rt_mutex to prevent priority inversion between
>>> clients, which can cause unacceptable delays in some cases.
>>
>> It would be nice if you have any numbers to share in the commit text.
> 
> I can try to dig up some numbers, but mileage will vary tremendously of
> course. Improvement is really only seen in certain high-concurrency
> scenarios.

We need to revisit this thread because the issue has been reported again
recently.
Here is the data I can provide regarding the performance issue. Please
check if it is sufficient for the commit message to understand the change.
The CFS normal tasks holding the mutex lock were runnable for
approximately 40ms in a busy load scenario, causing the RT task to wait
for the mutex for about 40ms, which resulted in the RT task not being
'real-time' enough and causing janks. Changing the mutex to an RT mutex
helped the caller of the interface, such as icc_set_bw, to ensure that
RT tasks can deliver RT priority to the current RT mutex owner quickly,
thereby improving performance in this scenario.


*Before the change the scenario is like:
 +------------+           +-----------------+


  | RT Task A  |           |Normal cfs task B|
                                                +------------+
+-----------------+


                            mutex_lock(&icc_lock)


  call icc_set_bw()


  wait mutex_unlock(&icc_lock)


                            wait other high priority tasks


                            mutex_unlock(&icc_lock)


  get the lock





*After the change the solution will be like:




   +------------+           +-----------------+


   | RT Task A  |           |Normal cfs task B|


   +------------+           +-----------------+


                          rt_mutex_lock(&icc_lock)


                           wait other high priority task





   call icc_set_bw()


   rt_mutex_lock(&icc_lock)


   -->boost task_B prio


                            Get the chance to run


                             -->mutex_unlock(&icc_lock)


                             -->deboost task_B prio


   get the lock with RT prio

Please comment if more information is needed to apply the current
similar patch. If there are no objections, we can rebase and upload a
new patch set accordingly.
> 
>>
>>> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
>>> ---
>>>
>>> We've run into a number of cases internally and from customers where
>>> high priority, RT clients (typically display) become blocked for long
>>> periods of time on lower priority, non-RT clients. Switching to rt_mutex
>>> has proven to help performance in these cases.
>>
>> I am wondering if avoiding the inversion on this specific lock is the right
>> solution, as there could be other locks that may cause similar issues. Do we
>> see similar issue with clocks for example or is it just with interconnects?

The current issue has been captured in multiple projects, while it has
only been reported in interconnects so far. We need to understand
whether specific mutex locks such as those from clocks, are being called
by RT tasks in any possible scenarios.
> 
> I raised these same concerns internally, since some of the clients
> experiencing delays also request clocks and regulators. However, I
> believe they primarily request interconnects in these critical paths and
> not clocks/regulators. At least not as frequently as they request
> interconnect. Additionally, I suspect the average interconnect latencies
> are higher than clock on our platforms, since interconnect will always
> result in blocking calls to RPM/RPMh. I also wouldn't be surprised if we
> have more consistent contention on interconnect, since certain clients
> update DDR BW quite frequently. I suppose at some point the same
> rt_mutex argument could be made for clock and regulator as well, but
> to-date we've only needed to change interconnect to see improvement.
> 
> I'm not sure what an alternative, generic solution would be. We have
> many clients requesting many different paths. Some are more
> latency-sensitive and higher priority than others. If these use cases
> overlap, then we're subject to these sorts of priority inversion issues.
> Bumping the priority of all clients to match the highest priority one
> isn't really possible.

Based on my understanding, rt_mutex is a good API to solve this type of
issue.

-- 
Thx and BRs,
Aiqun(Maria) Yu


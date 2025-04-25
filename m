Return-Path: <linux-pm+bounces-26211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E85A9C75F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E7A7A1A3A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9886243367;
	Fri, 25 Apr 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QVSZywrF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138742288D5;
	Fri, 25 Apr 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580024; cv=none; b=Z8ebfHmCCgsPNE0gCXuqY0WHSJWWldOJCGIjjdbSQHPsXtOXlFV5MJ9iBIPSywsSnEe8VZggmNeeFk0k45m1GmQxYvPPZwYemz0OgYN3Q1neNqeXnEwCxVBtcMtXnxcngeOA5FITsZuUHilUC+CU7jITLFytxiTYsDVeV/macLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580024; c=relaxed/simple;
	bh=TJZh81SjEZBDNhoT9ldG/mkGWaLykL+jklT1+eZXI38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vi5rkVEIYV31iQOZVyAZ7VPyvn4hurccjKFMmY87Dx89NH4usTUWbhHCpaWfzmr4TqBLc+9+2Fc/VbU5jfGYkOtPFWvL90EOiB7nQhWHCWoMsjXyAr+qsv3QQeLOd+FAdrTHCwVygK5QXVoCt+WWrdtgXMyUSU0rEoUcBbq8MGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QVSZywrF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8T9H6023852;
	Fri, 25 Apr 2025 11:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oQSr+itK2RuL/7zySkrXmf0a0tlBOxk8aa7gHC44CDQ=; b=QVSZywrFH8vDP09C
	FZJS+L6X2WhQKKHhy0dek5Ijh6TZVr2AHUKJfxsgWcDcpholwQUAnFxcvRne+aWd
	Fh7einHAmDWzyAd29q2qjkLl5aXEQ6f9qKey1n9fGHiffYib1d+wVbfbDhqu7gF3
	vY3R4OwBzHyeXegoMS5HXy9NFniwG1SsQBwvBwNPGlZsM78ZlbObpt+1KP+Qx4VV
	jpuM03rLeLb0LtS1862BPG6307f9Trm7KRuMFP3xs322Q90jPRO+n0NltYwBr+dL
	bsMSdWKuvoAXU0qjnop6SE4SGqKYYjlxQPeN841uDDzuZ1CEn3gP9gL9wqId+ZZm
	XUhvdA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1rtgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:20:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53PBKE4K016706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:20:14 GMT
Received: from [10.253.74.112] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 04:20:12 -0700
Message-ID: <fe68d36d-f8b2-42ac-88d9-aeabf3499fd0@quicinc.com>
Date: Fri, 25 Apr 2025 19:20:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs
 latency QoS
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
        <pavel@kernel.org>, <len.brown@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>
 <31742ec7-c1c5-4cb9-8c13-a30b7a6033be@arm.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <31742ec7-c1c5-4cb9-8c13-a30b7a6033be@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sJBj20LxjBKR4w6FHmX0sxSMdrn_TBP6
X-Proofpoint-ORIG-GUID: sJBj20LxjBKR4w6FHmX0sxSMdrn_TBP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MSBTYWx0ZWRfX7uMFVfnMRP86 01wl2i3UKngLMqRlCt6Kei0vc4MMQ/773ieLUqrNMVyv+3EH/AShz3lHSjQ9sqzZfRjYdlXfdbM AZcqCltUVMB8Kis+PEHg2WXtfmyNgwLejyuToEyVaZlCb+WvlVobuTA5er/Pv+yqiy9K8FVGlIR
 whNqFfYea6c1gay74pTq2kLIIOLJ+tFuMChXP4vIdRn4IbIjJ2mZuTTJ8hNUUQPxgiNO4Rj1T9m 913PF80C/J1CYDCN2EQ40MAHQCAlJ7ip2vRmPpCnEGJcx3MCqf/CcGTq5i7j8S72U2mbD/s5lV0 vx34Qc2jGt3U0bwv8R6GVd9nJRzdSDGYZVovjj6hYaUp3sPUg4/tvjlExFgJ6LVP7i0mcmMFUjU
 6P6R5FuDnGWvsn3ZQgbhNoK/lvSc9V55NolnYjEObNVjicUKmul92o7DR7vkNnpaG8kh2cgM
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=680b6fef cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=aQTRFtgv6h2UHWNZ-SkA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=955 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250081

On 4/24/2025 6:25 PM, Christian Loehle wrote:
> On 4/24/25 10:52, Zhongqiu Han wrote:
>> Currently, the PM QoS framework supports global CPU latency QoS and
>> per-device CPU latency QoS requests. An example of using global CPU
>> latency QoS is a commit 2777e73fc154 ("scsi: ufs: core: Add CPU latency
>> QoS support for UFS driver") that improved random io performance by 15%
>> for ufs on specific device platform.
>>
>> However, this prevents all CPUs in the system from entering C states.
>> Typically, some threads or drivers know which specific CPUs they are
>> interested in. For example, drivers with IRQ affinity only want interrupts
>> to wake up and be handled on specific CPUs. Similarly, kernel thread bound
>> to specific CPUs through affinity only care about the latency of those
>> particular CPUs.
>>
>> This patch introduces support for partial CPUs PM QoS using a CPU affinity
>> mask, allowing flexible and more precise latency QoS settings for specific
>> CPUs. This can help save power, especially on heterogeneous platforms with
>> big and little cores, as well as some power-conscious embedded systems for
>> example:
>>
>>                    driver A       rt kthread B      module C
>> QoS cpu mask:       0-3              2-5              6-7
>> target latency:     20               30               50
>>                      |                |                |
>>                      v                v                v
>>                      +---------------------------------+
>>                      |        PM  QoS  Framework       |
>>                      +---------------------------------+
>>                      |                |                |
>>                      v                v                v
>> cpu mask:          0-3            2-3,4-5            6-7
>> actual latency:    20             20, 30             50
>>
>> Implement this support based on per-device CPU latency PM QoS.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> 
> I like the idea!
> The interface does need an in-tree user, why not convert the UFS driver?
> 

Thanks Christian for the review.

As far as I know, the UFS IRQ affinity varies across different
platforms, so a universal solution is needed (we need to investigate
whether there is already a solution or add parameters like intr_mask to
represent the IRQ affinity mask). Let me investigate it, or raise other
user patches as a patch series in PATCH v2 as soon as possible. Thanks


-- 
Thx and BRs,
Zhongqiu Han


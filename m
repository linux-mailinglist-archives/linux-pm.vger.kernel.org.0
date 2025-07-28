Return-Path: <linux-pm+bounces-31475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC4B13923
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3E71890792
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 10:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DDE246BD7;
	Mon, 28 Jul 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YM3FyWew"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B11B0F1E;
	Mon, 28 Jul 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699238; cv=none; b=oz3wYkfcaBHMobjUuQYpWhEs0MkJd/Hhf8Rrm+VFaJaSO/OyH6gxVNOQiQOf2Mooaa27ByIVzQv05ASrrMBXaKpBEV9HaXY+Ua7SSmLNOLo5ZIKqNIcm+PCpp0rskICITeJa1rJs9xCmsGTHtwMx6kxOkVAxYnqa+M64NFffs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699238; c=relaxed/simple;
	bh=ZpdH2IUOs7nJEOce8Lb8z4FCmhrAYwR2CjUSeHLZDPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pvue08J3i4+nXJq8xT2QZ9mq65xnP74drW9U0A2dpzf7x7sGu7FbmutLjYd2lvqJa0DBnXaZuIbNYnMyWA81LOVSnurk3EEfsxzsIXvpsNIQ88EWZkStGaWo+hB2wg+tCQjSXxS7pCQ1qreUwvXwy4x82UF4Ji0WFIQEVUArhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YM3FyWew; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rNqq016874;
	Mon, 28 Jul 2025 10:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s8cS8tfgNQE29TK9RkGVU1PGvKe/8A7mwK9kLQpNRzw=; b=YM3FyWewkEQsJT6W
	OuZEY2w/jHcxBkH8XHIRCbnq8UUWXaBbJudSdZanyXTitj7O0EBZWrpa2N10uKZX
	3QhMX+RxLUxxuMSynS/7NJThJiiqB3lJ6OZ0/6TnfCALP7jfXXlD5g52s83ZMSqJ
	drLNHNiUBr3G+J+xmyeL8Ku4iS4810gW6eNDNPlb1i86sg65afH3r3VCDtcH1KsU
	X6FhFin2HC8Ecn6JIBHqdsDTjWLJL7/esPpkLK5DtLpyKSrY48jOaGyq6DBI6aUh
	dAeuYUqe2hR/ukYOTlHfbrpc7uS0JTFKJGMvLADdT2hj1R00yy4d6Q5hiTrHKOF8
	1bk2rw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ensfnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 10:40:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56SAeSsx009435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 10:40:28 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 28 Jul
 2025 03:40:25 -0700
Message-ID: <819fb853-59f7-4296-8499-715c142487f5@quicinc.com>
Date: Mon, 28 Jul 2025 18:40:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <pavel@kernel.org>, <tony.luck@intel.com>,
        <reinette.chatre@intel.com>, <Dave.Martin@arm.com>,
        <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhongqiu Han
	<quic_zhonhan@quicinc.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <2379088e-e5d0-4766-9968-756aad04f9a3@arm.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <2379088e-e5d0-4766-9968-756aad04f9a3@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u-Ysbr_cc1Z2GwNUlFEZC5q8GoPFtOjT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3NyBTYWx0ZWRfXylhAN+Lv2Dj2
 a2Xx0iKiJi4MOVXN8oR2saTSxsqI1Or8sRg0NMBNcBYquqbKcT6Iv+ASiiXwyBdYL7RDFS9pUBJ
 BTnU6+AgJ+ocP5uOe403TkZM+5yixYN55bR3DT0HkmvlQj1q/ztCgXkr/No7nyZB00RaUz/Lcwd
 hQB2rzzrBlOFO14D5rSJB1V2rQE8dfV6vRu9ooTVY5Q2oXv6F9BzpavSKorwmOxasfb+gxLCta1
 mwTtAKYj0BH6QbwFJLGhEcOWpUa974aawxY2Bq+5+QsdGnPVvlgL5PIzBodV5IuPGSZsK1BRzhA
 rgVq2PLEha84aIc8hxOPDd2T2OgZxSINe78NMx8kTbsFdDOBGK58uXdEQlioODbnAvHNcvNOwc8
 RcXhN14NJOEpKKoB9WH+CS1r7FYS11MFgtQupR3WcLspb9q5pgBEYbIVY18gvfv3DlvdnQuA
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6887539c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=xf8G_7bVrPfR0LIrT9wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: u-Ysbr_cc1Z2GwNUlFEZC5q8GoPFtOjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280077

On 7/28/2025 6:09 PM, Christian Loehle wrote:
> On 7/21/25 13:40, Zhongqiu Han wrote:
>> Hi all,
>>
>> This patch series introduces support for CPU affinity-based latency
>> constraints in the PM QoS framework. The motivation is to allow
>> finer-grained power management by enabling latency QoS requests to target
>> specific CPUs, rather than applying system-wide constraints.
>>
>> The current PM QoS framework supports global and per-device CPU latency
>> constraints. However, in many real-world scenarios, such as IRQ affinity
>> or CPU-bound kernel threads, only a subset of CPUs are
>> performance-critical. Applying global constraints in such cases
>> unnecessarily prevents other CPUs from entering deeper C-states, leading
>> to increased power consumption.
>>
>> This series addresses that limitation by introducing a new interface that
>> allows latency constraints to be applied to a CPU mask. This is
>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>> embedded systems where power efficiency is critical for example:
>>
>>                          driver A       rt kthread B      module C
>>    CPU IDs (mask):         0-3              2-5              6-7
>>    target latency(us):     20               30               100
>>                            |                |                |
>>                            v                v                v
>>                            +---------------------------------+
>>                            |        PM  QoS  Framework       |
>>                            +---------------------------------+
>>                            |                |                |
>>                            v                v                v
>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>    runtime latency(us):   20             20, 30             100
>>
>> The current implementation includes only cpu_affinity_latency_qos_add()
>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>> planned for future submission, along with PM QoS optimizations in the UFS
>> subsystem.
> 
> So what's needed for the UFS use-case additionally?
> Would adding that here be too much?
> 

Hi Christian,
Thanks for your review and discussion~

Currently my plan is only to move forward with the current patch series,
which includes only the below interfaces:

cpu_affinity_latency_qos_add()
cpu_affinity_latency_qos_remove()
cpu_affinity_latency_qos_active()


For most use-cases, seems these three interfaces already sufficient.


The reason I mentioned UFS is to explain why the update
interface cpu_affinity_latency_qos_update()

is not included at this stage. The UFS use-case is planned to
use the cpu_affinity_latency_qos_update() interface in the future, which
is similar to the global CPU PM QoS interface
cpu_latency_qos_update_request().



-- 
Thx and BRs,
Zhongqiu Han


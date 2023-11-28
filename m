Return-Path: <linux-pm+bounces-347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE47FB549
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 10:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7AF1F20FBC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6D3D39A;
	Tue, 28 Nov 2023 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BytLajBi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672D7AB;
	Tue, 28 Nov 2023 01:12:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS8xC52028057;
	Tue, 28 Nov 2023 09:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AqfsZhfJIV0ah8Mcq2ahxjWlSq2ikPRbgAL9ct0yCb4=;
 b=BytLajBiDBIkAvT8ar4pqExWzyliSVFA3VGWJxDU4m9cU+4SbYWXcviucRqHk/riR+w/
 jR+/9kGqB6jRDAoElZba5BzEeN+gGU4yWTQgI8WqW3hhN085W+pJMYwFznMl0UL77LUh
 woPZ/eMIe4IeKetBDYAa/Ze48iCGFmvfZwqiJNAYhlv/tQMr82k3EoxybJCzlYQYSIa6
 +8A5s4rN9xGhEyJM/TR62PaTZUsRp/M6n3X3OwTTatpjzQe1Cq5BybMk46WjC14b1kD5
 L5k9dlz02k3IfsSQNcCI65PD7ecEJzX7yFG75WBglE7q/9Y0uI/NLwxU2Zq9wjMVH9zG yg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt4qjx6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 09:12:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS9C5Dd016438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 09:12:05 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 01:12:03 -0800
Message-ID: <a86228f5-c1ae-4afe-87bd-5144633a9601@quicinc.com>
Date: Tue, 28 Nov 2023 17:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] freezer,sched: do not restore saved_state of a thawed
 task
To: Elliot Berman <quic_eberman@quicinc.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar
	<mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: <linux-arm-msm@vger.kernel.org>,
        Pavan Kondeti
	<quic_pkondeti@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Abhijeet Dharmapurikar
	<quic_adharmap@quicinc.com>
References: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
From: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tb538e39X4vhm4jHaQHO2TqEhx3aRRHW
X-Proofpoint-GUID: tb538e39X4vhm4jHaQHO2TqEhx3aRRHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_08,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=831 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280071

On 11/21/2023 1:36 AM, Elliot Berman wrote:
> This series applies couple fixes to commit 8f0eed4a78a8 ("freezer,sched:
> Use saved_state to reduce some spurious wakeups") which was found while
> testing with legacy cgroup freezer. My original testing was only with
> system-wide freezer. We found that thaw_task could be called on a task
> which was already frozen. Prior to commit 8f0eed4a78a8 ("freezer,sched:
> Use saved_state to reduce some spurious wakeups"), this wasn't an issue
> as kernel would try to wake up TASK_FROZEN, which wouldn't match the
> thawed task state, and no harm done to task. After commit 8f0eed4a78a8
> ("freezer,sched: Use saved_state to reduce some spurious wakeups"), it
> was possible to overwrite the state of thawed task.
> 
> To: Rafael J. Wysocki <rafael@kernel.org>
> To: Pavel Machek <pavel@ucw.cz>
> To: Ingo Molnar <mingo@kernel.org>
> To: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc:  <linux-arm-msm@vger.kernel.org>
> Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc:  <linux-pm@vger.kernel.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Shall we add Fixed tag and Cc: stable@vger.kernel.org ?
Since it is fixing a stable user thread hung issue.
> 
> Originally sent to only linux-arm-msm, resending to correct authors.
> - Link to v1: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-0-a4c453f50745@quicinc.com
> 
> ---
> Elliot Berman (2):
>        freezer,sched: do not restore saved_state of a thawed task
>        freezer,sched: clean saved_state when restoring it during thaw
> 
>   kernel/freezer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> ---
> base-commit: 6d7e4782bcf549221b4ccfffec2cf4d1a473f1a3
> change-id: 20231108-freezer-state-multiple-thaws-7a3a8d9dadb3
> 
> Best regards,

-- 
Thx and BRs,
Aiqun(Maria) Yu



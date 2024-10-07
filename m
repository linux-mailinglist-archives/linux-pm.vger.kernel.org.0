Return-Path: <linux-pm+bounces-15290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9CE9934C7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 19:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE04D282738
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2401DCB30;
	Mon,  7 Oct 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IQTpJbB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F851DD523;
	Mon,  7 Oct 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321645; cv=none; b=hpIJDKSHK9dEXoRK1Aa63Y008XY1Dq+qgLu7f0MgFlCswTbFT2H1AmHQkH7wbuOrtj8LGEcFCpP2PDXzE2GWXZpjK6ZmP/9YzZaCTwaMQkhpYn9j/t3bBSuphKSM7jMduTG9KimO8Z1n/c51yNldCZCdZuFTHG/NoNceIBbPb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321645; c=relaxed/simple;
	bh=BiWtr4IVq/5xsgaa3fV0CRaC4Xyzet6pkUEDfK38hs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLv2TxBJnBt7ckErol67xvp+SgImQbrKvAt+SV9kEUuVXCCTuWtNOjrqiAEMhcSm+KCOI62/lYDEQ2M7oYDYZUCjiejibreGqplTCMbsZUnVXERjqnxRDGZv0D1G5Cq2vZR8eKQi0fWb+RPiq307QS/7Q38QbHfYuas9lEqUPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IQTpJbB8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497Gp6sJ026632;
	Mon, 7 Oct 2024 17:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=B
	iWtr4IVq/5xsgaa3fV0CRaC4Xyzet6pkUEDfK38hs4=; b=IQTpJbB8enCB8eIe5
	TM9cZLlsiuhRrkwpZUnTTuD4yHMdxnpz2bZUbpzFmMAOcSxrtRS/h5fQ5mDlPyhu
	N22jTxVXsInbS79nFqkg/MOEXzBpfrq0sICEQWWX/O7zAgXpdeqhxipUiVFJPQ/G
	VkXPGnwZrpZCPT4EJ5BDTvBGfB4p3otISAMHFjfafGux4GgU+e382JXPabPi/idE
	ql+QEr+4dquq6u3bNhuluRtgUCdjManO1l/lKjiW7EW836749y3QIFiV93l8ru7F
	t+CenrHC+b/Hv1eNHBtnTP8J+Uz/i3CT1Q3AAKeUpqCuq/c/muui9b2Ro8a+BRja
	tZhug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424kgyg5c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 17:20:20 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497HKJfc022703;
	Mon, 7 Oct 2024 17:20:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424kgyg5c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 17:20:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497FUWrN022852;
	Mon, 7 Oct 2024 17:20:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0qjf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 17:20:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497HKGtn49152382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 17:20:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDE5420043;
	Mon,  7 Oct 2024 17:20:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FAB620040;
	Mon,  7 Oct 2024 17:20:13 +0000 (GMT)
Received: from [9.39.16.71] (unknown [9.39.16.71])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 17:20:13 +0000 (GMT)
Message-ID: <ae65e4aa-3407-4fb0-b1f1-eb7c2626f768@linux.ibm.com>
Date: Mon, 7 Oct 2024 22:50:11 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
Content-Language: en-US
From: Anjali K <anjalik@linux.ibm.com>
In-Reply-To: <20240728184551.42133-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ty1IRVPvPrRYZTNQU7ANS6Pxd5XiQ0w0
X-Proofpoint-ORIG-GUID: FYLorLhiWLWSPUEUUKsj3t3mlEz4qhjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=599 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070121

Hi, I tested this patch to see if it causes any regressions on bare-metal power9 systems with microbenchmarks.
The test system is a 2 NUMA node 128 cpu powernv power9 system. The conservative governor is enabled.
I took the baseline as the 6.10.0-rc1 tip sched/core kernel.
No regressions were found.

+------------------------------------------------------+--------------------+----------+
|                     Benchmark                        |      Baseline      | Baseline |
|                                                      |  (6.10.0-rc1 tip   | + patch  |
|                                                      |  sched/core)       |          |
+------------------------------------------------------+--------------------+----------+
|Hackbench run duration (sec)                          |         1          |   1.01   |
|Lmbench simple fstat (usec)                           |         1          |   0.99   |
|Lmbench simple open/close (usec)                      |         1          |   1.02   |
|Lmbench simple read (usec)                            |         1          |   1      |
|Lmbench simple stat (usec)                            |         1          |   1.01   |
|Lmbench simple syscall (usec)                         |         1          |   1.01   |
|Lmbench simple write (usec)                           |         1          |   1      |
|stressng (bogo ops)                                   |         1          |   0.94   |
|Unixbench execl throughput (lps)                      |         1          |   0.97   |
|Unixbench Pipebased Context Switching throughput (lps)|         1          |   0.94   |
|Unixbench Process Creation (lps)                      |         1          |   1      |
|Unixbench Shell Scripts (1 concurrent) (lpm)          |         1          |   1      |
|Unixbench Shell Scripts (8 concurrent) (lpm)          |         1          |   1.01   |
+------------------------------------------------------+--------------------+----------+

Thank you,
Anjali K



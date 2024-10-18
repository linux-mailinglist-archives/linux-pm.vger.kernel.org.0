Return-Path: <linux-pm+bounces-15987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F49A45F0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8513B22855
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8B201101;
	Fri, 18 Oct 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="He7HI+Uw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6F20E338;
	Fri, 18 Oct 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276356; cv=none; b=I7FSReQoXssRVJ135Wtkm55+ZXvU3cbpq/MCaFj/72krTDRCVGtHEHvnkPl0wGcCwCFNucp1c2DEDytXn+QM0HL7uFUJot87Sj9iWpS6Kj9YS4kbIrVriXackzgxo79jVArcdPNoMrrL1W2I8xOJlo7bc7ymEkHhTuvJvq5JeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276356; c=relaxed/simple;
	bh=ZwknKRBj45yWIN8VEOzJN4ZADwXRcELqseQtTwYHpjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyzJtY/L5PwVegkw0UvNAPWmGk0JvYCyaSkqlB4vSGXjObwpqo0wRPYCL6Hza+mMpLaa1AZmtTYRg1OCIDmMFEPsXG1CBNRbHtpUTXYzSYRubQrSI1qBg1Fts2CUtc67Whs0GNCboO/qnX1Ht6CRhPGAItcT69p6ZcGe/7DEu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=He7HI+Uw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IArN53025075;
	Fri, 18 Oct 2024 18:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZwknKR
	Bj45yWIN8VEOzJN4ZADwXRcELqseQtTwYHpjQ=; b=He7HI+UwwBA7YA/87gJ38w
	QLL+f3incrA8Pi1O/1AYj/i8wSy4i5S6PGg6v7TI9LVQEi//GxSvLcsGrIzIPSUL
	mbJTYvW1Umt42voDLoGmIwCpuKQideNrsV1dH4+8KX/OMvOUhPUSo4AAKBSzYulg
	sTmeg4KGYFSOx1cCAgfdUkLLpk3JFcejz1Sx5aBD6qH4VZgELFy5Tam0E7noeP8u
	ly1BA8Zba+3Cd6tqU2TvTNrYiyWdOB6g1AO6AF7I54QLYMziEWkKf/Fksk87xFwb
	pOzgoEygPDXw1CL8KtStz3meXv+Y7ry/g+Khy8cTHSCSokO86J7F5czaoAL3zrPw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbdaycu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 18:32:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IIWHqU031157;
	Fri, 18 Oct 2024 18:32:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbdaycr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 18:32:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIBf24005965;
	Fri, 18 Oct 2024 18:32:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651dtk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 18:32:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IIWEuJ54657312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 18:32:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7DF82005A;
	Fri, 18 Oct 2024 18:32:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5625420040;
	Fri, 18 Oct 2024 18:32:11 +0000 (GMT)
Received: from [9.124.220.53] (unknown [9.124.220.53])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 18:32:11 +0000 (GMT)
Message-ID: <a1cac0d3-c17d-478e-8a6b-40399a9428b6@linux.ibm.com>
Date: Sat, 19 Oct 2024 00:02:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Christian Loehle <christian.loehle@arm.com>,
        Qais Yousef <qyousef@layalina.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ae65e4aa-3407-4fb0-b1f1-eb7c2626f768@linux.ibm.com>
 <fa2f15b1-1602-4fd0-80ff-9d33303b7b5a@arm.com>
Content-Language: en-US
From: Anjali K <anjalik@linux.ibm.com>
In-Reply-To: <fa2f15b1-1602-4fd0-80ff-9d33303b7b5a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U1Aid8jIKUqdZvN0_BzTP6eYltAiJ7pt
X-Proofpoint-GUID: eqVF1Twp3eD4Y-fo-Z2SKsoSRmU8IRaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=975
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180116

On 08/10/24 15:26, Christian Loehle wrote:
> The default CPUFREQ_DBS_MIN_SAMPLING_INTERVAL is still to have 2 ticks between
> cpufreq updates on conservative/ondemand.
> What is your sampling_rate setting? What's your HZ?
The sampling_rate setting is 8000 us.
CONFIG_HZ is set to 250 Hz.
> Interestingly the context switch heavy benchmarks still show -6% don't they?
Yes, stress-ng and Unixbench Pipebased Context Switching benchmarks showed 6% regression. There was a high run-to-run variation in stress-ng and the Unixbench Pipebased Context Switching benchmarks of 15% and 5% respectively. This led me to doubt those results and so I re-ran these two benchmarks.

Each run below is an average of 10 iterations of the benchmarks.
The results are as follows:
+------------------------------------------------------+--------------------+----------+--------+---------+----------------+
|                     Benchmark                        |      Baseline      | Baseline +   |Baseline|Baseline | Throughput |
|                                                      |  (6.10.0-rc1 tip   |    patch     |        |+ patch  |Difference %|
|                                                      |  sched/core)       |              |stdev % | stdev % |            |
|                                                      |  avg throughput    |avg throughput|        |         |            |    
+------------------------------------------------------+--------------------+--------------+--------+---------+------------+
|Unixbench Pipebased Context Switching throughput (lps)|         1          |     1.02     |   6.48 |  10.29  |    2.18    |
|                                                      |         1          |     1.19     |  13.74 |   8.22  |   19.20    |
|                                                      |         1          |     0.87     |  11.27 |   8.12  |  -13.24    |
|                                                      |                    |              |        |         |            |
|stressng (bogo ops)                                   |         1          |     1.01     |  2.68  |  1.90   |    1.35    |
|                                                      |         1          |     0.98     |  2.29  |  4.26   |   -2.03    |
|                                                      |         1          |     0.99     |  2.01  |  2.24   |   -0.56    |
+------------------------------------------------------+--------------------+--------------+--------+---------+------------+                   
There is a very high run-to-run variation in the Unixbench Pipebased Context
Switching benchmark and we can't conclude anything from this benchmark.
There is no regression in stress-ng on applying this patch on this system.

> Do you mind trying schedutil with a reasonable rate_limit_us, too?

I think the schedutil governor is not working on my system because the cpu
frequency shoots to the maximum (3.9GHz) even when the system is only 10%
loaded.
I ran stress-ng --cpu `nproc` --cpu-load 10.
The mpstat command shows that the system is 10% loaded:
10:55:25 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:56:50 AM  all   10.03    0.00    0.02    0.00    0.18    0.00    0.00    0.00    0.00   89.76
But cpupower frequency-info showed that the system is at max frequency
root@ltczz10:~# cpupower frequency-info
<snipped>
  available cpufreq governors: conservative ondemand performance schedutil
  current policy: frequency should be within 2.30 GHz and 3.90 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: 3.90 GHz (asserted by call to hardware)
<snipped>
This is not expected, right?
I will work on finding out why the schedutil governor is not working on
this system and get back.

Thank you for your response,
Anjali K



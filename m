Return-Path: <linux-pm+bounces-18025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6B9D7B8D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 07:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E94162921
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42E38382;
	Mon, 25 Nov 2024 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGz2L3fk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1122500DE;
	Mon, 25 Nov 2024 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516364; cv=none; b=GYJi7MLV6NQ8x6t/e96E8hOq/jJ/tK1V3+ocaZ+zZVX4rFcGkFCRK7AeR/yuqYokFq7YEzgyiGg1FNWubxnwW7qlEST6XKMbt3eH1cbAjf5WxM13RX5ftOf8cqZ9Kdi4Q4n17I//q4/8RsErhihzBjAZjjA9qsLBaOOfdtuy7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516364; c=relaxed/simple;
	bh=ayX8poqt/2duoplls0XbaSyfTU+NTTv8T+bVE1sx8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UizrqQwz4uxfiQVJiAh6wUQDRbXPlHRaDNs1GYz4ZB064q9eMwjQxYV7UI8u7zo/mSiEDbjXLbEylr19Db79gviLW7n7qwJPn4bdd6crevfHTQwJiMnHi7uyDFb1yuW7zJekd0TcKwNS/QLwkwxc+B0NSnrgNQMzirU4LsCda6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGz2L3fk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP5HM3E011278;
	Mon, 25 Nov 2024 06:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ayX8po
	qt/2duoplls0XbaSyfTU+NTTv8T+bVE1sx8Gg=; b=pGz2L3fk1ANpJqj4VSh8W1
	FRt5ah/JbsLOne1cy0lh5az6Cf4SRn9sNEgyUQPQPIQ+3NMwWpJ9bdDThFuIrKJ/
	S/EjcRo5K70YLJDALv7CDEiyvOOCSfkBXpitDV+vNdI82NLfkQkHU09uIj7Q7QX/
	cLGC/jksH9WnF26zwuv5mDD2PIlU1FMsJQkEPQfh04Hfus3MoHVND3GawHdEMOOY
	al7v9u5oZ2iynxszWYxNRg2WdgYg2EmP27UKRmvLS/Mt80rz0X+EkFU6s5Z09lLG
	xHlGGiCOAW2twUDRvsEupZExOvjp8sh3t/2DbZvVuSX9Qf5OPFNXySFIgdIWM+VA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n6ttp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:32:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AP6VbNB009177;
	Mon, 25 Nov 2024 06:32:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n6ttj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:32:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP5QRHd027210;
	Mon, 25 Nov 2024 06:32:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 433ukj1xfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:32:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AP6WNQX50594238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 06:32:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F60720049;
	Mon, 25 Nov 2024 06:32:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3AB20040;
	Mon, 25 Nov 2024 06:32:19 +0000 (GMT)
Received: from [9.109.204.70] (unknown [9.109.204.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 06:32:19 +0000 (GMT)
Message-ID: <886aa016-a439-4981-892d-3e92df526f41@linux.ibm.com>
Date: Mon, 25 Nov 2024 12:02:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
From: Anjali K <anjalik@linux.ibm.com>
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
 <a1cac0d3-c17d-478e-8a6b-40399a9428b6@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a1cac0d3-c17d-478e-8a6b-40399a9428b6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 39T-hClF59H4MkQy9cvEim0Y7teHx8il
X-Proofpoint-ORIG-GUID: zejLQytzzKW6aUA1hOiFPf6Wjwn2opAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250053

On 19/10/24 00:02, Anjali K wrote:
>> Do you mind trying schedutil with a reasonable rate_limit_us, too?
> I think the schedutil governor is not working on my system because the cpu
> frequency shoots to the maximum (3.9GHz) even when the system is only 10%
> loaded.
> I ran stress-ng --cpu `nproc` --cpu-load 10.
> The mpstat command shows that the system is 10% loaded:
> 10:55:25 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 10:56:50 AM  all   10.03    0.00    0.02    0.00    0.18    0.00    0.00    0.00    0.00   89.76
> But cpupower frequency-info showed that the system is at max frequency
> root@ltczz10:~# cpupower frequency-info
> <snipped>
>   available cpufreq governors: conservative ondemand performance schedutil
>   current policy: frequency should be within 2.30 GHz and 3.90 GHz.
>                   The governor "schedutil" may decide which speed to use
>                   within this range.
>   current CPU frequency: 3.90 GHz (asserted by call to hardware)
> <snipped>
> This is not expected, right?
> I will work on finding out why the schedutil governor is not working on
> this system and get back.
Hi, I found that the schedutil governor is working on this system. I 
concluded this because when I printed the util parameter passed in
get_next_freq() when running stress-ng --cpu `nproc` --cpu-load 10, the
util parameter was always 1024 ( equal to the cpu capacity) and so the
frequency gets set to the maximum as expected. Adding `--cpu-load-slice 10`
to the stress-ng commandline, I got lower util values and found that the
frequency is being set as per the system load as shown below:

+-------------+------------+------------+
|  stress-ng  |    avg     | run-to-run |
|   load %    |  cpu freq  |  std dev%  |
|             |    (Hz)    |            |   
+-------------+------------+------------+   
|     10%     |    2.80    |    1.51    |   
|     30%     |    3.53    |    2.47    |   
|     50%     |    3.70    |    0.01    |   
|     70%     |    3.61    |    0.08    |   
|     90%     |    3.54    |    0.04    |   
+-------------+------------+------------+  
Note that the frequency range for this system is 2.3GHz - 3.9Ghz.

The results with the schedutil governor for the same set of benchmarks is
as follows. Each benchmark is run 3 times:
+------------------------------------------------------+--------------------+----------+--------+---------+------------+
|                     Benchmark                        |      Baseline      | Baseline |Baseline|Baseline |Regression% |                                                                                          
|                                                      |  (6.10.0-rc1 tip   | + patch  |        |+ patch  |            |
|                                                      |  sched/core)       |          |stdev % | stdev % |            |
+------------------------------------------------------+--------------------+----------+--------+---------+------------+
|Hackbench run duration (sec)                          |         1          |   1.01   |  1.60  |  1.80   |    0.69    |
|Lmbench simple fstat (usec)                           |         1          |   0.99   |  0.40  |  0.07   |   -0.66    |
|Lmbench simple open/close (usec)                      |         1          |   0.99   |  0.01  |  0.04   |   -0.51    |
|Lmbench simple read (usec)                            |         1          |   1      |  0.23  |  0.41   |   -0.05    |
|Lmbench simple stat (usec)                            |         1          |   0.98   |  0.13  |  0.03   |   -1.54    |
|Lmbench simple syscall (usec)                         |         1          |   0.99   |  0.89  |  0.69   |   -0.59    |
|Lmbench simple write (usec)                           |         1          |   1      |  0.27  |  0.80   |    0       |
|Unixbench execl throughput (lps)                      |         1          |   1      |  0.44  |  0.13   |    0.17    |
|Unixbench Process Creation (lps)                      |         1          |   0.99   |  0.11  |  0.13   |   -0.68    |
|Unixbench Shell Scripts (1 concurrent) (lpm)          |         1          |   1      |  0.07  |  0.05   |    0.03    |
|Unixbench Shell Scripts (8 concurrent) (lpm)          |         1          |   1      |  0.05  |  0.11   |   -0.13    |
+------------------------------------------------------+--------------------+----------+--------+---------+------------+
I did not see any significant improvements/regressions on applying the patch.
I ignored the Stress-ng and Unixbench Pipebased Context Switching
benchmarks as they showed high run-to-run variation with the schedutil
governor (without applying the patch) of 10.68% and 12.5% respectively.

Thank you,
Anjali K


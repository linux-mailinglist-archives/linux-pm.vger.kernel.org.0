Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7345EE2BF3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 10:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438078AbfJXITs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 04:19:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbfJXITs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 04:19:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9O8GMhx053168
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 04:19:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vu74m2t2v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 04:19:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 24 Oct 2019 09:19:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 09:19:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9O8Jdef23134452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 08:19:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1962E4C04A;
        Thu, 24 Oct 2019 08:19:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85EA54C04E;
        Thu, 24 Oct 2019 08:19:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.94])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Oct 2019 08:19:35 +0000 (GMT)
Subject: Re: [Discussion v2] Usecases for the per-task latency-nice attribute
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        tim.c.chen@linux.intel.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, vincent.guittot@linaro.org, pavel@ucw.cz,
        David.Laight@ACULAB.COM, mingo@redhat.com,
        morten.rasmussen@arm.com, pjt@google.com, dietmar.eggemann@arm.com,
        tj@kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, dhaval.giani@oracle.com,
        qperret@qperret.net, ggherdovich@suse.cz, viresh.kumar@linaro.org,
        Doug Smythies <dsmythies@telus.net>
References: <2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com>
Date:   Thu, 24 Oct 2019 13:49:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102408-0020-0000-0000-0000037DADA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102408-0021-0000-0000-000021D3F2E8
Message-Id: <376e1a37-8f7d-3cbc-9d9d-dd349afb9b3b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240079
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/30/19 4:13 PM, Parth Shah wrote:
> Hello everyone,
> 
> This is the v2 of the discussion started for introducing per-task
> latency-nice attribute for providing scheduler hints.
> 
> v1: https://lkml.org/lkml/2019/9/18/555
> 
> In brief, we face two challenges with the introduction of such attr.
> 
> 1. Name:
> ==============
> ( Should be relevant to all the possible usecases, not confuse end-user and
> reflect the functionality it provides to the scheduler behaviour )
> 
> Curated list of proposed names:
> 
> 1. latency-nice:
>    should have a better understanding based on pre-existing concepts
> 
> - But poses two interpretation ambiguity
>   a) -20 (least nice to latency, i.e. sacrifice latency for throughput)
>      +19 (most nice to latency, i.e. sacrifice throughput for latency)
>   b) -20 (least nice to other task in terms of sacrificing latency, i.e.
> 	  latency-sensitive)
>      +19 (most nice to other tasks in terms of sacrificing latency, i.e.
> 	  latency-forgoing)
> 
> 2. latency-tolerant:
>    decouples a bit its meaning from the niceness thus giving maybe a bit
>    more freedom in its complete definition and perhaps avoid any
>    possible interpretation confusion
> 
> 3. latency-nasty
> 
> 4. latency-sensible

+ 5. temper
     -20 (short temper, angry tasks, i.e., requires least latency)
     +19 (calm tasks, i.e., sacrifice latency for throughput)

> 
> 
> 
> 2. Value(s):
> ==============
> ( Boolean/Ternary, Range of values, profile tagging )
> 
> - Recent discussion plots the range of [-20, 19] to be the most agreed upon.
> 
> 1. Range:
> - [-20, 19]:
>     Which has similarities with the niceness concept and gives a minimal
>     continuous range. This can be on hand for things like scaling the
>     vruntime normalization [3]
> 
> 2. Profile tagging:
> - Can be used just like a flag attribute
>   e.g., Background, foreground, latency-sensible, reduce-idle-search, etc.
> 
> 3. Binary:
> - 0 for: Latency sensitive/sensible/in-tolerant/hungry...
> - 1 for Latency insensitive/insensible/tolerant/nice-to-others/...
> 
>   Ternary:
> -  0: no effect
> - -1: require least latency
> - +1: no restrictions in terms of lower/higher latency
> 
> [...]

I guess the latency-tolerant name seems to be more relevant and the range
[-20,19] will suit all the discussed usecases.
( ( ( tomatoes target here ) ) )

If this seems alright then I am thinking of writing out some patches to
introduce p->latency-tolerant with the use of "sched_setattr" syscall.


Thanks,
Parth


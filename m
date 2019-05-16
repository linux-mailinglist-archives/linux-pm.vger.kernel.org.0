Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C454020C87
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfEPQGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 12:06:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbfEPQGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 12:06:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GG56OR033609
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 12:06:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sh9auwawn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 12:06:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 16 May 2019 17:05:38 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 17:05:35 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GG5Yv948365702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 16:05:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E85DB5204E;
        Thu, 16 May 2019 16:05:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0BEC65205A;
        Thu, 16 May 2019 16:05:31 +0000 (GMT)
Subject: Re: [RFCv2 0/6] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515164854.GZ2589@hirez.programming.kicks-ass.net>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 16 May 2019 21:35:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190515164854.GZ2589@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051616-0012-0000-0000-0000031C671D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051616-0013-0000-0000-000021550957
Message-Id: <82883320-fb98-ec7b-ad1a-0c4248a0225b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160102
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/19 10:18 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:16PM +0530, Parth Shah wrote:
>> Abstract
>> ========
>>
>> The modern servers allows multiple cores to run at range of
>> frequencies higher than rated range of frequencies. But the power budget
>> of the system inhibits sustaining these higher frequencies for
>> longer durations.
>>
>> However when certain cores are put to idle states, the power can be
>> effectively channelled to other busy cores, allowing them to sustain
>> the higher frequency.
>>
>> One way to achieve this is to pack tasks onto fewer cores keeping others idle,
>> but it may lead to performance penalty for such tasks and sustaining higher
>> frequencies proves to be of no benefit. But if one can identify unimportant low
>> utilization tasks which can be packed on the already active cores then waking up
>> of new cores can be avoided. Such tasks are short and/or bursty "jitter tasks"
>> and waking up new core is expensive for such case.
>>
>> Current CFS algorithm in kernel scheduler is performance oriented and hence
>> tries to assign any idle CPU first for the waking up of new tasks. This policy
>> is perfect for major categories of the workload, but for jitter tasks, one
>> can save energy by packing it onto active cores and allow other cores to run at
>> higher frequencies.
>>
>> These patch-set tunes the task wake up logic in scheduler to pack exclusively
>> classified jitter tasks onto busy cores. The work involves the use of additional
>> attributes inside "cpu" cgroup controller to manually classify tasks as jitter. 
> 
> Why does this make sense? Don't these higher freq bins burn power like
> stupid? That is, it makes sense to use turbo-bins for single threaded
> workloads that are CPU-bound and need performance.
> 
> But why pack a bunch of 'crap' tasks onto a core and give it turbo;
> that's just burning power without getting anything back for it.
> 

Thanks for taking interest in my patch series.
I will try my best to answer your question.

This patch series tries to pack jitter tasks on the busier cores to avoid waking
up any idle core as long as possible. This approach is supposed to give more
performance to the CPU bound tasks by sustaining Turbo for a longer duration.

Current implementation for task wake up is biased towards waking an idle CPU first,
which in turn consumes power as the CPU leaves idle domain.
For the system supporting Turbo frequencies, power budget is fixed and hence to
maintain this budget the system may throttle the frequency.

So the idea is, if we can pack the jitter tasks on already running cores, then we
can avoid waking up new cores and save power thereby sustaining Turbo for longer
duration.


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AC7F5CD
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfHBLMN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 07:12:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731048AbfHBLMN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 07:12:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72B7tBo069328
        for <linux-pm@vger.kernel.org>; Fri, 2 Aug 2019 07:12:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4k7mt72m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2019 07:12:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 2 Aug 2019 12:12:09 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 12:12:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72BC42n38994170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 11:12:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5EBD11C058;
        Fri,  2 Aug 2019 11:12:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D08CA11C050;
        Fri,  2 Aug 2019 11:12:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.31.193])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 11:12:01 +0000 (GMT)
Subject: Re: [RFC v4 0/8] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
To:     Pavel Machek <pavel@ucw.cz>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
References: <20190725070857.6639-1-parth@linux.ibm.com>
 <20190728133102.GD8718@xo-6d-61-c0.localdomain>
 <4fcd3488-6ba0-bc22-a08d-ceebbce1c120@linux.ibm.com>
 <20190731173225.GB24222@amd>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 2 Aug 2019 16:42:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190731173225.GB24222@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080211-0008-0000-0000-00000303B0EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080211-0009-0000-0000-00002272B768
Message-Id: <7a7c5c57-0337-6733-e494-b0759cf83931@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020115
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/31/19 11:02 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Abstract
>>>> ========
>>>>
>>>> The modern servers allows multiple cores to run at range of frequencies
>>>> higher than rated range of frequencies. But the power budget of the system
>>>> inhibits sustaining these higher frequencies for longer durations.
>>>
>>> Thermal budget?
>>
>> Right, it is a good point, and there can be possibility of Thermal throttling
>> which is not covered here.
>> But the thermal throttling is less often seen in the servers than the throttling
>> due to the Power budget constraints. Also one can change the power cap which leads
>> to increase in the throttling and task packing can handle in such
>> cases.
> 
> Ok. I thought you are doing this due to thermals. If I understand
> things correctly, you can go over thermal limits for a few seconds
> before the silicon heats up. What is the timescale for power budget?
> 

I guess it varies across architectures.
AFAIK, in the POWER systems, the frequency is throttled down instantaneously as we exceed
the power budget.
If an idle core is woken up and the power budget is exceeded then the system throttles
down to the frequency value that is know to be sustainable with that many busy cores.

>> BTW, Task packing allows few more cores to remain idle for longer time, so
>> shouldn't this decrease thermal throttles upto certain extent?
> 
> I guess so, yes.
> 
>>>>> These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchmark
>>>> which can create two kinds of tasks: CPU bound (High Utilization) and
>>>> Jitters (Low Utilization). N in X-axis represents N-CPU bound and N-Jitter
>>>> tasks spawned.
>>>
>>> Ok, so you have description how it causes 13% improvements. Do you also have metrics how
>>> it harms performance.. how much delay is added to unimportant tasks etc...?
>>>
>>
>> Yes, if we try to pack the tasks despite of no frequency throttling, we see a regression
>> around 5%. For instance, in the synthetic benchmark I used to show performance benefit,
>> for lower count of CPU intensive threads (N=2) there is -5% performance drop.
>>
>> Talking about the delay added to an unimportant tasks, the result can be lower throughput
>> or higher latency for such tasks.
> 
> Thanks. I believe it would be good to mention disadvantages in the
> documentation, too.

Sure, I will add the mentioned possible regression on jitter tasks in the documentation
somewhere.


Thanks,
Parth


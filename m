Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6DD0B00
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJIJXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 05:23:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbfJIJXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 05:23:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x999DsDD146067
        for <linux-pm@vger.kernel.org>; Wed, 9 Oct 2019 05:23:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhb2sbt3v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 05:23:05 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 9 Oct 2019 10:23:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 10:22:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x999Mv7K59703298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 09:22:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63B854203F;
        Wed,  9 Oct 2019 09:22:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 024C342045;
        Wed,  9 Oct 2019 09:22:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.210])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 09:22:54 +0000 (GMT)
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        Quentin Perret <qperret@qperret.net>,
        rafael.j.wysocki@intel.com, tim.c.chen@linux.intel.com,
        daniel.lezcano@linaro.org
References: <20191007083051.4820-1-parth@linux.ibm.com>
 <20191008132842.6612-1-hdanton@sina.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 9 Oct 2019 14:52:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20191008132842.6612-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100909-0008-0000-0000-00000320633E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100909-0009-0000-0000-00004A3F6726
Message-Id: <d4c936d9-c99f-e50d-95c9-0732ae45d1b9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/8/19 6:58 PM, Hillf Danton wrote:
> 
> On Mon,  7 Oct 2019 14:00:49 +0530 Parth Shah wrote:
>> +/*
>> + * Try to find a non idle core in the system  based on few heuristics:
>> + * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
>> + * - If none CPUs are busy then do not select the core for task packing
>> + * - If atleast one CPU is busy then do task packing unless overutilized CPUs
>> + *   count is < busy/2 CPU count
>> + * - Always select idle CPU for task packing
>> + */
>> +static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
>> +{
>> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
>> +	int iter_cpu, sibling;
>> +
>> +	cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
>> +
>> +	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
>> +		int idle_cpu_count = 0, non_idle_cpu_count = 0;
>> +		int overutil_cpu_count = 0;
>> +		int busy_cpu_count = 0;
>> +		int best_cpu = iter_cpu;
>> +
>> +		for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
>> +			__cpumask_clear_cpu(sibling, cpus);
>> +			if (idle_cpu(iter_cpu)) {
> 
> Would you please elaborate the reasons that the iter cpu is checked idle
> more than once for finding a busy core?
> 

Thanks for looking at the patches.
Could you please point me out where iter_cpu is checked more than once?

>> +				idle_cpu_count++;
>> +				best_cpu = iter_cpu;
>> +			} else {
>> +				non_idle_cpu_count++;
>> +				if (cpu_overutilized(iter_cpu))
>> +					overutil_cpu_count++;
>> +				if (is_cpu_busy(cpu_util(iter_cpu)))
>> +					busy_cpu_count++;
>> +			}
>> +		}
>> +
> 


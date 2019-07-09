Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE74263006
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 07:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfGIFdG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 01:33:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfGIFdG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 01:33:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x695W35k144530
        for <linux-pm@vger.kernel.org>; Tue, 9 Jul 2019 01:33:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tmg54g709-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 01:33:04 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Tue, 9 Jul 2019 06:33:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Jul 2019 06:32:59 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x695WwWw57212984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 05:32:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 478B34C040;
        Tue,  9 Jul 2019 05:32:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 138C04C044;
        Tue,  9 Jul 2019 05:32:53 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.102.2.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 05:32:52 +0000 (GMT)
Subject: Re: [PATCH v3 1/3] cpuidle-powernv : forced wakeup for stop states
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com,
        mpe@ellerman.id.au, rjw@rjwysocki.net
References: <20190704091827.19555-1-huntbag@linux.vnet.ibm.com>
 <20190704091827.19555-2-huntbag@linux.vnet.ibm.com>
 <1562493994.wseoth6w1s.astroid@bobo.none>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Tue, 9 Jul 2019 11:02:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1562493994.wseoth6w1s.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19070905-4275-0000-0000-0000034A6987
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070905-4276-0000-0000-0000385A9281
Message-Id: <bf598a94-cf36-3a5d-6b7f-0de8fa43ff74@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090067
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nick,

Will post next version with the changes you have suggested.
There is a comment below.

On 07/07/2019 03:43 PM, Nicholas Piggin wrote:
> Abhishek Goel's on July 4, 2019 7:18 pm:
>> Currently, the cpuidle governors determine what idle state a idling CPU
>> should enter into based on heuristics that depend on the idle history on
>> that CPU. Given that no predictive heuristic is perfect, there are cases
>> where the governor predicts a shallow idle state, hoping that the CPU will
>> be busy soon. However, if no new workload is scheduled on that CPU in the
>> near future, the CPU may end up in the shallow state.
>>
>> This is problematic, when the predicted state in the aforementioned
>> scenario is a shallow stop state on a tickless system. As we might get
>> stuck into shallow states for hours, in absence of ticks or interrupts.
>>
>> To address this, We forcefully wakeup the cpu by setting the
>> decrementer. The decrementer is set to a value that corresponds with the
>> residency of the next available state. Thus firing up a timer that will
>> forcefully wakeup the cpu. Few such iterations will essentially train the
>> governor to select a deeper state for that cpu, as the timer here
>> corresponds to the next available cpuidle state residency. Thus, cpu will
>> eventually end up in the deepest possible state.
>>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> ---
>>
>> Auto-promotion
>>   v1 : started as auto promotion logic for cpuidle states in generic
>> driver
>>   v2 : Removed timeout_needed and rebased the code to upstream kernel
>> Forced-wakeup
>>   v1 : New patch with name of forced wakeup started
>>   v2 : Extending the forced wakeup logic for all states. Setting the
>> decrementer instead of queuing up a hrtimer to implement the logic.
>>   v3 : Cleanly handle setting/resetting of decrementer so as to not break
>> irq work
>>
>>   arch/powerpc/include/asm/time.h   |  2 ++
>>   arch/powerpc/kernel/time.c        | 40 +++++++++++++++++++++++++++++++
>>   drivers/cpuidle/cpuidle-powernv.c | 32 +++++++++++++++++++++++++
>>   3 files changed, 74 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
>> index 54f4ec1f9..a3bd4f3c0 100644
>> --- a/arch/powerpc/include/asm/time.h
>> +++ b/arch/powerpc/include/asm/time.h
>> @@ -188,6 +188,8 @@ static inline unsigned long tb_ticks_since(unsigned long tstamp)
>>   extern u64 mulhdu(u64, u64);
>>   #endif
>>   
>> +extern int set_dec_before_idle(u64 timeout);
>> +extern void reset_dec_after_idle(void);
>>   extern void div128_by_32(u64 dividend_high, u64 dividend_low,
>>   			 unsigned divisor, struct div_result *dr);
>>   
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 694522308..814de3469 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -576,6 +576,46 @@ void arch_irq_work_raise(void)
>>   
>>   #endif /* CONFIG_IRQ_WORK */
>>   
>> +/*
>> + * Returns 1 if we have reprogrammed the decrementer for idle.
>> + * Returns 0 if the decrementer is unchanged.
>> + */
>> +int set_dec_before_idle(u64 timeout)
>> +{
>> +	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
>> +	u64 now = get_tb_or_rtc();
>> +
>> +	/*
>> +	 * Ensure that the timeout is at least one microsecond
>> +	 * before the current decrement value. Else, we will
>> +	 * unnecesarily wakeup again within a microsecond.
>> +	 */
>> +	if (now + timeout + 512 > *next_tb)
> I would pass this 512 in as a parameter and put the comment in the
> idle code. Timer code does not know/care.
>
> Maybe return bool and call it try_set_dec_before_idle.
>> +		return 0;
>> +
>> +	set_dec(timeout);
> This needs to have
>
>    if (test_irq_work_pending())
>        set_dec(1);
>
> here AFAIKS
>
>> +
>> +	return 1;
>> +}
>> +
>> +void reset_dec_after_idle(void)
>> +{
>> +	u64 now;
>> +	u64 *next_tb;
>> +
>> +	if (test_irq_work_pending())
>> +		return;
>> +
>> +	now = get_tb_or_rtc();
>> +	next_tb = this_cpu_ptr(&decrementers_next_tb);
>> +	if (now >= *next_tb)
>> +		return;
> Are you sure it's okay to escape early in this case?

Yeah, It looks safe. In power9_idle_type, we call irq_set_pending_from_srr1
which sets the irq_happened. If reason is IRQ_DEC, in __check_irq_replay,
decrementer_check_overflow will be called which will set dec to a positive
valid value.
Also, we typically disable MSR EE before entering stop. And if a decrementer
wakes us up, before we enable EE, check for pending interrupt will be done.
And we finally reset dec to a positive value before we set EE=1.
> Thanks,
> Nick
>

Thanks,
Abhishek


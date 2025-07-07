Return-Path: <linux-pm+bounces-30286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065DAFB253
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F02F3A7458
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E028A726;
	Mon,  7 Jul 2025 11:33:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA41B3925;
	Mon,  7 Jul 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887987; cv=none; b=XqUa0KOw9n+0w/7PrTb7UVjCI0c48u04hBev1bYp1NmHyam51ZPxlQ4P02vvKRzkrpVuHI6jnR1pD4AWmOZFpj+YtF2Q9ZiT3+ad09X+8AvJ4z9JBys3kKPwpCSaJKNy87S8C1yiDM1W6Vcf2VqkRDbTPGQqN8R5t27kbwCM/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887987; c=relaxed/simple;
	bh=2oZpAz8+MxmhAJfukRgTlHr2Qu9Ax32beFxHKIqm0/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5U29wkE4gux3yrRQ8b1E8m6gK+8H9Fs2iw8c2w0k1JLFf6BhLNjp/FjduFRfm5R3Nm2mDGtBFi8xdVyoE3w/25ezrOiQ7UZXPUWJPoqpZwVyPl+/QC/BQi4QXbJmFsGckr3FZ8xUMNCWvQDs/TIX9khQ8QIAvfc2BMxcwHw37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbMYW0xKqzKHMZH;
	Mon,  7 Jul 2025 19:33:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 913D11A0EC3;
	Mon,  7 Jul 2025 19:33:01 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBHMA5ssGtokfTAAw--.13365S2;
	Mon, 07 Jul 2025 19:33:01 +0800 (CST)
Message-ID: <c63a1698-2d93-4105-8641-ecec69b48523@huaweicloud.com>
Date: Mon, 7 Jul 2025 19:32:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
To: Peter Zijlstra <peterz@infradead.org>
Cc: timvp@google.com, Michal Koutn?? <mkoutny@suse.com>, rafael@kernel.org,
 pavel@kernel.org, tj@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
 <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
 <20250707101019.GE1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250707101019.GE1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHMA5ssGtokfTAAw--.13365S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWktw4kJFW8AF1xJw18Zrb_yoW8tw1Up3
	95G3WvkrnYqrnFyrsFyw4UZrZYka93JryUWr95Wr1xJF4ftasaqr47Aa4YkF4jvr97Ka45
	JFWj9wn3u3ykZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/7 18:10, Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 12:02:47PM +0800, Chen Ridong wrote:
> 
>>>> And I'm not quite sure I understand this hunk either. If we bail out,
>>>> current->__state is reset to TASK_RUNNING, so what's the problem?
>>>
>>> The issue occurs in this race scenario:
>>>
>>> echo FROZEN > freezer.state
>>>   freeze_cgroup()
>>>     freeze_task()
>>>       fake_signal_wake_up() // wakes task to freeze it
>>>
>>> In task context:
>>> get_signal
>>>   try_to_freeze
>>>     __refrigerator
>>>       WRITE_ONCE(current->__state, TASK_FROZEN); // set TASK_FROZEN
>>>       // race: cgroup state updates to frozen
> 
> I suppose this is me not quite knowing how this cgroup freezer works;
> how does it race? what code marks the task frozen?
> 

Hi.Peter,
Thank you for your reply.

Below is the race condition scenario:

get_signal				read freezer.state
try_to_freeze
__refrigerator				freezer_read
					update_if_frozen
WRITE_ONCE(current->__state, TASK_FROZEN);			
					// The task is set to frozen(now, frozen(task) == ture).
					// we suppose other tasks are all frozen.
					// set cgroup frozen when all tasks are frozen
					freezer->state |= CGROUP_FROZEN;
// freezing(current) will return false,
// since cgroup is frozen(not freezing)
break out
__set_current_state(TASK_RUNNING);
//bug: the task is set to running, but it should be frozen.

Please let me know if you have any questions.

>>>       freezing(current) now return false
>>>       // We bail out, the task is not frozen but it should be frozen.
>>>
>>> I hope this explanation clarifies the issue I encountered.
>>>
>>
>> Hi, Peter, Tim
>>
>> I was looking at the WARN_ON_ONCE(freezing(p)) check in __thaw_task
>> and started wondering: since we already have !frozen(p) check, is this
>> warning still needed? If we can remove it, maybe reverting commit
>> cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen")
>> would be a better approach.
> 
> I suppose that is possible; modern sensibilities require we write that
> function something like so:
> 
> void __thaw_task(struct task_struct *p)
> {
> 	guard(spinlock_irqsave)(&freezer_lock);
> 	if (frozen(p) && !task_call_func(p, __restore_freezer_state, NULL))
> 		wake_up_state(p, TASK_FROZEN);
> }

Glad to heard that.

Best regards,
Ridong



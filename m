Return-Path: <linux-pm+bounces-30242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5EBAFAA7A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 06:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DB17A4FB5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 04:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468618A6DF;
	Mon,  7 Jul 2025 04:02:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC76F9CB;
	Mon,  7 Jul 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860974; cv=none; b=d++dmArx5izlaveQ6Wvz7RzFY2jFvp4R5Encko2Qc3JdW/Klf/HWAHsST3pfkQKqs+YCqBGANB2a/VUhIDYowOG7acN7VirQD5+wAvZQqAv4fex4H7kI9E4dlS39TdTQEqpmAQrtzXd2cHF/Gb/4vwqc17vh0z5offUWfE9fcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860974; c=relaxed/simple;
	bh=XqeXht5H88ggNIkEZWgWOp9EnyfQkP+PDOU8tlnxtko=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F7c/G+ewikc5sLZ7Y3Am6w2EgSQ89EKvHZj9LpCBj4wVNNbUN1vIDhAHtjKIiOc1/pMjT6cCzEdJSODR6cwOK3OU8FHPn555nwMiLEbuua1Cc6dyHBmQSHUzVuKk/CCplOiU0DYMnyDlRmA9DSQA3KaUVIDvVo6aQc1xcIFsFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bb9Z255NwzKHMw1;
	Mon,  7 Jul 2025 12:02:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2EB961A121C;
	Mon,  7 Jul 2025 12:02:49 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgDXOCbnRmtoudKcAw--.32718S2;
	Mon, 07 Jul 2025 12:02:49 +0800 (CST)
Message-ID: <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
Date: Mon, 7 Jul 2025 12:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
From: Chen Ridong <chenridong@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>, timvp@google.com
Cc: Michal Koutn?? <mkoutny@suse.com>, rafael@kernel.org, pavel@kernel.org,
 timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDXOCbnRmtoudKcAw--.32718S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4rtFyktF17XF43Gry5twb_yoW5Xw1kp3
	95XF4UJ3WFqr17urnFvw4qqrZ5Ka9F9r4UGrykW3WxJF4YqasxXr17ArW5KF4jvry8Kry7
	XayjgrZ3A3yUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/4 18:25, Chen Ridong wrote:
> 
> 
> On 2025/7/4 15:57, Peter Zijlstra wrote:
>> On Fri, Jul 04, 2025 at 11:11:52AM +0800, Chen Ridong wrote:
>>
>> Your patches are mangled; please educate your MUA.
>>
> Hi Peter,
> 
> Thank you for your review and feedback
> Apologies for the formatting issues in the patch.
> 
>>> --- a/kernel/freezer.c
>>> +++ b/kernel/freezer.c
>>> @@ -71,19 +71,20 @@ bool __refrigerator(bool check_kthr_stop)
>>>         for (;;) {
>>>                 bool freeze;
>>>
>>> -               raw_spin_lock_irq(&current->pi_lock);
>>> -               WRITE_ONCE(current->__state, TASK_FROZEN);
>>> -               /* unstale saved_state so that __thaw_task() will wake
>>> us up */
>>> -               current->saved_state = TASK_RUNNING;
>>> -               raw_spin_unlock_irq(&current->pi_lock);
>>> -
>>>                 spin_lock_irq(&freezer_lock);
>>> -               freeze = freezing(current) && !(check_kthr_stop &&
>>> kthread_should_stop());
>>> +               freeze = (freezing(current) || !cgroup_thawed(current))
>>> +                        && !(check_kthr_stop && kthread_should_stop());
>>
>> This makes no sense to me; why can't this stay in cgroup_freezing()?
>>
>> Also, can someone please fix that broken comment style there.
>>
> The change relates to commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen"),
> which modified cgroup_freezing() to verify the FROZEN flag isn't set. The freezing(p) will return
> false if the cgroup is frozen.
> 
>>>                 spin_unlock_irq(&freezer_lock);
>>>
>>>                 if (!freeze)
>>>                         break;
>>>
>>> +               raw_spin_lock_irq(&current->pi_lock);
>>> +               WRITE_ONCE(current->__state, TASK_FROZEN);
>>> +               /* unstale saved_state so that __thaw_task() will wake
>>> us up */
>>> +               current->saved_state = TASK_RUNNING;
>>> +               raw_spin_unlock_irq(&current->pi_lock);
>>> +
>>
>> And I'm not quite sure I understand this hunk either. If we bail out,
>> current->__state is reset to TASK_RUNNING, so what's the problem?
> 
> The issue occurs in this race scenario:
> 
> echo FROZEN > freezer.state
>   freeze_cgroup()
>     freeze_task()
>       fake_signal_wake_up() // wakes task to freeze it
> 
> In task context:
> get_signal
>   try_to_freeze
>     __refrigerator
>       WRITE_ONCE(current->__state, TASK_FROZEN); // set TASK_FROZEN
>       // race: cgroup state updates to frozen
>       freezing(current) now return false
>       // We bail out, the task is not frozen but it should be frozen.
> 
> I hope this explanation clarifies the issue I encountered.
> 

Hi, Peter, Tim

I was looking at the WARN_ON_ONCE(freezing(p)) check in __thaw_task and started wondering: since we
already have !frozen(p) check, is this warning still needed? If we can remove it, maybe reverting
commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen") would be a better approach.

What do you think?

Best regards,
Ridong



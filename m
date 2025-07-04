Return-Path: <linux-pm+bounces-30099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03FAF85F2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFDA7B5194
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFA1DF26B;
	Fri,  4 Jul 2025 03:12:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461EA1DF246;
	Fri,  4 Jul 2025 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751598720; cv=none; b=bi0YPkYKCCWazbcYo+QMdSDYia3Z2kN8eQRLLl2x6qZQ37IUxgLCNrWVKUzRF6B4Ld5KP+uvgeL0SjT1gRFjTq6O918H3lU4zX/7uAgTCBDlHzZfiPHFpQZjQ6LFg15bZHVofbzQFogI5X+73XYYd0wrD/xGr63SYbxRppFfEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751598720; c=relaxed/simple;
	bh=xpFzJK7EbTj8oT8gx1B/pIapBvfvKwiCvyDHV1ZcyUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A5BQy8SltePE+L+VTIE1A+cua405WkH2PfgQ0evuObbT0kZ3ZY9OynFo+5t75II0Mhnpthiza5uzYttooA3QB15RFzeBJzdpnrD24X6GMdv9unkvXTVZExO5HPD66/TeDtRKM+zzgcma+LXq1Z0WdTm49F7pmYwpdPuub36GldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bYJZf4gjMzYQtdc;
	Fri,  4 Jul 2025 11:11:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7F8801A0EA9;
	Fri,  4 Jul 2025 11:11:53 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgA37Lx5RmdoRWNgAg--.12441S2;
	Fri, 04 Jul 2025 11:11:53 +0800 (CST)
Message-ID: <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
Date: Fri, 4 Jul 2025 11:11:52 +0800
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
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA37Lx5RmdoRWNgAg--.12441S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1rKw4DJw4xWF17Kw1xZrb_yoW8Kr1fpr
	WrWa1UG3Z7trs2yrn2qw4vqws8K392yF4UGr95CrWxJa1YqasIgr4Ik3yYkF1jvryxArnF
	qF4jq3s7AayUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/4 11:02, Chen Ridong wrote:
> 
> 
> On 2025/7/4 1:01, Michal Koutný wrote:
>> Hello Ridong.
>>
>> On Thu, Jul 03, 2025 at 01:34:27PM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> 2. The cgroup freezer state changes to FROZEN (Can be triggered by reading
>>>    freezer.state).
>> /o\
>>
>>> 3. freezing() is called and returns false.
>>
>> I can see how this can happen because freezer_lock != freezer_mutex.
>>
>>> As a result, the task may escape being frozen when it should be.
>>>
>>> To fix this, move the setting of the FROZEN flag to occur just before
>>> schedule(). This ensures the flag is only set when we're certain the
>>> task must be switched out.
>>
>> Is it sufficient? (If the task is spuriously woken up, the next
>> iteration in that refrigerator loop would be subject to same race, no?)
>>
>> Thanks,
>> Michal
> 
> Hi, Michal:
> 
> Regarding your question: Did you mean that the task was frozen, received
> another signal to wake up, but should have remained frozen instead of
> entering the running state?
> 
> For this scenario, the solution I've found is that the task can only
> break out of the frozen state when its cgroup is thawed. The code
> modification would look like the following, and we'll need to add the
> cgroup_thawed(p) function:
> 

Sorry, the code should look like:

--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -71,19 +71,20 @@ bool __refrigerator(bool check_kthr_stop)
        for (;;) {
                bool freeze;

-               raw_spin_lock_irq(&current->pi_lock);
-               WRITE_ONCE(current->__state, TASK_FROZEN);
-               /* unstale saved_state so that __thaw_task() will wake
us up */
-               current->saved_state = TASK_RUNNING;
-               raw_spin_unlock_irq(&current->pi_lock);
-
                spin_lock_irq(&freezer_lock);
-               freeze = freezing(current) && !(check_kthr_stop &&
kthread_should_stop());
+               freeze = (freezing(current) || !cgroup_thawed(current))
+                        && !(check_kthr_stop && kthread_should_stop());
                spin_unlock_irq(&freezer_lock);

                if (!freeze)
                        break;

+               raw_spin_lock_irq(&current->pi_lock);
+               WRITE_ONCE(current->__state, TASK_FROZEN);
+               /* unstale saved_state so that __thaw_task() will wake
us up */
+               current->saved_state = TASK_RUNNING;
+               raw_spin_unlock_irq(&current->pi_lock);
+
                was_frozen = true;
                schedule();
        }

Best regards,
Ridong



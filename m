Return-Path: <linux-pm+bounces-5870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A88972C2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D12B2E471
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3EB1494D3;
	Wed,  3 Apr 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAInuEps"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24986148FFA
	for <linux-pm@vger.kernel.org>; Wed,  3 Apr 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154409; cv=none; b=AO/bDuYblSm0oZ9JAvQQtLA7Z8b9wVpB/NOfknvhqTUNfO4LdI55VleYPYf1J1mr5WzotGkSXgVJWnUihI+7qveO2ZZR/c9jVWLT2a1l7gTMMqdgXXGrgo5ttZoL1ts/OvcVOVzdYFo2yF5omVuI9jXODsED3eNVyr1NyC6Ad/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154409; c=relaxed/simple;
	bh=RBFLm5+uDEmgofj9uWxnzSGcRd9//fecuzhvrER/xPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AaYyC+uItMEopvuvcvZA68sybPnCmK1NDMC5MvwjHqyMDlUGdsVhTqi6FRdAqdv8HLsy6tk86JAHtVeU7sOH8fhGP7yyO1VztsXN0mJyhHCpaEoh5yZFtRCS56AoR40CeYvSwivfoc09DtzgpPJBFL/YfDgVw8rvNk4ghXE5qC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAInuEps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712154406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57LjQ/Xo+U2gCuYANCe1R7m3CEd4Dr8ZrP/P0e/5PCw=;
	b=SAInuEpsN1iUV4UMwu3+mE7o70v3N42XZUQVt0PLiSOsTW76P1a1/MWT+TDZdFefAoW4/z
	6yDvjiE7oxvMoSSWlzxOm+Rd8xESXJ9NiopdyW6kFiFByne09EWzvky5+qfAa3hIkuc/Hp
	vGtR2HxQGLJOuFZtdQhc2qFSfwq/I1o=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-wqfpNXrwP7W8IKcFM1I1dQ-1; Wed, 03 Apr 2024 10:26:44 -0400
X-MC-Unique: wqfpNXrwP7W8IKcFM1I1dQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e67fa991f1so7686387a34.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2024 07:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154404; x=1712759204;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57LjQ/Xo+U2gCuYANCe1R7m3CEd4Dr8ZrP/P0e/5PCw=;
        b=tpacI+YcaidvIzl51SaUGJ1Vv2Q7ykK2QGL3HKiqWAvQJQ3iqCGkEOXWPMjNwAchz+
         2/gjscLMGQMEGJ1gA0AuH2d9C7daPCnLSxQBEFhRia7+QYnMjB6bCYtqO7X6wpxKdxAc
         Q/iUwlBsbYLjYQrybUY7KIX6TeHm2ZepHe5Q2bvAK78J7P8kwahVZuOlTD8jh8tNx4+v
         7nJ+XxdY27O6R9A84bPsuapzaTUZRxTukwNF+EMjUvOiIdJlzsAfWKu53p2BqBwdYnBf
         ZVdg9FjLDX+8mcMqWm7cNp8PTMO3p08X2KucSIt3dFxlOkEmqC7W7M4P96MmN3xyzpXG
         KEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMqnA0x2pq5rA7+HiJhvEXeJg9Dpvpd3RUJIt6NN3qVZQuUB7flVXq9g7MvSndPfP/rP7Ay+z9WS4QYBU4jwQpEivYaamt1WE=
X-Gm-Message-State: AOJu0YwH0k3qYWbMCWi8Az2nnD0JXK+5HHMr3yFbqOCyp3NyJe1nsDeI
	riiAi/Lr/UoN15KYxwrZWm7HhPspsDZfgWwA18LGFoD8DYmpTD+4dLGGSywmoe/5Y2qp2TEZeDu
	Rb+tBVOAofa2IQ/nXcT7MMXTSfedEZEKlSKm14T6ffPgsMb7QwdzVE08c
X-Received: by 2002:a9d:5e89:0:b0:6e6:c77e:3933 with SMTP id f9-20020a9d5e89000000b006e6c77e3933mr3900678otl.17.1712154403649;
        Wed, 03 Apr 2024 07:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0oaGSIyUo+FTnIsjVJ3ux/o0Qa7R44NDTFF1Hk8OXdUAwOVdR3LsBgCR9cxlorz/yDCeJXA==
X-Received: by 2002:a9d:5e89:0:b0:6e6:c77e:3933 with SMTP id f9-20020a9d5e89000000b006e6c77e3933mr3900642otl.17.1712154403283;
        Wed, 03 Apr 2024 07:26:43 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ke11-20020a056214300b00b006915ae114efsm6515532qvb.52.2024.04.03.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:26:42 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Waiman Long <longman@redhat.com>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
In-Reply-To: <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
Date: Wed, 03 Apr 2024 16:26:38 +0200
Message-ID: <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/24 09:38, Waiman Long wrote:
> On 4/3/24 08:02, Michal Koutn=C3=BD wrote:
>> On Tue, Apr 02, 2024 at 11:30:11AM -0400, Waiman Long <longman@redhat.co=
m> wrote:
>>> Yes, there is a potential that a cpus_read_lock() may be called leading=
 to
>>> deadlock. So unless we reverse the current cgroup_mutex --> cpu_hotplug=
_lock
>>> ordering, it is not safe to call cgroup_transfer_tasks() directly.
>> I see that cgroup_transfer_tasks() has the only user -- cpuset. What
>> about bending it for the specific use like:
>>
>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index 34aaf0e87def..64deb7212c5c 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -109,7 +109,7 @@ struct cgroup *cgroup_get_from_fd(int fd);
>>   struct cgroup *cgroup_v1v2_get_from_fd(int fd);
>>
>>   int cgroup_attach_task_all(struct task_struct *from, struct task_struc=
t *);
>> -int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
>> +int cgroup_transfer_tasks_locked(struct cgroup *to, struct cgroup *from=
);
>>
>>   int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cf=
ts);
>>   int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype =
*cfts);
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index 520a11cb12f4..f97025858c7a 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -91,7 +91,8 @@ EXPORT_SYMBOL_GPL(cgroup_attach_task_all);
>>    *
>>    * Return: %0 on success or a negative errno code on failure
>>    */
>> -int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>> +int cgroup_transfer_tasks_locked(struct cgroup *to, struct cgroup *from)
>>   {
>>      DEFINE_CGROUP_MGCTX(mgctx);
>>      struct cgrp_cset_link *link;
>> @@ -106,9 +106,11 @@ int cgroup_transfer_tasks(struct cgroup *to, struct=
 cgroup *from)
>>      if (ret)
>>              return ret;
>>
>> -	cgroup_lock();
>> -
>> -	cgroup_attach_lock(true);
>> +	/* The locking rules serve specific purpose of v1 cpuset hotplug
>> +	 * migration, see hotplug_update_tasks_legacy() and
>> +	 * cgroup_attach_lock() */
>> +	lockdep_assert_held(&cgroup_mutex);
>> +	lockdep_assert_cpus_held();
>> +	percpu_down_write(&cgroup_threadgroup_rwsem);
>>
>>      /* all tasks in @from are being moved, all csets are source */
>>      spin_lock_irq(&css_set_lock);
>> @@ -144,8 +146,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct =
cgroup *from)
>>      } while (task && !ret);
>>   out_err:
>>      cgroup_migrate_finish(&mgctx);
>> -	cgroup_attach_unlock(true);
>> -	cgroup_unlock();
>> +	percpu_up_write(&cgroup_threadgroup_rwsem);
>>      return ret;
>>   }
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 13d27b17c889..94fb8b26f038 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4331,7 +4331,7 @@ static void remove_tasks_in_empty_cpuset(struct cp=
uset *cs)
>>                      nodes_empty(parent->mems_allowed))
>>              parent =3D parent_cs(parent);
>>
>> -	if (cgroup_transfer_tasks(parent->css.cgroup, cs->css.cgroup)) {
>> +	if (cgroup_transfer_tasks_locked(parent->css.cgroup, cs->css.cgroup)) {
>>              pr_err("cpuset: failed to transfer tasks out of empty cpuse=
t ");
>>              pr_cont_cgroup_name(cs->css.cgroup);
>>              pr_cont("\n");
>> @@ -4376,21 +4376,9 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>>
>>      /*
>>       * Move tasks to the nearest ancestor with execution resources,
>> -	 * This is full cgroup operation which will also call back into
>> -	 * cpuset. Execute it asynchronously using workqueue.
>>       */
>> -	if (is_empty && css_tryget_online(&cs->css)) {
>> -		struct cpuset_remove_tasks_struct *s;
>> -
>> -		s =3D kzalloc(sizeof(*s), GFP_KERNEL);
>> -		if (WARN_ON_ONCE(!s)) {
>> -			css_put(&cs->css);
>> -			return;
>> -		}
>> -
>> -		s->cs =3D cs;
>> -		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
>> -		schedule_work(&s->work);
>> +	if (is_empty)
>> +		remove_tasks_in_empty_cpuset(cs);
>>      }
>>   }
>>
>
> It still won't work because of the possibility of mutiple tasks
> involving in a circular locking dependency. The hotplug thread always
> acquire the cpu_hotplug_lock first before acquiring cpuset_mutex or
> cgroup_mtuex in this case (cpu_hotplug_lock --> cgroup_mutex). Other
> tasks calling into cgroup code will acquire the pair in the order
> cgroup_mutex --> cpu_hotplug_lock. This may lead to a deadlock if these
> 2 locking sequences happen at the same time. Lockdep will certainly
> spill out a splat because of this.

> So unless we change all the relevant
> cgroup code to the new cpu_hotplug_lock --> cgroup_mutex locking order,
> the hotplug code can't call cgroup_transfer_tasks() directly.
>

IIUC that was Thomas' suggestion [1], but I can't tell yet how bad it would
be to change cgroup_lock() to also do a cpus_read_lock().

Also, I gave Michal's patch a try and it looks like it's introducing a
  cgroup_threadgroup_rwsem -> cpuset_mutex
ordering from
  cgroup_transfer_tasks_locked()
  `\
    percpu_down_write(&cgroup_threadgroup_rwsem);
    cgroup_migrate()
    `\
      cgroup_migrate_execute()
      `\
        ss->can_attach() // cpuset_can_attach()
        `\
          mutex_lock(&cpuset_mutex);

which is invalid, see below.

[1]: https://lore.kernel.org/lkml/87cyrfe7a3.ffs@tglx/

[   77.627915] WARNING: possible circular locking dependency detected
[   77.628419] 6.9.0-rc1-00042-g844178b616c7-dirty #23 Tainted: G        W
[   77.629035] ------------------------------------------------------
[   77.629548] cpuhp/2/24 is trying to acquire lock:
[   77.629946] ffffffff82d680b0 (cgroup_threadgroup_rwsem){++++}-{0:0}, at:=
 cgroup_transfer_tasks_locked+0x123/0x450
[   77.630851]
[   77.630851] but task is already holding lock:
[   77.631397] ffffffff82d6c088 (cpuset_mutex){+.+.}-{3:3}, at: cpuset_upda=
te_active_cpus+0x352/0xca0
[   77.632169]
[   77.632169] which lock already depends on the new lock.
[   77.632169]
[   77.632891]
[   77.632891] the existing dependency chain (in reverse order) is:
[   77.633521]
[   77.633521] -> #1 (cpuset_mutex){+.+.}-{3:3}:
[   77.634028]        lock_acquire+0xc0/0x2d0
[   77.634393]        __mutex_lock+0xaa/0x710
[   77.634751]        cpuset_can_attach+0x6d/0x2c0
[   77.635146]        cgroup_migrate_execute+0x6f/0x520
[   77.635565]        cgroup_attach_task+0x2e2/0x450
[   77.635989]        __cgroup1_procs_write.isra.0+0xfd/0x150
[   77.636440]        kernfs_fop_write_iter+0x127/0x1c0
[   77.636917]        vfs_write+0x2b0/0x540
[   77.637330]        ksys_write+0x70/0xf0
[   77.637707]        int80_emulation+0xf8/0x1b0
[   77.638183]        asm_int80_emulation+0x1a/0x20
[   77.638636]
[   77.638636] -> #0 (cgroup_threadgroup_rwsem){++++}-{0:0}:
[   77.639321]        check_prev_add+0xeb/0xb20
[   77.639751]        __lock_acquire+0x12ac/0x16d0
[   77.640345]        lock_acquire+0xc0/0x2d0
[   77.640903]        percpu_down_write+0x33/0x260
[   77.641347]        cgroup_transfer_tasks_locked+0x123/0x450
[   77.641826]        cpuset_update_active_cpus+0x782/0xca0
[   77.642268]        sched_cpu_deactivate+0x1ad/0x1d0
[   77.642677]        cpuhp_invoke_callback+0x16b/0x6b0
[   77.643098]        cpuhp_thread_fun+0x1ba/0x240
[   77.643488]        smpboot_thread_fn+0xd8/0x1d0
[   77.643873]        kthread+0xce/0x100
[   77.644209]        ret_from_fork+0x2f/0x50
[   77.644626]        ret_from_fork_asm+0x1a/0x30
[   77.645084]
[   77.645084] other info that might help us debug this:
[   77.645084]
[   77.645829]  Possible unsafe locking scenario:
[   77.645829]
[   77.646356]        CPU0                    CPU1
[   77.646748]        ----                    ----
[   77.647143]   lock(cpuset_mutex);
[   77.647529]                                lock(cgroup_threadgroup_rwsem=
);
[   77.648193]                                lock(cpuset_mutex);
[   77.648767]   lock(cgroup_threadgroup_rwsem);
[   77.649216]
[   77.649216]  *** DEADLOCK ***



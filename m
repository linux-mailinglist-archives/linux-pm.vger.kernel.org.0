Return-Path: <linux-pm+bounces-25633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A932CA91E03
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D373A78FC
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5D245017;
	Thu, 17 Apr 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YrWKRm8i"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB235948;
	Thu, 17 Apr 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896531; cv=none; b=ifhNAjwtn7CB4SBHZgKhWGxoEgNL53qiHAEVa4r3zs+e9JBOmgRDtEAc1rG8tv7oEb4C9Mn+Ks+kAAm+AhPhqlKxh51ncEivPxat3oHwiow5vobstkut/65NmgGEsMU1OkAWBC8rvnYcLcTysCDvoOPO203ulLLHYq0tKr4mrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896531; c=relaxed/simple;
	bh=wyDrjObx2d/jAlYGTVoynAezismk4KrEVgvdF/EK0Cw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ymg9m8GRmPhMf8pViigwd0mUsdRkDaK0h2u9A77qSXi4W7oBHXj8tDedn/u5THbTUCTLpIv+CghHoiVDnt9sgcelCYJpUOYa1KkhOqfVjCLGA1F3fd3ekRksnqVnmegosxDaJ0RdYz8x36aX8P+EBR0wsoiDrOgA4fceJ3W7fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YrWKRm8i; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/rT6d8HNq5uMmOgaei59ZL41n/Gekb+BH3BbOQkgZX0=; b=YrWKRm8iLWrzKXs22fH2ZFc591
	VHIXU2Z7a5un45v9L0mFpoFxNq+/D2Qy7MN4nxM1pF3dRli0/REiI1lA9IF9vrNh++XFsLO6rnHE1
	SCVpYuqS6RDrGwVpzXz4upyPzww7MI5TN0DEahaXTJyK0lEgRnXfpsLj37s6cvb7fv0a02encbprz
	Oh2h9cjfBdN1uCLxse99LvkJ+WtZfN7bl+NkTUvQU7cXsv8Skk45KWSFFIlWQftyqp33WFTf1kU6B
	7isI2I/CS82M2WgoDx2wjXnh6dpozbRv1h1ahnuNrII/wlOTdItV6Se7dysEZyEKSviCodat746G+
	be3SYLSA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u5PID-000ovm-6j; Thu, 17 Apr 2025 15:28:37 +0200
Message-ID: <f7e388e0-331f-43b3-a1e1-d0c14818e3ad@igalia.com>
Date: Thu, 17 Apr 2025 22:28:29 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH] PM: EM: Add inotify support when the energy model is
 updated.
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, len.brown@intel.com,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, pavel@kernel.org
References: <20250415004215.48757-1-changwoo@igalia.com>
 <d29e4ea6-2bfe-4017-b7c8-0d77613959f4@arm.com>
 <CAJZ5v0jx44heAgXPwCDriGo-xyjX2pUP+PG1cQwjme_=EHo3rg@mail.gmail.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0jx44heAgXPwCDriGo-xyjX2pUP+PG1cQwjme_=EHo3rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lukasz and Rafael,

Thank you super much for the comments!

On 4/16/25 02:05, Rafael J. Wysocki wrote:
> On Tue, Apr 15, 2025 at 10:31 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Changwoo,
>>
>> Thanks for the patch.
>>
>> On 4/15/25 01:42, Changwoo Min wrote:
>>> The sched_ext schedulers [1] currently access the energy model through the
>>> debugfs to make energy-aware scheduling decisions [2]. The userspace part
>>> of a sched_ext scheduler feeds the necessary (post-processed) energy-model
>>> information to the BPF part of the scheduler.
>>
>> This is very interesting use case!
>>
>>>
>>> However, there is a limitation in the current debugfs support of the energy
>>> model. When the energy model is updated (em_dev_update_perf_domain), there
>>> is no way for the userspace part to know such changes (besides polling the
>>> debugfs files).
>>>
>>> Therefore, add inotify support (IN_MODIFY) when the energy model is
>>> updated. With this inotify support, the sched_ext scheduler can monitor the
>>> energy model change in userspace using the regular inotify interface and
>>> feed the updated energy model information to make energy-aware scheduling
>>> decisions.
>>>
>>> [1] https://lwn.net/Articles/922405/
>>> [2] https://github.com/sched-ext/scx/pull/1624
>>>
>>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>>> ---
>>>    kernel/power/energy_model.c | 47 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 47 insertions(+)
>>>
>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>> index d9b7e2b38c7a..0c06e0278df6 100644
>>> --- a/kernel/power/energy_model.c
>>> +++ b/kernel/power/energy_model.c
>>> @@ -14,6 +14,7 @@
>>>    #include <linux/cpumask.h>
>>>    #include <linux/debugfs.h>
>>>    #include <linux/energy_model.h>
>>> +#include <linux/fsnotify.h>
>>>    #include <linux/sched/topology.h>
>>>    #include <linux/slab.h>
>>>
>>> @@ -156,9 +157,53 @@ static int __init em_debug_init(void)
>>>        return 0;
>>>    }
>>>    fs_initcall(em_debug_init);
>>> +
>>> +static void em_debug_update_ps(struct em_perf_domain *em_pd, int i,
>>> +                            struct dentry *pd)
>>> +{
>>> +     static const char *names[] = {
>>> +             "frequency",
>>> +             "power",
>>> +             "cost",
>>> +             "performance",
>>> +             "inefficient",
>>> +     };
>>> +     struct em_perf_state *table;
>>> +     unsigned long freq;
>>> +     struct dentry *d, *cd;
>>> +     char name[24];
>>> +     int j;
>>> +
>>> +     rcu_read_lock();
>>> +     table = em_perf_state_from_pd(em_pd);
>>> +     freq = table[i].frequency;
>>> +     rcu_read_unlock();
>>> +
>>> +     snprintf(name, sizeof(name), "ps:%lu", freq);
>>> +     d = debugfs_lookup(name, pd);
>>> +
>>> +     for (j = 0; j < ARRAY_SIZE(names); j++) {
>>> +             cd = debugfs_lookup(names[j], d);
>>> +             if (!cd)
>>> +                     return;
>>> +             fsnotify_dentry(cd, FS_MODIFY);
>>> +             cond_resched();
>>> +     }
>>> +}
>>> +
>>> +static void em_debug_update(struct device *dev)
>>> +{
>>> +     struct dentry *d;
>>> +     int i;
>>> +
>>> +     d = debugfs_lookup(dev_name(dev), rootdir);
>>> +     for (i = 0; i < dev->em_pd->nr_perf_states; i++)
>>> +             em_debug_update_ps(dev->em_pd, i, d);
>>> +}
>>>    #else /* CONFIG_DEBUG_FS */
>>>    static void em_debug_create_pd(struct device *dev) {}
>>>    static void em_debug_remove_pd(struct device *dev) {}
>>> +static void em_debug_update(struct device *dev) {}
>>>    #endif
>>>
>>>    static void em_release_table_kref(struct kref *kref)
>>> @@ -323,6 +368,8 @@ int em_dev_update_perf_domain(struct device *dev,
>>>
>>>        em_table_free(old_table);
>>>
>>> +     em_debug_update(dev);
>>> +
>>
>> I would move this out of the locked section, below the mutex
>> unlock. Looking at the code in em_debug_update() you are trying
>> to send such notification for each EM's table entry * number of
>> fields, which is heavy. The RCU copy that you get will make sure
>> you have consistent view on the data and you don't have to
>> be under the mutex lock.

That makes sense. I will change it in the next version as you suggested.

>>
>> A different question would be if the notification has to be
>> that heavy?

This is a good question. In this version, I tried to mimic the situation
such that all the files under a performance domain are updated, so I
sent inotify for all files.

However, that is *not* necessary considering how a userspace code
monitors the update of the energy model. Now, I think it will be better
to inotify just the directory of a performance domain (e.g., /sys/
kernel/debug/energy_model/cpu0). A userspace application just monitors
'/sys/kernel/debug/energy_model' to get a notification for an update on
any performance domain.

The change will be minimal as follows:

@@ -14,6 +14,7 @@
  #include <linux/cpumask.h>
  #include <linux/debugfs.h>
  #include <linux/energy_model.h>
+#include <linux/fsnotify.h>
  #include <linux/sched/topology.h>
  #include <linux/slab.h>

@@ -156,9 +157,18 @@ static int __init em_debug_init(void)
  	return 0;
  }
  fs_initcall(em_debug_init);
+
+void em_debug_update(struct device *dev)
+{
+	struct dentry *d;
+
+	d = debugfs_lookup(dev_name(dev), rootdir);
+	fsnotify_dentry(d, FS_MODIFY);
+}
  #else /* CONFIG_DEBUG_FS */
  static void em_debug_create_pd(struct device *dev) {}
  static void em_debug_remove_pd(struct device *dev) {}
+static void em_debug_update(struct device *dev) {}
  #endif

  static void em_destroy_table_rcu(struct rcu_head *rp)
@@ -335,6 +345,8 @@ int em_dev_update_perf_domain(struct device *dev,
  	em_table_free(old_table);

  	mutex_unlock(&em_pd_mutex);
+
+	em_debug_update(dev);
  	return 0;
  }
  EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);

>> Can we just 'ping' the user-space that there is a change and ask to read
>> the new values?

Besides the inotify, another 'ping' mechanism that I can think of is
using kprobe/kretprobe. The BPF code hooks em_dev_update_perf_domain()
using kprobe/kretprobe. When the function is called, the BPF code tells
the userspace to re-read the energy model.

This is pretty ad-hoc and has two (or more) problems. Firstly, it
requires another communication mechanism (maybe BPF ring buffer) from
the BPF code to the userspace. This will eventually mimic what inotify
does. More importantly, the BPF code has a dependency on the function
name. The changes in the function name/prototype will break the  BPF
code. We may consider adding a tracepoint to em_dev_update_perf_domain()
to avoid this, but to me, it feels like another bandage over a bandage.

Due to this, I think inotify is the right solution to the problem.

@Lukasz -- If you have anything particular in mind other than kprobe and
inotify, please let me know.

>>
>> Another question, but this time to Rafael would be if for such use case
>> we can use debugfs, or we need a sysfs?
> 
> debugfs is not really suitable for this IMV and the problem at hand is
> a symptom of that (but there will be more issues in the future
> AFAICS).

I agree debugfs is not ideal in the sense that it is not considered as a
stable interface. We can consider moving from the debugfs to the sysfs
if there is a consensus. In my view, moving to sysfs is reasonable since
there is no major change in the debugfs hierarchy since its inception.
If necessary, I will add the sysfs implementation (dropping the debugfs
code) to the next version.

@Rafael -- Could you elaborate a bit more about 'the problem at hand'
and 'more issues in the future'? Once inotify-ing only the performance
domain directory as described above, I think overhead is no longer a
problem. Do you have anything particular concerning about?

> 
> Before starting to invent new interfaces for user space, though, I'm
> wondering why the BPF code cannot obtain the energy model information
> from the kernel?

First of all, we prefer a userspace interface over adding new BPF kfuncs
to access the energy model. The user space has much more freedom than
the BPF code (e.g., using external libraries and floating point
arithmetics). For instance, one sched_ext scheduler may leverage the
energy model information to find the best subset of CPUs given the
workload using machine learning or some numerical optimization
techniques. Such approaches are infeasible (if not impossible) in the
BPF/kernel code.

Secondly,  I am unsure if the current energy model data structures are
accessible without any modifications through new BPF kfuncs. In
particular, there are two flexible array members (cpus[] in
em_perf_domain and state[] in em_perf_table). I guess that the BPF
verifier may not be able to know the bounds of the arrays.

Finally, even if the current EM data structures are accessible without
any modifications, I still think adding new BPF kfuncs is not ideal
because that creates dependencies between the EM data structures and the
BPF code. If the EM data structures change (e.g., struct name change,
field name change), the BPF code will break. While there is a BPF
compatibility feature (CO-RE), managing such changes in the BPF code
will be painful.

Regards,
Changwoo Min
> 
>>>        mutex_unlock(&em_pd_mutex);
>>>        return 0;
>>>    }
> 
> 



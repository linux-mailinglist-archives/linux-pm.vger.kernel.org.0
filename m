Return-Path: <linux-pm+bounces-5811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C05089583D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3091AB202E9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B9131751;
	Tue,  2 Apr 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfcjU7iJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1C132C38
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071821; cv=none; b=k4+AmLTSqnzje0gSsdgkGVROFE3D3TbkbRncEJ9wjmTwXGrqZkzIqKv1vRZwcA7fmmPBn1Xqm1RAhP2VHfo9EIrfj99jkGCFfAnC+ceF+UibmbR1YQjq0ZuWsSOQMGAJe6E1rPzitNR1m8Q6HyuZxm1Cjsje4PeGFlhftpoqh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071821; c=relaxed/simple;
	bh=23qNJ4ftegx5H447MVacyBoGDIcrxV1t1VQ4lsSZJ/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrLqk0QA7tKGov7+ujbeYaJxnGKzm5i5LJSIRHNYGQvrYXN51iaV8TGWigQZJG2BDnXjqsTb1HzP5QmHqHuEmrxYwYcjC9kKOLPDkV7WZKquep6OQ+ITeH/g4zCzaGcRBdZAPjaxY7MJgPNYA5KAiPQ80D5YbH/Ca/rqizTIV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfcjU7iJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712071818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CES7zO5vAsVp440eN4HWeKNk0OJ2Kki5eVVcnl1iPU=;
	b=dfcjU7iJ4Xr2mO8rHtzf16z87ViIcBWb9JuydKG1xqsnqZjE5HKidjxPBPKzQWVdKS/RIR
	7EQXIWKqwZPUv528473HuqxRX3nCNZzruu7gdJFV562w+1HsXefx5V+vaKb1jkOG/ecRer
	k9oWrupH7KSLD98p1iQTkLzwsyiLYHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-mCLhMP9nP1GCXUty7wZCZQ-1; Tue,
 02 Apr 2024 11:30:14 -0400
X-MC-Unique: mCLhMP9nP1GCXUty7wZCZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 575BD1E441D0;
	Tue,  2 Apr 2024 15:30:13 +0000 (UTC)
Received: from [10.22.33.108] (unknown [10.22.33.108])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E66122022EA7;
	Tue,  2 Apr 2024 15:30:11 +0000 (UTC)
Message-ID: <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
Date: Tue, 2 Apr 2024 11:30:11 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Barry Song <song.bao.hua@hisilicon.com>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 4/2/24 10:13, Michal Koutný wrote:
> Hello Waiman.
>
> (I have no opinion on the overall locking reworks, only the bits about
> v1 migrations caught my attention.)
>
> On Mon, Apr 01, 2024 at 10:58:57AM -0400, Waiman Long <longman@redhat.com> wrote:
> ...
>> @@ -4383,12 +4377,20 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>>   	/*
>>   	 * Move tasks to the nearest ancestor with execution resources,
>>   	 * This is full cgroup operation which will also call back into
>> -	 * cpuset. Should be done outside any lock.
>> +	 * cpuset. Execute it asynchronously using workqueue.
>                     ...to avoid deadlock on cpus_read_lock
>
> Is this the reason?
> Also, what happens with the tasks in the window till the migration
> happens?
> Is it handled gracefully that their cpu is gone?

Yes, there is a potential that a cpus_read_lock() may be called leading 
to deadlock. So unless we reverse the current cgroup_mutex --> 
cpu_hotplug_lock ordering, it is not safe to call 
cgroup_transfer_tasks() directly.


>
>
>> -	if (is_empty) {
>> -		mutex_unlock(&cpuset_mutex);
>> -		remove_tasks_in_empty_cpuset(cs);
>> -		mutex_lock(&cpuset_mutex);
>> +	if (is_empty && css_tryget_online(&cs->css)) {
>> +		struct cpuset_remove_tasks_struct *s;
>> +
>> +		s = kzalloc(sizeof(*s), GFP_KERNEL);
> Is there a benefit of having a work for each cpuset?
> Instead of traversing whole top_cpuset once in the async work.

We could do that too. It's just that we have the repeat the iteration 
process once the workfn is invoked, but that has the advantage of not 
needing to do memory allocation. I am OK with either way. Let's see what 
other folks think about that.

Cheers,
Longman



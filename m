Return-Path: <linux-pm+bounces-10945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7F92D631
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A686EB239E3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC4194A74;
	Wed, 10 Jul 2024 16:22:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746120312;
	Wed, 10 Jul 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628576; cv=none; b=U+cxPHEocGIKTDq2OG3Bh/vkynTkvjU2fH+wJsPMXtS4QMsIfOiMs2jjwxy8u9RbUJojUVkLxYEJuEXLUGnnc4eIzrMChMOm7j7KI9i3LJC0t12HeiiEe7ESXZaKcw4bU1hpxUS2Wvz6HCRZgSuFZGR3MUw50qwEK1orxIxTfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628576; c=relaxed/simple;
	bh=sMjjMgparp932QXd67qn3mBn+OzKzakROy2sUzZrde8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnAWiYb+bX64GR5MIRofiEY9Wh2DoNr/zk/JZhTllolObpG7S17e2xhDn1JxZ+0kMqo/HO21jZ6lQ/eQHlgHZllaG8zwB9fAD4s1/pol8betNTZNRhxn8OtbiqYwm9MQ5A6LlkCt3m+pOQNJSaBv9PWikgToMKvFKh/ZK7YCZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC9C1042;
	Wed, 10 Jul 2024 09:23:18 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 904513F762;
	Wed, 10 Jul 2024 09:22:50 -0700 (PDT)
Message-ID: <03f3bdd8-d3c1-448c-ba46-7be2289d75ae@arm.com>
Date: Wed, 10 Jul 2024 18:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <CAKfTPtBQnTJQaU6iYCz3JhZ0Y=MjyM7oZ3Ug_SNfyZ0AwVPXJQ@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtBQnTJQaU6iYCz3JhZ0Y=MjyM7oZ3Ug_SNfyZ0AwVPXJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 09:48, Vincent Guittot wrote:
> On Wed, 19 Jun 2024 at 22:14, Qais Yousef <qyousef@layalina.io> wrote:

[...]

>> @@ -811,7 +818,14 @@ int __sched_setscheduler(struct task_struct *p,
>>         if (running)
>>                 set_next_task(rq, p);
>>
>> -       check_class_changed(rq, p, prev_class, oldprio);
>> +       update_cpufreq |= check_class_changed(rq, p, prev_class, oldprio);
>> +
>> +       /*
>> +        * Changing class or uclamp value implies requiring to send cpufreq
>> +        * update.
>> +        */
>> +       if (update_cpufreq && running)
> 
> Why running ? it should be queued as we are max aggregating

Also wondering ... IMHO, this has been discussed in v4 already:

https://lkml.kernel.org/r/20240529011144.smuq6dbaxvulxy4e@airbuntu

[...]



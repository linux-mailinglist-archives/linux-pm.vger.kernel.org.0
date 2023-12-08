Return-Path: <linux-pm+bounces-832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCBF80A02F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 11:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B2D1C20859
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171C12B83;
	Fri,  8 Dec 2023 10:04:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82BDF1720;
	Fri,  8 Dec 2023 02:04:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C69E11FB;
	Fri,  8 Dec 2023 02:05:24 -0800 (PST)
Received: from [10.57.82.108] (unknown [10.57.82.108])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D203F762;
	Fri,  8 Dec 2023 02:04:36 -0800 (PST)
Message-ID: <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
Date: Fri, 8 Dec 2023 10:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, Vincent Guittot
 <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Wei Wang <wvw@google.com>,
 Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra <peterz@infradead.org>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231208015242.385103-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Qais,

On 12/8/23 01:52, Qais Yousef wrote:

[snip]

> @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	 */
>   	util_est_enqueue(&rq->cfs, p);
>   
> -	/*
> -	 * If in_iowait is set, the code below may not trigger any cpufreq
> -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> -	 * passed.
> -	 */
> -	if (p->in_iowait)
> -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> -

Why this io wait boost is considered as the $subject says 'aggressive'
calling?

Regards,
Lukasz


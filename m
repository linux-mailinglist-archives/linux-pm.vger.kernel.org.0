Return-Path: <linux-pm+bounces-14377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F597B475
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0DFB2408C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D810176228;
	Tue, 17 Sep 2024 20:09:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27817152176;
	Tue, 17 Sep 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726603772; cv=none; b=ko4WY+RhAN3+Iofp0lXAYNYdA37ab9YzRvFk4NRfuDQVY4amDwoa3fdKXE2FbK1mFsBXc1nFcph5Wu4TeVPtE4DjZtMqZKdZwcjztLIv2ezXd8nhkR7AnGjEZoUdN0tqHgXishbNjNaFXMtI7ooHgimWxU1JbgSzGfeyZkEiPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726603772; c=relaxed/simple;
	bh=hoh85dhDSNoH4kL9B/JMGc0NlnTNoU6i3FvI5uRdVmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crfoSQ6U04VYS7L6K/N9z2QMZLF/UO2WfFkf8pKsndQ/OJ5rLmgdVvA5oa1xDdWOe/DtdPAG7X4UUc5oREVAeRY8HQ39o2DOrO+pYKQQTZ1cinze+/JDxHrp+WDpFNZxLHTjLRAURW/NB4uawApLFygCLw8Owir4uip2+z9U9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8B0FEC;
	Tue, 17 Sep 2024 13:09:58 -0700 (PDT)
Received: from [10.1.47.44] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92A373F64C;
	Tue, 17 Sep 2024 13:09:26 -0700 (PDT)
Message-ID: <d5726cec-cbc6-476d-8abc-b29b98a1bcf4@arm.com>
Date: Tue, 17 Sep 2024 22:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/16] sched/qos: Add rampup multiplier QoS
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-12-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240820163512.1096301-12-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 18:35, Qais Yousef wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0c10e2afb52d..3d9794db58e1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4906,7 +4906,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	if (!task_sleep) {
>  		if (task_util(p) > task_util_dequeued(p)) {
>  			ewma &= ~UTIL_AVG_UNCHANGED;
> -			ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
> +			ewma = approximate_util_avg(ewma, (p->se.delta_exec/1000) * p->sched_qos.rampup_multiplier);

Isn't this exactly the idea from UTIL_EST_FASTER?

faster_est_approx(delta * 2) ... double speed even w/o contention?
                          ^
[...]


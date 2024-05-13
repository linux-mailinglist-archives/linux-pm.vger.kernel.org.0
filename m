Return-Path: <linux-pm+bounces-7762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A78C40ED
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 14:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDE61C211F3
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F714F9C8;
	Mon, 13 May 2024 12:44:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98830A3F;
	Mon, 13 May 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604254; cv=none; b=Ors9WQFe7soQrWR/uiGL0OLPctJaqvFLdR/QkxWj3cvYm/WTC3ELYp7lesZ5+7LrrqQXtUPbaqOqJDlmIez81m58WnO701mWNtmIvJo+ggjPPIYCqOQuXmdjqxt5rX96Bf/qrYkKSZl25lvESU3iPH+d5y4/p0ZLR9JRcUm4WXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604254; c=relaxed/simple;
	bh=/b03Zf1aRDdZv7Bhcjq4xGxDuP82x35zRerWPUH3wHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAlyK+f1v9uwlfkEmpERjS3Ti2cVxPP0L9liiaXZTVapNsOC9jbX6j/REc+rIrO0IiGZLzdH21+ZG8VpibX+w0D5TZ1MRpozkanzOLmScol27dJf2ZyN2wqwn9T9TbPNw2qOroivElTGvqL0gXeCtK4NItTObhbOl9l/GBesmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04781007;
	Mon, 13 May 2024 05:44:36 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA61E3F7A6;
	Mon, 13 May 2024 05:44:08 -0700 (PDT)
Message-ID: <9e845146-8a31-407c-a5ee-e2e32f1655e5@arm.com>
Date: Mon, 13 May 2024 14:43:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240512190018.531820-1-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240512190018.531820-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/05/2024 21:00, Qais Yousef wrote:

[...]

> @@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, 0);
> +	cpufreq_update_util(rq_of(cfs_rq), 0);

Isn't this slighlty different now?

before:

   if (&rq->cfs == cfs_rq) {
       cpufreq_update_util(rq, ....)
   }

now:

   cpufreq_update_util(rq_of(cfs_rq), ...)

You should get way more updates from attach/detach now.

>  
>  	trace_pelt_cfs_tp(cfs_rq);
>  }

[...]



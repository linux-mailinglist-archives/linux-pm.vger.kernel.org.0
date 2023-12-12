Return-Path: <linux-pm+bounces-1007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E226880F5C1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA51C20C7C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5302B7F553;
	Tue, 12 Dec 2023 18:50:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EF691A1;
	Tue, 12 Dec 2023 10:50:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC581FB;
	Tue, 12 Dec 2023 10:51:03 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE553F762;
	Tue, 12 Dec 2023 10:50:14 -0800 (PST)
Message-ID: <2236f098-b889-4d70-b863-11a3f246889c@arm.com>
Date: Tue, 12 Dec 2023 19:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/23] PM: EM: Add API for updating the runtime
 modifiable EM
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-12-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-12-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:08, Lukasz Luba wrote:

[...]

> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 489a358b9a00..614891fde8df 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -221,6 +221,52 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
>  	return 0;
>  }
>  
> +/**
> + * em_dev_update_perf_domain() - Update runtime EM table for a device
> + * @dev		: Device for which the EM is to be updated
> + * @table	: The new EM table that is going to used from now

s/going to used/going to be used

> + *
> + * Update EM runtime modifiable table for the @dev using the privided @table.

s/privided/provided

> + *
> + * This function uses mutex to serialize writers, so it must not be called
> + * from non-sleeping context.
> + *
> + * Return 0 on success or a proper error in case of failure.
> + */
> +int em_dev_update_perf_domain(struct device *dev,
> +			      struct em_perf_table __rcu *new_table)
> +{
> +	struct em_perf_table __rcu *old_table;
> +	struct em_perf_domain *pd;
> +
> +	/*
> +	 * The lock serializes update and unregister code paths. When the
> +	 * EM has been unregistered in the meantime, we should capture that
> +	 * when entering this critical section. It also makes sure that

What do you want to capture here? You want to block in this moment,
right? Don't understand the 2. sentence here.

[...]


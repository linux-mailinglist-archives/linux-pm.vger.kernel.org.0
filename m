Return-Path: <linux-pm+bounces-1003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7280F5B3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441251F21793
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664A7F551;
	Tue, 12 Dec 2023 18:49:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1749CF4;
	Tue, 12 Dec 2023 10:49:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F5451FB;
	Tue, 12 Dec 2023 10:50:17 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4D43F762;
	Tue, 12 Dec 2023 10:49:28 -0800 (PST)
Message-ID: <985618de-73cf-4b54-aef4-6e7bbfe86b17@arm.com>
Date: Tue, 12 Dec 2023 19:49:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/23] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-5-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:08, Lukasz Luba wrote:
> The Energy Model (EM) is going to support runtime modification. There
> are going to be 2 EM tables which store information. This patch aims
> to prepare the code to be generic and use one of the tables. The function
> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
> instead a pointer to 'struct em_perf_state' (which is one of the EM's
> tables).
I thought the 2 EM tables design is gone?

IMHO it would be less code changes and hence a more enjoyable review
experience if you would add the 'modifiable' feature to the existing EM
(1) and not add (2) and then remove (1) in [21/23].


 struct em_perf_domain {
-	struct em_perf_state *table;                <-- (1)
 	struct em_perf_table __rcu *runtime_table;  <-- (2)

> Prepare em_pd_get_efficient_state() for the upcoming changes and
> make it possible to re-use. Return an index for the best performance

s/make it possible to re-use/make it possible to be re-used ?

> state for a given EM table. The function arguments that are introduced
> should allow to work on different performance state arrays. The caller of
> em_pd_get_efficient_state() should be able to use the index either
> on the default or the modifiable EM table.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/energy_model.h | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..8069f526c9d8 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
>  
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> - * @pd   : Performance domain for which we want an efficient frequency
> - * @freq : Frequency to map with the EM
> + * @state:		List of performance states, in ascending order

(3)

> + * @nr_perf_states:	Number of performance states
> + * @freq:		Frequency to map with the EM
> + * @pd_flags:		Performance Domain flags
>   *
>   * It is called from the scheduler code quite frequently and as a consequence
>   * doesn't implement any check.
>   *
> - * Return: An efficient performance state, high enough to meet @freq
> + * Return: An efficient performance state id, high enough to meet @freq
>   * requirement.
>   */
> -static inline
> -struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> -						unsigned long freq)
> +static inline int
> +em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> +			  unsigned long freq, unsigned long pd_flags)

(3) but em_pd_get_efficient_state(struct em_perf_state *table
                                                        ^^^^^
[...]


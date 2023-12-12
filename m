Return-Path: <linux-pm+bounces-1005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A280F5BD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B951C20DAD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26887F553;
	Tue, 12 Dec 2023 18:50:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 002DBBD;
	Tue, 12 Dec 2023 10:50:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17E371FB;
	Tue, 12 Dec 2023 10:50:50 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0133F762;
	Tue, 12 Dec 2023 10:50:01 -0800 (PST)
Message-ID: <fbee5e3b-4c32-443a-b756-943762ae07b8@arm.com>
Date: Tue, 12 Dec 2023 19:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/23] PM: EM: Refactor how the EM table is allocated
 and populated
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-8-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-8-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:08, Lukasz Luba wrote:
> Split the process of allocation and data initialization for the EM table.
> The upcoming changes for modifiable EM will use it.
> 
> This change is not expected to alter the general functionality.

NIT: IMHO, I guess you wanted to say: "No functional changes
introduced"? I.e. all not only general functionality ...

[...]

>  static int em_create_pd(struct device *dev, int nr_states,
> @@ -234,11 +234,15 @@ static int em_create_pd(struct device *dev, int nr_states,
>  			return -ENOMEM;
>  	}
>  
> -	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
> -	if (ret) {
> -		kfree(pd);
> -		return ret;
> -	}
> +	pd->nr_perf_states = nr_states;

Why does `pd->nr_perf_states = nr_states;` have to move from
em_create_perf_table() to em_create_pd()?

> +
> +	ret = em_allocate_perf_table(pd, nr_states);
> +	if (ret)
> +		goto free_pd;
> +
> +	ret = em_create_perf_table(dev, pd, pd->table, nr_states, cb, flags);

If you set it in em_create_pd() then you can use 'pd->nr_perf_states' in
em_create_perf_table() and doesn't have to pass `nr_states`.

[...]


Return-Path: <linux-pm+bounces-878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E780BEAF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 02:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA4A280AB6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 01:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BFC321D;
	Mon, 11 Dec 2023 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hUDwjp8k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412EAA9
	for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 17:15:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so17028545e9.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702257311; x=1702862111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVYCyVS3+ff43Qu6NzjIwTDiljR88wG6SCIsO7lLWds=;
        b=hUDwjp8kWW21rshJ2xD5xVe1/v2MPrdMkSORUL5685RPBIDOdhsxQEBTgDphBI2WYe
         SrafVbt/3Jh1c/wZZTlozayYEBnCg7F0nKklHjAEO97ZTDXa6fO+vf4ORVqnO1USBhxl
         1Lx82BN+lJ0cYktMWp+EKyWHhVVjDFz9LYlqcvKodiv1AdSrfUVUVdg7DeXtMZ36I3Tv
         1QKztmHsmTsu7GKiA5/B53C85W1kJly3uaZc/tvdYSpMzJn/U2qVuZBSdtXyWGLR//QF
         8uEVFfsHnEalP1E9KxbNNCbTIYeLhGA0JYCkLcmZgZkQyvUPmwyS8HKS5UzKny+oE51F
         lwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702257311; x=1702862111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVYCyVS3+ff43Qu6NzjIwTDiljR88wG6SCIsO7lLWds=;
        b=Tv60JlFog+gVtJBXNIzPxRvwSPDJy7TW/e339NgofvbbLzn34W8pMC0u2zCO8kxYmo
         0WHyNvT1+pu85nbrDfloOV/ki3lpWuShHtFaquC1HZvAP7fPgzS3D14Zdwjauhe8ywNh
         QfHbH6Sb+3UYjZ1Y3no5OQOXeOoRmsWhpwoR+Uz9R7CDgn0Wd1qtQ99LTKVe7E9AZ2RF
         FbUFv69Eti/zNcmJmwMCfwqAMp65Ko5eNg/CTxd4WURUqS/LTHJD6mpQ/qIVeRF09tFw
         1cIsxRhyp97oYefRdPc6VnN89RxF2ZltuP1TeIvj0S5oUfxCaUBEhQ+7WukPa1LX+v6P
         UKfw==
X-Gm-Message-State: AOJu0YxiZZmCaZxdyB82T3DJheFZOs9+noJ9sYbDW2V78RSsBDCTS0yv
	XKL2NKL06XGRq8mkVrfwbpAlWg==
X-Google-Smtp-Source: AGHT+IHs/2WGc7kkqOKYqUw7U3gIBEFHtRUjCsAT6m4TrVG9iYyfq51zDosI6ulGoJtA7worvysu+A==
X-Received: by 2002:a05:600c:2294:b0:40c:2328:fcd with SMTP id 20-20020a05600c229400b0040c23280fcdmr1585213wmf.135.1702257310691;
        Sun, 10 Dec 2023 17:15:10 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm4316862wmb.15.2023.12.10.17.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:15:10 -0800 (PST)
Date: Mon, 11 Dec 2023 00:08:09 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 2/4] sched/uclamp: Remove rq max aggregation
Message-ID: <20231211000809.qostlrd5bka6cvak@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-3-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231208015242.385103-3-qyousef@layalina.io>

On 12/08/23 01:52, Qais Yousef wrote:

> +/* Request freq update on context switch if necessary */
> +static inline void uclamp_context_switch(struct rq *rq)
>  {
> -	return static_branch_likely(&sched_uclamp_used);
> +	unsigned long uclamp_min;
> +	unsigned long uclamp_max;
> +	unsigned long util;
> +
> +	/* Only RT and FAIR tasks are aware of uclamp */
> +	if (!rt_policy(current->policy) && !fair_policy(current->policy))
> +		return;

We have a dependency on min_granularity_ns (or base_slice_ns) here that
I forgot to add before posting.

If our base_slice_ns is smaller than dvfs_update_delay, then tasks won't run
long enough for the hardware to apply their performance hints before they get
context switched out.

Beside the new proposed sched_runtime being able to request a smaller slice; in
practice default base_slice_ns is okay-ish.

> +
> +	uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> +	uclamp_max = uclamp_eff_value(current, UCLAMP_MAX);
> +	util = rq->cfs.avg.util_avg;
> +
> +	if (uclamp_min > util || uclamp_max < util)
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_PERF_HINTS);
>  }


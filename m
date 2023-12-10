Return-Path: <linux-pm+bounces-875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B780BD58
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 22:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C02E1C2039E
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4401CAA7;
	Sun, 10 Dec 2023 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="FZoPsK9L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BEDB
	for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 13:24:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33349b3f99aso3614771f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702243453; x=1702848253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqEf7WmuKDGX9nvRdQA8LWh5OGSEy6Iu2m6IfkFvvR8=;
        b=FZoPsK9LRG4psqsGmAMfhEbonWl7qM1oYWXL2NkrKTyc9ijDckexMNcyVe0/btkP1f
         UcS2NqlgT3AG3Vr07JafFUJtu0BVuU6tBAODrsJ90kSdjHqqNWlz+sSzcEtEnuWD3YuT
         GMWfd0n4+ztuM41n72SEsefxXsSb0etAFR6QuBI+11uFZzAUjL2imszV2/Ubxi7TgfFV
         bqcp1F4IXPp7sbkrlUh1wh1SAZYpUWCnFVoA+k36JnaC1NubAIXG/SpMSRkCuJErzvtu
         T8svHvASWAYtNkcetvDc5YrDHIi5WgN3UPEe5kL+C70niG+TMGddQYYwOvFjkkMbtNkB
         badQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702243453; x=1702848253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqEf7WmuKDGX9nvRdQA8LWh5OGSEy6Iu2m6IfkFvvR8=;
        b=r7lScNtfGtSq2x6KZE4Hfylb7EMsCMDPxTHlJvKL9wpNQD/+XzQ3nsNckcgsTF9Ytx
         CXst1a7HoWruvR1zPJ+GgRKrL+EAnEXy/Tib+1tEHN+ngnT2sWTjG4nIa4WsbkGzjZ4M
         c8ySGqDERaVAC2NJR/Wh7jnlwOGbjpCgWLrr6lKqhVzw9IY4sDXUyv+15Ybjyca1iBn5
         6rBcL+4397A5hwV6u835Me0fAJQYyqTqv5UZ8W9iYNIGw3YPb74UP/NlxR1e0Gk0n3Lh
         VXMx49g2/IqgncwSjZfN+hbRd89LlKibi6bEHIDAZsd+JrbMTwPCyqVgYvxj1n51YzSz
         YnYw==
X-Gm-Message-State: AOJu0YwHmFv9KRTDEvspgtMkl47NYCMVDKOkdgwpIDzzShHcYQDvXVrF
	h0YeNTvYZlQSUyfSpDKIk++bpg==
X-Google-Smtp-Source: AGHT+IHk94izCilF/BewfwW/CZqmak7w/eouFIC+6NzSJblcQxRBUIeAZX7fQCm4BQU00/CeXDVuJw==
X-Received: by 2002:a05:6000:4c4:b0:333:28f6:d9e3 with SMTP id h4-20020a05600004c400b0033328f6d9e3mr1730755wri.33.1702243453583;
        Sun, 10 Dec 2023 13:24:13 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600004c400b0033621fe3a29sm706874wri.26.2023.12.10.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 13:24:13 -0800 (PST)
Date: Sun, 10 Dec 2023 20:51:56 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231210205156.kausxdcwsydggwie@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>

On 12/08/23 10:05, Lukasz Luba wrote:
> Hi Qais,
> 
> On 12/8/23 01:52, Qais Yousef wrote:
> 
> [snip]
> 
> > @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >   	 */
> >   	util_est_enqueue(&rq->cfs, p);
> > -	/*
> > -	 * If in_iowait is set, the code below may not trigger any cpufreq
> > -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > -	 * passed.
> > -	 */
> > -	if (p->in_iowait)
> > -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > -
> 
> Why this io wait boost is considered as the $subject says 'aggressive'
> calling?

This will trigger a frequency update along with the iowait boost. Did I miss
something?


Cheers

--
Qais Yousef


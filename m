Return-Path: <linux-pm+bounces-948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E691C80EC31
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951431F2138B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DE5EE97;
	Tue, 12 Dec 2023 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kUKZmeuo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0315170F
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:40:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso27201175e9.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702384839; x=1702989639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEInFwXfrwxR4sFrknUGYX+rR0E8l6zymNGh3bpC2tI=;
        b=kUKZmeuoA2BL0arcRItjJDzqMaTmlQv0lcci51NmGBFDYhZp9CsKFs4L2WRg4WgDWC
         H9+XaJ8bMHk6oK7F17hfqsz5babIrB0xj8MMuM9gKd1dSWm0Wa5pUEzhZqRd7oCM4/fl
         9Ya5QVlswtcK76qJhGkM00oCefYa4ayJYOVg1C8MTKD3gt2mAXIgEvcPpfcmFJBuMU7U
         5wQFRloWBE4JDjMlBKeJrriHhPi0bI/+kJ21Lsq0oFo9s/xNJI+QXvi+vLYm1YIojGdd
         ye6JIZlHrdSdPaxrmW+bQxt64exh6mDlSfE+N3YevLrIxLuhID08liQsI9YTGcXfrJDi
         0AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384839; x=1702989639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEInFwXfrwxR4sFrknUGYX+rR0E8l6zymNGh3bpC2tI=;
        b=nHtRbi489U/SZ3zFE9CqESJfgIJE865FzINiBjrnwIq7zQKcd8aVFu9o1vdXgiNAu3
         N5aQiCnCB/G5P1+cR2XS+bu7R9+Hrqzq1LLOOuKTJXj5cTKijpDCmSjEMw35743ruaAL
         GjQwUVBtFgmttCXotJ4bQqmeIUoUp+IbW/bDJyBnQ1nlnttqgpZFQLzx8kmDrfNWaIGB
         0DdNgre8+aEW48kNq47gcHCfQ+csxPqVyalOWBItU5Gn+d0SYt6ufyrAKbdkYV2rqEY+
         qKJ3XHXpMxcrqFiTNjuAx7z9lh9zKWUCgvVWLvdUtc5sCPJqEyvO9CYMa2UUlWa+7/JO
         pBBw==
X-Gm-Message-State: AOJu0Yza4Xf8z0DeOQurGjiHIGxJhDz+9I00K96L0QV5UBfhbZL/lcie
	MlBSuD9MeI9RswhFEjkNDLdECw==
X-Google-Smtp-Source: AGHT+IEcP9feutn+YHeiAGhIg/+iM2mTSQxn08hnetlycIsYkr1ZTqWNunBC21LxXDYDPIOUkYtwPw==
X-Received: by 2002:a05:600c:3784:b0:40b:5e4a:235a with SMTP id o4-20020a05600c378400b0040b5e4a235amr2753723wmr.92.1702384839171;
        Tue, 12 Dec 2023 04:40:39 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040c4620b9fasm7999178wmq.11.2023.12.12.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:40:38 -0800 (PST)
Date: Tue, 12 Dec 2023 12:40:37 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212124037.at47izy5xp6lsxh2@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>

On 12/12/23 12:06, Vincent Guittot wrote:

> > @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  enqueue_throttle:
> >         assert_list_leaf_cfs_rq(rq);
> >
> 
> Here and in the other places below,  you lose :
> 
>  -       } else if (decayed) {
> 
> The decayed condition ensures a rate limit (~1ms) in the number of
> calls to cpufreq_update_util.
> 
> enqueue/dequeue/tick don't create any sudden change in the PELT
> signals that would require to update cpufreq of the change unlike
> attach/detach

Okay, thanks for the clue. Let me rethink this again.


Cheers

--
Qais Yousef


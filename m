Return-Path: <linux-pm+bounces-7733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6255C8C2ECA
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 04:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811D91C2137A
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8EF12B95;
	Sat, 11 May 2024 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rYyYJX1R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E724EEA9
	for <linux-pm@vger.kernel.org>; Sat, 11 May 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392989; cv=none; b=eHT3KL8DScuVgNxw0F/1QrQNYBytwEBngyoHiPe/atURviA3EH6QgixEeegNn95yNw6a+B0KP9rPr2afxIJtLInMSU/ns8zEGTnh4cYoZ8hKbT4eIijgF0JC2tbmmFW5Lz1o/29Wo8LjPTR4tn7JrKWj9tao+buTc5ujQzvhOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392989; c=relaxed/simple;
	bh=23NCtM4rk91GLA9JKh8efv+I/oh07TPyt/vfGu2aLuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTWqHlO4i+LJRvdq9v4MphItWgcX9C56fJuGKX9l2QOpVdD3VMdNjBrEs6k017xeQy62MmDYc6kc/5zf4ejoLCRNjLYICsyTqgodeUMC8s9k4pPFeZCrIHA3q1h30UOaWHc5zPY7nCnWYofSU7zO4sGdBAuwQaC0NAWoXi18vcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rYyYJX1R; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b7a26326eso18154375e9.3
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 19:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715392986; x=1715997786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6V27w9Elu3u/pD8Slmp6ksTzr07hsPIaIb7/sQr47g=;
        b=rYyYJX1RFtQtI02lTjDN4ppYamBcVMGgWRYCi2UiuBkOAUW3yG85SmWAfPf9UUoKHy
         hxTVMJQ4Ci9ufU1kDIzq5YKdwTE7XM49AbTAwxh1X+RKNELnFJH0UvXqoNPBlzwoMy3S
         CMavNqEpmLcnCfVhU8oi0BmdpDIjL0Mx2eIp4b7BtGVFgcNG5R+73+usbMBEarfpFtV0
         dNFdVrcCTohYyo7zAXPvlzOqWSt1qXDoOy9/PXmx6poCybvZ7B6agTvKaT++ZLGMVKhi
         KO6nGWknGIthC/zhFDLtAx8XhOLhiFW9OVGgFKxoImaDODtEJCDc9FFuPj1Ecy5Z2YXi
         UPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715392986; x=1715997786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6V27w9Elu3u/pD8Slmp6ksTzr07hsPIaIb7/sQr47g=;
        b=D81g6xvTYvvZF/AqeiNjhHSZ1G2QcJ3qBkDnI+8XBWyhhYmB3EIZ1gBwXBkWnQ2oUI
         qhLMzja+MpXGtf7v1oD6X5cpIlMdh+YRLwPNgAVasPS07/3ywr5fqu6iA6hnVbmbnbWw
         58B9VPtkfDsQlGLwqK9PkvG+fET4Xpa7wUtCjszweWzAX6nSjnGDCa5FWYubhlCHX81e
         nE3xf2fqEvttJaDWTK2D7KGHpqxlhnxO3TzM1l77llw7V898zL23fcB4Y6ldFU28tqUb
         YIImHTQJombPi8f7bL3hpaK+wXlKiB+C0F0kqxjoXDFN1HP9Wi5BtTEGqo7BYrQKZBs/
         wGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtd3BXHHxExxlh931RJQfHqrk54GNnrPsRXoYJ0NkMhu6PDg+tawyF48u+0OGx+Hv+EEps2JZqXgzZAL7mpfa4LxAMuUF1exw=
X-Gm-Message-State: AOJu0YyUaVME3D7alutB6dvuLV9XYhaqx+RgvI4GVxJyYKF4oY5f0+qw
	DQaSnr9ZJBZ70tTqIMXmT6URMP9pOL3xEzckW66JIXL5oZonLlmHILCHaJ2Vlog=
X-Google-Smtp-Source: AGHT+IGLtqTVf/kA9u1uh02f0R98g9CKEcqESRK8UYS5eXXvG54c0e7v5dfvmqZg32fgcgo3LExIrg==
X-Received: by 2002:a05:600c:1c1c:b0:41a:c170:701f with SMTP id 5b1f17b1804b1-41fead61f3cmr36992635e9.38.1715392985507;
        Fri, 10 May 2024 19:03:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff6fd7e73sm41994055e9.27.2024.05.10.19.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:03:04 -0700 (PDT)
Date: Sat, 11 May 2024 03:03:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240511020303.c27wr52eqflft2o3@airbuntu>
References: <20240505233103.168766-1-qyousef@layalina.io>
 <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu>
 <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>

On 05/07/24 14:53, Vincent Guittot wrote:

> No I mean going out of idle. On an idle cpu, nothing happens at CFS
> task wakeup and we have to wait for the next tick to apply the new
> freq. This happens for both short task with uclamp min or long
> running/sleeping task (i.e. with high util_est)

I think I found the problem, thanks for catching it!

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbe79c8ac2ed..dea9383a906e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4714,7 +4714,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
        if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
                __update_load_avg_se(now, cfs_rq, se);

-       cfs_rq->decayed  = update_cfs_rq_load_avg(now, cfs_rq);
+       cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
        cfs_rq->decayed |= propagate_entity_load_avg(se);

        if (!se->avg.last_update_time && (flags & DO_ATTACH)) {


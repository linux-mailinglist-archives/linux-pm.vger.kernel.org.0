Return-Path: <linux-pm+bounces-13888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B3971B35
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297DC1F22EDF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEB1B9B37;
	Mon,  9 Sep 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQNQ+Ou2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D401B9B41
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889100; cv=none; b=FIU6R4U9xM3KpWgbLfOQR6vMNisiXOjDZgj/YAC9wFVtGMMIDts54eVWfV9lZy5U3ya7AYupoQPNbGofWGsdbOMjQilUFS++ghnYo+C9MV2DHZ+T+CfQvhu9AeotsB8BwEF3lR4L4qCGIPohvszQmasmVi3cDTM9zBWe3ZuSKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889100; c=relaxed/simple;
	bh=4JtttTg184hPjhbSUxHmAX54px/ljcpQVT+QyrGE07E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUsqR3AGRHP6cYzY7TgdsUliL5gW0S7ib0aWG43hxRanZMQ9FsS/SOLSjqDJo4c9Q8lAt0bBkun7Z/MZ38EGUHECmzTESPemQLCCQw3aFk9AYElnNfjL0pWwi+XmG+m4dLm9o7OWQYyhf18w1/dj0lWDOTeDdQzZOHPqrGv7v5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQNQ+Ou2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053a0bd0a6so46211795ad.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889097; x=1726493897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sh1bTqKg0D65aguFyhg6kqtTdyiHMJ5ZzX0ZqbKXdZg=;
        b=aQNQ+Ou2JKbE7AMNMI+Aw3Aa6wpSVkRXprckN6NanKjb/TONLWjnnLGMGfJGI+2ZzQ
         paQkScelBAPIa3eAsf7aDdy6nvRa/CKK3+iGHbL71MPlD1BUcxXIzfWDdxCQZns/Rjgn
         ttNeUd7u2+GHHY7tHrHM6crKtC2RCQylrj7pXaLf8NhpNLO5DK0ncJvrUKVAdb7X8uBv
         6/IwVoJhRD15XK1Xw/BQXeAdiCKdFbbFW2b7LfZsnRvRJ8/RDK8k/DmDCKf+bIhLgmN0
         /HaVsOYNJ1Euy4iNL12JIzgiTm86nimTCQzt2/oOIwMVDSL4niq9/ha1SCEYoIqoCXtA
         hGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889097; x=1726493897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sh1bTqKg0D65aguFyhg6kqtTdyiHMJ5ZzX0ZqbKXdZg=;
        b=QWCzMdcdxqDjeqrGR1CLH1S3XDXLgl3P2Y8TTuu5drheuvX87lYqiUG0wax1vKKU71
         QnJv+Td9BNQZeTNAWNaCK9s2xe2OJc0THCKC3RdQXZ5T6si5gAsQqoyTzdCtGGYRU6fu
         mKTYUxx7CFTmnesfIh6qXeCbV0MfwKxjTudadf8R2CbeVCtdb6ZH8dR4RjwyLOgER71W
         RNzdjmFlz+jEdCHWesx3lH33RshP6IT0uF7DuKgagZLMZmhcsJP4DjUhuQG1+gVnMWXh
         hi8NvjwTO2a45CRthJbfT7MEU0xCkL2rLyEAzr4eiMRTZGHP/Bzjcs6EP6gzvVbizSQN
         lSVQ==
X-Gm-Message-State: AOJu0YwQA9/bIGZwOnaPI5Sg5RDd2bkC9UqN5IRpTfsYU/ujgIXXPPh3
	4Oplld51buMrF1skwmxdd4bdg7ja/YXtGLhNclaBicIZ0lFviQF2hyxfbTl/HPA0Pg5zRZRao7O
	kcGW9l0zR4Mbk/jl/5UqGBr3fPmlQmODR+oIMrw==
X-Google-Smtp-Source: AGHT+IEGP14U1qyL+yzSZUl+d/8B/ITwt7vjtE/Q7so7NSWaxQJelr/V8UDcXzllYjE5LVNwjmnXVK/U1hj+NcyhExU=
X-Received: by 2002:a17:902:e550:b0:205:7574:3b79 with SMTP id
 d9443c01a7336-206f052e0a6mr140871925ad.25.1725889097277; Mon, 09 Sep 2024
 06:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813144348.1180344-1-christian.loehle@arm.com> <20240813144348.1180344-5-christian.loehle@arm.com>
In-Reply-To: <20240813144348.1180344-5-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Sep 2024 15:38:06 +0200
Message-ID: <CAKfTPtBGm0yx8AAxY3vseMvrRWx3FRkMGSiDVdTh25ueJ-CNiw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/cpufreq: Use NSEC_PER_MSEC for deadline task
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	qyousef@layalina.io, peterz@infradead.org, daniel.lezcano@linaro.org, 
	rostedt@goodmis.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 16:44, Christian Loehle <christian.loehle@arm.com> wrote:
>
> Convert the sugov deadline task attributes to use the available
> definitions to make them more readable.
> No functional change.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

I missed this new version and your ping to Peter brought it back to visibility

Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..43111a515a28 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>                  * Fake (unused) bandwidth; workaround to "fix"
>                  * priority inheritance.
>                  */
> -               .sched_runtime  =  1000000,
> -               .sched_deadline = 10000000,
> -               .sched_period   = 10000000,
> +               .sched_runtime  = NSEC_PER_MSEC,
> +               .sched_deadline = 10 * NSEC_PER_MSEC,
> +               .sched_period   = 10 * NSEC_PER_MSEC,
>         };
>         struct cpufreq_policy *policy = sg_policy->policy;
>         int ret;
> --
> 2.34.1
>


Return-Path: <linux-pm+bounces-7788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97FC8C497D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 00:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D306B22539
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80584A4C;
	Mon, 13 May 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="c/hxBFsJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D32119
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638148; cv=none; b=JoouOx2VMTGCmuA35bP0p2Oi70mwIUDR/9eo20UgZ7Pbs1spn7dsZ+KwgMW4SW39NW+eUS4S123gPsO2uJWNgTWAZIRZGfYVNfipk1MYZSYoHsXEpfoataQIfcttMCj3xXHjeUm+99grk0KrR4TcKO75JC+B2eig1F7/osSDdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638148; c=relaxed/simple;
	bh=vi5iaDvRQg3CqeJvi6xM7pq0n5laaRvsoKlUNFzlm9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK8fO0vSrpUvN3yXqx0zKhhCp2bVTCWOzLVfzaKv/TbHnut5aVD/XoMGXQembO8gUp2pGQsT/d87ydnXaFMHyrhxj+CyiSQu+1tHc4LLWdJrKVpApP77ie7YmCuH3Fq0AWITdbw1DN7Utwx8YztYMgUs4F0ShdSDwVunR4VsjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=c/hxBFsJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34da04e44a2so3899424f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715638145; x=1716242945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEF+7Zh6Uoh6U88ZqyDfhKlBt9uWxrFMHSIjui5E6d4=;
        b=c/hxBFsJiQ9/DMCQ7UTPmerrSqHpwkU60w5dWmp5sPyjkGeqVPCrsLdHHPGInvU5TN
         5jDawbnoYLY/WYg60ll4weEHxjjeOle3cqekO8ua8y7v7b3HylIyoM8Uf3mw9zA9qKxV
         THPX00Kx3x/CWDYKCDf4RzsirM2AI1WpZPvK8LB+1vItnOXn+eYAsCNOhYa5KmoW3+nS
         CcpV3RII45dYJohyNAkZDN5B4ADb3Yd9x7JUfx0hAsu5dR4P995EOn6esjVejgR8onEQ
         N+37qvSnFLGSiWdYj6ByRAS/fKm/zaqqx2Ak+YElx6+ol8wgO15ed1/+QS8pv2n94bvM
         IVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715638145; x=1716242945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEF+7Zh6Uoh6U88ZqyDfhKlBt9uWxrFMHSIjui5E6d4=;
        b=Ajd0BSacYT3k6FFMBOnaQFwVTnarJGyObjkOqwcx3SAjo3E0QXKGsda+/HttxvJmiA
         SvHkwVkhjzZZMyxdlPQkr4CyPMCD/Z8u3EMfKjDoeYKBCjHiI78nnMRM7AOzr/qv7FJo
         N7gy9lcaOCdapWU3Y03CXD6Qr5Y2+uuYkyRBzRUDS8UpNuwxECWgNYAMawb9V1jDeQVC
         li7sJcZtOVO02NWfVrX3UAjNFvqNTTg4+2DYmg2ql4PpKm569Z0QoPqB8wePfqIkf6kA
         SpjygDe2bUlkJlOBRwMR9a/YDxgGgy5wEWqDLrZTa3E9fecpEL+0Ge/D6cHu9YOdL8XQ
         EN7w==
X-Forwarded-Encrypted: i=1; AJvYcCVDlNHb4nNyx1qmETv2X11l52/QslLin5Ww+gltCzjCVK3H/qVbFrRHCbT+yP7qLap+jbe8SFkpnogSJSBgqW/iDrzFXB9xMmo=
X-Gm-Message-State: AOJu0YyTGfuXrCzFXV7TTtvx5MrcB6V4WdjdR/o70AUXYYKHi2esdG3I
	YTr19U2VVVc+wrrtSqCtPuzX2mlGE/AJMk4ryLuhM9fSeSSnolgJQp1i+K4WY84=
X-Google-Smtp-Source: AGHT+IF3EknNB8B5pOL23xKet8GPy31iFfknB06WMrwPkJSwM2TCrKcEoJPhIn4hrlO5GGr/6WvANg==
X-Received: by 2002:a05:6000:c06:b0:34d:9cbe:d36e with SMTP id ffacd0b85a97d-3504a95836cmr7019368f8f.50.1715638145427;
        Mon, 13 May 2024 15:09:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b79e8e6bsm4413455f8f.65.2024.05.13.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:09:04 -0700 (PDT)
Date: Mon, 13 May 2024 23:09:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: Consolidate cpufreq updates
Message-ID: <20240513220903.no2j6zl4tk7lr6um@airbuntu>
References: <20240512190018.531820-1-qyousef@layalina.io>
 <9e845146-8a31-407c-a5ee-e2e32f1655e5@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e845146-8a31-407c-a5ee-e2e32f1655e5@arm.com>

On 05/13/24 14:43, Dietmar Eggemann wrote:
> On 12/05/2024 21:00, Qais Yousef wrote:
> 
> [...]
> 
> > @@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  
> >  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
> >  
> > -	cfs_rq_util_change(cfs_rq, 0);
> > +	cpufreq_update_util(rq_of(cfs_rq), 0);
> 
> Isn't this slighlty different now?
> 
> before:
> 
>    if (&rq->cfs == cfs_rq) {
>        cpufreq_update_util(rq, ....)
>    }
> 
> now:
> 
>    cpufreq_update_util(rq_of(cfs_rq), ...)
> 
> You should get way more updates from attach/detach now.

Yes, well spotted!

Looking at the path more closely, I can see this is called from
enqueue_task_fair() path when a task migrates to new CPU. And when
attach_task_cfs_rq() which is called when we switch_to_fair(), which I already
cover in the policy change for the RUNNING task, or when
task_change_group_fair() which what I originally understood Vincent was
referring to. I moved the update to this function after the detach/attach
operations with better guards to avoid unnecessary update.

I understood this will lead to big change and better apply immediately vs
wait for the next context switch. But I'll ask the question again, can we drop
this and defer to context switch?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43f6244ab0f9..e791969360d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4659,8 +4659,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s

        add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);

-       cpufreq_update_util(rq_of(cfs_rq), 0);
-
        trace_pelt_cfs_tp(cfs_rq);
 }

@@ -4689,8 +4687,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s

        add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);

-       cpufreq_update_util(rq_of(cfs_rq), 0);
-
        trace_pelt_cfs_tp(cfs_rq);
 }

@@ -12856,6 +12852,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_change_group_fair(struct task_struct *p)
 {
+       struct rq *rq = task_rq(p);
        /*
         * We couldn't detach or attach a forked task which
         * hasn't been woken up by wake_up_new_task().
@@ -12871,6 +12868,10 @@ static void task_change_group_fair(struct task_struct *p)
 #endif
        set_task_rq(p, task_cpu(p));
        attach_task_cfs_rq(p);
+       if (task_on_rq_queued(p) && rq->cfs.decayed) {
+               rq->cfs.decayed = false;
+               cpufreq_update_util(rq, 0);
+       }
 }

 void free_fair_sched_group(struct task_group *tg)


Return-Path: <linux-pm+bounces-7760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200ED8C3D8F
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 10:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A098EB22900
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC621482E9;
	Mon, 13 May 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrMTWOPD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B46147C93
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590235; cv=none; b=IHWLD8L6hGLzyvLKse+gmFs9WKv8R9Rvi4bBMjzF4ixfLi3cbq87JvEukK1WY9OLRM8RAXVFyNQw4f6aW8S3w1VDC+wy6j9YrzsTF6ONcr+i/Iz6uTxlDVaVp8eb1jrGO23APT+r5LamCvCwAbso50zhr/OfWfec1aSZy4LWSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590235; c=relaxed/simple;
	bh=t2CpuG2/kXnCeTE/h8lPr+FMfqwXNQ5Ys+9794rjXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEpFb+peBeGs6iD2qX7Ww1uhTPeFUhCkmP3t5Mk2Is6mKwxzHAAC3wnUEep7T282gZtFCyO9HCRiYMITybxIyW5dw701W9FovDokJzCIcb5YuPfxPsaWTeW2SDNzGRE7HU1wLg8ckQEiRmaylBiJ1XX4ThpGBWpGB1PZMrl5MrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xrMTWOPD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792bd1f5b28so437088285a.2
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715590233; x=1716195033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7++kW2Cm2K1g7q3S48vKWO4QTE6hzmFVZfJMpS2VOE=;
        b=xrMTWOPD/nGYN6oAofxf1WL+q0jIplyPEYwzxkM8gvbe0Qjy3BWHT4YQ5OWda7WY89
         Xoyf/ZZ+tvpi1YwCbTyTdOoJKgqGNQhuO+0RF10norYt+5l59K/IVjl1K3nuoYEs1SjB
         zNUcYve7NhdvCUeenKU9hYk4DpaDWgjUPjbEzPBDWq3ieichMQg5x5rXjAIn6sFZ0iri
         DVRjwIABIitkXBo83SnWKQQ+0CZd5SMzDyYfi0kGj1vnUH4EJGNsGi9DRpl/TosQzFFB
         ght3RB7Bqo2AESl+Yx8FkDoC4e+p+tIZ3OeBvj6MKZVeYPR9fpGuXRIk8/gVmXYlQ31e
         Xydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590233; x=1716195033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7++kW2Cm2K1g7q3S48vKWO4QTE6hzmFVZfJMpS2VOE=;
        b=EKjuu2Nz0dtMZKxxyXs+Wki2K2r0giAXhVY8n8tk1EIX+HJ02pi0CF/QsrU5Hdlj+z
         Qrq7lJ6p2ZlKW0AXo7pTEl92JM+Ceya5Ec2PKPCpLI9CIcgugltw1rLNC8yZTEi4nao0
         7p1jJCuqJN6y6p3XLBMqNGAGwCh7lBWWJXCLeSgbpEuM/krBldvmL1hIgtBBdr3kanoj
         aNEDja/qvx2Cb//e7LRTFmBJPDuXHuKbHMk3kTICrPaaqyAXU2TwIH8VMIy0jnHV7llp
         1cHZu9XG8Tjv36XLcyJ3Sx7OHkzFVJQxEvY66hCuyGwC/cUdCU7n7RB+SKBMs1arFywM
         457A==
X-Forwarded-Encrypted: i=1; AJvYcCVx982usL6G2iSL2HxghbzRs70YV8qlmfHyKIzICN319Fsj4DMt4AXodHOiQpoJV6U9aUwt7ROhOiR9sl4FdnrGP16TSpbI/qo=
X-Gm-Message-State: AOJu0YxWH44dC4ROzhpLFd3sAuLgllnP7GgCULWVC2NgwiMuqDTPK5Rp
	6jIsPbP45YoyjViLEMXKrqmTh4rMvvZu2rX2+gfMPxAQcIq+L9lBpJqIjYtG8SfXip72U59EA1h
	9qluMd0ZilYHDC1XF+sZqLtCOS3NWgzO8YQ0SXg==
X-Google-Smtp-Source: AGHT+IF0Vv5wfCSDrAajeXEdHfFjYzk73OIgqIT9Tf6OHm+deGoTKaxKl7QrCK4aOkONq6C5mZzP/vrdPcnxOA4XBEw=
X-Received: by 2002:a05:620a:4085:b0:792:c3a3:ba3b with SMTP id
 af79cd13be357-792c75779aamr1186274785a.10.1715590233169; Mon, 13 May 2024
 01:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505233103.168766-1-qyousef@layalina.io> <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu> <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
 <20240511020303.c27wr52eqflft2o3@airbuntu>
In-Reply-To: <20240511020303.c27wr52eqflft2o3@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 May 2024 10:50:21 +0200
Message-ID: <CAKfTPtAaxGrHjQyikJdrROA3qdwp08R-b6k0zo=u146emeBncg@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 04:03, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 05/07/24 14:53, Vincent Guittot wrote:
>
> > No I mean going out of idle. On an idle cpu, nothing happens at CFS
> > task wakeup and we have to wait for the next tick to apply the new
> > freq. This happens for both short task with uclamp min or long
> > running/sleeping task (i.e. with high util_est)
>
> I think I found the problem, thanks for catching it!

Ok I will test it when I will be back and have access to the board

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cbe79c8ac2ed..dea9383a906e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4714,7 +4714,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
>                 __update_load_avg_se(now, cfs_rq, se);
>
> -       cfs_rq->decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> +       cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
>         cfs_rq->decayed |= propagate_entity_load_avg(se);
>
>         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {


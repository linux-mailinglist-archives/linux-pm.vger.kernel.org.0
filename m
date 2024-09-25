Return-Path: <linux-pm+bounces-14650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3098553E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5073D281165
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8A11581E0;
	Wed, 25 Sep 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkWaqbgc"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45211547F5
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252083; cv=none; b=qLsvYjNgBcA18NCRjUyLh1Vqo51FXbAc6JOSTwkTRfNZ4kuglIfE2HLG7aqvrq8gGNnsve4Tq9Km93U/of4Q8Xw3p8QjNvgSb+mL6BkdA0rNIihh04fZKAmLVrwMbpG+lmIFaUnli19f1+4vNn/fhhUy+8nPnXxzuoJMuMQJUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252083; c=relaxed/simple;
	bh=BM4+PHT5MQW1tzpb5VK/c/ddqQXat3uRsnUaLXnXbio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/ZHG2WuqpwnDlfVakT556VSpTIohg9zSBLS/Pkw6zCV5qhD67YxhXGENDwnk+rlNMA6QFcZw/RTxjqqtFa80/OipyK1XlP2tbVIvInBo0m+LXRF6qLzL0HSoAY6BZ5/gUEqt3iO9MIdvRtrRXgz5yYL/eOgCOfxQ2J2o9JX5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkWaqbgc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727252080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohfUwWhacb0visOzTSsijGJM7JyOseW65bAWIgeEGW8=;
	b=NkWaqbgcF9FcnmYAG5x7gQgaQvSyvdmfpbm4U0w6IugTmL18yVZy/Jsbsv+iE26pnk0aN5
	ADc79vYN8fTfS3p+dnn7WOieKuaGpt+DETc27Rfr75xfCHaMjQJVhDf075lPo6xm1c9QoR
	lpr8VQ0vBIt5Q+hBTY3JtJ08m+A9VcY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-6S8aFNAOM2ym4yjS9ZyzDA-1; Wed, 25 Sep 2024 04:14:38 -0400
X-MC-Unique: 6S8aFNAOM2ym4yjS9ZyzDA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cc4f28e88so227548f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 01:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727252077; x=1727856877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohfUwWhacb0visOzTSsijGJM7JyOseW65bAWIgeEGW8=;
        b=oFTk8WuUObXgqYQYE63kRM0AsbupqhJkdesrx30AvXUt8zFqXMUgORFUGCB5xswfD+
         j0LkBen6L4PCz4EaWKEToCTMIyrgk20njKCA8ATHYxVrj8lMAzUBJuCvobIHPcSCldNz
         dqAE1z6cHxOqnploCBMntBZOQmMBpuNCQfJXj6HrZRLUfGTUb0LBPdSqgEX71PyDFrqd
         EwOkSr6CF5/auFeZQ82uX7kYFsPtqQCisQmm0C2Rle4iqHNW4GtUgXAHgsQAOvlfWYUN
         XJQxOAEgIQI47tsCbIN+D3PbldwBiVhI2gfNy2HBeAT9K9dxgz5KA8/AMUzJmszXQuIe
         HEEw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQdeZvHSXcZpT6cB7hU+9GhUrYST5IDWxntqOFxmHGm/NAuuRi67kVLq9X+zZ2r31ryP8DBxPHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKexWyZMk1rz92Z3u+1wC3vyWH7829DtkAvh+Mqsa5FjlahR2
	w+B6G+pzpB5uqX/wcpu2PiluukxyvRwoVFl1EZM/86WKmA1WFCXqzYAmIRI5wD+xD4Uog0u3+Ev
	P2iBvL3OHVC4t8dP7GAcNPBcKGllCdPNSpuSwLSmRMr4+vlyhNti2q4le
X-Received: by 2002:a5d:4e0c:0:b0:374:c6af:1658 with SMTP id ffacd0b85a97d-37cc245d187mr1943057f8f.1.1727252077191;
        Wed, 25 Sep 2024 01:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvvX0qsLkCUiC24qNlWQhIP1iZa0HBvfDgrX63bwheFNg//fcomFIcU8AuFJMGHgav4DSreQ==
X-Received: by 2002:a5d:4e0c:0:b0:374:c6af:1658 with SMTP id ffacd0b85a97d-37cc245d187mr1943023f8f.1.1727252076661;
        Wed, 25 Sep 2024 01:14:36 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f3cesm3323261f8f.98.2024.09.25.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:14:35 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:14:33 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
Message-ID: <ZvPGacuDDXNa5k62@jlelli-thinkpadt14gen4.remote.csb>
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
 <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
 <ac4c9060-e447-46da-9f37-167864a7906f@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac4c9060-e447-46da-9f37-167864a7906f@arm.com>

Hi,

On 12/09/24 17:01, Christian Loehle wrote:
> On 9/12/24 16:41, Rafael J. Wysocki wrote:
> > On Thu, Sep 12, 2024 at 3:53 PM Christian Loehle

...

> >> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> >> index c62acf509b74..7d4a4edfcfb9 100644
> >> --- a/kernel/sched/syscalls.c
> >> +++ b/kernel/sched/syscalls.c
> >> @@ -1159,6 +1159,9 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
> >>         if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
> >>                 return 0;
> >>
> >> +       if (dl_entity_is_special(&p->dl))
> >> +               return 0;
> >> +
> > 
> > Care to explain this particular piece?
> 
> Looks suspicious but the truncated comment below explains it:
> 	/*
> 	 * Since bandwidth control happens on root_domain basis,
> 	 * if admission test is enabled, we only admit -deadline
> 	 * tasks allowed to run on all the CPUs in the task's
> 	 * root_domain.
> 	 */
> So that would only allow setting it to all CPUs for the relevant
> platforms unfortunately.
> 
> That should be fine though since the sugov task is pretty much
> a dummy in terms of bandwidth / admission control internally, so
> no harm done to not enforce this when userspace wants to set
> affinities.
> ...Unless Juri disagrees.

Nope, I agree. :)

Wonder if we should put a comment along the lines of what you said above
right above the new conditions (so that people will not need to wonder
about it in the future). But not a strict requirement for me.

Thanks! (and apologies for the delay in replying)
Juri



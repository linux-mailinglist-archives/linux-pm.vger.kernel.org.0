Return-Path: <linux-pm+bounces-30299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61192AFB766
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 17:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C89A3AC4F7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678454D8D1;
	Mon,  7 Jul 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciD5xaXZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB24A1D;
	Mon,  7 Jul 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902263; cv=none; b=kYDLu1BHiVrXSKWRD+LNypwCV7TzxM+ls8rLKkqRmeM7uvzA9ix06H2ShRhPrpPdCZ7y/xQF5BPzrOeupT8BV7k+Ao5pppd6J4XXTdzuTyQLthJff7N+Xq/Sqy4rVkcei3W5190T9f/Cjwvgsebw1n4EFc+OR3O9xztrqZdOmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902263; c=relaxed/simple;
	bh=ATyJMtGHG3jO6qs36Tb4q7P8Z755/fLF5s4dPMEYyZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD5PEz33pJAG68xIN+UEcTcXzfCdhK82uAVUWd9c8q0FFyjkstjtujAYWpDyTJlCaUyzc1t0RoJ7pbfCNaYuqqNjqO2I2zk6MzxfNcjROZwco7ZNfseAlZjtOg7kHFUoSR7a7GMsKGzxQyiUwg+d0SZkiTrMXLIDyifdz/eP7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciD5xaXZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-711d4689084so31581877b3.0;
        Mon, 07 Jul 2025 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902260; x=1752507060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djyfmWSct5qNckSDJV4cIn8Eu1LxyifzuanxHWIj8bs=;
        b=ciD5xaXZBjgBhJLuHwcCFc5QNOqsJ/hvt0kme3/SPRvuNZbWkxahQcifuWiKm2Ue2R
         1gvj8G7yGiCf0qlXtUuKjIpwn2AaEfZfKCfLIJXOri3BDgdexCPVRZd98HFeIB2Phnd2
         LMxhyBNe8tvma/RxhZEwxzgUOxlRFsrBRDVQguONp4OO7OdfPolxmxtzAfRPKzzHe1q1
         sOuW1heViPUSJUE/kvEWK9n8bejRTwfu5Oi8zhmcz42oytk5FGPRPZoFNYaEV8XoxzkG
         WFjYWmjkfhA+60nrEqjU9X8EF9OL2HcUNcRy220NQZa6GIrXJVZOKPueLs5QguexaVA0
         91sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902261; x=1752507061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djyfmWSct5qNckSDJV4cIn8Eu1LxyifzuanxHWIj8bs=;
        b=GwdJvsgAL5eQde+OVigWxNhdHA/J6hVv/tqbpWlyym3UfodLMTsiK6Xz3OAHlEJVE3
         QOb4UhIwEEse0pjWPu6b2KwBPWb0RtpdAIOaqJrnl353pqbrQ7tKO3scRV/UqVFJ75Xa
         4XohKBlxkgxKZxxPP2mmqAlzd91ivmRMrAaLKHUWT5hHQDdy4PSwNywx4SlXL2qGCij4
         A55euNwthQN6TPG+OnqTg48k7IF+n64J/I2UakdcgurYEfleCHJG+rDCnQ3yQlPXcjLk
         8de7CDx1Bok2rSiehKTDM46+evjRGSZ9rfjD4ANH78x2Fuky+3IeAdzFhFYEWYsX/mJe
         LQSg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNOOheiUo7V5aERkfxpwwcYSNnX0SP0a7mCJKRfBxeM11P6IPC1gIuf0LTu11JoinPF272fFZtRR6xEU=@vger.kernel.org, AJvYcCX2t8Wb8tV7Hhy4YvPCW5gMYPKlKLbC9hHRYD5JhC74PNiPtINqJHwoPvRXxs1J8t50ZW1zW+0Bsr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTqxvUdBx1Ay9l7BEoG14NGA1N15OIufJil5g/oGNhPQbhBRV
	jjJO3afGv8zE7CeDkv2sLfMNTmEkF0Q1LujduID6qZw+h+uVltQ36XRF
X-Gm-Gg: ASbGncuqqpt1/B7Mrwu6lC4Yn8drF4kAWEusZ8xfKHEJdJ7vUxfXxrFk6TRwDoCSDBY
	CXh07hQlJm+9txUsZng3OgaaYd74cwKQaC4cKzh6qTwM3i8X/YLqlUG08Fm7oie39e1ZLyWuPZK
	cGRuNx2/v6cRMVYtZmB7X17Dq8NcRC/yjxEdrtRcuZ2e4vR6F+jdlMlgc3DTUATylwSXNXpPtRo
	Qf6ItteWOYJgMKFbjvyTd+3aJAKX3YIp8E0NwxF9UFcG0WF+3+dPXzMogtmKtnM6hUkMFAEpiOO
	z4XxWsr4ATYyDeZurx7KXejcGk6DVu3QMLttWOW6AZVTloArhkGuPcD5beLTMJ+ZD1R3aDM/68D
	+QkZNEM7RoVCqaoXNJ3TOmg==
X-Google-Smtp-Source: AGHT+IFI2Nw9TrN/ywTjkhdkG1RKL2Sap5bXOF20CpZ9ZVyG4mfCZuaIxD2zwR5GZzvX6YKmD1ovxg==
X-Received: by 2002:a05:690c:6302:b0:710:ea78:8ff with SMTP id 00721157ae682-7176ccaa7c5mr110962967b3.23.1751902260339;
        Mon, 07 Jul 2025 08:31:00 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7166598b378sm17075967b3.12.2025.07.07.08.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:30:59 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:30:58 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: dt: fix opencoded for_each_cpu() in
 idle_state_valid()
Message-ID: <aGvoMhLuX0-zIFVk@yury>
References: <20250604213908.27819-1-yury.norov@gmail.com>
 <CAJZ5v0h7CeO+vG4BVcdc=XxcWMRY+OmhrWxtrAS59T-uK1KDOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h7CeO+vG4BVcdc=XxcWMRY+OmhrWxtrAS59T-uK1KDOw@mail.gmail.com>

On Wed, Jul 02, 2025 at 08:27:21PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 4, 2025 at 11:39 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> >
> > The function opencodes the for_each_cpu_from() by using an open for-loop.
> > Fix that in sake of readability.
> >
> > While there, drop the 'valid' variable as it's pretty useless here.
> >
> > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > ---
> >  drivers/cpuidle/dt_idle_states.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> > index 97feb7d8fb23..558d49838990 100644
> > --- a/drivers/cpuidle/dt_idle_states.c
> > +++ b/drivers/cpuidle/dt_idle_states.c
> > @@ -98,7 +98,6 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
> >  {
> >         int cpu;
> >         struct device_node *cpu_node, *curr_state_node;
> > -       bool valid = true;
> >
> >         /*
> >          * Compare idle state phandles for index idx on all CPUs in the
> > @@ -107,20 +106,17 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
> >          * retrieved from. If a mismatch is found bail out straight
> >          * away since we certainly hit a firmware misconfiguration.
> >          */
> > -       for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
> > -            cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
> > +       cpu = cpumask_first(cpumask) + 1;
> 
> Doing
> 
> cpu = cpumask_next(cpumask_first(cpumask), cpumask);
> 
> here might save a few iterations for sparse cpumasks.

For that it's better to use cpumask_nth(1).

I believe there will be no benefit in calling cpumask_next() before
entering the loop because for_each_cpu_from() is based on it, and it
will be called anyways.

I can send v2 with cpumask_nth() change if you like it better. Please
let me know.

Thanks,
Yury
 
> > +       for_each_cpu_from(cpu, cpumask) {
> >                 cpu_node = of_cpu_device_node_get(cpu);
> >                 curr_state_node = of_get_cpu_state_node(cpu_node, idx);
> > -               if (state_node != curr_state_node)
> > -                       valid = false;
> > -
> >                 of_node_put(curr_state_node);
> >                 of_node_put(cpu_node);
> > -               if (!valid)
> > -                       break;
> > +               if (state_node != curr_state_node)
> > +                       return false;
> >         }
> >
> > -       return valid;
> > +       return true;
> >  }
> >
> >  /**
> > --
> > 2.43.0
> >


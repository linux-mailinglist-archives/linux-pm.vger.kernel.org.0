Return-Path: <linux-pm+bounces-38546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0EC84551
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0997A3B1F4A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14B2EE60B;
	Tue, 25 Nov 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CC2AoRKe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CF16A395
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064683; cv=none; b=ko9MyxLMjEa0tXxyWl0Nc1q5jAs/LstFP/vRXXW9DcYlY856TUJKbQCKJL7QidRRr7ZDeo1gAOFFtb3SGh/iXoi2baNHqclbCON5L/fylxEyVO3qfalGMds2vuugUQtWtEJEBFbY/055kwBTQX7J2OHVQO9Vzlu0lw2Hy/I5crI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064683; c=relaxed/simple;
	bh=Y93r+NAz9Q3ugrrl3DN0uAHV9NDiXOsOZgcJBbkLxcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFhysFyMpjX3b9pJKsHzI32QXjx+eAlQo3Z94Hnc/fNBSB0Yfd45DVJSLZl/Pxb+1pcvhsPvAT+lkkvUbO8pJITQr18HCgcs9u/jCGjrD9ihGSN1gn0j4lZRnqAFbrRxirA4Lod/EEHXe8WumwnZWnwyzeXIcPUmwaKxi7804lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CC2AoRKe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b736cd741c1so927601366b.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 01:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764064680; x=1764669480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y93r+NAz9Q3ugrrl3DN0uAHV9NDiXOsOZgcJBbkLxcI=;
        b=CC2AoRKePFNDKdvnu8eqFntc+hflGBBQBDPPXvTXLP912022MTKfjdxDatWU+9YrOQ
         z9BffU0C1JUw0I4YIlKXqSdxNGVlQOdVlo6EoYCSvWuBQBbqN0Wc0Za6owWpJy6xn5WN
         lEscYzeP0iLfmyMPXL9KDHY9xEl1dhn30LGzqcVoDU3vSlPap70mpVfpS36afHMjvLYB
         QcOQSnj+potRAO6X6HeDPaPEQb7YuL79yBmtVxpIb3rn25s6iHsvga5rJtLvOR1zhX2F
         6rt/AT8MkeaeiYdKSdTTc82vqRnwIjCF/hsd7P0zeD6iyLr1WZh5rPb4iGBzIpvYp0W8
         hhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764064680; x=1764669480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y93r+NAz9Q3ugrrl3DN0uAHV9NDiXOsOZgcJBbkLxcI=;
        b=b/Ux04KXDgjKmb2MDkvnkfNwXVYqumzuZU3DvQzePnazGS1DQlnw636gfMTi0CpcPu
         CQMixWvhcLcyv5/mqVZnn1Ma317BpKu3VGOlXNoZIH7SHTAWf/hkbckgoY23VElAZlGw
         PTb9h5GmJsk8Nj2BDuxQHRJA43MbyCGLroedD7+EqsA4tGU3Q09oTgCg5tjYKyWR/r/g
         lGeQdvlxHuW9oEmsY95gw5QWVMl2GyyWIz6PIDQNhPStO/2PRyEgAkHdUuPqX5t6oT3Q
         rWMCQHNWvXVH7ZjzG4fmMVjxrN61zFv749mbdxDFsvcofmRfvBrIl7aTbNCPPG7qMyJy
         prfg==
X-Forwarded-Encrypted: i=1; AJvYcCXEJc5JVqyT/u0UwnSl+SGCbHTT3Ia9BdfkXMnT4QCn066N83y+7y2L8mdkCqZKk6CUSdr82sJrDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGoBB6SmmDf7KI7ZF02n7kp9hX19J6bax16BqoFtr0GHa3/x2
	+zv/LjlOC27xANhG7O2t7gxo7+Z+OTNCIvTisl+ul+WjMohAUqbYVojA8vX0aZP99SPsTYyN/2z
	tuV1to/ZVeCucTmH+ySZuB17sPhtseRJJdn6BuMPJ9Wb52Z8TaPkS
X-Gm-Gg: ASbGncsEU++/kxJ9qiEEVAdfHIePykxsmjcaQtBku/jcS5RcHZUhTrSYEtw4N8Yblsc
	138ZjLM3slizyFtKvP8ju8bEpViBxXamOjc7kgusiFracJVf8RbYTDRwgHNjMvg1yXmdHPFeZEL
	C13NRPInamZRih+B8iWWZj9P7V3Ubk/gCvvuom9IxnUYYMh/7GmbAqWqGxZ60zr7LP57WlVShbM
	C6V2W6H+4FOWfBskUgkCnlK9CaP6vsz+n2Bb5OSkZjMaqYI5tVE2mCBeWh4tWkcCr71eBDi3ty9
	kt3kUhPCkpBGC5sWZQt9Lr8f
X-Google-Smtp-Source: AGHT+IHplYX2hvTMgiKVA1ktpR5uivdWyLSdeM8ENWWZ4cei9rCZHX3gdTAneyNbPoNJPp85dxglQGk1cSfej4VLpTs=
X-Received: by 2002:a17:907:96a6:b0:b50:a389:7aa4 with SMTP id
 a640c23a62f3a-b7671547e0fmr1497299166b.13.1764064680110; Tue, 25 Nov 2025
 01:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com> <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAKfTPtChUavg0TYK_BiA9NnR-9_A1nz49kMASf6g8vCwhpJzcg@mail.gmail.com> <5ce509d3-0e11-444f-a22e-6c01280dd9af@arm.com>
In-Reply-To: <5ce509d3-0e11-444f-a22e-6c01280dd9af@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Nov 2025 10:57:48 +0100
X-Gm-Features: AWmQ_bmE4ITza-ROcviwnYWTaBBkqQYaC8edNpm_j9xdAmwksRnB2rivzc4skWM
Message-ID: <CAKfTPtAh7-gt=ivhOhm2uGt7SuHO5hVBSLSQ_7VaDvkYOVNHMw@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bsegall@google.com" <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 10:46, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 11/25/25 09:38, Vincent Guittot wrote:
> > On Tue, 25 Nov 2025 at 10:23, Kumar, Kaushlendra
> > <kaushlendra.kumar@intel.com> wrote:
> >>
> >> Hi Lukasz,
> >>
> >> On 11/25/25 XX:XX, Lukasz Luba wrote:
> >>> Hi Kaushlendra,
> >>>
> >>> On 11/25/25 03:24, Kaushlendra Kumar wrote:
> >>>> In sugov_next_freq_shared(), the CPU capacity is retrieved only for
> >>>> the CPU that triggered the update (sg_cpu->cpu) and then incorrectly
> >>>> applied to all CPUs in the shared frequency domain during the loop.On
> >>>> heterogeneous systems with CPUs of different capacities sharing a
> >>>> frequency domain, this causes incorrect frequency selection.
> >>>
> >>> How is this possible?
> >>> Is it old or new Intel SoC (a chip name would be also welcome)?
> >>
> >> This is with respect to intel platforms which has E-cores and P-cores.
> >
> > Do you mean that they share the same frequency domains ?
>
> Just to get everybody on the same page:
> Intel has what's called "favored cores", P-cores that allow for slightly
> higher frequencies than the other (same uArch) P-cores.

Okay so it's not E-core and P-core in the same domain but P-cores and
favored P-cores

> Rafael's EAS series decided that it wouldn't be worth the effort make EAS
> always iterate over an extra cluster (overhead on every wakeup hot-path)
> for CPUs where in the bigger picture the difference is negligible.
> https://lore.kernel.org/lkml/1592aa65-9dfb-47d6-9bcf-17afd3184a0a@arm.com/
> (capacities are 623, 1009 and 1024 here, 1009 and 1024 are lumped into one
> cluster.)
> I think this isn't unreasonable, as long as this technicality lives inside
> of intel_pstate setup code and doesn't escape, like proposed here.

I agree

> Obviously EAS heavily relies on "1 cluster => 1 capacity" assumption as
> mentioned before, even just for max-spare-cap in feec().
> Breaking this assumption would require a huge rework, which AFAIU specifically
> wasn't was Rafael intended, but I'm sure he'll chime in himself.
> So if you really have issues with the different capacities within a cluster
> trick that Rafael went with, please just reconsider that instead of trying
> to patch things up outside of intel_pstate.


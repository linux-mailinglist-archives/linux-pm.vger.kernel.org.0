Return-Path: <linux-pm+bounces-30504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B8AFEFD7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 19:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0C71C84987
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1260322A7E6;
	Wed,  9 Jul 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfrzZ+IU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B022837F
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081953; cv=none; b=D41PQ323TpsIlY1WL+Sy2VcYp9l8cT0nMvtqqi/bfJwRYMEA/+YgzeRve+NWF2I6QW2UCpveLyhwYl8biiI+zlO5qQP6Sbhml8q47qGCjtkkjfVMEl8xKEa1eGm84lB8ICh/q0DMIlT2J8JxUSJBYTKiWfahRqJ9vkZlhm+JmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081953; c=relaxed/simple;
	bh=jPpxTKLyPqI/cFRUCuUIyZbBG7qVBxV2OKuHj7nB3+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPnkLWPItjMLrMP3d374KpheGQiviFv3H90JacnhptioQt9zPaZNYAtejYO0y4LlPbXqDaPVZv4gtMCqC2uYf08iv5S+fkUFV0lZVPWAow+qQg1b9yq8Fm5r8HiJTLS4dC8V08Oe0QflfSrDd/zxNTghMtQBLLpz616ElmRVOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OfrzZ+IU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso19111cf.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752081950; x=1752686750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUjJtPe4ejoRXpGOVMVYkbRyzaSCAR7oa43uH1ZiIgE=;
        b=OfrzZ+IUd8Nr9IyR6l9N7PjoU1oIK4BEwsZ0xfiO2N4Y1GN6kKTfdUTC4FlhBl4PuT
         SrE4SUMF1jS/CxOl2cw1TkqqplDhjQ5UwBZh0Dh23rTdIGquTeMmf49X39T2ISZe4WJ/
         dJYHXa3C824CMlCfPMftVYzKJn5M4qjDmH8EzmPDd3bZg9aiIEsv8zOoKhXNdO7LcFth
         fXtqZjtFOf+/QcO9AjKYjr4HC/pmdHUYnzoiIXbOHnQkn9QUpAU1yvPSl4mhYPyW+NHe
         bpFWAXnU31OHWwVOZ5vUz3B93CIuKbGA7FpEmOUtHVZXwb3YV3XPUVvFQNN8ZpFEV1j+
         T2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752081950; x=1752686750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUjJtPe4ejoRXpGOVMVYkbRyzaSCAR7oa43uH1ZiIgE=;
        b=GFDb7t1Qf7UyCmMtgQxLg4zRwq7oAnlbDqBn6oc+YWCxE/cyx+v+QRcSU5msiTv1bc
         JUBw364iItqeN20OrAaHnX6EJ28E4Y6msLhlhz2KHCXHcFwnFUSVyZ5LcnvFSlnFI3Ly
         bBHXx8r/LXzv+zlUv/melPJA3xPf0VbekbGgmd4lxjLihlo6VNQ5jEzR0ZbkTJQ+M//j
         a4WWNtdc1tdVJlkdlEMwOxGBFxsL8YMAuNeWVgiJIjowdhasxbGcLOgL2UF66mefbo/j
         5dT6SHL8xe+DzwAYEWqnamRGHjs5A/MwbXy9vy+fa94j+m/uU6L+34sRtsxHCdJAJ2V5
         8qvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgV/Tp+NoIKPgdFp0X7i+uLB3hdf1kHbPP726txU2b3+X1MFxmPB0/fgQqM0B5lYVVLnNow8TsiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybvLj1vK5SPwHZ3mU7vdzPxWcaquSFi0q6/jxu65iwKg9fLEFK
	aBz4SiJEQyA34Ij79A2wdiOm7iJNDiWObvR1ykFzOFeZgx4OV0T3e6u8e8gWytXtp+6jIw7LMmB
	9D4RT4xJxv480Wp6qIZTji0JWO0/ASM0FIHoUqE0E
X-Gm-Gg: ASbGncuL28ks26TzVgSeKAGy1cV+uCuyInjqRwHUiJnN624zoq/SW5MVaxxGCyoN4xp
	JF+cauoMYQp+yinb3tscCqhoxvEAt9Nk365SbrNrOiZAyHkNr4cjmNQ85tLKqliOPwJw6J+79yu
	K5mbBPe0PW+mpVANE/e12CRahT/qep+uxGWOytk62X42Agbq1jKJJCfKrlE273Jg03cVQldQ8=
X-Google-Smtp-Source: AGHT+IFypQd7Mq/ljNYvUr9csDRkxavb+g9AvF8pr4DH1TvX4BRLGx90MyL0/szowHfersDuxpDtcmleZrEXJ8ECIS0=
X-Received: by 2002:ac8:64cc:0:b0:4a9:d263:d983 with SMTP id
 d75a77b69052e-4a9dcd8252fmr4031851cf.22.1752081949736; Wed, 09 Jul 2025
 10:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com> <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com> <aGuGLu2u7iKxR3ul@arm.com>
In-Reply-To: <aGuGLu2u7iKxR3ul@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 9 Jul 2025 10:25:38 -0700
X-Gm-Features: Ac12FXznsYt2b-23fsWr9XVQZcZdVZIe5uc43u-DcYDLBiSCRn72bCnu6KWzEgs
Message-ID: <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Beata,

Thanks for taking a look.

On Mon, 7 Jul 2025 at 01:33, Beata Michalska <beata.michalska@arm.com> wrote:
>
> Hi Prashant,
>
> On Wed, Jul 02, 2025 at 11:38:11AM -0700, Prashant Malani wrote:
> > Hi All,
> >
> > Ionela, Beata, could you kindly review ?
> >
> > On Fri, 27 Jun 2025 at 10:07, Prashant Malani <pmalani@google.com> wrote:
> > >
> >
> > I think it is pertinent to note: the actual act of reading the CPPC counters
> > will (at least for ACPI_ADR_SPACE_FIXED_HARDWARE counters)
> > wake the CPU up, so even if a CPU *was* idle, the reading of the counters
> > calls cpc_read_ffh() [1] which does an IPI on the target CPU [2] thus waking
> > it up from WFI.
> >
> > And that brings us back to the original assertion made in this patch:
> > the counter values are quite unreliable when the CPU is in this
> > idle (or rather I should correct that to, waking from WFI) state.
> >
> I'd say that's very platform specific, and as such playing with the delay makes
> little sense. I'd need to do more deliberate testing, but I haven't noticed
> (yet) any discrepancies in AMU counters on waking up.
> Aside, you have mentioned that you've observed the frequency reported to be
> above max one (4GHz vs 3.5HZ if I recall correctly) - shouldn't that be clamped
> by the driver if the values are outside of supported range ?
>
> Verifying whether the CPU is idle before poking it just to get a counters
> reading to derive current frequency from those does feel rather like an
> appealing idea.

That's good to hear. What can we do to refine this series further?

> Narrowing the scope for ACPI_ADR_SPACE_FIXED_HARDWARE cases
> could be solved by providing a query for the address space. Though I am not an
> expert here so would be good to get some input from someone who is
> (on both).

Who would be the expert here (are they on this mailing list)?

Could you point me to an example for the query for the address space? Then
I can respin this series to use that query and narrow the scope.

BR,

-- 
-Prashant


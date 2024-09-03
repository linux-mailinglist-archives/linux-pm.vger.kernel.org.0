Return-Path: <linux-pm+bounces-13379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48915969434
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD571F23F43
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24701D54F2;
	Tue,  3 Sep 2024 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKDuynZ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F51D54DA
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346467; cv=none; b=Jw9PgR0Qo9tCupc5W60EZKq9ISxcAx+71xMY+D9ewP+B+M65pFspmimj2Na4yNVBUtNfodKEvV/BpWSDhjEZn79qbv5Ou7chktU1X291fVIP1S+yBGBs7KjIAFB+X3LNpxuBgGZbEERFA8EYAOcl29IQ6YS1kijqhXB+YDeDNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346467; c=relaxed/simple;
	bh=5sOUrIVahmmple1uIWjrF4wHQ8qBafYo39JTntoHm0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNGjogdvNYKEL7R5HHrfLpvFgWbcctZmyTjoqdQBWkbTO+xyE7vqwzIHTPhW8PZ0rSHhvpOvNnwjKRoM0OU9tZ1cOEeqwMJPGx+Ax6y37L2jOEOIEFYaaK6Z4fMMMs7m/FVDQYavV4EH6KW1kG+vkAOmV3fr65gxikpFoJNri1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKDuynZ+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so1522520a91.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725346465; x=1725951265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxmIyuKoW2pVhEttJGpDv883KCAqUB8WThdg5jNdn1E=;
        b=bKDuynZ+Qfg3nDbuARvIqipsUe8FQVqypeRly46JbdaGE6a+iEPLnj9AnCn4fjYf7G
         5rv4vo6qipa4cTxYNj2YJjqMtZKnmUvjw18tUe1gvUE5ih8bHfS2MRoO0LAfMuHoPGfQ
         cTz0k5Ef0GXkLfkXlET9ZiQizP0B2MTsVk8BEjKxpNoEJUpHmjpv9HMgYJtCPDQjz4GX
         UObVuVMPO60syhAWOtHhzx/F0l0uJuNFZOpjIGiUhzD7hf1zae/IaXeJisBl63TDngI9
         oLgUv4RO0YYfqCoYOIfUi7ykANWuiXKkFN9wvrWQXkaOERhJYlvZVEScE+z82vk5241N
         eapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725346465; x=1725951265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxmIyuKoW2pVhEttJGpDv883KCAqUB8WThdg5jNdn1E=;
        b=Ct0LRkZ4arMh8a03m5RfmAiL0w6dkEv2Uth3Ru1f8SQ7btG3vwWaGUVV4k9rdBfpnx
         +l05wR8dOISOfbwJifk2Z3QEzQ35ho/mvfnB1O79P22Kr+kAFL7zlZe4DwcZVOiEeCej
         YCWnUcNEyqgW1pIfcAU4kFRLlMQk1ZSRBdUeNBf/Mk3GivAdhYajRtlA7y/Pyff+g4xS
         EKc8/LIFBW0bd4CI8z5B0PJAURKynwQ3mA5jXpzj3ED2cotVWJRpJHhnPXRthn7noaf3
         8FXvLcWVUtf9uITZn94Dfvk2qKYVjoCpS00xp5vm8S+HcXvd4XkGN3jWecldRXso6uQd
         Fr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo6vt7at3ndJXrs/VmUPtuQBSmBcKcWCPx9kOUJeZDTnBDfMp04dOFoKEwmecaGD2Li+gVkc/MeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVQ8CPJwFl61mZ5Am+xcDwoBhrZtbP1/TWHcg/aTEvmQc/CcU
	CRyzvtZfcMSeRIljlLKLh6UZxnWW+8w1QswG1QLq1nS/ZbhpUOAeoHBJ9UbCUAI/wskBcQYROOd
	KP09NK0qZkVrCXLy/G9Vk1vhbAycTRZvqH/aVqw==
X-Google-Smtp-Source: AGHT+IF4T/nByo/MxQzWDW1yMEKazLS17F5AeV+FpJArbbqMYDPHgdtn63zkls0Bkpjdz3jg3BvVB87wTIUiz4KmW4A=
X-Received: by 2002:a17:90a:cf13:b0:2cf:def1:d1eb with SMTP id
 98e67ed59e1d1-2d85617babfmr18242140a91.8.1725346465441; Mon, 02 Sep 2024
 23:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu> <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu> <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>
 <20240902204301.v55w7id3d2kw64qy@airbuntu>
In-Reply-To: <20240902204301.v55w7id3d2kw64qy@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 3 Sep 2024 08:54:14 +0200
Message-ID: <CAKfTPtA_L=8DtguZgTddSxSEaVLyvYWKYrrtwMmcuteP7ef9FA@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 22:43, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 09/02/24 15:36, Vincent Guittot wrote:
>
> > > If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
> > > I am just this will be safe on all platforms of course.
> > >
> > > But yeah, I don't think this is a solution anyway but the simplest thing to
> > > make it harder to hit.
> > >
> > > > The problem is that the 1st switch to task A will be preempted by
> > > > sugov so the 1st switch is useless. You should call cpufreq_update
> > > > before switching to A so that we skip the useless switch to task A and
> > > > directly switch to sugov 1st then task A
> > >
> > > Can we do this safely after we pick task A, but before we do the actual context
> > > switch? One of the reasons I put this too late is because there's a late call
> > > to balance_calbacks() that can impact the state of the rq and important to take
> > > into account based on my previous testing and analysis.
> >
> > I don't have all cases in mind and it would need more thinking but
> > this should be doable
> >
> > >
> > > Any reason we need to run the sugov worker as DL instead for example being
> > > a softirq?
> >
> > sugov can sleep
>
> Hmm. I thought the biggest worry is about this operation requires synchronous
> operation to talk to hw/fw to change the frequency which can be slow and we
> don't want this to happen from the scheduler fast path with all the critical
> locks held.
>
> If we sleep, then the sugov DL task will experience multiple context switches
> to perform its work. So it is very slow anyway.

A good reason to not add more

>
> IMO refactoring the code so we allow drivers that don't sleep to run from
> softirq context to speed things up and avoid any context switches is the
> sensible optimization to do.

AFAICT, only cpufreq fast_switch is known to be atomic,  others can
take a lock and as a result sleep so it's not possible.

Please use fast_switch in this case but not softirq which can end up
in a daemon anyway.

>
> Drivers that sleep will experience significant delays and I'm not seeing the
> point of optimizing an additional context switch. I don't see we need to get

No, They don't have spurious wakeups now, your patch is adding one
more. I don't see why they should accept spurious context switch

> out of our way to accommodate these slow platforms. But give them the option to
> move to something better if they manage to write their code to avoid sleeps.
>
> Would this be a suitable option to move forward?
>
> FWIW I did test this on pixel 6 which !fast_switch and benchmark scores are
> either the same or better (less frame drops in UI particularly).


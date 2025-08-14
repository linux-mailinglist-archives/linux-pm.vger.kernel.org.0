Return-Path: <linux-pm+bounces-32396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823FB2649D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 13:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B0A7BB1C0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD9B2FA0C7;
	Thu, 14 Aug 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER5ThlAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC831814A;
	Thu, 14 Aug 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172123; cv=none; b=o5urz62ZeeGEohYjG8Mo8dydeiPSumlmVxKe5mclBmfzxTpgvk5b5CPwG1k00io4PGL80WdnSkn344PMeCi5Pw6Id1GJ2813n8Dg4yFEbSxy+TDa4VHWclAK2rrBWiIjRq44sYOPctmNbNBNrnXtNMqXt/fSqrCKcaYqAdwYITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172123; c=relaxed/simple;
	bh=b61i+aTB/uzhwve5Fu3fATvHkZhBGTi/ygNX6v8CQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATMuh35LIWE/j1lqLdnTS5N7lGAB+YijtJoO9fSVpOG0uKQ5dxidt9qdUQm1vqx6QIuehNQeYF9lCCpKlaPnTVrCuFdNSGoJljytYfheSx9foSB8l83pv2ZQdNPKaVNRD6fXRDzqvUIhKA0HNatQ0f52d1ilmyYZEolCHqmMxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER5ThlAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E79BC4CEF9;
	Thu, 14 Aug 2025 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755172122;
	bh=b61i+aTB/uzhwve5Fu3fATvHkZhBGTi/ygNX6v8CQNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ER5ThlATnS3aZOnndJCBOXLbKrTls7BrUwiZnyQTRXVV/ZULjpdzRfPU1DV9n+Paj
	 IvkkQ0XJWkOHrYZHIj7M4qBnzDa+UPzW63KOp4SZK/YRWn3y4Ndf+EAJPWv9Ezmrlh
	 0uAYZgmwsUZi90+iqEjFd/9ErQewNlUHyH3QaJUwX7gPCsXiQxY84+kkzcCSh6QPFb
	 SXZehoDA/K9Wgt0p19j4Lz711Ife0svhUMweI1vtaFhmdrkkqpgnVUnyyC7g9rnUn5
	 4sZ+LMuQzPcqRbRjetHsgraUW5Jy3qTz14QwVvDy0stCVtn+kuxnid4a4+y3SI9zD3
	 Jox5IJ8mN4ELw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61bd47429c1so560657eaf.1;
        Thu, 14 Aug 2025 04:48:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw239RS9ks9z5AYe6Kizt8hTha8TF9ahE/resTGN0PIzxChfdjrCzSKqDrQaSmXHwnSiWoDMGR4lokh34=@vger.kernel.org, AJvYcCWJ2vYHnbS3BB9hH7f5WvqcvR/FXWXvvypsTwlyd57NocGh9l6Ml4EhvSjWr6rWvcxtGGREAZVw9X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzseRmlDTkb4V8EKx0YyscdzStddDjt1o5JCywxbS3GA4Xjra4
	55CLqmOteXcZXNy/IpoQPggfNDfxSEn8Tp3YsvQ8ewUkjW0U/vxVv0/7ez/w+C9kMOipWDzxyfR
	8XqhmMUCuWoaDt8deTYas6SatxoO+7UM=
X-Google-Smtp-Source: AGHT+IGMYj2aqppLnXpbLv6kOmbtN3Vco3T0DqflMGMdOAnyAXzTk6xza19aJHUAolQIH2uE81GF2xB2e8CmMtXEGbQ=
X-Received: by 2002:a05:6820:4b0b:b0:61b:9bfa:593c with SMTP id
 006d021491bc7-61bd69befaamr1270726eaf.3.1755172121823; Thu, 14 Aug 2025
 04:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com> <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7> <aJo5vP_mfBn_vxSF@google.com>
 <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com> <aJpMHkrWJIyHtHL5@google.com>
In-Reply-To: <aJpMHkrWJIyHtHL5@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Aug 2025 13:48:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXUoqmxwjH0CN8gGDj=qnC3ZWrJc5VarkqRfh=0SCUWw@mail.gmail.com>
X-Gm-Features: Ac12FXwMz-z9DAAonTPH4BpY5XQU-If2y11OogUEqhlEE82MFIeyMCFe4503Vpg
Message-ID: <CAJZ5v0hXUoqmxwjH0CN8gGDj=qnC3ZWrJc5VarkqRfh=0SCUWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Prashant Malani <pmalani@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Beata Michalska <beata.michalska@arm.com>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:01=E2=80=AFPM Prashant Malani <pmalani@google.co=
m> wrote:
>
> On Aug 11 21:19, Rafael J. Wysocki wrote:
> > On Mon, Aug 11, 2025 at 8:43=E2=80=AFPM Prashant Malani <pmalani@google=
.com> wrote:
> > >
> > > On Aug 11 11:35, Viresh Kumar wrote:
> > > > On 06-08-25, 17:19, Prashant Malani wrote:
> > > > > So, do we have consensus that the idle check is acceptable as pro=
posed?
> > > > > (Just want to make sure this thread doesn't get lost given anothe=
r thread
> > > > > has forked off in this conversation).
> > > >
> > > > I don't have any objections to this or a better solution to this.
> > >
> > > Thanks Viresh! Beata, can we kindly move ahead with the idle
> > > optimization (which is this series), while we continue discussions fo=
r
> > > the "under load" scenarios on the other thread?
> >
> > I need some more time, please?
> >
> > This problem is similar (if not analogous) to what happens on x86 and
> > that is not handled in the cpuidle core.
>
> My apologies! Didn't mean to rush.

No worries.

> Will stand by for updates.

First off, AFAICS, using idle_cpu() for reliable detection of CPU
idleness in a sysfs attribute code path would be at least
questionable, if not outright invalid.  By the time you have got a
result from it, there's nothing to prevent the CPU in question from
going idle or waking up from idle.  Moreover, the fact that the given
CPU is idle from the scheduler perspective doesn't actually mean that
it is in an idle state and so it has no bearing on whether or not its
performance counters can be accessed etc.

The way x86 deals with this problem is to snapshot the counters in
question periodically (actually, in scheduler ticks) and fall back to
cpu_khz if the interval between the two consecutive updates is too
large (see https://elixir.bootlin.com/linux/v6.16/source/arch/x86/kernel/cp=
u/aperfmperf.c#L502).
I think that this is the only reliable way to handle it, but I may be
mistaken.


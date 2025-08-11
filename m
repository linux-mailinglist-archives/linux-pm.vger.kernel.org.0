Return-Path: <linux-pm+bounces-32187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC74B21542
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CD34226B0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC72D4813;
	Mon, 11 Aug 2025 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7gwDtGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005782BCF68;
	Mon, 11 Aug 2025 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939960; cv=none; b=p4RA9fdojpyJFc4jNVBzKhsYmIFqgFp/MCj1qzPL8UtX5YPkdEztxxV/Ub4zHmV4RVWs9CiqFNNzwcb05OF9oUf5J4sYMg4MHEga66kS2pF00glG/VV8caDHg2tspZ7rQLBzyzUTGEMwwd1Uf73NBgFIHgh5sExJSy+Cr4Dc61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939960; c=relaxed/simple;
	bh=F+Sa4E4K9l7ZyUTYlxEZRSWEF0BA6NaeA97AuWM3NS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOPsWmOWKcc+tcug70pREA+CAR2qt/qO7FNK9+QJPfB9Y82hdiVaFUcAejjEK1oJwBJQJy0wK5BpEgieSR1/+1LvajAuBubWAM9D6CqmjczgE6Az6Ru9bv+KXKG7jyujR69O+9hW+l9i4eAJM+hmDsS+SaL0ugdaEFBYS4nlPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7gwDtGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACAEC4CEF1;
	Mon, 11 Aug 2025 19:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754939959;
	bh=F+Sa4E4K9l7ZyUTYlxEZRSWEF0BA6NaeA97AuWM3NS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I7gwDtGN8rab14VWaZFX3ZyNvXLyBTv26lRcKpeSkTZzezWEMQSh3vG8RSlsZzMwv
	 qNcIHNS0DS4pV6pJ7JNJQ55FsrKUXXO8ayuup0xE/2kMX9ip5Wio5wcEFzh32F40Sz
	 wJ4uYkSuxGY+tHnmslyP/ltALttexfF+aMA2BktWzZc3U9cQMA6OAvlTwJa3qi5Fnf
	 Y1gFyCGTxL4D0ix6gtU8A74UiepD+I4fjVLaPuT2teqikzk0qYSuy5s27yjFr9LMi4
	 WPOvldpjEpLN35Rgu2F7YzgjrW6/eteXM60JLz17sZwfHK7JVTWW150FpfvothlkLG
	 DfwRLhoY/YjKw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61b43c84905so3318032eaf.3;
        Mon, 11 Aug 2025 12:19:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbMAgQvVw5XdkvTd2CouVG/1pDa6y3gjN8BG+qkVSoyLcjYytGNATai4bbiddwLWZcErsif7HIvr9dZ5w=@vger.kernel.org, AJvYcCXy6JhNFkL4TBoOW9XfqYLT3uLAd1aihDCwPltI93DE57BgA+ke1SkkU7kDkoGacjsJ3OLZawPeLaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3slVLrGEL0lIDDy0YUyv2SuCpxBIHXPY9qZxOUHD9+kyKWpV
	Ykokd6gohn/j6EYPUQiEvHa0HdLL4i8aZ+hqqPWtJvexo/hmasj/E+B5mydTm/y58+0hXqenUdS
	iot73Jcw70jtGOFC6XUodlXe7ZmYGF1I=
X-Google-Smtp-Source: AGHT+IFVukX1KrTZ6Yyf5VUjR0OxjtiZK4zWjKVwlwWtei1I3lI5mQbpQzv9OVjqxabgFCTTanCIhfmEprfzY9Mm2Xo=
X-Received: by 2002:a05:6820:1c88:b0:619:950f:2413 with SMTP id
 006d021491bc7-61bb581df2bmr607359eaf.2.1754939958801; Mon, 11 Aug 2025
 12:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com> <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7> <aJo5vP_mfBn_vxSF@google.com>
In-Reply-To: <aJo5vP_mfBn_vxSF@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Aug 2025 21:19:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>
X-Gm-Features: Ac12FXz-ahcyrD5qoZX9IPtX0f9rw_hXpZGNeAy_-IiQw1U4FWq-BH_JYXYvI8s
Message-ID: <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Prashant Malani <pmalani@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Beata Michalska <beata.michalska@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:43=E2=80=AFPM Prashant Malani <pmalani@google.com=
> wrote:
>
> On Aug 11 11:35, Viresh Kumar wrote:
> > On 06-08-25, 17:19, Prashant Malani wrote:
> > > So, do we have consensus that the idle check is acceptable as propose=
d?
> > > (Just want to make sure this thread doesn't get lost given another th=
read
> > > has forked off in this conversation).
> >
> > I don't have any objections to this or a better solution to this.
>
> Thanks Viresh! Beata, can we kindly move ahead with the idle
> optimization (which is this series), while we continue discussions for
> the "under load" scenarios on the other thread?

I need some more time, please?

This problem is similar (if not analogous) to what happens on x86 and
that is not handled in the cpuidle core.

Thanks!


Return-Path: <linux-pm+bounces-42238-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFXjEMcjhmklKAQAu9opvQ
	(envelope-from <linux-pm+bounces-42238-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 18:24:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A068F100EAA
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8824D3008A47
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75A3B5314;
	Fri,  6 Feb 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="GBVCH0YU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD7188CC9
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398625; cv=none; b=rkczxClz9t40d+H/3tK3SVLvAEEfPIg/MOLtRboZsvyJ2I9F9x8qUQGF16sXZTTQW6xIJTNe+zojg77i2bjrsahvHlLpm7o0qoOtJ1iCsO14dyI11e36+7ftqs+WhgyJENxdnt6hgRfmA1uqWgOhZz1f+3cNG1x92AHOQpYPR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398625; c=relaxed/simple;
	bh=tEtL+dBskuH3EpxFN3oBQDxmYNiTjz5rDQJuxU6XDco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0IyYyB8q+goZNTKIdg9ZaPYR+35O9gGEcAnkF5xI9blfI3u+QUEnbCxosTYn1wOHk5pM5L39NLe5hjCsRifuGrACItJAGJU7MtW7kzYcSCvFf5gG1HXHB1E8z8XgMmTqNu0Sl4kd2LYeLSmNaCogLrLgsETjfhGuIEV5QEShfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=GBVCH0YU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so25185275e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1770398623; x=1771003423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O42vGZNh7OAnLgx1JlMOtVYnJfy3seTRSj7uXA3WvXk=;
        b=GBVCH0YUZVupPOfA7HbD9ff4gO2hFv4eyVgKQghq/GUnlOj4m14EjUbCgLcCYhO5n/
         UMdYCcZ7kkxw7m6n51mTicczdceWvl0yBO3C/vJYlz7ybU+sUhqVOjk4ddV1VDDlDj05
         5ouUpHusWfx7d/GNxdcqldfuicHjJSND/a12Xn7Yzxic0y/QupvLbh8ZELEmfrpYCXEN
         EO/54gESKduWdJgxpqnc28vhz5HQtv5LmX/H536lCy/DIt96ytz4gKa0AT3Te/Dr3q0n
         7s8W6qpWLb62amUzHY1TsLZk8k/6gs7Bk2erug+Qlqm0Onh7NyJoS/jeibcZlG8JvxJH
         8fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398623; x=1771003423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O42vGZNh7OAnLgx1JlMOtVYnJfy3seTRSj7uXA3WvXk=;
        b=VePpVePhWYAwPJb767Rz+RcHxs9VMYsT4uWIxsjOObJzl/42BGP8J0oUM4G9JTDMWX
         uIN8+ce+TeqxPAdlQu3VfNc+kfXnSm0p9xO/EZNOZLVstWaA6W7yfbVXcfwVEhnF3a4t
         y1uSUO483Etw4oAody+kipJJS4D7AJuFh4zfL6A5AbhpDPmXSQvndBhoS/vhT7DvJbZl
         eFtaw0ShX8EP+JiNwxjJ4hpppuFM6nJkRu8wP5PLdJFIWSowSfxkiFc+PinxbGV/mIfV
         xImxfIFx+hnv2HnYZ7XywHLYSUJaTrBV06Eb0g2FeOgrqZzQ64C6HpPWqzQQUDz32w8e
         I4Wg==
X-Gm-Message-State: AOJu0Yxu/ebtpwqoKLkTOvesvIUVbkWkiUonz6xJXVZR4Acgft+R94aT
	2kDyIZmkRG+VcXb5RI+WN1SpbfmoI2qbfkGy8+lByvlxDzILXvlPE93mH+zvIH9BFnY=
X-Gm-Gg: AZuq6aLEYhuJAwjgbzeFxnoTG/LIjPX8dzNQsrt4fQAq+ttaNdAt5n1ubtgyD5UeAZq
	tSeRx2UAZxmuEkTb0WVT0IWIp6pO5laSQkyFudbpasNQvGC1QIILg7ILBlkvZWLCltzz1W0m5Lb
	s4wdYOjav8stLUu5N+viNQHBh6mmL2SaImH/Fr7ku+32UKREEUQ2MGIw/KQwoC/p3o3/b5z818j
	/iggEi6WnaUXg9iru9g+endMkjLA1Ab05k30c8J0h6JAE9PbSs8fXQSOqM0xSEGcvyw6rwSMa2m
	h3n0+0EE786pNAOZ+Ypn0lJRigqE6wZPw2Zm8Em+ZaA+49IOz7I/dQkEGYy5LOc4UIBNjqu4azq
	8pcQk/Jwlub2GN1fX+61jE+tYS3tzXUV7Tfa02LdSq7WoLhVnKMJag+TsQXurKOk9VzhZRn2shO
	WcoPl3i9rtJZVeWAJ+VE40cPPx2LuylLrFERDxgJTS6ZyFga6jU6DZAeL+0Boykv8=
X-Received: by 2002:a05:600d:6451:10b0:480:6910:abd1 with SMTP id 5b1f17b1804b1-483202311c6mr38220265e9.18.1770398622809;
        Fri, 06 Feb 2026 09:23:42 -0800 (PST)
Received: from airbuntu (host109-153-232-30.range109-153.btcentralplus.com. [109.153.232.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d835f0sm138673995e9.14.2026.02.06.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:23:42 -0800 (PST)
Date: Fri, 6 Feb 2026 17:23:41 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rafael@kernel.org, peterz@infradead.org, pierre.gondois@arm.com,
	qperret@google.com, sven@svenpeter.dev
Subject: Re: [PATCH 0/1] sched: Ignore overutilized by lone task on max-cap
 CPU
Message-ID: <20260206172341.4p5rv7o6dxv4l3la@airbuntu>
References: <20251230093037.427141-1-christian.loehle@arm.com>
 <20260113131134.n4ixed2awnikgmeq@airbuntu>
 <8e230c6d-ddd7-4385-865e-257168dc0057@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e230c6d-ddd7-4385-865e-257168dc0057@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[layalina-io.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[layalina-io.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-42238-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[layalina.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qyousef@layalina.io,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A068F100EAA
X-Rspamd-Action: no action

On 01/15/26 11:17, Christian Loehle wrote:
> On 1/13/26 13:11, Qais Yousef wrote:
> > On 12/30/25 09:30, Christian Loehle wrote:
> >> I'm trying to deliver on my overdue promise of redefining overutilized state.
> >> My investigation basically lead to redefinition of overutilized state
> >> bringing very little hard improvements, while it comes with at least
> >> some risk of worsening platforms and workload combinations I might've
> >> overlooked, therefore I only concentrate on one, the least
> >> controversial, for now.
> > 
> > What are the controversial bits?
> > 
> > This is a step forward, but not sure it is in the right direction. The concept
> > of a *cpu* being overutilized === rd is overutilized no longer makes sense
> > since misfit was decoupled from this logic which was the sole reason to
> > require this check at CPU level.  Overutilized state is, rightly, set at the
> > rootdomain level. And the check makes sense to be done at that level too by
> > traversing the perf domains and seeing if we are in a state that requires
> > moving tasks around. Which should be done in update_{sg,sd}_lb_stats() logic
> > only.
> > 
> > I guess the difficult question (which might be what you're referring to as
> > controversial), is at what point we can no longer pack (use EAS) and must
> > distribute tasks around?
> 
> And that is precisely the 'controversial bits', I didn't want to touch them
> with this patch specifically.

What makes it controversial? I don't think it is really controversial. Maybe
you're referring to some offline discussion or I missed something on the list.

The concept of a *cpu* being overutilized doesn't make sense for the purpose of
this overutilized state. Trying to make it better in some particular case is
not really moving us in the right direction. And not discussing what's the
right direction doesn't move us in any direction :)

> A more holistic redefinition of OU is still on the table, but it needs to
> a) Still fulfill the requirements we want from it (guarantee of accurate PELT
> values because compute capacity was 'always' provided, switching to throughput
> maximization when needed).

I think the PELT is very inaccurate :-) You saw my talk about invariance and
black hole effect?

If you view this problem as PELT accuracy, this is a problem. The code was
tightly coupled to misfit logic, which it was decoupled from and these
cpu_overutilized() checks are overzealous can be safely removed from many
locations to start with. We need to focus on the concept of system
overutilized. Even if you keep the current logic as-is but just move the checks
to the right place when deciding to do load balance where we take the global
view of the system's state. Not on context switch etc which I think were to
help misfit to trigger?

> b) Provide sufficient testing to convince us of not regressing anything majorly
> on the quite diverse EAS platforms we have today.

I don't think the testing effort is that hard really. Things that need multi
core performance should give us indications. GB MT is one of them, but you can
try speedometer with code compilation (limited to fewer cores than NCPUS) in
the background for instance to see how much this affect the score.

I'd agree it is hard if we don't know under what conditions it is supposed to
help.  Which is my main point here. It is supposed to be useful under specific
scenarios only. And these scenarios are NOT tied to cpu state, but global
system state. And I think we can reason about them.

When packing on a PD is worse than distributing? It is definitely not when
a CPU is saturated. feec() has improved a lot over the years and does
distribute load a lot better than its earlier days. The question is when does
it fail?

I think under few scenarios:

1. Number of tasks >> number of cpus
2. Many of these tasks are long running and won't sleep and wake up again for
   feec()/wake up to distribute them again.

It will need then to help move those long running tasks to idle cpus as they
become available. But if tasks are sleeping and waking up then they'd be
distributed without any additional help. If not, the fix is to make wake up
path smarter.

It also can help when there are no idle time but many tasks keep waking up.
Some tasks can get stuck enqueued for a long time where we can have nr_running
high on one cpu, but I'd argue we have issues with wake up path packing when
the system is loaded. Even feec() shouldn't do that. Still lb is useful because
enqueued task can't go to sleep even if they need to run for a short time if
they are not given a chance to.

Do you have other scenarios in mind? I think breaking the problem based on
benefits would help advance the code and clarify what satisfactory tests are
required that it behaves correctly. It seems you imply we can't know where it
is supposed to help with to test sufficiently it is not a problem, and here
where I disagree. We should be able to quantify and demonstrate where it should
help.

> 
> I think $SUBJECT does a) and b) well, but of course it's for improving a
> specific set of systems and doesn't address the issues with OU that have been
> named in the past.
> 
> > 
> > I think this question is limited by what the lb can do today. With push lb,
> > I believe the current global lb is likely to be unnecessary in small systems
> > (single LLC) since it can shuffle things around immediately to handle misfit
> > and overload.
> > 
> > On top of that, what can the existing global lb do? I am not sure to be honest.
> > The system has to have a number of long running tasks > num_cpus for it to be
> > useful. But given util signal will lose its meaning under these circumstances,
> > I am not sure the global lb can do a better job than push lb trying to move
> > these tasks around. But it could do a more comprehensive job in one go? I'll
> > defer to Vincent, he probably more able to answer this from the top of his
> > head. But the answer to this question is the key to how we want to define this
> > *system* is overutilized state.
> > 
> > Assuming this is on top of push lb, I believe something like below which will
> > trigger overutilized only if all cpus are overutilized (ie system is nearly
> > maxed out (has 20% or less headroom)) is a good starting point at least.
> 
> It's an approach, but it needs a lot of data to convince everyone that
> push lb + much more liberal OU state outperforms current global LB OU.
> 
> Given this is not really about defining OU in a final state, any comments from
> you and Vincent on $SUBJECT and the problem it's addressing would be 
> much appreciated!

I think you're avoiding the problem. And testing effort is not really that
different in both cases IMO.

In my view generally our load balancer is not great and very slow to react.
I do believe the push lb will make this overutilized state completely
unnecessary. But we shall see :)

I am not a fan of this band aid. But as I said, makes things better but not
moving us in the right direction. I'd rather see discussions in the latter.
Burying it around with we'll do it later and it's controversial is what
concerns me the most and makes me not keen in taking this small improvement.
But if Peter or Vincent would see it helpful no real objection from me FWIW.
I just think it's not hard to do better.


Cheers

--
Qais Yousef


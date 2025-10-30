Return-Path: <linux-pm+bounces-37093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12910C1FFCA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D433B5092
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799C2F3607;
	Thu, 30 Oct 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUd4Tq2Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFD1F4631
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827002; cv=none; b=peEknWir9r9azAhdYAY+gbSUQN8Bz02dHTGPzV+e2yz96NNsR3bkUCpyBxO/49A1GE5ZTGIeBnBKwdVaWumbuskH7OUFTDhks9X1oT2S54t4YoGan2pOtlwslQZXaDVAe9owaJ8Tp1xpNGJMjDZNuSMm+B0IJYeVgLKcWvI5P30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827002; c=relaxed/simple;
	bh=bqOlW2oWI7RdtQm/N15Vuwk/lchf4mj5RPORlezgpKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ5rr+RvJRwLrW+cZ/YYOTI9XyaqBUTOqbNf21m2xMt80agbiLxXfqtWokFURNdyXeMr8oYsUTOgkuw7sWNvRh57vkgoP9GM0QEiXEkIXSHrDjojbJRfKiAx2hUj6bLgDz+zJ1OgSYrmrA5jXwzRsdU5Rs7QDxtwAucS4I3Azz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUd4Tq2Z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d71bcab69so11540597b3.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761826999; x=1762431799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWFtfYb05SOq83bboDg32uBQSLrzGUIx7jAl5366nJ4=;
        b=iUd4Tq2ZQPLsCOdMp69QAEfdDY+jL6pzAmOiBIHXBAXtz5z/vHVGGb+GMciV3h8lT9
         1xvJo5S1qnqHl21/0CaxGaxxvhJCnmzZnBuRUnmhoQuwJxw4tXiyTT6HW2ip2nWZd8kT
         6gk1N7xtHcJJvwDXabrtnehDpm74IO6GvDQ+CNnM/O+3sfiTIQL4A0EjoTpsB5BuDt3Q
         z7gpQ3N1ueYa8QefJghd790hHXLJLaxt0rwxuJaynXF0bKSQvEZRoWVj/nszy0ACwM44
         tJLsuhyC5D8n3eLkw40dmvEyyrKtGhuYp6b5JXNFhz/rTdbFCeHFM8YqdeRvwo2ES5Kr
         swpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826999; x=1762431799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWFtfYb05SOq83bboDg32uBQSLrzGUIx7jAl5366nJ4=;
        b=CWT1M1CGVrl9pTWBu2o/C6Y8XU+jCF4naRdtvHMKUUEMnGI5N5ZbsctvrP0Mtpkx7J
         4+9yfHzE/H1yVjII9lhG7R23lxEmcs3kJdAd6bP2aIglNPu5JmS0gtL99nZqUOhPNwyC
         qBkahMspBMGbthxyEZoqJcVJSf5ju6gquL+xCwwFjSPyFhgHEnkkTjSMn3sdioZ8f2yD
         PsxqxZCJwVNG9IE+iZcLevC755kHg1me+tkUFtngMJ/WfagauNgGg/fX5MEcroBWq5+t
         ICOeX/WW3s7FaQmImDL4a4zYceA12JTRgNFixXckOw3A4WU2CQ5z+lXqKb2jknBATNZq
         9QzQ==
X-Gm-Message-State: AOJu0YwzPxHs5YeEoRy8Mpg4VNoH52M71S340Gs5V+J8CxdUypqJcZUb
	sFJttfLTsNycHYEpvyyiGXpjqpTvDu7rmYOj4hT6F+rEzVqet2t+vhTDxKVtK2txa5SJY5hRAWC
	P2b5qCgpLVzqa741lxP//DIHfKQOjXCFXTnRpBK/r9w==
X-Gm-Gg: ASbGnctr52warnzRx/RISlMifA1+qgwLFcZDCSFukpJ68L6TK+2jgP4fkafTNeVgakn
	2Dws9gz6gu70lRP8zqgbGXQefHunr8UaA1MAfhCSQcvu2QqJko303ojafG/Am9g7fYk9hE2Od2N
	JeoERpA8/fkOfeVUbOzLh32bZew7g9m2sJtGHi4k2lS0hD99LE3XiigFBEVcMrVxUgF46XwvXph
	LUqTbplkcTNo6sKhWatrotvd+mzEyOoUMuY4tCdlNgwzM+DQX0YpzMFqzWxADg4rkRap8pW
X-Google-Smtp-Source: AGHT+IHT9zocseeovUel6KQS/8tgyAhacJN5zXZoo2RiIByIVZXze4S+TL+MF8zrXEeVGop1sApCJVnU5MEid9zjmZA=
X-Received: by 2002:a05:690c:610b:b0:786:4459:cb5a with SMTP id
 00721157ae682-7864459cff1mr5156577b3.65.1761826999581; Thu, 30 Oct 2025
 05:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org> <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 13:22:43 +0100
X-Gm-Features: AWmQ_bmZlYP-vMQKR-I5oY2UwXbMGNHaD98nubyYKhsx7HdNG9dPpE2bV5NB1-4
Message-ID: <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Changes in v2:
> >         - Limit the new QoS to CPUs  and make some corresponding renami=
ng of the
> >         functions along with name of the device node for user space.
> >         - Make sure we deal with the failure/error path correctly when =
there are
> >         no state available for s2idle.
> >         - Add documentation.
> >
> > Some platforms supports multiple low-power states for CPUs that can be =
used
> > when entering system-wide suspend and s2idle in particular. Currently w=
e are
> > always selecting the deepest possible state for the CPUs, which can bre=
ak the
> > system-wakeup latency constraint that may be required for some use-case=
s.
> >
> > Therefore, this series suggests to introduce a new interface for user-s=
pace,
> > allowing us to specify the CPU system-wakeup QoS limit. The QoS limit i=
s then
> > taken into account when selecting a suitable low-power state for s2idle=
.
>
> Last time we discussed this I said I would like the new limit to be
> taken into account by regular "runtime" cpuidle because the "s2idle"
> limit should not be less that the "runtime" limit (or at least it
> would be illogical if that happened).

Yes, we discussed this, but that was also before we concluded to add a
new file for user-space to operate on after all.

To me, it looks unnecessarily limiting to not allow them to be
orthogonal, but I am not insisting that it needs to be like this. I
was just thinking that we do not necessarily have to care about the
same use-case in runtime as in the system-suspend state. Moreover,
nothing would prevent user-space from applying the same constraint to
both of them, if that is needed.

>
> It looks like that could be implemented by making
> cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit()
> into account, couldn't it?

Right, but I am not sure we want that. See above.

Kind regards
Uffe


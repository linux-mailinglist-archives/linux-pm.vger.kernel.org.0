Return-Path: <linux-pm+bounces-25550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC65A8B909
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1611891765
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66E2472BD;
	Wed, 16 Apr 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFiYD0Jt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366E221272;
	Wed, 16 Apr 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806517; cv=none; b=Ri8jq69Kt5oKGTCb1q/9ScOM0VrxzUblS0sI8bLlwg80HBT1UpSmjRMvPGbTkzSkFrBEi3ofJ0yiFYq/SiArLbh0yHXcnTVKrHN9u9ir5rrgeuQdlcHq3oJR51Je0nGszc+i3cfLyLKl2F9iJH8cq2Bnk9csRuNcvWhFeDbb9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806517; c=relaxed/simple;
	bh=isH+/GLjm96yE33ush2efbXsDtXy/PzEAVhFahYOoUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/3RHuouMPzJjJpGlB6K9d8Rzc8T/FmCXiwA/fNE4l0Qu/OAmaOdetq51/EHjmLWedxksN59TgxDFJX9dnLY2QYGtWaTJSh7Fu8HBaU5RWQzj441a4uaG4yhlW+mO3FgSsHfHOYzV+KfSJBMeEqCQzZQg5PIa5a46Q58rWCcdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFiYD0Jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C093C4AF09;
	Wed, 16 Apr 2025 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744806517;
	bh=isH+/GLjm96yE33ush2efbXsDtXy/PzEAVhFahYOoUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VFiYD0Jt/MKrIM0O//OrfmAdWr2spMP+s6SohLzUc7eyC7YiTFpHRWoNdmSrh9bTi
	 Ycwf9Y0B1cQb8W4KGT1amdpcGFItaszDb0ntMQYtmLTI/2uccUzy91qgdC5sPJ0ZKJ
	 aRr9H++OvXjRfPTM5mIVkmN5dbsvDn0nYzH7k6IKrEpwS1qnmr2JeCQJokdZ7DPdlK
	 V5D/4DHKZkbuWZLZMi0FaMncqpQ1RvXAlYm9QktFWvzwmWNLyduyWsPZdOQaV+/DsN
	 TW4t326oI1dGC9nnAQtBgXmFYoWWGWVwQurddBQ3Ek3vxQOmyO5FCyjOySGZ69GEkC
	 m4aZVLSYY7tIA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60402c94319so3140886eaf.1;
        Wed, 16 Apr 2025 05:28:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1GAIX5t+M0Yo/eCkvN0YxDr5kzirC6ueTnpf/DGiS90iY0nI2IUTWTQBm5Pr3OihtNFJn5UZekG3BkQo=@vger.kernel.org, AJvYcCVAOPNSuuRbmFu7smCMgFxGh5lVyvUTjs+u0WM79NsSsVh49En26vejRDnrJZSh0cOqjoAXH8Kyl3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXqXLX+hSxmr0bRj9DNw6eoj7S66MqEqk7uVOANLTA3MWOEjz
	MnNQL3dZQAlu3385nxmohNh14ljbeB5wfrdkIhplwS8hdPz/QM/J7ermh0YtcF7V51A0vZDfBtW
	vA60HCuPliOHT5PLb2iOJliHyXJk=
X-Google-Smtp-Source: AGHT+IFrO74weq/vUqQ4mNSCLwxe3ubAkgSLFMvBBYG4HOr4lzKB6U2U2DBNC9LcVYVOoqEPARxRVv1bLZCgJEVbeN8=
X-Received: by 2002:a05:6871:9e11:b0:29e:5297:a2a7 with SMTP id
 586e51a60fabf-2d4d2d124a9mr911568fac.30.1744806516430; Wed, 16 Apr 2025
 05:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6171293.lOV4Wx5bFT@rjwysocki.net> <3376719.44csPzL39Z@rjwysocki.net>
 <b0c863d8-b1bd-4b69-b5ec-18544608448c@arm.com>
In-Reply-To: <b0c863d8-b1bd-4b69-b5ec-18544608448c@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 14:28:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i3OBrhbXTpRAo3R3mrpjn8OJu874LtFAysAvziXmLxEA@mail.gmail.com>
X-Gm-Features: ATxdqUFyjxDWWtShbfENUw8wSykV7527_6SbJLtcjDALUF9zyWpjAnpQ0gxZBFY
Message-ID: <CAJZ5v0i3OBrhbXTpRAo3R3mrpjn8OJu874LtFAysAvziXmLxEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] cpufreq/sched: Explicitly synchronize
 limits_changed flag handling
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sultan Alsawaf <sultan@kerneltoast.com>, Peter Zijlstra <peterz@infradead.org>, 
	Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:01=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/15/25 10:59, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The handling of the limits_changed flag in struct sugov_policy needs to
> > be explicitly synchronized to ensure that cpufreq policy limits updates
> > will not be missed in some cases.
> >
> > Without that synchronization it is theoretically possible that
> > the limits_changed update in sugov_should_update_freq() will be
> > reordered with respect to the reads of the policy limits in
> > cpufreq_driver_resolve_freq() and in that case, if the limits_changed
> > update in sugov_limits() clobbers the one in sugov_should_update_freq()=
,
> > the new policy limits may not take effect for a long time.
> >
> > Likewise, the limits_changed update in sugov_limits() may theoretically
> > get reordered with respect to the updates of the policy limits in
> > cpufreq_set_policy() and if sugov_should_update_freq() runs between
> > them, the policy limits change may be missed.
> >
> > To ensure that the above situations will not take place, add memory
> > barriers preventing the reordering in question from taking place and
> > add READ_ONCE() and WRITE_ONCE() annotations around all of the
> > limits_changed flag updates to prevent the compiler from messing up
> > with that code.
> >
> > Fixes: 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when l=
imits change")
> > Cc: 5.3+ <stable@vger.nernel.org> # 5.3+
>
> typo in the address here.

Yup, thanks!

> I don't fully understand why we wouldn't want this in 6.15-rc already,
> even if the actual impact may be limited?

I wanted it to get some coverage in linux-next before it hits
mainline, but then it's -rc3 time frame, so there will still be 4
weeks of testing before the final release.

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!


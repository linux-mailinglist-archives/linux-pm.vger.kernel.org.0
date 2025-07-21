Return-Path: <linux-pm+bounces-31223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A04AB0C929
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 19:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F7D543DEA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D221421A;
	Mon, 21 Jul 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBgo4r4Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932770838;
	Mon, 21 Jul 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117243; cv=none; b=Y/VLQt1ScRjx42EChYt31aX5XRKMp7nYTLMIYNqAU2/UoFJM9NoR0k3ZJ1cBi+M6B1M5dX8JaSnHqLSURq7yfodSFxKMzBCjNLUSNYATlL2ePoRlH7W2PklpJex4KoDp3bLigVxVkeHt9lwqs+gRgb4LECgE5sFcTY4ECFncUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117243; c=relaxed/simple;
	bh=7d9Kecvwsvgo7o1A4iRWacudzfro57HsAyrEpFJvb4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwjJyGZT6k/KTbx22FXLUEpZdyi+LjmqqjeQtZ+A5ZXDjC6b2Pm5xKvSzPAjy25B2uInTJ8DhiUEXP6kXlwIpotI3FHrXaYCtQzvCmbAJAxq4rKmiB5NZNogPBFfL5TwvF/kkdSTYQEl/+Vq/5/9RlPeuKOW7qFS92btiHMD5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBgo4r4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2704CC4CEF7;
	Mon, 21 Jul 2025 17:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753117242;
	bh=7d9Kecvwsvgo7o1A4iRWacudzfro57HsAyrEpFJvb4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eBgo4r4YmOP7vzOXen94Z016e6fnCycgylIbCxO+f/VSypnp5Fi9obpNayG4K4Yj5
	 LDi0kv6HVeFDcZmLNOrPHd5TAsfLt6ThMzAoNtHUEiIbEt1e3YJTH/HCFL839k2XDm
	 fRhTXW3YWEodn7ncQagTF+Nka1VPEmfxTg9pndZhdVFxA1FaSfcF2OcG4fVGiDN1fu
	 ZmAetb7mhG1vH/hUXAq1ANwVtjaZrIHvFK09SfbaZlQzK5ROXGPx9OtxnD7kxkigz7
	 vcl3m5UU4qer/CSK61cW2ijLmCZCrA3EDNBWncsMyRasoOGd+CVMqBP2z9mKZT8DJB
	 qACDkrvDESVQw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-615eb598b0fso280130eaf.2;
        Mon, 21 Jul 2025 10:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/9dy3SDXCd72Df83T43jBxGOaonTqp5/m91Qq9TF6fW4Cn6brnPgMFCnY0/A9uguaE7pQmhgWqQQ=@vger.kernel.org, AJvYcCXyCPER5WfPTNyowuptO+shvBbiXpvWkBqEZdgusJe+7sNjBPNpBcMCKR3dzDAfTNG7zvwDE3jsjFFDk4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuTYfNmTMPIivDiz5hoOU060jAdBphq4B6PpgYtSAsLJa8My+
	woUfYWi1X5YvoSxjAzXw1Vdllhyhe5qtSLkBMG2ueyyHzsTZ9K7QtLqe6+azop5x3ReVS2GoYlj
	z4HHjI/Zc80QCkydPqzJqobKVUxZtuWc=
X-Google-Smtp-Source: AGHT+IFH8hdFo49OCKRGtXKLaGVewbQO4AH8kOfQeXjxdGZzIkdT1RmSA6/593DIfxVYqOy7vWKFYbRT1IiAFrcdbd4=
X-Received: by 2002:a4a:c994:0:b0:615:9107:fae3 with SMTP id
 006d021491bc7-615a1fd6c08mr12940001eaf.8.1753117241180; Mon, 21 Jul 2025
 10:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com> <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
In-Reply-To: <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 19:00:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
X-Gm-Features: Ac12FXzay_rGup9nAI5Mnagj3Z1I3807jJVdvBGS6XkcV4GLMO8s7WIDVqPw-A8
Message-ID: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Prashant Malani <pmalani@google.com>
Cc: Beata Michalska <beata.michalska@arm.com>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 8:28=E2=80=AFAM Prashant Malani <pmalani@google.com=
> wrote:
>
> +Sudeep.
>
> On Mon, 14 Jul 2025 at 02:31, Beata Michalska <beata.michalska@arm.com> w=
rote:
> > So I believe this should be handled in CPUFreq core, if at all.
> > Would be good to get an input/opinion from the maintainers: Viresh and =
Rafael.
>
> Viresh, Rafael, Sudeep, could you kindly chime in? The unreliability
> of this frequency
> measurement method in CPPC is affecting the cached frequency saved by CPU=
Freq,
> which in turn affects future frequency set calls.

I gather that "the cached frequency saved by CPUFreq" means policy->cur.

> It would be great if we could solve this in CPUFreq core (maybe not
> rely on the cached frequency while setting the new one [3]?)

I see what you mean now.

Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?

That would kind of make sense given how the driver works overall, or
am I missing anything?

> >
> > In the meantime ....
> > It seems that the issue of getting counters on a CPU that is idle is no=
t
> > in the counters themselves, but in the way how they are being read - at=
 least
> > from what I can observe.
> > The first read experience longer delay between reading core and const c=
ounters,
> > and as const one is read as a second one, it misses some increments (wi=
thin
> > calculated delta). So, what we could do within the driver is either:
> > - Add a way to request reading both counters in a single cpc_read (pref=
erable
> >   I guess, though I would have to have a closer look at that)
>
> I already tried something like this; I used [1] which basically puts the
> 2 (constcnt, corecnt) register reads in a single CPC call;
> This did not help. The values are still highly variable. I never got
> merged FWIW.
>
> > - Add some logic that would make sure the reads are not far apart
>
> As Jie pointed out earlier, a lot of this has been discussed (see the ref=
erences
> within the patch link [2]), so I'm not really sure what else can done
> to reduce this on
> Linux; there are two registers (SYS_AMEVCNTR0_CORE_EL0 &
> SYS_AMEVCNTR0_CORE_EL0), so there will always be some scheduler induced
> variability between the two reads.
>
> Best regards,
>
> [1] https://patchew.org/linux/20240229162520.970986-1-vanshikonda@os.ampe=
recomputing.com/20240229162520.970986-4-vanshikonda@os.amperecomputing.com/
> [2] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.micha=
lska@arm.com/
> [3] https://elixir.bootlin.com/linux/v6.15.6/source/drivers/cpufreq/cpufr=
eq.c#L2415
>
> --
> -Prashant
>


Return-Path: <linux-pm+bounces-35229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34083B968C5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DFD3B51C6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDD231827;
	Tue, 23 Sep 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIXubb8J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C818220F2D
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640923; cv=none; b=T4+taUxb9dHh8RU7jz5PJLxq3mu/9If48u05slXH0XImIbHOUgwGDPjsdtYkZvPG4WVd5YkZEGE9xeu7g4/hoRr4PwQ9oA0f4TprRlnFwnNPd+5LptVJhxy+POYYVpSo4MYvuj+8xRlQ3kEnh4Y0nP5BoDx+OfzUlV8co5ujtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640923; c=relaxed/simple;
	bh=7bZSGMQ5mwqXO+sLkyQfULfqF0fom0fGvmRzs68vpHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQatNrKSnP3fn/kerh6FHQA93DUtUwNSmSNlrWZoCqJXC4Hvj9p7OhMDT9QXfraUJm6tMUjpU1A03Z/+CS+oRAXoSE7Pa7yhg+HPaMo1ZqymNnqNxrELC2/EV+s1wrJAtXiS8hdf1kdbYlxt75K2MA6dzuL8jjfJUsjnJRTxYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIXubb8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAD1C4AF0B
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640922;
	bh=7bZSGMQ5mwqXO+sLkyQfULfqF0fom0fGvmRzs68vpHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SIXubb8JFj6Tt6qq9r8LFxQcRvsmjylM67O5ceE92hg6FhM8e88QLElIOeEfhco2/
	 l94P8hMJPszPIhENG4sEQVJB/uYrrceYeLAx2LQ+hV45sN7BGiBqZ7ibBMoHRdWJjU
	 KoCmA28X0JdWp8a/T/UbzdTeKHY9vHvvVNbAnAnuzHDvrjv1Fq5bstsV3wjYvlYLKX
	 RmRHRYC1PaCb+GTOywEc6mr5JAyJNo6GhwZUxNdu21Vv7+sF2GW9+os6tHHUbtPvK5
	 Ht0K6zGJpjMDXhW3IYhFyMvPkmwASEGEXLYkzi1EcK/3Ss0dZDXOwi3lswT5A9rz17
	 YHGvZ5r1HmA9w==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-62190d14a96so2116463eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 08:22:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNj2epiMYWR3FASY2+zYwnZHjTu744PNTLf6lx5HRbBctULPbpFhQ7KBvSiot0SDsStcLPSvwf+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4fbgeH1KypKwo5r9/t+aq5u2TaBCv4e32d+K6+gvinYC/CCp
	SfF03v2SOqQ8zWWE2mHCjoEkkf6/Yiotsbda/sXP3+m1jGiL8PTJOH50VV8AQGGpV6ImkG/dyy1
	qHEQ8wYMTUjt6BGkLkasnTC1Dm0WzDE8=
X-Google-Smtp-Source: AGHT+IFiv1EPSVY/X4ywZhPtwQ4ZHqOSLQqaU6hYqeFwwOLfMIBaaMhovazKd0vF3COc0oBn8BzEhq+gBSMDZYj/MbQ=
X-Received: by 2002:a05:6808:1307:b0:43f:2500:6531 with SMTP id
 5614622812f47-43f2d31b20fmr1344148b6e.9.1758640922031; Tue, 23 Sep 2025
 08:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923075553.45532-1-zhangzihuan@kylinos.cn> <20250923090910.6ojsyi333ijyjmmo@lcpd911>
In-Reply-To: <20250923090910.6ojsyi333ijyjmmo@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 17:21:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gp61N2e1VkPzJQtgXm-DTiP1TASoy=v9mWrP=CcybmJA@mail.gmail.com>
X-Gm-Features: AS18NWDgAsoETywuw19E7PJiSb6qJSqn4soooqyvnKgSE_2MV3k0ckiq7jEAPxE
Message-ID: <CAJZ5v0gp61N2e1VkPzJQtgXm-DTiP1TASoy=v9mWrP=CcybmJA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Replace pointer subtraction with iteration macros
To: Dhruva Gole <d-gole@ti.com>, Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, zhenglifeng <zhenglifeng1@huawei.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:09=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Sep 23, 2025 at 15:55:53 +0800, Zihuan Zhang wrote:
> > The cpufreq documentation suggests avoiding direct pointer subtraction
> > when working with entries in driver_freq_table, as it is relatively
> > costly. Instead, the recommended approach is to use the provided
> > iteration macros:
>
> Thanks for the patch,
> Just say "macro" not "macros".
>
> >
> > - cpufreq_for_each_valid_entry_idx()
> >
> > Replace pointer subtraction in freq_table.c with the macros
> > cpufreq_for_each_entry_idx() and cpufreq_for_each_valid_entry_idx(), as
>
> Where is "cpufreq_for_each_entry_idx" in this entire patch?
> Please drop this reference, why confuse people?
>
> > the index does not need initialization, avoiding unnecessary
> > computation. This improves code clarity and follows the established
> > cpufreq coding style.
>
> You don't need to add all this to the commit message about the
> unnecessary computation, code clarity, etc..
> Please keep it to the point.
>
> >
> > No functional change intended.
> >
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> >
> > V2:
> >  - Remove unnecessary initialization for current and remaining follow R=
afael's suggestion
>
> You didn't fix Rafael's first comment [1] about the $subject, and also pl=
ease
> add links to previous revisions for ease of review.
>
> [1] > In the subject, this is just one macro, not multiple macros.

@Dhruva, thanks for the review!

I've fixed up the shortcomings pointed out above and applied the patch
as 6.18 material.

> > ---
> >  drivers/cpufreq/freq_table.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.=
c
> > index d5111ee56e38..408fd8fee2e3 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -33,16 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_=
policy *policy)
> >       struct cpufreq_frequency_table *pos, *table =3D policy->freq_tabl=
e;
> >       unsigned int min_freq =3D ~0;
> >       unsigned int max_freq =3D 0;
> > +     unsigned int i;
> >       unsigned int freq;
> >
> > -     cpufreq_for_each_valid_entry(pos, table) {
> > +     cpufreq_for_each_valid_entry_idx(pos, table, i) {
> >               freq =3D pos->frequency;
> >
> >               if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
> >                   && (pos->flags & CPUFREQ_BOOST_FREQ))
> >                       continue;
> >
> > -             pr_debug("table entry %u: %u kHz\n", (int)(pos - table), =
freq);
> > +             pr_debug("table entry %u: %u kHz\n", i, freq);
> >               if (freq < min_freq)
> >                       min_freq =3D freq;
> >               if (freq > max_freq)
> > @@ -126,7 +127,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_pol=
icy *policy,
> >       };
> >       struct cpufreq_frequency_table *pos;
> >       struct cpufreq_frequency_table *table =3D policy->freq_table;
> > -     unsigned int freq, diff, i =3D 0;
> > +     unsigned int freq, diff, i;
> >       int index;
>
> Usually, it isn't advised to touch code that's not strictly relevant to
> your patch. However since this seems like a minor fixup it's fine by
> me... Upto Rafael whether he prefers to have/not have this unrelated chan=
ge.
>
> But atleast mention in your commit message that you're also removing the
> initialization from cpufreq_table_index_unsorted as part of some minor cl=
eanup
> (which seems kinda unnecessary to me TBH in the first place)

Yeah, better to say about things like this in the patch changelog.
I've fixed that too.


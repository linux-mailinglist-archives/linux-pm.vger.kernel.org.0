Return-Path: <linux-pm+bounces-33586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E85B3EEDB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 21:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C4166626
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239C343217;
	Mon,  1 Sep 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meJ89MjB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741E343210;
	Mon,  1 Sep 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756090; cv=none; b=QI5KR0LrfV7Mcn9B6wFsVD6lDrP47nchPHVj0TpbLenxAaqjucbmJs/y1WkFYPURQNrmESlMIuJnSj+DkWNqFSIjDfVsNLoroYrg7tTKxrjjCjO+pQUVOK0bSQDOsqTo5mX1W6GW7F5hItj72h3JWWcKxFqJtK+wZ0FJfMOZc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756090; c=relaxed/simple;
	bh=DGZHTkJldzUyQjKeR9Fu5h08ChhZavUznUG/ig7/IXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9WsvSwSKQqIEe1qriFmV5aq7JqeChh8nk4YLuDsDiZEfyfFw7h3wS1D8y6W+9tdoac/app9EUivfHTqSw+f472CCLwK2kZsG7FmH/c1Wfgncg4ENyyGlDVeLAdP6ICr3VS7/yXwr1upIqBbDX7JHIEiITvjiTjiRBkasV52rBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meJ89MjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C585C4CEF7;
	Mon,  1 Sep 2025 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756090;
	bh=DGZHTkJldzUyQjKeR9Fu5h08ChhZavUznUG/ig7/IXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=meJ89MjBHaFLc7CJ9S+9ZYQHtM2CenKIIuAbVB2BqRNDMhzUNSiXJ2FkdoCdfkmV+
	 Aea4Yqj5mZG/44mlICXAtpI7raYRQr88bSGNVB6Ooel1/7+aPfVXwf17tYL0Vzy/M9
	 qp1AfQNwfOvHdUqc0ne5ZcY8Ka+uzty9vdk17h86JgMvWwudpmsbCB0RGihyGGTi85
	 Xv7KYAs+VzVlnUjCW/v83qQEev7vIp+sfIVctMKuai4wedVLpzxDY03MWoRaV+AU6q
	 js83ksSS7MX50rhswxIQZQpjpzh3i4Q+MXYSJwjCIv4Lp4l7/h9B2yCee6BaFbbL70
	 8EzwMJLBHCj0w==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7456b27fac1so2013823a34.2;
        Mon, 01 Sep 2025 12:48:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVye0F62ufKTDXLFVSRBhGqWAqmeLI7XrUEa6HMX6PkrAve/NalsoTH2iJQNeEeuo6dKa3p75z9@vger.kernel.org, AJvYcCX3GXW3e2h1aRIPMJoXAr+UlFbRVZTZGA9ozZZlgxXhdIowEfjUEl9FXkYr6RnCW8UxRloTVQO4B8I=@vger.kernel.org, AJvYcCXTAVPUwBgjmE1KYK8yniTrtxMDx5jqmidHXNW0QZSkaOu6Fzdr8ydoXSQkCTQKtc/61r2q+c6jS4PoUDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSSADTovrHn2VHJXIrhb0cSoMnyNGq0ty3qDpHfr+uurIMHH0
	oA+4yxSvhNE40G9lzscW/1xpWlMEmIky07gInn4SCkzj+8pMud8L44r6uzTT/NLhZ5hVkoQttc4
	s2Pi1pHkbUzA8QV9r0dWKLyU/FHivprc=
X-Google-Smtp-Source: AGHT+IFUMlmRkB0VAdqBqgHkiKH7N16/2Mtp7BjtUcoC9Ff2BlzVEjq1QWzxOnH23ztVsfzX9y7JNueDkmKcGIo+hMo=
X-Received: by 2002:a05:6830:7010:b0:741:5d00:e86a with SMTP id
 46e09a7af769-74569dbdce6mr4573078a34.8.1756756089427; Mon, 01 Sep 2025
 12:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831214357.2020076-1-christian.loehle@arm.com>
 <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com>
 <dd2e0cdd-ca95-4c83-9397-0606f3899799@arm.com> <CAJZ5v0jbOwH7T0StbjQLVeQiYhYU2EMCT+yp8jr8r0p4AwNgkw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbOwH7T0StbjQLVeQiYhYU2EMCT+yp8jr8r0p4AwNgkw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 21:47:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOuLJEPm_sG=4xOpqKJ2izY2pbLc7ROq70wvXgtb_m4A@mail.gmail.com>
X-Gm-Features: Ac12FXzhuwiVzSIYKWcXfJbzb2NecGmZKKEToOtHf8uJwsUberAa5nVrgbkTFxs
Message-ID: <CAJZ5v0gOuLJEPm_sG=4xOpqKJ2izY2pbLc7ROq70wvXgtb_m4A@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix late boot with holes in CPU topology
To: Christian Loehle <christian.loehle@arm.com>
Cc: lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, 
	kenneth.crudup@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 7:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Sep 1, 2025 at 7:33=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 9/1/25 17:58, Rafael J. Wysocki wrote:
> > > On Sun, Aug 31, 2025 at 11:44=E2=80=AFPM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
> > >> adjustment") added a mechanism to handle CPUs that come up late by
> > >> retrying when any of the `cpufreq_cpu_get()` call fails.
> > >>
> > >> However, if there are holes in the CPU topology (offline CPUs, e.g.
> > >> nosmt), the first missing CPU causes the loop to break, preventing
> > >> subsequent online CPUs from being updated.
> > >> Instead of aborting on the first missing CPU policy, loop through al=
l
> > >> and retry if any were missing.
> > >>
> > >> Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity=
 adjustment")
> > >> Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
> > >> Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
> > >> Closes: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854=
f72b8144d@panix.com/
> > >> Cc: stable@vger.kernel.org
> > >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > >> ---
> > >>  kernel/power/energy_model.c | 13 ++++++++-----
> > >>  1 file changed, 8 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model=
.c
> > >> index ea7995a25780..b63c2afc1379 100644
> > >> --- a/kernel/power/energy_model.c
> > >> +++ b/kernel/power/energy_model.c
> > >> @@ -778,7 +778,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
> > >>  static void em_check_capacity_update(void)
> > >>  {
> > >>         cpumask_var_t cpu_done_mask;
> > >> -       int cpu;
> > >> +       int cpu, failed_cpus =3D 0;
> > >>
> > >>         if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
> > >>                 pr_warn("no free memory\n");
> > >> @@ -796,10 +796,8 @@ static void em_check_capacity_update(void)
> > >>
> > >>                 policy =3D cpufreq_cpu_get(cpu);
> > >>                 if (!policy) {
> > >> -                       pr_debug("Accessing cpu%d policy failed\n", =
cpu);
> > >
> > > I'm still quite unsure why you want to stop printing this message.  I=
t
> > > is kind of useful to know which policies have had to be retried, whil=
e
> > > printing the number of them really isn't particularly useful.  And
> > > this is pr_debug(), so user selectable anyway.
> > >
> > > So I'm inclined to retain the line above and drop the new pr_debug() =
below.
> > >
> > > Please let me know if this is a problem.
> >
> > For nosmt this leads to a lot of prints every seconds, that's all.
> > I can resend with the pr_debug for every fail, alternatively print a
> > cpumask.
>
> Printing a cpumask might be better, but it would add some complexity
> only needed for the printing.
>
> Maybe it's just better to not print anything at all.

I've changed the patch to that effect and tentatively applied it, so
no need to resend if you agree with this modification.

Thanks!


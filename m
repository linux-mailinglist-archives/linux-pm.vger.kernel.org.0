Return-Path: <linux-pm+bounces-33579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80357B3ED70
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF2934E00D1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3145320A24;
	Mon,  1 Sep 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1tZ14NR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79812E6CDF;
	Mon,  1 Sep 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756748507; cv=none; b=J3cuMPukzFRqks/xcWIswsfEcDgceFcvqM/9PqeY7VTm/KE2h3Mw9HREbUGr8J/ppKPlgviyzIxzDu1bNYLvrrBuoWmrvkiil5peP/UJHeaipKXoCYSHCsaxj9IUWgCAu+FEUahp/3sqKOwqH+iJXsy/4/lFopqr6MLJIZBwdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756748507; c=relaxed/simple;
	bh=1wZjdHwOsPto9cpgRr7TJEUhZc8WSboxPhUfyDDvGTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKF8w0YqpxmPK2xLWRQVNTId2cvvJjMIbCpTeLqyvfCmgszKcpb1pdu2AOENPo0vumfblBotPvQw40Ub+IPMT/izuQhifNmEXT4pI5z7mlce7dEJ1RMIoQAtSfOePN/7ow3F6cAOWJTtHub6y86+1y/5v4uvXiZO//Uwke9xI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1tZ14NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D0C4CEF0;
	Mon,  1 Sep 2025 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756748507;
	bh=1wZjdHwOsPto9cpgRr7TJEUhZc8WSboxPhUfyDDvGTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A1tZ14NRhB+83cV7mQTWGS7Ogmy8JyL0CSBt68sEqrIh61DIhmoSTXamRZSUoO8Q4
	 1Qs6xk23m+ghalc8Wa4mzIbQMkVwU+Azslo4CVMPlyKwAeWiGJK7JFKJ3rHb4gGB1W
	 /0B/YdnDqM7N2G7VhKGPDsjBqegJrizgx0GaeO2yMYYZjfPnGAm9n6yxu2QHZeuzDR
	 fCMSBpiZbMXWc/BCvgMyAQy+Z+KfDgo6GP5+LNemAoyY4wIxUJ1nrOGpQ55bCLE06X
	 o/ALVH28jNAalXB77rn0BDBotYG55OQQQOYVjjQ/rHtS9biAKvGps1c+ZJX1Xwuo0b
	 VCrJ4AdloKauw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61e4c824615so513193eaf.2;
        Mon, 01 Sep 2025 10:41:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjwsSSWdiN5IET3ai/kKK+NYSo2HlXATgZNB9g6csNevbo3x3hHzO+iFa63ZFvQ6McMhx3kx9AFSs=@vger.kernel.org, AJvYcCXVdVbQvIt8Sm6dPXGvdvLtCrJaIgyXO3jn/sesRQsT7bzXo6eTRXPyfGLX3knH+vq/0hlXIPS1@vger.kernel.org, AJvYcCXrcplm4DTbAFGmYzVt5wsTGm5gS6YsIlJqJtlkOW5p8SHfUEjmFA/XserSzTr5jygO3wEI5b7OuqLIzSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXo3NhnItryqdLOq2XZtXjLZeGvUk4l9DwOsckkHs1OAxBi/b
	+OaEQLeBALaBBR6m6v+pP329GU1kZWSKYhldt/SkkpmfKX9aMHmyd8kTQK8elC6HjLuq5pP3xTT
	NoKVBmfbK/i+MagQxKnW99IySvj8P7tc=
X-Google-Smtp-Source: AGHT+IGa4xfTnY3Sp9MIANCEgCMoCnAUqHJjLjgbQUIgBxSwzomaui+aS72hy+yHlMeRPAjZGGHn6QEYiI4fpxfWEuQ=
X-Received: by 2002:a05:6808:144a:b0:437:f66d:a110 with SMTP id
 5614622812f47-437f7cc19acmr3529062b6e.9.1756748506627; Mon, 01 Sep 2025
 10:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831214357.2020076-1-christian.loehle@arm.com>
 <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com> <dd2e0cdd-ca95-4c83-9397-0606f3899799@arm.com>
In-Reply-To: <dd2e0cdd-ca95-4c83-9397-0606f3899799@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 19:41:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jbOwH7T0StbjQLVeQiYhYU2EMCT+yp8jr8r0p4AwNgkw@mail.gmail.com>
X-Gm-Features: Ac12FXy4YWoYjLnpyHC9xyZgDg-5XYmUIKhhC8G5lwNBwuCxV2o86m6_E_VUs7Y
Message-ID: <CAJZ5v0jbOwH7T0StbjQLVeQiYhYU2EMCT+yp8jr8r0p4AwNgkw@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix late boot with holes in CPU topology
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, 
	kenneth.crudup@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 7:33=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/1/25 17:58, Rafael J. Wysocki wrote:
> > On Sun, Aug 31, 2025 at 11:44=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
> >> adjustment") added a mechanism to handle CPUs that come up late by
> >> retrying when any of the `cpufreq_cpu_get()` call fails.
> >>
> >> However, if there are holes in the CPU topology (offline CPUs, e.g.
> >> nosmt), the first missing CPU causes the loop to break, preventing
> >> subsequent online CPUs from being updated.
> >> Instead of aborting on the first missing CPU policy, loop through all
> >> and retry if any were missing.
> >>
> >> Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity a=
djustment")
> >> Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
> >> Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
> >> Closes: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f7=
2b8144d@panix.com/
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>  kernel/power/energy_model.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> >> index ea7995a25780..b63c2afc1379 100644
> >> --- a/kernel/power/energy_model.c
> >> +++ b/kernel/power/energy_model.c
> >> @@ -778,7 +778,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
> >>  static void em_check_capacity_update(void)
> >>  {
> >>         cpumask_var_t cpu_done_mask;
> >> -       int cpu;
> >> +       int cpu, failed_cpus =3D 0;
> >>
> >>         if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
> >>                 pr_warn("no free memory\n");
> >> @@ -796,10 +796,8 @@ static void em_check_capacity_update(void)
> >>
> >>                 policy =3D cpufreq_cpu_get(cpu);
> >>                 if (!policy) {
> >> -                       pr_debug("Accessing cpu%d policy failed\n", cp=
u);
> >
> > I'm still quite unsure why you want to stop printing this message.  It
> > is kind of useful to know which policies have had to be retried, while
> > printing the number of them really isn't particularly useful.  And
> > this is pr_debug(), so user selectable anyway.
> >
> > So I'm inclined to retain the line above and drop the new pr_debug() be=
low.
> >
> > Please let me know if this is a problem.
>
> For nosmt this leads to a lot of prints every seconds, that's all.
> I can resend with the pr_debug for every fail, alternatively print a
> cpumask.

Printing a cpumask might be better, but it would add some complexity
only needed for the printing.

Maybe it's just better to not print anything at all.


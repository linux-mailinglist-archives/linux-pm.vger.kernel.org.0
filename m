Return-Path: <linux-pm+bounces-24963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01EDA814B7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 20:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455994C60C4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA923F273;
	Tue,  8 Apr 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQr42NUm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A411223714;
	Tue,  8 Apr 2025 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137277; cv=none; b=KXTEMrdQUsrX1mDEcyj+R8yOMy4AFcoc8CPj/hoz7gZol3NLj5A7XxAVicvTg5HrHelEQhgoiRKjriKjLSklFEMEuuWTTfjFstO11pXV34LNwIW2hphkxZPf/CtKBK0Ku46v+dYcOqV3XmiUi5Ozhpiy6S1bfC0p2ZrlSBXhTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137277; c=relaxed/simple;
	bh=0sZJJExaQ91TPDvwSrGsR8vheFg2V6WnKKctpJC0AIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LziPlJzKmv9PT/lkz6NwT78k5ZOyVkY4ZUCd9vrYYgiNe1/g/DiLjC8nN9rmtHSd1w3vTwhvp/z81LoqxKlyQDPJVQ3gVNBs38kmLb/BUAmkC+eEkLXVKfVMcMylAC2SyHiLwdCfzMJhC7PTDDdPv0CReVznLQ3hIx+NOVL7rRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQr42NUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815AEC4CEE8;
	Tue,  8 Apr 2025 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744137276;
	bh=0sZJJExaQ91TPDvwSrGsR8vheFg2V6WnKKctpJC0AIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nQr42NUmcE7b5R+cW2+tbsT7qO66bsMGbcbi9sMVlSyk75SwX2iNzKLMVy4A1L51d
	 QPgjrkWHMU4euO2YcFVVZbMQruHCW4ikEzmf1xGEV3PZmwQfnbRJQH2UlKkdknk5Eh
	 8MUWZMSJDM9VtW01wvqzaMiSY4Eh6snhrV21kipVPlF/u4YTDpgyr33gGuz4/qlHl6
	 0nY+TQmovtydnex7MWUw1Kg9NHwSUATgF1oFShWuy6XLpB5/gfQXVqJGib2RDgF6KL
	 +Ami9tcY0OstBW+j8bgrBhyGuWEbgJCYfhGhOjIuUhogfiLEgFcKwK0dphzXllFeJB
	 REYxgvoC9rrlg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cc36b39545so2151740fac.1;
        Tue, 08 Apr 2025 11:34:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqhtxfYi1n6aFmIPB9AiAJoSMpCU5GtPOe5Iu6yEbPvsaiRCI2vBQhpYrOErt3S90tqwZcnu/GHM0=@vger.kernel.org, AJvYcCX0/6H4T0ZNXDIybvRjVYRguNEQrt0PrUfGpk5X+pWXSo1xcKgPo57ZfUjMI+aOqoZdYicJFfV3HtLaCMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBo55f0M8v7xiNnb2XeXdE2bpZbCIotfDWBqxbrn5AGaLmdDS
	qiPtYHx1WCFHQgmlkWhaAILmSfC2rmbcvaIzwW3WklmAMKykOeDurHTOeEryAnIH+ef6Mi1t29Q
	4SFE3gAExPNsyIj2LlDhNAQ5TgrE=
X-Google-Smtp-Source: AGHT+IG/tFyu4CHjzqr5TuSGmA+9Zy6vwaCIjvPWzPUyqDSdzWJT8gBoepKM7Suk+Q8NTl0kcIAPmKkak9PjufJrxDw=
X-Received: by 2002:a05:6871:20c4:b0:2c2:37db:dad with SMTP id
 586e51a60fabf-2d08dc8ee6amr87182fac.1.1744137275808; Tue, 08 Apr 2025
 11:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <8560367.NyiUUSuA9g@rjwysocki.net>
 <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com>
 <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
 <CAJZ5v0i7uUFDcTYuam4Hz2fYxpnT6QQQzULk8CNHvkOUfg=bfQ@mail.gmail.com>
 <CAJZ5v0hJCtqbkyMaOSMNoiD5DSz+H6PK_FyUdoVTZTVWEFJQyQ@mail.gmail.com> <6346af9942a0e6730fd6b26f2586b82e6fc04d4c.camel@linux.intel.com>
In-Reply-To: <6346af9942a0e6730fd6b26f2586b82e6fc04d4c.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Apr 2025 20:34:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htfoQzL48=-JcocfiV7hN5N5Bjn36vZ+zLCQ=Lathcfg@mail.gmail.com>
X-Gm-Features: ATxdqUGbcDgnIvD-diYgGnd22eZM6rrXCUoJJJNCfX6jx4cnh6QZdqwI3T3olyw
Message-ID: <CAJZ5v0htfoQzL48=-JcocfiV7hN5N5Bjn36vZ+zLCQ=Lathcfg@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to ->update_limits()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:47=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2025-04-08 at 15:37 +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 8, 2025 at 1:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org>
> > wrote:
> > >
> > > On Tue, Apr 8, 2025 at 12:28=E2=80=AFAM srinivas pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >
> > > > On Mon, 2025-04-07 at 20:48 +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki
> > > > > <rjw@rjwysocki.net>
> > > > > wrote:
> > > > > >
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Since cpufreq_update_limits() obtains a cpufreq policy
> > > > > > pointer for
> > > > > > the
> > > > > > given CPU and reference counts the corresponding policy
> > > > > > object, it
> > > > > > may
> > > > > > as well pass the policy pointer to the cpufreq driver's -
> > > > > > > update_limits()
> > > > > > callback which allows that callback to avoid invoking
> > > > > > cpufreq_cpu_get()
> > > > > > for the same CPU.
> > > > > >
> > > > > > Accordingly, redefine ->update_limits() to take a policy
> > > > > > pointer
> > > > > > instead
> > > > > > of a CPU number and update both drivers implementing it,
> > > > > > intel_pstate
> > > > > > and amd-pstate, as needed.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > Hi Rafael,
> > > >
> > > > > Hi Srinivas,
> > > > >
> > > > > If you have any concerns regarding this patch, please let me
> > > > > know
> > > > > (note that it is based on the [05/10]).
> > > > >
> > > > Changes looks fine, but wants to test out some update limits from
> > > > interrupt path.
> > > > Checked your branches at linux-pm, not able to locate in any
> > > > branch to
> > > > apply.
> > > > Please point me to a branch.
> > >
> > > I'll put it in 'testing' later today.
> >
> > Now available from
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> > testing
> >
> Looks good.
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks!

IIUC this applies to both [5/10] and [10/10], or please let me know if
that's not the case.


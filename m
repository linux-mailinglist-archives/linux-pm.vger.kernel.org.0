Return-Path: <linux-pm+bounces-24936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BFA80CB1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C172E1BC12DE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940217A312;
	Tue,  8 Apr 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv8gKvYZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A281632DF;
	Tue,  8 Apr 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119457; cv=none; b=qSksNWcMJXNPQxQ7YPpUS8KGWPd3y0NxC5ZBWW92nn0+H8mdQ6BU1rjmaAdKlUSQegkKNcoC9YFsllj27KNii1p+mad3CiMQrfPVesY3rz/8zYIQqqyRPwdcLWZRFkHRExPihY2hDyKUjouRd8FxPmCWFss6ujkAqTROpEYjuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119457; c=relaxed/simple;
	bh=FYhTE/iY9Y+AzxVNHuLvd4WShotIjn52sSa5sln1lrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQjVF+6y6gBPhmWW4RdOOvSyTP0LoHgxhY0033HVUO0gAAvu3oYjeVizs5cZxpUSS6MXxgMwljH1V1V1CEMdRgS3AHjRvVkfW55KxdYm18lNBipFD+i6+x2CAzgs6JzYAegL6/ri0pOOhLh0C5Sg6genorwyXz4/nJkGC0acwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv8gKvYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF41C4CEEC;
	Tue,  8 Apr 2025 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119457;
	bh=FYhTE/iY9Y+AzxVNHuLvd4WShotIjn52sSa5sln1lrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uv8gKvYZOxTnZdY0kaKd6FfRtBKdSQeRlS8xgoNb3TbCBt8rFIBllwn5HFtEVSmkj
	 HGNw8KRFyjfqKZ6vVo7Q5ILOY/qnDl15t/mvpl2shaLm6fBRS8++vE3Wptj+gxEyAv
	 r5OEDjeiELYQvQMFHw99mWl3rJTXewJS7FC6nJj3qB/jW5KB9Xlq4+NZBs/TZzg9Pc
	 B/EAED1DfVYkfKwV6Crj7usAFkBI0woxUmRsOfjpBYUhQRrnpveYZFHo9P8M5PlvN/
	 7K08e9f7fp6mtStt+nIOYxdGoEwLW69JeJa92DtF5GkKU+0qG39guG6m9PNQB4SBaG
	 LgAtU8VAaV25Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2b8e26063e4so2894470fac.3;
        Tue, 08 Apr 2025 06:37:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLeMBkcZ4YzcRg8QbH4uQ5I1OonAseaaRbnUdxoQMAyIv6PyivuyRY/9atiu3NCXxZ+yDqPqzeKYb7L2E=@vger.kernel.org, AJvYcCWqsBVYX9TRrIC5Q5+W8Uh12HxUs3MYj8uyFfcjMvvIKN8o2v8HJzYLYcpVsXEBHQhM8pp8x0YM8aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHZT91tEmIzb7fzQYPg2eT0Yu3PpIR6y5Qm5Sqd3IKYm39Omk
	6wxfHV4Gx1X3wKCof6utnl7nxb0+woWE27mB+z4mG/WGyxmWvsSpQpKMtwtb48twCXKGSBmAezA
	xkN2UzrFPP44ux4kI5WNLnIIqkUA=
X-Google-Smtp-Source: AGHT+IGRAb61WFFRgfsEeOJinw/+ed+QxyallZV2HUVj9aBY9akS78F0a6R6DBNGpRCCIF3fc585Boi5z1vTofAQfZ8=
X-Received: by 2002:a05:6870:4d10:b0:2c2:71f:2c0b with SMTP id
 586e51a60fabf-2cd32eb7750mr7025079fac.11.1744119456219; Tue, 08 Apr 2025
 06:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <8560367.NyiUUSuA9g@rjwysocki.net>
 <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com>
 <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com> <CAJZ5v0i7uUFDcTYuam4Hz2fYxpnT6QQQzULk8CNHvkOUfg=bfQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i7uUFDcTYuam4Hz2fYxpnT6QQQzULk8CNHvkOUfg=bfQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Apr 2025 15:37:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJCtqbkyMaOSMNoiD5DSz+H6PK_FyUdoVTZTVWEFJQyQ@mail.gmail.com>
X-Gm-Features: ATxdqUEAF_o5jnFIRHZPzl5rUxlanD7LPJjjrI0gfAf7gry5f-ssJM1-NxQ7ytE
Message-ID: <CAJZ5v0hJCtqbkyMaOSMNoiD5DSz+H6PK_FyUdoVTZTVWEFJQyQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to ->update_limits()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Apr 8, 2025 at 12:28=E2=80=AFAM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Mon, 2025-04-07 at 20:48 +0200, Rafael J. Wysocki wrote:
> > > On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki <rjw@rjwyso=
cki.net>
> > > wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Since cpufreq_update_limits() obtains a cpufreq policy pointer for
> > > > the
> > > > given CPU and reference counts the corresponding policy object, it
> > > > may
> > > > as well pass the policy pointer to the cpufreq driver's -
> > > > >update_limits()
> > > > callback which allows that callback to avoid invoking
> > > > cpufreq_cpu_get()
> > > > for the same CPU.
> > > >
> > > > Accordingly, redefine ->update_limits() to take a policy pointer
> > > > instead
> > > > of a CPU number and update both drivers implementing it,
> > > > intel_pstate
> > > > and amd-pstate, as needed.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > Hi Rafael,
> >
> > > Hi Srinivas,
> > >
> > > If you have any concerns regarding this patch, please let me know
> > > (note that it is based on the [05/10]).
> > >
> > Changes looks fine, but wants to test out some update limits from
> > interrupt path.
> > Checked your branches at linux-pm, not able to locate in any branch to
> > apply.
> > Please point me to a branch.
>
> I'll put it in 'testing' later today.

Now available from

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git testing


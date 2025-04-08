Return-Path: <linux-pm+bounces-24932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B5A80253
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876464423FA
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C37265602;
	Tue,  8 Apr 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmo638XH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29719AD5C;
	Tue,  8 Apr 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112476; cv=none; b=RuNUNVwmbFBh0x8n42MOC/a4oSBRlHApTHowqztNjE9CgPsUt4yl0FC+yo0ujvYkQGLBcalfc2ryUXIMXJluGPzd9VgnNMT0HbSwwfnBWNiwX6qMwtHHxcXdlCx7dKrXNRIcOfvAPWIck0fY8pEFJStcQwcWcE9dqqBLY8ctBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112476; c=relaxed/simple;
	bh=Y4Qqj2e8sRw4IcpVEs62t53lddToNxMVHOHtZI31qLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwA/IOaGOvhcoRNS/XzV8W2noUdWRR3l9zkGlaaKqojVO8WQE2mKauc4dM2EW4irAu7nx1qv/fl8zf2dH2iLKpejipI+eOM8m234o40QXJ/bvD0S4KxZrvVNy4bVBhdk2/9nAH4Nf55hGuRtO7d8BQ29rebONNCfYsRCKFe6W+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmo638XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C95C4CEEB;
	Tue,  8 Apr 2025 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744112475;
	bh=Y4Qqj2e8sRw4IcpVEs62t53lddToNxMVHOHtZI31qLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kmo638XHPrDfntfbt/7HnD3EEGtmgwL3ZC0AURBYbePPWWs/RQlt+S5tzOGj8Hwcx
	 KTR1nbXWf1YlnvF+5g6SVgiQ9xnzDtb+REbT4rwOY8CHdEYQvFMTFsiJJCYrdImevc
	 Ih1cbPOmopQub4X4CNS1q0Fi8kxb6huWaxmwCOCEhQ+7XE95oNN9iYqN4uFjqIhbbr
	 QFvKm/wEDMU/rDlzHsbCcUEHRUTSiGsf8tmjlKrcspvYq4EwUtEZMnpkXZMoSlHw1T
	 C4Wcq7OfDCwUNnOfGJj9h3FtvR6Q4iocRIcJeYMcfsSlAzhfL6a50xALxCadO3DU3x
	 4KPlmo63QswoQ==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c16e658f4so2342266a34.1;
        Tue, 08 Apr 2025 04:41:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkf1brNWi00lbQgJxSGYH90ftQF6YkD2Kema2OZplaYMNvYO/pb8n9wUm10BAON6Zx4g4EmZCTGoAB13E=@vger.kernel.org, AJvYcCXuEAlU55CjMJj+gJIapqXKVZhAvxkES2gFeBT6x5b+Hb9BD/R+P0I9GYXsHMumfilNFgS+W7TAL8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3vm/EIjXxOqHGJ0nBULCPthkt0i08HmViOr/84z9Te2Vde7G
	p6O4IvOkivI8ytdBLzCsrXKvQHkUiAR+qpL7w1uQNcjeSaomLCXOufn4gu6tnLkqjx5eIt0mpqs
	z52Qd4ox0xwCNk944g1CPYzzX+oY=
X-Google-Smtp-Source: AGHT+IEcpWj1ur7hPh90DboICwtcCiawjXAh0K7u+IcizwWx+1R+Zd+C5PAclMFiSvtu+Yttll2dZVgfwpVHzhSJSKw=
X-Received: by 2002:a05:6830:2a8a:b0:72b:a6f4:de5e with SMTP id
 46e09a7af769-72e37fd1343mr9972915a34.26.1744112475133; Tue, 08 Apr 2025
 04:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <8560367.NyiUUSuA9g@rjwysocki.net>
 <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com> <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
In-Reply-To: <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Apr 2025 13:41:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7uUFDcTYuam4Hz2fYxpnT6QQQzULk8CNHvkOUfg=bfQ@mail.gmail.com>
X-Gm-Features: ATxdqUEzPWxoGPM3HLYod2V1jjuFZnoOwCx--NKvhKQb62bHicBeqE3gV5M-skg
Message-ID: <CAJZ5v0i7uUFDcTYuam4Hz2fYxpnT6QQQzULk8CNHvkOUfg=bfQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to ->update_limits()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:28=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2025-04-07 at 20:48 +0200, Rafael J. Wysocki wrote:
> > On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysock=
i.net>
> > wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Since cpufreq_update_limits() obtains a cpufreq policy pointer for
> > > the
> > > given CPU and reference counts the corresponding policy object, it
> > > may
> > > as well pass the policy pointer to the cpufreq driver's -
> > > >update_limits()
> > > callback which allows that callback to avoid invoking
> > > cpufreq_cpu_get()
> > > for the same CPU.
> > >
> > > Accordingly, redefine ->update_limits() to take a policy pointer
> > > instead
> > > of a CPU number and update both drivers implementing it,
> > > intel_pstate
> > > and amd-pstate, as needed.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> Hi Rafael,
>
> > Hi Srinivas,
> >
> > If you have any concerns regarding this patch, please let me know
> > (note that it is based on the [05/10]).
> >
> Changes looks fine, but wants to test out some update limits from
> interrupt path.
> Checked your branches at linux-pm, not able to locate in any branch to
> apply.
> Please point me to a branch.

I'll put it in 'testing' later today.


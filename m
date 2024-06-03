Return-Path: <linux-pm+bounces-8535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7248D88A5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6051C22A20
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC71384B6;
	Mon,  3 Jun 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsEnbYk8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAD1CD38;
	Mon,  3 Jun 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439564; cv=none; b=RyVJjdKUsdn1x2mSW22shsGPxUwdpbrqm9hSFIAvbfWV2ZslRwmuUey2vquLaHRt3cdLuMvamohu3QHnUwjQkTx6QwzQv+wWoON4vBGvo9Fn+wlcMb5DdUTNEGL18fF1wYxDpfyPW5GOAkSD9NnK6a9HbGz7fdsHzTxsIM3uOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439564; c=relaxed/simple;
	bh=aPa+/FsLkyYUDC9JB9iMOLBgMjAYvMKPSrF8ZW8Ds9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu/5Q9fwkR/YzImnxk2/xEiNQE0yGtapDgTwfBVWi1tDzFNNWnBKzDooeVBGL+kHSy8tsRqg5yq5oMCQkCP867otG08GpBH4pG0PpoNEJEMgzJt5S+O7/OSLz+NFw/xK+t6I/ArpJ1bKt9ch8Qym96ZvEXbPHp0oE+VWQbNRXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsEnbYk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715BDC4AF08;
	Mon,  3 Jun 2024 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717439564;
	bh=aPa+/FsLkyYUDC9JB9iMOLBgMjAYvMKPSrF8ZW8Ds9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NsEnbYk8tcs5EN293qSPbTGJ7Ffzf1hp1D7/KGgH4flOKv+9yRsQu2d9DHUzSSiQF
	 ywfJJl3Ow1AeWqRM90arYV9XdE6o5psPLn7DQYa0gmR8k1cVT2QTYcqtCILRJ+mbH7
	 sBdBpg3ei8jcXkjE7DKC8Sn5G0fFq7OGchun3zOYHTPr299vlPKjN3oq5xiyHsdDlK
	 pQeoDFKnuAIUTnKeXfzPGxS6Ecy63OAdXWouQnCwbkrhBDxrF08vvmNIfRVL42/YkD
	 KnLrduogY6PLPFn5cA12Prw2AjnQXvlmer1NQjGTCxs3xo90h484M7BXsIRRNE+Zen
	 iHpE1zzj1S4+g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b99ba97d89so443190eaf.1;
        Mon, 03 Jun 2024 11:32:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAcxeO/oyX541bnnlLJVsA5qHdWFzpCTlOicgC5w97BXM5D40GCAAJg08JzsZKV4mySBUvOXvKoEtgyk0YYdP6HgP/dTFpmXjJRvlNzPzUXpO0WxVSYYB1SzidQdxbQOvFMWStmxg=
X-Gm-Message-State: AOJu0Yyi+PNnz0lZYzL3fzQgjsA3Kg6866f+IcczbUlgWJ5O7KQtnGE+
	lBt4wTDR4z2gij2sRopQkGzyM9rtJQ15BAHUuNOpTjFyyBcciFkem9nWEdluSwAnhrYAFs/muGh
	9Ty83bjEI52uQlWr0cwih0xC2OLE=
X-Google-Smtp-Source: AGHT+IFkVGBmRedZ8pCYTCG05bHXWol2F1IK/xuSCVveLWdmV8qOK18/xpRA2GSOP8+QAxtU+fHb9EoNTFDYjsSMZyc=
X-Received: by 2002:a05:6870:36d5:b0:24f:ee85:2c9e with SMTP id
 586e51a60fabf-2508bde6735mr11670759fac.5.1717439563751; Mon, 03 Jun 2024
 11:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com> <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
In-Reply-To: <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jun 2024 20:32:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
Message-ID: <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
To: Xi Ruoyao <xry111@xry111.site>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:44=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Mon, 2024-06-03 at 10:11 -0700, srinivas pandruvada wrote:
> > On Mon, 2024-06-03 at 21:12 +0800, Xi Ruoyao wrote:
> > > On Sun, 2024-06-02 at 16:11 -0700, srinivas pandruvada wrote:
> > >
> > > /* snip */
> > >
> > > > What is the output of:
> > > > grep . /sys/devices/system/cpu/intel_pstate/*
> > > >
> > > > Also
> > > > rdmsr 0x771
> > > > rdmsr 0x774
> > > >
> > > >
> > > > Try these three patches. Don't worry about the commit description
> > > > for
> > > > this issue.
> > >
> > > Unfortunately they still do not fix the issue for me.
> > >
> > > The outputs of grep and rdmsr commands are initially:
> > >
> > > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > > /sys/devices/system/cpu/intel_pstate/status:active
> > > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > > rdmsr 0x771: 10d1f2c
> > > rdmsr 0x774: 1f04
> > >
> > > But it then changes to:
> > >
> > > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > > /sys/devices/system/cpu/intel_pstate/status:active
> > > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > > rdmsr 0x771: 10c1f2c
> > > rdmsr 0x774: 1f04
> > >
> > > It seems only the output of rdmsr 0x771 has changed.  And if I read
> > > the
> > > SDM correctly it's a "Most_Efficient_Performance" change.
> > That is fine.
> >
> > We don't have any notifications either via ACPI or via HWP interrupt.
> > I think it was working by chance before this change as by the cpufreq
> > core is trying to set policy, the turbo is enabled by the firmware.
> >
> > What is this laptop make and model?
>
> It's a Hasee X5-2021S5H.
>
> Hasee is known for producing some laptops very cheap but often having
> "minor" issues.  So I guess the firmware is doing some stupid thing.
>
> But turbo works just fine on Windows 11 so it'd be better if we could
> make it work for Linux too.

In principle, there are two things that can be done about this.

First, MSR_IA32_MISC_ENABLE_TURBO_DISABLE on this system can be
ignored altogether, but that would require adding a quirk.

Second, a delayed work can be added to check the MSR long enough after
initialization and update global.turbo_disabled if it is 1.  However,
that would require some code surgery.


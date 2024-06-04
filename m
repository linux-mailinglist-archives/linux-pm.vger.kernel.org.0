Return-Path: <linux-pm+bounces-8587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C18FB97F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6F7B28AFB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C214901A;
	Tue,  4 Jun 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VublYuka"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF813D607;
	Tue,  4 Jun 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519626; cv=none; b=eEJIXn3luBrCdvDsaziYmf0Dr+O2jBe0WDsVxt5minUwI2ZjQkLCk5pEsa2H6qin9kRiEmE2FoYk30cC6dseu+h42beUHMVIX6E371qxjTfIyOXd7SZOnxDV42viU9HB+wmMv/7BCEV+TmXdqtMoaDfqTjic6Cjm1hndLMRq2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519626; c=relaxed/simple;
	bh=NaQPL/mB5WOAFakIMpjp+LfKzjoD3bgZCruovf/5aIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlHtPQy+xy3vXqtntpYK/EUJkumLbKl0yyuHCQi/k1b60cqKDp0oeO1ATN24/a6Ps3VDdj31+BXHXL47cYjHOhhshcFSV7bMXEArzLTXqTnZPHbT10tpoZEd2pkYE+r1WrwK0s7mnxXDylGP0b4naE7MM7QUZ/v0y6u5QPj5X0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VublYuka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20364C4AF0D;
	Tue,  4 Jun 2024 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717519626;
	bh=NaQPL/mB5WOAFakIMpjp+LfKzjoD3bgZCruovf/5aIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VublYukalkFdLt7uNJTqbYX2nA8pMe4HhFmgp7LSKBTA43Tu2EvgBc7Ikzc6GpmOa
	 +NZXnu8mcHxBy3nRb7/ZpXKPU2TngmbvO8BGQr74eipICqZelmvFqeu/Ta+klFIf+X
	 fHdbc38tmyltHQ0fc/wysNlZ15u6v3iQrPLoE69Q4cTKjU8YomvljaseE0vgiC2Obk
	 CW8VHP1n4qKcOOOVFu5WiFEmAa66jlMcX5Ioyi7JXrr+6RTXgkhgDL6ykBcvZFgkqf
	 e2ACCq8eGDOSKTHGu9QftzvcD7xYevf1zn8tcz+DP+SR/fOU6D+//nPci4clElpXol
	 RRns+uspxVf9g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b99ba97d89so499505eaf.1;
        Tue, 04 Jun 2024 09:47:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5EXmA1DHAnbK0mCvBd8WsFjRFen//la2zCUCZBqGQ4DYaCiHAB5/VusHBz+ZsUX+Z5S0beFOZGRWcg/947h70Iv9nJNoLU8765ej9OM2Ec3o2rc/VshBgmGofv51MoQH1VmvTWLM=
X-Gm-Message-State: AOJu0YySd7+FETE9EFvohfGoBXvPyTgWhYbVbClfLv98JR69rLjkCiPE
	OND8DBOy0J2HHCdy1RymSgoOiwbwYTGvSstYCvKWdwZ0d+DVcIE0B8HN4zx+xF5CLkIajFFPH9b
	IaSCLBJPiQFP6q5pT+GeWWKAlpi8=
X-Google-Smtp-Source: AGHT+IH0MT+IPbDGKP0RcQA6aQMggoqeQNDQvmGYOnjoS8zXXu3J4swmJC3r87UemTbydKGgpdGWhJYzQfL+zqJdzjY=
X-Received: by 2002:a4a:ea38:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5ba78d42df7mr222079eaf.0.1717519625410; Tue, 04 Jun 2024
 09:47:05 -0700 (PDT)
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
 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
 <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
 <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
 <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
 <258ce61c155c28937620f6abe57a39f2b4b0ff56.camel@xry111.site> <101b903e58f2ebae60934edc374c7cda09f83de1.camel@linux.intel.com>
In-Reply-To: <101b903e58f2ebae60934edc374c7cda09f83de1.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Jun 2024 18:46:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBBgjBny0Ps9bvHc7q1Un_6sdudpNL0==Z5HB+gHH0Hw@mail.gmail.com>
Message-ID: <CAJZ5v0jBBgjBny0Ps9bvHc7q1Un_6sdudpNL0==Z5HB+gHH0Hw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:41=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2024-06-04 at 18:32 +0800, Xi Ruoyao wrote:
> > On Tue, 2024-06-04 at 03:29 -0700, srinivas pandruvada wrote:
> > > On Tue, 2024-06-04 at 17:30 +0800, Xi Ruoyao wrote:
> > > > On Mon, 2024-06-03 at 21:31 -0700, srinivas pandruvada wrote:
> > > >
> > > > > > > Second, a delayed work can be added to check the MSR long
> > > > > > > enough
> > > > > > > after
> > > > > > > initialization and update global.turbo_disabled if it is 1.
> > > > > > > However,
> > > > > > > that would require some code surgery.
> > > > > >
> > > > > Something like the attached which does same way as user space
> > > > > no_turbo
> > > > > update.
> > > >
> > > > >  static int intel_pstate_register_driver(struct cpufreq_driver
> > > > > *driver)
> > > > >  {
> > > > >         int ret;
> > > > > @@ -3114,6 +3137,9 @@ static int
> > > > > intel_pstate_register_driver(struct cpufreq_driver *driver)
> > > > >         global.turbo_disabled =3D turbo_is_disabled();
> > > > >         global.no_turbo =3D global.turbo_disabled;
> > > > >
> > > > > +       if (global.turbo_disabled)
> > > > > +               schedule_delayed_work(&turbo_work, HZ);
> > > > > +
> > > >
> > > > I have to change it to 20 * HZ to make it work for me.  15 * HZ
> > > > does
> > > > not
> > > > work.
> > >
> > > Is there any consistency or it is changing every time?
> >
> > It seems consistent.
> With such a delay, I am not sure how this even worked before.
> Can you revert the patch in question and use kernel dynamic debug
> dyndbg=3D"file intel_pstate.c +p" kernel command line and collect log for
> 30 seconds?

I think that it worked because the MSR was read every time
intel_pstate ran, so it got updated at one point and stayed that way.


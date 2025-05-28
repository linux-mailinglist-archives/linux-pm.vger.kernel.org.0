Return-Path: <linux-pm+bounces-27749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A90AC6EC9
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6974E3C0F
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D728DF29;
	Wed, 28 May 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXU5e9hj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDBD28DF24;
	Wed, 28 May 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452174; cv=none; b=G+s3nuzdcmPgtlsV4Lu4CfPCRuj6k2HuCB5cr2ntoqiylk8a6LwjcAaVujd4OfhFg1wzCQvfyuVNim0D+bvP8UMe5nj7PXbYyBOX+q/eulSoS+Th5luoCyFQfxNc2wzag7Zhi05F+uTjeXI87yHJEDb3LHir8PEYrh0c9LpJftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452174; c=relaxed/simple;
	bh=HkR+wu8C2YNUTGexZDvoxynMprEXblTejO/1RGsnJHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4V89GvMwvIholUzm5bOhl3krhOQG8HZqB1Xq+6J9edMVd7xsXoHNBPpq9NqalRkjwdJJslIeIPXJDDYjdBxKXJgL5X2XL6NjiXIogwLxQiwBU27gopWpHkvaEyRvNl2soNsiAvj4J6+eCtNvAfxrZiK8d9o+Au6C2WQIpZfAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXU5e9hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60282C4CEF1;
	Wed, 28 May 2025 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748452174;
	bh=HkR+wu8C2YNUTGexZDvoxynMprEXblTejO/1RGsnJHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXU5e9hjwe0RYk1Cjl+MC9IAeql1/93wm+xIE6QweWrVed7erIrx4cKBSF9Ph0ozt
	 FQN9B5RrjJ0IlgDEYvqa0BvZtpJEBDNh1o67zXt/NBx0sGV+HejX9v6zpbTyStnGfe
	 gSyyMANFIquDgxWE3VyfhaaEs59SZuAf/0AcDRlV9+5FBluenqy1+hqL+zFO05GwA/
	 kHNwgKS34ayd9RXVjXD5e+ceH+ain/uKwbH2IXzsHZuH8BkTts2LojpeFw9K0IJJXE
	 fOMF1PkUSRNOBShtFWq1mSWIQyFRP7qzW2XKL70Z4/9Tq5BrfrM8Ub6LIXXGG5Uwpz
	 jJoOI3bf4pKtA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60219d9812bso18609eaf.0;
        Wed, 28 May 2025 10:09:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOMBnxHuYu4FCRo2ioybT+mQMZ7BvUn93PdyEf9SFRoO4dUxwV28uqoAHan0/KStcvByB3nxqWcaYyaRo=@vger.kernel.org, AJvYcCXGgg7n5SqFwUEJ5P5zVDNkWCWMTbQ3ayAbyvfCeiMG5uW2pPmBY7PwqhPzkPUbKWLOh5y7FmmKdv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyALCOKQOydQG1fJ6oKS6OH2pBgcy27UMUDCHjDT8qHb+D0vyUy
	UdgdJoYqxACdqJwiUc8zZkUFXqKzxLa0raa+xufEKQ+Najckve+JPv7O/4Us2GiH3KimDbtlQQQ
	G667F0CgpdjSGd0yPQnOp5rN/qsz8K+c=
X-Google-Smtp-Source: AGHT+IFxlmFquI8XlLScaVJomEsGf59emFFFBAZ/64sUKvyXiS5JOJ76G4+elEalKulRHHzba52P+lI3Tpz0ktuByPE=
X-Received: by 2002:a05:6820:4c81:b0:604:4846:78a with SMTP id
 006d021491bc7-60b9fa5c426mr9718070eaf.2.1748452173721; Wed, 28 May 2025
 10:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2006806.PYKUYFuaPT@rjwysocki.net> <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
 <20250528133807.GC39944@noisy.programming.kicks-ass.net> <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
 <20250528160523.GE39944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250528160523.GE39944@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 May 2025 19:09:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>
X-Gm-Features: AX0GCFtKiXc3m4qPv0Ukobep1NVEUOLfrhFWYC5AiBQNz19Akzfh3sFePEUu36k
Message-ID: <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit 96040f7273e2
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:05=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, May 28, 2025 at 04:25:19PM +0200, Rafael J. Wysocki wrote:
>
> > If cpuidle is available and works, it will do the same thing.
>
> Why can't we make it available sooner? But no, cpuidle does not do the
> same thing -- it was argued it does the right thing because it has them
> tables with C states on and doesn't try and divinate from CPUID.
>
> > > The whole point was that mwait_play_dead did not DTRT because hints a=
re
> > > stupid and it could not select the deepest C state in an unambiguous
> > > fashion.
> >
> > Yes, on some systems.
>
> The 'on some systems' thing is irrelevant. Either it always works, or it
> doesn't and we shouldnt be having it.
>
> > > And now you're restoring that -- code you all argued was fundamentall=
y
> > > buggered.
> > >
> > > Yes is 'fixes' things on old platforms, but it is equally broken on t=
he
> > > new platforms where you all argued it was broken on. So either way
> > > around you're going to need to fix those, and this isn't it.
>
> > The commit reverted by the first patch removed
> > mwait_play_dead_cpuid_hint() altogether, so it never runs and the only
> > fallback is hlt_play_dead(), but this doesn't work for disabling SMT
> > siblings.
>
> It should either be fixed to always work or stay dead.

I'm talking about the current code which is broken on many systems.

> > > Now, SMT siblings are all AP, by definition. So can't we simply send
> > > them INIT instead of doing CLI;HLT, that way they drop into
> > > Wait-for-SIPI and the ucode can sort it out?
> >
> > No, I don't think so.  I don't think that Wait-for-SIPI is an idle stat=
e.
> >
> > But we are discussing patch [2/2] here while really the problem is
> > that the commit in question is broken, so it needs to be reverted in
> > the first place.
>
> No, you all very much argued that mwait_play_dead couldn't be fixed, as
> such it must die and stay dead. Sometimes working is worse than never
> working.
>
> So no, I very much object to the revert.

And I object to leaving a user-visible regression behind.


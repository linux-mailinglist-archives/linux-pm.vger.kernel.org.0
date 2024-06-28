Return-Path: <linux-pm+bounces-10212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0991C623
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5536B1C2167F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8A5381B;
	Fri, 28 Jun 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnqCbULC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C027725;
	Fri, 28 Jun 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600963; cv=none; b=S2ui+erLyIwhbFFM4/gTu96C8H1eUVTmyIgsPzFv2qSwfDWsCKpr7Ldm+zIpm5TOWghQQPstj8MbWaxVqw5UZ9Vy3fOqhFXvsUJvAn7oAc8m8J6Uwf4RjNXAcKn4uXk1jlng/eAHG/t7IPAUJewLrXHenA8i6H44WOPE6BhrkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600963; c=relaxed/simple;
	bh=VDbB67Z3bIECGKJDj4pPAbgO82rGC1DMBgigZ4Sr46Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqb1bp/4c8T8/LLq1DvmfY2JPp637VVM1VqQbh1SRurrHeRvVba3N919rqkiFXXBYdxukJpBrPYJh/pdJ6pDgZBZBWyzNJiEcaegrhq7IfNhU80CwvtdZyeCvHBqm65hOWAGBJLf2MI6/u3FT7jXG7rpJB789mFxGS2iFCh5yBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnqCbULC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C427FC116B1;
	Fri, 28 Jun 2024 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600962;
	bh=VDbB67Z3bIECGKJDj4pPAbgO82rGC1DMBgigZ4Sr46Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZnqCbULCQevrFv/B5YSxGwoBu9z9HzbBunC97BGheVU2J4m9qSP+N1IgynGqE+iuo
	 nn8dBKVjEVzr6JTn4KDWuUCRLGvCRj34HKuMyscTlvjVYrVcBuGtDc4yj+1CfXYvYU
	 Imk7GjX7NEjH1oZXxYbMCST9NJ3x/9wlM7vFfFKFHDZI0CjRiN0smlA8bku87YeNDE
	 4k97TO7gBix90gfkk8cUihmh+uRG8EnRg29ah2YrFEpSAOFyibSM/9H56BpVPy3Ms1
	 qlp1/QgERKmLPfComGndI5eT+kE43gyKQvAIhLsf885sRqWBDqQJ538Bn1PN2HdQj+
	 Z68FJeDaJxRuw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25c98395938so135859fac.3;
        Fri, 28 Jun 2024 11:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1zlvD0hMSchRoYYNVPbUjDtVGlBbt8aO31XA0Dq32vGzPZxTawtCe8v8bTBNryIwtLzlTDsmnJYH7IRPC+cmN/PdSwmO6nYzgAcg/4Z6IEDV7cuIegdBwuGWEbdUPR1i3XIWfC68=
X-Gm-Message-State: AOJu0YyG1lQpxlaiGfWPVWAeyE3EOZh9yzoawitbWumKP6Dt3qkO9rmo
	wNHjJXnXtLYKn/rl9BZ7EHAEi1B9ksGIXrqMl0+poiEUO5t/tud0CqfSU+0T9VHD0oL0TyD/RBY
	DQtWr5ATUfRy7AXJt5x9cQBk4Mvw=
X-Google-Smtp-Source: AGHT+IFavZi+phT1i/Y33ndVBo5RWqyyhymCCRWkZBya/izLWOy0ES7Nkokp23mNUk7SlmoXrW1bfLVhs9lijk0t9SA=
X-Received: by 2002:a05:6870:17a8:b0:254:7dbe:1b89 with SMTP id
 586e51a60fabf-25cf3c23288mr20251722fac.1.1719600962163; Fri, 28 Jun 2024
 11:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com> <CAJZ5v0iE_-eMi1JvWfDJM5-Z810WUdQPUoq9Qn8q62F5daXoSg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iE_-eMi1JvWfDJM5-Z810WUdQPUoq9Qn8q62F5daXoSg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 20:55:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOv26eWVFommYx-q=kOfadJjtA+ZWU-PBiypJkfbXXQA@mail.gmail.com>
Message-ID: <CAJZ5v0hOv26eWVFommYx-q=kOfadJjtA+ZWU-PBiypJkfbXXQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Update highest frequency of a CPU after boot
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: x86@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:04=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jun 24, 2024 at 6:11=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > Intel Xeon servers, which are capable of dynamic highest performance
> > change, are unable to achieve the highest frequency when the performanc=
e
> > profile is changed.
> >
> > The highest frequency at which a CPU can operate is not fixed and can
> > vary after the system boots. These changes can be initiated by switchin=
g
> > to different performance profiles using the Intel Speed Select Technolo=
gy
> > interface. Additionally, adjustments can be made remotely through a BMC
> > (Baseboard Management Controller) interface. Administrators can select
> > various performance profiles to align with specific performance
> > requirements, as these choices will directly influence the total power
> > consumption and cooling requirements.
> >
> > Whenever an administrator switches to a different performance profile t=
hat
> > alters the highest frequency, the hardware sends an interrupt and updat=
e
> > the new highest frequency at which the system can operate. This interru=
pt
> > can be enabled via the MSR_HWP_INTERRUPT register, and only if support =
is
> > indicated by the CPUID[6].EAX[15] =3D 1.
> >
> > To enable changes to the highest frequency, add a CPU features flag and
> > enable the HWP (Hardware P-states) highest performance change interrupt
> > when it is supported by the CPU.
> >
> > v2:
> > - Prevent display in /proc/cpuinfo flags
> > - Use cpu_feature_enabled() instead of boot_cpu_has()
> >
> > Srinivas Pandruvada (2):
> >   x86/cpufeatures: Add HWP highest perf change feature flag
> >   cpufreq: intel_pstate: Support highest performance change interrupt
> >
> >  arch/x86/include/asm/cpufeatures.h |  1 +
> >  drivers/cpufreq/intel_pstate.c     | 23 +++++++++++++++++++----
> >  2 files changed, 20 insertions(+), 4 deletions(-)
> >
> > --
>
> Please let me know if there are objections against this from the x86 angl=
e.
>
> If not, I'll pick it up.

Applied now, as 6.11 material.

Thanks!


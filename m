Return-Path: <linux-pm+bounces-24665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD397A76F21
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 22:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D946C188BF9E
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BBC2144C0;
	Mon, 31 Mar 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbtYkXt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5814D29B;
	Mon, 31 Mar 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452727; cv=none; b=t5m/mD3++B4n032CG47PCwHJuu6RDQJJr+1jFsSbdsBBHafn9VCYiymU8ASEf12iVUAOMyWt1H/JVbXi5N8f8DdMX/LL6tbiBMR6H7Q2oCs6x8dG2DVmHaQJ0jVxLYs84Q26lOW1uc8L7B4xUJtwt5fc4byLTwcWvyJpGXOrLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452727; c=relaxed/simple;
	bh=HIrTCApyUI6z9mNHfz/Tj6ozDxPQrbqQfpuGoqEqy8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pinogya9BvkmshmcLErAIrd4FMpvSupXqDjX1lrRad6tzjHybIPvxaj7quNKVPmVA6TCMPdJD9kU03HFkVA4XfXOipEy/CNpwUEE7ztS2RHinqjKVyhd6F3yr9xQsoK8mv+igam/uNQTbF0SmweYW7xMBI5feX4nWuVaSGbd7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbtYkXt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A7BC4CEEE;
	Mon, 31 Mar 2025 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452727;
	bh=HIrTCApyUI6z9mNHfz/Tj6ozDxPQrbqQfpuGoqEqy8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YbtYkXt0+2jTE/6nRB/szJIKDmcQTL1iUpBdG54Bw+A5fs5ibstBVSnOxkUuADwp3
	 GLnCaxJ7eOLa12HJDPOczF6EIzrS7YRJYIUb7LPy3yUrrLXgpxhJDp/2oV9uA2ZLy3
	 Oc3kj1+PUvB2cYWsK6+0/2miyMHOk6eSQuIcd+JJLo4owPJQAUllx6Hmt5OIcCZ7VG
	 YOfcK8u6XvKAEVUqqn7gVEcQyYc5yQ24Fy70b8jEUUQVrOfoCvGhFEpkxdQBdaISIo
	 yeCIfOLEaYsliw1pxISaUC5ymVKH45zY4t29AE3e3diHEfeuRLEVWI0oJA0AAHIhkz
	 QJ3Y2CilMP7hw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6028e5a45d7so395166eaf.1;
        Mon, 31 Mar 2025 13:25:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa9YQo19szZ+79jRRha9hrImlP8w0VVHsp1HRbsA99rIDO3NSPehKiaoClDo0eRqEaU8DI59lL@vger.kernel.org, AJvYcCVqa9at6fQy0eRNmExzgWvq+15QpgOM9v1mhhLDog8d22y00Q/D2j0NPfmhWRS9ga+o8K2YQO7MQ2Dot1U=@vger.kernel.org, AJvYcCXLA/2bD6vytfYw40QmIQxBamNgL1nmda5hcVNc9UmFaeu2kPKNlKYAM7lq2XTQVqG6lHrAQ6mMCw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5i/Y04Om0NFeSmboGJf31AA/aT64IbrU1LMcbkD9eEQKftiMA
	5ECet5LBadG7IORL7zh/y2xgVCvml3QFMt0aH5mLDol5YZuWt8GVek8ck19j3TCDPnrxKmlClUj
	mkJ3QiWAi07A68w7EB4LAbON3nhU=
X-Google-Smtp-Source: AGHT+IE2MnxYcEJPT7iTnc0xVnzAudkbexu5Aqgnz9oKUGGbqsjRUa8sEYypsTv5IKX8Hhj/ppZWLYejK5qggypnIV0=
X-Received: by 2002:a05:6870:be94:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2cbcf805f9fmr6504735fac.36.1743452726411; Mon, 31 Mar 2025
 13:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326062540.820556-1-xin@zytor.com> <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
 <148C8753-8972-4970-8951-E2D1CB26D8B0@zytor.com>
In-Reply-To: <148C8753-8972-4970-8951-E2D1CB26D8B0@zytor.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 22:25:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j+yxAPZE0eVqkrNjG2L-gZwndmW-0=Pjt9dgeTG7KKKQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrq30lwkTb_KiOVXJm-_hg25edEjHIRU-4WPLre4pYOSFiiRO7G2_gYicc
Message-ID: <CAJZ5v0j+yxAPZE0eVqkrNjG2L-gZwndmW-0=Pjt9dgeTG7KKKQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with
 FRED enabled
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, pavel@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, xi.pardee@intel.com, 
	todd.e.brandt@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 10:04=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On March 31, 2025 8:30:49 AM PDT, "Rafael J. Wysocki" <rafael@kernel.org>=
 wrote:
> >On Wed, Mar 26, 2025 at 7:26=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> w=
rote:
> >>
> >> During an S4 resume, the system first performs a cold power-on.  The
> >> kernel image is initially loaded to a random linear address, and the
> >> FRED MSRs are initialized.  Subsequently, the S4 image is loaded,
> >> and the kernel image is relocated to its original address from before
> >> the S4 suspend.  Due to changes in the kernel text and data mappings,
> >> the FRED MSRs must be reinitialized.
> >
> >To be precise, the above description of the hibernation control flow
> >doesn't exactly match the code.
> >
> >Yes, a new kernel is booted upon a wakeup from S4, but this is not "a
> >cold power-on", strictly speaking.  This kernel is often referred to
> >as the restore kernel and yes, it initializes the FRED MSRs as
> >appropriate from its perspective.
> >
> >Yes, it loads a hibernation image, including the kernel that was
> >running before hibernation, often referred to as the image kernel, but
> >it does its best to load image pages directly into the page frames
> >occupied by them before hibernation unless those page frames are
> >currently in use.  In that case, the given image pages are loaded into
> >currently free page frames, but they may or may not be part of the
> >image kernel (they may as well belong to user space processes that
> >were running before hibernation).  Yes, all of these pages need to be
> >moved to their original locations before the last step of restore,
> >which is a jump into a "trampoline" page in the image kernel, but this
> >is sort of irrelevant to the issue at hand.
> >
> >At this point, the image kernel has control, but the FRED MSRs still
> >contain values written to them by the restore kernel and there is no
> >guarantee that those values are the same as the ones written into them
> >by the image kernel before hibernation.  Thus the image kernel must
> >ensure that the values of the FRED MSRs will be the same as they were
> >before hibernation, and because they only depend on the location of
> >the kernel text and data, they may as well be recomputed from scratch.
> >
> >> Reported-by: Xi Pardee <xi.pardee@intel.com>
> >> Reported-and-Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> >> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> >> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> >> Cc: stable@kernel.org # 6.9+
> >> ---
> >>  arch/x86/power/cpu.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> >> index 63230ff8cf4f..ef3c152c319c 100644
> >> --- a/arch/x86/power/cpu.c
> >> +++ b/arch/x86/power/cpu.c
> >> @@ -27,6 +27,7 @@
> >>  #include <asm/mmu_context.h>
> >>  #include <asm/cpu_device_id.h>
> >>  #include <asm/microcode.h>
> >> +#include <asm/fred.h>
> >>
> >>  #ifdef CONFIG_X86_32
> >>  __visible unsigned long saved_context_ebx;
> >> @@ -231,6 +232,21 @@ static void notrace __restore_processor_state(str=
uct saved_context *ctxt)
> >>          */
> >>  #ifdef CONFIG_X86_64
> >>         wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
> >> +
> >> +       /*
> >> +        * Restore FRED configs.
> >> +        *
> >> +        * FRED configs are completely derived from current kernel tex=
t and
> >> +        * data mappings, thus nothing needs to be saved and restored.
> >> +        *
> >> +        * As such, simply re-initialize FRED to restore FRED configs.
> >
> >Instead of the above, I would just say "Reinitialize FRED to ensure
> >that the FRED registers contain the same values as before
> >hibernation."
> >
> >> +        *
> >> +        * Note, FRED RSPs setup needs to access percpu data structure=
s.
> >
> >And I'm not sure what you wanted to say here?  Does this refer to the
> >ordering of the code below or to something else?
> >
> >> +        */
> >> +       if (ctxt->cr4 & X86_CR4_FRED) {
> >> +               cpu_init_fred_exceptions();
> >> +               cpu_init_fred_rsps();
> >> +       }
> >>  #else
> >>         loadsegment(fs, __KERNEL_PERCPU);
> >>  #endif
> >> --
> >
>
> Just to make it clear: the patch is correct, the shortcoming is in the de=
scription.

Yes, the code changes in the patch are technically correct.

> I would say that Xin's description, although perhaps excessively brief, i=
s correct from the *hardware* point of view, whereas Rafael adds the much n=
eeded *software* perspective.
>
> As far as hardware is concerned, Linux S4 is just a power on (we don't us=
e any BIOS support for S4 even if it exists, which it rarely does anymore, =
and for very good reasons.) From a software point of view, it is more like =
a kexec into the frozen kernel image, which then has to re-establish its ru=
ntime execution environment =E2=80=93 (including the FRED state, which is w=
hat this patch does.)
>
> For the APs this is done through the normal AP bringup mechanism, it is o=
nly the BSP that needs special treatment.

That's correct.


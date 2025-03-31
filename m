Return-Path: <linux-pm+bounces-24659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A323DA76B18
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B13B520F
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D3202993;
	Mon, 31 Mar 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9D05Dud"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268831DE2C6;
	Mon, 31 Mar 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435062; cv=none; b=ovLSfumjUH1b7+Y2/EkIJT089fi8Mm/hN9MdQC3efpXBh6YERG2oOYoejS7wtAc9xIpSATvKxAW0qhy/E2ie3+w+KVft2G58X9ZOAN9WYg5gA2HrLRjln1WOBR0iaC5t44g6NEf0Lf8ElASHrCqmDJEc8qt00AgUPEL3EQp/rxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435062; c=relaxed/simple;
	bh=whtitelNaAooblrrzckEGZQfB+acI9Cqi1TP/G6isgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InFyi9Lrf1XrzcDqwjaIJ4zIFnIDyZkVDgw3cKoMhLzUEezmq1kBR2bG8TVvph8wg5STOH+D6e77gCAw7btxfecn5jxlDNAqATyk0uAX88+37tdltTavRaLP+ZUQLrU+2Ac6Yo67+yWsUpHRlxUJrrXLDN+Mewx+1vaVWqymGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9D05Dud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971CBC4CEF1;
	Mon, 31 Mar 2025 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435061;
	bh=whtitelNaAooblrrzckEGZQfB+acI9Cqi1TP/G6isgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W9D05DudV+pzA1YXiURdN2q0jrxpJdOdJu4nN4gM8eX/74+TSEK4Hm9OgUyfSsyxg
	 vRTtuGTb4X3lgQp1Adetwd3NJa+AwZ9E/aGPJGZE66P3uISoeJzwbp08+mHP+D/yTL
	 U9YfCaqnpY13UNgN1o1ioXugAXRuDW/ulmQGb/d6CaH2X/JtuiuOsmEpp6arkUgNEQ
	 4jMAS4gVBNdmywBkDNqfHf+XI1EWjgK46lihqukygJOEUC6N8QgGg9JVj/TFJ14Apb
	 MP6Ll/9WryeGkwJyM3H5geSRAG16H/Tp95Q2Sm/aJgz5iDtomsl1WaFdlaAVxAXzmx
	 J9pF3pxhFhr5g==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2b38896c534so2259455fac.0;
        Mon, 31 Mar 2025 08:31:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVS2pBU3Z/AYsqN36J88e5jnoht/w1gyx8qKzMIEVg91UYHWkB6TMuzFtYCcprLR8vbK413tyij@vger.kernel.org, AJvYcCX+8E2p+xistEf6+yvV0eze1xPi1r5Wtnve6Ci6MCDapKW3kNeqOjYmCRson5M1eR+27X1AOFl5ndEsz4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFE7VDVbSyC++itBhS3aj5bJbjkfafKrVmFNG+JtJ551xrSMvn
	+yZy/aHGJI/T8iHDlU8XiDQUKEqJS7Of1Tv1CCaxVblUdhkjjrsBFwGMRMtC7oClaWVjGtu9SX0
	txmmMu5F7omyxfHiqN01WcNMSykg=
X-Google-Smtp-Source: AGHT+IGIhIF5/6SVyhXhTrJaMpw0O3qhB7mWLJbgIhw7iYi1D92BKcwaBrqjP7yZF/1Fn8xURTuaIu8jiQ3gGE6nnQ0=
X-Received: by 2002:a05:6870:9b04:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2cbcf477387mr5238979fac.8.1743435060716; Mon, 31 Mar 2025
 08:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326062540.820556-1-xin@zytor.com>
In-Reply-To: <20250326062540.820556-1-xin@zytor.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 17:30:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoP08C2aBndYcbJxHvbMYDAZQGUQpcAem2TVzrVLICaeabG4u7JljIyEvI
Message-ID: <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with
 FRED enabled
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, rafael@kernel.org, pavel@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	xi.pardee@intel.com, todd.e.brandt@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:26=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrot=
e:
>
> During an S4 resume, the system first performs a cold power-on.  The
> kernel image is initially loaded to a random linear address, and the
> FRED MSRs are initialized.  Subsequently, the S4 image is loaded,
> and the kernel image is relocated to its original address from before
> the S4 suspend.  Due to changes in the kernel text and data mappings,
> the FRED MSRs must be reinitialized.

To be precise, the above description of the hibernation control flow
doesn't exactly match the code.

Yes, a new kernel is booted upon a wakeup from S4, but this is not "a
cold power-on", strictly speaking.  This kernel is often referred to
as the restore kernel and yes, it initializes the FRED MSRs as
appropriate from its perspective.

Yes, it loads a hibernation image, including the kernel that was
running before hibernation, often referred to as the image kernel, but
it does its best to load image pages directly into the page frames
occupied by them before hibernation unless those page frames are
currently in use.  In that case, the given image pages are loaded into
currently free page frames, but they may or may not be part of the
image kernel (they may as well belong to user space processes that
were running before hibernation).  Yes, all of these pages need to be
moved to their original locations before the last step of restore,
which is a jump into a "trampoline" page in the image kernel, but this
is sort of irrelevant to the issue at hand.

At this point, the image kernel has control, but the FRED MSRs still
contain values written to them by the restore kernel and there is no
guarantee that those values are the same as the ones written into them
by the image kernel before hibernation.  Thus the image kernel must
ensure that the values of the FRED MSRs will be the same as they were
before hibernation, and because they only depend on the location of
the kernel text and data, they may as well be recomputed from scratch.

> Reported-by: Xi Pardee <xi.pardee@intel.com>
> Reported-and-Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Cc: stable@kernel.org # 6.9+
> ---
>  arch/x86/power/cpu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 63230ff8cf4f..ef3c152c319c 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -27,6 +27,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/microcode.h>
> +#include <asm/fred.h>
>
>  #ifdef CONFIG_X86_32
>  __visible unsigned long saved_context_ebx;
> @@ -231,6 +232,21 @@ static void notrace __restore_processor_state(struct=
 saved_context *ctxt)
>          */
>  #ifdef CONFIG_X86_64
>         wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
> +
> +       /*
> +        * Restore FRED configs.
> +        *
> +        * FRED configs are completely derived from current kernel text a=
nd
> +        * data mappings, thus nothing needs to be saved and restored.
> +        *
> +        * As such, simply re-initialize FRED to restore FRED configs.

Instead of the above, I would just say "Reinitialize FRED to ensure
that the FRED registers contain the same values as before
hibernation."

> +        *
> +        * Note, FRED RSPs setup needs to access percpu data structures.

And I'm not sure what you wanted to say here?  Does this refer to the
ordering of the code below or to something else?

> +        */
> +       if (ctxt->cr4 & X86_CR4_FRED) {
> +               cpu_init_fred_exceptions();
> +               cpu_init_fred_rsps();
> +       }
>  #else
>         loadsegment(fs, __KERNEL_PERCPU);
>  #endif
> --


Return-Path: <linux-pm+bounces-24697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264CA77A14
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602733A0382
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF21E766E;
	Tue,  1 Apr 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UABBcv3N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96679476;
	Tue,  1 Apr 2025 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508315; cv=none; b=oMdUsbQRFg56Ex4qzfRdilMqltVpBSMAlFG7HbpGwHRFmg3ehgkgUvRBFDaN0zc9d5n8rQxkRqO3qqaP1fsHC4PcfFHih5e3BooZLrqJ/K8egY/VlzLbUhFeR0ccDaaFXTLUb5KQE7tpNJtU2yvkg24tu7VRSTiQboCwpsPQfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508315; c=relaxed/simple;
	bh=E+aYB8ocMdh2cBhiUzobqPIZzwXAJ/3ZPCQMLoddGjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4RsFB4COrZizE/Ca4e5AEb8Jm6It2kcI9kzbhV4PcY48r+2WnXQr2CUP3M0w8ccV2KrQ5Ic0VYvAaM2+HnUN3htdZc+GXZa+CJBt8MoVZaIEsnFetR8V5uSBDYx28omYoTy0fG0grhLw3tVO9R5RanMUc2DQ2L2Mz47SyHX1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UABBcv3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D75C4CEE8;
	Tue,  1 Apr 2025 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743508315;
	bh=E+aYB8ocMdh2cBhiUzobqPIZzwXAJ/3ZPCQMLoddGjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UABBcv3NrzktVMTtqvzxm3QMZPvFUVakwxGongmJO3GLk3MwHBU1mvBAaQPdVnl0j
	 JrjlPX/P6yGaIGwePJDz5O6nb0tQZb7UlK5ifl226N48TjhUGhWp8S6mBpcrdTEeVO
	 4MDT1x1ezh9vUKsiMmZZ/hWECjXZD7dtqJjxKwB1PVa9quV6miMIrHfINUj+PcB6Ot
	 NDpt1b5JtIeJR83ylovowynWdcekeqCHM665GvHmrNCFSDO3UOY7ri8onBX+JmWOHk
	 9hPlh3juk+j59AI6Wz8zGQhQvZVQk/aBc68er3yCJgL0CRNsvgUCoGQhaeR1iLCB35
	 X58D/Fz4t+7Gw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c81fffd523so1703448fac.0;
        Tue, 01 Apr 2025 04:51:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVipO+tVVSSTAF9IiAKA8wrQJ5JSRDVRGfd+3mVoScBy1BqMVrJ1F9DtIbDC4EZmJrf7qzxR0zFvTrelV4=@vger.kernel.org, AJvYcCWzbvUgRC6UXpU19/h0PFcLWtcrAZ+L20wYdqJrGiuxNcIsCOWIeQopGFv306ANmm8c/HOY4LzN@vger.kernel.org
X-Gm-Message-State: AOJu0YzL32TD6/HGYt+x1xNB+ZTpvg5Bs+hSUGd/Lm6qTJWLAv5vCoaP
	4IYCX57BjV+JyIGdKWfmU8RMF31AT1nmWjWUcBRtcLzOInEa7DrdZGjHMS8q6CoLWEg5ENMWsKL
	E8Ok/Wvr25C+aE6Q0dz1bdLH2hi8=
X-Google-Smtp-Source: AGHT+IFn6Bi+Dnctzh8KGZpcYIv+IQJGBcrY8EaGdyE5gFfCz0hm86z5KpV94NN/Wu3rjBA2PsRpNuD6A8MHac3owAQ=
X-Received: by 2002:a05:6871:82b:b0:29e:5e83:150e with SMTP id
 586e51a60fabf-2cbcf77437dmr5836423fac.27.1743508314455; Tue, 01 Apr 2025
 04:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401075728.3626147-1-xin@zytor.com>
In-Reply-To: <20250401075728.3626147-1-xin@zytor.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Apr 2025 13:51:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4_i7FyMi1gnZZ1ymi=SkAySpk28oWoitGo4BOt-Wsyg@mail.gmail.com>
X-Gm-Features: AQ5f1Jok1Tlzb8a-RMfEeGheQ4w5um035keyQcoquNa3nRQtyfJpYgCWyrRs4yY
Message-ID: <CAJZ5v0j4_i7FyMi1gnZZ1ymi=SkAySpk28oWoitGo4BOt-Wsyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/fred: Fix system hang during S4 resume with
 FRED enabled
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, rafael@kernel.org, pavel@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	brgerst@gmail.com, jgross@suse.com, torvalds@linux-foundation.org, 
	xi.pardee@intel.com, todd.e.brandt@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:57=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrote=
:
>
> Upon a wakeup from S4, the restore kernel starts and initializes the
> FRED MSRs as needed from its perspective.  It then loads a hibernation
> image, including the image kernel, and attempts to load image pages
> directly into their original page frames used before hibernation unless
> those frames are currently in use.  Once all pages are moved to their
> original locations, it jumps to a "trampoline" page in the image kernel.
>
> At this point, the image kernel takes control, but the FRED MSRs still
> contain values set by the restore kernel, which may differ from those
> set by the image kernel before hibernation.  Therefore, the image kernel
> must ensure the FRED MSRs have the same values as before hibernation.
> Since these values depend only on the location of the kernel text and
> data, they can be recomputed from scratch.
>
> Reported-by: Xi Pardee <xi.pardee@intel.com>
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@vger.kernel.org # 6.9+

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> Change in v2:
> * Rewrite the change log and in-code comments based on Rafael's feedback.

Thanks!

> ---
>  arch/x86/power/cpu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 63230ff8cf4f..08e76a5ca155 100644
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
> @@ -231,6 +232,19 @@ static void notrace __restore_processor_state(struct=
 saved_context *ctxt)
>          */
>  #ifdef CONFIG_X86_64
>         wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
> +
> +       /*
> +        * Reinitialize FRED to ensure the FRED MSRs contain the same val=
ues
> +        * as before hibernation.
> +        *
> +        * Note, the setup of FRED RSPs requires access to percpu data
> +        * structures.  Therefore, FRED reinitialization can only occur a=
fter
> +        * the percpu access pointer (i.e., MSR_GS_BASE) is restored.
> +        */
> +       if (ctxt->cr4 & X86_CR4_FRED) {
> +               cpu_init_fred_exceptions();
> +               cpu_init_fred_rsps();
> +       }
>  #else
>         loadsegment(fs, __KERNEL_PERCPU);
>  #endif
>
> base-commit: 535bd326c5657fe570f41b1f76941e449d9e2062
> --
> 2.49.0
>


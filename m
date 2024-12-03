Return-Path: <linux-pm+bounces-18478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23E9E231F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EA7166ACF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443B71F7566;
	Tue,  3 Dec 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWl6IF+P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143071F7557;
	Tue,  3 Dec 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239695; cv=none; b=lbvj0p3GwI3J0fdl9Vv5QvVdTsBX0kI20RwkgvBF1kzPqfrPNhm1z43LVxsqPYxw2upmoR1kY6STJNuM+cMZa73XNC6h63AmDTWG+dZuxmg+iOwB828p7I5OoC0UuSPnmq/XpXClhU+/1+q4W5Uk4dE4sX4ZSTVKq3TVSp6/99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239695; c=relaxed/simple;
	bh=N0BkY/ggH+tuVrewwwmwKP9Nf+Iv3TX+3MCwcoLII/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPPFvi5GdKIHomyy2kE0qlid+LhydfD6PmLezrXycZ/mjCa039heGOQoFC/mQOVP1QKd8ypoMTQOeWHRittlpfjumc4NQLGmfQKINdmODLRzd60jvL23SW0MmXOSyGrVBZPKSnB1p60tLJF3GGzXv9Mj87uPlLK0XBGudwOKYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWl6IF+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65CFC4CED8;
	Tue,  3 Dec 2024 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733239694;
	bh=N0BkY/ggH+tuVrewwwmwKP9Nf+Iv3TX+3MCwcoLII/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kWl6IF+PL/jW5gtC87aDjIqfmBIOq8mAVxVdB75oYAgao14c3KJmVPuAQsFCY7nCF
	 Sj82YOBr1WLj9MoH0kwg8uMS4SggJAH74i4LLk8R8qA1aQwLgjduXPNdFbp1ZYGlEe
	 692Tb1GdDXLLvXoowEQmJxhjjz0HSf0aLXHey4v6N2k5tXzSCZ4HUgb8mml2ZeNnvF
	 pTjM/UjBeyuc162YLyE1Eet69iTtumlyCtzWHkv0fdH2XB96sHqFRynQMXRwhoY8Jb
	 r7Er3eSyU3O992lF0Kup6xaEcnRq1zwgKmWADWLlQu8HJBNhoKPWn9fMqKmswInZ0i
	 hDnDXxWNmiRzw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so6525641e87.1;
        Tue, 03 Dec 2024 07:28:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1pKz22fCcHWkH64z9gc/LXUl73TwN7Yv/7dmBF8l2j353Y5LZV+Oi5X5kMYNztUg2/48875r8@vger.kernel.org, AJvYcCWoQ2TY7rhJuL7kFWTqPp/WnGl90XoMY7yMTR0KOPTCONdCS1NCyU4LWUauQmLQLqgBa6C7VlxZHlw=@vger.kernel.org, AJvYcCX3P/n50Uc68le8rjdLMT4Aazct0IFvFpsmKJ1OT7y3E9RrwVjEwd8lNpM3YCNVdLozIH3tEfS6rZtoqtNd@vger.kernel.org, AJvYcCX3Vu+1xewLIBhoLoHN6tpcMpncmR0Ox5U+rRJxsb16mRx1DeJBsWOqLOq2Ft8YGXmjXZlGRdmXrn4Pr34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwTK01D/9VWKaQcshE3kiM09M2tfMVHqb99CQi4eu+IU8ONKS
	8C2bk7bnCMnAEWdNgeI+4c6ZgpXSSL0rH7PFtUh/ckL0JINtZ3qUg7dJPasupJ67AODv0YsU10C
	UPM8Od0a46NZofEbxPTm9lQHs/QY=
X-Google-Smtp-Source: AGHT+IFbGc7Z55XjDY3dxgfRXS7E3uMfxtXjokd26/r3+Qtpz7UwIcGh3l41gXthpLrPGRCJfCAoo5M2nf1TrArtITU=
X-Received: by 2002:a05:6512:3b12:b0:53d:a86e:42d7 with SMTP id
 2adb3069b0e04-53e12a2e9dfmr1948992e87.49.1733239693443; Tue, 03 Dec 2024
 07:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128111844.GE10431@google.com> <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com> <87iks3wt2t.ffs@tglx> <CAK7LNARWpcbVsJFYCDN28vuuLfEibZmT+m5=qMEJcKD9Abzv4Q@mail.gmail.com>
 <87iks1vlu5.ffs@tglx>
In-Reply-To: <87iks1vlu5.ffs@tglx>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 4 Dec 2024 00:27:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARufW5wc=qBt5R=RJ9BkFirLKAgRgg_t=OmTTGbjLfsAg@mail.gmail.com>
Message-ID: <CAK7LNARufW5wc=qBt5R=RJ9BkFirLKAgRgg_t=OmTTGbjLfsAg@mail.gmail.com>
Subject: Re: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 20241015061522.25288-1-rui.zhang@intel.com, 
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com, peterz@infradead.org, 
	thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com, 
	len.brown@intel.com, srinivas.pandruvada@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, 
	x86@kernel.org, linux-pm@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:03=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Dec 02 2024 at 11:02, Masahiro Yamada wrote:
> > On Sun, Dec 1, 2024 at 8:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >>
> >> The compiler can fully inline the actual handler function of an interr=
upt
> >> entry into the .irqentry.text entry point. If such a function contains=
 an
> >> access which has an exception table entry, modpost complains about a
> >> section mismatch:
> >>
> >>   WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference=
 ...
> >>
> >>   The relocation at __ex_table+0x447c references section ".irqentry.te=
xt"
> >>   which is not in the list of authorized sections.
> >>
> >> Add .irqentry.text to OTHER_SECTIONS to cure the issue.
> >>
> >> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
> > I found the context in LKML.
> > Closes: https://lore.kernel.org/all/20241128111844.GE10431@google.com/
> >
> > However, is this still relevant to the mainline kernel?
> >
> > In Linux 5.4.y, I agree this because smp_apic_timer_interrupt()
> > is annotated as __irq_entry:
>
> Correct.
>
> > In this mainline kernel, DEFINE_IDTENTRY_SYSVEC()
> > expands to a normal .text function which is explicitly
> > annotated 'noinline'.
>
> It's not annotated noinline, it's annotated 'noinstr', which puts the
> code into the .noinstr.text section. That one is indeed covered.


The callsite of local_apic_timer_interrupt() is annotated 'noinline'
if I correctly understand this line:
  https://github.com/torvalds/linux/blob/v6.13-rc1/arch/x86/include/asm/idt=
entry.h#L272


It expands to:

static noinline void __sysvec_apic_timer_interrupt(struct pt_regs *regs)
{
       [snip]
       local_apic_timer_interrupt();
       [snip]
}



> So yes, the fix is only required for pre 5.8 kernels.

This never occurs on x86 after commit f0178fc01fe46,
but theoretically this may occur for other architectures.

Now applied to linux-kbuild.
Thanks.




>
> Thanks,
>
>         tglx



--=20
Best Regards
Masahiro Yamada


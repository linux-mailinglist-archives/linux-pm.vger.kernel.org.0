Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4263123D
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEaQX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 12:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfEaQX4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 12:23:56 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC3A26C05
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559319835;
        bh=efAbtd2ephq3ZJ+e75edZWXg5Ub9SkPbKyfyY9Hh5qU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1GTjQ4bKBpUZNLYNxsYoMB6gOI4xxNtlEBdDQatSNiGr5QltCyAtTw7ocauWoJQMc
         B2j4PF8Ub8RR61CwnLkYYYy+MwlnhexTDkEs0i+NJoVNFJdiGBas5sDhjrYbPhjpbO
         Haai5dz1o04iuV8JD9BE9hlgNbWGd0rg5yjc5MXU=
Received: by mail-wm1-f44.google.com with SMTP id t5so6305516wmh.3
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 09:23:54 -0700 (PDT)
X-Gm-Message-State: APjAAAWrDrvZIRMqiZE/X8uScRrqYghTZWeefhIHlZ7IoMxE0LVsC3FS
        h0o7sPqJSl/F93T7h3jK/oFpYisZPjtpTS7GZ9DYIg==
X-Google-Smtp-Source: APXvYqxZXzo/x+zipl4hnTwPXUOZvfyifCyETHcTpGpWwjYJHutyX2v/KLKuwXvBoO8UfHzJFsNQifVW3kxN18t73zk=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr6365439wmj.79.1559319833382;
 Fri, 31 May 2019 09:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
 <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm> <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
 <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 May 2019 09:23:41 -0700
X-Gmail-Original-Message-ID: <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com>
Message-ID: <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 7:54 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 31 May 2019, Andy Lutomirski wrote:
>
> > For that matter, what actually happens if we get an SMI while halted?
> > Does RSM go directly to sleep or does it re-fetch the HLT?
>
> Our mails just crossed, I replied to Josh's mwait() proposal patch a
> minute ago.
>
> HLT is guaranteed to be re-entered if SMM interrupted it, while MWAIT is
> not.
>
> So as a short-term fix for 5.2, I still believe in v4 of my patch that
> does the mwait->hlt->mwait transition across hibernate/resume, and for 5.=
3
> I can look into forcing it to wait-for-SIPI proper.
>

How sure are you?  From http://www.rcollins.org/ddj/Mar97/Mar97.html I see:

In general, the AutoHALT field directs the microprocessor whether or
not to restart the HLT instruction upon exit of SMM. This is
accomplished by decrementing EIP and executing whatever instruction
resides at that position. AutoHALT restart behavior is consistent,
regardless of whether or not EIP-1 contains a HLT instruction. If the
SMM handler set Auto HALT[bit0]=3D1 when the interrupted instruction was
not a HLT instruction(AutoHALT[bit0]=3D 0 upon entrance), they would run
the risk of resuming execution at an undesired location. The RSM
microcode doesn=E2=80=99t know the length of the interrupted instruction.
Therefore when AutoHALT[bit0]=3D1 upon exit, the RSM microcode blindly
decrements the EIP register by 1 and resumes execution. This explains
why Intel warns that unpredictable behavior may result from setting
this field to restart a HLT instruction when the microprocessor wasn=E2=80=
=99t
in a HALT state upon entrance. Listing One presents an algorithm that
describes the AutoHALT Restart feature.

The AMD APM says:

If the return from SMM takes the processor back to the halt state, the
HLT instruction is not re-
executed. However, the halt special bus-cycle is driven on the
processor bus after the RSM instruction
executes.

The Intel SDM Vol 3 34.10 says:

If the HLT instruction is restarted, the processor will generate a
memory access to fetch the HLT instruction (if it is
not in the internal cache), and execute a HLT bus transaction. This
behavior results in multiple HLT bus transactions
for the same HLT instruction.

And the SDM is very clear that one should *not* do RSM with auto-halt
set if the instruction that was interrupted wasn't HLT.

It sounds to me like Intel does not architecturally guarantee that
it's okay to do HLT from one CPU and then remove the HLT instruction
out from under it on another CPU.

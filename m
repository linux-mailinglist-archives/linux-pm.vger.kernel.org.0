Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD620A2794
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 22:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfH2UD2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 16:03:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37483 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2UD2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 16:03:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id f22so5396600edt.4
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYf/lCZC1gwMIR9/lhwT5M/JPgKzeUqjFNgwUcFRWFg=;
        b=U75GJORVMHIr0iUVnntJaP5CkG0L6J04X+1V/ZPN5uW3dQqnBj8pdaROlXs8b4Z1SG
         DR1yBHet2NvJnJhuzP0i5c/qQ5sBWpaG0KlB9URDDEL2UqurL8fMaEild5hR6irruZ3I
         WwlNUWnUuDyL8bRkDmAo8qYqSmnG/ayXfekSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYf/lCZC1gwMIR9/lhwT5M/JPgKzeUqjFNgwUcFRWFg=;
        b=cfv5vMJWhzZzQ4/gjQiR8vfn+AFQkdiCwl+vBrJYxh8KC+kp6mLU/QUimYhCG8t85P
         0IBr0dKtuUBcoHKdKXYFpQUhNc7aUjyznToVAAOLXzvtGxQPTBwN/iDZLj6Z8zSESjqK
         KFRrJNmPiaM1PdwMt/MW8MTLTv9FD3fYJSQUdNObCRim7C+CH0Xj4iU+bc0QtPzaAmXk
         wsNhdwnR/mOWgKLbId/2MbLKL1F0x1LKVQv5JPkOEfG0K6vlmXA4IDTupcJIa96hkuN3
         m1RlbRsvu4+DvCB+BYsflrLv8f2K7zlwkXiynDGjDCxWfbjZS2PcN10q01bmof5aV4nl
         +4HA==
X-Gm-Message-State: APjAAAVvEeAUbcYyx0q7XqUGH2MgGPT8k0fSHk+lDGjYBT0r63GsB201
        d6/zLmgNuT5X+lcl9bhL9SZMLaRFqdA=
X-Google-Smtp-Source: APXvYqzED6xAReLD2Cg+XBOJXY907fr+ZS3UcmITkV4ZbPyFR4w2IheUdPqwR/jBc2RSfrpMBeauew==
X-Received: by 2002:a50:9724:: with SMTP id c33mr12091047edb.193.1567109006668;
        Thu, 29 Aug 2019 13:03:26 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id w19sm615876edt.41.2019.08.29.13.03.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 13:03:26 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id z11so4686864wrt.4
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 13:03:26 -0700 (PDT)
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr13235010wrs.200.1567108513590;
 Thu, 29 Aug 2019 12:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190806154347.GD25897@zn.tnic> <20190806155034.GP2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190806155034.GP2349@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 29 Aug 2019 12:55:00 -0700
X-Gmail-Original-Message-ID: <CAJcbSZETvvQYmh6U_Oauptdsrp-emmSG_QsAZzKLv+0-b2Yxig@mail.gmail.com>
Message-ID: <CAJcbSZETvvQYmh6U_Oauptdsrp-emmSG_QsAZzKLv+0-b2Yxig@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 6, 2019 at 8:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 06, 2019 at 05:43:47PM +0200, Borislav Petkov wrote:
> > On Tue, Jul 30, 2019 at 12:12:44PM -0700, Thomas Garnier wrote:
> > > These patches make some of the changes necessary to build the kernel as
> > > Position Independent Executable (PIE) on x86_64. Another patchset will
> > > add the PIE option and larger architecture changes.
> >
> > Yeah, about this: do we have a longer writeup about the actual benefits
> > of all this and why we should take this all? After all, after looking
> > at the first couple of asm patches, it is posing restrictions to how
> > we deal with virtual addresses in asm (only RIP-relative addressing in
> > 64-bit mode, MOVs with 64-bit immediates, etc, for example) and I'm
> > willing to bet money that some future unrelated change will break PIE
> > sooner or later.

The goal is being able to extend the range of addresses where the
kernel can be placed with KASLR. I will look at clarifying that in the
future.

>
> Possibly objtool can help here; it should be possible to teach it about
> these rules, and then it will yell when violated. That should avoid
> regressions.
>

I will look into that as well.

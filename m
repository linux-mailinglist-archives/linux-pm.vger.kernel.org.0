Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1765826B0E6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIOWVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgIOWVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 18:21:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9580C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 15:21:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so2778294pfd.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxBRuw/C6HLU3Bd1Bhwg7UE2SLU/Bk+h9NyqyWyOoK0=;
        b=g7+9TPPxUqofAYywvWtgGzTXjsxcAxEvpCWnZyGAQNbc/8dBs01CYsIOgXSwDSfseo
         Dn+utEzxQFSmJXU/4xRl8s+PT4hymXCcErAn1yvB1F7uyjP+o1G5ZExkFkFmjFW4/JLl
         30mRAAXq05Nii8JCXx1PSXi6GtXQeiXcguUJgjud1qOfUbhA80KUa5Zjgb8Vy97nAe21
         CqWU4YmFD51/cm/ewnlrCG2kPuwj7M0V7YhRle6E+imkC9O/KNbh0Q2BJUJ+IBHFuExT
         yvbgEqyKMQbj9KSyLx+8vhEzWL1Ch3YCzfjs9mJ++Lhig/v8zK6XW15eAE9BFMiEaavl
         yqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxBRuw/C6HLU3Bd1Bhwg7UE2SLU/Bk+h9NyqyWyOoK0=;
        b=pU8Ij1ZHTaWN+4k0iuoyShGb6WXsW6dWLg2ZxpL9lHHHnWhDuC6NA2Iy7HE3mGm3PU
         dZFsKfNYT+YY3QnAsB2kVqCWw/kpBJjq0eFbPgjGbVFcgpt9vgRtljintgj4c0ztr9mM
         mgDeB231E/wzA3ZD2cGy+Sxjitu8miRAE/nlFQpToOKcyWDaPqSMRjd6I83zW+eNJUdx
         DRPmAeGUpzwWGecbFCGGZGpYhx49xN7rCD1paf8s09CIioUYJFV4Ok+hLNBWvusYoeLE
         zZZm2X0YbZDccph4QgXwPMlX20xuIXXXka+GyGTL2q3oshjilLiESrqxXVfW6Hv226kD
         01aQ==
X-Gm-Message-State: AOAM531MKNTESQtrDRXQz5+79GDngyeXIlIB2SlnYcXHl2Wo+k0b7hk/
        P7q0xDbDdWljz1OtF52OKaO+a00/iloW7NXVow+bug==
X-Google-Smtp-Source: ABdhPJzyLRSWjEyD5YYgopJuOjOrDt04aECFNOhGFss06tCpVTpKEtyQIVnBh++ONuR5z2bPjmnoXBpLDC7AKFC9ihY=
X-Received: by 2002:aa7:99c2:0:b029:142:440b:fa28 with SMTP id
 v2-20020aa799c20000b0290142440bfa28mr523449pfi.30.1600208498211; Tue, 15 Sep
 2020 15:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915221708.GA26453@duo.ucw.cz>
In-Reply-To: <20200915221708.GA26453@duo.ucw.cz>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 15:21:25 -0700
Message-ID: <CAKwvOdnuR9GF2tZuyS7Fe8i-S0W2YZ45qP8xJRm_gf+g+oF4=Q@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Pavel Machek <pavel@denx.de>
Cc:     Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 3:17 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Haitao Shan <hshan@google.com>
> >
> > This is a workaround which fixes triple fault
> > in __restore_processor_state on clang when
> > built with LTO.
> >
> > When load_TR_desc and load_mm_ldt are inlined into
> > fix_processor_context due to LTO, they cause
> > fix_processor_context (or in this case __restore_processor_state,
> > as fix_processor_context was inlined into __restore_processor_state)
> > to access the stack canary through %gs, but before
> > __restore_processor_state has restored the previous value
> > of %gs properly. LLVM appears to be inlining functions with stack
> > protectors into functions compiled with -fno-stack-protector,
> > which is likely a bug in LLVM's inliner that needs to be fixed.
>
> That's rather ugly.
>
> Would it be easier to simply mark those functions as noinline or
> something like that?

It is possible, and a possible solution here.  We discussed that
internally, and found it to not be great.  You only want to prevent
inlining across TUs for LTO; currently there's no great way to express
that in source code.  As in "go ahead and inline this from calls
within the TU that this is defined, but don't inline across TUs other
than from where the callee is defined."  I think we should create a
function level attribute for expressing that intention to the
compiler.  You could emulate that somewhat by wrapping the noinline
attribute in CONFIG_LTO_CLANG, but that doesn't solve allowing
inlining within the same TU.  If you've been following the thread,
there's multiple ways to skin this cat; your suggestion is one we did
consider, just not on the public mailing list.
-- 
Thanks,
~Nick Desaulniers

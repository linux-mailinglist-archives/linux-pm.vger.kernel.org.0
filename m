Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34696177AC8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgCCPnr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:43:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbgCCPnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:43:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id h62so4891241edd.12
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUChkrPr5ljfTasjojcfSOHYLssa67n/JsN8CgfdAHE=;
        b=K9XNUJGroYRdDR1ux6pXF7oQJcGzvpLxnCKPCsX26C0Tu9hC5HuWWrFU7srbEOJOL+
         Jk8ookxlAbji14BsL73PDTTF5eIJrpdAnDiCpyDiRGGvFozH6M+B80Uy/Fe1JxlrrsXH
         GRW1RIhoPUEdNvwHY5SmG3qe3uwWBJBypBRAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUChkrPr5ljfTasjojcfSOHYLssa67n/JsN8CgfdAHE=;
        b=CiUbZlcQvgHW/m43Z3vcugxOTKA3V7ubY/iaG8Uw6v9EVOnws3IRRyJ6ZGBAtzC4B9
         mdqQNWk35Lk7c1cDBtPtOM2J5SBKGewr8RzMawlPdQDH89ejldN5Mk1FvIREkPI8spT4
         5iLamMVE40+7oXmYVQTiQHuQQWdP3fQ9l6e7pxYKOoANHW36238dgOMP7Lg8WM0SYVfv
         LkYdPSTJoPDD9nSuBQH20pRgrwlPDa3OoysOROhxmRmqxxZaOiwoNIXM+aIW4L0W7tfc
         Q1NOrjzWcPTQUnz7YTA/jnWl4qcAxQ1ICE9qHf6Eg3YjdkFlHtgN/7rHH5RKemXG16g+
         d8bQ==
X-Gm-Message-State: ANhLgQ3xoPP6r5vi/kdHlSlu4/MtbyhSbYFN/Jde+J6UU3nNCfn65RF7
        dgcBAetQbO6MT+c950jGuCNVFq1s3vU=
X-Google-Smtp-Source: ADFU+vtYE6P3YOb7uJDHrzNRrfL45SHHON2N6LQ9V6I7jorD4fO0uScDrdMaeqPUlbCsnroKcyUKEA==
X-Received: by 2002:a17:906:1cd8:: with SMTP id i24mr4138255ejh.354.1583250225184;
        Tue, 03 Mar 2020 07:43:45 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id q5sm303300edw.34.2020.03.03.07.43.44
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:43:45 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 6so3779348wmi.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:43:44 -0800 (PST)
X-Received: by 2002:a7b:c416:: with SMTP id k22mr4837344wmi.88.1583250223087;
 Tue, 03 Mar 2020 07:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook> <20200303095514.GA2596@hirez.programming.kicks-ass.net>
In-Reply-To: <20200303095514.GA2596@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Tue, 3 Mar 2020 07:43:31 -0800
X-Gmail-Original-Message-ID: <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
Message-ID: <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
> > On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> > > Minor changes based on feedback and rebase from v10.
> > >
> > > Splitting the previous serie in two. This part contains assembly code
> > > changes required for PIE but without any direct dependencies with the
> > > rest of the patchset.
> > >
> > > Note: Using objtool to detect non-compliant PIE relocations is not yet
> > > possible as this patchset only includes the simplest PIE changes.
> > > Additional changes are needed in kvm, xen and percpu code.
> > >
> > > Changes:
> > >  - patch v11 (assembly);
> > >    - Fix comments on x86/entry/64.
> > >    - Remove KASLR PIE explanation on all commits.
> > >    - Add note on objtool not being possible at this stage of the patchset.
> >
> > This moves us closer to PIE in a clean first step. I think these patches
> > look good to go, and unblock the work in kvm, xen, and percpu code. Can
> > one of the x86 maintainers pick this series up?
>
> But,... do we still need this in the light of that fine-grained kaslr
> stuff?
>
> What is the actual value of this PIE crud in the face of that?

If I remember well, it makes it easier/better but I haven't seen a
recent update on that. Is that accurate Kees?

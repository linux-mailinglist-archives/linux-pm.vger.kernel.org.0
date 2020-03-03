Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19167176E42
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 06:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgCCFCS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 00:02:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38499 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgCCFCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 00:02:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id p7so760467pli.5
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2020 21:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q35xHdWKJJDozqgC+DE0AkepRfor0WoHxwu3tIn+R2o=;
        b=eM1bRdtSZ21RFCiu3jUoxsurIubkaafgJWUsxzqiQyxFo7G2KBL2RG/I/wfAF1UYea
         Xddni38mDnMFm2IKvCz4VSolutjZv4ttQqpL+flyNOMJA62Ny43fYEbLDP6dNZ32iYUY
         8v23/qNQpbLvAQG60wWdJDvpXEeqSQ62YQm+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q35xHdWKJJDozqgC+DE0AkepRfor0WoHxwu3tIn+R2o=;
        b=aGsqynVT1ZkY28lEMGXWa3t7pwBzZ4+9fTj9J1TTOVs0KEImzcve9/OO0Suk1rJg35
         L01fjuxKX+mGWametkOkE8BfOagPR6Mg9w0eRf7/BXUm4oXqSC8QnolBACjWIT8FV5ga
         x98OF8OKYKVxp6n1JrXnvx06QDxCJM1Ywj1scftgGiut3MDYdPJc7wpOJIV3mJCetODc
         eSkje4DRtUfFnOlR+hGazHecb9+0z0+YcKFdtH32xdtS0f0N1npn2xLaCM+FnimYlqTg
         IqWtX3GFNluniegXeR4e3yG5gXeE1R9YNQliTIileezkG0ZeFS1YVNxb8bTC2bHq4WXR
         MBZg==
X-Gm-Message-State: ANhLgQ2Mk0hvTwGZJeRa6xP6L4BNIx+iQERUyTsgQzmdyF76MzKFG+iL
        DrAtgC1w9E8hvmdaQijtfv/F2g==
X-Google-Smtp-Source: ADFU+vvEQbUyygn93oWCIMo6EP7RE0Je117ZwkjgVdAneWftAbKV9R8PWH6lnNIep/0z+sFWAbUeBA==
X-Received: by 2002:a17:90a:5d97:: with SMTP id t23mr2156642pji.61.1583211737104;
        Mon, 02 Mar 2020 21:02:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w17sm22267976pfi.56.2020.03.02.21.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 21:02:16 -0800 (PST)
Date:   Mon, 2 Mar 2020 21:02:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <202003022100.54CEEE60F@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> Minor changes based on feedback and rebase from v10.
> 
> Splitting the previous serie in two. This part contains assembly code
> changes required for PIE but without any direct dependencies with the
> rest of the patchset.
> 
> Note: Using objtool to detect non-compliant PIE relocations is not yet
> possible as this patchset only includes the simplest PIE changes.
> Additional changes are needed in kvm, xen and percpu code.
> 
> Changes:
>  - patch v11 (assembly);
>    - Fix comments on x86/entry/64.
>    - Remove KASLR PIE explanation on all commits.
>    - Add note on objtool not being possible at this stage of the patchset.

This moves us closer to PIE in a clean first step. I think these patches
look good to go, and unblock the work in kvm, xen, and percpu code. Can
one of the x86 maintainers pick this series up?

Thanks!

-Kees

>  - patch v10 (assembly):
>    - Swap rax for rdx on entry/64 changes based on feedback.
>    - Addressed feedback from Borislav Petkov on boot, paravirt, alternatives
>      and globally.
>    - Rebased the patchset and ensure it works with large kaslr (not included).
>  - patch v9 (assembly):
>    - Moved to relative reference for sync_core based on feedback.
>    - x86/crypto had multiple algorithms deleted, removed PIE changes to them.
>    - fix typo on comment end line.
>  - patch v8 (assembly):
>    - Fix issues in crypto changes (thanks to Eric Biggers).
>    - Remove unnecessary jump table change.
>    - Change author and signoff to chromium email address.
>  - patch v7 (assembly):
>    - Split patchset and reorder changes.
>  - patch v6:
>    - Rebase on latest changes in jump tables and crypto.
>    - Fix wording on couple commits.
>    - Revisit checkpatch warnings.
>    - Moving to @chromium.org.
>  - patch v5:
>    - Adapt new crypto modules for PIE.
>    - Improve per-cpu commit message.
>    - Fix xen 32-bit build error with .quad.
>    - Remove extra code for ftrace.
>  - patch v4:
>    - Simplify early boot by removing global variables.
>    - Modify the mcount location script for __mcount_loc intead of the address
>      read in the ftrace implementation.
>    - Edit commit description to explain better where the kernel can be located.
>    - Streamlined the testing done on each patch proposal. Always testing
>      hibernation, suspend, ftrace and kprobe to ensure no regressions.
>  - patch v3:
>    - Update on message to describe longer term PIE goal.
>    - Minor change on ftrace if condition.
>    - Changed code using xchgq.
>  - patch v2:
>    - Adapt patch to work post KPTI and compiler changes
>    - Redo all performance testing with latest configs and compilers
>    - Simplify mov macro on PIE (MOVABS now)
>    - Reduce GOT footprint
>  - patch v1:
>    - Simplify ftrace implementation.
>    - Use gcc mstack-protector-guard-reg=%gs with PIE when possible.
>  - rfc v3:
>    - Use --emit-relocs instead of -pie to reduce dynamic relocation space on
>      mapped memory. It also simplifies the relocation process.
>    - Move the start the module section next to the kernel. Remove the need for
>      -mcmodel=large on modules. Extends module space from 1 to 2G maximum.
>    - Support for XEN PVH as 32-bit relocations can be ignored with
>      --emit-relocs.
>    - Support for GOT relocations previously done automatically with -pie.
>    - Remove need for dynamic PLT in modules.
>    - Support dymamic GOT for modules.
>  - rfc v2:
>    - Add support for global stack cookie while compiler default to fs without
>      mcmodel=kernel
>    - Change patch 7 to correctly jump out of the identity mapping on kexec load
>      preserve.
> 
> These patches make some of the changes necessary to build the kernel as
> Position Independent Executable (PIE) on x86_64. Another patchset will
> add the PIE option and larger architecture changes. PIE allows the kernel to be
> placed below the 0xffffffff80000000 increasing the range of KASLR.
> 
> The patches:
>  - 1, 3-11: Change in assembly code to be PIE compliant.
>  - 2: Add a new _ASM_MOVABS macro to fetch a symbol address generically.
> 
> diffstat:
>  crypto/aegis128-aesni-asm.S         |    6 +-
>  crypto/aesni-intel_asm.S            |    8 +--
>  crypto/aesni-intel_avx-x86_64.S     |    3 -
>  crypto/camellia-aesni-avx-asm_64.S  |   42 +++++++--------
>  crypto/camellia-aesni-avx2-asm_64.S |   44 ++++++++--------
>  crypto/camellia-x86_64-asm_64.S     |    8 +--
>  crypto/cast5-avx-x86_64-asm_64.S    |   50 ++++++++++--------
>  crypto/cast6-avx-x86_64-asm_64.S    |   44 +++++++++-------
>  crypto/des3_ede-asm_64.S            |   96 ++++++++++++++++++++++++------------
>  crypto/ghash-clmulni-intel_asm.S    |    4 -
>  crypto/glue_helper-asm-avx.S        |    4 -
>  crypto/glue_helper-asm-avx2.S       |    6 +-
>  crypto/sha256-avx2-asm.S            |   18 ++++--
>  entry/entry_64.S                    |   16 ++++--
>  include/asm/alternative.h           |    6 +-
>  include/asm/asm.h                   |    1 
>  include/asm/bug.h                   |    2 
>  include/asm/paravirt_types.h        |   32 ++++++++++--
>  include/asm/pm-trace.h              |    2 
>  include/asm/processor.h             |    6 +-
>  kernel/acpi/wakeup_64.S             |   31 ++++++-----
>  kernel/head_64.S                    |   15 +++--
>  kernel/relocate_kernel_64.S         |    2 
>  power/hibernate_asm_64.S            |    4 -
>  24 files changed, 268 insertions(+), 182 deletions(-)
> 
> Patchset is based on next-20200227.
> 
> 

-- 
Kees Cook

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD5209E6C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404610AbgFYM16 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 08:27:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43781 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404630AbgFYM15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 08:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593088075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/icW62T4HUCwgSKZakwjRQ1z0NoKU4sAPE7i/iVWfo=;
        b=B+t6nj1qL9xhMCJXWWghpeSVqbQ1+xgQtwTY7DtfnsoFM+31v7BZkOUI99W7G7mOMmodr1
        V9ibn6VJIG0FRIJS3EPq/LeOquDBBRYbmOjb+rSnKSzL9boFNUiHkT9rv3qaGBC2Sj9WIp
        rA0lwt2tW2TeARzJK8QI5aFVq2BkOME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-C5LbrgYXMsybLOKDlz4mdg-1; Thu, 25 Jun 2020 08:27:52 -0400
X-MC-Unique: C5LbrgYXMsybLOKDlz4mdg-1
Received: by mail-wr1-f71.google.com with SMTP id 59so40240wrp.4
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 05:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/icW62T4HUCwgSKZakwjRQ1z0NoKU4sAPE7i/iVWfo=;
        b=Fes5+uyfLKVHAKTJ3lJZpEVtmEQbkJK9PM8R/V6bPGmfvoGgCpoe5dHzmBYWolmPYg
         pduVqM4MDsyyXut/imUeL919qmezlD4FLmuK5B4IX3OkvrT7SVsRMevclC0hduf+IHHn
         ckMKzeZ+5v/qolNgCsCXwbx8C+A5rD3LlIzZdKgnrOvgMMhBu7MAq7rMTLaDMY6YBNbk
         LcLWuus+bi2aIreKUsnTQEatQhADOVYDdbHjtXN9NsCVzqE40l009KDv2QEimIZibj4u
         JUaF9/iw2NF9lZKXVKvKCWUGQ+2l7pdyG0jNdGkLuVU4+vFX/sm7BLww7EYcmLHfxrbD
         r3GQ==
X-Gm-Message-State: AOAM533wqz6XSfNKyLuyQWWn3JfWxKACEDhR1HZBXh/JXD3vBHY5pVJH
        9nug+bTOvEq7QfpDK0mrKQD43j7AmTn266M8tAjdG9+p324gMUGzloY33d6hMoZLaNIffDlH8Rb
        TFSbdHrFRHy3mh3XsZRM=
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr9096777wre.260.1593088070568;
        Thu, 25 Jun 2020 05:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxllhAQRLAR9I9dtDG8whn5hCHq7QeFhyH3PL95QcplZ/bHbi4Ic9wL0R+tysHRbldN2Fn3Q==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr9096750wre.260.1593088070290;
        Thu, 25 Jun 2020 05:27:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80? ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
        by smtp.gmail.com with ESMTPSA id t5sm11697507wmj.37.2020.06.25.05.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:27:49 -0700 (PDT)
Subject: Re: [PATCH v2] x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during
 wakeup
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        kvm-devel <kvm@vger.kernel.org>
References: <20200608174134.11157-1-sean.j.christopherson@intel.com>
 <CAJZ5v0inhpW1vbYJYPqWgkekK7hKhgO_fE5JmemT+p2qh7RFaw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a3976ac-242b-260a-ce7b-2080d8e9d0f8@redhat.com>
Date:   Thu, 25 Jun 2020 14:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0inhpW1vbYJYPqWgkekK7hKhgO_fE5JmemT+p2qh7RFaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/06/20 14:06, Rafael J. Wysocki wrote:
> On Mon, Jun 8, 2020 at 7:49 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
>>
>> Reinitialize IA32_FEAT_CTL on the BSP during wakeup to handle the case
>> where firmware doesn't initialize or save/restore across S3.  This fixes
>> a bug where IA32_FEAT_CTL is left uninitialized and results in VMXON
>> taking a #GP due to VMX not being fully enabled, i.e. breaks KVM.
>>
>> Use init_ia32_feat_ctl() to "restore" IA32_FEAT_CTL as it already deals
>> with the case where the MSR is locked, and because APs already redo
>> init_ia32_feat_ctl() during suspend by virtue of the SMP boot flow being
>> used to reinitialize APs upon wakeup.  Do the call in the early wakeup
>> flow to avoid dependencies in the syscore_ops chain, e.g. simply adding
>> a resume hook is not guaranteed to work, as KVM does VMXON in its own
>> resume hook, kvm_resume(), when KVM has active guests.
>>
>> Reported-by: Brad Campbell <lists2009@fnarfbargle.com>
>> Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Cc: stable@vger.kernel.org # v5.6
>> Fixes: 21bd3467a58e ("KVM: VMX: Drop initialization of IA32_FEAT_CTL MSR")
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Given the regression fix nature of this patch, is it being taken care
> of by anyone (tip in particular) already?

I was waiting for tip to pick it up, but I can as well with an Acked-by
(KVM is broken by the patch but there's nothing KVM specific in it).

Paolo

>> ---
>>
>> v2:
>>   - Collect Reviewed/Tested tags. [Brad, Liam, Maxim].
>>   - Include asm/cpu.h to fix Zhaoxin and Centaur builds. [Brad, LKP]
>>   - Add Cc to stable. [Liam]
>>
>>  arch/x86/include/asm/cpu.h    | 5 +++++
>>  arch/x86/kernel/cpu/centaur.c | 1 +
>>  arch/x86/kernel/cpu/cpu.h     | 4 ----
>>  arch/x86/kernel/cpu/zhaoxin.c | 1 +
>>  arch/x86/power/cpu.c          | 6 ++++++
>>  5 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
>> index dd17c2da1af5..da78ccbd493b 100644
>> --- a/arch/x86/include/asm/cpu.h
>> +++ b/arch/x86/include/asm/cpu.h
>> @@ -58,4 +58,9 @@ static inline bool handle_guest_split_lock(unsigned long ip)
>>         return false;
>>  }
>>  #endif
>> +#ifdef CONFIG_IA32_FEAT_CTL
>> +void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
>> +#else
>> +static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
>> +#endif
>>  #endif /* _ASM_X86_CPU_H */
>> diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
>> index 426792565d86..c5cf336e5077 100644
>> --- a/arch/x86/kernel/cpu/centaur.c
>> +++ b/arch/x86/kernel/cpu/centaur.c
>> @@ -3,6 +3,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/sched/clock.h>
>>
>> +#include <asm/cpu.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/e820/api.h>
>>  #include <asm/mtrr.h>
>> diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
>> index 37fdefd14f28..38ab6e115eac 100644
>> --- a/arch/x86/kernel/cpu/cpu.h
>> +++ b/arch/x86/kernel/cpu/cpu.h
>> @@ -80,8 +80,4 @@ extern void x86_spec_ctrl_setup_ap(void);
>>
>>  extern u64 x86_read_arch_cap_msr(void);
>>
>> -#ifdef CONFIG_IA32_FEAT_CTL
>> -void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
>> -#endif
>> -
>>  #endif /* ARCH_X86_CPU_H */
>> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
>> index df1358ba622b..05fa4ef63490 100644
>> --- a/arch/x86/kernel/cpu/zhaoxin.c
>> +++ b/arch/x86/kernel/cpu/zhaoxin.c
>> @@ -2,6 +2,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/sched/clock.h>
>>
>> +#include <asm/cpu.h>
>>  #include <asm/cpufeature.h>
>>
>>  #include "cpu.h"
>> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
>> index aaff9ed7ff45..b0d3c5ca6d80 100644
>> --- a/arch/x86/power/cpu.c
>> +++ b/arch/x86/power/cpu.c
>> @@ -193,6 +193,8 @@ static void fix_processor_context(void)
>>   */
>>  static void notrace __restore_processor_state(struct saved_context *ctxt)
>>  {
>> +       struct cpuinfo_x86 *c;
>> +
>>         if (ctxt->misc_enable_saved)
>>                 wrmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
>>         /*
>> @@ -263,6 +265,10 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>>         mtrr_bp_restore();
>>         perf_restore_debug_store();
>>         msr_restore_context(ctxt);
>> +
>> +       c = &cpu_data(smp_processor_id());
>> +       if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
>> +               init_ia32_feat_ctl(c);
>>  }
>>
>>  /* Needed by apm.c */
>> --
>> 2.26.0
>>
> 


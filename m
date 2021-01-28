Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9513073D7
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhA1Kff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 05:35:35 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36274 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhA1Kfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 05:35:31 -0500
Received: by mail-ot1-f41.google.com with SMTP id d7so4702149otf.3;
        Thu, 28 Jan 2021 02:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eM3bLsjxVdhKVCPZibScqY9Yi+rfdugDa6YasYlA1c0=;
        b=df5pj9YWGMli/f9jtgiRKQOhfR6TP1+cCtomUL4SNPdwh0oHvirBsHM2R3BMKVgf/7
         aRQhT4jQkHHcogMjaoo0JnvtCXSDiNdP9M7CRnOAXzKTnnca73RpSIB2LyzmxKFzxK6d
         mUJ5CzMALXu/1V+jjP1FqD1Bq9q5wRyHulD6YzpMGEbYkTMxsp5/OiyHah8VDtJEkn23
         E76koaxe/HvFdUvo0Z2t6+115Y8fURpLuLLRERG+d3ZOvcGitAuthB+unVxxmtu3HAnj
         R/0uPsHAtTa5wkQYnOKCR6RDCArDRcnxIZXk2ZxfcM6MIZXbcPypD+hPN91Pp7K3ndWC
         lRGw==
X-Gm-Message-State: AOAM533iGip/FhzW7cl+Fs1B0+yOZ5pQyPIJ0Wp8h96mqzWxzxPmPBKZ
        Zp4C5Ew3+YktHRRdRzH+e6pbQjw5x9UQ2elrhiM=
X-Google-Smtp-Source: ABdhPJwhQjZGqoMXVX4zZgO1PB2TaI23c2MiN2Qhoom2AcJ9upK8mtWpdybJ+4E15R5cpHWaVEVKP3v0VxTN+lEbRbc=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr11144610ote.321.1611830089890;
 Thu, 28 Jan 2021 02:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20201216174146.10446-1-chang.seok.bae@intel.com> <20201216174146.10446-5-chang.seok.bae@intel.com>
In-Reply-To: <20201216174146.10446-5-chang.seok.bae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Jan 2021 11:34:36 +0100
Message-ID: <CAJZ5v0jbz16DQg6CZr1hp-ZgUJ6gJOw=4AUaGeqeUk2UD7U_Fw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from
 the ACPI S3/4 sleep states
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ning Sun <ning.sun@intel.com>, kumar.n.dwarakanath@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 16, 2020 at 6:47 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> When the system state switches to these sleep states, the internal key gets
> reset. Since this system transition is transparent to userspace, the
> internal key needs to be restored properly.
>
> Key Locker provides a mechanism to back up the internal key in non-volatile
> memory. The kernel requests a backup right after the key loaded at
> boot-time and copies it later when the system wakes up.
>
> The backup during the S5 sleep state is not trusted. It is overwritten by a
> new key at the next boot.
>
> On a system with the S3/4 states, enable the feature only when the backup
> mechanism is supported.
>
> Disable the feature when the copy fails (or the backup corrupts). The
> shutdown is considered too noisy. A new key is considerable only when
> threads can be synchronously suspended.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  arch/x86/include/asm/keylocker.h | 12 ++++++++
>  arch/x86/kernel/cpu/common.c     | 25 +++++++++++-----
>  arch/x86/kernel/keylocker.c      | 51 ++++++++++++++++++++++++++++++++
>  arch/x86/power/cpu.c             | 34 +++++++++++++++++++++
>  4 files changed, 115 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
> index daf0734a4095..722574c305c2 100644
> --- a/arch/x86/include/asm/keylocker.h
> +++ b/arch/x86/include/asm/keylocker.h
> @@ -6,6 +6,7 @@
>  #ifndef __ASSEMBLY__
>
>  #include <linux/bits.h>
> +#include <asm/msr.h>
>
>  #define KEYLOCKER_CPUID                0x019
>  #define KEYLOCKER_CPUID_EAX_SUPERVISOR BIT(0)
> @@ -25,5 +26,16 @@ void invalidate_keylocker_data(void);
>  #define invalidate_keylocker_data() do { } while (0)
>  #endif
>
> +static inline u64 read_keylocker_backup_status(void)
> +{
> +       u64 status;
> +
> +       rdmsrl(MSR_IA32_IWKEYBACKUP_STATUS, status);
> +       return status;
> +}
> +
> +void backup_keylocker(void);
> +bool copy_keylocker(void);
> +
>  #endif /*__ASSEMBLY__ */
>  #endif /* _ASM_KEYLOCKER_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index d675075848bb..a446d5aff08f 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -463,24 +463,35 @@ __setup("nofsgsbase", x86_nofsgsbase_setup);
>
>  static __always_inline void setup_keylocker(struct cpuinfo_x86 *c)
>  {
> -       bool keyloaded;
> -
>         if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
>                 goto out;
>
>         cr4_set_bits(X86_CR4_KEYLOCKER);
>
>         if (c == &boot_cpu_data) {
> +               bool keyloaded;
> +
>                 if (!check_keylocker_readiness())
>                         goto disable_keylocker;
>
>                 make_keylocker_data();
> -       }
>
> -       keyloaded = load_keylocker();
> -       if (!keyloaded) {
> -               pr_err_once("x86/keylocker: Failed to load internal key\n");
> -               goto disable_keylocker;
> +               keyloaded = load_keylocker();
> +               if (!keyloaded) {
> +                       pr_err("x86/keylocker: Fail to load internal key\n");
> +                       goto disable_keylocker;
> +               }
> +
> +               backup_keylocker();
> +       } else {
> +               bool keycopied;
> +
> +               /* NB: When system wakes up, this path recovers the internal key. */
> +               keycopied = copy_keylocker();
> +               if (!keycopied) {
> +                       pr_err_once("x86/keylocker: Fail to copy internal key\n");
> +                       goto disable_keylocker;
> +               }
>         }
>
>         pr_info_once("x86/keylocker: Activated\n");
> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
> index e455d806b80c..229875ac80d5 100644
> --- a/arch/x86/kernel/keylocker.c
> +++ b/arch/x86/kernel/keylocker.c
> @@ -5,11 +5,15 @@
>   */
>
>  #include <linux/random.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
>
>  #include <asm/keylocker.h>
>  #include <asm/fpu/types.h>
>  #include <asm/fpu/api.h>
>
> +static bool keybackup_available;
> +
>  bool check_keylocker_readiness(void)
>  {
>         u32 eax, ebx, ecx, edx;
> @@ -21,6 +25,14 @@ bool check_keylocker_readiness(void)
>                 return false;
>         }
>
> +       keybackup_available = (ebx & KEYLOCKER_CPUID_EBX_BACKUP);
> +       /* Internal Key backup is essential with S3/4 states */
> +       if (!keybackup_available &&
> +           (acpi_sleep_state_supported(ACPI_STATE_S3) ||
> +            acpi_sleep_state_supported(ACPI_STATE_S4))) {
> +               pr_debug("x86/keylocker: no key backup support with possible S3/4\n");
> +               return false;
> +       }
>         return true;
>  }
>
> @@ -29,6 +41,7 @@ bool check_keylocker_readiness(void)
>  #define LOADIWKEY_NUM_OPERANDS 3
>
>  static struct key {
> +       bool valid;
>         struct reg_128_bit value[LOADIWKEY_NUM_OPERANDS];
>  } keydata;
>
> @@ -38,11 +51,15 @@ void make_keylocker_data(void)
>
>         for (i = 0; i < LOADIWKEY_NUM_OPERANDS; i++)
>                 get_random_bytes(&keydata.value[i], sizeof(struct reg_128_bit));
> +
> +       keydata.valid = true;
>  }
>
>  void invalidate_keylocker_data(void)
>  {
>         memset(&keydata.value, 0, sizeof(struct reg_128_bit) * LOADIWKEY_NUM_OPERANDS);
> +
> +       keydata.valid = false;
>  }
>
>  #define USE_SWKEY      0
> @@ -69,3 +86,37 @@ bool load_keylocker(void)
>
>         return err ? false : true;
>  }
> +
> +void backup_keylocker(void)
> +{
> +       if (keybackup_available)
> +               wrmsrl(MSR_IA32_COPY_LOCAL_TO_PLATFORM, 1);
> +}
> +
> +#define KEYRESTORE_RETRY       1
> +
> +bool copy_keylocker(void)
> +{
> +       bool copied = false;
> +       int i;
> +
> +       /* Use valid key data when available */
> +       if (keydata.valid)
> +               return load_keylocker();
> +
> +       if (!keybackup_available)
> +               return copied;
> +
> +       wrmsrl(MSR_IA32_COPY_PLATFORM_TO_LOCAL, 1);
> +
> +       for (i = 0; (i <= KEYRESTORE_RETRY) && !copied; i++) {
> +               u64 status;
> +
> +               if (i)
> +                       udelay(1);
> +               rdmsrl(MSR_IA32_COPY_STATUS, status);
> +               copied = status & BIT(0) ? true : false;
> +       }
> +
> +       return copied;
> +}
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index db1378c6ff26..5412440e7c5c 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -25,6 +25,7 @@
>  #include <asm/cpu.h>
>  #include <asm/mmu_context.h>
>  #include <asm/cpu_device_id.h>
> +#include <asm/keylocker.h>
>
>  #ifdef CONFIG_X86_32
>  __visible unsigned long saved_context_ebx;
> @@ -57,6 +58,38 @@ static void msr_restore_context(struct saved_context *ctxt)
>         }
>  }
>
> +/*
> + * The boot CPU executes this function, while other CPUs restore the key
> + * through the setup path in setup_keylocker().
> + */
> +static void restore_keylocker(void)
> +{
> +       u64 keybackup_status;
> +       bool keycopied;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
> +               return;
> +
> +       keybackup_status = read_keylocker_backup_status();
> +       if (!(keybackup_status & BIT(0))) {
> +               pr_err("x86/keylocker: internal key restoration failed with %s\n",
> +                      (keybackup_status & BIT(2)) ? "read error" : "invalid status");
> +               WARN_ON(1);
> +               goto disable_keylocker;
> +       }

The above conditional could be consolidated a bit by using WARN():

if (WARN(!(keybackup_status & BIT(0)), "x86/keylocker: internal key
restoration failed with %s\n",
        (keybackup_status & BIT(2)) ? "read error" : "invalid status")
                goto disable_keylocker;

Apart from this the patch LGTM.

Thanks!

> +
> +       keycopied = copy_keylocker();
> +       if (keycopied)
> +               return;
> +
> +       pr_err("x86/keylocker: internal key copy failure\n");
> +
> +disable_keylocker:
> +       pr_info("x86/keylocker: Disabled with internal key restoration failure\n");
> +       setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
> +       cr4_clear_bits(X86_CR4_KEYLOCKER);
> +}
> +
>  /**
>   *     __save_processor_state - save CPU registers before creating a
>   *             hibernation image and before restoring the memory state from it
> @@ -265,6 +298,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>         mtrr_bp_restore();
>         perf_restore_debug_store();
>         msr_restore_context(ctxt);
> +       restore_keylocker();
>
>         c = &cpu_data(smp_processor_id());
>         if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
> --
> 2.17.1
>

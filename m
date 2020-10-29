Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD94229F18D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgJ2Qb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 12:31:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40396 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgJ2QaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 12:30:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id f97so2874920otb.7;
        Thu, 29 Oct 2020 09:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZB07qrLbOJe5x8k5kgwlwyYgrU0au+3LEdR9BcQ+dAw=;
        b=TdqNwgwd6SEmWeBIsgrmnnAhJcU1jR6JkgBXiYPNceJPDCmy/xRRyCtChqC9pcSHG+
         hUy4qHfYMjsSoG3GDSKCNV/BVIKYQVWNkOCV5leODPiWi4k5SPXg/yR5hU8z5iUiQg6w
         +Q9Pq5tbrMKcaCKHwJjhaU5UmDlZZ/qvXKarY1By/Y1dFpyrVAhefM3pNiRiqTWLesMz
         BvH2fLJOJ7Tzu69ejkZE4ett12upvcK7nPktjMHkYdGTlui9zw7FngwQoZlpcv2g/XDG
         muLlmY5TvAxnXX2Mwkq27PaNIMb+1fcBFmPe52w5fWOs9lLSGOmHCKSo8QdzV4JxOfxy
         Dscw==
X-Gm-Message-State: AOAM530ebeZR5+DLUOxvAV+RYa330DUZGdnq3RB7IOz6iFpQhv8yINaD
        rJI64p/v5bRE5oFs0EoJ3cctV/gpObj5LSNn1RM=
X-Google-Smtp-Source: ABdhPJy2gnJASZanadb1mOz1tbg80ys3NM2aGYdvcYIISMX2t1bfCDW4CoQJSVVkimsx+nxAWLJibjXQBAg79vyeqWE=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr4119563otk.260.1603989017370;
 Thu, 29 Oct 2020 09:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201029161902.19272-1-rppt@kernel.org> <20201029161902.19272-3-rppt@kernel.org>
In-Reply-To: <20201029161902.19272-3-rppt@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Oct 2020 17:30:06 +0100
Message-ID: <CAJZ5v0jY2vqZxdD7CaGUsCb2ePodamDnneOLHZcagCODn5kmrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PM: hibernate: make direct map manipulations more explicit
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <len.brown@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 29, 2020 at 5:19 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a page may be
> not present in the direct map and has to be explicitly mapped before it
> could be copied.
>
> On arm64 it is possible that a page would be removed from the direct map
> using set_direct_map_invalid_noflush() but __kernel_map_pages() will refuse
> to map this page back if DEBUG_PAGEALLOC is disabled.
>
> Introduce hibernate_map_page() that will explicitly use
> set_direct_map_{default,invalid}_noflush() for ARCH_HAS_SET_DIRECT_MAP case
> and debug_pagealloc_map_pages() for DEBUG_PAGEALLOC case.
>
> The remapping of the pages in safe_copy_page() presumes that it only
> changes protection bits in an existing PTE and so it is safe to ignore
> return value of set_direct_map_{default,invalid}_noflush().
>
> Still, add a WARN_ON() so that future changes in set_memory APIs will not
> silently break hibernation.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

From the hibernation support perspective:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/mm.h      | 12 ------------
>  kernel/power/snapshot.c | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1fc0609056dc..14e397f3752c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2927,16 +2927,6 @@ static inline bool debug_pagealloc_enabled_static(void)
>  #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
>  extern void __kernel_map_pages(struct page *page, int numpages, int enable);
>
> -/*
> - * When called in DEBUG_PAGEALLOC context, the call should most likely be
> - * guarded by debug_pagealloc_enabled() or debug_pagealloc_enabled_static()
> - */
> -static inline void
> -kernel_map_pages(struct page *page, int numpages, int enable)
> -{
> -       __kernel_map_pages(page, numpages, enable);
> -}
> -
>  static inline void debug_pagealloc_map_pages(struct page *page,
>                                              int numpages, int enable)
>  {
> @@ -2948,8 +2938,6 @@ static inline void debug_pagealloc_map_pages(struct page *page,
>  extern bool kernel_page_present(struct page *page);
>  #endif /* CONFIG_HIBERNATION */
>  #else  /* CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> -static inline void
> -kernel_map_pages(struct page *page, int numpages, int enable) {}
>  static inline void debug_pagealloc_map_pages(struct page *page,
>                                              int numpages, int enable) {}
>  #ifdef CONFIG_HIBERNATION
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 46b1804c1ddf..054c8cce4236 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -76,6 +76,32 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
>  static inline void hibernate_restore_unprotect_page(void *page_address) {}
>  #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
>
> +static inline void hibernate_map_page(struct page *page, int enable)
> +{
> +       if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> +               unsigned long addr = (unsigned long)page_address(page);
> +               int ret;
> +
> +               /*
> +                * This should not fail because remapping a page here means
> +                * that we only update protection bits in an existing PTE.
> +                * It is still worth to have WARN_ON() here if something
> +                * changes and this will no longer be the case.
> +                */
> +               if (enable)
> +                       ret = set_direct_map_default_noflush(page);
> +               else
> +                       ret = set_direct_map_invalid_noflush(page);
> +
> +               if (WARN_ON(ret))
> +                       return;
> +
> +               flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +       } else {
> +               debug_pagealloc_map_pages(page, 1, enable);
> +       }
> +}
> +
>  static int swsusp_page_is_free(struct page *);
>  static void swsusp_set_page_forbidden(struct page *);
>  static void swsusp_unset_page_forbidden(struct page *);
> @@ -1355,9 +1381,9 @@ static void safe_copy_page(void *dst, struct page *s_page)
>         if (kernel_page_present(s_page)) {
>                 do_copy_page(dst, page_address(s_page));
>         } else {
> -               kernel_map_pages(s_page, 1, 1);
> +               hibernate_map_page(s_page, 1);
>                 do_copy_page(dst, page_address(s_page));
> -               kernel_map_pages(s_page, 1, 0);
> +               hibernate_map_page(s_page, 0);
>         }
>  }
>
> --
> 2.28.0
>

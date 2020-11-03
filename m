Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A72A43BB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKCLIT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 06:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgKCLIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 06:08:18 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69934C061A48
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 03:08:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l2so21639352lfk.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 03:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0sEXlBoxnDPWC0PSImx6b45EW/XdSxvl0dskuufPCkM=;
        b=DDGsed/rnR9bezm8l99j+eaiR9Ng8+VD49bJiK1NAcb13ryZua3eiHNJkEUJYM7q4q
         zCCEua4OxygsHhj1XVYFclEnvfs8dtk8HZUq1aa2fKeCC1ivOtLxqOefmDgSGp9oFlOr
         hAWnMoFYPcy6/inHtPYp6y+Ll+sbonCF0KjG6nyml+YxQJr6IbSjcrdNbOQkutO8NxkL
         FEkF/0STPopqzOAi1pVyuF642sMpo4gqoXWfJTZgyjNsKfE0QyHjFu93yXEkV6QK5fCs
         LXCWy6h56hyXQaKhqHUvZP6L632PtDIPp/Z07qwJ3b4T1YdUnIRaKCRJ/6v0LV3pGdBe
         QkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0sEXlBoxnDPWC0PSImx6b45EW/XdSxvl0dskuufPCkM=;
        b=NZkAgrwE4Mt31o0dY/A3Cvwj/hqaJtVNci8K8F0Yiro0LlJmAYS3xAxy1qz1rnrPit
         rrHAzFUygEp3Zjg/lHTjZnUKQBGLxn8tz9AT6YnVV3lVVhbHkk+5BTu2X8xaY9cjpQxq
         Xan+oJuXsGFaTiUWF80uOcYskEePKFwj+8AOWEc/7fWNaS1IwON5Ziq8VCXPSrWulohX
         2zhVKtY9cHoSHRd4tMVUfVFWKh2rCyr3X/6ddzqOPZgnxSLY2AfqbJInafntd2XrGWLH
         nu3akv9fUXw0a7Lw2vgIPNhRfaDOFjpms8RuKtI0M9t1i2EsOwBxZBi96+KchZL9M5B7
         nyMQ==
X-Gm-Message-State: AOAM530UJRORXq7CGLXTbw7OQhEWO/+k1JisJCFs7ZHqDFd5WCJWrTtA
        3cCqYT/puLmdnG/QNe8tXguswg==
X-Google-Smtp-Source: ABdhPJzAyrukqGQuCxp2/NOEVoOC9ZkivmVdXf94z98OJ3dGsVtTaaSEH+8Z/YJLbxgkwYbzErDtUQ==
X-Received: by 2002:a19:c187:: with SMTP id r129mr8047701lff.533.1604401696649;
        Tue, 03 Nov 2020 03:08:16 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w9sm4094835ljh.95.2020.11.03.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 03:08:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B845910231C; Tue,  3 Nov 2020 14:08:16 +0300 (+03)
Date:   Tue, 3 Nov 2020 14:08:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/4] PM: hibernate: make direct map manipulations more
 explicit
Message-ID: <20201103110816.t6a3ebtgcm7mfogy@box>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101170815.9795-3-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 01, 2020 at 07:08:13PM +0200, Mike Rapoport wrote:
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
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> +		unsigned long addr = (unsigned long)page_address(page);
> +		int ret;
> +
> +		/*
> +		 * This should not fail because remapping a page here means
> +		 * that we only update protection bits in an existing PTE.
> +		 * It is still worth to have WARN_ON() here if something
> +		 * changes and this will no longer be the case.
> +		 */
> +		if (enable)
> +			ret = set_direct_map_default_noflush(page);
> +		else
> +			ret = set_direct_map_invalid_noflush(page);
> +
> +		if (WARN_ON(ret))

_ONCE?
> +			return;
> +
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +	} else {
> +		debug_pagealloc_map_pages(page, 1, enable);
> +	}
> +}
> +
>  static int swsusp_page_is_free(struct page *);
>  static void swsusp_set_page_forbidden(struct page *);
>  static void swsusp_unset_page_forbidden(struct page *);

-- 
 Kirill A. Shutemov

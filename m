Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536382A43DA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 12:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgKCLP0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCLPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 06:15:25 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA8C0617A6
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 03:15:25 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id k25so18590700lji.9
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 03:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncuj71puAub1y9k++6jjBlDK0kArgOgR8TXfNbxvsd8=;
        b=izMTq7qxXBvApfWEFsxvjdUJPgrZuhTimURmEAxHbNo4gFnz/aLq2b7VWGISw5z4df
         T4qAkIJ/wVC4TwenAjvns/G4eV3KtASB7SoA8G7okZ0DlaEStNAMb73QDSEutPwz7Cxr
         9dwIgPWHz7UWHdA9P9qEfMywjEVY/N8zUXbSYG6q36rmSFiE581fBMYfvokjD/8gAh06
         qYdTpEzw9QcJY1be9GP/o6iEFZwXPue/WXhcJtWuRvtKWCdMX7XpnZXp5E2hc11zR/K7
         2suAPN+eebeKUXh9rBamFs3h05hvuWg15bi4K5NGwazMJ1rOL7mta6TyCdehAzblBry8
         3fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncuj71puAub1y9k++6jjBlDK0kArgOgR8TXfNbxvsd8=;
        b=uZjI+tcTxg9J9GTmTQM4FUe+OMNrFBgB6zoPTyWK9728wgisX/KRTdkFyIBvYuGmTj
         Xdys7VOds0cISV3xjPC1jRrmRoDJcwJOWX+TMmYm8l5hTDtWFP2+gVFR6QJbDEG//ZQ4
         sjDUsI2fmgksYT3Qpzaf+wluBxYIasoZQH8rym65q195p3dEs88zb3vQUcbHEopea34T
         iAGxR60HRfcfxBCfJgMy3XBfZMOuePHILenZmx5rwhHxmUX84CuuUSDrKKv8LwqDGsZ8
         tye2CUokpRTzWDnGf4V1X7G9r/a5KMI0dS8z0xmBET8snKJk/htBjskwJptu7ITeBegl
         vK+Q==
X-Gm-Message-State: AOAM533ocxkjMPDGHhEHC1q674NICuFcSiYptpj/aR0nSeRrxymTyxV4
        vRkin2WjUVxNA0AkIm+x163zbA==
X-Google-Smtp-Source: ABdhPJxjF5BnQdEHGsyL0gaT34gDeSETHtrYJVXOHHeYBc231eIiqfI8v+rYFTL2Y/vLhKT27dJQgw==
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr8731933ljn.77.1604402123506;
        Tue, 03 Nov 2020 03:15:23 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q22sm3657427lfj.145.2020.11.03.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 03:15:22 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id D700710231C; Tue,  3 Nov 2020 14:15:23 +0300 (+03)
Date:   Tue, 3 Nov 2020 14:15:23 +0300
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
        x86@kernel.org
Subject: Re: [PATCH v3 0/4] arch, mm: improve robustness of direct map
 manipulation
Message-ID: <20201103111523.zt5q5ypnnccdlque@box>
References: <20201101170815.9795-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101170815.9795-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 01, 2020 at 07:08:11PM +0200, Mike Rapoport wrote:
> Mike Rapoport (4):
>   mm: introduce debug_pagealloc_map_pages() helper
>   PM: hibernate: make direct map manipulations more explicit
>   arch, mm: restore dependency of __kernel_map_pages() of DEBUG_PAGEALLOC
>   arch, mm: make kernel_page_present() always available

The series looks good to me (apart from the minor nit):

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A072A4867
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKCOje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 09:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKCOjS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 09:39:18 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6EC0617A6
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 06:39:17 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 23so19256506ljv.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M/CcLnAggfPJTPHCvJqAFAyQXrrFbGX8RqEWGTOIlRk=;
        b=tYRtCsCJ97u7yAlrOFN203Mpt9jz/EvbuW4V+3hipSUNsR5M8ZDqWsq7efoMiN9R5c
         nhVCnARjFr5alomHWUrG2S/QRxbOVwaEaiSQTgeF0uEgCJ7a2rbupEC/g2AUeshC9i6C
         wIKR126viYncqhHiZROMnSmO9imaid0rNJepyxM6rr8Apn+RPbJ3qWs7P+ZnHrSgvOWA
         QcXHZrEHzXM4SVCDzBK7zqXcUTu3T+G1dUvHRbLGUKs/I2DIfrL0bitkL+B4SCLYpFfX
         lHpCGqsodauH4LxSQSOtDBLKGW1a7DHfcCp5nbfeol5ZCBBoivuqpYvLjRQisIJ68BoF
         UMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M/CcLnAggfPJTPHCvJqAFAyQXrrFbGX8RqEWGTOIlRk=;
        b=SaaiVsTVNaNso9bPwKeR7IEYfNyCGB8JPtQljhyexie6u2ZTRNBK/cyKPV1bkYiwA1
         eBEe5Mr18x+cd1EuPZ7FP6ZdQW1CIqNabBfIQM074GB/LNhT6BHtegClZ0zI4LjvaUHn
         eeUt/LK065HBcuDh8DqJAaymhLjRNPnESl9Vif3IklCfa5Bz95s6iKIhfmcbnOA9NKyn
         s5JEAprh095avOhmWc2WzvFRYqV9V6W/Z2oKqpRQxIjHLBqrBOuwDY6THXDM+odgPHQK
         X93ZiGVqF5+8kHqVo5xfnMTUVhP4WcytxLfJ8ZT42JRzf4WVUMcF2ezfuDNOO6eJFLkS
         w9OQ==
X-Gm-Message-State: AOAM530ceXnvNwV5yGThoFSHtvNedJd35cVnP+MndyyV+GDLvyWagYxD
        YEtNR2lG82hOpbuv+/T+63Tytg==
X-Google-Smtp-Source: ABdhPJz+L8qrHCJkzOuQS8/wvO1dQM/ksNE/UzgTA6Cx0Ac2GRFSZ5fX6eoakfcdH0CZnI4/h7s3ng==
X-Received: by 2002:a2e:879a:: with SMTP id n26mr9115208lji.347.1604414356208;
        Tue, 03 Nov 2020 06:39:16 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g27sm4334360ljl.91.2020.11.03.06.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:39:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 65F1510231C; Tue,  3 Nov 2020 17:39:16 +0300 (+03)
Date:   Tue, 3 Nov 2020 17:39:16 +0300
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
Message-ID: <20201103143916.otz2o4h2dlmewn3h@box>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
 <20201103110816.t6a3ebtgcm7mfogy@box>
 <20201103121350.GI4879@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103121350.GI4879@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 03, 2020 at 02:13:50PM +0200, Mike Rapoport wrote:
> On Tue, Nov 03, 2020 at 02:08:16PM +0300, Kirill A. Shutemov wrote:
> > On Sun, Nov 01, 2020 at 07:08:13PM +0200, Mike Rapoport wrote:
> > > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > > index 46b1804c1ddf..054c8cce4236 100644
> > > --- a/kernel/power/snapshot.c
> > > +++ b/kernel/power/snapshot.c
> > > @@ -76,6 +76,32 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
> > >  static inline void hibernate_restore_unprotect_page(void *page_address) {}
> > >  #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
> > >  
> > > +static inline void hibernate_map_page(struct page *page, int enable)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > > +		unsigned long addr = (unsigned long)page_address(page);
> > > +		int ret;
> > > +
> > > +		/*
> > > +		 * This should not fail because remapping a page here means
> > > +		 * that we only update protection bits in an existing PTE.
> > > +		 * It is still worth to have WARN_ON() here if something
> > > +		 * changes and this will no longer be the case.
> > > +		 */
> > > +		if (enable)
> > > +			ret = set_direct_map_default_noflush(page);
> > > +		else
> > > +			ret = set_direct_map_invalid_noflush(page);
> > > +
> > > +		if (WARN_ON(ret))
> > 
> > _ONCE?
> 
> I've changed it to pr_warn() after David said people enable panic on
> warn in production kernels.

pr_warn_once()? :P

-- 
 Kirill A. Shutemov

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A029D6DD
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgJ1WTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731779AbgJ1WRp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:45 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E673E246A2;
        Wed, 28 Oct 2020 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603883399;
        bh=eCXz+icsPBbUt7e5/gqYfjD87B/R7/XDnyNtNoyBXrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSkA1LMThGYa8UMoSh4pNOLlYk0Lxh/6LDfGk3lRhOIkmwmSNIL5gi4KdTIE8Tsxu
         qd8mkHa8sLSEDYsQV8mEhfTUE/HscCn3fQbHDAv2vipDt0prchwp0fFl1i7QNwuZ5Y
         aIHs1RviptzndqpoN78OxdW+Os4KYEQl9gh6FnDI=
Date:   Wed, 28 Oct 2020 13:09:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "cl@linux.com" <cl@linux.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "will@kernel.org" <will@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "rientjes@google.com" <rientjes@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Brown, Len" <len.brown@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
Message-ID: <20201028110945.GE1428094@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
 <20201026090526.GA1154158@kernel.org>
 <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
 <20201027083816.GG1154158@kernel.org>
 <e5fc62b6-f644-4ed5-de5b-ffd8337861e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5fc62b6-f644-4ed5-de5b-ffd8337861e4@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 09:46:35AM +0100, David Hildenbrand wrote:
> On 27.10.20 09:38, Mike Rapoport wrote:
> > On Mon, Oct 26, 2020 at 06:05:30PM +0000, Edgecombe, Rick P wrote:
> > 
> > > Beyond whatever you are seeing, for the latter case of new things
> > > getting introduced to an interface with hidden dependencies... Another
> > > edge case could be a new caller to set_memory_np() could result in
> > > large NP pages. None of the callers today should cause this AFAICT, but
> > > it's not great to rely on the callers to know these details.

> > A caller of set_memory_*() or set_direct_map_*() should expect a failure
> > and be ready for that. So adding a WARN to safe_copy_page() is the first
> > step in that direction :)
> > 
> 
> I am probably missing something important, but why are we saving/restoring
> the content of pages that were explicitly removed from the identity mapping
> such that nobody will access them?

Actually, we should not be saving/restoring free pages during
hibernation as there are several calls to mark_free_pages() that should
exclude the free pages from the snapshot. I've tried to find why the fix
that maps/unmaps a page to save it was required at the first place, but
I could not find bug reports.

The closest I've got is an email from Rafael that asked to update
"hibernate: handle DEBUG_PAGEALLOC" patch:

https://lore.kernel.org/linux-pm/200802200133.44098.rjw@sisk.pl/

Could it be that safe_copy_page() tries to workaround a non-existent
problem?

-- 
Sincerely yours,
Mike.

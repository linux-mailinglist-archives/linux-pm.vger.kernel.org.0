Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEABB2A4A75
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKCP4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:56:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgKCP4v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:56:51 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B47820870;
        Tue,  3 Nov 2020 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604419010;
        bh=PdZbTZgg1JmpGp2bwjsENk8fgDYDWqJbhtmXs83/fs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5lRRB1N1MmXeOH2myvsU+QScNFs2bqbrupv/pQ4irlpmZwooHX8QWAG7Auq1KyAR
         BKUUy9aydAOF9vLJs/4y281FnWsGIjtK6pWCGXyL7y2ETSAe5RqnViQPWzk/w9t3W5
         2kvBIUagkYLvCz/jLs5zwUcf94hBrrkoIybAauvg=
Date:   Tue, 3 Nov 2020 17:56:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Message-ID: <20201103155636.GJ4879@kernel.org>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
 <20201103110816.t6a3ebtgcm7mfogy@box>
 <20201103121350.GI4879@kernel.org>
 <20201103143916.otz2o4h2dlmewn3h@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103143916.otz2o4h2dlmewn3h@box>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 03, 2020 at 05:39:16PM +0300, Kirill A. Shutemov wrote:
> On Tue, Nov 03, 2020 at 02:13:50PM +0200, Mike Rapoport wrote:
> > > > +
> > > > +		if (WARN_ON(ret))
> > > 
> > > _ONCE?
> > 
> > I've changed it to pr_warn() after David said people enable panic on
> > warn in production kernels.
> 
> pr_warn_once()? :P

Sure :)

-- 
Sincerely yours,
Mike.

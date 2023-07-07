Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4514874B597
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGGRNb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 7 Jul 2023 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGGRNa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 13:13:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C981FEC
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 10:13:27 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="363974296"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="363974296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 10:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="833477255"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="833477255"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2023 10:13:26 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id EA802580C63;
        Fri,  7 Jul 2023 10:13:24 -0700 (PDT)
Message-ID: <eef335753f73e505eb91307b2a2cd06b32901d24.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mwait: Add support for idle via umwait
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Date:   Fri, 07 Jul 2023 20:13:23 +0300
In-Reply-To: <87352a0vu4.ffs@tglx>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
         <20230610183518.4061159-2-dedekind1@gmail.com> <87352a0vu4.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2023-06-30 at 00:04 +0200, Thomas Gleixner wrote:
> > +#ifdef CONFIG_X86_64
> > +/*
> > + * Monitor a memory address at 'rcx' using the 'umonitor' instruction.
> > + */
> > +static inline void __umonitor(const void *rcx)
> > +{
> > +       /* "umonitor %rcx" */
> > +#ifdef CONFIG_AS_TPAUSE
> 
> Are you sure that the instruction check for TPAUSE is sufficient to also
> include UMONITOR on all toolchains which support TPAUSE?

I've verified by building the kernel with gcc/binutils and clang/LLVM.
Builds, boots, umwait works, C0.2 happens with both.

I inspected gcc, binutils, and clang/llvm git logs: support for
'tpause' and 'umwait' arrived in the same commit. Details below.

'tpause' and 'umwait' instructions are very similar, arrived together,
guarded together by CPUID.7's "MWAITPKG" bit. Based on this, I'd generally
expect toolchains to support both or none.

I can add a note about this in the commit message too.

Details on commits in the projects I checked.

1. binutils-gcc git tree:
   de89d0a34d5 Enable Intel WAITPKG instructions.

2. gcc git tree:
   55f31ed10fd i386-common.c (OPTION_MASK_ISA_WAITPKG_SET, [...]): New defines.

3. llvm-project git tree:
   2e02579a76cf [OpenMP] Add use of TPAUSE

It'll take some time to re-test and and partially re-measure power/perf,
so I'll send new version a bit later.

Thanks,
Artem.

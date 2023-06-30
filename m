Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22274402E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jun 2023 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjF3QzH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 30 Jun 2023 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjF3QzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2023 12:55:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A13ABD
        for <linux-pm@vger.kernel.org>; Fri, 30 Jun 2023 09:54:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="361291574"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="361291574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 09:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="747480504"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="747480504"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 09:54:45 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 1487D580DA1;
        Fri, 30 Jun 2023 09:54:43 -0700 (PDT)
Message-ID: <910cf424b779332e459e61e26426911a5a8a83bc.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mwait: Add support for idle via umwait
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Date:   Fri, 30 Jun 2023 19:54:43 +0300
In-Reply-To: <87352a0vu4.ffs@tglx>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
         <20230610183518.4061159-2-dedekind1@gmail.com> <87352a0vu4.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

Good point, I checked only GNU compiler. I can check Clang/LLVM.


Will also address other issues that you pointed, thanks!

Artem.

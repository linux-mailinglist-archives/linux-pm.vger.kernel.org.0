Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2126B1D43
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 09:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCIICo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 9 Mar 2023 03:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCIICU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 03:02:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4965F516
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 00:02:00 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335087288"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="335087288"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="923143532"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="923143532"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2023 00:01:59 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 84FA65807E7;
        Thu,  9 Mar 2023 00:01:58 -0800 (PST)
Message-ID: <12e008c7fd280c8abc45f417f64bb782485a40b8.camel@gmail.com>
Subject: Re: [PATCH 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Thu, 09 Mar 2023 10:01:57 +0200
In-Reply-To: <20230308123222.GF2017917@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
         <20230306123418.720679-4-dedekind1@gmail.com>
         <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
         <CAJZ5v0gFrWCdyVNPUoU4tq2vTzcx5WtzvhbXVx1WeyTtt=Gqvg@mail.gmail.com>
         <20230308123222.GF2017917@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2023-03-08 at 13:32 +0100, Peter Zijlstra wrote:
> > Well, it would be kind of nice to say that this is related to commit
> > 6d9c7f51b1d9 ("cpuidle, intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
> > *again*") that is present in 6.3-rc1.
> 
> Right, but he said the patches were based on -next, which would've had
> that commit for a fair while too.

I can see what is the problem from the above mentioned commit. But I struggle to
reproduce it. I tried 'make W=1', and 'tools/objtool/objtool -n vmlinux.o'. I
have 'CONFIG_HAVE_NOINSTR_VALIDATION' too.

I also tries this:

1. Build kernel with this patch-set
2. tools/objtool/objtool -n vmlinux.o > ~/tmp/before.txt  2>&1
3. Make clean; Build kernel with a fix (local_irq_disable() ->
raw_local_irq_disable())
4. tools/objtool/objtool -n vmlinux.o > ~/tmp/after.txt  2>&1
5. diff -u ~/tmp/before.txt ~/tmp/after.txt

And no difference.

Could you please help by giving a hint how to verify?

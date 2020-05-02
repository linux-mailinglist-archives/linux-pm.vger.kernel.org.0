Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC91C21C6
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 02:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgEBADx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 20:03:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:23947 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEBADw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 20:03:52 -0400
IronPort-SDR: w+JaYkrsklYnu+WTvaWXxY7mlzm+zTOXdcXaRHh/T97gr23vSWHpxvSit5k9E1QM4dyR6ejibb
 j75lw+s7CxMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 17:03:52 -0700
IronPort-SDR: 3rgefx24t0xzK5AFJhBE8FFAt7fW+8zYHVDdpAlxca0bsfHckSLU21AtWDiKaoGZU5sszVnJ0a
 /yaGiFdgUSjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="405889455"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2020 17:03:51 -0700
Date:   Fri, 1 May 2020 17:04:23 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
Message-ID: <20200502000423.GA3118@ranerica-svr.sc.intel.com>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
 <20200428132450.24901-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428132450.24901-3-ggherdovich@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 28, 2020 at 03:24:50PM +0200, Giovanni Gherdovich wrote:
> There may be CPUs that support turbo boost but don't declare any turbo
> ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> scale-invariant calculations can't be performed.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks for implementing this, Giovanni!

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

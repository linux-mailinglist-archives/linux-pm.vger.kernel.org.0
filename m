Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC3A21602E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 22:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGFUT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 16:19:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:35159 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGFUT5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Jul 2020 16:19:57 -0400
IronPort-SDR: nbhH2bSgIDfFYKOctCl/mh7cUL/rIIO54qMOjta0YUpdtmbM1OoCAMr0gQySQWZJYxyK4cS1Gm
 0/dD8N+jlYHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149011865"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="149011865"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 13:19:57 -0700
IronPort-SDR: 3BSlNuO2KXikjBngo+wNaqVNmV3zQUTDkjml4aOc/RpldiXpP1T8cEi6HYwkxOytSN/E8JRvFA
 R0GfNdOpaQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="483254110"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2020 13:19:56 -0700
Date:   Mon, 6 Jul 2020 13:19:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
Message-ID: <20200706201956.GA1390666@iweiny-DESK2.sc.intel.com>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
 <20200531182453.15254-3-ggherdovich@suse.cz>
 <20200601233418.GA15416@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601233418.GA15416@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 01, 2020 at 04:34:18PM -0700, Ricardo Neri wrote:
> On Sun, May 31, 2020 at 08:24:52PM +0200, Giovanni Gherdovich wrote:
> > There may be CPUs that support turbo boost but don't declare any turbo
> > ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> > scale-invariant calculations can't be performed.
> > 
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> FWIW,
> 
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Is this going to make it as a fix to 5.8?

Tested-by: Ira Weiny <ira.weiny@intel.com>


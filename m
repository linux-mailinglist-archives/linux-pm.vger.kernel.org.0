Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF621EB233
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 01:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgFAXeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 19:34:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:42708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgFAXeG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 19:34:06 -0400
IronPort-SDR: Q1KurRVnOV0L6suGSexoNtQRgAQZgQ2weXnc9ibqWDQOJXqSWB5MbtzhTzyQWRvTw5yitw04ox
 D6K9dQ5qsfxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 16:34:06 -0700
IronPort-SDR: Kml1XbBZ4CYpWZ5606pxLMSmoLZvuxbm5FDG31d2M/6fMdnMlPGvLFU/DPM3gRJE45FjNGW/HI
 tMKcZT//UIEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="272162677"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2020 16:34:05 -0700
Date:   Mon, 1 Jun 2020 16:34:18 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
Message-ID: <20200601233418.GA15416@ranerica-svr.sc.intel.com>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
 <20200531182453.15254-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531182453.15254-3-ggherdovich@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 08:24:52PM +0200, Giovanni Gherdovich wrote:
> There may be CPUs that support turbo boost but don't declare any turbo
> ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> scale-invariant calculations can't be performed.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

FWIW,

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

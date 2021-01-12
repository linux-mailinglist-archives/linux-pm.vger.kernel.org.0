Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0D2F337D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbhALPBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 10:01:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:48640 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbhALPBE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Jan 2021 10:01:04 -0500
IronPort-SDR: bigQfL0RdZSvw+EWQaaSpXiKIKlc/Pa70HSwZzEIOiQ3PQ6mFkC2WuPLYwWwYSXJ3sVVVATmGf
 ccCxMfc80g6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="239592233"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="239592233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 07:00:22 -0800
IronPort-SDR: 9X8eWtH59RL9xfctl3owzHGS3bEVAKRfaT8ZCCkLMo6joFK2nyLXZ8olC2Oyl4rU4BQBdKaBl2
 U7Sukbtiy/Yg==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="381456283"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 07:00:20 -0800
Date:   Tue, 12 Jan 2021 23:03:40 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v3] cpufreq: intel_pstate: Get percpu max freq via HWP
 MSR register if available
Message-ID: <20210112150340.GA17152@chenyu-office.sh.intel.com>
References: <20210112052127.4557-1-yu.c.chen@intel.com>
 <CAJZ5v0i5jdp6YcpvVuLyxGePRAsFPUPL6=iQC7PEFSzjNRUJLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5jdp6YcpvVuLyxGePRAsFPUPL6=iQC7PEFSzjNRUJLw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 12, 2021 at 02:52:50PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 12, 2021 at 6:19 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Currently when turbo is disabled(either by BIOS or by the user), the
> > intel_pstate driver reads the max non-turbo frequency from the package-wide
> > MSR_PLATFORM_INFO(0xce) register. However on asymmetric platforms it is
> > possible in theory that small and big core with HWP enabled might have
> > different max non-turbo cpu frequency, because the MSR_HWP_CAPABILITIES
> > is percpu scope according to Intel Software Developer Manual.
> >
> > The turbo max freq is already percpu basis in current code, thus make
> > similar change to the max non-turbo frequency as well.
> >
> > Reported-by: Wendy Wang <wendy.wang@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v2: Per Srinivas' suggestion, avoid duplicated assignment of max_pstate.
> > v3: Per Rafael's suggestion, do not add new argument in intel_pstate_get_hwp_max()
> >     to avoid redundant local vars.
> >     Per Srinivas' suggestion, refined the commit log to reflect the 'non-turbo'
> >     max frequency.
> 
> Looks good now, thanks!
> 
> Is it needed in -stable and if so, which -stable series should it go into?
>
Yes, I think so, it should be 
Cc: stable@vger.kernel.org # 4.18+
as the HWP reading turbo frequency was firstly introduced in v4.18-rc2 and it
was easier to be applied.
BTW, this patch is on top of your previous patch set on intel_pstate clean up:
https://patchwork.kernel.org/project/linux-pm/list/?series=410797

thanks,
Chenyu

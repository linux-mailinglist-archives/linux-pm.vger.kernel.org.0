Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46F7195BB3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0Q5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 12:57:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:46569 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgC0Q5G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 12:57:06 -0400
IronPort-SDR: wgVrTOegU7HCPxCh8zP+ILQr9cCmMLaBd0hco5YEMjkY9W7kNCvtB+ozH+snkdqGPLp/QhH8r7
 f3do1OQFbNog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:57:05 -0700
IronPort-SDR: TOLEhEw5bMLfGz8lrR9zf02Q2myP1TBpAMsJVCZ8ck27t11V5xFKUDAD7u6Xxz+K8TPCTpKNGw
 aIEkV6stNkmQ==
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="251198630"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.248.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:57:05 -0700
Message-ID: <4ced6de2fba86c2b0d35bc0b8b986404d9033122.camel@linux.intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Fri, 27 Mar 2020 09:57:03 -0700
In-Reply-To: <alpine.DEB.2.21.2003261303530.3213@xps-7390>
References: <20200326181641.291505803E3@linux.intel.com>
         <707c44fc116e37fdf8edd6543aadf8426f590799.camel@linux.intel.com>
         <alpine.DEB.2.21.2003261303530.3213@xps-7390>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-03-26 at 13:14 -0700, Kenneth R. Crudup wrote:
> On Thu, 26 Mar 2020, Srinivas Pandruvada wrote:
> 
> > I tried on the Dell 7390 2-in-1 and see the behavior you reported.
> 
> Thanks for that (and glad to see my specific system is available to
> you!)
> 
> > The problem is that the energy counter is 0 during probe (msr 0x64d
> > is
> > 0), which is not correct.
> 
> Any insight as to why this only happens during a reboot (vs. cold
> boot)?
> 
> > Even the counter values are not correct. The delta between two
> > reads of
> > energy_uj is less than the package domain energy_uj delta.
> ...
> > So psys domain is not useful on this system.
> 
> So, If I understand you correctly, even when I can see the psys
> domain, the
> values aren't useful?
> 
> I trust your conclusion, but I have a tool called "S-Tui" deployed on
> my
> machine and when the psys domain is active, I get what apears to be
> moving
> values depending on system load. (See attachment.)
> 
> I may also be asking the wrong question, too- perhaps "What do I lose
> by
> not having a working psys domain?" (or conversely, "What do I gain by
> having
> one available?") is what I should be asking; I'm trying to do
> whatever I can
> to manage thermals on this machine, mostly 'cause with a 15W tDp and
> my
> typical build workload I seem to throttle quite a bit (not uncommon
> for my
> machine's ultrabook form factor, though).
You will not loose anything if you don't have psys domain. What disto
you are using? Check thermald version (Some distros star this by
default like Ubuntu)
thermald --version

Run this tool once on your system
https://github.com/intel/dptfxtract

Thanks,
Srinivas

> 
> Thanks,
> 
> 	-Kenny
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1435195E81
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 20:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0TTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 15:19:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:57335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0TTk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 15:19:40 -0400
IronPort-SDR: rUqoMNkgmHJ1m7X8q4jMBCOpFw9jU1VuXmnoAxfuKo5mqXa3at8Rqn8sMyJDYCTexTm2eedHNc
 tZWYF2kKx69w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 12:19:39 -0700
IronPort-SDR: 3P/EWkoj2KVCtX6Xb7F+vabVoWmX0g52x+FkDxy9/ENVNjvi6GEYRe1d37MOEEI3LZCTvDXwG6
 3VjHhtatVaeg==
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="251236050"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.248.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 12:19:39 -0700
Message-ID: <6efaa8c55d4ca67bdd67072ae67f123d56ecc730.camel@linux.intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Fri, 27 Mar 2020 12:19:38 -0700
In-Reply-To: <alpine.DEB.2.21.2003271005360.2705@xps-7390>
References: <20200326181641.291505803E3@linux.intel.com>
         <707c44fc116e37fdf8edd6543aadf8426f590799.camel@linux.intel.com>
         <alpine.DEB.2.21.2003261303530.3213@xps-7390>
         <4ced6de2fba86c2b0d35bc0b8b986404d9033122.camel@linux.intel.com>
         <alpine.DEB.2.21.2003271005360.2705@xps-7390>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-03-27 at 10:09 -0700, Kenneth R. Crudup wrote:
> On Fri, 27 Mar 2020, Srinivas Pandruvada wrote:
> 
> > You will not loose anything if you don't have psys domain.
> 
> OK. I think a BIOS update from HP that just came thru yesterday seems
> to
> have fixed this issue, BTW.
> 
> > What distro you are using?
> 
> Kubuntu 19.10 (but I build my own kernels from Linus' master since I
> have
> an IceLake CPU).
> 
> > Check thermald version (Some distros star this by
> 
> I disabled thermald a while ago; it goes overboard and slows me down
> too much.
> 
> > Run this tool once on your system
> > https://github.com/intel/dptfxtract
> 
> I did that a while ago (back when I was using thermald) and have a
> bunch of
> entries in /etc/thermald/... ; but as I'm no longer using thermald is
> this
> relevant for me? What should I look for?
In some platform to set the correct power settings and then control
thermal when there is an issue.


Thanks,
Srinivas


> 
> 	-Kenny
> 


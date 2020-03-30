Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D8919802F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgC3PvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 11:51:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:28872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgC3PvK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 11:51:10 -0400
IronPort-SDR: 4cCNJFXRPaIFB4ZrkXZDReYAm9WLQ5+0QgDJZCD2X3hnw71EEp1o6OxrLePWNsi/lERvmaffRs
 d2hxdTZ1PBdw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 08:51:10 -0700
IronPort-SDR: awTv6nzme+vK11LpjmDAMs4bOM7/vA4lfqwerJ7UrVIY8AfRTdsQaudxE3DtL/bVtlwdLdOYGe
 tv/jiVIoUnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="294617225"
Received: from nzehfroo-mobl.amr.corp.intel.com (HELO spandruv-mobl3.jf.intel.com) ([10.135.21.18])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 08:51:09 -0700
Message-ID: <7583412585916da6bb23d9352257c7768c509388.camel@linux.intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, "Liang, Kan" <kan.liang@intel.com>
Date:   Mon, 30 Mar 2020 08:51:08 -0700
In-Reply-To: <b772ca4f2c08cca65da9cf09b4a61157854669af.camel@intel.com>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>
         <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>
         <alpine.DEB.2.21.2003252353370.2971@xps-7390>
         <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com>
         <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
         <alpine.DEB.2.21.2003260237130.26874@xps-7390>
         <alpine.DEB.2.21.2003260311030.2844@xps-7390>
         <b772ca4f2c08cca65da9cf09b4a61157854669af.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-03-30 at 17:55 +0800, Zhang Rui wrote:
> CC Kan.
> 
> By checking the RAPL PMU code, it is possible that rdmsr_safe fails
> when reading MSR_PLATFORM_ENERGY_STATUS.
> But we don't have any debug message showing the exact failure reason.
> 
> can you please apply the patch attached and see why psys probe fails?
I could reproduce this. This fails because the Psys MSR read 0. Also
the counter values are not correct as the incremental values are less
than package energy counter values.

Thanks,
Srinivas

> 
> thanks,
> rui
> 
> On Thu, 2020-03-26 at 03:15 -0700, Kenneth R. Crudup wrote:
> > So I just tested a few shutdown vs. reboot cycles, and if I reboot,
> > I
> > only
> > get three counters. If I shutdown, then restart, I get 4 counters
> > (including
> > the "psys domain" one).
> > 
> > I tried it on a few kernels, including the oldest one that comes
> > with
> > my
> > distro (5.3.0-40-generic) where all the RAPL stuff is made as
> > modules.
> > 
> > So, maybe we're not "clearing" (wild guess here) the "psys" RAPL on
> > a
> > reboot,
> > something that would happen on a cold boot? (I'm afraid to say the
> > "B-word",
> > as that would mean it's a Dell issue so I won't hold my breath
> > waiting for
> > a fix).
> > 
> > 	-Kenny
> > 


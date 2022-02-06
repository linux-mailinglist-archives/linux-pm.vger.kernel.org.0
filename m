Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2221B4AAE7A
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 09:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiBFIff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 03:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFIfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 03:35:34 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 00:35:33 PST
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34BC06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 00:35:33 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,347,1635199200"; 
   d="scan'208";a="5130966"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 09:34:27 +0100
Date:   Sun, 6 Feb 2022 09:34:26 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Zhang Rui <rui.zhang@intel.com>
cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: DRAM power consumption with turbostat
In-Reply-To: <44a1ea665bad28a8e2d314427d9c50c214e1a436.camel@intel.com>
Message-ID: <alpine.DEB.2.22.394.2202060933280.3126@hadrien>
References: <alpine.DEB.2.22.394.2201301121380.3109@hadrien> <44a1ea665bad28a8e2d314427d9c50c214e1a436.camel@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Sun, 6 Feb 2022, Zhang Rui wrote:

> Hi, Julia,
>
> Thanks for reporting this.
>
> On Sun, 2022-01-30 at 11:27 +0100, Julia Lawall wrote:
> > Hello,
> >
> > I was wondering whether the DRAM power consumption reported by
> > turbostat
> > is reliable on recent Intel machines?
> >
> > In particular, I observed that turbostat reported a high DRAM energy
> > comsumption on a machine (Intel 5128)
>
> are you sure it is 5128? google tells me that 5128 is pretty old, in
> around 2006.

Oops!  5218

Thanks for the pointer to the new version.  I will try that.

julia

>
> can you please paste the lscpu output?
>
> >  with persistent memory, but where
> > the persistent memory was not being used.  A colleague did an
> > experiemnt
> > on another machine with persistent memory, and reported:
> >
> > -----
> >
> > I didn't run the test on troll but on another server equipped with PM
> > where I was able to reproduce the bug and by reading directly the msr
> > registers, I see that:
> > CPU Energy units = 0.00006104J
> > DRAM Energy units = 0.00001526J
> >
> > However turbostat assumes that the DRAM  Energy units is 0.00006104J
> > when
> > it runs the computation to obtain Joules (hence the too-high value
> > returned by turbostat)
>
> And can you please try latest version of turbostat?
>
> The problem should be fixed by the below commit
>
> commit abdc75ab53b7fd2ef42c79e88cf0caf2d007c4f2
> Author:     Zhang Rui <rui.zhang@intel.com>
> AuthorDate: Thu Mar 11 10:05:13 2021 +0800
> Commit:     Len Brown <len.brown@intel.com>
> CommitDate: Tue May 4 18:23:14 2021 -0400
>
>     tools/power turbostat: Fix DRAM Energy Unit on SKX
>
>     SKX uses fixed DRAM Energy Unit, just like HSX and BDX.
>
>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
>
> thanks,
> rui
> >
> > -----
> >
> > I see the code in turbostat that just uses the CPU energy units value
> > (rapl_dram_energy_units_probe), but I don't know what was the MSR
> > used to
> > collect the above information.  Overall, I am wondering if the DRAM
> > energy
> > consumption values are reliable in cases with and without persistent
> > memory.
> >
> > thanks,
> > julia
>
>

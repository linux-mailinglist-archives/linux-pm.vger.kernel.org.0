Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6315456ED
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 00:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiFIWLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFIWK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 18:10:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFBF1DA7F
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654812657; x=1686348657;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlgEJEZzzL/zrxg16ECWHa6MAYYtCFSvHiqQtEQNXdc=;
  b=clm++tIxLgyBAlxWSVnEa0hYZimFub8JL5TieR0Ejy9IDwbW058yi39A
   7MKo2NIQ7oAO0aVWl7RAkY50CWCj2RoWk5ZikmPfSnD0ChaIWPe9iEBH/
   YaPBOlGGZe2X9p4jmIHL/uoVU/krnRRBPBq9TslIDd9Qlk2A5NLN855p6
   fxmBT1pVtwULB3JDpm5Dn1Bu3uP0eSY3+QPAmbb4DARBVmr+rK50lqsXn
   aH1O7fh/okjhhMmvnVNfG1WMLRh5hXsNaJ/bGoaDz26tneL4/Cze4BLiG
   jf3TnutOJ/Uy9H9E+sd2OVKben4oSA5oxs5bFHDati/LEvchf7ULCMody
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="260555960"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="260555960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 15:10:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="616113447"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 15:10:57 -0700
Message-ID: <448c7f1d3adbdc9c8eb71bba0ff7b547535d0e76.camel@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Sworo, George D" <george.d.sworo@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Thu, 09 Jun 2022 15:10:57 -0700
In-Reply-To: <abfe8223dd06766d4297cbef0728c84f1e7d3aed.camel@intel.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
         <4060997f422b18a01eca3c8d0d17b39fef7e9e5e.camel@linux.intel.com>
         <abfe8223dd06766d4297cbef0728c84f1e7d3aed.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2022-06-09 at 21:47 +0000, Sworo, George D wrote:
> On Thu, 2022-06-09 at 14:02 -0700, srinivas pandruvada wrote:
> > On Thu, 2022-06-09 at 20:55 +0200, Rafael J. Wysocki wrote:
> > > Rui, Srinivas, should I take this one?
> > > 
> > Yes.
> > 
> > Not sure if the RAPL-MMIO driver is loaded on this system.
> > 
> > George,
> > 
> > What is the output of
> > lspci -vv -s :0:4.0
> > 
> > If the device id is 0xA71D, then we have this change in the
> > upstream kernel. If not then we need to submit patch for that.
> > 
> > Thanks,
> > Srinivas
> > 
> Thanks for the quick review.
> 
> the device id is 0xA71D
We have upstream patch for this ID. So we are good.

Thanks,
Srinivas

>  is not avaible without this patch. But when
> add it i can see the ID. Below are the outputs
> 
> Output from a kernel without this patch:
> -------------------------------------
> localhost ~ # lspci -vv -s :0:4.0
> 00:04.0 Signal processing controller: Intel Corporation Alder Lake
> Innovation Platform Framework Processor Participant (rev 03)
>         Subsystem: Intel Corporation Device 7270
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> 
> Output with this patch added:
> ----------------------------------------
> localhost ~ # lspci -vv -s :0:4.0
> 00:04.0 Signal processing controller: Intel Corporation Device a71d
> 
> > > On Wed, Jun 1, 2022 at 9:22 PM <george.d.sworo@intel.com> wrote:
> > > > From: George D Sworo <george.d.sworo@intel.com>
> > > > 
> > > > Add RAPTORLAKE_P to the list of supported processor model in
> > > > the
> > > > Intel
> > > > 
> > > > RAPL power capping driver.
> > > > 
> > > > Signed-off-by: George D Sworo <george.d.sworo@intel.com>
> > > > ---
> > > >  drivers/powercap/intel_rapl_common.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > > b/drivers/powercap/intel_rapl_common.c
> > > > index a9c99d9e8b42..21d624f9f5fb 100644
> > > > --- a/drivers/powercap/intel_rapl_common.c
> > > > +++ b/drivers/powercap/intel_rapl_common.c
> > > > @@ -1109,6 +1109,7 @@ static const struct x86_cpu_id rapl_ids[]
> > > > __initconst = {
> > > >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,        
> > > > &rapl_defaults_core),
> > > >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,        
> > > > &rapl_defaults_core),
> > > >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,         
> > > > &rapl_defaults_core),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,       
> > > > &rapl_defaults_core),
> > > >         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,   
> > > > &rapl_defaults_spr_server),
> > > >         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,          
> > > > &rapl_defaults_core),
> > > > 
> > > > --
> > > > 2.17.1
> > > > 



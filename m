Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252AA545618
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiFIVCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiFIVCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 17:02:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06917110998
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654808556; x=1686344556;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUd0oYR1V3vwSg2Hp0oCsnbCXabjqX6pLq9MGrTjDbo=;
  b=IFQ8jBxncX5yJLqqzs70zTykjFr2V+a6DXJY1AtOgll/tHSkRf1w1vrr
   3lI5ybdsumQtFNVkJBdUOVaeec646VujBmOxzDy7fzYuntYzPooh148t4
   lRgu/sdnPJPtSdMZRwy8WbuH9Cfpp7A5qNuozD0tSwXYweNBmlVp07m5C
   NKDU1cXN7n7CHQd2JJTJ8zgHtCXxYkbgBo7WfHhPl+GjeTQ/jrRfeL5lQ
   gJUah/k0SoHSk2K5BWj/+eNFZL1RpCsdf6dR3o7b33K3UtD7JY9LMsZ+u
   zQQZrp9hTZozOXGGRqsCrc+K2wVHTXRXN+0W18h+tfe+eLgJ4NrqjQ9NK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266189277"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="266189277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 14:02:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="760226132"
Received: from motahar-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.223.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 14:02:35 -0700
Message-ID: <4060997f422b18a01eca3c8d0d17b39fef7e9e5e.camel@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        George D Sworo <george.d.sworo@intel.com>
Date:   Thu, 09 Jun 2022 14:02:35 -0700
In-Reply-To: <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2022-06-09 at 20:55 +0200, Rafael J. Wysocki wrote:
> Rui, Srinivas, should I take this one?
> 
Yes.

Not sure if the RAPL-MMIO driver is loaded on this system.

George,

What is the output of
lspci -vv -s :0:4.0

If the device id is 0xA71D, then we have this change in the
upstream kernel. If not then we need to submit patch for that.

Thanks,
Srinivas

> On Wed, Jun 1, 2022 at 9:22 PM <george.d.sworo@intel.com> wrote:
> > 
> > From: George D Sworo <george.d.sworo@intel.com>
> > 
> > Add RAPTORLAKE_P to the list of supported processor model in the
> > Intel
> > 
> > RAPL power capping driver.
> > 
> > Signed-off-by: George D Sworo <george.d.sworo@intel.com>
> > ---
> >  drivers/powercap/intel_rapl_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index a9c99d9e8b42..21d624f9f5fb 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1109,6 +1109,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,        
> > &rapl_defaults_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,        
> > &rapl_defaults_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,         
> > &rapl_defaults_core),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,       
> > &rapl_defaults_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,   
> > &rapl_defaults_spr_server),
> >         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,          
> > &rapl_defaults_core),
> > 
> > --
> > 2.17.1
> > 


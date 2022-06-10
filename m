Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E53545A08
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiFJC1G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 22:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiFJC1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 22:27:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D779CC142
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654828024; x=1686364024;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YhopTnCL2tDWKi7DIPRXg+goFOsnmlIgLYpLyJ3v+c=;
  b=kQezF4c7C4mU1wjc0f9QzUhukSvpGnnHsudDDpmq4n7W19ibfXihO/yu
   Rfd7DgbiILbx7BkEh2yGuNwHvpqQn8boAYR5VJ8EhAVK7FKbR+Qtz2smE
   1tArGdjG20FkUQNCUtrWVH5xogdd8wUbnEeT963gEkchLbO28vNYU6VCj
   uxx3af9urRGMOvCJOfcFQDQmDShfIgiBNyzID4STudjrYiXt3LZkm9StC
   Js55WqzUZEoSoR/nG/dTE9z9XqcOHdyywvz3GGu1m3Zkc6wJzN0zmkkqc
   rn3vruNV/DEFEQFGWWG14ilDD5Vo/A5FdWlLtxgtuAitZQVUOh9f1GPZs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275013018"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="275013018"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:27:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="671618576"
Received: from xueqianz-mobl.ccr.corp.intel.com ([10.249.172.254])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:27:02 -0700
Message-ID: <13a8ee34a67ec8a59e926c91894365e8d512d260.camel@intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        George D Sworo <george.d.sworo@intel.com>
Date:   Fri, 10 Jun 2022 10:26:58 +0800
In-Reply-To: <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2022-06-09 at 20:55 +0200, Rafael J. Wysocki wrote:
> Rui, Srinivas, should I take this one?

Sorry that I missed this one.

George,

Have this patch been tested yet?
I have the same patch internally, it should work but I haven't got
chance to test it yet.

thanks,
rui
> 
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
> >  drivers/powercap/intel_rapl_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index a9c99d9e8b42..21d624f9f5fb 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1109,6 +1109,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl_defau
> > lts_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &rapl_defau
> > lts_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defau
> > lts_core),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defau
> > lts_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defau
> > lts_spr_server),
> >         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defau
> > lts_core),
> > 
> > --
> > 2.17.1
> > 


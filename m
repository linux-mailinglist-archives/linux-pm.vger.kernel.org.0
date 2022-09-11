Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2615B4B8B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 06:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIKEIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 00:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKEIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 00:08:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36237FB5
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 21:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662869314; x=1694405314;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H1XO7fvDoNPhGNJLdO7pJ2Bmf8jk2VIr1Y2CNiymtl8=;
  b=I0gZhRHaZySAV9H5jrLzpn4wL74sjFgRhq5Jc2oi35uwSI1+8PUnjTpv
   i+t+5eGZ/9iLIUDiMt2alpxMVTENoLHDXgIvDWV6VqRFQXQR51rI0u/5c
   I5Lpo2fJUsav07idrhSey0Xy4/nNDPCFfZON7mUEOuQXul8ErCorQ5/tU
   VscPSUVIHMGwfIGjaO2kw7vFqxaBfhbTvPl+6gfbUT8EnHmFXcyFHmmf4
   IEgwdRh82YePQZkS5PUvL+EzrtEQrE/dQAzEQrnHd69NvsK3iIUbdfGO3
   xdQstCzWRrv6M1upDsU6A0OMnetegU9EDzi9Ir1PKfA7yawToqAdbY3cc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="297692501"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="297692501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 21:08:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="566800664"
Received: from clee6-mobl2.gar.corp.intel.com ([10.214.162.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 21:08:30 -0700
Message-ID: <abe9bd8ca3620dae94b8788b62af53862f97c0f6.camel@intel.com>
Subject: Re: [PATCH 1/2] powercap: intel_rapl: Add support for MeteorLake
 platforms
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Sun, 11 Sep 2022 12:08:18 +0800
In-Reply-To: <CAJZ5v0hPh21mgTLT6jZf4=bZqNbsLqFnu41j9G3K5TTo3=YKHQ@mail.gmail.com>
References: <20220910131542.22708-1-rui.zhang@intel.com>
         <CAJZ5v0hPh21mgTLT6jZf4=bZqNbsLqFnu41j9G3K5TTo3=YKHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2022-09-10 at 18:44 +0200, Rafael J. Wysocki wrote:
> On Sat, Sep 10, 2022 at 3:12 PM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > Add intel_rapl support for the MeteorLake platforms, which behave
> > the
> > same as RaptorLake platforms.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> > 
> > Note:
> > This patch depends on commit 5515d21c6817
> > ("x86/cpu: Add CPU model numbers for Meteor Lake") in the
> > x86/urgent
> > branch of tip tree.
> 
> So I think I will have to rebase the powercap branch on top of a
> future -rc in order to apply this one.

Yeah, or we can wait for the next release cycle as this is not that
urgent.

thanks,
rui
> 
> > Note:
> > This patch is made on top of commit 0d7a23b5f8e1
> > ("powercap: intel_rapl: Add support for RAPTORLAKE_S") in the
> > linux-next branch of pm tree to avoid conflict.
> > 
> > ---
> >  drivers/powercap/intel_rapl_common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 6812c1ca3100..949eb90f5733 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1111,6 +1111,8 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defau
> > lts_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defau
> > lts_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &rapl_defau
> > lts_core),
> > +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          &rapl_defau
> > lts_core),
> > +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,        &rapl_defau
> > lts_core),
> >         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defau
> > lts_spr_server),
> >         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defau
> > lts_core),
> > 
> > --


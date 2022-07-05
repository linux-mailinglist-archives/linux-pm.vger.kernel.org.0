Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4A56770E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 21:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiGETBS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiGETBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 15:01:17 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55A15720
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 12:01:17 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id j7so17138899ybj.10
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 12:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFwX1lQi7AlluT7gMykPTwku2LsEkqkTmjUoPw22FjU=;
        b=2efOFqJOgZ2oUfBfJnI5URwq1sGRNju+6+b1GZEhl9/fZGus7p5QZMWvcHKa9PBw8c
         H6A29MzOgAXG2AM8CUAQtQ3HKbkmlka7Ga0vBtdM4bXoXna0tJSP8uRfbxPs5k2ruzkR
         yiZlIKdzUuzeAn156mzPIqRUbGpSfgrdi6wdEfRX+udJzGO9p/BaruMGIC7LzSEIBIVo
         cpSIgRYmdYATk9lpvB9n8LDIcIHDuSDtajgD77tb0QdoIrGa9sh30SgCeGxBr3PMiDPn
         xSxcG3isw83zsCq2GOOyEmCKHqtdRsDwUx26Z8RvSnhJMaScn+7fFqkFYSuNBoTTjO4A
         xvkw==
X-Gm-Message-State: AJIora+/xMkjuBFGbUvrfo123h0+5+QJs5TeQg3E7xtp6536qp2E/yFf
        YFc3byYesfuQg/1bZMh02uKUkesrZh3CuYnjIev6LeZH
X-Google-Smtp-Source: AGRyM1v3INo9bFEDoj5u7gFb8ODeCcLFzez6rCJ4Al8gc3x08ARKgxpZ+uvkMW4gKeIht2+93SPUMMt/5idPVN8vrZw=
X-Received: by 2002:a25:9847:0:b0:669:b4c6:d081 with SMTP id
 k7-20020a259847000000b00669b4c6d081mr37927326ybo.633.1657047676064; Tue, 05
 Jul 2022 12:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220601192216.9174-1-george.d.sworo@intel.com>
 <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
 <13a8ee34a67ec8a59e926c91894365e8d512d260.camel@intel.com>
 <de55f764d1f91594d2abd61b9058ccbe45cf8035.camel@intel.com>
 <CY4PR1101MB2184428049D89C064419CE8FBBB39@CY4PR1101MB2184.namprd11.prod.outlook.com>
 <2883de49cd4a8698c8c3cd3104daa9fbbb3300cd.camel@intel.com>
In-Reply-To: <2883de49cd4a8698c8c3cd3104daa9fbbb3300cd.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 21:01:05 +0200
Message-ID: <CAJZ5v0i+xGF+zEoHOmiGjKd7wk88p9pTQRbzn89LtD8-Bh41oA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
To:     "Sworo, George D" <george.d.sworo@intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 21, 2022 at 9:22 PM Sworo, George D
<george.d.sworo@intel.com> wrote:
>
> On Tue, 2022-06-21 at 14:49 +0000, Pawnikar, Sumeet R wrote:
> > > -----Original Message-----
> > > From: Sworo, George D <george.d.sworo@intel.com>
> > > Sent: Friday, June 10, 2022 9:02 AM
> > > To: Zhang, Rui <rui.zhang@intel.com>;
> > > srinivas.pandruvada@linux.intel.com;
> > > rafael@kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Subject: Re: [PATCH] powercap: intel_rapl: Add support for
> > > RAPTORLAKE_P
> > >
> > > On Fri, 2022-06-10 at 10:26 +0800, Zhang Rui wrote:
> > > > On Thu, 2022-06-09 at 20:55 +0200, Rafael J. Wysocki wrote:
> > > > > Rui, Srinivas, should I take this one?
> > > >
> > > > Sorry that I missed this one.
> > > >
> > > > George,
> > > >
> > > > Have this patch been tested yet?
> > > yes. This is tested on RPL SOC. Thanks
> > > > I have the same patch internally, it should work but I haven't
> > > > got
> > > > chance to test it yet.
> > > >
> > > > thanks,
> > > > rui
> > > > > On Wed, Jun 1, 2022 at 9:22 PM <george.d.sworo@intel.com>
> > > > > wrote:
> > > > > > From: George D Sworo <george.d.sworo@intel.com>
> > > > > >
> > > > > > Add RAPTORLAKE_P to the list of supported processor model in
> > > > > > the
> > > > > > Intel
> > > > > >
> > > > > > RAPL power capping driver.
> > > > > >
> > > > > > Signed-off-by: George D Sworo <george.d.sworo@intel.com>
> >
> > Hi George,
> > Thank you for this patch.
> > I have tested this on Raptor Lake system and it works.
> >
> > Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> >
> > Thanks,
> > Sumeet.
> >
> Thanks Sumeet for confirming!
> @Rafael, let me know if you have further comments

I've applied the patch as 5.20 material with a couple of minor edits
in the changelog.

Thanks!


> > > > > > ---
> > > > > >  drivers/powercap/intel_rapl_common.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > > > > b/drivers/powercap/intel_rapl_common.c
> > > > > > index a9c99d9e8b42..21d624f9f5fb 100644
> > > > > > --- a/drivers/powercap/intel_rapl_common.c
> > > > > > +++ b/drivers/powercap/intel_rapl_common.c
> > > > > > @@ -1109,6 +1109,7 @@ static const struct x86_cpu_id
> > > > > > rapl_ids[]
> > > > > > __initconst = {
> > > > > >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl
> > > > > > _def
> > > > > > au
> > > > > > lts_core),
> > > > > >         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &rapl
> > > > > > _def
> > > > > > au
> > > > > > lts_core),
> > > > > >         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl
> > > > > > _def
> > > > > > au
> > > > > > lts_core),
> > > > > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl
> > > > > > _def
> > > > > > au
> > > > > > lts_core),
> > > > > >         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl
> > > > > > _def
> > > > > > au
> > > > > > lts_spr_server),
> > > > > >         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl
> > > > > > _def
> > > > > > au
> > > > > > lts_core),
> > > > > >
> > > > > > --
> > > > > > 2.17.1
> > > > > >

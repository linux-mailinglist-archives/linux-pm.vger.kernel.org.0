Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90465AC09A
	for <lists+linux-pm@lfdr.de>; Sat,  3 Sep 2022 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiICSWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Sep 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiICSWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Sep 2022 14:22:23 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A24E85A
        for <linux-pm@vger.kernel.org>; Sat,  3 Sep 2022 11:22:22 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-324ec5a9e97so41330947b3.7
        for <linux-pm@vger.kernel.org>; Sat, 03 Sep 2022 11:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F8zhM+daxg1TLdqJQ/5eX5qsWSvgSM2N0WFzuAiR1qg=;
        b=nohdoowA2ySNpQgi5cZ2m1r89WlhXOh4+ZuzFKpJOiAMtysd/jbP5rUtXmvfw73P0d
         fC1HhW78bnVbkgnGrvGnt8K6w2xGwpMcG3GoLpkxV038wSZL34nfVG0ZDfLEUAnG18ZC
         3/gULJwgXVsq7gyvK0Har/gfjjQrQzkdr0gXi3GSNdvaabV/Z8cjMTK6uupDrVfUcxZB
         +04mYf9WOvRa4gzmuSstw+Ay2/TAxvA75uyu1eVhCq+TvC5pX4ci2QeoFDbtFqL0YqVp
         YkAyjoGUsnr/TI4rTz+WoXML5oxk9f+KgQ6xkovG5C0zJC4e4k7RSWxSqADIN1TDL5BR
         jg1g==
X-Gm-Message-State: ACgBeo2n/ujnHp8wHnCAknX4JPOiB9CgOupKeGSlB4vt3+8FiEk7ugLQ
        uwTTXR3k69gs0Y4G5qmbuBIY24Ukr8CmcEk+JD9a2eIC
X-Google-Smtp-Source: AA6agR7Zhcptt+7Qd0JMwhDHa1+VHY27xMuK2lIH3LxX+A5fzohchfb2iZYydSn1eMJyRROVvkigBo2mBdU6Gy/ElyQ=
X-Received: by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr32609564ywe.196.1662229342174; Sat, 03
 Sep 2022 11:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830030134.8111-1-rui.zhang@intel.com> <efe3eb3d0ad53d58ebd1a54cb5b3a27fdaec3487.camel@intel.com>
In-Reply-To: <efe3eb3d0ad53d58ebd1a54cb5b3a27fdaec3487.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:22:11 +0200
Message-ID: <CAJZ5v0gJLyS_fUpXhNC6Pr42aD5S+-t+SfRKDsXvGBMbOCmVCQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_S
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Tue, Aug 30, 2022 at 5:01 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Note that this patch depends on commit
> ea902bcc1943 ("x86/cpu: Add new Raptor Lake CPU model number") which
> was merged in 6.0-rc3.
>
> thanks,
> rui
>
> On Tue, 2022-08-30 at 11:01 +0800, Zhang Rui wrote:
> > Add intel_rapl support for RAPTORLAKE_S platform, which behaves the
> > same
> > as RAPTORLAKE and RAPTORLAKE_P platforms.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/powercap/intel_rapl_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 21d624f9f5fb..6812c1ca3100 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1110,6 +1110,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_
> > core),
> > +     X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &rapl_defaults_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_default
> > s_spr_server),
> >       X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_default
> > s_core),
> >

Applied as 6.1 material, on top of 6.0-rc3.

Thanks!

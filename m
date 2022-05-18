Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6C52C28E
	for <lists+linux-pm@lfdr.de>; Wed, 18 May 2022 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiERSml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbiERSmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 14:42:40 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52511C6CAB
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 11:42:39 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id p139so5173215ybc.11
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dkZRRnbKX4PaTjPiK1vxh1uWm0aJQCKVz65l8JNT/g=;
        b=BUpoJEORx3jwBWyazAGNxZacnPmMJIYvLaRhrLHP6s9QeCLzygAm0IX/gg8R/ncwwT
         uybfFh+ioooApqGoQ+LeGjIzvJbbmWg61Z/ulbsjia8LEIGl05O4dl/9r3wKfAMpLTUa
         X8PrOYD8MVDRwgdYtL/chwoCJwX7I1E7exhxZ8vie7RQ5TMJjv8wOZhl7mBAF6gZDX7U
         QDWzVz/r2s3MKFmchm+MT9BFHJ3t3FjKfwZbADZA0/hZsoknF8pRM4FhrzGU1vWe/9pf
         NtMO4GGk0BjGILK/VBk2NJMlUwc/LQWJ4h0eThgzFyqS4nIMmzg70keqU+4etiMXE13I
         a5OQ==
X-Gm-Message-State: AOAM533KSBA6LHQ6TlPFabpmMW00s0wDLcFeeICs85tm0G/g4bx8laon
        LsYXWULJ2Nz57S9iuuFMQAHqMAr+hF49mBcMBJYYuyj6
X-Google-Smtp-Source: ABdhPJyrCjGvS07QSWN+ydI9d+JTx8untg3rT0EjwkaA78UuheE8HGEaYBimbrOSs8M5ISjuMoexj2UUtETZnX8bamY=
X-Received: by 2002:a25:c6:0:b0:64d:8a54:d45c with SMTP id 189-20020a2500c6000000b0064d8a54d45cmr1020428yba.153.1652899358952;
 Wed, 18 May 2022 11:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220513050040.3387524-1-rui.zhang@intel.com> <4868e0731ded53d1a51c46a2338f206657aa50b9.camel@intel.com>
In-Reply-To: <4868e0731ded53d1a51c46a2338f206657aa50b9.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 20:42:28 +0200
Message-ID: <CAJZ5v0i_fNF_TrYYgCScFptjv07dgB3-mEN6ZTEs5sxFKumFnA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: add support for ALDERLAKE_N
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

On Fri, May 13, 2022 at 7:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Hi, Rafael,
>
> Forgot to mention, this patch is made on top of this commit
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/drivers/powercap/intel_rapl_common.c?h=linux-next&id=ae0dc7ed1a7c713ee9ba563a328d3b4d59223d7c
> in your linux-next branch.
>
> thanks,
> rui
>
> On Fri, 2022-05-13 at 13:00 +0800, Zhang Rui wrote:
> > Add intel_rapl support for the ALDERLAKE_N platform.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/powercap/intel_rapl_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 83da499dd6ec..e45c1c3b0cae 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1107,6 +1107,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >       X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl_default
> > s_core),
> > +     X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_default
> > s_core),
> >       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_default
> > s_spr_server),
> >       X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_default
> > s_core),

Applied, thanks!

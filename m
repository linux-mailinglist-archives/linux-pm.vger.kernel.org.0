Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51276B3F7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHALzm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 1 Aug 2023 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHALzk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 07:55:40 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594C1722
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 04:55:39 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b9da57da6bso624928a34.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2023 04:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890939; x=1691495739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q36cQ7O+IuvRjOd/yqqUldTL07zW4xXdids3DoWR2G8=;
        b=LxGYJPcPQFujXBmBuVqMbMCt+2BHDalHGwNsWppKIs/7wJQoAMGRwooP3wzUt96qEv
         +epQUFu4Ih+cdlZOnehZfSu84pcIw/+kwjEJ9i98EOoRemXLMg5/Q2+GIq95NcDa6Fdb
         UnsLB+CDZr6AuBQ/40Y6vD4WYGGVuEtwOFzMyCyUuvJ86sJTk8+dvUGoKxiV+jNheHYa
         PnAEDJF/dz8AeSUOkZ2CqZjQ7iOnHGAY52HQnZyu8N9duXlUqoa3F+j3oiqW+NBsD8YY
         Gya1DcTgSR7aCT++KIPF5kB/sNnh3YYfd1T2uaRWJhYMqwUefASB9QMTBtlgIdnw4RjA
         GGMw==
X-Gm-Message-State: ABy/qLbgf73jRK07EsQu2Oe32GkVLOOJQRAZQ0DIfo8RNZDvmW19EXcf
        tDpkVSNG3cHcVqasJZ4uhChfJe2NQewan8SIzylTolOq
X-Google-Smtp-Source: APBJJlGAQ/9kUy4ht9MfeGKl7N+3cTuQrwBvfDj0fA+EN9rXqZjrFq0ey9CZYUwcql4Pe91HrYp3Fe7PqeRACG4dUyk=
X-Received: by 2002:a05:6870:c226:b0:1bb:4e18:f0b1 with SMTP id
 z38-20020a056870c22600b001bb4e18f0b1mr9059376oae.1.1690890938774; Tue, 01 Aug
 2023 04:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230407024759.2320858-1-xiongxin@kylinos.cn> <CAJZ5v0juDz6=P23NJ11mNCVBCjp_p3qNRFo0i8YqFBPUW9tkQQ@mail.gmail.com>
 <6a712fb99c97d24bffb602cc99dcd69e6fe41d74.camel@linux.intel.com>
In-Reply-To: <6a712fb99c97d24bffb602cc99dcd69e6fe41d74.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 13:55:27 +0200
Message-ID: <CAJZ5v0hbchynpDvW4sP-r3uC1sH6f25xGtoB8D0o+GYshou1eQ@mail.gmail.com>
Subject: Re: [v2] powercap: intel_rapl: Optimize rp->domains memory allocation
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        xiongxin <xiongxin@kylinos.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 25, 2023 at 1:16 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2023-05-24 at 18:40 +0200, Rafael J. Wysocki wrote:
> > On Fri, Apr 7, 2023 at 4:48 AM xiongxin <xiongxin@kylinos.cn> wrote:
> > >
> > > In the memory allocation of rp->domains in rapl_detect_domains(),
> > > there
> > > is an additional memory of struct rapl_domain allocated, optimize
> > > the
> > > code here to save sizeof(struct rapl_domain) bytes of memory.
> > >
> > > Test in Intel NUC (i5-1135G7).
> > >
> > > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> > > Tested-by: xiongxin <xiongxin@kylinos.cn>
> > > ---
> > >
> > > v2: The extra memory will never be used, so can directly remove
> > > '+1'.
> > >
> > >  drivers/powercap/intel_rapl_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > b/drivers/powercap/intel_rapl_common.c
> > > index 8970c7b80884..a766d6e43c34 100644
> > > --- a/drivers/powercap/intel_rapl_common.c
> > > +++ b/drivers/powercap/intel_rapl_common.c
> > > @@ -1319,7 +1319,7 @@ static int rapl_detect_domains(struct
> > > rapl_package *rp, int cpu)
> > >         }
> > >         pr_debug("found %d domains on %s\n", rp->nr_domains, rp-
> > > >name);
> > >
> > > -       rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct
> > > rapl_domain),
> > > +       rp->domains = kcalloc(rp->nr_domains, sizeof(struct
> > > rapl_domain),
> > >                               GFP_KERNEL);
> > >         if (!rp->domains)
> > >                 return -ENOMEM;
> > > --
> >
> > Srinivas, is this OK, or does it miss anything?
> Looks good.
>
> Reviewed-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>

Thanks!

So queued up as 6.6 material, thanks!

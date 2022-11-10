Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548E862446D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Nov 2022 15:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiKJOfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 09:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKJOfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 09:35:24 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCDCD9
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 06:35:23 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id fz10so996861qtb.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 06:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqNgPn+I6CyA3TY4PApytTiqIBnEPtT6dZ4uCHT36l4=;
        b=8MlUSQNPtjnJUdXTigLg7XRE1qTRHFK96aiY0BtCWhaEneX9DFobrPeg4anzUp+FT6
         TmXWfo6ENCUygZ3Q+/Pf/Gzx6MAacKFR5hHWDNB/x0S+nq64uucocRrXLT2IC0BYwATm
         aBTWrJmn5waMJRbAof066yyBkwlvjOuA0Yg0t1P+73ZAuJzE3A8D0Zrg5sup/cMGnhki
         pO5y/uOI7PEBhnR0Ec8jglwBOX0PK5dBycq8czROt5buAoNW4VT2fwPLT4WXb6Qn+XHW
         PVw/XRofeYLGcii3o18CyttdImvpJbmEvUb/K9VXpbeowSW56TPr8au4/ncPSFCnaA9v
         IMmQ==
X-Gm-Message-State: ACrzQf31BcHS1LQhOFP3lHLXXtP4yN5slXlM+a1Odxp/8XMfLGCsqj4D
        EkLfuJ+XOGpJ0FL5KcHd2pNeh3a0SNiPAfMeMpU=
X-Google-Smtp-Source: AMsMyM7efHNfhrVFsPlR9y+J7B9cMZeThflJN2iGOMRgzbWp0idUFxxNH624jCleaq990S2CLCBpny2Xei5FVvX6tdM=
X-Received: by 2002:a05:622a:4c07:b0:3a5:27ec:6dd3 with SMTP id
 ey7-20020a05622a4c0700b003a527ec6dd3mr44163275qtb.411.1668090922126; Thu, 10
 Nov 2022 06:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20221031142017.26750-1-luoxueqin66@gmail.com> <CAJZ5v0g1JU=Se2yPW2z9_PHCJ=CE6NAmP1cFTJbK9oitwiWQSw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g1JU=Se2yPW2z9_PHCJ=CE6NAmP1cFTJbK9oitwiWQSw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 15:35:11 +0100
Message-ID: <CAJZ5v0iw0REm47_NbnY1v5Pk=LDbPkkB2Xnw74tCL=nv3VxLVA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/power : add pr_err() for debugging "Error -14
 resuming" error
To:     Luo Xueqin <luoxueqin66@gmail.com>
Cc:     pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        xiongxin@kylinos.cn, Xueqin Luo <luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 10, 2022 at 3:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Oct 31, 2022 at 3:20 PM Luo Xueqin <luoxueqin66@gmail.com> wrote:
> >
> > From: Xueqin Luo <luoxueqin@kylinos.cn>
> >
> > The system memory map can change over a hibernation-restore cycle due
> > to a defect in the platform firmware, and some of the page frames used
> > by the kernel before hibernation may not be available any more during
> > the subsequent restore which leads to the error below.
> >
> > [  T357] PM: Image loading progress:   0%
> > [  T357] PM: Read 2681596 kbytes in 0.03 seconds (89386.53 MB/s)
> > [  T357] PM: Error -14 resuming
> > [  T357] PM: Failed to load hibernation image, recovering.
> > [  T357] PM: Basic memory bitmaps freed
> > [  T357] OOM killer enabled.
> > [  T357] Restarting tasks ... done.
> > [  T357] PM: resume from hibernation failed (-14)
> > [  T357] PM: Hibernation image not present or could not be loaded.
> >
> > So, by adding an Error message to the unpack () function, you can quickly
> > navigate to the Error page number and analyze the cause when an "Error -14
> > resuming" error occurs in S4. This can save developers the cost of
> > debugging time.
> >
> > Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> > ---
> >
> > v2: Modify the commit message and pr_err() function output
> >
> >  kernel/power/snapshot.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 2a406753af90..2be2e9f5a060 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -2259,10 +2259,13 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
> >                 if (unlikely(buf[j] == BM_END_OF_MAP))
> >                         break;
> >
> > -               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
> > +               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
> >                         memory_bm_set_bit(bm, buf[j]);
> > -               else
> > +               } else {
> > +                       if (!pfn_valid(buf[j]))
> > +                               pr_err("The page frame number: %lx is not valid.\n", buf[j]);
>
> What about printing this message instead:
>
> pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
> page_address(pfn_to_page(buf[j])));

Actually, this should be

pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
PFN_PHYS(buf[j])));

>
> >                         return -EFAULT;
> > +               }
> >         }
> >
> >         return 0;
> > --
> > 2.25.1
> >

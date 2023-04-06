Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435166D9395
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDFKFA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 6 Apr 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjDFKE6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 06:04:58 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB18A69
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 03:04:31 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id g18so40565ejx.7
        for <linux-pm@vger.kernel.org>; Thu, 06 Apr 2023 03:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680775465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++/XeHR7esiJtCSVGhB/ZCmtwjp+N0bD+dxVzVUERpY=;
        b=5Ujx5cRsxp3R66HmWx+TleuWV2s3o6w/cgayTaksEHltJwJajcNsMU6lojz2smwMEN
         PSriSopuGbmkMimg88Wji4TkmVpe5TGndgfAC80ted4IUvuzTyHQDso9KYmBvJ+yuwnl
         VLUi18mWMGs0dcKG48WRLhngOdkQCJZo6ticlxxzIC53crJhnKIlsEacChjVDzxefFMR
         1tezCGtAHUUF8H5SpDYOrUN6UY8r8ntq8qoWbU18yIvNGkDQkIuSOerj+Wu7hBa9Rvji
         1u9Z/rBbKJD38V99eMubRiUYPupWl58H0htCfQtG1WR3pJUToUX1nqFC16iYnxrgxc5R
         P5cA==
X-Gm-Message-State: AAQBX9chlxOHFOeke2ktnRDwL2tLrVgHvoXQYo/LnGzp+kxJ2h9nwwCv
        XqhV6IQOw30sgSsrwgNOiNNkh9A3C1aqvGFRyQY=
X-Google-Smtp-Source: AKy350bij/7gQZDIpdJlW9U2nmyRQZwQdq0Di5oKTevTWtRxYI3s6aRG4Wu4bIYx2TtyT339PS8vdV2gmCBOYPeDxXY=
X-Received: by 2002:a17:907:3f92:b0:934:b5d6:14d0 with SMTP id
 hr18-20020a1709073f9200b00934b5d614d0mr3466134ejc.2.1680775465370; Thu, 06
 Apr 2023 03:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230404083656.713825-1-xiongxin@kylinos.cn> <CAJZ5v0g+yrmCH0o2-ezCNmoXe24ooA4U-JAWD4xNXsjT9XBwyQ@mail.gmail.com>
 <4cfb3dd3-e564-49ff-aad8-ee4d8587b689@kylinos.cn>
In-Reply-To: <4cfb3dd3-e564-49ff-aad8-ee4d8587b689@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Apr 2023 12:04:13 +0200
Message-ID: <CAJZ5v0hU2Ua0Ls1LWhRr6wCoXfETKRYGRUPrko6cZ_8yWDCYjg@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Optimize rp->domains memory allocation
To:     TGSP <xiongxin@kylinos.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 6, 2023 at 3:23 AM TGSP <xiongxin@kylinos.cn> wrote:
>
> 在 2023/4/5 00:30, Rafael J. Wysocki 写道:
> > On Tue, Apr 4, 2023 at 10:37 AM xiongxin <xiongxin@kylinos.cn> wrote:
> >>
> >> In the memory allocation of rp->domains in rapl_detect_domains(), there
> >> is an additional memory of struct rapl_domain allocated to prevent the
> >> pointer out of bounds called later.
> >>
> >> Optimize the code here to save sizeof(struct rapl_domain) bytes of
> >> memory.
> >>
> >> Test in Intel NUC (i5-1135G7).
> >>
> >> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> >> Tested-by: xiongxin <xiongxin@kylinos.cn>
> >> ---
> >>   drivers/powercap/intel_rapl_common.c | 15 ++++++++-------
> >>   1 file changed, 8 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> >> index 8970c7b80884..f8971282498a 100644
> >> --- a/drivers/powercap/intel_rapl_common.c
> >> +++ b/drivers/powercap/intel_rapl_common.c
> >> @@ -1171,13 +1171,14 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
> >>   {
> >>          struct rapl_domain *rd;
> >>          struct powercap_zone *power_zone = NULL;
> >> -       int nr_pl, ret;
> >> +       int nr_pl, ret, i;
> >>
> >>          /* Update the domain data of the new package */
> >>          rapl_update_domain_data(rp);
> >>
> >>          /* first we register package domain as the parent zone */
> >> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
> >> +       for (i = 0; i < rp->nr_domains; i++) {
> >> +               rd = &rp->domains[i];
> >>                  if (rd->id == RAPL_DOMAIN_PACKAGE) {
> >>                          nr_pl = find_nr_power_limit(rd);
> >>                          pr_debug("register package domain %s\n", rp->name);
> >> @@ -1201,8 +1202,9 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
> >>                  return -ENODEV;
> >>          }
> >>          /* now register domains as children of the socket/package */
> >> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
> >> +       for (i = 0; i < rp->nr_domains; i++) {
> >>                  struct powercap_zone *parent = rp->power_zone;
> >> +               rd = &rp->domains[i];
> >>
> >>                  if (rd->id == RAPL_DOMAIN_PACKAGE)
> >>                          continue;
> >> @@ -1302,7 +1304,6 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
> >>    */
> >>   static int rapl_detect_domains(struct rapl_package *rp, int cpu)
> >>   {
> >> -       struct rapl_domain *rd;
> >>          int i;
> >>
> >>          for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
> >> @@ -1319,15 +1320,15 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
> >>          }
> >>          pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
> >>
> >> -       rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
> >> +       rp->domains = kcalloc(rp->nr_domains, sizeof(struct rapl_domain),
> >>                                GFP_KERNEL);
> >
> > Why can't you modify just the above statement alone?  What would break
> > if you did that?
> At the beginning, I just didn't understand what this '+1' was for, but
> contacting the for loop behind, here '+1', just because the rd pointer
> will not point outside the memory of 'rp->domains' before the for loop
> exits.
>
> if '+1' is to prevent the invalidation of the rd pointer, and apply for
> an additional struct rapl_domains here, then my patch may not be
> completely modified.
>
> >
> >>          if (!rp->domains)
> >>                  return -ENOMEM;
> >>
> >>          rapl_init_domains(rp);
> >>
> >> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++)
> >> -               rapl_detect_powerlimit(rd);
>
> If '+1' is directly removed, before the for loop exits, the rd pointer
> has already pointed to outside the memory of rp->domains.

But that value is never dereferenced AFAICS.

> >> +       for (i = 0; i < rp->nr_domains; i++)
> >> +               rapl_detect_powerlimit(&rp->domains[i]);
> >>
> >>          return 0;
> >>   }
> >> --

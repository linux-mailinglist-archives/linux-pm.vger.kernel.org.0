Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3672CD3F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjFLRwy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 12 Jun 2023 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjFLRwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 13:52:53 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AFA1;
        Mon, 12 Jun 2023 10:52:52 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9786c0cbfdcso91025866b.1;
        Mon, 12 Jun 2023 10:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592371; x=1689184371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk5mQxl2Lpjp+K7mqJY5Aj4l1gdZbnDRwMCKsWpujRY=;
        b=Mlp7vCKwljcNFXsE3qa/dsHFg89saq7o66k9p8LAKuda4r7gVQ49cjFPhlr7+d+B2k
         bPIK+4b5k4yb0a0kin+4nstiXuSBF2QAvPzEp28UvOhHxurrCqQ7RS8bxmRV58bbQaSL
         i7dYSlMs/TPVqb1f7OyjPG12aoDG49ujzhlroBQ1ee7oda+psSwgfIn+JfQb16Ow429E
         +HDe+u5rFps7YzMg1Yhjru2qONjyJ6ZEOI1bSW645RAQ97XPMe3S1h7fmxTFntklZl8c
         djyliF0F7xXoXJpg3g2UC1k5UXxoFSANt1ntfVaQ8lnm+zxPlSJ/x2geKulo2UiPaKsi
         RRVQ==
X-Gm-Message-State: AC+VfDwPAOPNpEaf8GWrA7HD2/VYSFoq+lmGPcL2WIQnNxYTeyDM0uH6
        ax/2JgdTghgbWgOBUfE3lwjfX4ARN6MQVmJ5iDA=
X-Google-Smtp-Source: ACHHUZ7998Mx5vp8Vnwc4ktkHdel4mSdRHJKDrBT7+1hHRITf7dFRi+nWDK2oSxVOdcUTpTj2X2KHDjc0/pheTKucbo=
X-Received: by 2002:a17:906:290:b0:953:2918:71e7 with SMTP id
 16-20020a170906029000b00953291871e7mr8905394ejf.5.1686592371143; Mon, 12 Jun
 2023 10:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZH7s0qNJ8a/KHjvQ@moroto> <8e34bb46e770408efd5b207fb293af7c06832a94.camel@intel.com>
In-Reply-To: <8e34bb46e770408efd5b207fb293af7c06832a94.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:52:40 +0200
Message-ID: <CAJZ5v0g+ZqEp8a9CZtyp4uijd_MP5T+Q1fia-qPD55T2Hhs05g@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix a NULL vs IS_ERR() bug
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 6, 2023 at 10:56 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Tue, 2023-06-06 at 11:22 +0300, Dan Carpenter wrote:
> > The devm_ioremap_resource() function returns error pointers on error,
> > it never returns NULL.  Update the check accordingly.
> >
> > Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI
> > interface driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied as 6.5 material, thanks!

> > ---
> >  drivers/powercap/intel_rapl_tpmi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/powercap/intel_rapl_tpmi.c
> > b/drivers/powercap/intel_rapl_tpmi.c
> > index c016127b3497..4f4f13ded225 100644
> > --- a/drivers/powercap/intel_rapl_tpmi.c
> > +++ b/drivers/powercap/intel_rapl_tpmi.c
> > @@ -255,8 +255,8 @@ static int intel_rapl_tpmi_probe(struct
> > auxiliary_device *auxdev,
> >         }
> >
> >         trp->base = devm_ioremap_resource(&auxdev->dev, res);
> > -       if (!trp->base) {
> > -               ret = -ENOMEM;
> > +       if (IS_ERR(trp->base)) {
> > +               ret = PTR_ERR(trp->base);
> >                 goto err;
> >         }
> >
>

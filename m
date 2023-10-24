Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F9B7D5018
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjJXMnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 08:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjJXMnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 08:43:06 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39AFCC
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 05:43:03 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7dafb659cso44245587b3.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698151383; x=1698756183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SpleMM8m0jhcaDqQyFBGrVtoZ5P9DdEhN73hgpeUdeU=;
        b=x9rBmMf92SL+q4i9iPGd8ZuKZnKp5vuJPxHi6kqZdMYkpwvMhNlvmwEOVnPB75+/V+
         DHtU0hbEU724e4+zUDBJ9tgqyqOsuSBOeYV64p2fNLF5zI5WOrP5g86V4iduHC/b9wSa
         yy20c3XpITSopxgoGMYzCUX3uqdFsCAMyD1rGn/mhIopj1p4nUCx9VzlahJZ0K5N/Mxb
         MowezdD8ULI6migHWeup+dqKbAr89v/QDMaVZCn0CNt7cdtlUKgP7h9xl+lC4Wy+PrE7
         5uB/UKWcKnCpMzOvn/fyyVDkUtSVTE4//qg5DoX5WHfMvXNh3uoV14UmW7bN/BQtLNaF
         eLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151383; x=1698756183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpleMM8m0jhcaDqQyFBGrVtoZ5P9DdEhN73hgpeUdeU=;
        b=eC8jalmm5E18W+TPtb2Mc3xQ+GIzlNiI2kHG0vAOZuyVmwOQbDau6+akkYPKNozDdQ
         Tzr65OYiqEydN9kzpWNCp7RRTm9q1eGicT0p4SgBZWvintpGaK/XiKgKkTLburhNn8We
         Lu+lUeBwMeYzfhSYRxQp8jq7E7KmxmiVr+nDCgT9QnoEedGp6EektSH8N1ACdxoFDpxI
         Tcfe98QyAKEov/jgkkFeeT4Jkat71vlczLHCcEGNpNbkC8F+cKMKbF+Cuu4xAf36K6pw
         Am1J3t214o+JLqKAa1IOsXw1/dd9FUnEmGUFcGWY4vOwPYzH+TjbHcOj0J6M/JZq9aJb
         Y2rA==
X-Gm-Message-State: AOJu0YxrZjedu3jOjDb+xMcNxDcVsJHIRAJBegq94NU7L2B/YTNq0n8c
        pQZ3AvWwp7wxtpdXa1n2t3otJ1nuUHRCMqYMiSbUQnqTBGPrVznGsAE=
X-Google-Smtp-Source: AGHT+IGGgX/6oQ68HkEwX7+eUPIekYr5wxkrHPNG/iThTFv8mea0//UFej5TCruAcAZcVLbdSohXOC99BIaf7c2cXpk=
X-Received: by 2002:a81:bb43:0:b0:5a9:27c8:edbc with SMTP id
 a3-20020a81bb43000000b005a927c8edbcmr7536843ywl.28.1698151382830; Tue, 24 Oct
 2023 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132214.257207-1-emkan@prevas.dk> <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
 <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
 <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2> <CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9ATGpemxvcc8mtL86g@mail.gmail.com>
In-Reply-To: <CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9ATGpemxvcc8mtL86g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Oct 2023 14:42:26 +0200
Message-ID: <CAPDyKFotwRPBLpOe6q86b7JhS8t36wP2wvn2hid5uZ-57J9Ytw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
To:     festevam@gmail.com, Emil Kronborg Andersen <emkan@prevas.dk>,
        Pengfei Li <pengfei.li_1@nxp.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Pengfei Li

On Tue, 17 Oct 2023 at 12:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 17 Oct 2023 at 10:00, Emil Kronborg Andersen <emkan@prevas.dk> wrote:
> >
> > Hi Ulf,
> >
> > On Mon, Oct 16, 2023 at 11:53 +0200, Ulf Hansson wrote:
> > > Unfortunately, it's not that easy. It's not required by
> > > pm_genpd_init() (or of_genpd_add_provider_*) to use a struct *device
> > > when registering a genpd provider. In fact, that's also the reason why
> > > pm_genpd_init() needs to initialize its own struct device.
> >
> > Do you see any way to do it properly at pmdomain level instead, or is
> > that not feasible? I agree with Saravana that a centralized solution,
> > akin to what was implemented for tty devices in commit 1a5ecc73b2bf
> > ("serdev: Set fwnode for serdev devices"), would be ideal. However, I
> > was not able to find other reports or patches of problems regarding
> > fw_devlink at pmdomain level, so it might not be a general problem here,
> > and fixes per driver might be okay in this case?
>
> Sure, we could fix it though a centralized solution, but it requires
> us to patch each and every genpd provider driver too. At this point I
> would therefore say, let's just fix it for those that need it.
>
> >
> > > That said, can you please explain the special condition that caused
> > > this thing to be needed in the first place?
> >
> > I noticed this issue when I updated from 5.15.93 to 6.1.37. Except for
> > the commit I bisected, i.e., 3fb16866b51d ("driver core: fw_devlink:
> > Make cycle detection more robust"), I found that the issue was
> > introduced somewhere between 6.1.16 and 6.1.15. Here, some commits
> > regarding fw_devlink was backported, which might be relevant:
> >
> > $ git log --oneline v6.1.15..v6.1.16 -- drivers/base/core.c | grep fw_devlink
> > 11d93294b7c3 driver core: fw_devlink: Avoid spurious error message
> > 3dd596616d10 driver core: fw_devlink: Make cycle detection more robust
> > a3c171751512 driver core: fw_devlink: Improve check for fwnode with no device/driver
> > 7a8ce4d2fbbc driver core: fw_devlink: Consolidate device link flag computation
> > 16aa2487cf15 driver core: fw_devlink: Allow marking a fwnode link as being part of a cycle
> > eaf9b5612a47 driver core: fw_devlink: Don't purge child fwnode's consumer links
> > 2455b81afe68 driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
>
> Thanks for sharing the commits. I haven't looked much closer to them,
> but maybe Saravana has some ideas about whether this potentially can
> be fixed in the fw_devlink parsing instead?

I had a bit closer look at this. If I understand things correctly,
this problem is because the imx_gpc_driver's ->probe() (imx_gpc_probe)
is allocating/adding a new platform device, per child-of-node to
represent a power-domain.

I suspect in most other cases where a platform device is being
allocated per child node, is when the child node has a
compatible-string and the parent driver is calling
of_platform_populate(), or similar. In those cases, the "dev.fwnode"
would be set accordingly, but not in the imx_gpc_driver case as it
needs to be set explicitly.

That said, it looks like we should move forward with the $subject
patch. However, it looks like the patch [1] from Pengfei Li is more
correct than the $subject patch.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20231020185949.537083-1-pengfei.li_1@nxp.com/

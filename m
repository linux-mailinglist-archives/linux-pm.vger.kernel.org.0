Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B97D7106
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJYPgd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYPgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 11:36:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73942136
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 08:36:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c7262d5eso57902227b3.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698248189; x=1698852989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m5aG2kcj/gzSuQIJp+50pi5/4/8aKwFFMZ9BHteXapM=;
        b=AT7jZDn3RJEV3a6K5n3pcq2q9ZSH0F3Nft7Nv5gLekYgMkhVH+fdnSdeJ7gp33HCZ6
         4eIfwSYdDfZZmTSHnx0FFIMBWGQG2OP//7qjfodnl8bc+aqcS0BHhcfNu3ULAaKmn0Tt
         u5WQYD39XEo769U29836K+wocW54K1lsVibLtP1O8qnSPEuP9M/702nUaWodVJB5yAB/
         9tLGOucLHDMTDjZ8yIP8qPfVxwC24oOkGltBAzuI1V++oOHPFIBRg6eM6ra09uumMn5j
         71dn5dgShRJ/JcKHHFHOLfDRKyChXArihpsf4QLQCzQdXYPPVOcoPRUzkpX9JYZIQ6Vi
         ACEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248189; x=1698852989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5aG2kcj/gzSuQIJp+50pi5/4/8aKwFFMZ9BHteXapM=;
        b=pNYwecalacwqMjPZPPO+DSm5TR/Ti9KA4HKGOIdH4Cj3oHlIwbuypZyxWzE49SwXFQ
         fL90h46rFlV9zKBHR6AjiBRU6Av8RjvGsXMLp6AQvi0A8DEy99SuAtxUA2ipTijtKLL+
         6TL3sfp4a9FD0XAQ3pszdaFiAiAUg+yL/ws+bmt5qLwGpdguc1Tz2l933XfL5iJARPJ7
         aQWJBahhapmJ048EPofuUXquJah5ZeLPXu73mt5RxETG15EIJ/LGF0B3HIqgY7eiw65+
         3EvmqWionimHfrtasUlO5TGjr6B3m/zw/tJWDd4id6u1xjGUQSA7LVqm/mAsi/KdOuR0
         4vGA==
X-Gm-Message-State: AOJu0YwvSWCK/7RcWkGDgJCubfKpNFd9ccSJ7TGge7ra7m/AYBo/HgDS
        dhUox3+PO4IM8xL85drJhyRQOV3bVhnRhgYm/wKomA==
X-Google-Smtp-Source: AGHT+IErzJaQp0MmnTtxqePxF7meHNj3cKaB8ijukeX40b3F8jxWGNXuxPEzN8ao8l3g9hPEzy91wCxNh2V+VykAbWY=
X-Received: by 2002:a81:a1c9:0:b0:595:887f:e180 with SMTP id
 y192-20020a81a1c9000000b00595887fe180mr16292147ywg.40.1698248189639; Wed, 25
 Oct 2023 08:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132214.257207-1-emkan@prevas.dk> <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
 <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
 <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2>
 <CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9ATGpemxvcc8mtL86g@mail.gmail.com>
 <CAPDyKFotwRPBLpOe6q86b7JhS8t36wP2wvn2hid5uZ-57J9Ytw@mail.gmail.com> <3jw4nompbmwfigjetvob6pxxac56tbavifzvf3kbvsubtvxwvk@oskzm5ihpc74>
In-Reply-To: <3jw4nompbmwfigjetvob6pxxac56tbavifzvf3kbvsubtvxwvk@oskzm5ihpc74>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Oct 2023 17:35:53 +0200
Message-ID: <CAPDyKFo+sa7xutrpLs0avceV3Ybd6koUkEhBXV6FTAhpPG7A_g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
To:     Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     festevam@gmail.com, Pengfei Li <pengfei.li_1@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Oct 2023 at 12:12, Emil Kronborg Andersen <emkan@prevas.dk> wrote:
>
> On Tue, Oct 24, 2023 at 14:42 +0200, Ulf Hansson wrote:
> > I had a bit closer look at this. If I understand things correctly,
> > this problem is because the imx_gpc_driver's ->probe() (imx_gpc_probe)
> > is allocating/adding a new platform device, per child-of-node to
> > represent a power-domain.
> >
> > I suspect in most other cases where a platform device is being
> > allocated per child node, is when the child node has a
> > compatible-string and the parent driver is calling
> > of_platform_populate(), or similar. In those cases, the "dev.fwnode"
> > would be set accordingly, but not in the imx_gpc_driver case as it
> > needs to be set explicitly.
> >
> > That said, it looks like we should move forward with the $subject
> > patch. However, it looks like the patch [1] from Pengfei Li is more
> > correct than the $subject patch.
> >
> > Kind regards
> > Uffe
> >
> > [1]
> > https://lore.kernel.org/all/20231020185949.537083-1-pengfei.li_1@nxp.com/
>
> That is also how I understand it works.
>
> I was unsure if the patch from Pengfei Li [1] solves the same issue as
> this patch, since there are no errors included in the commit message.
> However, after testing the patch in [1], I can confirm that it fixes:
>
> [    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) with 20c8000.anatop:regulator-vddpu
>
> I based my solution on other patches, where device_set_node() is used.
> For example, a26cc2934331 ("drm/mipi-dsi: Set the fwnode for
> mipi_dsi_device") and 6dbe6c07f94f ("gpio: Propagate firmware node from
> a parent"). I am curious: Why is the approach in [1] considered more
> correct? It seems logical to set the fwnode as early as possible from
> the parent its device.

Why do we want to use the parent's node? The devices (platform-device)
that we allocate belongs to the corresponding parsed child node,
doesn't it?

Kind regards
Uffe

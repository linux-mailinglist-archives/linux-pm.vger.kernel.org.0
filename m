Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF047D84A5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjJZO1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 10:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZO1c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 10:27:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CD128
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 07:27:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso676708276.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698330449; x=1698935249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EIua5hiq7Ss/snyDGyH3jPMUL/d7t9Mf97skCzkhvrc=;
        b=FtgeCOAbxObRYXwFhRvdqzG0KPduASBB9v6ZJS9EFQLtXrW2gROzG2RnogTBa/sick
         XKgq0tQ7FBk4wji4JVdNeDQkHNXZN2k+lX8uFPviROukrBelBdAHc70sIp+GQrQgA8+x
         o3HOrZHp01WSzt/WoP6ImYLPsM4lufmLQTMxiPuK1oME+HeAtBlPRd3VJ+eLk3EVLuci
         rsDACjzl5ltixzYh8RfsXhpS8YbXkOq6BM46hWo7NUWaU2ByVYWjJxuVxotk2E2JduS7
         hjXtGlOeI8zGpalLPqTIoUxGkEYxIkcy6phTEBQ4pB/YPv3rmZF1gbsW1XQxQWWFZPC2
         1wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330449; x=1698935249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIua5hiq7Ss/snyDGyH3jPMUL/d7t9Mf97skCzkhvrc=;
        b=lr5v7OfoL0d7UjMEhEVHopMeG545mZ/n/y91iLxGFwCMxQtY4XBxFmdgzl13mMsVl3
         VDgKDb/3/tFYe0dF4Ky3Fd6z8d0akm8XjjLLMETbf1SJPUtZfnEkHo//5bE5g666E9uW
         oRm3bBs+XuRLBJhXLxdCEt9XN/mQt8hn53e5Pow8a8kcAs47puHm6Ad2Tp87V9t+b+R7
         +mcxXMQnoL0pLfYdMYxnvs0g+bHngNR83SVpXt0cyof9wYgRZbPOBCTH8t+oUD5cRyDq
         ewVLiXGMtO2Qc6rqcdhvwWo5yPPrpYHcFeg4gYCrjG1hMXObLp3wUcZFdLuJSBp9c8zA
         eSNw==
X-Gm-Message-State: AOJu0YxQWIajBw/aVTNiU+fg5l8xruqoqeygcT9jPAYhRbL4FPZLpK0H
        s3j0y7d6LaAwLZ5zvHz3BSpqxHmAIdMhB4ezMRdIyg==
X-Google-Smtp-Source: AGHT+IGl0kMJiIHVgiKxB0yAdsTyFDDToHMGbI+mtD1CScPU20O/2PCND5ja9EcQGuq+JNqqtL7movH9VvK1ot0Fvu4=
X-Received: by 2002:a5b:651:0:b0:da0:76eb:3d31 with SMTP id
 o17-20020a5b0651000000b00da076eb3d31mr4793177ybq.15.1698330449175; Thu, 26
 Oct 2023 07:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231020185949.537083-1-pengfei.li_1@nxp.com> <hm4ae2dr234wvrcjqkltmudlxqybkpommqewkfqqdo47s6jffi@swy7wtro7rdy>
In-Reply-To: <hm4ae2dr234wvrcjqkltmudlxqybkpommqewkfqqdo47s6jffi@swy7wtro7rdy>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Oct 2023 16:26:53 +0200
Message-ID: <CAPDyKFoRMHEO-cvq_gz25kKn-HtDXJYYM784ie+oDuxuQNtRYw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: Make imx pgc power domain also set the fwnode
To:     Pengfei Li <pengfei.li_1@nxp.com>,
        Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linus.walleij@linaro.org,
        rafael@kernel.org, heiko@sntech.de, robh@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Oct 2023 at 09:54, Emil Kronborg Andersen <emkan@prevas.dk> wrote:
>
> On Sat, Oct 21, 2023 at 02:59 +0800, Pengfei Li wrote:
> > Currently, The imx pgc power domain doesn't set the fwnode
> > pointer, which results in supply regulator device can't get
> > consumer imx pgc power domain device from fwnode when creating
> > a link.
> >
> > This causes the driver core to instead try to create a link
> > between the parent gpc device of imx pgc power domain device and
> > supply regulator device. However, at this point, the gpc device
> > has already been bound, and the link creation will fail. So adding
> > the fwnode pointer to the imx pgc power domain device will fix
> > this issue.
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > ---
> >  drivers/pmdomain/imx/gpc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> > index 114f44ca07dd..7d81e3171d39 100644
> > --- a/drivers/pmdomain/imx/gpc.c
> > +++ b/drivers/pmdomain/imx/gpc.c
> > @@ -497,6 +497,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
> >
> >                       pd_pdev->dev.parent = &pdev->dev;
> >                       pd_pdev->dev.of_node = np;
> > +                     pd_pdev->dev.fwnode = of_fwnode_handle(np);
> >
> >                       ret = platform_device_add(pd_pdev);
> >                       if (ret) {
> > --
> > 2.34.1
>
> I originally proposed [1] to address errors like the one below:
>
> [    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) with 20c8000.anatop:regulator-vddpu
>
> I tested this patch on an i.MX 6Quad board, and it also fixes these
> errors.
>
> Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>
>
> [1]
> https://lore.kernel.org/linux-arm-kernel/20231012132214.257207-1-emkan@prevas.dk/T/
>
> Best regards,
> Emil

Okay, so I decided to pick this one for fixes, instead of [1] as it
looks like it's ready to be applied as is. I added a fixes/stable tag
to it too.

Kind regards
Uffe

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D517CA491
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjJPJx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJPJx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 05:53:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F29DE
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 02:53:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a84204e7aeso23018867b3.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697450035; x=1698054835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3pZnRFJywOxqklLsUp6XbBpT9hgWVXHMP5XbLP8M5I=;
        b=tOSamBolxwCq7+Unb871H3Lw8rPthAYWRnHYcnSsRIItHDlTptxPVoBFuq8IDx+fLm
         nPxsSY3iyoALXut8VJ/6leu/YghnkvZOLFyFjBNSXiASkOplttTGHjckJNazC+f/MxQw
         UKzJe7/0trlmpeCffvWLLIzA9l2SDmbwn7dMzkgDxQu9+hLbgLdgCY0jY+dp94OkP7LK
         GUI4t1j/JAsGLBfpYtjlSpB6Hzg3xcx5Fr8dOWfKmxgRo7seZEsO4VEIAVJ/lh0TRqAG
         +Itj67f7U3nj1xzfS8m2Qj7/1nsxWRYZrXVSyuRb0PLXkK29wfsJUbVHCBy7/vINOB/c
         1+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450035; x=1698054835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3pZnRFJywOxqklLsUp6XbBpT9hgWVXHMP5XbLP8M5I=;
        b=nxggf8LoL+40ugW3m5C7SZ+yXVXbJ5hi3wBexdR416n3P6H8XVPH4aN0QYWWQ4hm35
         i7M7/EFwnnHIm5n0fyl/+ONjl1YvdB22sguDwmv4nAhhwK8FkL4fcBfr5v3n40yrxVFl
         YGHTIo+9GWRLDxYzg8iVU93oDxzUyco/jnwnBy8xe5QfDh1O87Yu5wtSTCQA5N9Pd429
         zdTCDWd80WrXlOXn/iSCZsWziJA7BwXR3cPZNGNadzZYcPDZPUyCFHw7plM2/yRor2iz
         CTUGHklI+M80C9dS75tWUN1E3bzUMDbDLT2CM90HTfrTYKzRFozm/4FPtD2wqMW2OzuN
         PtjA==
X-Gm-Message-State: AOJu0YxzCwf2vKi3lr/fk6rVRIPWGsdfS2FxUEELJ6gBj+rZOtkvpaz6
        2hCHDKs3T9TpaUiSTYFLDW59LQBBwZ9SpuHSFSexKA==
X-Google-Smtp-Source: AGHT+IECYJnjD+K0XEeZVGVq+LhBVcqbnl+K4+LOsgPYbYpmbwZin/4QjIyraZOk2BbCqMnRJVClQNceURVcwYd2Usc=
X-Received: by 2002:a25:1105:0:b0:d9a:4772:48c6 with SMTP id
 5-20020a251105000000b00d9a477248c6mr16905981ybr.38.1697450035698; Mon, 16 Oct
 2023 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132214.257207-1-emkan@prevas.dk> <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
In-Reply-To: <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 11:53:19 +0200
Message-ID: <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
To:     Emil Kronborg Andersen <emkan@prevas.dk>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 13 Oct 2023 at 23:30, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Oct 12, 2023 at 6:22=E2=80=AFAM Emil Kronborg Andersen <emkan@pre=
vas.dk> wrote:
> >
> > Before commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > detection more robust"), consumer devices without their fwnode set
> > printed errors like the one below:
> >
> > [    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180=
) with 20c8000.anatop:regulator-vddpu
> >
> > To fix this, set the fwnode so fw_devlink can find and handle it
> > properly.
> >
> > Signed-off-by: Emil Kronborg Andersen <emkan@prevas.dk>
> > ---
> >  drivers/pmdomain/imx/gpc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> > index 90a8b2c0676f..8759eab72880 100644
> > --- a/drivers/pmdomain/imx/gpc.c
> > +++ b/drivers/pmdomain/imx/gpc.c
> > @@ -411,6 +411,8 @@ static int imx_gpc_probe(struct platform_device *pd=
ev)
> >         void __iomem *base;
> >         int ret;
> >
> > +       device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
> > +
>
> Similar question as the other patch. Can we do this at a pmdomain
> framework level instead of per driver?

Unfortunately, it's not that easy. It's not required by
pm_genpd_init() (or of_genpd_add_provider_*) to use a struct *device
when registering a genpd provider. In fact, that's also the reason why
pm_genpd_init() needs to initialize its own struct device.

That said, can you please explain the special condition that caused
this thing to be needed in the first place?

[...]

Kind regards
Uffe

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1320DF99
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbgF2UiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731730AbgF2TOU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:14:20 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FDC02A560
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 06:14:26 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id y7so3702760vkf.9
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUm1DqpGN5XmVYcQ9vlrW6bAWNxPJKNUBexoC8nS/Ds=;
        b=BT0/zl5XRxbuPrO7SatKs69j+FXHyw9zFUp0W6pCAVRFbuVWsW/4rz69J5XNFI7+XT
         rT8v/ZqOiYGqHBnb+pYZoAokisxWDuNC2q47a0XSkycGVxnMjNveTa7pj8XQ9gb/6CFt
         NTe7mK7rogiD669XOv416uCvsxR/XoJw7xJMyxmLhjwaLJKceTx+XS8Riw5PoJY4j/Y9
         BKTk0peACR14oHYIDFCn+Yk1mNwJgp4TuUGHzHSWj3bCyeliHFLJagaf1yzY6U9oROQC
         7dFa8Ozo9FTPibEn9J4pxoTfmbvJLelFDOrmIqC0ijrtPtMq+MHprK13S8XtQrd6KKvX
         Sgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUm1DqpGN5XmVYcQ9vlrW6bAWNxPJKNUBexoC8nS/Ds=;
        b=UFhJyK8onKn9Vqlmb0StV93biFTxySBb4F73HEyhNj21f5ft3ljoIE2JDL8tOXLJq9
         irqgm6+CIT6OvkKJ21q4X11wO+kY0TpbMkHUMv6C6uF3fVnSQ36pA05gZWSS99+iAfYt
         PT4qVDUIMfKcYJ+eFZzqKtRYjljuM/FBwS6ClDO6KrDn3etvj7bmhHjtIp91h7ok629d
         ZKpv34ofXxcoub2ftCL7S60y2UBpBojfWm1AyRcYPygrym+SzcZv6PmbCrZPUCQNETo0
         t7xEfMbI+NB4N4MQzXDOug8rzo9fwvVEv70UsOpWBK4v6rjfyMYlYOL5iO23U2JivUMN
         Er8Q==
X-Gm-Message-State: AOAM530vB5nv/q1cLFOZnXPQ5CQb3xDBckzrA/qLu6KIHOPy84XDI4sZ
        seUprFzVdR8i3V4xzNCy1d9J9QT+xb6R1UjRVBgPiw==
X-Google-Smtp-Source: ABdhPJwqjv8P1N2hkVCTPq8KPMs3rDIm5sBcQeK3WBhBYHmZo8sJWnzLMHUoFYfgRwa/6N4osQmIDHV/F2ze2jLTbgM=
X-Received: by 2002:a1f:d783:: with SMTP id o125mr10139104vkg.46.1593436464488;
 Mon, 29 Jun 2020 06:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <1590371941-25430-1-git-send-email-yangtiezhu@loongson.cn> <CADBw62pW3StqqAm-35zSsWkTo6040zDyEG1K2+tFzE9HxuaUFw@mail.gmail.com>
In-Reply-To: <CADBw62pW3StqqAm-35zSsWkTo6040zDyEG1K2+tFzE9HxuaUFw@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 29 Jun 2020 18:44:13 +0530
Message-ID: <CAHLCerNwEefUG+bbWw6pd-jpBau8p2qs0Sd9f1yzx2iisCv01w@mail.gmail.com>
Subject: Re: [PATCH] thermal: sprd: Fix return value of sprd_thm_probe()
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 29, 2020 at 7:55 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi,
>
> On Mon, May 25, 2020 at 10:00 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> > to check the return value and return PTR_ERR() if failed.
> >
> > Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Good catch. Thanks.
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> > ---
> >  drivers/thermal/sprd_thermal.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> > index a340374..4cde70d 100644
> > --- a/drivers/thermal/sprd_thermal.c
> > +++ b/drivers/thermal/sprd_thermal.c
> > @@ -348,8 +348,8 @@ static int sprd_thm_probe(struct platform_device *pdev)
> >
> >         thm->var_data = pdata;
> >         thm->base = devm_platform_ioremap_resource(pdev, 0);
> > -       if (!thm->base)
> > -               return -ENOMEM;
> > +       if (IS_ERR(thm->base))
> > +               return PTR_ERR(thm->base);
> >
> >         thm->nr_sensors = of_get_child_count(np);
> >         if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
> > --
> > 2.1.0
> >
>
>
> --
> Baolin Wang

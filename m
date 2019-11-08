Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A02F59CB
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 22:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfKHVXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 16:23:44 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44936 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKHVXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 16:23:44 -0500
Received: by mail-il1-f193.google.com with SMTP id i6so6364952ilr.11;
        Fri, 08 Nov 2019 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCOt2Rtumxvf/Biz+Vs4wvQqytGG66Sp0P52B5IVXcw=;
        b=hWT1qsvqdYiewCmdOmHSEMDeWIM+8pNjUsNBz/qCr7IroTCfl1cs27AODC7QjRIjzY
         owpslhoOcJnJAoygT9Yewln/sHZjpd+WUqoF+uA1/CNz7b6JZx+0QWd3amC2TSwcOeiv
         uPGhDMZLcYVlegyNUgxmG10Syz+QvrSBSQkjdUFnV+dwnCue0kyb2n4ImAQNzV/nInoi
         ncnJ+pCyEdBC7QJxJ9mMNXpWLzsczuvj5o6qQ0P3k29ulatzD0YQaeID/ute9DEzowbw
         FDjNRbllELYsu3jqzq8/Pzx/v8/jKaQzlqJataskqkBvRm7/olHyJv3FE6f+Q2BpMpvO
         cYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCOt2Rtumxvf/Biz+Vs4wvQqytGG66Sp0P52B5IVXcw=;
        b=uALbqfEsC+W29tR7yGemVptvkTIqRDWnFMFd3/DhSLcIdGl2WM6bJ6gb5Mi40tRiCw
         V7h4NnW1ydcflRo118Icf6He60PGpCvmp1vSosu5T6ZOlgo5ptdjQi5j+Eh0p3TT/ZKO
         PM+mYjGep9DYIzcjfR19MDxnMkavoiKovGnOrjLWxOBMyZua6SxhKuAiBWKxL3YRgwWz
         DVJzcAiO0xiF8kmSDsIKu/xUNCSJX4BMtJP0lRn6rwFJfTo+yxPkVP09amq71X8RsMGN
         yYS5EmEj5yXklzkIvSpn8IgOiZ/zYAuycu1QVzP+wZLsEmifqPOn/LJmfStLol1PEV6k
         e0Sw==
X-Gm-Message-State: APjAAAXav0+Psob8nHozroRK/yBC+Av5EWe3DtWqbIHv7RLFa+hxBzRP
        29Np+xOKJOQ9g3KQmbeUoazwZ8VRXfll+/TRrCw=
X-Google-Smtp-Source: APXvYqwzNYRYwEpdo5RlEzzhZ9LrBF3z1Xy1bKoz4OsjEJrlcSAsftBHl5mKd+SoT9fzNNGhzCyrlztUVdlSafiTG+8=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr14584088ilo.58.1573248223229;
 Fri, 08 Nov 2019 13:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20191108205954.20136-1-aford173@gmail.com> <20191108211717.GR5610@atomide.com>
In-Reply-To: <20191108211717.GR5610@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Nov 2019 15:23:32 -0600
Message-ID: <CAHCN7xL3h4r3eTmJj_+jEy0NPwkPfP8qjLpuNjjoKQkq9gqdow@mail.gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Enable addition power management
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <adam.ford@logicpd.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 8, 2019 at 3:17 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191108 21:00]:
> > +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> > +                               unsigned long cmd, void *v);
> >
> >  /***   Helper functions to access registers and their bitfields   ***/
> >
> > @@ -1025,6 +1033,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
> > +     cpu_pm_register_notifier(&bgp->nb);
> > +
>
> Hmm looks like you're missing the related call to
> cpu_pm_unregister_notifier(), right?

Good catch.  I'm new to this PM stuff.  :-)

>
> Other than that, it also works on droid4, so please
> feel free to add:

Awesome!

>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thank you.  I have already resent V2

adam

>

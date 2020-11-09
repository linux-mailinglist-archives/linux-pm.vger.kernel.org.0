Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4932AC03B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgKIPuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 10:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIPuX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 10:50:23 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51953C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 07:50:23 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id n189so1989231vkb.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L51XkjqpivDL+gi7hdK0mHKvFEWiUWHhaavhkjK/7JU=;
        b=s86ENdjB9rhqpZoOQ8WWqBcdYrSX1vetoclGIZsHeD49HUNoyWPcsE3zXlb4Ae0eeY
         lRZIrlJXJLjhNss47OPpcaibknEDzA6Ag9MqZEoq9DZoAed/D/yybS/RtrzMxKUav3Ir
         dXPrpr9UEqiLaeSs+SJku2M96DsLkC3pgUU4xqWLYyKFI9KJ2rL4Kwe/9jbZh5AdUL4b
         roSese/e8cR+yTfwE0bFAFoACk3jvYEynL+bnITfe5mI1xUrbjuJtdLSTXcsbvOCCh53
         /lWCb7nJmJ81+4NWW3kn6hyc/z8LmxeqjjwY/eHhYc9Y02OJjfYcYAb9GWDv48nWMQ8K
         K+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L51XkjqpivDL+gi7hdK0mHKvFEWiUWHhaavhkjK/7JU=;
        b=idPbTCMv+edpXBNa6pgkNNefYLJfp4glKyrBXuZoXDk7yNs5gXwp/j732HTM6vI4Tr
         PiHO5wsx6S01HlE/xlY9SoK4jY+sAzxb+RRe+w3VvuMriNZVJuTdhkreSeHHcwDptQ9S
         76eBPdSwCKTup4LpYi7jY90AC4bu76uPfhUKOTbWYfTHJ34ORJHTV+/5noYgc/a0lD8e
         uug94dFNZxyyirxqRa10OZvWRmJh/z/u+m8eUNhA0EjxM3K87DQqtnNJ2+z9lzWFTrYb
         UCLQFcHCdOlsJaeJt4d8jGmyAmvJ8Z+s1FKQbclCHyQBboCKyYobqMW82vDPF8kCP47A
         lGYg==
X-Gm-Message-State: AOAM530Dj72ftPOrp8tNkrDtFA41nqkJ5VgtmkUpARQBo2E8D63FGnoP
        c9H2BnDzKQ2mvnBbTT657Bz0jmYpWsA+lMYd0wQFqA==
X-Google-Smtp-Source: ABdhPJxXb6HXDuIXp7atH8WtlH14Ds4SLH9UNRivXFJAdlbKA6NSKdHmA03ggD7MLlBBqev5AyCx8q9UtTTEouBmAbA=
X-Received: by 2002:a1f:9682:: with SMTP id y124mr7471961vkd.6.1604937022457;
 Mon, 09 Nov 2020 07:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20201109150416.1877878-1-zhangqilong3@huawei.com>
 <20201109150416.1877878-2-zhangqilong3@huawei.com> <CAJZ5v0gGG4FeVfrFOYe1+axv78yh9vA4FAOsbLughbsQosP9-w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gGG4FeVfrFOYe1+axv78yh9vA4FAOsbLughbsQosP9-w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Nov 2020 16:49:45 +0100
Message-ID: <CAPDyKFr-XCAWKQiN29s-=XusqqPSqumK9wZVePT+5C7J43BKqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: runtime: Add a general runtime get sync
 operation to deal with usage counter
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Qilong <zhangqilong3@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fugang Duan <fugang.duan@nxp.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 9 Nov 2020 at 16:20, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 9, 2020 at 4:00 PM Zhang Qilong <zhangqilong3@huawei.com> wrote:
> >
> > In many case, we need to check return value of pm_runtime_get_sync, but
> > it brings a trouble to the usage counter processing. Many callers forget
> > to decrease the usage counter when it failed. It has been discussed a
> > lot[0][1]. So we add a function to deal with the usage counter for better
> > coding.
> >
> > [0]https://lkml.org/lkml/2020/6/14/88
> > [1]https://patchwork.ozlabs.org/project/linux-tegra/patch/20200520095148.10995-1-dinghao.liu@zju.edu.cn/
> > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> > ---
> >  include/linux/pm_runtime.h | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 4b708f4e8eed..6549ce764400 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -386,6 +386,36 @@ static inline int pm_runtime_get_sync(struct device *dev)
> >         return __pm_runtime_resume(dev, RPM_GET_PUT);
> >  }
> >
> > +/**
> > + * pm_runtime_general_get - Bump up usage counter of a device and resume it.
> > + * @dev: Target device.
> > + *
> > + * Increase runtime PM usage counter of @dev first, and carry out runtime-resume
> > + * of it synchronously. If __pm_runtime_resume return negative value(device is in
> > + * error state), we to need decrease the usage counter before it return. If
> > + * __pm_runtime_resume return positive value, it means the runtime of device has
> > + * already been in active state, and we let the new wrapper return zero instead.
> > + *
> > + * The possible return values of this function is zero or negative value.
> > + * zero:
> > + *    - it means resume succeeed or runtime of device has already been active, the
> > + *      runtime PM usage counter of @dev remains incremented.
> > + * negative:
> > + *    - it means failure and the runtime PM usage counter of @dev has been balanced.
>
> The kerneldoc above is kind of noisy and it is hard to figure out what
> the helper really does from it.
>
> You could basically say something like "Resume @dev synchronously and
> if that is successful, increment its runtime PM usage counter.  Return
> 0 if the runtime PM usage counter of @dev has been incremented or a
> negative error code otherwise."
>
> > + */
> > +static inline int pm_runtime_general_get(struct device *dev)
>
> What about pm_runtime_resume_and_get()?

We already have pm_runtime_get_if_active() - so perhaps
pm_runtime_get_if_suspended() could be an option as well?

>
> > +{
> > +       int ret = 0;
>
> This extra initialization is not necessary.
>
> You can initialize ret to the __pm_runtime_resume() return value right away.
>
> > +
> > +       ret = __pm_runtime_resume(dev, RPM_GET_PUT);
> > +       if (ret < 0) {
> > +               pm_runtime_put_noidle(dev);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
> >   * @dev: Target device.
> > --

Kind regards
Uffe

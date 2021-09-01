Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412DD3FE455
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 22:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhIAU5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhIAU5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 16:57:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE57C061764
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 13:56:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r4so1271205ybp.4
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0G6R62N1gO7DOjfEZAPNKqynBW5XZ5XNt6xZIMqank=;
        b=u4SEUsyX5hLbDNCYJrkK/Dq3ED5N6gzAoGqvPapHzprtM++i9ndf4lKuBAebuB3Xif
         VZH3nWhY/dR+Zs4fJg4ZZ6PoJ+tnml+weetYIwbOsyjJNbfwVCwsxvQaeXOrN7paZlo/
         vo5HRCSvtQ+mZgOd7pOwxXVXqGjVEbZNfbSow13HA2/Eq+58R82NmEKWnd4uArDPHtWw
         z0H1hH0zf19jG8Cs5DHbQR06BHcK+vrSD6lfIL8T7TmlXILI9qVAmsOP2nIQIlSXVDfG
         lTwOR4y7cyiLt4m8gld7ZI9Kj+iZS1kSOOKp4b6cyN567suVGHJLacrMqiRuxIevaT4o
         O3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0G6R62N1gO7DOjfEZAPNKqynBW5XZ5XNt6xZIMqank=;
        b=N6dDNQinHsjdpf1dvP8VxLUkH4iMEsj33a7XGOvAFGNuW+WSj5W1sW6UAYYt8MBOw3
         rF/BiEylwVae713lpum124JaGuAgVjMnL3v0igqQgGHo0u4P7rbS4ycTL5A3n2pNFHUZ
         WEOrm88bJ7DLQm3uvbB2CSaLoYnKZGP11wYDyjcWJPERIb5hBV8rX1ghWLwJizzihO/U
         rzJmFodKB9RrTLdRQcFB9cGG6cXXP0NnLY8C9F+DMsHiPJf33g3nG3YFQwPR1PCRWM35
         AK7ZQxInwGd7bv4R5D7PskcOaH7HxBKA/zLvkBk4dP9pmW0iP96oEmKQPWytfVvaKM0d
         xdjg==
X-Gm-Message-State: AOAM532VyL9ZzR921XwNSnfbnNkOYYRNlHSTb85KDvHq9LmH51EII5a4
        kFowS6h1CTzXgFaonRhBncTENXODIM7Uf2dejfe60g==
X-Google-Smtp-Source: ABdhPJzF7Zt72N0YmUtW1wz8l2WyJWxKJcMNBmyngHxWM/3Tu2UpcRUGekYR0bcdcfaQBUAjDifDWgmEvC0bo9QmANc=
X-Received: by 2002:a25:6746:: with SMTP id b67mr2325216ybc.96.1630529816125;
 Wed, 01 Sep 2021 13:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102125.624661-1-ulf.hansson@linaro.org>
 <CAGETcx868QWj0jMJ+U-eL62jT-LO_LTOw5EcwEKptfFOVa=A5A@mail.gmail.com> <CAPDyKFopTW=ZoB9FYJ-ozRZTnJDTT_gFtz0XDiU-weYb1Q9bkQ@mail.gmail.com>
In-Reply-To: <CAPDyKFopTW=ZoB9FYJ-ozRZTnJDTT_gFtz0XDiU-weYb1Q9bkQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 13:56:20 -0700
Message-ID: <CAGETcx_e7kCQ_0yC9=k1jzjJJEqdOMuA=JkD81=2-Nb4fcS0+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: property: fw_devlink: Rename 'node_not_dev' to 'optional_con_dev'
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 1, 2021 at 12:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 31 Aug 2021 at 19:31, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > In the struct supplier_bindings the member 'node_not_dev' is described as
> > > "The consumer node containing the property is never a device.", but that
> > > doesn't match the behaviour of the code in of_link_property().
> > >
> > > To make the behaviour consistent with the description, let's rename the
> > > member to "optional_con_dev" and clarify the corresponding comment.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/of/property.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 6c028632f425..2babb1807228 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1249,7 +1249,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> > >   * @parse_prop.index: For properties holding a list of phandles, this is the
> > >   *                   index into the list
> > >   * @optional: Describes whether a supplier is mandatory or not
> > > - * @node_not_dev: The consumer node containing the property is never a device.
> > > + * @optional_con_dev: The consumer node containing the property may not be a
> > > + *                   device, then try finding one from an ancestor node.
> >
> > Nak. This flag is not about "may not be". This is explicitly for
> > "never a device". It has to do with stuff like remote-endpoint which
> > is never listed under the root node of the device node. Your
> > documentation change is changing the meaning of the flag.
>
> Okay, fair enough.
>
> Although, as stated in the commit message this isn't the way code
> behaves. Shouldn't we at least make the behaviour consistent with the
> description of the 'node_not_dev' flag?

I know what you mean, but if you use the flag correctly (where the
phandle pointed to will never be a device with compatible property),
the existing code would work correctly. And since the flag is relevant
only in this file, it's easy to keep it correct. I'd just leave it as
is.

-Saravana


>
> Along the lines of the below patch then?
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Wed, 1 Sep 2021 09:28:03 +0200
> Subject: [PATCH] of: property: fw_devlink: Fixup behaviour when 'node_not_dev'
>  is set
>
> In the struct supplier_bindings the member 'node_not_dev' is described as
> "The consumer node containing the property is never a device.", but that is
> inconsistent with the behaviour of the code in of_link_property(), as it
> calls of_get_compat_node() that starts parsing for a compatible property,
> starting from the node it gets passed to it.
>
> Make the behaviour consistent with the description of the 'node_not_dev'
> flag, by passing the parent node to of_get_compat_node() instead.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/of/property.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6c028632f425..16ee017884b8 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1075,6 +1075,17 @@ static struct device_node
> *of_get_compat_node(struct device_node *np)
>         return np;
>  }
>
> +static struct device_node *of_get_compat_node_parent(struct device_node *np)
> +{
> +       struct device_node *parent, *node;
> +
> +       parent = of_get_parent(np);
> +       node = of_get_compat_node(parent);
> +       of_node_put(parent);
> +
> +       return node;
> +}
> +
>  /**
>   * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
>   * @con_np: consumer device tree node
> @@ -1416,7 +1427,7 @@ static int of_link_property(struct device_node
> *con_np, const char *prop_name)
>                         struct device_node *con_dev_np;
>
>                         con_dev_np = s->node_not_dev
> -                                       ? of_get_compat_node(con_np)
> +                                       ? of_get_compat_node_parent(con_np)
>                                         : of_node_get(con_np);
>                         matched = true;
>                         i++;
> --
> 2.25.1
>
> [...]
>
> Kind regards
> Uffe

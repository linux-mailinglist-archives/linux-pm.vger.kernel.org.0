Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F083FF21B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhIBRLI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346412AbhIBRLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 13:11:07 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0384C061575
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 10:10:08 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n126so5190812ybf.6
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNnGL/XFkRACc5/CvoRAa+dSZMwb3AAvxOKNDcBdSNM=;
        b=hEwlT3tYR2Y31bwXVcknM/ypCL0SfikclQ4C9fMYjRR1+rQmog4PK6nRvTQKh97yoQ
         s7Tg5N94Vr/J02byNanGEtllbrHrSb6RualdV5dxuVcNods1HVS2TVSNMZn+8a/W14PU
         g2y/1Wm73RdC8yZNDuv8cTRi9RQEL1St3o6XG4uzaruoIzKA9jBGbKbGSMsfVjypo6Y1
         vMPgZORq6yI29cWlIEtFRuHUXmkRh7ZfYD0UIpUvhoSFI6v6rE4mURxeN6qr6IA3ZVEY
         yHVLboNcPXLpTZqClnttBGFdLWekds8ZR0GDLgbvZoSZ3a9fGNTvcz2SLTjxP+gLIzTQ
         QCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNnGL/XFkRACc5/CvoRAa+dSZMwb3AAvxOKNDcBdSNM=;
        b=n4vQw1AvUihfaj3rG0Bs2LULCPos4dHs4GjacPSkubVEO9TzZfgiceD8+gK7KVdTgz
         G33zJeMmH+s7NcfqmQTKbPIPyRBITDEhUMcmVT/Keq52+GnA8mH33+IifaIn/sD2NZvS
         BQ2WrOYweQWU1TjviWXvmPwYLr9oRTqM0J0w3eVWFCPkMvjGIyUJ0RXXi8Z4c9ad0qNP
         8YwNlfGfyItI1t3j4Wqu5lnsKKGxg+RxUPR9PT3vKxU6AKPSvN0u/FoWmTZyWzJFBTAo
         YgSL3XVTVYwcAMiIRqumdxPCu7elbR3kIhc3fRkzL72WWEGgn0SyIsV/sjNaxJNS6fsQ
         /UvQ==
X-Gm-Message-State: AOAM532wtdeJk7IkaMS0pCT5w6S3EosxsrM2y8vrdeFqKzjytbSOSTL2
        qzUQ5lmAUG34jOl93whsgUtyJvLS4fGQmRQk5SuofA==
X-Google-Smtp-Source: ABdhPJz2YTSqz5EeiE5FHkhjNK+OPxgcJfPp1zoX7Cf/S0pbqfT5CJ+wPJareJf4D00vVRM27wfYnbzZFVmWZbdh5p0=
X-Received: by 2002:a5b:50b:: with SMTP id o11mr5830667ybp.466.1630602607975;
 Thu, 02 Sep 2021 10:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210902090221.820254-1-ulf.hansson@linaro.org>
In-Reply-To: <20210902090221.820254-1-ulf.hansson@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 10:09:32 -0700
Message-ID: <CAGETcx_TLhOf3tVZbWkM0-p8fs1kFUHWTULU3Hp_TBdtZWeZqg@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fixup behaviour when
 'node_not_dev' is set
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 2, 2021 at 2:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the struct supplier_bindings the member 'node_not_dev' is described as
> "The consumer node containing the property is never a device.", but that is
> inconsistent with the behaviour of the code in of_link_property(), as it
> calls of_get_compat_node() that starts parsing for a compatible property
> from the node it gets passed to it. The proper behaviour is to start at the
> node's parent, so let's do that.
>
> While at it, let's take the opportunity to update the description of the
> 'node_not_dev' flag, as to clarify its purpose.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  drivers/of/property.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6c028632f425..a94d007be416 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1075,6 +1075,17 @@ static struct device_node *of_get_compat_node(struct device_node *np)
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
> @@ -1249,7 +1260,9 @@ static struct device_node *parse_##fname(struct device_node *np,       \
>   * @parse_prop.index: For properties holding a list of phandles, this is the
>   *                   index into the list
>   * @optional: Describes whether a supplier is mandatory or not
> - * @node_not_dev: The consumer node containing the property is never a device.
> + * @node_not_dev: The consumer node containing the property is never converted
> + *               to a struct device. Instead, parse ancestor nodes for the
> + *               compatible property to find a node corresponding to a device.
>   *
>   * Returns:
>   * parse_prop() return values are
> @@ -1416,7 +1429,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
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

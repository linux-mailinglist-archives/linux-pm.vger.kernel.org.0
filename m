Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E855D455D38
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhKROFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 09:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhKROFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 09:05:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD9C061764
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 06:02:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b40so26590141lfv.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcvMf04a42I8nvaFKWnn+hHtsxzFN2+dQNetw5PDMV4=;
        b=rlt2VRwuJrLjMD1u62DODkASk5YQGVq12j1CL1oNN9gYt01TPAj0Z2gSttN4b9a1Cc
         PCCSwYuavb06GBpikMmt63YfO4B1XxUbhYS4dXw6M2bJhLBdCJvwj9HphwsQa3X/RWhM
         ZdyIL+2NzbvORZScEGLo6lM6RKV7YcF0WwzxQr43XIwYDamfHR9MILbrh3/ohNa1ZVqf
         h7yZOX5YV2kcwvyO20CAQDxUeTnz/uAKAbPgugaQONs1f2e8XZAPjl4DW8GIit+qeUG/
         15FMowfE1EAEnMprapgTN/DLppeLSdT07sLyWLoc6RS5Xz1J04WUuJeCdljo/JVrOOSh
         5Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcvMf04a42I8nvaFKWnn+hHtsxzFN2+dQNetw5PDMV4=;
        b=A45DAJuQw6nGDektGuWPrsHNbZEVQx9f0y0TOfHFSd8FsI5h4c69snzqfYDIkwgEWI
         fKWWfXrhHP9PFvMDDkhBm3qDtE/DTR6O+WUdq8BxdkonL0IKM2AQSBxaU4GQmE0tFDwU
         dQfXtq52vZoiwgbx6Ds81weEqSZBERGZwLP05OTDej1KyhCffPGbc0QuSjhL5ni+JeoD
         RbpGREyhDtnF+54wRrSULB+qg0uTdngSg+dzVuM/1uqze8n0d07qcmtGjjc+k/pMm8Bg
         VorBspktN8XBck5zlJ440XdFbYmIAowz+isZOTFZ1mbSVZK9py5shjY8twMJuXCPt3Oh
         cU9Q==
X-Gm-Message-State: AOAM533qcLTdiOFHjY0m4KVeMm0VdrEGjg8/y9Pz3RAaI7AYrBhyA1FW
        lNE5dJ2TdxAltB3l/b3fNwDJvqfZ19Z8mYv6FCCu4Q==
X-Google-Smtp-Source: ABdhPJwLhJuGAR+t56gMBcybZC15N2Oh5BbNKdeI9yWoV9VlHVR6e9tjjRqNJkVldiRcDTShHr5i/t/lVfJqI8EMZmg=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr24614147lfv.233.1637244162680;
 Thu, 18 Nov 2021 06:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20210902090221.820254-1-ulf.hansson@linaro.org>
In-Reply-To: <20210902090221.820254-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Nov 2021 15:02:06 +0100
Message-ID: <CAPDyKFqdjpT2fzpq7LGDotkzwruZ7OjKnkw=_O+2eV9bgdYvkQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fixup behaviour when
 'node_not_dev' is set
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2 Sept 2021 at 11:02, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

Rob, just a gentle reminder about this one. Should I perhaps resend?

Kind regards
Uffe

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

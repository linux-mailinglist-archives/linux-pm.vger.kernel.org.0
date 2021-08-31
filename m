Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041E63FCC5B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhHaRcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbhHaRcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 13:32:11 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5CC06179A
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 10:31:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r4so36640275ybp.4
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4HrFHUEESj2r5pg822WYUbEDh1E29PcEg+NUHp2lfY=;
        b=XQJTNcZ/Yns5Xw3Pexc1RyG8YNhEfpoB9JlfAMUFDwSIxjfonMb2yWiUc8J622xxwZ
         cnp9epbY6cGUQUeM3LnfNK8HqyCMdIAj1S6fi5TsfuqCq+ChjavGOcV561FQ3bFHHjJe
         CeVejYdqu5xT/crGfvd7oQw6VO3WrCa2rXYt3J6oGMaX17UbsndQqfJN70ZObGbKUK+K
         oTdta97PWiYl4+a6u7TBpzmFArGyVTX/L2FvMkdPObStd2mZLjsnRsXZoXUxsgutmC5A
         4RhYaejO2gx5+RHkSUD/N+tRJWPQqYyEaNW1h/HVpN3Dak2AeLvx4Kb7FgwDIiRqt9OO
         Rnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4HrFHUEESj2r5pg822WYUbEDh1E29PcEg+NUHp2lfY=;
        b=fhJm7qIkou2Z8ghr/G4PZr4zc1D94QJgkBtbvBrDYLYsohC8JSiGGBGRS8vHTE+h15
         eC+DaOxeCSwyxViU2ox+6v6xQHigiGyPn/Y0spCJQcpybZrM5VDS9AP4FE0n7YNCQfcg
         3nezbKTFdLZ0WNudLm8i+bhdr0nq/S532NdAd2/UbyfF8ta8Ko8sitqAhPWryJsOowe/
         +/tJZeo/0Lo3lK0/mhqPlQ6B1+Px1hfipBW6RBe+1RaV2ev4qE0JSHVXZu/8RNRkwfCh
         yf3ImjhhnLz3hOpuj0yFKuN25Dsx+ZY4PWws0KjEgp1ZY1yDlBoGDtgxP0f4rbViK6YE
         VXcg==
X-Gm-Message-State: AOAM531TzzbUFNs+DaN7Rw/m40GpCNHXgefL1h+uxSjl0ysr2QrgAv9L
        5Qx67UABykdLU2V6mt1TkUk8NAfmmTHgBqYqW5c8Aw==
X-Google-Smtp-Source: ABdhPJzYDnP24wwOelVeEyCcBSvfNazhiS7QfNC77RO9c3sg9x5dox+fMIX33I/5b3Ecdv0X677NG4RGlEqudd7zz6c=
X-Received: by 2002:a25:804:: with SMTP id 4mr30394840ybi.346.1630431075086;
 Tue, 31 Aug 2021 10:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102125.624661-1-ulf.hansson@linaro.org>
In-Reply-To: <20210831102125.624661-1-ulf.hansson@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 31 Aug 2021 10:30:39 -0700
Message-ID: <CAGETcx868QWj0jMJ+U-eL62jT-LO_LTOw5EcwEKptfFOVa=A5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: property: fw_devlink: Rename 'node_not_dev' to 'optional_con_dev'
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

On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the struct supplier_bindings the member 'node_not_dev' is described as
> "The consumer node containing the property is never a device.", but that
> doesn't match the behaviour of the code in of_link_property().
>
> To make the behaviour consistent with the description, let's rename the
> member to "optional_con_dev" and clarify the corresponding comment.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/of/property.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6c028632f425..2babb1807228 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1249,7 +1249,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
>   * @parse_prop.index: For properties holding a list of phandles, this is the
>   *                   index into the list
>   * @optional: Describes whether a supplier is mandatory or not
> - * @node_not_dev: The consumer node containing the property is never a device.
> + * @optional_con_dev: The consumer node containing the property may not be a
> + *                   device, then try finding one from an ancestor node.

Nak. This flag is not about "may not be". This is explicitly for
"never a device". It has to do with stuff like remote-endpoint which
is never listed under the root node of the device node. Your
documentation change is changing the meaning of the flag.

-Saravana

>   *
>   * Returns:
>   * parse_prop() return values are
> @@ -1261,7 +1262,7 @@ struct supplier_bindings {
>         struct device_node *(*parse_prop)(struct device_node *np,
>                                           const char *prop_name, int index);
>         bool optional;
> -       bool node_not_dev;
> +       bool optional_con_dev;
>  };
>
>  DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> @@ -1370,7 +1371,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_pinctrl6, },
>         { .parse_prop = parse_pinctrl7, },
>         { .parse_prop = parse_pinctrl8, },
> -       { .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
> +       { .parse_prop = parse_remote_endpoint, .optional_con_dev = true, },
>         { .parse_prop = parse_gpio_compat, },
>         { .parse_prop = parse_interrupts, },
>         { .parse_prop = parse_regulators, },
> @@ -1415,7 +1416,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
>                 while ((phandle = s->parse_prop(con_np, prop_name, i))) {
>                         struct device_node *con_dev_np;
>
> -                       con_dev_np = s->node_not_dev
> +                       con_dev_np = s->optional_con_dev
>                                         ? of_get_compat_node(con_np)
>                                         : of_node_get(con_np);
>                         matched = true;
> --
> 2.25.1
>

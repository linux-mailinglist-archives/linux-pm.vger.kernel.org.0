Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E53FCC8F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhHaRwG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbhHaRwE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 13:52:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C99C0613D9
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 10:51:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f4so4820812ybr.5
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pIETbwzEvPZUMVPq9wsIAHnQx3O5wMdlNB0MfEAuj0=;
        b=Scrjc8ijJCC3MvC3aftivYj8cIv3TlJZmhY8OLSRRBkZ4hnBtr9FaP/6dJPohUw+RL
         raVFD4SoCWgrxMVU8+MZcKXNxX8QwgTJ5zgW4Rlb3qhBJabgFDFmK0fZhAPfmVz+g5tE
         OyB9fGyFfo9WU8S6AurRO4cDiPf6Rg01ZJyQAWnddwIYACTMEdrpK3zyJi2okwqk76dn
         Ljx2DGor44imcUSBFdUU2x15NtTGEmAEJqYhzzg3/zOh2DuO+MbqJrZ+aAI9yT17oFEi
         QVC1otAlffCIQl606fsBe+bQNFEnJLMHjYjD96OMmjz+RdqfDJUvBxeNao1iXnkOOW8K
         QRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pIETbwzEvPZUMVPq9wsIAHnQx3O5wMdlNB0MfEAuj0=;
        b=J0DZAmjT4IPRyzEWxI0XCvDe3K2yeQ7M6SHJkg29ZpUB+MTJ7YZxyTCWiDFKc9KCu2
         qfb+8QFBGjbresq/AJCruWpzcb2EH46l7+gmHCTTz3hM6qTR1ii9pKWWNrbkVZTjmFyu
         GNOpg0XAP2ggYgOuV0i/rvzB/kwlIcIUO/G5cy/WYghN41zcCv+J3d4NHj2sLfN9xqRk
         gC1laI9dI5KMpF61p/11c0mZw5vR6wtws1y4iGezZTRgVjUdejQNWzwVx67aQC7Pusig
         8Z7/gcLFih1TZgx6m/McfMvQo3K9X8ymEF7aTjlqo2RP1Mt4vth7/QsT6cs+bczKFctR
         Pfpg==
X-Gm-Message-State: AOAM532WMVLY2OVP0qpWURsHDXavBxC4vwWvd9mR78UibdzYo6X/GOvr
        KI18NrbKMJdv8pee/X1cMq9pNVCxYQNj7g3F86bu9A==
X-Google-Smtp-Source: ABdhPJx71dpDR7UFbZr/7dCKBg0wfUJ8rz8RAzLgJ17BiDMwG2mbWmRhd4UNFPU3Gvmb0HfjgfKKjR1/4rBmHnzioQ8=
X-Received: by 2002:a25:d2c8:: with SMTP id j191mr32908959ybg.412.1630432268128;
 Tue, 31 Aug 2021 10:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102141.624725-1-ulf.hansson@linaro.org>
In-Reply-To: <20210831102141.624725-1-ulf.hansson@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 31 Aug 2021 10:50:32 -0700
Message-ID: <CAGETcx8FKnmeCh3dD1b2TYXf3gwHnW-iWwfz0q-9UzeP2VZSDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for parse_power_domains
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
> The power-domain DT bindings [1] doesn't enforce a compatible string for a
> provider node, even if this is common to use. In particular, when
> describing a hierarchy with parent/child power-domains, as the psci DT
> bindings [2] for example, it's sometimes not applicable to use a compatible
> string.

Ok, and fw_devlink handles that -- provider not having a compatible
string is pretty common. In these cases, the parent node is the actual
device that gets probed and registers the provider. So fw_devlink will
create a link from the consumer to the parent device node.

> Therefore, let's set the 'optional_con_dev' to true to avoid creating
> incorrect fw_devlinks for power-domains.

This part doesn't make sense or is incomplete. What is being done incorrectly?

>
> [1] Documentation/devicetree/bindings/power/power-domain.yaml
> [2] Documentation/devicetree/bindings/arm/psci.yaml
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Some more details of what goes on here. I have added a debug print in
> of_link_to_phandle() to see the fw_devlinks that gets created.
>
> This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
> ...
> [    0.041274] device: 'psci': device_add
> [    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
> [    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
> [    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
> [    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
> [    0.041494] device: 'platform:psci--platform:psci': device_add
> [    0.041556] platform psci: Linked as a sync state only consumer to psci
> ...
>
> This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
> ...
> [    0.041179] device: 'psci': device_add
> [    0.041265] OF: Not linking psci to psci - is descendant
> [    0.041293] OF: Not linking psci to psci - is descendant
> [    0.041319] OF: Not linking psci to psci - is descendant
> [    0.041346] OF: Not linking psci to psci - is descendant
> ...

Can you please explain what exactly is going on that's wrong here? I
notice that psci is not probed as a device at all. And when you aren't
setting this flag the only difference I see is the creating of a sync
state only link -- which shouldn't matter here because you don't even
have a driver implemented.

> The relevant dtsi file:
> arch/arm64/boot/dts/qcom/msm8916.dtsi
>
> Kind regards
> Ulf Hansson
>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 2babb1807228..4d607fdbea24 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_io_channels, },
>         { .parse_prop = parse_interrupt_parent, },
>         { .parse_prop = parse_dmas, .optional = true, },
> -       { .parse_prop = parse_power_domains, },
> +       { .parse_prop = parse_power_domains, .optional_con_dev = true, },

This change is just shooting in dark/completely unrelated to the
commit text. This is just saying the actual consumer is a level up
from where the property is listed (eg: remote-endpoint). It just
happens to fix your case for unrelated reasons.

Definite Nak as this *will* break other cases.

-Saravana


>         { .parse_prop = parse_hwlocks, },
>         { .parse_prop = parse_extcon, },
>         { .parse_prop = parse_nvmem_cells, },
> --
> 2.25.1
>

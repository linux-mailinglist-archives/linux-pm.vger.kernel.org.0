Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A083FD502
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbhIAIOE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbhIAIOB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 04:14:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465D2C061760
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 01:13:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s10so4634904lfr.11
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2tKAP/1aZjb1THg3HM096zaMHW+UEhDKNrwvOztN+o=;
        b=NtdFfLlMBvvwmCb3CWPpIKNwfwDjzXrs9rRY0SFXdfUlT+qdz9Su5Ptd4lNpsXckXV
         wymW4+zGn+9GDI4Qh/wk/gLLDJVfQBuqAEhHLk565ytuia6g8Y2vYC7z0DzwmwRkhU22
         stPv6sldloGbiFxEcEprQr93tsb9hhR8/efVxzERsFIqg8RK1O7CSUT2kTmjI0vUyevv
         2ihP59qDk8Xly7x43n4Z7pObGikldxv2cCbzbBOlnoDEUtZNk8cf3etRHcqneLLmV6TQ
         ESaP5kSJzmkCnp0Tr0xyayje1gOJmPDeaO5kJEVx9p6vSQjUVRz5oUUDCulxt/jHKkZL
         JQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2tKAP/1aZjb1THg3HM096zaMHW+UEhDKNrwvOztN+o=;
        b=gX2THasbAlcu9dbEhbFU3+gGdJPHaQhFP//wuKFMV0i69LhVPl7UfFwYNn3Lhf0ahh
         4v8U+E6SpPmTcKrMG5rXqERGSdHircC/WDU2fk/w5UbW2S2KHxdBK7VTR2yWCLrN8b9E
         XW5LU+56POHp4FMv5P1do8c2kEte5jILJmTs2FAB5W+fFC4Kd4qwKLTOts6TZQrahat2
         CHaDkFQUagafIipEni0d7QzamzYCuUjq6ErFbVpox4Fafb4/YJ/ikEpaFxoQLqZNPxX/
         +KBkM+romDiGKhLUfXwqA4/5XscL2nRRcFcuQtrpUr5JPmu40owYCnE3+0zTGQL/J0b9
         BM1Q==
X-Gm-Message-State: AOAM530M6PLnPnLUUEnpEFFGMGBkRAKZB1Ku6onYEpznGAQ0LOXih3bU
        fxheYY9r1P6LowVF8vpo+2wdLQybHU3lHlF9dFapUKlhLeVDqQ==
X-Google-Smtp-Source: ABdhPJzq8baOlGTK2GwvtcD99p4jRPFD/7gsxAm2hrNPt8zCt6zdxwd4ae6WRjr3X66BQKEonrqMI3gmqCxmWhAvYIc=
X-Received: by 2002:a19:c107:: with SMTP id r7mr24899153lff.29.1630483982545;
 Wed, 01 Sep 2021 01:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102141.624725-1-ulf.hansson@linaro.org> <CAGETcx8FKnmeCh3dD1b2TYXf3gwHnW-iWwfz0q-9UzeP2VZSDw@mail.gmail.com>
In-Reply-To: <CAGETcx8FKnmeCh3dD1b2TYXf3gwHnW-iWwfz0q-9UzeP2VZSDw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Sep 2021 10:12:26 +0200
Message-ID: <CAPDyKFq7aD_VXyY6=Kvp3t2Ph1_+CheZWDA6j2AoPK6ExX4h0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for parse_power_domains
To:     Saravana Kannan <saravanak@google.com>
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

On Tue, 31 Aug 2021 at 19:51, Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > The power-domain DT bindings [1] doesn't enforce a compatible string for a
> > provider node, even if this is common to use. In particular, when
> > describing a hierarchy with parent/child power-domains, as the psci DT
> > bindings [2] for example, it's sometimes not applicable to use a compatible
> > string.
>
> Ok, and fw_devlink handles that -- provider not having a compatible
> string is pretty common. In these cases, the parent node is the actual
> device that gets probed and registers the provider. So fw_devlink will
> create a link from the consumer to the parent device node.

Yes, correct. That is working fine and isn't a problem.

The first problem (I think) is that fw_devlink creates a fw_devlink
from a child provider node (consumer without compatible string) to a
parent node (supplier with a compatible string). I don't understand
the reason why this is needed, perhaps you can elaborate on why?

I come to the second and follow up problem from this behaviour, see below.

>
> > Therefore, let's set the 'optional_con_dev' to true to avoid creating
> > incorrect fw_devlinks for power-domains.
>
> This part doesn't make sense or is incomplete. What is being done incorrectly?

See below.

>
> >
> > [1] Documentation/devicetree/bindings/power/power-domain.yaml
> > [2] Documentation/devicetree/bindings/arm/psci.yaml
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Some more details of what goes on here. I have added a debug print in
> > of_link_to_phandle() to see the fw_devlinks that gets created.
> >
> > This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
> > ...
> > [    0.041274] device: 'psci': device_add
> > [    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
> > [    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
> > [    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
> > [    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
> > [    0.041494] device: 'platform:psci--platform:psci': device_add
> > [    0.041556] platform psci: Linked as a sync state only consumer to psci

Because we created a fw_devlink for the child provider nodes
(consumer) that lacks compatible properties, we end up creating a sync
state only devlink. I don't think it serves a purpose, but I may be
wrong!?

Additionally, the actual devlink that is created, has the same
supplier and consumer device, which indicates that this isn't the
right thing to do.

> > ...
> >
> > This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
> > ...
> > [    0.041179] device: 'psci': device_add
> > [    0.041265] OF: Not linking psci to psci - is descendant
> > [    0.041293] OF: Not linking psci to psci - is descendant
> > [    0.041319] OF: Not linking psci to psci - is descendant
> > [    0.041346] OF: Not linking psci to psci - is descendant
> > ...
>
> Can you please explain what exactly is going on that's wrong here? I
> notice that psci is not probed as a device at all. And when you aren't
> setting this flag the only difference I see is the creating of a sync
> state only link -- which shouldn't matter here because you don't even
> have a driver implemented.

See above.

>
> > The relevant dtsi file:
> > arch/arm64/boot/dts/qcom/msm8916.dtsi
> >
> > Kind regards
> > Ulf Hansson
> >
> > ---
> >  drivers/of/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 2babb1807228..4d607fdbea24 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
> >         { .parse_prop = parse_io_channels, },
> >         { .parse_prop = parse_interrupt_parent, },
> >         { .parse_prop = parse_dmas, .optional = true, },
> > -       { .parse_prop = parse_power_domains, },
> > +       { .parse_prop = parse_power_domains, .optional_con_dev = true, },
>
> This change is just shooting in dark/completely unrelated to the
> commit text. This is just saying the actual consumer is a level up
> from where the property is listed (eg: remote-endpoint). It just
> happens to fix your case for unrelated reasons.

Again, see above.

>
> Definite Nak as this *will* break other cases.

In what way will this break other cases?

Would you mind elaborating for my understanding and perhaps point me
to an example where it will break?

>
> -Saravana
>
>
> >         { .parse_prop = parse_hwlocks, },
> >         { .parse_prop = parse_extcon, },
> >         { .parse_prop = parse_nvmem_cells, },
> > --
> > 2.25.1
> >

Kind regards
Uffe
